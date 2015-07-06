//
//  ProtectionPlans.m
//  iMobile Planner
//
//  Created by Meng Cheong on 8/20/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ProtectionPlans.h"
#import "ExistingProtectionPlans.h"
#import "DataClass.h"
#import "textFields.h"

@interface ProtectionPlans (){
        DataClass *obj;
}

@end

@implementation ProtectionPlans
@synthesize ExistingProtectionPlansVC;

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
    
    BOOL doesContain = [self.myView.subviews containsObject:self.ExistingProtectionPlansVC.view];
    if (!doesContain){
        self.ExistingProtectionPlansVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ExistingProtectionPlans"];
        self.ExistingProtectionPlansVC.rowToUpdate = self.rowToUpdate;
        [self addChildViewController:self.ExistingProtectionPlansVC];
        [self.myView addSubview:self.ExistingProtectionPlansVC.view];
    }
    
    obj=[DataClass getInstance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doCancel:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000){
        [self.ExistingProtectionPlansVC.PolicyOwner becomeFirstResponder];
    }
    else if (alertView.tag == 1001){
        [self.ExistingProtectionPlansVC.Company becomeFirstResponder];
    }
    else if (alertView.tag == 1002){
        [self.ExistingProtectionPlansVC.TypeOfPlan becomeFirstResponder];
    }
    else if (alertView.tag == 1003){
        [self.ExistingProtectionPlansVC.LifrAssured becomeFirstResponder];
    }
    else if (alertView.tag == 1004){
        [self.ExistingProtectionPlansVC.DeathBenefit becomeFirstResponder];
    }
    else if (alertView.tag == 1005){
        [self.ExistingProtectionPlansVC.PremiumContribution becomeFirstResponder];
    }
    else if (alertView.tag == 1007){
        [self.ExistingProtectionPlansVC.MaturityDate becomeFirstResponder];
    }
	//fix for bug 2625 start
	else if (alertView.tag == 1008){
        [self.ExistingProtectionPlansVC.PolicyOwner becomeFirstResponder];
    }
	else if (alertView.tag == 1009){
        [self.ExistingProtectionPlansVC.LifrAssured becomeFirstResponder];
    }
	//fix for bug 2625 end
}

- (IBAction)doSave:(id)sender {
    
    [self.ExistingProtectionPlansVC doDeathBenefit:nil];
    [self.ExistingProtectionPlansVC doDisabilityBenefit1:nil];
    [self.ExistingProtectionPlansVC doCriticalIllnessBenefit:nil];
    [self.ExistingProtectionPlansVC doOtherBenefit:nil];
    [self.ExistingProtectionPlansVC doPremiumContribution:nil];
    
    if ([self.ExistingProtectionPlansVC.PolicyOwner.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Policy Owner is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1000;
        [alert show];
        alert = Nil;
        return;
    }
	//fix for bug 2625 start
	else if ([textFields validateString:self.ExistingProtectionPlansVC.PolicyOwner.text]){
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
	//fix for bug 2625 end
    else if ([self.ExistingProtectionPlansVC.Company.text length] == 0){
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
    else if ([self.ExistingProtectionPlansVC.TypeOfPlan.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Type of Plan is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1002;
        [alert show];
        alert = Nil;
        return;
    }
    else if ([self.ExistingProtectionPlansVC.LifrAssured.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Life Assured is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1003;
        [alert show];
        alert = Nil;
        return;
    }
	//fix for bug 2625 start
	else if ([textFields validateString:self.ExistingProtectionPlansVC.LifrAssured.text]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"The same alphabet cannot be repeated more than 3 times for Life Assured."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1009;
        [alert show];
        alert = Nil;
        return;
    }
	//fix for bug 2625 end
    else if ([self.ExistingProtectionPlansVC.DeathBenefit.text length] == 0 && [self.ExistingProtectionPlansVC.DisabledBenefit.text length] == 0 && [self.ExistingProtectionPlansVC.CriticalIllnessBenefit.text length] == 0 && [self.ExistingProtectionPlansVC.OtherBenefit.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"At least one Benefit is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1004;
        [alert show];
        alert = Nil;
        return;
    }
    else if ([self.ExistingProtectionPlansVC.PremiumContribution.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Premium is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1005;
        [alert show];
        alert = Nil;
        return;
    }
    else if (self.ExistingProtectionPlansVC.Mode.selectedSegmentIndex == -1){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Mode is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1006;
        [alert show];
        alert = Nil;
        return;
    }
    else if ([self.ExistingProtectionPlansVC.MaturityDate.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Maturity Date is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1007;
        [alert show];
        alert = Nil;
        return;
    }
    if (self.rowToUpdate == 1){
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.PolicyOwner.text forKey:@"ExistingProtection1PolicyOwner"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.Company.text forKey:@"ExistingProtection1Company"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.TypeOfPlan.text forKey:@"ExistingProtection1TypeOfPlan"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.LifrAssured.text forKey:@"ExistingProtection1LifeAssured"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.DeathBenefit.text forKey:@"ExistingProtection1DeathBenefit"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.DisabledBenefit.text forKey:@"ExistingProtection1DisabilityBenefit"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.CriticalIllnessBenefit.text forKey:@"ExistingProtection1CriticalIllnessBenefit"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.OtherBenefit.text forKey:@"ExistingProtection1OtherBenefit"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.PremiumContribution.text forKey:@"ExistingProtection1PremiumContribution"];
        
        if (self.ExistingProtectionPlansVC.Mode.selectedSegmentIndex != -1){
            [[obj.CFFData objectForKey:@"SecF"] setValue:[self.ExistingProtectionPlansVC.Mode titleForSegmentAtIndex:self.ExistingProtectionPlansVC.Mode.selectedSegmentIndex] forKey:@"ExistingProtection1Mode"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1Mode"];
        }
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.MaturityDate.text forKey:@"ExistingProtection1MaturityDate"];
    }
    else if (self.rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.PolicyOwner.text forKey:@"ExistingProtection2PolicyOwner"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.Company.text forKey:@"ExistingProtection2Company"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.TypeOfPlan.text forKey:@"ExistingProtection2TypeOfPlan"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.LifrAssured.text forKey:@"ExistingProtection2LifeAssured"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.DeathBenefit.text forKey:@"ExistingProtection2DeathBenefit"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.DisabledBenefit.text forKey:@"ExistingProtection1DisabilityBenefit"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.CriticalIllnessBenefit.text forKey:@"ExistingProtection2CriticalIllnessBenefit"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.OtherBenefit.text forKey:@"ExistingProtection2OtherBenefit"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.PremiumContribution.text forKey:@"ExistingProtection2PremiumContribution"];
        
        if (self.ExistingProtectionPlansVC.Mode.selectedSegmentIndex != -1){
            [[obj.CFFData objectForKey:@"SecF"] setValue:[self.ExistingProtectionPlansVC.Mode titleForSegmentAtIndex:self.ExistingProtectionPlansVC.Mode.selectedSegmentIndex] forKey:@"ExistingProtection2Mode"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2Mode"];
        }
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.MaturityDate.text forKey:@"ExistingProtection2MaturityDate"];
    }
    else if (self.rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.PolicyOwner.text forKey:@"ExistingProtection3PolicyOwner"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.Company.text forKey:@"ExistingProtection3Company"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.TypeOfPlan.text forKey:@"ExistingProtection3TypeOfPlan"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.LifrAssured.text forKey:@"ExistingProtection3LifeAssured"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.DeathBenefit.text forKey:@"ExistingProtection3DeathBenefit"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.DisabledBenefit.text forKey:@"ExistingProtection3DisabilityBenefit"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.CriticalIllnessBenefit.text forKey:@"ExistingProtection3CriticalIllnessBenefit"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.OtherBenefit.text forKey:@"ExistingProtection3OtherBenefit"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.PremiumContribution.text forKey:@"ExistingProtection3PremiumContribution"];
        
        if (self.ExistingProtectionPlansVC.Mode.selectedSegmentIndex != -1){
            [[obj.CFFData objectForKey:@"SecF"] setValue:[self.ExistingProtectionPlansVC.Mode titleForSegmentAtIndex:self.ExistingProtectionPlansVC.Mode.selectedSegmentIndex] forKey:@"ExistingProtection3Mode"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3Mode"];
        }
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingProtectionPlansVC.MaturityDate.text forKey:@"ExistingProtection3MaturityDate"];
    }
    
    [self.delegate ExistingProtectionPlansUpdate:self.ExistingProtectionPlansVC rowToUpdate:self.rowToUpdate];
}

-(void)doDelete:(int)rowToUpdate{
    if (self.rowToUpdate == 1){
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
    }
    else if (self.rowToUpdate == 2){
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
    }
    else if (self.rowToUpdate == 3){
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
    }
    [self.delegate ExistingProtectionPlansDelete:self.ExistingProtectionPlansVC rowToUpdate:self.rowToUpdate];
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
