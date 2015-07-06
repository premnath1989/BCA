//
//  SavingsPlans.m
//  iMobile Planner
//
//  Created by Meng Cheong on 8/26/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "SavingsPlans.h"
#import "DataClass.h"
#import "ExistingSavingAndInvestmentPlans.h"
#import "textFields.h" //fix for bug 2626

@interface SavingsPlans (){
    DataClass *obj;
}

@end

@implementation SavingsPlans
@synthesize ExistingSavingsPlansVC;

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
    
    
    BOOL doesContain = [self.myView.subviews containsObject:self.ExistingSavingsPlansVC.view];
    if (!doesContain){
        self.ExistingSavingsPlansVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ExistingSavingAndInvestmentPlans"];
        self.ExistingSavingsPlansVC.rowToUpdate = self.rowToUpdate;
        [self addChildViewController:self.ExistingSavingsPlansVC];
        [self.myView addSubview:self.ExistingSavingsPlansVC.view];
    }
    
    obj=[DataClass getInstance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000){
        [self.ExistingSavingsPlansVC.PolicyOwner becomeFirstResponder];
    }
    else if (alertView.tag == 1001){
        [self.ExistingSavingsPlansVC.Company becomeFirstResponder];
    }
    else if (alertView.tag == 1002){
        [self.ExistingSavingsPlansVC.TypeOfPlan becomeFirstResponder];
    }
    else if (alertView.tag == 1003){
        [self.ExistingSavingsPlansVC.Purpose becomeFirstResponder];
    }
    else if (alertView.tag == 1004){
        [self.ExistingSavingsPlansVC.Premium becomeFirstResponder];
    }
    else if (alertView.tag == 1005){
        [self.ExistingSavingsPlansVC.CommDate becomeFirstResponder];
    }
    else if (alertView.tag == 1006){
        [self.ExistingSavingsPlansVC.Premium becomeFirstResponder];
    }
    else if (alertView.tag == 1007){
        [self.ExistingSavingsPlansVC.AmountMaturity becomeFirstResponder];
    }
	//fix for bug 2626 start
	else if (alertView.tag == 1008){
        [self.ExistingSavingsPlansVC.PolicyOwner becomeFirstResponder];
    }
	//fix for bug 2626 end
}

- (IBAction)doSave:(id)sender {
    
    [self.ExistingSavingsPlansVC doPremium:nil];
    [self.ExistingSavingsPlansVC doAmountMaturity:nil];
    
    
    if([self.ExistingSavingsPlansVC.PolicyOwner.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Name is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1000;
        [alert show];
        alert = Nil;
        return;
    }
	//fix for bug 2626 start
	else if([textFields validateString:self.ExistingSavingsPlansVC.PolicyOwner.text]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"The same alphabet cannot be repeated more than 3 times for Policy Owner."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1008;
        [alert show];
        alert = Nil;
        return;
    }
	//fix for bug 2626 end
    else if([self.ExistingSavingsPlansVC.Company.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Company is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1001;
        [alert show];
        alert = Nil;
        return;
    }
    else if([self.ExistingSavingsPlansVC.TypeOfPlan.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Type of Savings/Investment is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1002;
        [alert show];
        alert = Nil;
        return;
    }
    else if([self.ExistingSavingsPlansVC.Purpose.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Purpose is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1003;
        [alert show];
        alert = Nil;
        return;
    }
    else if([self.ExistingSavingsPlansVC.Premium.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Premium is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1004;
        [alert show];
        alert = Nil;
        return;
    }
    else if([self.ExistingSavingsPlansVC.CommDate.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Commencement date is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1005;
        [alert show];
        alert = Nil;
        return;
    }
    else if ([self.ExistingSavingsPlansVC.Premium.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Premium must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1006;
        [alert show];
        alert = Nil;
        return;
    }
    else if ([self.ExistingSavingsPlansVC.AmountMaturity.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1007;
        [alert show];
        alert = Nil;
        return;
    }
    
    if (self.rowToUpdate == 1){
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingSavingsPlansVC.PolicyOwner.text forKey:@"ExistingSavings1PolicyOwner"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingSavingsPlansVC.Company.text forKey:@"ExistingSavings1Company"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingSavingsPlansVC.TypeOfPlan.text forKey:@"ExistingSavings1TypeOfPlan"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingSavingsPlansVC.Purpose.text forKey:@"ExistingSavings1Purpose"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingSavingsPlansVC.Premium.text forKey:@"ExistingSavings1Premium"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingSavingsPlansVC.CommDate.text forKey:@"ExistingSavings1CommDate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingSavingsPlansVC.AmountMaturity.text forKey:@"ExistingSavings1AmountMaturity"];
    }
    else if (self.rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingSavingsPlansVC.PolicyOwner.text forKey:@"ExistingSavings2PolicyOwner"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingSavingsPlansVC.Company.text forKey:@"ExistingSavings2Company"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingSavingsPlansVC.TypeOfPlan.text forKey:@"ExistingSavings2TypeOfPlan"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingSavingsPlansVC.Purpose.text forKey:@"ExistingSavings2Purpose"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingSavingsPlansVC.Premium.text forKey:@"ExistingSavings2Premium"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingSavingsPlansVC.CommDate.text forKey:@"ExistingSavings2CommDate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingSavingsPlansVC.AmountMaturity.text forKey:@"ExistingSavings2AmountMaturity"];
    }
    else if (self.rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingSavingsPlansVC.PolicyOwner.text forKey:@"ExistingSavings3PolicyOwner"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingSavingsPlansVC.Company.text forKey:@"ExistingSavings3Company"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingSavingsPlansVC.TypeOfPlan.text forKey:@"ExistingSavings3TypeOfPlan"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingSavingsPlansVC.Purpose.text forKey:@"ExistingSavings3Purpose"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingSavingsPlansVC.Premium.text forKey:@"ExistingSavings3Premium"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingSavingsPlansVC.CommDate.text forKey:@"ExistingSavings3CommDate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingSavingsPlansVC.AmountMaturity.text forKey:@"ExistingSavings3AmountMaturity"];
    }
    
    [self.delegate ExistingSavingsPlansUpdate:self.ExistingSavingsPlansVC rowToUpdate:self.rowToUpdate];
}

-(void)doDelete:(int)rowToUpdate{
    if (self.rowToUpdate == 1){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1PolicyOwner"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1Company"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1TypeOfPlan"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1Purpose"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1Premium"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1CommDate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1AmountMaturity"];
    }
    else if (self.rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings2PolicyOwner"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings2Company"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2TypeOfPlan"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings2Purpose"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings2Premium"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings2CommDate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings2AmountMaturity"];
    }
    else if (self.rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings3PolicyOwner"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings3Company"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3TypeOfPlan"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings3Purpose"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings3Premium"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings3CommDate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings3AmountMaturity"];
    }
    [self.delegate ExistingSavingsPlansDelete:self.ExistingSavingsPlansVC rowToUpdate:self.rowToUpdate];
}

- (IBAction)doCancel:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
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

@end
