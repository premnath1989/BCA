//
//  AdditionalQuestions.m
//  iMobile Planner
//
//  Created by shawal sapuan on 6/21/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "AdditionalQuestions.h"
#import "ColorHexCode.h"
#import "AddtionalQuestInsured.h"
#import "ViewInsuredRecord.h"
#import "MainAdditionalQuestInsureds.h"
#import "MainViewInsured.h"
#import <QuartzCore/QuartzCore.h>

#define NUMBERS_ONLY @"0123456789.,"
#define CHARACTER_LIMIT 13


@interface AdditionalQuestions ()
{
    DataClass *obj;
	NSString *_incomeTF_original;
}
@end

@implementation AdditionalQuestions
//@synthesize addInsurerd,addInsurerdTableView,ViewAddInsurerdBtn;
@synthesize labelSurround;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _incomeTF.delegate = self;
	_nameTF.delegate = self;
	_reasonTF.delegate = self;
    obj = [DataClass getInstance];
    
    
	
	self.addInsurerd.enabled = false;
	self.ViewAddInsurerdBtn.enabled = false;
    
    _nameTF.adjustsFontSizeToFitWidth = YES;
    _nameTF.minimumFontSize = 0;
    
    
	[_incomeTF addTarget:self action:@selector(Amount2:) forControlEvents:UIControlEventEditingDidEnd];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disableViewBtn) name:@"disableViewBtn" object:nil];
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	
	results = Nil;
	results = [database executeQuery:@"select OccpCode from Clt_Profile as c where c.IndexNo = (select ClientProfileID from eApp_Listing where ProposalNo =?)",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
	while ([results next]) {
		occpToEnableSection = [results stringForColumn:@"OccpCode"];
	}
    
    
    //GET THE insured_objects - START
    results = Nil;
	results = [database executeQuery:@"SELECT A.AdditionalQuestionsInsured, B.AdditionalQuestionsCompany, B.AdditionalQuestionsAmountInsured, B.AdditionalQuestionsLifeAccidentDisease, B.AdditionalQuestionsYrIssued from eProposal_Additional_Questions_1 AS A, eProposal_Additional_Questions_2 AS B  WHERE A.eProposalNo = ? AND B.eProposalNo = ? ORDER BY B.AdditionalQuestionsCompany asc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"],[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"],Nil];
	NSMutableArray *insuredArray =  [[NSMutableArray alloc]init];
    
    while ([results next]) {
        
		if ([[results stringForColumn:@"AdditionalQuestionsInsured"] isEqualToString:@"True"])
        {
            InsuredObject *insuredObject;
            
            insuredObject = [[InsuredObject alloc] init];
            insuredObject.Company = [results stringForColumn:@"AdditionalQuestionsCompany"];
            insuredObject.Year = [results stringForColumn:@"AdditionalQuestionsYrIssued"];
            insuredObject.Amount = [results stringForColumn:@"AdditionalQuestionsAmountInsured"];
            insuredObject.Diease = [results stringForColumn:@"AdditionalQuestionsLifeAccidentDisease"];
            
            [insuredArray addObject:insuredObject];
        }
	}
    if (insuredArray.count > 0)
    {
        [[obj.eAppData objectForKey:@"SecF"] setValue:insuredArray forKey:@"Insured_Array"];
		[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
        
        _fivethQuesTitle.textColor =[UIColor blackColor];
        _reasonTF.textColor =[UIColor grayColor];
		_reasonTF.userInteractionEnabled = FALSE;
        _reasonTF.editable =FALSE;
        _reasonTF.text =Nil;
        _SixQuesTitle.textColor =[UIColor grayColor];
        [[self.reasonTF layer] setBorderColor:[[UIColor grayColor] CGColor]];
	}
    
        
    
    
    
    //GET THE insured_objects - END
    
    
	[results close];
	[database close];
	
      
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"e-Application";
    self.navigationItem.titleView = label;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnDone:)];
    
    //    [[self.reasonTF layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.reasonTF layer] setBorderWidth:1.0];
    [[self.reasonTF layer] setCornerRadius:0.1];
    
    
    NSString* name =  [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Name"];
    
    NSString* income =  [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Income"];
    
    
    NSString* occupation =  [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Occupation"];
    
    NSString* no_Reason =  [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"No_Reason"];
    
    NSString* seg_insured =  [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured"];
    
    int c =  [[[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"] count];
    
    if(name != NULL || ![name isEqualToString:@""])
        self.nameTF.text = name;
    if(income != NULL || ![income isEqualToString:@""])
        self.incomeTF.text = income;
    if(occupation != NULL || ![occupation isEqualToString:@""])
        self.occupationLbl.text = occupation;
    if(no_Reason != NULL || ![no_Reason isEqualToString:@""])
        self.reasonTF.text = no_Reason;
    if([seg_insured isEqualToString:@"True"])
        self.insuredSC.selectedSegmentIndex = 0;
    else if([seg_insured isEqualToString:@"False"])
        self.insuredSC.selectedSegmentIndex = 1;
    if(c > 0)
    {
        self.addInsurerd.enabled = true;
        self.ViewAddInsurerdBtn.enabled = true;
        //NSLog(@"alltrue");
    }
	else
    {
		self.addInsurerd.enabled = false;
        self.ViewAddInsurerdBtn.enabled = false;
        self.addInsurerd.enabled = FALSE;
        self.ViewAddInsurerdBtn.enabled = FALSE;
        _fivethQuesTitle.textColor =[UIColor grayColor];
		_reasonTF.editable = TRUE;
        _reasonTF.userInteractionEnabled =TRUE;
        _reasonTF.textColor =[UIColor blackColor];
        _SixQuesTitle.textColor =[UIColor blackColor];
        [[self.reasonTF layer] setBorderColor:[[UIColor blackColor] CGColor]];

        //NSLog(@"allfalse");
	}
	
	[self.nameTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[self.incomeTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    
    if (_insuredSC.selectedSegmentIndex == -1)
    {
        //NSLog(@"segemented_Control");
        _reasonTF.textColor =[UIColor grayColor];
        _reasonTF.userInteractionEnabled = FALSE;
        _reasonTF.editable =FALSE;
        _reasonTF.text =Nil;
        _fivethQuesTitle.textColor =[UIColor blackColor];
        [[self.reasonTF layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    }

    
}

- (void)disableViewBtn
{
    
    self.ViewAddInsurerdBtn.enabled = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setNameTF:nil];
    [self setIncomeTF:nil];
    [self setInsuredSC:nil];
    [self setOccupationLbl:nil];
    [self setInsuranceDetailsTblV:nil];
    [self setReasonTF:nil];
    [self setBtnOccupationPO:nil];
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)actionForOccupationPO:(id)sender {
	if (_OccupationVC == nil) {
        
        self.OccupationVC = [[OccupationList alloc] initWithStyle:UITableViewStylePlain];
        _OccupationVC.delegate = self;
        self.OccupationPopover = [[UIPopoverController alloc] initWithContentViewController:_OccupationVC];
    }
    
    [self.OccupationPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)AddInsured:(id)sender {
    
    MainAdditionalQuestInsureds *mepl = [self.storyboard instantiateViewControllerWithIdentifier:@"MainAdditionalQuestInsureds"];
	//	maptvc.delegate = self;
	mepl.modalPresentationStyle = UIModalPresentationFormSheet;
    [mepl setDelegate:self];
	[self presentViewController:mepl animated:YES completion:Nil];
    
}

- (void) processSuccessful:(BOOL)success
{
	
    
    self.ViewAddInsurerdBtn.enabled = true;
}

- (IBAction)viewInsured:(id)sender
{
    
    
    MainViewInsured *mainViewInsured = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewInsured"];
	//	maptvc.delegate = self;
	mainViewInsured.modalPresentationStyle = UIModalPresentationFormSheet;
    // [mainViewInsured setDelegate:self];
	[self presentViewController:mainViewInsured animated:YES completion:Nil];
    
    
    
}

- (void)OccupDescSelected:(NSString *) OccupDesc
{
	_occupationLbl.text = OccupDesc;
	_occupationLbl.textColor = [UIColor blackColor];
    [self.OccupationPopover dismissPopoverAnimated:YES];
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
}

- (void)OccupCodeSelected:(NSString *) OccupCode {
	
}
- (void)OccupClassSelected:(NSString *) OccupClass {
	
}

- (IBAction)SelectInsured:(id)sender
{
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
    if(self.insuredSC.selectedSegmentIndex == 0)
    {
        self.addInsurerd.enabled = TRUE;
        NSMutableArray *insured_Array = [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"];
        

        
        if(insured_Array.count > 0)
            self.ViewAddInsurerdBtn.enabled = TRUE;
        
        
        else
            _fivethQuesTitle.textColor =[UIColor blackColor];
        _reasonTF.textColor =[UIColor grayColor];
		_reasonTF.userInteractionEnabled = FALSE;
        _reasonTF.editable =FALSE;
        _reasonTF.text =Nil;
        _SixQuesTitle.textColor =[UIColor grayColor];
        [[self.reasonTF layer] setBorderColor:[[UIColor grayColor] CGColor]];
        
        
    }
    
    else if(self.insuredSC.selectedSegmentIndex == 1)
    {
        self.addInsurerd.enabled = FALSE;
        self.ViewAddInsurerdBtn.enabled = FALSE;
        _fivethQuesTitle.textColor =[UIColor grayColor];
		_reasonTF.editable = TRUE;
        _reasonTF.userInteractionEnabled =TRUE;
        _reasonTF.textColor =[UIColor blackColor];
        _SixQuesTitle.textColor =[UIColor blackColor];
        [[self.reasonTF layer] setBorderColor:[[UIColor blackColor] CGColor]];
        
        NSMutableArray *insured_Array = [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"];
        
        if(insured_Array.count > 0)
        {
            [insured_Array removeAllObjects];
        }
        
    }
}


-(void)AmountChange:(id) sender
{
    _incomeTF.text = [_incomeTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    _incomeTF.text = [_incomeTF.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    _incomeTF.text = [_incomeTF.text stringByTrimmingCharactersInSet:
					  [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *result;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setMaximumFractionDigits:2];
    [formatter setUsesGroupingSeparator:YES];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    double entryFieldFloat = [_incomeTF.text doubleValue];
    
    
    if ([_incomeTF.text rangeOfString:@".00"].length == 3)
    {
        
        formatter.alwaysShowsDecimalSeparator = YES;
        result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
        result = [result stringByAppendingFormat:@"00"];
        
    }
    else  if ([_incomeTF.text rangeOfString:@"."].length == 1)
    {
        
        
        formatter.alwaysShowsDecimalSeparator = YES;
        result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
        
        
        
    }else if ([_incomeTF.text rangeOfString:@"."].length != 1)
    {
        
        formatter.alwaysShowsDecimalSeparator = NO;
        
        result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
        result = [result stringByAppendingFormat:@".00"];
        
        
    }
    
    _incomeTF_original = _incomeTF.text;
    
    if(_incomeTF.text.length==0)
        _incomeTF.text = @"";
    else
        _incomeTF.text = result;
	
}

-(void)Amount2:(id) sender
{
    _incomeTF.text = [_incomeTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    _incomeTF.text = [_incomeTF.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    _incomeTF.text = [_incomeTF.text stringByTrimmingCharactersInSet:
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
    result =[formatter stringFromNumber:[formatter numberFromString:_incomeTF.text]];
    //NSLog(@"%@",result);
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
    //NSLog(@"%@",result);
    
    
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
    _incomeTF_original = _incomeTF.text;
    
    if(_incomeTF.text.length==0)
        _incomeTF.text = @"";
    else
        _incomeTF.text = result;
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    /*if (textField == _incomeTF) {
     NSUInteger newLength = [textField.text length] + [string length] - range.length;
     NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
     NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
     return (([string isEqualToString:filtered]) && newLength <= 15);
     }*/
	NSUInteger newLength = [textField.text length] + [string length] - range.length;
	if (textField == _incomeTF)
        
    {
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
    
	if (textField == _nameTF)
    {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz./@'()-"] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered]) && newLength <= 50);
	}
    //	if (textField == _reasonTF)
    //    {
    //		NSUInteger newLength = [textField.text length] + [string length] - range.length;
    //
    //		return ((newLength <= 255));
    //	}
	
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _incomeTF)
    {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle: NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:0];
        textField.text = [[formatter stringFromNumber:[formatter numberFromString:textField.text]] stringByReplacingOccurrencesOfString:@"," withString:@""];
        

    }
}



-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == _reasonTF)
    {
		NSUInteger newLength = [textView.text length] + [text length] - range.length;
        
		return ((newLength <= 255));
	}
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField //resign first responder for textfield
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
}

-(void)detectChanges:(id) sender
{
    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
}

@end
