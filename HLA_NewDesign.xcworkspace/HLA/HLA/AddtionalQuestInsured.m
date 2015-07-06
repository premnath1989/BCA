//
//  AddtionalQuestInsured.m
//  iMobile Planner
//
//  Created by kuan on 9/15/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "AddtionalQuestInsured.h"
#import "DataClass.h"
#import "InsuredObject.h"
#import "ColorHexCode.h"

@interface AddtionalQuestInsured ()

{
    DataClass *obj;
    InsuredObject *insuredObject;
}
@end

@implementation AddtionalQuestInsured
@synthesize txtCompany,txtAmount,txtDiease,txtYear,insuredArray;
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
    obj = [DataClass getInstance];
    insuredArray = [[NSMutableArray alloc]init];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeVC:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}
- (IBAction)saveInsured:(id)sender
{
    
    if ([self validSecF])
        
    {
        insuredObject = [[InsuredObject alloc] init];
        insuredObject.Company = txtCompany.text;
        insuredObject.Year = txtYear.text;
        insuredObject.Amount = txtAmount.text;
        insuredObject.Diease = txtDiease.text;
        
        
        //NSLog(@"ADDITIONAL COUNT - % i", [[[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"] count]);
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
        
        
        
        [self dismissModalViewControllerAnimated:YES];
        
        [self processComplete];
        
    }
    
}

-(BOOL)validSecF
{
    NSString *error = @"";
    if(txtCompany.text.length == 0)
    {
        error = @"Company Name is required.";
        [txtCompany becomeFirstResponder];
    }
    else if(txtDiease.text.length == 0)
    {
        error = @"Life / Accident / Disease is required.";
        [txtDiease becomeFirstResponder];
        
    }
    else if(txtAmount.text.length == 0){
        error = @"Amount Insured is required.";
        [txtAmount becomeFirstResponder];
        
    }
    
    else if(txtYear.text.length == 0)
    {
        error = @"Year Issued is required.";
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

-(NSString*)startSomeProcess
{
    NSLog(@"return ");
    if([[[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"] count] > 0)
        
        return @"Good";
    
    else
        return @"None";
}

- (void)processComplete
{
	//[[self delegate] processSuccessful:YES];
    // NSLog(@"complete ");
}

@end
