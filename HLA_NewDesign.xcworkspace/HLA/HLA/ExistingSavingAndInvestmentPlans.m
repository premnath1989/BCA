//
//  ExistingSavingAndInvestmentPlans.m
//  iMobile Planner
//
//  Created by Juliana on 7/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ExistingSavingAndInvestmentPlans.h"
#import "ColorHexCode.h"
#import "SavingsPlans.h"
#import "DataClass.h"

#define NUMBERS_ONLY @"1234567890."
#define DATE @"1234567890/"
#define CHARACTER_LIMIT3 3
#define CHARACTER_LIMIT15 16
#define CHARACTER_LIMIT70 70
#define CHARACTER_LIMIT100 100

@interface ExistingSavingAndInvestmentPlans (){
        DataClass *obj;
}

@end

@implementation ExistingSavingAndInvestmentPlans

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
    _CommDate.delegate = self;
    _AmountMaturity.delegate = self;
    
    
    if (self.rowToUpdate == 1){
        _PolicyOwner.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1PolicyOwner"];
        _Company.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1Company"];
        _TypeOfPlan.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1TypeOfPlan"];
        _Premium.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1Premium"];
        _Purpose.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1Purpose"];
        _CommDate.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1CommDate"];
        _AmountMaturity.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1AmountMaturity"];
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
    }
    else if (self.rowToUpdate == 2){
        _PolicyOwner.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2PolicyOwner"];
        _Company.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2Company"];
        _TypeOfPlan.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2TypeOfPlan"];
        _Premium.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2Premium"];
        _Purpose.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2Purpose"];
        _CommDate.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2CommDate"];
        _AmountMaturity.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2AmountMaturity"];
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
    }
    else if (self.rowToUpdate == 3){
        _PolicyOwner.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3PolicyOwner"];
        _Company.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3Company"];
        _TypeOfPlan.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3TypeOfPlan"];
        _Premium.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3Premium"];
        _Purpose.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3Purpose"];
        _CommDate.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3CommDate"];
        _AmountMaturity.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3AmountMaturity"];
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3"] isEqualToString:@"1"]){
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
    else if (textField == _CommDate){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:DATE] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT100));
    }
    else if (textField == _AmountMaturity){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT15));
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

- (void)viewDidUnload {
    [self setPolicyOwner:nil];
    [self setCompany:nil];
    [self setTypeOfPlan:nil];
    [self setPremium:nil];
//    [self setCommDate:nil];
    [self setAmountMaturity:nil];
    [self setDeleteCell:nil];
    [self setPurpose:nil];
    [self setCommDate:nil];
    [self setCommDate:nil];
    [super viewDidUnload];
}
- (IBAction)doPremium:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_Premium.text = [formatter stringFromNumber:[formatter numberFromString:_Premium.text]];
}

- (IBAction)doAmountMaturity:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_AmountMaturity.text = [formatter stringFromNumber:[formatter numberFromString:_AmountMaturity.text]];
}

- (IBAction)doDelete:(id)sender {
    SavingsPlans *parent = (SavingsPlans *) self.parentViewController;
    [parent doDelete:self.rowToUpdate];
}

//fixed bug 2609 start
- (IBAction)actionForCommDate:(id)sender {
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
	_CommDate.text = dateString;
	mainStoryboard = nil;
}

-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
	_CommDate.text = strDate;
	//	_dobLbl.textColor = [UIColor blackColor];
}

-(void)CloseWindow
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [self.SIDatePopover dismissPopoverAnimated:YES];
}
//fixed bug 2609 end

@end
