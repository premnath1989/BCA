//
//  PRxml.m
//  HLA_InfoConnect
//
//  Created by compurex on 1/2/14.
//  Copyright (c) 2014 compurex. All rights reserved.
//

#import "PRxml.h"
#import "NullValidations.h"
#import "DataClass.h"

#import "textFields.h"

@implementation PRxml{
    
    NSString *referenceNo;
    NSString *trustinfo,*childinfo,*retirementinfo,*educationinfo,*savinginfo,*productrec,*nomineinfo,*existpolinfo,*protecinfo,
    *ecffinfo,*recofadv,*recoofconf,*personalinfo;
    
    
    DataClass *obj;
    
}

-(void)GeneratePRXML:(NSDictionary*)DataDictionary RNNumber:(NSString*) RNNumber
{
    referenceNo = [[NSString alloc]init];
    
    for (id key in DataDictionary) {
        if([key isEqualToString:@"eProposalNo"]){
            referenceNo = [DataDictionary objectForKey:key];
        }else{
            referenceNo =  RNNumber;
        }
    }
    
    NSMutableString *XMLString = [NSMutableString string];
    
    XMLString = [XMLString stringByAppendingString:@"<eApps>"];
    XMLString = [XMLString stringByAppendingString:[self geteSystemInfo:DataDictionary]];
    XMLString = [XMLString stringByAppendingString:[self getSubmissionInfo:DataDictionary]];
    XMLString = [XMLString stringByAppendingString:[self getChannelInfo:DataDictionary]];
    XMLString = [XMLString stringByAppendingString:[self getAgentInfo:DataDictionary]];
    XMLString = [XMLString stringByAppendingString:[self getAssuredInfo:DataDictionary]];
    
    XMLString = [XMLString stringByAppendingString:[self getNomineeInfo:DataDictionary]];
    //    nomineinfo = [XMLString stringByAppendingString:[self getNomineeInfo:DataDictionary]];
    //    if(nomineinfo== NULL)
    //    {
    //        NSString *nomineinfo = @"";
    //
    //    }
    
    
    XMLString = [XMLString stringByAppendingString:[self getCreditCardInfo:DataDictionary]];
//     XMLString = [XMLString stringByAppendingString:[self getGSTInfo:DataDictionary]];
    XMLString = [XMLString stringByAppendingString:[self getDCCreditCardInfo:DataDictionary]];

    XMLString = [XMLString stringByAppendingString:[self getFATCAInfo:DataDictionary]];
    
     XMLString = [XMLString stringByAppendingString:[self getFTCreditCardInfo:DataDictionary]];
    
    XMLString = [XMLString stringByAppendingString:[self getPaymentInfo:DataDictionary]];
    
    XMLString = [XMLString stringByAppendingString:[self getTrusteeInfo:DataDictionary]];
    
    XMLString = [XMLString stringByAppendingString:[self getExistingPolInfo:DataDictionary]];
    
    
    XMLString = [XMLString stringByAppendingString:[self getQuestionaireInfo:DataDictionary]];
    //XMLString = [XMLString stringByAppendingString:[self getAdditionalQuestionaireInfo:DataDictionary]];
    
    //XMLString = [XMLString stringByAppendingString:[self getAdditionalQuestionaireDetailsInfo:DataDictionary]];
    XMLString = [XMLString stringByAppendingString:[self getContigentInfo:DataDictionary]];
    XMLString = [XMLString stringByAppendingString:[self getAdditionalQuestionaireInfo:DataDictionary]];
    
    XMLString = [XMLString stringByAppendingString:[self getDividendInfo:DataDictionary]];
    XMLString = [XMLString stringByAppendingString:[self getFundInfo:DataDictionary]];
    //changed by basvi from lno 74 to 174 for comapnycase dont need xml
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsPath = [paths objectAtIndex:0];
	NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
	
	FMDatabase *db = [FMDatabase databaseWithPath:path];
	[db open];
	
	NSString *eProposalNo = referenceNo;
	NSString *POOtherIDType;
	NSString *selectPO = [NSString stringWithFormat:@"SELECT LAOtherIDType FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'",eProposalNo];
	
	FMResultSet *results;
	results = [db executeQuery:selectPO];
	while ([results next]) {
		POOtherIDType = [results objectForColumnName:@"LAOtherIDType"];
	}
	//ecffinfo
	if ([POOtherIDType isEqualToString:@"CR"])
    {
       // NSLog(@"dont generate xml in this case");
    }
    else
    {
        XMLString = [XMLString stringByAppendingString:[self geteCFFInfo:DataDictionary]];
    }
    
    
    
    //personal info
    if ([POOtherIDType isEqualToString:@"CR"]) {
        
        NSLog(@"dont generete xml");
    }else
    {
        XMLString = [XMLString stringByAppendingString:[self getPersonalInfo:DataDictionary]];
    }
    //childinfo
    if ([POOtherIDType isEqualToString:@"CR"]) {
        
        NSLog(@"dont generete xml");
    }else
    {
        XMLString = [XMLString stringByAppendingString:[self getChildInfo:DataDictionary]];
    }
    //protection info
    if ([POOtherIDType isEqualToString:@"CR"]) {
        
        NSLog(@"dont generete xml");
    }else
    {
        
        XMLString = [XMLString stringByAppendingString:[self getProtectionInfo:DataDictionary]];
    }
    
    //retirement Info
    if ([POOtherIDType isEqualToString:@"CR"]) {
        
        NSLog(@"dont generete xml");
    }else
    {
        
        XMLString = [XMLString stringByAppendingString:[self getRetirementInfo:DataDictionary]];
    }
    //education info
    if ([POOtherIDType isEqualToString:@"CR"]) {
        
        NSLog(@"dont generete xml");
    }else
    {
        XMLString = [XMLString stringByAppendingString:[self getEducInfo:DataDictionary]];
    }
    //saving info
    if ([POOtherIDType isEqualToString:@"CR"]) {
        
        NSLog(@"dont generete xml");
    }else
    {
        XMLString = [XMLString stringByAppendingString:[self getSavingInfo:DataDictionary]];
    }
    
    //Record of advice info
    if ([POOtherIDType isEqualToString:@"CR"]) {
        
        NSLog(@"dont generete xml");
    }else
    {
        XMLString = [XMLString stringByAppendingString:[self getRecordOfAdvice:DataDictionary]];
    }
    //confirmation of advice info
    if ([POOtherIDType isEqualToString:@"CR"]) {
        
        NSLog(@"dont generete xml");
    }else
    {
        XMLString = [XMLString stringByAppendingString:[self getConfirmationOfAdviceGivenTo:DataDictionary]];
    }
    //product Recomended
    if ([POOtherIDType isEqualToString:@"CR"]) {
        
        NSLog(@"dont generete xml");
    }else
    {
        XMLString = [XMLString stringByAppendingString:[self getProductRecommended:DataDictionary]];
    }
    //iMobileExtraInfo
    XMLString = [XMLString stringByAppendingString:[self getiMobileExtraInfo:DataDictionary]];
    //SignInfo
    XMLString = [XMLString stringByAppendingString:[self getSignInfo:DataDictionary]];
     
    
    
    //  questinaryinfo = [XMLString stringByAppendingString:[self getQuestionaireInfo:DataDictionary]];
    //  if (questinaryinfo != NULL) {
    
    // }
    
    XMLString = [XMLString stringByAppendingString:@"</eApps>"];
    
    /*
     NSMutableString *XMLString = [NSMutableString string];
     [XMLString appendFormat:@"<eApps>%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@%@</eApps>",
     
     
     [self geteSystemInfo:DataDictionary],
     [self getSubmissionInfo:DataDictionary],
     [self getChannelInfo:DataDictionary],
     [self getAgentInfo:DataDictionary],
     [self getAssuredInfo:DataDictionary],
     [self getNomineeInfo:DataDictionary],
     [self getCreditCardInfo:DataDictionary],
     [self getPaymentInfo:DataDictionary],
     [self getTrusteeInfoInfo:DataDictionary],
     [self getExistingPolInfo:DataDictionary],
     [self getQuestionaireInfo:DataDictionary],
     [self getContigentInfo:DataDictionary],
     [self getDividendInfo:DataDictionary],
     [self getFundInfo:DataDictionary],
     [self geteCFFInfo:DataDictionary],
     [self getPersonalInfo:DataDictionary],
     [self getChildInfo:DataDictionary],
     [self getProtectionInfo:DataDictionary],
     [self getRetirementInfo:DataDictionary],
     [self getEducInfo:DataDictionary],
     [self getSavingInfo:DataDictionary],
     [self getRecordOfAdvice:DataDictionary],
     [self getConfirmationOfAdviceGivenTo:DataDictionary],
     [self getProductRecommended:DataDictionary]];
     
     */
    [[NSFileManager defaultManager] createFileAtPath:[[NSString stringWithFormat:@"~/Documents/ProposalXML/%@_PR.xml",referenceNo] stringByExpandingTildeInPath]
                                            contents:[XMLString dataUsingEncoding:NSUTF8StringEncoding]
                                          attributes:nil];
    //HTTPPost *PostRequest = [[HTTPPost alloc]init];
    //[PostRequest HTTPPost:[NSString stringWithFormat:@"%@_PR.xml",[[DataDictionary objectForKey:@"AssuredInfo"]objectForKey:@"eProposalNo"]]];
}

-(id)geteSystemInfo:(NSDictionary*)DataDictionary
{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *eSystemInfoXML = [NSMutableString string];
    id eventsArray = [DataDictionary objectForKey:@"eSystemInfo"];
    [eSystemInfoXML appendFormat:@"<eSystemInfo>%@</eSystemInfo>",[self parserNSDictionarytoXML:eventsArray]];
    return eSystemInfoXML;
}

-(id)getSubmissionInfo:(NSDictionary*)DataDictionary
{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *SubmissionInfoXML = [NSMutableString string];
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/YYYY HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    
    // NSLog(dateString);
    
    
    [SubmissionInfoXML appendFormat:@"<SubmissionInfo>"];
    
    [SubmissionInfoXML appendFormat:@"<CreatedAt>%@</CreatedAt>",[[DataDictionary objectForKey:@"SubmissionInfo"]objectForKey:@"CreatedAt"]];
    [SubmissionInfoXML appendFormat:@"<XMLGeneratedAt>%@",[[DataDictionary objectForKey:@"SubmissionInfo"]objectForKey:@"XMLGeneratedAt"]];
    [SubmissionInfoXML appendString:dateString];
    [SubmissionInfoXML appendString:@"</XMLGeneratedAt>"];
    
    
    
    [SubmissionInfoXML appendFormat:@"<BackDate>%@</BackDate>",[[DataDictionary objectForKey:@"SubmissionInfo"]objectForKey:@"BackDate"]];
    [SubmissionInfoXML appendFormat:@"<Backdating>%@</Backdating>",[[DataDictionary objectForKey:@"SubmissionInfo"]objectForKey:@"Backdating"]];
    [SubmissionInfoXML appendFormat:@"<SIType>%@</SIType>",[[DataDictionary objectForKey:@"SubmissionInfo"]objectForKey:@"SIType"]];
    [SubmissionInfoXML appendFormat:@"<CFFStatus>%@</CFFStatus>",[[DataDictionary objectForKey:@"SubmissionInfo"]objectForKey:@"CFFStatus"]];
    [SubmissionInfoXML appendFormat:@"<PreferredLife>%@</PreferredLife>",[[DataDictionary objectForKey:@"SubmissionInfo"]objectForKey:@"PreferredLife"]];
    
    // [SubmissionInfoXML appendFormat:[@"<SubmissionInfo><CreatedAt>%@</CreatedAt><BackDate>%@</BackDate><Backdating>%@</Backdating><SIType>%@</SIType><CFFStatus>%@</CFFStatus>" ,
    
    //[DataDictionary objectForKey:@"SubmissionInfo"]objectForKey:@"CreatedAt"],
    //[SubmissionInfoXML appendString:@"<XMLGeneratedAt>%@</XMLGeneratedAt>"],
    //[SubmissionInfoXML appendString:dateString];
    // [[DataDictionary objectForKey:@"SubmissionInfo"]objectForKey:@"XMLGeneratedAt"],
    
    // [[DataDictionary objectForKey:@"SubmissionInfo"]objectForKey:@"BackDate"],
    //[[DataDictionary objectForKey:@"SubmissionInfo"]objectForKey:@"Backdating"],
    //[[DataDictionary objectForKey:@"SubmissionInfo"]objectForKey:@"SIType"],
    // [[DataDictionary objectForKey:@"SubmissionInfo"]objectForKey:@"CFFStatus"]];
    
    
    //[SubmissionInfoXML appendString:dateString]];
    id eventsArray = [DataDictionary objectForKey:@"SubmissionInfo"];
    
    [SubmissionInfoXML appendFormat:@"</SubmissionInfo>"];
    return SubmissionInfoXML;
    
}

-(id)getChannelInfo:(NSDictionary*)DataDictionary
{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *ChannelInfoXML = [NSMutableString string];
    [ChannelInfoXML appendFormat:@"<ChannelInfo><Channel>%@</Channel>",
     [[DataDictionary objectForKey:@"ChannelInfo"]objectForKey:@"Channel"]];
    id eventsArray = [DataDictionary objectForKey:@"ChannelInfo"];
    [ChannelInfoXML appendFormat:@"</ChannelInfo>"];
    return ChannelInfoXML;
}

-(id)getAgentInfo:(NSDictionary*)DataDictionary
{
    
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    
    @try {
        NSMutableString *AgentInfoXML = [NSMutableString string];
        [AgentInfoXML appendFormat:@"<AgentInfo><AgentCount>%@</AgentCount>",[[[DataDictionary objectForKey:@"AgentInfo"] lastObject]objectForKey:@"AgentCount"]];
        int AgentCount = [[[[DataDictionary objectForKey:@"AgentInfo"] lastObject]objectForKey:@"AgentCount"] intValue];
        for(int i = 0;i<AgentCount ;i++)
        {
            
            /*     [AgentInfoXML appendFormat:@"<Agent ID>%d</Agent ID><AgentCode>%@</AgentCode><AgentContactNo>%d</AgentContactNo>",i,
             
             [[[DataDictionary objectForKey:@"AgentInfo"] objectAtIndex:i]objectForKey:@"Agent ID"],
             
             [[[DataDictionary objectForKey:@"AgentInfo"] objectAtIndex:i]objectForKey:@"AgentCode"],
             
             [[[DataDictionary objectForKey:@"AgentInfo"] objectAtIndex:i]objectForKey:@"AgentContactNo"];
             */
            
            id eventsArray = [[DataDictionary objectForKey:@"AgentInfo"] objectAtIndex:i];
            
            //        AgentCode = A0000615;
            //        AgentContactNo = 123456789;
            
            
            [[[DataDictionary objectForKey:@"AgentInfo"] objectAtIndex:i] objectForKey:[NSString stringWithFormat:@"Agent ID=\"%d\"",i]];
            [AgentInfoXML appendFormat:@"<Agent ID=\"%d\">",[[eventsArray objectForKey:@"Agent ID"] intValue]];
            [AgentInfoXML appendFormat:@"<Seq>%@</Seq>",[eventsArray objectForKey:@"Seq"]];
            [AgentInfoXML appendFormat:@"<AgentCode>%@</AgentCode>",[eventsArray objectForKey:@"AgentCode"]];
         
            
            if ([[eventsArray objectForKey:@"AgentName"] length]>0) {
                 [AgentInfoXML appendFormat:@"<iAgentName>%@</iAgentName>",[eventsArray objectForKey:@"AgentName"]];
            }
            [AgentInfoXML appendFormat:@"<AgentContactNo>%@</AgentContactNo>",[eventsArray objectForKey:@"AgentContactNo"]];
            [AgentInfoXML appendFormat:@"<LeaderCode>%@</LeaderCode>",[eventsArray objectForKey:@"LeaderCode"]];
            [AgentInfoXML appendFormat:@"<LeaderName>%@</LeaderName>",[eventsArray objectForKey:@"LeaderName"]];
            [AgentInfoXML appendFormat:@"<BRCode>%@</BRCode>",[eventsArray objectForKey:@"BRCode"]];
            [AgentInfoXML appendFormat:@"<ISONo>%@</ISONo>",[eventsArray objectForKey:@"ISONo"]];
            [AgentInfoXML appendFormat:@"<BRClosed>%@</BRClosed>",[eventsArray objectForKey:@"BRClosed"]];
            [AgentInfoXML appendFormat:@"<AgentPercentage>%@</AgentPercentage>",[eventsArray objectForKey:@"AgentPercentage"]];
            
            [AgentInfoXML appendFormat:@"</Agent>"];
            
        }
        [AgentInfoXML appendFormat:@"</AgentInfo>"];
        return AgentInfoXML;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

-(id)getAssuredInfo:(NSDictionary*)DataDictionary
{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *AssuredInfoXML = [NSMutableString string];
    
    [AssuredInfoXML appendFormat:@"<AssuredInfo><eProposalNo>%@</eProposalNo>",referenceNo];
    
    for(int i=1;i<[[DataDictionary objectForKey:@"AssuredInfo"]count];i++)
        
    {
        
        [AssuredInfoXML appendFormat:@"<Party ID=\"%d\"><PTypeCode>%@</PTypeCode><Seq>%@</Seq><DeclarationAuth>%@</DeclarationAuth><ClientChoice>%@</ClientChoice><LATitle>%@</LATitle><LAName>%@</LAName><LASex>%@</LASex><LADOB>%@</LADOB><LABirthCountry>%@</LABirthCountry><AgeAdmitted>%@</AgeAdmitted><LAMaritalStatus>%@</LAMaritalStatus><LARace>%@</LARace><LAReligion>%@</LAReligion><LANationality>%@</LANationality><LAOccupationCode>%@</LAOccupationCode><LAExactDuties><![CDATA[%@]]></LAExactDuties><LATypeOfBusiness><![CDATA[%@]]></LATypeOfBusiness><LAEmployerName>%@</LAEmployerName><LAYearlyIncome>%@</LAYearlyIncome><LARelationship>%@</LARelationship><ChildFlag>%@</ChildFlag><ResidenceOwnRented>%@</ResidenceOwnRented><CorrespondenceAddress>%@</CorrespondenceAddress><MalaysianWithPOBox>%@</MalaysianWithPOBox>",i,
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i]objectForKey:@"PTypeCode"],
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i]objectForKey:@"Seq"],
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i]objectForKey:@"DeclarationAuth"],
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i]objectForKey:@"ClientChoice"],
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i]objectForKey:@"LATitle"],
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i]objectForKey:@"LAName"],
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"LASex"],
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"LADOB"],
		 
		 [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"LABirthCountry"],
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"AgeAdmitted"],
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"LAMaritalStatus"],
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"LARace"],
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"LAReligion"],
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"LANationality"],
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"LAOccupationCode"],
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"LAExactDuties"],
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"LATypeOfBusiness"],
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"LAEmployerName"],
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"LAYearlyIncome"],
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"LARelationship"],
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"ChildFlag"],
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"ResidenceOwnRented"],
         
         [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"CorrespondenceAddress"],
		
		[[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"MalaysianWithPOBox"]];
        
        
		
        
        id eventsArray =  [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"LANewIC"];
        [AssuredInfoXML appendFormat:@"<LANewIC>"];
        [AssuredInfoXML appendFormat:@"<LANewICCode>%@</LANewICCode>",[eventsArray objectForKey:@"LANewICCode"]];
        [AssuredInfoXML appendFormat:@"<LANewICNo>%@</LANewICNo>",[eventsArray objectForKey:@"LANewICNo"]];
        [AssuredInfoXML appendFormat:@"</LANewIC>"];
        
        
        
        
        eventsArray =  [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"LAOtherID"];
        [AssuredInfoXML appendFormat:@"<LAOtherID>"];
        [AssuredInfoXML appendFormat:@"<LAOtherIDType>%@</LAOtherIDType>",[eventsArray objectForKey:@"LAOtherIDType"]];
        [AssuredInfoXML appendFormat:@"<LAOtherID>%@</LAOtherID>",[eventsArray objectForKey:@"LAOtherID"]];
        [AssuredInfoXML appendFormat:@"</LAOtherID>"];
        [AssuredInfoXML appendFormat:@"<iLAOtherID>"];
        [AssuredInfoXML appendFormat:@"<iLAOtherIDType>%@</iLAOtherIDType>",[eventsArray objectForKey:@"LAOtherIDType"]];
        [AssuredInfoXML appendFormat:@"<iLAOtherIDNo>%@</iLAOtherIDNo>",[eventsArray objectForKey:@"LAOtherID"]];
        [AssuredInfoXML appendFormat:@"</iLAOtherID>"];
        
        
        [AssuredInfoXML appendFormat:@"<Addresses>"];
        
        eventsArray =  [[[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"Addresses"]objectForKey:@"Residence"];
        [AssuredInfoXML appendFormat:@"<Address Type=\"Residence\">"];
        
        [AssuredInfoXML appendFormat:@"<AddressCode>%@</AddressCode>",[eventsArray objectForKey:@"AddressCode"]];
        [AssuredInfoXML appendFormat:@"<Address1><![CDATA[%@]]></Address1>",[eventsArray objectForKey:@"Address1"]];
        [AssuredInfoXML appendFormat:@"<Address2><![CDATA[%@]]></Address2>",[eventsArray objectForKey:@"Address2"]];
        [AssuredInfoXML appendFormat:@"<Address3><![CDATA[%@]]></Address3>",[eventsArray objectForKey:@"Address3"]];
        [AssuredInfoXML appendFormat:@"<Town><![CDATA[%@]]></Town>",[eventsArray objectForKey:@"Town"]];
        [AssuredInfoXML appendFormat:@"<State><![CDATA[%@]]></State>",[eventsArray objectForKey:@"State"]];
        [AssuredInfoXML appendFormat:@"<Postcode>%@</Postcode>",[eventsArray objectForKey:@"Postcode"]];
        [AssuredInfoXML appendFormat:@"<Country><![CDATA[%@]]></Country>",[eventsArray objectForKey:@"Country"]];
        [AssuredInfoXML appendFormat:@"<ForeignAddress>%@</ForeignAddress>",[eventsArray objectForKey:@"ForeignAddress"]];
		[AssuredInfoXML appendFormat:@"<POBoxFlag>%@</POBoxFlag>",[eventsArray objectForKey:@"PoBox"]];
        [AssuredInfoXML appendFormat:@"</Address>"];
        
        
        
        eventsArray =  [[[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"Addresses"]objectForKey:@"Office"];
        [AssuredInfoXML appendFormat:@"<Address Type=\"Office\">"];
        
        [AssuredInfoXML appendFormat:@"<AddressCode>%@</AddressCode>",[eventsArray objectForKey:@"AddressCode"]];
        [AssuredInfoXML appendFormat:@"<Address1><![CDATA[%@]]></Address1>",[eventsArray objectForKey:@"Address1"]];
        [AssuredInfoXML appendFormat:@"<Address2><![CDATA[%@]]></Address2>",[eventsArray objectForKey:@"Address2"]];
        [AssuredInfoXML appendFormat:@"<Address3><![CDATA[%@]]></Address3>",[eventsArray objectForKey:@"Address3"]];
        [AssuredInfoXML appendFormat:@"<Town><![CDATA[%@]]></Town>",[eventsArray objectForKey:@"Town"]];
        [AssuredInfoXML appendFormat:@"<State><![CDATA[%@]]></State>",[eventsArray objectForKey:@"State"]];
        [AssuredInfoXML appendFormat:@"<Postcode>%@</Postcode>",[eventsArray objectForKey:@"Postcode"]];
        [AssuredInfoXML appendFormat:@"<Country><![CDATA[%@]]></Country>",[eventsArray objectForKey:@"Country"]];
        [AssuredInfoXML appendFormat:@"<ForeignAddress>%@</ForeignAddress>",[eventsArray objectForKey:@"ForeignAddress"]];
		[AssuredInfoXML appendFormat:@"<POBoxFlag>%@</POBoxFlag>",[eventsArray objectForKey:@"PoBox"]];
        [AssuredInfoXML appendFormat:@"</Address>"];
        
        [AssuredInfoXML appendFormat:@"</Addresses>"];
        
        
        
        
        [AssuredInfoXML appendFormat:@"<Contacts>"];
        
        eventsArray =  [[[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"Contacts"]objectForKey:@"Residence"];
        [AssuredInfoXML appendFormat:@"<Contact Type=\"Residence\">"];
        [AssuredInfoXML appendFormat:@"<ContactCode>%@</ContactCode>",[eventsArray objectForKey:@"ContactCode"]];
        [AssuredInfoXML appendFormat:@"<ContactNo>%@</ContactNo>",[eventsArray objectForKey:@"ContactNo"]];
        [AssuredInfoXML appendFormat:@"</Contact>"];
        
        
        
        
        eventsArray =  [[[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"Contacts"]objectForKey:@"Office"];
        [AssuredInfoXML appendFormat:@"<Contact Type=\"Office\">"];
        [AssuredInfoXML appendFormat:@"<ContactCode>%@</ContactCode>",[eventsArray objectForKey:@"ContactCode"]];
        [AssuredInfoXML appendFormat:@"<ContactNo>%@</ContactNo>",[eventsArray objectForKey:@"ContactNo"]];
        [AssuredInfoXML appendFormat:@"</Contact>"];
        
        
        
        eventsArray =  [[[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"Contacts"]objectForKey:@"Mobile"];
        [AssuredInfoXML appendFormat:@"<Contact Type=\"Mobile\">"];
        [AssuredInfoXML appendFormat:@"<ContactCode>%@</ContactCode>",[eventsArray objectForKey:@"ContactCode"]];
        [AssuredInfoXML appendFormat:@"<ContactNo>%@</ContactNo>",[eventsArray objectForKey:@"ContactNo"]];
        [AssuredInfoXML appendFormat:@"</Contact>"];
        
        
        
        eventsArray =  [[[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"Contacts"]objectForKey:@"Email"];
        [AssuredInfoXML appendFormat:@"<Contact Type=\"Email\">"];
        [AssuredInfoXML appendFormat:@"<ContactCode>%@</ContactCode>",[eventsArray objectForKey:@"ContactCode"]];
        [AssuredInfoXML appendFormat:@"<ContactNo>%@</ContactNo>",[eventsArray objectForKey:@"ContactNo"]];
        [AssuredInfoXML appendFormat:@"</Contact>"];
        
        
        
        eventsArray =  [[[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"Contacts"]objectForKey:@"Fax"];
        [AssuredInfoXML appendFormat:@"<Contact Type=\"Fax\">"];
        [AssuredInfoXML appendFormat:@"<ContactCode>%@</ContactCode>",[eventsArray objectForKey:@"ContactCode"]];
        [AssuredInfoXML appendFormat:@"<ContactNo>%@</ContactNo>",[eventsArray objectForKey:@"ContactNo"]];
        [AssuredInfoXML appendFormat:@"</Contact>"];
        
        
        [AssuredInfoXML appendFormat:@"</Contacts>"];
        
        
        
        [AssuredInfoXML appendFormat:@"<PentalHealthDetails>"];
        //        PentalHealthDetails =     {
        //            PentalHealth =         {
        //                Code = MDTAUW01;
        //                Status = "";
        //            };
        //        };
        
        eventsArray =  [[[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i]  objectForKey:@"PentalHealthDetails"]objectForKey:@"PentalHealth1"];
        [AssuredInfoXML appendFormat:@"<PentalHealth>"];
        [AssuredInfoXML appendFormat:@"<Code>%@</Code>",[eventsArray objectForKey:@"Code"]];
        [AssuredInfoXML appendFormat:@"<Status>%@</Status>",[eventsArray objectForKey:@"Status"]];
        
        [AssuredInfoXML appendFormat:@"</PentalHealth>"];
        
        
        
        
        eventsArray =  [[[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"PentalHealthDetails"]objectForKey:@"PentalHealth2"];
        [AssuredInfoXML appendFormat:@"<PentalHealth>"];
        [AssuredInfoXML appendFormat:@"<Code>%@</Code>",[eventsArray objectForKey:@"Code"]];
        [AssuredInfoXML appendFormat:@"<Status>%@</Status>",[eventsArray objectForKey:@"Status"]];
        
        [AssuredInfoXML appendFormat:@"</PentalHealth>"];
        
        eventsArray =  [[[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"PentalHealthDetails"]objectForKey:@"PentalHealth3"];
        [AssuredInfoXML appendFormat:@"<PentalHealth>"];
        [AssuredInfoXML appendFormat:@"<Code>%@</Code>",[eventsArray objectForKey:@"Code"]];
        [AssuredInfoXML appendFormat:@"<Status>%@</Status>",[eventsArray objectForKey:@"Status"]];
        
        [AssuredInfoXML appendFormat:@"</PentalHealth>"];
        
        [AssuredInfoXML appendFormat:@"</PentalHealthDetails>"];
        
                
        eventsArray =  [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"LAGST"];
        [AssuredInfoXML appendFormat:@"<LAGST>"];
        [AssuredInfoXML appendFormat:@"<GSTRegPerson>%@</GSTRegPerson>",[eventsArray objectForKey:@"GSTRegPerson"]];
        [AssuredInfoXML appendFormat:@"<GSTRegNo>%@</GSTRegNo>",[eventsArray objectForKey:@"GSTRegNo"]];
        [AssuredInfoXML appendFormat:@"<GSTRegDate>%@</GSTRegDate>",[eventsArray objectForKey:@"GSTRegDate"]];
        [AssuredInfoXML appendFormat:@"<GSTExempted>%@</GSTExempted>",[eventsArray objectForKey:@"GSTExempted"]];
    
        [AssuredInfoXML appendFormat:@"</LAGST></Party>"];        
        
    }
    
    [AssuredInfoXML appendFormat:@"</AssuredInfo>"];
    
    return AssuredInfoXML;
    
}



-(id)getNomineeInfo:(NSDictionary*)DataDictionary
{
    
    
    //    <NomineeInfo>
    //    <NomineeCount>1</NomineeCount>
    //    <Nominee ID="1">
    //    <Seq>1</Seq>
    //    <NMTitle>CIK</NMTitle>
    //    <NMName>Tan Ah Kow</NMName>
    //    <NMShare>100</NMShare>
    //    <NMDOB>21/07/1989</NMDOB>
    //    <NMSex>M</NMSex>
    //    <NMRelationship>KP</NMRelationship>
    //    <NMSamePOAddress>True</NMSamePOAddress>
    //    <NMTrustStatus />
    //    <NMChildAlive>Y</NMChildAlive>
    //    <NMNewIC>
    //    <NMNewICCode>NRIC</NMNewICCode>
    //    <NMNewICNo>890721097879</NMNewICNo>
    //    </NMNewIC>
    //    <NMOtherID>
    //    <NMOtherIDType />
    //    <NMOtherID />
    //    </NMOtherID>
    //    <NMAddr>
    //    <AddressCode>ADR001</AddressCode>
    //    <Address1>123 Damansara Jaya</Address1>
    //    <Address2>Damansara Jaya</Address2>
    //    <Address3>Petaing Jaya</Address3>
    //    <Town>PETALING JAYA</Town>
    //    <State>SL</State>
    //    <Postcode>47400</Postcode>
    //    <Country>MAL</Country>
    //    <ForeignAddress>N</ForeignAddress>
    //    <AddressSameAsPO>Y</AddressSameAsPO>
    //    </NMAddr>
    //    </Nominee>
    //    </NomineeInfo>
    
    //    $1 = 0x145c5060 {
    //        NMAddr =     {
    //            Address1 = "";
    //            Address2 = "";
    //            Address3 = "";
    //            AddressCode = ADR001;
    //            AddressSameAsPO = "";
    //            Country = "";
    //            ForeignAddress = "";
    //            Postcode = "";
    //            State = "";
    //            Town = "";
    //        };
    //        NMChildAlive = "";
    //        NMDOB = "";
    //        NMName = "";
    //        NMNewIC =     {
    //            NMNewICCode = "";
    //            NMNewICNo = "";
    //        };
    //        NMOtherID =     {
    //            NMOtherID = "";
    //            NMOtherIDType = "";
    //        };
    //        NMRelationship = "";
    //        NMSamePOAddress = "";
    //        NMSex = "";
    //        NMShare = "";
    //        NMTitle = "";
    //        NMTrustStatus = "";
    //        Seq = 1;
    //    }
    
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *NomineeInfoXML = [NSMutableString string];
    if([[[DataDictionary objectForKey:@"proposalNomineeInfo"]objectForKey:@"NomineeCount"] intValue]>0)
    {
        
        [NomineeInfoXML appendFormat:@"<NomineeInfo><NomineeCount>%@</NomineeCount>",[[DataDictionary objectForKey:@"proposalNomineeInfo"]objectForKey:@"NomineeCount"]];
        
        NSInteger NomineeCount = [[[DataDictionary objectForKey:@"proposalNomineeInfo"]objectForKey:@"NomineeCount"]integerValue];
        for(int i=0;i<NomineeCount;i++)
        {
            
            
            id NomineeDictionary=[[DataDictionary objectForKey:@"proposalNomineeInfo"] objectForKey:[NSString stringWithFormat:@"Nominee ID = \"%d\"",i+1]];
            [NomineeInfoXML appendFormat:[NSString stringWithFormat:@"<Nominee ID=\"%d\">",i+1] ]
            ;
            [NomineeInfoXML appendFormat:@"<Seq>%@</Seq>",[NomineeDictionary objectForKey:@"Seq"] ];
            [NomineeInfoXML appendFormat:@"<NMTitle>%@</NMTitle>",[NomineeDictionary objectForKey:@"NMTitle"] ];
            [NomineeInfoXML appendFormat:@"<NMName>%@</NMName>",[NomineeDictionary objectForKey:@"NMName"] ];
            [NomineeInfoXML appendFormat:@"<NMShare>%@</NMShare>",[NomineeDictionary objectForKey:@"NMShare"] ];
            [NomineeInfoXML appendFormat:@"<NMDOB>%@</NMDOB>",[NomineeDictionary objectForKey:@"NMDOB"] ];
            [NomineeInfoXML appendFormat:@"<NMSex>%@</NMSex>",[NomineeDictionary objectForKey:@"NMSex"] ];
            [NomineeInfoXML appendFormat:@"<NMRelationship>%@</NMRelationship>",[NomineeDictionary objectForKey:@"NMRelationship"] ];
            [NomineeInfoXML appendFormat:@"<NMNationality>%@</NMNationality>",[NomineeDictionary objectForKey:@"NMNationality"] ];
            [NomineeInfoXML appendFormat:@"<NMEmployerName>%@</NMEmployerName>",[NomineeDictionary objectForKey:@"NMEmployerName"] ];
            [NomineeInfoXML appendFormat:@"<NMOccupation>%@</NMOccupation>",[NomineeDictionary objectForKey:@"NMOccupation"] ];
            [NomineeInfoXML appendFormat:@"<NMExactDuties><![CDATA[%@]]></NMExactDuties>",[NomineeDictionary objectForKey:@"NMExactDuties"] ];
            [NomineeInfoXML appendFormat:@"<NMSamePOAddress>%@</NMSamePOAddress>",[NomineeDictionary objectForKey:@"NMSamePOAddress"] ];
            [NomineeInfoXML appendFormat:@"<NMTrustStatus>%@</NMTrustStatus>",[NomineeDictionary objectForKey:@"NMTrustStatus"] ];
            [NomineeInfoXML appendFormat:@"<NMChildAlive>%@</NMChildAlive>",[NomineeDictionary objectForKey:@"NMChildAlive"] ];
            
            
            [NomineeInfoXML appendFormat:[NSString stringWithFormat:@"<NMNewIC><NMNewICCode>%@</NMNewICCode><NMNewICNo>%@</NMNewICNo></NMNewIC> <NMOtherID><NMOtherIDType>%@</NMOtherIDType><NMOtherID>%@</NMOtherID></NMOtherID>",[[NomineeDictionary objectForKey:@"NMNewIC"] objectForKey:@"NMNewICCode"],[[NomineeDictionary objectForKey:@"NMNewIC"] objectForKey:@"NMNewICNo"],[[NomineeDictionary objectForKey:@"NMOtherID"] objectForKey:@"NMOtherIDType"],[[NomineeDictionary objectForKey:@"NMOtherID"] objectForKey:@"NMOtherID"]]];
            
            
            NSString *RAdd;
			RAdd = [[NomineeDictionary objectForKey:@"NMAddrR"] objectForKey:@"Address1"];
			RAdd = [RAdd stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
			NSLog(@"Radd %@", RAdd);
			
			[NomineeInfoXML appendFormat:@"<NMAddr>"];
			
			if (RAdd.length > 0){
				[NomineeInfoXML appendFormat:[NSString stringWithFormat:@"<NMAddress Type = \"R\"><NMAddressCode>%@</NMAddressCode><NMAddress1><![CDATA[%@]]></NMAddress1><NMAddress2><![CDATA[%@]]></NMAddress2><NMAddress3><![CDATA[%@]]></NMAddress3><NMTown><![CDATA[%@]]></NMTown><NMState><![CDATA[%@]]></NMState><NMPostcode>%@</NMPostcode><NMCountry><![CDATA[%@]]></NMCountry><NMForeignAddress>%@</NMForeignAddress><NMCorrespondenceFlag>%@</NMCorrespondenceFlag></NMAddress> ",[[NomineeDictionary objectForKey:@"NMAddrR"] objectForKey:@"AddressCode"],[[NomineeDictionary objectForKey:@"NMAddrR"] objectForKey:@"Address1"],[[NomineeDictionary objectForKey:@"NMAddrR"] objectForKey:@"Address2"],[[NomineeDictionary objectForKey:@"NMAddrR"] objectForKey:@"Address3"],[[NomineeDictionary objectForKey:@"NMAddrR"] objectForKey:@"Town"],[[NomineeDictionary objectForKey:@"NMAddrR"] objectForKey:@"State"],[[NomineeDictionary objectForKey:@"NMAddrR"] objectForKey:@"Postcode"],[[NomineeDictionary objectForKey:@"NMAddrR"] objectForKey:@"Country"],[[NomineeDictionary objectForKey:@"NMAddrR"] objectForKey:@"ForeignAddress"],[[NomineeDictionary objectForKey:@"NMAddrR"] objectForKey:@"AddressSameAsPO"]]];
            }
			
			NSString *CAdd;
			CAdd = [[NomineeDictionary objectForKey:@"NMAddrC"] objectForKey:@"Address1"];
			CAdd = [CAdd stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
			
			if (CAdd.length > 0){
				[NomineeInfoXML appendFormat:[NSString stringWithFormat:@"<NMAddress Type = \"C\"><NMAddressCode>%@</NMAddressCode><NMAddress1><![CDATA[%@]]></NMAddress1><NMAddress2><![CDATA[%@]]></NMAddress2><NMAddress3><![CDATA[%@]]></NMAddress3><NMTown><![CDATA[%@]]></NMTown><NMState><![CDATA[%@]]></NMState><NMPostcode>%@</NMPostcode><NMCountry><![CDATA[%@]]></NMCountry><NMForeignAddress>%@</NMForeignAddress><NMCorrespondenceFlag>%@</NMCorrespondenceFlag></NMAddress> ",[[NomineeDictionary objectForKey:@"NMAddrC"] objectForKey:@"AddressCode"],[[NomineeDictionary objectForKey:@"NMAddrC"] objectForKey:@"Address1"],[[NomineeDictionary objectForKey:@"NMAddrC"] objectForKey:@"Address2"],[[NomineeDictionary objectForKey:@"NMAddrC"] objectForKey:@"Address3"],[[NomineeDictionary objectForKey:@"NMAddrC"] objectForKey:@"Town"],[[NomineeDictionary objectForKey:@"NMAddrC"] objectForKey:@"State"],[[NomineeDictionary objectForKey:@"NMAddrC"] objectForKey:@"Postcode"],[[NomineeDictionary objectForKey:@"NMAddrC"] objectForKey:@"Country"],[[NomineeDictionary objectForKey:@"NMAddrC"] objectForKey:@"ForeignAddress"],[[NomineeDictionary objectForKey:@"NMAddrC"] objectForKey:@"AddressSameAsPO"]]];
            }
			
            [NomineeInfoXML appendFormat:@"</NMAddr>"];
		
            [NomineeInfoXML appendFormat:@"</Nominee>"];
        }
        
        [NomineeInfoXML appendFormat:@"</NomineeInfo>"];
    }
    return NomineeInfoXML;
}

-(id)getCreditCardInfo:(NSDictionary*)DataDictionary
{
    
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *CreditCardInfoXML = [NSMutableString string];
    
    [CreditCardInfoXML appendFormat:@"<CreditCardInfo><CardMemberAccountNo>%@</CardMemberAccountNo><CardExpiredDate>%@</CardExpiredDate><CardMemberName>%@</CardMemberName><CardMemberNewICNo>%@</CardMemberNewICNo><CardMemberContactNo>%@</CardMemberContactNo><CardMemberRelationship>%@</CardMemberRelationship><CreditCardType>%@</CreditCardType><CreditCardBank>%@</CreditCardBank>",
     [[DataDictionary objectForKey:@"proposalCreditCardInfo"]objectForKey:@"CardMemberAccountNo"],
     [[DataDictionary objectForKey:@"proposalCreditCardInfo"]objectForKey:@"CardExpiredDate"],
     [[DataDictionary objectForKey:@"proposalCreditCardInfo"]objectForKey:@"CardMemberName"],
     [[DataDictionary objectForKey:@"proposalCreditCardInfo"]objectForKey:@"CardMemberNewICNo"],
     [[DataDictionary objectForKey:@"proposalCreditCardInfo"]objectForKey:@"CardMemberContactNo"],
     [[DataDictionary objectForKey:@"proposalCreditCardInfo"]objectForKey:@"CardMemberRelationship"],
     [[DataDictionary objectForKey:@"proposalCreditCardInfo"]objectForKey:@"CreditCardType"],
     [[DataDictionary objectForKey:@"proposalCreditCardInfo"]objectForKey:@"CreditCardBank"]];
    id eventsArray = [DataDictionary objectForKey:@"proposalCreditCardInfo"];
    [CreditCardInfoXML appendFormat:@"</CreditCardInfo>"];
    return CreditCardInfoXML;
}

-(id)getDCCreditCardInfo:(NSDictionary*)DataDictionary
{
    
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *CreditCardInfoXML = [NSMutableString string];
     [CreditCardInfoXML appendFormat:@"<DirectCredit><DirectCredit>%@</DirectCredit>",[[DataDictionary objectForKey:@"DCCreditCardInfo"]objectForKey:@"DirectCredit"]];
    
    [CreditCardInfoXML appendFormat:@"<PolicyBankInfo><PBBankname>%@</PBBankname><PBAccType>%@</PBAccType><PBAccNo>%@</PBAccNo><PBPayeeType>%@</PBPayeeType><PBNRIC>%@</PBNRIC><PBOtherIDType>%@</PBOtherIDType><PBOtherID>%@</PBOtherID><PBEmail>%@</PBEmail><PBMobileNo>%@</PBMobileNo>",
     
     [[DataDictionary objectForKey:@"DCCreditCardInfo"]objectForKey:@"PBBankname"],
     [[DataDictionary objectForKey:@"DCCreditCardInfo"]objectForKey:@"PBAccType"],
     [[DataDictionary objectForKey:@"DCCreditCardInfo"]objectForKey:@"PBAccNo"],
     [[DataDictionary objectForKey:@"DCCreditCardInfo"]objectForKey:@"PBPayeeType"],
     [[DataDictionary objectForKey:@"DCCreditCardInfo"]objectForKey:@"PBNRIC"],
     [[DataDictionary objectForKey:@"DCCreditCardInfo"]objectForKey:@"PBOtherIDType"],
     [[DataDictionary objectForKey:@"DCCreditCardInfo"]objectForKey:@"PBOtherID"],
     [[DataDictionary objectForKey:@"DCCreditCardInfo"]objectForKey:@"PBEmail"],
     [[DataDictionary objectForKey:@"DCCreditCardInfo"]objectForKey:@"PBMobileNo"]];
  
    [CreditCardInfoXML appendFormat:@"</PolicyBankInfo>"];
    [CreditCardInfoXML appendFormat:@"</DirectCredit>"];
    return CreditCardInfoXML;
}

-(id)getFATCAInfo:(NSDictionary*)DataDictionary
{
    
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *CreditCardInfoXML = [NSMutableString string];
    [CreditCardInfoXML appendFormat:@"<FATCAInfo>"];
    
    [CreditCardInfoXML appendFormat:@"<FATCA ID=\"%@\"><PTypeCode>%@</PTypeCode><Seq>%@</Seq><PersonChoice>%@</PersonChoice><BizCategoryChoice>%@</BizCategoryChoice><FATCAClassification>%@</FATCAClassification><GIIN>%@</GIIN><EntityType>%@</EntityType>",
     @"1",
     [[DataDictionary objectForKey:@"FATCAInfo"]objectForKey:@"PTypeCode"],
     [[DataDictionary objectForKey:@"FATCAInfo"]objectForKey:@"Seq"],     
     [[DataDictionary objectForKey:@"FATCAInfo"]objectForKey:@"PersonChoice"],
     [[DataDictionary objectForKey:@"FATCAInfo"]objectForKey:@"BizCategoryChoice"],
     [[DataDictionary objectForKey:@"FATCAInfo"]objectForKey:@"FATCAClassification"],
     [[DataDictionary objectForKey:@"FATCAInfo"]objectForKey:@"GIIN"],
     [[DataDictionary objectForKey:@"FATCAInfo"]objectForKey:@"EntityType"]],

    [CreditCardInfoXML appendFormat:@"</FATCA>"];
    [CreditCardInfoXML appendFormat:@"</FATCAInfo>"];
    return CreditCardInfoXML;
}

//-(id)getGSTInfo:(NSDictionary*)DataDictionary
//{
//    
//    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
//    NSMutableString *CreditCardInfoXML = [NSMutableString string];
//    
//    [CreditCardInfoXML appendFormat:@"<GSTInfo><GSTRegPerson>%@</GSTRegPerson><GSTRegNo>%@</GSTRegNo><GSTRegDate>%@</GSTRegDate><GSTExempted>%@</GSTExempted>",
//     [[DataDictionary objectForKey:@"GSTInfo"]objectForKey:@"GSTRegPerson"],
//     [[DataDictionary objectForKey:@"GSTInfo"]objectForKey:@"GSTRegNo"],
//     [[DataDictionary objectForKey:@"GSTInfo"]objectForKey:@"GSTRegDate"],
//     [[DataDictionary objectForKey:@"GSTInfo"]objectForKey:@"GSTExempted"]],
//    
//    [CreditCardInfoXML appendFormat:@"</GSTInfo>"];
//    return CreditCardInfoXML;
//}


-(id)getFTCreditCardInfo:(NSDictionary*)DataDictionary
{
    
    
    
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *FTCreditCardInfoXML = [NSMutableString string];
    [FTCreditCardInfoXML setString:@""];
    if([FTCreditCardInfoXML isEqualToString:@"(null)"]){
      [FTCreditCardInfoXML setString:@""];  
    }
    [FTCreditCardInfoXML appendFormat:@"<FTPCreditCardInfo><CardMemberAccountNo>%@</CardMemberAccountNo><CardExpiredDate>%@</CardExpiredDate><CardMemberName>%@</CardMemberName><CardMemberSex>%@</CardMemberSex><CardMemberOtherIDType>%@</CardMemberOtherIDType><CardMemberOtherID>%@</CardMemberOtherID><CardMemberDOB>%@</CardMemberDOB><CardMemberNewICNo>%@</CardMemberNewICNo><CardMemberContactNo>%@</CardMemberContactNo><CardMemberRelationship>%@</CardMemberRelationship><CreditCardType>%@</CreditCardType><CreditCardBank>%@</CreditCardBank>",
     
     [[DataDictionary objectForKey:@"proposalFTCreditCardInfo"]objectForKey:@"FTCardMemberAccountNo"],
     [[DataDictionary objectForKey:@"proposalFTCreditCardInfo"]objectForKey:@"FTCardExpiredDate"],
     [[DataDictionary objectForKey:@"proposalFTCreditCardInfo"]objectForKey:@"FTCardMemberName"],
     [[DataDictionary objectForKey:@"proposalFTCreditCardInfo"]objectForKey:@"FTCardMemberSex"],
     [[DataDictionary objectForKey:@"proposalFTCreditCardInfo"]objectForKey:@"FTCardMemberOtherIDType"],
     [[DataDictionary objectForKey:@"proposalFTCreditCardInfo"]objectForKey:@"FTCardMemberOtherID"],
     [[DataDictionary objectForKey:@"proposalFTCreditCardInfo"]objectForKey:@"FTCardMemberDOB"],
     [[DataDictionary objectForKey:@"proposalFTCreditCardInfo"]objectForKey:@"FTCardMemberNewICNo"],
     [[DataDictionary objectForKey:@"proposalFTCreditCardInfo"]objectForKey:@"FTCardMemberContactNo"],
     [[DataDictionary objectForKey:@"proposalFTCreditCardInfo"]objectForKey:@"FTCardMemberRelationship"],
     [[DataDictionary objectForKey:@"proposalFTCreditCardInfo"]objectForKey:@"FTCreditCardType"],
     [[DataDictionary objectForKey:@"proposalFTCreditCardInfo"]objectForKey:@"FTCreditCardBank"]];
    [FTCreditCardInfoXML appendFormat:@"</FTPCreditCardInfo>"];
    
    if([FTCreditCardInfoXML isEqualToString:@"(null)"]){
        [FTCreditCardInfoXML setString:@""];
    }
    return FTCreditCardInfoXML;
}

-(id)getPaymentInfo:(NSDictionary*)DataDictionary
{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *PaymentInfoXML = [NSMutableString string];
    
    [PaymentInfoXML appendFormat:@"<PaymentInfo><FirstTimePayment>%@</FirstTimePayment><PaymentMode>%@</PaymentMode><PaymentMethod>%@</PaymentMethod><TotalModalPremium>%@</TotalModalPremium><PaymentFinalAcceptance>%@</PaymentFinalAcceptance><EPP>%@</EPP>",
     [[DataDictionary objectForKey:@"proposalPaymentInfo"]objectForKey:@"FirstTimePayment"],
     [[DataDictionary objectForKey:@"proposalPaymentInfo"]objectForKey:@"PaymentMode"],
     [[DataDictionary objectForKey:@"proposalPaymentInfo"]objectForKey:@"PaymentMethod"],
     [[DataDictionary objectForKey:@"proposalPaymentInfo"]objectForKey:@"TotalModalPremium"],
     
     [[DataDictionary objectForKey:@"proposalPaymentInfo"]objectForKey:@"PaymentFinalAcceptance"],
     [[DataDictionary objectForKey:@"proposalFTCreditCardInfo"]objectForKey:@"FTEPP"]];
    id eventsArray = [DataDictionary objectForKey:@"proposalPaymentInfo"];
    [PaymentInfoXML appendFormat:@"</PaymentInfo>"];
    return PaymentInfoXML;
    
}

-(id)getTrusteeInfo:(NSDictionary*)DataDictionary
{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    
    if ([[[DataDictionary objectForKey:@"proposalTrusteeInfo"]objectForKey:@"TrusteeCount"]intValue] ) {
        
        
        NSMutableString *TrusteeInfoXML = [NSMutableString string];
        [TrusteeInfoXML appendFormat:@"<TrusteeInfo><TrusteeCount>%@</TrusteeCount>",[[DataDictionary objectForKey:@"proposalTrusteeInfo"]objectForKey:@"TrusteeCount"]];
        NSInteger TrusteeCount = [[[DataDictionary objectForKey:@"proposalTrusteeInfo"]objectForKey:@"TrusteeCount"]integerValue];
        for(int i=1;i<TrusteeCount+1;i++)
        {
            NSString* trustString=[NSString stringWithFormat:@"Trustee ID = %i",i];
            // NSLog(@"***result=%@",trustString);
            // NSLog(@"***result=%@",[[DataDictionary objectForKey:@"proposalTrusteeInfo"]objectForKey:[NSString stringWithFormat:@"Trustee ID= \"%d\"",i]]);
            // NSLog(@"***result=%@",[[DataDictionary objectForKey:@"proposalTrusteeInfo"]objectForKey:[NSString stringWithFormat:@"%@",trustString]]);
            // NSLog(@"***result=%@",[[DataDictionary objectForKey:@"proposalTrusteeInfo"]objectForKey:[NSString stringWithFormat:@"Trustee ID = 1"]]);
            
            [TrusteeInfoXML appendFormat:@"<Trustee ID=\"%d\"><Seq>%@</Seq><TrusteeTitle>%@</TrusteeTitle><TrusteeName>%@</TrusteeName><TrusteeRelationship>%@</TrusteeRelationship><TrusteeSex>%@</TrusteeSex><TrusteeDOB>%@</TrusteeDOB>",i,
             [[[DataDictionary objectForKey:@"proposalTrusteeInfo"]objectForKey:[NSString stringWithFormat:@"Trustee ID = %i",i]]objectForKey:@"Seq"],
             [[[DataDictionary objectForKey:@"proposalTrusteeInfo"]objectForKey:[NSString stringWithFormat:@"Trustee ID = %i",i]]objectForKey:@"TrusteeTitle"],
             [[[DataDictionary objectForKey:@"proposalTrusteeInfo"]objectForKey:[NSString stringWithFormat:@"Trustee ID = %i",i]]objectForKey:@"TrusteeName"],
             [[[DataDictionary objectForKey:@"proposalTrusteeInfo"]objectForKey:[NSString stringWithFormat:@"Trustee ID = %i",i]]objectForKey:@"TrusteeRelationship"],
             [[[DataDictionary objectForKey:@"proposalTrusteeInfo"]objectForKey:[NSString stringWithFormat:@"Trustee ID = %i",i]]objectForKey:@"TrusteeSex"],
             [[[DataDictionary objectForKey:@"proposalTrusteeInfo"]objectForKey:[NSString stringWithFormat:@"Trustee ID = %i",i]]objectForKey:@"TrusteeDOB"]];
            
            id eventsArray = [[[DataDictionary objectForKey:@"proposalTrusteeInfo"]objectForKey:[NSString stringWithFormat:@"Trustee ID = %i",i]]objectForKey:@"TRNewIC"];
            [TrusteeInfoXML appendFormat:@"<TRNewIC>%@</TRNewIC>",[self parserNSDictionarytoXML:eventsArray]];
            eventsArray = [[[DataDictionary objectForKey:@"proposalTrusteeInfo"]objectForKey:[NSString stringWithFormat:@"Trustee ID = %i",i]]objectForKey:@"TROtherID"];
            [TrusteeInfoXML appendFormat:@"<TROtherID>%@</TROtherID>",[self parserNSDictionarytoXML:eventsArray]];
            eventsArray = [[[DataDictionary objectForKey:@"proposalTrusteeInfo"]objectForKey:[NSString stringWithFormat:@"Trustee ID = %i",i]]objectForKey:@"TrusteeAddr"];
            [TrusteeInfoXML appendFormat:@"<TrusteeAddr>"];
            [TrusteeInfoXML appendFormat:@"<AddressCode>%@</AddressCode>",[eventsArray objectForKey:@"AddressCode"]];
            [TrusteeInfoXML appendFormat:@"<Address1><![CDATA[%@]]></Address1>",[eventsArray objectForKey:@"Address1"]];
            [TrusteeInfoXML appendFormat:@"<Address2><![CDATA[%@]]></Address2>",[eventsArray objectForKey:@"Address2"]];
            [TrusteeInfoXML appendFormat:@"<Address3><![CDATA[%@]]></Address3>",[eventsArray objectForKey:@"Address3"]];
            [TrusteeInfoXML appendFormat:@"<Town><![CDATA[%@]]></Town>",[eventsArray objectForKey:@"Town"]];
            [TrusteeInfoXML appendFormat:@"<State><![CDATA[%@]]></State>",[eventsArray objectForKey:@"State"]];
            [TrusteeInfoXML appendFormat:@"<Postcode>%@</Postcode>",[eventsArray objectForKey:@"Postcode"]];
            [TrusteeInfoXML appendFormat:@"<Country><![CDATA[%@]]></Country>",[eventsArray objectForKey:@"Country"]];
            [TrusteeInfoXML appendFormat:@"<ForeignAddress>%@</ForeignAddress>",[eventsArray objectForKey:@"ForeignAddress"]];
            [TrusteeInfoXML appendFormat:@"<AddressSameAsPO>%@</AddressSameAsPO>",[eventsArray objectForKey:@"AddressSameAsPO"]];
            [TrusteeInfoXML appendFormat:@"</TrusteeAddr>"];
            [TrusteeInfoXML appendFormat:@"</Trustee>"];
            
        }
        
        [TrusteeInfoXML appendFormat:@"</TrusteeInfo>"];
        return TrusteeInfoXML;
    }
    else
        return @"";
}

//    NSMutableString *TrusteeInfoXML = [NSMutableString string];
//    if([[[DataDictionary objectForKey:@"proposalTrusteeInfo"]objectForKey:@"TrusteeCount"] intValue]>0)
//    {
//
//        [TrusteeInfoXML appendFormat:@"<NomineeInfo><TrusteeCount>%@</TrusteeCount>",[[DataDictionary objectForKey:@"proposalNomineeInfo"]objectForKey:@"TrusteeCount"]];
//
//        NSInteger TrusteeCount = [[[DataDictionary objectForKey:@"proposalNomineeInfo"]objectForKey:@"TrusteeCount"]integerValue];
//        for(int i=0;i<TrusteeCount;i++)
//        {
//
//
//            id NomineeDictionary=[[DataDictionary objectForKey:@"proposalNomineeInfo"] objectForKey:[NSString stringWithFormat:@"Trustee ID = \"%d\"",i+1]];
//            [TrusteeInfoXML appendFormat:[NSString stringWithFormat:@"<Trustee ID=\"%d\">",i+1] ]
//            ;
//            [TrusteeInfoXML appendFormat:@"<Seq>%@</Seq>",[NomineeDictionary objectForKey:@"Seq"] ];
//            [TrusteeInfoXML appendFormat:@"<TrusteeTitle>%@</TrusteeTitle>",[NomineeDictionary objectForKey:@"TrusteeTitle"] ];
//            [TrusteeInfoXML appendFormat:@"<TrusteeName>%@</TrusteeName>",[NomineeDictionary objectForKey:@"TrusteeName"] ];
//            [TrusteeInfoXML appendFormat:@"<NMShare>%@</NMShare>",[NomineeDictionary objectForKey:@"NMShare"] ];
//            [TrusteeInfoXML appendFormat:@"<NMDOB>%@</NMDOB>",[NomineeDictionary objectForKey:@"NMDOB"] ];
//
//            [TrusteeInfoXML appendFormat:@"<NMSex>%@</NMSex>",[NomineeDictionary objectForKey:@"NMSex"] ];
//            [TrusteeInfoXML appendFormat:@"<NMRelationship>%@</NMRelationship>",[NomineeDictionary objectForKey:@"NMRelationship"] ];
//            [TrusteeInfoXML appendFormat:@"<NMSamePOAddress>%@</NMSamePOAddress>",[NomineeDictionary objectForKey:@"NMSamePOAddress"] ];
//            [TrusteeInfoXML appendFormat:@"<NMTrustStatus>%@</NMTrustStatus>",[NomineeDictionary objectForKey:@"NMTrustStatus"] ];
//            [TrusteeInfoXML appendFormat:@"<NMChildAlive>%@</NMChildAlive>",[NomineeDictionary objectForKey:@"NMChildAlive"] ];
//
//
//            [TrusteeInfoXML appendFormat:[NSString stringWithFormat:@"<NMNewIC><NMNewICCode>%@</NMNewICCode><NMNewICNo>%@</NMNewICNo></NMNewIC> <NMOtherID><NMOtherIDType>%@</NMOtherIDType><NMOtherID>%@</NMOtherID></NMOtherID>",[[NomineeDictionary objectForKey:@"NMNewIC"] objectForKey:@"NMNewICCode"],[[NomineeDictionary objectForKey:@"NMNewIC"] objectForKey:@"NMNewICNo"],[[NomineeDictionary objectForKey:@"NMOtherID"] objectForKey:@"NMOtherIDType"],[[NomineeDictionary objectForKey:@"NMOtherID"] objectForKey:@"NMOtherID"]]];
//
//
//
//            [TrusteeInfoXML appendFormat:[NSString stringWithFormat:@"<NMAddr><AddressCode>%@</AddressCode><Address1>%@</Address1><Address2>%@</Address2><Address3>%@</Address3><Town>%@</Town><State>%@</State><Postcode>%@</Postcode><Country>%@</Country><ForeignAddress>%@</ForeignAddress><AddressSameAsPO>%@</AddressSameAsPO></NMAddr> ",[[NomineeDictionary objectForKey:@"NMAddr"] objectForKey:@"AddressCode"],[[NomineeDictionary objectForKey:@"NMAddr"] objectForKey:@"Address1"],[[NomineeDictionary objectForKey:@"NMAddr"] objectForKey:@"Address2"],[[NomineeDictionary objectForKey:@"NMAddr"] objectForKey:@"Address3"],[[NomineeDictionary objectForKey:@"NMAddr"] objectForKey:@"Town"],[[NomineeDictionary objectForKey:@"NMAddr"] objectForKey:@"State"],[[NomineeDictionary objectForKey:@"NMAddr"] objectForKey:@"Postcode"],[[NomineeDictionary objectForKey:@"NMAddr"] objectForKey:@"Country"],[[NomineeDictionary objectForKey:@"NMAddr"] objectForKey:@"ForeignAddress"],[[NomineeDictionary objectForKey:@"NMAddr"] objectForKey:@"AddressSameAsPO"]]];
//
//
//            [TrusteeInfoXML appendFormat:@"</Nominee>"];
//        }
//
//        [TrusteeInfoXML appendFormat:@"</NomineeInfo>"];
//    }
//    return TrusteeInfoXML;

//}


-(id)getExistingPolInfo:(NSDictionary*)DataDictionary
{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *ExistingPolInfoXML = [NSMutableString string];
    NSInteger ExistingPolCount = [[[DataDictionary objectForKey:@"policyExistingLifePolicies"]objectForKey:@"ExistingPolCount"]integerValue];
    
    if ([[DataDictionary objectForKey:@"policyExistingLifePolicies"]objectForKey:@"ExistingPolCount"]==0 ) {
        ExistingPolCount=0;
    }
    
    
    [ExistingPolInfoXML appendFormat:@"<ExistingPolInfo><ExistingPolCount>%i</ExistingPolCount>",ExistingPolCount];
        for(int i=1;i<ExistingPolCount+1;i++)
        {
            [ExistingPolInfoXML appendFormat:@"<ExistingPol ID=\"%d\"><PTypeCode>%@</PTypeCode><Seq>%@</Seq><PTypeCodeDesc>%@</PTypeCodeDesc><ExistingPolDetailsCount>%@</ExistingPolDetailsCount>",i,
             [[[DataDictionary objectForKey:@"policyExistingLifePolicies"]objectForKey:[NSString stringWithFormat:@"ExistingPol ID=\"%d\"",i]]objectForKey:@"PTypeCode"],
             [[[DataDictionary objectForKey:@"policyExistingLifePolicies"]objectForKey:[NSString stringWithFormat:@"ExistingPol ID=\"%d\"",i]]objectForKey:@"Seq"],
             [[[DataDictionary objectForKey:@"policyExistingLifePolicies"]objectForKey:[NSString stringWithFormat:@"ExistingPol ID=\"%d\"",i]]objectForKey:@"PTypeCodeDesc"],
             [[[DataDictionary objectForKey:@"policyExistingLifePolicies"]objectForKey:[NSString stringWithFormat:@"ExistingPol ID=\"%d\"",i]]objectForKey:@"ExistingPolDetailsCount"]];
            
            
            NSInteger ExistingPolDetailsCount = [[[[DataDictionary objectForKey:@"policyExistingLifePolicies"]objectForKey:[NSString stringWithFormat:@"ExistingPol ID=\"%d\"",i]]objectForKey:@"ExistingPolDetailsCount"]integerValue];
            for(int j=1;j<ExistingPolDetailsCount+1;j++)
            {
                id eventsArray = [[[DataDictionary objectForKey:@"policyExistingLifePolicies"]objectForKey:[NSString stringWithFormat:@"ExistingPol ID=\"%d\"",i]]objectForKey:[NSString stringWithFormat:@"ExistingPolDetails ID=\"%d\"",j]];
                
                [ExistingPolInfoXML appendFormat:@"<ExistingPolDetails ID=\"%d\">",j];
                [ExistingPolInfoXML appendFormat:@"<ExtPolCompany>%@</ExtPolCompany>",[eventsArray objectForKey:@"ExtPolCompany"]];
                [ExistingPolInfoXML appendFormat:@"<ExtPolLife>%@</ExtPolLife>",[eventsArray objectForKey:@"ExtPolLife"]];
                [ExistingPolInfoXML appendFormat:@"<ExtPolPA>%@</ExtPolPA>",[eventsArray objectForKey:@"ExtPolPA"]];
                [ExistingPolInfoXML appendFormat:@"<ExtPolHI>%@</ExtPolHI>",[eventsArray objectForKey:@"ExtPolHI"]];
                [ExistingPolInfoXML appendFormat:@"<ExtPolCI>%@</ExtPolCI>",[eventsArray objectForKey:@"ExtPolCI"]];
                [ExistingPolInfoXML appendFormat:@"<ExtPolDateIssued>%@</ExtPolDateIssued>",[eventsArray objectForKey:@"ExtPolDateIssued"]];
                [ExistingPolInfoXML appendFormat:@"<iExtPolLA>%@</iExtPolLA>",[eventsArray objectForKey:@"ExtPolLA"]];                
                [ExistingPolInfoXML appendFormat:@"</ExistingPolDetails>"];
            }
            
            [ExistingPolInfoXML appendFormat:@"</ExistingPol>"];
        }
        [ExistingPolInfoXML appendFormat:@"<ExistingPolAns1>%@</ExistingPolAns1>",[[DataDictionary objectForKey:@"policyExistingLifePolicies"]objectForKey:@"ExistingPolQues_1"]];
        [ExistingPolInfoXML appendFormat:@"<ExistingPolAns2>%@</ExistingPolAns2>",[[DataDictionary objectForKey:@"policyExistingLifePolicies"]objectForKey:@"ExistingPolQues_1a"]];
        [ExistingPolInfoXML appendFormat:@"<ExistingPolAns3a>%@</ExistingPolAns3a>",[[DataDictionary objectForKey:@"policyExistingLifePolicies"]objectForKey:@"ExistingPolQues_2"]];
        [ExistingPolInfoXML appendFormat:@"<ExistingPolAns3b>%@</ExistingPolAns3b>",[[DataDictionary objectForKey:@"policyExistingLifePolicies"]objectForKey:@"ExistingPolQues_3"]];
        [ExistingPolInfoXML appendFormat:@"<ExistingPolAns3c>%@</ExistingPolAns3c>",[[DataDictionary objectForKey:@"policyExistingLifePolicies"]objectForKey:@"ExistingPolQues_4"]];
        [ExistingPolInfoXML appendFormat:@"<ExistingPolAns3d>%@</ExistingPolAns3d>",[[DataDictionary objectForKey:@"policyExistingLifePolicies"]objectForKey:@"ExistingPolQues_5"]];

        
        [ExistingPolInfoXML appendFormat:@"</ExistingPolInfo>"];
        return ExistingPolInfoXML;
//    }
//    else
//        return @"";
}


-(id)getQuestionaireInfo:(NSDictionary*)DataDictionary
{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *QuestionaireInfoXML = [NSMutableString string];
    
    if( [[DataDictionary objectForKey:@"proposalQuestionairies"]  count])
    {
        [QuestionaireInfoXML appendFormat:@"<QuestionaireInfo><QuestionaireCount>%d</QuestionaireCount>",[[DataDictionary objectForKey:@"proposalQuestionairies"] count]];
        // NSLog(@"count=%i",[[DataDictionary objectForKey:@"proposalQuestionairies"]  count]);
        
        
        //  NSInteger QuestionaireCount = [[[[DataDictionary objectForKey:@"proposalQuestionairies"] objectAtIndex:0] objectForKey:@"QuestionaireCount"]integerValue];
        
        for(int i=0;i<[[DataDictionary objectForKey:@"proposalQuestionairies"]  count];i++)
        {
            
            
            /*Open this if you get dynamic  Questionaire ID from datadictionary     */
            //NSString *newQuestionairiesID=[NSString stringWithFormat:@"Questionaire ID=\"%i\"",i+1];
            
            
            //use for static
            NSString *newQuestionairiesID=[NSString stringWithFormat:@"Questionaire ID=\"1\""];
            
            //NSString *strQuestionairiesID=[NSString stringWithFormat:@"Questionaire ID=%@",[[[DataDictionary objectForKey:@"proposalQuestionairies"] objectAtIndex:i] objectForKey:@"Questionaire ID"]];
            
            // NSLog(@"ques id=%@",newQuestionairiesID);
            // NSString *strQID=[NSString stringWithFormat:@"Questionaire ID=\"%d\"",j];
            id eventsArray = [[[DataDictionary objectForKey:@"proposalQuestionairies"] objectAtIndex:i]
                              objectForKey:newQuestionairiesID];
            //  NSString *strQuestionairiesID=[NSString stringWithFormat:@"Questionaire ID=\"%@\"",[[[DataDictionary objectForKey:@"proposalQuestionairies"] objectAtIndex:i] objectForKey:@"Questionaire ID"]];
            
            
            //[QuestionaireInfoXML appendFormat:@"<Questionaire ID=%@><PTypeCode>%@</PTypeCode><Seq>%@</Seq><Height>%@</Height><Weight>%@</Weight>",[[[DataDictionary objectForKey:@"proposalQuestionairies"] objectAtIndex:i] objectForKey:@"Questionaire ID"],
            
            
            //[QuestionaireInfoXML appendFormat:@"<Questionaire ID=\"%d\"><PTypeCode>%@</PTypeCode><Seq>%@</Seq><Height>%@</Height><Weight>%@</Weight>",[[[[DataDictionary objectForKey:@"proposalQuestionairies"] objectAtIndex:i] objectForKey:@"Questionaire ID"] intValue],
            NSString*    dummynewQuestionairiesID=[NSString stringWithFormat:@"Questionaire ID=\"%d\"",i+1];
            ;
            [QuestionaireInfoXML appendFormat:@"<%@><PTypeCode>%@</PTypeCode><Seq>%@</Seq><Height>%@</Height><Weight>%@</Weight>",dummynewQuestionairiesID,
             [eventsArray objectForKey:@"PTypeCode"],
             [eventsArray objectForKey:@"Seq"],
             [eventsArray objectForKey:@"Height"],
             [eventsArray objectForKey:@"Weight"]];
            
            for(int j=1;j<26;j++)
            {
                
                //"
                NSString *strQID=[NSString stringWithFormat:@"Questions ID=\"%d\"",j];
                id eventsArray = [[[[DataDictionary objectForKey:@"proposalQuestionairies"] objectAtIndex:i]
                                   objectForKey:newQuestionairiesID] objectForKey:strQID];
                
                [QuestionaireInfoXML appendFormat:@"<Questions ID=\"%@\">",[NSString stringWithFormat:@"%d",j]];
                
                
                [QuestionaireInfoXML appendFormat:@"<QnID>%@</QnID>",[eventsArray objectForKey:@"QnID"]];
                [QuestionaireInfoXML appendFormat:@"<QnParty>%@</QnParty>",[eventsArray objectForKey:@"QnParty"]];
                [QuestionaireInfoXML appendFormat:@"<AnswerType>%@</AnswerType>",[eventsArray objectForKey:@"AnswerType"]];
                [QuestionaireInfoXML appendFormat:@"<Answer>%@</Answer>",[eventsArray objectForKey:@"Answer"]];
                [QuestionaireInfoXML appendFormat:@"<Reason><![CDATA[%@]]></Reason>",[eventsArray objectForKey:@"Reason"]];
                
                
                
                
                
                
                
                // eventsArray =  [[[DataDictionary objectForKey:@"proposalQuestionairies"] objectAtIndex:i] objectForKey:@"Reason"];
                
                // eventsArray =  [[[DataDictionary objectForKey:@"AssuredInfo"] objectAtIndex:i] objectForKey:@"LAOtherID"];
                
                //  [AssuredInfoXML appendFormat:@"<LAOtherID>%@</LAOtherID>",[self parserNSDictionarytoXML:eventsArray]];
                
                [QuestionaireInfoXML appendFormat:@"</Questions>"];
            }
            
            
            [QuestionaireInfoXML appendFormat:@"</Questionaire>"];
        }
        [QuestionaireInfoXML appendFormat:@"</QuestionaireInfo>"];
        return QuestionaireInfoXML;
    }
    else
        return @"";
    
}

-(id)getAdditionalQuestionaireInfo:(NSDictionary*)DataDictionary

{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *AddtionalQInfo = [NSMutableString string];
    
    [AddtionalQInfo appendFormat:@"<AddQuesInfo>"];
    
    NSString *newQuestionairiesID=[NSString stringWithFormat:@"AddQuesID = \"1\""];
    
    id eventsArray = [[DataDictionary objectForKey:@"propoalAddQuesInfo"] objectForKey:newQuestionairiesID];
    
    if ([[eventsArray objectForKey:@"AddQuesName"] length]==0) {
        return @"";
    }
    [AddtionalQInfo appendFormat:@"<AddQues ID =\"1\">"];
    
    [AddtionalQInfo appendFormat:@"<AddQuesName>%@</AddQuesName>",[eventsArray objectForKey:@"AddQuesName"]];
    
    [AddtionalQInfo appendFormat:@"<AddQuesMthlyIncome>%@</AddQuesMthlyIncome>",[eventsArray objectForKey:@"AddQuesMthlyIncome"]];
    
    [AddtionalQInfo appendFormat:@"<AddQuesOccpCode>%@</AddQuesOccpCode>",[eventsArray objectForKey:@"AddQuesOccpCode"]];
    
    [AddtionalQInfo appendFormat:@"<AddQuesInsured>%@</AddQuesInsured>",[eventsArray objectForKey:@"AddQuesInsured"]];
    
    [AddtionalQInfo appendFormat:@"<AddQuesReason><![CDATA[%@]]></AddQuesReason>",[eventsArray objectForKey:@"AddQuesReason"]];
    
    [AddtionalQInfo appendFormat:@"</AddQues>"];
    
    [AddtionalQInfo appendFormat:@"</AddQuesInfo>"];
    
    
    // [AddtionalQInfo appendFormat:@"<AddQuesDetailsCount>%i</AddQuesDetailsCount>",[[DataDictionary objectForKey:@"proposalAddQuesDetails"]  count]];
    
    [AddtionalQInfo appendFormat:@"<AddQuesDetailsInfo>"];
    [AddtionalQInfo appendFormat:@"<AddQuesDetailsCount>%i</AddQuesDetailsCount>",[[DataDictionary objectForKey:@"proposalAddQuesDetails"]  count]];
    
    for(int i=0;i<[[DataDictionary objectForKey:@"proposalAddQuesDetails"]  count];i++)
        
    {
        
		//[AddtionalQInfo appendFormat:@"<AddQuesDetailsCount>%i</AddQuesDetailsCount>",[[DataDictionary objectForKey:@"proposalAddQuesDetails"]  count]];
        NSString *strQID=[NSString stringWithFormat:@"AddQuesDetails ID = \"%d\"",i+1];
        
        
        id eventsArray=[[[DataDictionary objectForKey:@"proposalAddQuesDetails"] objectAtIndex:i]
                        
                        objectForKey:strQID];
        [AddtionalQInfo appendFormat:@"<AddQuesDetails ID =\"%d\">",i+1];
        
        [AddtionalQInfo appendFormat:@"<AddQuesCompany>%@</AddQuesCompany>",[eventsArray objectForKey:@"AddQuesCompany"]];
        
        [AddtionalQInfo appendFormat:@"<AddQuesAmountInsured>%@</AddQuesAmountInsured>",[eventsArray objectForKey:@"AddQuesAmountInsured"]];
        
        [AddtionalQInfo appendFormat:@"<AddQuesLifeAccidentDisease>%@</AddQuesLifeAccidentDisease>",[eventsArray objectForKey:@"AddQuesLifeAccidentDisease"]];
        
        [AddtionalQInfo appendFormat:@"<AddQuesYrIssued>%@</AddQuesYrIssued>",[eventsArray objectForKey:@"AddQuesYrIssued"]];
        
        [AddtionalQInfo appendFormat:@"</AddQuesDetails>"];
        
    }
    [AddtionalQInfo appendFormat:@"</AddQuesDetailsInfo>"];
    
    
    //    [AddtionalQInfo appendFormat:@"</AddQuesInfo>"];
    
    
    return AddtionalQInfo;
    
}
//Additional quest

-(id)getAdditionalQuestionaireInfo1:(NSDictionary*)DataDictionary

{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *AddtionalQInfo = [NSMutableString string];
    
    [AddtionalQInfo appendFormat:@"<AddQuesInfo>"];
    
    NSString *newQuestionairiesID=[NSString stringWithFormat:@"AddQuesID = \"1\""];
    
    id eventsArray = [[DataDictionary objectForKey:@"propoalAddQuesInfo"] objectForKey:newQuestionairiesID];
    
    if ([[eventsArray objectForKey:@"AddQuesName"] length]==0) {
        return @"";
    }
    [AddtionalQInfo appendFormat:@"<AddQues ID =\"1\">"];
    
    [AddtionalQInfo appendFormat:@"<AddQuesName>%@</AddQuesName>",[eventsArray objectForKey:@"AddQuesName"]];
    
    [AddtionalQInfo appendFormat:@"<AddQuesMthlyIncome>%@</AddQuesMthlyIncome>",[eventsArray objectForKey:@"AddQuesMthlyIncome"]];
    
    [AddtionalQInfo appendFormat:@"<AddQuesOccpCode>%@</AddQuesOccpCode>",[eventsArray objectForKey:@"AddQuesOccpCode"]];
    
    [AddtionalQInfo appendFormat:@"<AddQuesInsured>%@</AddQuesInsured>",[eventsArray objectForKey:@"AddQuesInsured"]];
    
    [AddtionalQInfo appendFormat:@"<AddQuesReason><![CDATA[%@]]></AddQuesReason>",[eventsArray objectForKey:@"AddQuesReason"]];
    
    [AddtionalQInfo appendFormat:@"</AddQues>"];
    
    [AddtionalQInfo appendFormat:@"</AddQuesInfo>"];
    
    
    return AddtionalQInfo;
    
}

-(id)getAdditionalQuestionaireDetailsInfo:(NSDictionary*)DataDictionary

{
    
    
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *AddtionalQInfo = [NSMutableString string];
    
    [AddtionalQInfo appendFormat:@"<AddQuesDetailsInfo>"];
    
    for(int i=0;i<[[DataDictionary objectForKey:@"proposalAddQuesDetails"]  count];i++)
        
    {
        
        NSString *strQID=[NSString stringWithFormat:@"AddQuesDetails ID = \"%d\"",i+1];
        
        // NSLog(@"%@",[[[DataDictionary objectForKey:@"proposalAddQuesDetails"] objectAtIndex:i]
        
        //bjectForKey:strQID]);
        id eventsArray=[[[DataDictionary objectForKey:@"proposalAddQuesDetails"] objectAtIndex:i]
                        
                        objectForKey:strQID];
        
        
        [AddtionalQInfo appendFormat:@"<AddQuesDetails ID =\"%d\">",i+1];
        
        [AddtionalQInfo appendFormat:@"<AddQuesCompany>%@</AddQuesCompany>",[eventsArray objectForKey:@"AddQuesCompany"]];
        
        [AddtionalQInfo appendFormat:@"<AddQuesAmountInsured>%@</AddQuesAmountInsured>",[eventsArray objectForKey:@"AddQuesAmountInsured"]];
        
        [AddtionalQInfo appendFormat:@"<AddQuesLifeAccidentDisease>%@</AddQuesLifeAccidentDisease>",[eventsArray objectForKey:@"AddQuesLifeAccidentDisease"]];
        
        [AddtionalQInfo appendFormat:@"<AddQuesYrIssued>%@</AddQuesYrIssued>",[eventsArray objectForKey:@"AddQuesYrIssued"]];
        
        
        
        [AddtionalQInfo appendFormat:@"</AddQuesDetails>"];
        
    }
    
    [AddtionalQInfo appendFormat:@"</AddQuesDetailsInfo>"];
    
    
    
    return AddtionalQInfo;
    
}

-(id)getDividendInfo:(NSDictionary*)DataDictionary
{
    obj = [DataClass getInstance];
    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath1 = [paths1 objectAtIndex:0];
    NSString *path1 = [docsPath1 stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database1 = [FMDatabase databaseWithPath:path1];
    [database1 open];
    NSString *PolicyType;
    NSString *ridercode;
    NSString *sino = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
    NSString *eproposalNo =  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    NSString *BasicPlanCode = @"";
    NSString *payeeType;
    if(ridercode==NULL|| nil)
        ridercode = @"";
    if(BasicPlanCode==NULL||nil)
        BasicPlanCode = @"";
    if(PolicyType==NULL|| nil)
        PolicyType = @"";
    
    
    NSString *selectPO = [NSString stringWithFormat:@"select PTypeCode, LANewICNo, LAOtherIDType, LAOtherID, MobilePhoneNo,MobilePhoneNoPrefix, EmailAddress FROM eProposal_LA_Details WHERE eProposalNo = '%@'",eproposalNo];
    
       
    FMResultSet *results8;
    results8 = [database1 executeQuery:selectPO];
    
    NSMutableArray *LifeAssure1st = [[NSMutableArray alloc]init];
    while ([results8 next])
    {
        payeeType = [results8 objectForColumnName:@"PTypeCode"];
        
        [LifeAssure1st addObject:payeeType];
        
        NSLog(@"payeeType2 %@",payeeType);
        
        
    }
    
    
    
    
    
    FMResultSet *results3;
     results3 = [database1 executeQuery:@"SELECT BasicPlanCode from eProposal WHERE eProposalNo = ?",eproposalNo];
      while ([results3 next]) {
             
                BasicPlanCode = [results3 stringForColumn:@"BasicPlanCode"];
        
            }

    
    results3 = [database1 executeQuery:@"SELECT Ridercode, PTypecode FROM TRAD_Rider_Details WHERE RiderCode in ('WBD10R30', 'WB30R','WBI6R30','EDUWR','WB50R') "
                "AND SINO = ?",sino];

    
 //   NSMutableArray *LifeAssure1stRider = [[NSMutableArray alloc]init];

    
       
       while ([results3 next])
       {
         PolicyType = [results3 stringForColumn:@"PTypeCode"];
        ridercode = [results3 stringForColumn:@"RiderCode"];
      //     [LifeAssure1stRider addObject:ridercode];

           
           
       }
       [database1 close];
    
    
  //  NSString *test =[LifeAssure1st objectAtIndex:0];
    
 //   NSString *RiderLA1;

    
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *DividendInfoXML = [NSMutableString string];
    
    [DividendInfoXML appendFormat:@"<DividendInfo>"];
    
     if (ridercode && [PolicyType isEqualToString:@"LA"])
    {
        
    }
    
    else
        
    {
       // RiderLA1 =[LifeAssure1stRider objectAtIndex:0];
        
         [DividendInfoXML appendFormat:@"<CashPaymentOption></CashPaymentOption>"];
        
    }

    
    
    if (ridercode && [PolicyType isEqualToString:@"LA"])
    {
        
        if([BasicPlanCode isEqualToString:@"HLAWP"] && [PolicyType isEqualToString:@"LA"] && ([ridercode isEqualToString:@"WBD10R30"]||[ridercode isEqualToString:@"WB30R"]||[ridercode isEqualToString:@"WBI6R30"]||[ridercode isEqualToString:@"EDUWR"] ||[ridercode isEqualToString:@"WB50R"]))
            
            
        {
            
            [DividendInfoXML appendFormat:@"<CashPaymentOption>%@</CashPaymentOption>",[[DataDictionary objectForKey:@"proposalDividenInfo"]objectForKey:@"CashPaymentOption"]];
        }
        
        else
        {
            [DividendInfoXML appendFormat:@"<CashPaymentOption></CashPaymentOption>"];
            
        }
        
    }
    
    [DividendInfoXML appendFormat:@"<CashDividendOption>%@</CashDividendOption>",[[DataDictionary objectForKey:@"proposalDividenInfo"]objectForKey:@"CashDividendOption"]];
    
    [DividendInfoXML appendFormat:@"<FullPaidUpOption>%@</FullPaidUpOption>",[[DataDictionary objectForKey:@"proposalDividenInfo"]objectForKey:@"FullPaidUpOption"]];
    [DividendInfoXML appendFormat:@"<FullPaidUpTerm>%@</FullPaidUpTerm>",[[DataDictionary objectForKey:@"proposalDividenInfo"]objectForKey:@"FullPaidUpTerm"]];
    [DividendInfoXML appendFormat:@"<RevisedSA>%@</RevisedSA>",[[DataDictionary objectForKey:@"proposalDividenInfo"]objectForKey:@"RevisedSA"]];
    [DividendInfoXML appendFormat:@"<AmtRevised>%@</AmtRevised>",[[DataDictionary objectForKey:@"proposalDividenInfo"]objectForKey:@"AmtRevised"]];
    [DividendInfoXML appendFormat:@"<ReducePaidUpYear>%@</ReducePaidUpYear>",[[DataDictionary objectForKey:@"proposalDividenInfo"]objectForKey:@"ReducePaidUpYear"]];
    
    [DividendInfoXML appendFormat:@"<ReInvestYI>%@</ReInvestYI>",[[DataDictionary objectForKey:@"proposalDividenInfo"]objectForKey:@"ReInvestYI"]];
    
  
    
    
    if (ridercode && [PolicyType isEqualToString:@"LA"])
    {
        
        if([BasicPlanCode isEqualToString:@"HLAWP"] && [PolicyType isEqualToString:@"LA"] && ([ridercode isEqualToString:@"WBD10R30"]||[ridercode isEqualToString:@"WB30R"]||[ridercode isEqualToString:@"WBI6R30"]||[ridercode isEqualToString:@"EDUWR"] ||[ridercode isEqualToString:@"WB50R"]))
        {
            id eventsArray=[[[DataDictionary objectForKey:@"proposalDividenInfo"]objectForKey:@"CashPaymentOptionType"] objectForKey:@"Options"];
            
            [DividendInfoXML appendFormat:@"<CashPaymentOptionType>"];
            for(int i=0; i<[eventsArray count];i++)
            {
                [DividendInfoXML appendFormat:@"<Options ID = \"%d\">",i+1];
                //                                       },
                [DividendInfoXML appendFormat:@"<OptionType>%@</OptionType>",[[eventsArray objectAtIndex:i] objectForKey:@"OptionType"]];
                
                [DividendInfoXML appendFormat:@"<Percentage>%@</Percentage>",[[eventsArray objectAtIndex:i] objectForKey:@"Percentage"]];
                
                [DividendInfoXML appendFormat:@"</Options>"];
                
            }
            
            [DividendInfoXML appendFormat:@"</CashPaymentOptionType>"];
        }
        
        else
        {
            
        }
    }

    
    
    
    
//    if([BasicPlanCode isEqualToString:@"HLAWP"]  && ([ridercode isEqualToString:@"WP30R"]||[ridercode isEqualToString:@"WP50R"]||[ridercode isEqualToString:@"WPTPD30R"]||[ridercode isEqualToString:@"WPTPD50R"] ||[ridercode isEqualToString:@""]))
//    {
//        
//
// 
//    }
    
//    else
//    {
//    id eventsArray=[[[DataDictionary objectForKey:@"proposalDividenInfo"]objectForKey:@"CashPaymentOptionType"] objectForKey:@"Options"];
//    
//    [DividendInfoXML appendFormat:@"<CashPaymentOptionType>"];
//    for(int i=0; i<[eventsArray count];i++)
//    {
//        [DividendInfoXML appendFormat:@"<Options ID = \"%d\">",i+1];
//        //                                       },
//        [DividendInfoXML appendFormat:@"<OptionType>%@</OptionType>",[[eventsArray objectAtIndex:i] objectForKey:@"OptionType"]];
//        
//        [DividendInfoXML appendFormat:@"<Percentage>%@</Percentage>",[[eventsArray objectAtIndex:i] objectForKey:@"Percentage"]];
//        
//        [DividendInfoXML appendFormat:@"</Options>"];
//        
//    }
//    
//    [DividendInfoXML appendFormat:@"</CashPaymentOptionType>"];
//    }
    [DividendInfoXML appendFormat:@"</DividendInfo>"];
    
    return DividendInfoXML;
    
}

-(id)getContigentInfo:(NSDictionary*)DataDictionary
{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *ContigentInfoXML = [NSMutableString string];
    
    [ContigentInfoXML appendFormat:@"<ContigentInfo><COTitle>%@</COTitle><COName>%@</COName><CODOB>%@</CODOB><COSex>%@</COSex><CORelationship>%@</CORelationship><CONationality>%@</CONationality><COEmployerName>%@</COEmployerName><COOccupation>%@</COOccupation><COExactDuties><![CDATA[%@]]></COExactDuties><COSameAddressPO>%@</COSameAddressPO>",
     
     [[DataDictionary objectForKey:@"proposalCODetails"]objectForKey:@"COTitle"],
     [[DataDictionary objectForKey:@"proposalCODetails"]objectForKey:@"COName"],
     [[DataDictionary objectForKey:@"proposalCODetails"]objectForKey:@"CODOB"],
     [[DataDictionary objectForKey:@"proposalCODetails"]objectForKey:@"COSex"],
     [[DataDictionary objectForKey:@"proposalCODetails"]objectForKey:@"CORelationship"],
     [[DataDictionary objectForKey:@"proposalCODetails"]objectForKey:@"CONationality"],
     [[DataDictionary objectForKey:@"proposalCODetails"]objectForKey:@"COEmployerName"],
     [[DataDictionary objectForKey:@"proposalCODetails"]objectForKey:@"COOccupation"],
     [[DataDictionary objectForKey:@"proposalCODetails"]objectForKey:@"COExactDuties"],     
     [[DataDictionary objectForKey:@"proposalCODetails"]objectForKey:@"COSameAddressPO"]];
    
    id eventsArray = [[DataDictionary objectForKey:@"proposalCODetails"]objectForKey:@"CONewIC"];
    [ContigentInfoXML appendFormat:@"<CONewIC>"];
    [ContigentInfoXML appendFormat:@"<CONewICCode>%@</CONewICCode>",[eventsArray objectForKey:@"CONewICCode"]];
    [ContigentInfoXML appendFormat:@"<CONewICNo>%@</CONewICNo>",[eventsArray objectForKey:@"CONewICNo"]];
    [ContigentInfoXML appendFormat:@"</CONewIC>"];
    
    
    
    eventsArray = [[DataDictionary objectForKey:@"proposalCODetails"]objectForKey:@"COOtherID"];
    [ContigentInfoXML appendFormat:@"<COOtherID>"];
    [ContigentInfoXML appendFormat:@"<COOtherIDType>%@</COOtherIDType>",[eventsArray objectForKey:@"COOtherIDType"]];
    [ContigentInfoXML appendFormat:@"<COOtherID>%@</COOtherID>",[eventsArray objectForKey:@"COOtherID"]];
    [ContigentInfoXML appendFormat:@"</COOtherID>"];
    
    eventsArray = [[DataDictionary objectForKey:@"proposalCODetails"]objectForKey:@"COOtherID"];
    [ContigentInfoXML appendFormat:@"<iCOOtherID>"];
    [ContigentInfoXML appendFormat:@"<iCOOtherIDType>%@</iCOOtherIDType>",[eventsArray objectForKey:@"COOtherIDType"]];
    [ContigentInfoXML appendFormat:@"<iCOOtherIDNo>%@</iCOOtherIDNo>",[eventsArray objectForKey:@"COOtherID"]];
    [ContigentInfoXML appendFormat:@"</iCOOtherID>"];
    
    
    [ContigentInfoXML appendFormat:@"<COAddr><COAddress Type = \"R\"><COAddressCode>%@</COAddressCode><COAddress1><![CDATA[%@]]></COAddress1><COAddress2><![CDATA[%@]]></COAddress2><COAddress3><![CDATA[%@]]></COAddress3><COTown><![CDATA[%@]]></COTown><COState><![CDATA[%@]]></COState><COPostcode>%@</COPostcode><COCountry><![CDATA[%@]]></COCountry><COForeignAddress>%@</COForeignAddress><COCorrespondenceFlag>%@</COCorrespondenceFlag>",
     
     
     [[[DataDictionary objectForKey:@"proposalCODetails"] objectForKey:@"COAddrR"] objectForKey:@"AddressCode"],
     [[[DataDictionary objectForKey:@"proposalCODetails"] objectForKey:@"COAddrR"]objectForKey:@"Address1"],
     [[[DataDictionary objectForKey:@"proposalCODetails"] objectForKey:@"COAddrR"]objectForKey:@"Address2"],
     [[[DataDictionary objectForKey:@"proposalCODetails"] objectForKey:@"COAddrR"] objectForKey:@"Address3"],
     [[[DataDictionary objectForKey:@"proposalCODetails"] objectForKey:@"COAddrR"]objectForKey:@"Town"],
     [[[DataDictionary objectForKey:@"proposalCODetails"] objectForKey:@"COAddrR"]objectForKey:@"State"],
     [[[DataDictionary objectForKey:@"proposalCODetails"] objectForKey:@"COAddrR"]objectForKey:@"Postcode"],
     [[[DataDictionary objectForKey:@"proposalCODetails"] objectForKey:@"COAddrR"]objectForKey:@"Country"],
     [[[DataDictionary objectForKey:@"proposalCODetails"] objectForKey:@"COAddrR"]objectForKey:@"ForeignAddress"],
     [[[DataDictionary objectForKey:@"proposalCODetails"] objectForKey:@"COAddrR"]objectForKey:@"AddressSameAsPO"]];
    
    eventsArray = [[DataDictionary objectForKey:@"proposalCODetails"]objectForKey:@"COAddrR"];
    
    [ContigentInfoXML appendFormat:@"</COAddress>"];
    
    [ContigentInfoXML appendFormat:@"<COAddress Type = \"C\"><COAddressCode>%@</COAddressCode><COAddress1><![CDATA[%@]]></COAddress1><COAddress2><![CDATA[%@]]></COAddress2><COAddress3><![CDATA[%@]]></COAddress3><COTown><![CDATA[%@]]></COTown><COState><![CDATA[%@]]></COState><COPostcode>%@</COPostcode><COCountry><![CDATA[%@]]></COCountry><COForeignAddress>%@</COForeignAddress><COCorrespondenceFlag>%@</COCorrespondenceFlag>",
     
     
     [[[DataDictionary objectForKey:@"proposalCODetails"] objectForKey:@"COAddrC"] objectForKey:@"AddressCode"],
     [[[DataDictionary objectForKey:@"proposalCODetails"] objectForKey:@"COAddrC"]objectForKey:@"Address1"],
     [[[DataDictionary objectForKey:@"proposalCODetails"] objectForKey:@"COAddrC"]objectForKey:@"Address2"],
     [[[DataDictionary objectForKey:@"proposalCODetails"] objectForKey:@"COAddrC"] objectForKey:@"Address3"],
     [[[DataDictionary objectForKey:@"proposalCODetails"] objectForKey:@"COAddrC"]objectForKey:@"Town"],
     [[[DataDictionary objectForKey:@"proposalCODetails"] objectForKey:@"COAddrC"]objectForKey:@"State"],
     [[[DataDictionary objectForKey:@"proposalCODetails"] objectForKey:@"COAddrC"]objectForKey:@"Postcode"],
     [[[DataDictionary objectForKey:@"proposalCODetails"] objectForKey:@"COAddrC"]objectForKey:@"Country"],
     [[[DataDictionary objectForKey:@"proposalCODetails"] objectForKey:@"COAddrC"]objectForKey:@"ForeignAddress"],
     [[[DataDictionary objectForKey:@"proposalCODetails"] objectForKey:@"COAddrC"]objectForKey:@"AddressSameAsPO"]];
    
    eventsArray = [[DataDictionary objectForKey:@"proposalCODetails"]objectForKey:@"COAddrC"];
    
    [ContigentInfoXML appendFormat:@"</COAddress>"];
    [ContigentInfoXML appendFormat:@"</COAddr>"];
    
    
    [ContigentInfoXML appendFormat:@"<COContacts>"];
    
    eventsArray = [[[[DataDictionary objectForKey:@"proposalCODetails"] objectForKey:@"COContacts"] objectAtIndex:0 ]objectForKey:@"Contact Type = \"Residence\""];
    
    [ContigentInfoXML appendFormat:@"<COContact Type=\"Residence\">"];
    [ContigentInfoXML appendFormat:@"<ContactCode>%@</ContactCode>",[eventsArray objectForKey:@"ContactCode"]];
    [ContigentInfoXML appendFormat:@"<ContactNo>%@</ContactNo>",[eventsArray objectForKey:@"ContactNo"]];
    [ContigentInfoXML appendFormat:@"</COContact>"];
    
    eventsArray = [[[[DataDictionary objectForKey:@"proposalCODetails"]objectForKey:@"COContacts"]objectAtIndex:1 ]objectForKey:@"Contact Type = \"Mobile\""];
    [ContigentInfoXML appendFormat:@"<COContact Type=\"Mobile\">"];
    [ContigentInfoXML appendFormat:@"<ContactCode>%@</ContactCode>",[eventsArray objectForKey:@"ContactCode"]];
    [ContigentInfoXML appendFormat:@"<ContactNo>%@</ContactNo>",[eventsArray objectForKey:@"ContactNo"]];
    [ContigentInfoXML appendFormat:@"</COContact>"];
    
    
    eventsArray = [[[[DataDictionary objectForKey:@"proposalCODetails"]objectForKey:@"COContacts"] objectAtIndex:2 ]objectForKey:@"Contact Type = \"Email\""];
    [ContigentInfoXML appendFormat:@"<COContact Type=\"Email\">"];
    [ContigentInfoXML appendFormat:@"<ContactCode>%@</ContactCode>",[eventsArray objectForKey:@"ContactCode"]];
    [ContigentInfoXML appendFormat:@"<ContactNo>%@</ContactNo>",[eventsArray objectForKey:@"ContactNo"]];
    [ContigentInfoXML appendFormat:@"</COContact>"];
    
    [ContigentInfoXML appendFormat:@"</COContacts></ContigentInfo>"];
    
    return ContigentInfoXML;
}

-(id)getFundInfo:(NSDictionary*)DataDictionary
{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *FundInfoXML = [NSMutableString string];
    
    [FundInfoXML appendFormat:@"<FundInfo><BenefitChoices>%@</BenefitChoices><ExcessPaymentOpt>%@</ExcessPaymentOpt><LienOpt>%@</LienOpt><StrategyCode>%@</StrategyCode><InvestHorizon>%@</InvestHorizon>",
     [[DataDictionary objectForKey:@"proposalFundInfo"]objectForKey:@"BenefitChoices"],
     [[DataDictionary objectForKey:@"proposalFundInfo"]objectForKey:@"ExcessPaymentOpt"],
     [[DataDictionary objectForKey:@"proposalFundInfo"]objectForKey:@"LienOpt"],
     [[DataDictionary objectForKey:@"proposalFundInfo"]objectForKey:@"StrategyCode"],
     [[DataDictionary objectForKey:@"proposalFundInfo"]objectForKey:@"InvestHorizon"]];
    
    id eventsArray = [DataDictionary objectForKey:@"proposalFundInfo"];
    [FundInfoXML appendFormat:@"</FundInfo>"];
    
    return FundInfoXML;
    
}

-(id)geteCFFInfo:(NSDictionary*)DataDictionary
{
    
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *eCFFInfoXML = [NSMutableString string];
    [eCFFInfoXML appendFormat:@"<eCFFInfo><CreatedAt>%@</CreatedAt><LastUpdatedAt>%@</LastUpdatedAt><IntermediaryStatus>%@</IntermediaryStatus><BrokerName>%@</BrokerName><ClientChoice>%@</ClientChoice><RiskReturnProfile>%@</RiskReturnProfile><NeedsQ1_Ans1>%@</NeedsQ1_Ans1><NeedsQ1_Ans2>%@</NeedsQ1_Ans2><NeedsQ1_Priority>%@</NeedsQ1_Priority><NeedsQ2_Ans1>%@</NeedsQ2_Ans1><NeedsQ2_Ans2>%@</NeedsQ2_Ans2><NeedsQ2_Priority>%@</NeedsQ2_Priority><NeedsQ3_Ans1>%@</NeedsQ3_Ans1><NeedsQ3_Ans2>%@</NeedsQ3_Ans2><NeedsQ3_Priority>%@</NeedsQ3_Priority><NeedsQ4_Ans1>%@</NeedsQ4_Ans1><NeedsQ4_Ans2>%@</NeedsQ4_Ans2><NeedsQ4_Priority>%@</NeedsQ4_Priority><NeedsQ5_Ans1>%@</NeedsQ5_Ans1><NeedsQ5_Ans2>%@</NeedsQ5_Ans2><NeedsQ5_Priority>%@</NeedsQ5_Priority><IntermediaryCode>%@</IntermediaryCode><IntermediaryName>%@</IntermediaryName><IntermediaryNRIC>%@</IntermediaryNRIC><IntermediaryContractDate>%@</IntermediaryContractDate><IntermediaryAddress1><![CDATA[%@]]></IntermediaryAddress1><IntermediaryAddress2><![CDATA[%@]]></IntermediaryAddress2><IntermediaryAddress3><![CDATA[%@]]></IntermediaryAddress3><IntermediaryAddress4><![CDATA[%@]]></IntermediaryAddress4><IntermediaryPostcode>%@</IntermediaryPostcode><IntermediaryTown><![CDATA[%@]]></IntermediaryTown><IntermediaryState><![CDATA[%@]]></IntermediaryState><IntermediaryCountry><![CDATA[%@]]></IntermediaryCountry><IntermediaryManagerName>%@</IntermediaryManagerName><ClientAck>%@</ClientAck><ClientComments><![CDATA[%@]]></ClientComments>",
     
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"CreatedAt"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"LastUpdatedAt"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryStatus"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"BrokerName"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"ClientChoice"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"RiskReturnProfile"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"NeedsQ1_Ans1"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"NeedsQ1_Ans2"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"NeedsQ1_Priority"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"NeedsQ2_Ans1"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"NeedsQ2_Ans2"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"NeedsQ2_Priority"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"NeedsQ3_Ans1"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"NeedsQ3_Ans2"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"NeedsQ3_Priority"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"NeedsQ4_Ans1"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"NeedsQ4_Ans2"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"NeedsQ4_Priority"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"NeedsQ5_Ans1"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"NeedsQ5_Ans2"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"NeedsQ5_Priority"],
     
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryCode"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryName"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryNRIC"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryContractDate"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryAddress1"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryAddress2"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryAddress3"],
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryAddress4"],

     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryPostcode"],  //postcode
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryTown"],  //town
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryState"],  //state
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryCountry"],  //country
     
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryManagerName"],
     
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"ClientAck"],
     
     [[DataDictionary objectForKey:@"eCFFInfo"]objectForKey:@"ClientComments"]];
    id eventsArray = [DataDictionary objectForKey:@"eCFFInfo"];
    [eCFFInfoXML appendFormat:@"</eCFFInfo>"];
    return eCFFInfoXML;
}


-(id)getPersonalInfo:(NSDictionary*)DataDictionary
{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *PersonalInfoXML = [NSMutableString string];
    [PersonalInfoXML appendFormat:@"<PersonalInfo>"];
    for(int i=1;i<[[DataDictionary objectForKey:@"eCFFPersonalInfo"]count]+1;i++)
    {
        [PersonalInfoXML appendFormat:@"<CFFParty ID=\"%d\"><AddFromCFF>%@</AddFromCFF><AddNewPayor>%@</AddNewPayor><SameAsPO>%@</SameAsPO><PTypeCode>%@</PTypeCode><PYFlag>%@</PYFlag><Title>%@</Title><Name>%@</Name><NewICNo>%@</NewICNo><OtherIDType>%@</OtherIDType><OtherID>%@</OtherID><Nationality>%@</Nationality><Race>%@</Race><Religion>%@</Religion><Sex>%@</Sex><Smoker>%@</Smoker><DOB>%@</DOB><Age>%@</Age><MaritalStatus>%@</MaritalStatus><Occupation>%@</Occupation><ResidencePhoneNo>%@</ResidencePhoneNo><OfficePhoneNo>%@</OfficePhoneNo><MobilePhoneNo>%@</MobilePhoneNo><FaxPhoneNo>%@</FaxPhoneNo><EmailAddress>%@</EmailAddress><CFFAddresses>",i,
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"AddFromCFF"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"AddNewPayor"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"SameAsPO"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"PTypeCode"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"PYFlag"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"Title"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"Name"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"NewICNo"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"OtherIDType"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"OtherID"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"Nationality"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"Race"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"Religion"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"Sex"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"Smoker"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"DOB"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"Age"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"MaritalStatus"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"Occupation"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"ResidencePhoneNo"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"OfficePhoneNo"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"MobilePhoneNo"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"FaxPhoneNo"],
         [[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"EmailAddress"]];
        
        id eventsArray = [[[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"CFFAddresses"]objectForKey:@"CFFAddress Type=\"Mailing\""];
        [PersonalInfoXML appendFormat:@"<CFFAddress Type=\"Mailing\">"];
        [PersonalInfoXML appendFormat:@"<AddressSameAsPO>%@</AddressSameAsPO>",[eventsArray objectForKey:@"AddressSameAsPO"]];
        [PersonalInfoXML appendFormat:@"<Address1><![CDATA[%@]]></Address1>",[eventsArray objectForKey:@"Address1"]];
        [PersonalInfoXML appendFormat:@"<Address2><![CDATA[%@]]></Address2>",[eventsArray objectForKey:@"Address2"]];
        [PersonalInfoXML appendFormat:@"<Address3><![CDATA[%@]]></Address3>",[eventsArray objectForKey:@"Address3"]];
        [PersonalInfoXML appendFormat:@"<Town><![CDATA[%@]]></Town>",[eventsArray objectForKey:@"Town"]];
        [PersonalInfoXML appendFormat:@"<State><![CDATA[%@]]></State>",[eventsArray objectForKey:@"State"]];
        [PersonalInfoXML appendFormat:@"<Postcode>%@</Postcode>",[eventsArray objectForKey:@"Postcode"]];
        [PersonalInfoXML appendFormat:@"<Country><![CDATA[%@]]></Country>",[eventsArray objectForKey:@"Country"]];
        [PersonalInfoXML appendFormat:@"<ForeignAddress>%@</ForeignAddress>",[eventsArray objectForKey:@"ForeignAddress"]];
        [PersonalInfoXML appendFormat:@"</CFFAddress>"];
        eventsArray = [[[[DataDictionary objectForKey:@"eCFFPersonalInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"%d\"",i]]objectForKey:@"CFFAddresses"]objectForKey:@"CFFAddress Type=\"Permanent\""];
        [PersonalInfoXML appendFormat:@"<CFFAddress Type=\"Permanent\">"];
        //[PersonalInfoXML appendFormat:@"<AddressCode>%@</AddressCode>",[eventsArray objectForKey:@"AddressCode"]];
        [PersonalInfoXML appendFormat:@"<AddressSameAsPO>%@</AddressSameAsPO>",[eventsArray objectForKey:@"AddressSameAsPO"]];
        [PersonalInfoXML appendFormat:@"<Address1><![CDATA[%@]]></Address1>",[eventsArray objectForKey:@"Address1"]];
        [PersonalInfoXML appendFormat:@"<Address2><![CDATA[%@]]></Address2>",[eventsArray objectForKey:@"Address2"]];
        [PersonalInfoXML appendFormat:@"<Address3><![CDATA[%@]]></Address3>",[eventsArray objectForKey:@"Address3"]];
        [PersonalInfoXML appendFormat:@"<Town><![CDATA[%@]]></Town>",[eventsArray objectForKey:@"Town"]];
        [PersonalInfoXML appendFormat:@"<State><![CDATA[%@]]></State>",[eventsArray objectForKey:@"State"]];
        [PersonalInfoXML appendFormat:@"<Postcode>%@</Postcode>",[eventsArray objectForKey:@"Postcode"]];
        [PersonalInfoXML appendFormat:@"<Country><![CDATA[%@]]></Country>",[eventsArray objectForKey:@"Country"]];
        [PersonalInfoXML appendFormat:@"<ForeignAddress>%@</ForeignAddress>",[eventsArray objectForKey:@"ForeignAddress"]];
        [PersonalInfoXML appendFormat:@"</CFFAddress></CFFAddresses></CFFParty>"];
        
        NSString *gotPartner = [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"AddFromCFF"] ;
        
        if ([gotPartner isEqualToString:@"True"] || [gotPartner isEqualToString:@"False"]) {
            
            
            [PersonalInfoXML appendFormat:@"<CFFParty ID=\"2\"><AddFromCFF>%@</AddFromCFF><AddNewPayor>%@</AddNewPayor><SameAsPO>%@</SameAsPO><PTypeCode>%@</PTypeCode><PYFlag>%@</PYFlag><Title>%@</Title><Name>%@</Name><NewICNo>%@</NewICNo><OtherIDType>%@</OtherIDType><OtherID>%@</OtherID><Nationality>%@</Nationality><Race>%@</Race><Religion>%@</Religion><Sex>%@</Sex><Smoker>%@</Smoker><DOB>%@</DOB><Age>%@</Age><MaritalStatus>%@</MaritalStatus><Occupation>%@</Occupation><ResidencePhoneNo>%@</ResidencePhoneNo><OfficePhoneNo>%@</OfficePhoneNo><MobilePhoneNo>%@</MobilePhoneNo><FaxPhoneNo>%@</FaxPhoneNo><EmailAddress>%@</EmailAddress><CFFAddresses>",
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"AddFromCFF"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"AddNewPayor"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"SameAsPO"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"PTypeCode"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"PYFlag"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"Title"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"Name"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"NewICNo"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"OtherIDType"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"OtherID"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"Nationality"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"Race"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"Religion"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"Sex"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"Smoker"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"DOB"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"Age"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"MaritalStatus"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"Occupation"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"ResidencePhoneNo"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"OfficePhoneNo"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"MobilePhoneNo"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"FaxPhoneNo"],
             [[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"EmailAddress"]];
            
            id eventsArray2 = [[[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"CFFAddresses"]objectForKey:@"CFFAddress Type=\"Mailing\""];
            [PersonalInfoXML appendFormat:@"<CFFAddress Type=\"Mailing\">"];
            [PersonalInfoXML appendFormat:@"<AddressSameAsPO>%@</AddressSameAsPO>",[eventsArray2 objectForKey:@"AddressSameAsPO"]];
            [PersonalInfoXML appendFormat:@"<Address1><![CDATA[%@]]></Address1>",[eventsArray2 objectForKey:@"Address1"]];
            [PersonalInfoXML appendFormat:@"<Address2><![CDATA[%@]]></Address2>",[eventsArray2 objectForKey:@"Address2"]];
            [PersonalInfoXML appendFormat:@"<Address3><![CDATA[%@]]></Address3>",[eventsArray2 objectForKey:@"Address3"]];
            [PersonalInfoXML appendFormat:@"<Town><![CDATA[%@]]></Town>",[eventsArray2 objectForKey:@"Town"]];
            [PersonalInfoXML appendFormat:@"<State><![CDATA[%@]]></State>",[eventsArray2 objectForKey:@"State"]];
            [PersonalInfoXML appendFormat:@"<Postcode>%@</Postcode>",[eventsArray2 objectForKey:@"Postcode"]];
            [PersonalInfoXML appendFormat:@"<Country><![CDATA[%@]]></Country>",[eventsArray2 objectForKey:@"Country"]];
            [PersonalInfoXML appendFormat:@"<ForeignAddress>%@</ForeignAddress>",[eventsArray2 objectForKey:@"ForeignAddress"]];
            [PersonalInfoXML appendFormat:@"</CFFAddress>"];
            eventsArray2 = [[[[DataDictionary objectForKey:@"eCFFPartnerInfo"]objectForKey:[NSString stringWithFormat:@"CFFParty ID=\"2\""]]objectForKey:@"CFFAddresses"]objectForKey:@"CFFAddress Type=\"Permanent\""];
            [PersonalInfoXML appendFormat:@"<CFFAddress Type=\"Permanent\">"];
            //[PersonalInfoXML appendFormat:@"<AddressCode>%@</AddressCode>",[eventsArray objectForKey:@"AddressCode"]];
            [PersonalInfoXML appendFormat:@"<AddressSameAsPO>%@</AddressSameAsPO>",[eventsArray2 objectForKey:@"AddressSameAsPO"]];
            [PersonalInfoXML appendFormat:@"<Address1><![CDATA[%@]]></Address1>",[eventsArray2 objectForKey:@"Address1"]];
            [PersonalInfoXML appendFormat:@"<Address2><![CDATA[%@]]></Address2>",[eventsArray2 objectForKey:@"Address2"]];
            [PersonalInfoXML appendFormat:@"<Address3><![CDATA[%@]]></Address3>",[eventsArray2 objectForKey:@"Address3"]];
            [PersonalInfoXML appendFormat:@"<Town><![CDATA[%@]]></Town>",[eventsArray2 objectForKey:@"Town"]];
            [PersonalInfoXML appendFormat:@"<State><![CDATA[%@]]></State>",[eventsArray2 objectForKey:@"State"]];
            [PersonalInfoXML appendFormat:@"<Postcode>%@</Postcode>",[eventsArray2 objectForKey:@"Postcode"]];
            [PersonalInfoXML appendFormat:@"<Country><![CDATA[%@]]></Country>",[eventsArray2 objectForKey:@"Country"]];
            [PersonalInfoXML appendFormat:@"<ForeignAddress>%@</ForeignAddress>",[eventsArray2 objectForKey:@"ForeignAddress"]];
            [PersonalInfoXML appendFormat:@"</CFFAddress></CFFAddresses></CFFParty>"];
            
        }
        
        
    }
    [PersonalInfoXML appendFormat:@"</PersonalInfo>"];
    return PersonalInfoXML;
}

-(id)getChildInfo:(NSDictionary*)DataDictionary
{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *ChildInfoXML = [NSMutableString string];
    [ChildInfoXML appendFormat:@"<ChildInfo>"];
    for(int i=0;i<[[DataDictionary objectForKey:@"eCFFChildInfo"]count];i++)
    {
        
        id eventsArray = [[[DataDictionary objectForKey:@"eCFFChildInfo"] objectAtIndex:i]objectForKey:[NSString stringWithFormat:@"ChildParty ID=\"%d\"",i+1]];
        
        [ChildInfoXML appendFormat:@"<ChildParty ID=\"%d\">",i+1];
        [ChildInfoXML appendFormat:@"<AddFromCFF>%@</AddFromCFF>",[eventsArray objectForKey:@"AddFromCFF"]];
        [ChildInfoXML appendFormat:@"<SameAsPO>%@</SameAsPO>",[eventsArray objectForKey:@"SameAsPO"]];
        [ChildInfoXML appendFormat:@"<PTypeCode>%@</PTypeCode>",[eventsArray objectForKey:@"PTypeCode"]];
        [ChildInfoXML appendFormat:@"<Name>%@</Name>",[eventsArray objectForKey:@"Name"]];
        [ChildInfoXML appendFormat:@"<Relationship>%@</Relationship>",[eventsArray objectForKey:@"Relationship"]];
        [ChildInfoXML appendFormat:@"<DOB>%@</DOB>",[eventsArray objectForKey:@"DOB"]];
        [ChildInfoXML appendFormat:@"<Age>%@</Age>",[eventsArray objectForKey:@"Age"]];
        [ChildInfoXML appendFormat:@"<Sex>%@</Sex>",[eventsArray objectForKey:@"Sex"]];
        [ChildInfoXML appendFormat:@"<YearsToSupport>%@</YearsToSupport>",[eventsArray objectForKey:@"YearsToSupport"]];
        
        [ChildInfoXML appendFormat:@"</ChildParty>"];
        
        // [ChildInfoXML appendFormat:@"<ChildParty ID=\"%d\">%@</ChildParty>",i,[self parserNSDictionarytoXML:eventsArray]];
        
        //[ChildInfoXML appendFormat:@"<ChildParty ID=\"%d\">%@</ChildParty ID=\"%d\"> ",i,[self parserNSDictionarytoXML:eventsArray],i];
    }
    [ChildInfoXML appendFormat:@"</ChildInfo>"];
    return ChildInfoXML;
}



-(id)getProtectionInfo:(NSDictionary*)DataDictionary
{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *ProtectionInfoXML = [NSMutableString string];
    [ProtectionInfoXML appendFormat:@"<ProtectionInfo><NoExistingPlan>%@</NoExistingPlan><AllocateIncome_1>%@</AllocateIncome_1><AllocateIncome_2>%@</AllocateIncome_2><TotalSA_CurAmt>%@</TotalSA_CurAmt><TotalSA_ReqAmt>%@</TotalSA_ReqAmt><TotalSA_SurAmt>%@</TotalSA_SurAmt><TotalCISA_CurAmt>%@</TotalCISA_CurAmt><TotalCISA_ReqAmt>%@</TotalCISA_ReqAmt><TotalCISA_SurAmt>%@</TotalCISA_SurAmt><TotalHB_CurAmt>%@</TotalHB_CurAmt><TotalHB_ReqAmt>%@</TotalHB_ReqAmt><TotalHB_SurAmt>%@</TotalHB_SurAmt><TotalPA_CurAmt>%@</TotalPA_CurAmt><TotalPA_ReqAmt>%@</TotalPA_ReqAmt><TotalPA_SurAmt>%@</TotalPA_SurAmt>",
     [[DataDictionary objectForKey:@"eCFFProtectionInfo"]objectForKey:@"NoExistingPlan"],
     [[DataDictionary objectForKey:@"eCFFProtectionInfo"]objectForKey:@"AllocateIncome_1"],
     [[DataDictionary objectForKey:@"eCFFProtectionInfo"]objectForKey:@"AllocateIncome_2"],
     [[DataDictionary objectForKey:@"eCFFProtectionInfo"]objectForKey:@"TotalSA_CurAmt"],
     [[DataDictionary objectForKey:@"eCFFProtectionInfo"]objectForKey:@"TotalSA_ReqAmt"],
     [[DataDictionary objectForKey:@"eCFFProtectionInfo"]objectForKey:@"TotalSA_SurAmt"],
     [[DataDictionary objectForKey:@"eCFFProtectionInfo"]objectForKey:@"TotalCISA_CurAmt"],
     [[DataDictionary objectForKey:@"eCFFProtectionInfo"]objectForKey:@"TotalCISA_ReqAmt"],
     [[DataDictionary objectForKey:@"eCFFProtectionInfo"]objectForKey:@"TotalCISA_SurAmt"],
     [[DataDictionary objectForKey:@"eCFFProtectionInfo"]objectForKey:@"TotalHB_CurAmt"],
     [[DataDictionary objectForKey:@"eCFFProtectionInfo"]objectForKey:@"TotalHB_ReqAmt"],
     [[DataDictionary objectForKey:@"eCFFProtectionInfo"]objectForKey:@"TotalHB_SurAmt"],
     [[DataDictionary objectForKey:@"eCFFProtectionInfo"]objectForKey:@"TotalPA_CurAmt"],
     [[DataDictionary objectForKey:@"eCFFProtectionInfo"]objectForKey:@"TotalPA_ReqAmt"],
     [[DataDictionary objectForKey:@"eCFFProtectionInfo"]objectForKey:@"TotalPA_SurAmt"]];
    
    //    for(int i=0;i<[[DataDictionary objectForKey:@"eCFFProtectionDetails"] count];i++){
    //        id eventsArray = [[[DataDictionary objectForKey:@"eCFFProtectionDetails"] objectAtIndex:i] objectForKey:[NSString stringWithFormat:@"ProtectionPlanInfo ID=\"%d\"",i+1]];
    //        [ProtectionInfoXML appendFormat:@"<ProtectionPlanInfo ID=\"%d\">%@</ProtectionPlanInfo>",i+1,[self parserNSDictionarytoXML:eventsArray]];
    //    }
    //
    for(int i=0;i<[[DataDictionary objectForKey:@"eCFFProtectionDetails"]count];i++)
    {
        id eventsArray = [[[DataDictionary objectForKey:@"eCFFProtectionDetails"] objectAtIndex:i]objectForKey:[NSString stringWithFormat:@"ProtectionPlanInfo ID=\"%d\"",i+1]];
        [ProtectionInfoXML appendFormat:@"<ProtectionPlanInfo ID=\"%d\">",i+1];
        [ProtectionInfoXML appendFormat:@"<POName>%@</POName>",[eventsArray objectForKey:@"POName"]];
        [ProtectionInfoXML appendFormat:@"<Company>%@</Company>",[eventsArray objectForKey:@"Company"]];
        [ProtectionInfoXML appendFormat:@"<PlanType><![CDATA[%@]]></PlanType>",[eventsArray objectForKey:@"PlanType"]];
        [ProtectionInfoXML appendFormat:@"<LAName>%@</LAName>",[eventsArray objectForKey:@"LAName"]];
        [ProtectionInfoXML appendFormat:@"<Benefit1>%@</Benefit1>",[eventsArray objectForKey:@"Benefit1"]];
        [ProtectionInfoXML appendFormat:@"<Benefit2>%@</Benefit2>",[eventsArray objectForKey:@"Benefit2"]];
        [ProtectionInfoXML appendFormat:@"<Benefit3>%@</Benefit3>",[eventsArray objectForKey:@"Benefit3"]];
        [ProtectionInfoXML appendFormat:@"<Benefit4>%@</Benefit4>",[eventsArray objectForKey:@"Benefit4"]];
        [ProtectionInfoXML appendFormat:@"<Premium>%@</Premium>",[eventsArray objectForKey:@"Premium"]];
        [ProtectionInfoXML appendFormat:@"<Mode>%@</Mode>",[eventsArray objectForKey:@"Mode"]];
        [ProtectionInfoXML appendFormat:@"<MaturityDate>%@</MaturityDate>",[eventsArray objectForKey:@"MaturityDate"]];
        [ProtectionInfoXML appendFormat:@"</ProtectionPlanInfo>"];
    }
    
    [ProtectionInfoXML appendFormat:@"</ProtectionInfo>"];
    return ProtectionInfoXML;
    
}

-(id)getRetirementInfo:(NSDictionary*)DataDictionary
{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *RetirementInfoXML = [NSMutableString string];
    [RetirementInfoXML appendFormat:@"<RetirementInfo><NoExistingPlan>%@</NoExistingPlan><AllocateIncome_1>%@</AllocateIncome_1><AllocateIncome_2>%@</AllocateIncome_2><IncomeSource_1>%@</IncomeSource_1><IncomeSource_2>%@</IncomeSource_2><CurAmt>%@</CurAmt><ReqAmt>%@</ReqAmt><SurAmt>%@</SurAmt>",
     [[DataDictionary objectForKey:@"eCFFRetirementInfo"]objectForKey:@"NoExistingPlan"],
     [[DataDictionary objectForKey:@"eCFFRetirementInfo"]objectForKey:@"AllocateIncome_1"],
     [[DataDictionary objectForKey:@"eCFFRetirementInfo"]objectForKey:@"AllocateIncome_2"],
     [[DataDictionary objectForKey:@"eCFFRetirementInfo"]objectForKey:@"IncomeSource_1"],
     [[DataDictionary objectForKey:@"eCFFRetirementInfo"]objectForKey:@"IncomeSource_2"],
     [[DataDictionary objectForKey:@"eCFFRetirementInfo"]objectForKey:@"CurAmt"],
     [[DataDictionary objectForKey:@"eCFFRetirementInfo"]objectForKey:@"ReqAmt"],
     [[DataDictionary objectForKey:@"eCFFRetirementInfo"]objectForKey:@"SurAmt"]];
    
    //    for(int i=0;i<[[DataDictionary objectForKey:@"eCFFRetirementDetails"] count];i++){
    //        id eventsArray = [[[DataDictionary objectForKey:@"eCFFRetirementDetails"] objectAtIndex:i] objectForKey:[NSString stringWithFormat:@"RetirementPlanInfo ID=\"%d\"",i+1]];
    //        [RetirementInfoXML appendFormat:@"<RetirementPlanInfo ID=\"%d\">%@</RetirementPlanInfo>",i+1,[self parserNSDictionarytoXML:eventsArray]];
    //    }
    
    for(int i=0;i<[[DataDictionary objectForKey:@"eCFFRetirementDetails"]count];i++)
    {
        id eventsArray = [[[DataDictionary objectForKey:@"eCFFRetirementDetails"] objectAtIndex:i]objectForKey:[NSString stringWithFormat:@"RetirementPlanInfo ID=\"%d\"",i+1]];
        [RetirementInfoXML appendFormat:@"<RetirementPlanInfo ID=\"%d\">",i+1];
        [RetirementInfoXML appendFormat:@"<POName>%@</POName>",[eventsArray objectForKey:@"POName"]];
        [RetirementInfoXML appendFormat:@"<Company>%@</Company>",[eventsArray objectForKey:@"Company"]];
        [RetirementInfoXML appendFormat:@"<PlanType><![CDATA[%@]]></PlanType>",[eventsArray objectForKey:@"PlanType"]];
        [RetirementInfoXML appendFormat:@"<Premium>%@</Premium>",[eventsArray objectForKey:@"Premium"]];
        [RetirementInfoXML appendFormat:@"<Frequency>%@</Frequency>",[eventsArray objectForKey:@"Frequency"]];
        [RetirementInfoXML appendFormat:@"<StartDate>%@</StartDate>",[eventsArray objectForKey:@"StartDate"]];
        [RetirementInfoXML appendFormat:@"<EndDate>%@</EndDate>",[eventsArray objectForKey:@"EndDate"]];
        [RetirementInfoXML appendFormat:@"<LSMaturityAmt>%@</LSMaturityAmt>",[eventsArray objectForKey:@"LSMaturityAmt"]];
        [RetirementInfoXML appendFormat:@"<AIMaturityAmt>%@</AIMaturityAmt>",[eventsArray objectForKey:@"AIMaturityAmt"]];
        [RetirementInfoXML appendFormat:@"<Benefits><![CDATA[%@]]></Benefits>",[eventsArray objectForKey:@"Benefits"]];
        
        [RetirementInfoXML appendFormat:@"</RetirementPlanInfo>"];
    }
    
    [RetirementInfoXML appendFormat:@"</RetirementInfo>"];
    return RetirementInfoXML;
}

-(id)getEducInfo:(NSDictionary*)DataDictionary
{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *EducInfoXML = [NSMutableString string];
    [EducInfoXML appendFormat:@"<EducInfo><NoExistingPlan>%@</NoExistingPlan><NoChild>%@</NoChild><AllocateIncome_1>%@</AllocateIncome_1><CurAmt_C1>%@</CurAmt_C1><ReqAmt_C1>%@</ReqAmt_C1><SurAmt_C1>%@</SurAmt_C1><CurAmt_C2>%@</CurAmt_C2><ReqAmt_C2>%@</ReqAmt_C2><SurAmt_C2>%@</SurAmt_C2><CurAmt_C3>%@</CurAmt_C3><ReqAmt_C3>%@</ReqAmt_C3><SurAmt_C3>%@</SurAmt_C3><CurAmt_C4>%@</CurAmt_C4><ReqAmt_C4>%@</ReqAmt_C4><SurAmt_C4>%@</SurAmt_C4>",
     [[DataDictionary objectForKey:@"eCFFEducationInfo"]objectForKey:@"NoExistingPlan"],
     [[DataDictionary objectForKey:@"eCFFEducationInfo"]objectForKey:@"NoChild"],
     [[DataDictionary objectForKey:@"eCFFEducationInfo"]objectForKey:@"AllocateIncome_1"],
     [[DataDictionary objectForKey:@"eCFFEducationInfo"]objectForKey:@"CurAmt_C1"],
     [[DataDictionary objectForKey:@"eCFFEducationInfo"]objectForKey:@"ReqAmt_C1"],
     [[DataDictionary objectForKey:@"eCFFEducationInfo"]objectForKey:@"SurAmt_C1"],
     [[DataDictionary objectForKey:@"eCFFEducationInfo"]objectForKey:@"CurAmt_C2"],
     [[DataDictionary objectForKey:@"eCFFEducationInfo"]objectForKey:@"ReqAmt_C2"],
     [[DataDictionary objectForKey:@"eCFFEducationInfo"]objectForKey:@"SurAmt_C2"],
     [[DataDictionary objectForKey:@"eCFFEducationInfo"]objectForKey:@"CurAmt_C3"],
     [[DataDictionary objectForKey:@"eCFFEducationInfo"]objectForKey:@"ReqAmt_C3"],
     [[DataDictionary objectForKey:@"eCFFEducationInfo"]objectForKey:@"SurAmt_C3"],
     [[DataDictionary objectForKey:@"eCFFEducationInfo"]objectForKey:@"CurAmt_C4"],
     [[DataDictionary objectForKey:@"eCFFEducationInfo"]objectForKey:@"ReqAmt_C4"],
     [[DataDictionary objectForKey:@"eCFFEducationInfo"]objectForKey:@"SurAmt_C4"]];
    
    //    for(int i=0;i<[[DataDictionary objectForKey:@"eCFFEducationDetails"] count];i++){
    //        id eventsArray = [[[DataDictionary objectForKey:@"eCFFEducationDetails"] objectAtIndex:i] objectForKey:[NSString stringWithFormat:@"EducPlanInfo ID=\"%d\"",i+1]];
    //        [EducInfoXML appendFormat:@"<EducPlanInfo ID=\"%d\">%@</EducPlanInfo>",i+1,[self parserNSDictionarytoXML:eventsArray]];
    //    }
    
    for(int i=0;i<[[DataDictionary objectForKey:@"eCFFEducationDetails"]count];i++)
    {
        id eventsArray = [[[DataDictionary objectForKey:@"eCFFEducationDetails"] objectAtIndex:i]objectForKey:[NSString stringWithFormat:@"EducPlanInfo ID=\"%d\"",i+1]];
        [EducInfoXML appendFormat:@"<EducPlanInfo ID=\"%d\">",i+1];
        [EducInfoXML appendFormat:@"<Name>%@</Name>",[eventsArray objectForKey:@"Name"]];
        [EducInfoXML appendFormat:@"<Company>%@</Company>",[eventsArray objectForKey:@"Company"]];
        [EducInfoXML appendFormat:@"<Premium>%@</Premium>",[eventsArray objectForKey:@"Premium"]];
        [EducInfoXML appendFormat:@"<Frequency>%@</Frequency>",[eventsArray objectForKey:@"Frequency"]];
        [EducInfoXML appendFormat:@"<StartDate>%@</StartDate>",[eventsArray objectForKey:@"StartDate"]];
        [EducInfoXML appendFormat:@"<EndDate>%@</EndDate>",[eventsArray objectForKey:@"EndDate"]];
        [EducInfoXML appendFormat:@"<MaturityAmt>%@</MaturityAmt>",[eventsArray objectForKey:@"MaturityAmt"]];
        
        [EducInfoXML appendFormat:@"</EducPlanInfo>"];
    }
    
    
    [EducInfoXML appendFormat:@"</EducInfo>"];
    return EducInfoXML;
}


-(id)getSavingInfo:(NSDictionary*)DataDictionary
{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *SavingInfoXML = [NSMutableString string];
    [SavingInfoXML appendFormat:@"<SavingInfo><NoExistingPlan>%@</NoExistingPlan><AllocateIncome_1>%@</AllocateIncome_1><CurAmt>%@</CurAmt><ReqAmt>%@</ReqAmt><SurAmt>%@</SurAmt>",
     [[DataDictionary objectForKey:@"eCFFSavingInfo"]objectForKey:@"NoExistingPlan"],
     [[DataDictionary objectForKey:@"eCFFSavingInfo"]objectForKey:@"AllocateIncome_1"],
     [[DataDictionary objectForKey:@"eCFFSavingInfo"]objectForKey:@"CurAmt"],
     [[DataDictionary objectForKey:@"eCFFSavingInfo"]objectForKey:@"ReqAmt"],
     [[DataDictionary objectForKey:@"eCFFSavingInfo"]objectForKey:@"SurAmt"]];
    
    //    for(int i=0;i<[[DataDictionary objectForKey:@"eCFFSavingsDetails"] count];i++){
    //        id eventsArray = [[[DataDictionary objectForKey:@"eCFFSavingsDetails"] objectAtIndex:i] objectForKey:[NSString stringWithFormat:@"SavingPlanInfo ID=\"%d\"",i+1]];
    //        [SavingInfoXML appendFormat:@"<SavingPlanInfo ID=\"%d\">%@</SavingPlanInfo>",i+1,[self parserNSDictionarytoXML:eventsArray]];
    //    }
    
    for(int i=0;i<[[DataDictionary objectForKey:@"eCFFSavingsDetails"]count];i++)
    {
        id eventsArray = [[[DataDictionary objectForKey:@"eCFFSavingsDetails"] objectAtIndex:i]objectForKey:[NSString stringWithFormat:@"SavingPlanInfo ID=\"%d\"",i+1]];
        [SavingInfoXML appendFormat:@"<SavingPlanInfo ID=\"%d\">",i+1];
        [SavingInfoXML appendFormat:@"<POName>%@</POName>",[eventsArray objectForKey:@"POName"]];
        [SavingInfoXML appendFormat:@"<Company>%@</Company>",[eventsArray objectForKey:@"Company"]];
        [SavingInfoXML appendFormat:@"<Type>%@</Type>",[eventsArray objectForKey:@"Type"]];
        [SavingInfoXML appendFormat:@"<Purpose>%@</Purpose>",[eventsArray objectForKey:@"Purpose"]];
        [SavingInfoXML appendFormat:@"<Premium>%@</Premium>",[eventsArray objectForKey:@"Premium"]];
        [SavingInfoXML appendFormat:@"<ComDate>%@</ComDate>",[eventsArray objectForKey:@"ComDate"]];
        [SavingInfoXML appendFormat:@"<MaturityAmt>%@</MaturityAmt>",[eventsArray objectForKey:@"MaturityAmt"]];
        
        [SavingInfoXML appendFormat:@"</SavingPlanInfo>"];
    }
    
    [SavingInfoXML appendFormat:@"</SavingInfo>"];
    return SavingInfoXML;
    
}

-(id)getRecordOfAdvice:(NSDictionary*)DataDictionary
{
    // DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    
    // NSLog(@"%@",[[DataDictionary objectForKey:@"eCFFRecordOfAdviceP1"]objectForKey:@"Priority ID=\"1\""]);
    // NSLog(@"%@",[[DataDictionary objectForKey:@"eCFFRecoredOfAdviceP2"]objectForKey:@"Priority ID=\"2\""]);
    NSMutableString *RecordOfAdviceXML = [NSMutableString string];
    [RecordOfAdviceXML appendFormat:@"<RecordOfAdvice>"];
    [RecordOfAdviceXML appendFormat:@"<RecCount>%@</RecCount>",[[DataDictionary objectForKey:@"eCFFRecordOfAdviceP1"]objectForKey:@"RecCount"]];
    
    
    [RecordOfAdviceXML appendFormat:@"<Priority ID=\"1\"><Seq>%@</Seq><SameAsQuotation>%@</SameAsQuotation><PlanType><![CDATA[%@]]></PlanType><Term>%@</Term><InsurerName>%@</InsurerName><InsuredName>%@</InsuredName><SA>%@</SA><Reason><![CDATA[%@]]></Reason><Action><![CDATA[%@]]></Action>",
     [[[DataDictionary objectForKey:@"eCFFRecordOfAdviceP1"]objectForKey:@"Priority ID=\"1\""]objectForKey:@"Seq"],
     [[[DataDictionary objectForKey:@"eCFFRecordOfAdviceP1"]objectForKey:@"Priority ID=\"1\""]objectForKey:@"SameAsQuotation"],
     [[[DataDictionary objectForKey:@"eCFFRecordOfAdviceP1"]objectForKey:@"Priority ID=\"1\""]objectForKey:@"PlanType"],
     [[[DataDictionary objectForKey:@"eCFFRecordOfAdviceP1"]objectForKey:@"Priority ID=\"1\""]objectForKey:@"Term"],
     [[[DataDictionary objectForKey:@"eCFFRecordOfAdviceP1"]objectForKey:@"Priority ID=\"1\""]objectForKey:@"InsurerName"],
     [[[DataDictionary objectForKey:@"eCFFRecordOfAdviceP1"]objectForKey:@"Priority ID=\"1\""]objectForKey:@"InsuredName"],
     [[[DataDictionary objectForKey:@"eCFFRecordOfAdviceP1"]objectForKey:@"Priority ID=\"1\""]objectForKey:@"SA"],
     [[[DataDictionary objectForKey:@"eCFFRecordOfAdviceP1"]objectForKey:@"Priority ID=\"1\""]objectForKey:@"Reason"],
     [[[DataDictionary objectForKey:@"eCFFRecordOfAdviceP1"]objectForKey:@"Priority ID=\"1\""]objectForKey:@"Action"]];
    
    NSInteger RecCount = [[[DataDictionary objectForKey:@"eCFFRecordOfAdviceP1"]objectForKey:@"RecCount"]integerValue];
    
    id arrrecordodadvBenefits = [[[DataDictionary objectForKey:@"eCFFRecordOfAdviceP1"]objectForKey:@"Priority ID=\"1\""]objectForKey:@"RecordOfAdviceBenefits"];
    
    
    [RecordOfAdviceXML appendFormat:@"<RecordOfAdviceBenefits>"];
    
    for(int i=0; i<[arrrecordodadvBenefits count];i++)    {
        //NSDictionary *dictRiders=[arrAdditionalBenefits objectAtIndex:i];
        NSString *CDATA;
        
        
        
        NSMutableDictionary *dictRiders=[[NSMutableDictionary alloc]initWithDictionary:[[arrrecordodadvBenefits objectAtIndex:i] objectForKey:[NSString stringWithFormat:@"Rider ID = \"%d\"",1]]];
        
        
        [RecordOfAdviceXML appendFormat:[NSString stringWithFormat:@"<Rider ID=\"%d\">",i+1]];
        
        [RecordOfAdviceXML appendFormat:@"<RiderName><![CDATA[%@]]></RiderName>", [dictRiders objectForKey:@"RiderName"]];
        
        [RecordOfAdviceXML appendFormat:@"</Rider>"];
        //NSMutableString *lStr = [[NSMutableString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
        
    }
    
    [RecordOfAdviceXML appendFormat:@"</RecordOfAdviceBenefits></Priority>"];
    
    
    //[RecordOfAdviceXML appendFormat:@"</Priority>"];
    // NSLog(@"%@",[[DataDictionary objectForKey:@"eCFFRecoredOfAdviceP2"]objectForKey:@"Priority ID=\"2\""]);
    
    if([[[DataDictionary objectForKey:@"eCFFRecordOfAdviceP1"]objectForKey:@"RecCount"] intValue]==2)
    {
    
    [RecordOfAdviceXML appendFormat:@"<Priority ID=\"2\"><Seq>%@</Seq><SameAsQuotation>%@</SameAsQuotation><PlanType><![CDATA[%@]]></PlanType><Term>%@</Term><InsurerName>%@</InsurerName><InsuredName>%@</InsuredName><SA>%@</SA><Reason><![CDATA[%@]]></Reason><Action><![CDATA[%@]]></Action>",
     //[[DataDictionary objectForKey:@"eCFFRecordOfAdviceP1"]objectForKey:@"RecCount"],
     [[[DataDictionary objectForKey:@"eCFFRecoredOfAdviceP2"]objectForKey:@"Priority ID=\"2\""]objectForKey:@"Seq"],
     [[[DataDictionary objectForKey:@"eCFFRecoredOfAdviceP2"]objectForKey:@"Priority ID=\"2\""]objectForKey:@"SameAsQuotation"],
     [[[DataDictionary objectForKey:@"eCFFRecoredOfAdviceP2"]objectForKey:@"Priority ID=\"2\""]objectForKey:@"PlanType"],
     [[[DataDictionary objectForKey:@"eCFFRecoredOfAdviceP2"]objectForKey:@"Priority ID=\"2\""]objectForKey:@"Term"],
     [[[DataDictionary objectForKey:@"eCFFRecoredOfAdviceP2"]objectForKey:@"Priority ID=\"2\""]objectForKey:@"InsurerName"],
     [[[DataDictionary objectForKey:@"eCFFRecoredOfAdviceP2"]objectForKey:@"Priority ID=\"2\""]objectForKey:@"InsuredName"],
     [[[DataDictionary objectForKey:@"eCFFRecoredOfAdviceP2"]objectForKey:@"Priority ID=\"2\""]objectForKey:@"SA"],
     [[[DataDictionary objectForKey:@"eCFFRecoredOfAdviceP2"]objectForKey:@"Priority ID=\"2\""]objectForKey:@"Reason"],
     [[[DataDictionary objectForKey:@"eCFFRecoredOfAdviceP2"]objectForKey:@"Priority ID=\"2\""]objectForKey:@"Action"]];
    
    
    id arrrecordodadvBenefits2 = [[[DataDictionary objectForKey:@"eCFFRecoredOfAdviceP2"]objectForKey:@"Priority ID=\"2\""]objectForKey:@"RecordOfAdviceBenefits"];
    
    
    [RecordOfAdviceXML appendFormat:@"<RecordOfAdviceBenefits>"];
    
    if (![arrrecordodadvBenefits2 length]==0)
    {
        
        [RecordOfAdviceXML appendFormat:@"<Rider ID=\"1\"><RiderName><![CDATA[%@]]></RiderName></Rider>",
         
         [[[DataDictionary objectForKey:@"eCFFRecoredOfAdviceP2"]objectForKey:@"Priority ID=\"2\""]objectForKey:@"RecordOfAdviceBenefits"]];
        
    }
    [RecordOfAdviceXML appendFormat:@"</RecordOfAdviceBenefits></Priority>"];
    }
    
    [RecordOfAdviceXML appendFormat:@"</RecordOfAdvice>"];
    return RecordOfAdviceXML;
}
-(id)getConfirmationOfAdviceGivenTo:(NSDictionary*)DataDictionary
{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *ConfirmationOfAdviceGivenToXML = [NSMutableString string];
    [ConfirmationOfAdviceGivenToXML appendFormat:@"<ConfirmationOfAdviceGivenTo><Choice1>%@</Choice1><Choice2>%@</Choice2><Choice3>%@</Choice3><Choice4>%@</Choice4><Choice5>%@</Choice5><Choice6>%@</Choice6><Choice6_desc><![CDATA[%@]]></Choice6_desc>",
     // [[DataDictionary objectForKey:@"eCFFRecordOfAdviceP1"]objectForKey:@"RecCount"],
     [[DataDictionary objectForKey:@"eCFFConfirmationAdviceGivenTo"] objectForKey:@"Choice1" ],
     [[DataDictionary objectForKey:@"eCFFConfirmationAdviceGivenTo"] objectForKey:@"Choice2" ],
     [[DataDictionary objectForKey:@"eCFFConfirmationAdviceGivenTo"] objectForKey:@"Choice3" ],
     [[DataDictionary objectForKey:@"eCFFConfirmationAdviceGivenTo"] objectForKey:@"Choice4" ],
     [[DataDictionary objectForKey:@"eCFFConfirmationAdviceGivenTo"] objectForKey:@"Choice5" ],
     [[DataDictionary objectForKey:@"eCFFConfirmationAdviceGivenTo"] objectForKey:@"Choice6" ],
     [[DataDictionary objectForKey:@"eCFFConfirmationAdviceGivenTo"]objectForKey:@"Choice6_desc" ]];
    
    id eventsArray = [DataDictionary objectForKey:@"eCFFConfirmationAdviceGivenTo"];
    
    
    [ConfirmationOfAdviceGivenToXML appendFormat:@"</ConfirmationOfAdviceGivenTo>"];
    return ConfirmationOfAdviceGivenToXML;
    
    
    
    
}

-(id)getProductRecommended:(NSDictionary*)DataDictionary
{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    
    NSMutableString *ProductRecommendedXML = [NSMutableString string];
    
    [ProductRecommendedXML appendFormat:@"<ProductRecommended>"];
    
  //  [ProductRecommendedXML appendFormat:@"<RecCount>%@</RecCount>",[DataDictionary objectForKey:@"RecCount"]];
    [ProductRecommendedXML appendFormat:@"<RecCount>%@</RecCount>",[[[DataDictionary objectForKey:@"eCFFRecommendedProducts"] firstObject]objectForKey:@"RecCount"]];
    for(int i=0; i< [[DataDictionary objectForKey:@"eCFFRecommendedProducts"] count] ; i++)
    {
        
        id eventsArray=[[[DataDictionary objectForKey:@"eCFFRecommendedProducts"] objectAtIndex:i]
                        objectForKey:[NSString stringWithFormat:@"RecommendationInfo ID=\"%d\"",i+1]];
        
        [ProductRecommendedXML appendFormat:@"<RecommendationInfo ID=\"%d\">",i+1];
        [ProductRecommendedXML appendFormat:@"<Seq>%@</Seq>",[eventsArray objectForKey:@"Seq"]];
        [ProductRecommendedXML appendFormat:@"<InsuredName>%@</InsuredName>",[eventsArray objectForKey:@"InsuredName"]];
        [ProductRecommendedXML appendFormat:@"<PlanType><![CDATA[%@]]></PlanType>",[eventsArray objectForKey:@"PlanType"]];
        [ProductRecommendedXML appendFormat:@"<Term>%@</Term>",[eventsArray objectForKey:@"Term"]];
        [ProductRecommendedXML appendFormat:@"<Premium>%@</Premium>",[eventsArray objectForKey:@"Premium"]];
        [ProductRecommendedXML appendFormat:@"<Frequency>%@</Frequency>",[eventsArray objectForKey:@"Frequency"]];
        [ProductRecommendedXML appendFormat:@"<SA>%@</SA>",[eventsArray objectForKey:@"SA"]];
        [ProductRecommendedXML appendFormat:@"<BoughtOpt>%@</BoughtOpt>",[eventsArray objectForKey:@"BoughtOpt"]];
        [ProductRecommendedXML appendFormat:@"<AddNew>%@</AddNew>",[eventsArray objectForKey:@"AddNew"]];
        //[ProductRecommendedXML appendFormat:@"<AdditionalBenefits>%@</AdditionalBenefits>",[eventsArray objectForKey:@"AdditionalBenefits"]];
        
        id arrAdditionalBenefits=[eventsArray objectForKey:@"AdditionalBenefits"] ;
        
        [ProductRecommendedXML appendFormat:@"<AdditionalBenefits>"];
        int j;
        for(int j=0; j<[arrAdditionalBenefits count];j++)
        {
            // NSDictionary *dictRiders=[arrAdditionalBenefits objectAtIndex:i];
            
            NSDictionary *dictRiders=[[arrAdditionalBenefits objectAtIndex:j] objectForKey:[NSString stringWithFormat:@"Rider ID = \"%d\"",j+1]];
            [ProductRecommendedXML appendFormat:[NSString stringWithFormat:@"<RecommendedRider ID=\"%d\">",j+1]];
            [ProductRecommendedXML appendFormat:@"<RiderName><![CDATA[%@]]></RiderName>",[dictRiders objectForKey:@"RiderName"]];
            [ProductRecommendedXML appendFormat:@"</RecommendedRider>"];
        }
        [ProductRecommendedXML appendFormat:@"</AdditionalBenefits>"];
        
        [ProductRecommendedXML appendFormat:@"</RecommendationInfo>"];
    }
    [ProductRecommendedXML appendFormat:@"</ProductRecommended>"];
    return ProductRecommendedXML;
    
}

-(id)getiMobileExtraInfo:(NSDictionary*)DataDictionary
{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *iMobileExtraInfoToXML = [NSMutableString string];
    [iMobileExtraInfoToXML appendFormat:@"<iMobileExtraInfo><Guardian><GuardianName>%@</GuardianName><GuardianNewIC>%@</GuardianNewIC>",
     
     [[DataDictionary objectForKey:@"iMobileExtraInfo"] objectForKey:@"GuardianName" ],
     [[DataDictionary objectForKey:@"iMobileExtraInfo"]objectForKey:@"GuardianNewICNo" ]];
    
    [iMobileExtraInfoToXML appendFormat:@"</Guardian></iMobileExtraInfo>"];
    return iMobileExtraInfoToXML;
}


-(id)getSignInfo:(NSDictionary*)DataDictionary
{
    DataDictionary=[DataDictionary dictionaryByReplacingNullsWithBlanks];
    NSMutableString *SignInfoToXML = [NSMutableString string];
    [SignInfoToXML appendFormat:@"<SignInfo><SIGNDATE></SIGNDATE><SIGNAT></SIGNAT><SIGNFASSURED1>N</SIGNFASSURED1><SIGNFASSURED2>N</SIGNFASSURED2><SIGNFPOLOWNER>N</SIGNFPOLOWNER><SIGNFCONOWNER>N</SIGNFCONOWNER><SIGNFTRUSTEE1>N</SIGNFTRUSTEE1><SIGNFTRUSTEE2>N</SIGNFTRUSTEE2><SIGNFPARENTS>N</SIGNFPARENTS><SIGNFWITNESS>N</SIGNFWITNESS><SIGNFCARDHOLDER>N</SIGNFCARDHOLDER>",
     // [[DataDictionary objectForKey:@"eCFFRecordOfAdviceP1"]objectForKey:@"RecCount"],
     [[DataDictionary objectForKey:@"eCFFConfirmationAdviceGivenTo"] objectForKey:@"SIGNFASSURED1" ],
     [[DataDictionary objectForKey:@"eCFFConfirmationAdviceGivenTo"] objectForKey:@"SIGNFASSURED2" ],
     [[DataDictionary objectForKey:@"eCFFConfirmationAdviceGivenTo"] objectForKey:@"SIGNFPOLOWNER" ],
     [[DataDictionary objectForKey:@"eCFFConfirmationAdviceGivenTo"] objectForKey:@"SIGNFCONOWNER" ],
     [[DataDictionary objectForKey:@"eCFFConfirmationAdviceGivenTo"] objectForKey:@"SIGNFTRUSTEE1" ],
     [[DataDictionary objectForKey:@"eCFFConfirmationAdviceGivenTo"] objectForKey:@"SIGNFTRUSTEE2" ],
     [[DataDictionary objectForKey:@"eCFFConfirmationAdviceGivenTo"] objectForKey:@"SIGNFPARENTS" ],
     [[DataDictionary objectForKey:@"eCFFConfirmationAdviceGivenTo"] objectForKey:@"SIGNFWITNESS" ],
     [[DataDictionary objectForKey:@"eCFFConfirmationAdviceGivenTo"] objectForKey:@"SIGNFCARDHOLDER" ],
     
          
     [[DataDictionary objectForKey:@"eCFFConfirmationAdviceGivenTo"]objectForKey:@"Choice6_desc" ]];
    
    id eventsArray = [DataDictionary objectForKey:@"eCFFConfirmationAdviceGivenTo"];
    
    
    [SignInfoToXML appendFormat:@"</SignInfo>"];
    return SignInfoToXML;
}

-(id)parserNSDictionarytoXML:(NSDictionary*)Dictionary
{
    
    NSMutableString *String = [NSMutableString string];
    [Dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop){
        [String appendFormat:@"<%@>%@</%@>", key, value, key];
    }];
    return String;
}
@end

