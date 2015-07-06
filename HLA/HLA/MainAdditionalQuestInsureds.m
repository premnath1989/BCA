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
#import "textFields.h"


@interface MainAdditionalQuestInsureds ()
{
    InsuredObject *insuredObject;
	NSString *alertMsg;
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
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	tap.delegate = self;
	[self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionForDone:(id)sender
{
	[self hideKeyboard];
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
			[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
        }
        else{
            
            NSMutableArray *getArray  = [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"];
            
            [getArray addObject:insuredObject];
            
            [[obj.eAppData objectForKey:@"SecF"] setValue:getArray forKey:@"Insured_Array"];
			[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
        }
        
        
        
        //[self dismissModalViewControllerAnimated:YES];
        [self processComplete];
        [self dismissViewControllerAnimated:YES completion:Nil];
		
    }
    
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

-(BOOL)validSecF
{
    
    NSString *error = @"";
    
    
    if([textFields trimWhiteSpaces:addtionalQuestInsured.txtCompany.text].length == 0)
    {
        //error = @"Company Name is required.";
       // [addtionalQuestInsured.txtCompany resignFirstResponder];
        [self hideKeyboard];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Company Name is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 400;
        [alert show];
        alert = nil;
        return FALSE;
        
        NSLog(@"company_name");
    }
    
    if ([textFields trimWhiteSpaces:addtionalQuestInsured.txtCompany.text].length > 0 && [textFields validateOtherID:addtionalQuestInsured.txtCompany.text]) {
       // [addtionalQuestInsured.txtCompany resignFirstResponder];
        [self hideKeyboard];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 400;
        [alert show];
        alert = nil;
        return FALSE;
    }
    
    if ([addtionalQuestInsured.txtCompany.text isEqualToString:@"0"])
        {
       // [addtionalQuestInsured.txtCompany resignFirstResponder];
            [self hideKeyboard];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"invalid Company Name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 400;
        [alert show];
        alert = nil;
        return FALSE;
    }

    
    
    if([textFields trimWhiteSpaces:addtionalQuestInsured.txtCompany.text].length == 0)
    {
        //error = @"Company Name is required.";
        //[addtionalQuestInsured.txtCompany resignFirstResponder];
        [self hideKeyboard];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Company Name is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 400;
        [alert show];
        alert = nil;
        return FALSE;
        
        

    }
	
	else if ([textFields validateString:addtionalQuestInsured.txtCompany.text])
    {
        [self hideKeyboard];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid name format. Same alphabet cannot be repeated for more than three times." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 400;
		[alert show];
		alert = Nil;
		return FALSE;
	}
    //	else if ([textFields validateString3:addtionalQuestInsured.txtCompany.text]) {
    //		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //		alert.tag = 400;
    //		[alert show];
    //		alert = Nil;
    //		return FALSE;
    //	}
    else if(addtionalQuestInsured.txtDiease.text.length == 0)
    {
        // error = @"Life / Accident / Disease is required.";
       // [addtionalQuestInsured.txtDiease becomeFirstResponder];
        [self hideKeyboard];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Type of insurance (Life/Accident/Critical Illness) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 500;
        [alert show];
        alert = nil;
        return FALSE;
    }
    else if(addtionalQuestInsured.txtAmount.text.length == 0){
        //error = @"Amount Insured is required.";
       // [addtionalQuestInsured.txtAmount becomeFirstResponder];
        [self hideKeyboard];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Amount Insured is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 600;
        [alert show];
        alert = nil;
        return FALSE;
    }
	//##ENS
	else if([addtionalQuestInsured.txtAmount.text intValue] <= 0){
        //error = @"Yearly Income must be a numerical amount greater than zero and maximum 13 digits with 2 decimal points.";
       // [addtionalQuestInsured.txtAmount becomeFirstResponder];
        [self hideKeyboard];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Amount insured must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 600;
        [alert show];
        alert = nil;
        return FALSE;
    }
    else if(addtionalQuestInsured.txtYear.text.length == 0)
    {
        // error = @"Year Inssured is required.";
      //  [addtionalQuestInsured.txtYear becomeFirstResponder];
        [self hideKeyboard];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Year Issued is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 700;
        [alert show];
        alert = nil;
        return FALSE;
    }
	else if([addtionalQuestInsured.txtYear.text intValue] == 0) {
		//error = @"Input must be integer greater than zero.";
       // [addtionalQuestInsured.txtYear becomeFirstResponder];
        [self hideKeyboard];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Input must be integer greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 700;
        [alert show];
        alert = nil;
        return FALSE;
	}
    
    //if(error.length == 0)
    //{
    return true;
    //}
    //else{
    //[self hideKeyboard];
    
    /* UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @"iMobile Planner"
     message: error
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     [alert setTag:1003];
     [alert show];
     alert = Nil;
     return false;
     
     */
    
    // }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001 && buttonIndex == 0)
    {
        alertMsg = @"Record saved successfully.";
    }
    else if (alertView.tag == 1002 && buttonIndex == 0)
    {
        
        if ([self validSecF]){
            
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
			
        }
    }
    
	if (alertView.tag == 400) {
		[addtionalQuestInsured.txtCompany becomeFirstResponder];
	}
	else if (alertView.tag == 500) {
		[addtionalQuestInsured.txtDiease becomeFirstResponder];
	}
	else if (alertView.tag == 600) {
		[addtionalQuestInsured.txtAmount becomeFirstResponder];
	}
	else if (alertView.tag == 700) {
		[addtionalQuestInsured.txtYear becomeFirstResponder];
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
