//
//  MainSubDetailsVC.m
//  iMobile Planner
//
//  Created by Juliana on 9/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "MainSubDetailsVC.h"
#import "DataClass.h"
#import "Utility.h"

@interface MainSubDetailsVC ()
{
      DataClass *obj;
    UIAlertView *alert;
}

@end

@implementation MainSubDetailsVC

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
    obj=[DataClass getInstance];
	// Do any additional setup after loading the view.
	subDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"SubDetails"];
	subDetails.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
//	NSLog(@"%f, %f", self.view.frame.size.width, self.view.frame.size.height);
	[self addChildViewController:subDetails];
	[self.mainView addSubview:subDetails.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
	[self setView:nil];
	[self setMainView:nil];
	[super viewDidUnload];
}
 
- (IBAction)selectDone:(id)sender {
   if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickPart2"] isEqualToString:@"Y"])
    {
     if (![[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickResidenceAdd"] isEqualToString:@"Y"] && ![[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickOfficeAdd"] isEqualToString:@"Y"])
     {
          
           [Utility showAllert:@"Correspondence Address is required."];
     }
    else if(subDetails.txtAdd1.text.length==0)
    {
        [subDetails.txtAdd1 becomeFirstResponder];
        [Utility showAllert:@"Address is required."];
        
      
    }
    else if(subDetails.txtPostcode1.text.length==0)
    {
        [subDetails.txtAdd1 resignFirstResponder];
        
        [subDetails.txtPostcode1 becomeFirstResponder];
        [Utility showAllert:@"Postcode is required."];
         
    }
    
    else if(subDetails.txtAdd2.text.length==0)
    {
        [subDetails.txtAdd1 resignFirstResponder];
        [subDetails.txtPostcode1 resignFirstResponder];
        
        [subDetails.txtAdd2 becomeFirstResponder];
        [Utility showAllert:@"Address is required."];
    }
    else if(subDetails.txtPostcode2.text.length==0)
    {
        [subDetails.txtAdd1 resignFirstResponder];
        [subDetails.txtPostcode1 resignFirstResponder];
        [subDetails.txtAdd2 resignFirstResponder];
        
        [subDetails.txtPostcode2 becomeFirstResponder];
        [Utility showAllert:@"Postcode is required."];
    }
    else if(subDetails.txtResidence2.text.length==0 && subDetails.txtMobile2.text.length==0 && subDetails.txtFax2.text.length==0 && subDetails.txtOffice2.text.length==0)
    {
        [subDetails.txtAdd1 resignFirstResponder];
        [subDetails.txtPostcode1 resignFirstResponder];
        [subDetails.txtAdd2 resignFirstResponder];
        [subDetails.txtPostcode2 resignFirstResponder];
        
        [subDetails.txtMobile1 becomeFirstResponder];
        [Utility showAllert:@"Either one Contact No. is required."];
    }
    else if(subDetails.txtName.text.length==0)
    {
        [subDetails.txtAdd1 resignFirstResponder];
        [subDetails.txtPostcode1 resignFirstResponder];
        [subDetails.txtAdd2 resignFirstResponder];
        [subDetails.txtPostcode2 resignFirstResponder];
        [subDetails.txtMobile1 resignFirstResponder];
        
        [subDetails.txtName becomeFirstResponder];
        [Utility showAllert:@"Name is required."];
    }
    else if(subDetails.txtIC.text.length==0)
    {
        [subDetails.txtAdd1 resignFirstResponder];
        [subDetails.txtPostcode1 resignFirstResponder];
        [subDetails.txtAdd2 resignFirstResponder];
        [subDetails.txtPostcode2 resignFirstResponder];
        [subDetails.txtMobile1 resignFirstResponder];
        [subDetails.txtName resignFirstResponder];
        
        [subDetails.txtIC becomeFirstResponder];
        [Utility showAllert:@"New IC No. is required."];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:Nil];
        [self saveData];
        [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"SecA_savedSubDetails"];
         
    }
    }
    else
        [self dismissViewControllerAnimated:YES completion:Nil];
     
}
-(void)saveData
{
     //Save Residence Address
    [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtAdd1.text forKey:@"Residence_add1"];
    [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtAdd12.text forKey:@"Residence_add2"];
    [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtAdd13.text forKey:@"Residence_add3"];
    [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtPostcode1.text forKey:@"Residence_postcode"];
    [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtTown1.text forKey:@"Residence_town"];
    [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtState1.text forKey:@"Residence_state"];
    [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtCountry1.text forKey:@"Residence_country"];
    
    
    //Save Office Address
    [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtAdd2.text forKey:@"Office_add1"];
    [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtAdd22.text forKey:@"Office_add2"];
    [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtAdd23.text forKey:@"Office_add3"];
    [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtPostcode2.text forKey:@"Office_postcode"];
    [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtTown2.text forKey:@"Office_town"];
    [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtState2.text forKey:@"Office_state"];
    [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtCountry2.text forKey:@"Office_country"];
    
    if(subDetails.txtResidence1.text.length!=0)
             [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtResidence1.text forKey:@"Contact_Residence1"];
 
    if(subDetails.txtResidence2.text.length!=0)
              [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtResidence2.text forKey:@"Contact_Residence2"];
    
    if(subDetails.txtMobile1.text.length!=0)
        [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtMobile1.text forKey:@"Contact_Mobile1"];
    
    if(subDetails.txtMobile2.text.length!=0)
        [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtMobile2.text forKey:@"Contact_Mobile2"];
    
    if(subDetails.txtOffice1.text.length!=0)
        [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtOffice1.text forKey:@"Contact_Office1"];
    
    if(subDetails.txtOffice2.text.length!=0)
        [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtOffice2.text forKey:@"Contact_Office2"];
    
    if(subDetails.txtFax1.text.length!=0)
        [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtFax1.text forKey:@"Contact_Fax1"];
    
    if(subDetails.txtFax2.text.length!=0)
        [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtFax2.text forKey:@"Contact_Fax2"];
    
    if(subDetails.txtEmail.text.length!=0)
        [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtEmail.text forKey:@"Contact_Email"];
    
    if(subDetails.txtName.text.length!=0)
        [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtName.text forKey:@"Contact_Name"];
    
    if(subDetails.txtIC.text.length!=0)
        [[obj.eAppData objectForKey:@"SecA"] setValue:subDetails.txtIC.text forKey:@"Contact_IC"];

}



- (IBAction)selectClose:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}






@end
