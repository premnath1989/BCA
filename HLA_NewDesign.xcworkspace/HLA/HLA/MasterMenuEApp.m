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

NSString *alert_answerall = @"Please answer all questions.";

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSLog(@"view did loaddddd");
    alertMsg = @"Do you want to save changes for 1st Life Assured now";
    
    obj = [DataClass getInstance];
	
	[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-linen.png"]]];
    
    self.myTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-linen.png"]];
    
    ListOfSubMenu = [[NSMutableArray alloc] initWithObjects:@"Summary", @"Personal Details", @"Policy Details", @"Existing Life Policies", @"Nominees/Trustees", @"Health Questions", @"Additional Questions",@"Declaration", nil ];
    myTableView.rowHeight = 44;
    [myTableView reloadData];
    
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

//	_nameLALbl.text = [[obj.eAppData objectForKey:@"SI"] objectForKey:@"NameLA"];
	_nameLALbl.text = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIName"];
    
    nextStoryboard = nil;
	
	
	//from db
//	[[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.fullNameTF.text forKey:@"FullName"];
	//
    
    NSLog(@"sinumberrr: %@", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"]);
	
	
//	[[obj.eAppData objectForKey:@"EAPP"] setValue:Nil forKey:@"SINumber"];
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
	//set nil to all personal details value
	
	//set nil to all policy details value
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"SecB_Saved"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"PaymentMode"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"BasicPlan"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"Term"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"SumAssured"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"BasicPremium"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"TotalPremium"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"FirstTimePayment"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"FirstPaymentDeduct"];
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
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"PaidUpOption"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"PaidUpTerm"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"RevisedSumAssured"];
	[[obj.eAppData objectForKey:@"SecB"] setValue:Nil forKey:@"RevisedAmount"];
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
	[[obj.eAppData objectForKey:@"SecC"] setValue:Nil forKey:@"DatePolicyBackdating"];
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
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_Address"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_add1TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_add2TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_add3TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_postcodeTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_townTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_stateTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee1_countryTF"];

	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_title"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_name"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_ic"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_otherIDType"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_otherID"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_dob"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_gender"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_share"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_relatioship"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_Address"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_add1TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_add2TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_add3TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_postcodeTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_townTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_stateTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee2_countryTF"];
	
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_title"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_name"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_ic"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_otherIDType"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_otherID"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_dob"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_gender"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_share"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_relatioship"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_Address"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_add1TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_add2TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_add3TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_postcodeTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_townTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_stateTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee3_countryTF"];

	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_title"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_name"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_ic"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_otherIDType"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_otherID"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_dob"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_gender"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_share"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_relatioship"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_Address"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_add1TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_add2TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_add3TF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_postcodeTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_townTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_stateTF"];
	[[obj.eAppData objectForKey:@"SecD"] setValue:Nil forKey:@"Nominee4_countryTF"];
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
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_personType"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_height"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_weight"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q1B"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q1"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q2"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q2"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q3"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q3_beerTF"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q3_wineTF"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q3_wboTF"];
	
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q4"];
	
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q5"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q5"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q6"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q6"];
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
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q8D"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q8d"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q8E"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q8e"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q9"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q9"];
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
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q14B"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"Q14b"];
	
	[[obj.eAppData objectForKey:@"SecE"] setValue:Nil forKey:@"SecE_Q15"];
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
	NSLog(@"string id: %@, si: %@", stringID, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"]);
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
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"CONewICNo"] forKey:@"ICNo"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COMobileNo"] forKey:@"MobileNo"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"CODOB"] forKey:@"DOB"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COEmailAddress"] forKey:@"Email"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COOtherIDType"] forKey:@"OtherIDType"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COOtherID"] forKey:@"OtherID"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"CORelationship"] forKey:@"Relationship"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COSameAddressPO"] forKey:@"SameAddress"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COForeignAddressFlag"] forKey:@"ForeignAddress"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COAddress1"] forKey:@"Address1"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COAddress2"] forKey:@"Address2"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COAddress3"] forKey:@"Address3"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COPostcode"] forKey:@"Postcode"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COTown"] forKey:@"Town"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COState"] forKey:@"State"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:[results2 stringForColumn:@"COCountry"] forKey:@"Country"];
	}
//	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"FullName"] length] != 0) {
//		[[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"TickPart2"];
//	}
//	else {
//		[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickPart2"];
//	}
	//SEC A - CO end
	
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
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"FirstTimePayment"] forKey:@"FirstTimePayment"];
		NSLog(@"bbbb : %@", [results2 stringForColumn:@"FirstTimePayment"]);
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"PaymentUponFinalAcceptance"] forKey:@"FirstPaymentDeduct"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"RecurringPayment"] forKey:@"RecurringPayment"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"SecondAgentCode"] forKey:@"AgentCode"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"SecondAgentContactNo"] forKey:@"AgentContactNo"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"SecondAgentName"] forKey:@"AgentName"];
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
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"FullyPaidUpOption"] forKey:@"PaidUpOption"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"FullyPaidUpTerm"] forKey:@"PaidUpTerm"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"RevisedSA"] forKey:@"RevisedSumAssured"];
		[[obj.eAppData objectForKey:@"SecB"] setValue:[results2 stringForColumn:@"AmtRevised"] forKey:@"RevisedAmount"];
	}
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
	//		while ([results next]) {
	results2 = [database executeQuery:@"select * from  eProposal_Existing_Policy_1 where eProposalNo = ?",stringID,Nil];
	while ([results2 next]) {
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ProposalPTypeCode"] forKey:@"PersonType"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer1"] forKey:@"ExistingPolicies"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer2"] forKey:@"NoticeA"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer3"] forKey:@"NoticeB"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer4"] forKey:@"NoticeC"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"ExistingPolicy_Answer5"] forKey:@"NoticeD"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"blnBackDating"] forKey:@"PolicyBackdating"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"BackDating"] forKey:@"DatePolicyBackdating"];
	}
    results2 = Nil;
    results2 = [database executeQuery:@"select * from eProposal_Existing_Policy_2 where eProposalNo = ? and PTypeCodeDesc = ?", stringID, @"1st Life Assured", Nil];
    NSMutableArray *mutAry = [NSMutableArray array];
    while ([results2 next]) {
        
        NSArray *details = [NSArray arrayWithObjects:[results2 objectForColumnName:@"PTypeCodeDesc"],[results2 objectForColumnName:@"ExistingPolicy_Company"], [results2 objectForColumnName:@"ExistingPolicy_LifeTerm"], [results2 objectForColumnName:@"ExistingPolicy_Accident"], [results2 objectForColumnName:@"ExistingPolicy_CriticalIllness"], [results2 objectForColumnName:@"ExistingPolicy_DateIssued"], nil];
        
        [mutAry addObject:[details copy]];
    }
    if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"]) {
        [[obj.eAppData objectForKey:@"SecC"] setValue:[NSMutableDictionary dictionary] forKey:@"ExistingPolicy1stLA"];
    }
    [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] setValue:[mutAry mutableCopy] forKey:@"PolicyData"];
    
    results2 = Nil;
    results2 = [database executeQuery:@"select * from eProposal_Existing_Policy_2 where eProposalNo = ? and PTypeCodeDesc = ?", stringID, @"2nd Life Assured", Nil];
    mutAry = [NSMutableArray array];
    while ([results2 next]) {
        
        NSArray *details = [NSArray arrayWithObjects:[results2 objectForColumnName:@"PTypeCodeDesc"],[results2 objectForColumnName:@"ExistingPolicy_Company"], [results2 objectForColumnName:@"ExistingPolicy_LifeTerm"], [results2 objectForColumnName:@"ExistingPolicy_Accident"], [results2 objectForColumnName:@"ExistingPolicy_CriticalIllness"], [results2 objectForColumnName:@"ExistingPolicy_DateIssued"], nil];
        
        [mutAry addObject:[details copy]];
    }
    if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy2ndLA"]) {
        [[obj.eAppData objectForKey:@"SecC"] setValue:[NSMutableDictionary dictionary] forKey:@"ExistingPolicy2ndLA"];
    }
    [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy2ndLA"] setValue:[mutAry mutableCopy] forKey:@"PolicyData"];
    
    results2 = Nil;
    results2 = [database executeQuery:@"select * from eProposal_Existing_Policy_2 where eProposalNo = ? and PTypeCodeDesc = ?", stringID, @"Policy Owner", Nil];
    mutAry = [NSMutableArray array];
    while ([results2 next]) {
        
        NSArray *details = [NSArray arrayWithObjects:[results2 objectForColumnName:@"PTypeCodeDesc"],[results2 objectForColumnName:@"ExistingPolicy_Company"], [results2 objectForColumnName:@"ExistingPolicy_LifeTerm"], [results2 objectForColumnName:@"ExistingPolicy_Accident"], [results2 objectForColumnName:@"ExistingPolicy_CriticalIllness"], [results2 objectForColumnName:@"ExistingPolicy_DateIssued"], nil];
        
        [mutAry addObject:[details copy]];
    }
    if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyPO"]) {
        [[obj.eAppData objectForKey:@"SecC"] setValue:[NSMutableDictionary dictionary] forKey:@"ExistingPolicyPO"];
    }
    [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyPO"] setValue:[mutAry mutableCopy] forKey:@"PolicyData"];
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
				NSLog(@"name nm 1: %@" ,[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_name"]);
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMOtherIDType"] forKey:@"Nominee1_otherIDType"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMOtherID"] forKey:@"Nominee1_otherID"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMDOB"] forKey:@"Nominee1_dob"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMSex"] forKey:@"Nominee1_gender"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMShare"] forKey:@"Nominee1_share"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMRelationship"] forKey:@"Nominee1_relatioship"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMSamePOAddress"] forKey:@"Nominee1_Address"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress1"] forKey:@"Nominee1_add1TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress2"] forKey:@"Nominee1_add2TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress3"] forKey:@"Nominee1_add3TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMPostcode"] forKey:@"Nominee1_postcodeTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMTown"] forKey:@"Nominee1_townTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMState"] forKey:@"Nominee1_stateTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCountry"] forKey:@"Nominee1_countryTF"];
			}
			else if (gotNomineeCount == 2) {
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMTitle"] forKey:@"Nominee2_title"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMName"] forKey:@"Nominee2_name"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMNewICNo"] forKey:@"Nominee2_ic"];
//				NSLog(@"nameeeee: %@" ,[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Name"]);
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMOtherIDType"] forKey:@"Nominee2_otherIDType"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMOtherID"] forKey:@"Nominee2_otherID"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMDOB"] forKey:@"Nominee2_dob"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMSex"] forKey:@"Nominee2_gender"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMShare"] forKey:@"Nominee2_share"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMRelationship"] forKey:@"Nominee2_relatioship"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMSamePOAddress"] forKey:@"Nominee2_Address"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress1"] forKey:@"Nominee2_add1TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress2"] forKey:@"Nominee2_add2TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress3"] forKey:@"Nominee2_add3TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMPostcode"] forKey:@"Nominee2_postcodeTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMTown"] forKey:@"Nominee2_townTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMState"] forKey:@"Nominee2_stateTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCountry"] forKey:@"Nominee2_countryTF"];
			}
			else if (gotNomineeCount == 3) {
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMTitle"] forKey:@"Nominee3_title"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMName"] forKey:@"Nominee3_name"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMNewICNo"] forKey:@"Nominee3_ic"];
//				NSLog(@"nameeeee: %@" ,[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Name"]);
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMOtherIDType"] forKey:@"Nominee3_otherIDType"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMOtherID"] forKey:@"Nominee3_otherID"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMDOB"] forKey:@"Nominee3_dob"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMSex"] forKey:@"Nominee3_gender"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMShare"] forKey:@"Nominee3_share"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMRelationship"] forKey:@"Nominee3_relatioship"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMSamePOAddress"] forKey:@"Nominee3_Address"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress1"] forKey:@"Nominee3_add1TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress2"] forKey:@"Nominee3_add2TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress3"] forKey:@"Nominee3_add3TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMPostcode"] forKey:@"Nominee3_postcodeTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMTown"] forKey:@"Nominee3_townTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMState"] forKey:@"Nominee3_stateTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCountry"] forKey:@"Nominee3_countryTF"];
			}
			else if (gotNomineeCount == 4) {
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMTitle"] forKey:@"Nominee4_title"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMName"] forKey:@"Nominee4_name"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMNewICNo"] forKey:@"Nominee4_ic"];
//				NSLog(@"nameeeee: %@" ,[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Name"]);
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMOtherIDType"] forKey:@"Nominee4_otherIDType"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMOtherID"] forKey:@"Nominee4_otherID"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMDOB"] forKey:@"Nominee4_dob"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMSex"] forKey:@"Nominee4_gender"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMShare"] forKey:@"Nominee4_share"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMRelationship"] forKey:@"Nominee4_relatioship"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMSamePOAddress"] forKey:@"Nominee4_Address"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress1"] forKey:@"Nominee4_add1TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress2"] forKey:@"Nominee4_add2TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMAddress3"] forKey:@"Nominee4_add3TF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMPostcode"] forKey:@"Nominee4_postcodeTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMTown"] forKey:@"Nominee4_townTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMState"] forKey:@"Nominee4_stateTF"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:[results2 stringForColumn:@"NMCountry"] forKey:@"Nominee4_countryTF"];
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
//			NSLog(@"count more than 0");
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
				NSLog(@"got trustee");
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeSameAsPO"] forKey:@"SamePO"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeTitle"] forKey:@"Title"];
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeName"] forKey:@"Name"];
				NSLog(@"nameeeee: %@" ,[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"SamePO"]);
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
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeCountry"] forKey:@"Country"];
			}
			else if (gotTrusteeCount == 2) {
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeSameAsPO"] forKey:@"2TSamePO"];
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
				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeCountry"] forKey:@"2TCountry"];
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
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_height"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_weight"];
                }
                else if (gotHQCount == 2) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q1B"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q1"];
                }
                else if (gotHQCount == 3) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q2"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q2"];
                }
                else if (gotHQCount == 4) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q3"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q3_beerTF"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q3_wineTF"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q3_wboTF"];
                }
                else if (gotHQCount == 5) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q4"];
                }
                else if (gotHQCount == 6) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q5"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q5"];
                }
                else if (gotHQCount == 7) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q6"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q6"];
                }
                else if (gotHQCount == 8) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q7A"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q7"];
                }
                else if (gotHQCount == 9) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q7B"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q7b"];
                }
                else if (gotHQCount == 10) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q7C"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q7c"];
                }
                else if (gotHQCount == 11) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q7D"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q7d"];
                }
                else if (gotHQCount == 12) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q7E"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q7e"];
                }
                else if (gotHQCount == 13) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q7F"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q7f"];
                }
                else if (gotHQCount == 14) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q7G"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q7g"];
                }
                else if (gotHQCount == 15) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q7H"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q7h"];
                }
                else if (gotHQCount == 16) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q7I"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q7i"];
                }
                else if (gotHQCount == 17) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q7J"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q7j"];
                }
                else if (gotHQCount == 18) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q8A"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q8"];
                }
                else if (gotHQCount == 19) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q8B"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q8b"];
                }
                else if (gotHQCount == 20) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q8C"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q8c"];
                }
                else if (gotHQCount == 21) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q8D"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q8d"];
                }
                else if (gotHQCount == 22) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q8E"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q8e"];
                }
                else if (gotHQCount == 23) {
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Answer"] forKey:@"SecE_Q9"];
                    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q9"];
                }
                else if (gotHQCount == 24) {
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
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] setValue:[results2 stringForColumn:@"Reason"] forKey:@"Q14"];
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
            }
        }
    }
	//SEC E end
	
	//SEC F start
	results2 = Nil;
	results2 = [database executeQuery:@"select * from  eProposal_Additional_Questions_1 where eProposalNo = ?",stringID, Nil];
	while ([results2 next]) {
		[[obj.eAppData objectForKey:@"SecF"] setValue:[results2 stringForColumn:@"AdditionalQuestionsName"] forKey:@"Name"];
		[[obj.eAppData objectForKey:@"SecF"] setValue:[results2 stringForColumn:@"AdditionalQuestionsMonthlyIncome"] forKey:@"Income"];
		[[obj.eAppData objectForKey:@"SecF"] setValue:[results2 stringForColumn:@"AdditionalQuestionsOccupationCode"] forKey:@"Occupation"];
		[[obj.eAppData objectForKey:@"SecF"] setValue:[results2 stringForColumn:@"AdditionalQuestionsInsured"] forKey:@"Insured"];
		[[obj.eAppData objectForKey:@"SecF"] setValue:[results2 stringForColumn:@"AdditionalQuestionsReason"] forKey:@"No_Reason"];
	}
	//SEC F end
	
	//SEC G start
	results2 = Nil;
	results2 = [database executeQuery:@"select * from  eProposal where eProposalNo = ?",stringID,Nil];
	while ([results2 next]) {
		[[obj.eAppData objectForKey:@"SecG"] setValue:[results2 stringForColumn:@"DeclarationAuthorization"] forKey:@"Declaration_agree"];
	}
	//SEC G end
	
	[results close];
	[results2 close];
	[results3 close];
	[database close];
	
	//NSLog(@"1st time payment ee %@", [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FirstTimePayment"]);
	//NSLog(@"agree ee %@", [[obj.eAppData objectForKey:@"SecG"] objectForKey:@"Declaration_agree"]);
	//NSLog(@"all ee %@", [[obj.eAppData objectForKey:@"SecB"] allKeys]);
	
	
    //ky
    //  Enable the tick  - Check from the obj
//	NSLog(@"tick a: %@", [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SecA_Saved"]);
    if([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SecA_Saved"] isEqualToString:@"Y"])
    {
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3001];
        imageView.hidden = FALSE;
        imageView = nil;
        
        self.SummaryVC.tickPersonalDetails.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        
        self.SummaryVC.tickPersonalDetails.text = @"✓";
       
        
    }
    if([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"SecB_Saved"] isEqualToString:@"Y"])
    {
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3002];
        imageView.hidden = FALSE;
        imageView = nil;
        self.SummaryVC.tickPolicyDetails.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        
        self.SummaryVC.tickPolicyDetails.text = @"✓";
    }
    
    if([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"SecC_Saved"] isEqualToString:@"Y"])
    {
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3003];
        imageView.hidden = FALSE;
        imageView = nil;
        //self.SummaryVC.tickPolicyDetails.text = @"✓";
      //  self.SummaryVC.tickPolicyDetails.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        
       // self.SummaryVC.tickPolicyDetails.text = @"✓";
    }
    
    //KY - Edit eApp , check and tick if saved successfully before.
    if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"SecD_Saved"] isEqualToString:@"Y"])
    {
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3004];
        imageView.hidden = FALSE;
        imageView = nil;
     //   self.SummaryVC.tickNominees.text = @"✓";
        
        self.SummaryVC.tickNominees.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        
        self.SummaryVC.tickNominees.text = @"✓";
    }
    if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Saved"] isEqualToString:@"Y"])
    {
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
        imageView.hidden = FALSE;
        imageView = nil;
      //  self.SummaryVC.tickHealthQuestions.text = @"✓";
        self.SummaryVC.tickHealthQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        
        self.SummaryVC.tickHealthQuestions.text = @"✓";
    }
    if([[[obj.eAppData objectForKey:@"SecF"] objectForKey:@"SecF_Saved"] isEqualToString:@"Y"])
    {
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3006];
        imageView.hidden = FALSE;
        imageView = nil;
        self.SummaryVC.tickAdditionalQuestions.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        
        self.SummaryVC.tickAdditionalQuestions.text = @"✓";
        
         
    }
//    if([[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"SecG_Saved"] isEqualToString:@"Y"])
	if ([[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"Declaration_agree"] length] != 0)
    {
        UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3007];
        imageView.hidden = FALSE;
        imageView = nil;
        //self.SummaryVC.tickDeclaration.text = @"✓";
        self.SummaryVC.tickDeclaration.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        
        self.SummaryVC.tickDeclaration.text = @"✓";
    }
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
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

- (UITableViewCell *)tableView:(UITableView *)myTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
	
	UIImageView *imgIcon2;
    imgIcon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconComplete.png"]];
    imgIcon2.hidden = TRUE;
    
    imgIcon2.frame = CGRectMake(200, 14, 16, 16);
    imgIcon2.tag = 3000+indexPath.row;
    [cell.contentView addSubview:imgIcon2];
    
    return cell;
}


#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedPath = indexPath;
    UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
	
    if (indexPath.row == 0)     //summary
    {
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
        if (!doesContain){
			self.SummaryVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"SummaryScreen"];
            [self addChildViewController:self.SummaryVC];
            [self.rightView addSubview:self.SummaryVC.view];
			
			
//        self.SummaryVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"SummaryScreen"];
//        _SummaryVC.delegate = self;
//        [self addChildViewController:self.SummaryVC];
//        [self.rightView addSubview:self.SummaryVC.view];
		}
    }
    
    else if (indexPath.row == 1)
    {
		self.rightView.hidden = TRUE;
        self.SectAView.hidden = FALSE;
        self.SectBView.hidden = TRUE;
        self.SectCView.hidden = TRUE;
        self.SectDView.hidden = TRUE;
        self.SectEView.hidden = TRUE;
        self.SectFView.hidden = TRUE;
        self.SectGView.hidden = TRUE;
		
        [[obj.eAppData objectForKey:@"EAPP"] setValue:@"SectionA" forKey:@"Sections"];
//		NSLog(@"aaaaaa: %@", [[obj.eAppData objectForKey:@"Sections2"]objectForKey:@"CurrentSection"]);
		
		BOOL doesContain = [self.SectAView.subviews containsObject:self.eAppPersonalDataVC.view];
        if (!doesContain){
			self.eAppPersonalDataVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"eAppDataScreen"];
			[self addChildViewController:self.eAppPersonalDataVC];
			[self.SectAView addSubview:self.eAppPersonalDataVC.view];
		}
    }
    
    else if (indexPath.row == 2)     //policy details
    {
		self.rightView.hidden = TRUE;
        self.SectAView.hidden = TRUE;
        self.SectBView.hidden = FALSE;
        self.SectCView.hidden = TRUE;
        self.SectDView.hidden = TRUE;
        self.SectEView.hidden = TRUE;
        self.SectFView.hidden = TRUE;
        self.SectGView.hidden = TRUE;
		
        [[obj.eAppData objectForKey:@"EAPP"] setValue:@"SectionB" forKey:@"Sections"];
//		NSLog(@"aaaaaa: %@", [[obj.eAppData objectForKey:@"Sections2"]objectForKey:@"CurrentSection"]);
		
        BOOL doesContain = [self.SectBView.subviews containsObject:self.PolicyVC.view];
        if (!doesContain){
//			[[obj.eAppData objectForKey:@"SecB"] setValue:@"Basic   Plan" forKey:@"BasicPlan"];
			self.PolicyVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"MainPolicyScreen"];
			[self addChildViewController:self.PolicyVC];
			[self.SectBView addSubview:self.PolicyVC.view];
		}
    }
    
    else if (indexPath.row == 3)     //Existing  Life Policy
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
//        NSLog(@"aaaaaa: %@", [[obj.eAppData objectForKey:@"Sections2"]objectForKey:@"CurrentSection"]);
		
        BOOL doesContain = [self.SectCView.subviews containsObject:self.part4.view];
        if (!doesContain){
			self.part4 = [nextStoryboard instantiateViewControllerWithIdentifier:@"Part4Existing"];
			[self addChildViewController:self.part4];
			[self.SectCView addSubview:self.part4.view];
		}
    }
    
    else if (indexPath.row == 4)     //nominees & trustees
    {
		self.rightView.hidden = TRUE;
        self.SectAView.hidden = TRUE;
        self.SectBView.hidden = TRUE;
        self.SectCView.hidden = TRUE;
        self.SectDView.hidden = FALSE;
        self.SectEView.hidden = TRUE;
        self.SectFView.hidden = TRUE;
        self.SectGView.hidden = TRUE;
		
        [[obj.eAppData objectForKey:@"EAPP"] setValue:@"SectionD" forKey:@"Sections"];
//		NSLog(@"aaaaaa: %@", [[obj.eAppData objectForKey:@"Sections2"]objectForKey:@"CurrentSection"]);
        
        BOOL doesContain = [self.SectDView.subviews containsObject:self.NomineesVC.view];
        if (!doesContain){
			self.NomineesVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"MainNomineesScreen"];
			[self addChildViewController:self.NomineesVC];
			[self.SectDView addSubview:self.NomineesVC.view];
			
			//1st nominee
			if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_name"] length] != 0) {
				_NomineesVC.Nominee1Lbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_name"];
			}
			//2nd nominee
			if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_name"] length] != 0) {
				_NomineesVC.Nominee2Lbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_name"];
			}
			//3rd nominee
			if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_name"] length] != 0) {
				_NomineesVC.Nominee3Lbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_name"];
			}
			//4th nominee
			if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_name"] length] != 0) {
				_NomineesVC.Nominee4Lbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_name"];
			}
			
			//1st trustee
			if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Name"] length] != 0) {
				NSLog(@"11");
				_NomineesVC.trusteeLbl1.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Name"];
			}
			else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"SamePO"] isEqualToString:@"true"]) {
				NSLog(@"12");
				_NomineesVC.trusteeLbl1.text = @"PO Name";
			}
			else {
				NSLog(@"13");
				_NomineesVC.trusteeLbl1.text = @"Add Trustee (1)";
			}
			//2nd trustee
			if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TName"] length] != 0) {
				NSLog(@"14");
				_NomineesVC.trusteeLbl2.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TName"];
			}
			else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TSamePO"] isEqualToString:@"true"]) {
				NSLog(@"15");
				_NomineesVC.trusteeLbl2.text = @"PO Name";
			}
			else {
				NSLog(@"16");
				_NomineesVC.trusteeLbl2.text = @"Add Trustee (2)";
			}
			
		}
    }
    
    else if (indexPath.row == 5)     //health questions
    {
		self.rightView.hidden = TRUE;
        self.SectAView.hidden = TRUE;
        self.SectBView.hidden = TRUE;
        self.SectCView.hidden = TRUE;
        self.SectDView.hidden = TRUE;
        self.SectEView.hidden = FALSE;
        self.SectFView.hidden = TRUE;
        self.SectGView.hidden = TRUE;
		
        [[obj.eAppData objectForKey:@"EAPP"] setValue:@"SectionE" forKey:@"Sections"];
//		NSLog(@"aaaaaa: %@", [[obj.eAppData objectForKey:@"Sections2"]objectForKey:@"CurrentSection"]);
        
        //BOOL doesContain = [self.SectEView.subviews containsObject:self.HealthVC.view];
        //if (!doesContain){
		//	self.HealthVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"HealthQuestScreen"];
        //_HealthVC.delegate = self;
		//	[self addChildViewController:self.HealthVC];
		//	[self.SectEView addSubview:self.HealthVC.view];
		//}
        BOOL doesContain = [self.SectEView.subviews containsObject:self.HealthQuestionsVC.view];
        if (!doesContain) {
            self.HealthQuestionsVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"HealthQuestionsScreen"];
            [self addChildViewController:self.HealthQuestionsVC];
            [self.SectEView addSubview:self.HealthQuestionsVC.view];
        }
    }
    
    else if (indexPath.row == 6)     //Additional questions
    {
		self.rightView.hidden = TRUE;
        self.SectAView.hidden = TRUE;
        self.SectBView.hidden = TRUE;
        self.SectCView.hidden = TRUE;
        self.SectDView.hidden = TRUE;
        self.SectEView.hidden = TRUE;
        self.SectFView.hidden = FALSE;
        self.SectGView.hidden = TRUE;
		
        [[obj.eAppData objectForKey:@"EAPP"] setValue:@"SectionF" forKey:@"Sections"];
//		NSLog(@"aaaaaa: %@", [[obj.eAppData objectForKey:@"Sections2"]objectForKey:@"CurrentSection"]);
        
        BOOL doesContain = [self.SectFView.subviews containsObject:self.AddQuestVC.view];
        if (!doesContain){
			self.AddQuestVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"AddQuestScreen"];
			[self addChildViewController:self.AddQuestVC];
			[self.SectFView addSubview:self.AddQuestVC.view];
		}
    }
    
    else if (indexPath.row == 7)     //Declaration
    {
		self.rightView.hidden = TRUE;
        self.SectAView.hidden = TRUE;
        self.SectBView.hidden = TRUE;
        self.SectCView.hidden = TRUE;
        self.SectDView.hidden = TRUE;
        self.SectEView.hidden = TRUE;
        self.SectFView.hidden = TRUE;
        self.SectGView.hidden = FALSE;
		
        [[obj.eAppData objectForKey:@"EAPP"] setValue:@"SectionG" forKey:@"Sections"];
//		NSLog(@"aaaaaa: %@", [[obj.eAppData objectForKey:@"Sections2"]objectForKey:@"CurrentSection"]);
        
        BOOL doesContain = [self.SectGView.subviews containsObject:self.DeclareVC.view];
        if (!doesContain){
			self.DeclareVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"DeclareEAppScreen"];
			[self addChildViewController:self.DeclareVC];
			[self.SectGView addSubview:self.DeclareVC.view];
		}
    }

    nextStoryboard = nil;
}

-(void)selectedMenu:(NSString *)menu
{
//    NSLog(@"receive menu %@",menu);
    UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
    
    if ([menu isEqualToString:@"1"]) {
        
//        NSLog(@"1");
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
    [super viewDidUnload];
}

- (IBAction)doeAppChecklist:(id)sender {
        [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)doDone:(id)sender {
	NSLog(@"do done what: %@", [[obj.eAppData objectForKey:@"EAPP"]objectForKey:@"Sections"]);
	if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionA"]) {
		if (_eAppPersonalDataVC.p2) {
            [self alertForPersonalDetails];
			[[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"TickPart2"];
			[[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.titleLbl.text forKey:@"Title"];
			if (_eAppPersonalDataVC.sexSC.selectedSegmentIndex == 0) {
				[[obj.eAppData objectForKey:@"SecA"] setValue:@"M" forKey:@"Sex"];
			}
			else {
				[[obj.eAppData objectForKey:@"SecA"] setValue:@"F" forKey:@"Sex"];
			}
			[[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.fullNameTF.text forKey:@"FullName"];
			[[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.telNoTF.text forKey:@"TelNo"];
			[[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.icNoTF.text forKey:@"ICNo"];
			[[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.mobileTF.text forKey:@"MobileNo"];
			[[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.DOBLbl.text forKey:@"DOB"];
			[[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.emailTF.text forKey:@"Email"];
			[[obj.eAppData objectForKey:@"SecA"] setValue:_eAppPersonalDataVC.OtherIDLbl.text forKey:@"OtherIDType"];
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
		}
		else {
			[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickPart2"];
		}
		UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3001];
		imageView.hidden = FALSE;
		imageView = nil;
		
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"SecA_Saved"];
		_SummaryVC.tickPersonalDetails.text =  @"✓";
		[self saveEApp];
		
	}
	else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionB"]) {
	if ([self validSecB]){
        
        if (_PolicyVC.ccsi) {
			[self alertForPolicyDetails];
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
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.memberOtherIDTypeLbl.text forKey:@"MemberOtherIDType"];
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.memberOtherIDTF.text forKey:@"MemberOtherID"];
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.memberContactNoTF.text forKey:@"MemberContactNo"];
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.memberRelationshipLbl.text forKey:@"MemberRelationship"];
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

            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.firstTimePaymentLbl.text forKey:@"FirstTimePayment"];
			if (_PolicyVC.deductSC.selectedSegmentIndex == 0) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"Y" forKey:@"FirstPaymentDeduct"];
			}
			else if (_PolicyVC.deductSC.selectedSegmentIndex == 1) {
				[[obj.eAppData objectForKey:@"SecB"] setValue:@"N" forKey:@"FirstPaymentDeduct"];
			}
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.recurPaymentLbl.text forKey:@"RecurringPayment"];
            
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.agentCodeTF.text forKey:@"AgentCode"];
            [[obj.eAppData objectForKey:@"SecB"] setValue:_PolicyVC.agentContactNoTF.text forKey:@"AgentContactNo"];
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
            
            [Utility showAllert:@"Record saved successfully."];
            
            [[obj.eAppData objectForKey:@"SecB"] setValue:@"Y" forKey:@"SecB_Saved"];
//            _SummaryVC.tickPolicyDetails.text =  @"✓";
		[self saveEApp];
        }
//	}
    }
	else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionC"]) {
//	if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"SecB_Saved"] isEqualToString:@"Y"]) {
		NSLog(@"yay for c");
//		NSLog(@"data ###: %@", [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] objectForKey:@"PolicyData"]);
 		if ([self validSecC]){
            NSLog(@"valid c");
            [[obj.eAppData objectForKey:@"SecC"] setValue:_part4.personTypeLbl.text forKey:@"PersonType"];
            
//			if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PersonType"] isEqualToString:@"1st Life Assured"]) {
				
//				if (_part4.Q1SC.selectedSegmentIndex == 0) {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"ExistingPolicies"];
//				}
//				else {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"ExistingPolicies"];
//				}
//				
//				if (_part4.noticeASC.selectedSegmentIndex == 0) {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"NoticeA"];
//				}
//				else {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"NoticeA"];
//				}
//				
//				if (_part4.noticeBSC.selectedSegmentIndex == 0) {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"NoticeB"];
//				}
//				else if (_part4.noticeBSC.selectedSegmentIndex == 1) {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"NoticeB"];
//				}
//				else {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"" forKey:@"NoticeB"];
//				}
//				if (_part4.noticeCSC.selectedSegmentIndex == 0) {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"NoticeC"];
//				}
//				else if (_part4.noticeCSC.selectedSegmentIndex == 1) {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"NoticeC"];
//				}
//				else {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"" forKey:@"NoticeC"];
//				}
//				if (_part4.noticeDSC.selectedSegmentIndex == 0) {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"NoticeD"];
//				}
//				else if (_part4.noticeDSC.selectedSegmentIndex == 1) {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"NoticeD"];
//				}
//				else {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"" forKey:@"NoticeD"];
//				}
//							
//				if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"CD"] isEqualToString:@"A"]) {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Keep" forKey:@"CashDividend"];
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"WdCashDividend"];
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"KpCashDividend"];
//				}
//				else {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Withdraw" forKey:@"CashDividend"];
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"WdCashDividend"];
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"KpCashDividend"];
//				}
//							
//				if (_part4.pb) {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"PolicyBackdating"];
//					[[obj.eAppData objectForKey:@"SecC"] setValue:_part4.dateSpecialReqLbl.text forKey:@"DatePolicyBackdating"];
//				}
//				else {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"PolicyBackdating"];
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"" forKey:@"DatePolicyBackdating"];
//				}
//				
////			}
////			else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PersonType"] isEqualToString:@"Policy Owner"]) {
//				
//				if (_part4.Q1POSC.selectedSegmentIndex == 0) {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"ExistingPoliciesPO"];
//				}
//				else {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"ExistingPoliciesPO"];
//				}
//				
//				if (_part4.noticeAPOSC.selectedSegmentIndex == 0) {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"NoticeAPO"];
//				}
//				else {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"NoticeAPO"];
//				}
//				
//				if (_part4.noticeBPOSC.selectedSegmentIndex == 0) {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"NoticeBPO"];
//				}
//				else if (_part4.noticeBPOSC.selectedSegmentIndex == 1) {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"NoticeBPO"];
//				}
//				else {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"" forKey:@"NoticeBPO"];
//				}
//				if (_part4.noticeCPOSC.selectedSegmentIndex == 0) {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"NoticeCPO"];
//				}
//				else if (_part4.noticeCPOSC.selectedSegmentIndex == 1) {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"NoticeCPO"];
//				}
//				else {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"" forKey:@"NoticeCPO"];
//				}
//				if (_part4.noticeDPOSC.selectedSegmentIndex == 0) {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"NoticeDPO"];
//				}
//				else if (_part4.noticeDPOSC.selectedSegmentIndex == 1) {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"NoticeDPO"];
//				}
//				else {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"" forKey:@"NoticeDPO"];
//				}
//				
////				if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"CD"] isEqualToString:@"A"]) {
////					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Keep" forKey:@"CashDividend"];
////					[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"WdCashDividend"];
////					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"KpCashDividend"];
////				}
////				else {
////					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Withdraw" forKey:@"CashDividend"];
////					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"WdCashDividend"];
////					[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"KpCashDividend"];
////				}
//				
//				if (_part4.pbPO) {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"PolicyBackdatingPO"];
//					[[obj.eAppData objectForKey:@"SecC"] setValue:_part4.dateSpecialReqPOLbl.text forKey:@"DatePolicyBackdatingPO"];
//				}
//				else {
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"PolicyBackdatingPO"];
//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"" forKey:@"DatePolicyBackdatingPO"];
//				}
//				
////			}
//			
//			if (_part4.Q1LA2SC.selectedSegmentIndex == 0) {
//				[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"ExistingPoliciesLA2"];
//			}
//			else {
//				[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"ExistingPoliciesLA2"];
//			}
//			
//			if (_part4.noticeALA2SC.selectedSegmentIndex == 0) {
//				[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"NoticeALA2"];
//			}
//			else {
//				[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"NoticeALA2"];
//			}
//			
//			if (_part4.noticeBLA2SC.selectedSegmentIndex == 0) {
//				[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"NoticeBLA2"];
//			}
//			else if (_part4.noticeBLA2SC.selectedSegmentIndex == 1) {
//				[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"NoticeBLA2"];
//			}
//			else {
//				[[obj.eAppData objectForKey:@"SecC"] setValue:@"" forKey:@"NoticeBLA2"];
//			}
//			if (_part4.noticeCLA2SC.selectedSegmentIndex == 0) {
//				[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"NoticeCLA2"];
//			}
//			else if (_part4.noticeCLA2SC.selectedSegmentIndex == 1) {
//				[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"NoticeCLA2"];
//			}
//			else {
//				[[obj.eAppData objectForKey:@"SecC"] setValue:@"" forKey:@"NoticeCLA2"];
//			}
//			if (_part4.noticeDLA2SC.selectedSegmentIndex == 0) {
//				[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"NoticeDLA2"];
//			}
//			else if (_part4.noticeDLA2SC.selectedSegmentIndex == 1) {
//				[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"NoticeDLA2"];
//			}
//			else {
//				[[obj.eAppData objectForKey:@"SecC"] setValue:@"" forKey:@"NoticeDLA2"];
//			}
//			
//			//				if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"CD"] isEqualToString:@"A"]) {
//			//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Keep" forKey:@"CashDividend"];
//			//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"WdCashDividend"];
//			//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"KpCashDividend"];
//			//				}
//			//				else {
//			//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Withdraw" forKey:@"CashDividend"];
//			//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"WdCashDividend"];
//			//					[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"KpCashDividend"];
//			//				}
//			
//			if (_part4.pbLA2) {
//				[[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"PolicyBackdatingLA2"];
//				[[obj.eAppData objectForKey:@"SecC"] setValue:_part4.dateSpecialReqPOLbl.text forKey:@"DatePolicyBackdatingLA2"];
//			}
//			else {
//				[[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"PolicyBackdatingLA2"];
//				[[obj.eAppData objectForKey:@"SecC"] setValue:@"" forKey:@"DatePolicyBackdatingLA2"];
//			}
			
			
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3003];
            imageView.hidden = FALSE;
            imageView = nil;
            
            [Utility showAllert:@"Record saved successfully."];
            
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"SecC_Saved"];
			if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"SecC_Saved"] isEqualToString:@"Y"] && [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"SecB_Saved"] isEqualToString:@"Y"]) {
				_SummaryVC.tickPolicyDetails.text =  @"✓";
			}
            [self saveEApp];
 		}
//	}
//	else {
//		[Utility showAllert:@"Please complete Policy Details section first."];
//	}
	}
	else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionD"]) {
        
        if ([self validSecD]){
			
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3004];
            imageView.hidden = FALSE;
            imageView = nil;
            
            [Utility showAllert:@"Record saved successfully."];
            
            [[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"SecD_Saved"];
			
            _SummaryVC.tickNominees.text =  @"✓";
            
            [self saveEApp];
 		}
	}
	else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionE"]) {
        /*
		if ([self validSecE]){
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
	
		}*/
        
        
        
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message: alertMsg
                              delegate: self
                              cancelButtonTitle:@"Yes"
                              otherButtonTitles:@"No", nil];
        
        
        [alert setTag:1002];
        [alert show];
        alert = Nil;
        
        

	}
	else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionF"]) {
		if ([self validSecF]){
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3006];
            imageView.hidden = FALSE;
            imageView = nil;
            
            [Utility showAllert:@"Record saved successfully."];
            
            [[obj.eAppData objectForKey:@"SecF"] setValue:@"Y" forKey:@"SecF_Saved"];
            _SummaryVC.tickAdditionalQuestions.text =  @"✓";
            [self saveEApp];
            
		}
	}
	else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sections"] isEqualToString:@"SectionG"]) {
		if ([self validSecG]){
			
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3007];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
            NSLog(@"sss ###: %@", [[obj.eAppData objectForKey:@"SecG"] objectForKey:@"Declaration_agree"]);
            [[obj.eAppData objectForKey:@"SecG"] setValue:@"Y" forKey:@"SecG_Saved"];
            _SummaryVC.tickDeclaration.text = @"✓";
            [self saveEApp];
            
		}
	}
	else {
	UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"iMobile Planner"
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

- (void)alertForPolicyDetails {
	//	NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
	//	[f setNumberStyle:NSNumberFormatterDecimalStyle];
	//	NSNumber *myNumber = [f numberFromString:nominees.sharePercentageTF.text];
	//
	//	NSNumberFormatter * f2 = [[NSNumberFormatter alloc] init];
	//	[f2 setNumberStyle:NSNumberFormatterDecimalStyle];
	//	NSNumber *myNumber2 = [f2 numberFromString:@"100"];
	
	if (_PolicyVC.personTypeLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Person Type is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 100;
		[alert show];
	}
	else if (_PolicyVC.bankLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Issuing Bank is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 200;
		[alert show];
	}
	else if (_PolicyVC.cardTypeLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Card Type is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 300;
		[alert show];
	}
	else if (_PolicyVC.accNoTF.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Card No. is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 400;
		[alert show];
	}
	else if (_PolicyVC.expiryDateTF.text.length == 0 && _PolicyVC.expiryDateYearTF.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Card Expired Date is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 500;
		[alert show];
	}
	
	//Other Payor start
	else if (_PolicyVC.op) {
	if (_PolicyVC.memberNameTF.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Name is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 601;
		[alert show];
	}
	else if ([textFields validateString:_PolicyVC.memberNameTF.text])
	{
//		NSLog(@"same");
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Invalid name format. Same alphabet cannot be repeated more than three times." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 602;
		[alert show];
	}
	else if (_PolicyVC.memberSexSC.selectedSegmentIndex == -1) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Sex is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 603;
		[alert show];
	}
	else if (_PolicyVC.memberDOBLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Date of Birth is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 604;
		[alert show];
	}
	else if (_PolicyVC.memberIC.text.length == 0 && _PolicyVC.memberOtherIDTypeLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Either New IC No. or Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 605;
		[alert show];
	}
	else if (!(_PolicyVC.memberOtherIDTypeLbl.text.length == 0) && _PolicyVC.memberOtherIDTF.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 606;
		[alert show];
	}
	else if (_PolicyVC.memberContactNoTF.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Contact No. is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 607;
		[alert show];
	}
	else if (_PolicyVC.memberRelationshipLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Relationship is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 608;
		[alert show];
	}
//	else {
//		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Record saved successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		NSLog(@"no title b1");
//		//		alert.tag = 608;
//		[alert show];
//	}
		
	}
	//Other Payor end
	else {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Record saved successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		NSLog(@"no title b2");
//		alert.tag = 608;
		[alert show];
	}
		
}

- (void)alertForPersonalDetails {
	//	NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
	//	[f setNumberStyle:NSNumberFormatterDecimalStyle];
	//	NSNumber *myNumber = [f numberFromString:nominees.sharePercentageTF.text];
	//
	//	NSNumberFormatter * f2 = [[NSNumberFormatter alloc] init];
	//	[f2 setNumberStyle:NSNumberFormatterDecimalStyle];
	//	NSNumber *myNumber2 = [f2 numberFromString:@"100"];
	
	if (_eAppPersonalDataVC.titleLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Title is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 1000;
		[alert show];
	}
	else if (_eAppPersonalDataVC.fullNameTF.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Name is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 2000;
		[alert show];
	}
	else if (_eAppPersonalDataVC.icNoTF.text.length == 0 && _eAppPersonalDataVC.OtherIDLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Either New IC No. or Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 3000;
		[alert show];
	}
	else if (_eAppPersonalDataVC.DOBLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Date of Birth is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 4000;
		[alert show];
	}
	else if (_eAppPersonalDataVC.sexSC.selectedSegmentIndex == -1) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Sex is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 5000;
		[alert show];
	}
	else if (_eAppPersonalDataVC.telNoTF.text.length == 0 && _eAppPersonalDataVC.mobileTF.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Either one Contact No. is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 6000;
		[alert show];
	}
	else if (!(_eAppPersonalDataVC.OtherIDLbl.text.length == 0) && _eAppPersonalDataVC.otherIDTF.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 7000;
		[alert show];
	}
	else if (_eAppPersonalDataVC.RelationshipLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Relationship is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 8000;
		[alert show];
	}
		 
	//Not Same Address start
	else if (!_eAppPersonalDataVC.sa) {
		if (_eAppPersonalDataVC.addressTF.text.length == 0) {
            
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 9001;
			[alert show];
		}
		//not foreign add start
		else if (!_eAppPersonalDataVC.fa) {
			if (_eAppPersonalDataVC.postcodeTF.text.length == 0) {
				UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Postcode is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				//		NSLog(@"no title");
				alert.tag = 9002;
				[alert show];
			}
			else if ([_eAppPersonalDataVC.stateLbl.text isEqualToString:@"State"]) {
				UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Invalid Post Code." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				//		NSLog(@"no title");
				alert.tag = 9003;
				[alert show];
			}
			else {
				UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Record saved successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				//		NSLog(@"no title");
				//		alert.tag = 608;
				[alert show];
			}
		}
		//not foreign add end
		//foreign add start
		else if (_eAppPersonalDataVC.fa) {
			if (_eAppPersonalDataVC.countryLbl.text.length == 0) {
				UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Country is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				//		NSLog(@"no title");
				alert.tag = 9004;
				[alert show];
			}
			else {
				UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Record saved successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				//		NSLog(@"no title");
				//		alert.tag = 608;
				[alert show];
			}
		}
		//foreign add end
		else {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Record saved successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			//		alert.tag = 608;
			[alert show];
		}
	}
	//Not Same Address end
	else {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Record saved successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		//		alert.tag = 608;
		[alert show];
	}
}

- (BOOL)validSecB {
	if (_PolicyVC.firstTimePaymentLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"First Time Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		return FALSE;
	}
	else if (_PolicyVC.recurPaymentLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Recurring Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		return FALSE;
	}
	else
		return TRUE;
}


-(BOOL)validSecC{
    if(_part4.personTypeLbl.text.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Person Type is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        return  FALSE;
    }
    // 1st LA checking
	if ([_part4.personTypeLbl.text isEqualToString:@"1st Life Assured"]) {
		if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies1stLA"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Existing Policy Question 1 is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
			return  FALSE;
		}
        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies1stLA"] isEqualToString:@"Y"]) {
            if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] objectForKey:@"PolicyData"] count] == 0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Details of Existing Policy for 1st Life Assured is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return  FALSE;
            }
        }
        else if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA1stLA"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Existing Policy Question 2(a) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return  FALSE;
        }
        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA1stLA"] isEqualToString:@"Y"] && ![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeB1stLA"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Existing Policy Question 2(b) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
            return FALSE;
        }
        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA1stLA"] isEqualToString:@"Y"] && ![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeC1stLA"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Existing Policy Question 2(c) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
            return  FALSE;
        }
        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA1stLA"] isEqualToString:@"Y"] && ![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeD1stLA"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Existing Policy Question 2(d) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
            return  FALSE;
        }
        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PolicyBackdating1stLA"] isEqualToString:@"Y"]) {
            if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdating1stLA"]) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Policy Backdating is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return  FALSE;
            }
        }
    }
    // 2nd LA checking
    if ([_part4.personTypeLbl.text isEqualToString:@"2nd Life Assured"]) {
        NSLog(@"21");
		if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies2ndLA"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Existing Policy Question 1 is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
			return  FALSE;
		}
        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy2ndLA"] isEqualToString:@"Y"]) {
            if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy2ndLA"] objectForKey:@"PolicyData"] count] == 0) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Details of Existing Policy for 2nd Life Assured is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return  FALSE;
            }
        }
        else if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA2ndLA"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Existing Policy Question 2(a) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return  FALSE;
        }
        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA2ndLA"] isEqualToString:@"Y"] && ![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeB2ndLA"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Existing Policy Question 2(b) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
            return FALSE;
        }
        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA2ndLA"] isEqualToString:@"Y"] && ![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeC2ndLA"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Existing Policy Question 2(c) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
            return  FALSE;
        }
        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA2ndLA"] isEqualToString:@"Y"] && ![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeD2ndLA"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Existing Policy Question 2(d) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
            return  FALSE;
        }
        else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PolicyBackdating2ndLA"] isEqualToString:@"Y"]) {
            if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdating2ndLA"]) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Policy Backdating is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return  FALSE;
            }
        }
    }
    //PO checking
    if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyPO"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Please complete Existing Policy Question for Policy Owner." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			return  FALSE;
    }
    else if ([_part4.personTypeLbl.text isEqualToString:@"Policy Owner"]) {
		if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyPO"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Existing Policy Question 1 is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			return  FALSE;
		}
		else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyPO"] isEqualToString:@"Y"]) {
			if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyPO"] objectForKey:@"PolicyData"] count] == 0) {
				UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Details of Existing Policy for Policy Owner is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
                return  FALSE;
			}
		}
		else if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeAPO"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Existing Policy Question 2(a) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			return  FALSE;
		}
		else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeAPO"] isEqualToString:@"Y"] && ![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeBPO"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Existing Policy Question 2(b) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			return FALSE;
		}
		else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeAPO"] isEqualToString:@"Y"] && ![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeCPO"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Existing Policy Question 2(c) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			return  FALSE;
		}
		else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeAPO"] isEqualToString:@"Y"] && ![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeDPO"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Existing Policy Question 2(d) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			return  FALSE;
		}
		else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PolicyBackdatingPO"] isEqualToString:@"Y"]) {
			if (![[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdatingPO"]) {
				UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Policy Backdating is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
                return  FALSE;
			}
		}
    }
		//check part 1 start
//		else if (_part4.Q1SC.selectedSegmentIndex == -1) {
//			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Please complete Existing Policy Question for 1st Life Assured." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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

- (void)alertForExistingPolicies {
	//Details of Existing Policy is required.
//	if (_part4.personTypeLbl.text.length == 0) {
//		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Person Type is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		//		alert.tag = 608;
//		[alert show];
//
//	}
//	else if (_part4.noticeASC.selectedSegmentIndex == 0 && _part4.noticeBSC.selectedSegmentIndex == -1) {
//		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Existing Policy Question 2(b) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		//		alert.tag = 608;
//		[alert show];
//	}
//	else if (_part4.noticeASC.selectedSegmentIndex == 0 && _part4.noticeCSC.selectedSegmentIndex == -1) {
//		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Existing Policy Question 2(c) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		//		alert.tag = 608;
//		[alert show];
//	}
//	else if (_part4.noticeASC.selectedSegmentIndex == 0 && _part4.noticeDSC.selectedSegmentIndex == -1) {
//		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Existing Policy Question 2(d) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		//		alert.tag = 608;
//		[alert show];
//	}
//	else if (_part4.pb && _part4.dateSpecialReqLbl.text.length == 0) {
//		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Policy Backdating is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		//		alert.tag = 608;
//		[alert show];
//	}
//	else if (_part4.noticeASC.selectedSegmentIndex == 0 && [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FirstTimePayment"] == Nil) {
//		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"First Time Payment is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		alert.tag = 41;
//		[alert show];
//	}
//	else {
//		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Record saved successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		//		alert.tag = 608;
//		[alert show];
//	}
}

-(BOOL)validSecD {
    
   
  //  int total = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"] intValue];
     // NSLog(@"MasterMenuEApp validSecD total - %@", [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"]);
//    if ([self.NomineesVC.Nominee1Lbl.text isEqualToString:@"Add Nominee (1)"]
//        && [self.NomineesVC.Nominee2Lbl.text isEqualToString:@"Add Nominee (2)"]
//        && [self.NomineesVC.Nominee3Lbl.text isEqualToString:@"Add Nominee (3)"]
//        && [self.NomineesVC.Nominee4Lbl.text isEqualToString:@"Add Nominee (4)"]
//        && [self.NomineesVC.trusteeLbl1.text isEqualToString:@"Add Trustee (1)"]
//        && [self.NomineesVC.trusteeLbl2.text isEqualToString:@"Add Trustee (2)"])
//    {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"No Nominee/Trustee record to save." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        
//        [alert setTag:1001];
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
    
//    if (total < 100)
//    {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Total Percentage of Share less than 100% " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        
//        [alert setTag:1001];
//        [alert show];
//        alert = Nil;
//        return FALSE;
//        
//    }
//    else
//    {
        if(self.NomineesVC.Nominee1Lbl.text.length != 0 )
            [[obj.eAppData objectForKey:@"SecD"] setValue:self.NomineesVC.Nominee1Lbl.text forKey:@"nominee1"];
        if(self.NomineesVC.Nominee2Lbl.text.length != 0 )
            [[obj.eAppData objectForKey:@"SecD"] setValue:self.NomineesVC.Nominee2Lbl.text forKey:@"nominee2"];
        if(self.NomineesVC.Nominee3Lbl.text.length != 0 )
            [[obj.eAppData objectForKey:@"SecD"] setValue:self.NomineesVC.Nominee3Lbl.text forKey:@"nominee3"];
        if(self.NomineesVC.Nominee4Lbl.text.length != 0 )
            [[obj.eAppData objectForKey:@"SecD"] setValue:self.NomineesVC.Nominee4Lbl.text forKey:@"nominee4"];
        
        return  TRUE;
//    }
    
}
-(BOOL)validSecE {
    
    NSArray *keys1 = [[NSArray alloc] initWithObjects:@"LA1HQ", @"LA2HQ", @"POHQ",nil];
    NSArray *keys2 = [[NSArray alloc] initWithObjects:@"SecE_Q1B", @"SecE_Q2", @"SecE_Q3", @"SecE_Q4", @"SecE_Q5", @"SecE_Q6", @"SecE_Q7A", @"SecE_Q7B", @"SecE_Q7C",@"SecE_Q7D", @"SecE_Q7E",@"SecE_Q7F",@"SecE_Q7G", @"SecE_Q7H", @"SecE_Q7I", @"SecE_Q7J", @"SecE_Q8A", @"SecE_Q8B", @"SecE_Q8C", @"SecE_Q8D", @"SecE_Q8E", @"SecE_Q9", @"SecE_Q10", @"SecE_Q11", @"SecE_Q12", @"SecE_Q13", @"SecE_Q14A", @"SecE_Q14B", @"SecE_Q15",nil];
    
    for (NSString *key1 in keys1) {
        for (NSString *key2 in keys2) {
            NSLog(@"%@", key2);
            if ([[obj.eAppData objectForKey:@"SecE"] objectForKey:key1]) {
                if (![[[obj.eAppData objectForKey:@"SecE"] objectForKey:key1] objectForKey:key2]) {
                    return FALSE;
                }
            }
        }
    }
    [[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"SecE_Saved"];
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

-(BOOL)validSecF
{
    
    if(self.AddQuestVC.nameTF.text.length == 0)
    {
        [Utility showAllert:@"Name is required."];
        [self.AddQuestVC.nameTF becomeFirstResponder];
        return FALSE;
    }
    else if(self.AddQuestVC.incomeTF.text.length == 0)
    {
        [Utility showAllert:@"Income is required."];
        [self.AddQuestVC.incomeTF becomeFirstResponder];
        return FALSE;
    }
    else if([(self.AddQuestVC.occupationLbl.text)isEqualToString:@"Occupation of Husband/Parent"])
    {
        [Utility showAllert:@"Occupation is required."];
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
            [Utility showAllert:@"Full Details of Insured is required."];
            return FALSE;
        }
        
        
    }
    else if(self.AddQuestVC.insuredSC.selectedSegmentIndex == 1)
    {
        if(self.AddQuestVC.reasonTF.text.length == 0)
        {
            [Utility showAllert:@"Reason is required."];
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
		[[obj.eAppData objectForKey:@"SecF"] setValue:@"Y" forKey:@"Insured"];
	}
	else {
		[[obj.eAppData objectForKey:@"SecF"] setValue:@"N" forKey:@"Insured"];
	}
    [[obj.eAppData objectForKey:@"SecF"] setValue:self.AddQuestVC.reasonTF.text forKey:@"No_Reason"];
    return TRUE;
    
    
}
-(BOOL)validSecG
{
	
    if(self.DeclareVC.agreed == 0 && self.DeclareVC.disagreed == 0 ){
        [Utility showAllert:@"Declaration is required."];
        return FALSE;
    }
    else{
        
		if(self.DeclareVC.agreed == 1) {
			NSLog(@"a");
			[[obj.eAppData objectForKey:@"SecG"] setValue:@"Y" forKey:@"Declaration_agree"];
		}
		else if (self.DeclareVC.disagreed == 1) {
			NSLog(@"da");
			[[obj.eAppData objectForKey:@"SecG"] setValue:@"N" forKey:@"Declaration_agree"];
		}
        
		return TRUE;
    }
	
	
	
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001 && buttonIndex == 0)
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
		[_PolicyVC.memberContactNoTF becomeFirstResponder];
	}
	else if (alertView.tag == 2000) {
		[_eAppPersonalDataVC.fullNameTF becomeFirstResponder];
	}
	else if (alertView.tag == 3000) {
		[_eAppPersonalDataVC.icNoTF becomeFirstResponder];
	}
	else if (alertView.tag == 6000) {
		[_eAppPersonalDataVC.telNoTF becomeFirstResponder];
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
}

- (void)saveEApp {
	NSLog(@"save eapp");
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
    int lastId;
	
//	if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"NewProposal"] isEqualToString:@"1"]) {
//		NSLog(@"new proposal: %@", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"NewProposal"]);
//		[db executeUpdate:@"DELETE FROM eProposal WHERE SINo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], Nil];
//		[db executeUpdate:@"INSERT INTO eProposal (SINo, CreatedAt, UpdatedAt) VALUES(?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], commDate, commDate, nil];

		lastId = [db lastInsertRowId];
		[[obj.eAppData objectForKey:@"EAPP"] setValue:[NSString stringWithFormat:@"%d",lastId] forKey:@"lastId"];
		
		results2 = Nil;
		results2 = [db executeQuery:@"select * from eProposal where SINo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
		while ([results2 next]) {
			[[obj.eAppData objectForKey:@"EAPP"] setValue:[results2 stringForColumn:@"eProposalNo"] forKey:@"eProposalID"];
		}
//	}
	
	lastId = [[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"lastId"] intValue];
	
	//Section A Start
	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SecA_Saved"] isEqualToString:@"Y"]) {
		
	
	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickPart2"] isEqualToString:@"Y"])
//	if (_eAppPersonalDataVC.fullNameTF.text.length != 0)
	{
		NSLog(@"update a yes");
//		NSLog(@"test save a: %@", [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Title"]);
		NSString *query = @"";
		query = [NSString stringWithFormat:@"UPDATE eProposal SET COMandatoryFlag = '%@', COTitle = '%@', COSex = '%@', COName = '%@', COPhoneNo = '%@', CONewICNo = '%@', COMobileNo = '%@', CODOB = '%@', COEmailAddress = '%@', COOtherIDType = '%@', COOtherID = '%@', CORelationship = '%@', COSameAddressPO = '%@', COAddress1 = '%@', COAddress2 = '%@', COAddress3 = '%@', COPostcode = '%@', COTown = '%@', COState = '%@', COCountry = '%@', UpdatedAt = '%@', LAMandatoryFlag = '%@', COForeignAddressFlag = '%@' WHERE eProposalNo = '%@'", [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickPart2"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Title"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Sex"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"FullName"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TelNo"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ICNo"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"MobileNo"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"DOB"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Email"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"OtherIDType"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"OtherID"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Relationship"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SameAddress"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Address1"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Address2"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Address3"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Postcode"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Town"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"State"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Country"],commDate, [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SecA_Saved"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ForeignAddress"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]];
		[db executeUpdate:query];
	}
	else if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickPart2"] isEqualToString:@"N"])
	{
		NSLog(@"update a no");
		NSString *query = @"";
//		NSLog(@"eproposal a no: %@", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]);
		query = [NSString stringWithFormat:@"UPDATE eProposal SET COMandatoryFlag = '%@', UpdatedAt = '%@', LAMandatoryFlag = '%@' WHERE eProposalNo = '%@'", [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickPart2"], commDate, [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SecA_Saved"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]];
		[db executeUpdate:query];
	}
		
	}
	//Section A End
	
	//Section B Start
	if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"SecB_Saved"] isEqualToString:@"Y"]) {
				
//		if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickPart2"] isEqualToString:@"Y"])
			//	if (_eAppPersonalDataVC.fullNameTF.text.length != 0)
//		{
			NSLog(@"update b yes");
//			[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"BasicUnitAcc"], [obj.eAppData objectForKey:@"SecB"] objectForKey:@"RiderUnitAcc"],
			NSString *query = @"";
		query = [NSString stringWithFormat:@"UPDATE eProposal SET PaymentMode = '%@', BasicPlanCode = '%@', BasicPlanTerm = '%@', BasicPlanSA = '%@', BasicPlanModalPremium = '%@', TotalModalPremium = '%@', FirstTimePayment = '%@', PaymentUponFinalAcceptance = '%@', RecurringPayment = '%@', SecondAgentCode = '%@', SecondAgentContactNo = '%@', SecondAgentName = '%@', PTypeCode = '%@', CreditCardBank = '%@', CreditCardType = '%@', CardMemberAccountNo = '%@', CardExpiredDate = '%@', CardMemberName = '%@', CardMemberSex = '%@', CardMemberDOB = '%@', CardMemberNewICNo = '%@', CardMemberOtherIDType = '%@', CardMemberOtherID = '%@', CardMemberContactNo = '%@', CardMemberRelationship = '%@', FullyPaidUpOption = '%@', FullyPaidUpTerm = '%@', RevisedSA = '%@', AmtRevised = '%@', PolicyDetailsMandatoryFlag = '%@' WHERE eProposalNo = '%@'", [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaymentMode"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"BasicPlan"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"Term"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"SumAssured"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"BasicPremium"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"TotalPremium"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FirstTimePayment"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"FirstPaymentDeduct"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"RecurringPayment"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"AgentCode"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"AgentContactNo"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"AgentName"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PersonType"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"IssuingBank"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardType"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardAccNo"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"CardExpDate"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberName"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberSex"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberDOB"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberIC"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberOtherIDType"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberOtherID"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberContactNo"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"MemberRelationship"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaidUpOption"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"PaidUpTerm"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"RevisedSumAssured"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"RevisedAmount"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"SecB_Saved"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]];
			[db executeUpdate:query];
//		}
//		else if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickPart2"] isEqualToString:@"N"])
//		{
//			NSLog(@"update a no");
//			NSString *query = @"";
//			query = [NSString stringWithFormat:@"UPDATE eProposal SET COMandatoryFlag = '%@', UpdatedAt = '%@', LAMandatoryFlag = '%@' WHERE ID = %d", [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickPart2"], commDate, [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SecA_Saved"], lastId];
//			//		[db executeUpdate:query];
//		}
		
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
//	[db executeUpdate:@"DELETE FROM eProposal_Existing_Policy_2 WHERE eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], Nil];
		
				
		NSLog(@"insert c");
		[db executeUpdate:@"INSERT INTO eProposal_Existing_Policy_1(eProposalNo, ProposalPTypeCode, ExistingPolicy_Answer1, ExistingPolicy_Answer2, ExistingPolicy_Answer3, ExistingPolicy_Answer4, ExistingPolicy_Answer5, Withdraw_CashDividend, CompanyKeep_CashDividend, CashPayment_PO, CashPayment_Acc, blnBackDating, BackDating, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], @"LA1", [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies1stLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA1stLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeB1stLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeC1stLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeD1stLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"CashDividend"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TradGuaranteedCPI"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TPWithdrawPct"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TPKeepPct"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PolicyBackdating1stLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdating1stLA"], commDate, commDate, Nil];
		
		[db executeUpdate:@"INSERT INTO eProposal_Existing_Policy_1(eProposalNo, ProposalPTypeCode, ExistingPolicy_Answer1, ExistingPolicy_Answer2, ExistingPolicy_Answer3, ExistingPolicy_Answer4, ExistingPolicy_Answer5, Withdraw_CashDividend, CompanyKeep_CashDividend, CashPayment_PO, CashPayment_Acc, blnBackDating, BackDating, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], @"PO", [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPoliciesPO"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeAPO"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeBPO"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeCPO"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeDPO"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"CashDividend"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TradGuaranteedCPI"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TPWithdrawPct"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TPKeepPct"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PolicyBackdatingPO"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdatingPO"], commDate, commDate, Nil];
		
		[db executeUpdate:@"INSERT INTO eProposal_Existing_Policy_1(eProposalNo, ProposalPTypeCode, ExistingPolicy_Answer1, ExistingPolicy_Answer2, ExistingPolicy_Answer3, ExistingPolicy_Answer4, ExistingPolicy_Answer5, Withdraw_CashDividend, CompanyKeep_CashDividend, CashPayment_PO, CashPayment_Acc, blnBackDating, BackDating, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], @"LA2", [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies2ndLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA2ndLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeB2ndLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeC2ndLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeD2ndLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"CashDividend"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TradGuaranteedCPI"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TPWithdrawPct"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TPKeepPct"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PolicyBackdating2ndLA"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdating2ndLA"], commDate, commDate, Nil];
		
		//policy data start
        NSArray *policyKeys = [NSArray arrayWithObjects:@"ExistingPolicy1stLA", @"ExistingPolicy2ndLA", @"ExistingPolicyPO", nil];
        for (NSString *key in policyKeys) {
            if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:key] objectForKey:@"PolicyData"] count] != 0) {
                NSString *pt;
                NSString *cn;
                NSString *ltsa;
                NSString *asa;
                NSString *cisa;
                NSString *di;
                
                for (int i=0; i<[[[[obj.eAppData objectForKey:@"SecC"] objectForKey:key] objectForKey:@"PolicyData"] count]; i++) {
                    pt = [[[[[obj.eAppData objectForKey:@"SecC"] objectForKey:key] objectForKey:@"PolicyData"] objectAtIndex:i] objectAtIndex:0];
                    cn = [[[[[obj.eAppData objectForKey:@"SecC"] objectForKey:key] objectForKey:@"PolicyData"] objectAtIndex:i] objectAtIndex:1];
                    ltsa = [[[[[obj.eAppData objectForKey:@"SecC"] objectForKey:key] objectForKey:@"PolicyData"] objectAtIndex:i] objectAtIndex:2];
                    asa = [[[[[obj.eAppData objectForKey:@"SecC"] objectForKey:key] objectForKey:@"PolicyData"] objectAtIndex:i] objectAtIndex:3];
                    cisa = [[[[[obj.eAppData objectForKey:@"SecC"] objectForKey:key] objectForKey:@"PolicyData"] objectAtIndex:i] objectAtIndex:4];
                    di = [[[[[obj.eAppData objectForKey:@"SecC"] objectForKey:key] objectForKey:@"PolicyData"] objectAtIndex:i] objectAtIndex:5];
                    
                    [db executeUpdate:@"INSERT INTO eProposal_Existing_Policy_2(eProposalNo, PTypeCodeDesc, ExistingPolicy_Company, ExistingPolicy_LifeTerm, ExistingPolicy_Accident, ExistingPolicy_CriticalIllness, ExistingPolicy_DateIssued, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], pt, cn, ltsa, asa, cisa, di, commDate, commDate, Nil];
                }
                
            }
        }
		//policy data end
	}
	//Section C End

	//Section D Start
	if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"SecD_Saved"] isEqualToString:@"Y"]) {
		NSString *query = @"";
		query = [NSString stringWithFormat:@"UPDATE eProposal SET NomineesMandatoryFlag = '%@' WHERE eProposalNo = '%@'",[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"SecD_Saved"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]];
		[db executeUpdate:query];
		
	//Nominees Start
	[db executeUpdate:@"DELETE FROM eProposal_NM_Details WHERE eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], Nil];
	
	NSLog(@"test:   %@", _NomineesVC.Nominee1Lbl.text);
	//	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Trustee1"] isEqualToString:@"1"])
	if ((![_NomineesVC.Nominee1Lbl.text isEqualToString:@"Add Nominee (1)"]))
	{
		NSLog(@"insert dn1");
		[db executeUpdate:@"INSERT INTO eProposal_NM_Details(eProposalNo, NMTitle, NMName, NMNewICNo, NMOtherIDType, NMOtherID, NMDOB, NMSex, NMShare, NMRelationship, NMSamePOAddress, NMAddress1, NMAddress2, NMAddress3, NMPostcode, NMTown, NMState, NMCountry, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_title"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_name"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_ic"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_otherIDType"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_otherID"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_dob"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_gender"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_share"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_relatioship"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_Address"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add1TF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add2TF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add3TF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_postcodeTF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_townTF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_stateTF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_countryTF"], commDate, commDate, Nil];
	}
	else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Delete1stNominee"] isEqualToString:@"1"]) {
		[db executeUpdate:@"DELETE FROM eProposal_NM_Details WHERE eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], Nil];
	}
	
	if ((![_NomineesVC.Nominee2Lbl.text isEqualToString:@"Add Nominee (2)"]))
	{
		NSLog(@"insert dn2");
		[db executeUpdate:@"INSERT INTO eProposal_NM_Details(eProposalNo, NMTitle, NMName, NMNewICNo, NMOtherIDType, NMOtherID, NMDOB, NMSex, NMShare, NMRelationship, NMSamePOAddress, NMAddress1, NMAddress2, NMAddress3, NMPostcode, NMTown, NMState, NMCountry, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_title"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_name"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_ic"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_otherIDType"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_otherID"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_dob"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_gender"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_share"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_relatioship"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_Address"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_add1TF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_add2TF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_add3TF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_postcodeTF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_townTF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_stateTF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_countryTF"], commDate, commDate, Nil];
	}
	else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Delete2ndNominee"] isEqualToString:@"1"]) {
		[db executeUpdate:@"DELETE FROM eProposal_NM_Details WHERE eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], Nil];
	}
	
	if ((![_NomineesVC.Nominee3Lbl.text isEqualToString:@"Add Nominee (3)"]))
	{
		NSLog(@"insert dn3");
		[db executeUpdate:@"INSERT INTO eProposal_NM_Details(eProposalNo, NMTitle, NMName, NMNewICNo, NMOtherIDType, NMOtherID, NMDOB, NMSex, NMShare, NMRelationship, NMSamePOAddress, NMAddress1, NMAddress2, NMAddress3, NMPostcode, NMTown, NMState, NMCountry, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_title"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_name"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_ic"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_otherIDType"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_otherID"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_dob"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_gender"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_share"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_relatioship"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_Address"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_add1TF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_add2TF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_add3TF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_postcodeTF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_townTF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_stateTF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_countryTF"], commDate, commDate, Nil];
	}
	else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Delete3rdNominee"] isEqualToString:@"1"]) {
		[db executeUpdate:@"DELETE FROM eProposal_NM_Details WHERE eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], Nil];
	}
	
	if ((![_NomineesVC.Nominee4Lbl.text isEqualToString:@"Add Nominee (4)"]))
	{
		NSLog(@"insert dn4");
		[db executeUpdate:@"INSERT INTO eProposal_NM_Details(eProposalNo, NMTitle, NMName, NMNewICNo, NMOtherIDType, NMOtherID, NMDOB, NMSex, NMShare, NMRelationship, NMSamePOAddress, NMAddress1, NMAddress2, NMAddress3, NMPostcode, NMTown, NMState, NMCountry, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_title"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_name"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_ic"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_otherIDType"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_otherID"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_dob"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_gender"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_share"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_relatioship"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_Address"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_add1TF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_add2TF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_add3TF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_postcodeTF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_townTF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_stateTF"], [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_countryTF"], commDate, commDate, Nil];
	}
	else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Delete4thNominee"] isEqualToString:@"1"]) {
		[db executeUpdate:@"DELETE FROM eProposal_NM_Details WHERE eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], Nil];
	}
	//	}
	//Nominees End
	
	//Trustees Start
    
  
	[db executeUpdate:@"DELETE FROM eProposal_Trustee_Details WHERE eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], Nil];
        
	NSLog(@"test save trustee :   %@", _NomineesVC.trusteeLbl1.text);
//	if (![[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Label1"] isEqualToString:@"Add Trustee (1)"] || ![_NomineesVC.trusteeLbl1.text isEqualToString:@"Add Trustee (1)"])
	if (![_NomineesVC.trusteeLbl1.text isEqualToString:@"Add Trustee (1)"])
	{
		[db executeUpdate:@"INSERT INTO eProposal_Trustee_Details(eProposalNo, TrusteeTitle, TrusteeName, TrusteeSex, TrusteeDOB, TrusteeNewICNo, TrusteeOtherIDType, TrusteeOtherID, TrusteeRelationship, TrusteeAddress1, TrusteeAddress2, TrusteeAddress3, TrusteePostcode, TrusteeTown, TrusteeState, TrusteeCountry, CreatedAt, UpdatedAt, TrusteeSameAsPO) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Title"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Name"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Sex"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"DOB"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"ICNo"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"OtherIDType"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"OtherID"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Relationship"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Address1"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Address2"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Address3"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Postcode"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Town"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"State"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Country"], commDate, commDate, [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"SamePO"], Nil];
        
         
	}
	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Delete1st"] isEqualToString:@"1"]) {
		NSLog(@"delete dt1");
		[db executeUpdate:@"DELETE FROM eProposal_Trustee_Details WHERE eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], Nil];
	}
	//	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Trustee2"] isEqualToString:@"1"])
	if (![_NomineesVC.trusteeLbl2.text isEqualToString:@"Add Trustee (2)"])
	{
		NSLog(@"insert dt2");
		[db executeUpdate:@"INSERT INTO eProposal_Trustee_Details(eProposalNo, TrusteeTitle, TrusteeName, TrusteeSex, TrusteeDOB, TrusteeNewICNo, TrusteeOtherIDType, TrusteeOtherID, TrusteeRelationship, TrusteeAddress1, TrusteeAddress2, TrusteeAddress3, TrusteePostcode, TrusteeTown, TrusteeState, TrusteeCountry, CreatedAt, UpdatedAt, TrusteeSameAsPO) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TTitle"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TName"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TSex"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TDOB"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TICNo"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TOtherIDType"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TOtherID"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TRelationship"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TAddress1"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TAddress2"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TAddress3"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TPostcode"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TTown"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TState"], [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TCountry"], commDate, commDate, [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TSamePO"], Nil];
	}
	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Delete2nd"] isEqualToString:@"1"]) {
		NSLog(@"delete dt2");
		[db executeUpdate:@"DELETE FROM eProposal_Trustee_Details WHERE eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], Nil];
	}
	//Trustees End
		
	}
	//Section D End
	
	//Section E Start
	if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Saved"] isEqualToString:@"Y"]) {
        NSString *query = @"";
		query = [NSString stringWithFormat:@"UPDATE eProposal SET QuestionnaireMandatoryFlag = '%@' WHERE eProposalNo = '%@'",[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Saved"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]];
		[db executeUpdate:query];
		
		[db executeUpdate:@"DELETE FROM eProposal_QuestionAns WHERE eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], Nil];
        NSArray *keys = [[NSArray alloc] initWithObjects:@"LA1HQ", @"LA2HQ",@"POHQ",nil];
        for (NSString *key in keys) {
            NSLog(@"insert healthQ");
            if ([[obj.eAppData objectForKey:@"SecE"] objectForKey:key]) {
                NSString *HW = [NSString stringWithFormat:@"%@ %@", [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_height"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_weight"]];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], HW, @"Q1001", commDate, commDate,Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q1B"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q1"], @"Q1002", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q2"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q2"], @"Q1003", commDate, commDate,  Nil];
                
                NSString *ANS3 = [NSString stringWithFormat:@"%@ %@ %@", [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q3_beerTF"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q3_wineTF"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q3_wboTF"]];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q3"], ANS3, @"Q1004", commDate, commDate,  Nil];
                
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], @"N", @"Q1005", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q5"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q5"], @"Q1006", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q6"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q6"], @"Q1007", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7A"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7"], @"Q1008", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7B"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7b"], @"Q1010", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7C"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7c"], @"Q1011", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7D"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7d"], @"Q1012", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7E"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7e"], @"Q1013", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7F"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7f"], @"Q1014", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7G"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7g"], @"Q1015", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7H"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7h"], @"Q1016", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7I"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7i"], @"Q1017", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q7J"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q7j"], @"Q1018", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q8A"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q8"], @"Q1019", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q8B"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q8b"], @"Q1021", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q8C"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q8c"], @"Q1022", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q8D"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q8d"], @"Q1023", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q8E"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q8e"], @"Q1024", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q9"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q9"], @"Q1025", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q10"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q10"], @"Q1026", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q11"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q11"], @"Q1029", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q12"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q12"], @"Q1030", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q13"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q13"], @"Q1031", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q14A"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q14"], @"Q1027", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, Reason, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_Q14B"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"Q14b"], @"Q1028", commDate, commDate,  Nil];
                [db executeUpdate:@"INSERT INTO eProposal_QuestionAns(eProposalNo, LAType, Answer, QnID, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"], [[[obj.eAppData objectForKey:@"SecE"] objectForKey:key] objectForKey:@"SecE_personType"], @"N", @"Q1032", commDate, commDate,  Nil];
            }
        }
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
        
        
		[db executeUpdate:@"INSERT INTO eProposal_Additional_Questions_1(eProposalNo, AdditionalQuestionsName, AdditionalQuestionsMonthlyIncome, AdditionalQuestionsOccupationCode, AdditionalQuestionsInsured, AdditionalQuestionsReason, CreatedAt, UpdatedAt) VALUES(?,?,?,?,?,?,?,?);",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Name"], [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Income"], [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Occupation"], [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured"], [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"No_Reason"], commDate, commDate, Nil];
	}
	//Section F End
	
	//Section G Start
	if ([[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"Declaration_agree"] length] != 0)
	{
		NSLog(@"insert declare");
//		NSLog(@"eproposal no: %@", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]);
		NSString *query = @"";
		query = [NSString stringWithFormat:@"UPDATE eProposal SET DeclarationAuthorization = '%@', DeclarationMandatoryFlag = '%@' WHERE eProposalNo = '%@'",[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"Declaration_agree"], [[obj.eAppData objectForKey:@"SecG"] objectForKey:@"SecG_Saved"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]];
		[db executeUpdate:query];
	}
	//Section G End
		
	[db commit];
    [db close];
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"0" forKey:@"NewProposal"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"0" forKey:@"Delete1st"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"0" forKey:@"Delete2nd"];
}

@end
