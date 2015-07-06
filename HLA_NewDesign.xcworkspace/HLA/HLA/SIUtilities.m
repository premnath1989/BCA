//
//  SIUtilities.m
//  iMobile Planner
//
//  Created by shawal sapuan on 5/13/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "SIUtilities.h"
#import "DataTable.h"


static sqlite3 *contactDB = nil;

@implementation SIUtilities


+(BOOL)makeDBCopy:(NSString *)path
{
    BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	
    success = [fileManager fileExistsAtPath:path];
    if (success) return YES;
    
    if (!success) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"hladb.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:path error:&error];
        if (!success) {
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
            return NO;
        }
        
        defaultDBPath = Nil;
    }
    
	fileManager = Nil;
    error = Nil;
    return YES;
}


+(BOOL)addColumnTable:(NSString *)table column:(NSString *)columnName type:(NSString *)columnType dbpath:(NSString *)path
{
    sqlite3_stmt *statement;
    if (sqlite3_open([path UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN %@ %@",table,columnName,columnType];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) != SQLITE_OK) {
            return NO;
        }
        
        sqlite3_exec(contactDB, [querySQL UTF8String], NULL, NULL, NULL);
        return YES;
        sqlite3_close(contactDB);
    }
    return YES;
}


+(BOOL)updateTable:(NSString *)table set:(NSString *)column value:(NSString *)val where:(NSString *)param equal:(NSString *)val2 dbpath:(NSString *)path
{
    sqlite3_stmt *statement;
    if (sqlite3_open([path UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"UPDATE %@ SET %@= \"%@\" WHERE %@=\"%@\"",table,column,val,param,val2];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) != SQLITE_OK) {
            return NO;
        }
        
        sqlite3_exec(contactDB, [querySQL UTF8String], NULL, NULL, NULL);
        return YES;
        sqlite3_close(contactDB);
    }
    return YES;
}


+(BOOL)createTableCFF:(NSString *)path
{
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSString *query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS CFF_CA_Recommendation (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, Seq TEXT, PTypeCode TEXT, InsuredName TEXT, PlanType TEXT, Term TEXT, Premium TEXT, Frequency TEXT, SumAssured TEXT, BoughtOption TEXT, AddNew TEXT)"];
    [database executeUpdate:query];
    
    
    NSString *query2 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS CFF_CA_Recommendation_Rider (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, Seq TEXT, RiderName TEXT);"];
    [database executeUpdate:query2];
    
    
    NSString *query3 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS CFF_Education (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, NoChild TEXT, NoExistingPlan TEXT, CurrentAmt_Child_1 TEXT, RequiredAmt_Child_1 TEXT, SurplusShortFallAmt_Child_1 TEXT, CurrentAmt_Child_2 TEXT, RequiredAmt_Child_2 TEXT, SurplusShortFallAmt_Child_2 TEXT, CurrentAmt_Child_3 TEXT, RequiredAmt_Child_3 TEXT, SurplusShortFallAmt_Child_3 TEXT, CurrentAmt_Child_4 TEXT, RequiredAmt_Child_4 TEXT, SurplusShortFallAmt_Child_4 TEXT, AllocateIncome_1 TEXT)"];
    [database executeUpdate:query3];
    
    
    NSString *query4 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS CFF_Education_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, SeqNo TEXT, Name TEXT, CompanyName TEXT, Premium TEXT, Frequency TEXT, StartDate TEXT, MaturityDate TEXT, ProjectedValueAtMaturity TEXT)"];
    [database executeUpdate:query4];
    
    
    NSString *query5 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS CFF_Family_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, AddFromCFF TEXT, CompleteFlag TEXT, SameAsPO TEXT, PTypeCode TEXT, Name TEXT, Relationship TEXT, DOB TEXT, Age TEXT, Sex TEXT, YearsToSupport TEXT)"];
    [database executeUpdate:query5];
    
    
    NSString *query6 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS CFF_Master (ID INTEGER PRIMARY KEY AUTOINCREMENT, eProposalNo TEXT, ClientProfileID TEXT,PartnerClientProfileID TEXT, IntermediaryStatus TEXT, BrokerName TEXT, ClientChoice TEXT, RiskReturnProfile TEXT, NeedsQ1_Ans1 TEXT, NeedsQ1_Ans2 TEXT, NeedsQ1_Priority TEXT, NeedsQ2_Ans1 TEXT, NeedsQ2_Ans2 TEXT, NeedsQ2_Priority TEXT, NeedsQ3_Ans1 TEXT, NeedsQ3_Ans2 TEXT, NeedsQ3_Priority TEXT, NeedsQ4_Ans1 TEXT, NeedsQ4_Ans2 TEXT, NeedsQ4_Priority TEXT, NeedsQ5_Ans1 TEXT, NeedsQ5_Ans2 TEXT, NeedsQ5_Priority TEXT, IntermediaryCode TEXT, IntermediaryName TEXT, IntermediaryNRIC TEXT, IntermediaryContractDate TEXT, IntermediaryAddress1 TEXT, IntermediaryAddress2 TEXT, IntermediaryAddress3 TEXT, IntermediaryAddress4 TEXT, IntermediaryManagerName TEXT, ClientAck TEXT, ClientComments TEXT, CreatedAt TEXT, LastUpdatedAt TEXT, Status TEXT, CFFType TEXT, SecACompleted TEXT, SecBCompleted TEXT, SecCCompleted TEXT,SecDCompleted TEXT, SecECompleted TEXT, SecFProtectionCompleted TEXT, SecFRetirementCompleted TEXT, SecFEducationCompleted TEXT, SecFSavingsCompleted TEXT, SecGCompleted TEXT, SecHCompleted TEXT, SecICompleted TEXT)"];
    [database executeUpdate:query6];
    
    
    NSString *query7 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS CFF_Personal_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, eProposalNo TEXT, AddFromCFF TEXT, CompleteFlag TEXT, PTypeCode TEXT, PYFlag TEXT, AddNewPayor TEXT, SameAsPO TEXT, Title TEXT, Name, NewICNo TEXT, OtherIDType TEXT, OtherID TEXT, Nationality TEXT, Race TEXT, Religion TEXT, Sex TEXT, Smoker TEXT, DOB TEXT, Age TEXT, MaritalStatus TEXT, OccupationCode TEXT, MailingForeignAddressFlag TEXT, MailingAddressSameAsPO TEXT, MailingAddress1 TEXT, MailingAddress2 TEXT, MailingAddress3 TEXT, MailingTown TEXT, MailingState TEXT, MailingPostCode TEXT, MailingCountry TEXT, PermanentForeignAddressFlag TEXT, PermanentAddressSameAsPO TEXT, PermanentAddress1 TEXT, PermanentAddress2 TEXT, PermanentAddress3 TEXT, PermanentTown TEXT, PermanentState TEXT, PermanentPostCode TEXT, PermanentCountry TEXT, ResidencePhoneNo TEXT, OfficePhoneNo TEXT, MobilePhoneNo TEXT, FaxPhoneNo TEXT, EmailAddress TEXT)"];
    [database executeUpdate:query7];
    
    
    NSString *query8 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS CFF_Protection (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, NoExistingPlan TEXT, AllocateIncome_1 TEXT, AllocateIncome_2 TEXT, TotalSA_CurrentAmt TEXT, TotalSA_RequiredAmt TEXT, TotalSA_SurplusShortFall TEXT, TotalCISA_CurrentAmt TEXT, TotalCISA_RequiredAmt TEXT, TotalCISA_SurplusShortFall TEXT, TotalHB_CurrentAmt TEXT, TotalHB_RequiredAmt TEXT, TotalHB_SurplusShortFall TEXT, TotalPA_CurrentAmt TEXT, TotalPA_RequiredAmt TEXT, TotalPA_SurplusShortFall TEXT)"];
    [database executeUpdate:query8];
    
    
    NSString *query9 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS CFF_RecordOfAdvice (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, SameAsQuotation TEXT, Priority TEXT, PlanType TEXT, Term TEXT, InsurerName TEXT, PTypeCode TEXT, InsuredName TEXT, SumAssured TEXT, ReasonRecommend TEXT, ActionRemark TEXT)"];
    [database executeUpdate:query9];
    
    
    NSString *query10 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS CFF_Protection_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, SeqNo TEXT, POName TEXT, CompanyName TEXT, PlanType TEXT, LifeAssuredName TEXT, Benefit1 TEXT, Benefit2 TEXT, Benefit3 TEXT, Benefit4 TEXT, Premium TEXT, Mode TEXT, MaturityDate TEXT)"];
    
    [database executeUpdate:query10];
    
    
    NSString *query11 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS CFF_RecordOfAdvice_Rider (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, Priority TEXT, RiderName TEXT, Seq TEXT)"];
    [database executeUpdate:query11];
    
    
    NSString *query12 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS CFF_Retirement (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, NoExistingPlan TEXT, AllocateIncome_1 TEXT, AllocateIncome_2 TEXT, CurrentAmt TEXT, RequiredAmt TEXT, SurplusShortFallAmt TEXT, OtherIncome_1 TEXT, OtherIncome_2 TEXT)"];
    [database executeUpdate:query12];
    
    
    NSString *query13 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS CFF_Retirement_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, SeqNo TEXT, POName TEXT, CompanyName TEXT, PlanType TEXT, Premium TEXT, Frequency TEXT, StartDate TEXT, MaturityDate TEXT, ProjectedLumSum TEXT, ProjectedAnnualIncome TEXT, AdditionalBenefits TEXT)"];
    [database executeUpdate:query13];
    
    
    NSString *query14 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS CFF_SavingsInvest (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, NoExistingPlan TEXT, CurrentAmt TEXT, RequiredAmt TEXT, SurplusShortFallAmt TEXT, AllocateIncome_1 TEXT)"];
    [database executeUpdate:query14];
    
    
    NSString *query15 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS CFF_SavingsInvest_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, SeqNo TEXT, POName TEXT, CompanyName TEXT, PlanType TEXT, Purpose TEXT, Premium TEXT, CommDate TEXT, MaturityAmt TEXT)"];
    [database executeUpdate:query15];
    
    
    NSString *query16 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS CFF_CA (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, Choice1 TEXT, Choice2 TEXT, Choice3 TEXT, Choice4 TEXT, Choice5 TEXT, Choice6 TEXT, Choices6Desc TEXT)"];
    [database executeUpdate:query16];
    
    FMResultSet *results;
    
    NSString *query17 = [NSString stringWithFormat:@"SELECT SecACompleted from CFF_master"];
    results = [database executeQuery:query17];
    if (!results){
        query17 = [NSString stringWithFormat:@"alter table CFF_Master add SecACompleted TEXT"];
        [database executeUpdate:query17];
    }
    
    NSString *query18 = [NSString stringWithFormat:@"SELECT SecBCompleted from CFF_master"];
    results = [database executeQuery:query18];
    if (!results){
        query18 = [NSString stringWithFormat:@"alter table CFF_Master add SecBCompleted TEXT"];
        [database executeUpdate:query18];
    }
    
    NSString *query19 = [NSString stringWithFormat:@"SELECT SecCCompleted from CFF_master"];
    results = [database executeQuery:query19];
    if (!results){
        query19 = [NSString stringWithFormat:@"alter table CFF_Master add SecCCompleted TEXT"];
        [database executeUpdate:query19];
    }
    
    NSString *query20 = [NSString stringWithFormat:@"SELECT SecDCompleted from CFF_master"];
    results = [database executeQuery:query20];
    if (!results){
        query20 = [NSString stringWithFormat:@"alter table CFF_Master add SecDCompleted TEXT"];
        [database executeUpdate:query20];
    }
    
    NSString *query21 = [NSString stringWithFormat:@"SELECT SecECompleted from CFF_master"];
    results = [database executeQuery:query21];
    if (!results){
        query21 = [NSString stringWithFormat:@"alter table CFF_Master add SecECompleted TEXT"];
        [database executeUpdate:query21];
    }
    
    NSString *query22 = [NSString stringWithFormat:@"SELECT SecFProtectionCompleted from CFF_master"];
    results = [database executeQuery:query22];
    if (!results){
        query22 = [NSString stringWithFormat:@"alter table CFF_Master add SecFProtectionCompleted TEXT"];
        [database executeUpdate:query22];
    }
    
    NSString *query23 = [NSString stringWithFormat:@"SELECT SecFRetirementCompleted from CFF_master"];
    results = [database executeQuery:query23];
    if (!results){
        query23 = [NSString stringWithFormat:@"alter table CFF_Master add SecFRetirementCompleted TEXT"];
        [database executeUpdate:query23];
    }
    
    NSString *query24 = [NSString stringWithFormat:@"SELECT SecFEducationCompleted from CFF_master"];
    results = [database executeQuery:query24];
    if (!results){
        query24 = [NSString stringWithFormat:@"alter table CFF_Master add SecFEducationCompleted TEXT"];
        [database executeUpdate:query24];
    }
    
    NSString *query25 = [NSString stringWithFormat:@"SELECT SecFSavingsCompleted from CFF_master"];
    results = [database executeQuery:query25];
    if (!results){
        query25 = [NSString stringWithFormat:@"alter table CFF_Master add SecFSavingsCompleted TEXT"];
        [database executeUpdate:query25];
    }
    
    NSString *query26 = [NSString stringWithFormat:@"SELECT SecGCompleted from CFF_master"];
    results = [database executeQuery:query26];
    if (!results){
        query26 = [NSString stringWithFormat:@"alter table CFF_Master add SecGCompleted TEXT"];
        [database executeUpdate:query26];
    }
    
    NSString *query27 = [NSString stringWithFormat:@"SELECT SecHCompleted from CFF_master"];
    results = [database executeQuery:query27];
    if (!results){
        query27 = [NSString stringWithFormat:@"alter table CFF_Master add SecHCompleted TEXT"];
        [database executeUpdate:query27];
    }
    
    NSString *query28 = [NSString stringWithFormat:@"SELECT SecICompleted from CFF_master"];
    results = [database executeQuery:query28];
    if (!results){
        query28 = [NSString stringWithFormat:@"ALTER TABLE CFF_Master ADD COLUMN SecICompleted TEXT"];
        [database executeUpdate:query28];
    }
    
    [database close];
    return YES;
}

+(BOOL)createTableeApp:(NSString *)path {
	FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	
	NSString *query1 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_Contact (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, ContactCode TEXT, ContactDesc TEXT, Status TEXT)"];
	[database executeUpdate:query1];
	
	NSString *query2 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_ErrorListing (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, ID TEXT, RefNo TEXT, ErrorCode TEXT, ErrorDescription TEXT, ErrorCreatedAt TEXT, CreatedAt TEXT)"];
	[database executeUpdate:query2];
	
	NSString *query3 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_Existing_Policy_1 (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, eProposalNo TEXT, ExistingPolicy_Answer1 TEXT, ExistingPolicy_Answer2 TEXT, ExistingPolicy_Answer3 TEXT, ExistingPolicy_Answer4 TEXT, ExistingPolicy_Answer5 TEXT, Withdraw_CashDividend TEXT, Withdraw_GuaranteedCash TEXT, CompanyKeep_CashDividend TEXT, CompanyKeep_GuaranteedCash TEXT, blnBackDating TEXT, BackDating TEXT, CreatedAt TEXT, UpdatedAt TEXT ProposalPTypeCode TEXT, CashPayment_PO TEXT, CashPayment_Acc TEXT)"];
	[database executeUpdate:query3];
	
	NSString *query4 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_Existing_Policy_2 (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, RecID TEXT, eProposalNo TEXT, PTypeCode TEXT, PTypeCodeDesc TEXT, ExistingPolicy_Company TEXT, ExistingPolicy_LifeTerm TEXT, ExistingPolicy_Accident TEXT, ExistingPolicy_CriticalIllness TEXT, ExistingPolicy_DateIssued TEXT, CreatedAt TEXT, UpdatedAt TEXT)"];
	[database executeUpdate:query4];
	
	NSString *query5 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_LA_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, eProposalNo TEXT, PTypeCode TEXT, LATitle TEXT, LAName TEXT, LASex TEXT, LADOB TEXT, LANewICNo TEXT, LAOtherIDType TEXT, LAOtherID TEXT, LAMaritalStatus TEXT, LARace TEXT, LAReligion TEXT, LANationality TEXT, LAOccupationCode TEXT, LAExactDuties TEXT, LATypeOfBusiness TEXT, LAEmployerName TEXT, LAYearlyIncome TEXT, LARelationship TEXT, POFlag TEXT, CorrespondenceAddress TEXT, ResidenceOwnRented TEXT,ResidenceAddress1 TEXT, ResidenceAddress2 TEXT, ResidenceAddress3 TEXT, ResidenceTown TEXT, ResidenceState TEXT, ResidencePostcode TEXT, ResidenceCountry TEXT, OfficeAddress1 TEXT, OfficeAddress2 TEXT, OfficeAddress3 TEXT, OfficeTown TEXT,OfficeState TEXT, OfficePostcode TEXT, OfficeCountry TEXT, ResidencePhoneNo TEXT, OfficePhoneNo TEXT, FaxPhoneNo TEXT, MobilePhoneNo TEXT, EmailAddress TEXT, PentalHealthStatus TEXT, PentalFemaleStatus TEXT, PentalDeclarationStatus TEXT,LACompleteFlag TEXT, AddPO TEXT, LASmoker TEXT, ResidenceForeignAddressFlag TEXT, OfficeForeignAddressFlag TEXT, CreatedAt TEXT, UpdatedAt TEXT, POType TEXT"];
	[database executeUpdate:query5];
	
	NSString *query6 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_NM_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, eProposalNo TEXT, NMTitle TEXT, NMName TEXT, NMShare TEXT, NMNewICNo TEXT, NMOtherIDType TEXT, NMOtherID TEXT, NMSex TEXT, NMDOB TEXT, NMRelationship TEXT, NMSamePOAddress TEXT, NMAddress1 TEXT, NMAddress2 TEXT, NMAddress3 TEXT, NMTown TEXT, NMState TEXT, NMPostcode TEXT, NMCountry TEXT, CreatedAt TEXT, UpdatedAt TEXT)"];
	[database executeUpdate:query6];
	
	NSString *query7 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_QuestionAns (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, eProposalNo TEXT, LAType TEXT, QnID TEXT, QnParty TEXT, AnswerType TEXT, Answer TEXT, Reason TEXT, CreatedAt TEXT, UpdatedAt TEXT)"];
	[database executeUpdate:query7];
	
	NSString *query8 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_Rider (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, Id TEXT, eProposalNo TEXT, PTypeCode TEXT, RiderCode TEXT, RiderTerm TEXT, RiderSA TEXT, RiderModalPremium TEXT, CreatedAt TEXT, UpdatedAt Text)"];
	[database executeUpdate:query8];
	
	NSString *query9 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_Trustee_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, eProposalNo TEXT, TrusteeTitle TEXT, TrusteeName TEXT, TrusteeSex TEXT, TrusteeNewICNo TEXT, TrusteeDOB TEXT,TrusteeOtherIDType TEXT, TrusteeOtherID TEXT, TrusteeRelationship TEXT, TrusteeAddress1 TEXT, TrusteeAddress2 TEXT, TrusteeAddress3 TEXT, TrusteePostcode TEXT, TrusteeState TEXT,TrusteeTown TEXT, TrusteeCountry TEXT, CreatedAt TEXT, UpdatedAt TEXT, TrusteeSameAsPO TEXT)"];
	[database executeUpdate:query9];
	
	NSString *query10 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, eProposalNo TEXT, SINo TEXT, PolicyNo TEXT,Status TEXT, ClientChoice TEXT, DeclarationAuthorization TEXT,GuardianName TEXT, GuardianNewICNo TEXT, COTitle TEXT,COName TEXT, COSex TEXT, CONewICNo TEXT,COOtherIDType TEXT, COOtherID TEXT, CODOB TEXT,CORelationship TEXT, COOtherRelationship TEXT, COSameAddressPO TEXT,COAddress1 TEXT, COAddress2 TEXT, COAddress3 TEXT,COTown TEXT, COState TEXT, COOtherState TEXT,COPostcode TEXT, COCountry TEXT, COOtherCountry TEXT,COPhoneNo TEXT, COMobileNo TEXT, COEmailAddress TEXT,FirstTimePayment TEXT, PaymentUponFinalAcceptance TEXT, RecurringPayment TEXT,FullyPaidUpOption TEXT, FullyPaidUpTerm TEXT, RevisedSA TEXT,AmtRevised TEXT, PaymentMode TEXT, CreditCardBank TEXT,CreditCardType TEXT, CardMemberAccountNo TEXT, CardExpiredDate TEXT,PTypeCode TEXT, CardMemberName TEXT, CardMemberSex TEXT,CardMemberDOB TEXT, CardMemberNewICNo TEXT, CardMemberOtherIDType TEXT,CardMemberOtherID TEXT, CardMemberContactNo TEXT, CardMemberRelationship TEXT,BasicPlanCode TEXT, BasicPlanTerm TEXT, BasicPlanSA TEXT,BasicPlanModalPremium TEXT, TotalModalPremium TEXT, SecondAgentCode TEXT,SecondAgentName TEXT, SecondAgentContactNo TEXT, COMandatoryFlag TEXT,PolicyDetailsMandatoryFlag TEXT, QuestionnaireMandatoryFlag TEXT, NomineesMandatoryFlag TEXT,LAMandatoryFlag TEXT, AdditionalQuestionsMandatoryFlag TEXT, DeclarationMandatoryFlag TEXT,SynchFlag TEXT, SIType TEXT, SIRemarks TEXT,SIVersion TEXT, eAppVersion TEXT, AgentCode TEXT,PDSFlag TEXT, StatusRemarks TEXT, CreatedBy TEXT,CreatedAt TEXT, UpdatedAt TEXT, SynchAt TEXT,IsResubmit TEXT)"];
	[database executeUpdate:query10];
	
	NSString *query11 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_Additional_Questions_1 (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, eProposalNo TEXT, AdditionalQuestionsName TEXT, AdditionalQuestionsMonthlyIncome TEXT,AdditionalQuestionsOccupationCode TEXT, AdditionalQuestionsInsured TEXT, AdditionalQuestionsReason TEXT, CreatedAt TEXT, UpdatedAt TEXT)"];
	[database executeUpdate:query11];

	NSString *query12 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_Additional_Questions_2 (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, RecID TEXT, eProposalNo TEXT, AdditionalQuestionsCompany TEXT,AdditionalQuestionsAmountInsured TEXT, AdditionalQuestionsLifeAccidentDisease TEXT, AdditionalQuestionsYrIssued TEXT, CreatedAt TEXT, UpdatedAt TEXT)"];
	[database executeUpdate:query12];
	
	NSString *query13 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_Address_Type (ID INTEGER PRIMARY KEY AUTOINCREMENT, EAPPID TEXT, AddressCode TEXT, AddressDesc TEXT, Status TEXT)"];
	[database executeUpdate:query13];
	
	NSString *query14 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eApp_Listing (ID INTEGER PRIMARY KEY AUTOINCREMENT, ClientProfileID TEXT, POName TEXT, IDNumber TEXT, ProposalNo TEXT, DateCreated TEXT, DateUpdated TEXT, Status TEXT)"];
	[database executeUpdate:query14];
    
    // from query15 until query30 is newly added by Benjamin on 28/10/2013
    NSString *query15 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_CFF_CA (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, Choice1 TEXT, Choice2 TEXT, Choice3 TEXT, Choice4 TEXT, Choice5 TEXT, Choice6 TEXT, Choices6Desc TEXT, EAPPID TEXT)"];
    [database executeUpdate:query15];
    
    NSString *query16 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_CFF_CA_Recommendation (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, Seq TEXT, PTypeCode TEXT, InsuredName TEXT, PlanType TEXT, Term TEXT, Premium TEXT, Frequency TEXT, SumAssured TEXT, BoughtOption TEXT, AddNew TEXT, EAPPID TEXT)"];
    [database executeUpdate:query16];
    
    NSString *query17 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_CFF_CA_Recommendation_Rider (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, Seq TEXT, RiderName TEXT, EAPPID TEXT)"];
    [database executeUpdate:query17];
    
    NSString *query18 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_CFF_Education (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, NoChild TEXT, NoExistingPlan TEXT, CurrentAmt_Child_1 TEXT, RequiredAmt_Child_1 TEXT, SurplusShortFallAmt_Child_1 TEXT, CurrentAmt_Child_2 TEXT, RequiredAmt_Child_2 TEXT, SurplusShortFallAmt_Child_2 TEXT, CurrentAmt_Child_3 TEXT, RequiredAmt_Child_3 TEXT, SurplusShortFallAmt_Child_3 TEXT, CurrentAmt_Child_4 TEXT, RequiredAmt_Child_4 TEXT, SurplusShortFallAmt_Child_4 TEXT, AllocateIncome_1 TEXT, EAPPID TEXT)"];
    [database executeUpdate:query18];
    
    NSString *query19 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_CFF_Education_Details (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, SeqNo TEXT, Name TEXT, CompanyName TEXT, Premium TEXT, Frequency TEXT, StartDate TEXT, MaturityDate TEXT, ProjectedValueAtMaturity TEXT, EAPPID TEXT)"];
    [database executeUpdate:query19];
    
    NSString *query20 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_CFF_Family_Details (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, AddFromCFF TEXT, CompleteFlag TEXT, SameAsPO TEXT, PTypeCode TEXT, Name TEXT, Relationship TEXT, DOB TEXT, Age TEXT, Sex TEXT, YearsToSupport TEXT, RelationshipIndexNo TEXT, EAPPID TEXT)"];
    [database executeUpdate:query20];
    
    NSString *query21 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_CFF_Master (SecICompleted , SecHCompleted , SecGCompleted , SecFSavingsCompleted , SecFEducationCompleted , SecFRetirementCompleted , SecFProtectionCompleted , SecECompleted , SecDCompleted , SecCCompleted , SecBCompleted , SecACompleted , PartnerClientProfileID , ID INTEGER, eProposalNo TEXT, EAPPID, TEXT, ClientProfileID TEXT, IntermediaryStatus TEXT, BrokerName TEXT, ClientChoice TEXT, RiskReturnProfile TEXT, NeedsQ1_Ans1 TEXT, NeedsQ1_Ans2 TEXT, NeedsQ1_Priority TEXT, NeedsQ2_Ans1 TEXT, NeedsQ2_Ans2 TEXT, NeedsQ2_Priority TEXT, NeedsQ3_Ans1 TEXT, NeedsQ3_Ans2 TEXT, NeedsQ3_Priority TEXT, NeedsQ4_Ans1 TEXT, NeedsQ4_Ans2 TEXT, NeedsQ4_Priority TEXT, NeedsQ5_Ans1 TEXT, NeedsQ5_Ans2 TEXT, NeedsQ5_Priority TEXT, IntermediaryCode TEXT, IntermediaryName TEXT, IntermediaryNRIC TEXT, IntermediaryContractDate TEXT, IntermediaryAddress1 TEXT, IntermediaryAddress2 TEXT, IntermediaryAddress3 TEXT, IntermediaryAddress4 TEXT, IntermediaryManagerName TEXT, ClientAck TEXT, ClientComments TEXT, CreatedAt TEXT, LastUpdatedAt TEXT, Status TEXT, CFFType TEXT)"];
    [database executeUpdate:query21];
    
    NSString *query22 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_CFF_Personal_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, eProposalNo TEXT, AddFromCFF TEXT, CompleteFlag TEXT, PTypeCode TEXT, PYFlag TEXT, AddNewPayor TEXT, SameAsPO TEXT, Title TEXT, Name, NewICNo TEXT, OtherIDType TEXT, OtherID TEXT, Nationality TEXT, Race TEXT, Religion TEXT, Sex TEXT, Smoker TEXT, DOB TEXT, Age TEXT, MaritalStatus TEXT, OccupationCode TEXT, MailingForeignAddressFlag TEXT, MailingAddressSameAsPO TEXT, MailingAddress1 TEXT, MailingAddress2 TEXT, MailingAddress3 TEXT, MailingTown TEXT, MailingState TEXT, MailingPostCode TEXT, MailingCountry TEXT, PermanentForeignAddressFlag TEXT, PermanentAddressSameAsPO TEXT, PermanentAddress1 TEXT, PermanentAddress2 TEXT, PermanentAddress3 TEXT, PermanentTown TEXT, PermanentState TEXT, PermanentPostCode TEXT, PermanentCountry TEXT, ResidencePhoneNo TEXT, OfficePhoneNo TEXT, MobilePhoneNo TEXT, FaxPhoneNo TEXT, EmailAddress TEXT, EAPPID TEXT)"];
    [database executeUpdate:query22];
    
    NSString *query23 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_CFF_Protection (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, NoExistingPlan TEXT, AllocateIncome_1 TEXT, AllocateIncome_2 TEXT, TotalSA_CurrentAmt TEXT, TotalSA_RequiredAmt TEXT, TotalSA_SurplusShortFall TEXT, TotalCISA_CurrentAmt TEXT, TotalCISA_RequiredAmt TEXT, TotalCISA_SurplusShortFall TEXT, TotalHB_CurrentAmt TEXT, TotalHB_RequiredAmt TEXT, TotalHB_SurplusShortFall TEXT, TotalPA_CurrentAmt TEXT, TotalPA_RequiredAmt TEXT, TotalPA_SurplusShortFall TEXT, EAPPID TEXT)"];
    [database executeUpdate:query23];
    
    NSString *query24 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_CFF_Protection_Details (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, SeqNo TEXT, POName TEXT, CompanyName TEXT, PlanType TEXT, LifeAssuredName TEXT, Benefit1 TEXT, Benefit2 TEXT, Benefit3 TEXT, Benefit4 TEXT, Premium TEXT, Mode TEXT, MaturityDate TEXT, EAPPID TEXT)"];
    [database executeUpdate:query24];
    
    NSString *query25 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_CFF_RecordOfAdvice (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, SameAsQuotation TEXT, Priority TEXT, PlanType TEXT, Term TEXT, InsurerName TEXT, PTypeCode TEXT, InsuredName TEXT, SumAssured TEXT, ReasonRecommend TEXT, ActionRemark TEXT, EAPPID TEXT)"];
    [database executeUpdate:query25];
    
    NSString *query26 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_CFF_RecordOfAdvice_Rider (ID INTEGER PRIMARY KEY AUTOINCREMENT, CFFID TEXT, eProposalNo TEXT, Priority TEXT, RiderName TEXT, Seq TEXT, EAPPID TEXT)"];
    [database executeUpdate:query26];
    
    NSString *query27 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_CFF_Retirement (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, NoExistingPlan TEXT, AllocateIncome_1 TEXT, AllocateIncome_2 TEXT, CurrentAmt TEXT, RequiredAmt TEXT, SurplusShortFallAmt TEXT, OtherIncome_1 TEXT, OtherIncome_2 TEXT, EAPPID TEXT)"];
    [database executeUpdate:query27];
    
    NSString *query28 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_CFF_Retirement_Details (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, SeqNo TEXT, POName TEXT, CompanyName TEXT, PlanType TEXT, Premium TEXT, Frequency TEXT, StartDate TEXT, MaturityDate TEXT, ProjectedLumSum TEXT, ProjectedAnnualIncome TEXT, AdditionalBenefits TEXT, EAPPID TEXT)"];
    [database executeUpdate:query28];
    
    NSString *query29 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_CFF_SavingsInvest (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, NoExistingPlan TEXT, CurrentAmt TEXT, RequiredAmt TEXT, SurplusShortFallAmt TEXT, AllocateIncome_1 TEXT, EAPPID TEXT)"];
    [database executeUpdate:query29];
    
    NSString *query30 = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS eProposal_CFF_SavingsInvest_Details (CFFID , ID INTEGER PRIMARY KEY, eProposalNo TEXT, SeqNo TEXT, POName TEXT, CompanyName TEXT, PlanType TEXT, Purpose TEXT, Premium TEXT, CommDate TEXT, MaturityAmt TEXT, EAPPID TEXT)"];
    [database executeUpdate:query30];
    
    
    //
    NSString *query31 = [NSString stringWithFormat:@"SELECT TrusteeSameAsPO from eProposal_Trustee_Details"];
   FMResultSet *results = [database executeQuery:query31];
    if (!results){
        query31 = [NSString stringWithFormat:@"alter table eProposal_Trustee_Details add TrusteeSameAsPO TEXT"];
        [database executeUpdate:query31];
    }
    
    NSString *query32 = [NSString stringWithFormat:@"SELECT LASmoker from eProposal_LA_Details"];
    results = [database executeQuery:query32];
    if (!results){
        query31 = [NSString stringWithFormat:@"alter table eProposal_LA_Details add LASmoker TEXT"];
        [database executeUpdate:query31];
    }

    
    NSString *query33 = [NSString stringWithFormat:@"SELECT ResidenceForeignAddressFlag from eProposal_LA_Details"];
    results = [database executeQuery:query33];
    if (!results){
        query31 = [NSString stringWithFormat:@"alter table eProposal_LA_Details add ResidenceForeignAddressFlag TEXT"];
        [database executeUpdate:query31];
    }
    
    
    NSString *query34 = [NSString stringWithFormat:@"SELECT OfficeForeignAddressFlag from eProposal_LA_Details"];
    results = [database executeQuery:query34];
    if (!results){
        query31 = [NSString stringWithFormat:@"alter table eProposal_LA_Details add OfficeForeignAddressFlag TEXT"];
        [database executeUpdate:query31];
    }
    
    
	[database close];
    return YES;
}

+(BOOL)UPDATETrad_Sys_Medical_Comb:(NSString *)path
{
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSString *query = [NSString stringWithFormat:@"UPDATE Trad_Sys_Medical_Comb SET \"LIMIT\" = '400' where OccpCode like '%%UNEMP%%'"];
    [database executeUpdate:query];

    [database close];
    return YES;
}

+(BOOL)InstallUpdate:(NSString *)path
{
	NSString * AppsVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];

	sqlite3_stmt *statement;
    NSString *QuerySQL;
	NSString *CurrenVersion = @"";
	
	if (sqlite3_open([path UTF8String], &contactDB) == SQLITE_OK){
		
		QuerySQL = [ NSString stringWithFormat:@"select SIVersion FROM Trad_Sys_SI_version_Details"];
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_ROW) {
				CurrenVersion = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
	
	//[self InstallVersion1dot3:path];
	if (![AppsVersion isEqualToString:CurrenVersion]) {
		
		[self InstallVersion1dot3:path];
		if (sqlite3_open([path UTF8String], &contactDB) == SQLITE_OK){
			
			QuerySQL = [ NSString stringWithFormat:@"Update Trad_Sys_SI_version_Details set SIVersion = '%@'", AppsVersion];
			if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
				if (sqlite3_step(statement) == SQLITE_DONE) {
					
				}
				sqlite3_finalize(statement);
			}
			sqlite3_close(contactDB);
		}
		
	}
	
    return YES;
}

+(void)ClearAllDBData :(NSString *)path{
	FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	
	NSString *query;
	/*
	 query = [NSString stringWithFormat:@"Drop table UL_Details"];
	 [database executeUpdate:query];
	 
	 query = [NSString stringWithFormat:@"Drop table UL_Fund_Maturity_option"];
	 [database executeUpdate:query];
	 */
	query = [NSString stringWithFormat:@"Delete from UL_Rider_Mtn"];
	[database executeUpdate:query];
	query = [NSString stringWithFormat:@"Delete from UL_Rider_Profile"];
	[database executeUpdate:query];
	query = [NSString stringWithFormat:@"Delete from UL_Rider_Label"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"Delete from Trad_sys_profile where plancode = 'UV' "];
	[database executeUpdate:query];
	
	[database close];
	
}

+(void)InstallVersion1dot3:(NSString *)path{
	
	[self ClearAllDBData:path]; //to avoid duplicate records
	
	FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	
	NSString *query;
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'UL_Temp_Pages' ('htmlName' TEXT,'PageNum' NUMERIC,'PageDesc' TEXT,'riders' VARCHAR)"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'UL_Temp_Rider' ('SINo' VARCHAR, 'RiderCode' VARCHAR, 'DataType2' VARCHAR, "
			 "'PolTerm' INTEGER, 'TotPremPaid' DOUBLE, 'SurrenderValueHigh' INTEGER, 'SurrenderValueLow' INTEGER)"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'UL_Temp_Trad_Basic' ('SINo' VARCHAR, 'SeqNo' INTEGER, 'DataType' VARCHAR, 'col0_1' INTEGER, "
			 "'col0_2' INTEGER, 'col1' VARCHAR, 'col2' VARCHAR, 'col3' VARCHAR, 'col4' VARCHAR, 'col5' VARCHAR, 'col6' "
			 "VARCHAR, 'col7' VARCHAR, 'col8' VARCHAR, 'col9' VARCHAR, 'col10' VARCHAR, 'col11' VARCHAR, 'col12' VARCHAR, "
			 "'col13' VARCHAR, 'col14' VARCHAR, 'col15' VARCHAR, 'col16' VARCHAR, 'col17' VARCHAR, 'col18' VARCHAR, 'col19' VARCHAR, "
			 "'col20' VARCHAR, 'col21' VARCHAR, 'col22' VARCHAR, 'col23' VARCHAR, 'col24' VARCHAR, 'col25' VARCHAR, 'col26' VARCHAR, 'col27' VARCHAR, "
			 "'col28' VARCHAR, 'col29' VARCHAR, 'col30' VARCHAR, 'col31' VARCHAR)"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'UL_Temp_Summary' ('SINo' VARCHAR, 'SeqNo' INTEGER, 'DataType' VARCHAR, 'col0_1' INTEGER, "
			 "'col0_2' INTEGER, 'col1' VARCHAR, 'col2' VARCHAR, 'col3' VARCHAR, 'col4' VARCHAR, 'col5' VARCHAR, 'col6' "
			 "VARCHAR, 'col7' VARCHAR, 'col8' VARCHAR, 'col9' VARCHAR, 'col10' VARCHAR, 'col11' VARCHAR, 'col12' VARCHAR, "
			 "'col13' VARCHAR, 'col14' VARCHAR, 'col15' VARCHAR, 'col16' VARCHAR, 'col17' VARCHAR, 'col18' VARCHAR, 'col19' VARCHAR, "
			 "'col20' VARCHAR, 'col21' VARCHAR, 'col22' VARCHAR, 'col23' VARCHAR, 'col24' VARCHAR, 'col25' VARCHAR, 'col26' VARCHAR, 'col27' VARCHAR, "
			 "'col28' VARCHAR, 'col29' VARCHAR, 'col30' VARCHAR, 'col31' VARCHAR)"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'UL_Temp_Fund' ('SINo' VARCHAR, "
			 "'col1' VARCHAR, 'col2' VARCHAR, 'col3' VARCHAR, 'col4' VARCHAR, 'col5' VARCHAR, 'col6' "
			 "VARCHAR, 'col7' VARCHAR, 'col8' VARCHAR, 'col9' VARCHAR, 'col10' VARCHAR)"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'UL_Temp_Trad_Details' ('SINo' VARCHAR, 'SeqNo' VARCHAR, 'DataType' VARCHAR, 'col0_1' VARCHAR, "
			 "'col0_2' VARCHAR, 'col1' VARCHAR, 'col2' VARCHAR, 'col3' VARCHAR, 'col4' VARCHAR, 'col5' VARCHAR, 'col6' VARCHAR, "
			 "'col7' VARCHAR, 'col8' VARCHAR, 'col9' VARCHAR, 'col10' VARCHAR, 'col11' VARCHAR)"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'UL_Temp_Trad_Overall' ('SINo' VARCHAR,'SurrenderValueHigh1' VARCHAR,'SurrenderValueLow1' VARCHAR, "
			 "'TotPremPaid1' VARCHAR,'TotYearlyIncome1' VARCHAR,'SurrenderValueHigh2' VARCHAR,'SurrenderValueLow2' VARCHAR, "
			 "'TotPremPaid2' VARCHAR,'TotYearlyIncome2' VARCHAR)"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'UL_Temp_Trad_Rider' ('SINo' VARCHAR,'SeqNo' VARCHAR,'DataType' VARCHAR,'PageNo' VARCHAR,'col0_1' "
			 "VARCHAR,'col0_2' VARCHAR,'col1' VARCHAR,'col2' VARCHAR,'col3' VARCHAR,'col4' VARCHAR,'col5' VARCHAR,'col6' VARCHAR,'col7' "
			 "VARCHAR,'col8' VARCHAR,'col9' VARCHAR,'col10' VARCHAR,'col11' VARCHAR,'col12' VARCHAR,'col13' VARCHAR,'col14' VARCHAR)"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'UL_Temp_trad_LA' ('SINo' VARCHAR, 'LADesc' VARCHAR, 'PTypeCode' VARCHAR, 'Seq' VARCHAR, 'Name' VARCHAR, "
			 "'Age' VARCHAR, 'Sex' VARCHAR, 'Smoker' VARCHAR, 'LADescM' VARCHAR)"];
	[database executeUpdate:query];

	query = [NSString stringWithFormat:@"CREATE TABLE 'UL_Temp_RPUO' ('SINo' VARCHAR, \"SeqNo\" INTEGER, \"col1\" VARCHAR, "
			 "\"col2\" VARCHAR, \"col3\" VARCHAR, \"col4\" VARCHAR, \"col5\" VARCHAR, \"col6\" VARCHAR, \"col7\" VARCHAR, \"col8\" VARCHAR, \"col9\" VARCHAR, \"col10\" VARCHAR, "
			 "\"col11\" VARCHAR, \"col12\" VARCHAR, \"col13\" VARCHAR, \"col14\" VARCHAR, \"col15\" VARCHAR, \"col16\" VARCHAR, \"col17\" VARCHAR, \"col18\" VARCHAR, \"col19\" VARCHAR, "
			 "\"col20\" VARCHAR, \"col21\" VARCHAR, \"col22\" VARCHAR )"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE 'UL_Temp_ECAR' ('SINo' VARCHAR, \"SeqNo\" INTEGER, \"DataType\" VARCHAR, \"col0_1\" INTEGER, \"col0_2\" INTEGER, \"col1\" VARCHAR, "
			 "\"col2\" VARCHAR, \"col3\" VARCHAR, \"col4\" VARCHAR, \"col5\" VARCHAR, \"col6\" VARCHAR, \"col7\" VARCHAR, \"col8\" VARCHAR, \"col9\" VARCHAR, \"col10\" VARCHAR, "
			 "\"col11\" VARCHAR, \"col12\" VARCHAR, \"col13\" VARCHAR, \"col14\" VARCHAR, \"col15\" VARCHAR, \"col16\" VARCHAR, \"col17\" VARCHAR, \"col18\" VARCHAR, \"col19\" VARCHAR, "
			 "\"col20\" VARCHAR, \"col21\" VARCHAR, \"col22\" VARCHAR )"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE 'UL_Temp_ECAR6' ('SINo' VARCHAR, \"SeqNo\" INTEGER, \"DataType\" VARCHAR, \"col0_1\" INTEGER, \"col0_2\" INTEGER, \"col1\" VARCHAR, "
			 "\"col2\" VARCHAR, \"col3\" VARCHAR, \"col4\" VARCHAR, \"col5\" VARCHAR, \"col6\" VARCHAR, \"col7\" VARCHAR, \"col8\" VARCHAR, \"col9\" VARCHAR, \"col10\" VARCHAR, "
			 "\"col11\" VARCHAR, \"col12\" VARCHAR, \"col13\" VARCHAR, \"col14\" VARCHAR, \"col15\" VARCHAR, \"col16\" VARCHAR, \"col17\" VARCHAR, \"col18\" VARCHAR, \"col19\" VARCHAR, "
			 "\"col20\" VARCHAR, \"col21\" VARCHAR, \"col22\" VARCHAR )"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE 'UL_Temp_ECAR55' ('SINo' VARCHAR, \"SeqNo\" INTEGER, \"DataType\" VARCHAR, \"col0_1\" INTEGER, \"col0_2\" INTEGER, \"col1\" VARCHAR, "
			 "\"col2\" VARCHAR, \"col3\" VARCHAR, \"col4\" VARCHAR, \"col5\" VARCHAR, \"col6\" VARCHAR, \"col7\" VARCHAR, \"col8\" VARCHAR, \"col9\" VARCHAR, \"col10\" VARCHAR, "
			 "\"col11\" VARCHAR, \"col12\" VARCHAR, \"col13\" VARCHAR, \"col14\" VARCHAR, \"col15\" VARCHAR, \"col16\" VARCHAR, \"col17\" VARCHAR, \"col18\" VARCHAR, \"col19\" VARCHAR, "
			 "\"col20\" VARCHAR, \"col21\" VARCHAR, \"col22\" VARCHAR )"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_Details (\"SINO\" VARCHAR, \"PlanCode\" VARCHAR, \"CovTypeCode\" INTEGER, \"ATPrem\" "
			 "DOUBLE, \"BasicSA\" DOUBLE, \"CovPeriod\" INTEGER, \"OccpCode\" VARCHAR, \"OccLoading\" DOUBLE, \"CPA\" INTEGER, "
			 "\"PA\" INTEGER, \"HLoading\" DOUBLE, \"HloadingTerm\" INTEGER, \"HloadingPct\" VARCHAR, \"HloadingPctTerm\" VARCHAR "
			 ", \"MedicalReq\" VARCHAR, \"ComDate\" VARCHAR, \"HLGES\" VARCHAR, \"ATU\" VARCHAR, \"BUMPMode\" VARCHAR "
			 ", \"InvCode\" VARCHAR, \"InvHorizon\" VARCHAR, \"RiderRTU\" VARCHAR, \"RiderRTUTerm\" VARCHAR, \"PolicySustainYear\" VARCHAR"
			 ", \"Package\" VARCHAR, \"TotATPrem\" VARCHAR, \"TotUpPrem\" VARCHAR, \"VU2023\" VARCHAR, \"VU2023To\" VARCHAR"
			 ", \"VU2025\" VARCHAR, \"VU2025To\" VARCHAR, \"VU2028\" VARCHAR, \"VU2028To\" VARCHAR, \"VU2030\" VARCHAR"
			 ", \"VU2030To\" VARCHAR, \"VU2035\" VARCHAR, \"VU2035To\" VARCHAR, \"VUCash\" VARCHAR, \"VUCashTo\" VARCHAR"
			 ", \"ReinvestYI\" VARCHAR, \"FullyPaidUp6Year\" VARCHAR, \"FullyPaidUp10Year\" VARCHAR, \"ReduceBSA\" VARCHAR"
			 ", \"SpecialVersion\" VARCHAR, \"VURet\" VARCHAR, \"VURetTo\" VARCHAR, \"VURetOpt\" VARCHAR, \"VURetToOpt\" VARCHAR"
			 ", \"VUDana\" VARCHAR, \"VUDanaTo\" VARCHAR, \"VUDanaOpt\" VARCHAR, \"VUDanaToOpt\" VARCHAR "
			 ", \"VUCashOpt\" VARCHAR, \"VUCashToOpt\" VARCHAR, \"SIVersion\" VARCHAR, \"SIStatus\" VARCHAR, \"QuotationLang\" VARCHAR,  \"DateCreated\" DATETIME, "
			 "\"CreatedBy\" VARCHAR, \"DateModified\" DATETIME, \"ModifiedBy\" VARCHAR)"];
	
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_LAPayor (\"SINO\" VARCHAR, \"CustCode\"	VARCHAR, \"PTypeCode\" "
			 "VARCHAR, \"Seq\" INTEGER, \"DateCreated\" DATETIME, \"CreatedBy\" VARCHAR, \"DateModified\" DATETIME, \"ModifiedBy\" VARCHAR) "];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_ReducedPaidUp (\"SINO\" VARCHAR, \"ReducedYear\" INTEGER, \"Amount\" "
			 "DOUBLE) "];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_RegTopUp (\"SINO\" VARCHAR, \"FromYear\" VARCHAR, \"ToYear\" "
			 "VARCHAR, \"Amount\" DOUBLE)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_Rider_Details (\"SINO\" VARCHAR, \"RiderCode\" VARCHAR, \"PTypeCode\" "
			 "VARCHAR, \"Seq\" INTEGER, \"RiderTerm\" INTEGER, \"SumAssured\" DOUBLE, \"Units\" INTEGER, \"PlanOption\" VARCHAR, "
			 "\"HLoading\" DOUBLE, \"HLoadingTerm\" INTEGER, \"HLoadingPCt\" INTEGER, \"HLoadingPCtTerm\" INTEGER, \"Premium\" DOUBLE, "
			 "\"Deductible\" VARCHAR, \"PaymentTerm\" INTEGER, \"ReinvestGYI\" VARCHAR, \"GYIYear\" INTEGER, \"RRTUOFromYear\" INTEGER, "
			 "\"RRTUOYear\" INTEGER, \"RiderDesc\" VARCHAR) "];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_TopupPrem (\"SINO\" VARCHAR, \"PolYear\" INTEGER, \"Amount\" "
			 "DOUBLE) "];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_TPExcess (\"SINO\" VARCHAR, \"FromYear\" INTEGER, \"YearInt\" INTEGER, \"Amount\" "
			 "DOUBLE, \"ForYear\" INTEGER) "];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_TPIncrease (\"SINO\" VARCHAR, \"FromYear\" INTEGER, \"YearInt\" INTEGER, \"Amount\" "
			 "DOUBLE) "];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_Fund_Maturity_Option (\"SINO\" VARCHAR, \"Fund\" VARCHAR, \"Option\" VARCHAR, "
			 "\"Partial_withd_Pct\" DOUBLE, \"EverGreen2025\" DOUBLE, \"EverGreen2028\" DOUBLE, \"EverGreen2030\" DOUBLE, "
			 "\"EverGreen2035\" DOUBLE, \"CashFund\" DOUBLE, \"RetireFund\" DOUBLE, \"DanaFund\" DOUBLE ) "];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_Rider_mtn (\"RiderCode\" VARCHAR, \"isEDD\" INTEGER, \"MinAge\" INTEGER, "
			 "\"MaxAge\" INTEGER, \"ExpiryAge\" INTEGER, \"MinSA\" DOUBLE, \"MaxSA\" DOUBLE, "
			 "\"MinTerm\" INTEGER, \"MaxTerm\" INTEGER, \"PlanCode\" VARCHAR, \"PTypeCode\" VARCHAR, \"Seq\" INTEGER)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_Rider_Profile ('RiderCode' VARCHAR, 'RiderDesc' VARCHAR, 'LifePlan' INTEGER, "
			 "'Status' INTEGER)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_Rider_Label (\"LabelCode\" VARCHAR, \"LabelDesc\" VARCHAR, \"RiderCode\" VARCHAR, "
			 "\"RiderName\" VARCHAR, \"InputCode\" VARCHAR, \"TableName\" VARCHAR, \"FieldName\" VARCHAR, \"Condition\" VARCHAR, "
			 "\"DateCreated\" DATETIME, \"CreatedBy\" VARCHAR, \"DateModified\" DATETIME, \"ModifiedBy\" VARCHAR)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS UL_RegWithdrawal('SINO' VARCHAR, 'FromAge' VARCHAR, 'ToAge' INTEGER, "
			 "'YearInt' INTEGER, 'Amount' VARCHAR )"];
    [database executeUpdate:query];
	
	//
	
	query = [NSString stringWithFormat:@"INSERT INTO Trad_Sys_Profile ('PlanCode', 'PlanName') VALUES(\"UV\", 'HLA EverLife Plus')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"ACIR\", 0, 0, 65, -100, 10000, 1500000, 10, 100, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"CIRD\", 0, 30, 55, 65, 20000, 100000, 10 , 10, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"CIWP\", 0, 0, 70, -80, 0.00, 0.00, 3 , 25, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"DCA\", 0, 0, 70, -75, 10000, 0.00, 5 , 75, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"DHI\", 0, 0, 70, -75, 50, 0.00, 5 , 75, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"ECAR\", 0, 0, 65, 80, 600, 0.00, 20 , 25, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"ECAR55\", 0, 0, 50, -100, 50.00, 0.00, 0 , 100, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"ECAR6\", 0, 0, 65, 80, 600, 0.00, 20 , 25, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"HMM\", 0, 0, 70, -100, 0.00, 0.00,0 , 100, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"LCWP\", 0, 16, 65, 80, 0.00, 0.00, 3 , 25, \"UV\", \"PY\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"LCWP\", 0, 16, 65, 80, 0.00, 0.00, 3 , 25, \"UV\", \"LA\", 2 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"LSR\", 0, 0, 70, -100, 20000, 0.00, 0 , 100, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"MG_IV\", 0, 0, 70, -100, 0.00, 0.00, 0 , 100, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"MR\", 0, 0, 70, 75, 1000, 5000, 5, 75, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"PA\", 0, 0, 70, 75, 10000, 0.00, 5 , 75, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"PR\", 0, 16, 65, 80, 0.00, 0.00, 3 , 25, \"UV\", \"PY\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"PR\", 0, 16, 65, 80, 0.00, 0.00, 3 , 25, \"UV\", \"LA\", 2 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"RRTUO\", 0, 0, 100, 100, 1.00, 10000, 1 , 100, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"TPDMLA\", 0, 0, 70, 75, 500, 10000, 5 , 75, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"TPDWP\", 0, 0, 65, 80, 0.00, 0.00, 3 , 80, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_mtn VALUES(\"WI\", 0, 20, 65, 70, 100, 8000, 5 , 70, \"UV\", \"LA\", 1 )"];
    [database executeUpdate:query];
	
	//
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES('ACIR', 'Accelerated Critical Illness', 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES('CIRD', 'Diabetes Wellness Care Rider', 0 , 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES('CIWP', 'Critical Illness Waiver of Premium Rider', 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES('DCA', 'Acc. Death & Compassionate Allowance Rider', 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"DHI\", \"Acc. Daily Hospitalisation Income Rider\", 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"ECAR\", \"EverCash 1 Rider\", 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"ECAR6\", \"EverCash Rider\", 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"ECAR55\", \"EverCash 55 Rider\", 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES('HMM', 'HLA Major Medi', 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES('LCWP', 'Living Care Waiver of Premium Rider', 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"LSR\", \"LifeShield Rider\", 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES('MG_IV', 'MedGlobal IV Plus', 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"MR\", \"Acc. Medical Reimbursement Rider\", 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES('PA', 'Personal Accident Rider', 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES('PR', 'Waiver of Premium Rider', 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"RRTUO\", \"Rider Regular Top Up Option\", 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"TPDMLA\", \"Acc. TPD Monthly Living Allowance Rider\", 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"TPDWP\", \"TPD Waiver of Premium Rider\", 0, 1)"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Profile VALUES(\"WI\", \"Acc. Weekly Indemnity Rider\", 0, 1)"];
    [database executeUpdate:query];
	
	
	//
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"ACIR\", \"Accelerated Critical Illness\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"ACIR\", \"Accelerated Critical Illness\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"ACIR\", \"Accelerated Critical Illness\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];

	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"ACIR\", \"Accelerated Critical Illness\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Rider Term\", \"CIRD\", \"Diabetes Wellness Care Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"CIRD\", \"Diabetes Wellness Care Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
	[database executeUpdate:query];

	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"CIRD\", \"Diabetes Wellness Care Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
	[database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"CIWP\", \"Critical Illness Waiver of Premium Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"CIWP\", \"Critical Illness Waiver of Premium Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"DCA\", \"Acc. Death & Compassionate Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"DCA\", \"Acc. Death & Compassionate Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"PAYT\", \"Payment Term\", \"DCA\", \"Acc. Death & Compassionate Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"DCA\", \"Acc. Death & Compassionate Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"DCA\", \"Acc. Death & Compassionate Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"DHI\", \"Acc. Daily Hospitalisation Income Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"DHI\", \"Acc. Daily Hospitalisation Income Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"PAYT\", \"Payment Term\", \"DHI\", \"Acc. Daily Hospitalisation Income Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"DHI\", \"Acc. Daily Hospitalisation Income Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"DHI\", \"Acc. Daily Hospitalisation Income Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"ECAR\", \"EverCash 1 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"YINC\", \"Yearly Income\", \"ECAR\", \"EverCash 1 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"PAYT\", \"Payment Term\", \"ECAR\", \"EverCash 1 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"REYI\", \"Reinvestment of Yearly Income\", \"ECAR\", \"EverCash 1 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1KSA)\", \"ECAR\", \"EverCash 1 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	//---
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"ECAR6\", \"EverCash 6 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"YINC\", \"Yearly Income\", \"ECAR6\", \"EverCash 6 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"PAYT\", \"Payment Term\", \"ECAR6\", \"EverCash 6 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"REYI\", \"Reinvestment of Yearly Income\", \"ECAR6\", \"EverCash 6 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1KSA)\", \"ECAR6\", \"EverCash 6 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	//---
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"MINC\", \"Monthly Income\", \"ECAR55\", \"EverCash 55 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"PAYT\", \"Payment Term\", \"ECAR55\", \"EverCash 55 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"REMI\", \"Reinvestment of Month Income\", \"ECAR55\", \"EverCash 55 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1KSA)\", \"ECAR55\", \"EverCash 55 Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"PLCH\", \"Plan Choice\", \"HMM\", \"HLA Major Medi\", \"DD\", "
			 "\"\", \"\", \"PlanChoiceHMM\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"DEDUC\", \"Deductible\", \"HMM\", \"HLA Major Medi\", \"DD\", "
			 "\"\", \"\", \"DeductibleHMM\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"HMM\", \"HLA Major Medi\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"LCWP\", \"Living CAre Waiver of Premium Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1KSA)\", \"LCWP\", \"Living Care Waiver of Premium Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"LSR\", \"LifeShield Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1KSA)\", \"LSR\", \"LifeShield Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"LSR\", \"LifeShield Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"PLCH\", \"Plan Choice\", \"MG_IV\", \"MedGlobal IV Plus\", \"TF\", "
			 "\"\", \"\", 'PlanChoiceMGIV',  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"MG_IV\", \"MedGlobal IV Plus\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"MR\", \"Acc. Medical Reimbursement Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"MR\", \"Acc. Medical Reimbursement Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"MR\", \"Acc. Medical Reimbursement Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];

	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"MR\", \"Acc. Medical Reimbursement Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"PA\", \"Personal Accident Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"PA\", \"Personal Accident Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"PA\", \"Personal Accident Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];

	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"PA\", \"Personal Accident Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"PR\", \"Waiver of Premium Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1KSA)\", \"PR\", \"Waiver of Premium Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"CFPA\", \"Commencing From (pol. anniversary)\", \"RRTUO\", \"Rider Regular Top Up Option\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"FORY\", \"for(year)\", \"RRTUO\", \"Rider Regular Top Up Option\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"PREM\", \"Premium\", \"RRTUO\", \"Rider Regular Top Up Option\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"TPDMLA\", \"Acc. TPD Monthly Living Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"TPDMLA\", \"Acc. TPD Monthly Living Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"TPDMLA\", \"Acc. TPD Monthly Living Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"TPDMLA\", \"Acc. TPD Monthly Living Allowance Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"TPDWP\", \"TPD Waiver of Premium Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"TPDWP\", \"TPD Waiver of Premium Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"RITM\", \"Rider Term\", \"WI\", \"Acc. Weekly Indemnity Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"SUMA\", \"Sum Assured\", \"WI\", \"Acc. Weekly Indemnity Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HLP\", \"Health Loading (%%)\", \"WI\", \"Acc. Weekly Indemnity Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];

	query = [NSString stringWithFormat:@"INSERT INTO UL_Rider_Label VALUES(\"HL1K\", \"Health Loading (Per 1K SA)\", \"WI\", \"Acc. Weekly Indemnity Rider\", \"TF\", "
			 "\"\", \"\", \"\",  date('now'), 'HLA', date('now'), 'HLA')"];
    [database executeUpdate:query];
	
	[database close];
	 
}


+(NSString *)WSLogin{
	
	return @"http://echannel.dev/";
	//return @"http://www.hla.com.my:2880/";
}

@end
