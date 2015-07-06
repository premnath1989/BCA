//
//  FNARetirement.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "FNARetirement.h"
#import "DataClass.h"
#import "RetirementPlans.h"
#import "ExistingRetirementPlans.h"

#define NUMBERS_ONLY @"1234567890."
#define CHARACTER_LIMIT15 13
#define CHARACTER_LIMIT70 70
#define CHARACTER_LIMIT100 100

@interface FNARetirement (){
    DataClass *obj;
    bool gotPlans;
}

@end

@implementation FNARetirement

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
    _required1.delegate = self;
    
    _current1.delegate = self;
    
    _customerAlloc.delegate = self;
    _partnerAlloc.delegate = self;
    
    _customerRely.delegate = self;
    _partnerRely.delegate = self;
    
    obj=[DataClass getInstance];
    
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasRetirement"] isEqualToString:@"0"]){
        hasRetirement = TRUE;
        self.RetirementSelected = TRUE;
        [_retirementPlans setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1"] isEqualToString:@"1"]){
            _plan1.text = [NSString stringWithFormat:@"Policy Owner: %@", [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1PolicyOwner"]];
            gotPlans = TRUE;
        }
		else {
			_plan1.text = [NSString stringWithFormat:@"Add Existing Retirement Plan (1)"];
		}
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2"] isEqualToString:@"1"]){
            _plan2.text = [NSString stringWithFormat:@"Policy Owner: %@", [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2PolicyOwner"]];
            gotPlans = TRUE;
        }
        else {
			_plan2.text = [NSString stringWithFormat:@"Add Existing Retirement Plan (2)"];
		}
		
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3"] isEqualToString:@"1"]){
            _plan3.text = [NSString stringWithFormat:@"Policy Owner: %@", [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3PolicyOwner"]];
            gotPlans = TRUE;
        }
		else {
			_plan3.text = [NSString stringWithFormat:@"Add Existing Retirement Plan (3)"];
		}
    }
    else{
        hasRetirement = FALSE;
        self.RetirementSelected = FALSE;
        [_retirementPlans setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        _current1.enabled = FALSE;
    }
    
    _current1.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementCurrent1"];
    _required1.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementRequired1"];
    _difference1.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementDifference1"];
    
    _customerAlloc.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementCustomerAlloc"];
    _partnerAlloc.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementPartnerAlloc"];
    
    _customerRely.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementCustomerRely"];
    _partnerRely.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementPartnerRely"];

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please add existing retirement details in sequence." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        if (indexPath.row == 2) {
            if (![[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1"] isEqualToString:@"1"] && ![[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2"] isEqualToString:@"1"]) {
                [alert show];
                alert = nil;
                return;
            }
        }
        else if (indexPath.row == 3) {
            if ((![[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2"] isEqualToString:@"1"]) && ![[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3"] isEqualToString:@"1"]) {
                [alert show];
                alert = nil;
                return;
            }
        }
        
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
        
        RetirementPlans *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"RetirementPlans"];
        vc.modalPresentationStyle = UIModalPresentationFormSheet;
        vc.rowToUpdate = indexPath.row;
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:NULL];
        [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"RetirementNeedValidation"];
        [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3){
        
        if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please add existing retirement details in sequence." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            if (indexPath.row == 2) {
                if (![[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1"] isEqualToString:@"1"] && ![[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2"] isEqualToString:@"1"]) {
                    [alert show];
                    alert = nil;
                    return;
                }
            }
            else if (indexPath.row == 3) {
                if ((![[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2"] isEqualToString:@"1"]) && ![[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3"] isEqualToString:@"1"]) {
                    [alert show];
                    alert = nil;
                    return;
                }
            }
        }
        
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
        
        RetirementPlans *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"RetirementPlans"];
        vc.modalPresentationStyle = UIModalPresentationFormSheet;
        vc.rowToUpdate = indexPath.row;
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:NULL];
        [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"RetirementNeedValidation"];
        [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create the parent view that will hold header Label
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(615.0, 0.0, 100.0, 0.0)];
    customView.backgroundColor = [UIColor clearColor];
    
    // create the button object
    UIButton * headerBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    headerBtn.backgroundColor = [UIColor clearColor];
    //headerBtn.opaque = NO;
    headerBtn.frame = CGRectMake(618.0, 15.0, 100.0, 30.0);
    
    [headerBtn setTitle:@"Clear All" forState:UIControlStateNormal];
    
    [headerBtn setBackgroundImage:[UIImage imageNamed:@"merahBtn.png"]
                         forState:UIControlStateNormal];
    [headerBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    
    [headerBtn addTarget:self action:@selector(ActionEventForButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [customView addSubview:headerBtn];
    
    return customView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (hasRetirement){
        _plan1.hidden = FALSE;
        _plan2.hidden = FALSE;
        _plan3.hidden = FALSE;
    }
    else{
        if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3){
            _plan1.hidden = TRUE;
            _plan2.hidden = TRUE;
            _plan3.hidden = TRUE;
            return 0;
        }
    }
    
    if (indexPath.row == 4){
        return 103;
    }
    else if (indexPath.row == 5){
        return 90;
    }
    else if (indexPath.row == 6){
        return 136;
    }
    return 44;
}

- (void) ActionEventForButton:(id)sender {
    
    if(self.RetirementSelected == FALSE)
    {
          _current1.text = @"0.00";
    }
    else
    {
          _current1.text = @"";
    }
       
    _customerAlloc.text = @"";
    _customerRely.text = @"";
    _partnerAlloc.text = @"";
    _partnerRely.text = @"";
    _required1.text = @"";
    _difference1.text = @"";
    
    if (!hasRetirement) {
        [_retirementPlans sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    
    if (!gotPlans) {
        [[obj.CFFData objectForKey:@"CFF"] setValue:@"0" forKey:@"CFFValidate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"RetirementNeedValidation"];
        [[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"0" forKey:@"Completed"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Validate"];
    }
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementCurrent1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementRequired1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementDifference1"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementCustomerAlloc"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementPartnerAlloc"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementCustomerRely"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementPartnerRely"];
    
    UIImageView *img = (UIImageView *)[self.parentViewController.view viewWithTag:3005];
    img.hidden = TRUE;
    img = nil;
}

-(void) ActionEventForButton1 {
    
    if(self.RetirementSelected == FALSE)
    {
        _current1.text = @"0.00";
    }
    else
    {
        _current1.text = @"";
    }
    
    _customerAlloc.text = @"";
    _customerRely.text = @"";
    _partnerAlloc.text = @"";
    _partnerRely.text = @"";
    _required1.text = @"";
    _difference1.text = @"";
    
    if (!hasRetirement) {
        [_retirementPlans sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    
    if (!gotPlans) {
        [[obj.CFFData objectForKey:@"CFF"] setValue:@"0" forKey:@"CFFValidate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"RetirementNeedValidation"];
        [[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"0" forKey:@"Completed"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Validate"];
    }
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementCurrent1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementRequired1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementDifference1"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementCustomerAlloc"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementPartnerAlloc"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementCustomerRely"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementPartnerRely"];
    
    UIImageView *img = (UIImageView *)[self.parentViewController.view viewWithTag:3005];
    img.hidden = TRUE;
    img = nil;
}



- (void)viewDidUnload {
    [self setRetirementPlans:nil];
    [super viewDidUnload];
}
- (IBAction)retirementPlansBtn:(id)sender {
    if (hasRetirement){
        hasRetirement = FALSE;
        self.RetirementSelected = FALSE;
    }
    else{
        hasRetirement = TRUE;
        self.RetirementSelected = TRUE;
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
    
    
    if (hasRetirement){
        NSString *zero = @"";
        _current1.text = zero;
        _current1.enabled = TRUE;
        [_retirementPlans setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasRetirement"];
		[[obj.CFFData objectForKey:@"SecF"] setValue:zero forKey:@"RetirementCurrent1"];
    }
    else{
        NSString *zero = @"0.00";
        _current1.text = zero;
        _current1.enabled = FALSE;
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:zero forKey:@"RetirementCurrent1"];
        
        [_retirementPlans setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"-1" forKey:@"HasRetirement"];
    }
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    [self CalcualeDifference];
    
    if (hasRetirement) {
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"RetirementNeedValidation"];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == _customerRely){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return ((newLength <= CHARACTER_LIMIT100));
    }
    else if (textField == _partnerRely){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return ((newLength <= CHARACTER_LIMIT100));
    }
    else{
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT15));
    }
    return FALSE;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _partnerAlloc) {
        [[obj.CFFData objectForKey:@"SecF"] setValue:_partnerAlloc.text forKey:@"RetirementPartnerAlloc"];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == _current1 || textField == _required1 || textField == _customerAlloc || textField == _partnerAlloc) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle: NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:0];
        textField.text = [[formatter stringFromNumber:[formatter numberFromString:textField.text]] stringByReplacingOccurrencesOfString:@"," withString:@""];
    }
}

- (IBAction)current1Action:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_current1.text = [formatter stringFromNumber:[formatter numberFromString:_current1.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_current1.text forKey:@"RetirementCurrent1"];
    
    [self CalcualeDifference];
}

- (IBAction)required1Action:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_required1.text = [formatter stringFromNumber:[formatter numberFromString:_required1.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_required1.text forKey:@"RetirementRequired1"];
    
    [self CalcualeDifference];
}

- (IBAction)customerAllocAction:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_customerAlloc.text = [formatter stringFromNumber:[formatter numberFromString:_customerAlloc.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_customerAlloc.text forKey:@"RetirementCustomerAlloc"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"RetirementNeedValidation"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}

- (IBAction)partnerAllocAction:(id)sender {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle: NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:2];
        [formatter setPositiveFormat:@"#,##0.00"];
        _partnerAlloc.text = [formatter stringFromNumber:[formatter numberFromString:_partnerAlloc.text]];
        [[obj.CFFData objectForKey:@"SecF"] setValue:_partnerAlloc.text forKey:@"ProtectionPartnerAlloc"];
        [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"RetirementNeedValidation"];
        [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}

- (IBAction)customerRelyAction:(id)sender {
    //NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	//[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	//[formatter setMaximumFractionDigits:2];
	//[formatter setPositiveFormat:@"#,##0.00"];
	//_customerRely.text = [formatter stringFromNumber:[formatter numberFromString:_customerRely.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_customerRely.text forKey:@"RetirementCustomerRely"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"RetirementNeedValidation"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}

- (IBAction)partnerRelyAction:(id)sender {
    //NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	//[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	//[formatter setMaximumFractionDigits:2];
	//[formatter setPositiveFormat:@"#,##0.00"];
	//_partnerRely.text = [formatter stringFromNumber:[formatter numberFromString:_partnerRely.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_partnerRely.text forKey:@"RetirementPartnerRely"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"RetirementNeedValidation"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}



-(void)CalcualeDifference{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
    
    if ([_current1.text length] == 0 || [_required1.text length] == 0){
        _difference1.text = @"";
        [[obj.CFFData objectForKey:@"SecF"] setValue:_difference1.text forKey:@"RetirementDifference1"];
    }
    else{
        double stringFloat =  [[_required1.text stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue]
        - [[_current1.text stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
        
        
        if (stringFloat < 0.00){
            _difference1.text = [formatter stringFromNumber:[formatter numberFromString:[NSString stringWithFormat:@"%f", stringFloat]]];
            _difference1.text = [_difference1.text stringByReplacingOccurrencesOfString:@"-"
                                                                             withString:@""];
            _difference1.text = [NSString stringWithFormat:@"(%@)",_difference1.text];
        }
        else{
            _difference1.text = [formatter stringFromNumber:[formatter numberFromString:[NSString stringWithFormat:@"%f", stringFloat]]];
        }
        [[obj.CFFData objectForKey:@"SecF"] setValue:_difference1.text forKey:@"RetirementDifference1"];
    }
    
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"RetirementNeedValidation"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
    
    if (hasRetirement && _current1.text.length == 0 && _required1.text.length == 0 && _customerAlloc.text.length == 0 && _partnerAlloc.text.length == 0 && !gotPlans) {
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"RetirementNeedValidation"];
    }
}

-(void)ExistingRetirementPlansUpdate:(ExistingRetirementPlans *)controller rowToUpdate:(int)rowToUpdate{
    gotPlans = TRUE;
    if (rowToUpdate == 1){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingRetirement1"];
        _plan1.text = [NSString stringWithFormat:@"Policy Owner: %@",controller.PolicyOwner.text];
    }
    else if (rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingRetirement2"];
        _plan2.text = [NSString stringWithFormat:@"Policy Owner: %@",controller.PolicyOwner.text];
    }
    else if (rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingRetirement3"];
        _plan3.text = [NSString stringWithFormat:@"Policy Owner: %@",controller.PolicyOwner.text];
    }
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"RetirementNeedValidation"];
    
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

-(void)ExistingRetirementPlansDelete:(ExistingRetirementPlans *)controller rowToUpdate:(int)rowToUpdate{
    if (rowToUpdate == 1){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingRetirement1"];
        _plan1.text = [NSString stringWithFormat:@"Add Existing Retirement Plan (1)"];
    }
    else if (rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingRetirement2"];
        _plan2.text = [NSString stringWithFormat:@"Add Existing Retirement Plan (2)"];
    }
    else if (rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingRetirement3"];
        _plan3.text = [NSString stringWithFormat:@"Add Existing Retirement Plan (3)"];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1"] isEqualToString:@"0"] && [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2"] isEqualToString:@"0"] && [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3"] isEqualToString:@"0"]) {
        gotPlans = FALSE;
    }
    
    [self dismissViewControllerAnimated:TRUE completion:nil];
}


@end
