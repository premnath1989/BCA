//
//  InsuredDetail.m
//  iMobile Planner
//
//  Created by kuan on 9/20/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "InsuredDetail.h"
#import "DataClass.h"
#import "ViewInsuredRecord.h"
#import "ColorHexCode.h"
#import "InsuredObject.h"

@interface InsuredDetail ()
{
    DataClass *obj;
    
}

@end


@implementation InsuredDetail

@synthesize txtComp,txtYear,txtAmount,txtDisease;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    obj = [DataClass getInstance];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)deleteInsured:(id)sender {
    
    
    NSMutableArray *insured_Array = [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"];
    
     
    [insured_Array removeObjectAtIndex:self.view.tag];
    
    [[obj.eAppData objectForKey:@"SecF"] setValue:insured_Array forKey:@"Insured_Array"];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewInsuredTable" object:self];
    [self dismissModalViewControllerAnimated:YES];
    
}

- (IBAction)btnClose:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
    
}

- (IBAction)saveInsured:(id)sender {
    
    if([self validate])
    {
        NSMutableArray *insured_Array = [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"];
        
        
        InsuredObject *insured_Object =  insured_Array[self.view.tag];
        
        
        insured_Object.Company = self.txtComp.text;
        insured_Object.Diease = self.txtDisease.text;
        insured_Object.Year  = self.txtYear.text;
        insured_Object.Amount = self.txtAmount.text;
        
        insured_Array[self.view.tag] = insured_Object;
        [[obj.eAppData objectForKey:@"SecF"] setValue:insured_Array forKey:@"Insured_Array"];
        
        
        
        [self dismissModalViewControllerAnimated:YES];
        
        ViewInsuredRecord *parent = (ViewInsuredRecord *) self.presentingViewController;
        
        [parent reloadTableRecord];
        
        
        
    }
    
    
    
}

-(BOOL)validate
{
    NSString *error = @"";
    if(self.txtComp.text.length == 0)
    {
        error = @"Company Name is required.";
        [self.txtComp becomeFirstResponder];
    }
    else if(txtDisease.text.length == 0)
    {
        error = @"Diease is required.";
        [txtDisease becomeFirstResponder];
        
    }
    else if(txtAmount.text.length == 0){
        error = @"Amount is required.";
        [txtAmount becomeFirstResponder];
        
    }
    else if(txtYear.text.length == 0)
    {
        error = @"Year is required.";
        [txtYear becomeFirstResponder];
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



- (void)viewDidUnload {
    
    [super viewDidUnload];
}
@end
