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

- (IBAction)doSave:(id)sender {
    
    
    if ([self.ChildrenandDependentsVC.childName.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Name is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        alert = Nil;
		[self.ChildrenandDependentsVC.childName becomeFirstResponder];
        return;
    }
	//fix for bug 2623 start
	else if ([textFields validateString:self.ChildrenandDependentsVC.childName.text]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"The same alphabet cannot be repeated 3 times for Name."
                              delegate: self cancelButtonTitle:@"OK"otherButtonTitles:nil];
        [alert show];
        alert = Nil;
		[self.ChildrenandDependentsVC.childName becomeFirstResponder];
        return;
    }
	//fix for bug 2623 end
    else if (self.ChildrenandDependentsVC.childGender.selectedSegmentIndex == -1){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
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
                              initWithTitle: @"iMobile Planner"
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
                              initWithTitle: @"iMobile Planner"
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
                              initWithTitle: @"iMobile Planner"
                              message:@"Year to support is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        alert = Nil;
		[self.ChildrenandDependentsVC.childSupport becomeFirstResponder];
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
        
        
        NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Sex"]);
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childDOB.text forKey:@"Childen1DOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childAge.text forKey:@"Childen1Age"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.relationship.text forKey:@"Childen1Relationship"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childSupport.text forKey:@"Childen1Support"];
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
    }
    else if (self.rowToUpdate == 4){
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childName.text forKey:@"Childen4Name"];
        if (self.ChildrenandDependentsVC.childGender.selectedSegmentIndex != -1){
            [[obj.CFFData objectForKey:@"SecC"] setValue:[self.ChildrenandDependentsVC.childGender titleForSegmentAtIndex:self.ChildrenandDependentsVC.childGender.selectedSegmentIndex] forKey:@"Childen4Sex"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Sex"];
        }
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childDOB.text forKey:@"Childen4DOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childAge.text forKey:@"Childen4Age"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.relationship.text forKey:@"Childen4Relationship"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:self.ChildrenandDependentsVC.childSupport.text forKey:@"Childen4Support"];
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
    }
    else if (self.rowToUpdate == 1){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Name"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Sex"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2DOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Age"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Relationship"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Support"];
    }
    else if (self.rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Name"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Sex"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3DOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Age"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Relationship"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Support"];
    }
    else if (self.rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Name"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Sex"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4DOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Age"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Relationship"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Support"];
    }
    else if (self.rowToUpdate == 0){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Name"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Sex"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5DOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Age"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Relationship"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Support"];
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


@end
