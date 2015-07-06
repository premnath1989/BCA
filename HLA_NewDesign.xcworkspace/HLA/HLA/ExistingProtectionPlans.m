//
//  ExistingProtectionPlans.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ExistingProtectionPlans.h"
#import "ColorHexCode.h"
#import "DataClass.h"
#import "ProtectionPlans.h"

#define NUMBERS_ONLY @"1234567890."
#define DATE @"0123456789/" //fix for bug 2625
#define CHARACTER_LIMIT3 3
#define CHARACTER_LIMIT15 16
#define CHARACTER_LIMIT70 70
#define CHARACTER_LIMIT100 100


@interface ExistingProtectionPlans (){
    DataClass *obj;
}

@end

@implementation ExistingProtectionPlans

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	//ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    //self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];


/*
	ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"Existing Protection Plan";
    self.navigationItem.titleView = label;
 */
    obj=[DataClass getInstance];
    
    _PolicyOwner.delegate = self;
    _Company.delegate = self;
    _TypeOfPlan.delegate = self;
    _LifrAssured.delegate = self;
    _DeathBenefit.delegate = self;
    _DisabledBenefit.delegate = self;
    _CriticalIllnessBenefit.delegate = self;
    _OtherBenefit.delegate = self;
    _PremiumContribution.delegate = self;
    _MaturityDate.delegate = self;

    
    //NSLog(@"www%d",self.rowToUpdate);
    //_PolicyOwner.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"CurrentSection"];
    if (self.rowToUpdate == 1){
        _PolicyOwner.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1PolicyOwner"];
        _Company.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1Company"];
        _TypeOfPlan.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1TypeOfPlan"];
        _LifrAssured.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1LifeAssured"];
        _DeathBenefit.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1DeathBenefit"];
        _DisabledBenefit.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1DisabilityBenefit"];
        _CriticalIllnessBenefit.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1CriticalIllnessBenefit"];
        _OtherBenefit.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1OtherBenefit"];
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1Mode"] isEqualToString:@""]){
            [_Mode setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1Mode"] isEqualToString:@"Annual"]){
            [_Mode setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1Mode"] isEqualToString:@"Semi Annual"]){
            [_Mode setSelectedSegmentIndex:1];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1Mode"] isEqualToString:@"Quarterly"]){
            [_Mode setSelectedSegmentIndex:2];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1Mode"] isEqualToString:@"Monthly"]){
            [_Mode setSelectedSegmentIndex:3];
        }
        
        _PremiumContribution.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1PremiumContribution"];
        _MaturityDate.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1MaturityDate"];
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
        
    }
    else if (self.rowToUpdate == 2){
        _PolicyOwner.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2PolicyOwner"];
        _Company.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2Company"];
        _TypeOfPlan.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2TypeOfPlan"];
        _LifrAssured.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2LifeAssured"];
        _DeathBenefit.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2DeathBenefit"];
        _DisabledBenefit.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2DisabilityBenefit"];
        _CriticalIllnessBenefit.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2CriticalIllnessBenefit"];
        _OtherBenefit.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2OtherBenefit"];
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2Mode"] isEqualToString:@""]){
            [_Mode setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2Mode"] isEqualToString:@"Annual"]){
            [_Mode setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2Mode"] isEqualToString:@"Semi Annual"]){
            [_Mode setSelectedSegmentIndex:1];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2Mode"] isEqualToString:@"Quarterly"]){
            [_Mode setSelectedSegmentIndex:2];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2Mode"] isEqualToString:@"Monthly"]){
            [_Mode setSelectedSegmentIndex:3];
        }
        
        _PremiumContribution.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2PremiumContribution"];
        _MaturityDate.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2MaturityDate"];
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
    }
    else if (self.rowToUpdate == 3){
        _PolicyOwner.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3PolicyOwner"];
        _Company.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3Company"];
        _TypeOfPlan.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3TypeOfPlan"];
        _LifrAssured.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3LifeAssured"];
        _DeathBenefit.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3DeathBenefit"];
        _DisabledBenefit.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3DisabilityBenefit"];
        _CriticalIllnessBenefit.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3CriticalIllnessBenefit"];
        _OtherBenefit.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3OtherBenefit"];
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3Mode"] isEqualToString:@""]){
            [_Mode setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3Mode"] isEqualToString:@"Annual"]){
            [_Mode setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3Mode"] isEqualToString:@"Semi Annual"]){
            [_Mode setSelectedSegmentIndex:1];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3Mode"] isEqualToString:@"Quarterly"]){
            [_Mode setSelectedSegmentIndex:2];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3Mode"] isEqualToString:@"Monthly"]){
            [_Mode setSelectedSegmentIndex:3];
        }
        
        _PremiumContribution.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3PremiumContribution"];
        _MaturityDate.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3MaturityDate"];
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _PolicyOwner){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return ((newLength <= CHARACTER_LIMIT70));
    }
    else if (textField == _Company){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return ((newLength <= CHARACTER_LIMIT70));
    }
    else if (textField == _TypeOfPlan){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return ((newLength <= CHARACTER_LIMIT100));
    }
    else if (textField == _LifrAssured){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return ((newLength <= CHARACTER_LIMIT70));
    }
    else if (textField == _DeathBenefit){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT15));
    }
    else if (textField == _DisabledBenefit){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT15));
    }
    else if (textField == _CriticalIllnessBenefit){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT15));
    }
    else if (textField == _OtherBenefit){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT15));
    }
    else if (textField == _PremiumContribution){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT15));
    }
    else if (textField == _MaturityDate){
		//fix for bug 2625 start
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:DATE] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT100));
		//fix for bug 2625 end
    }
    return FALSE;
}

- (IBAction)doDone:(id)sender {
    NSLog(@"vdavadvs");
    if ([_PolicyOwner.text length] == 0){

    }
    
    [self dismissViewControllerAnimated:TRUE completion:nil];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000){
        [_PolicyOwner becomeFirstResponder];
    }
}



- (IBAction)doCancel:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}
- (void)viewDidUnload {
    [self setPolicyOwner:nil];
    [self setCompany:nil];
    [self setTypeOfPlan:nil];
    [self setLifrAssured:nil];
    [self setDeathBenefit:nil];
    [self setDisabledBenefit:nil];
    [self setCriticalIllnessBenefit:nil];
    [self setOtherBenefit:nil];
    [self setPremiumContribution:nil];
    [self setMode:nil];
    [self setMaturityDate:nil];
    [self setDeleteCell:nil];
    [self setDoDisabilityBenefit:nil];
    [super viewDidUnload];
}

- (IBAction)doDeathBenefit:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_DeathBenefit.text = [formatter stringFromNumber:[formatter numberFromString:_DeathBenefit.text]];
}

- (IBAction)doDisabilityBenefit1:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_DisabledBenefit.text = [formatter stringFromNumber:[formatter numberFromString:_DisabledBenefit.text]];
}

- (IBAction)doCriticalIllnessBenefit:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_CriticalIllnessBenefit.text = [formatter stringFromNumber:[formatter numberFromString:_CriticalIllnessBenefit.text]];
}

- (IBAction)doOtherBenefit:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_OtherBenefit.text = [formatter stringFromNumber:[formatter numberFromString:_OtherBenefit.text]];
}

- (IBAction)doPremiumContribution:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_PremiumContribution.text = [formatter stringFromNumber:[formatter numberFromString:_PremiumContribution.text]];
}

- (IBAction)doDelete:(id)sender {
    ProtectionPlans *parent = (ProtectionPlans *) self.parentViewController;
    [parent doDelete:self.rowToUpdate];
}
@end
