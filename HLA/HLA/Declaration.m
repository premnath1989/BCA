//
//  Declaration.m
//  iMobile Planner
//
//  Created by Erza on 6/18/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "Declaration.h"
#import "ColorHexCode.h"
#import "DataClass.h"



@interface Declaration ()
{
    DataClass *obj;
   // UILabel *part10lbl;
}

@end

@implementation Declaration
@synthesize btnAgree,btnDisagree;
@synthesize btnIndidual10a,btnIndidual10b,btnIndidual10c;
@synthesize btnCompany10a,btnCompany10a1,btnCompany10b,btnCompany10c,btnCompany10d,btnCompany10e,btnCompany10e1,btnCompany10e2,btnCompany10f;
@synthesize agreed,disagreed,QuestionSElectOne,CaseType,PersonChoice,BizCategoryChoice,BizCategoryChoiceQuest4,EntityType,POBox,OfficeForeign,ResidenceForeign,ResidenceForeign_POBOX,OfficeForeign_POBOX;

- (void)viewDidLoad
{
    [super viewDidLoad];
     obj = [DataClass getInstance];
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
    
    _FATCATV.delegate = self;
    _GIINTF.delegate = self;
    
    NSString *otherIDType_check = @"CR";
    NSString *ptypeCode_check = @"PO";
    NSString *comcase = @"No";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *results_check_comcase = [database executeQuery:@"SELECT * from eProposal_LA_Details WHERE eProposalNo = ? AND PTypeCode =? AND LAOtherIDType = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], ptypeCode_check, otherIDType_check];
    
    while ([results_check_comcase next]) {
        //NSLog(@"Company case, CA and CFF will not be generated!");
        comcase = @"Yes";
        
        
    }
    
    if ([comcase isEqualToString:@"No"])
    {
        
        
        CaseType =@"Individual";
            
        }
        
    else
    {
       
        CaseType =@"Company";
    }

	FMDatabase *db = [FMDatabase databaseWithPath:path];
    if (![db open]) {
        NSLog(@"Could not open db.");
        db = [FMDatabase databaseWithPath:path];
        
        [db open];
    }
    
    
    NSString *displayThis = nil;
    displayThis = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    if (displayThis ==nil) {
        displayThis = @"";
    }
    
    
    NSString *selectPO = [NSString stringWithFormat:@"select OfficeForeignAddressFlag,ResidenceForeignAddressFlag,Residence_POBOX,Office_POBOX,MalaysianWithPOBox  FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'",displayThis];
    
	
    
		FMResultSet *results;
        results = [db executeQuery:selectPO];
        while ([results next])
        {
			
		   ResidenceForeign =[results objectForColumnName:@"ResidenceForeignAddressFlag"];
		   OfficeForeign =[results objectForColumnName:@"OfficeForeignAddressFlag"];
		   ResidenceForeign_POBOX = [results objectForColumnName:@"Residence_POBOX"];
		   OfficeForeign_POBOX = [results objectForColumnName:@"Office_POBOX"];
           POBox = [results objectForColumnName:@"MalaysianWithPOBox"];

		}
	
//    //---retrieve data start---
//	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docsPath = [paths objectAtIndex:0];
//    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
//    FMDatabase *database = [FMDatabase databaseWithPath:path];
//    [database open];
//	stringID = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
//	NSLog(@"string id: %@, si: %@", stringID, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"]);
//	//SEC A - CO start
//	results2 = Nil;
//	//		while ([results next]) {
//	results2 = [database executeQuery:@"select * from  eProposal where eProposalNo = ?",stringID,Nil];
//	while ([results2 next]) {
//		[[obj.eAppData objectForKey:@"SecG"] setValue:[results2 stringForColumn:@"DeclarationAuthorization"] forKey:@"Declaration_agree"];
//	}
//	[results2 close];
//	[database close];
//	//---retrieve data end---
	
	
//    part10lbl =[[UILabel alloc]initWithFrame:CGRectMake(70, 645 , 400, 40)];
//    part10lbl.backgroundColor =[UIColor clearColor];
//    part10lbl.font =[UIFont boldSystemFontOfSize:15];
//    part10lbl.text =@"Part 10: Foreign Account Tax Compliance Act (FATCA) ";
//    part10lbl.textColor =[UIColor blackColor];
//    [self.view addSubview:part10lbl];
    
    agreed = NO;
    disagreed = NO;
    
	agree =  [[obj.eAppData objectForKey:@"SecG"] objectForKey:@"Declaration_agree"];
    NSLog(@"agree %@", agree);
    if([agree isEqualToString:@"Y"])
    {
        [btnAgree setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        agreed = YES;
    }
    else if ([agree isEqualToString:@"N"])
    {
        [btnDisagree setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        disagreed = YES;

    }
	
	obj=[DataClass getInstance];
	NSString *proposalStatus = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ProposalStatus"];
	
	if ([proposalStatus isEqualToString:@"Confirmed"] || [proposalStatus isEqualToString:@"3"]) {
		btnAgree.enabled = FALSE;
		btnDisagree.enabled = FALSE;
	}
    NSString *Selection;
    
   Selection = [[obj.eAppData objectForKey:@"SecG"] objectForKey:@"FACTA_Q2"];
    if ([Selection isEqualToString:@"1"])
    {
        [btnIndidual10a setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        [[obj.eAppData objectForKey:@"SecG"] setValue:@"1" forKey:@"FACTA_Q2"];
        PersonChoice =@"1";

    }
    else if([Selection isEqualToString:@"2"])
    {
        [btnIndidual10b setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        [[obj.eAppData objectForKey:@"SecG"] setValue:@"2" forKey:@"FACTA_Q2"];
        PersonChoice =@"2";


        
    }
    
    else if([Selection isEqualToString:@"3"])
    {
        [btnIndidual10c setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        
        [[obj.eAppData objectForKey:@"SecG"] setValue:@"3" forKey:@"FACTA_Q2"];
        PersonChoice =@"3";

    }
    
    
    NSString *SelectionCompany;
    
    //disable
    _FATCATV.userInteractionEnabled=FALSE;
    _GIINTF.enabled = FALSE;
    
    SelectionCompany = [[obj.eAppData objectForKey:@"SecG"] objectForKey:@"FACTA_Q4"];
    {
        if ([SelectionCompany isEqualToString:@"1"])
        {
            [btnCompany10a setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            [btnCompany10a1 setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"1" forKey:@"FACTA_Q4"];
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q4_Ans_1"];
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q4_ANS_2"];
            
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q5_Entity"];
            
            
            BizCategoryChoice =@"1";
            QuestionSElectOne =NO;
         
        }
        
        else if ([SelectionCompany isEqualToString:@"2"])
        {
            [btnCompany10b setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"2" forKey:@"FACTA_Q4"];
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q4_Ans_1"];
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q4_ANS_2"];
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q5_Entity"];
            
            
            BizCategoryChoice =@"2";
            QuestionSElectOne =NO;

                      
        }
        else if ([SelectionCompany isEqualToString:@"3"])
        {
            [btnCompany10c setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"3" forKey:@"FACTA_Q4"];
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q4_Ans_1"];
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q4_ANS_2"];
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q5_Entity"];
            
            BizCategoryChoice =@"3";
            QuestionSElectOne =NO;
            
        }
        
        else if ([SelectionCompany isEqualToString:@"4"])
        {
            
            //enable
            _FATCATV.userInteractionEnabled=TRUE;
            _GIINTF.enabled = TRUE;

            [btnCompany10d setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            
            _FATCATV.text =[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"FACTA_Q4_Ans_1"];
            _GIINTF.text =[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"FACTA_Q4_ANS_2"];
            
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"4" forKey:@"FACTA_Q4"];
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q5_Entity"];
            
            BizCategoryChoice =@"4";
            QuestionSElectOne =NO;
            
        }
        else if ([SelectionCompany isEqualToString:@"5"])
        {
           
            
            [btnCompany10e setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            
            NSString *SelectionEntity = [[obj.eAppData objectForKey:@"SecG"] objectForKey:@"FACTA_Q5_Entity"];
        
            
            if ([SelectionEntity isEqualToString:@"1"])
            {
                [btnCompany10e1 setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
                EntityType =@"yes";
                
                [[obj.eAppData objectForKey:@"SecG"] setValue:@"1" forKey:@"FACTA_Q5_Entity"];
            }
            else if ([SelectionEntity isEqualToString:@"2"])
            {
                 [btnCompany10e2 setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
                EntityType =@"yes";
                
                [[obj.eAppData objectForKey:@"SecG"] setValue:@"2" forKey:@"FACTA_Q5_Entity"];
            }
            
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"5" forKey:@"FACTA_Q4"];
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q4_Ans_1"];
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q4_ANS_2"];
            
            
            BizCategoryChoice =@"5";

            
        }
        else if ([SelectionCompany isEqualToString:@"6"])
        {
            [btnCompany10f setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            
            QuestionSElectOne =NO;
            
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"6" forKey:@"FACTA_Q4"];
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q4_Ans_1"];
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q4_ANS_2"];
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q5_Entity"];
            
            
            BizCategoryChoice =@"7";

        }
    }
    
    
}

- (void)btnDone:(id)sender
{
    
    
}

- (IBAction)isAgree:(id)sender
{

    UIButton *btnPressed = (UIButton*)sender;
    
    if (btnPressed.tag == 1) {


            [btnAgree setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            agreed = YES;
            
            [btnDisagree setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
            disagreed = NO;
		[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
    }
    
    else if (btnPressed.tag == 2) {
 

            [btnDisagree setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            disagreed = YES;
            
            [btnAgree setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
            agreed = NO;
        [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
    }
}
- (IBAction)isIndidual10a:(id)sender
{
	if (([ResidenceForeign isEqualToString:@"Y"]||[OfficeForeign isEqualToString:@"Y"])&&([ResidenceForeign_POBOX isEqualToString:@"Y"]&&[OfficeForeign_POBOX isEqualToString:@"Y"]))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid option in view of no permanent address is provided" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];

	}
	
	else
	{
		[btnIndidual10a setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[btnIndidual10b setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[btnIndidual10c setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		
		[[obj.eAppData objectForKey:@"SecG"] setValue:@"1" forKey:@"FACTA_Q2"];
		[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
		
		PersonChoice =@"1";
		

	}
}
- (IBAction)isIndidual10b:(id)sender
{
	if (([ResidenceForeign isEqualToString:@"Y"]||[OfficeForeign isEqualToString:@"Y"])&&([ResidenceForeign_POBOX isEqualToString:@"Y"]&&[OfficeForeign_POBOX isEqualToString:@"Y"]))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid option in view of no permanent address is provided" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		
	}
	
	else
	{
    [btnIndidual10a setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    [btnIndidual10b setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    [btnIndidual10c setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    [[obj.eAppData objectForKey:@"SecG"] setValue:@"2" forKey:@"FACTA_Q2"];
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
   PersonChoice =@"2";
	}
    
}
- (IBAction)isIndidual10c:(id)sender
{
    [btnIndidual10a setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    [btnIndidual10b setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    [btnIndidual10c setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    
    [[obj.eAppData objectForKey:@"SecG"] setValue:@"3" forKey:@"FACTA_Q2"];
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
    
    PersonChoice =@"3";

}
- (IBAction)isCompany10a:(id)sender
{
    [btnCompany10a setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    [btnCompany10a1 setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];

    
    [btnCompany10b setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];

    [btnCompany10c setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];

    [btnCompany10d setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];

    
    _FATCATV.userInteractionEnabled =NO;
    _GIINTF.enabled =NO;
    _FATCATV.text=@"";
    _GIINTF.text =@"";
    
    [btnCompany10e setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];

    [btnCompany10e1 setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];

    [btnCompany10e2 setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];

    
    [btnCompany10f setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    QuestionSElectOne =NO;
    
     [[obj.eAppData objectForKey:@"SecG"] setValue:@"1" forKey:@"FACTA_Q4"];
    [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q4_Ans_1"];
    [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q4_ANS_2"];
    
     [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q5_Entity"];
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];

    
    BizCategoryChoice =@"1";

    
}
- (IBAction)isCompany10a1:(id)sender
{
	
}

- (IBAction)isCompany10b:(id)sender
{
    [btnCompany10a setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    [btnCompany10a1 setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    
    [btnCompany10b setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    
    [btnCompany10c setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    [btnCompany10d setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    
    _FATCATV.userInteractionEnabled =NO;
    _GIINTF.enabled =NO;
    _FATCATV.text=@"";
    _GIINTF.text =@"";
    
    [btnCompany10e setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    [btnCompany10e1 setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    [btnCompany10e2 setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    
    [btnCompany10f setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    QuestionSElectOne =NO;
    
    [[obj.eAppData objectForKey:@"SecG"] setValue:@"2" forKey:@"FACTA_Q4"];
    [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q4_Ans_1"];
    [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q4_ANS_2"];
    [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q5_Entity"];
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];

    
    BizCategoryChoice =@"2";
    
}
- (IBAction)isCompany10c:(id)sender
{
    [btnCompany10a setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    [btnCompany10a1 setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    
    [btnCompany10b setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    [btnCompany10c setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    
    [btnCompany10d setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    
    _FATCATV.userInteractionEnabled =NO;
    _GIINTF.enabled =NO;
    _FATCATV.text=@"";
    _GIINTF.text =@"";
    
    [btnCompany10e setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    [btnCompany10e1 setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    [btnCompany10e2 setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    
    [btnCompany10f setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    QuestionSElectOne =NO;
    
    [[obj.eAppData objectForKey:@"SecG"] setValue:@"3" forKey:@"FACTA_Q4"];
    [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q4_Ans_1"];
    [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q4_ANS_2"];
    [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q5_Entity"];
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
    
    BizCategoryChoice =@"3";
    
    
}
- (IBAction)isCompany10d:(id)sender
{
    [btnCompany10a setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    [btnCompany10a1 setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    
    [btnCompany10b setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    [btnCompany10c setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    [btnCompany10d setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    
    
    _FATCATV.userInteractionEnabled =YES;
    _GIINTF.enabled =YES;
    
        
    BizCategoryChoiceQuest4 =@"Yes";
    
    [btnCompany10e setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    [btnCompany10e1 setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    [btnCompany10e2 setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    
    [btnCompany10f setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    QuestionSElectOne =NO;
    
    [[obj.eAppData objectForKey:@"SecG"] setValue:@"4" forKey:@"FACTA_Q4"];
    [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q5_Entity"];
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
       
    BizCategoryChoice =@"4";
}

- (IBAction)isCompany10e:(id)sender
{
    
    
    [btnCompany10a setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    [btnCompany10a1 setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    
    [btnCompany10b setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    [btnCompany10c setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    [btnCompany10d setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    
    _FATCATV.userInteractionEnabled =NO;
    _FATCATV.text=@"";
    _GIINTF.text =@"";
    _GIINTF.enabled =NO;
    
    [btnCompany10e setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    
//    [btnCompany10e1 setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
//    
//    [btnCompany10e2 setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    
    [btnCompany10f setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    QuestionSElectOne =YES;
    
    [[obj.eAppData objectForKey:@"SecG"] setValue:@"5" forKey:@"FACTA_Q4"];
    [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q4_Ans_1"];
    [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q4_ANS_2"];
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];

    
    BizCategoryChoice =@"5";
    
}
- (IBAction)isCompany10e1:(id)sender
{
    
    NSString *SelectionCompany = [[obj.eAppData objectForKey:@"SecG"] objectForKey:@"FACTA_Q4"];
    
    if([SelectionCompany isEqualToString:@"5"])
    {
        QuestionSElectOne = YES;
    }
    
    if(QuestionSElectOne ==YES)
    {
        [btnCompany10e1 setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        
        [btnCompany10e2 setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        
        EntityType =@"yes";
        
         [[obj.eAppData objectForKey:@"SecG"] setValue:@"1" forKey:@"FACTA_Q5_Entity"];
		 [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];

       // BizCategoryChoice =@"6";
    }
    
    
}
- (IBAction)isCompany10e2:(id)sender
{
    
    
     NSString *SelectionCompany = [[obj.eAppData objectForKey:@"SecG"] objectForKey:@"FACTA_Q4"];
    
    if([SelectionCompany isEqualToString:@"5"])
    {
        QuestionSElectOne = YES;
    }

    
    if(QuestionSElectOne ==YES)
    {
        [btnCompany10e2 setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        
        [btnCompany10e1 setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        
         [[obj.eAppData objectForKey:@"SecG"] setValue:@"2" forKey:@"FACTA_Q5_Entity"];
		[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
        
        EntityType =@"yes";
        
      //  BizCategoryChoice =@"6";
    }

    
}

- (IBAction)isCompany10f:(id)sender
{
    [btnCompany10a setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    [btnCompany10a1 setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    
    [btnCompany10b setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    [btnCompany10c setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    [btnCompany10d setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    
    _FATCATV.userInteractionEnabled =NO;
    _GIINTF.enabled =NO;
    _FATCATV.text=@"";
    _GIINTF.text =@"";
    
    [btnCompany10e setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
        [btnCompany10e1 setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
       [btnCompany10e2 setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    
    
    [btnCompany10f setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    
    QuestionSElectOne =NO;
    
    [[obj.eAppData objectForKey:@"SecG"] setValue:@"6" forKey:@"FACTA_Q4"];
    [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q4_Ans_1"];
    [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q4_ANS_2"];
    [[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"FACTA_Q5_Entity"];
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];

    
    BizCategoryChoice =@"7";
    
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == _FATCATV)
    {
		NSUInteger newLength = [textView.text length] + [text length] - range.length;
        
		return ((newLength <= 100));
	}
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
	if (textField == _GIINTF) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		return (newLength <= 50);
	}
    
    return YES;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //To Check if this is company case
    NSString *otherIDType_check = @"CR";
    NSString *ptypeCode_check = @"PO";
    NSString *comcase = @"No";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *results_check_comcase = [database executeQuery:@"SELECT * from eProposal_LA_Details WHERE eProposalNo = ? AND PTypeCode =? AND LAOtherIDType = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], ptypeCode_check, otherIDType_check];
    
    while ([results_check_comcase next]) {
        //NSLog(@"Company case, CA and CFF will not be generated!");
        comcase = @"Yes";
        
        
    }
    
    if ([comcase isEqualToString:@"No"]) {
        
       
        if (indexPath.section==2 ) {
            
            UITableViewCell *updateCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
           // updateCell.hidden=YES;
           // part10lbl.hidden=YES;
            updateCell.userInteractionEnabled=NO;
            // part10lbl.hidden=NO;
            
            updateCell.alpha=0.6;
             CaseType =@"Individual";
            
        }
        
    }
    else
    {
        UITableViewCell *updateCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
       // updateCell.hidden=NO;
       // part10lbl.hidden=NO;
        CaseType =@"Company";
        updateCell.userInteractionEnabled=YES;
    }
    
           
}

@end
