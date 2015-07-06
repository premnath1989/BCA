//
//  ExistingRetirementPlans.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ExistingRetirementPlans.h"
#import "ColorHexCode.h"
#import "DataClass.h"
#import "RetirementPlans.h"

#define NUMBERS_ONLY @"1234567890."
#define DATE @"1234567890/"
#define CHARACTER_LIMIT3 3
#define CHARACTER_LIMIT15 16
#define CHARACTER_LIMIT70 70
#define CHARACTER_LIMIT100 100
#define CHARACTER_LIMIT200 200

@interface ExistingRetirementPlans (){
    DataClass *obj;
}

@end

@implementation ExistingRetirementPlans

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
    
	obj=[DataClass getInstance];
    
    _PolicyOwner.delegate = self;
    _Company.delegate = self;
    _TypeOfPlan.delegate = self;
    _Premium.delegate = self;
    _StartDate.delegate = self;
    _MaturityDate.delegate = self;
    _SumMaturity.delegate = self;
    _IncomeMaturity.delegate = self;
    _AdditionalBenefit.delegate = self;
    
    
    
    if (self.rowToUpdate == 1){
        _PolicyOwner.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1PolicyOwner"];
        _Company.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Company"];
        
        
        
        _TypeOfPlan.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1TypeOfPlan"];
        
        
                    NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1TypeOfPlan"]);
        
        
        _Premium.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Premium"];
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Frequency"] isEqualToString:@""]){
            [_Frequency setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Frequency"] isEqualToString:@"Annual"]){
            [_Frequency setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Frequency"] isEqualToString:@"Semi Annual"]){
            [_Frequency setSelectedSegmentIndex:1];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Frequency"] isEqualToString:@"Quarterly"]){
            [_Frequency setSelectedSegmentIndex:2];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Frequency"] isEqualToString:@"Monthly"]){
            [_Frequency setSelectedSegmentIndex:3];
        }
        
        _StartDate.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1StartDate"];
        
        _MaturityDate.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1MaturityDate"];
        
        _SumMaturity.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1SumMaturity"];
        
        _IncomeMaturity.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1IncomeMaturity"];
        
        _AdditionalBenefit.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1AdditionalBenefit"];
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
    }
    else if (self.rowToUpdate == 2){
        _PolicyOwner.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2PolicyOwner"];
        _Company.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Company"];
        _TypeOfPlan.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2TypeOfPlan"];
        
        _Premium.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Premium"];
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Frequency"] isEqualToString:@""]){
            [_Frequency setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Frequency"] isEqualToString:@"Annual"]){
            [_Frequency setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Frequency"] isEqualToString:@"Semi Annual"]){
            [_Frequency setSelectedSegmentIndex:1];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Frequency"] isEqualToString:@"Quarterly"]){
            [_Frequency setSelectedSegmentIndex:2];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Frequency"] isEqualToString:@"Monthly"]){
            [_Frequency setSelectedSegmentIndex:3];
        }
        
        _StartDate.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2StartDate"];
        
        _MaturityDate.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2MaturityDate"];
        
        _SumMaturity.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2SumMaturity"];
        
        _IncomeMaturity.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2IncomeMaturity"];
        
        _AdditionalBenefit.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2AdditionalBenefit"];
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
    }
    if (self.rowToUpdate == 3){
        _PolicyOwner.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3PolicyOwner"];
        _Company.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Company"];
        _TypeOfPlan.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3TypeOfPlan"];
        
        _Premium.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Premium"];
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Frequency"] isEqualToString:@""]){
            [_Frequency setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Frequency"] isEqualToString:@"Annual"]){
            [_Frequency setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Frequency"] isEqualToString:@"Semi Annual"]){
            [_Frequency setSelectedSegmentIndex:1];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Frequency"] isEqualToString:@"Quarterly"]){
            [_Frequency setSelectedSegmentIndex:2];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Frequency"] isEqualToString:@"Monthly"]){
            [_Frequency setSelectedSegmentIndex:3];
        }
        
        _StartDate.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3StartDate"];
        
        _MaturityDate.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3MaturityDate"];
        
        _SumMaturity.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3SumMaturity"];
        
        _IncomeMaturity.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3IncomeMaturity"];
        
        _AdditionalBenefit.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3AdditionalBenefit"];
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
        
    }
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
    else if (textField == _Premium){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT15));
    }
    else if (textField == _StartDate){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:DATE] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT100));
    }
    else if (textField == _MaturityDate){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:DATE] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT100));
    }
    else if (textField == _SumMaturity){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT15));
    }
    else if (textField == _IncomeMaturity){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT15));
    }
    else if (textField == _AdditionalBenefit){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return ((newLength <= CHARACTER_LIMIT200));
    }
    return FALSE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)doCancel:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)doDone:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}
- (IBAction)deleteBtn:(id)sender {
}
- (IBAction)doDelete:(id)sender {
    RetirementPlans *parent = (RetirementPlans *) self.parentViewController;
    [parent doDelete:self.rowToUpdate];
}
- (void)viewDidUnload {
    [self setDeleteCell:nil];
    [self setPolicyOwner:nil];
    [self setCompany:nil];
    [self setTypeOfPlan:nil];
    [self setPremium:nil];
    [self setFrequency:nil];
//    [self setStartDate:nil];
//    [self setMaturityDate:nil];
    [self setIncomeMaturity:nil];
    [self setSumMaturity:nil];
    [self setAdditionalBenefit:nil];
    [self setStartDate:nil];
    [self setMaturityDate:nil];
    [self setStartDate:nil];
    [self setMaturityDate:nil];
    [super viewDidUnload];
}
- (IBAction)doPremium:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_Premium.text = [formatter stringFromNumber:[formatter numberFromString:_Premium.text]];
}

- (IBAction)doProjectedLumpSum:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_SumMaturity.text = [formatter stringFromNumber:[formatter numberFromString:_SumMaturity.text]];
}

- (IBAction)doIncomeMaturity:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_IncomeMaturity.text = [formatter stringFromNumber:[formatter numberFromString:_IncomeMaturity.text]];
}

//fixed bug 2610 start
- (IBAction)actionForStartDate:(id)sender {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    
    if (_SIDate == Nil) {
        
        self.SIDate = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIDate"];
        _SIDate.delegate = self;
        self.SIDatePopover = [[UIPopoverController alloc] initWithContentViewController:_SIDate];
    }
    
    [self.SIDatePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.SIDatePopover presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    
    dateFormatter = Nil;
	dateString = nil;
	_StartDate.text = dateString;
	mainStoryboard = nil;
	_btn = 12;
}

- (IBAction)actionForMaturityDate:(id)sender {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    
    if (_SIDate2 == Nil) {
        
        self.SIDate2 = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIDate"];
        _SIDate2.delegate = self;
        self.SIDatePopover2 = [[UIPopoverController alloc] initWithContentViewController:_SIDate2];
    }
    
    [self.SIDatePopover2 setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.SIDatePopover2 presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    
    dateFormatter = Nil;
	dateString = nil;
	_MaturityDate.text = dateString;
	mainStoryboard = nil;
	_btn = 13;
}

-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
	if (_btn == 12) {
		_StartDate.text = strDate;
	}
    else if (_btn == 13) {
		_MaturityDate.text = strDate;
	}
	//	_dobLbl.textColor = [UIColor blackColor];
}

-(void)CloseWindow
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [self.SIDatePopover dismissPopoverAnimated:YES];
	[self.SIDatePopover2 dismissPopoverAnimated:YES];
}
//fixed bug 2610 end

@end
