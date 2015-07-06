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
#define CHARACTER_LIMIT15 13
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
    _Purpose.delegate = self;
    
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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	tap.delegate = self;
	[self.view addGestureRecognizer:tap];
    
}

-(void)hideKeyboard{
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UITextField class]] ||
        [touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == _Premium || textField == _AmountMaturity) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle: NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:0];
        textField.text = [[formatter stringFromNumber:[formatter numberFromString:textField.text]] stringByReplacingOccurrencesOfString:@"," withString:@""];
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (textView == _Purpose) {
        NSUInteger newLength = [textView.text length] + [text length] - range.length;
        return newLength <= CHARACTER_LIMIT100;
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

#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    // create the parent view that will hold header Label
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(400.0, 0.0, 100.0, 100.0)];
    customView.backgroundColor = [UIColor clearColor];
    
    // create the button object
    UIButton * headerBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    headerBtn.backgroundColor = [UIColor clearColor];
    //headerBtn.opaque = NO;
    headerBtn.frame = CGRectMake(403.0, 15.0, 100.0, 30.0);
    
    [headerBtn setTitle:@"Clear All" forState:UIControlStateNormal];
    
    [headerBtn setBackgroundImage:[UIImage imageNamed:@"merahBtn.png"]
                         forState:UIControlStateNormal];
    [headerBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    
    [headerBtn addTarget:self action:@selector(ActionEventForButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [customView addSubview:headerBtn];
    
    return customView;
}

#pragma mark - action
-(IBAction)ActionEventForButton:(id)sender {
    _PolicyOwner.text = @"";
    _Company.text = @"";
    _TypeOfPlan.text = @"";
    _Purpose.text = @"";
    _Premium.text = @"";
    _CommDate.text = @"";
    _AmountMaturity.text = @"";
}
@end
