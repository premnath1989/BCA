//
//  MainAdditionalQuestions.m
//  iMobile Planner
//
//  Created by kuan on 9/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "MainAdditionalQuestInsureds.h"
#import "AddtionalQuestInsured.h"
#import "InsuredObject.h"

@interface MainAdditionalQuestInsureds ()
{
    InsuredObject *insuredObject;
}
@end

@implementation MainAdditionalQuestInsureds
@synthesize insuredArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    obj = [DataClass getInstance];
    insuredArray = [[NSMutableArray alloc]init];
	// Do any additional setup after loading the view.
    addtionalQuestInsured = [self.storyboard instantiateViewControllerWithIdentifier:@"AddtionalQuestInsured"];
	addtionalQuestInsured.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
	//	NSLog(@"trustee: %f, %f", self.view.frame.size.width, self.view.frame.size.height);
	[self addChildViewController:addtionalQuestInsured];
	[self.mainView addSubview:addtionalQuestInsured.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionForDone:(id)sender
{
    if ([self validSecF])
        
    {
        insuredObject = [[InsuredObject alloc] init];
        insuredObject.Company = addtionalQuestInsured.txtCompany.text;
        insuredObject.Year = addtionalQuestInsured.txtYear.text;
        insuredObject.Amount = addtionalQuestInsured.txtAmount.text;
        insuredObject.Diease = addtionalQuestInsured.txtDiease.text;
        
        
      //  NSLog(@"ADDITIONAL COUNT - % i", [[[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"] count]);
        int c = [[[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"] count];
        
        
        if(c == 0)
        {
            [insuredArray addObject:insuredObject];
            [[obj.eAppData objectForKey:@"SecF"] setValue:insuredArray forKey:@"Insured_Array"];
        }
        else{
            
            NSMutableArray *getArray  = [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"];
            
            [getArray addObject:insuredObject];
            
            [[obj.eAppData objectForKey:@"SecF"] setValue:getArray forKey:@"Insured_Array"];
        }
        
        
        
        //[self dismissModalViewControllerAnimated:YES];
        
        [self processComplete];
        [self dismissViewControllerAnimated:YES completion:Nil];
        
    }
    
    
    
}
-(BOOL)validSecF
{
    NSString *error = @"";
    if(addtionalQuestInsured.txtCompany.text.length == 0)
    {
        error = @"Company Name is required.";
        [addtionalQuestInsured.txtCompany becomeFirstResponder];
    }
    else if(addtionalQuestInsured.txtDiease.text.length == 0)
    {
        error = @"Life / Accident / Disease is required.";
        [addtionalQuestInsured.txtDiease becomeFirstResponder];
        
    }
    else if(addtionalQuestInsured.txtAmount.text.length == 0){
        error = @"Amount Insured is required.";
        [addtionalQuestInsured.txtAmount becomeFirstResponder];
        
    }
    
    else if(addtionalQuestInsured.txtYear.text.length == 0)
    {
        error = @"Year Inssured is required.";
        [addtionalQuestInsured.txtYear becomeFirstResponder];
    }
    
    
    if(error.length == 0)
    {
        return true;
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message: error
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert setTag:1003];
        [alert show];
        alert = Nil;
        return false;
    }
    
}

- (void)processComplete
{
	[[self delegate] processSuccessful:YES];
   // NSLog(@"complete ");
}

- (IBAction)actionForClose:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:Nil];
    
}

@end
