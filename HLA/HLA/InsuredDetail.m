//
//  InsuredDetail.m
//  iMobile Planner
//
//  Created by kuan on 9/20/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "InsuredDetail.h"
#import "DataClass.h"
#import "textFields.h"
#import "ViewInsuredRecord.h"
#import "ColorHexCode.h"
#import "InsuredObject.h"

@interface InsuredDetail ()
{
    DataClass *obj;
	NSString *amount_original;
    
    
}

@end


@implementation InsuredDetail

@synthesize txtComp,txtYear,txtAmount,txtDisease,prefs;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    obj = [DataClass getInstance];
	txtComp.delegate = self;
	txtAmount.delegate = self;
	txtDisease.delegate = self;
	txtYear.delegate = self;
	
	[txtAmount addTarget:self action:@selector(Amount2:) forControlEvents:UIControlEventEditingDidEnd];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	tap.delegate = self;
	[self.view addGestureRecognizer:tap];
    
    //  NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // saving an NSString
    [prefs setObject:@"0" forKey:@"detectChangesLookupString"];
    
    
    [self.txtComp addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[self.txtAmount addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [self.txtDisease addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [self.txtYear addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
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


-(void)detectChanges:(id) sender
{
    [prefs setObject:@"detectChanges" forKey:@"detectChangesLookupString"];
    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
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
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
    
    
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
		[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
        
        
        
        [self dismissModalViewControllerAnimated:YES];
        
        ViewInsuredRecord *parent = (ViewInsuredRecord *) self.presentingViewController;
        
        [parent reloadTableRecord];
        
        
    }
    
    
    
}

-(BOOL)validate
{
    NSString *error = @"";
    if([textFields trimWhiteSpaces:self.txtComp.text].length == 0)
    {
        error = @"Company Name is required.";
        
        NSLog(@"edit2");
        [self.txtComp becomeFirstResponder];
    }
    
   
    else if(txtDisease.text.length == 0)
    {
        error =@"Type of insurance (Life/Accident/Critical Illness) is required.";
        [txtDisease becomeFirstResponder];
        
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
	else if([txtYear.text intValue] == 0) {
		error = @"Input must be integer greater than zero.";
        [txtYear becomeFirstResponder];
	}
    NSLog(@"ENS: txtyear: %@", txtYear.text);
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

-(void)Amount2:(id) sender
{
    txtAmount.text = [txtAmount.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    txtAmount.text = [txtAmount.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    txtAmount.text = [txtAmount.text stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]];
    
    
    NSString *result;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    //[formatter setUsesGroupingSeparator:YES];
    
    [formatter setPositiveFormat:@"#,##0.00"];
    //[formatter setRoundingMode: NSNumberFormatterRoundUp];
    // double entryFieldFloat = [_accidentTF.text doubleValue];
    //
    result =[formatter stringFromNumber:[formatter numberFromString:txtAmount.text]];
    NSLog(@"%@",result);
    NSArray  *comp = [result componentsSeparatedByString:@"."];
    
    if ((comp.count==0 || comp.count==1)) {
        result = [result stringByAppendingFormat:@".00"];//53545
        
    }
    if ([comp count]==2) {
        if([[comp objectAtIndex:1] length]==0){//53245.
            result = [result stringByAppendingFormat:@"00"];//
        }
        else if([[comp objectAtIndex:1] length]==1){//53452.2
            result = [result stringByAppendingFormat:@"0"];
        }
    }
    NSLog(@"%@",result);
    
    
    /*11
     //
     if ([_lifeTermTF.text rangeOfString:@".00"].length == 3) {
     
     formatter.alwaysShowsDecimalSeparator = YES;
     result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
     result = [result stringByAppendingFormat:@"00"];
     
     }
     else  if ([_lifeTermTF.text rangeOfString:@"."].length == 1) {
     
     
     formatter.alwaysShowsDecimalSeparator = YES;
     result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
     // result = [result stringByAppendingFormat:@"0"];
     
     
     }else if ([_lifeTermTF.text rangeOfString:@"."].length != 1)
     {
     
     formatter.alwaysShowsDecimalSeparator = NO;
     
     result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
     result = [result stringByAppendingFormat:@".00"];
     //  NSLog(@"3 ky result - %@",result);
     }
     */
    amount_original = txtAmount.text;
    
    if(txtAmount.text.length==0)
        txtAmount.text = @"";
    else
        txtAmount.text = result;
    
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
        
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890.,"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if( return13digit == TRUE)
            return (([string isEqualToString:filtered])&&(newLength <= 13));
        else
            return (([string isEqualToString:filtered])&&(newLength <= 13));
    }
	
	
	
	if (textField == txtComp)
    {
        NSLog(@"changes");
        
        
        
		return ((newLength <= 25));
	}
	
	if (textField == txtDisease) {
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



- (void)viewDidUnload {
    
    [super viewDidUnload];
}
@end
