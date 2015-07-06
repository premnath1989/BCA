//
//  CustomerChoice.m
//  eAppScreen
//
//  Created by Erza on 7/5/13.
//  Copyright (c) 2013 IFC. All rights reserved.
//

#import "CustomerChoice.h"
#import "ColorHexCode.h"
#import "DataClass.h"
#import "MasterMenuCFF.h"
#import "FNAProtection.h"
#import "FNAEducation.h"
#import "FNARetirement.h"
#import "FNASavings.h"

@interface CustomerChoice (){
     DataClass *obj;
}

@end

@implementation CustomerChoice
@synthesize checkboxButton1;
@synthesize checkboxButton2;
@synthesize checkboxButton3;


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
    checked3 = NO;
    checked2 = NO;
    checked1 = NO;
	
	ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"Customer Fact Find";
    self.navigationItem.titleView = label;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnDone:)];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    obj=[DataClass getInstance];
    
    
    
    if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"1"]){
        [checkboxButton1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        [checkboxButton2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        [checkboxButton3 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        checked1 = YES;
        checked2 = NO;
        checked3 = NO;
        checkboxButton1.selected = TRUE;
        checkboxButton2.selected = FALSE;
        checkboxButton3.selected = FALSE;
		[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"SecFEnable"];
    }
    else if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"2"]){
        [checkboxButton2 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        [checkboxButton1 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        [checkboxButton3 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        checked1 = NO;
        checked2 = YES;
        checked3 = NO;
        checkboxButton1.selected = FALSE;
        checkboxButton2.selected = TRUE;
        checkboxButton3.selected = FALSE;
		[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"SecFEnable"];
    }
    else if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"3"]){
        [checkboxButton3 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        [checkboxButton2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        [checkboxButton1 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        checked1 = NO;
        checked2 = NO;
        checked3 = YES;
        checkboxButton1.selected = FALSE;
        checkboxButton2.selected = FALSE;
        checkboxButton3.selected = TRUE;
		[[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"SecFEnable"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)checkButton1:(id)sender {
    [checkboxButton1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
    [checkboxButton2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
     [checkboxButton3 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    checked1 = YES;
    checked2 = NO;
    checked3 = NO;
    checkboxButton1.selected = TRUE;
    checkboxButton2.selected = FALSE;
    checkboxButton3.selected = FALSE;
    
    if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"1"] && ![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"0"]) {
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"Validate"];
    }
    
    [[obj.CFFData objectForKey:@"SecB"] setValue:@"1" forKey:@"ClientChoice"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"SecFEnable"];
    
    //UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3001];
    //imageView.hidden = FALSE;
    //imageView = nil;
    [[obj.CFFData objectForKey:@"SecB"] setValue:@"1" forKey:@"Completed"];
    
    MasterMenuCFF *parent = (MasterMenuCFF *) self.parentViewController;
    
    UITableViewCell * cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    //special
    //if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.userInteractionEnabled = YES;
    //}
    //else{
    //    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    //    cell.textLabel.textColor = [UIColor grayColor];
    //    cell.userInteractionEnabled = NO;
    //}
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    parent = nil;
    cell = nil;
    
    //hack
    UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3002];
    //imageView.hidden = FALSE;
    imageView = nil;
    imageView = (UIImageView *)[self.parentViewController.view viewWithTag:3001];
    imageView.hidden = FALSE;
    imageView = nil;
    //[[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
    if ([[[obj.CFFData objectForKey:@"SecFProtection"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecFRetirement"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecFEducation"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecFSavings"] objectForKey:@"Completed"] isEqualToString:@"1"]) {
        imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3005];
        imageView.hidden = FALSE;
        imageView = nil;
    }
    else {
        imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3005];
        imageView.hidden = TRUE;
        imageView = nil;
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
    }
    [[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecFSavings"] setValue:@"0" forKey:@"Completed"];
	
	[self ClearFNAValue];
 
}
- (IBAction)checkButton2:(id)sender {
    [checkboxButton2 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
    [checkboxButton1 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    [checkboxButton3 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    checked1 = NO;
    checked2 = YES;
    checked3 = NO;
    checkboxButton1.selected = FALSE;
    checkboxButton2.selected = TRUE;
    checkboxButton3.selected = FALSE;
    
    if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"2"] && ![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"0"]) {
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"Validate"];
    }
    
    [[obj.CFFData objectForKey:@"SecB"] setValue:@"2" forKey:@"ClientChoice"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"SecFEnable"];
    
    //UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3001];
    //imageView.hidden = FALSE;
    //imageView = nil;
    [[obj.CFFData objectForKey:@"SecB"] setValue:@"1" forKey:@"Completed"];
    
    MasterMenuCFF *parent = (MasterMenuCFF *) self.parentViewController;
    
    UITableViewCell * cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    //special
    //if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.userInteractionEnabled = YES;
    //}
    //else{
    //    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    //    cell.textLabel.textColor = [UIColor grayColor];
    //    cell.userInteractionEnabled = NO;
    //}
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    BOOL doesContainEducation = [parent.SecFViewEducation.subviews containsObject:parent.FNAEducationVC.view];
    if (!doesContainEducation){
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
        parent.FNAEducationVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FinancialEducationView"];
        [parent addChildViewController:parent.FNAEducationVC];
        [parent.SecFViewEducation addSubview:parent.FNAEducationVC.view];
    }
    if (parent.FNAEducationVC.hasChildren == FALSE) {
        NSLog(@"Customer Choice hack SecF");
        [parent.FNAEducationVC hasChildBtn:parent.FNAEducationVC.hasChild];
        [[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"0" forKey:@"Completed"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"EducationNeedValidation"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
        
        NSLog(@"Protection: %@", [[obj.CFFData objectForKey:@"SecFProtection"] objectForKey:@"Completed"]);
        NSLog(@"Retirement: %@", [[obj.CFFData  objectForKey:@"SecFRetirement"] objectForKey:@"Completed"]);
        NSLog(@"Education: %@", [[obj.CFFData objectForKey:@"SecFSavings"] objectForKey:@"Completed"]);
    }
    
    parent = nil;
    cell = nil;
    
    //hack
    UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3002];
    //imageView.hidden = FALSE;
    //imageView = nil;
    imageView = (UIImageView *)[self.parentViewController.view viewWithTag:3001];
    imageView.hidden = FALSE;
    imageView = nil;
    //[[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
    //[[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"0" forKey:@"Completed"];
    //[[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"0" forKey:@"Completed"];
    //[[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"0" forKey:@"Completed"];
    //[[obj.CFFData objectForKey:@"SecFSavings"] setValue:@"0" forKey:@"Completed"];
	
	[self ClearFNAValue];
}
- (IBAction)checkButton3:(id)sender {
    [checkboxButton3 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
    [checkboxButton2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    [checkboxButton1 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    checked1 = NO;
    checked2 = NO;
    checked3 = YES;
    if (checked3 ==YES)
    {
        NSLog(@"imChecked");
        
        FNAProtection *viewController = [[FNAProtection alloc]init];
        [viewController ActionEventForButton1];
        
        FNAEducation *viewController1 = [[FNAEducation alloc]init];
        [viewController1 ActionEventForButton1];
        
        FNARetirement *viewController2 = [[FNARetirement alloc]init];
        [viewController2 ActionEventForButton1];
        
        FNASavings *viewController3 = [[FNASavings alloc]init];
        [viewController3 ActionEventForButton1];
        
        [self ClearFNAValue];

    }
    
    checkboxButton1.selected = FALSE;
    checkboxButton2.selected = FALSE;
    checkboxButton3.selected = TRUE;
	
	if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"3"] && ![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"0"]) {
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"Validate"];
    }
    [[obj.CFFData objectForKey:@"SecB"] setValue:@"3" forKey:@"ClientChoice"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"SecFEnable"];
    
    //UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3001];
    //imageView.hidden = FALSE;
    //imageView = nil;
    [[obj.CFFData objectForKey:@"SecB"] setValue:@"1" forKey:@"Completed"];
    
    MasterMenuCFF *parent = (MasterMenuCFF *) self.parentViewController;
    
    UITableViewCell * cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    //special
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.userInteractionEnabled = NO;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    parent = nil;
    cell = nil;
    
    //hack
    UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3002];
    //imageView.hidden = FALSE;
    imageView = nil;
    imageView = (UIImageView *)[self.parentViewController.view viewWithTag:3001];
    imageView.hidden = FALSE;
    imageView = nil;
    imageView = (UIImageView *)[self.parentViewController.view viewWithTag:3005];
    imageView.hidden = TRUE;
    imageView = nil;
    //[[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
    
    //[[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"0" forKey:@"Completed"];
    //[[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"0" forKey:@"Completed"];
    //[[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"0" forKey:@"Completed"];
    //[[obj.CFFData objectForKey:@"SecFSavings"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Validate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"Completed"];
	
	[self ClearFNAValue];
}

-(void) ClearFNAValue {
	
	//FNAProtection

	[[obj.CFFData objectForKey:@"CFF"] setValue:@"0" forKey:@"CFFValidate"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ProtectionNeedValidation"];
	[[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"0" forKey:@"Completed"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Validate"];
    
    // Clear save data in object class
	
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasProtection"];
	
	
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingProtection1"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingProtection2"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingProtection3"];
	
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1PolicyOwner"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2PolicyOwner"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3PolicyOwner"];
	
	
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionCurrent1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionRequired1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionDifference1"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionCurrent2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionRequired2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionDifference2"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionCurrent3"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionRequired3"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionDifference3"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionCurrent4"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionRequired4"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionDifference4"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionCustomerAlloc"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionPartnerAlloc"];
	
	
	//CLEAR EXISTING PLAN
	
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1PolicyOwner"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1Company"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1TypeOfPlan"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1LifeAssured"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1DeathBenefit"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1DisabilityBenefit"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1CriticalIllnessBenefit"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1OtherBenefit"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1PremiumContribution"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1Mode"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1MaturityDate"];

	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2PolicyOwner"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2Company"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2TypeOfPlan"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2LifeAssured"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2DeathBenefit"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2DisabilityBenefit"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2CriticalIllnessBenefit"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2OtherBenefit"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2PremiumContribution"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2Mode"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2MaturityDate"];

	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3PolicyOwner"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3Company"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3TypeOfPlan"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3LifeAssured"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3DeathBenefit"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3DisabilityBenefit"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3CriticalIllnessBenefit"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3OtherBenefit"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3PremiumContribution"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3Mode"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3MaturityDate"];
	
	//FNARetirement

	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasRetirement"];
    
	
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"RetirementNeedValidation"];
	[[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"0" forKey:@"Completed"];
	
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingRetirement1"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingRetirement2"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingRetirement3"];
	
	[[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"" forKey:@"ExistingRetirement1PolicyOwner"];
	[[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"" forKey:@"ExistingRetirement2PolicyOwner"];
	[[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"" forKey:@"ExistingRetirement3PolicyOwner"];
	
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementCurrent1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementRequired1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementDifference1"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementCustomerAlloc"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementPartnerAlloc"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementCustomerRely"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementPartnerRely"];
	
	//-- Existing plan
	
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1PolicyOwner"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1Company"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1TypeOfPlan"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1Premium"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1Frequency"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1StartDate"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1MaturityDate"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1SumMaturity"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1IncomeMaturity"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1AdditionalBenefit"];

	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2PolicyOwner"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2Company"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2TypeOfPlan"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2Premium"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2Frequency"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2StartDate"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2MaturityDate"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2SumMaturity"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2IncomeMaturity"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2AdditionalBenefit"];

	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3PolicyOwner"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3Company"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3TypeOfPlan"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3Premium"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3Frequency"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3StartDate"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3MaturityDate"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3SumMaturity"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3IncomeMaturity"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3AdditionalBenefit"];
	
	
	//FNAEducation
	
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasEducation"];
	
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasEducationChild"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"EducationRowToHide"];
	
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingEducation1"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingEducation2"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingEducation3"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingEducation4"];
	
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"EducationNeedValidation"];
	[[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"0" forKey:@"Completed"];
	
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationCurrent1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationRequired1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationDifference1"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationCurrent2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationRequired2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationDifference2"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationCurrent3"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationRequired3"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationDifference3"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationCurrent4"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationRequired4"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationDifference4"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationCustomerAlloc"];
    
	//-- existing plan
	
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1ChildName"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1Company"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1Premium"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1Frequency"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1StartDate"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1MaturityDate"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1ValueMaturity"];

	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2ChildName"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2Company"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2Premium"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2Frequency"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2StartDate"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2MaturityDate"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2ValueMaturity"];

	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3ChildName"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3Company"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3Premium"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3Frequency"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3StartDate"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3MaturityDate"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3ValueMaturity"];

	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4ChildName"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4Company"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4Premium"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4Frequency"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4StartDate"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4MaturityDate"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4ValueMaturity"];
	
    
	//FNASavings
	
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasSavings"];
	
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingSavings1"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingSavings2"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingSavings3"];

	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"SavingsNeedValidation"];
	[[obj.CFFData objectForKey:@"SecFSavings"] setValue:@"0" forKey:@"Completed"];
	
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"SavingsCurrent1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"SavingsRequired1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"SavingsDifference1"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"SavingsCustomerAlloc"];
	
	//--existing plan
	
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1PolicyOwner"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1Company"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1TypeOfPlan"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1Purpose"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1Premium"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1CommDate"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1AmountMaturity"];

	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings2PolicyOwner"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings2Company"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings2TypeOfPlan"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings2Purpose"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings2Premium"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings2CommDate"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings2AmountMaturity"];

	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings3PolicyOwner"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings3Company"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings3TypeOfPlan"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings3Purpose"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings3Premium"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings3CommDate"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings3AmountMaturity"];
	
	
	
	//CLEAR FLAG IN FNA
	
	UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3002];
    imageView = nil;
	imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3005];
	imageView.hidden = TRUE;
	imageView = nil;

}

@end
