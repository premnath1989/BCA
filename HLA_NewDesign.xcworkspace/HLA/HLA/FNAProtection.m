//
//  FNAProtection.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "FNAProtection.h"
#import "ProtectionPlans.h"
#import "ExistingProtectionPlans.h"
#import "DataClass.h"

#define NUMBERS_ONLY @"1234567890."
#define CHARACTER_LIMIT 15
#define CHARACTER_LIMIT_CCNO 15

@interface FNAProtection (){
     DataClass *obj;
}

@end

@implementation FNAProtection

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
    
    UIButton * headerBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    headerBtn.backgroundColor = [UIColor clearColor];
    headerBtn.frame = CGRectMake(615.0, 15.0, 100.0, 30.0);
    
    [headerBtn setTitle:@"Clear All" forState:UIControlStateNormal];
    
    [headerBtn setBackgroundImage:[UIImage imageNamed:@"merahBtn.png"]
                        forState:UIControlStateNormal];
    [headerBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    
    [headerBtn addTarget:self action:@selector(ActionEventForButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *aa = [[UIView alloc] initWithFrame:CGRectZero];
    aa.frame = CGRectMake(0.0,0.0,0.0,40.0);
    aa.backgroundColor = [UIColor clearColor];
    [aa addSubview:headerBtn];

    _required1.delegate = self;
    _required2.delegate = self;
    _required3.delegate = self;
    _required4.delegate = self;
    
    _current1.delegate = self;
    _current2.delegate = self;
    _current3.delegate = self;
    _current4.delegate = self;
    
    _customerAlloc.delegate = self;
    _partnerAlloc.delegate = self;
     obj=[DataClass getInstance];
    
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasProtection"] isEqualToString:@"0"]){
        hasProtection = TRUE;
        self.ProtectionSelected = TRUE;
        [_ProtectionPlans setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1"] isEqualToString:@"1"]){
            _plan1.text = [NSString stringWithFormat:@"Policy Owner: %@", [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1PolicyOwner"]];
        }
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2"] isEqualToString:@"1"]){
            _plan2.text = [NSString stringWithFormat:@"Policy Owner: %@", [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2PolicyOwner"]];
        }
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3"] isEqualToString:@"1"]){
            _plan3.text = [NSString stringWithFormat:@"Policy Owner: %@", [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3PolicyOwner"]];
        }
    }
    else{
        hasProtection = FALSE;
        self.ProtectionSelected = FALSE;
        [_ProtectionPlans setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        _current1.enabled = FALSE;
        _current2.enabled = FALSE;
        _current3.enabled = FALSE;
        _current4.enabled = FALSE;
        
    }
    
    _current1.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent1"];
    _required1.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired1"];
    _difference1.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference1"];
    
    _current2.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent2"];
    _required2.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired2"];
    _difference2.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference2"];
    
    _current3.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent3"];
    _required3.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired3"];
    _difference3.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference3"];
    
    _current4.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent4"];
    _required4.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired4"];
    _difference4.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference4"];
    
    _customerAlloc.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCustomerAlloc"];
    _partnerAlloc.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionPartnerAlloc"];
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
    /*
     UIButton * headerBtn = [[UIButton alloc] initWithFrame:CGRectZero];
     headerBtn.backgroundColor = [UIColor whiteColor];
     //headerBtn.opaque = NO;
     headerBtn.frame = CGRectMake(615.0, 15.0, 100.0, 30.0);
     
     [headerBtn setTitle:@"Clear All" forState:UIControlStateNormal];
     
     [headerBtn setBackgroundImage:[UIImage imageNamed:@"merahBtn.png"]
     forState:UIControlStateNormal];
     [headerBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
     
     [headerBtn addTarget:self action:@selector(ActionEventForButton:) forControlEvents:UIControlEventTouchUpInside];
     */
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}


- (void) ActionEventForButton:(id)sender {
    
    if(self.ProtectionSelected == FALSE)
    {
        _current1.text =  @"0.00";
        _current2.text =  @"0.00";
        _current3.text =  @"0.00";
        _current4.text =  @"0.00";

    }
    
    else
    {
        _current1.text =  @"";
        _current2.text =  @"";
        _current3.text =  @"";
        _current4.text =  @"";
    }
    
    _required1.text =  @"";
    _required2.text =  @"";
    _required3.text =  @"";
    _required4.text =  @"";
    
    _customerAlloc.text = @"";
    _partnerAlloc.text =  @"";
    [self CalcualeDifference];
    
    
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"0" forKey:@"CFFValidate"];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewDidUnload {
    [self setProtectionPlans:nil];
    [self setCurrent1:nil];
    [self setRequired1:nil];
    [self setCurrent2:nil];
    [self setRequired2:nil];
    [self setDifference1:nil];
    [self setDifference2:nil];
    [self setCurrent3:nil];
    [self setRequired3:nil];
    [self setDifference3:nil];
    [self setCurrent4:nil];
    [self setRequired4:nil];
    [self setDifference4:nil];
    [self setCustomerAlloc:nil];
    [self setPartnerAlloc:nil];
    [self setPlan1:nil];
    [self setPlan2:nil];
    [self setPlan3:nil];
    [self setMyTableView:nil];
    [super viewDidUnload];
}
- (IBAction)ProtectionPlansBtn:(id)sender {
    if (hasProtection){
        hasProtection = FALSE;
        self.ProtectionSelected = FALSE;
    }
    else{
        hasProtection = TRUE;
        self.ProtectionSelected = TRUE;
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
    
    
    if (hasProtection){
        NSString *zero = @"";
        _current1.text = zero;
        _current2.text = zero;
        _current3.text = zero;
        _current4.text = zero;
        
        _current1.enabled = TRUE;
        _current2.enabled = TRUE;
        _current3.enabled = TRUE;
        _current4.enabled = TRUE;
        [_ProtectionPlans setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasProtection"];
        //[self current1Action:Nil];
    }
    else{
        NSString *zero = @"0.00";
        _current1.text = zero;
        _current2.text = zero;
        _current3.text = zero;
        _current4.text = zero;
        
        _current1.enabled = FALSE;
        _current2.enabled = FALSE;
        _current3.enabled = FALSE;
        _current4.enabled = FALSE;
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:zero forKey:@"ProtectionCurrent1"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:zero forKey:@"ProtectionCurrent2"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:zero forKey:@"ProtectionCurrent3"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:zero forKey:@"ProtectionCurrent4"];
        
        [_ProtectionPlans setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"-1" forKey:@"HasProtection"];
    }
    //[self.tableView reloadData];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    [self CalcualeDifference];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT));
}

- (IBAction)current1Action:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_current1.text = [formatter stringFromNumber:[formatter numberFromString:_current1.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_current1.text forKey:@"ProtectionCurrent1"];
    
    [self CalcualeDifference];
}

- (IBAction)required1Action:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_required1.text = [formatter stringFromNumber:[formatter numberFromString:_required1.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_required1.text forKey:@"ProtectionRequired1"];
    
    [self CalcualeDifference];
}

- (IBAction)current2Action:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_current2.text = [formatter stringFromNumber:[formatter numberFromString:_current2.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_current2.text forKey:@"ProtectionCurrent2"];
    
    if ([_current2.text length] == 0 || [_required2.text length] == 0){
        _difference2.text = @"";
        [[obj.CFFData objectForKey:@"SecF"] setValue:_difference2.text forKey:@"ProtectionDifference2"];
        return;
    }
    
    [self CalcualeDifference];
}

- (IBAction)required2Action:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_required2.text = [formatter stringFromNumber:[formatter numberFromString:_required2.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_required2.text forKey:@"ProtectionRequired2"];
    
    [self CalcualeDifference];
}

- (IBAction)current3Action:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_current3.text = [formatter stringFromNumber:[formatter numberFromString:_current3.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_current3.text forKey:@"ProtectionCurrent3"];
    
    [self CalcualeDifference];
}

- (IBAction)required3Action:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_required3.text = [formatter stringFromNumber:[formatter numberFromString:_required3.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_required3.text forKey:@"ProtectionRequired3"];
    
    [self CalcualeDifference];
}

- (IBAction)current4Action:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_current4.text = [formatter stringFromNumber:[formatter numberFromString:_current4.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_current4.text forKey:@"ProtectionCurrent4"];
    
    [self CalcualeDifference];
}

- (IBAction)required4Action:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_required4.text = [formatter stringFromNumber:[formatter numberFromString:_required4.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_required4.text forKey:@"ProtectionRequired4"];
    
    [self CalcualeDifference];
}

- (IBAction)customerAllocAction:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_customerAlloc.text = [formatter stringFromNumber:[formatter numberFromString:_customerAlloc.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_customerAlloc.text forKey:@"ProtectionCustomerAlloc"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ProtectionNeedValidation"];
}

- (IBAction)partnerAllocAction:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_partnerAlloc.text = [formatter stringFromNumber:[formatter numberFromString:_partnerAlloc.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_partnerAlloc.text forKey:@"ProtectionPartnerAlloc"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ProtectionNeedValidation"];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if([self.hiddenSections containsObject:[NSNumber numberWithInt:indexPath.section]]){
    //    return 0;
    //}
    
    //return [super tableView:tableView heightForRowAtIndexPath:[self offsetIndexPath:indexPath]];
    //return 100.0;
    
    //hasProtection = FALSE;
    
    if (hasProtection){
        //NSLog(@"show");
        _plan1.hidden = FALSE;
        _plan2.hidden = FALSE;
        _plan3.hidden = FALSE;
    }
    else{
        if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3){
            _plan1.hidden = TRUE;
            _plan2.hidden = TRUE;
            _plan3.hidden = TRUE;
            //NSLog(@"hide");
            return 0;
        }
    }
    
    if (indexPath.row == 4){
        return 284;
    }
    else if (indexPath.row == 5){
        return 94;
    }
    return 44;
}






/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return @"1. Protection";
    return nil;
}
 */

-(void)CalcualeDifference{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
    
    if ([_current1.text length] == 0 || [_required1.text length] == 0){
        _difference1.text = @"";
        [[obj.CFFData objectForKey:@"SecF"] setValue:_difference1.text forKey:@"ProtectionDifference1"];
    }
    else{
        float stringFloat =  [[_required1.text stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue]
        - [[_current1.text stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];

        
        if (stringFloat < 0.00){
            _difference1.text = [formatter stringFromNumber:[formatter numberFromString:[NSString stringWithFormat:@"%f", stringFloat]]];
            _difference1.text = [_difference1.text stringByReplacingOccurrencesOfString:@"-"
                                                                             withString:@""];
            _difference1.text = [NSString stringWithFormat:@"(%@)",_difference1.text];
        }
        else{
            _difference1.text = [formatter stringFromNumber:[formatter numberFromString:[NSString stringWithFormat:@"%f", stringFloat]]];
        }
        [[obj.CFFData objectForKey:@"SecF"] setValue:_difference1.text forKey:@"ProtectionDifference1"];
    }
    
    if ([_current2.text length] == 0 || [_required2.text length] == 0){
        _difference2.text = @"";
        [[obj.CFFData objectForKey:@"SecF"] setValue:_difference2.text forKey:@"ProtectionDifference2"];
    }
    else{
        float stringFloat =  [[_required2.text stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue]
        - [[_current2.text stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];
        
        if (stringFloat < 0.00){
            _difference2.text = [formatter stringFromNumber:[formatter numberFromString:[NSString stringWithFormat:@"%f", stringFloat]]];
            _difference2.text = [_difference2.text stringByReplacingOccurrencesOfString:@"-"
                                                                             withString:@""];
            _difference2.text = [NSString stringWithFormat:@"(%@)",_difference2.text];
        }
        else{
            _difference2.text = [formatter stringFromNumber:[formatter numberFromString:[NSString stringWithFormat:@"%f", stringFloat]]];
        }
        [[obj.CFFData objectForKey:@"SecF"] setValue:_difference2.text forKey:@"ProtectionDifference2"];
    }
    
    if ([_current3.text length] == 0 || [_required3.text length] == 0){
        _difference3.text = @"";
        [[obj.CFFData objectForKey:@"SecF"] setValue:_difference3.text forKey:@"ProtectionDifference3"];
    }
    else{
        float stringFloat =  [[_required3.text stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue]
        - [[_current3.text stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];

        
        if (stringFloat < 0.00){
            _difference3.text = [formatter stringFromNumber:[formatter numberFromString:[NSString stringWithFormat:@"%f", stringFloat]]];
            _difference3.text = [_difference3.text stringByReplacingOccurrencesOfString:@"-"
                                                                             withString:@""];
            _difference3.text = [NSString stringWithFormat:@"(%@)",_difference3.text];
        }
        else{
            _difference3.text = [formatter stringFromNumber:[formatter numberFromString:[NSString stringWithFormat:@"%f", stringFloat]]];
        }
        [[obj.CFFData objectForKey:@"SecF"] setValue:_difference3.text forKey:@"ProtectionDifference3"];
    }
    
    if ([_current4.text length] == 0 || [_required4.text length] == 0){
        _difference4.text = @"";
        [[obj.CFFData objectForKey:@"SecF"] setValue:_difference4.text forKey:@"ProtectionDifference4"];
    }
    else{
        float stringFloat =  [[_required4.text stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue]
        - [[_current4.text stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];

        
        if (stringFloat < 0.00){
            _difference4.text = [formatter stringFromNumber:[formatter numberFromString:[NSString stringWithFormat:@"%f", stringFloat]]];
            _difference4.text = [_difference4.text stringByReplacingOccurrencesOfString:@"-"
                                                                             withString:@""];
            _difference4.text = [NSString stringWithFormat:@"(%@)",_difference4.text];
        }
        else{
            _difference4.text = [formatter stringFromNumber:[formatter numberFromString:[NSString stringWithFormat:@"%f", stringFloat]]];
        }
        [[obj.CFFData objectForKey:@"SecF"] setValue:_difference4.text forKey:@"ProtectionDifference4"];
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ProtectionNeedValidation"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3){
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
        
        ProtectionPlans *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ProtectionPlans"];
        vc.modalPresentationStyle = UIModalPresentationFormSheet;
        vc.rowToUpdate = indexPath.row;
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:NULL];
        [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ProtectionNeedValidation"];
    }
}

-(void)ExistingProtectionPlansUpdate:(ExistingProtectionPlans *)controller rowToUpdate:(int)rowToUpdate{
    
    //NSLog(@"%d",rowToUpdate);
    
    //_plan1.text = [NSString stringWithFormat:@"Policy Owner: %@   Company: %@   Type of Plan: %@",controller.PolicyOwner.text,controller.Company.text,controller.TypeOfPlan.text];
    
    if (rowToUpdate == 1){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingProtection1"];
        _plan1.text = [NSString stringWithFormat:@"Policy Owner: %@",controller.PolicyOwner.text];
    }
    else if (rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingProtection2"];
        _plan2.text = [NSString stringWithFormat:@"Policy Owner: %@",controller.PolicyOwner.text];
    }
    else if (rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingProtection3"];
        _plan3.text = [NSString stringWithFormat:@"Policy Owner: %@",controller.PolicyOwner.text];
    }
    
    
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

-(void)ExistingProtectionPlansDelete:(ExistingProtectionPlans *)controller rowToUpdate:(int)rowToUpdate{
    if (rowToUpdate == 1){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingProtection1"];
        _plan1.text = [NSString stringWithFormat:@"Add Protection Plan (1)"];
    }
    else if (rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingProtection2"];
        _plan2.text = [NSString stringWithFormat:@"Add Protection Plan (2)"];
    }
    else if (rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingProtection3"];
        _plan3.text = [NSString stringWithFormat:@"Add Protection Plan (3)"];
    }
    
    
    [self dismissViewControllerAnimated:TRUE completion:nil];
}


@end
