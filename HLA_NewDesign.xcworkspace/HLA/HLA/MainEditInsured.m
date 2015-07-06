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

@interface MainEditInsured ()

{
    DataClass *obj;
    
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
        
        
        
        [self dismissModalViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewInsuredTable" object:self];
        [self dismissModalViewControllerAnimated:YES];
        
        // ViewInsuredRecord *parent = (ViewInsuredRecord *) self.presentingViewController;
        
        // [parent reloadTableRecord];
        
        
        
    }
    
    
    
}
-(BOOL)validate
{
    NSString *error = @"";
    if(insuredDetail.txtComp.text.length == 0)
    {
        error = @"Company Name is required.";
        [insuredDetail.txtComp becomeFirstResponder];
    }
    else if(insuredDetail.txtDisease.text.length == 0)
    {
        error = @"Diease is required.";
        [insuredDetail.txtDisease becomeFirstResponder];
        
    }
    else if(insuredDetail.txtAmount.text.length == 0){
        error = @"Amount is required.";
        [insuredDetail.txtAmount becomeFirstResponder];
        
    }
    else if(insuredDetail.txtYear.text.length == 0)
    {
        error = @"Year is required.";
        [insuredDetail.txtYear becomeFirstResponder];
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
