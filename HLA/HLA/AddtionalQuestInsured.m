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
#import "textFields.h"
#define NUMBERS_ONLY @"0123456789,."

@interface AddtionalQuestInsured ()

{
    DataClass *obj;
    InsuredObject *insuredObject;
	NSString *amount_original;
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
    
    
    //NSLog(@"inThemain");
    
    txtAmount.delegate = self;
	txtCompany.delegate = self;
	txtDiease.delegate = self;
	txtYear.delegate = self;
	
	[txtAmount addTarget:self action:@selector(AmountChange:) forControlEvents:UIControlEventEditingDidEnd];
	txtYear.keyboardType = UIKeyboardTypeNumberPad;
    
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	tap.delegate = self;
	[self.view addGestureRecognizer:tap];
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
			[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
        }
        else{
            
            NSMutableArray *getArray  = [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"];
            
            [getArray addObject:insuredObject];
            
            [[obj.eAppData objectForKey:@"SecF"] setValue:getArray forKey:@"Insured_Array"];
			[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
        }
        
        
        
        [self dismissModalViewControllerAnimated:YES];
        
        [self processComplete];
        
    }
    
}

-(BOOL)validSecF
{
    NSString *error = @"";
    
    if([textFields trimWhiteSpaces:txtCompany.text].length == 0)
    {
        error = @"Company Name is required.";
        //NSLog(@"company_name2");
        [txtCompany becomeFirstResponder];
    }
    else if(txtDiease.text.length == 0)
    {
        error = @"Type of insurance (Life/Accident/Critical Illness) is required.";
        [txtDiease becomeFirstResponder];
        
    }
    else if(txtAmount.text.length == 0){
        error = @"Amount Insured is required.";
        [txtAmount becomeFirstResponder];
        
    }
	
	else if([txtAmount.text intValue] <= 0){
        error = @"Amount insured must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points.";
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
                              initWithTitle: @" "
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
    //NSLog(@"return ");
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


-(void)CloseWindow
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [self.SIDatePopover dismissPopoverAnimated:YES];
}
- (IBAction)actionForDOB:(id)sender {
    
    //UIKeyboardOrderOutAutomatic();
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    //txtYear.text = dateString;
	txtYear.textColor = [UIColor blackColor];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    
    if (_SIDate == Nil) {
        
        self.SIDate = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIDate"];
        _SIDate.delegate = self;
        self.SIDatePopover = [[UIPopoverController alloc] initWithContentViewController:_SIDate];
    }
    
    [self.SIDatePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.SIDatePopover presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    
    
    dateFormatter = Nil;
    dateString = Nil, mainStoryboard = nil;
}

-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *date = [dateFormatter dateFromString:strDate];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    txtYear.text = dateString;
	txtYear.textColor = [UIColor blackColor];
}

-(void)AmountChange:(id) sender
{
    txtAmount.text = [txtAmount.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    txtAmount.text = [txtAmount.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    txtAmount.text = [txtAmount.text stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *result;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setMaximumFractionDigits:2];
    [formatter setUsesGroupingSeparator:YES];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    double entryFieldFloat = [txtAmount.text doubleValue];
    
    
    
    if ([txtAmount.text rangeOfString:@".00"].length == 3) {
        
        formatter.alwaysShowsDecimalSeparator = YES;
        result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
        result = [result stringByAppendingFormat:@"00"];
        
    }
    else  if ([txtAmount.text rangeOfString:@"."].length == 1) {
        
        
        formatter.alwaysShowsDecimalSeparator = YES;
        result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
        
        
        
    }else if ([txtAmount.text rangeOfString:@"."].length != 1)
    {
        
        formatter.alwaysShowsDecimalSeparator = NO;
        
        result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
        result = [result stringByAppendingFormat:@".00"];
        //  NSLog(@"3 ky result - %@",result);
    }
    
    amount_original = txtAmount.text;
    
    if(txtAmount.text.length==0)
        txtAmount.text = @"";
    else
        txtAmount.text = result;

}





- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    	NSUInteger newLength = [textField.text length] + [string length] - range.length;
    /*if (textField == txtAmount) {
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 13));
	}*/
	if (textField == txtAmount) {
        BOOL return13digit = FALSE;
		//NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSString * AI = [textField.text stringByReplacingCharactersInRange:range withString:string];
		
        if ([AI rangeOfString:@"."].length == 1) {
            NSArray  *comp = [AI componentsSeparatedByString:@"."];
            NSString *get_num = [[comp objectAtIndex:0] stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            int c = [get_num length];
            if(c > 13)
            {
                return13digit = TRUE;
            }
			
        }else  if([AI rangeOfString:@"."].length == 0){
			NSArray  *comp = [AI componentsSeparatedByString:@"."];
            NSString *get_num = [[comp objectAtIndex:0] stringByReplacingOccurrencesOfString:@"," withString:@""];
            int c = [get_num length];
            if(c  > 13)
            {
				return13digit = TRUE;
            }
		}
        
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if( return13digit == TRUE)
            return (([string isEqualToString:filtered])&&(newLength <= 13));
        else
            return (([string isEqualToString:filtered])&&(newLength <= 16));
    }

	
	
	if (textField == txtCompany) {
		return ((newLength <= 25));
	}

	if (textField == txtDiease) {
		return ((newLength <= 25));
	}
	
	if (textField == txtYear) {
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 4));
		
	}
	
	
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == txtAmount)
    {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle: NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:0];
        textField.text = [[formatter stringFromNumber:[formatter numberFromString:textField.text]] stringByReplacingOccurrencesOfString:@"," withString:@""];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField //resign first responder for textfield
{
    [textField resignFirstResponder];
    return YES;
}
@end
