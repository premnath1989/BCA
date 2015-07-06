//
//  ChildrenDependents.m
//  iMobile Planner
//
//  Created by Meng Cheong on 9/2/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ChildrenDependents.h"
#import "ChildrenandDependents.h"
#import "DataClass.h"
#import "textFields.h" //fix for bug 2623

@interface ChildrenDependents (){
    DataClass *obj;
}


@end

@implementation ChildrenDependents
@synthesize ChildrenandDependentsVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
    
    BOOL doesContain = [self.myView.subviews containsObject:self.ChildrenandDependentsVC.view];
    if (!doesContain){
        self.ChildrenandDependentsVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ChildrenandDependents"];
        self.ChildrenandDependentsVC.rowToUpdate = self.rowToUpdate;
        [self addChildViewController:self.ChildrenandDependentsVC];
        [self.myView addSubview:self.ChildrenandDependentsVC.view];
    }
    [self.myView setBackgroundColor:self.ChildrenandDependentsVC.view.backgroundColor];
    obj=[DataClass getInstance];
}

-(void)hideKeyboard{
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doCancel:(id)sender {
    self.ChildrenandDependentsVC.childAge.text = @"";
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)doSave:(id)sender {
    [self hideKeyboard];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
    
    if ([self.ChildrenandDependentsVC.childName.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Child name is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1001;
        [alert show];
        alert = Nil;
        return;
    }
	//fix for bug 2623 start
	else if ([textFields validateString:self.ChildrenandDependentsVC.childName.text]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Invalid name format. Same alphabet cannot be repeated more than 3 times."
                              delegate: self cancelButtonTitle:@"OK"otherButtonTitles:nil];
        alert.tag = 1001;
        [alert show];
        alert = Nil;
        return;
    }
    else if ([textFields validateString3:self.ChildrenandDependentsVC.childName.text]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Invalid Name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)"
                              delegate: self cancelButtonTitle:@"OK"otherButtonTitles:nil];
        alert.tag = 1001;
        [alert show];
        alert = Nil;
        return;
    }
	//fix for bug 2623 end
    else if (self.ChildrenandDependentsVC.childGender.selectedSegmentIndex == -1){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Sex is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        alert = Nil;
        return;
    }
	//fix for bug 2613 start
    else if ([self.ChildrenandDependentsVC.childDOB.text length] == 0 && [self.ChildrenandDependentsVC.childAge.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Either Date of Birth or Age is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        alert = Nil;
        return;
    }
	//fix for bug 2613 end
    else if ([self.ChildrenandDependentsVC.relationship.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Relationship is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        alert = Nil;
        return;
    }
    else if ([self.ChildrenandDependentsVC.childSupport.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Years to support is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1003;
        [alert show];
        alert = Nil;
        return;
    }
    else if ([self.ChildrenandDependentsVC.childSupport.text isEqualToString:@"0"]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Years to support must be numerical value and greater than zero."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1003;
        [alert show];
        alert = Nil;
        return;
    }
    
    bool exist = FALSE;
    for (int i = 1; i < 5; i++) {
        NSString *nameKey = [NSString stringWithFormat:@"Childen%dName", i];
        NSString *dobKey = [NSString stringWithFormat:@"Childen%dDOB", i];
        
        NSString *name = [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:nameKey]];
        NSString *dob = [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:dobKey]];
        
        if ([[textFields trimWhiteSpaces:self.ChildrenandDependentsVC.childName.text] isEqualToString:name] && self.rowToUpdate != i-1) {
            if ([[textFields trimWhiteSpaces:self.ChildrenandDependentsVC.childDOB.text] isEqualToString:dob]) {
                exist = TRUE;
                break;
            }
        }
    }
    
    if (exist) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Same Children and Dependents’ already exist." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
        return;
    }
    
    
    if (self.rowToUpdate == 0){
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childName.text forKey:@"Childen1Name"];
        
        //NSLog(@"%@",self.ChildrenandDependentsVC.childName.text);
        
        
        
        
        
        if (self.ChildrenandDependentsVC.childGender.selectedSegmentIndex != -1){
            [[obj.CFFData objectForKey:@"SecC"] setValue:[self.ChildrenandDependentsVC.childGender titleForSegmentAtIndex:self.ChildrenandDependentsVC.childGender.selectedSegmentIndex] forKey:@"Childen1Sex"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1Sex"];
        }
        
        
        //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Sex"]);
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childDOB.text forKey:@"Childen1DOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childAge.text forKey:@"Childen1Age"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.relationship.text forKey:@"Childen1Relationship"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childSupport.text forKey:@"Childen1Support"];
        
        NSString *check_IndexNO = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"SelectedClientProfileID"];
		if (![check_IndexNO isEqualToString:NULL] && ![check_IndexNO isEqualToString:@""]) {
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"SelectedClientProfileID"] forKey:@"Childen1ClientProfileID"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"Childen1AddFromCFF"];

        } else
        {
            [[obj.CFFData objectForKey:@"SecC"] setValue:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1ClientProfileID"] forKey:@"Childen1ClientProfileID"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"Childen1AddFromCFF" forKey:@"Childen1AddFromCFF"];
        }
        
        

    }
    else if (self.rowToUpdate == 1){
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childName.text forKey:@"Childen2Name"];
        if (self.ChildrenandDependentsVC.childGender.selectedSegmentIndex != -1){
            [[obj.CFFData objectForKey:@"SecC"] setValue:[self.ChildrenandDependentsVC.childGender titleForSegmentAtIndex:self.ChildrenandDependentsVC.childGender.selectedSegmentIndex] forKey:@"Childen2Sex"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Sex"];
        }
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childDOB.text forKey:@"Childen2DOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childAge.text forKey:@"Childen2Age"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.relationship.text forKey:@"Childen2Relationship"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childSupport.text forKey:@"Childen2Support"];
        
        NSString *check_IndexNO = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"SelectedClientProfileID"];
		if (![check_IndexNO isEqualToString:NULL] && ![check_IndexNO isEqualToString:@""]) {
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"SelectedClientProfileID"] forKey:@"Childen2ClientProfileID"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"Childen2AddFromCFF"];            
            
        } else
        {
            [[obj.CFFData objectForKey:@"SecC"] setValue:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2ClientProfileID"] forKey:@"Childen2ClientProfileID"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"Childen2AddFromCFF" forKey:@"Childen2AddFromCFF"];            
        }
        
    }
    else if (self.rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childName.text forKey:@"Childen3Name"];
        if (self.ChildrenandDependentsVC.childGender.selectedSegmentIndex != -1){
            [[obj.CFFData objectForKey:@"SecC"] setValue:[self.ChildrenandDependentsVC.childGender titleForSegmentAtIndex:self.ChildrenandDependentsVC.childGender.selectedSegmentIndex] forKey:@"Childen3Sex"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Sex"];
        }
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childDOB.text forKey:@"Childen3DOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childAge.text forKey:@"Childen3Age"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.relationship.text forKey:@"Childen3Relationship"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childSupport.text forKey:@"Childen3Support"];
        
        NSString *check_IndexNO = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"SelectedClientProfileID"];
		if (![check_IndexNO isEqualToString:NULL] && ![check_IndexNO isEqualToString:@""]) {
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"SelectedClientProfileID"] forKey:@"Childen3ClientProfileID"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"Childen3AddFromCFF"];            
            
        } else
        {
            [[obj.CFFData objectForKey:@"SecC"] setValue:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3ClientProfileID"] forKey:@"Childen3ClientProfileID"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"Childen3AddFromCFF" forKey:@"Childen3AddFromCFF"];            
        }
    }
    else if (self.rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childName.text forKey:@"Childen4Name"];
        if (self.ChildrenandDependentsVC.childGender.selectedSegmentIndex != -1){
            [[obj.CFFData objectForKey:@"SecC"] setValue:[self.ChildrenandDependentsVC.childGender titleForSegmentAtIndex:self.ChildrenandDependentsVC.childGender.selectedSegmentIndex] forKey:@"Childen4Sex"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Sex"];
        }
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childDOB.text forKey:@"Childen4DOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childAge.text forKey:@"Childen4Age"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.relationship.text forKey:@"Childen4Relationship"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childSupport.text forKey:@"Childen4Support"];
        
        NSString *check_IndexNO = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"SelectedClientProfileID"];
		if (![check_IndexNO isEqualToString:NULL] && ![check_IndexNO isEqualToString:@""]) {
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"SelectedClientProfileID"] forKey:@"Childen4ClientProfileID"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"Childen4AddFromCFF"];            
            
        } else
        {
            [[obj.CFFData objectForKey:@"SecC"] setValue:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4ClientProfileID"] forKey:@"Childen4ClientProfileID"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"Childen4AddFromCFF" forKey:@"Childen4AddFromCFF"];            
        }

    }
    else if (self.rowToUpdate == 4){
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childName.text forKey:@"Childen5Name"];
        if (self.ChildrenandDependentsVC.childGender.selectedSegmentIndex != -1){
            [[obj.CFFData objectForKey:@"SecC"] setValue:[self.ChildrenandDependentsVC.childGender titleForSegmentAtIndex:self.ChildrenandDependentsVC.childGender.selectedSegmentIndex] forKey:@"Childen5Sex"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Sex"];
        }
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childDOB.text forKey:@"Childen5DOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childAge.text forKey:@"Childen5Age"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.relationship.text forKey:@"Childen5Relationship"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childSupport.text forKey:@"Childen5Support"];

        NSString *check_IndexNO = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"SelectedClientProfileID"];
		if (![check_IndexNO isEqualToString:NULL] && ![check_IndexNO isEqualToString:@""]) {
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"SelectedClientProfileID"] forKey:@"Childen5ClientProfileID"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"Childen5AddFromCFF"];            
            
        } else
        {
            [[obj.CFFData objectForKey:@"SecC"] setValue:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5ClientProfileID"] forKey:@"Childen5ClientProfileID"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"Childen5AddFromCFF" forKey:@"Childen5AddFromCFF"];            
        }
        
    }
    [self.delegate ChildrenDependentsUpdate:self.ChildrenandDependentsVC rowToUpdate:self.rowToUpdate];
}
-(void)doDelete:(int)rowToUpdate{
    if (self.rowToUpdate == 0){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1Name"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1Sex"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1DOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1Age"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1Relationship"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1Support"];
		[[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1ClientProfileID"];
    }
    else if (self.rowToUpdate == 1){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Name"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Sex"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2DOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Age"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Relationship"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Support"];
		[[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2ClientProfileID"];
    }
    else if (self.rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Name"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Sex"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3DOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Age"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Relationship"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Support"];
		[[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3ClientProfileID"];
    }
    else if (self.rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Name"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Sex"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4DOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Age"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Relationship"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Support"];
		[[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4ClientProfileID"];
    }
    else if (self.rowToUpdate == 4){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Name"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Sex"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5DOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Age"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Relationship"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Support"];
		[[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5ClientProfileID"];
    }
    [self.delegate ChildrenDependentsDelete:self.ChildrenandDependentsVC rowToUpdate:self.rowToUpdate];
}

- (void)viewDidUnload {
    [self setMyView:nil];
    [super viewDidUnload];
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        switch (alertView.tag) {
            case 1001:
                [self.ChildrenandDependentsVC.childName becomeFirstResponder];
                break;
            case 1002:
                [self.ChildrenandDependentsVC.childDOB becomeFirstResponder];
                break;
            case 1003:
                [self.ChildrenandDependentsVC.childSupport becomeFirstResponder];
                break;
            default:
                break;
        }
        
    }
}
@end
