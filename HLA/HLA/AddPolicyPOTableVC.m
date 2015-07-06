//
//  AddPolicyPOTableVC.m
//  iMobile Planner
//
//  Created by Juliana on 11/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "AddPolicyPOTableVC.h"
#import "DataClass.h"

#define CURRENCY @".0123456789"
#define CHARACTER_LIMIT_CURRENCY 13

@interface AddPolicyPOTableVC () {
	DataClass *obj;
	NSString *amount_original;
}

@end

@implementation AddPolicyPOTableVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    NSLog(@"3");
	_compNameTF.delegate = self;
	_dateIssuedTF.delegate = self;
    
    
    NSLog(@"addPolicytable");

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	obj = [DataClass getInstance];
	pn = [[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyPO"] objectForKey:@"WhichPolicy"]intValue];
	pc = [[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyPO"] objectForKey:@"Count"] intValue];
	pcm = pc-1;
	_arrayPolicy = [[NSMutableArray alloc] init];
	if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyPO"] objectForKey:@"PolicyData"] count] != 0) {
		_arrayPolicy = [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyPO"] objectForKey:@"PolicyData"];
	}
	
	[_lifeTermTF setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [_criticalIllnessTF setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [_accidentTF setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [_dailyHospitalIncomeTF setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
	
	[_lifeTermTF addTarget:self action:@selector(lifeTermChange:) forControlEvents:UIControlEventEditingDidEnd];
	[_criticalIllnessTF addTarget:self action:@selector(criticalIllnessChange:) forControlEvents:UIControlEventEditingDidEnd];
	[_accidentTF addTarget:self action:@selector(accidentChange:) forControlEvents:UIControlEventEditingDidEnd];
    [_dailyHospitalIncomeTF addTarget:self action:@selector(accidentChange:) forControlEvents:UIControlEventEditingDidEnd];

}

-(void)lifeTermChange:(id) sender
{
    _lifeTermTF.text = [_lifeTermTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    _lifeTermTF.text = [_lifeTermTF.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    _lifeTermTF.text = [_lifeTermTF.text stringByTrimmingCharactersInSet:
						[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *result;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setMaximumFractionDigits:2];
    [formatter setUsesGroupingSeparator:YES];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    double entryFieldFloat = [_lifeTermTF.text doubleValue];
    
    
    
    if ([_lifeTermTF.text rangeOfString:@".00"].length == 3) {
        
        formatter.alwaysShowsDecimalSeparator = YES;
        result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
        result = [result stringByAppendingFormat:@"00"];
        
    }
    else  if ([_lifeTermTF.text rangeOfString:@"."].length == 1) {
        
        
        formatter.alwaysShowsDecimalSeparator = YES;
        result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
        
        
        
    }else if ([_lifeTermTF.text rangeOfString:@"."].length != 1)
    {
        
        formatter.alwaysShowsDecimalSeparator = NO;
        
        result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
        result = [result stringByAppendingFormat:@".00"];
        //  NSLog(@"3 ky result - %@",result);
    }
    
    amount_original = _lifeTermTF.text;
    
    if(_lifeTermTF.text.length==0)
        _lifeTermTF.text = @"";
    else
        _lifeTermTF.text = result;
	
}


-(void)criticalIllnessChange:(id) sender
{
    _criticalIllnessTF.text = [_criticalIllnessTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    _criticalIllnessTF.text = [_criticalIllnessTF.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    _criticalIllnessTF.text = [_criticalIllnessTF.text stringByTrimmingCharactersInSet:
							   [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *result;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setMaximumFractionDigits:2];
    [formatter setUsesGroupingSeparator:YES];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    double entryFieldFloat = [_criticalIllnessTF.text doubleValue];
    
    
    
    if ([_criticalIllnessTF.text rangeOfString:@".00"].length == 3) {
        
        formatter.alwaysShowsDecimalSeparator = YES;
        result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
        result = [result stringByAppendingFormat:@"00"];
        
    }
    else  if ([_criticalIllnessTF.text rangeOfString:@"."].length == 1) {
        
        
        formatter.alwaysShowsDecimalSeparator = YES;
        result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
        
        
        
    }else if ([_criticalIllnessTF.text rangeOfString:@"."].length != 1)
    {
        
        formatter.alwaysShowsDecimalSeparator = NO;
        
        result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
        result = [result stringByAppendingFormat:@".00"];
        //  NSLog(@"3 ky result - %@",result);
    }
    
    amount_original = _criticalIllnessTF.text;
    
    if(_criticalIllnessTF.text.length==0)
        _criticalIllnessTF.text = @"";
    else
        _criticalIllnessTF.text = result;
	
}


-(void)accidentChange:(id) sender
{
    _accidentTF.text = [_accidentTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    _accidentTF.text = [_accidentTF.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    _accidentTF.text = [_accidentTF.text stringByTrimmingCharactersInSet:
						[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *result;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setMaximumFractionDigits:2];
    [formatter setUsesGroupingSeparator:YES];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    double entryFieldFloat = [_accidentTF.text doubleValue];
    
    
    
    if ([_accidentTF.text rangeOfString:@".00"].length == 3) {
        
        formatter.alwaysShowsDecimalSeparator = YES;
        result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
        result = [result stringByAppendingFormat:@"00"];
        
    }
    else  if ([_accidentTF.text rangeOfString:@"."].length == 1) {
        
        
        formatter.alwaysShowsDecimalSeparator = YES;
        result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
        
        
        
    }else if ([_accidentTF.text rangeOfString:@"."].length != 1)
    {
        
        formatter.alwaysShowsDecimalSeparator = NO;
        
        result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
        result = [result stringByAppendingFormat:@".00"];
        //  NSLog(@"3 ky result - %@",result);
    }
    
    amount_original = _accidentTF.text;
    
    if(_accidentTF.text.length==0)
        _accidentTF.text = @"";
    else
        _accidentTF.text = result;
	
}
-(void)dailyHospitalincomeChange:(id) sender
{
    _dailyHospitalIncomeTF.text = [_dailyHospitalIncomeTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    _dailyHospitalIncomeTF.text = [_dailyHospitalIncomeTF.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    _dailyHospitalIncomeTF.text = [_dailyHospitalIncomeTF.text stringByTrimmingCharactersInSet:
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
    result =[formatter stringFromNumber:[formatter numberFromString:_dailyHospitalIncomeTF.text]];
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
    
    /*
     
     if ([_criticalIllnessTF.text rangeOfString:@".00"].length == 3) {
     
     formatter.alwaysShowsDecimalSeparator = YES;
     result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
     result = [result stringByAppendingFormat:@"00"];
     
     }
     else  if ([_criticalIllnessTF.text rangeOfString:@"."].length == 1) {
     
     
     formatter.alwaysShowsDecimalSeparator = YES;
     result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
     //result = [result stringByAppendingFormat:@"0"];
     
     
     }else if ([_criticalIllnessTF.text rangeOfString:@"."].length != 1)
     {
     
     formatter.alwaysShowsDecimalSeparator = NO;
     
     result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
     result = [result stringByAppendingFormat:@".00"];
     //  NSLog(@"3 ky result - %@",result);
     }
     */
    amount_original = _dailyHospitalIncomeTF.text;
    
    if(_dailyHospitalIncomeTF.text.length==0)
        _dailyHospitalIncomeTF.text = @"";
    else
        _dailyHospitalIncomeTF.text = result;
    
	
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionForDeletePolicy:(id)sender {
	
	//	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] objectForKey:@"WhichPolicy"] != Nil) {
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Are you sure you want to delete selected record?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
	//		NSLog(@"no title");
	alert.tag = 11;
	[alert show];
	//	}
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 11 && buttonIndex == 0)
    {
        [_arrayPolicy removeObjectAtIndex:pn];
		
		[self dismissViewControllerAnimated:NO completion:^{
			NSLog(@"close");
			[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyPO"] setValue:_arrayPolicy  forKey:@"PolicyData"];
			[[NSNotificationCenter defaultCenter]postNotificationName:@"TestNotificationPO" object:self];
			[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
			//			[delegate reloadPolicyTable];
		}];
		
		
	}
	//	else if (alertView.tag == 11 && buttonIndex == 1) {
	//		[self dismissViewControllerAnimated:NO completion:Nil];
	//	}
}

- (void)viewDidDisappear:(BOOL)animated {
	NSLog(@"viewDidDisappear");
	
	//	NSLog(@"number: %@", [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] objectForKey:@"Count"]);
	//	[epl.mainTableView reloadData];
}


//- (IBAction)actionForPersonType:(id)sender {
//	if (_PersonTypePicker == nil) {
//        _PersonTypePicker = [[HealthQuestPersonType alloc] initWithStyle:UITableViewStylePlain];
//        _PersonTypePicker.delegate = self;
//        self.PersonTypePopover = [[UIPopoverController alloc] initWithContentViewController:_PersonTypePicker];
//    }
//    
//    [self.PersonTypePopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//}
//
//- (void)selectedPersonType:(NSString *)thePersonType {
//	_personTypeLbl.text = thePersonType;
//	[_PersonTypePopover dismissPopoverAnimated:YES];
//}

- (IBAction)actionForDateIssued:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    _dateIssuedLbl.text = dateString;
	//	_memberDOBLbl.textColor = [UIColor blackColor];
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
    _dateIssuedLbl.text = strDate;
	//	_memberDOBLbl.textColor = [UIColor blackColor];
}

-(void)CloseWindow
{NSLog(@"close");
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [self.SIDatePopover dismissPopoverAnimated:YES];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	NSUInteger newLength = [textField.text length] + [string length] - range.length;
	if (textField == _lifeTermTF || textField == _accidentTF || textField == _criticalIllnessTF||textField == _dailyHospitalIncomeTF) {
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
            return (([string isEqualToString:filtered])&&(newLength <= 16));
	}
	
	if (textField == _compNameTF) {
		return ((newLength <= 30));
	}
	else if (textField == _dateIssuedTF) {
		return ((newLength <= 15));
	}
	
	else return YES;
}

- (void)viewDidUnload {
	[self setDateIssuedLbl:nil];
	[self setDateIssuedTF:nil];
	[self setCriticalIllnessTF:nil];
	[self setAccidentTF:nil];
    [self setDailyHospitalIncomeTF:nil];
    
	[self setLifeTermTF:nil];
	[self setCompNameTF:nil];
	[self setPersonTypeLbl:nil];
	[self setDeleteBtn:nil];
	[self setRow2:nil];
	[super viewDidUnload];
}

- (void) dealloc
{
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
