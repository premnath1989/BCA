//
//  EducationPlans.m
//  iMobile Planner
//
//  Created by Meng Cheong on 8/23/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "EducationPlans.h"
#import "DataClass.h"
#import "ExistingChildrenEducationPlans.h"

@interface EducationPlans (){
    DataClass *obj;
}

@end

@implementation EducationPlans
@synthesize ExistingChildrenEducationPlansVC;


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
    
    
    BOOL doesContain = [self.myView.subviews containsObject:self.ExistingChildrenEducationPlansVC.view];
    if (!doesContain){
        self.ExistingChildrenEducationPlansVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ExistingChildrenEducationPlans"];
        self.ExistingChildrenEducationPlansVC.rowToUpdate = self.rowToUpdate;
        [self addChildViewController:self.ExistingChildrenEducationPlansVC];
        [self.myView addSubview:self.ExistingChildrenEducationPlansVC.view];
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
        [self.ExistingChildrenEducationPlansVC.ChildName becomeFirstResponder];
    }
    else if (alertView.tag == 1001){
        [self.ExistingChildrenEducationPlansVC.Company becomeFirstResponder];
    }
    else if (alertView.tag == 1002){
        [self.ExistingChildrenEducationPlansVC.Premium becomeFirstResponder];
    }
    else if (alertView.tag == 1004){
        [self.ExistingChildrenEducationPlansVC.startDateLbl becomeFirstResponder];
    }
    else if (alertView.tag == 1005){
        [self.ExistingChildrenEducationPlansVC.maturityDateLbl becomeFirstResponder];
    }
    else if (alertView.tag == 1006){
        [self.ExistingChildrenEducationPlansVC.Premium becomeFirstResponder];
    }
}

- (IBAction)doSave:(id)sender {
    
    [self.ExistingChildrenEducationPlansVC PremiumAction:nil];
    [self.ExistingChildrenEducationPlansVC ProjectedValueAction:nil];
    
    if ([self.ExistingChildrenEducationPlansVC.ChildName.text length] == 0){
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
    else if ([self.ExistingChildrenEducationPlansVC.Company.text length] == 0){
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
    else if ([self.ExistingChildrenEducationPlansVC.Premium.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Premium is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1002;
        [alert show];
        alert = Nil;
        return;
    }
    else if (self.ExistingChildrenEducationPlansVC.Frequency.selectedSegmentIndex == -1){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Frequency is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        //alert.tag = 1004;
        [alert show];
        alert = Nil;
        return;
    }
    else if ([self.ExistingChildrenEducationPlansVC.startDateLbl.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Start Date is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1004;
        [alert show];
        alert = Nil;
        return;
    }
    else if ([self.ExistingChildrenEducationPlansVC.maturityDateLbl.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Maturity Date is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1005;
        [alert show];
        alert = Nil;
        return;
    }
    else if ([self.ExistingChildrenEducationPlansVC.Premium.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Premium (RM) must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 1006;
        [alert show];
        alert = Nil;
        return;
    }
    
    if (self.rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.ChildName.text forKey:@"ExistingEducation1ChildName"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.Company.text forKey:@"ExistingEducation1Company"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.Premium.text forKey:@"ExistingEducation1Premium"];
        if (self.ExistingChildrenEducationPlansVC.Frequency.selectedSegmentIndex != -1){
            [[obj.CFFData objectForKey:@"SecF"] setValue:[self.ExistingChildrenEducationPlansVC.Frequency titleForSegmentAtIndex:self.ExistingChildrenEducationPlansVC.Frequency.selectedSegmentIndex] forKey:@"ExistingEducation1Frequency"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1Frequency"];
        }
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.startDateLbl.text forKey:@"ExistingEducation1StartDate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.maturityDateLbl.text forKey:@"ExistingEducation1MaturityDate"];
        
        
        NSLog(@"TTTT%@",self.ExistingChildrenEducationPlansVC.maturityDateLbl.text);
        
        NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1MaturityDate"]);

        
        
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.ProjectedValue.text forKey:@"ExistingEducation1ValueMaturity"];
    }
    else if (self.rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.ChildName.text forKey:@"ExistingEducation2ChildName"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.Company.text forKey:@"ExistingEducation2Company"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.Premium.text forKey:@"ExistingEducation2Premium"];
        if (self.ExistingChildrenEducationPlansVC.Frequency.selectedSegmentIndex != -1){
            [[obj.CFFData objectForKey:@"SecF"] setValue:[self.ExistingChildrenEducationPlansVC.Frequency titleForSegmentAtIndex:self.ExistingChildrenEducationPlansVC.Frequency.selectedSegmentIndex] forKey:@"ExistingEducation2Frequency"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2Frequency"];
        }
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.startDateLbl.text forKey:@"ExistingEducation2StartDate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.maturityDateLbl.text forKey:@"ExistingEducation2MaturityDate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.ProjectedValue.text forKey:@"ExistingEducation2ValueMaturity"];
    }
    else if (self.rowToUpdate == 4){
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.ChildName.text forKey:@"ExistingEducation3ChildName"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.Company.text forKey:@"ExistingEducation3Company"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.Premium.text forKey:@"ExistingEducation3Premium"];
        if (self.ExistingChildrenEducationPlansVC.Frequency.selectedSegmentIndex != -1){
            [[obj.CFFData objectForKey:@"SecF"] setValue:[self.ExistingChildrenEducationPlansVC.Frequency titleForSegmentAtIndex:self.ExistingChildrenEducationPlansVC.Frequency.selectedSegmentIndex] forKey:@"ExistingEducation3Frequency"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3Frequency"];
        }
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.startDateLbl.text forKey:@"ExistingEducation3StartDate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.maturityDateLbl.text forKey:@"Existingeducation3MaturityDate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.ProjectedValue.text forKey:@"ExistingEducation3ValueMaturity"];
    }
    else if (self.rowToUpdate == 5){
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.ChildName.text forKey:@"ExistingEducation4ChildName"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.Company.text forKey:@"ExistingEducation4Company"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.Premium.text forKey:@"ExistingEducation4Premium"];
        if (self.ExistingChildrenEducationPlansVC.Frequency.selectedSegmentIndex != -1){
            [[obj.CFFData objectForKey:@"SecF"] setValue:[self.ExistingChildrenEducationPlansVC.Frequency titleForSegmentAtIndex:self.ExistingChildrenEducationPlansVC.Frequency.selectedSegmentIndex] forKey:@"ExistingEducation4Frequency"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4Frequency"];
        }
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.startDateLbl.text forKey:@"ExistingEducation4StartDate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.maturityDateLbl.text forKey:@"ExistingEducation4MaturityDate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:self.ExistingChildrenEducationPlansVC.ProjectedValue.text forKey:@"ExistingEducation4ValueMaturity"];
    }
    [self.delegate ExistingEducationPlansUpdate:self.ExistingChildrenEducationPlansVC rowToUpdate:self.rowToUpdate];
    
}

-(void)doDelete:(int)rowToUpdate{
    if (self.rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1ChildName"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1Company"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1Premium"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1Frequency"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1StartDate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1MaturityDate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1ValueMaturity"];
    }
    else if (self.rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2ChildName"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2Company"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2Premium"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2Frequency"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2StartDate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2MaturityDate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2ValueMaturity"];
    }
    else if (self.rowToUpdate == 4){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3ChildName"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3Company"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3Premium"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3Frequency"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3StartDate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3MaturityDate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3ValueMaturity"];
    }
    else if (self.rowToUpdate == 5){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4ChildName"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4Company"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4Premium"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4Frequency"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4StartDate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4MaturityDate"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4ValueMaturity"];
    }
    [self.delegate ExistingEducationPlansDelete:self.ExistingChildrenEducationPlansVC rowToUpdate:self.rowToUpdate];
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
