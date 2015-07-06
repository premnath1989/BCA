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

@interface AdditionalQuestions ()
{
     DataClass *obj;
}
@end

@implementation AdditionalQuestions
//@synthesize addInsurerd,addInsurerdTableView,ViewAddInsurerdBtn;
 
  
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    obj = [DataClass getInstance];
    
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
       
		if ([[results stringForColumn:@"AdditionalQuestionsInsured"] isEqualToString:@"Y"])
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
        [[obj.eAppData objectForKey:@"SecF"] setValue:insuredArray forKey:@"Insured_Array"];

    //GET THE insured_objects - END
    
    
	[results close];
	[database close];
	
	if ([occpToEnableSection isEqualToString:@"OCC01109"] || [occpToEnableSection isEqualToString:@"OCC01179"] || [occpToEnableSection isEqualToString:@"OCC02147"] || [occpToEnableSection isEqualToString:@"OCC00209"]) {
		NSLog(@"ENABLE additional Q");
		self.nameTF.enabled = TRUE;
		self.incomeTF.enabled = TRUE;
		self.btnOccupationPO.enabled = TRUE;
		self.insuredSC.enabled = TRUE;
		self.reasonTF.enabled = FALSE;
		self.addInsurerd.enabled = FALSE;
		self.ViewAddInsurerdBtn.enabled = FALSE;
	}
	else {
		NSLog(@"DISABLE additional Q");
		self.nameTF.enabled = FALSE;
		self.incomeTF.enabled = FALSE;
		self.btnOccupationPO.enabled = FALSE;
		self.insuredSC.enabled = FALSE;
		self.reasonTF.enabled = FALSE;
		self.addInsurerd.enabled = FALSE;
		self.ViewAddInsurerdBtn.enabled = FALSE;
	}

    
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
    if([seg_insured isEqualToString:@"Y"])
        self.insuredSC.selectedSegmentIndex = 0;
    else if([seg_insured isEqualToString:@"N"])
         self.insuredSC.selectedSegmentIndex = 1;
    if(c > 0)
    {
        self.addInsurerd.enabled = true;
        self.ViewAddInsurerdBtn.enabled = true;
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
	NSLog(@"Process completed");
    
    self.ViewAddInsurerdBtn.enabled = true;
}

- (IBAction)viewInsured:(id)sender
{
    
    NSLog(@"KY AdditionalQuestions - click viewInsured");
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
}

- (void)OccupCodeSelected:(NSString *) OccupCode {
	
}
- (void)OccupClassSelected:(NSString *) OccupClass {
	
}

- (IBAction)SelectInsured:(id)sender
{
    if(self.insuredSC.selectedSegmentIndex == 0)
    {
        self.addInsurerd.enabled = TRUE;
        NSMutableArray *insured_Array = [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"];
        
        if(insured_Array.count > 0)
            self.ViewAddInsurerdBtn.enabled = TRUE;
        else
            self.ViewAddInsurerdBtn.enabled = FALSE;
		
		_reasonTF.enabled = FALSE;
        
    }
    
    else if(self.insuredSC.selectedSegmentIndex == 1)
    {
        self.addInsurerd.enabled = FALSE;
        self.ViewAddInsurerdBtn.enabled = FALSE;
		_reasonTF.enabled = TRUE;
    }
}


@end
