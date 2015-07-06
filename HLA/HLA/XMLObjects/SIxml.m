//
//  SIxml.m
//  HLAInfoConnect
//
//  Created by compurex on 12/30/13.
//  Copyright (c) 2013 compurex. All rights reserved.
//

#import "SIxml.h"
@implementation SIxml{
    
    NSString *referenceNo;
    
}

-(void)GenerateSIXML:(NSDictionary*)DataDictionary RNNumber:(NSString*) RNNumber
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
    id eventsArray = [DataDictionary objectForKey:@"eSystemInfo"];
    [XMLString appendFormat:@"<eApps><eSystemInfo>%@</eSystemInfo><SIDetails><eProposalNo>%@</eProposalNo><CommencementDate>%@</CommencementDate><SINo>%@</SINo><SIVersion>%@</SIVersion><SIType>%@</SIType>%@%@%@%@</FundAllocation></SIDetails></eApps>",[self parserNSDictionarytoXML:eventsArray],referenceNo,
     [[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"]objectForKey:@"CommencementDate"],
     [[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"SINo"],
     [[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"SIVersion"],
     [[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"SIType"],
     [self getAgentInfo:DataDictionary],
     [self getBasicPlan:DataDictionary],
     [self getParties:DataDictionary],
     [self getFundAllocation:DataDictionary]];
    [[NSFileManager defaultManager] createFileAtPath:[[NSString stringWithFormat:@"~/Documents/SIXML/%@_SI.xml",referenceNo] stringByExpandingTildeInPath]
                                            contents:[XMLString dataUsingEncoding:NSUTF8StringEncoding]
                                          attributes:nil];
    //HTTPPost *PostRequest = [[HTTPPost alloc]init];
    //[PostRequest HTTPPost:[NSString stringWithFormat:@"%@_SI.xml",[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"eProposalNo"]]];
}

-(id)getAgentInfo:(NSDictionary*)DataDictionary
{
    NSMutableString *AgentInfoXML = [NSMutableString string];
    
    [AgentInfoXML appendFormat:@"<AgentInfo><FirstAgentCode>%@</FirstAgentCode><FirstAgentName>%@</FirstAgentName><FirstAgentContact>%@</FirstAgentContact>",
     
     [[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"AgentInfo"]objectForKey:@"FirstAgentCode"],
     [[[[DataDictionary  objectForKey:@"SIDetails"] objectForKey:@"SIDetails"]objectForKey:@"AgentInfo"]objectForKey:@"FirstAgentName"],
     [[[[DataDictionary  objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"AgentInfo"]objectForKey:@"FirstAgentContact"]];
    id eventsArray = [[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"AgentInfo"];
    [AgentInfoXML appendFormat:@"</AgentInfo>"];
    return AgentInfoXML;
    
}

-(id)getBasicPlan:(NSDictionary*)DataDictionary
{
    NSMutableString *BasicPlanXML = [NSMutableString string];
    [BasicPlanXML appendFormat:@"<BasicPlan><PlanType>%@</PlanType><PTypeCode>%@</PTypeCode><Seq>%@</Seq><PlanCode>%@</PlanCode><PlanOption>%@</PlanOption><SumAssured>%@</SumAssured><CoverageUnit>%@</CoverageUnit><CoverageTerm>%@</CoverageTerm><PayingTerm>%@</PayingTerm><PaymentMode>%@</PaymentMode><PaymentAmount>%@</PaymentAmount><Deductible>%@</Deductible>",
     
     [[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"BasicPlan"]objectForKey:@"PlanType"],
     [[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"BasicPlan"]objectForKey:@"PTypeCode"],
     [[[[DataDictionary  objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"BasicPlan"]objectForKey:@"Seq"],
     [[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"BasicPlan"]objectForKey:@"PlanCode"],
     [[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"BasicPlan"]objectForKey:@"PlanOption"],
     [[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"BasicPlan"]objectForKey:@"SumAssured"],
     [[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"BasicPlan"]objectForKey:@"CoverageUnit"],
     [[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"]objectForKey:@"BasicPlan"]objectForKey:@"CoverageTerm"],
     [[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"BasicPlan"]objectForKey:@"PayingTerm"],
     [[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"BasicPlan"]objectForKey:@"PaymentMode"],
     [[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"BasicPlan"]objectForKey:@"PaymentAmount"],
     [[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"BasicPlan"]objectForKey:@"Deductible"]];
    
    id eventsArray = [[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"BasicPlan"];
    [BasicPlanXML appendFormat:@"</BasicPlan>"];
    return BasicPlanXML;
    
    
    
}

-(id)getParties:(NSDictionary*)DataDictionary
{
    NSInteger PartyCount = [[[[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"Parties"] objectAtIndex:0]objectForKey:@"PartyCount"] intValue];
    NSMutableString *Parties = [NSMutableString string];
    [Parties appendFormat:@"<Parties><PartyCount>%@</PartyCount>",[[[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"Parties"] objectAtIndex:0]objectForKey:@"PartyCount"]];
    //    for(int i=1;i<PartyCount+1;i++)
    //    {
    [Parties appendFormat:@"%@",[self getParty:DataDictionary PartyID:1]];
    // }
    [Parties appendFormat:@"</Parties>"];
    return Parties;
}

-(id)getParty:(NSDictionary*)DataDictionary PartyID:(NSInteger)Numbering
{
    
    NSMutableString *RiderXML1 = [NSMutableString string];
    
    NSMutableString *RiderXML2 = [NSMutableString string];
    
    
    NSMutableString *PartyXML = [NSMutableString string];
    
    NSString *PartyID = [NSString stringWithFormat:@"%d", Numbering];
    
    
    
    if([[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"Parties"] count]>0)
        
    {
        
        
        
        
        
        
        
        int partyCount=[[[[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"Parties"] objectAtIndex:0] objectForKey:@"PartyCount"]  intValue];
        
        
        
        //For LA
        
        if(partyCount>=1)
            
        {
            
            [PartyXML appendFormat:@"<Party PTypeCode=\"LA\"><Seq>%@</Seq>",[[[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"Parties"] objectAtIndex:1] objectForKey:@"Seq"]];
            
            
            
            id eventsArray = [[[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"Parties"] objectAtIndex:1] objectForKey:@"Riders"];
            
            if([eventsArray count]>0)
                
            {
                
                
                
                [RiderXML1 appendFormat:@"<Riders>"];
                
                [RiderXML1 appendFormat:@"<RiderCount>%d</RiderCount>",[eventsArray count]-1];
                
                
                
                for(int i=1;i<[eventsArray count];i++)
                    
                {
                    
                    
                    
                    NSDictionary *ridersDict = [eventsArray objectAtIndex:i-1];
                    
                    [RiderXML1 appendFormat:@"<Rider ID=\"%d\">",i];
                    
                    
                    
                    [RiderXML1 appendFormat:@"<PlanType>%@</PlanType>",[ridersDict objectForKey:@"PlanType"]];
                    
                    [RiderXML1 appendFormat:@"<PlanCode>%@</PlanCode>",[ridersDict objectForKey:@"PlanCode"]];
                    
                    [RiderXML1 appendFormat:@"<PlanOption>%@</PlanOption>",[ridersDict objectForKey:@"PlanOption"]];
                    
                    [RiderXML1 appendFormat:@"<SumAssured>%@</SumAssured>",[ridersDict objectForKey:@"SumAssured"]];
                    
                    [RiderXML1 appendFormat:@"<CoverageUnit>%@</CoverageUnit>",[ridersDict objectForKey:@"CoverageUnit"]];
                    
                    [RiderXML1 appendFormat:@"<CoverageTerm>%@</CoverageTerm>",[ridersDict objectForKey:@"CoverageTerm"]];
                    
                    [RiderXML1 appendFormat:@"<PayingTerm>%@</PayingTerm>",[ridersDict objectForKey:@"PayingTerm"]];
                    
                    [RiderXML1 appendFormat:@"<PaymentMode>%@</PaymentMode>",[ridersDict objectForKey:@"PaymentMode"]];
                    
                    [RiderXML1 appendFormat:@"<PaymentAmount>%@</PaymentAmount>",[ridersDict objectForKey:@"PaymentAmount"]];
                    
                    [RiderXML1 appendFormat:@"<WOPAmount>%@</WOPAmount>",[ridersDict objectForKey:@"WOPAmount"]];
                    
                    [RiderXML1 appendFormat:@"<Deductible>%@</Deductible>",[ridersDict objectForKey:@"Deductible"]];
                    
                    [RiderXML1 appendFormat:@"<PaidUpOption>%@</PaidUpOption>",[ridersDict objectForKey:@"PaidUpOption"]];
                    
                    [RiderXML1 appendFormat:@"<PaidUpTerm>%@</PaidUpTerm>",[ridersDict objectForKey:@"PaidUpTerm"]];
                    
                    [RiderXML1 appendFormat:@"<GYIOption>%@</GYIOption>",[ridersDict objectForKey:@"GYIOption"]];
                    
                    
                    
                    
                    
                    [RiderXML1 appendFormat:@"</Rider>"];
                    
                    
                    
                }
                
                
                
                [RiderXML1 appendFormat:@"</Riders>"];
                
                
                [PartyXML appendString:RiderXML1];
                
                [PartyXML appendFormat:@"</Party>"];
                
            }
            
        }
        
        
        
        
        
        
        
        if(partyCount>=2)
            
        {
            
            [PartyXML appendFormat:@"<Party PTypeCode=\"LA\"><Seq>%@</Seq>",[[[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"Parties"] objectAtIndex:2] objectForKey:@"Seq"]];
            
            
            
            id eventsArray = [[[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"Parties"] objectAtIndex:2] objectForKey:@"Riders"];
            
            if([eventsArray count]>0)
                
            {
                
                
                
                [RiderXML2 appendFormat:@"<Riders>"];
                
                [RiderXML2 appendFormat:@"<RiderCount>%d</RiderCount>",[eventsArray count]-1];
                
                
                
                for(int i=1;i<[eventsArray count];i++)
                    
                {
                    
                    
                    
                    NSDictionary *ridersDict = [eventsArray objectAtIndex:i-1];
                    
                    [RiderXML2 appendFormat:@"<Rider ID=\"%d\">",i];
                    
                    
                    
                    [RiderXML2 appendFormat:@"<PlanType>%@</PlanType>",[ridersDict objectForKey:@"PlanType"]];
                    
                    [RiderXML2 appendFormat:@"<PlanCode>%@</PlanCode>",[ridersDict objectForKey:@"PlanCode"]];
                    
                    [RiderXML2 appendFormat:@"<PlanOption>%@</PlanOption>",[ridersDict objectForKey:@"PlanOption"]];
                    
                    [RiderXML2 appendFormat:@"<SumAssured>%@</SumAssured>",[ridersDict objectForKey:@"SumAssured"]];
                    
                    [RiderXML2 appendFormat:@"<CoverageUnit>%@</CoverageUnit>",[ridersDict objectForKey:@"CoverageUnit"]];
                    
                    [RiderXML2 appendFormat:@"<CoverageTerm>%@</CoverageTerm>",[ridersDict objectForKey:@"CoverageTerm"]];
                    
                    [RiderXML2 appendFormat:@"<PayingTerm>%@</PayingTerm>",[ridersDict objectForKey:@"PayingTerm"]];
                    
                    [RiderXML2 appendFormat:@"<PaymentMode>%@</PaymentMode>",[ridersDict objectForKey:@"PaymentMode"]];
                    
                    [RiderXML2 appendFormat:@"<PaymentAmount>%@</PaymentAmount>",[ridersDict objectForKey:@"PaymentAmount"]];
                    
                    [RiderXML2 appendFormat:@"<WOPAmount>%@</WOPAmount>",[ridersDict objectForKey:@"WOPAmount"]];
                    
                    [RiderXML2 appendFormat:@"<Deductible>%@</Deductible>",[ridersDict objectForKey:@"Deductible"]];
                    
                    [RiderXML2 appendFormat:@"<PaidUpOption>%@</PaidUpOption>",[ridersDict objectForKey:@"PaidUpOption"]];
                    
                    [RiderXML2 appendFormat:@"<PaidUpTerm>%@</PaidUpTerm>",[ridersDict objectForKey:@"PaidUpTerm"]];
                    
                    [RiderXML2 appendFormat:@"<GYIOption>%@</GYIOption>",[ridersDict objectForKey:@"GYIOption"]];
                    
                    
                    
                    
                    
                    [RiderXML2 appendFormat:@"</Rider>"];
                    
                    
                    
                }
                
                
                
                [RiderXML2 appendFormat:@"</Riders>"];
                
                
                
                [PartyXML appendString:RiderXML2];
                
            }
            
            
            
            
            
            
            
            
            
            [PartyXML appendFormat:@"</Party>"];
            
            
            
            
        }
        
    }
    
    
    
    return PartyXML;
    
}

-(id)getFundAllocation:(NSDictionary*)DataDictionary
{
    NSMutableString *FundAllocationXML = [NSMutableString string];
    [FundAllocationXML appendFormat:@"<FundAllocation>"];
    
    
    //
    //    <FundAllocation>
    //    <FundDateRange ID="1">
    //    <FundFrom>CD</FundFrom>
    //    <FundTo>25/11/2025</FundTo>
    //    <FundStrategy ID="1">
    //    <FundStraType>F</FundStraType>
    //    <FundStraCode>HEG2023</FundStraCode>
    //    <NPercent>0</NPercent>
    //    </FundStrategy>
    //    <FundStrategy ID="2">
    //    <FundStraType>F</FundStraType>
    //    <FundStraCode>HEG2025</FundStraCode>
    //    <NPercent>5</NPercent>
    //    </FundStrategy>
    //    ===================
    /*
     
     (lldb) po [[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"FundAllocation"]
     $2 = 0x1625df90 <__NSArrayM 0x1625df90>(
     {
     "FundDateRange ID : 1" =     {
     FundFrom = CD;
     "FundStrategy ID=1" =         {
     FundStraCode = HEG2023;
     FundStraType = F;
     NPercent = 0;
     };
     "FundStrategy ID=2" =         {
     FundStraCode = HEG2025;
     FundStraType = F;
     NPercent = 10;
     };
     },
     {
     "MaturityFundOption : 1" =     {
     FundCode = HEG2035;
     FundOption = FR;
     "ReinvestInfo ID=1" =         {
     FundCode = HEG2025;
     ReinvestPercent = "0.0";
     };
     "ReinvestInfo ID=2" =         {
     FundCode = HEG2028;
     ReinvestPercent = "0.0";
     };
     
     )
     */
    
    for (NSDictionary *dict in [[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"FundAllocation"])
        //for (int i=0;i<[[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"FundAllocation"] count] ; i++)
    {
        // NSDictionary *dict=[[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"FundAllocation"] objectAtIndex:i];
        NSString *key = [[dict allKeys] objectAtIndex:0];
        NSArray *componants = [key componentsSeparatedByString:@":"];
        int i;
        if (componants.count>=2) {
            i = [[componants objectAtIndex:1] intValue];
        }
        if ([key rangeOfString:@"FundDateRange ID"].location!=NSNotFound)
        {
            [FundAllocationXML appendFormat:@"%@",[self getFundDateRange:dict RangeID:i]];
        }
        else if ([key rangeOfString:@"MaturityFundOption"].location!=NSNotFound)
        {
            [FundAllocationXML appendFormat:@"%@",[self getMaturityFundOption:dict OptionID:i]];
        }
    }
    
    //    for(int i=1;i<[[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"FundAllocation"]count]+1;i++){
    //        NSDictionary *fundDict = [[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"FundAllocation"] objectAtIndex:i-1];
    //
    //        NSString *fundDate = [NSString stringWithFormat:@"FundDateRange ID : %d",i];
    //        NSString *maturity = [NSString stringWithFormat:@"MaturityFundOption ID : %d",i];
    //        if([fundDict objectForKey:fundDate])
    //        {
    //            [FundAllocationXML appendFormat:@"%@",[self getFundDateRange:fundDict RangeID:i]];
    //        }
    //        else if ([fundDict objectForKey:maturity])
    //        {
    //            [FundAllocationXML appendFormat:@"%@",[self getMaturityFundOption:fundDict OptionID:i]];
    //        }
    //    }
    
    //    for(int i=1;i<[[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"FundAllocation"]count]+1;i++){
    //         NSDictionary *fundDict = [[[[DataDictionary objectForKey:@"SIDetails"] objectForKey:@"SIDetails"] objectForKey:@"FundAllocation"] objectAtIndex:i-1];
    //        if([fundDict objectForKey:[NSString stringWithFormat:@"MaturityFundOption ID=\"%d\"",i]])
    //        {
    //            [FundAllocationXML appendFormat:@"%@",[self getMaturityFundOption:fundDict OptionID:i]];
    //        }
    //    }
    //[FundAllocationXML appendFormat:@"</FundAllocation>"];
    return FundAllocationXML;
}

-(id)getFundDateRange:(NSDictionary*)DataDictionary RangeID:(NSInteger)Numbering
{
    NSString *FundDateRangeID = [NSString stringWithFormat:@"%d", Numbering];
    NSMutableString *FundDateRangeXML = [NSMutableString string];
    NSString *fundRange = [NSString stringWithFormat:@"FundDateRange ID : %@",FundDateRangeID];
    [FundDateRangeXML appendFormat:@"<FundDateRange ID=\"%@\"><FundFrom>%@</FundFrom><FundTo>%@</FundTo>",FundDateRangeID,
     [[DataDictionary objectForKey:fundRange]objectForKey:@"FundFrom"],
     [[DataDictionary objectForKey:fundRange]objectForKey:@"FundTo"]];
    
    // for(int i=0;i<[[[[DataDictionary objectForKey:[NSString stringWithFormat:@"FundDateRange ID : %@",FundDateRangeID]] allKeys] sortedArrayUsingSelector:@selector(compare:)] count];i++)
    
    
    for(int i=0;i<[[DataDictionary objectForKey:fundRange] count]-2;i++)
    {
        // NSString *key = [[[[DataDictionary objectForKey:[NSString stringWithFormat:@"FundDateRange ID : %@",FundDateRangeID]] allKeys] sortedArrayUsingSelector:@selector(compare:)] objectAtIndex:i];
        // id events = [[DataDictionary objectForKey:[NSString stringWithFormat:@"FundDateRange ID : %@",FundDateRangeID]] objectForKey:key];
        // if ([events isKindOfClass:[NSDictionary class]]) {
        
        // FundStrategy ID
        
        
        
        id eventsArray =  [[DataDictionary objectForKey:fundRange] objectForKey:[NSString stringWithFormat:@"FundStrategy ID=%d",i+1]];
        
        [FundDateRangeXML appendFormat:@"<FundStrategy><FundStraType>%@</FundStraType><FundStraCode>%@</FundStraCode><NPercent>%@</NPercent>",[eventsArray objectForKey:@"FundStraType"],[eventsArray objectForKey:@"FundStraCode"],[eventsArray objectForKey:@"NPercent"]];
        
        [FundDateRangeXML appendFormat:@"</FundStrategy>"];
        
        //}
        
        
    }
    [FundDateRangeXML appendFormat:@"</FundDateRange>"];
    return FundDateRangeXML;
}

-(id)getMaturityFundOption:(NSDictionary*)DataDictionary OptionID:(NSInteger)Numbering
{
    NSString *MaturityFundOptionID = [NSString stringWithFormat:@"%d", Numbering];
    NSMutableString *MaturityFundOptionXML = [NSMutableString string];
    [MaturityFundOptionXML appendFormat:@"<MaturityFundOption ID=\"%@\"><FundCode>%@</FundCode><FundOption>%@</FundOption><ReinvestPercent>%@</ReinvestPercent><WithdrawPercent>%@</WithdrawPercent>",MaturityFundOptionID,
     
     [[DataDictionary objectForKey:[NSString stringWithFormat:@"MaturityFundOption : %@",MaturityFundOptionID]]objectForKey:@"FundCode"],
     [[DataDictionary objectForKey:[NSString stringWithFormat:@"MaturityFundOption : %@",MaturityFundOptionID]]objectForKey:@"FundOption"],
     [[DataDictionary objectForKey:[NSString stringWithFormat:@"MaturityFundOption : %@",MaturityFundOptionID]]objectForKey:@"ReinvestPercent"],
     [[DataDictionary objectForKey:[NSString stringWithFormat:@"MaturityFundOption : %@",MaturityFundOptionID]]objectForKey:@"WithdrawPercent"]];
    
    for(int i=0;i<[[[[DataDictionary objectForKey:[NSString stringWithFormat:@"MaturityFundOption : %@",MaturityFundOptionID]] allKeys] sortedArrayUsingSelector:@selector(compare:)] count];i++)
    {
        NSString *key = [[[[DataDictionary objectForKey:[NSString stringWithFormat:@"MaturityFundOption : %@",MaturityFundOptionID]] allKeys] sortedArrayUsingSelector:@selector(compare:)] objectAtIndex:i];
        id events = [[DataDictionary objectForKey:[NSString stringWithFormat:@"MaturityFundOption : %@",MaturityFundOptionID]] objectForKey:key];
        if ([events isKindOfClass:[NSDictionary class]]) {
            [MaturityFundOptionXML appendFormat:@"<%@>%@</ReinvestInfo>",key,[self parserNSDictionarytoXML:events]];
        }
        
        
    }
    //<FundCode>, <FundOption>, <ReinvestPercent> and <WithdrawPercent>
    //    for(int i=1;i<7;i++)
    //    {
    //        id eventsArray = [[DataDictionary objectForKey:[NSString stringWithFormat:@"MaturityFundOption ID=\"%@\"",MaturityFundOptionID]]objectForKey:[NSString stringWithFormat:@"ReinvestInfo ID=\"%d\"",i]];
    //        [MaturityFundOptionXML appendFormat:@"<ReinvestInfo ID=\"%d\">%@</ReinvestInfo>",i,[self parserNSDictionarytoXML:eventsArray]];
    //    }
    [MaturityFundOptionXML appendFormat:@"</MaturityFundOption>"];
    return MaturityFundOptionXML;
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




