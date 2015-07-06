//
//  MainEditInsured.m
//  iMobile Planner
//
//  Created by kuan on 9/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "MainEditInsured.h"
#import "DataClass.h"
#import "InsuredObject.h"
#import "textFields.h"

@interface MainEditInsured ()

{
    DataClass *obj;
    NSString *alertMsg;
    
}
@end

@implementation MainEditInsured
int record_row;
@synthesize mainView;

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
    
    
    [super viewDidLoad];
    
    
    
    
    NSMutableArray *insured_Array = [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"];
    
    
    InsuredObject *insured_Object =  insured_Array[record_row];
    
    
    
    //  insuredDetail.view.tag = indexPath.row;
    
    
    insuredDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"InsuredDetail"];
    insuredDetail.view.tag = record_row;
    
	insuredDetail.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
	
	[self addChildViewController:insuredDetail];
	[self.mainView addSubview:insuredDetail.view];
    
    insuredDetail.txtComp.text = insured_Object.Company;
    insuredDetail.txtDisease.text = insured_Object.Diease;
    insuredDetail.txtAmount.text = insured_Object.Amount;
    insuredDetail.txtYear.text = insured_Object.Year;
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
//	tap.cancelsTouchesInView = NO;
//	tap.numberOfTapsRequired = 1;
//	tap.delegate = self;
//	[self.view addGestureRecognizer:tap];
    
    
    
}
- (void) setRow:(int)row
{
    record_row = row;
    
    
    
}
- (IBAction)actionForClose:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)saveInsured:(id)sender {
    
    [insuredDetail.txtAmount resignFirstResponder];

   // [self hideKeyboard];
    if([self validate])
    {
        NSMutableArray *insured_Array = [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"];
        
        
        InsuredObject *insured_Object =  insured_Array[record_row];
        
        
        insured_Object.Company = insuredDetail.txtComp.text;
        insured_Object.Diease = insuredDetail.txtDisease.text;
        insured_Object.Year  = insuredDetail.txtYear.text;
        insured_Object.Amount = insuredDetail.txtAmount.text;
        
        insured_Array[record_row] = insured_Object;
        [[obj.eAppData objectForKey:@"SecF"] setValue:insured_Array forKey:@"Insured_Array"];
		[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
        
        
        
        [self dismissModalViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewInsuredTable" object:self];
        [self dismissModalViewControllerAnimated:YES];
        
        // ViewInsuredRecord *parent = (ViewInsuredRecord *) self.presentingViewController;
        
        // [parent reloadTableRecord];
        
        
        
    }
    
    
    
}
//-(BOOL)validate
//{
//    NSString *error = @"";
//    if([textFields trimWhiteSpaces:insuredDetail.txtComp.text].length == 0)
//    {
//        [self hideKeyboard];
//        error = @"Company Name is required.";
//        [insuredDetail.txtComp becomeFirstResponder];
//    }
//    
//    else if ([textFields trimWhiteSpaces:insuredDetail.txtComp.text].length > 0 && [textFields validateOtherID:insuredDetail.txtComp.text])
//    {
//        [self hideKeyboard];
//        error = @"Invalid name format. Input must be alphabet A-Z, space, apostrophe ('), alias(@), slash(/), dash(-), bracket(()) or dot(.).";
//        
//        [insuredDetail.txtComp becomeFirstResponder];
//    }
//
//	else if ([textFields validateString:insuredDetail.txtComp.text])
//    {
//        [self hideKeyboard];
//        error = @"Invalid Name format. Same alphabet cannot be repeated more than three times.";
//        [insuredDetail.txtComp becomeFirstResponder];
//    }
////    else if ([textFields validateString3:insuredDetail.txtComp.text]) {
////        error = @"Invalid name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.).";
////        [insuredDetail.txtComp becomeFirstResponder];
////    }
//    else if(insuredDetail.txtDisease.text.length == 0)
//    {
//        [self hideKeyboard];
//        error = @"Life / Accident / Critical Illness is required.";
//        [insuredDetail.txtDisease becomeFirstResponder];
//        
//    }
//    else if(insuredDetail.txtAmount.text.length == 0)
//    {
//        [self hideKeyboard];
//        error = @"Amount Insured is required.";
//        [insuredDetail.txtAmount becomeFirstResponder];
//        
//    }
//    
//    else if([insuredDetail.txtAmount.text intValue] <= 0)
//    {
//        [self hideKeyboard];
//        error = @"Amount Insured must be a numerical amount greater than zero and maximum 13 digits with 2 decimal points.";
//        [insuredDetail.txtAmount becomeFirstResponder];
//    }
//    
//    else if(insuredDetail.txtYear.text.length == 0)
//    {
//        [self hideKeyboard];
//        error = @"Year Issued is required.";
//        [insuredDetail.txtYear becomeFirstResponder];
//    }
//	else if([insuredDetail.txtYear.text intValue] == 0)
//    {
//        [self hideKeyboard];
//		error = @"Input must be integer greater than zero.";
//        [insuredDetail.txtYear becomeFirstResponder];
//	}
//    
//    if(error.length == 0)
//    {
//        return true;
//    }
//    else{
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle: @" "
//                              message: error
//                              delegate: self
//                              cancelButtonTitle:@"OK"
//                              otherButtonTitles:nil];
//        [alert setTag:1003];
//        [alert show];
//        alert = Nil;
//        return false;
//    }
//    
//}

-(void)hideKeyboard{
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
}



-(BOOL)validate

{
    
    NSString *error = @"";
    
    [insuredDetail.txtAmount resignFirstResponder]; 
    
    if([textFields trimWhiteSpaces:insuredDetail.txtComp.text].length == 0)
    {
        //error = @"Company Name is required.";
      //  [insuredDetail.txtComp resignFirstResponder];
        [self hideKeyboard];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Company Name is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 400;
        [alert show];
        alert = nil;
        return FALSE;
        
        NSLog(@"company_name");
    }
    
    if ([textFields trimWhiteSpaces:insuredDetail.txtComp.text].length > 0 && [textFields validateOtherID:insuredDetail.txtComp.text]) {
       // [insuredDetail.txtComp resignFirstResponder];
        [self hideKeyboard];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 400;
        [alert show];
        alert = nil;
        return FALSE;
    }
    
    if ([insuredDetail.txtComp.text isEqualToString:@"0"])
    {
       // [insuredDetail.txtComp resignFirstResponder];
        [self hideKeyboard];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"invalid Company Name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 400;
        [alert show];
        alert = nil;
        return FALSE;
    }
    
    
    
    if([textFields trimWhiteSpaces:insuredDetail.txtComp.text].length == 0)
    {
        //error = @"Company Name is required.";
       // [insuredDetail.txtComp resignFirstResponder];
        [self hideKeyboard];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Company Name is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 400;
        [alert show];
        alert = nil;
        return FALSE;
        
        
        
    }
	
	else if ([textFields validateString:insuredDetail.txtComp.text])
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
    else if(insuredDetail.txtDisease.text.length == 0)
    {
        // error = @"Life / Accident / Disease is required.";
        
       // [insuredDetail.txtDisease becomeFirstResponder];
        [self hideKeyboard];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Type of insurance (Life/Accident/Critical Illness) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 500;
        [alert show];
        alert = nil;
        return FALSE;
    }
    else if(insuredDetail.txtAmount.text.length == 0){
        //error = @"Amount Insured is required.";
     //   [insuredDetail.txtAmount becomeFirstResponder];
        [self hideKeyboard];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Amount Insured is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 600;
        [alert show];
        alert = nil;
        return FALSE;
    }
	//##ENS
	else if([insuredDetail.txtAmount.text intValue] <= 0){
        //error = @"Yearly Income must be a numerical amount greater than zero and maximum 13 digits with 2 decimal points.";
      //  [insuredDetail.txtAmount becomeFirstResponder];
        [self hideKeyboard];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Amount insured must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 600;
        [alert show];
        alert = nil;
        return FALSE;
    }
    else if(insuredDetail.txtYear.text.length == 0)
    {
        // error = @"Year Inssured is required.";
      //  [insuredDetail.txtYear becomeFirstResponder];
        [self hideKeyboard];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Year Issued is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 700;
        [alert show];
        alert = nil;
        return FALSE;
    }
	else if([insuredDetail.txtYear.text intValue] == 0) {
		//error = @"Input must be integer greater than zero.";
       // [insuredDetail.txtYear becomeFirstResponder];
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
     initWithTitle: @" "
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
        
        if ([self validate]){
            
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
			
        }
    }
    
	if (alertView.tag == 400) {
		[insuredDetail.txtComp becomeFirstResponder];
	}
	else if (alertView.tag == 500) {
		[insuredDetail.txtDisease becomeFirstResponder];
	}
	else if (alertView.tag == 600) {
		[insuredDetail.txtAmount becomeFirstResponder];
	}
	else if (alertView.tag == 700) {
		[insuredDetail.txtYear becomeFirstResponder];
	}
	
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
