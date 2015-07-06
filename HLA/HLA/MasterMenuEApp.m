//
//  MasterMenuEApp.m
//  iMobile Planner
//
//  Created by shawal sapuan on 6/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "MasterMenuEApp.h"
#import "DataClass.h"
#import "textFields.h"
#import "Utility.h"

@interface MasterMenuEApp (){
    NSString *alertMsg;
    DataClass *obj;
    int check_proposal;
    BOOL poIsMuslim;
	BOOL Proceed;
    BOOL PopUpAlert;
    BOOL PopUpAlertForA;
	int firstTimePD;
	NSIndexPath *CurrentP;
    NSString *strTrusteecountry;
    NSString *strTrusteecountry2;
}

@end

@implementation MasterMenuEApp
@synthesize SummaryVC = _SummaryVC;
@synthesize PolicyVC = _PolicyVC;
@synthesize NomineesVC = _NomineesVC;
@synthesize HealthVC = _HealthVC;
@synthesize AddQuestVC = _AddQuestVC;
@synthesize DeclareVC = _DeclareVC;
@synthesize eAppPersonalDataVC = _eAppPersonalDataVC;
@synthesize HealthVC2 = _HealthVC2;
@synthesize HealthVC3 = _HealthVC3;
@synthesize part4 = _part4;
@synthesize myTableView,rightView,ListOfSubMenu;
@synthesize HealthQuestions1stLA = _HealthQuestions1stLA;
@synthesize doneBtn = _doneBtn;

NSString *alert_answerall = @"Please answer all questions.";

- (void)viewDidLoad
{
    
    check_proposal = 0;
	firstTimePD = 0;
    [super viewDidLoad];
    //    NSLog(@"view did loaddddd");
    alertMsg = @"Record saved successfully.";
    
    obj = [DataClass getInstance];
	
	[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-linen.png"]]];
    
    self.myTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-linen.png"]];
    
    ListOfSubMenu = [[NSMutableArray alloc] initWithObjects:@"Summary", @"Personal Details", @"Policy Details", @"Existing Life Policies", @"Nominees/Trustees", @"Health Questions", @"Additional Questions",@"Declaration", nil ];
    myTableView.rowHeight = 44;
    
    
    [myTableView reloadData];
    myTableView.scrollEnabled = NO;
    
    UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
    if ([[obj.eAppData objectForKey:@"Proposal"] objectForKey:@"Complete"] != Nil){
        self.SummaryVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"SummaryScreenComplete"];
        [self addChildViewController:self.SummaryVC];
        [self.rightView addSubview:self.SummaryVC.view];
        selectedPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else{
        
        self.SummaryVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"SummaryScreen"];
        [self addChildViewController:self.SummaryVC];
        [self.rightView addSubview:self.SummaryVC.view];
        selectedPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
	//Add by Emi: disable done button if status is confirmed
	NSString *proposalStatus = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ProposalStatus"];
	if ([proposalStatus isEqualToString:@"Confirmed"] || [proposalStatus isEqualToString:@"3"]) {
		_doneBtn.enabled = FALSE;
	}
	
	
    //	_nameLALbl.text = [[obj.eAppData objectForKey:@"SI"] objectForKey:@"NameLA"];
	_nameLALbl.text = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIName"];
    
    
    nextStoryboard = nil;
	
	
	//from db
    //	[[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.fullNameTF.text forKey:@"FullName"];
	//
    
    // NSLog(@"sinumberrr: %@", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"]);
	
	
    //	[[obj.eAppData objectForKey:@"EAPP"] setValue:Nil forKey:@"SINumber"];
	
    [self reloadData];
    [self FlagProposal];
	Proceed = YES;
    PopUpAlert = YES;
    PopUpAlertForA = YES;
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"0" forKey:@"EAPPSave"];
    
    //[self insertIntoXML];
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	tap.delegate = self;
	[self.view addGestureRecognizer:tap];
}

-(void)reloadData
{
	//set nil to all personal details value
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"SecA_Saved"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"TickPart2"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"Title"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"Sex"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"FullName"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"TelNo"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"ICNo"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"MobileNo"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"DOB"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"Email"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"OtherIDType"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"OtherID"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"Relationship"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"SameAddress"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"Address1"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"Address2"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"Address3"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"Postcode"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"Town"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"State"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"Country"];
    
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"CRAddress1"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"CRAddress2"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"CRAddress3"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"CRPostcode"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"CRTown"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"CRState"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"CRCountry"];
    
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"Nationality"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"NameOfEmployer"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"Occupation"];
	[[obj.eAppData objectForKey:@"SecA"] setValue:Nil forKey:@"ExactNatureOfWork"];
	//set nil to all personal details value
	
	//set nil to all policy details value
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"SecB_Saved"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"PaymentMode"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"BasicPlan"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"Term"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"SumAssured"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"BasicPremium"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"TotalPremium"];
	
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"TotalGSTAmt"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"TotalPayableAmt"];
	
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"FirstTimePayment"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"FirstPaymentDeduct"];
    [[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"EPP"];
    
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"RecurringPayment"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"AgentCode"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"AgentContactNo"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"AgentName"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"PersonType"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"IssuingBank"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"CardType"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"CardAccNo"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"CardExpDate"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"MemberName"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"MemberSex"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"MemberDOB"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"MemberIC"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"MemberOtherIDType"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"MemberOtherID"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"MemberContactNo"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"MemberRelationship"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"FTPersonType"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"FTIssuingBank"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"FTCardType"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"FTCardAccNo"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"FTCardExpDate"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"FTMemberName"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"FTMemberSex"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"FTMemberDOB"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"FTMemberIC"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"FTMemberOtherIDType"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"FTMemberOtherID"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"FTMemberContactNo"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"FTMemberRelationship"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"PaidUpOption"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"PaidUpTerm"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"RevisedSumAssured"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"RevisedAmount"];
    [[obj.eAppData objectForKey:@"SecB"] setValue:@"FALSE" forKey:@"LIEN"];
    
    [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"isDirectCredit"];
    [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCBank"];
    [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCAccountType"];
    [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCAccNo"];
    [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCPayeeType"];
    [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCNewICNo"];
    [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCOtherIDType"];
    [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCOtherID"];
    [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCEmail"];
    [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCMobile"];
    [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCMobilePrefix"];
    
    
	//set nil to all policy details value
	
	//set nil to all existing policy value
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"SecC_Saved"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"PersonType"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"ExistingPolicies"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"NoticeA"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"NoticeB"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"NoticeC"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"NoticeD"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"CD"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"CashDividend"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"WdCashDividend"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"KpCashDividend"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"TPWithdrawPct"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"TPKeepPct"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"PolicyBackdating"];
    [[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"PreferredLife"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"DatePolicyBackdating"];
	
	//[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"PersonType1stLA"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"ExistingPolicies1stLA"];
    [[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"ExistingPolicies1stLACR"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"NoticeA1stLA"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"NoticeB1stLA"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"NoticeC1stLA"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"NoticeD1stLA"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"PolicyBackdating1stLA"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"DatePolicyBackdating1stLA"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"DatePolicyBackdatingTemp"];
    
	//[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"PersonType2ndLA"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"ExistingPolicies2ndLA"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"NoticeA2ndLA"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"NoticeB2ndLA"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"NoticeC2ndLA"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"NoticeD2ndLA"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"PolicyBackdating2ndLA"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"DatePolicyBackdating2ndLA"];
    
	//[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"PersonTypePO"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"ExistingPoliciesPO"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"NoticeAPO"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"NoticeBPO"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"NoticeCPO"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"NoticeDPO"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"PolicyBackdatingPO"];
    [[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"PreferredLife"];
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"DatePolicyBackdatingPO"];
	
	//set nil to all existing policy value
	
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"SecD_Saved"];
	//set nil to all nominees value
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_title"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_name"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_ic"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_otherIDType"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_otherID"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_dob"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_gender"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_share"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_relatioship"];
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_nationality"];
    
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_ExactDuties"];
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_Occupation"];
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_nameofemployer"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_Address"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_add1TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_add2TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_add3TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_postcodeTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_townTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_stateTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_countryTF"];
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_CRadd1TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_CRadd2TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_CRadd3TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_CRpostcodeTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_CRtownTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_CRstateTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_CRcountryTF"];
    
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_title"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_name"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_ic"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_otherIDType"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_otherID"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_dob"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_gender"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_share"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_relatioship"];
    
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_nationality"];
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_ExactDuties"];
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_Occupation"];
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_nameofemployer"];
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_Address"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_add1TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_add2TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_add3TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_postcodeTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_townTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_stateTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_countryTF"];
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_CRadd1TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_CRadd2TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_CRadd3TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_CRpostcodeTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_CRtownTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_CRstateTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_CRcountryTF"];
	//
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_title"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_name"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_ic"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_otherIDType"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_otherID"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_dob"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_gender"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_share"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_relatioship"];
    
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_nationality"];
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_ExactDuties"];
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_Occupation"];
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_nameofemployer"];
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_Address"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_add1TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_add2TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_add3TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_postcodeTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_townTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_stateTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_countryTF"];
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_CRadd1TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_CRadd2TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_CRadd3TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_CRpostcodeTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_CRtownTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_CRstateTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_CRcountryTF"];
    //
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_title"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_name"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_ic"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_otherIDType"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_otherID"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_dob"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_gender"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_share"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_relatioship"];
    
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_nationality"];
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_ExactDuties"];
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_Occupation"];
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_nameofemployer"];
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_Address"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_add1TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_add2TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_add3TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_postcodeTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_townTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_stateTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_countryTF"];
    [[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_CRadd1TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_CRadd2TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_CRadd3TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_CRpostcodeTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_CRtownTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_CRstateTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_CRcountryTF"];
	//set nil to all nominees value
	
	//set nil to all trustees value
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"SamePO"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"Title"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"Name"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"Sex"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"DOB"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"ICNo"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"OtherIDType"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"OtherID"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"Relationship"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"Address1"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"Address2"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"Address3"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"Postcode"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"Town"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"State"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"Country"];
	
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"2TSamePO"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"2TTitle"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"2TName"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"2TSex"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"2TDOB"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"2TICNo"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"2TOtherIDType"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"2TOtherID"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"2TRelationship"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"2TAddress1"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"2TAddress2"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"2TAddress3"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"2TPostcode"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"2TTown"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"2TState"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:Nil forKey:@"2TCountry"];
	//set nil to all trustees value
	
	//set nil to healthQ value
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Saved"];
	//[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_personType"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_height"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_weight"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q1B"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q1"];
    //	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q2"];
    //	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q2"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q3"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q3_beerTF"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q3_wineTF"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q3_wboTF"];
    
    [[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q4"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q4_cigarettesTF"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q4_pipeTF"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q4_cigarTF"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q4_eCigarTF"];
	
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q5"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q5"];
    //	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q6"];
    //	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q6"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q7A"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q7"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q7B"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q7b"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q7C"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q7c"];
	[[obj.eAppData objectForKey:@"SecE"]  setValue:Nil forKey:@"SecE_Q7D"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q7d"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q7E"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q7e"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q7F"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q7f"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q7G"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q7g"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q7H"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q7h"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q7I"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q7i"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q7J"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q7j"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q8A"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q8"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q8B"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q8b"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q8C"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q8c"];
    //	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q8D"];
    //	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q8d"];
    //	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q8E"];
    //	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q8e"];
    //	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q9"];
    //	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q9"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q10"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q10"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q11"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q11"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q12"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q12"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q13"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q13"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q14A"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q14"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q14_weeksTF"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q14_monthsTF"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q14B"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q14b"];
	
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q15"];
	
	NSArray *LATypes = [[NSArray alloc] initWithObjects:@"LA1", @"LA2", @"PO", nil];
	for (NSString *LAType in LATypes) {
		NSString *key;
		if ([LAType isEqualToString:@"LA1"]) {
			key = @"LA1HQ";
		}
		else if ([LAType isEqualToString:@"LA2"]) {
			key = @"LA2HQ";
		}
		else {
			key = @"POHQ";
		}
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Saved"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:@"" forKey:@"SecE_height"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:@"" forKey:@"SecE_weight"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q1B"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q1"];
        //		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q2"];
        //		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q2"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q3"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q3_beerTF"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q3_wineTF"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q3_wboTF"];
		
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Sec_Q4"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q4_cigarettesTF"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q4_pipeTF"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q4_cigarTF"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q4_eCigarTF"];
        
		
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q5"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q5"];
        //		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q6"];
        //		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q6"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q7A"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q7"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q7B"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q7b"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q7C"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q7c"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q7D"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q7d"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q7E"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q7e"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q7F"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q7f"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q7G"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q7g"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q7H"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q7h"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q7I"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q7i"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q7J"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q7j"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q8A"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q8"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q8B"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q8b"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q8C"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q8c"];
        //		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q8D"];
        //		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q8d"];
        //		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q8E"];
        //		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q8e"];
        //		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q9"];
        //		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q9"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q10"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q10"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q11"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q11"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q12"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q12"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q13"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q13"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q14A"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q14"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q14_weeksTF"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q14_monthsTF"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q14B"];
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"Q14b"];
		
		[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:Nil forKey:@"SecE_Q15"];
        
	}
	
	//set nil to healthQ value
	
	//set nil to all additionalQ value
	[[obj.eAppData objectForKey:@"SecF"] setValue:Nil forKey:@"SecF_Saved"];
	[[obj.eAppData objectForKey:@"SecF"] setValue:Nil forKey:@"Name"];
    [[obj.eAppData objectForKey:@"SecF"] setValue:Nil forKey:@"Income"];
    [[obj.eAppData objectForKey:@"SecF"] setValue:Nil forKey:@"Occupation"];
	[[obj.eAppData objectForKey:@"SecF"] setValue:Nil forKey:@"Insured"];
    [[obj.eAppData objectForKey:@"SecF"] setValue:Nil forKey:@"No_Reason"];
	//set nil to all additionalQ value
	
	//set nil to declaration value
	[[obj.eAppData objectForKey:@"SecG"] setValue:Nil forKey:@"Declaration_agree"];
    [[obj.eAppData objectForKey:@"SecG"] setValue:Nil forKey:@"FACTA_Q2"];
    [[obj.eAppData objectForKey:@"SecG"] setValue:Nil forKey:@"FACTA_Q4"];
    [[obj.eAppData objectForKey:@"SecG"] setValue:Nil forKey:@"FACTA_Q4_Ans_1"];
    [[obj.eAppData objectForKey:@"SecG"] setValue:Nil forKey:@"FACTA_Q4_ANS_2"];
    [[obj.eAppData objectForKey:@"SecG"] setValue:Nil forKey:@"FACTA_Q5_Entity"];
    
    
    
	//set nil to declaration value
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    //	results = [database executeQuery:@"select * from eProposal where SINo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
    //	while ([results next]) {
    //		stringID = [results stringForColumn:@"eProposalNo"];
    //	}
	stringID = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
	//NSLog(@"string id: %@, si: %@", stringID, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"]);
	//SEC A - CO start
	results2 = Nil;
	//		while ([results next]) {
	results2 = [database executeQuery:@"select * from  eProposal where eProposalNo = ?",stringID,Nil];
	while ([results2 next]) {
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"LAMandatoryFlag"] forKey:@"SecA_Saved"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"PolicyDetailsMandatoryFlag"] forKey:@"SecB_Saved"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPoliciesMandatoryFlag"] forKey:@"SecC_Saved"];
		[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NomineesMandatoryFlag"] forKey:@"SecD_Saved"];
		[[obj.eAppData objectForKey:@"SecE"] setValue:[results2 stringForColumn:@"QuestionnaireMandatoryFlag"] forKey:@"SecE_Saved"];
		[[obj.eAppData objectForKey:@"SecF"] setValue:[results2 stringForColumn:@"AdditionalQuestionsMandatoryFlag"] forKey:@"SecF_Saved"];
		[[obj.eAppData objectForKey:@"SecG"] setValue:[results2 stringForColumn:@"DeclarationMandatoryFlag"] forKey:@"SecG_Saved"];
        
        
        
        
        
        
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COMandatoryFlag"] forKey:@"TickPart2"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COTitle"] forKey:@"Title"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COSex"] forKey:@"Sex"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COName"] forKey:@"FullName"];
        [[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COPhoneNo"] forKey:@"TelNo"];
        
        [[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COPhoneNo"] forKey:@"TelNo"];
        
        //   NSLog(@"testing %@",[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COPhoneNo"] forKey:@"TelNo"]);
        
        //        NSString *phoneNo = [results2 stringForColumn:@"COPhoneNo"];
        //        NSArray *phoneNoAry = [phoneNo componentsSeparatedByString:@" "];
        //        if (phoneNoAry.count > 1) {
        //            [[obj.eAppData objectForKey:@"SecA"] setValue:![[phoneNoAry objectAtIndex:0] isEqualToString:@"(null)"] ? [phoneNoAry objectAtIndex:0] : @""  forKey:@"TelNoPrefix"];
        //            [[obj.eAppData objectForKey:@"SecA"] setValue:![[phoneNoAry objectAtIndex:1] isEqualToString:@"(null)"] ? [phoneNoAry objectAtIndex:1] : @"" forKey:@"TelNo"];
        //        }
        //        else {
        //            [[obj.eAppData objectForKey:@"SecA"] setValue:![[phoneNoAry objectAtIndex:0] isEqualToString:@"(null)"] ? [phoneNoAry objectAtIndex:0] : @""  forKey:@"TelNoPrefix"];
        //        }
		
        //NSLog(@"PhoneNo: %@, Prefic: %@, Phone: %@", phoneNo, [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TelNo"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TelNoPrefix"]);
		
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"CONewICNo"] forKey:@"ICNo"];
        
        [[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COMobileNo"] forKey:@"MobileNo"];
        
        //        NSString *mobileNo = [results2 stringForColumn:@"COMobileNo"];
        //        NSArray *mobileNoAry = [mobileNo componentsSeparatedByString:@" "];
        //        if (mobileNoAry.count > 1) {
        //            [[obj.eAppData objectForKey:@"SecA"] setValue:![[mobileNoAry objectAtIndex:0] isEqualToString:@"(null)"] ? [mobileNoAry objectAtIndex:0] : @"" forKey:@"MobileNoPrefix"];
        //            [[obj.eAppData objectForKey:@"SecA"] setValue:![[mobileNoAry objectAtIndex:1] isEqualToString:@"(null)"] ? [mobileNoAry objectAtIndex:1] : @"" forKey:@"MobileNo"];
        //        }
        //        else {
        //            [[obj.eAppData objectForKey:@"SecA"] setValue:![[mobileNoAry objectAtIndex:0] isEqualToString:@"(null)"] ? [mobileNoAry objectAtIndex:0] : @"" forKey:@"MobileNoPrefix"];
        //        }
        
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"CODOB"] forKey:@"DOB"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COEmailAddress"] forKey:@"Email"];
        
        //	[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"CONationality"] forKey:@"Nationality"];
        [[obj.eAppData objectForKey:@"SecA"] setValue:[self getNAtionalityDesc:[results2 stringForColumn:@"CONationality"]] forKey:@"Nationality"];
        //  [[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COOccupation"] forKey:@"Occupation"];
        [[obj.eAppData objectForKey:@"SecA"] setValue:[self getOccupationDesc:[results2 stringForColumn:@"COOccupation"]] forKey:@"Occupation"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"CONameOfEmployer"] forKey:@"NameOfEmployer"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COExactNatureOfWork"] forKey:@"ExactNatureOfWork"];
        
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COOtherIDType"] forKey:@"OtherIDType"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COOtherID"] forKey:@"OtherID"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[self getRelationshipDesc:[results2 stringForColumn:@"CORelationship"]] forKey:@"Relationship"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COSameAddressPO"] forKey:@"SameAddress"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COForeignAddressFlag"] forKey:@"ForeignAddress"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COAddress1"] forKey:@"Address1"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COAddress2"] forKey:@"Address2"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COAddress3"] forKey:@"Address3"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COPostcode"] forKey:@"Postcode"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COTown"] forKey:@"Town"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[self getStateDesc:[results2 stringForColumn:@"COState"]] forKey:@"State"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[self getCountryDesc:[results2 stringForColumn:@"COCountry"]] forKey:@"Country"];
        
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COCRForeignAddressFlag"] forKey:@"CRForeignAddress"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COCRAddress1"] forKey:@"CRAddress1"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COCRAddress2"] forKey:@"CRAddress2"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COCRAddress3"] forKey:@"CRAddress3"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COCRPostcode"] forKey:@"CRPostcode"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COCRTown"] forKey:@"CRTown"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[self getStateDesc:[results2 stringForColumn:@"COCRState"]] forKey:@"CRState"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[self getCountryDesc:[results2 stringForColumn:@"COCRCountry"]] forKey:@"CRCountry"];
        
	}
    //	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"FullName"] length] != 0) {
    //		[[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"TickPart2"];
    //	}
    //	else {
    //		[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickPart2"];
    //	}
	//SEC A - CO end
	
	// ########### ADDED BY EMI 11/06/2014 #######
	//CHECK IF SINO HAS RIDER
	
	//set default value 0 to HasRider
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"N" forKey:@"PYHasRider"];
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"N" forKey:@"LA2HasRider"];
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"N" forKey:@"LA1HasRider"];
	
	
	results2 = Nil;
	//		while ([results next]) {
	results2 = [database executeQuery:@"select PTypeCode, Seq from Trad_Rider_Details where SINO = ? ",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
	
	while ([results2 next])
    {
		NSString * PTypeCode = [results2 stringForColumn:@"PTypeCode"];
		NSString *Seq = [results2 stringForColumn:@"Seq"];
		if ([PTypeCode isEqualToString:@"PY"])
			[[obj.eAppData objectForKey:@"EAPP"] setValue:@"Y" forKey:@"PYHasRider"];
		else if ([PTypeCode isEqualToString:@"LA"] && [Seq isEqualToString:@"2"])
			[[obj.eAppData objectForKey:@"EAPP"] setValue:@"Y" forKey:@"LA2HasRider"];
		else if ([PTypeCode isEqualToString:@"LA"] && [Seq isEqualToString:@"1"])
			[[obj.eAppData objectForKey:@"EAPP"] setValue:@"Y" forKey:@"LAHasRider"];
	}
	//#### CHECK RIDER END
    
	
	//SEC B start
	results2 = Nil;
	//		while ([results next]) {
	results2 = [database executeQuery:@"select * from  eProposal where eProposalNo = ?",stringID,Nil];
	while ([results2 next]) {
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"PaymentMode"] forKey:@"PaymentMode"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"BasicPlanCode"] forKey:@"BasicPlan"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"BasicPlanTerm"] forKey:@"Term"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"BasicPlanSA"] forKey:@"SumAssured"];
        //		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"BasicPlanModalPremium"] forKey:@"BasicPremium"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"TotalModalPremium"] forKey:@"TotalPremium"];
        

		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"TotalGSTAmt"] forKey:@"TotalGSTAmt"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"TotalPayableAmt"] forKey:@"TotalPayableAmt"];
        
        NSString *firstTimeCode = [results2 stringForColumn:@"FirstTimePayment"];
        NSString *firstTimePayment;
        
        results = Nil;
        results = [database executeQuery:@"select PaymentMethodDesc from eProposal_Payment_Method where PaymentMethodCode = ? AND FirstTimePayment = ?", firstTimeCode,@"TRUE"];
        while ([results next]) {
            firstTimePayment = [results stringForColumn:@"PaymentMethodDesc"] != NULL ? [results stringForColumn:@"PaymentMethodDesc"] : @"";
        }
		[[obj.eAppData objectForKey:@"SecB"] setValue:firstTimePayment forKey:@"FirstTimePayment"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"PaymentUponFinalAcceptance"] forKey:@"FirstPaymentDeduct"];
        [[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"EPP"] forKey:@"EPP"];
        
        
        NSString *recurringCode = [results2 stringForColumn:@"RecurringPayment"];
        NSString *recurringPayment;
        
		results = Nil;
        results = [database executeQuery:@"select PaymentMethodDesc from eProposal_Payment_Method where PaymentMethodCode = ?", recurringCode];
        while ([results next]) {
            recurringPayment = [results stringForColumn:@"PaymentMethodDesc"] != NULL ? [results stringForColumn:@"PaymentMethodDesc"] : @"";
        }
        [[obj.eAppData objectForKey:@"SecB"] setValue:recurringPayment forKey:@"RecurringPayment"];
        
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"SecondAgentCode"] forKey:@"AgentCode"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"SecondAgentContactNo"] forKey:@"AgentContactNo"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"SecondAgentName"] forKey:@"AgentName"];
		
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"SameAsFT"] forKey:@"SameAsFT"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"PTypeCode"] forKey:@"PersonType"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"CreditCardBank"] forKey:@"IssuingBank"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"CreditCardType"] forKey:@"CardType"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"CardMemberAccountNo"] forKey:@"CardAccNo"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"CardExpiredDate"] forKey:@"CardExpDate"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"CardMemberName"] forKey:@"MemberName"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"CardMemberSex"] forKey:@"MemberSex"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"CardMemberDOB"] forKey:@"MemberDOB"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"CardMemberNewICNo"] forKey:@"MemberIC"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"CardMemberOtherIDType"] forKey:@"MemberOtherIDType"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"CardMemberOtherID"] forKey:@"MemberOtherID"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"CardMemberContactNo"] forKey:@"MemberContactNo"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"CardMemberRelationship"] forKey:@"MemberRelationship"];
		
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"FTPTypeCode"] forKey:@"FTPersonType"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"FTCreditCardBank"] forKey:@"FTIssuingBank"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"FTCreditCardType"] forKey:@"FTCardType"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"FTCardMemberAccountNo"] forKey:@"FTCardAccNo"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"FTCardExpiredDate"] forKey:@"FTCardExpDate"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"FTCardMemberName"] forKey:@"FTMemberName"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"FTCardMemberSex"] forKey:@"FTMemberSex"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"FTCardMemberDOB"] forKey:@"FTMemberDOB"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"FTCardMemberNewICNo"] forKey:@"FTMemberIC"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"FTCardMemberOtherIDType"] forKey:@"FTMemberOtherIDType"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"FTCardMemberOtherID"] forKey:@"FTMemberOtherID"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"FTCardMemberContactNo"] forKey:@"FTMemberContactNo"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"FTCardMemberRelationship"] forKey:@"FTMemberRelationship"];
        
        
        [[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"isDirectCredit"] forKey:@"isDirectCredit"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"DCBank"] forKey:@"DCBank"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"DCAccountType"] forKey:@"DCAccountType"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"DCAccNo"] forKey:@"DCAccNo"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"DCPayeeType"] forKey:@"DCPayeeType"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"DCNewICNo"] forKey:@"DCNewICNo"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"DCOtherIDType"] forKey:@"DCOtherIDType"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"DCOtherID"] forKey:@"DCOtherID"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"DCEmail"] forKey:@"DCEmail"];
        [[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"DCMobile"] forKey:@"DCMobile"];
        [[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"DCMobilePrefix"] forKey:@"DCMobilePrefix"];
		
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"FullyPaidUpOption"] forKey:@"PaidUpOption"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"FullyPaidUpTerm"] forKey:@"PaidUpTerm"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"RevisedSA"] forKey:@"RevisedSumAssured"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"AmtRevised"] forKey:@"RevisedAmount"];
        
        NSString *cardExpiredDate = [results2 stringForColumn:@"CardExpiredDate"];
		
		NSString *month;
		NSString *year;
		if (![cardExpiredDate isEqualToString:@""]) {
			month = [[cardExpiredDate componentsSeparatedByString:@" "] objectAtIndex:0];
			year = [[cardExpiredDate componentsSeparatedByString:@" "] objectAtIndex:1];
			cardExpiredDate = [cardExpiredDate stringByReplacingOccurrencesOfString:@" " withString:@""];
		}
        
        [[obj.eAppData objectForKey:@"SecB"] setValue:month forKey:@"MonthExpiryDate"];
        [[obj.eAppData objectForKey:@"SecB"] setValue:year forKey:@"YearExpiryDate"];
		
		NSString *FTcardExpiredDate = [results2 stringForColumn:@"FTCardExpiredDate"];
		
        NSString *FTmonth = @" ";
		NSString *FTyear = @" ";
		
		if (![FTcardExpiredDate isEqualToString:@""]) {
			FTmonth = [[FTcardExpiredDate componentsSeparatedByString:@" "] objectAtIndex:0];
			FTyear = [[FTcardExpiredDate componentsSeparatedByString:@" "] objectAtIndex:1];
			FTcardExpiredDate = [FTcardExpiredDate stringByReplacingOccurrencesOfString:@" " withString:@""];
		}
        
        [[obj.eAppData objectForKey:@"SecB"] setValue:FTmonth forKey:@"FTMonthExpiryDate"];
        [[obj.eAppData objectForKey:@"SecB"] setValue:FTyear forKey:@"FTYearExpiryDate"];
		
		
        [[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"LIEN"] forKey:@"LIEN"];
	}
    
    results2 = nil;
    results2 = [database executeQuery:@"select * from eProposal_Riders where eProposalNo = ?", stringID, nil];
    if (![[obj.eAppData objectForKey:@"SecB"] objectForKey:@"Riders"]) {
        [[obj.eAppData objectForKey:@"SecB"] setValue:[NSMutableDictionary dictionary] forKey:@"Riders"];
    }
    while ([results2 next]) {
        NSString *key = [results2 stringForColumn:@"RiderCode"];
        NSString *value = [results2 stringForColumn:@"Years"];
        [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"Riders"] setValue:value forKey:key];
    }
    // NSLog(@"2Riders:  %@", [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"Riders"]);
    
	//SEC B end
    
	//SEC C start
	
	results3 = Nil;
	results3 = [database executeQuery:@"select * from SI_Trad_Details where SINo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
	while ([results3 next]) {
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results3 stringForColumn:@"CashDividend"] forKey:@"CD"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results3 stringForColumn:@"CashPayment_PO"] forKey:@"TPWithdrawPct"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results3 stringForColumn:@"CashPayment_Acc"] forKey:@"TPKeepPct"];
	}
	
	results2 = Nil;
    results2 = [database executeQuery:@"select * from  eProposal_Existing_Policy_1 where eProposalNo = ? and ProposalPTypeCode = ?",stringID, @"LA1", Nil];
	while ([results2 next]) {
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ProposalPTypeCode"] forKey:@"PersonType1stLA"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer1"] forKey:@"ExistingPolicies1stLA"];
        [[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer1a"] forKey:@"ExistingPolicies1stLACR"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer2"] forKey:@"NoticeA1stLA"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer3"] forKey:@"NoticeB1stLA"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer4"] forKey:@"NoticeC1stLA"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer5"] forKey:@"NoticeD1stLA"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"blnBackDating"] forKey:@"PolicyBackdating1stLA"];
        [[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"PreferredLife"] forKey:@"PreferredLife"];
        [[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"BackDating"] forKey:@"DatePolicyBackdating1stLA"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"BackDating"] forKey:@"DatePolicyBackdatingTemp"];
	}
    
    results2 = Nil;
    results2 = [database executeQuery:@"select * from  eProposal_Existing_Policy_1 where eProposalNo = ? and ProposalPTypeCode = ?",stringID, @"LA2", Nil];
	while ([results2 next]) {
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ProposalPTypeCode"] forKey:@"PersonType2ndLA"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer1"] forKey:@"ExistingPolicies2ndLA"];
        [[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer1a"] forKey:@"ExistingPolicies2ndLACR"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer2"] forKey:@"NoticeA2ndLA"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer3"] forKey:@"NoticeB2ndLA"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer4"] forKey:@"NoticeC2ndLA"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer5"] forKey:@"NoticeD2ndLA"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"blnBackDating"] forKey:@"PolicyBackdating2ndLA"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"BackDating"] forKey:@"DatePolicyBackdating2ndLA"];
        [[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"PreferredLife"] forKey:@"PreferredLife"];
	}
	
    results2 = Nil;
	results2 = [database executeQuery:@"select * from  eProposal_Existing_Policy_1 where eProposalNo = ? and ProposalPTypeCode = ?",stringID, @"PO", Nil];
	while ([results2 next]) {
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ProposalPTypeCode"] forKey:@"PersonTypePO"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer1"] forKey:@"ExistingPoliciesPO"];
        [[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer1a"] forKey:@"ExistingPoliciesPOCR"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer2"] forKey:@"NoticeAPO"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer3"] forKey:@"NoticeBPO"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer4"] forKey:@"NoticeCPO"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer5"] forKey:@"NoticeDPO"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"blnBackDating"] forKey:@"PolicyBackdatingPO"];
        [[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"PreferredLife"] forKey:@"PreferredLife"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"BackDating"] forKey:@"DatePolicyBackdatingPO"];
	}
    results2 = Nil;
    //results2 = [database executeQuery:@"select * from eProposal_Existing_Policy_2 where eProposalNo = ? and PTypeCodeDesc = ?", stringID, @"1st Life Assured", Nil];
	results2 = [database executeQuery:@"select * from eProposal_Existing_Policy_2 where eProposalNo = ? and PTypeCode = ? order by PTypeCodeDesc", stringID, @"1st Life Assured", Nil];
    NSMutableArray *mutAry = [NSMutableArray array];
    while ([results2 next]) {
        
        NSArray *details = [NSArray arrayWithObjects:[results2 objectForColumnName:@"PTypeCodeDesc"],[results2 objectForColumnName:@"ExistingPolicy_Company"], [results2 objectForColumnName:@"ExistingPolicy_LifeTerm"], [results2 objectForColumnName:@"ExistingPolicy_Accident"],[results2 objectForColumnName:@"ExistingPolicy_DailyHospitalIncome"], [results2 objectForColumnName:@"ExistingPolicy_CriticalIllness"], [results2 objectForColumnName:@"ExistingPolicy_DateIssued"], nil];
        
        
        [mutAry addObject:[details copy]];
    }
    
    if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"]) {
        [[obj.eAppData objectForKey:@"SecC"] setValue:[NSMutableDictionary dictionary] forKey:@"ExistingPolicy1stLA"];
    }
    [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] setValue:[mutAry mutableCopy] forKey:@"PolicyData"];
    
    results2 = Nil;
    //    results2 = [database executeQuery:@"select * from eProposal_Existing_Policy_2 where eProposalNo = ? and PTypeCodeDesc = ?", stringID, @"2nd Life Assured", Nil];
	results2 = [database executeQuery:@"select * from eProposal_Existing_Policy_2 where eProposalNo = ? and PTypeCode = ? order by PTypeCodeDesc", stringID, @"2nd Life Assured", Nil];
    mutAry = [NSMutableArray array];
    while ([results2 next]) {
        
        NSArray *details = [NSArray arrayWithObjects:[results2 objectForColumnName:@"PTypeCodeDesc"],[results2 objectForColumnName:@"ExistingPolicy_Company"], [results2 objectForColumnName:@"ExistingPolicy_LifeTerm"], [results2 objectForColumnName:@"ExistingPolicy_Accident"],[results2 objectForColumnName:@"ExistingPolicy_DailyHospitalIncome"],[results2 objectForColumnName:@"ExistingPolicy_CriticalIllness"], [results2 objectForColumnName:@"ExistingPolicy_DateIssued"], nil];
        
        [mutAry addObject:[details copy]];
    }
    
    if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy2ndLA"]) {
        [[obj.eAppData objectForKey:@"SecC"] setValue:[NSMutableDictionary dictionary] forKey:@"ExistingPolicy2ndLA"];
    }
    [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy2ndLA"] setValue:[mutAry mutableCopy] forKey:@"PolicyData"];
    
    results2 = Nil;
    //    results2 = [database executeQuery:@"select * from eProposal_Existing_Policy_2 where eProposalNo = ? and PTypeCodeDesc = ?", stringID, @"Policy Owner", Nil];
    results2 = [database executeQuery:@"select * from eProposal_Existing_Policy_2 where eProposalNo = ? and PTypeCode = ? order by PTypeCodeDesc", stringID, @"Policy Owner", Nil];
    mutAry = [NSMutableArray array];
    while ([results2 next]) {
        
        NSArray *details = [NSArray arrayWithObjects:[results2 objectForColumnName:@"PTypeCodeDesc"],[results2 objectForColumnName:@"ExistingPolicy_Company"], [results2 objectForColumnName:@"ExistingPolicy_LifeTerm"], [results2 objectForColumnName:@"ExistingPolicy_Accident"],[results2 objectForColumnName:@"ExistingPolicy_DailyHospitalIncome"],[results2 objectForColumnName:@"ExistingPolicy_CriticalIllness"], [results2 objectForColumnName:@"ExistingPolicy_DateIssued"], nil];
        
        [mutAry addObject:[details copy]];
    }
    if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyPO"]) {
        [[obj.eAppData objectForKey:@"SecC"] setValue:[NSMutableDictionary dictionary] forKey:@"ExistingPolicyPO"];
    }
    [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyPO"] setValue:[mutAry mutableCopy] forKey:@"PolicyData"];
    
    if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"] isEqualToString:@"ES"]) {
        results2 = nil;
        results2 = [database executeQuery:@"select count(*) as count from UL_Rider_Details where ReinvestGYI = 'Yes' and SINO = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], nil];
        bool reinvest = FALSE;
        while ([results2 next]) {
            if ([results2 intForColumn:@"count"] > 0)
            {
                reinvest = TRUE;
                [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"EverGuaranteedCPI"];
            }
            else {
                [[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"EverGuaranteedCPI"];
            }
        }
        if (reinvest) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"EverGuaranteedCPI"];
        }
        else if (!reinvest) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"EverGuaranteedCPI"];
        }
    }
    
    //SEC C end
	
	//SEC D - Nominees start
	results2 = Nil;
	results2 = [database executeQuery:@"select count(*) as count from  eProposal_NM_Details where eProposalNo = ?",stringID,Nil];
	int gotNominee = 0;
	int gotNomineeCount = 0;
	while ([results2 next]) {
		if ([results2 intForColumn:@"count"] > 0) {
            //			NSLog(@"count more than 0");
			gotNominee = 1;
		}
	}
	if (gotNominee == 1) {
		results2 = Nil;
		//		while ([results next]) {
		results2 = [database executeQuery:@"select * from  eProposal_NM_Details where eProposalNo = ? order by ID asc",stringID,Nil];
		while ([results2 next]) {
			gotNomineeCount++;
			if (gotNomineeCount == 1) {
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMTitle"] forKey:@"Nominee1_title"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMName"] forKey:@"Nominee1_name"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMNewICNo"] forKey:@"Nominee1_ic"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMOtherIDType"] forKey:@"Nominee1_otherIDType"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMOtherID"] forKey:@"Nominee1_otherID"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMDOB"] forKey:@"Nominee1_dob"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMSex"] forKey:@"Nominee1_gender"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMShare"] forKey:@"Nominee1_share"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMRelationship"] forKey:@"Nominee1_relatioship"];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:[self getNAtionalityDesc:[results2 stringForColumn:@"NMNationality"]] forKey:@"Nominee1_nationality"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMExactDuties"] forKey:@"Nominee1_ExactDuties"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMNameOfEmployer"] forKey:@"Nominee1_nameofemployer"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:[self getOccupationDesc:[results2 stringForColumn:@"NMOccupation"]] forKey:@"Nominee1_Occupation"];
                
                //            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_nationality"];
                //            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_ExactDuties"];
                //            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_Occupation"];
                //            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_nameofemployer"];
                
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMSamePOAddress"] forKey:@"Nominee1_Address"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress1"] forKey:@"Nominee1_add1TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress2"] forKey:@"Nominee1_add2TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress3"] forKey:@"Nominee1_add3TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMPostcode"] forKey:@"Nominee1_postcodeTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMTown"] forKey:@"Nominee1_townTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getStateDesc:[results2 stringForColumn:@"NMState"]] forKey:@"Nominee1_stateTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getCountryDesc:[results2 stringForColumn:@"NMCountry"]] forKey:@"Nominee1_countryTF"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCRAddress1"] forKey:@"Nominee1_CRadd1TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCRAddress2"] forKey:@"Nominee1_CRadd2TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCRAddress3"] forKey:@"Nominee1_CRadd3TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCRPostcode"] forKey:@"Nominee1_CRpostcodeTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCRTown"] forKey:@"Nominee1_CRtownTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getStateDesc:[results2 stringForColumn:@"NMCRState"]] forKey:@"Nominee1_CRstateTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getCountryDesc:[results2 stringForColumn:@"NMCRCountry"]] forKey:@"Nominee1_CRcountryTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getCountryDesc:[results2 stringForColumn:@"NMChildAlive"]] forKey:@"Nominee1_ChildAlive"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getCountryDesc:[results2 stringForColumn:@"NMTrustStatus"]] forKey:@"Nominee1_TrustStatus"];
			}
			else if (gotNomineeCount == 2) {
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMTitle"] forKey:@"Nominee2_title"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMName"] forKey:@"Nominee2_name"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMNewICNo"] forKey:@"Nominee2_ic"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMOtherIDType"] forKey:@"Nominee2_otherIDType"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMOtherID"] forKey:@"Nominee2_otherID"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMDOB"] forKey:@"Nominee2_dob"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMSex"] forKey:@"Nominee2_gender"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMShare"] forKey:@"Nominee2_share"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMRelationship"] forKey:@"Nominee2_relatioship"];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:[self getNAtionalityDesc:[results2 stringForColumn:@"NMNationality"]] forKey:@"Nominee2_nationality"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMExactDuties"] forKey:@"Nominee2_ExactDuties"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMNameOfEmployer"] forKey:@"Nominee2_nameofemployer"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:[self getOccupationDesc:[results2 stringForColumn:@"NMOccupation"]] forKey:@"Nominee2_Occupation"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMSamePOAddress"] forKey:@"Nominee2_Address"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress1"] forKey:@"Nominee2_add1TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress2"] forKey:@"Nominee2_add2TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress3"] forKey:@"Nominee2_add3TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMPostcode"] forKey:@"Nominee2_postcodeTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMTown"] forKey:@"Nominee2_townTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getStateDesc:[results2 stringForColumn:@"NMState"]]  forKey:@"Nominee2_stateTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getCountryCode:[results2 stringForColumn:@"NMCountry"]] forKey:@"Nominee2_countryTF"];
                
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCRAddress1"] forKey:@"Nominee2_CRadd1TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCRAddress2"] forKey:@"Nominee2_CRadd2TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCRAddress3"] forKey:@"Nominee2_CRadd3TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCRPostcode"] forKey:@"Nominee2_CRpostcodeTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCRTown"] forKey:@"Nominee2_CRtownTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getStateDesc:[results2 stringForColumn:@"NMCRState"]] forKey:@"Nominee2_CRstateTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getCountryDesc:[results2 stringForColumn:@"NMCRCountry"]] forKey:@"Nominee2_CRcountryTF"];
                
                
                
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getCountryDesc:[results2 stringForColumn:@"NMChildAlive"]] forKey:@"Nominee2_ChildAlive"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getCountryDesc:[results2 stringForColumn:@"NMTrustStatus"]] forKey:@"Nominee2_TrustStatus"];
                
                
			}
			else if (gotNomineeCount == 3) {
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMTitle"] forKey:@"Nominee3_title"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMName"] forKey:@"Nominee3_name"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMNewICNo"] forKey:@"Nominee3_ic"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMOtherIDType"] forKey:@"Nominee3_otherIDType"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMOtherID"] forKey:@"Nominee3_otherID"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMDOB"] forKey:@"Nominee3_dob"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMSex"] forKey:@"Nominee3_gender"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMShare"] forKey:@"Nominee3_share"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMRelationship"] forKey:@"Nominee3_relatioship"];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:[self getNAtionalityDesc:[results2 stringForColumn:@"NMNationality"]] forKey:@"Nominee3_nationality"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMExactDuties"] forKey:@"Nominee3_ExactDuties"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMNameOfEmployer"] forKey:@"Nominee3_nameofemployer"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:[self getOccupationDesc:[results2 stringForColumn:@"NMOccupation"]] forKey:@"Nominee3_Occupation"];
				
                
                
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMSamePOAddress"] forKey:@"Nominee3_Address"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress1"] forKey:@"Nominee3_add1TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress2"] forKey:@"Nominee3_add2TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress3"] forKey:@"Nominee3_add3TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMPostcode"] forKey:@"Nominee3_postcodeTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMTown"] forKey:@"Nominee3_townTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getStateDesc:[results2 stringForColumn:@"NMState"]]  forKey:@"Nominee3_stateTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getCountryCode:[results2 stringForColumn:@"NMCountry"]] forKey:@"Nominee3_countryTF"];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCRAddress1"] forKey:@"Nominee3_CRadd1TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCRAddress2"] forKey:@"Nominee3_CRadd2TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCRAddress3"] forKey:@"Nominee3_CRadd3TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCRPostcode"] forKey:@"Nominee3_CRpostcodeTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCRTown"] forKey:@"Nominee3_CRtownTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getStateDesc:[results2 stringForColumn:@"NMCRState"]] forKey:@"Nominee3_CRstateTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getCountryDesc:[results2 stringForColumn:@"NMCRCountry"]] forKey:@"Nominee3_CRcountryTF"];
                
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getCountryDesc:[results2 stringForColumn:@"NMChildAlive"]] forKey:@"Nominee3_ChildAlive"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getCountryDesc:[results2 stringForColumn:@"NMTrustStatus"]] forKey:@"Nominee3_TrustStatus"];
			}
			else if (gotNomineeCount == 4) {
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMTitle"] forKey:@"Nominee4_title"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMName"] forKey:@"Nominee4_name"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMNewICNo"] forKey:@"Nominee4_ic"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMOtherIDType"] forKey:@"Nominee4_otherIDType"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMOtherID"] forKey:@"Nominee4_otherID"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMDOB"] forKey:@"Nominee4_dob"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMSex"] forKey:@"Nominee4_gender"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMShare"] forKey:@"Nominee4_share"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMRelationship"] forKey:@"Nominee4_relatioship"];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:[self getNAtionalityDesc:[results2 stringForColumn:@"NMNationality"]] forKey:@"Nominee4_nationality"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMExactDuties"] forKey:@"Nominee4_ExactDuties"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMNameOfEmployer"] forKey:@"Nominee4_nameofemployer"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:[self getOccupationDesc:[results2 stringForColumn:@"NMOccupation"]] forKey:@"Nominee4_Occupation"];
                
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMSamePOAddress"] forKey:@"Nominee4_Address"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress1"] forKey:@"Nominee4_add1TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress2"] forKey:@"Nominee4_add2TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress3"] forKey:@"Nominee4_add3TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMPostcode"] forKey:@"Nominee4_postcodeTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMTown"] forKey:@"Nominee4_townTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getStateDesc:[results2 stringForColumn:@"NMState"]]  forKey:@"Nominee4_stateTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getCountryCode:[results2 stringForColumn:@"NMCountry"]] forKey:@"Nominee4_countryTF"];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCRAddress1"] forKey:@"Nominee4_CRadd1TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCRAddress2"] forKey:@"Nominee4_CRadd2TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCRAddress3"] forKey:@"Nominee4_CRadd3TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCRPostcode"] forKey:@"Nominee4_CRpostcodeTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCRTown"] forKey:@"Nominee4_CRtownTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getStateDesc:[results2 stringForColumn:@"NMCRState"]] forKey:@"Nominee4_CRstateTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getCountryDesc:[results2 stringForColumn:@"NMCRCountry"]] forKey:@"Nominee4_CRcountryTF"];
                
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getCountryDesc:[results2 stringForColumn:@"NMChildAlive"]] forKey:@"Nominee4_ChildAlive"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[self getCountryDesc:[results2 stringForColumn:@"NMTrustStatus"]] forKey:@"Nominee4_TrustStatus"];
			}
		}
		
		//		}
	}
	//SEC D - Nominees end
    
	//SEC D - Trustees start
	results2 = Nil;
	results2 = [database executeQuery:@"select count(*) as count from  eProposal_Trustee_Details where eProposalNo = ?",stringID,Nil];
	int gotTrustee = 0;
	int gotTrusteeCount = 0;
	while ([results2 next]) {
		if ([results2 intForColumn:@"count"] > 0) {
            //  NSLog(@"count more than 0");
			gotTrustee = 1;
		}
	}
    
	if (gotTrustee == 1) {
        
		results2 = Nil;
		//		while ([results next]) {
		results2 = [database executeQuery:@"select * from  eProposal_Trustee_Details where eProposalNo = ? order by ID asc",stringID,Nil];
		while ([results2 next]) {
            
			gotTrusteeCount++;
			if (gotTrusteeCount == 1) {
				if ([[results2 stringForColumn:@"TrusteeSameAsPO"] isEqualToString:@"Y"])
					[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"true" forKey:@"SamePO"];
				else if ([[results2 stringForColumn:@"TrusteeSameAsPO"] isEqualToString:@"Y"])
					[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"false" forKey:@"SamePO"];
				else
					[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeSameAsPO"] forKey:@"SamePO"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"isForeignAddress"] forKey:@"ForeignAddress"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeTitle"] forKey:@"Title"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeName"] forKey:@"Name"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeSex"] forKey:@"Sex"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeDOB"] forKey:@"DOB"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeNewICNo"] forKey:@"ICNo"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeOtherIDType"] forKey:@"OtherIDType"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeOtherID"] forKey:@"OtherID"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeRelationship"] forKey:@"Relationship"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeAddress1"] forKey:@"Address1"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeAddress2"] forKey:@"Address2"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeAddress3"] forKey:@"Address3"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteePostcode"] forKey:@"Postcode"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeTown"] forKey:@"Town"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeState"] forKey:@"State"];
                
                strTrusteecountry = [self getCountryDesc:[results2 stringForColumn:@"TrusteeCountry"]];
                
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:strTrusteecountry forKey:@"Country"];
			}
			else if (gotTrusteeCount == 2) {
				//[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeSameAsPO"] forKey:@"2TSamePO"];
				if ([[results2 stringForColumn:@"TrusteeSameAsPO"] isEqualToString:@"Y"])
					[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"true" forKey:@"2TSamePO"];
				else if ([[results2 stringForColumn:@"TrusteeSameAsPO"] isEqualToString:@"Y"])
					[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"false" forKey:@"2TSamePO"];
				else
					[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeSameAsPO"] forKey:@"2TSamePO"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"isForeignAddress"] forKey:@"2TForeignAddress"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeTitle"] forKey:@"2TTitle"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeName"] forKey:@"2TName"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeSex"] forKey:@"2TSex"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeDOB"] forKey:@"2TDOB"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeNewICNo"] forKey:@"2TICNo"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeOtherIDType"] forKey:@"2TOtherIDType"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeOtherID"] forKey:@"2TOtherID"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeRelationship"] forKey:@"2TRelationship"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeAddress1"] forKey:@"2TAddress1"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeAddress2"] forKey:@"2TAddress2"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeAddress3"] forKey:@"2TAddress3"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteePostcode"] forKey:@"2TPostcode"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeTown"] forKey:@"2TTown"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeState"] forKey:@"2TState"];
                
                strTrusteecountry2 = [self getCountryDesc:[results2 stringForColumn:@"TrusteeCountry"]];
                
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:strTrusteecountry2 forKey:@"2TCountry"];
			}
			
		}
		
		//		}
	}
	//SEC D - Trustees end
    
	//SEC E start
	results2 = Nil;
	results2 = [database executeQuery:@"select count(*) as count from  eProposal_QuestionAns where eProposalNo = ?",stringID,Nil];
	int gotHQ = 0;
	int gotHQCount = 0;
	while ([results2 next]) {
		if ([results2 intForColumn:@"count"] > 0) {
			gotHQ = 1;
		}
	}
    
	if (gotHQ == 1) {
        
        
        NSArray *LATypes = [[NSArray alloc] initWithObjects:@"LA1", @"LA2", @"PO", nil];
        for (NSString *LAType in LATypes) {
            
            
            results2 = Nil;
            results2 = [database executeQuery:@"select * from  eProposal_QuestionAns where eProposalNo = ? and LAType = ? order by ID asc",stringID, LAType, Nil];
            
            
            
            
            NSString *key;
			gotHQCount = 0;
            while ([results2 next]) {
                
                
                
                [[obj.eAppData objectForKey:@"SecE"] setValue:[results2 stringForColumn:@"LAType"] forKey:@"SecE_personType"];
                gotHQCount++;
                
                if ([LAType isEqualToString:@"LA1"]) {
                    key = @"LA1HQ";
                }
                else if ([LAType isEqualToString:@"LA2"]) {
                    key = @"LA2HQ";
                }
                else {
                    key = @"POHQ";
                }
                if (![[obj.eAppData objectForKey:@"SecE"] objectForKey:key]) {
                    [[obj.eAppData objectForKey:@"SecE"] setValue:[NSMutableDictionary dictionary] forKey:key];
                }
                
                if (gotHQCount == 1) {
                    
                    NSArray *strAry = [[results2 stringForColumn:@"Answer"] componentsSeparatedByString:@" "];
                    if(strAry.count>1)
                    {
                        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[strAry objectAtIndex:0] forKey:@"SecE_height"];
                        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[strAry objectAtIndex:1] forKey:@"SecE_weight"];
                    }
                    else
                    {
                        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:@"" forKey:@"SecE_height"];
                        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:@"" forKey:@"SecE_weight"];
                    }
                    
                }
                else if (gotHQCount == 2){
                    
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q1B"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q1"];
                }
                //                else if (gotHQCount == 3) {
                //
                //                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q2"];
                //                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q2"];
                //                }
                else if (gotHQCount == 3) {
                    
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q3"];
                    NSArray *alcoholAry = [[results2 stringForColumn:@"Reason"] componentsSeparatedByString:@" "];
                    
                    
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[alcoholAry objectAtIndex:0] forKey:@"Q3_beerTF"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[alcoholAry objectAtIndex:1] forKey:@"Q3_wineTF"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[alcoholAry objectAtIndex:2] forKey:@"Q3_wboTF"];
                    
                }
                else if (gotHQCount == 4) {
                    
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q4"];
                    NSArray *smokeAry = [[results2 stringForColumn:@"Reason"] componentsSeparatedByString:@" "];
                    
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[smokeAry objectAtIndex:0] forKey:@"Q4_cigarettesTF"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[smokeAry objectAtIndex:1] forKey:@"Q4_pipeTF"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[smokeAry objectAtIndex:2] forKey:@"Q4_cigarTF"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[smokeAry objectAtIndex:3] forKey:@"Q4_eCigarTF"];
                    
                    
                    //                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q4"];
                }
                else if (gotHQCount == 5) {
                    
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q5"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q5"];
                }
                //                else if (gotHQCount == 7) {
                //
                //                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q6"];
                //                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q6"];
                //                }
                else if (gotHQCount == 6) {
                    
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q7A"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q7"];
                }
                else if (gotHQCount == 7) {
                    
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q7B"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q7b"];
                }
                else if (gotHQCount == 8) {
                    
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q7C"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q7c"];
                }
                else if (gotHQCount == 9) {
                    
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q7D"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q7d"];
                }
                else if (gotHQCount == 10) {
                    
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q7E"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q7e"];
                }
                else if (gotHQCount == 11) {
                    
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q7F"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q7f"];
                }
                else if (gotHQCount == 12) {
                    
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q7G"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q7g"];
                }
                else if (gotHQCount == 13) {
                    
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q7H"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q7h"];
                }
                else if (gotHQCount == 14) {
                    
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q7I"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q7i"];
                }
                else if (gotHQCount == 15) {
                    
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q7J"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q7j"];
                }
                else if (gotHQCount == 16) {
                    
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q8A"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q8"];
                }
                else if (gotHQCount == 17) {
                    
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q8B"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q8b"];
                }
                else if (gotHQCount == 18) {
                    
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q8C"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q8c"];
                }
                //                else if (gotHQCount == 21) {
                //
                //                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q8D"];
                //                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q8d"];
                //                }
                //                else if (gotHQCount == 22) {
                //
                //                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q8E"];
                //                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q8e"];
                //                }
                //                else if (gotHQCount == 23) {
                //
                //                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q9"];
                //                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q9"];
                //                }
                else if (gotHQCount == 19) {
                    
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q10"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q10"];
                }
            }
            
            
            results2 = Nil;
            results2 = [database executeQuery:@"select * from  eProposal_QuestionAns where eProposalNo = ? and QnID = ? and LAType = ?",stringID, @"Q1029", LAType, Nil];
            while ([results2 next]) {
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q11"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q11"];
            }
            
            results2 = Nil;
            results2 = [database executeQuery:@"select * from  eProposal_QuestionAns where eProposalNo = ? and QnID = ? and LAType = ?",stringID, @"Q1030", LAType, Nil];
            while ([results2 next]) {
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q12"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q12"];
            }
            
            results2 = Nil;
            results2 = [database executeQuery:@"select * from  eProposal_QuestionAns where eProposalNo = ? and QnID = ? and LAType = ?",stringID, @"Q1031", LAType, Nil];
            while ([results2 next]) {
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q13"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q13"];
            }
            
            
            results2 = Nil;
            results2 = [database executeQuery:@"select * from  eProposal_QuestionAns where eProposalNo = ? and QnID = ? and LAType = ?",stringID, @"Q1027", LAType, Nil];
            while ([results2 next]) {
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q14A"];
                //                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q14"];
                
                NSArray *femaleAry = [[results2 stringForColumn:@"Reason"] componentsSeparatedByString:@" "];
                
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[femaleAry objectAtIndex:0] forKey:@"Q14"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[femaleAry objectAtIndex:1] forKey:@"Q14_monthsTF"];
                
            }
            
            results2 = Nil;
            results2 = [database executeQuery:@"select * from  eProposal_QuestionAns where eProposalNo = ? and QnID = ? and LAType = ?",stringID, @"Q1028", LAType, Nil];
            while ([results2 next]) {
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q14B"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q14b"];
            }
            
            results2 = Nil;
            results2 = [database executeQuery:@"select * from  eProposal_QuestionAns where eProposalNo = ? and QnID = ? and LAType = ?",stringID, @"Q1032", LAType, Nil];
            
            
            while ([results2 next]) {
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q15"];
                NSString *reason = [results2 stringForColumn:@"Reason"];
                NSArray *ary = [reason componentsSeparatedByString:@" "];
                
                
                //NSLog(@"KY C31 - ary - %i | ary -%@",ary.count,ary);
                
                //KY
                if(ary.count>1)
                {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[ary objectAtIndex:0] forKey:@"Q15_weight"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[ary objectAtIndex:1] forKey:@"Q15_days"];
                }
                else
                {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:@"" forKey:@"Q15_weight"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:@"" forKey:@"Q15_days"];
                }
                
            }
        }
    }
	
	[[obj.eAppData objectForKey:@"SecE"] setValue:@"1st Life Assured" forKey:@"PersonType"]; //default set
	//SEC E end
    
	//SEC F start
	results2 = Nil;
	results2 = [database executeQuery:@"select * from  eProposal_Additional_Questions_1 where eProposalNo = ?",stringID, Nil];
	while ([results2 next]) {
		[[obj.eAppData objectForKey:@"SecF"] setValue:[results2 stringForColumn:@"AdditionalQuestionsName"] forKey:@"Name"];
		[[obj.eAppData objectForKey:@"SecF"] setValue:[results2 stringForColumn:@"AdditionalQuestionsMonthlyIncome"] forKey:@"Income"];
		//[[obj.eAppData objectForKey:@"SecF"] setValue:[results2 stringForColumn:@"AdditionalQuestionsOccupationCode"] forKey:@"Occupation"];
        [[obj.eAppData objectForKey:@"SecF"] setValue:[self getOccupationDesc:[results2 stringForColumn:@"AdditionalQuestionsOccupationCode"]] forKey:@"Occupation"];
        
		[[obj.eAppData objectForKey:@"SecF"] setValue:[results2 stringForColumn:@"AdditionalQuestionsInsured"] forKey:@"Insured"];
		[[obj.eAppData objectForKey:@"SecF"] setValue:[results2 stringForColumn:@"AdditionalQuestionsReason"] forKey:@"No_Reason"];
	}
	//SEC F end
    
	//SEC G start
	results2 = Nil;
	results2 = [database executeQuery:@"select * from  eProposal where eProposalNo = ?",stringID,Nil];
	while ([results2 next]) {
		[[obj.eAppData objectForKey:@"SecG"] setValue:[results2 stringForColumn:@"DeclarationAuthorization"] forKey:@"Declaration_agree"];
        [[obj.eAppData objectForKey:@"SecG"] setValue:[results2 stringForColumn:@"FACTA_Q2"] forKey:@"FACTA_Q2"];
        [[obj.eAppData objectForKey:@"SecG"] setValue:[results2 stringForColumn:@"FACTA_Q4"] forKey:@"FACTA_Q4"];
        [[obj.eAppData objectForKey:@"SecG"] setValue:[results2 stringForColumn:@"FACTA_Q4_Ans_1"] forKey:@"FACTA_Q4_Ans_1"];
        [[obj.eAppData objectForKey:@"SecG"] setValue:[results2 stringForColumn:@"FACTA_Q4_ANS_2"] forKey:@"FACTA_Q4_ANS_2"];
        [[obj.eAppData objectForKey:@"SecG"] setValue:[results2 stringForColumn:@"FACTA_Q5_Entity"] forKey:@"FACTA_Q5_Entity"];
        
        
	}
	//SEC G end
	
	[results close];
    [results2 close];
	[results3 close];
    [database close];
}

-(void)CheckRider
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    //  [database open];
    //	results = [database executeQuery:@"select * from eProposal where SINo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
    //	while ([results next]) {
    //		stringID = [results stringForColumn:@"eProposalNo"];
    //	}
	stringID = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
	//NSLog(@"string id: %@, si: %@", stringID, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"]);
	//SEC A - CO start
	results2 = Nil;
    
    if ([database close])
    {
		[database open];
	}
    
    // ########### ADDED BY EMI 11/06/2014 #######
	//CHECK IF SINO HAS RIDER
	
	//set default value 0 to HasRider
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"N" forKey:@"PYHasRider"];
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"N" forKey:@"LA2HasRider"];
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"N" forKey:@"LA1HasRider"];
	
	
	results2 = Nil;
	//		while ([results next]) {
	results2 = [database executeQuery:@"select PTypeCode, Seq from Trad_Rider_Details where SINO = ? ",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
	
	while ([results2 next])
    {
		NSString * PTypeCode = [results2 stringForColumn:@"PTypeCode"];
		NSString * Seq = [results2 stringForColumn:@"Seq"];
		if ([PTypeCode isEqualToString:@"PY"])
			[[obj.eAppData objectForKey:@"EAPP"] setValue:@"Y" forKey:@"PYHasRider"];
		else if ([PTypeCode isEqualToString:@"LA"] && [Seq isEqualToString:@"2"])
			[[obj.eAppData objectForKey:@"EAPP"] setValue:@"Y" forKey:@"LA2HasRider"];
		else if ([PTypeCode isEqualToString:@"LA"] && [Seq isEqualToString:@"1"])
			[[obj.eAppData objectForKey:@"EAPP"] setValue:@"Y" forKey:@"LAHasRider"];
	}
	//#### CHECK RIDER END
    [database close];
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

-(void)FlagProposal
{
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	
	check_proposal = 0;
    
	if([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SecA_Saved"] isEqualToString:@"Y"])
    {
        UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9001];
        imageView1.hidden = TRUE;
        imageView1 =nil;
        
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3001];
        imageView.hidden = FALSE;
        
        if (imageView.hidden ==FALSE)
        {
            imageView1.hidden = TRUE;
        }
        imageView = nil;
        
        self.SummaryVC.tickPersonalDetails.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        
        self.SummaryVC.tickPersonalDetails.text = @"✓";
        check_proposal +=1;
		firstTimePD = 1;
    }
    
    //    else if([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SecA_Saved"] isEqualToString:@"N"])
    //    {
    //        UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9001];
    //        imageView1.hidden = TRUE;
    //        imageView1 =nil;
    //
    //        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3001];
    //        imageView.hidden = FALSE;
    //        imageView = nil;
    //
    //    }
    
    
    if([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"SecB_Saved"] isEqualToString:@"Y"])
    {
        UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9002];
        imageView1.hidden = TRUE;
        imageView1 =nil;
        
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3002];
        imageView.hidden = FALSE;
        
        if (imageView.hidden ==FALSE)
        {
            imageView1.hidden = TRUE;
        }
        imageView = nil;
        
        self.SummaryVC.tickPolicyDetails.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        
        self.SummaryVC.tickPolicyDetails.text = @"✓";
        check_proposal +=1;
        
    }
    
    if([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"SecC_Saved"] isEqualToString:@"Y"])
    {
        UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9003];
        imageView1.hidden = TRUE;
        imageView1 =nil;
        
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3003];
        imageView.hidden = FALSE;
        
        if (imageView.hidden ==FALSE)
        {
            imageView1.hidden = TRUE;
        }
        imageView = nil;
        
        
        self.SummaryVC.tickeCFF.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        self.SummaryVC.tickeCFF.text =  @"✓";
        check_proposal +=1;
    }
    
    //KY - Edit eApp , check and tick if saved successfully before. //## FLAG FOR NOMINEE
    if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"SecD_Saved"] isEqualToString:@"Y"])
    {
		if (![database open]) {
			NSLog(@"Could not open db.");
		}
		
		bool PYAvailable;
		int gotNominee = 0;
		
		results2 = [database executeQuery:@"select count(*) as count from eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"PY1", Nil];
		while ([results2 next]) {
			if ([results2 intForColumn:@"count"] > 0) {
				PYAvailable = TRUE;
			}
			else {
				PYAvailable = FALSE;
			}
		}
		
		NSString *PYhasRider = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"PYHasRider"];
		
		if (PYAvailable == TRUE) {
			if ([PYhasRider isEqualToString:@"N"]) {
				
			}
			else {
				results = Nil;
				NSString *eProposal = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
				NSString *queryNM = [NSString stringWithFormat:@"select count(*) from eProposal_NM_Details where eProposalNo = '%@'", eProposal];
				results = [database executeQuery:queryNM];
				while ([results next]) {
					gotNominee = [results intForColumn:@"count"];
				}
				//	if (gotNominee > 0) {
                UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9004];
                imageView1.hidden = TRUE;
                imageView1 =nil;
                
                
				UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3004];
				imageView.hidden = FALSE;
				imageView = nil;
				//   self.SummaryVC.tickNominees.text = @"✓";
				
				self.SummaryVC.tickNominees.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
				self.SummaryVC.tickNominees.text = @"✓";
				//	}
			}
		}
		else {
			results = Nil;
			NSString *eProposal = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
			NSString *queryNM = [NSString stringWithFormat:@"select NMName from eProposal_NM_Details where eProposalNo = '%@'", eProposal];
			results = [database executeQuery:queryNM];
			int countNM = 0;
			while ([results next]) {
				countNM = countNM + 1;
				gotNominee = [results intForColumn:@"count"];
			}
			gotNominee = countNM;
			if (gotNominee > 0) {
                
                UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9004];
                imageView1.hidden = TRUE;
                imageView1 =nil;
                
				UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3004];
				imageView.hidden = FALSE;
				imageView = nil;
				//self.SummaryVC.tickNominees.text = @"✓";
				
				self.SummaryVC.tickNominees.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
				self.SummaryVC.tickNominees.text = @"✓";
			}
		}
		
        
        //check_proposal +=1; //Nominee part is optional. Emi
    }
    
    else if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"SecD_Saved"] isEqualToString:@"N"])
    {
        UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9004];
        imageView1.hidden = TRUE;
        imageView1 =nil;
        
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3004];
        imageView.hidden = FALSE;
        imageView = nil;
        
        
    }
    
	
    if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Saved"] isEqualToString:@"Y"])
    {
        
        
        
		//        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
		//        imageView.hidden = FALSE;
		//        imageView = nil;
		//
		//
		//        self.SummaryVC.tickHealthQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
		//        self.SummaryVC.tickHealthQuestions.text = @"✓";
		//  [self tickMarkForSecE];
        //Changes by Satya for 3220
        NSString *LAtYpe=nil;
        [database open];
        results = [database executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
        while([results next]) {
            LAtYpe = [results stringForColumn:@"PTypeCode"];
			
        }
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
        FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
        [db open];
        NSString *POOtherIDType;
        results4 = [db executeQuery:@"select LAOtherIDType from eProposal_LA_Details where eProposalNo = ? AND POFlag = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"N"];
        
        while ([results4 next]) {
            POOtherIDType = [results4 objectForColumnName:@"LAOtherIDType"];
        }
        
        [database close];
        if ([LAtYpe isEqualToString:@"LA1"] && [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_height"]) {
            
            UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9005];
            imageView1.hidden = TRUE;
            imageView1 =nil;
            
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
            self.SummaryVC.tickHealthQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
            
            self.SummaryVC.tickHealthQuestions.text = @"✓";
        }
        
        else if ([LAtYpe isEqualToString:@"LA2"] && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_height"]length]>0 && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_height"]length]>0 ) {
            
            UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9005];
            imageView1.hidden = TRUE;
            imageView1 =nil;
            
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
            
            self.SummaryVC.tickHealthQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
            
            self.SummaryVC.tickHealthQuestions.text = @"✓";
        }
        else if ([LAtYpe isEqualToString:@"PY1"] && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_height"]length]>0 && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_height"]length]>0 ) {
            //[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Saved"];
            
            
            UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9005];
            imageView1.hidden = TRUE;
            imageView1 =nil;
            
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
            
            self.SummaryVC.tickHealthQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
            
            self.SummaryVC.tickHealthQuestions.text = @"✓";
        }
        else if ([LAtYpe isEqualToString:@"PY1"] && [POOtherIDType isEqualToString:@"EDD"] && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_height"]length]>0 ) {
            //[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Saved"];
            
            
            UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9005];
            imageView1.hidden = TRUE;
            imageView1 =nil;
            
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
            
            self.SummaryVC.tickHealthQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
            
            self.SummaryVC.tickHealthQuestions.text = @"✓";
        }
		else if ([LAtYpe isEqualToString:@"PO"] && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_height"]length]>0) {
            //[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Saved"];
            
            UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9005];
            imageView1.hidden = TRUE;
            imageView1 =nil;
            
            
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
            
            self.SummaryVC.tickHealthQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
            
            self.SummaryVC.tickHealthQuestions.text = @"✓";
        }
        
        // }
		
        check_proposal +=1;
    }
    
    else  if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Saved"] isEqualToString:@"Y"])
    {
        UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9005];
        imageView1.hidden = TRUE;
        imageView1 =nil;
        
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
        imageView.hidden = FALSE;
        imageView = nil;
        
        
    }
    
    
    
	//    //Occupation for not baby/housewife/juvenile/students - will auto save
	//    NSString *occup =  [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"LA_Occupation"];
	//
	//   	if (![occup isEqualToString:@"OCC01109"] && ![occup isEqualToString:@"OCC01179"] && ![occup isEqualToString:@"OCC02147"] && ![occup isEqualToString:@"OCC00209"])
	//    {
	//        [[obj.eAppData objectForKey:@"SecF"] setValue:@"Y" forKey:@"SecF_Saved"];
	//
	//
	//    }
	//
	//    if([[[obj.eAppData objectForKey:@"SecF"] objectForKey:@"SecF_Saved"] isEqualToString:@"Y"])
	//    {
	//        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3006];
	//        //imageView.hidden = FALSE;
	//        imageView = nil;
	//        self.SummaryVC.tickAdditionalQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
	//
	//       // self.SummaryVC.tickAdditionalQuestions.text = @"✓";
	//        check_proposal +=1;
	//
	//
	//
	//    }
    
    //fixes by basvi for 3304, 3293
    //Occupation for not baby/housewife/juvenile/students - will auto save
    //changed by basvi for issue no 3304 and 3293
    NSString *occup =  [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"LA_Occupation"];
    
    //    if (![occup isEqualToString:@"OCC01109"] && ![occup isEqualToString:@"OCC01179"] && ![occup isEqualToString:@"OCC02147"] && ![occup isEqualToString:@"OCC00209"])
	if (![occup isEqualToString:@"OCC01082"] && ![occup isEqualToString:@"OCC01105"] && ![occup isEqualToString:@"OCC01109"] && ![occup isEqualToString:@"OCC00209"] && ![occup isEqualToString:@"OCC01179"] && ![occup isEqualToString:@"OCC01360"] && ![occup isEqualToString:@"OCC00570"] && ![occup isEqualToString:@"OCC01961"] && ![occup isEqualToString:@"OCC01962"] && ![occup isEqualToString:@"OCC02321"] && ![occup isEqualToString:@"OCC01596"] && ![occup isEqualToString:@"OCC02147"] && ![occup isEqualToString:@"OCC02149"])
    {
        [[obj.eAppData objectForKey:@"SecF"] setValue:@"Y" forKey:@"SecF_Saved"];
        
        //        //   UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3006];
        //        // imageView.hidden = FALSE;
        //        //imageView = nil;c
        //
        //
        //        //  self.SummaryVC.tickAdditionalQuestions.text=@"";
        //        /// self.SummaryVC.tickAdditionalQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        //
        //        //    self.SummaryVC.tickAdditionalQuestions.text = @"✓";
        //        //     check_proposal +=1;
        
    }
    
    else  if(![[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Income"] )
    {
        //  NSLog(@"%@ obj.eAppData",[[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Income"]);
        
        //        UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9006];
        //        imageView1.hidden = TRUE;
        //        imageView1 =nil;
        //
        //        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3006];
        //         imageView.hidden = FALSE;
        //        imageView = nil;
        self.SummaryVC.tickAdditionalQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
        
        // self.SummaryVC.tickAdditionalQuestions.text = @"✓";
        check_proposal +=1;
    }
    else
    {
        UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9006];
        imageView1.hidden = TRUE;
        imageView1 =nil;
        
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3006];
        imageView.hidden = FALSE;
        imageView = nil;
        self.SummaryVC.tickAdditionalQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        self.SummaryVC.tickAdditionalQuestions.text = @"✓";
        check_proposal +=1;
    }
	
    
	if ([[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"Declaration_agree"] length] != 0)
    {
        UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9007];
        imageView1.hidden = TRUE;
        imageView1 = nil;
        
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3007];
        imageView.hidden = FALSE;
        imageView = nil;
        
        
        //self.SummaryVC.tickDeclaration.text = @"✓";
        self.SummaryVC.tickDeclaration.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        
        self.SummaryVC.tickDeclaration.text = @"✓";
        check_proposal +=1;
    }
    
	int total_checkProposal;
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
    [db open];
    NSString *POOtherIDType;
    results4 = [db executeQuery:@"select LAOtherIDType from eProposal_LA_Details where eProposalNo = ? AND POFlag = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"N"];
	
	while ([results4 next]) {
		POOtherIDType = [results4 objectForColumnName:@"LAOtherIDType"];
    }
    
	
    //	if (![occup isEqualToString:@"OCC01109"] && ![occup isEqualToString:@"OCC01179"] && ![occup isEqualToString:@"OCC02147"] && ![occup isEqualToString:@"OCC00209"])
	if (![occup isEqualToString:@"OCC01082"] && ![occup isEqualToString:@"OCC01105"] && ![occup isEqualToString:@"OCC01109"] && ![occup isEqualToString:@"OCC00209"] && ![occup isEqualToString:@"OCC01179"] && ![occup isEqualToString:@"OCC01360"] && ![occup isEqualToString:@"OCC00570"] && ![occup isEqualToString:@"OCC01961"] && ![occup isEqualToString:@"OCC01962"] && ![occup isEqualToString:@"OCC02321"] && ![occup isEqualToString:@"OCC01596"] && ![occup isEqualToString:@"OCC02147"] && ![occup isEqualToString:@"OCC02149"] && ![POOtherIDType isEqualToString:@"EDD"])
        
    {
		total_checkProposal = 5;
	}
    else if( [POOtherIDType isEqualToString:@"EDD"]){
        NSString *PYhasRider1ForEDD = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"PYHasRider"];
        if  ([PYhasRider1ForEDD isEqualToString:@"Y"]){
            total_checkProposal = 5;
        }else
            total_checkProposal = 4;
    }
	else
		total_checkProposal = 6;
	
    if(check_proposal == total_checkProposal)
    {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
        FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
        if (![db open]) {
            NSLog(@"Could not open db.");
        }
        
        [db open];
        
        [db executeUpdate:@"UPDATE eProposal SET ProposalCompleted = 'Y' WHERE eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
        
        [[obj.eAppData objectForKey:@"EAPP"] setValue:@"Y" forKey:@"Proposal_Confirmation"];
        
        [db close];
    }
	else {
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
        FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
        if (![db open]) {
            NSLog(@"Could not open db.");
        }
        
        [db open];
        
        [db executeUpdate:@"UPDATE eProposal SET ProposalCompleted = 'N' WHERE eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
        
        [[obj.eAppData objectForKey:@"EAPP"] setValue:@"N" forKey:@"Proposal_Confirmation"];
        
        [db close];
        
	}
    
}

#pragma mark - XML
-(void)insertIntoXML {
    
    obj = [DataClass getInstance];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    //credit card info
    FMResultSet *resultsXML = [database executeQuery:@"select * from  eProposal where eProposalNo = ?",stringID,Nil];
    
    NSString *cardMemberAccountNo;
    NSString *cardExpiredDate;
    NSString *cardMemberName;
    NSString *cardMemberNewIcNo;
    NSString *cardMemberContactNo;
    NSString *cardMemberRelationship;
    NSString *creditCardType;
    NSString *creditCardBank;
    bool gotCreditCard;
    while ([resultsXML next]) {
        gotCreditCard = TRUE;
        cardMemberAccountNo = [resultsXML stringForColumn:@"CardMemberAccountNo"] != NULL ? [resultsXML stringForColumn:@"CardMemberAccountNo"] : @"";
        cardExpiredDate = [resultsXML stringForColumn:@"CardExpiredDate"] != NULL ? [resultsXML stringForColumn:@"CardExpiredDate"] : @"";
        cardMemberName = [resultsXML stringForColumn:@"CardMemberName"] != NULL ? [resultsXML stringForColumn:@"CardMemberName"] : @"";
        cardMemberNewIcNo = [resultsXML stringForColumn:@"CardMemberNewICNo"] != NULL ? [resultsXML stringForColumn:@"CardMemberNewICNo"] : @"";
        cardMemberContactNo = [resultsXML stringForColumn:@"CardMemberContactNo"] != NULL ? [resultsXML stringForColumn:@"CardMemberContactNo"] : @"";
        cardMemberRelationship = [resultsXML stringForColumn:@"CardMemberRelationship"] != NULL ? [resultsXML stringForColumn:@"CardMemberRelationship"] : @"";
        FMResultSet  *resultRelationship = [database executeQuery:@"select RelCode from eProposal_Relation where RelDesc = ?",cardMemberRelationship, Nil];
        while ([resultRelationship next])
        {
            cardMemberRelationship = [resultRelationship stringForColumn:@"RelCode"];
        }
        creditCardType = [resultsXML stringForColumn:@"CreditCardType"] != NULL ? [resultsXML stringForColumn:@"CreditCardType"] : @"";
        creditCardBank = [resultsXML stringForColumn:@"CreditCardBank"] != NULL ? [resultsXML stringForColumn:@"CreditCardBank"] : @"";
    }
    
    if (gotCreditCard) {
        NSDictionary *creditCardInfo = @{@"CardMemberAccountNo" : cardMemberAccountNo,
                                         @"CardExpiredDate" : cardExpiredDate,
                                         @"CardMemberName" : cardMemberName,
                                         @"CardMemberNewICNo" : cardMemberNewIcNo,
                                         @"CardMemberContactNo" : cardMemberContactNo,
                                         @"CardMemberRelationship" : cardMemberRelationship,
                                         @"CreditCardType" : creditCardType,
                                         @"CreditCardBank" : creditCardBank,
                                         };
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:creditCardInfo forKey:@"proposalCreditCardInfo"];
    }
    
    //payment info
    resultsXML = nil;
    resultsXML = [database executeQuery:@"select * from  eProposal where eProposalNo = ?",stringID,Nil];
    
    NSString *firstTimePayment;
    NSString *paymentMode;
    NSString *paymentMethod;
    NSString *totalModalPremium1;
    NSString *totalModalPremium = [totalModalPremium1 stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSString *paymentFinalAcceptance;
    bool gotPayment = FALSE;
    while ([resultsXML next]) {
        gotPayment = TRUE;
        firstTimePayment = [resultsXML stringForColumn:@"FirstTimePayment"] != NULL ? [resultsXML stringForColumn:@"FirstTimePayment"] : @"";
        paymentMode = [resultsXML stringForColumn:@"PaymentMode"] != NULL ? [resultsXML stringForColumn:@"PaymentMode"] : @"";
        paymentMethod = [resultsXML stringForColumn:@"RecurringPayment"] != NULL ? [resultsXML stringForColumn:@"RecurringPayment"] : @"";
        totalModalPremium = [resultsXML stringForColumn:@"TotalModalPremium"] != NULL ? [resultsXML stringForColumn:@"TotalModalPremium"] : @"";
        
        paymentFinalAcceptance = [resultsXML stringForColumn:@"PaymentUponFinalAcceptance"] != NULL ? [resultsXML stringForColumn:@"PaymentUponFinalAcceptance"] : @"";
    }
    
    if (gotPayment) {
        NSDictionary *paymentInfo = @{@"FirstTimePayment" : firstTimePayment,
                                      @"PaymentMode" : paymentMode,
                                      @"PaymentMethod" : paymentMethod,
                                      @"TotalModalPremium" : totalModalPremium,
                                      @"PaymentFinalAcceptance" : paymentFinalAcceptance,
                                      };
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:paymentInfo forKey:@"proposalPaymentInfo"];
    }
    
    //quesionaire
    resultsXML = Nil;
	resultsXML = [database executeQuery:@"select count(*) as count from  eProposal_QuestionAns where eProposalNo = ?",stringID,Nil];
	int gotHQ = 0;
	int gotHQCount = 0;
	while ([resultsXML next]) {
		if ([resultsXML intForColumn:@"count"] > 0) {
			gotHQ = 1;
		}
	}
    if (gotHQ == 1) {
        NSMutableArray *questionaires = [NSMutableArray array];
        NSArray *LATypes = [[NSArray alloc] initWithObjects:@"LA1", @"LA2", @"PO", nil];
        for (NSString *LAType in LATypes) {
            resultsXML = nil;
            resultsXML = [database executeQuery:@"select * from  eProposal_QuestionAns where eProposalNo = ? and LAType = ? order by ID asc",stringID, LAType, Nil];
            NSString *height;
            NSString *weight;
            NSString *q1BAns;
            NSString *q1BReason;
            //            NSString *q2Ans;
            //            NSString *q2Reason;
            NSString *q3Ans;
            NSString *q3Reason;
            NSString *q3Reason2;
            NSString *q3Reason3;
            NSString *q4Ans;
            NSString *q4Reason;
            NSString *q5Ans;
            NSString *q5Reason;
            //            NSString *q6Ans;
            //            NSString *q6Reason;
            NSString *q7AAns;
            NSString *q7AReason;
            NSString *q7BAns;
            NSString *q7BReason;
            NSString *q7CAns;
            NSString *q7CReason;
            NSString *q7DAns;
            NSString *q7DReason;
            NSString *q7EAns;
            NSString *q7EReason;
            NSString *q7FAns;
            NSString *q7FReason;
            NSString *q7GAns;
            NSString *q7GReason;
            NSString *q7HAns;
            NSString *q7HReason;
            NSString *q7IAns;
            NSString *q7IReason;
            NSString *q7JAns;
            NSString *q7JReason;
            NSString *q8AAns;
            NSString *q8AReason;
            NSString *q8BAns;
            NSString *q8BReason;
            NSString *q8CAns;
            NSString *q8CReason;
            //            NSString *q8DAns;
            //            NSString *q8DReason;
            //            NSString *q8EAns;
            //            NSString *q8EReason;
            //            NSString *q9Ans;
            //            NSString *q9Reason;
            NSString *q10Ans;
            NSString *q10Reason;
            NSString *q11Ans;
            NSString *q11Reason;
            NSString *q12Ans;
            NSString *q12Reason;
            NSString *q13Ans;
            NSString *q13Reason;
            NSString *q14AAns;
            NSString *q14AReason;
            NSString *q14BAns;
            NSString *q14BReason;
            NSString *q15Ans;
            NSString *q15Reason;
            
            while ([resultsXML next]) {
                gotHQCount++;
                switch (gotHQCount) {
                    case 1:
                        height = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        weight = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        break;
                    case 2:
                        q1BAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q1BReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                        //                    case 3:
                        //                        q2Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        //                        q2Reason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        //                        break;
                    case 3:
                        q3Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q3Reason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        //q3Reason2 = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        //q3Reason3 = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 4:
                        q4Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q4Reason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 5:
                        q5Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q5Reason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                        //                    case 7:
                        //                        q6Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        //                        q6Reason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        //                        break;
                    case 6:
                        q7AAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q7AReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 7:
                        q7BAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q7BReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 8:
                        q7CAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q7CReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 9:
                        q7DAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q7DReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 10:
                        q7EAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q7EReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 11:
                        q7FAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q7FReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 12:
                        q7GAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q7GReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 13:
                        q7HAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q7HReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 14:
                        q7IAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q7IReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 15:
                        q8AAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q8AReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 16:
                        q8BAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q8BReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 17:
                        q8BAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q8BReason = [resultsXML stringForColumn:@"Reason"];
                        break;
                    case 18:
                        q8CAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q8CReason = [resultsXML stringForColumn:@"Reason"];
                        break;
                        //                    case 21:
                        //                        q8DAns = [resultsXML stringForColumn:@"Answer"];
                        //                        q8DReason = [resultsXML stringForColumn:@"Reason"];
                        //                        break;
                        //                    case 22:
                        //                        q8EAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        //                        q8EReason = [resultsXML stringForColumn:@"Reason"];
                        //                        break;
                        //                    case 23:
                        //                        q9Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        //                        q9Reason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        //                        break;
                    case 19:
                        q10Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q10Reason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    default:
                        break;
                }
            }
            resultsXML = nil;
            resultsXML = [database executeQuery:@"select * from  eProposal_QuestionAns where eProposalNo = ? and QnID = ? and LAType = ?",stringID, @"Q1029", LAType, Nil];
            while ([resultsXML next]) {
                q11Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                q11Reason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
            }
            
            resultsXML = nil;
            resultsXML = [database executeQuery:@"select * from  eProposal_QuestionAns where eProposalNo = ? and QnID = ? and LAType = ?",stringID, @"Q1030", LAType, Nil];
            while ([resultsXML next]) {
                q12Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                q12Reason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
            }
            
            resultsXML = nil;
            resultsXML = [database executeQuery:@"select * from  eProposal_QuestionAns where eProposalNo = ? and QnID = ? and LAType = ?",stringID, @"Q1031", LAType, Nil];
            while ([resultsXML next]) {
                q13Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                q13Reason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
            }
            
            resultsXML = nil;
            resultsXML = [database executeQuery:@"select * from  eProposal_QuestionAns where eProposalNo = ? and QnID = ? and LAType = ?",stringID, @"Q1027", LAType, Nil];
            while ([resultsXML next]) {
                q14AAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                q14AReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
            }
            
            resultsXML = nil;
            resultsXML = [database executeQuery:@"select * from  eProposal_QuestionAns where eProposalNo = ? and QnID = ? and LAType = ?",stringID, @"Q1028", LAType, Nil];
            while ([resultsXML next]) {
                q14BAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                q14BReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
            }
            
            resultsXML = nil;
            resultsXML = [database executeQuery:@"select * from  eProposal_QuestionAns where eProposalNo = ? and QnID = ? and LAType = ?",stringID, @"Q1032", LAType, Nil];
            while ([resultsXML next]) {
                q15Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                q15Reason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
            }
            
            if([q3Ans isEqualToString:@"N"])
            {
                q3Reason = @"";
            }
            
            if([q15Ans isEqualToString:@"N"])
            {
                q15Reason = @"";
            }
            
            NSDictionary *questionaireInfo = @{@"QuestionaireCount" : @"30",
                                               @"Questionaire ID=\"1\"" :
                                                   @{@"PTypeCode" : LAType,
                                                     @"Seq" : @"14/06/2013 17:08:22",
                                                     @"Height" : height,
                                                     @"Weight" : weight,
                                                     @"Questions ID=\"1\"" :
                                                         @{@"QnID":@"Q1001",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"OPT",
                                                           @"Answer":@"150;55",
                                                           @"Reason":@"",
                                                           },
                                                     @"Questions ID=\"2\"" :
                                                         @{@"QnID":@"Q1002",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"OPT",
                                                           @"Answer":q1BAns,
                                                           @"Reason":q1BReason,
                                                           },
                                                     //                                                     @"Questions ID=\"3\"" :
                                                     //                                                         @{@"QnID":@"Q1003",
                                                     //                                                           @"QnParty":@"I",
                                                     //                                                           @"AnswerType":@"OPT",
                                                     //                                                           @"Answer":q2Ans,
                                                     //                                                           @"Reason":q2Reason,
                                                     //                                                           },
                                                     @"Questions ID=\"3\"" :
                                                         @{@"QnID":@"Q1004",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"OPT",
                                                           @"Answer":q3Ans,
                                                           @"Reason":q3Reason,
                                                           },
                                                     //                                                     @"Questions ID=\"4\"" :
                                                     //                                                         @{@"QnID":@"Q1004",
                                                     //                                                           @"QnParty":@"I",
                                                     //                                                           @"AnswerType":@"OPT",
                                                     //                                                           @"Answer":q3Ans,
                                                     //                                                           @"Reason":q3Reason2,
                                                     //                                                           },
                                                     //                                                     @"Questions ID=\"4\"" :
                                                     //                                                         @{@"QnID":@"Q1004",
                                                     //                                                           @"QnParty":@"I",
                                                     //                                                           @"AnswerType":@"OPT",
                                                     //                                                           @"Answer":q3Ans,
                                                     //                                                           @"Reason":q3Reason,
                                                     //                                                           },
                                                     @"Questions ID=\"4\"" :
                                                         @{@"QnID":@"Q1005",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"OPT",
                                                           @"Answer":q4Ans,
                                                           @"Reason":q4Reason,
                                                           },
                                                     @"Questions ID=\"5\"" :
                                                         @{@"QnID":@"Q1006",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"OPT",
                                                           @"Answer":q5Ans,
                                                           @"Reason":q5Reason,
                                                           },
                                                     //                                                     @"Questions ID=\"7\"" :
                                                     //                                                         @{@"QnID":@"Q1007",
                                                     //                                                           @"QnParty":@"I",
                                                     //                                                           @"AnswerType":@"TXT",
                                                     //                                                           @"Answer":q6Ans,
                                                     //                                                           @"Reason":q6Reason,
                                                     //                                                           },
                                                     @"Questions ID=\"6\"" :
                                                         @{@"QnID":@"Q1008",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"OPT",
                                                           @"Answer":q7AAns,
                                                           @"Reason":q7AReason,
                                                           },
                                                     @"Questions ID=\"7\"" :
                                                         @{@"QnID":@"Q1010    ",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"TXT",
                                                           @"Answer":q7BAns,
                                                           @"Reason":q7BReason,
                                                           },
                                                     @"Questions ID=\"8\"" :
                                                         @{@"QnID":@"Q1011",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"OPT",
                                                           @"Answer":q7CAns,
                                                           @"Reason":q7CReason,
                                                           },
                                                     @"Questions ID=\"9\"" :
                                                         @{@"QnID":@"Q1012",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"TXT",
                                                           @"Answer":q7DAns,
                                                           @"Reason":q7DReason,
                                                           },
                                                     @"Questions ID=\"10\"" :
                                                         @{@"QnID":@"Q1013",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"OPT",
                                                           @"Answer":q7EAns,
                                                           @"Reason":q7EReason,
                                                           },
                                                     @"Questions ID=\"11\"" :
                                                         @{@"QnID":@"Q1014",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"TXT",
                                                           @"Answer":q7FAns,
                                                           @"Reason":q7FReason,
                                                           },
                                                     @"Questions ID=\"12\"" :
                                                         @{@"QnID":@"Q1015",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"OPT",
                                                           @"Answer":q7GAns,
                                                           @"Reason":q7GReason,
                                                           },
                                                     @"Questions ID=\"13\"" :
                                                         @{@"QnID":@"Q1016",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"OPT",
                                                           @"Answer":q7HAns,
                                                           @"Reason":q7HReason,
                                                           },
                                                     @"Questions ID=\"14\"" :
                                                         @{@"QnID":@"Q1017",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"OPT",
                                                           @"Answer":q7IAns,
                                                           @"Reason":q7IReason,
                                                           },
                                                     @"Questions ID=\"15\"" :
                                                         @{@"QnID":@"Q1018",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"TXT",
                                                           @"Answer":q7JAns,
                                                           @"Reason":q7JReason,
                                                           },
                                                     @"Questions ID=\"16\"" :
                                                         @{@"QnID":@"Q1033",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"OPT",
                                                           @"Answer":q8AAns,
                                                           @"Reason":q8AReason,
                                                           },
                                                     @"Questions ID=\"17\"" :
                                                         @{@"QnID":@"Q1034",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"OPT",
                                                           @"Answer":q8BAns,
                                                           @"Reason":q8BReason,
                                                           },
                                                     @"Questions ID=\"18\"" :
                                                         @{@"QnID":@"Q1035",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"OPT",
                                                           @"Answer":q8CAns,
                                                           @"Reason":q8CReason,
                                                           },
                                                     //                                                     @"Questions ID=\"21\"" :
                                                     //                                                         @{@"QnID":@"Q1023",
                                                     //                                                           @"QnParty":@"I",
                                                     //                                                           @"AnswerType":@"OPT",
                                                     //                                                           @"Answer":q8DAns,
                                                     //                                                           @"Reason":q8DReason,
                                                     //                                                           },
                                                     //                                                     @"Questions ID=\"22\"" :
                                                     //                                                         @{@"QnID":@"Q1024",
                                                     //                                                           @"QnParty":@"I",
                                                     //                                                           @"AnswerType":@"OPT",
                                                     //                                                           @"Answer":q8EAns,
                                                     //                                                           @"Reason":q8EReason,
                                                     //                                                           },
                                                     //                                                     @"Questions ID=\"23\"" :
                                                     //                                                         @{@"QnID":@"Q1025",
                                                     //                                                           @"QnParty":@"I",
                                                     //                                                           @"AnswerType":@"OPT",
                                                     //                                                           @"Answer":q9Ans,
                                                     //                                                           @"Reason":q9Reason,
                                                     //                                                           },
                                                     @"Questions ID=\"19\"" :
                                                         @{@"QnID":@"Q1026",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"OPT",
                                                           @"Answer":q10Ans,
                                                           @"Reason":q10Reason,
                                                           },
                                                     @"Questions ID=\"20\"" :
                                                         @{@"QnID":@"Q1029",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"OPT",
                                                           @"Answer":q11Ans,
                                                           @"Reason":q11Reason,
                                                           },
                                                     @"Questions ID=\"21\"" :
                                                         @{@"QnID":@"Q1025",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"OPT",
                                                           @"Answer":q12Ans,
                                                           @"Reason":q12Reason,
                                                           },
                                                     @"Questions ID=\"22\"" :
                                                         @{@"QnID":@"Q1031",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"OPT",
                                                           @"Answer":q13Ans,
                                                           @"Reason":q13Reason,
                                                           },
                                                     @"Questions ID=\"23\"" :
                                                         @{@"QnID":@"Q1027",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"OPT",
                                                           @"Answer":q14AAns,
                                                           @"Reason":q14AReason,
                                                           },
                                                     @"Questions ID=\"24\"" :
                                                         @{@"QnID":@"Q1028",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"OPT",
                                                           @"Answer":q14BAns,
                                                           @"Reason":q14BReason,
                                                           },
                                                     @"Questions ID=\"25\"" :
                                                         @{@"QnID":@"Q1032",
                                                           @"QnParty":@"I",
                                                           @"AnswerType":@"OPT",
                                                           @"Answer":q15Ans,
                                                           @"Reason":q15Reason,
                                                           },
                                                     },
                                               };
            [questionaires addObject:questionaireInfo];
        }
        
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:questionaires forKey:@"proposalQuestionairies"];
    }
    
    //existing policies
    resultsXML = Nil;
    resultsXML = [database executeQuery:@"select * from eProposal_Existing_Policy_2 where eProposalNo = ? and PTypeCodeDesc = ?", stringID, @"1st Life Assured", Nil];
    NSMutableArray *mutAry = [NSMutableArray array];
    while ([resultsXML next]) {
        
        NSArray *details = [NSArray arrayWithObjects:[resultsXML objectForColumnName:@"PTypeCodeDesc"] != NULL ? [resultsXML objectForColumnName:@"PTypeCodeDesc"] : @"",
                            [resultsXML objectForColumnName:@"ExistingPolicy_Company"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_Company"] : @"",
                            [resultsXML objectForColumnName:@"ExistingPolicy_LifeTerm"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_LifeTerm"] : @"",
                            [resultsXML objectForColumnName:@"ExistingPolicy_Accident"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_Accident"] : @"",
                            [resultsXML objectForColumnName:@"ExistingPolicy_DailyHospitalIncome"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_DailyHospitalIncome"] : @"",
                            [resultsXML objectForColumnName:@"ExistingPolicy_CriticalIllness"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_CriticalIllness"] : @"",
                            [resultsXML objectForColumnName:@"ExistingPolicy_DateIssued"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_DateIssued"] : @"",
                            nil];
        
        
        [mutAry addObject:[details copy]];
    }
    
    NSMutableDictionary *existingPolInfo = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < mutAry.count; i++) {
        NSArray *details = [mutAry objectAtIndex:i];
        NSString *extPolLife = [details objectAtIndex:2];
        NSString *extPolPA = [details objectAtIndex:3];
        NSString *extPolHI = [details objectAtIndex:4];
        NSString *extPolCI = [details objectAtIndex:5];
        extPolLife = [extPolLife stringByReplacingOccurrencesOfString:@"," withString:@""];
        extPolPA = [extPolPA stringByReplacingOccurrencesOfString:@"," withString:@""];
        extPolHI = [extPolHI stringByReplacingOccurrencesOfString:@"," withString:@""];
        extPolCI = [extPolCI stringByReplacingOccurrencesOfString:@"," withString:@""];
        
        NSDictionary *polInfo = @{[NSString stringWithFormat:@"ExistingPol ID=\"%d\"", i+1] :
                                      @{@"PTypeCode" : @"LA",
                                        @"Seq" : [NSString stringWithFormat:@"%d", i+1],
                                        @"PTypeCodeDesc" : [details objectAtIndex:0],
                                        @"ExistingPolDetailsCount" : [NSString stringWithFormat:@"%d", details.count],
                                        [NSString stringWithFormat:@"ExistingPolDetails ID=\"%d\"", i+1] :
                                            @{@"ExtPolCompany":[details objectAtIndex:1],
                                              @"ExtPolLife":extPolLife,
                                              @"ExtPolPA":extPolPA,
                                              @"ExtPolHI":extPolHI,
                                              @"ExtPolCI":extPolCI,
                                              @"ExtPolDateIssued":[details objectAtIndex:6],
                                              @"ExtPolLA":[details objectAtIndex:0],
                                              },
                                        },
                                  };
        [existingPolInfo setValuesForKeysWithDictionary:polInfo];
    }
    
    resultsXML = Nil;
    resultsXML = [database executeQuery:@"select * from eProposal_Existing_Policy_2 where eProposalNo = ? and PTypeCodeDesc = ?", stringID, @"2nd Life Assured", Nil];
    mutAry = [NSMutableArray array];
    while ([resultsXML next]) {
        
        NSString *pTypeCodeDesc = [resultsXML objectForColumnName:@"PTypeCodeDesc"] != NULL ? [resultsXML objectForColumnName:@"PTypeCodeDesc"] : @"";
        NSString *existingPolicyCompany = [resultsXML objectForColumnName:@"ExistingPolicy_Company"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_Company"] : @"";
        NSString *existingPolicyLifeTerm = [resultsXML objectForColumnName:@"ExistingPolicy_LifeTerm"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_LifeTerm"] : @"";
        NSString *existingPolicyAccident = [resultsXML objectForColumnName:@"ExistingPolicy_Accident"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_Accident"] : @"";
        NSString *existingPolicyDailyHospitalIncome = [resultsXML objectForColumnName:@"ExistingPolicy_DailyHospitalIncome"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_DailyHospitalIncome"] : @"";
        NSString *existingPolicyCriticalIllness = [resultsXML objectForColumnName:@"ExistingPolicy_CriticalIllness"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_CriticalIllness"] : @"";
        NSString *existingPolicyDateIssued = [resultsXML objectForColumnName:@"ExistingPolicy_DateIssued"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_DateIssued"] : @"";
        
        NSArray *details = [NSArray arrayWithObjects: pTypeCodeDesc, existingPolicyCompany, existingPolicyLifeTerm, existingPolicyAccident,existingPolicyDailyHospitalIncome, existingPolicyCriticalIllness, existingPolicyDateIssued, nil];
        
        [mutAry addObject:[details copy]];
        
        
    }
    
    for (int i = 0; i < mutAry.count; i++) {
        NSArray *details = [mutAry objectAtIndex:i];
        NSString *extPolLife = [details objectAtIndex:2];
        NSString *extPolPA = [details objectAtIndex:3];
        NSString *extPolHI = [details objectAtIndex:4];
        NSString *extPolCI = [details objectAtIndex:5];
        extPolLife = [extPolLife stringByReplacingOccurrencesOfString:@"," withString:@""];
        extPolPA = [extPolPA stringByReplacingOccurrencesOfString:@"," withString:@""];
        extPolHI = [extPolHI stringByReplacingOccurrencesOfString:@"," withString:@""];
        extPolCI = [extPolCI stringByReplacingOccurrencesOfString:@"," withString:@""];
        
        NSDictionary *polInfo = @{[NSString stringWithFormat:@"ExistingPol ID=\"%d\"", i+1] :
                                      @{@"PTypeCode" : @"LA2",
                                        @"Seq" : [NSString stringWithFormat:@"%d", i+1],
                                        @"PTypeCodeDesc" : [details objectAtIndex:0],
                                        @"ExistingPolDetailsCount" : [NSString stringWithFormat:@"%d", details.count],
                                        [NSString stringWithFormat:@"ExistingPolDetails ID=\"%d\"", i+1] :
                                            @{@"ExtPolCompany":[details objectAtIndex:1],
                                              @"ExtPolLife":extPolLife,
                                              @"ExtPolPA":extPolPA,
                                              @"ExtPolHI":extPolHI,
                                              @"ExtPolCI":extPolCI,
                                              @"ExtPolDateIssued":[details objectAtIndex:6],
                                              @"ExtPolLA":[details objectAtIndex:0],
                                              },
                                        },
                                  };
        [existingPolInfo setValuesForKeysWithDictionary:polInfo];
    }
    [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:existingPolInfo forKey:@"policyExistingLifePolicies"];
    
    //Additional Questions
    resultsXML = Nil;
	resultsXML = [database executeQuery:@"select * from  eProposal_Additional_Questions_1 where eProposalNo = ?",stringID, Nil];
    NSString *addQuesName;
    NSString *addQuesMthlyIncome;
    NSString *addQuesOccpCode;
    NSString *addQuesInsured;
    NSString *addQuesReason;
    bool gotAddQues = FALSE;
    while ([resultsXML next]) {
        gotAddQues = TRUE;
        addQuesName = [resultsXML stringForColumn:@"AdditionalQuestionsName"] != NULL ?[resultsXML stringForColumn:@"AdditionalQuestionsName"] : @"";
        addQuesMthlyIncome = [resultsXML stringForColumn:@"AdditionalQuestionsMonthlyIncome"] != NULL ? [resultsXML stringForColumn:@"AdditionalQuestionsMonthlyIncome"] : @"";
        addQuesMthlyIncome = [addQuesMthlyIncome stringByReplacingOccurrencesOfString:@"," withString:@""];
        addQuesOccpCode = [resultsXML stringForColumn:@"AdditionalQuestionsOccupationCode"] != NULL ? [resultsXML stringForColumn:@"AdditionalQuestionsOccupationCode"] : @"";
        addQuesInsured = [resultsXML stringForColumn:@"AdditionalQuestionsInsured"] != NULL ? [resultsXML stringForColumn:@"AdditionalQuestionsInsured"] : @"";
        addQuesReason = [resultsXML stringForColumn:@"AdditionalQuestionsReason"] != NULL ? [resultsXML stringForColumn:@"AdditionalQuestionsReason"] : @"";
    }
    if (gotAddQues)
    {
        NSDictionary *addQuesInfo = @{@"AddQuesID = \"1\"" :
                                          @{@"AddQuesName": addQuesName,
                                            @"AddQuesMthlyIncome" : addQuesMthlyIncome,
                                            @"AddQuesOccpCode" : addQuesOccpCode,
                                            @"AddQuesInsured" : addQuesInsured,
                                            @"AddQuesReason" : addQuesReason
                                            },
                                      };
        
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:addQuesInfo forKey:@"propoalAddQuesInfo"];
    }
    
    resultsXML = Nil;
    resultsXML = [database executeQuery:@"select count(*) as count from eProposal_Additional_Questions_2 where eProposalNo = ?", stringID, nil];
    int gotQuesCount = 0;
    while ([resultsXML next]) {
        if ([resultsXML intForColumn:@"count"] > 0) {
            gotQuesCount = [resultsXML intForColumn:@"count"];
        }
    }
    if(gotQuesCount != 0) {
        NSMutableArray *addQuesDetails = [NSMutableArray array];
        resultsXML = Nil;
        resultsXML = [database executeQuery:@"select * from eProposal_Additional_Questions_2 where eProposalNo = ?", stringID, nil];
        int quesCount = 0;
        while ([resultsXML next]) {
            quesCount++;
            NSString *addQuesCompany = [resultsXML stringForColumn:@"AdditionalQuestionsCompany"] != NULL ? [resultsXML stringForColumn:@"AdditionalQuestionsCompany"] : @"";
            NSString *addQuesAmountInsured = [resultsXML stringForColumn:@"AdditionalQuestionsAmountInsured"] != NULL ? [resultsXML stringForColumn:@"AdditionalQuestionsAmountInsured"] : @"";
            addQuesAmountInsured = [addQuesAmountInsured stringByReplacingOccurrencesOfString:@"," withString:@""];
            NSString *addQuesLifeAccidentDisease = [resultsXML stringForColumn:@"AdditionalQuestionsLifeAccidentDisease"] != NULL ? [resultsXML stringForColumn:@"AdditionalQuestionsLifeAccidentDisease"] : @"";
            NSString *addQuesYrIssued = [resultsXML stringForColumn:@"AdditionalQuestionsYrIssued"] != NULL ? [resultsXML stringForColumn:@"AdditionalQuestionsYrIssued"] : @"";
            NSDictionary *addQues = @{[NSString stringWithFormat:@"AddQuesDetails ID = \"%d\"", quesCount] : @{@"AddQuesCompany":addQuesCompany, @"AddQuesAmountInsured":addQuesAmountInsured, @"AddQuesLifeAccidentDisease":addQuesLifeAccidentDisease,@"AddQuesYrIssued":addQuesYrIssued},};
            [addQuesDetails addObject:addQues];
            
        }
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:addQuesDetails forKey:@"proposalAddQuesDetails"];
    }
    
    //dividen info
    resultsXML = nil;
    resultsXML = [database executeQuery:@"select * from eProposal where eProposalNo = ?", stringID,nil];
    NSString *cashPaymentOption;
    NSString *cashDividendOption;
    NSString *fullPaidUpOption;
    NSString *fullPaidUpTerm;
    NSString *revisedSA;
    NSString *amtRevised;
    NSString *reducePaidUpYear;
    NSString *reInvestYI;
    bool gotDividen = FALSE;
    while ([resultsXML next]) {
        gotDividen = TRUE;
        cashPaymentOption = @"";
        cashDividendOption = @"";
        fullPaidUpOption = [resultsXML stringForColumn:@"FullyPaidUpOption"] != NULL ? [resultsXML stringForColumn:@"FullyPaidUpOption"] : @"";
        fullPaidUpTerm = [resultsXML stringForColumn:@"FullyPaidUpTerm"] != NULL ? [resultsXML stringForColumn:@"FullyPaidUpTerm"] : @"";
        revisedSA = [resultsXML stringForColumn:@"RevisedSA"] != NULL ? [resultsXML stringForColumn:@"RevisedSA"] : @"";
        amtRevised = [resultsXML stringForColumn:@"AmtRevised"] != NULL ? [resultsXML stringForColumn:@"AmtRevised"] : @"";
        reducePaidUpYear = @"";
        reInvestYI = @"";
    }
    if (gotDividen) {
        NSDictionary *dividenInfo = @{
                                      @"CashPaymentOption" : cashPaymentOption,
                                      @"CashDividendOption" : cashDividendOption,
                                      @"FullPaidUpOption" : fullPaidUpOption,
                                      @"FullPaidUpTerm" : fullPaidUpTerm,
                                      @"RevisedSA" : revisedSA,
                                      @"AmtRevised" : amtRevised,
                                      @"ReducePaidUpYear" : reducePaidUpYear,
                                      @"ReInvestYI" : reInvestYI,
                                      };
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:dividenInfo forKey:@"proposalDividenInfo"];
    }
    
    //Sec D Nominees
    resultsXML = Nil;
    resultsXML = [database executeQuery:@"select count(*) as count from eProposal_NM_Details where eProposalNo = ?", stringID, Nil];
    int gotNominee = 0;
    int gotNomineeCount = 0;
    while ([resultsXML next]) {
        gotNominee = [resultsXML intForColumn:@"count"];
    }
    if (gotNominee > 0) {
        NSMutableDictionary *nomineesInfo = [NSMutableDictionary dictionary];
        [nomineesInfo setValue:[NSString stringWithFormat:@"%d", gotNominee] forKey:@"NomineeCount"];
        resultsXML = Nil;
        resultsXML = [database executeQuery:@"select * from eProposal_NM_Details where eProposalNo = ? order by ID asc", stringID, Nil];
        while ([resultsXML next]) {
            gotNomineeCount++;
            NSDictionary *nominee = @{@"Seq" : [NSString stringWithFormat:@"%d", gotNomineeCount],
                                      @"NMTitle" : [resultsXML stringForColumn:@"NMTitle"] != NULL ? [resultsXML stringForColumn:@"NMTitle"] : @"",
                                      @"NMName" : [resultsXML stringForColumn:@"NMName"] != NULL ? [resultsXML stringForColumn:@"NMName"] : @"",
                                      @"NMShare" : [resultsXML stringForColumn:@"NMShare"] != NULL ? [resultsXML stringForColumn:@"NMShare"] : @"",
                                      @"NMDOB" : [resultsXML stringForColumn:@"NMDOB"] != NULL ? [resultsXML stringForColumn:@"NMDOB"] : @"",
                                      @"NMSex" : [resultsXML stringForColumn:@"NMSex"] != NULL ? [resultsXML stringForColumn:@"NMSex"] : @"",
                                      @"NMRelationship" : [resultsXML stringForColumn:@"NMRelationship"] != NULL ? [resultsXML stringForColumn:@"NMRelationship"] : @"",
                                      @"NMNationality" : [resultsXML stringForColumn:@"NMNationality"] != NULL ? [resultsXML stringForColumn:@"NMNationality"] : @"",
                                      @"NMEmployerName" : [resultsXML stringForColumn:@"NMNameOfEmployer"] != NULL ? [resultsXML stringForColumn:@"NMNameOfEmployer"] : @"",
                                      @"NMOccupation" : [resultsXML stringForColumn:@"NMOccupation"] != NULL ? [resultsXML stringForColumn:@"NMOccupation"] : @"",
                                      @"NMExactDuties" : [resultsXML stringForColumn:@"NMExactDuties"] != NULL ? [resultsXML stringForColumn:@"NMExactDuties"] : @"",
                                      @"NMSamePOAddress" : [resultsXML stringForColumn:@"NMSamePOAddress"] != NULL ? [resultsXML stringForColumn:@"NMSamePOAddress"] : @"",
                                      @"NMTrustStatus" : @"",
                                      @"NMChildAlive" : @"",
                                      @"NMNewIC" :
                                          @{@"NMNewICCode":[resultsXML stringForColumn:@"NMNewICNo"] != NULL ? [resultsXML stringForColumn:@"NMNewICNo"] : @"",
                                            @"NMNewICNo":[resultsXML stringForColumn:@"NMNewICNo"] != NULL ? [resultsXML stringForColumn:@"NMNewICNo"] : @"",
                                            },
                                      @"NMOtherID" :
                                          @{@"NMOtherIDType":[resultsXML stringForColumn:@"NMOtherIDType"] != NULL ? [resultsXML stringForColumn:@"NMOtherIDType"] : @"",
                                            @"NMOtherID":[resultsXML stringForColumn:@"NMOtherID"] != NULL ? [resultsXML stringForColumn:@"NMOtherID"] : @"",
                                            },
                                      @"NMAddr" :
                                          @{@"AddressCode":@"ADR001",
                                            @"Address1":[resultsXML stringForColumn:@"NMAddress1"] != NULL ? [resultsXML stringForColumn:@"NMAddress1"] : @"",
                                            @"Address2":[resultsXML stringForColumn:@"NMAddress2"] != NULL ? [resultsXML stringForColumn:@"NMAddress2"] : @"",
                                            @"Address3":[resultsXML stringForColumn:@"NMAddress3"] != NULL ? [resultsXML stringForColumn:@"NMAddress3"] : @"",
                                            @"Town":[resultsXML stringForColumn:@"NMTown"] != NULL ? [resultsXML stringForColumn:@"NMTown"] : @"",
                                            @"State":[resultsXML stringForColumn:@"NMState"] != NULL ? [resultsXML stringForColumn:@"NMState"] : @"",
                                            @"Postcode":[resultsXML stringForColumn:@"NMPostcode"] != NULL ? [resultsXML stringForColumn:@"NMPostcode"] : @"",
                                            @"Country":[resultsXML stringForColumn:@"NMCountry"] != NULL ? [resultsXML stringForColumn:@"NMCountry"] : @"",
                                            @"ForeignAddress":[resultsXML stringForColumn:@"NMSamePOAddress"] != NULL ? [resultsXML stringForColumn:@"NMSamePOAddress"] : @"",
                                            @"AddressSameAsPO":[resultsXML stringForColumn:@"NMSamePOAddress"] != NULL ? [resultsXML stringForColumn:@"NMSamePOAddress"] : @"",
                                            },
                                      };
            NSString *key = [NSString stringWithFormat:@"Nominee ID = \"%d\"", gotNomineeCount];
            [nomineesInfo setValue:nominee forKey:key];
        }
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:nomineesInfo forKey:@"proposalNomineeInfo"];
    }
    
    //Sec D Trustees
    resultsXML = Nil;
    resultsXML = [database executeQuery:@"select count(*) as count from eProposal_Trustee_Details where eProposalNo = ?", stringID, Nil];
    int gotTrustee = 0;
    int gotTrusteeCount = 0;
    while ([resultsXML next]) {
        gotTrustee = [resultsXML intForColumn:@"count"];
    }
    if (gotTrustee > 0) {
        NSMutableDictionary *trusteeInfo = [NSMutableDictionary dictionary];
        [trusteeInfo setValue:[NSString stringWithFormat:@"%d", gotTrustee] forKey:@"TrusteeCount"];
        resultsXML = Nil;
        resultsXML = [database executeQuery:@"select * from eProposal_Trustee_Details where eProposalNo = ? order by ID asc", stringID, Nil];
        while ([resultsXML next]) {
            gotTrusteeCount++;
            NSDictionary *trustee = @{@"Seq" : [NSString stringWithFormat:@"%d", gotTrusteeCount],
                                      @"TrusteeTitle" : [resultsXML stringForColumn:@"TrusteeTitle"] != NULL ? [resultsXML stringForColumn:@"TrusteeTitle"] : @"",
                                      @"TrusteeName" : [resultsXML stringForColumn:@"TrusteeName"] != NULL ? [resultsXML stringForColumn:@"TrusteeName"] : @"",
                                      @"TrusteeRelationship" : [resultsXML stringForColumn:@"TrusteeRelationship"] != NULL ? [resultsXML stringForColumn:@"TrusteeRelationship"] : @"",
                                      @"TrusteeSex" : [resultsXML stringForColumn:@"TrusteeSex"] != NULL ? [resultsXML stringForColumn:@"TrusteeSex"] : @"",
                                      @"TrusteeDOB" : [resultsXML stringForColumn:@"TrusteeDOB"] != NULL ? [resultsXML stringForColumn:@"TrusteeDOB"] : @"",
                                      @"TRNewIC" :
                                          @{@"TRNewICCode":[resultsXML stringForColumn:@"TrusteeNewICNo"] != NULL ? [resultsXML stringForColumn:@"TrusteeNewICNo"] : @"",
                                            @"TRNewICNo":[resultsXML stringForColumn:@"TrusteeNewICNo"] != NULL ? [resultsXML stringForColumn:@"TrusteeNewICNo"] : @"",
                                            },
                                      @"TROtherID" :
                                          @{@"TrusteeOtherIDType":[resultsXML stringForColumn:@"TrusteeOtherIDType"] != NULL ? [resultsXML stringForColumn:@"TrusteeOtherIDType"] : @"",
                                            @"TrusteeOtherID":[resultsXML stringForColumn:@"TrusteeOtherID"] != NULL ? [resultsXML stringForColumn:@"TrusteeOtherID"] : @"",
                                            },
                                      @"TrusteeAddr" :
                                          @{@"AddressCode":@"ADR001",
                                            @"Address1":[resultsXML stringForColumn:@"TrusteeAddress1"] != NULL ? [resultsXML stringForColumn:@"TrusteeAddress1"] : @"",
                                            @"Address2":[resultsXML stringForColumn:@"TrusteeAddress2"] != NULL ? [resultsXML stringForColumn:@"TrusteeAddress2"] : @"",
                                            @"Address3":[resultsXML stringForColumn:@"TrusteeAddress3"] != NULL ? [resultsXML stringForColumn:@"TrusteeAddress3"] : @"",
                                            @"Town":[resultsXML stringForColumn:@"TrusteeTown"] != NULL ? [resultsXML stringForColumn:@"TrusteeTown"] : @"",
                                            @"State":[resultsXML stringForColumn:@"TrusteeState"] != NULL ? [resultsXML stringForColumn:@"TrusteeState"] : @"",
                                            @"Postcode":[resultsXML stringForColumn:@"TrusteePostcode"] != NULL ? [resultsXML stringForColumn:@"TrusteePostcode"] : @"",
                                            @"Country":[resultsXML stringForColumn:@"TrusteeCountry"] != NULL ? [resultsXML stringForColumn:@"TrusteeCountry"] : @"",
                                            @"ForeignAddress":[resultsXML stringForColumn:@"isForeignAddress"] != NULL ? [resultsXML stringForColumn:@"isForeignAddress"] : @"",
                                            @"AddressSameAsPO":[resultsXML stringForColumn:@"TrusteeSameAsPO"] != NULL ? [resultsXML stringForColumn:@"TrusteeSameAsPO"] : @"",
                                            },
                                      };
            NSString *key = [NSString stringWithFormat:@"Trustee ID = %d", gotTrusteeCount];
            [trusteeInfo  setValue:trustee forKey:key];
        }
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:trusteeInfo forKey:@"eProposalTrusteeInfo"];
    }
    
    //Sec B CO
    resultsXML = Nil;
    resultsXML = [database executeQuery:@"select * from eProposal where eProposalNo = ?", stringID, Nil];
    while ([resultsXML next]) {
        NSDictionary *CODetails = @{
                                    @"COTitle":[resultsXML stringForColumn:@"COTitle"] != NULL ? [resultsXML stringForColumn:@"COTitle"] : @"",
                                    @"COName":[resultsXML stringForColumn:@"COName"] != NULL ? [resultsXML stringForColumn:@"COName"] : @"",
                                    @"CODOB":[resultsXML stringForColumn:@"CODOB"] != NULL ? [resultsXML stringForColumn:@"CODOB"] : @"",
                                    @"COSex":[resultsXML stringForColumn:@"COSex"] != NULL ? [resultsXML stringForColumn:@"COSex"] : @"",
                                    @"CONationality":[resultsXML stringForColumn:@"CONationality"] != NULL ? [resultsXML stringForColumn:@"CONationality"] : @"",
                                    @"CONameOfEmployer":[resultsXML stringForColumn:@"CONameOfEmployer"] != NULL ? [resultsXML stringForColumn:@"CONameOfEmployer"] : @"",
                                    @"COExactNatureOfWork":[resultsXML stringForColumn:@"COExactNatureOfWork"] != NULL ? [resultsXML stringForColumn:@"COExactNatureOfWork"] : @"",
                                    @"CORelationship":[resultsXML stringForColumn:@"CORelationship"] != NULL ? [resultsXML stringForColumn:@"CORelationship"] : @"",
                                    @"CONationality":[resultsXML stringForColumn:@"CONationality"] != NULL ? [resultsXML stringForColumn:@"CONationality"] : @"",
                                    @"COEmployerName":[resultsXML stringForColumn:@"CONameOfEmployer"] != NULL ? [resultsXML stringForColumn:@"CONameOfEmployer"] : @"",
                                    @"COOccupation":[resultsXML stringForColumn:@"COOccupation"] != NULL ? [resultsXML stringForColumn:@"COOccupation"] : @"",
                                    @"COExactDuties":[resultsXML stringForColumn:@"COExactNatureOfWork"] != NULL ? [resultsXML stringForColumn:@"COExactNatureOfWork"] : @"",
                                    @"COSameAddressPO":[resultsXML stringForColumn:@"COSameAddressPO"] != NULL ? [resultsXML stringForColumn:@"COSameAddressPO"] : @"",
                                    @"CONewIC": @{@"CONewICCode": [resultsXML stringForColumn:@"CONewICNo"] != NULL ? [resultsXML stringForColumn:@"CONewICNo"] : @"",
                                                  @"CONewICNo": [resultsXML stringForColumn:@"CONewICNo"] != NULL ? [resultsXML stringForColumn:@"CONewICNo"] : @"",
                                                  },
                                    @"COOtherID":@{@"COOtherIDType": [resultsXML stringForColumn:@"COOtherIDType"] != NULL ? [resultsXML stringForColumn:@"COOtherIDType"] : @"",
                                                   @"COOtherID": [resultsXML stringForColumn:@"COOtherID"] != NULL ? [resultsXML stringForColumn:@"COOtherID"] : @"",
                                                   },
                                    @"COAddr": @{@"AddressCode": @"ADR001",
                                                 @"Address1": [resultsXML stringForColumn:@"COAddress1"] != NULL ? [resultsXML stringForColumn:@"COAddress1"] : @"",
                                                 @"Address2": [resultsXML stringForColumn:@"COAddress2"] != NULL ? [resultsXML stringForColumn:@"COAddress2"] : @"",
                                                 @"Address3": [resultsXML stringForColumn:@"COAddress3"] != NULL ? [resultsXML stringForColumn:@"COAddress3"] : @"",
                                                 @"Town": [resultsXML stringForColumn:@"COTown"] != NULL ? [resultsXML stringForColumn:@"COTown"] : @"",
                                                 @"State": [resultsXML stringForColumn:@"COState"] != NULL ? [resultsXML stringForColumn:@"COState"] : @"",
                                                 @"Postcode": [resultsXML stringForColumn:@"COPostcode"] != NULL ? [resultsXML stringForColumn:@"COPostcode"] : @"",
                                                 @"Country": [resultsXML stringForColumn:@"COCountry"] != NULL ? [resultsXML stringForColumn:@"COCountry"] : @"",
                                                 @"ForeignAddress": [resultsXML stringForColumn:@"COForeignAddressFlag"] != NULL ? [resultsXML stringForColumn:@"COForeignAddressFlag"] : @"",
                                                 @"AddressSameAsPO": [resultsXML stringForColumn:@"COSameAddressPO"] != NULL ? [resultsXML stringForColumn:@"COSameAddressPO"] : @"",
                                                 },
                                    @"COCRAddr": @{@"AddressCode": @"ADR001",
                                                   @"CRAddress1": [resultsXML stringForColumn:@"COCRAddress1"] != NULL ? [resultsXML stringForColumn:@"COCRAddress1"] : @"",
                                                   @"CRAddress2": [resultsXML stringForColumn:@"COCRAddress2"] != NULL ? [resultsXML stringForColumn:@"COCRAddress2"] : @"",
                                                   @"CRAddress3": [resultsXML stringForColumn:@"COCRAddress3"] != NULL ? [resultsXML stringForColumn:@"COCRAddress3"] : @"",
                                                   @"CRTown": [resultsXML stringForColumn:@"COCRTown"] != NULL ? [resultsXML stringForColumn:@"COCRTown"] : @"",
                                                   @"CRState": [resultsXML stringForColumn:@"COCRState"] != NULL ? [resultsXML stringForColumn:@"COCRState"] : @"",
                                                   @"CRPostcode": [resultsXML stringForColumn:@"COCRPostcode"] != NULL ? [resultsXML stringForColumn:@"COCRPostcode"] : @"",
                                                   @"CRCountry": [resultsXML stringForColumn:@"COCRCountry"] != NULL ? [resultsXML stringForColumn:@"COCRCountry"] : @"",
                                                   @"CRForeignAddress": [resultsXML stringForColumn:@"COCRForeignAddressFlag"] != NULL ? [resultsXML stringForColumn:@"COCRForeignAddressFlag"] : @"",
                                                   @"AddressSameAsPO": [resultsXML stringForColumn:@"COSameAddressPO"] != NULL ? [resultsXML stringForColumn:@"COSameAddressPO"] : @"",
                                                   },
                                    @"COContacts": @{@"Contact Type = \"Residence\"": @{@"ContactCode": @"CONT006",
                                                                                        @"ContactNo": [resultsXML stringForColumn:@"COPhoneNo"] != NULL ? [resultsXML stringForColumn:@"COPhoneNo"] : @""},
                                                     },
                                    @"COContacts": @{@"Contact Type = \"Mobile\"": @{@"ContactCode": @"CONT008",
                                                                                     @"ContactNo": [resultsXML stringForColumn:@"COMobileNo"] != NULL ? [resultsXML stringForColumn:@"COMobileNo"] : @""},
                                                     },
                                    @"COContacts": @{@"Contact Type = \"Mobile\"": @{@"ContactCode": @"CONT011",
                                                                                     @"ContactNo": [resultsXML stringForColumn:@"COEmailAddress"] != NULL ? [resultsXML stringForColumn:@"COEmailAddress"] : @""},
                                                     },
                                    };
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:CODetails forKey:@"proposalCODetails"];
    }
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //	_nameLALbl.text = [[obj.eAppData objectForKey:@"SI"] objectForKey:@"NameLA"];
    //    self.myTableView.frame = CGRectMake(0, 44, 318, 748);
    [self hideSeparatorLine];
    //    self.rightView.frame = CGRectMake(223, 0, 801, 748);
}

- (void)viewDidAppear:(BOOL)animated
{
    [self FlagProposal];
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

-(void)hideSeparatorLine
{
    CGRect frame = myTableView.frame;
    frame.size.height = MIN(44 * [ListOfSubMenu count], myTableView.frame.size.height);
    //	NSLog(@"myTableView.frame.size.height: %f", myTableView.frame.size.height);
    myTableView.frame = frame;
}

#pragma mark - table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)myTableView numberOfRowsInSection:(NSInteger)section
{
    return ListOfSubMenu.count;
}

- (void) checkOccupation
{
    obj = [DataClass getInstance];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    AdditionalQuestion_Occupation = @"";
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
	results = Nil;
	results = [database executeQuery:@"select LAOccupationCode from eProposal_LA_Details where eProposalNo = ? and POFlag = 'Y'",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
	while ([results next]) {
		AdditionalQuestion_Occupation = [results stringForColumn:@"LAOccupationCode"];
	}
    
    [[obj.eAppData objectForKey:@"EAPP"]setValue:AdditionalQuestion_Occupation forKey:@"LA_Occupation"];
    
    results = nil;
    results = [database executeQuery:@"select a.OccpCatCode, b.OccpCode from Adm_OccpCat a inner join Adm_OccpCat_Occp b on a.OccpCatCode = b.OccpCatCode where b.OccpCode = ?", AdditionalQuestion_Occupation, nil];
    while ([results next]) {
        AdditionalQuestion_Occupation = [textFields trimWhiteSpaces:[results objectForColumnName:@"OccpCatCode"]];
    }
    
    //[[obj.eAppData objectForKey:@"EAPP"]setValue:AdditionalQuestion_Occupation forKey:@"LA_Occupation"];
    
    
    if (![AdditionalQuestion_Occupation isEqualToString:@"EMP"] && ![AdditionalQuestion_Occupation isEqualToString:@"RET"] && ![AdditionalQuestion_Occupation isEqualToString:@"UNEMP"]) {
        
        
        [database executeUpdate:@"UPDATE eProposal SET AdditionalQuestionsMandatoryFlag = ? WHERE eProposalNo = ?", @"Y", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
        
        
    }
    [[obj.eAppData objectForKey:@"EAPP"]  setValue:@"Y" forKey:@"SecF_Saved"];
    
    
    
    [results close];
    [database close];
    
}

- (UITableViewCell *)tableView:(UITableView *)myTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(AdditionalQuestion_Occupation ==NULL)
        [self checkOccupation];
    
    [self CheckRider];
    
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [ListOfSubMenu objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"";
    cell.textLabel.textColor = [UIColor whiteColor];
	
    cell.textLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:18];
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    
    //    UIImageView *imv1 = [[UIImageView alloc]initWithFrame:CGRectMake(200, 14, 16, 16)];
    //    imv1.image=[UIImage imageNamed:@"cancel.png"];
    //    [cell addSubview:imv1];
    
    //    UIImageView *imgIcon1;
    //    imgIcon1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconNotComplete.png"]];
    //    imgIcon1.frame = CGRectMake(200, 14, 16, 16);
    //    imgIcon1.hidden = FALSE;
    //    imgIcon1.tag = 9000+indexPath.row;
    //
    //    if (imgIcon1.tag == 9000)
    //    {
    //        imgIcon1.hidden = TRUE;
    //    }
    
    UIImageView *imgIcon1;
    imgIcon1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconNotComplete.png"]];
    imgIcon1.frame = CGRectMake(200, 14, 16, 16);
    imgIcon1.hidden = FALSE;
    imgIcon1.tag = 9000+indexPath.row;
    
    if (imgIcon1.tag == 9000)
    {
        imgIcon1.hidden = TRUE;
    }
    
    
	UIImageView *imgIcon2;
    imgIcon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconComplete.png"]];
    imgIcon2.hidden = TRUE;
    imgIcon2.frame = CGRectMake(200, 14, 16, 16);
    imgIcon2.tag = 3000+indexPath.row;
    
    //    UIImageView *ImgIcon3;
    //    ImgIcon3 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"green_jelly_128"]];
    //    ImgIcon3.hidden = TRUE;
    //    ImgIcon3.frame = CGRectMake(200, 14, 16, 16);
    //    ImgIcon3.tag = 10000+indexPath.row;
    
    
    UILabel *labelNA;
    labelNA = [[UILabel alloc]initWithFrame:CGRectMake(195, 14, 30, 16)];
    labelNA.hidden = TRUE;
    labelNA.text =@"N/A";
    labelNA.textColor  =[UIColor grayColor];
    labelNA.backgroundColor =[UIColor clearColor];
    labelNA.tag = 10000+indexPath.row;
    
    //If LA occupation = housewife/juvenile/student/baby - auto save
    if (![AdditionalQuestion_Occupation isEqualToString:@"JUV"] && ![AdditionalQuestion_Occupation isEqualToString:@"STU"] && ![AdditionalQuestion_Occupation isEqualToString:@"HSEWIFE"])
    {
        if(indexPath.row ==6)
        {
            
            cell.textLabel.textColor = [UIColor grayColor];
            cell.userInteractionEnabled = FALSE;
            imgIcon1.hidden = TRUE;
            imgIcon2.hidden = TRUE;
            
            self.SummaryVC.tickAdditionalQuestions.text = @" N/A";
            self.SummaryVC.tickAdditionalQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
            
        }
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
    [db open];
    results = [db executeQuery:@"select LAReligion, LADOB, LAOtherIDType from eProposal_LA_Details where eProposalNo = ? AND POFlag = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"Y"];
    NSString *dob;
	NSString *LAOtherIDType;
    while ([results next]) {
        NSString *religion = [textFields trimWhiteSpaces:[results stringForColumn:@"LAReligion"]];
        if ([religion hasPrefix:@"M"]) {
            poIsMuslim = TRUE;
        }
        else {
            poIsMuslim = FALSE;
        }
        dob = [results stringForColumn:@"LADOB"];
		LAOtherIDType = [results stringForColumn:@"LAOtherIDType"];
    }
    
    
	if ([LAOtherIDType isEqualToString:@"CR"])
    {
        
        if(indexPath.row ==4)
        {
            cell.textLabel.textColor = [UIColor grayColor];
            imgIcon1.hidden = TRUE;
            imgIcon2.hidden = TRUE;
            cell.userInteractionEnabled = FALSE;
            
            self.SummaryVC.tickNominees.text = @" N/A";
            self.SummaryVC.tickNominees.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        }
        
	}
    if (![LAOtherIDType isEqualToString:@"CR"])
    {
		if ([self calculateAge:dob] < 16)
        {
            if(indexPath.row ==4)
            {
                cell.textLabel.textColor = [UIColor grayColor];
                imgIcon1.hidden = TRUE;
                imgIcon2.hidden = TRUE;
                cell.userInteractionEnabled = FALSE;
                
                self.SummaryVC.tickNominees.text = @" N/A";
                self.SummaryVC.tickNominees.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
                
                //  NSLog(@"Below16SudahBuat");
                
                
            }
            
		}
	}
    
    
    if ([db close])
    {
		[db open];
	}
	
	bool la2Available;
	bool PYAvailable;
	
    results = [db executeQuery:@"select count(*) as count from eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"LA2", Nil];
    while ([results next]) {
        if ([results intForColumn:@"count"] > 0) {
            la2Available = TRUE;
        }
        else {
            la2Available = FALSE;
        }
    }
	
	
	results2 = [db executeQuery:@"select count(*) as count from eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"PY1", Nil];
    //  NSLog(@"results2 %@",results2);
    
    while ([results2 next]) {
        if ([results2 intForColumn:@"count"] > 0)
        {
            PYAvailable = TRUE;
            // NSLog(@"True");
        }
        else
        {
            PYAvailable = FALSE;
            // NSLog(@"False");
        }
    }
	
	NSString *PYhasRider1 = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"PYHasRider"];
	NSString *LA2hasRider1 = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"LA2HasRider"];
    
    //    NSLog(@"psyRider %@",LA2hasRider1);
	
	if (PYAvailable == TRUE)
    {
        
		if ([PYhasRider1 isEqualToString:@"N"])
        {
            
            if(indexPath.row ==4)
            {
                cell.textLabel.textColor = [UIColor grayColor];
                imgIcon1.hidden = TRUE;
                imgIcon2.hidden = TRUE;
                cell.userInteractionEnabled = FALSE;
                
                self.SummaryVC.tickNominees.text = @" N/A";
                self.SummaryVC.tickNominees.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
                
            }
            
			//Delete nominee data if exist.
			//Delete eProposal_NM_Details
			if (![db executeUpdate:@"Delete from eProposal_NM_Details where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], nil])
            {
				NSLog(@"Error in Delete Statement - eProposal_NM_Details");
			}
			
			//Delete eProposal_Trustee_Details
			if (![db executeUpdate:@"Delete from eProposal_Trustee_Details where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], nil])
            {
				NSLog(@"Error in Delete Statement - eProposal_Trustee_Details");
			}
			
		}
		else
        {
            
            
		}
	}
	
	if (la2Available == TRUE)
    {
        
		if ([LA2hasRider1 isEqualToString:@"N"])
        {
            
            if(indexPath.row ==4)
            {
                cell.textLabel.textColor = [UIColor grayColor];
                imgIcon1.hidden = TRUE;
                imgIcon2.hidden = TRUE;
                cell.userInteractionEnabled = FALSE;
                
                self.SummaryVC.tickNominees.text = @" N/A";
                self.SummaryVC.tickNominees.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
                
            }
            
			//Delete nominee data if exist.
			//Delete eProposal_NM_Details
			if (![db executeUpdate:@"Delete from eProposal_NM_Details where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], nil])
            {
				NSLog(@"Error in Delete Statement - eProposal_NM_Details");
			}
			
			//Delete eProposal_Trustee_Details
			if (![db executeUpdate:@"Delete from eProposal_Trustee_Details where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], nil])
            {
				NSLog(@"Error in Delete Statement - eProposal_Trustee_Details");
			}
			
		}
		else
        {
            
            
		}
	}
	
	BOOL hasPO;
	results2 = [db executeQuery:@"select count(*) as count from eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"PO", Nil];
    
    while ([results2 next]) {
        if ([results2 intForColumn:@"count"] > 0)
        {
            hasPO = TRUE;
        }
        else
        {
            hasPO = FALSE;
        }
    }
	
	if (hasPO)
	{
		
		if(indexPath.row ==4)
		{
			cell.textLabel.textColor = [UIColor grayColor];
			imgIcon1.hidden = TRUE;
			imgIcon2.hidden = TRUE;
			cell.userInteractionEnabled = FALSE;
			
			self.SummaryVC.tickNominees.text = @" N/A";
			self.SummaryVC.tickNominees.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
			
		}
		
		//Delete nominee data if exist.
		//Delete eProposal_NM_Details
		if (![db executeUpdate:@"Delete from eProposal_NM_Details where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], nil])
		{
			NSLog(@"Error in Delete Statement - eProposal_NM_Details");
		}
		
		//Delete eProposal_Trustee_Details
		if (![db executeUpdate:@"Delete from eProposal_Trustee_Details where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], nil])
		{
			NSLog(@"Error in Delete Statement - eProposal_Trustee_Details");
		}
		
	}
	NSString *POOtherIDType;
    results4 = [db executeQuery:@"select LAOtherIDType from eProposal_LA_Details where eProposalNo = ? AND POFlag = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"N"];
	NSString *PYhasRider1ForEDD = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"PYHasRider"];
	while ([results4 next]) {
		POOtherIDType = [results4 objectForColumnName:@"LAOtherIDType"];
        if( [POOtherIDType isEqualToString:@"EDD"] && ![PYhasRider1ForEDD isEqualToString:@"Y"]){
            if(indexPath.row ==5)
            {
                cell.textLabel.textColor = [UIColor grayColor];
                imgIcon1.hidden = TRUE;
                imgIcon2.hidden = TRUE;
                cell.userInteractionEnabled = FALSE;
                
                
                
            }
        }
	}
    
    
    
    
	[db close];
    
    
    [cell.contentView addSubview:imgIcon2];
    [cell.contentView addSubview:imgIcon1];
    [cell.contentView addSubview:labelNA];
    
    return cell;
}

//- (UITableViewCell *)tableView:(UITableView *)myTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if(AdditionalQuestion_Occupation ==NULL)
//        [self checkOccupation];
//
//	static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//    }
//
//    cell.textLabel.text = [ListOfSubMenu objectAtIndex:indexPath.row];
//    cell.detailTextLabel.text = @"";
//    cell.textLabel.textColor = [UIColor whiteColor];
//
//    cell.textLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:18];
//    cell.textLabel.textAlignment = UITextAlignmentLeft;
//
////    UIImageView *imv1 = [[UIImageView alloc]initWithFrame:CGRectMake(200, 14, 16, 16)];
////    imv1.image=[UIImage imageNamed:@"cancel.png"];
////    [cell addSubview:imv1];
//
//    UIImageView *imgIcon1;
//    imgIcon1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconNotComplete.png"]];
//    imgIcon1.frame = CGRectMake(200, 14, 16, 16);
//    imgIcon1.hidden = FALSE;
//    imgIcon1.tag = 9000+indexPath.row;
//
//    if (imgIcon1.tag == 9000)
//    {
//         imgIcon1.hidden = TRUE;
//    }
//
//	UIImageView *imgIcon2;
//    imgIcon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconComplete.png"]];
//    imgIcon2.hidden = TRUE;
//    imgIcon2.frame = CGRectMake(200, 14, 16, 16);
//    imgIcon2.tag = 3000+indexPath.row;
//
////    UIImageView *ImgIcon3;
////    ImgIcon3 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"green_jelly_128"]];
////    ImgIcon3.hidden = TRUE;
////    ImgIcon3.frame = CGRectMake(200, 14, 16, 16);
////    ImgIcon3.tag = 10000+indexPath.row;
//
//
//    UILabel *labelNA;
//    labelNA = [[UILabel alloc]initWithFrame:CGRectMake(195, 14, 30, 16)];
//    labelNA.hidden = TRUE;
//    labelNA.text =@"N/A";
//    labelNA.textColor  =[UIColor grayColor];
//    labelNA.backgroundColor =[UIColor clearColor];
//    labelNA.tag = 10000+indexPath.row;
//
//    //If LA occupation = housewife/juvenile/student/baby - auto save
//    if (![AdditionalQuestion_Occupation isEqualToString:@"JUV"] && ![AdditionalQuestion_Occupation isEqualToString:@"STU"] && ![AdditionalQuestion_Occupation isEqualToString:@"HSEWIFE"]) {
//        if(indexPath.row ==6)
//        {
//            // NSLog(@"AdditionalQuestion_Occupation - %@",  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"LA_Occupation"]);
//            cell.textLabel.textColor = [UIColor grayColor];
//            cell.userInteractionEnabled = TRUE;
////            labelNA.hidden = FALSE;
//            imgIcon1.hidden = TRUE;
//            imgIcon2.hidden = TRUE;
//
//            self.SummaryVC.tickAdditionalQuestions.text = @" NA";
//            self.SummaryVC.tickAdditionalQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
//
//        }
//    }
//
//
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	NSString *docsPath = [paths objectAtIndex:0];
//	NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
//
//	FMDatabase *db = [FMDatabase databaseWithPath:path];
//	[db open];
//    NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
//	NSString *POOtherIDType;
//	NSString *selectPO = [NSString stringWithFormat:@"SELECT LAOtherIDType FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'",eProposalNo];
//
//	FMResultSet *results1;
//	results1 = [db executeQuery:selectPO];
//	while ([results1 next]) {
//		POOtherIDType = [results1 objectForColumnName:@"LAOtherIDType"];
//	}
//
//	if ([POOtherIDType isEqualToString:@"CR"])
//    {
//
//        if(indexPath.row ==4)
//        {
//            cell.textLabel.textColor = [UIColor grayColor];
//            imgIcon1.hidden = TRUE;
//            imgIcon2.hidden = TRUE;
//
//            self.SummaryVC.tickNominees.text = @" NA";
//            self.SummaryVC.tickNominees.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
//
//
//            NSLog(@"NominiesNominies %@",POOtherIDType);
//        }
//
//
//
//	}
//
//    [cell.contentView addSubview:imgIcon2];
//    [cell.contentView addSubview:imgIcon1];
//    [cell.contentView addSubview:labelNA];
//
//    return cell;
//}


#pragma mark - table delegate

- (void)nextStoryboard:(NSIndexPath *)indexPath
{
	selectedPath = indexPath;
    UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
	
    if (indexPath.row == 0)     //summary
    {
		if (Proceed) {
			self.rightView.hidden = FALSE;
			self.SectAView.hidden = TRUE;
			self.SectBView.hidden = TRUE;
			self.SectCView.hidden = TRUE;
			self.SectDView.hidden = TRUE;
			self.SectEView.hidden = TRUE;
			self.SectFView.hidden = TRUE;
			self.SectGView.hidden = TRUE;
			
			[[obj.eAppData objectForKey:@"EAPP"] setValue:@"Summary" forKey:@"Sections"];
			
			
			BOOL doesContain = [self.rightView.subviews containsObject:self.SummaryVC.view];
			if (!doesContain)
			{
				self.SummaryVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"SummaryScreen"];
				[self addChildViewController:self.SummaryVC];
				[self.rightView addSubview:self.SummaryVC.view];
				
				
				//        self.SummaryVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"SummaryScreen"];
				//        _SummaryVC.delegate = self;
				//        [self addChildViewController:self.SummaryVC];
				//        [self.rightView addSubview:self.SummaryVC.view];
			}
		}
    }
    
    else if (indexPath.row == 1)
    {
		if (Proceed == YES) {
			self.rightView.hidden = TRUE;
			self.SectAView.hidden = FALSE;
			self.SectBView.hidden = TRUE;
			self.SectCView.hidden = TRUE;
			self.SectDView.hidden = TRUE;
			self.SectEView.hidden = TRUE;
			self.SectFView.hidden = TRUE;
			self.SectGView.hidden = TRUE;
			
			[[obj.eAppData objectForKey:@"EAPP"] setValue:@"SectionA" forKey:@"Sections"];
			
			//BOOL doesContain = [self.SectAView.subviews containsObject:self.eAppPersonalDataVC.view];
			//if (!doesContain){
            self.eAppPersonalDataVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"eAppDataScreen"];
            [self addChildViewController:self.eAppPersonalDataVC];
            [self.SectAView addSubview:self.eAppPersonalDataVC.view];
			//}
		}
    }
    
    else if (indexPath.row == 2)     //policy details
    {
		if (Proceed == YES) {
			self.rightView.hidden = TRUE;
			self.SectAView.hidden = TRUE;
			self.SectBView.hidden = FALSE;
			self.SectCView.hidden = TRUE;
			self.SectDView.hidden = TRUE;
			self.SectEView.hidden = TRUE;
			self.SectFView.hidden = TRUE;
			self.SectGView.hidden = TRUE;
			
			[[obj.eAppData objectForKey:@"EAPP"] setValue:@"SectionB" forKey:@"Sections"];
			
			
			//BOOL doesContain = [self.SectBView.subviews containsObject:self.PolicyVC.view];
			//if (!doesContain){
            //			[[obj.eAppData objectForKey:@"SecB"] setValue:@"Basic   Plan" forKey:@"BasicPlan"];
            self.PolicyVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"MainPolicyScreen"];
            [self addChildViewController:self.PolicyVC];
            [self.SectBView addSubview:self.PolicyVC.view];
			//}
		}
    }
	
    else if (indexPath.row == 3)     //Existing  Life Policy
    {
		if (Proceed == YES)
        {
			self.rightView.hidden = TRUE;
			self.SectAView.hidden = TRUE;
			self.SectBView.hidden = TRUE;
			self.SectCView.hidden = FALSE;
			self.SectDView.hidden = TRUE;
			self.SectEView.hidden = TRUE;
			self.SectFView.hidden = TRUE;
			self.SectGView.hidden = TRUE;
			
			[[obj.eAppData objectForKey:@"EAPP"] setValue:@"SectionC" forKey:@"Sections"];
			
			
			//BOOL doesContain = [self.SectCView.subviews containsObject:self.part4.view];
			//if (!doesContain){
            self.part4 = [nextStoryboard instantiateViewControllerWithIdentifier:@"Part4Existing"];
            [self addChildViewController:self.part4];
            [self.SectCView addSubview:self.part4.view];
			//}
		}
    }
    
    else if (indexPath.row == 4)     //nominees & trustees
    {
		if (Proceed == YES) {
			self.rightView.hidden = TRUE;
			self.SectAView.hidden = TRUE;
			self.SectBView.hidden = TRUE;
			self.SectCView.hidden = TRUE;
			self.SectDView.hidden = FALSE;
			self.SectEView.hidden = TRUE;
			self.SectFView.hidden = TRUE;
			self.SectGView.hidden = TRUE;
			
			[[obj.eAppData objectForKey:@"EAPP"] setValue:@"SectionD" forKey:@"Sections"];
			
			//BOOL doesContain = [self.SectDView.subviews containsObject:self.NomineesVC.view];
			
			//if (!doesContain)
			//{
            self.NomineesVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"MainNomineesScreen"];
            [self addChildViewController:self.NomineesVC];
            [self.SectDView addSubview:self.NomineesVC.view];
            
            //1st nominee
            if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_name"] length] != 0)
            {
                _NomineesVC.Nominee1Lbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_name"];
            }
            else
                _NomineesVC.Nominee1Lbl.text = @"Add Nominee (1)";
            
            //2nd nominee
            if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_name"] length] != 0) {
                _NomineesVC.Nominee2Lbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_name"];
            }
            else
                _NomineesVC.Nominee2Lbl.text = @"Add Nominee (2)";
            //3rd nominee
            if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_name"] length] != 0) {
                _NomineesVC.Nominee3Lbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_name"];
            }
            else
                _NomineesVC.Nominee3Lbl.text = @"Add Nominee (3)";
            //4th nominee
            if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_name"] length] != 0) {
                _NomineesVC.Nominee4Lbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_name"];
            }
            else
                _NomineesVC.Nominee4Lbl.text = @"Add Nominee (4)";
            
            //1st trustee
            if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Name"] length] != 0) {
                
                _NomineesVC.trusteeLbl1.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Name"];
            }
            else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"SamePO"] isEqualToString:@"true"]) {
                
                _NomineesVC.trusteeLbl1.text = @"PO Name";
            }
            else {
                
                _NomineesVC.trusteeLbl1.text = @"Add Trustee (1)";
            }
            //2nd trustee
            if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TName"] length] != 0) {
                
                _NomineesVC.trusteeLbl2.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TName"];
            }
            else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TSamePO"] isEqualToString:@"true"]) {
                
                _NomineesVC.trusteeLbl2.text = @"PO Name";
            }
            else {
                
                _NomineesVC.trusteeLbl2.text = @"Add Trustee (2)";
            }
            
			//}
			
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *documentsDirectory = [paths objectAtIndex:0];
			NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
			
			FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
			if (![db open]) {
				NSLog(@"Could not open db.");
			}
			
			bool PYAvailable;
			
			results2 = [db executeQuery:@"select count(*) as count from eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"PY1", Nil];
			while ([results2 next]) {
				if ([results2 intForColumn:@"count"] > 0) {
					PYAvailable = TRUE;
				}
				else {
					PYAvailable = FALSE;
				}
			}
			
			NSString *PYhasRider = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"PYHasRider"];
			
			
			if (PYAvailable == TRUE) {
				if ([PYhasRider isEqualToString:@"N"]) {
					_NomineesVC.Nominee1Lbl.text = @"Add Nominee (1)";
					_NomineesVC.Nominee2Lbl.text = @"Add Nominee (2)";
					_NomineesVC.Nominee3Lbl.text = @"Add Nominee (3)";
					_NomineesVC.Nominee4Lbl.text = @"Add Nominee (4)";
					_NomineesVC.trusteeLbl1.text = @"Add Trustee (1)";
					_NomineesVC.trusteeLbl2.text = @"Add Trustee (2)";
					_NomineesVC.totalShareLbl.text = @"0";
					
					
					
				}
			}
			[db close];
		}
		
    }
    
    else if (indexPath.row == 5)     //health questions
    {
		if (Proceed == YES) {
			self.rightView.hidden = TRUE;
			self.SectAView.hidden = TRUE;
			self.SectBView.hidden = TRUE;
			self.SectCView.hidden = TRUE;
			self.SectDView.hidden = TRUE;
			self.SectEView.hidden = FALSE;
			self.SectFView.hidden = TRUE;
			self.SectGView.hidden = TRUE;
			
			[[obj.eAppData objectForKey:@"EAPP"] setValue:@"SectionE" forKey:@"Sections"];
            //			BOOL doesContain = [self.SectEView.subviews containsObject:self.HealthQuestionsVC.view];
            //			if (!doesContain) {
            self.HealthQuestionsVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"HealthQuestionsScreen"];
            [self addChildViewController:self.HealthQuestionsVC];
            [self.SectEView addSubview:self.HealthQuestionsVC.view];
            //			}
		}
    }
    
    else if (indexPath.row == 6)     //Additional questions
    {
		if (Proceed == YES) {
			self.rightView.hidden = TRUE;
			self.SectAView.hidden = TRUE;
			self.SectBView.hidden = TRUE;
			self.SectCView.hidden = TRUE;
			self.SectDView.hidden = TRUE;
			self.SectEView.hidden = TRUE;
			self.SectFView.hidden = FALSE;
			self.SectGView.hidden = TRUE;
			
			[[obj.eAppData objectForKey:@"EAPP"] setValue:@"SectionF" forKey:@"Sections"];
			
			//BOOL doesContain = [self.SectFView.subviews containsObject:self.AddQuestVC.view];
			//if (!doesContain)
			//{
            self.AddQuestVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"AddQuestScreen"];
            [self addChildViewController:self.AddQuestVC];
            [self.SectFView addSubview:self.AddQuestVC.view];
			//}
		}
    }
    
    else if (indexPath.row == 7)     //Declaration
    {
		if (Proceed == YES) {
			self.rightView.hidden = TRUE;
			self.SectAView.hidden = TRUE;
			self.SectBView.hidden = TRUE;
			self.SectCView.hidden = TRUE;
			self.SectDView.hidden = TRUE;
			self.SectEView.hidden = TRUE;
			self.SectFView.hidden = TRUE;
			self.SectGView.hidden = FALSE;
			
			[[obj.eAppData objectForKey:@"EAPP"] setValue:@"SectionG" forKey:@"Sections"];
			
			//BOOL doesContain = [self.SectGView.subviews containsObject:self.DeclareVC.view];
			//if (!doesContain)
			//{
            self.DeclareVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"DeclareEAppScreen"];
            [self addChildViewController:self.DeclareVC];
            [self.SectGView addSubview:self.DeclareVC.view];
			//}
		}
		
    }
	
	
    nextStoryboard = nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	selectedPath = indexPath;
	//CurrentP = indexPath;
	
	if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"EAPPSave"] isEqualToString:@"1"]) {
		[self hideKeyboard];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Do you want to save?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
		CurrentP = selectedPath;
		//indexPath = nil;
		alert.tag = 998;
		[alert show];
		alert = nil;
	}
	else if (![[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"EAPPSave"] isEqualToString:@"1"]) {
		[self nextStoryboard:indexPath];
	}
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (selectedPath.row == indexPath.row){//when trying to select the same row
        return nil;
    }
    if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionA"]) {
        if (_eAppPersonalDataVC.p2) {
            if (![self alertForPersonalDetails]) {
                return Nil;
            }
        }
		if (firstTimePD == 0 && ![[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SecA_Saved"] isEqualToString:@"Y"]){
            PopUpAlertForA = NO;
			Proceed = [self DoDone2];
			if (Proceed == NO)
				return nil;
		}
    }
	
	if (selectedPath.row != indexPath.row)    //summary
    {
		//NSLog(@"%d, %d",selectedPath.row, indexPath.row);
		previousPath = selectedPath;
		
		
        //		if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"EAPPSave"] isEqualToString:@"1"]) {
        //			[self hideKeyboard];
        //			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Do you want to save?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        //			CurrentP = indexPath;
        //			//indexPath = nil;
        //			alert.tag = 998;
        //			[alert show];
        //			alert = nil;
        //			return nil;
        //		}
	}
    
    return indexPath;
}



-(void)selectedMenu:(NSString *)menu
{
    
    UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
    
    if ([menu isEqualToString:@"1"]) {
        
        
        self.eAppPersonalDataVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"eAppDataScreen"];
        [self addChildViewController:self.eAppPersonalDataVC];
        [self.rightView addSubview:self.eAppPersonalDataVC.view];
        
        selectedPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    if ([menu isEqualToString:@"2"]) {
        
        self.PolicyVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"MainPolicyScreen"];
        [self addChildViewController:self.PolicyVC];
        [self.rightView addSubview:self.PolicyVC.view];
        
        selectedPath = [NSIndexPath indexPathForRow:2 inSection:0];
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    if ([menu isEqualToString:@"3"]) {
        
        self.NomineesVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"MainNomineesScreen"];
        [self addChildViewController:self.NomineesVC];
        [self.rightView addSubview:self.NomineesVC.view];
        
        selectedPath = [NSIndexPath indexPathForRow:3 inSection:0];
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    if ([menu isEqualToString:@"4"]) {
        
        self.HealthVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"HealthQuestScreen"];
        //        self.HealthVC.delegate = self;
		
        [self addChildViewController:self.HealthVC];
        [self.rightView addSubview:self.HealthVC.view];
        
        selectedPath = [NSIndexPath indexPathForRow:4 inSection:0];
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    if ([menu isEqualToString:@"5"]) {
        
        self.AddQuestVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"AddQuestScreen"];
        [self addChildViewController:self.AddQuestVC];
        [self.rightView addSubview:self.AddQuestVC.view];
        
        selectedPath = [NSIndexPath indexPathForRow:5 inSection:0];
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    if ([menu isEqualToString:@"6"]) {
        
        self.DeclareVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"DeclareEAppScreen"];
        [self addChildViewController:self.DeclareVC];
        [self.rightView addSubview:self.DeclareVC.view];
        
        selectedPath = [NSIndexPath indexPathForRow:6 inSection:0];
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

-(void) swipeToHQ2{
    self.HealthVC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"HQ2"];
    _HealthVC2.delegate = self;
    [self addChildViewController:self.HealthVC2];
    [self.rightView addSubview:self.HealthVC2.view];
    
}

-(void) swipeToHQ3 {
    self.HealthVC3 = [self.storyboard instantiateViewControllerWithIdentifier:@"HQ3"];
    [self addChildViewController:self.HealthVC3];
    [self.rightView addSubview:self.HealthVC3.view];
    
}



#pragma mark - memory managemnet

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [self setMyTableView:nil];
    [self setRightView:nil];
	[self setSectGView:nil];
	[self setSectFView:nil];
	[self setSectEView:nil];
	[self setSectDView:nil];
	[self setNameLALbl:nil];
	[self setDoneBtn:nil];
    [super viewDidUnload];
}

- (IBAction)doeAppChecklist:(id)sender {
    
	[self FlagProposal];
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"BackToChecklist"];
    if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"EAPPSave"] isEqualToString:@"1"]) {
        [self hideKeyboard];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Do you want to save?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
        alert.tag = 999;
        PopUpAlert = NO;
        [alert show];
        alert = nil;
        return;
    }
    else {
        [self dismissViewControllerAnimated:TRUE completion:nil];
		[self FlagProposal];
    }
	
}

- (IBAction)doDone:(id)sender {
	
    [self hideKeyboard];
	
	if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionA"]) {
		if (_eAppPersonalDataVC.p2) {
            if ([self alertForPersonalDetails]) {
                [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"TickPart2"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.TitleCodeSelected forKey:@"Title"];
                if (_eAppPersonalDataVC.sexSC.selectedSegmentIndex == 0) {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:@"M" forKey:@"Sex"];
                }
                else {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:@"F" forKey:@"Sex"];
                }
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.fullNameTF.text forKey:@"FullName"];
                
                if (_eAppPersonalDataVC.telNoTF.text.length != 0 && _eAppPersonalDataVC.telPhoneNoPrefixTF.text.length != 0)
                {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:[NSString stringWithFormat:@"%@ %@", _eAppPersonalDataVC.telPhoneNoPrefixTF.text ,_eAppPersonalDataVC.telNoTF.text]forKey:@"TelNo"];
                    NSLog(@"EEE: telNo: %@", [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TelNo"]);
                }
                else {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:@"" forKey:@"TelNo"];
                    
                    NSLog(@"EEE: telNo: %@", [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TelNo"]);
                }
                
                if (_eAppPersonalDataVC.mobilePrefixTF.text.length != 0 && _eAppPersonalDataVC.mobileTF.text.length != 0) {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:[NSString stringWithFormat:@"%@ %@", _eAppPersonalDataVC.mobilePrefixTF.text, _eAppPersonalDataVC.mobileTF.text] forKey:@"MobileNo"];
                }
                else {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:@"" forKey:@"MobileNo"];
                }
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.icNoTF.text forKey:@"ICNo"];
                
                
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.DOBLbl.text forKey:@"DOB"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.emailTF.text forKey:@"Email"];
                
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.NationalityLbl.text forKey:@"Nationality"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.OccupationLbl.text forKey:@"Occupation"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.nameOfEmployerTF.text forKey:@"NameOfEmployer"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.exactNatureOfWorkTF.text forKey:@"ExactNatureOfWork"];
                
                //[[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.OtherIDLbl.text forKey:@"OtherIDType"];
				[[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.IDTypeCodeSelected forKey:@"OtherIDType"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.otherIDTF.text forKey:@"OtherID"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.RelationshipLbl.text forKey:@"Relationship"];
                if (_eAppPersonalDataVC.sa) {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"SameAddress"];
                }
                else {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"SameAddress"];
                }
                if (_eAppPersonalDataVC.fa) {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"ForeignAddress"];
                }
                else {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"ForeignAddress"];
                }
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.addressTF.text forKey:@"Address1"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.address2TF.text forKey:@"Address2"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.address3TF.text forKey:@"Address3"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.postcodeTF.text forKey:@"Postcode"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.townTF.text forKey:@"Town"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.stateLbl.text forKey:@"State"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.countryLbl.text forKey:@"Country"];
                
                if (_eAppPersonalDataVC.CRfa) {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"CRForeignAddress"];
                }
                else {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"CRForeignAddress"];
                }
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.CRaddressTF.text forKey:@"CRAddress1"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.CRaddress2TF.text forKey:@"CRAddress2"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.CRaddress3TF.text forKey:@"CRAddress3"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.CRpostcodeTF.text forKey:@"CRPostcode"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.CRtownTF.text forKey:@"CRTown"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.CRstateLbl.text forKey:@"CRState"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.CRcountryLbl.text forKey:@"CRCountry"];
                
                
            }
            else {
                return;
            }
        }
        else {
            [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickPart2"];
        }
        
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3001];
        imageView.hidden = FALSE;
        imageView = nil;
        
        UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9001];
        imageView1.hidden = TRUE;
        imageView1 = nil;
        
        [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"SecA_Saved"];
        
        _SummaryVC.tickPersonalDetails.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        _SummaryVC.tickPersonalDetails.text =  @"✓";
		
		
		//Change view in Nominee depends on contingent Owner: NO CHECKING FOR RIDER YET
		
        //		if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickPart2"] isEqualToString:@"Y"]) {
        //			self.NomineesVC.tableView.allowsSelection = NO;
        //			self.NomineesVC.Nominee1Lbl.textColor = [UIColor grayColor];
        //			self.NomineesVC.Nominee2Lbl.textColor = [UIColor grayColor];
        //			self.NomineesVC.Nominee3Lbl.textColor = [UIColor grayColor];
        //			self.NomineesVC.Nominee4Lbl.textColor = [UIColor grayColor];
        //			self.NomineesVC.trusteeLbl1.textColor = [UIColor grayColor];
        //			self.NomineesVC.trusteeLbl2.textColor = [UIColor grayColor];
        //		}
        //		else {
        //			self.NomineesVC.tableView.allowsSelection = YES;
        //			self.NomineesVC.Nominee1Lbl.textColor = [UIColor blackColor];
        //			self.NomineesVC.Nominee2Lbl.textColor = [UIColor blackColor];
        //			self.NomineesVC.Nominee3Lbl.textColor = [UIColor blackColor];
        //			self.NomineesVC.Nominee4Lbl.textColor = [UIColor blackColor];
        //			self.NomineesVC.trusteeLbl1.textColor = [UIColor blackColor];
        //			self.NomineesVC.trusteeLbl2.textColor = [UIColor blackColor];
        //		}
        
        [self saveEApp];
        // [self deletePDFs];
		
	}
	else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionB"]) {
        if ([self validSecB]){
            
            if (_PolicyVC.ccsi) {
                //[self alertForPolicyDetails];
				
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.personTypeLbl.text forKey:@"PersonType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.bankLbl.text forKey:@"IssuingBank"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.cardTypeLbl.text forKey:@"CardType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.accNoTF.text forKey:@"CardAccNo"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.expiryDateTF.text forKey:@"MonthExpiryDate"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.expiryDateYearTF.text forKey:@"YearExpiryDate"];
                NSString *cardExpDate = [NSString stringWithFormat:@"%@ %@",_PolicyVC.expiryDateTF.text, _PolicyVC.expiryDateYearTF.text];
                [[obj.eAppData objectForKey:@"SecB"] setValue:cardExpDate forKey:@"CardExpDate"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.memberNameTF.text forKey:@"MemberName"];
                if (_PolicyVC.memberSexSC.selectedSegmentIndex == 0) {
                    [[obj.eAppData objectForKey:@"SecB"] setValue:@"M" forKey:@"MemberSex"];
                }
                else {
                    [[obj.eAppData objectForKey:@"SecB"] setValue:@"F" forKey:@"MemberSex"];
                }
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.memberDOBLbl.text forKey:@"MemberDOB"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.memberIC.text forKey:@"MemberIC"];
                //[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.memberOtherIDTypeLbl.text forKey:@"MemberOtherIDType"];
				[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.IDTypeCodeSelected forKey:@"MemberOtherIDType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.memberOtherIDTF.text forKey:@"MemberOtherID"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:[NSString stringWithFormat:@"%@ %@", _PolicyVC.memberContactNoPrefixCF.text ,_PolicyVC.memberContactNoTF.text] forKey:@"MemberContactNo"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.memberRelationshipLbl.text forKey:@"MemberRelationship"];
            }
			//NSLog(@"%@", _PolicyVC.recurPaymentLbl.text);
			if ([_PolicyVC.recurPaymentLbl.text isEqualToString:@"Cash / Cheque"]) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"PersonType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"IssuingBank"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"CardType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"CardAccNo"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"MonthExpiryDate"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"YearExpiryDate"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"CardExpDate"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"MemberName"];
				
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"MemberSex"];
                
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"MemberDOB"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"MemberIC"];
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"MemberOtherIDType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"MemberOtherID"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"MemberContactNo"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"MemberRelationship"];
				
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"SameAsFT"];
				
			}
			
			
			if (_PolicyVC.FTccsi) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTpersonTypeLbl.text forKey:@"FTPersonType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTbankLbl.text forKey:@"FTIssuingBank"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTcardTypeLbl.text forKey:@"FTCardType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTaccNoTF.text forKey:@"FTCardAccNo"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTexpiryDateTF.text forKey:@"FTMonthExpiryDate"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTexpiryDateYearTF.text forKey:@"FTYearExpiryDate"];
                NSString *FTcardExpDate = [NSString stringWithFormat:@"%@ %@",_PolicyVC.FTexpiryDateTF.text, _PolicyVC.FTexpiryDateYearTF.text];
                [[obj.eAppData objectForKey:@"SecB"] setValue:FTcardExpDate forKey:@"FTCardExpDate"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTmemberNameTF.text forKey:@"FTMemberName"];
                if (_PolicyVC.memberSexSC.selectedSegmentIndex == 0) {
                    [[obj.eAppData objectForKey:@"SecB"] setValue:@"M" forKey:@"FTMemberSex"];
                }
                else {
                    [[obj.eAppData objectForKey:@"SecB"] setValue:@"F" forKey:@"FTMemberSex"];
                }
                //                if (_PolicyVC.EPPSC.selectedSegmentIndex == 0) {
                //                    [[obj.eAppData objectForKey:@"SecB"] setValue:@"Y" forKey:@"EPP"];
                //                }
                //                else {
                //                    [[obj.eAppData objectForKey:@"SecB"] setValue:@"N" forKey:@"EPP"];
                //                }
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTmemberDOBLbl.text forKey:@"FTMemberDOB"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTmemberIC.text forKey:@"FTMemberIC"];
                //[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTmemberOtherIDTypeLbl.text forKey:@"MFTemberOtherIDType"];
				[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTIDTypeCodeSelected forKey:@"FTMemberOtherIDType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTmemberOtherIDTF.text forKey:@"FTMemberOtherID"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:[NSString stringWithFormat:@"%@ %@", _PolicyVC.FTmemberContactNoPrefixCF.text ,_PolicyVC.FTmemberContactNoTF.text] forKey:@"FTMemberContactNo"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTmemberRelationshipLbl.text forKey:@"FTMemberRelationship"];
			}
			
			if ([_PolicyVC.firstTimePaymentLbl.text isEqualToString:@"Cash / Cheque"]) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTPersonType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTIssuingBank"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTCardType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTCardAccNo"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTMonthExpiryDate"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTYearExpiryDate"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTCardExpDate"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTMemberName"];
                
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTMemberSex"];
                
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTMemberDOB"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTMemberIC"];
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTMemberOtherIDType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTMemberOtherID"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTMemberContactNo"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTMemberRelationship"];
				
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"SameAsFT"];
				
			}
			
            //        else{
            //		[self alertForPolicyDetails];
            if (_PolicyVC.paymentModeSC.selectedSegmentIndex == 0) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"Annual" forKey:@"PaymentMode"];
			}
			else if (_PolicyVC.paymentModeSC.selectedSegmentIndex == 1) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"SemiAnnual" forKey:@"PaymentMode"];
			}
			else if (_PolicyVC.paymentModeSC.selectedSegmentIndex == 2) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"Quarterly" forKey:@"PaymentMode"];
			}
			else if (_PolicyVC.paymentModeSC.selectedSegmentIndex == 3) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"Monthly" forKey:@"PaymentMode"];
			}
			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.basicPlanLbl.text forKey:@"BasicPlan"];
			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.termLbl.text forKey:@"Term"];
			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.sumAssuredLbl.text forKey:@"SumAssured"];
            //			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.basicPremLbl.text forKey:@"BasicPremium"];
			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.totalPremLbl.text forKey:@"TotalPremium"];
			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.basicUnitAccLbl.text forKey:@"BasicUnitAcc"];
			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.riderUnitAccLbl.text forKey:@"RiderUnitAcc"];
			
			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.srvTaxLbl.text forKey:@"TotalGSTAmt"];
			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.totalPremTaxLbl.text forKey:@"TotalPayableAmt"];
            
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.firstTimePaymentLbl.text forKey:@"FirstTimePayment"];
			if (_PolicyVC.deductSC.selectedSegmentIndex == 0) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"Yes" forKey:@"FirstPaymentDeduct"];
			}
			else if (_PolicyVC.deductSC.selectedSegmentIndex == 1) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"No" forKey:@"FirstPaymentDeduct"];
			}
            //EPP
            if (_PolicyVC.EPPSC.selectedSegmentIndex == 0) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"Y" forKey:@"EPP"];
			}
			else if (_PolicyVC.EPPSC.selectedSegmentIndex == 1) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"N" forKey:@"EPP"];
			}
            else
            {
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"EPP"];
            }
            
            if ([_PolicyVC.firstTimePaymentLbl.text isEqualToString:@"Cash / Cheque"]) {
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FirstPaymentDeduct"];
            }
            
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.recurPaymentLbl.text forKey:@"RecurringPayment"];
            
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.agentCodeTF.text forKey:@"AgentCode"];
            if (_PolicyVC.agentContactNoPrefixTF.text.length == 0) {
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.agentContactNoTF.text forKey:@"AgentContactNo"];
            }
            else {
                NSString *contact = [NSString stringWithFormat:@"%@ %@", _PolicyVC.agentContactNoPrefixTF.text, _PolicyVC.agentContactNoTF.text];
                [[obj.eAppData objectForKey:@"SecB"] setValue:contact forKey:@"AgentContactNo"];
            }
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.agentNameTF.text forKey:@"AgentName"];
            
            
            //		}
			
			if (_PolicyVC.paidUpOptionSC.selectedSegmentIndex == 0) {
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"Y" forKey:@"PaidUpOption"];
			}
			else if (_PolicyVC.paidUpOptionSC.selectedSegmentIndex == 1) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"N" forKey:@"PaidUpOption"];
			}
			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.paidUpTermLbl.text forKey:@"PaidUpTerm"];
			if (_PolicyVC.sumAssuredSC.selectedSegmentIndex == 0) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"Y" forKey:@"RevisedSumAssured"];
			}
			else if (_PolicyVC.sumAssuredSC.selectedSegmentIndex == 1) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"N" forKey:@"RevisedSumAssured"];
			}
			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.revisedAmountLbl.text forKey:@"RevisedAmount"];
            
            
            //  [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.TckbuttonPolicyBankDetails forKey:@"isDirectCredit"];
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.TickMArkValue forKey:@"isDirectCredit"];
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.DCBankName.text forKey:@"DCBank"];
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.DCAccountType.text forKey:@"DCAccountType"];
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.DCAccNo.text forKey:@"DCAccNo"];
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.PayeeType.text forKey:@"DCPayeeType"];
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.DCNewIcNo.text forKey:@"DCNewICNo"];
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.OtherIDTypeDc.text forKey:@"DCOtherIDType"];
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.OtherIDDC.text forKey:@"DCOtherID"];
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.emailDC.text forKey:@"DCEmail"];
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.mobileNoDC.text forKey:@"DCMobile"];
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.mobileNoPrefixDC.text forKey:@"DCMobilePrefix"];
            
            [self validSecB];
            
            
            
            
            //            @synthesize TckbuttonPolicyBankDetails;
            //            @synthesize DCBankName;
            //            @synthesize DCAccountType;
            //            @synthesize DCAccNo;
            //            @synthesize PayeeType;
            //            @synthesize DCNewIcNo;
            //            @synthesize OtherIDTypeDc;
            //            @synthesize OtherIDDC;
            //            @synthesize emailDC;
            //            @synthesize mobileNoPrefixDC;
            //            @synthesize mobileNoDC;
            
            
            
            
            
            
            
            
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3002];
            imageView.hidden = FALSE;
            imageView = nil;
            
            UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9002];
            imageView1.hidden = TRUE;
            imageView1 = nil;
            
            //[Utility showAllert:@"Record saved successfully."];
            
            [[obj.eAppData objectForKey:@"SecB"] setValue:@"Y" forKey:@"SecB_Saved"];
            _SummaryVC.tickPolicyDetails.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
            _SummaryVC.tickPolicyDetails.text =  @"✓";
            
            
            [self saveEApp];
            // [self deletePDFs];
        }
        //	}
        
        
    }
	else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionC"]) {
        if ([self validSecC]){
            [[obj.eAppData objectForKey:@"SecC"] setValue:_part4.personTypeLbl.text forKey:@"PersonType"];
            
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3003];
            imageView.hidden = FALSE;
            imageView = nil;
            
            //[Utility showAllert:@"Record saved successfully."];
            
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"SecC_Saved"];
			if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"SecC_Saved"] isEqualToString:@"Y"]) {
                
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3003];
                imageView.hidden = FALSE;
                imageView = nil;
                
                UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9003];
                imageView1.hidden = TRUE;
                imageView1 = nil;
                
                
                self.SummaryVC.tickeCFF.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
				self.SummaryVC.tickeCFF.text =  @"✓";
                
                
			}
            [self saveEApp];
            // [self deletePDFs];
 		}
        else {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"SecC_Saved"];
        }
        //	}
        //	else {
        //		[Utility showAllert:@"Please complete Policy Details section first."];
        //	}
	}
	else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionD"]) {
        
        if ([self validSecD]){
			
			if ((![_NomineesVC.Nominee1Lbl.text isEqualToString:@"Add Nominee (1)"]) || (![_NomineesVC.Nominee2Lbl.text isEqualToString:@"Add Nominee (2)"]) || (![_NomineesVC.Nominee3Lbl.text isEqualToString:@"Add Nominee (3)"]) || (![_NomineesVC.Nominee4Lbl.text isEqualToString:@"Add Nominee (4)"])) {
				UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3004];
				imageView.hidden = FALSE;
				imageView = nil;
                
                UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9004];
				imageView1.hidden = TRUE;
				imageView1 = nil;
                
                
				//[Utility showAllert:@"Record saved successfully."];
                
				[[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"SecD_Saved"];
				_SummaryVC.tickNominees.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
				_SummaryVC.tickNominees.text =  @"✓";
			}
			else
            {
                
                UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9004];
				imageView1.hidden = FALSE;
				imageView1 = nil;
                
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3004];
				imageView.hidden = TRUE;
				imageView = nil;
                
				
				[[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"SecD_Saved"];
				_SummaryVC.tickNominees.font = [UIFont fontWithName:@"Helvetica" size:24];
				_SummaryVC.tickNominees.text =  @"NA";
			}
            
            [self saveEApp];
            // [self deletePDFs];
 		}
	}
	else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionE"]) {
        
        NSString* LA1height = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_height"];
		NSString* LA1weight = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_weight"];
		NSString* LA2height = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_height"];
		NSString* LA2weight = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_weight"];
		NSString* POheight = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_height"];
		NSString* POweight = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_weight"];
		
		
        if (_HealthQuestionsVC.personTypeLbl.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please select Person Type." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = nil;
        }
		else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"1st Life Assured"] && (LA1height.length > 0 && [LA1height intValue] <= 0)) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Height and weight must be greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//[_HealthQuestions1stLA.txtHeight becomeFirstResponder];
			alert.tag = 80001;
            [alert show];
            alert = nil;
		}
		else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"1st Life Assured"] && LA1weight.length > 0 && [LA1weight intValue] <= 0) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Height and weight must be greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 80002;
            [alert show];
            alert = nil;
		}
		else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"1st Life Assured"] && (!LA1height.length > 0 || !LA1weight.length > 0)) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all questions" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 80001;
            [alert show];
            alert = nil;
		}
		else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"2nd Life Assured"] && (LA2height.length > 0 && [LA2height intValue] <= 0)) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Height and weight must be greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[_HealthQuestions1stLA.txtHeight becomeFirstResponder];
            alert.tag = 80001;
            [alert show];
            alert = nil;
		}
		else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"2nd Life Assured"] && LA2weight.length > 0 && [LA2weight intValue] <= 0) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Height and weight must be greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 80002;
            [alert show];
            alert = nil;
		}
		else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"2nd Life Assured"] && (!LA2height.length > 0 || !LA2weight.length > 0)) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all questions" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 80001;
            [alert show];
            alert = nil;
		}
		else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"Payor"] && (POheight.length > 0 && [POheight intValue] <= 0)) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Height and weight must be greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[_HealthQuestions1stLA.txtHeight becomeFirstResponder];
            alert.tag = 80001;
            [alert show];
            alert = nil;
		}
		else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"Payor"] && POweight.length > 0 && [POweight intValue] <= 0) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Height and weight must be greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 80002;
            [alert show];
            alert = nil;
		}
		else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"Payor"] && (!POheight.length > 0 || !POweight.length > 0)) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all questions" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 80001;
            [alert show];
            alert = nil;
		}
		/*else if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_Q1B"] isEqualToString:@"Y"] && ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"Q1"] isEqualToString:@""]))
         {
         UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 1B." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alert show];
         }*/
		else if ([self EmptyAnswer])
        {
            //            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            //            imageView.hidden = FALSE;
            //            imageView = nil;
            
            //            UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9005];
            //            imageView1.hidden = TRUE;
            //            imageView1 = nil;
            
		}
        else if ([self validSecE]){
            
            //            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            //            imageView.hidden = FALSE;
            //            imageView = nil;
            //
            //            UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9005];
            //            imageView1.hidden = TRUE;
            //            imageView1 = nil;
            
            //[Utility showAllert:@"Record saved successfully."];
            
            [self saveEApp];
            
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all questions" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = nil;
        }
        
        
        
        
        //        UIAlertView *alert = [[UIAlertView alloc]
        //                              initWithTitle: @" "
        //                              message: alertMsg
        //                              delegate: self
        //                              cancelButtonTitle:@"Yes"
        //                              otherButtonTitles:@"No", nil];
        //
        //
        //        [alert setTag:1002];
        //        [alert show];
        //        alert = Nil;
        
        
        
	}
	else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionF"]) {
		if ([self validSecF])
        {
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3006];
            imageView.hidden = FALSE;
            imageView = nil;
            
            UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9006];
            imageView1.hidden = TRUE;
            imageView1 = nil;
            
            
            //[Utility showAllert:@"Record saved successfully."];
            
            [[obj.eAppData objectForKey:@"SecF"] setValue:@"Y" forKey:@"SecF_Saved"];
            
            _SummaryVC.tickAdditionalQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
            _SummaryVC.tickAdditionalQuestions.text =  @"✓";
            [self saveEApp];
            //  [self deletePDFs];
            
		}
	}
	else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionG"]) {
		if ([self validSecG]){
			
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3007];
            imageView.hidden = FALSE;
            imageView = nil;
            
            UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9007];
            imageView1.hidden = TRUE;
            imageView1 = nil;
            
            //[Utility showAllert:@"Record saved successfully."];
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"Y" forKey:@"SecG_Saved"];
            _SummaryVC.tickDeclaration.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
            _SummaryVC.tickDeclaration.text = @"✓";
            [self saveEApp];
            // [self deletePDFs];
            
		}
	}
	else {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message: alertMsg
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert setTag:1001];
        [alert show];
        alert = Nil;
	}
    //	[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickPart2"];
	//Record saved successfully.
}

- (BOOL) DoDone2 {
	[self hideKeyboard];
	//BOOL Succeed = YES;
	if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionA"]) {
		if (_eAppPersonalDataVC.p2) {
            if ([self alertForPersonalDetails]) {
                [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"TickPart2"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.TitleCodeSelected forKey:@"Title"];
                if (_eAppPersonalDataVC.sexSC.selectedSegmentIndex == 0) {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:@"M" forKey:@"Sex"];
                }
                else {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:@"F" forKey:@"Sex"];
                }
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.fullNameTF.text forKey:@"FullName"];
                if (_eAppPersonalDataVC.telNoTF.text.length != 0 && _eAppPersonalDataVC.telPhoneNoPrefixTF.text.length != 0)
                {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:[NSString stringWithFormat:@"%@ %@", _eAppPersonalDataVC.telPhoneNoPrefixTF.text ,_eAppPersonalDataVC.telNoTF.text]forKey:@"TelNo"];
                    //NSLog(@"EEE: telNo: %@", [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TelNo"]);
                }
                else
                {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:@"" forKey:@"TelNo"];
                }
                
                if (_eAppPersonalDataVC.mobilePrefixTF.text.length != 0 && _eAppPersonalDataVC.mobileTF.text.length != 0) {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:[NSString stringWithFormat:@"%@ %@", _eAppPersonalDataVC.mobilePrefixTF.text, _eAppPersonalDataVC.mobileTF.text] forKey:@"MobileNo"];
                }
                else {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:@"" forKey:@"MobileNo"];
                }
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.icNoTF.text forKey:@"ICNo"];
                
                
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.DOBLbl.text forKey:@"DOB"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.emailTF.text forKey:@"Email"];
                
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.NationalityLbl.text forKey:@"Nationality"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.OccupationLbl.text forKey:@"Occupation"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.nameOfEmployerTF.text forKey:@"NameOfEmployer"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.exactNatureOfWorkTF.text forKey:@"ExactNatureOfWork"];
                
                //[[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.OtherIDLbl.text forKey:@"OtherIDType"];
				[[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.IDTypeCodeSelected forKey:@"OtherIDType"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.otherIDTF.text forKey:@"OtherID"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.RelationshipLbl.text forKey:@"Relationship"];
                if (_eAppPersonalDataVC.sa) {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"SameAddress"];
                }
                else {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"SameAddress"];
                }
                if (_eAppPersonalDataVC.fa) {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"ForeignAddress"];
                }
                else {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"ForeignAddress"];
                }
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.addressTF.text forKey:@"Address1"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.address2TF.text forKey:@"Address2"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.address3TF.text forKey:@"Address3"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.postcodeTF.text forKey:@"Postcode"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.townTF.text forKey:@"Town"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.stateLbl.text forKey:@"State"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.countryLbl.text forKey:@"Country"];
                
                if (_eAppPersonalDataVC.CRfa) {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"CRForeignAddress"];
                }
                else {
                    [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"CRForeignAddress"];
                }
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.CRaddressTF.text forKey:@"CRAddress1"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.CRaddress2TF.text forKey:@"CRAddress2"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.CRaddress3TF.text forKey:@"CRAddress3"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.CRpostcodeTF.text forKey:@"CRPostcode"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.CRtownTF.text forKey:@"CRTown"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.CRstateLbl.text forKey:@"CRState"];
                [[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.CRcountryLbl.text forKey:@"CRCountry"];
                
                
            }
            else {
                return NO;
            }
        }
        else {
            [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickPart2"];
        }
        
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3001];
        imageView.hidden = FALSE;
        imageView = nil;
        
        UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9001];
        imageView1.hidden = TRUE;
        imageView1 = nil;
        
        [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"SecA_Saved"];
        
        _SummaryVC.tickPersonalDetails.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        _SummaryVC.tickPersonalDetails.text =  @"✓";
		
        
        [self saveEApp];
		
	}
	else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionB"]) {
        if ([self validSecB]){
            
            if (_PolicyVC.ccsi) {
                //[self alertForPolicyDetails];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.personTypeLbl.text forKey:@"PersonType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.bankLbl.text forKey:@"IssuingBank"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.cardTypeLbl.text forKey:@"CardType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.accNoTF.text forKey:@"CardAccNo"];
                //            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.expiryDateTF.text forKey:@"MonthExpiryDate"];
                //            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.expiryDateYearTF.text forKey:@"YearExpiryDate"];
                NSString *cardExpDate = [NSString stringWithFormat:@"%@ %@",_PolicyVC.expiryDateTF.text, _PolicyVC.expiryDateYearTF.text];
                [[obj.eAppData objectForKey:@"SecB"] setValue:cardExpDate forKey:@"CardExpDate"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.memberNameTF.text forKey:@"MemberName"];
                if (_PolicyVC.memberSexSC.selectedSegmentIndex == 0) {
                    [[obj.eAppData objectForKey:@"SecB"] setValue:@"M" forKey:@"MemberSex"];
                }
                else {
                    [[obj.eAppData objectForKey:@"SecB"] setValue:@"F" forKey:@"MemberSex"];
                }
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.memberDOBLbl.text forKey:@"MemberDOB"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.memberIC.text forKey:@"MemberIC"];
                //[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.memberOtherIDTypeLbl.text forKey:@"MemberOtherIDType"];
				[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.IDTypeCodeSelected forKey:@"MemberOtherIDType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.memberOtherIDTF.text forKey:@"MemberOtherID"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:[NSString stringWithFormat:@"%@ %@", _PolicyVC.memberContactNoPrefixCF.text ,_PolicyVC.memberContactNoTF.text] forKey:@"MemberContactNo"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.memberRelationshipLbl.text forKey:@"MemberRelationship"];
            }
			
			if ([_PolicyVC.recurPaymentLbl.text isEqualToString:@"Cash / Cheque"]) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"PersonType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"IssuingBank"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"CardType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"CardAccNo"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"MonthExpiryDate"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"YearExpiryDate"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"CardExpDate"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"MemberName"];
				
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"MemberSex"];
                
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"MemberDOB"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"MemberIC"];
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"MemberOtherIDType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"MemberOtherID"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"MemberContactNo"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"MemberRelationship"];
				
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"SameAsFT"];
				
			}
			
			
			if (_PolicyVC.FTccsi) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTpersonTypeLbl.text forKey:@"FTPersonType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTbankLbl.text forKey:@"FTIssuingBank"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTcardTypeLbl.text forKey:@"FTCardType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTaccNoTF.text forKey:@"FTCardAccNo"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTexpiryDateTF.text forKey:@"FTMonthExpiryDate"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTexpiryDateYearTF.text forKey:@"FTYearExpiryDate"];
                NSString *FTcardExpDate = [NSString stringWithFormat:@"%@ %@",_PolicyVC.FTexpiryDateTF.text, _PolicyVC.FTexpiryDateYearTF.text];
                [[obj.eAppData objectForKey:@"SecB"] setValue:FTcardExpDate forKey:@"FTCardExpDate"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTmemberNameTF.text forKey:@"FTMemberName"];
                if (_PolicyVC.memberSexSC.selectedSegmentIndex == 0) {
                    [[obj.eAppData objectForKey:@"SecB"] setValue:@"M" forKey:@"FTMemberSex"];
                }
                else {
                    [[obj.eAppData objectForKey:@"SecB"] setValue:@"F" forKey:@"FTMemberSex"];
                }
				//                if (_PolicyVC.EPPSC.selectedSegmentIndex == 0) {
				//                    [[obj.eAppData objectForKey:@"SecB"] setValue:@"Y" forKey:@"EPP"];
				//                }
				//                else {
				//                    [[obj.eAppData objectForKey:@"SecB"] setValue:@"N" forKey:@"EPP"];
				//                }
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTmemberDOBLbl.text forKey:@"FTMemberDOB"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTmemberIC.text forKey:@"FTMemberIC"];
                //[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTmemberOtherIDTypeLbl.text forKey:@"MFTemberOtherIDType"];
				[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTIDTypeCodeSelected forKey:@"FTMemberOtherIDType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTmemberOtherIDTF.text forKey:@"FTMemberOtherID"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:[NSString stringWithFormat:@"%@ %@", _PolicyVC.FTmemberContactNoPrefixCF.text ,_PolicyVC.FTmemberContactNoTF.text] forKey:@"FTMemberContactNo"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.FTmemberRelationshipLbl.text forKey:@"FTMemberRelationship"];
			}
			
			if ([_PolicyVC.firstTimePaymentLbl.text isEqualToString:@"Cash / Cheque"]) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTPersonType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTIssuingBank"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTCardType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTCardAccNo"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTMonthExpiryDate"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTYearExpiryDate"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTCardExpDate"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTMemberName"];
				
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTMemberSex"];
                
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTMemberDOB"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTMemberIC"];
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTMemberOtherIDType"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTMemberOtherID"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTMemberContactNo"];
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"FTMemberRelationship"];
				
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"SameAsFT"];
				
			}
			
			
			
            //        else{
            //		[self alertForPolicyDetails];
            if (_PolicyVC.paymentModeSC.selectedSegmentIndex == 0) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"Annual" forKey:@"PaymentMode"];
			}
			else if (_PolicyVC.paymentModeSC.selectedSegmentIndex == 1) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"SemiAnnual" forKey:@"PaymentMode"];
			}
			else if (_PolicyVC.paymentModeSC.selectedSegmentIndex == 2) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"Quarterly" forKey:@"PaymentMode"];
			}
			else if (_PolicyVC.paymentModeSC.selectedSegmentIndex == 3) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"Monthly" forKey:@"PaymentMode"];
			}
			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.basicPlanLbl.text forKey:@"BasicPlan"];
			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.termLbl.text forKey:@"Term"];
			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.sumAssuredLbl.text forKey:@"SumAssured"];
            //			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.basicPremLbl.text forKey:@"BasicPremium"];
			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.totalPremLbl.text forKey:@"TotalPremium"];
			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.basicUnitAccLbl.text forKey:@"BasicUnitAcc"];
			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.riderUnitAccLbl.text forKey:@"RiderUnitAcc"];
			
			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.srvTaxLbl.text forKey:@"TotalGSTAmt"];
			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.totalPremTaxLbl.text forKey:@"TotalPayableAmt"];
            
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.firstTimePaymentLbl.text forKey:@"FirstTimePayment"];
			if (_PolicyVC.deductSC.selectedSegmentIndex == 0) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"Yes" forKey:@"FirstPaymentDeduct"];
			}
			else if (_PolicyVC.deductSC.selectedSegmentIndex == 1) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"No" forKey:@"FirstPaymentDeduct"];
			}
            
			
			//EPP
            if (_PolicyVC.EPPSC.selectedSegmentIndex == 0) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"Y" forKey:@"EPP"];
			}
			else if (_PolicyVC.EPPSC.selectedSegmentIndex == 1) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"N" forKey:@"EPP"];
			}
            else
            {
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"" forKey:@"EPP"];
            }
			
			
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.recurPaymentLbl.text forKey:@"RecurringPayment"];
            
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.agentCodeTF.text forKey:@"AgentCode"];
            if (_PolicyVC.agentContactNoPrefixTF.text.length == 0) {
                [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.agentContactNoTF.text forKey:@"AgentContactNo"];
            }
            else {
                NSString *contact = [NSString stringWithFormat:@"%@ %@", _PolicyVC.agentContactNoPrefixTF.text, _PolicyVC.agentContactNoTF.text];
                [[obj.eAppData objectForKey:@"SecB"] setValue:contact forKey:@"AgentContactNo"];
            }
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.agentNameTF.text forKey:@"AgentName"];
            
            
            //		}
			
			if (_PolicyVC.paidUpOptionSC.selectedSegmentIndex == 0) {
                [[obj.eAppData objectForKey:@"SecB"] setValue:@"Y" forKey:@"PaidUpOption"];
			}
			else if (_PolicyVC.paidUpOptionSC.selectedSegmentIndex == 1) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"N" forKey:@"PaidUpOption"];
			}
			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.paidUpTermLbl.text forKey:@"PaidUpTerm"];
			if (_PolicyVC.sumAssuredSC.selectedSegmentIndex == 0) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"Y" forKey:@"RevisedSumAssured"];
			}
			else if (_PolicyVC.sumAssuredSC.selectedSegmentIndex == 1) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"N" forKey:@"RevisedSumAssured"];
			}
			[[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.revisedAmountLbl.text forKey:@"RevisedAmount"];
            
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3002];
            imageView.hidden = FALSE;
            imageView = nil;
            
            UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9002];
            imageView1.hidden = TRUE;
            imageView1 = nil;
            
            //[Utility showAllert:@"Record saved successfully."];
            
            [[obj.eAppData objectForKey:@"SecB"] setValue:@"Y" forKey:@"SecB_Saved"];
            _SummaryVC.tickPolicyDetails.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
            _SummaryVC.tickPolicyDetails.text =  @"✓";
            
            
            [self saveEApp];
        }
		else {
			return NO;
		}
        //	}
        
        
    }
	else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionC"]) {
        if ([self validSecC]){
            [[obj.eAppData objectForKey:@"SecC"] setValue:_part4.personTypeLbl.text forKey:@"PersonType"];
            
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3003];
            imageView.hidden = FALSE;
            imageView = nil;
            
            //[Utility showAllert:@"Record saved successfully."];
            
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"SecC_Saved"];
			if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"SecC_Saved"] isEqualToString:@"Y"]) {
                
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3003];
                imageView.hidden = FALSE;
                imageView = nil;
                
                UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9003];
                imageView1.hidden = TRUE;
                imageView1 = nil;
                
                
                self.SummaryVC.tickeCFF.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
				self.SummaryVC.tickeCFF.text =  @"✓";
                
                
			}
            [self saveEApp];
 		}
        else {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"SecC_Saved"];
			return NO;
        }
	}
	else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionD"]) {
        
        if ([self validSecD]){
			
			if ((![_NomineesVC.Nominee1Lbl.text isEqualToString:@"Add Nominee (1)"]) || (![_NomineesVC.Nominee2Lbl.text isEqualToString:@"Add Nominee (2)"]) || (![_NomineesVC.Nominee3Lbl.text isEqualToString:@"Add Nominee (3)"]) || (![_NomineesVC.Nominee4Lbl.text isEqualToString:@"Add Nominee (4)"])) {
				UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3004];
				imageView.hidden = FALSE;
				imageView = nil;
                
                UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9004];
				imageView1.hidden = TRUE;
				imageView1 = nil;
                
                
				//[Utility showAllert:@"Record saved successfully."];
                
				[[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"SecD_Saved"];
				_SummaryVC.tickNominees.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
				_SummaryVC.tickNominees.text =  @"✓";
			}
			else
            {
                
                UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9004];
				imageView1.hidden = FALSE;
				imageView1 = nil;
                
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3004];
				imageView.hidden = TRUE;
				imageView = nil;
                
				
				[[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"SecD_Saved"];
				_SummaryVC.tickNominees.font = [UIFont fontWithName:@"Helvetica" size:24];
				_SummaryVC.tickNominees.text =  @"NA";
			}
            
            [self saveEApp];
 		}
		else
			return NO;
	}
	else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionE"]) {
        
        NSString* LA1height = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_height"];
		NSString* LA1weight = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_weight"];
		NSString* LA2height = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_height"];
		NSString* LA2weight = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_weight"];
		NSString* POheight = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_height"];
		NSString* POweight = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_weight"];
		
		
        if (_HealthQuestionsVC.personTypeLbl.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please select Person Type." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = nil;
			return NO;
        }
		else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"1st Life Assured"] && (LA1height.length > 0 && [LA1height intValue] <= 0)) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Height and weight must be greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//[_HealthQuestions1stLA.txtHeight becomeFirstResponder];
			alert.tag = 80001;
            [alert show];
            alert = nil;
			return NO;
		}
		else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"1st Life Assured"] && LA1weight.length > 0 && [LA1weight intValue] <= 0) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Height and weight must be greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 80002;
            [alert show];
            alert = nil;
			return NO;
		}
		else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"1st Life Assured"] && (!LA1height.length > 0 || !LA1weight.length > 0)) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all questions" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 80001;
            [alert show];
            alert = nil;
			return NO;
		}
		else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"2nd Life Assured"] && (LA2height.length > 0 && [LA2height intValue] <= 0)) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Height and weight must be greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[_HealthQuestions1stLA.txtHeight becomeFirstResponder];
            alert.tag = 80001;
            [alert show];
            alert = nil;
			return NO;
		}
		else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"2nd Life Assured"] && LA2weight.length > 0 && [LA2weight intValue] <= 0) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Height and weight must be greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 80002;
            [alert show];
            alert = nil;
			return NO;
		}
		else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"2nd Life Assured"] && (!LA2height.length > 0 || !LA2weight.length > 0)) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all questions" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 80001;
            [alert show];
            alert = nil;
			return NO;
		}
		else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"Payor"] && (POheight.length > 0 && [POheight intValue] <= 0)) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Height and weight must be greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[_HealthQuestions1stLA.txtHeight becomeFirstResponder];
            alert.tag = 80001;
            [alert show];
            alert = nil;
			return NO;
		}
		else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"Payor"] && POweight.length > 0 && [POweight intValue] <= 0) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Height and weight must be greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 80002;
            [alert show];
            alert = nil;
			return NO;
		}
		else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"Payor"] && (!POheight.length > 0 || !POweight.length > 0)) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all questions" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 80001;
            [alert show];
            alert = nil;
			return NO;
		}
		else if ([self EmptyAnswer]){
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
            
            UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9005];
            imageView1.hidden = TRUE;
            imageView1 = nil;
            return NO;
		}
        else if ([self validSecE]){
            
            //            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            //            imageView.hidden = FALSE;
            //            imageView = nil;
            //
            //            UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9005];
            //            imageView1.hidden = TRUE;
            //            imageView1 = nil;
            
            
            //[Utility showAllert:@"Record saved successfully."];
            
            [self saveEApp];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all questions" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = nil;
			return NO;
        }
        
	}
	else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionF"]) {
		if ([self validSecF])
        {
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3006];
            imageView.hidden = FALSE;
            imageView = nil;
            
            UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9006];
            imageView1.hidden = TRUE;
            imageView1 = nil;
            
            
            [[obj.eAppData objectForKey:@"SecF"] setValue:@"Y" forKey:@"SecF_Saved"];
            
            _SummaryVC.tickAdditionalQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
            _SummaryVC.tickAdditionalQuestions.text =  @"✓";
            [self saveEApp];
            
		}
		else {
			return NO;
		}
	}
	else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionG"]) {
		if ([self validSecG]){
			
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3007];
            imageView.hidden = FALSE;
            imageView = nil;
            
            UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9007];
            imageView1.hidden = TRUE;
            imageView1 = nil;
            
            //[Utility showAllert:@"Record saved successfully."];
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"Y" forKey:@"SecG_Saved"];
            _SummaryVC.tickDeclaration.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
            _SummaryVC.tickDeclaration.text = @"✓";
            [self saveEApp];
		}
		else
			return NO;
	}
	else {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message: alertMsg
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert setTag:1001];
        [alert show];
        alert = Nil;
	}
	return YES;
}

- (BOOL)alertForPolicyDetails {
	//	NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
	//	[f setNumberStyle:NSNumberFormatterDecimalStyle];
	//	NSNumber *myNumber = [f numberFromString:nominees.sharePercentageTF.text];
	//
	//	NSNumberFormatter * f2 = [[NSNumberFormatter alloc] init];
	//	[f2 setNumberStyle:NSNumberFormatterDecimalStyle];
	//	NSNumber *myNumber2 = [f2 numberFromString:@"100"];
	
	/*if (_PolicyVC.personTypeLbl.text.length == 0) {
     UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"2 Person Type is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
     alert.tag = 100;
     [alert show];
     }*/
    
    //	if ([_PolicyVC.firstTimePaymentLbl.text isEqual:@"Credit Card"]) {
    //		if (![self alertForFTCreditCard])
    //			return FALSE;
    //
    //	}
	
    int currentYear;
    int currentMonth;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    currentYear = [[dateFormatter stringFromDate:[NSDate date]] intValue];
    [dateFormatter setDateFormat:@"MM"];
    currentMonth = [[dateFormatter stringFromDate:[NSDate date]] intValue];
    
    if (_PolicyVC.personTypeLbl.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Person Type for Recurring Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return FALSE;
    }
    else if (_PolicyVC.bankLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Issuing Bank for Recurring Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 200;
		[alert show];
        return FALSE;
	}
	else if (_PolicyVC.cardTypeLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Card Type for Recurring Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 300;
		[alert show];
        return FALSE;
	}
	else if (_PolicyVC.accNoTF.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Credit Card No. for Recurring Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 400;
		[alert show];
        return FALSE;
	}
    else if (![[_PolicyVC.accNoTF.text substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"4"] && ![[_PolicyVC.accNoTF.text substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"5"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid credit card no. for Recurring Payment." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 400;
        [alert show];
        return FALSE;
    }
	else if (_PolicyVC.accNoTF.text.length < 16) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Credit Card No. for Recurring Payment must be in 16 digits." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 400;
        [alert show];
        return FALSE;
    }
    else if ([[_PolicyVC.accNoTF.text substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"4"] && [_PolicyVC.cardTypeLbl.text rangeOfString:@"Visa" options:NSCaseInsensitiveSearch].location == NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Credit Card No. for Recurring Payment didn’t match with card type." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 400;
        [alert show];
        return FALSE;
    }
    else if ([[_PolicyVC.accNoTF.text substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"5"] && [_PolicyVC.cardTypeLbl.text rangeOfString:@"Master" options:NSCaseInsensitiveSearch].location == NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Credit Card No. for Recurring Payment didn’t match with card type." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 400;
        [alert show];
        return FALSE;
    }
	else if (_PolicyVC.expiryDateTF.text.length == 0 && _PolicyVC.expiryDateYearTF.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Card expiry date for Recurring Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 500;
		[alert show];
        return FALSE;
	}
	else if ([_PolicyVC.expiryDateTF.text intValue] > 12 || [_PolicyVC.expiryDateTF.text intValue] < 1){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid credit card expiry month format for Recurring Payment. Credit card expiry month must be between 1 to 12." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 500;
		[alert show];
        return FALSE;
    }
    else if ([_PolicyVC.expiryDateTF.text length] == 1){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid month format." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 500;
		[alert show];
        return FALSE;
    }
    
    else if ([_PolicyVC.expiryDateYearTF.text intValue] < currentYear) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Card expiry year for Recurring Payment must be greater than current year." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 501;
		[alert show];
        return FALSE;
    }
    else if ([_PolicyVC.expiryDateYearTF.text intValue] == currentYear && [_PolicyVC.expiryDateTF.text intValue] < currentMonth) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Credit Card for Recurring Payment is expired. Please use another credit card." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 500;
		[alert show];
        return FALSE;
    }
	
	//Other Payor start
	else if (_PolicyVC.op) {
        // Item for IC checking
        bool isMale = FALSE;
        NSString *strDOB;
        if (_PolicyVC.memberIC.text.length != 0 && _PolicyVC.memberIC.text.length == 12) {
            NSString *last = [_PolicyVC.memberIC.text substringFromIndex:[_PolicyVC.memberIC.text length] -1];
            NSCharacterSet *oddSet = [NSCharacterSet characterSetWithCharactersInString:@"13579"];
            
            if ([last rangeOfCharacterFromSet:oddSet].location != NSNotFound) {
                isMale = TRUE;
            } else {
                isMale = FALSE;
            }
            
            //get the DOB value from ic entered
            NSString *strDate = [_PolicyVC.memberIC.text substringWithRange:NSMakeRange(4, 2)];
            NSString *strMonth = [_PolicyVC.memberIC.text substringWithRange:NSMakeRange(2, 2)];
            NSString *strYear = [_PolicyVC.memberIC.text substringWithRange:NSMakeRange(0, 2)];
            
            //get value for year whether 20XX or 19XX
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy"];
            
            NSString *currentYear = [dateFormatter stringFromDate:[NSDate date]];
            NSString *strCurrentYear = [currentYear substringWithRange:NSMakeRange(2, 2)];
            if ([strYear intValue] > [strCurrentYear intValue] && !([strYear intValue] < 30)) {
                strYear = [NSString stringWithFormat:@"19%@",strYear];
            }
            else {
                strYear = [NSString stringWithFormat:@"20%@",strYear];
            }
            
            strDOB = [NSString stringWithFormat:@"%@/%@/%@",strDate,strMonth,strYear];
        }
        
        if ([textFields trimWhiteSpaces:_PolicyVC.memberNameTF.text].length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Cardholder’s Name for Recurring Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 601;
            [alert show];
            return FALSE;
        }
        else if ([textFields validateString:_PolicyVC.memberNameTF.text])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid name format. Same alphabet cannot be repeated more than three times." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 602;
            [alert show];
            return FALSE;
        }
        else if ([textFields validateString3:_PolicyVC.memberNameTF.text])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 602;
            [alert show];
            return FALSE;
        }
        else if ([textFields trimWhiteSpaces:_PolicyVC.memberIC.text].length == 0 && ([textFields trimWhiteSpaces:_PolicyVC.memberOtherIDTypeLbl.text].length == 0 || [_PolicyVC.memberOtherIDTypeLbl.text isEqualToString:@"- SELECT -"])) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Either New IC No. or Other ID of cardholder for Recurring Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 6051;
            [alert show];
            return FALSE;
        }
        
        // else if ((_PolicyVC.memberIC.text.length != 12) && ([textFields trimWhiteSpaces:_PolicyVC.memberOtherIDTypeLbl.text].length == 0) && (_PolicyVC.memberIC.text.length != 0))
        else if ((_PolicyVC.memberIC.text.length != 12) && (_PolicyVC.memberIC.text.length != 0)){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No must be 12 digits characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 6051;
            [alert show];
            return FALSE;
        }
        
        else if ([textFields trimWhiteSpaces:_PolicyVC.memberIC.text].length != 0 && [textFields trimWhiteSpaces:_PolicyVC.memberIC.text].length == 12) {
            //CHECK DAY / MONTH / YEAR START
            //get the DOB value from ic entered
            NSString *strDate = [_PolicyVC.memberIC.text substringWithRange:NSMakeRange(4, 2)];
            NSString *strMonth = [_PolicyVC.memberIC.text substringWithRange:NSMakeRange(2, 2)];
            NSString *strYear = [_PolicyVC.memberIC.text substringWithRange:NSMakeRange(0, 2)];
            
            //get value for year whether 20XX or 19XX
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy"];
            
            NSString *currentYear = [dateFormatter stringFromDate:[NSDate date]];
            NSString *strCurrentYear = [currentYear substringWithRange:NSMakeRange(2, 2)];
            if ([strYear intValue] > [strCurrentYear intValue] && !([strYear intValue] < 30)) {
                strYear = [NSString stringWithFormat:@"19%@",strYear];
            }
            else {
                strYear = [NSString stringWithFormat:@"20%@",strYear];
            }
            
            NSString *strDOB2 = [NSString stringWithFormat:@"%@-%@-%@",strYear,strMonth,strDate];
            
            //determine day of february
            NSString *febStatus = nil;
            float devideYear = [strYear floatValue]/4;
            int devideYear2 = devideYear;
            float minus = devideYear - devideYear2;
            if (minus > 0) {
                febStatus = @"Normal";
            }
            else {
                febStatus = @"Jump";
            }
            
            //compare year is valid or not
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *d = [NSDate date];
            NSDate *d2 = [dateFormatter dateFromString:strDOB2];
            
            if ([d compare:d2] == NSOrderedAscending) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                alert.tag = 300;
                [alert show];
                
                return false;
            }
            else if ([strMonth intValue] > 12 || [strMonth intValue] < 1) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC month must be between 1 and 12." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                alert.tag = 300;
                [alert show];
                
                return false;
            }
            else if([strDate intValue] < 1 || [strDate intValue] > 31)
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC day must be between 1 and 31." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                alert.tag = 300;
                [alert show];
                
                return false;
                
            }
            else if (([strMonth isEqualToString:@"01"] || [strMonth isEqualToString:@"03"] || [strMonth isEqualToString:@"05"] || [strMonth isEqualToString:@"07"] || [strMonth isEqualToString:@"08"] || [strMonth isEqualToString:@"10"] || [strMonth isEqualToString:@"12"]) && [strDate intValue] > 31) {
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                alert.tag = 300;
                [alert show];
                
                return false;
            }
            
            else if (([strMonth isEqualToString:@"04"] || [strMonth isEqualToString:@"06"] || [strMonth isEqualToString:@"09"] || [strMonth isEqualToString:@"11"]) && [strDate intValue] > 30) {
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                alert.tag = 300;
                [alert show];
                
                return false;
            }
            else if (([febStatus isEqualToString:@"Normal"] && [strDate intValue] > 28 && [strMonth isEqualToString:@"02"]) || ([febStatus isEqualToString:@"Jump"] && [strDate intValue] > 29 && [strMonth isEqualToString:@"02"])) {
                
                
                NSString *msg = [NSString stringWithFormat:@"February of %@ doesn’t have 29 days",strYear] ;
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                alert.tag = 300;
                [alert show];
                
                return false;
            }
        }
        
        else if (_PolicyVC.memberSexSC.selectedSegmentIndex == -1) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Cardholder’s Gender for Recurring Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 603;
            [alert show];
            return FALSE;
        }
        else if (_PolicyVC.memberDOBLbl.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Cardholder’s Date of Birth for Recurring Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 604;
            [alert show];
            return FALSE;
        }
        //        if (([_PolicyVC.memberOtherIDTypeLbl.text isEqualToString:@"- SELECT -"]) && [textFields trimWhiteSpaces:_PolicyVC.memberOtherIDTF.text].length > 0) {
        //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Other ID Type is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //            //alert.tag = 606;
        //            [alert show];
        //            return FALSE;
        //        }
        
        if (!([textFields trimWhiteSpaces:_PolicyVC.memberOtherIDTypeLbl.text].length == 0 || [_PolicyVC.memberOtherIDTypeLbl.text isEqualToString:@"- SELECT -"] ) && _PolicyVC.memberOtherIDTF.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Cardholder’s Other ID for Recurring Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 606;
            [alert show];
            return FALSE;
        }
        // Added by Andy to check for IC and OtherID cannot be the same.
        else if ([_PolicyVC.memberOtherIDTF.text isEqualToString:_PolicyVC.memberIC.text]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Cardmember IC Number cannot be the same as Other ID Number." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 606;
            [alert show];
            return FALSE;
        }
		else if (!([textFields trimWhiteSpaces:_PolicyVC.memberOtherIDTypeLbl.text].length == 0 || [_PolicyVC.memberOtherIDTypeLbl.text isEqualToString:@"- SELECT -"] ) && [textFields validateOtherID:_PolicyVC.memberOtherIDTF.text ]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid Cardholder’s Other ID for Recurring Payment. Please key in the correct Other ID for Cardholder." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 606;
            [alert show];
            return FALSE;
        }
        
        //		else if (((isMale && _PolicyVC.memberSexSC.selectedSegmentIndex == 1) || (!isMale && _PolicyVC.memberSexSC.selectedSegmentIndex == 0)) && _PolicyVC.memberIC.text.length != 0) {
        //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No. entered does not match with sex." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //            alert.tag = 605;
        //            [alert show];
        //            return FALSE;
        //        }
        //        else if (strDOB && (![_PolicyVC.memberDOBLbl.text isEqualToString:strDOB])) {
        //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid New IC No. against DOB." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //            alert.tag = 605;
        //            [alert show];
        //            return FALSE;
        //        }
        else if ([textFields trimWhiteSpaces:_PolicyVC.memberContactNoTF.text].length == 0 && _PolicyVC.memberContactNoPrefixCF.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Cardholder’s contact number for Recurring Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 607;
            [alert show];
            return FALSE;
		}
        else if ((_PolicyVC.memberContactNoTF.text.length != 0 && _PolicyVC.memberContactNoPrefixCF.text.length == 0)) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Prefix for contact number of Recurring Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 607;
            [alert show];
            return FALSE;
        }
        else if ((_PolicyVC.memberContactNoTF.text.length == 0 || _PolicyVC.memberContactNoTF.text.length < 6) && _PolicyVC.memberContactNoPrefixCF.text.length != 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Cardholder’s contact number’s length for Recurring Payment must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 608;
            [alert show];
            return FALSE;
        }
        else if (_PolicyVC.memberRelationshipLbl.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Cardholder’s relationship for Recurring Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            // alert.tag = 608;
            [alert show];
            return FALSE;
        }
        
        //	else {
        //		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Record saved successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //		//		alert.tag = 608;
        //		[alert show];
        //	}
        return TRUE;
		
	}
	//Other Payor end
	else {
		/*UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Record saved successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         //		alert.tag = 608;
         [alert show];*/
        return TRUE;
	}
    
}

- (BOOL)alertForFTCreditCard {
	
    int currentYear;
    int currentMonth;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    currentYear = [[dateFormatter stringFromDate:[NSDate date]] intValue];
    [dateFormatter setDateFormat:@"MM"];
    currentMonth = [[dateFormatter stringFromDate:[NSDate date]] intValue];
    if (_PolicyVC.EPPSC.selectedSegmentIndex == -1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Extended Payment Plan (EPP) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return FALSE;
    }
    
    else if (_PolicyVC.FTpersonTypeLbl.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Person Type for First Time Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return FALSE;
    }
    else if (_PolicyVC.FTbankLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Issuing Bank for First Time Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 2001;
		[alert show];
        return FALSE;
	}
	else if (_PolicyVC.FTcardTypeLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Card Type for First Time Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 3001;
		[alert show];
        return FALSE;
	}
	else if (_PolicyVC.FTaccNoTF.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Credit Card No. for First Time Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 4001;
		[alert show];
        return FALSE;
	}
    else if (![[_PolicyVC.FTaccNoTF.text substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"4"] && ![[_PolicyVC.FTaccNoTF.text substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"5"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid credit card no. for First Time Payment." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 4001;
        [alert show];
        return FALSE;
    }
	else if (_PolicyVC.FTaccNoTF.text.length < 16) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Credit Card No. for First Time Payment must be in 16 digits." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 4001;
        [alert show];
        return FALSE;
    }
    else if ([[_PolicyVC.FTaccNoTF.text substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"4"] && [_PolicyVC.FTcardTypeLbl.text rangeOfString:@"Visa" options:NSCaseInsensitiveSearch].location == NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Credit Card No. for First Time Payment didn’t match with card type." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 4001;
        [alert show];
        return FALSE;
    }
    else if ([[_PolicyVC.FTaccNoTF.text substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"5"] && [_PolicyVC.FTcardTypeLbl.text rangeOfString:@"Master" options:NSCaseInsensitiveSearch].location == NSNotFound) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Credit Card No. for First Time Payment didn’t match with card type." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 4001;
        [alert show];
        return FALSE;
    }
	else if (_PolicyVC.FTexpiryDateTF.text.length == 0 && _PolicyVC.FTexpiryDateYearTF.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Card expiry date for First Time Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 5001;
		[alert show];
        return FALSE;
	}
	else if ([_PolicyVC.FTexpiryDateTF.text intValue] > 12 || [_PolicyVC.FTexpiryDateTF.text intValue] < 1){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid credit card expiry month format for First Time Payment. Credit card expiry month must be between 1 to 12." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 5001;
		[alert show];
        return FALSE;
    }
    else if ([_PolicyVC.FTexpiryDateTF.text length] == 1){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid month format." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 5001;
		[alert show];
        return FALSE;
    }
	
    else if ([_PolicyVC.FTexpiryDateYearTF.text intValue] < currentYear) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Card expiry year for First Time Payment must be greater than current year." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 5011;
		[alert show];
        return FALSE;
    }
    else if ([_PolicyVC.FTexpiryDateYearTF.text intValue] == currentYear && [_PolicyVC.FTexpiryDateTF.text intValue] < currentMonth) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Credit Card for First Time Payment is expired. Please use another credit card." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 5001;
		[alert show];
        return FALSE;
    }
	
	//Other Payor start
	else if (_PolicyVC.FTop) {
        // Item for IC checking
        bool isMale = FALSE;
        NSString *strDOB;
        if (_PolicyVC.FTmemberIC.text.length != 0 && _PolicyVC.FTmemberIC.text.length == 12) {
            NSString *last = [_PolicyVC.FTmemberIC.text substringFromIndex:[_PolicyVC.FTmemberIC.text length] -1];
            NSCharacterSet *oddSet = [NSCharacterSet characterSetWithCharactersInString:@"13579"];
            
            if ([last rangeOfCharacterFromSet:oddSet].location != NSNotFound) {
                isMale = TRUE;
            } else {
                isMale = FALSE;
            }
            
            //get the DOB value from ic entered
            NSString *strDate = [_PolicyVC.FTmemberIC.text substringWithRange:NSMakeRange(4, 2)];
            NSString *strMonth = [_PolicyVC.FTmemberIC.text substringWithRange:NSMakeRange(2, 2)];
            NSString *strYear = [_PolicyVC.FTmemberIC.text substringWithRange:NSMakeRange(0, 2)];
            
            //get value for year whether 20XX or 19XX
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy"];
            
            NSString *currentYear = [dateFormatter stringFromDate:[NSDate date]];
            NSString *strCurrentYear = [currentYear substringWithRange:NSMakeRange(2, 2)];
            if ([strYear intValue] > [strCurrentYear intValue] && !([strYear intValue] < 30)) {
                strYear = [NSString stringWithFormat:@"19%@",strYear];
            }
            else {
                strYear = [NSString stringWithFormat:@"20%@",strYear];
            }
            
            strDOB = [NSString stringWithFormat:@"%@/%@/%@",strDate,strMonth,strYear];
        }
        
        if ([textFields trimWhiteSpaces:_PolicyVC.FTmemberNameTF.text].length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Cardholder’s Name for First Time Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 6011;
            [alert show];
            return FALSE;
        }
        else if ([textFields validateString:_PolicyVC.FTmemberNameTF.text])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid name format. Same alphabet cannot be repeated more than three times." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 6021;
            [alert show];
            return FALSE;
        }
        else if ([textFields validateString3:_PolicyVC.FTmemberNameTF.text])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 6021;
            [alert show];
            return FALSE;
        }
        else if ([textFields trimWhiteSpaces:_PolicyVC.FTmemberIC.text].length == 0 && ([textFields trimWhiteSpaces:_PolicyVC.FTmemberOtherIDTypeLbl.text].length == 0 || [_PolicyVC.FTmemberOtherIDTypeLbl.text isEqualToString:@"- SELECT -"])) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Either New IC No. or Other ID of cardholder for First Time Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 6051;
            [alert show];
            return FALSE;
        }
        
        //  else if ((_PolicyVC.FTmemberIC.text.length != 12) && ([textFields trimWhiteSpaces:_PolicyVC.FTmemberOtherIDTypeLbl.text].length == 0) && (_PolicyVC.FTmemberIC.text.length != 0))
        else if ((_PolicyVC.FTmemberIC.text.length != 12)  && (_PolicyVC.FTmemberIC.text.length != 0)){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No must be 12 digits characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 6051;
            [alert show];
            return FALSE;
        }
        else if ([textFields trimWhiteSpaces:_PolicyVC.FTmemberIC.text].length != 0 && [textFields trimWhiteSpaces:_PolicyVC.FTmemberIC.text].length == 12) {
            //CHECK DAY / MONTH / YEAR START
            //get the DOB value from ic entered
            NSString *strDate = [_PolicyVC.FTmemberIC.text substringWithRange:NSMakeRange(4, 2)];
            NSString *strMonth = [_PolicyVC.FTmemberIC.text substringWithRange:NSMakeRange(2, 2)];
            NSString *strYear = [_PolicyVC.FTmemberIC.text substringWithRange:NSMakeRange(0, 2)];
            
            //get value for year whether 20XX or 19XX
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy"];
            
            NSString *currentYear = [dateFormatter stringFromDate:[NSDate date]];
            NSString *strCurrentYear = [currentYear substringWithRange:NSMakeRange(2, 2)];
            if ([strYear intValue] > [strCurrentYear intValue] && !([strYear intValue] < 30)) {
                strYear = [NSString stringWithFormat:@"19%@",strYear];
            }
            else {
                strYear = [NSString stringWithFormat:@"20%@",strYear];
            }
            
            NSString *strDOB2 = [NSString stringWithFormat:@"%@-%@-%@",strYear,strMonth,strDate];
            
            //determine day of february
            NSString *febStatus = nil;
            float devideYear = [strYear floatValue]/4;
            int devideYear2 = devideYear;
            float minus = devideYear - devideYear2;
            if (minus > 0) {
                febStatus = @"Normal";
            }
            else {
                febStatus = @"Jump";
            }
            
            //compare year is valid or not
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *d = [NSDate date];
            NSDate *d2 = [dateFormatter dateFromString:strDOB2];
            
            if ([d compare:d2] == NSOrderedAscending) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                alert.tag = 300;
                [alert show];
                
                return false;
            }
            else if ([strMonth intValue] > 12 || [strMonth intValue] < 1) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC month must be between 1 and 12." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                alert.tag = 300;
                [alert show];
                
                return false;
            }
            else if([strDate intValue] < 1 || [strDate intValue] > 31)
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC day must be between 1 and 31." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                alert.tag = 300;
                [alert show];
                
                return false;
                
            }
            else if (([strMonth isEqualToString:@"01"] || [strMonth isEqualToString:@"03"] || [strMonth isEqualToString:@"05"] || [strMonth isEqualToString:@"07"] || [strMonth isEqualToString:@"08"] || [strMonth isEqualToString:@"10"] || [strMonth isEqualToString:@"12"]) && [strDate intValue] > 31) {
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                alert.tag = 300;
                [alert show];
                
                return false;
            }
            
            else if (([strMonth isEqualToString:@"04"] || [strMonth isEqualToString:@"06"] || [strMonth isEqualToString:@"09"] || [strMonth isEqualToString:@"11"]) && [strDate intValue] > 30) {
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                alert.tag = 300;
                [alert show];
                
                return false;
            }
            else if (([febStatus isEqualToString:@"Normal"] && [strDate intValue] > 28 && [strMonth isEqualToString:@"02"]) || ([febStatus isEqualToString:@"Jump"] && [strDate intValue] > 29 && [strMonth isEqualToString:@"02"])) {
                
                
                NSString *msg = [NSString stringWithFormat:@"February of %@ doesn’t have 29 days",strYear] ;
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                alert.tag = 300;
                [alert show];
                
                return false;
            }
        }
        
        
        else if (_PolicyVC.FTmemberSexSC.selectedSegmentIndex == -1) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Cardholder’s Gender for First Time Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 6031;
            [alert show];
            return FALSE;
        }
        else if (_PolicyVC.FTmemberDOBLbl.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Cardholder’s Date of Birth for First Time Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 6041;
            [alert show];
            return FALSE;
        }
        //        if (([_PolicyVC.FTmemberOtherIDTypeLbl.text isEqualToString:@"- SELECT -"]) && [textFields trimWhiteSpaces:_PolicyVC.FTmemberOtherIDTF.text].length > 0) {
        //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Other ID Type is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //            //alert.tag = 606;
        //            [alert show];
        //            return FALSE;
        //        }
        
        if (!([textFields trimWhiteSpaces:_PolicyVC.FTmemberOtherIDTypeLbl.text].length == 0 || [_PolicyVC.FTmemberOtherIDTypeLbl.text isEqualToString:@"- SELECT -"] ) && _PolicyVC.FTmemberOtherIDTF.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Cardholder’s Other ID for First Time Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 6061;
            [alert show];
            return FALSE;
        }
        // Added by Andy to check for IC and OtherID cannot be the same.
        else if ([_PolicyVC.FTmemberOtherIDTF.text isEqualToString:_PolicyVC.FTmemberIC.text]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Cardmember IC Number cannot be the same as Other ID Number." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 6061;
            [alert show];
            return FALSE;
        }
		else if (!([textFields trimWhiteSpaces:_PolicyVC.FTmemberOtherIDTypeLbl.text].length == 0 || [_PolicyVC.FTmemberOtherIDTypeLbl.text isEqualToString:@"- SELECT -"] ) && [textFields validateOtherID:_PolicyVC.FTmemberOtherIDTF.text ]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid Cardholder’s Other ID for First Time Payment. Please key in the correct Other ID for Cardholder." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 6061;
            [alert show];
            return FALSE;
        }
        
        else if ([textFields trimWhiteSpaces:_PolicyVC.FTmemberContactNoTF.text].length == 0 && _PolicyVC.FTmemberContactNoPrefixCF.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Cardholder’s contact number for First Time Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 6071;
            [alert show];
            return FALSE;
		}
        else if ((_PolicyVC.FTmemberContactNoTF.text.length != 0 && _PolicyVC.FTmemberContactNoPrefixCF.text.length == 0)) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Prefix for contact number of First Time Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 6071;
            [alert show];
            return FALSE;
        }
        else if ((_PolicyVC.FTmemberContactNoTF.text.length == 0 || _PolicyVC.FTmemberContactNoTF.text.length < 6) && _PolicyVC.FTmemberContactNoPrefixCF.text.length != 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Cardholder’s contact number’s length for First Time Payment must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 6081;
            [alert show];
            return FALSE;
        }
        else if (_PolicyVC.FTmemberRelationshipLbl.text.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Cardholder’s relationship for First Time Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            // alert.tag = 608;
            [alert show];
            return FALSE;
        }
        return TRUE;
		
	}
	//Other Payor end
	else {
        return TRUE;
	}
    
}

- (BOOL)alertForPersonalDetails {
	//	NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
	//	[f setNumberStyle:NSNumberFormatterDecimalStyle];
	//	NSNumber *myNumber = [f numberFromString:nominees.sharePercentageTF.text];
	//
	//	NSNumberFormatter * f2 = [[NSNumberFormatter alloc] init];
	//	[f2 setNumberStyle:NSNumberFormatterDecimalStyle];
	//	NSNumber *myNumber2 = [f2 numberFromString:@"100"];
    //[self hideKeyboard];
	
    bool isMale = FALSE;
    NSString *strDOB;
    if ([textFields trimWhiteSpaces:_eAppPersonalDataVC.icNoTF.text].length != 0 && [textFields trimWhiteSpaces:_eAppPersonalDataVC.icNoTF.text].length == 12) {
        NSString *last = [[textFields trimWhiteSpaces:_eAppPersonalDataVC.icNoTF.text] substringFromIndex:[[textFields trimWhiteSpaces:_eAppPersonalDataVC.icNoTF.text] length] -1];
        NSCharacterSet *oddSet = [NSCharacterSet characterSetWithCharactersInString:@"13579"];
        
        if ([last rangeOfCharacterFromSet:oddSet].location != NSNotFound) {
            isMale = TRUE;
        } else {
            isMale = FALSE;
        }
        
        //get the DOB value from ic entered
        NSString *strDate = [_eAppPersonalDataVC.icNoTF.text substringWithRange:NSMakeRange(4, 2)];
        NSString *strMonth = [_eAppPersonalDataVC.icNoTF.text substringWithRange:NSMakeRange(2, 2)];
        NSString *strYear = [_eAppPersonalDataVC.icNoTF.text substringWithRange:NSMakeRange(0, 2)];
        
        //get value for year whether 20XX or 19XX
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy"];
        
        NSString *currentYear = [dateFormatter stringFromDate:[NSDate date]];
        NSString *strCurrentYear = [currentYear substringWithRange:NSMakeRange(2, 2)];
        if ([strYear intValue] > [strCurrentYear intValue] && !([strYear intValue] < 30)) {
            strYear = [NSString stringWithFormat:@"19%@",strYear];
        }
        else {
            strYear = [NSString stringWithFormat:@"20%@",strYear];
        }
        
        strDOB = [NSString stringWithFormat:@"%@/%@/%@",strDate,strMonth,strYear];
    }
    
	if (_eAppPersonalDataVC.titleLbl.text.length == 0 || [_eAppPersonalDataVC.titleLbl.text isEqualToString:@"- SELECT -"]) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Title is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1000;
		[alert show];
        return FALSE;
	}
	else if ([textFields trimWhiteSpaces:_eAppPersonalDataVC.fullNameTF.text].length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Name is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 2000;
		[alert show];
        return FALSE;
	}
    else if ([textFields validateString:_eAppPersonalDataVC.fullNameTF.text]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid Name format. Same alphabet cannot be repeated more than three times." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 2000;
		[alert show];
        return FALSE;
    }
    else if ([textFields validateString3:_eAppPersonalDataVC.fullNameTF.text]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 2000;
		[alert show];
        return FALSE;
    }
    //    else if ([_eAppPersonalDataVC.nameAry containsObject:[[textFields trimWhiteSpaces:_eAppPersonalDataVC.fullNameTF.text] lowercaseString]]) {
    //        int i = [_eAppPersonalDataVC.nameAry indexOfObject:[[textFields trimWhiteSpaces:_eAppPersonalDataVC.fullNameTF.text] lowercaseString]];
    //        if (i == 0) {
    //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"1st Life Assured cannot be appointed as Contingent Owner." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //            [alert show];
    //            return FALSE;
    //        }
    //        else {
    //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Payor cannot be appointed as Contingent Owner." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //            [alert show];
    //            return FALSE;
    //        }
    //    }
	else if ([textFields trimWhiteSpaces:_eAppPersonalDataVC.icNoTF.text].length == 0 && ([textFields trimWhiteSpaces:_eAppPersonalDataVC.OtherIDLbl.text].length == 0 || [_eAppPersonalDataVC.OtherIDLbl.text isEqualToString:@"- SELECT -"])) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Either New IC No or Other ID of Contingent Owner is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 3000;
		[alert show];
        return FALSE;
	}
    
    
    else if ([_eAppPersonalDataVC.otherIDTypeAry containsObject:[textFields trimWhiteSpaces:_eAppPersonalDataVC.IDTypeCodeSelected]] && _eAppPersonalDataVC.IDTypeCodeSelected.length != 0)
    {
        if ([_eAppPersonalDataVC.otherIDAry containsObject:[textFields trimWhiteSpaces:_eAppPersonalDataVC.otherIDTF.text]] && _eAppPersonalDataVC.otherIDTF.text.length != 0) {
            int i = [_eAppPersonalDataVC.otherIDAry indexOfObject:[textFields trimWhiteSpaces:_eAppPersonalDataVC.otherIDTF.text]];
            if (i == 0) {
                //NSString *name1st = [textFields trimWhiteSpaces:[_eAppPersonalDataVC.nameAry objectAtIndex:0]];
                //NSString *currName = [textFields trimWhiteSpaces:_eAppPersonalDataVC.fullNameTF.text];
                //if ([name1st isEqualToString:currName]) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"1st Life Assured cannot be appointed as Contingent Owner." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return FALSE;
                //}
            }
            else {
                //NSString *namePayor = [textFields trimWhiteSpaces:[_eAppPersonalDataVC.nameAry objectAtIndex:1]];
                //NSString *currName = [textFields trimWhiteSpaces:_eAppPersonalDataVC.fullNameTF.text];
                //if ([namePayor isEqualToString:currName]) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Payor cannot be appointed as Contingent Owner." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return FALSE;
                //}
            }
        }
        
    }
    
    
    if ([_eAppPersonalDataVC.icAry containsObject:[textFields trimWhiteSpaces:_eAppPersonalDataVC.icNoTF.text]] && _eAppPersonalDataVC.icNoTF.text.length != 0) {
        int i = [_eAppPersonalDataVC.icAry indexOfObject:[textFields trimWhiteSpaces:_eAppPersonalDataVC.icNoTF.text]];
        if (i == 0) {
            //NSString *name1st = [textFields trimWhiteSpaces:[_eAppPersonalDataVC.nameAry objectAtIndex:0]];
            //NSString *currName = [textFields trimWhiteSpaces:_eAppPersonalDataVC.fullNameTF.text];
            //if ([name1st isEqualToString:currName]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"1st Life Assured cannot be appointed as Contingent Owner." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return FALSE;
            //}
        }
        else {
            //NSString *namePayor = [textFields trimWhiteSpaces:[_eAppPersonalDataVC.nameAry objectAtIndex:1]];
            //NSString *currName = [textFields trimWhiteSpaces:_eAppPersonalDataVC.fullNameTF.text];
            //if ([namePayor isEqualToString:currName]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Payor cannot be appointed as Contingent Owner." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return FALSE;
            //}
        }
    }
    
	if (_eAppPersonalDataVC.icNoTF.text.length != 0 && _eAppPersonalDataVC.icNoTF.text.length < 12) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"New IC No must be 12 digits characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[_eAppPersonalDataVC.icNoTF becomeFirstResponder];
		alert.tag = 3000;
		[alert show];
        return FALSE;
	}
    
    else if ([_eAppPersonalDataVC.otherIDAry containsObject:[textFields trimWhiteSpaces:_eAppPersonalDataVC.OtherIDLbl.text]] && [textFields trimWhiteSpaces:_eAppPersonalDataVC.OtherIDLbl.text].length != 0) {
        int i = [_eAppPersonalDataVC.otherIDAry indexOfObject:[textFields trimWhiteSpaces:_eAppPersonalDataVC.OtherIDLbl.text]];
        if (i == 0) {
            //NSString *name1st = [textFields trimWhiteSpaces:[_eAppPersonalDataVC.nameAry objectAtIndex:0]];
            //NSString *currName = [textFields trimWhiteSpaces:_eAppPersonalDataVC.fullNameTF.text];
            //if ([name1st isEqualToString:currName]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"1st Life Assured cannot be appointed as Contingent Owner." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3000;
            [alert show];
            return FALSE;
            //}
        }
        else {
            //NSString *namePayor = [textFields trimWhiteSpaces:[_eAppPersonalDataVC.nameAry objectAtIndex:1]];
            //NSString *currName = [textFields trimWhiteSpaces:_eAppPersonalDataVC.fullNameTF.text];
            //if ([namePayor isEqualToString:currName]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Payor cannot be appointed as Contingent Owner." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 3000;
            [alert show];
            return FALSE;
            //}
        }
    }
    
	else if ([textFields trimWhiteSpaces:_eAppPersonalDataVC.icNoTF.text].length != 0 && [textFields trimWhiteSpaces:_eAppPersonalDataVC.icNoTF.text].length == 12) {
		//CHECK DAY / MONTH / YEAR START
		//get the DOB value from ic entered
		NSString *strDate = [_eAppPersonalDataVC.icNoTF.text substringWithRange:NSMakeRange(4, 2)];
		NSString *strMonth = [_eAppPersonalDataVC.icNoTF.text substringWithRange:NSMakeRange(2, 2)];
		NSString *strYear = [_eAppPersonalDataVC.icNoTF.text substringWithRange:NSMakeRange(0, 2)];
		
		//get value for year whether 20XX or 19XX
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy"];
		
		NSString *currentYear = [dateFormatter stringFromDate:[NSDate date]];
		NSString *strCurrentYear = [currentYear substringWithRange:NSMakeRange(2, 2)];
		if ([strYear intValue] > [strCurrentYear intValue] && !([strYear intValue] < 30)) {
			strYear = [NSString stringWithFormat:@"19%@",strYear];
		}
		else {
			strYear = [NSString stringWithFormat:@"20%@",strYear];
		}
		
		NSString *strDOB2 = [NSString stringWithFormat:@"%@-%@-%@",strYear,strMonth,strDate];
		
		//determine day of february
		NSString *febStatus = nil;
		float devideYear = [strYear floatValue]/4;
		int devideYear2 = devideYear;
		float minus = devideYear - devideYear2;
		if (minus > 0) {
			febStatus = @"Normal";
		}
		else {
			febStatus = @"Jump";
		}
		
		//compare year is valid or not
		[dateFormatter setDateFormat:@"yyyy-MM-dd"];
		NSDate *d = [NSDate date];
		NSDate *d2 = [dateFormatter dateFromString:strDOB2];
		
		if ([d compare:d2] == NSOrderedAscending) {
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
			alert.tag = 300;
			[alert show];
			
			return false;
		}
		else if ([strMonth intValue] > 12 || [strMonth intValue] < 1) {
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC month must be between 1 and 12." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
			alert.tag = 300;
			[alert show];
			
			return false;
		}
		else if([strDate intValue] < 1 || [strDate intValue] > 31)
		{
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC day must be between 1 and 31." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
			alert.tag = 300;
			[alert show];
			
			return false;
			
		}
		else if (([strMonth isEqualToString:@"01"] || [strMonth isEqualToString:@"03"] || [strMonth isEqualToString:@"05"] || [strMonth isEqualToString:@"07"] || [strMonth isEqualToString:@"08"] || [strMonth isEqualToString:@"10"] || [strMonth isEqualToString:@"12"]) && [strDate intValue] > 31) {
			
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
			alert.tag = 300;
			[alert show];
			
			return false;
		}
		
		else if (([strMonth isEqualToString:@"04"] || [strMonth isEqualToString:@"06"] || [strMonth isEqualToString:@"09"] || [strMonth isEqualToString:@"11"]) && [strDate intValue] > 30) {
			
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
			alert.tag = 300;
			[alert show];
			
			return false;
		}
		else if (([febStatus isEqualToString:@"Normal"] && [strDate intValue] > 28 && [strMonth isEqualToString:@"02"]) || ([febStatus isEqualToString:@"Jump"] && [strDate intValue] > 29 && [strMonth isEqualToString:@"02"])) {
			
			
			NSString *msg = [NSString stringWithFormat:@"February of %@ doesn’t have 29 days",strYear] ;
			
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
			alert.tag = 300;
			[alert show];
			
			return false;
		}
	}
	if ( ([textFields trimWhiteSpaces:_eAppPersonalDataVC.icNoTF.text].length == 0 || [_eAppPersonalDataVC.icNoTF.text isEqualToString:@"IC No"]) && !([textFields trimWhiteSpaces:_eAppPersonalDataVC.otherIDTF.text].length > 0 || ![_eAppPersonalDataVC.otherIDTF.text isEqualToString:@"- Select -"])) {
        //[_eAppPersonalDataVC.icNoTF becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Either New IC No or Other ID of Contingent Owner is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 3000;
		[alert show];
	}
	else if (!([_eAppPersonalDataVC.OtherIDLbl.text isEqualToString:@"- SELECT -"] || ([textFields trimWhiteSpaces:_eAppPersonalDataVC.OtherIDLbl.text].length == 0)) && [textFields trimWhiteSpaces:_eAppPersonalDataVC.otherIDTF.text].length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 7000;
		[alert show];
        return FALSE;
	}
	else if ((![_eAppPersonalDataVC.OtherIDLbl.text isEqualToString:@"- SELECT -"]) && [textFields trimWhiteSpaces:_eAppPersonalDataVC.OtherIDLbl.text].length > 0 && ([textFields validateOtherID:_eAppPersonalDataVC.otherIDTF.text])) {
        //[_eAppPersonalDataVC.otherIDTF becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid Contingent Owner’s Other ID. Please key in the correct Other ID for Contingent Owner." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 7000;
		[alert show];
		return false;
	}
	else if ([[textFields trimWhiteSpaces:_eAppPersonalDataVC.otherIDTF.text] isEqualToString:_eAppPersonalDataVC.icNoTF.text])  {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Other ID cannot be the same as New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 7000;
		[alert show];
		return FALSE;
	}
	else if (_eAppPersonalDataVC.DOBLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Date of Birth is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 4000;
		[alert show];
        return FALSE;
	}
    else if ([self calculateAge:_eAppPersonalDataVC.DOBLbl.text] < 16) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Contingent Owner must attain age 16 years and above." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		[alert show];
        return FALSE;
    }
	else if (_eAppPersonalDataVC.sexSC.selectedSegmentIndex == -1) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Gender is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 5000;
		[alert show];
        return FALSE;
	}
	else if (_eAppPersonalDataVC.RelationshipLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Relationship is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 8000;
		[alert show];
        return FALSE;
	}
    
    else if (([textFields trimWhiteSpaces:_eAppPersonalDataVC.telPhoneNoPrefixTF.text].length == 0 && [textFields trimWhiteSpaces:_eAppPersonalDataVC.telNoTF.text].length != 0)) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Prefix for Tel No. is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 6000;
		[alert show];
        return FALSE;
    }
	else if (([textFields trimWhiteSpaces:_eAppPersonalDataVC.telPhoneNoPrefixTF.text].length != 0 && [textFields trimWhiteSpaces:_eAppPersonalDataVC.telNoTF.text].length == 0)) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Telephone number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 6002;
		[alert show];
        return FALSE;
    }
    else if (([textFields trimWhiteSpaces:_eAppPersonalDataVC.mobilePrefixTF.text].length == 0 && [textFields trimWhiteSpaces:_eAppPersonalDataVC.mobileTF.text].length != 0)) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Prefix for Mobile No. is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 6001;
		[alert show];
        return FALSE;
    }
	else if (([textFields trimWhiteSpaces:_eAppPersonalDataVC.mobilePrefixTF.text].length != 0 && [textFields trimWhiteSpaces:_eAppPersonalDataVC.mobileTF.text].length == 0)) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Mobile number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 6003;
		[alert show];
        return FALSE;
    }
	else if ([textFields trimWhiteSpaces:_eAppPersonalDataVC.telNoTF.text].length != 0 && [textFields trimWhiteSpaces:_eAppPersonalDataVC.telNoTF.text].length < 6) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Telephone number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 6002;
		[alert show];
        return FALSE;
	}
	else if ([textFields trimWhiteSpaces:_eAppPersonalDataVC.mobileTF.text].length != 0 && [textFields trimWhiteSpaces:_eAppPersonalDataVC.mobileTF.text].length < 6) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Mobile number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 6003;
		[alert show];
        return FALSE;
	}
	else if (_eAppPersonalDataVC.telNoTF.text.length == 0 && _eAppPersonalDataVC.mobileTF.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Either one of the contact numbers is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 6000;
		[alert show];
        return FALSE;
	}
    
    else if ([textFields trimWhiteSpaces:_eAppPersonalDataVC.emailTF.text].length != 0 && ![textFields validateEmail:[textFields trimWhiteSpaces:_eAppPersonalDataVC.emailTF.text]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"You have entered an invalid email. Please key in the correct email." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return FALSE;
    }
    
    
    else if (_eAppPersonalDataVC.NationalityLbl.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Nationality is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 8000;
        [alert show];
        return FALSE;
    }
	
	else if (![_eAppPersonalDataVC.NationalityLbl.text isEqualToString:@"MALAYSIAN"] && _eAppPersonalDataVC.icNoTF.text.length != 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Nationality didn’t match with New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 8000;
        [alert show];
        return FALSE;
	}
	
    else if (![_eAppPersonalDataVC.NationalityLbl.text isEqualToString:@"MALAYSIAN"] && ([_eAppPersonalDataVC.OtherIDLbl.text isEqualToString:@"BIRTH CERTIFICATE"] || [_eAppPersonalDataVC.OtherIDLbl.text isEqualToString:@"OLD IDENTIFICATION NO"] || [_eAppPersonalDataVC.OtherIDLbl.text isEqualToString:@"ARMY IDENTIFICATION NUMBER"] || [_eAppPersonalDataVC.OtherIDLbl.text isEqualToString:@"POLICE IDENTIFICATION NUMBER"])
			 )
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Nationality didn’t match with Other ID No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 8000;
        [alert show];
        return FALSE;
	}
	else if ([_eAppPersonalDataVC.NationalityLbl.text isEqualToString:@"MALAYSIAN"] && ([_eAppPersonalDataVC.OtherIDLbl.text isEqualToString:@"PERMANENT RESIDENT"] || [_eAppPersonalDataVC.OtherIDLbl.text isEqualToString:@"FOREIGNER IDENTIFICATION NUMBER"] || [_eAppPersonalDataVC.OtherIDLbl.text isEqualToString:@"FOREIGNER BIRTH CERTIFICATE"])
			 )
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Nationality didn’t match with Other ID No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 8000;
        [alert show];
        return FALSE;
	}
	else if (![_eAppPersonalDataVC.NationalityLbl.text isEqualToString:@"SINGAPOREAN"] && ([_eAppPersonalDataVC.OtherIDLbl.text isEqualToString:@"SINGAPORE IDENTIFICATION NUMBER"])) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Nationality didn’t match with Other ID No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 8000;
        [alert show];
        return FALSE;
	}
	else if (_eAppPersonalDataVC.OccupationLbl.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Occupation is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 8000;
        [alert show];
        return FALSE;
    }
    //    else if ([textFields trimWhiteSpaces:_eAppPersonalDataVC.nameOfEmployerTF.text].length == 0 && _eAppPersonalDataVC.nameOfEmployerTF.enabled == TRUE) {
    //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Name of Employer is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        alert.tag = 8000;
    //        [alert show];
    //        return FALSE;
    //    }
    
    
    else if ([textFields trimWhiteSpaces:_eAppPersonalDataVC.nameOfEmployerTF.text].length == 0 && _eAppPersonalDataVC.nameOfEmployerTF.enabled == TRUE
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"HOUSEWIFE"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"HOME MAKER"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"HOUSE HUSBAND"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"BABY"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"JUVENILE"]
             &&![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"MINOR"]
             &&![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"RETIRED"]
             &&![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"PENSIONER"]
             &&![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"COLLEGE STUDENT"]
             &&![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"SCHOOLBOY"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"SCHOOLGIRL"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"UNIVERSITY STUDENT"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"PILOT STUDENT (non helicopter)"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"STUDENT"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"STUDENT NURSE"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"UNEMPLOYED"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"TEMPORARILY UNEMPLOYED"])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Name of Employer is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 8000;
        [alert show];
        return FALSE;
    }
    
    
    else if ([textFields trimWhiteSpaces:_eAppPersonalDataVC.nameOfEmployerTF.text].length != 0 && _eAppPersonalDataVC.nameOfEmployerTF.enabled == TRUE && [textFields validateOtherID: _eAppPersonalDataVC.nameOfEmployerTF.text]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid name format. Input must be alphabet A-Z, space, apostrophe('), alias(@), slash(/), dash(-), bracket(()) or dot(.)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 8000;
        [alert show];
        return FALSE;
    }
    
    
    else if ([textFields trimWhiteSpaces:_eAppPersonalDataVC.nameOfEmployerTF.text].length != 0 && [textFields validateString:_eAppPersonalDataVC.nameOfEmployerTF.text]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid Name of Employer format. Same alphabet cannot be repeated more than three times." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 8000;
        [alert show];
        return FALSE;
        
    }
    
    else if ([textFields validateString:_eAppPersonalDataVC.nameOfEmployerTF.text]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid Name of Employer format. Same alphabet cannot be repeated more than three times." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 8000;
		[alert show];
        return FALSE;
    }
    
    
    //    else if ([textFields trimWhiteSpaces:_eAppPersonalDataVC.exactNatureOfWorkTF.text].length == 0 && _eAppPersonalDataVC.exactNatureOfWorkTF.enabled == TRUE) {
    //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Exact Nature of Work is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        alert.tag = 8000;
    //        [alert show];
    //        return FALSE;
    //    }
    
    else if ([textFields trimWhiteSpaces:_eAppPersonalDataVC.exactNatureOfWorkTF.text].length == 0 && _eAppPersonalDataVC.exactNatureOfWorkTF.enabled == TRUE && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"HOUSEWIFE"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"HOME MAKER"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"HOUSE HUSBAND"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"BABY"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"JUVENILE"]
             &&![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"MINOR"]
             &&![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"RETIRED"]
             &&![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"PENSIONER"]
             &&![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"COLLEGE STUDENT"]
             &&![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"SCHOOLBOY"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"SCHOOLGIRL"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"UNIVERSITY STUDENT"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"PILOT STUDENT (non helicopter)"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"STUDENT"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"STUDENT NURSE"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"UNEMPLOYED"]
             && ![_eAppPersonalDataVC.OccupationLbl.text isEqualToString:@"TEMPORARILY UNEMPLOYED"])
        
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Exact Nature of Work is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 8000;
        [alert show];
        return FALSE;
    }
    
   	
	//CHECK VALIDATION FOR ADDRESS
	else if (([textFields trimWhiteSpaces:_eAppPersonalDataVC.CRaddressTF.text].length == 0 || _eAppPersonalDataVC.CRaddressTF.text == nil) && [textFields trimWhiteSpaces:_eAppPersonalDataVC.addressTF.text].length == 0 && !_eAppPersonalDataVC.fa && !_eAppPersonalDataVC.CRfa && [textFields trimWhiteSpaces:_eAppPersonalDataVC.postcodeTF.text].length == 0 && [textFields trimWhiteSpaces:_eAppPersonalDataVC.CRpostcodeTF.text].length == 0 && [textFields trimWhiteSpaces:_eAppPersonalDataVC.address2TF.text].length == 0 && [textFields trimWhiteSpaces:_eAppPersonalDataVC.address3TF.text].length == 0 && [textFields trimWhiteSpaces:_eAppPersonalDataVC.CRaddress2TF.text].length == 0 && [textFields trimWhiteSpaces:_eAppPersonalDataVC.CRaddress3TF.text].length == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Either Residential Address or Correspondence Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 9001;
        [alert show];
        return FALSE;
    }
    
    else if ([textFields trimWhiteSpaces:_eAppPersonalDataVC.CRaddressTF.text].length == 0 && [textFields trimWhiteSpaces:_eAppPersonalDataVC.addressTF.text].length == 0 && !_eAppPersonalDataVC.fa && !_eAppPersonalDataVC.CRfa && [textFields trimWhiteSpaces:_eAppPersonalDataVC.postcodeTF.text].length != 0 && [textFields trimWhiteSpaces:_eAppPersonalDataVC.address2TF.text].length != 0 && [textFields trimWhiteSpaces:_eAppPersonalDataVC.address3TF.text].length != 0) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@" Residential Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 9001;
        [alert show];
        return FALSE;
    }
    
    else if ([textFields trimWhiteSpaces:_eAppPersonalDataVC.CRaddressTF.text].length == 0 && [textFields trimWhiteSpaces:_eAppPersonalDataVC.addressTF.text].length == 0 && !_eAppPersonalDataVC.CRfa && [textFields trimWhiteSpaces:_eAppPersonalDataVC.CRpostcodeTF.text].length != 0 && [textFields trimWhiteSpaces:_eAppPersonalDataVC.CRaddress2TF.text].length != 0 && [textFields trimWhiteSpaces:_eAppPersonalDataVC.CRaddress3TF.text].length != 0) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@" Correspondence Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 9001;
        [alert show];
        return FALSE;
    }
    
    
    
	//check residence address
	if (_eAppPersonalDataVC.fa || [textFields trimWhiteSpaces:_eAppPersonalDataVC.addressTF.text].length != 0 || [textFields trimWhiteSpaces:_eAppPersonalDataVC.postcodeTF.text].length != 0 || [textFields trimWhiteSpaces:_eAppPersonalDataVC.townTF.text].length != 0) {
		
		if ([textFields trimWhiteSpaces:_eAppPersonalDataVC.addressTF.text].length == 0) {
            
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Residential Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 9001;
			[alert show];
            return FALSE;
		}
		if (!_eAppPersonalDataVC.fa) {
			if ([textFields trimWhiteSpaces:_eAppPersonalDataVC.postcodeTF.text].length == 0) {
				UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Residential Postcode is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				alert.tag = 9002;
				[alert show];
                return FALSE;
			}
			else if ([_eAppPersonalDataVC.stateLbl.text isEqualToString:@"State"]) {
				UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Postcode for Residential Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				alert.tag = 9003;
				[alert show];
                return FALSE;
			}
		}
		else {
			if (_eAppPersonalDataVC.countryLbl.text.length == 0 || [_eAppPersonalDataVC.countryLbl.text isEqualToString:@"- SELECT -"]) {
				UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Country for Residential Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				alert.tag = 9001;
				[alert show];
                return FALSE;
			}
		}
	}
	
	//check correspondence address
	if (_eAppPersonalDataVC.CRfa || [textFields trimWhiteSpaces:_eAppPersonalDataVC.CRaddressTF.text].length != 0 || [textFields trimWhiteSpaces:_eAppPersonalDataVC.CRpostcodeTF.text].length != 0 || [textFields trimWhiteSpaces:_eAppPersonalDataVC.CRtownTF.text].length != 0) {
		
		if ([textFields trimWhiteSpaces:_eAppPersonalDataVC.CRaddressTF.text].length == 0) {
            
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Correspondence Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 9004;
			[alert show];
            return FALSE;
		}
		if (!_eAppPersonalDataVC.CRfa) {
			if ([textFields trimWhiteSpaces:_eAppPersonalDataVC.CRpostcodeTF.text].length == 0) {
				UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Correspondence Postcode is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				alert.tag = 9005;
				[alert show];
                return FALSE;
			}
			else if ([_eAppPersonalDataVC.CRstateLbl.text isEqualToString:@"State"]) {
				UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Postcode for Correspondence Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				alert.tag = 9005;
				[alert show];
                return FALSE;
			}
			else {
				return TRUE;
			}
		}
		else {
			if (_eAppPersonalDataVC.CRcountryLbl.text.length == 0 || [_eAppPersonalDataVC.CRcountryLbl.text isEqualToString:@"- SELECT -"]) {
				UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Country for Correspondence Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				alert.tag = 9004;
				[alert show];
                return FALSE;
			}
			else {
				return TRUE;
			}
		}
	}
	
	
	//Not Same Address end
	else {
		//UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Record saved successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		alert.tag = 608;
		//[alert show];
        return TRUE;
	}
	return TRUE;
}


- (BOOL)validSecB {
	if (_PolicyVC.firstTimePaymentLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Source of First Time Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		return FALSE;
	}
	else if ((_PolicyVC.deductSC.enabled == true) && (_PolicyVC.deductSC.selectedSegmentIndex == -1)) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"1st Payment Deduct Upon Final Acceptance is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		return FALSE;
	}
	else if ([_PolicyVC.firstTimePaymentLbl.text isEqual:@"Credit Card"] && ![self alertForFTCreditCard]) {
		return FALSE;
	}
	else if (_PolicyVC.recurPaymentLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Source of Recurring Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		return FALSE;
	}
	else if (_PolicyVC.ccsi) {
        if (![self alertForPolicyDetails]) {
            return FALSE;
        }
    }
    if ([textFields trimWhiteSpaces:_PolicyVC.agentCodeTF.text].length != 0) {
        if ([textFields trimWhiteSpaces:_PolicyVC.agentNameTF.text].length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"2nd Agent Name is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 10001;
            [alert show];
            return FALSE;
        }
    }
	if ([textFields trimWhiteSpaces:_PolicyVC.agentCodeTF.text].length != 0) {
        if ([textFields trimWhiteSpaces:_PolicyVC.agentNameTF.text].length > 0 && [textFields validateString3:_PolicyVC.agentNameTF.text]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid name format. Input must be alphabet A-Z, space, apostrophe('), alias(@), slash(/), dash(-),bracket(()) or dot(.)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 10001;
            [alert show];
            return FALSE;
        }
    }
    if ([textFields trimWhiteSpaces:_PolicyVC.agentNameTF.text].length != 0) {
        if ([textFields trimWhiteSpaces:_PolicyVC.agentCodeTF.text].length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"2nd Agent Code is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 10003;
            [alert show];
            return FALSE;
        }
    }
	if ([textFields trimWhiteSpaces:_PolicyVC.agentNameTF.text].length != 0 && [textFields validateString:_PolicyVC.agentNameTF.text]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid agent name format. Same alphabet cannot be repeated more than three times." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 10001;
        [alert show];
        return FALSE;
        
    }
    if (_PolicyVC.agentContactNoTF.text.length != 0) {
        if ([textFields trimWhiteSpaces:_PolicyVC.agentCodeTF.text].length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"2nd Agent Code is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 10003;
            [alert show];
            return FALSE;
        }
    }
	if (_PolicyVC.agentContactNoPrefixTF.text.length != 0) {
        if ([textFields trimWhiteSpaces:_PolicyVC.agentCodeTF.text].length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"2nd Agent Code is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 10003;
            [alert show];
            return FALSE;
        }
    }
    
    if ([textFields trimWhiteSpaces:_PolicyVC.agentNameTF.text].length != 0 && _PolicyVC.agentContactNoTF.text.length != 0) {
        if ([textFields trimWhiteSpaces:_PolicyVC.agentCodeTF.text].length == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"2nd Agent Code is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 10003;
            [alert show];
            return FALSE;
        }
    }
    if ([textFields trimWhiteSpaces:_PolicyVC.agentCodeTF.text].length != 0 && _PolicyVC.agentContactNoTF.text.length != 0) {
        if ([textFields trimWhiteSpaces:_PolicyVC.agentNameTF.text].length == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"2nd Agent Name is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 10001;
            [alert show];
            return FALSE;
        }
    }
    if([textFields trimWhiteSpaces:_PolicyVC.agentCodeTF.text].length != 0 && [textFields validateString:_PolicyVC.agentNameTF.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid Name format. Same alphabet cannot be repeated for more than 3 times." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 10001;
        [alert show];
        return FALSE;
    }
	if ([textFields trimWhiteSpaces:_PolicyVC.agentCodeTF.text].length != 0 && [textFields trimWhiteSpaces:_PolicyVC.agentNameTF.text].length != 0) {
		if (_PolicyVC.agentContactNoPrefixTF.text.length == 0) {
            //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Prefix for Contact No. is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"2nd Agent Contact No. is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 10004;
            [alert show];
            return FALSE;
        }
        if (_PolicyVC.agentContactNoTF.text.length == 0 || _PolicyVC.agentContactNoTF.text.length < 6) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Number for Contact No. must be 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 10002;
            [alert show];
            return FALSE;
        }
    }
    if([textFields trimWhiteSpaces:_PolicyVC.agentCodeTF.text].length != 0 && [textFields validateString3:_PolicyVC.agentNameTF.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 10001;
        [alert show];
        return FALSE;
    }
    
    
    if([textFields trimWhiteSpaces:_PolicyVC.agentCodeTF.text].length != 0 && [textFields validateString3:_PolicyVC.agentNameTF.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 10001;
        [alert show];
        return FALSE;
    }
    
    else if ([_PolicyVC.ChangeTickMAsterMenu isEqualToString:@"Yes"])
    {
		if (_PolicyVC.DCBankName.text.length == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Bank name is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return FALSE;
        }
        
        else if (_PolicyVC.DCAccountType.text.length == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Account Type is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return FALSE;
            
        }
        
        else if (_PolicyVC.DCAccNo.text.length == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Account Number is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return FALSE;
            
        }
        
        else if (_PolicyVC.DCAccNo.text.length == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Account Number is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return FALSE;
            
        }
        
        
        else if (_PolicyVC.DCAccNo.text.length == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Account Number is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return FALSE;
            
        }
        
        else if (_PolicyVC.emailDC.text.length == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Email is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return FALSE;
            
        }
        else if ([textFields trimWhiteSpaces:_PolicyVC.emailDC.text].length != 0 && ![textFields validateEmail:[textFields trimWhiteSpaces:_PolicyVC.emailDC.text]]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"You have entered an invalid email. Please key in the correct email." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return FALSE;
        }
        
        
        else if (_PolicyVC.mobileNoPrefixDC.text.length == 0 ) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Prefix for contact number is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            // alert.tag = 10002;
            [alert show];
            return FALSE;
        }
        
        else if (_PolicyVC.mobileNoDC.text.length == 0 || _PolicyVC.mobileNoDC.text.length < 6) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Number for Contact No. must be 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            // alert.tag = 10002;
            [alert show];
            return FALSE;
        }
        
        
        
        
        
	}
    
    
	else
		return TRUE;
}




- (void)alertForExistingPolicies {
	//Details of Existing Policy is required.
    //	if (_part4.personTypeLbl.text.length == 0) {
    //		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Person Type is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //		//		alert.tag = 608;
    //		[alert show];
    //
    //	}
    //	else if (_part4.noticeASC.selectedSegmentIndex == 0 && _part4.noticeBSC.selectedSegmentIndex == -1) {
    //		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Existing Policy Question 2(b) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //		//		alert.tag = 608;
    //		[alert show];
    //	}
    //	else if (_part4.noticeASC.selectedSegmentIndex == 0 && _part4.noticeCSC.selectedSegmentIndex == -1) {
    //		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Existing Policy Question 2(c) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //		//		alert.tag = 608;
    //		[alert show];
    //	}
    //	else if (_part4.noticeASC.selectedSegmentIndex == 0 && _part4.noticeDSC.selectedSegmentIndex == -1) {
    //		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Existing Policy Question 2(d) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //		//		alert.tag = 608;
    //		[alert show];
    //	}
    //	else if (_part4.pb && _part4.dateSpecialReqLbl.text.length == 0) {
    //		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Policy Backdating is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //		//		alert.tag = 608;
    //		[alert show];
    //	}
    //	else if (_part4.noticeASC.selectedSegmentIndex == 0 && [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FirstTimePayment"] == Nil) {
    //		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"First Time Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //		alert.tag = 41;
    //		[alert show];
    //	}
    //	else {
    //		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Record saved successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //		//		alert.tag = 608;
    //		[alert show];
    //	}
}
-(BOOL)validSecC{
    if([textFields trimWhiteSpaces:_part4.personTypeLbl.text].length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Person Type is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        return  FALSE;
    }
    // 1st LA checking
	if ([_part4.personTypeLbl.text isEqualToString:@"1st Life Assured"]) {
		if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies1stLA"])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Existing Policy Question 1 is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
			return  FALSE;
		}
        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies1stLA"] isEqualToString:@"Y"])
        {
            if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] objectForKey:@"PolicyData"] count] == 0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Details of Existing Policy for 1st Life Assured is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return  FALSE;
            }
        }
        
        if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies1stLACR"])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Existing Policy Question 2 is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
			return  FALSE;
		}
        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies1stLACR"] isEqualToString:@"Y"])
        {
            if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] objectForKey:@"PolicyData"] count] == 0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Details of Existing Policy for 1st Life Assured is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return  FALSE;
            }
        }
        
        //        if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies1stLACR"])
        //        {
        //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Existing Policy Question 1a is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //            [alert show];
        //			return  FALSE;
        //		}
        //        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies1stLACR"] isEqualToString:@"Y"]) {
        //            if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLACR"] objectForKey:@"PolicyData"] count] == 0) {
        //                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Details of Existing Policy for 1st Life Assured is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //                [alert show];
        //                return  FALSE;
        //            }
        //        }
        //
        if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA1stLA"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Existing Policy Question 3(a) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return  FALSE;
        }
        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA1stLA"] isEqualToString:@"Y"] && (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeB1stLA"] || [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeB1stLA"] isEqualToString:@""]))
        {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Existing Policy Question 3(b) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
            return FALSE;
        }
        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA1stLA"] isEqualToString:@"Y"] && (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeC1stLA"] || [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeC1stLA"] isEqualToString:@""])) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Existing Policy Question 3(c) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
            return  FALSE;
        }
        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA1stLA"] isEqualToString:@"Y"] && (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeD1stLA"] || [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeD1stLA"] isEqualToString:@""])) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Existing Policy Question 3(d) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
            return  FALSE;
        }
        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PolicyBackdating1stLA"] isEqualToString:@"Y"])
        {
            if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdating1stLA"] isEqualToString:@""] || ![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdating1stLA"]) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Policy Backdating is required. Please select the backdating date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return  FALSE;
            }
			else {
				if ([self calculateBackdate:[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdating1stLA"]] == 0)
                {
					UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Policy backdating cannot be earlier than 6 months, current date or greater than today’s date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
					[alert show];
					return  FALSE;
				}
				else if ([self calculateBackdate:[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdating1stLA"]] == 2)
                {
					UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"“Backdating of commencement date is not allowed. Should you wish to backdate the commencement date to before 01/04/2015, you are required to proceed with manual submission or submit the Amendment To Proposal (ATP) in later stage " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
					[alert show];
					return  FALSE; 
				}
			}
        }
		
		
    }
    // 2nd LA checking
    if ([_part4.personTypeLbl.text isEqualToString:@"2nd Life Assured"]) {
		if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies2ndLA"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Existing Policy Question 1 is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
			return  FALSE;
		}
        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy2ndLA"] isEqualToString:@"Y"]) {
            if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy2ndLA"] objectForKey:@"PolicyData"] count] == 0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Details of Existing Policy for 2nd Life Assured is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return  FALSE;
            }
        }
        if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA2ndLA"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Existing Policy Question 2(a) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return  FALSE;
        }
        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA2ndLA"] isEqualToString:@"Y"] && ![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeB2ndLA"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Existing Policy Question 2(b) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
            return FALSE;
        }
        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA2ndLA"] isEqualToString:@"Y"] && ![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeC2ndLA"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Existing Policy Question 2(c) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
            return  FALSE;
        }
        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA2ndLA"] isEqualToString:@"Y"] && ![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeD2ndLA"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Existing Policy Question 2(d) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
            return  FALSE;
        }
        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PolicyBackdating2ndLA"] isEqualToString:@"Y"]) {
			//NSLog(@"ENS: Policy Backdating 2: %@ ", [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdating2ndLA"]);
            if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdating2ndLA"] isEqualToString:@""] || ![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdating2ndLA"]) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Policy Backdating is required. Please select the backdating date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return  FALSE;
            }
			else {
				//NSLog(@"ENS: return value DatePolicyBackdating2ndLA: %d ", [self calculateBackdate:[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdating2ndLA"]]);
				if ([self calculateBackdate:[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdating2ndLA"]] == 0){
					UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Policy backdating cannot be earlier than 6 months, current date or greater than today’s date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
					if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdatingTemp"] isEqualToString:@""])
						[[obj.eAppData objectForKey:@"SecC"] setValue:@"" forKey:@"DatePolicyBackdating1stLA"];
					else
						[[obj.eAppData objectForKey:@"SecC"] setValue:[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdatingTemp"] forKey:@"DatePolicyBackdating1stLA"];
					[alert show];
					return  FALSE;
				}
			}
        }
    }
    //PO checking
    if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyPO"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Existing Policy Question for Policy Owner." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return  FALSE;
    }
    else if ([_part4.personTypeLbl.text isEqualToString:@"Policy Owner"]) {
		if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPoliciesPO"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Existing Policy Question 1 is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			return  FALSE;
		}
		else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPoliciesPO"] isEqualToString:@"Y"]) {
			if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyPO"] objectForKey:@"PolicyData"] count] == 0) {
				UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Details of Existing Policy for Policy Owner is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
                return  FALSE;
			}
		}
		if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeAPO"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Existing Policy Question 2(a) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			return  FALSE;
		}
		else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeAPO"] isEqualToString:@"Y"] && ![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeBPO"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Existing Policy Question 2(b) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			return FALSE;
		}
		else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeAPO"] isEqualToString:@"Y"] && ![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeCPO"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Existing Policy Question 2(c) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			return  FALSE;
		}
		else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeAPO"] isEqualToString:@"Y"] && ![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeDPO"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Existing Policy Question 2(d) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			return  FALSE;
		}
		else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PolicyBackdatingPO"] isEqualToString:@"Y"]) {
			//NSLog(@"ENS: Policy Backdating 3: %@ ", [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdatingPO"]);
			if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdatingPO"] isEqualToString:@""] || ![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdatingPO"]) {
				UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Policy Backdating is required. Please select the backdating date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
                return  FALSE;
			}
			else {
				//NSLog(@"ENS: return value DatePolicyBackdatingPO: %d ", [self calculateBackdate:[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdatingPO"]]);
				if ([self calculateBackdate:[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdatingPO"]] == 0){
					UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Policy backdating cannot be earlier than 6 months, current date or greater than today’s date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
					if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdatingTemp"] isEqualToString:@""])
						[[obj.eAppData objectForKey:@"SecC"] setValue:@"" forKey:@"DatePolicyBackdating1stLA"];
					else
						[[obj.eAppData objectForKey:@"SecC"] setValue:[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdatingTemp"] forKey:@"DatePolicyBackdating1stLA"];
					[alert show];
					return  FALSE;
				}
			}
		}
    }
    //check part 1 start
    //		else if (_part4.Q1SC.selectedSegmentIndex == -1) {
    //			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Existing Policy Question for 1st Life Assured." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //			[alert show];
    //			return  FALSE;
    //		}
    //		//check part 1 end
    //	}
    //
    //	else
    //        return TRUE;
    return TRUE;
}

-(BOOL)validSecD
{
    
    // NSLog(@"MasterMenuEApp validSecD total - %@", [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"]);
    //    if ([self.NomineesVC.Nominee1Lbl.text isEqualToString:@"Add Nominee (1)"]
    //        && [self.NomineesVC.Nominee2Lbl.text isEqualToString:@"Add Nominee (2)"]
    //        && [self.NomineesVC.Nominee3Lbl.text isEqualToString:@"Add Nominee (3)"]
    //        && [self.NomineesVC.Nominee4Lbl.text isEqualToString:@"Add Nominee (4)"]
    //        && [self.NomineesVC.trusteeLbl1.text isEqualToString:@"Add Trustee (1)"]
    //        && [self.NomineesVC.trusteeLbl2.text isEqualToString:@"Add Trustee (2)"])
    //    {
    //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"No Nominee/Trustee record to save." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //
    //        [alert setTag:1001];
    //        [alert show];
    //        alert = Nil;
    //        return FALSE;
    //    }
    
    //    if (total < 100)
    //    {
    //        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Total Percentage of Share less than 100% " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //
    //        [alert setTag:1001];
    //        [alert show];
    //        alert = Nil;
    //        return FALSE;
    //
    //    }
    //    else
    //    {
	
	int total = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"] intValue];
	if (total < 100 && total != 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Total Percentage of Share less than 100%." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		return  FALSE;
	}
	
	else if (total > 100) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Total Percentage of Share exceeded 100%." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		return  FALSE;
	}
	
	else {
        
        if(self.NomineesVC.Nominee1Lbl.text.length != 0 )
            [[obj.eAppData objectForKey:@"SecD"] setValue:self.NomineesVC.Nominee1Lbl.text forKey:@"nominee1"];
        if(self.NomineesVC.Nominee2Lbl.text.length != 0 )
            [[obj.eAppData objectForKey:@"SecD"] setValue:self.NomineesVC.Nominee2Lbl.text forKey:@"nominee2"];
        if(self.NomineesVC.Nominee3Lbl.text.length != 0 )
            [[obj.eAppData objectForKey:@"SecD"] setValue:self.NomineesVC.Nominee3Lbl.text forKey:@"nominee3"];
        if(self.NomineesVC.Nominee4Lbl.text.length != 0 )
            [[obj.eAppData objectForKey:@"SecD"] setValue:self.NomineesVC.Nominee4Lbl.text forKey:@"nominee4"];
        
        return  TRUE;
        
        
	}
    
}

//Changes by satya for 3220
-(void)tickMarkForSecE{
    
    //    if(([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] valueForKey:@"SecE_height"]) )
    //
    //    {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
    [db open];
    NSString *POOtherIDType;
    results4 = [db executeQuery:@"select LAOtherIDType from eProposal_LA_Details where eProposalNo = ? AND POFlag = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"N"];
	
	while ([results4 next]) {
		POOtherIDType = [results4 objectForColumnName:@"LAOtherIDType"];
    }
    
    
    
    if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"count"] intValue] == 1 && [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_height"]) {
		
        
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
        imageView.hidden = FALSE;
        imageView = nil;
        self.SummaryVC.tickHealthQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        
        self.SummaryVC.tickHealthQuestions.text = @"✓";
		//UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
		imageView.hidden = FALSE;
		imageView = nil;
		
		UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9005];
		imageView1.hidden = TRUE;
		imageView1 = nil;
        
    }
    else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"count"] intValue] == 2 && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_height"]length]>0 && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_height"]length]>0 ) {
		
        // [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Saved"];
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
        imageView.hidden = FALSE;
        imageView = nil;
        
        self.SummaryVC.tickHealthQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        
        self.SummaryVC.tickHealthQuestions.text = @"✓";
		
		//UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
		imageView.hidden = FALSE;
		imageView = nil;
		
		UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9005];
		imageView1.hidden = TRUE;
		imageView1 = nil;
        
    }
	else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"count"] intValue] == 3
			 && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_height"]length]>0 && [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_height"] != NULL && ![[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_height"] isEqualToString:@"(null)"]
			 && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_height"]length]>0 && [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_height"] != NULL && ![[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_height"] isEqualToString:@"(null)"]) {
        //[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Saved"];
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
        imageView.hidden = FALSE;
        imageView = nil;
        
        self.SummaryVC.tickHealthQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        self.SummaryVC.tickHealthQuestions.text = @"✓";
		
		//UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
		imageView.hidden = FALSE;
		imageView = nil;
		
		UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9005];
		imageView1.hidden = TRUE;
		imageView1 = nil;
        
        
    }
	else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"count"] intValue] == 4 && [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_height"]) {
		
        
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
        imageView.hidden = FALSE;
        imageView = nil;
        self.SummaryVC.tickHealthQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        
        self.SummaryVC.tickHealthQuestions.text = @"✓";
		//UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
		imageView.hidden = FALSE;
		imageView = nil;
		
		UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9005];
		imageView1.hidden = TRUE;
		imageView1 = nil;
        
    }
    
    else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"count"] intValue] == 3 && [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_height"] && [POOtherIDType isEqualToString:@"EDD"]) {
		
        
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
        imageView.hidden = FALSE;
        imageView = nil;
        self.SummaryVC.tickHealthQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        
        self.SummaryVC.tickHealthQuestions.text = @"✓";
		//UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
		imageView.hidden = FALSE;
		imageView = nil;
		
		UIImageView *imageView1=(UIImageView *)[self.view viewWithTag:9005];
		imageView1.hidden = TRUE;
		imageView1 = nil;
        
    }
	
    
    // }
}
-(BOOL)validSecE {
    
    NSArray *keys1 = [[NSArray alloc] initWithObjects:@"LA1HQ", @"LA2HQ", @"POHQ",nil];
    
    //NSArray *keys2 = [[NSArray alloc] initWithObjects:@"SecE_height", @"SecE_weight",@"SecE_Q1B", @"SecE_Q2", @"SecE_Q3", @"SecE_Q4", @"SecE_Q5", @"SecE_Q6", @"SecE_Q7A", @"SecE_Q7B", @"SecE_Q7C",@"SecE_Q7D", @"SecE_Q7E",@"SecE_Q7F",@"SecE_Q7G", @"SecE_Q7H", @"SecE_Q7I", @"SecE_Q7J", @"SecE_Q8A", @"SecE_Q8B", @"SecE_Q8C", @"SecE_Q8D", @"SecE_Q8E", @"SecE_Q9", @"SecE_Q10", @"SecE_Q11", @"SecE_Q12", @"SecE_Q13", @"SecE_Q14A", @"SecE_Q14B", @"SecE_Q15",nil];
    NSArray *keys2 = [[NSArray alloc] initWithObjects:@"SecE_height", @"SecE_weight",@"SecE_Q1B", @"SecE_Q3", @"SecE_Q4", @"SecE_Q5", @"SecE_Q7A", @"SecE_Q7B", @"SecE_Q7C",@"SecE_Q7D", @"SecE_Q7E",@"SecE_Q7F",@"SecE_Q7G", @"SecE_Q7H", @"SecE_Q7I", @"SecE_Q7J", @"SecE_Q8A", @"SecE_Q8B", @"SecE_Q8C", @"SecE_Q10", @"SecE_Q11", @"SecE_Q12", @"SecE_Q13", @"SecE_Q14A", @"SecE_Q14B", @"SecE_Q15",nil];
    
    NSString *key1 = @"";
    if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"1st Life Assured"]) {
        key1 = @"LA1HQ";
    }
    else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"2nd Life Assured"]) {
        key1 = @"LA2HQ";
    }
    else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"Payor"]) {
        key1 = @"POHQ";
    }
    //for (NSString *key1 in keys1) {
    for (NSString *key2 in keys2) {
        if ([[obj.eAppData objectForKey:@"SecE"] objectForKey:key1]) {
            // NSLog(@"key1: %@, key2: %@, Value:%@",key1, key2, [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key1] objectForKey:key2]);
            if (![[[obj.eAppData objectForKey:@"SecE"] objectForKey:key1] objectForKey:key2]) {
                return FALSE;
            }
        }
        else {
            return FALSE;
        }
    }
    //}
    
	
    //[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key1] setValue:@"Y" forKey:@"Saved"];
	if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"1st Life Assured"]) {
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] setValue:@"Y" forKey:@"Saved"];
    }
    else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"2nd Life Assured"]) {
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"Saved"];
    }
    else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"Payor"]) {
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"Saved"];
    }
    [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Saved"];
    //Changes by satya for 3220
    //need to check number of ppl then confirm all is saved before SecE can be completed
    //
    //    if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"count"] intValue] == 1 && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"Saved"] isEqualToString:@"Y"]) {
    //
    //        [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Saved"];
    //        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
    //        imageView.hidden = FALSE;
    //        imageView = nil;
    //        self.SummaryVC.tickHealthQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    //
    //        self.SummaryVC.tickHealthQuestions.text = @"✓";
    //    }
    //    else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"count"] intValue] == 2 && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"Saved"] isEqualToString:@"Y"] && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"Saved"] isEqualToString:@"Y"]) {
    //
    //        [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Saved"];
    //        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
    //        imageView.hidden = FALSE;
    //        imageView = nil;
    //
    //        self.SummaryVC.tickHealthQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    //
    //        self.SummaryVC.tickHealthQuestions.text = @"✓";
    //    }
    //	else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"count"] intValue] == 3 && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"Saved"] isEqualToString:@"Y"] && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"Saved"] isEqualToString:@"Y"]) {
    //        [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Saved"];
    //        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
    //        imageView.hidden = FALSE;
    //        imageView = nil;
    //
    //        self.SummaryVC.tickHealthQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    //
    //        self.SummaryVC.tickHealthQuestions.text = @"✓";
    //    }
    //
    [self tickMarkForSecE];
    
    return TRUE;
    /*if(self.HealthVC.PersonTypeLb.text.length == 0)
     {
     [self.HealthVC.PersonTypeLb becomeFirstResponder];
     
     return FALSE;
     
     }
     else if(self.HealthVC.txtHeight.text.length == 0)
     {
     [self.HealthVC.txtHeight becomeFirstResponder];
     
     return FALSE;
     
     }
     else if(self.HealthVC.txtWeight.text.length == 0)
     {
     [self.HealthVC.txtWeight becomeFirstResponder];
     
     return FALSE;
     }
     else if(self.HealthVC.segQ1B.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ2.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ3.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ5.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ6.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ7A.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ7B.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ7C.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ7D.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ7E.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ7F.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ7G.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ7H.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ7I.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ7J.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ8A.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ8A.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ8B.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ8C.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ8D.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ8E.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ9.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ10.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ11.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ12.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ13.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ14A.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ14B.selectedSegmentIndex == -1)
     return FALSE;
     
     else if(self.HealthVC.segQ15.selectedSegmentIndex == -1)
     return FALSE;
     
     else{
     
     //Save Health  Questions
     
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Saved"];
     [[obj.eAppData objectForKey:@"SecE"] setValue:self.HealthVC.PersonTypeLb.text forKey:@"SecE_personType"];
     [[obj.eAppData objectForKey:@"SecE"] setValue:self.HealthVC.txtHeight.text forKey:@"SecE_height"];
     [[obj.eAppData objectForKey:@"SecE"] setValue:self.HealthVC.txtWeight.text forKey:@"SecE_weight"];
     
     if(self.HealthVC.segQ1B.selectedSegmentIndex == 0)
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q1B"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q1B"];
     
     
     if(self.HealthVC.segQ2.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q2"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q2"];
     
     if(self.HealthVC.segQ3.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q3"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q3"];
     
     
     if(self.HealthVC.segQ4.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q4"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q4"];
     
     if(self.HealthVC.segQ5.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q5"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q5"];
     
     if(self.HealthVC.segQ6.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q6"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q6"];
     
     if(self.HealthVC.segQ7A.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q7A"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q7A"];
     
     if(self.HealthVC.segQ7B.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q7B"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q7B"];
     
     
     if(self.HealthVC.segQ7C.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q7C"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q7C"];
     
     
     if(self.HealthVC.segQ7D.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q7D"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q7D"];
     
     
     if(self.HealthVC.segQ7E.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q7E"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q7E"];
     
     if(self.HealthVC.segQ7F.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q7F"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q7F"];
     
     if(self.HealthVC.segQ7G.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q7G"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q7G"];
     
     if(self.HealthVC.segQ7H.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q7H"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q7H"];
     
     if(self.HealthVC.segQ7I.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q7I"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q7I"];
     
     if(self.HealthVC.segQ7J.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q7J"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q7J"];
     
     if(self.HealthVC.segQ8A.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q8A"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q8A"];
     
     if(self.HealthVC.segQ8B.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q8B"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q8B"];
     
     if(self.HealthVC.segQ8C.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q8C"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q8C"];
     
     if(self.HealthVC.segQ8D.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q8D"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q8D"];
     
     if(self.HealthVC.segQ8E.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q8E"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q8E"];
     
     if(self.HealthVC.segQ9.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q9"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q9"];
     
     if(self.HealthVC.segQ10.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q10"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q10"];
     
     if(self.HealthVC.segQ11.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q11"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q11"];
     
     if(self.HealthVC.segQ12.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q12"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q12"];
     
     if(self.HealthVC.segQ13.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q13"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q13"];
     
     if(self.HealthVC.segQ14A.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q14A"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q14A"];
     
     if(self.HealthVC.segQ14B.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q14B"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q14B"];
     
     if(self.HealthVC.segQ15.selectedSegmentIndex == 0 )
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Q15"];
     else
     [[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"SecE_Q15"];
     
     
     return TRUE;
     
     }*/
    
}

-(BOOL)EmptyAnswer {
	
	//ENS, test checking if selected yes, but answer is empty.
	NSString *key = @"";
	if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"1st Life Assured"]) {
        key = @"LA1HQ";
    }
    else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"2nd Life Assured"]) {
        key = @"LA2HQ";
    }
    else if ([_HealthQuestionsVC.personTypeLbl.text isEqualToString:@"Payor"]) {
        key = @"POHQ";
    }
	
    //	NSString* text1 = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"Q15_weight"];
    //    NSString* text2 = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"Q15_days"];
	
	
	if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q1B"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q1"]] isEqualToString:@""] || ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q1"] == NULL)))
        
        
        
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 1(b)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
    //	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q2"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q2"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q2"] == NULL))
    //	{
    //		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 2." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //		alert.tag = 80000;
    //		[alert show];
    //		return true;
    //	}
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q3"] isEqualToString:@"Y"]
            && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q3_beerTF"]] isEqualToString:@""]
                || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q3_beerTF"] == NULL)
            && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q3_wineTF"]] isEqualToString:@""]
                || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q3_wineTF"] == NULL)
            && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q3_wboTF"]] isEqualToString:@""]
                || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q3_wboTF"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 3." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
    //	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q4"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q4"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q4"] == NULL))
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q4"] isEqualToString:@"Y"]
            && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q4_cigarettesTF"]] isEqualToString:@""]
                || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q4_cigarettesTF"] == NULL)
            && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q4_pipeTF"]] isEqualToString:@""]
                || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q4_pipeTF"] == NULL)
            && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q4_cigarTF"]] isEqualToString:@""]
                || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q4_cigarTF"] == NULL) && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q4_eCigarTF"]] isEqualToString:@""]
                                                                                                                    || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q4_eCigarTF"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 3." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q5"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q5"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q5"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 5." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
    //	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q6"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q6"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q6"] == NULL))
    //	{
    //		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 6." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //		alert.tag = 80000;
    //		[alert show];
    //		return true;
    //	}
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7A"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 7(a)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7B"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7b"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7b"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 7(b)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7C"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7c"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7c"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 7(c)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
    else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7D"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7d"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7d"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 7(d)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7E"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7e"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7e"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 7(e)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7F"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7f"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7f"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 7(f)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7G"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7g"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7g"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 7(g)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7H"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7h"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7h"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 7(h)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7I"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7i"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7i"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 7(i)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7J"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7j"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7j"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 7(j)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q8A"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q8"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q8"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 8(i)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q8B"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q8b"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q8b"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 8(ii)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q8C"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q8c"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q8c"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 8(iii)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
    //	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q8D"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q8d"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q8d"] == NULL))
    //	{
    //		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 8(iv)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //		alert.tag = 80000;
    //		[alert show];
    //		return true;
    //	}
    //	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q8E"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q8e"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q8e"] == NULL))
    //	{
    //		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 8(v)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //		alert.tag = 80000;
    //		[alert show];
    //		return true;
    //	}
    //	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q9"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q9"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q9"] == NULL))
    //	{
    //		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 9." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //		alert.tag = 80000;
    //		[alert show];
    //		return true;
    //	}
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q10"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q10"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q10"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 10." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q11"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q11"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q11"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 11." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q12"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q12"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q12"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 12." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q13"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q13"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q13"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 13." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q14A"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q14"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q14"] == NULL) && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q14_monthsTF"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q14_monthsTF"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 7(a)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q14B"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q14b"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q14b"] == NULL))
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 7(b)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
	else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q15"] isEqualToString:@"Y"] && ([[textFields trimWhiteSpaces:[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q15_days"]] isEqualToString:@""] || [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q15_days"] == NULL))
	{
        
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please complete Question 15." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 80000;
		[alert show];
		return true;
	}
    
	
	return false;
}


-(BOOL)validSecF
{
    NSString *occup =  [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"LA_Occupation"];
    
   	if (![occup isEqualToString:@"OCC01082"] && ![occup isEqualToString:@"OCC01105"] && ![occup isEqualToString:@"OCC01109"] && ![occup isEqualToString:@"OCC00209"] && ![occup isEqualToString:@"OCC01179"] && ![occup isEqualToString:@"OCC01360"] && ![occup isEqualToString:@"OCC00570"] && ![occup isEqualToString:@"OCC01961"] && ![occup isEqualToString:@"OCC01962"] && ![occup isEqualToString:@"OCC02321"] && ![occup isEqualToString:@"OCC01596"] && ![occup isEqualToString:@"OCC02147"] && ![occup isEqualToString:@"OCC02149"])
    {
        
        return TRUE;
    }
    
    if([textFields trimWhiteSpaces:self.AddQuestVC.nameTF.text].length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Husband/Father/Mother’s Name is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 20001;
        [alert show];
        alert = nil;
        return FALSE;
    }
    else if ([textFields validateString:self.AddQuestVC.nameTF.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid Name format. Same alphabet cannot be repeated more than three times." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 20001;
        [alert show];
        alert = nil;
        return FALSE;
    }
    else if ([textFields validateString3:self.AddQuestVC.nameTF.text]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 20001;
		[alert show];
        return FALSE;
    }
	else if ([textFields validateString:self.AddQuestVC.nameTF.text])
    {
		[Utility showAllert:@"Invalid name format. Same alphabet cannot be repeated more than three times."];
        [self.AddQuestVC.nameTF becomeFirstResponder];
		return FALSE;
    }
    else if(self.AddQuestVC.incomeTF.text.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Husband/Parent’s Yearly Income is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 20003;
		[alert show];
        return FALSE;
    }
    else if ([self.AddQuestVC.incomeTF.text isEqualToString:@"0.00"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Husband/Parent’s yearly income must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 20003;
		[alert show];
        return FALSE;
    }
    else if(self.AddQuestVC.occupationLbl.text.length == 0)
    {
        [Utility showAllert:@"Occupation of Husband/Parent is required."];
        [self.AddQuestVC.occupationLbl becomeFirstResponder];
        return FALSE;
    }
	else if([self.AddQuestVC.occupationLbl.text isEqualToString:@"- SELECT -"])
    {
        [Utility showAllert:@"Occupation of Husband/Parent is required."];
        [self.AddQuestVC.occupationLbl becomeFirstResponder];
        return FALSE;
    }
    else if(self.AddQuestVC.insuredSC.selectedSegmentIndex == -1)
    {
        [Utility showAllert:@"Insured is required."];
        return FALSE;
    }
    else if(self.AddQuestVC.insuredSC.selectedSegmentIndex == 0)
    {
        self.AddQuestVC.addInsurerd.enabled = TRUE;
        
        int c = [[[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"] count];
        
        if(c == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Full details of husband/parent are required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 20002;
            [alert show];
            alert = nil;
            return FALSE;
        }
        
        
    }
    else if(self.AddQuestVC.insuredSC.selectedSegmentIndex == 1)
    {
        if([textFields trimWhiteSpaces:self.AddQuestVC.reasonTF.text].length == 0)
        {
            //[Utility showAllert:@"Reason is required."];
            //return FALSE;
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Reason is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 20004;
            [alert show];
            alert = nil;
            return FALSE;
        }
        
    }
    else if(self.AddQuestVC.insuredSC.selectedSegmentIndex == 1)
    {
        self.AddQuestVC.addInsurerd.enabled = FALSE;
    }
    
    
    [[obj.eAppData objectForKey:@"SecF"] setValue:self.AddQuestVC.nameTF.text forKey:@"Name"];
    [[obj.eAppData objectForKey:@"SecF"] setValue:self.AddQuestVC.incomeTF.text forKey:@"Income"];
    [[obj.eAppData objectForKey:@"SecF"] setValue:self.AddQuestVC.occupationLbl.text forKey:@"Occupation"];
	if (self.AddQuestVC.insuredSC.selectedSegmentIndex == 0) {
		[[obj.eAppData objectForKey:@"SecF"] setValue:@"True" forKey:@"Insured"];
	}
	else {
		[[obj.eAppData objectForKey:@"SecF"] setValue:@"False" forKey:@"Insured"];
	}
    [[obj.eAppData objectForKey:@"SecF"] setValue:self.AddQuestVC.reasonTF.text forKey:@"No_Reason"];
    return TRUE;
    
    
}


-(BOOL)validSecG
{
    
	
    if(self.DeclareVC.agreed == 0 && self.DeclareVC.disagreed == 0 )
    {
        [Utility showAllert:@"Declaration is required."];
        return FALSE;
    }
    else{
        
		if(self.DeclareVC.agreed == 1)
        {
			[[obj.eAppData objectForKey:@"SecG"] setValue:@"Y" forKey:@"Declaration_agree"];
		}
		else if (self.DeclareVC.disagreed == 1)
        {
			[[obj.eAppData objectForKey:@"SecG"] setValue:@"N" forKey:@"Declaration_agree"];
            //  [Utility showAllert:@"Please check on either one of the option under Part 10: Foreign Account Tax Compliance Act (FATCA)."];
            // return FALSE;
		}
		
    }
    
    if([self.DeclareVC.CaseType isEqualToString:@"Individual"])
    {
        if ([self.DeclareVC.PersonChoice isEqualToString:@""]||self.DeclareVC.PersonChoice ==Nil)
        {
			[[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"Declaration_agree"];
			
            [Utility showAllert:@"FATCA's declaration for 1st Life Assured / Policy Owner is required."];
            return FALSE;
        }
        
        else
        {
            
            
            return TRUE;
        }
    }
    
    else if ([self.DeclareVC.CaseType isEqualToString:@"Company"])
    {
        if ([self.DeclareVC.PersonChoice isEqualToString:@""]||self.DeclareVC.PersonChoice ==Nil)
        {
			[[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"Declaration_agree"];
            [Utility showAllert:@"FATCA's declaration for 1st Life Assured / Policy Owner is required."];
            return FALSE;
        }
        
        else if([self.DeclareVC.BizCategoryChoice isEqualToString:@""]||self.DeclareVC.BizCategoryChoice ==Nil)
        {
			[[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"Declaration_agree"];
            [Utility showAllert:@"Declaration is required for Business Classification."];
            return FALSE;
        }
        
        else if([self.DeclareVC.BizCategoryChoice isEqualToString:@"4"])
        {
            
            if([textFields trimWhiteSpaces:self.DeclareVC.FATCATV.text].length == 0)
            {
                [Utility showAllert:@"FATCA Classification is required"];
				[[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"Declaration_agree"];
                return FALSE;
                
            }
            
            else if ([textFields trimWhiteSpaces:self.DeclareVC.GIINTF.text].length == 0)
            {
                [Utility showAllert:@"GIIN is required"];
				[[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"Declaration_agree"];
                return FALSE;
                
            }
            return TRUE;
            
        }
        
        else if([self.DeclareVC.BizCategoryChoice isEqualToString:@"5"])
        {
            
            if([self.DeclareVC.EntityType isEqualToString:@""]||self.DeclareVC.EntityType ==Nil)
            {
                [Utility showAllert:@"The categories of the entity is required"];
				[[obj.eAppData objectForKey:@"SecG"] setValue:@"" forKey:@"Declaration_agree"];
                return FALSE;
                
                
            }
            return TRUE;
            
        }
        
        else
        {
            return TRUE;
        }
        
        
    }
    
    else
    {
        return TRUE;
    }
    
    
	
}

-(void)showKeyBoard{
    
    if ([_HealthQuestionsVC.personTypeLbl.text hasPrefix:@"1st"]) {
        
        HealthQuestions1stLA* currentViewLA=(HealthQuestions1stLA *)_HealthQuestionsVC.hq1stLA;
        
        UITextField* heighttextField=(UITextField *)[currentViewLA.view viewWithTag:500];
        UITextField* weighttextField=(UITextField *)[currentViewLA.view viewWithTag:501];
        
        if (heighttextField.text.length==0 || [heighttextField.text intValue]<=0) {
            
            [heighttextField becomeFirstResponder];
        }
        else if (weighttextField.text.length==0 || [weighttextField.text intValue]<=0) {
            
            [weighttextField becomeFirstResponder];
        }
    }
    else if ([_HealthQuestionsVC.personTypeLbl.text hasPrefix:@"2nd"]) {
        
        
        HealthQuestions2ndLA* currentViewLA=(HealthQuestions2ndLA *)_HealthQuestionsVC.hq2ndLA;
        UITextField* heighttextField=(UITextField *)[currentViewLA.view viewWithTag:500];
        UITextField* weighttextField=(UITextField *)[currentViewLA.view viewWithTag:501];
        
        if (heighttextField.text.length==0 || [heighttextField.text intValue]<=0) {
            
            [heighttextField becomeFirstResponder];
        }
        else if (weighttextField.text.length==0 || [weighttextField.text intValue]<=0) {
            
            [weighttextField becomeFirstResponder];
        }
        
        
    }
    else {//
        
        HealthQuestionsPO* currentViewLA=(HealthQuestionsPO *)_HealthQuestionsVC.hqPo;
        UITextField* heighttextField=(UITextField *)[currentViewLA.view viewWithTag:500];
        UITextField* weighttextField=(UITextField *)[currentViewLA.view viewWithTag:501];
        
        if (heighttextField.text.length==0 || [heighttextField.text intValue]<=0) {
            
            [heighttextField becomeFirstResponder];
        }
        else if (weighttextField.text.length==0 || [weighttextField.text intValue]<=0) {
            
            [weighttextField becomeFirstResponder];
        }
        
        
    }
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
    [db open];
    NSString *POOtherIDType;
    results4 = [db executeQuery:@"select LAOtherIDType from eProposal_LA_Details where eProposalNo = ? AND POFlag = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"N"];
	
	while ([results4 next]) {
		POOtherIDType = [results4 objectForColumnName:@"LAOtherIDType"];
    }
    if (alertView.tag==1400) {
        
        if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"count"] intValue] == 1 && [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_height"])
        {
			//NSLog(@"emi: la1");
            
        }
        else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"count"] intValue] == 2 && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_height"]length]>0 && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_height"]length]>0 )
        {
            // NSLog(@"emi: la2");
        }
        else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"count"] intValue] == 3 && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_height"]length]>0 && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_height"]length]>0 )
        {
            //[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Saved"];
            // NSLog(@"emi: py");
        }
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"count"] intValue] == 4 && [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_height"])
        {
            //NSLog(@"emi: po");
        }
        
        else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"count"] intValue] == 3 && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_height"]length]>0 && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_height"]length] ==0 )
        {
            [Utility showAllert:@"Payor Health Questions are incomplete"];
        }
        
        else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"count"] intValue] == 3 && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_height"]length]==0 && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_height"]length] >0  && ![POOtherIDType isEqualToString:@"EDD"])
        {
            [Utility showAllert:@"1st Life Assured Health Questions are incomplete"];
        }
        
        else if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_height"]length]>0 && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_height"]length] ==0 )
        {
            [Utility showAllert:@"2nd Life Assured Health Questions are incomplete"];
        }
        
        else if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"SecE_height"]length]==0 && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_height"]length] >0 )
        {
            [Utility showAllert:@"1st Life Assured Health Questions are incomplete"];
        }
        
        
        else if(![POOtherIDType isEqualToString:@"EDD"])
        {
            
            
            
            
            
            [Utility showAllert:@"Health Questions are incomplete."];
        }
        
    }
    else if (alertView.tag == 1001 && buttonIndex == 0)
    {
        alertMsg = @"Record saved successfully.";
    }
    else if (alertView.tag == 1002 && buttonIndex == 0)
    {
        
        if ([self validSecE]){
            
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
            //[Utility showAllert:@"Record saved successfully."];
			[self saveEApp];
        }
        else
            [Utility showAllert:@"Please answer all questions."];
        
    }
    
	if (alertView.tag == 400) {
		[_PolicyVC.accNoTF becomeFirstResponder];
	}
	else if (alertView.tag == 500) {
		[_PolicyVC.expiryDateTF becomeFirstResponder];
	}
    else if (alertView.tag == 501) {
        [_PolicyVC.expiryDateYearTF becomeFirstResponder];
    }
	else if (alertView.tag == 601) {
		[_PolicyVC.memberNameTF becomeFirstResponder];
	}
	else if (alertView.tag == 602) {
		[_PolicyVC.memberNameTF becomeFirstResponder];
	}
	else if (alertView.tag == 605) {
		[_PolicyVC.memberIC becomeFirstResponder];
	}
	else if (alertView.tag == 606) {
		[_PolicyVC.memberOtherIDTF becomeFirstResponder];
	}
	else if (alertView.tag == 607) {
		[_PolicyVC.memberContactNoPrefixCF becomeFirstResponder];
	}
	else if (alertView.tag == 608) {
		[_PolicyVC.memberContactNoTF becomeFirstResponder];
	}
    else if (alertView.tag == 10001) {
        [_PolicyVC.agentNameTF becomeFirstResponder];
    }
    else if (alertView.tag == 10002) {
        [_PolicyVC.agentContactNoTF becomeFirstResponder];
    }
    else if (alertView.tag == 10003) {
        [_PolicyVC.agentCodeTF becomeFirstResponder];
    }
	else if (alertView.tag == 10004) {
        [_PolicyVC.agentContactNoPrefixTF becomeFirstResponder];
    }
	else if (alertView.tag == 4001) {
		[_PolicyVC.FTaccNoTF becomeFirstResponder];
	}
	else if (alertView.tag == 5001) {
		[_PolicyVC.FTexpiryDateTF becomeFirstResponder];
	}
    else if (alertView.tag == 5011) {
        [_PolicyVC.FTexpiryDateYearTF becomeFirstResponder];
    }
	else if (alertView.tag == 6011) {
		[_PolicyVC.FTmemberNameTF becomeFirstResponder];
	}
	else if (alertView.tag == 6021) {
		[_PolicyVC.FTmemberNameTF becomeFirstResponder];
	}
	else if (alertView.tag == 6051) {
		[_PolicyVC.FTmemberIC becomeFirstResponder];
	}
	else if (alertView.tag == 6061) {
		[_PolicyVC.FTmemberOtherIDTF becomeFirstResponder];
	}
	else if (alertView.tag == 6071) {
		[_PolicyVC.FTmemberContactNoPrefixCF becomeFirstResponder];
	}
	else if (alertView.tag == 6081) {
		[_PolicyVC.FTmemberContactNoTF becomeFirstResponder];
	}
	else if (alertView.tag == 2000) {
		[_eAppPersonalDataVC.fullNameTF becomeFirstResponder];
	}
	else if (alertView.tag == 3000) {
		[_eAppPersonalDataVC.icNoTF becomeFirstResponder];
	}
	else if (alertView.tag == 6000) {
		[_eAppPersonalDataVC.telPhoneNoPrefixTF becomeFirstResponder];
	}
	else if (alertView.tag == 6002) {
		[_eAppPersonalDataVC.telNoTF becomeFirstResponder];
	}
    else if (alertView.tag == 6001) {
        [_eAppPersonalDataVC.mobilePrefixTF becomeFirstResponder];
    }
	else if (alertView.tag == 6003) {
        [_eAppPersonalDataVC.mobileTF becomeFirstResponder];
    }
	else if (alertView.tag == 7000) {
		[_eAppPersonalDataVC.otherIDTF becomeFirstResponder];
	}
	else if (alertView.tag == 9001) {
		[_eAppPersonalDataVC.addressTF becomeFirstResponder];
	}
	else if (alertView.tag == 9002) {
		[_eAppPersonalDataVC.postcodeTF becomeFirstResponder];
	}
	else if (alertView.tag == 9003) {
		[_eAppPersonalDataVC.postcodeTF becomeFirstResponder];
	}
	else if (alertView.tag == 9004) {
		[_eAppPersonalDataVC.CRaddressTF becomeFirstResponder];
	}
	else if (alertView.tag == 9005) {
		[_eAppPersonalDataVC.CRpostcodeTF becomeFirstResponder];
	}
	else if (alertView.tag == 9006) {
		[_eAppPersonalDataVC.CRcountryLbl becomeFirstResponder];
	}
    else if (alertView.tag == 20001) {
        [_AddQuestVC.nameTF becomeFirstResponder];
    }
    else if (alertView.tag == 20002) {
        [_AddQuestVC.reasonTF becomeFirstResponder];
    }
    else if (alertView.tag == 20003) {
        [_AddQuestVC.incomeTF becomeFirstResponder];
    }
	else if (alertView.tag == 20004) {
        [_AddQuestVC.reasonTF becomeFirstResponder];
    }
	else if (alertView.tag == 80001) {
		[_HealthQuestions1stLA.txtHeight becomeFirstResponder];
        //[_HealthQuestions1stLA.txtHeight becomeFirstResponder];
        [self showKeyBoard];
    }
	else if (alertView.tag == 80002)
    {
        [_HealthQuestions1stLA.txtWeight becomeFirstResponder];
        [self showKeyBoard];
    }
    else if (alertView.tag == 444)
    {
        [self dismissViewControllerAnimated:YES completion:Nil];
    }
    else if (alertView.tag == 999)
    {
        if (buttonIndex == 0) {
            BOOL success = [self DoDone2];
			if (success == YES) {
				//[self dismissViewControllerAnimated:TRUE completion:nil];
				//[self dismissModalViewControllerAnimated:YES];
				[self FlagProposal];
			}
            // [self deletePDFs];
        }
		else{
			[[obj.eAppData objectForKey:@"EAPP"] setValue:@"0" forKey:@"EAPPSave"];
			Proceed = YES;
			[self reloadData];
			[self dismissViewControllerAnimated:TRUE completion:nil];
		}
    }
	else if (alertView.tag == 998) {
        if (buttonIndex == 0)
		{
            PopUpAlert = NO;
            Proceed = [self DoDone2];
            
			if (Proceed == NO) {
				[self nextStoryboard:nil];
				[myTableView selectRowAtIndexPath:previousPath animated:NO scrollPosition:NO];
				selectedPath = previousPath;
			}
			else
				[self nextStoryboard:CurrentP];
            
            // [self deletePDFs];
        }
		else
		{
			[[obj.eAppData objectForKey:@"EAPP"] setValue:@"0" forKey:@"EAPPSave"];
			Proceed = YES;
			[self reloadData];
			[self nextStoryboard:CurrentP];
		}
    }
}

- (void)saveEApp {
	
	//####### Change desc to code when save to DB ##############
    
    //get country code
	
	//Sec A, Contingent Owner
	NSString *CORelationship = [self getRelationshipCode:[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Relationship"]];
	NSString *COState = [self getStateCode:[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"State"]];
	NSString *COCountry = [self getCountryCode:[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Country"]];
	NSString *COCRState = [self getStateCode:[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRState"]];
	NSString *COCRCountry = [self getCountryCode:[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRCountry"]];
    
	if ([COState isEqualToString:@"State"]) {
		COState = @"";
	}
	if ([COCRState isEqualToString:@"State"]) {
		COCRState = @"";
	}
    
	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"OtherIDType"] isEqualToString:@""] || [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"OtherIDType"] == NULL) {
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"" forKey:@"OtherIDType"];
	}
	
	NSString *title = [self getTitleCode:[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Title"]];
	
	
	// Check if telNo already combine with prefix or not: ADD BY EMI 09/06/2014
	NSString *phoneNo = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TelNo"];
	NSArray *phoneNoAry = [phoneNo componentsSeparatedByString:@" "];
	if (phoneNoAry.count > 1) {
		phoneNo = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TelNo"];
	}
	else {
        //		NSString *prefix = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TelNoPrefix"];
        //		NSString *telno = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TelNo"];
		phoneNo = @"";
	}
	
	
	// Check if MobileNo already combine with prefix or not: ADD BY EMI 09/06/2014
	NSString *MobileNo = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"MobileNo"];
	NSArray *MobileNoAry = [MobileNo componentsSeparatedByString:@" "];
	if (MobileNoAry.count > 1) {
		MobileNo = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"MobileNo"];
	}
	else {
        //		NSString *prefixM = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"MobileNoPrefix"];
        //		NSString *telnoM = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"MobileNo"];
		MobileNo = @"";
	}
	
	//Sec D
	
    NSString *Nominee1_countrycode = [self getCountryCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_countryTF"]];
	NSString *Nominee2_countrycode = [self getCountryCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_countryTF"]];
	NSString *Nominee3_countrycode = [self getCountryCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_countryTF"]];
	NSString *Nominee4_countrycode = [self getCountryCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_countryTF"]];
    
    NSString *Nominee1_CRcountrycode = [self getCountryCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRcountryTF"]];
	NSString *Nominee2_CRcountrycode = [self getCountryCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_CRcountryTF"]];
	NSString *Nominee3_CRcountrycode = [self getCountryCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_CRcountryTF"]];
	NSString *Nominee4_CRcountrycode = [self getCountryCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_CRcountryTF"]];
    
	
	
	NSString *Nominee1_occupationcode = [self getOccupationCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_Occupation"]];
	NSString *Nominee2_occupationcode = [self getOccupationCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_Occupation"]];
    NSString *Nominee3_occupationcode = [self getOccupationCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_Occupation"]];
    NSString *Nominee4_occupationcode = [self getOccupationCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_Occupation"]];
    
	NSString *Nominee1_nationalitycode = [self getNationalityCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_nationality"]];
	NSString *Nominee2_nationalitycode = [self getNationalityCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_nationality"]];
	NSString *Nominee3_nationalitycode = [self getNationalityCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_nationality"]];
	NSString *Nominee4_nationalitycode = [self getNationalityCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_nationality"]];
    
    
    NSString *Trustee_countrycode = [self getCountryCode:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Country"]];
	NSString *Trustee2_countrycode = [self getCountryCode:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TCountry"]];
	
	NSString *Nominee1_statecode = [self getStateCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_stateTF"]];
    if ([Nominee1_statecode isEqualToString:@"State"])
		Nominee1_statecode = @"";
	NSString *Nominee2_statecode = [self getStateCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_stateTF"]];
    if ([Nominee2_statecode isEqualToString:@"State"])
		Nominee2_statecode = @"";
	NSString *Nominee3_statecode = [self getStateCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_stateTF"]];
    if ([Nominee3_statecode isEqualToString:@"State"])
		Nominee3_statecode = @"";
	NSString *Nominee4_statecode = [self getStateCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_stateTF"]];
    if ([Nominee4_statecode isEqualToString:@"State"])
		Nominee4_statecode = @"";
    
    NSString *Nominee1_CRstatecode = [self getStateCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRstateTF"]];
    if ([Nominee1_CRstatecode isEqualToString:@"State"])
		Nominee1_CRstatecode = @"";
	NSString *Nominee2_CRstatecode = [self getStateCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_CRstateTF"]];
    if ([Nominee2_CRstatecode isEqualToString:@"State"])
		Nominee2_CRstatecode = @"";
	NSString *Nominee3_CRstatecode = [self getStateCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_CRstateTF"]];
    if ([Nominee3_CRstatecode isEqualToString:@"State"])
		Nominee3_CRstatecode = @"";
	NSString *Nominee4_CRstatecode = [self getStateCode:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_CRstateTF"]];
    if ([Nominee4_CRstatecode isEqualToString:@"State"])
		Nominee4_CRstatecode = @"";
    
    NSString *Trustee_stateCode = [self getStateCode:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"State"]];
    if ([Trustee_stateCode isEqualToString:@"State"])
		Trustee_stateCode = @"";
	NSString *Trustee2_stateCode = [self getStateCode:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TState"]];
    if ([Trustee2_stateCode isEqualToString:@"State"])
		Trustee2_stateCode = @"";
	
	NSString *Trustee_samePO, * Trustee2_samePO;
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"SamePO"] isEqualToString:@"true"]) {
		Trustee_samePO = @"Y";
	}
	else
		Trustee_samePO = @"N";
    
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TSamePO"] isEqualToString:@"true"]) {
		Trustee2_samePO = @"Y";
	}
	else
		Trustee2_samePO = @"N";
	
	NSString *Occupation = [self getOccupationCode:[[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Occupation"]];
    NSString *Occupation1 = [self getOccupationCode:[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Occupation"]];
    NSString *Country11 = [self getNationalityCode:[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Nationality"]];
	//##################
	
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
    if (![db open]) {
        NSLog(@"Could not open db.");
    }
    [db beginTransaction];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *commDate = [dateFormatter stringFromDate:[NSDate date]];
	
	
	NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
	NSDate *currDate = [NSDate date];
	[dateFormatter2 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
	NSString *dateString = [dateFormatter2 stringFromDate:currDate];
	
    int lastId;
	
    
    lastId = [db lastInsertRowId];
    [[obj.eAppData objectForKey:@"EAPP"] setValue:[NSString stringWithFormat:@"%d",lastId] forKey:@"lastId"];
    
    results2 = Nil;
    results2 = [db executeQuery:@"select * from eProposal where SINo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
    while ([results2 next]) {
        [[obj.eAppData objectForKey:@"EAPP"] setValue:[results2 stringForColumn:@"eProposalNo"] forKey:@"eProposalID"];
    }
    //	}
	
	lastId = [[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"lastId"] intValue];
	
	//UPDATE EAPP_VERSION TO LATEST
	//### START
	
	NSString *eAppVersion;
	results2 = Nil;
    results2 = [db executeQuery:@"select * from eProposal_Version_Details", Nil];
    while ([results2 next]) {
        eAppVersion = [results2 stringForColumn:@"eAppVersion"];
    }
	
	NSString *queryA = @"";
	queryA = [NSString stringWithFormat:@"UPDATE eProposal SET eAppVersion = '%@' WHERE eProposalNo = '%@'", eAppVersion, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]];
	[db executeUpdate:queryA];
	
	//### END
	
	//Update dateUpdated
	
	NSString *queryB = @"";
	queryB = [NSString stringWithFormat:@"UPDATE eApp_Listing SET DateUpdated = '%@' WHERE ProposalNo = '%@'", dateString, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]];
	[db executeUpdate:queryB];
	
	
	//Section A Start
	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SecA_Saved"] isEqualToString:@"Y"]) {
		
        
        if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickPart2"] isEqualToString:@"Y"])
            //	if (_eAppPersonalDataVC.fullNameTF.text.length != 0)
        {
            NSLog(@"update Sec A yes");
			
            //NSLog(@"test save a: %@", [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Title"]);
            NSString *query = @"";
            query = [NSString stringWithFormat:@"UPDATE eProposal SET COMandatoryFlag = '%@', COTitle = '%@', COSex = '%@', COName = '%@', COPhoneNo = '%@', CONewICNo = '%@', COMobileNo = '%@', CODOB = '%@', COEmailAddress = '%@', CONationality = '%@', COOccupation = '%@', CONameOfEmployer = '%@', COExactNatureOfWork = '%@', COOtherIDType = '%@', COOtherID = '%@', CORelationship = '%@', COSameAddressPO = '%@', COAddress1 = '%@', COAddress2 = '%@', COAddress3 = '%@', COPostcode = '%@', COTown = '%@', COState = '%@', COCountry = '%@', COCRAddress1 = '%@', COCRAddress2 = '%@', COCRAddress3 = '%@', COCRPostcode = '%@', COCRTown = '%@', COCRState = '%@', COCRCountry = '%@', UpdatedAt = '%@', LAMandatoryFlag = '%@', COForeignAddressFlag = '%@', COCRForeignAddressFlag = '%@' WHERE eProposalNo = '%@'", [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickPart2"], title, [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Sex"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"FullName"], phoneNo, [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ICNo"], MobileNo, [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"DOB"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Email"], Country11,Occupation1, [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"NameOfEmployer"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ExactNatureOfWork"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"OtherIDType"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"OtherID"], CORelationship, [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SameAddress"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Address1"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Address2"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Address3"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Postcode"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Town"], COState, COCountry,[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRAddress1"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRAddress2"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRAddress3"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRPostcode"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRTown"], COCRState, COCRCountry, commDate, [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SecA_Saved"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ForeignAddress"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRForeignAddress"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]];
            [db executeUpdate:query];
        }
        else if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickPart2"] isEqualToString:@"N"])
        {
            NSLog(@"update a no");
            NSString *query = @"";
            query = [NSString stringWithFormat:@"UPDATE eProposal SET COMandatoryFlag = '%@', UpdatedAt = '%@', LAMandatoryFlag = '%@' , COTitle = '', COSex = '', COName = '', COPhoneNo = '', CONewICNo = '', COMobileNo = '', CODOB = '', COEmailAddress = '', CONationality = '',  COOccupation = '',CONameOfEmployer = '', COExactNatureOfWork = '', COOtherIDType = '', COOtherID = '', CORelationship = '', COSameAddressPO = 'N', COAddress1 = '', COAddress2 = '', COAddress3 = '', COPostcode = '', COTown = '', COState = '', COCountry = '', COCRAddress1 = '', COCRAddress2 = '', COCRAddress3 = '', COCRPostcode = '', COCRTown = '', COCRState = '', COCRCountry = ''  WHERE eProposalNo = '%@'", [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickPart2"], commDate, [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SecA_Saved"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]];
            [db executeUpdate:query];
        }
		
	}
    
	//Section A End
	
	//Section B Start
    /* NSString *str_plan;
     if([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"UV"])
     str_plan = @"HLA EverLife Plus";
     else
     str_plan = @"HLA Cash Promise";
     */
	if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"SecB_Saved"] isEqualToString:@"Y"]) {
        
        NSString *recurringPayment = [textFields trimWhiteSpaces:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"RecurringPayment"]];
        NSString *recurringCode;
        results = nil;
        results = [db executeQuery:@"select PaymentMethodCode from eProposal_Payment_Method where PaymentMethodDesc = ?", recurringPayment, Nil];
        while ([results next]) {
            recurringCode = [results stringForColumn:@"PaymentMethodCode"] != NULL ? [results stringForColumn:@"PaymentMethodCode"] : @"";
        }
        
        NSString *firstTimePayment = [textFields trimWhiteSpaces:[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FirstTimePayment"]];
        NSString *firstTimeCode;
        results = nil;
        results = [db executeQuery:@"select PaymentMethodCode from eProposal_Payment_Method where PaymentMethodDesc = ?", firstTimePayment, Nil];
        while ([results next]) {
            firstTimeCode = [results stringForColumn:@"PaymentMethodCode"] != NULL ? [results stringForColumn:@"PaymentMethodCode"] : @"";
        }
        
        //Added by Andy to save the CreditCard bank code and Card Type -START
        NSString *selectedCreditCardBankCode = @"";
        NSString *selectedCreditCardBank=[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"IssuingBank"];
		int countCCB = 0;
        FMResultSet *results4 = [db executeQuery:@"select * from  eProposal_Credit_Card_Bank where CompanyName = ?",selectedCreditCardBank,Nil];
        while ([results4 next]) {
            selectedCreditCardBankCode = [results4 stringForColumn:@"CompanyCode"];
			countCCB = 1;
		}
        if (countCCB ==0) {
			if (![[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"IssuingBank"] isEqualToString:@""]);
			selectedCreditCardBankCode = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"IssuingBank"];
		}
        
        NSString *selectedCreditCardTypeCode = @"";
        NSString *selectedCreditCardType=[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"];
		int countCCT = 0;
        FMResultSet *results5 = [db executeQuery:@"select * from  eProposal_Credit_Card_Types where CreditCardDesc = ?",selectedCreditCardType,Nil];
        while ([results5 next]) {
            selectedCreditCardTypeCode = [results5 stringForColumn:@"CreditCardCode"];
			countCCT = 1;
		}
		
		if (countCCT == 0) {
			if (![[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"] isEqualToString:@""]) {
				selectedCreditCardTypeCode = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"];}
		}
		
		//FT
		
		NSString *FTselectedCreditCardBankCode = @"";
        NSString *FTselectedCreditCardBank=[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTIssuingBank"];
		int FTcountCCB = 0;
        FMResultSet *resultsFT1 = [db executeQuery:@"select * from  eProposal_Credit_Card_Bank where CompanyName = ?",FTselectedCreditCardBank,Nil];
        while ([resultsFT1 next]) {
            FTselectedCreditCardBankCode = [resultsFT1 stringForColumn:@"CompanyCode"];
			FTcountCCB = 1;
		}
        if (FTcountCCB ==0) {
			if (![[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTIssuingBank"] isEqualToString:@""]);
			FTselectedCreditCardBankCode = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTIssuingBank"];
		}
        
        NSString *FTselectedCreditCardTypeCode = @"";
        NSString *FTselectedCreditCardType=[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTCardType"];
		int FTcountCCT = 0;
        FMResultSet *resultsFT2 = [db executeQuery:@"select * from  eProposal_Credit_Card_Types where CreditCardDesc = ?",FTselectedCreditCardType,Nil];
        while ([resultsFT2 next]) {
            FTselectedCreditCardTypeCode = [resultsFT2 stringForColumn:@"CreditCardCode"];
			FTcountCCT = 1;
		}
		
		if (FTcountCCT == 0) {
			if (![[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTCardType"] isEqualToString:@""]) {
				FTselectedCreditCardTypeCode = [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTCardType"];}
		}
		
        
        
        
        //Added by Andy to save the CreditCard bank code -END
        
        
        
        [db executeUpdate:@"UPDATE eProposal SET PaymentMode = ?, BasicPlanCode = ?, BasicPlanTerm = ?, BasicPlanSA = ?, BasicPlanModalPremium = ?, TotalModalPremium = ?, FirstTimePayment = ?, PaymentUponFinalAcceptance = ?,EPP=?, RecurringPayment = ?, SecondAgentCode = ?, SecondAgentContactNo = ?, SecondAgentName = ?, PTypeCode = ?, CreditCardBank = ?, CreditCardType = ?, CardMemberAccountNo = ?, CardExpiredDate = ?, CardMemberName = ?, CardMemberSex = ?, CardMemberDOB = ?, CardMemberNewICNo = ?, CardMemberOtherIDType = ?, CardMemberOtherID = ?, CardMemberContactNo = ?, CardMemberRelationship = ?, FTPTypeCode = ?, FTCreditCardBank = ?, FTCreditCardType = ?, FTCardMemberAccountNo = ?, FTCardExpiredDate = ?, FTCardMemberName = ?, FTCardMemberSex = ?, FTCardMemberDOB = ?, FTCardMemberNewICNo = ?, FTCardMemberOtherIDType = ?, FTCardMemberOtherID = ?, FTCardMemberContactNo = ?, FTCardMemberRelationship = ?, SameAsFT = ?, FullyPaidUpOption = ?, FullyPaidUpTerm = ?, RevisedSA = ?, AmtRevised = ?, PolicyDetailsMandatoryFlag = ?, LIEN = ?,isDirectCredit = ?,DCBank = ?,DCAccountType = ?,DCAccNo = ?,DCPayeeType = ?,DCNewICNo = ?,DCOtherIDType = ?,DCOtherID = ?,DCEmail = ?,DCMobile = ?,DCMobilePrefix =? ,TotalGSTAmt = ?, TotalPayableAmt = ? WHERE eProposalNo = ?", [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaymentMode"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"Term"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"SumAssured"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"BasicPremium"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"TotalPremium"], firstTimeCode, [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FirstPaymentDeduct"],[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"EPP"], recurringCode, [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"AgentCode"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"AgentContactNo"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"AgentName"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PersonType"], selectedCreditCardBankCode, selectedCreditCardTypeCode, [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardAccNo"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardExpDate"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberName"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberSex"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberDOB"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberIC"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberOtherIDType"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberOtherID"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberContactNo"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberRelationship"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTPersonType"], FTselectedCreditCardBankCode, FTselectedCreditCardTypeCode, [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTCardAccNo"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTCardExpDate"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberName"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberSex"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberDOB"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberIC"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberOtherIDType"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberOtherID"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberContactNo"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FTMemberRelationship"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"SameAsFT"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaidUpOption"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaidUpTerm"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"RevisedSumAssured"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"RevisedAmount"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"SecB_Saved"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"LIEN"],[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"isDirectCredit"],[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCBank"],[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCAccountType"],[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCAccNo"],[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCPayeeType"],[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCNewICNo"],[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCOtherIDType"],[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCOtherID"],[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCEmail"],[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCMobile"],[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"DCMobilePrefix"],[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"TotalGSTAmt"],[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"TotalPayableAmt"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]];
        
        [db executeUpdate:@"DELETE FROM eProposal_Riders where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], nil];
        NSArray *keys = [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"Riders"] allKeys];
        for (NSString *key in keys) {
            [db executeUpdate:@"insert into eProposal_Riders (eProposalNo, RiderCode, Years) values (?,?,?)", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], key, [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"Riders"] objectForKey:key], nil];
        }
        
	}
	//Section B End
	
	//Section C Start
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"SecC_Saved"] isEqualToString:@"Y"]) {
		NSLog(@"update c");
        //		if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"SecB_Saved"] isEqualToString:@"Y"]) {
        NSString *query = @"";
        query = [NSString stringWithFormat:@"UPDATE eProposal SET ExistingPoliciesMandatoryFlag = '%@' WHERE eProposalNo = '%@'",[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"SecC_Saved"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]];
        [db executeUpdate:query];
        //		}
		
        [db executeUpdate:@"DELETE FROM eProposal_Existing_Policy_1 WHERE eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], Nil];
        NSLog(@"error: %@", [db lastErrorMessage]);
        [db executeUpdate:@"DELETE FROM eProposal_Existing_Policy_2 WHERE eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], Nil];
        
        
		
        
		NSLog(@"insert c");
		[db executeUpdate:@"INSERT INTO eProposal_Existing_Policy_1(eProposalNo, ProposalPTypeCode, ExistingPolicy_Answer1, ExistingPolicy_Answer1a, ExistingPolicy_Answer2, ExistingPolicy_Answer3, ExistingPolicy_Answer4, ExistingPolicy_Answer5, Withdraw_CashDividend, CompanyKeep_CashDividend, CashPayment_PO, CashPayment_Acc, blnBackDating, BackDating, PreferredLife, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], @"LA1", [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies1stLA"],[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies1stLACR"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA1stLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeB1stLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeC1stLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeD1stLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"CashDividend"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TradGuaranteedCPI"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TPWithdrawPct"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TPKeepPct"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PolicyBackdating1stLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdating1stLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PreferredLife"], commDate, commDate, Nil];
		
        //		[db executeUpdate:@"INSERT INTO eProposal_Existing_Policy_1(eProposalNo, ProposalPTypeCode, ExistingPolicy_Answer1, ExistingPolicy_Answer2, ExistingPolicy_Answer3, ExistingPolicy_Answer4, ExistingPolicy_Answer5, Withdraw_CashDividend, CompanyKeep_CashDividend, CashPayment_PO, CashPayment_Acc, blnBackDating, BackDating, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], @"PO", [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPoliciesPO"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeAPO"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeBPO"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeCPO"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeDPO"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"CashDividend"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TradGuaranteedCPI"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TPWithdrawPct"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TPKeepPct"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PolicyBackdatingPO"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdatingPO"], commDate, commDate, Nil];
        //
        //		[db executeUpdate:@"INSERT INTO eProposal_Existing_Policy_1(eProposalNo, ProposalPTypeCode, ExistingPolicy_Answer1, ExistingPolicy_Answer2, ExistingPolicy_Answer3, ExistingPolicy_Answer4, ExistingPolicy_Answer5, Withdraw_CashDividend, CompanyKeep_CashDividend, CashPayment_PO, CashPayment_Acc, blnBackDating, BackDating, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], @"LA2", [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies2ndLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA2ndLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeB2ndLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeC2ndLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeD2ndLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"CashDividend"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TradGuaranteedCPI"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TPWithdrawPct"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TPKeepPct"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PolicyBackdating2ndLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdating2ndLA"], commDate, commDate, Nil];
		
		//policy data start
		if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies1stLA"] isEqualToString:@"N"] &&[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies1stLACR"] isEqualToString:@"N"])
        {
			//Delete eProposal_Existing_Policy_2
			if (![db executeUpdate:@"Delete from eProposal_Existing_Policy_2 where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], nil]) {
				NSLog(@"Error in Delete Statement - eProposal_Existing_Policy_2");
			}
		}
		else {
            NSArray *policyKeys = [NSArray arrayWithObjects:@"ExistingPolicy1stLA", @"ExistingPolicy2ndLA", @"ExistingPolicyPO", nil];
            for (NSString *key in policyKeys) {
                NSLog(@"count %@ PD: %d",key, [[[[obj.eAppData objectForKey:@"SecC"] objectForKey:key] objectForKey:@"PolicyData"] count]);
                if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:key] objectForKey:@"PolicyData"] count] != 0) {
                    NSString *pt;
                    NSString *cn;
                    NSString *ltsa;
                    NSString *asa;
                    NSString *cisa;
                    NSString *dhi;
                    NSString *di;
					
					NSString *ptypecode;
					if ([key isEqualToString:@"ExistingPolicy1stLA"])
						ptypecode = @"1st Life Assured";
					else if ([key isEqualToString:@"ExistingPolicy2ndLA"])
						ptypecode = @"2nd Life Assured";
					else if ([key isEqualToString:@"ExistingPolicyPO"])
						ptypecode = @"Policy Owner";
                    
                    for (int i=0; i<[[[[obj.eAppData objectForKey:@"SecC"] objectForKey:key] objectForKey:@"PolicyData"] count]; i++) {
                        pt = [[[[[obj.eAppData objectForKey:@"SecC"] objectForKey:key] objectForKey:@"PolicyData"] objectAtIndex:i] objectAtIndex:0];
                        cn = [[[[[obj.eAppData objectForKey:@"SecC"] objectForKey:key] objectForKey:@"PolicyData"] objectAtIndex:i] objectAtIndex:1];
                        ltsa = [[[[[obj.eAppData objectForKey:@"SecC"] objectForKey:key] objectForKey:@"PolicyData"] objectAtIndex:i] objectAtIndex:2];
                        asa = [[[[[obj.eAppData objectForKey:@"SecC"] objectForKey:key] objectForKey:@"PolicyData"] objectAtIndex:i] objectAtIndex:3];
                        dhi = [[[[[obj.eAppData objectForKey:@"SecC"] objectForKey:key] objectForKey:@"PolicyData"] objectAtIndex:i] objectAtIndex:4];
                        cisa = [[[[[obj.eAppData objectForKey:@"SecC"] objectForKey:key] objectForKey:@"PolicyData"] objectAtIndex:i] objectAtIndex:5];
                        di = [[[[[obj.eAppData objectForKey:@"SecC"] objectForKey:key] objectForKey:@"PolicyData"] objectAtIndex:i] objectAtIndex:6];
                        
                        
                        [db executeUpdate:@"INSERT INTO eProposal_Existing_Policy_2(eProposalNo, PTypeCode, PTypeCodeDesc, ExistingPolicy_Company, ExistingPolicy_LifeTerm, ExistingPolicy_Accident,ExistingPolicy_DailyHospitalIncome, ExistingPolicy_CriticalIllness, ExistingPolicy_DateIssued, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], ptypecode, pt, cn, ltsa, asa,dhi, cisa, di,commDate, commDate, Nil];
                    }
                    
                }
            }
		}
		//policy data end
	}
    else {
        NSString *query = [NSString stringWithFormat:@"UPDATE eProposal SET ExistingPoliciesMandatoryFlag = '%@' WHERE eProposalNo = '%@'",[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"SecC_Saved"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]];
        [db executeUpdate:query];
    }
	//Section C End
    
	//Section D Start
	if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"SecD_Saved"] isEqualToString:@"Y"]) {
		NSString *query = @"";
		query = [NSString stringWithFormat:@"UPDATE eProposal SET NomineesMandatoryFlag = '%@' WHERE eProposalNo = '%@'",[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"SecD_Saved"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]];
		[db executeUpdate:query];
		
        //Nominees Start
        [db executeUpdate:@"DELETE FROM eProposal_NM_Details WHERE eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], Nil];
        
        //	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Trustee1"] isEqualToString:@"1"])
        if ((![_NomineesVC.Nominee1Lbl.text isEqualToString:@"Add Nominee (1)"]))
        {
            NSLog(@"insert dn1");
            [db executeUpdate:@"INSERT INTO eProposal_NM_Details(eProposalNo, NMTitle, NMName, NMNewICNo, NMOtherIDType, NMOtherID, NMDOB, NMSex, NMShare, NMRelationship, NMNAtionality, NMOccupation, NMExactDuties ,NMNameofEmployer, NMSamePOAddress, NMAddress1, NMAddress2, NMAddress3, NMPostcode, NMTown, NMState, NMCountry, NMCRAddress1, NMCRAddress2, NMCRAddress3, NMCRPostcode, NMCRTown, NMCRState, NMCRCountry,CreatedAt, UpdatedAt, NMCHildAlive, NMTrustStatus) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);"
             ,[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_title"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_name"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_ic"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_otherIDType"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_otherID"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_dob"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_gender"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_share"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_relatioship"],
             Nominee1_nationalitycode,
             Nominee1_occupationcode,
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_ExactDuties"],
             
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_nameofemployer"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_Address"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add1TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add2TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add3TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_postcodeTF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_townTF"],
             
             //             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRadd1TF"],
             //             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRadd2TF"],
             //             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRadd3TF"],
             //             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRpostcodeTF"],
             //             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRtownTF"],PREMNATH VIJAYAKUMAR REFER ANDY ON SAVING
             
             Nominee1_statecode,
             Nominee1_countrycode,
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRadd1TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRadd2TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRadd3TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRpostcodeTF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRtownTF"],
             Nominee1_CRstatecode,
             Nominee1_CRcountrycode,
             
             commDate,
             commDate,
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_ChildAlive"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_TrustStatus"], Nil];
            
            //            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_nationality"];
            //            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_ExactDuties"];
            //            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_Occupation"];
            //            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_nameofemployer"];
        }
        else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Delete1stNominee"] isEqualToString:@"1"]) {
            [db executeUpdate:@"DELETE FROM eProposal_NM_Details WHERE eProposalNo = ? and NMNewICNo = ? and NMOtherIDType = ? and NMOtherID = ? ", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_ic"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_otherIDType"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_otherID"], Nil];
        }
        
        if ((![_NomineesVC.Nominee2Lbl.text isEqualToString:@"Add Nominee (2)"]))
        {
            NSLog(@"insert dn2");
            [db executeUpdate:@"INSERT INTO eProposal_NM_Details(eProposalNo, NMTitle, NMName, NMNewICNo, NMOtherIDType, NMOtherID, NMDOB, NMSex, NMShare, NMRelationship, NMNAtionality, NMOccupation, NMExactDuties ,NMNameofEmployer, NMSamePOAddress, NMAddress1, NMAddress2, NMAddress3, NMPostcode, NMTown, NMState, NMCountry, NMCRAddress1, NMCRAddress2, NMCRAddress3, NMCRPostcode, NMCRTown, NMCRState, NMCRCountry,CreatedAt, UpdatedAt, NMCHildAlive, NMTrustStatus) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",
             
             [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_title"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_name"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_ic"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_otherIDType"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_otherID"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_dob"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_gender"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_share"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_relatioship"],
             Nominee2_nationalitycode,
             Nominee2_occupationcode,
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_ExactDuties"],
             
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_nameofemployer"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_Address"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_add1TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_add2TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_add3TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_postcodeTF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_townTF"],
             
             //             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRadd1TF"],
             //             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRadd2TF"],
             //             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRadd3TF"],
             //             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRpostcodeTF"],
             //             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRtownTF"],PREMNATH VIJAYAKUMAR REFER ANDY ON SAVING
             
             Nominee2_statecode,
             Nominee2_countrycode,
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_CRadd1TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_CRadd2TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_CRadd3TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_CRpostcodeTF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_CRtownTF"],
             Nominee2_CRstatecode,
             Nominee2_CRcountrycode,
             
             commDate,
             commDate,
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_ChildAlive"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_TrustStatus"], Nil];
        }
        else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Delete2ndNominee"] isEqualToString:@"1"]) {
            [db executeUpdate:@"DELETE FROM eProposal_NM_Details WHERE eProposalNo = ? and NMNewICNo = ? and NMOtherIDType = ? and NMOtherID = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_ic"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_otherIDType"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_otherID"], Nil];
        }
        
        if ((![_NomineesVC.Nominee3Lbl.text isEqualToString:@"Add Nominee (3)"]))
        {
            NSLog(@"insert dn3");
            [db executeUpdate:@"INSERT INTO eProposal_NM_Details(eProposalNo, NMTitle, NMName, NMNewICNo, NMOtherIDType, NMOtherID, NMDOB, NMSex, NMShare, NMRelationship, NMNAtionality, NMOccupation, NMExactDuties ,NMNameofEmployer, NMSamePOAddress, NMAddress1, NMAddress2, NMAddress3, NMPostcode, NMTown, NMState, NMCountry, NMCRAddress1, NMCRAddress2, NMCRAddress3, NMCRPostcode, NMCRTown, NMCRState, NMCRCountry,CreatedAt, UpdatedAt, NMCHildAlive, NMTrustStatus) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",
             
             [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_title"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_name"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_ic"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_otherIDType"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_otherID"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_dob"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_gender"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_share"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_relatioship"],
             Nominee3_nationalitycode,
             Nominee3_occupationcode,
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_ExactDuties"],
             
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_nameofemployer"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_Address"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_add1TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_add2TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_add3TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_postcodeTF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_townTF"],
             
             //             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRadd1TF"],
             //             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRadd2TF"],
             //             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRadd3TF"],
             //             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRpostcodeTF"],
             //             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRtownTF"],PREMNATH VIJAYAKUMAR REFER ANDY ON SAVING
             
             Nominee3_statecode,
             Nominee3_countrycode,
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_CRadd1TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_CRadd2TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_CRadd3TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_CRpostcodeTF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_CRtownTF"],
             Nominee3_CRstatecode,
             Nominee3_CRcountrycode,
             
             commDate,
             commDate,
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_ChildAlive"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_TrustStatus"], Nil];
        }
        else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Delete3rdNominee"] isEqualToString:@"1"]) {
            [db executeUpdate:@"DELETE FROM eProposal_NM_Details WHERE eProposalNo = ? and NMNewICNo = ? and NMOtherIDType = ? and NMOtherID = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_ic"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_otherIDType"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_otherID"], Nil];
        }
        
        if ((![_NomineesVC.Nominee4Lbl.text isEqualToString:@"Add Nominee (4)"]))
        {
            NSLog(@"insert dn4");
            [db executeUpdate:@"INSERT INTO eProposal_NM_Details(eProposalNo, NMTitle, NMName, NMNewICNo, NMOtherIDType, NMOtherID, NMDOB, NMSex, NMShare, NMRelationship, NMNAtionality, NMOccupation, NMExactDuties ,NMNameofEmployer, NMSamePOAddress, NMAddress1, NMAddress2, NMAddress3, NMPostcode, NMTown, NMState, NMCountry, NMCRAddress1, NMCRAddress2, NMCRAddress3, NMCRPostcode, NMCRTown, NMCRState, NMCRCountry,CreatedAt, UpdatedAt, NMCHildAlive, NMTrustStatus) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",
             
             [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_title"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_name"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_ic"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_otherIDType"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_otherID"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_dob"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_gender"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_share"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_relatioship"],
             Nominee4_nationalitycode,
             Nominee4_occupationcode,
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_ExactDuties"],
             
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_nameofemployer"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_Address"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_add1TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_add2TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_add3TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_postcodeTF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_townTF"],
             
             //             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRadd1TF"],
             //             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRadd2TF"],
             //             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRadd3TF"],
             //             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRpostcodeTF"],
             //             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRtownTF"],PREMNATH VIJAYAKUMAR REFER ANDY ON SAVING
             
             Nominee4_statecode,
             Nominee4_countrycode,
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_CRadd1TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_CRadd2TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_CRadd3TF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_CRpostcodeTF"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_CRtownTF"],
             Nominee4_CRstatecode,
             Nominee4_CRcountrycode,
             
             commDate,
             commDate,
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_ChildAlive"],
             [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_TrustStatus"], Nil];
        }
        else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Delete4thNominee"] isEqualToString:@"1"]) {
            [db executeUpdate:@"DELETE FROM eProposal_NM_Details WHERE eProposalNo = ? and NMNewICNo = ? and NMOtherIDType = ? and NMOtherID = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_ic"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_otherIDType"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_otherID"], Nil];
        }
        //	}
        //Nominees End
        
        //Trustees Start
        
        
        [db executeUpdate:@"DELETE FROM eProposal_Trustee_Details WHERE eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], Nil];
        
        //	if (![[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Label1"] isEqualToString:@"Add Trustee (1)"] || ![_NomineesVC.trusteeLbl1.text isEqualToString:@"Add Trustee (1)"])
        if (![[textFields trimWhiteSpaces:_NomineesVC.trusteeLbl1.text] isEqualToString:@"Add Trustee (1)"])
        {
            
            [db executeUpdate:@"INSERT INTO eProposal_Trustee_Details(eProposalNo, TrusteeTitle, TrusteeName, TrusteeSex, TrusteeDOB, TrusteeNewICNo, TrusteeOtherIDType, TrusteeOtherID, TrusteeRelationship, TrusteeAddress1, TrusteeAddress2, TrusteeAddress3, TrusteePostcode, TrusteeTown, TrusteeState, TrusteeCountry, CreatedAt, UpdatedAt, TrusteeSameAsPO, isForeignAddress) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Title"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Name"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Sex"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"DOB"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"ICNo"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"OtherIDType"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"OtherID"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Relationship"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Address1"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Address2"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Address3"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Postcode"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Town"], Trustee_stateCode, Trustee_countrycode, commDate, commDate, Trustee_samePO, [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"ForeignAddress"], Nil];
            
            
        }
        else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Delete1st"] isEqualToString:@"1"]) {
            NSLog(@"delete dt1");
            [db executeUpdate:@"DELETE FROM eProposal_Trustee_Details WHERE eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], Nil];
        }
        //	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Trustee2"] isEqualToString:@"1"])
        if (![[textFields trimWhiteSpaces:_NomineesVC.trusteeLbl2.text] isEqualToString:@"Add Trustee (2)"])
        {
            NSLog(@"insert dt2");
            [db executeUpdate:@"INSERT INTO eProposal_Trustee_Details(eProposalNo, TrusteeTitle, TrusteeName, TrusteeSex, TrusteeDOB, TrusteeNewICNo, TrusteeOtherIDType, TrusteeOtherID, TrusteeRelationship, TrusteeAddress1, TrusteeAddress2, TrusteeAddress3, TrusteePostcode, TrusteeTown, TrusteeState, TrusteeCountry, CreatedAt, UpdatedAt, TrusteeSameAsPO, isForeignAddress) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TTitle"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TName"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TSex"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TDOB"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TICNo"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TOtherIDType"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TOtherID"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TRelationship"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TAddress1"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TAddress2"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TAddress3"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TPostcode"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TTown"], Trustee2_stateCode ,Trustee2_countrycode, commDate, commDate, Trustee2_samePO, [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TForeignAddress"], Nil];
        }
        else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Delete2nd"] isEqualToString:@"1"]) {
            NSLog(@"delete dt2");
            [db executeUpdate:@"DELETE FROM eProposal_Trustee_Details WHERE eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], Nil];
        }
        //Trustees End
		
	}
	//Section D End
	
	//Section E Start
	if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Saved"] isEqualToString:@"Y"] || [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA1HQ"] objectForKey:@"Saved"] isEqualToString:@"Y"]){
        
        NSString *SecE_Q1B = @"";
        //        NSString *SecE_Q2 = @"";
        NSString *SecE_Q3 = @"";
        NSString *SecE_Q4 = @"";
        NSString *SecE_Q5 = @"";
        //        NSString *SecE_Q6 = @"";
        NSString *SecE_Q7A = @"";
        NSString *SecE_Q7B = @"";
        NSString *SecE_Q7C = @"";
        NSString *SecE_Q7D = @"";
        NSString *SecE_Q7E = @"";
        NSString *SecE_Q7F = @"";
        NSString *SecE_Q7G = @"";
        NSString *SecE_Q7H = @"";
        NSString *SecE_Q7I = @"";
        NSString *SecE_Q7J = @"";
        NSString *SecE_Q8A = @"";
        NSString *SecE_Q8B = @"";
        NSString *SecE_Q8C = @"";
        
        //        NSString *SecE_Q8D = @"";
        //        NSString *SecE_Q8E = @"";
        //        NSString *SecE_Q9 = @"";
        NSString *SecE_Q10 = @"";
        NSString *SecE_Q11 = @"";
        NSString *SecE_Q12 = @"";
        NSString *SecE_Q13 = @"";
        NSString *SecE_Q14A = @"";
        NSString *SecE_Q14B = @"";
        
        NSString *SecE_Q15 = @"";
        NSString *ptype =@"";
        
        
        NSString *query = @"";
		query = [NSString stringWithFormat:@"UPDATE eProposal SET QuestionnaireMandatoryFlag = '%@' WHERE eProposalNo = '%@'",[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Saved"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]];
		[db executeUpdate:query];
        
        
        NSArray *keys = [[NSArray alloc] initWithObjects:@"LA1HQ", @"LA2HQ",@"POHQ",nil];
        for (NSString *key in keys) {
            NSLog(@"insert healthQ");
			
			NSString *PTType = @"";
			if ([key isEqualToString:@"LA1HQ"]) {
				PTType = @"LA1";
			}
			else if ([key isEqualToString:@"LA2HQ"]) {
				PTType = @"LA2";
			}
			else if ([key isEqualToString:@"POHQ"]) {
				PTType = @"PO";
			}
			
			if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"] isEqualToString:PTType]) {
				
                [db executeUpdate:@"DELETE FROM eProposal_QuestionAns WHERE eProposalNo = ? and LAType = ? ", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], PTType, Nil];
                
                if ([[obj.eAppData objectForKey:@"SecE"] objectForKey:key]) {
                    
                    NSString *HW = [NSString stringWithFormat:@"%@ %@", [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_height"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_weight"]];
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], HW, @"Q1001", commDate, commDate,Nil];
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q1B"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q1"], @"Q1002", commDate, commDate,  Nil];
                    
                    SecE_Q1B =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q1B"];
                    
                    //                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q2"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q2"], @"Q1003", commDate, commDate,  Nil];
                    //
                    //
                    //                    SecE_Q2 =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q2"];
                    
                    
                    NSString *ANS3 = [NSString stringWithFormat:@"%@ %@ %@", [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q3_beerTF"] != NULL ? [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q3_beerTF"] : @"", [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q3_wineTF"] != NULL ? [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q3_wineTF"] : @"", [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q3_wboTF"] != NULL ? [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q3_wboTF"] : @""];
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q3"], ANS3, @"Q1004", commDate, commDate,  Nil];
                    
                    SecE_Q3 =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q3"];
                    
                    
                    NSString *ANS4 = [NSString stringWithFormat:@"%@ %@ %@ %@", [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q4_cigarettesTF"] != NULL ? [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q4_cigarettesTF"] : @"", [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q4_pipeTF"] != NULL ? [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q4_pipeTF"] : @"", [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q4_cigarTF"] != NULL ? [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q4_cigarTF"] : @"", [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q4_eCigarTF"] != NULL ? [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q4_eCigarTF"] : @""];
                    
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q4"], ANS4, @"Q1005", commDate, commDate,  Nil];
                    
                    SecE_Q4 =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q4"];
                    
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q5"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q5"], @"Q1006", commDate, commDate,  Nil];
                    
                    SecE_Q5 =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q5"];
                    
                    
                    //                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q6"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q6"], @"Q1007", commDate, commDate,  Nil];
                    //
                    //                    SecE_Q6 =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q6"];
                    
                    
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7A"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7"], @"Q1008", commDate, commDate,  Nil];
                    
                    SecE_Q7A =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7A"];
                    
                    
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7B"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7b"], @"Q1010", commDate, commDate,  Nil];
                    
                    SecE_Q7B =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7B"];
                    
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7C"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7c"], @"Q1011", commDate, commDate,  Nil];
                    
                    SecE_Q7C =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7C"];
                    
                    
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7D"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7d"], @"Q1012", commDate, commDate,  Nil];
                    
                    SecE_Q7D =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7D"];
                    
                    
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7E"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7e"], @"Q1013", commDate, commDate,  Nil];
                    
                    SecE_Q7E =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7E"];
                    
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7F"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7f"], @"Q1014", commDate, commDate,  Nil];
                    
                    SecE_Q7F =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7F"];
                    
                    
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7G"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7g"], @"Q1015", commDate, commDate,  Nil];
                    
                    SecE_Q7G =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7G"];
                    
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7H"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7h"], @"Q1016", commDate, commDate,  Nil];
                    
                    SecE_Q7H =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7H"];
                    
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7I"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7i"], @"Q1017", commDate, commDate,  Nil];
                    
                    SecE_Q7I =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7I"];
                    
                    
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7J"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7j"], @"Q1018", commDate, commDate,  Nil];
                    
                    SecE_Q7J =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7J"];
                    
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q8A"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q8"], @"Q1033", commDate, commDate,  Nil];
                    
                    SecE_Q8A =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q8A"];
                    
                    
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q8B"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q8b"], @"Q1034", commDate, commDate,  Nil];
                    
                    SecE_Q8B =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q8B"];
                    
                    
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q8C"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q8c"], @"Q1035", commDate, commDate,  Nil];
                    
                    SecE_Q8C =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q8C"];
                    
                    //                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q8D"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q8d"], @"Q1023", commDate, commDate,  Nil];
                    //
                    //                    SecE_Q8D =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q8D"];
                    //
                    //                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q8E"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q8e"], @"Q1024", commDate, commDate,  Nil];
                    //
                    //                    SecE_Q8E =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q8E"];
                    //
                    //                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q9"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q9"], @"Q1025", commDate, commDate,  Nil];
                    //
                    //                    SecE_Q9 =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q9"];
                    
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q10"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q10"], @"Q1026", commDate, commDate,  Nil];
                    
                    SecE_Q10 =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q10"];
                    
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q11"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q11"], @"Q1029", commDate, commDate,  Nil];
                    
                    SecE_Q11 =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q11"];
                    
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q12"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q12"], @"Q1030", commDate, commDate,  Nil];
                    
                    SecE_Q12 =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q12"];
                    
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q13"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q13"], @"Q1031", commDate, commDate,  Nil];
                    
                    SecE_Q13 =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q13"];
                    
                    NSString *ANS5 = [NSString stringWithFormat:@"%@ %@", [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q14"] != NULL ? [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q14"] : @"", [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q14_monthsTF"] != NULL ? [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q14_monthsTF"] : @""];
                    
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q14A"], ANS5, @"Q1027", commDate, commDate,  Nil];
                    
                    SecE_Q14A =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q14A"];
                    
                    
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q14B"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q14b"], @"Q1028", commDate, commDate,  Nil];
                    
                    SecE_Q14B =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q14B"];
                    
                    NSString *reason15 = [NSString stringWithFormat:@"%@ %@", [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key]objectForKey:@"Q15_weight"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q15_days"]];
                    reason15 = [reason15 isEqualToString:@"(null) (null)"] ? @"" : reason15;
                    [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q15"], reason15, @"Q1032", commDate, commDate,  Nil];
                    SecE_Q15 =  [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q15"];
                    
                    
                    ptype =   [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"];            }
                
                
                //Check pentalhealth status , pental female status -- START
                NSString *pental_health = @"False";
                NSString *pental_female = @"False";
                NSString *pental_declaration = @"False";
                FMResultSet *qns_results;
                qns_results = [db executeQuery:@"select * from eProposal_QuestionAns where eProposalNo =? and LAType =? and Answer =?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"],PTType,@"Y"];
                
                while ([qns_results next])
                {
                    NSString *qnID1;
                    qnID1 =[qns_results objectForColumnName:@"QnID"];
                    FMResultSet *qns_results2;
                    qns_results2 = [db executeQuery:@"select * from eProposal_Question where QnID =?",qnID1];
                    while ([qns_results2 next])
                    {
                        NSString *questionNo1;
                        questionNo1 =[qns_results2 objectForColumnName:@"QuestionNO"];
                        
                        FMResultSet *qns_results3;
                        qns_results3 = [db executeQuery:@"select * from eProposal_QuestionMapping where QuestionNO =?",questionNo1];
                        
                        while ([qns_results3 next]) {
                            NSString *uwqncode1;
                            uwqncode1 =[qns_results3 objectForColumnName:@"UWQnCode"];
                            
                            if([uwqncode1 isEqualToString:@"MDTAUW01"])
                            {
                                pental_health= @"True";
                            }
                            else if ([uwqncode1 isEqualToString:@"MDTAUW02"])
                            {
                                pental_female= @"True";
                            }
                        }
                    }
                }
                
                //Check pentalhealth status , pental female status -- END
                
                //Check pentaldeclaration status -- START
                // Rule 1 - Check if it is company case
                FMResultSet *po_results;
                NSString *OtherIDNo_check=@"CR";
                po_results = [db executeQuery:@"select * from eApp_listing where ProposalNo = ? and OtherIDNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"],OtherIDNo_check];
                while ([po_results next]) {
                    NSString *policyownername;
                    policyownername =[po_results objectForColumnName:@"POName"];
                    pental_declaration= @"True";
                }
                
                // Rule 2 - Check if it is UL case
                FMResultSet *plan_results;
                NSString *si_type=@"ES";
                NSString *LIEN_check=@"TRUE";
                NSString *si_counter=@"False";
                plan_results = [db executeQuery:@"select * from eProposal where eProposalNo = ? and LIEN = ? and SIType = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"],LIEN_check,si_type];
                while ([plan_results next]) {
                    NSString *lc_results =[plan_results objectForColumnName:@"LIEN"];
                    NSString *si_no =[plan_results objectForColumnName:@"SINo"];
                    si_counter=@"True";
                    pental_declaration= @"True";
                }
                
                // Rule 3 - Check if it is EverCash Rider
                if ([si_counter isEqualToString:@"True"]) {
                    FMResultSet *rider_results;
                    rider_results = [db executeQuery:@"select * from UL_Rider_Details where SINo = ?",@"si_no"];
                    while ([rider_results next]) {
                        NSString *rider_code =[rider_results objectForColumnName:@"RiderCode"];
                        if ([rider_code isEqualToString:@"ECAR"] || [rider_code isEqualToString:@"ECAR6"] || [rider_code isEqualToString:@"ECAR60"] ) {
                            pental_declaration= @"True";
                        }
                    }
                }
                
                // Rule 4 - Check For relationship
                FMResultSet *relationship_results;
                relationship_results = [db executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"],PTType];
                while ([relationship_results next]) {
                    NSString *relationship1;
                    relationship1 =[relationship_results objectForColumnName:@"LARelationship"];
                    if ([relationship1 isEqualToString:@"SELF"] || [relationship1 isEqualToString:@"WIFE"] || [relationship1 isEqualToString:@"HUSBAND"] || [relationship1 isEqualToString:@"SON"] || [relationship1 isEqualToString:@"DAUGHTER"]|| [relationship1 isEqualToString:@"MOTHER"] || [relationship1 isEqualToString:@"FATHER"] ) {
                        pental_declaration= @"False";
                    }else
                    {
                        pental_declaration= @"True";
                    }
                }
                
                //Check pentaldeclaration status -- END
                
                // NSLog(@"ky proposalno - %@, ptype  -%@  | pental_health - %@",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], ptype, pental_health);
                //NSLog(@"ky proposalno - %@, ptype  -%@  | pental_health - %@",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], ptype, pental_health);
                NSLog(@"update e");
                
                if([ptype isEqualToString:@"PO"])
                {
                    ptype= @"PY1";
                }
                
                
                
                NSString *query2 = [NSString stringWithFormat:@"UPDATE eProposal_LA_Details SET PentalHealthStatus = '%@', PentalFemaleStatus = '%@', PentalDeclarationStatus = '%@' WHERE eProposalNo = '%@' AND PTypeCode = '%@'", pental_health, pental_female, pental_declaration, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"],ptype];
                
                [db executeUpdate:query2];
                
                if([ptype isEqualToString:@"PY1"])
                {
                    ptype= @"PO";
                }
                
                
                
                
            }
		}
        
        //        //Check pentalhealth status , pental female status -- START
        //        NSString *pental_health = @"False";
        //        NSString *pental_female = @"False";
        //        NSString *pental_declaration = @"False";
        //        FMResultSet *qns_results;
        //        qns_results = [db executeQuery:@"select * from eProposal_QuestionAns where eProposalNo =? and Answer =?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"],@"Y"];
        //
        //        while ([qns_results next])
        //        {
        //            NSString *qnID1;
        //            qnID1 =[qns_results objectForColumnName:@"QnID"];
        //            FMResultSet *qns_results2;
        //            qns_results2 = [db executeQuery:@"select * from eProposal_Question where QnID =?",qnID1];
        //            while ([qns_results2 next])
        //            {
        //                NSString *questionNo1;
        //                questionNo1 =[qns_results2 objectForColumnName:@"QuestionNO"];
        //
        //                FMResultSet *qns_results3;
        //                qns_results3 = [db executeQuery:@"select * from eProposal_QuestionMapping where QuestionNO =?",questionNo1];
        //
        //                while ([qns_results3 next]) {
        //                    NSString *uwqncode1;
        //                    uwqncode1 =[qns_results3 objectForColumnName:@"UWQnCode"];
        //
        //                    if([uwqncode1 isEqualToString:@"MDTAUW01"])
        //                    {
        //                        pental_health= @"True";
        //                    }
        //                    else if ([uwqncode1 isEqualToString:@"MDTAUW02"])
        //                    {
        //                        pental_female= @"True";
        //                    }
        //                }
        //            }
        //        }
        //
        //        //Check pentalhealth status , pental female status -- END
        //
        //        //Check pentaldeclaration status -- START
        //        // Rule 1 - Check if it is company case
        //        FMResultSet *po_results;
        //        NSString *OtherIDNo_check=@"CR";
        //        po_results = [db executeQuery:@"select * from eApp_listing where ProposalNo = ? and OtherIDNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"],OtherIDNo_check];
        //        while ([po_results next]) {
        //            NSString *policyownername;
        //            policyownername =[po_results objectForColumnName:@"POName"];
        //            pental_declaration= @"True";
        //        }
        //
        //        // Rule 2 - Check if it is UL case
        //        FMResultSet *plan_results;
        //        NSString *si_type=@"ES";
        //        NSString *LIEN_check=@"TRUE";
        //        NSString *si_counter=@"False";
        //        plan_results = [db executeQuery:@"select * from eProposal where eProposalNo = ? and LIEN = ? and SIType = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"],LIEN_check,si_type];
        //        while ([plan_results next]) {
        //            NSString *lc_results =[plan_results objectForColumnName:@"LIEN"];
        //            NSString *si_no =[plan_results objectForColumnName:@"SINo"];
        //            si_counter=@"True";
        //            pental_declaration= @"True";
        //        }
        //
        //        // Rule 3 - Check if it is EverCash Rider
        //        if ([si_counter isEqualToString:@"True"]) {
        //            FMResultSet *rider_results;
        //            rider_results = [db executeQuery:@"select * from UL_Rider_Details where SINo = ?",@"si_no"];
        //            while ([rider_results next]) {
        //                NSString *rider_code =[rider_results objectForColumnName:@"RiderCode"];
        //                if ([rider_code isEqualToString:@"ECAR"] || [rider_code isEqualToString:@"ECAR6"] || [rider_code isEqualToString:@"ECAR60"] ) {
        //                    pental_declaration= @"True";
        //                }
        //            }
        //        }
        //
        //        // Rule 4 - Check For relationship
        //        FMResultSet *relationship_results;
        //        relationship_results = [db executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]];
        //        while ([relationship_results next]) {
        //            NSString *relationship1;
        //            relationship1 =[relationship_results objectForColumnName:@"LARelationship"];
        //            if ([relationship1 isEqualToString:@"SELF"] || [relationship1 isEqualToString:@"WIFE"] || [relationship1 isEqualToString:@"HUSBAND"] || [relationship1 isEqualToString:@"SON"] || [relationship1 isEqualToString:@"DAUGHTER"]|| [relationship1 isEqualToString:@"MOTHER"] || [relationship1 isEqualToString:@"FATHER"] ) {
        //                pental_declaration= @"False";
        //            }else
        //            {
        //                pental_declaration= @"True";
        //            }
        //        }
        //
        //        //Check pentaldeclaration status -- END
        //
        //        // NSLog(@"ky proposalno - %@, ptype  -%@  | pental_health - %@",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], ptype, pental_health);
        //        //NSLog(@"ky proposalno - %@, ptype  -%@  | pental_health - %@",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], ptype, pental_health);
        //        NSLog(@"update e");
        //
        //        if([ptype isEqualToString:@"PO"])
        //        {
        //            ptype= @"PY1";
        //        }
        //
        //
        //
        //        NSString *query2 = [NSString stringWithFormat:@"UPDATE eProposal_LA_Details SET PentalHealthStatus = '%@', PentalFemaleStatus = '%@', PentalDeclarationStatus = '%@' WHERE eProposalNo = '%@' AND PTypeCode = '%@'", pental_health, pental_female, pental_declaration, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"],ptype];
        //
        //        [db executeUpdate:query2];
        //
        //        if([ptype isEqualToString:@"PY1"])
        //        {
        //            ptype= @"PO";
        //        }
        
        
        
        
        
	}
	//Section E End
	
	//Section F Start
	if ([[[obj.eAppData objectForKey:@"SecF"] objectForKey:@"SecF_Saved"] isEqualToString:@"Y"]) {
		NSLog(@"update f");
        NSString *query = @"";
        query = [NSString stringWithFormat:@"UPDATE eProposal SET AdditionalQuestionsMandatoryFlag = '%@' WHERE eProposalNo = '%@'", [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"SecF_Saved"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]];
        [db executeUpdate:query];
		
        
	 	[db executeUpdate:@"DELETE FROM eProposal_Additional_Questions_1 WHERE eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
	 	[db executeUpdate:@"DELETE FROM eProposal_Additional_Questions_2 WHERE eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
        
		
		NSLog(@"insert f");
        
        
        
        
        int c = [[[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"] count];
        
        NSMutableArray *insured_Array = [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"];
        for(int x = 0; x < c; x++)
        {
            
            InsuredObject *insured_Object =  insured_Array[x];
            
            
            NSString *comp = insured_Object.Company;
            NSString *disease = insured_Object.Diease;
            NSString *amount = insured_Object.Amount;
            NSString *year = insured_Object.Year;
            
            //   NSLog(@"SAVE ADD Q - comp - %@ || disease - %@ || amount - %@ || year - %@",comp,disease, amount, year);
            
            [db executeUpdate:@"INSERT INTO eProposal_Additional_Questions_2(eProposalNo, AdditionalQuestionsCompany, AdditionalQuestionsAmountInsured, AdditionalQuestionsLifeAccidentDisease, AdditionalQuestionsYrIssued, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",
             [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"],
             comp,
             amount,
             disease,
             year,commDate, commDate, Nil];
            
        }
        insured_Array = nil;
        
        
		[db executeUpdate:@"INSERT INTO eProposal_Additional_Questions_1(eProposalNo, AdditionalQuestionsName, AdditionalQuestionsMonthlyIncome, AdditionalQuestionsOccupationCode, AdditionalQuestionsInsured, AdditionalQuestionsReason, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Name"], [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Income"], Occupation, [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured"], [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"No_Reason"], commDate, commDate, Nil];
        
        
	}
	//Section F End
	
	//Section G Start
	if ([[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"Declaration_agree"] length] != 0)
	{
        
        NSString *test =[NSString stringWithFormat:@"%@",self.DeclareVC.FATCATV.text];
        
        [[obj.eAppData objectForKey:@"SecG"] setValue:test forKey:@"FACTA_Q4_Ans_1"];
        [[obj.eAppData objectForKey:@"SecG"] setValue:self.DeclareVC.GIINTF.text forKey:@"FACTA_Q4_ANS_2"];
        
        
        
        
		NSLog(@"insert declare");
        //		NSLog(@"eproposal no: %@", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]);
		NSString *query = @"";
        
        query = [NSString stringWithFormat:@"UPDATE eProposal SET DeclarationAuthorization = '%@', DeclarationMandatoryFlag = '%@', FACTA_Q2 = '%@', FACTA_Q4 = '%@',  FACTA_Q4_Ans_1 = '%@', FACTA_Q4_Ans_2 = '%@', FACTA_Q5_Entity = '%@' WHERE eProposalNo = '%@'",[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"Declaration_agree"], [[obj.eAppData objectForKey:@"SecG"] objectForKey:@"SecG_Saved"],[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"FACTA_Q2"], [[obj.eAppData objectForKey:@"SecG"] objectForKey:@"FACTA_Q4"],[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"FACTA_Q4_Ans_1"],[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"FACTA_Q4_ANS_2"],[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"FACTA_Q5_Entity"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]];
		[db executeUpdate:query];
        
        
        //		query = [NSString stringWithFormat:@"UPDATE eProposal SET DeclarationAuthorization = '%@', DeclarationMandatoryFlag = '%@', FACTA_Q2 = '%@', FACTA_Q4 = '%@', FACTA_Q4_ANS_1 = '%@', FACTA_Q4_ANS_2 = '%@', FACTA_Q5_ENTITIY = '%@' WHERE eProposalNo = '%@'",[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"Declaration_agree"], [[obj.eAppData objectForKey:@"SecG"] objectForKey:@"SecG_Saved"],[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"FACTA_Q2"],[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"FACTA_Q4"],[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"FACTA_Q4_ANS_1"],[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"FACTA_Q4_ANS_2"],[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"FACTA_Q5_ENTITIY"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]];
        //		[db executeUpdate:query];
	}
	//Section G End
    
	[db commit];
    [db close];
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"0" forKey:@"NewProposal"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"0" forKey:@"Delete1st"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"0" forKey:@"Delete2nd"];
    
    //[Utility showAllert:@"Record saved successfully"];
    
    
    
    
    NSString *PersonType;
    if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionE"])
    {
        PersonType=_HealthQuestionsVC.personTypeLbl.text;
    }
    else
    {
        PersonType = @"";
    }
    
    if ([PersonType isEqualToString:@"1st Life Assured"])
    {
        //[Utility showAllert:@"Record for 1st Life Assured saved successfully."];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Record for 1st Life Assured saved successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
        ClearData *ClData =[[ClearData alloc]init];
		[ClData deleteOldPdfs:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];

        MenuOption.DeletePDF=NO;
        MenuOption.FormsTickMark=YES;
		if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"BackToChecklist"] isEqualToString:@"1"]){
			alert.tag = 444;
		}
		else
			alert.tag=1400;
        [alert show];
        alert = nil;
        
    }
    else if ([PersonType isEqualToString:@"2nd Life Assured"])
    {
        // [Utility showAllert:@"Record for 2nd Life Assured saved successfully."];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Record for 2nd  Life Assured saved successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
        ClearData *ClData =[[ClearData alloc]init];
		[ClData deleteOldPdfs:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];

        MenuOption.DeletePDF=NO;
        MenuOption.FormsTickMark=YES;
        if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"BackToChecklist"] isEqualToString:@"1"]){
			alert.tag = 444;
		}
		else
			alert.tag=1400;
        [alert show];
        
        alert = nil;
    }
    else if ([PersonType isEqualToString:@"Payor"])
    {
        // [Utility showAllert:@"Record for Payor saved successfully."];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Record for Payor saved successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
        ClearData *ClData =[[ClearData alloc]init];
		[ClData deleteOldPdfs:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];

        MenuOption.DeletePDF=NO;
        MenuOption.FormsTickMark=YES;
        if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"BackToChecklist"] isEqualToString:@"1"]){
			alert.tag = 444;
		}
		else
			alert.tag=1400;
        [alert show];
        alert = nil;
    }
    else
    {
		if (![[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"EAPPSave"] isEqualToString:@"1"] && PopUpAlert == YES) {
            if(PopUpAlertForA == YES){
                [Utility showAllert:@"Record saved successfully."];
            }
			//[[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"data"];
            AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
            ClearData *ClData =[[ClearData alloc]init];
			[ClData deleteOldPdfs:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];

            MenuOption.DeletePDF=NO;
            MenuOption.FormsTickMark=YES;
            [[NSUserDefaults standardUserDefaults] synchronize];
		}
		else if (PopUpAlert == YES){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Record saved succesfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"BackToChecklist"] isEqualToString:@"1"]){
                alert.tag = 444;
			}
			[alert show];
            //[[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"data"];
            ClearData *ClData =[[ClearData alloc]init];
			[ClData deleteOldPdfs:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];

            [[NSUserDefaults standardUserDefaults] synchronize];
		}
		//[Utility showAllert:@"Record saved successfully."];
    }
    PersonType = @"";
    PopUpAlert = YES;
    PopUpAlertForA = YES;
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"0" forKey:@"EAPPSave"];
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"0" forKey:@"BackToChecklist"];
	Proceed = YES;
	
	
	//clear flag for FORM whenever user save again Proposal
	confirmStatus = YES;
	[[NSUserDefaults standardUserDefaults]setBool:confirmStatus forKey:@"confirmed"];
	[[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"data"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	
}





-(NSString*) getCountryCode : (NSString*)country
{
	
	if ([country isEqualToString:@""] || (country == NULL) || ([country isEqualToString:@"(NULL)"])) {
		return @"";
	}
	
    NSString *code;
    country = [country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT CountryCode FROM eProposal_Country WHERE CountryDesc = ?", country];
    
	NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        code =[result objectForColumnName:@"CountryCode"];
    }
    
    [result close];
    [db close];
    
	if (count == 0) {
		code = country;
	}
	
    return code;
    
}

-(NSString*) getCountryDesc : (NSString*)country
{
	
	if ([country isEqualToString:@""] || (country == NULL) || ([country isEqualToString:@"(NULL)"])) {
		return @"";
	}
	
    NSString *code;
    country = [country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT CountryDesc FROM eProposal_Country WHERE CountryCode = ?", country];
    
	NSInteger *count = 0;
    while ([result next]) {
        code =[result objectForColumnName:@"CountryDesc"];
        count = count + 1;
    }
    
    [result close];
    [db close];
    
	if (count == 0) {
		code = country;
	}
	
    return code;
    
}

-(NSString*) getNationalityCode : (NSString*)nationality
{
	
	if ([nationality isEqualToString:@""] || (nationality == NULL) || ([nationality isEqualToString:@"(NULL)"])) {
		return @"";
	}
	
    NSString *code;
    nationality = [nationality stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT NationCode FROM eProposal_Nationality WHERE NationDesc = ?", nationality];
    
	NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        code =[result objectForColumnName:@"NationCode"];
    }
    
    [result close];
    [db close];
    
	if (count == 0) {
		code = nationality;
	}
	
    return code;
    
}

-(NSString*) getNAtionalityDesc : (NSString*)nationality
{
	
	if ([nationality isEqualToString:@""] || (nationality == NULL) || ([nationality isEqualToString:@"(NULL)"])) {
		return @"";
	}
	
    NSString *code;
    nationality = [nationality stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT NationDesc FROM eProposal_Nationality WHERE NationCode = ?", nationality];
    
	NSInteger *count = 0;
    while ([result next]) {
        code =[result objectForColumnName:@"NationDesc"];
        count = count + 1;
    }
    
    [result close];
    [db close];
    
	if (count == 0) {
		code = nationality;
	}
	
    return code;
    
}


-(NSString*) getStateCode : (NSString*)state
{
	if ([state isEqualToString:@""] || (state == NULL) || ([state isEqualToString:@"(NULL)"])) {
		return @"";
	}
    NSString *code;
    state = [state stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT StateCode FROM eProposal_State WHERE StateDesc = ?", state];
    
	int count = 0;
    while ([result next]) {
		count = count + 1;
        code =[result objectForColumnName:@"StateCode"];
    }
    
	if (count == 0){
		code = state;
	}
	
    [result close];
    [db close];
    
    return code;
    
}

-(NSString*) getStateDesc : (NSString*)state
{
	if ([state isEqualToString:@""] || (state == NULL) || ([state isEqualToString:@"(NULL)"])) {
		return @"";
	}
	
    NSString *desc;
    state = [state stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT StateDesc FROM eProposal_State WHERE StateCode = ?", state];
    
	NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        desc = [result objectForColumnName:@"StateDesc"];
    }
    
    [result close];
    [db close];
	
	if (count == 0) {
		desc = state;
	}
    
    return desc;
    
}

-(NSString*) getRelationshipCode : (NSString*)relationship
{
	if ([relationship isEqualToString:@""] || (relationship == NULL) || ([relationship isEqualToString:@"(NULL)"])) {
		return @"";
	}
	
    NSString *code;
    relationship = [relationship stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT RelCode FROM eProposal_Relation WHERE RelDesc = ?", relationship];
    
	int count = 0;
    while ([result next]) {
		count = count + 1;
        code =[result objectForColumnName:@"RelCode"];
    }
    
	//if (code == NULL)
	//code = @"";
	if (count == 0)
		code = relationship;
    
    [result close];
    [db close];
    
    return code;
    
}

-(NSString*) getRelationshipDesc : (NSString*)relationship
{
	if ([relationship isEqualToString:@""] || (relationship == NULL) || ([relationship isEqualToString:@"(NULL)"])) {
		return @"";
	}
    NSString *desc;
    relationship = [relationship stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT RelDesc FROM eProposal_Relation WHERE RelCode = ?", relationship];
    
	NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        desc = [result objectForColumnName:@"RelDesc"];
    }
    
    [result close];
    [db close];
	
	if (count == 0) {
		desc = relationship;
	}
    
    return desc;
    
}

-(NSString*) getTitleCode : (NSString*)title
{
	if ([title isEqualToString:@""] || (title == NULL) || ([title isEqualToString:@"(NULL)"])) {
		return @"";
	}
	
    NSString *code;
    title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT TitleCode FROM eProposal_Title WHERE TitleDesc = ?", title];
    
	int count = 0;
    while ([result next]) {
		count = count + 1;
        code =[result objectForColumnName:@"TitleCode"];
    }
    
	if (count == 0)
		code = title;
	
    [result close];
    [db close];
    
    return code;
    
}

-(NSString*) getTitleDesc : (NSString*)Title
{
	if ([Title isEqualToString:@""] || (Title == NULL) || ([Title isEqualToString:@"(NULL)"])) {
		return @"";
	}
    NSString *desc;
    Title = [Title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT TitleDesc FROM eProposal_Title WHERE TitleCode = ?", Title];
    
	NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        desc = [result objectForColumnName:@"TitleDesc"];
    }
    
    [result close];
    [db close];
	
	if (count == 0) {
		desc = Title;
	}
    
    return desc;
    
}



#pragma mark - age formula
-(int)calculateAge:(NSString *)ageText {
    
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    [fmtDate setDateFormat:@"dd/MM/yyyy"];
    NSString *textDate = [NSString stringWithFormat:@"%@",[fmtDate stringFromDate:[NSDate date]]];
    
    NSArray *curr = [textDate componentsSeparatedByString: @"/"];
    NSString *currentDay = [curr objectAtIndex:0];
    NSString *currentMonth = [curr objectAtIndex:1];
    NSString *currentYear = [curr objectAtIndex:2];
    
    NSArray *foo = [ageText componentsSeparatedByString: @"/"];
    NSString *birthDay = [foo objectAtIndex: 0];
    NSString *birthMonth = [foo objectAtIndex: 1];
    NSString *birthYear = [foo objectAtIndex: 2];
    
    int yearN = [currentYear intValue];
    int yearB = [birthYear intValue];
    int monthN = [currentMonth intValue];
    int monthB = [birthMonth intValue];
    int dayN = [currentDay intValue];
    int dayB = [birthDay intValue];
    
    int ALB = yearN - yearB;
    int newALB;
    int newANB;
    
    if (yearN > yearB)
    {
        if (monthN < monthB) {
            newALB = ALB - 1;
        } else if (monthN == monthB && dayN < dayB) {
            newALB = ALB - 1;
        } else {
            newALB = ALB;
        }
        
        if (monthN > monthB) {
            newANB = ALB + 1;
        } else if (monthN == monthB && dayN >= dayB) {
            newANB = ALB + 1;
        } else {
            newANB = ALB;
        }
    }
    else {
        newALB = 0;
    }
    return newALB;
}

#pragma mark - backdate
-(int)calculateBackdate:(NSString *)Backdate {
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
	[df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [df setLocale:[NSLocale systemLocale]];
    [df setDateFormat:@"dd/MM/yyyy"];
    NSDate *d = [NSDate date];
	NSDate* d2 = [df dateFromString:Backdate];
	
	NSDate* d3Gst = [df dateFromString:@"01/04/2015"];
	
	//NSLog(@"ENS CompareDate d1 %@, d2 %@, backdate %@", d, d2, Backdate);
    
    //if ([d compare:d2] == NSOrderedAscending) {
	//	return  0;
	//}
    
    
	NSUInteger unitFlags = NSDayCalendarUnit;
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *components = [calendar components:unitFlags fromDate:d2 toDate:d options:0];
    
	NSDateComponents *compGST = [calendar components:unitFlags fromDate:d2 toDate:d3Gst options:0];
    
	NSLog(@"GST date1: %d", [compGST day]);
    
	if ([compGST day] > 0) {
		return  2; //Date set before GST
	}
	else if ([components day] > 180 || [components day] <= 0) {
		return  0;
	}
    
	return 1;
	
    
}

-(NSString*) getOccupationCode : (NSString*)country
{
	
	if ([country isEqualToString:@""] || (country == NULL) || ([country isEqualToString:@"(NULL)"])) {
		return @"";
	}
	
    NSString *code;
    country = [country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT OccpCode FROM Adm_Occp WHERE OccpDesc = '%@'", country];
    // NSLog(@"Query EEEEE: %@", sqlQuery);
    
    FMResultSet *result2 = [db executeQuery:sqlQuery];
    
	NSInteger *count = 0;
    while ([result2 next]) {
		count = count + 1;
        code =[result2 objectForColumnName:@"OccpCode"];
    }
    
    [result2 close];
    [db close];
    
	if (count == 0) {
		code = country;
	}
	
    return code;
    
}

-(NSString*) getOccupationDesc : (NSString*)country
{
	
	if ([country isEqualToString:@""] || (country == NULL) || ([country isEqualToString:@"(NULL)"])) {
		return @"";
	}
	
    NSString *code;
    country = [country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT OccpDesc FROM Adm_Occp WHERE OccpCode = ?", country];
    
	NSInteger *count = 0;
    while ([result next]) {
        code =[result objectForColumnName:@"OccpDesc"];
        count = count + 1;
    }
    
    [result close];
    [db close];
    
	if (count == 0) {
		code = country;
	}
	
    return code;
    
}


#pragma mark - Function Delete from SI
-(void) deleteEAppCase: (NSString *)SINO {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
	
	if (![db open])
		[db open];
	
	FMResultSet *result;
	FMResultSet *result2;
	
	NSString *ProposalNo_to_delete;
	
	NSString *query = [NSString stringWithFormat:@"SELECT eProposalNo FROM eProposal WHERE SINO = '%@'", SINO];
    result = [db executeQuery:query];
	
	while ([result next]) {
		//ONLY DELETE DATA WITH STATUS CREATED AND CONFIRMED
		NSString *query2 = [NSString stringWithFormat:@"SELECT ProposalNo FROM eApp_listing WHERE ProposalNo = '%@' AND status in (2,3)", [result objectForColumnName:@"eProposalNo"]];
		result2 = [db executeQuery:query2];
		
		while ([result2 next]) {
			ProposalNo_to_delete =  [result2 objectForColumnName:@"ProposalNo"];
			[self deleteConfirmCase:ProposalNo_to_delete database:db];
		}
	}
	
	[db close];
}

-(void) deleteConfirmCase:(NSString *)ProposalNo_to_delete database:(FMDatabase *)db
{
    
	[db executeUpdate:@"DELETE FROM eProposal WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_Additional_Questions_1 WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_Additional_Questions_1 Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_Additional_Questions_2 WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_Additional_Questions_2 Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_CA WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_CA Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_CA_Recommendation WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_CA_Recommendation Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_CA_Recommendation_Rider WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_CA_Recommendation_Rider Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_Education WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_Education Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_Education_Details WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_Education_Details Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_Family_Details WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_Family_Details Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_Master WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_Master Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_Personal_Details WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_Pesonal_Details Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_Protection WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_Protction Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_Protection_Details WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_Protection_Details Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_RecordOfAdvice WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_RecordOfAdvice Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_RecordOfAdvice_Rider WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_RecordOfAdvice_Rider Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_Retirement WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_Retirement Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_Retirement_Details WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_Retirement_Details Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_SavingsInvest WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_SavingsInvest Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_SavingsInvest_Details Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_Existing_Policy_1 WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_Existing_Policy_1 Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_Existing_Policy_2 WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_Existing_Policy_2 Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_LA_Details WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_LA_Details Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_NM_Details WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_NM_Details Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_Trustee_Details WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_Trustee_Details Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eApp_Listing WHERE ProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eApp_Listing Table Cleaned for Confirmed Case.");
    
}



@end//prem//
