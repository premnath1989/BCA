//
//  PRPage9.m
//  PDF
//
//  Created by Travel Chu on 3/19/14.
//  Copyright (c) 2014 Nexstream. All rights reserved.
//

#import "PRPage9.h"
#import "PRHtmlHandler.h"
#import "FMDatabase.h"
#import "FMResultSet.h"


@implementation PRPage9
+(NSString*)prPage9WithDictionary:(NSDictionary*)dicttionary{
    NSString *page=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PR_page9" ofType:@"al" inDirectory:@"PDFCreater.bundle"] encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    NSString *proposalNo= dicttionary[@"AssuredInfo"][@"eProposalNo"];
    
    
     // 4th Nominees Section   
    NSArray *arrayNom=nil;
    if ([dicttionary[@"NomineeInfo"][@"Nominee"] isKindOfClass:[NSDictionary class]]) {
        arrayNom=[NSArray arrayWithObject:dicttionary[@"NomineeInfo"][@"Nominee"]];
    }else if ([dicttionary[@"NomineeInfo"][@"Nominee"] isKindOfClass:[NSArray class]]){
        arrayNom=dicttionary[@"NomineeInfo"][@"Nominee"];
    }
    if (arrayNom) {
        for (NSDictionary *dict in arrayNom) {
            NSString *getID = dict[@"ID"];
            if ([dict[@"ID"] isEqualToString:@"4"]) {
            
            NSString *str=[NSString stringWithFormat:@"##name%@##",dict[@"ID"]];
            page=[page stringByReplacingString:str withString:dict[@"NMName"]];
            str=[NSString stringWithFormat:@"##share%@##",dict[@"ID"]];
            page=[page stringByReplacingString:str withString:dict[@"NMShare"]];
            NSString *icNO=dict[@"NMNewIC"][@"NMNewICNo"];
            if (icNO.length==12) {
                str=[NSString stringWithFormat:@"##ICNo%@.1##",dict[@"ID"]];
                page=[page stringByReplacingString:str withString:[icNO substringToIndex:6]];
                icNO=[icNO substringFromIndex:6];
                str=[NSString stringWithFormat:@"##ICNo%@.2##",dict[@"ID"]];
                page=[page stringByReplacingString:str withString:[icNO substringToIndex:2]];
                str=[NSString stringWithFormat:@"##ICNo%@.3##",dict[@"ID"]];
                page=[page stringByReplacingString:str withString:[icNO substringFromIndex:2]];
            }
            str=[NSString stringWithFormat:@"##otherIC%@##",dict[@"ID"]];
            //            if (dict[@"NMOtherID"][@"NMOtherID"]) {
            //                page=[page stringByReplacingString:str withString:dict[@"NMOtherID"][@"NMOtherID"]];
            //            }
            if (dict[@"NMOtherID"]) {
                page=[page stringByReplacingString:str withString:dict[@"NMOtherID"]];
            }
            str=[NSString stringWithFormat:@"##Relationship%@##",dict[@"ID"]];
            NSString *relation=[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getRelationByCode:dict[@"NMRelationship"]];
            page=[page stringByReplacingString:str withString:relation];

            if (dict[@"NMDOB"]) {
                NSArray *birth=[dict[@"NMDOB"] componentsSeparatedByString:@"/"];
                if (birth.count==3) {
                    str=[NSString stringWithFormat:@"##day%@##",dict[@"ID"]];
                    page=[page stringByReplacingString:str withString:birth[0]];
                    str=[NSString stringWithFormat:@"##month%@##",dict[@"ID"]];
                    page=[page stringByReplacingString:str withString:birth[1]];
                    str=[NSString stringWithFormat:@"##year%@##",dict[@"ID"]];
                    page=[page stringByReplacingString:str withString:birth[2]];
                }
            }

                // retrieving information from database
                NSString *nationality;
                NSString *nameOfEmployer;
                NSString *occupation;
                NSString *exactDuty;

                NSString *add1;
                NSString *add2;
                NSString *add3;
                NSString *town;
                NSString *state;
                NSString *postcode;
                NSString *country;
                NSString *sameAsPO;
                NSString *CRadd1;
                NSString *CRadd2;
                NSString *CRadd3;
                NSString *CRtown;
                NSString *CRstate;
                NSString *CRpostcode;
                NSString *CRcountry;
                
                
                FMResultSet *getNominee = [database executeQuery:@"select * from eProposal_NM_Details where eProposalNo = ? and NMName = ?",proposalNo,dict[@"NMName"]];
                while ([getNominee next]) {
                    nationality=[getNominee objectForColumnName:@"NMNationality"];
                    nameOfEmployer=[getNominee objectForColumnName:@"NMNameOfEmployer"];
                    occupation=[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getOccupationByCode:[getNominee objectForColumnName:@"NMOccupation"]];
                    exactDuty=[getNominee objectForColumnName:@"NMExactDuties"];
                    
                    add1=[getNominee objectForColumnName:@"NMAddress1"];
                    add2=[getNominee objectForColumnName:@"NMAddress2"];
                    add3=[getNominee objectForColumnName:@"NMAddress3"];
                    town=[getNominee objectForColumnName:@"NMTown"];
                    state=[getNominee objectForColumnName:@"NMState"];
                    postcode=[getNominee objectForColumnName:@"NMPostcode"];
                    country=[getNominee objectForColumnName:@"NMCountry"];
                    sameAsPO=[getNominee objectForColumnName:@"NMSamePOAddress"];
                    CRadd1=[getNominee objectForColumnName:@"NMCRAddress1"];
                    CRadd2=[getNominee objectForColumnName:@"NMCRAddress2"];
                    CRadd3=[getNominee objectForColumnName:@"NMCRAddress3"];
                    CRtown=[getNominee objectForColumnName:@"NMCRTown"];
                    CRstate=[getNominee objectForColumnName:@"NMCRState"];
                    CRpostcode=[getNominee objectForColumnName:@"NMCRPostcode"];
                    CRcountry=[getNominee objectForColumnName:@"NMCRCountry"];
                }
                
                if ([nationality isEqualToString:@"MY"]) {
                    str=[NSString stringWithFormat:@"##nationality%@.malaysian##",dict[@"ID"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                }else
                {
                    str=[NSString stringWithFormat:@"##nationality%@.malaysian##",dict[@"ID"]];
                    page=[page stringByReplacingString:str withString:@"◻︎"];
                    str=[NSString stringWithFormat:@"##nationality%@.others##",dict[@"ID"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                    str=[NSString stringWithFormat:@"##nationality%@.others2##",dict[@"ID"]];
                    page=[page stringByReplacingString:str withString:[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getNationalityByCode:nationality]];
                }
                
                str=[NSString stringWithFormat:@"##nameofemployer%@##",dict[@"ID"]];
                page=[page stringByReplacingString:str withString:nameOfEmployer];
                
                NSString *natureOfWork=[NSString stringWithFormat:@"%@ - %@",occupation,exactDuty];
                str=[NSString stringWithFormat:@"##natureOfWork%@##",dict[@"ID"]];
                page=[page stringByReplacingString:str withString:natureOfWork];
                
                // Residential Address
                NSString *addL1=[NSString stringWithFormat:@"%@ %@ %@",add1,add2,add3];
                NSString *addL2=[NSString stringWithFormat:@"%@ %@ %@",town,[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getStateByCode:state],[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getCountryByCode:country]];
                str=[NSString stringWithFormat:@"##N%@.6Line1##",dict[@"ID"]];
                page=[page stringByReplacingString:str withString:addL1];
                str=[NSString stringWithFormat:@"##N%@.6Line2##",dict[@"ID"]];
                page=[page stringByReplacingString:str withString:addL2];
				
				if  ((NSNull *) postcode == [NSNull null])
                    postcode = @"";
                str=[NSString stringWithFormat:@"##N%@.6bpostcode##",dict[@"ID"]];
                page=[page stringByReplacingString:str withString:postcode];
                
                if ([sameAsPO isEqualToString:@"same"]) {
                    str=[NSString stringWithFormat:@"##sameaddr%@.1##",dict[@"ID"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                    str=[NSString stringWithFormat:@"##N%@.6CRLine1##",dict[@"ID"]];
                    page=[page stringByReplacingString:str withString:@"Same address as Policy Owner"];
                    
                }else{
                    str=[NSString stringWithFormat:@"##sameaddr%@.2##",dict[@"ID"]];
                    page=[page stringByReplacingString:str withString:@"◼︎"];
                    
                    // Correspondence Address
                    NSString *CRaddL1=[NSString stringWithFormat:@"%@ %@ %@",CRadd1,CRadd2,CRadd3];
                    NSString *CRaddL2=[NSString stringWithFormat:@"%@ %@ %@",CRtown,[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getStateByCode:CRstate],[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getCountryByCode:CRcountry]];
                    str=[NSString stringWithFormat:@"##N%@.6CRLine1##",dict[@"ID"]];
                    page=[page stringByReplacingString:str withString:CRaddL1];
                    str=[NSString stringWithFormat:@"##N%@.6CRLine2##",dict[@"ID"]];
                    page=[page stringByReplacingString:str withString:CRaddL2];
                    str=[NSString stringWithFormat:@"##N%@.6CRbpostcode##",dict[@"ID"]];
					if  ((NSNull *) CRpostcode == [NSNull null])
						CRpostcode = @"";
                    page=[page stringByReplacingString:str withString:CRpostcode];
                }
                
                
        }
    }

   } 
    
    
    
    
    // Trustee Section
    NSArray *array=nil;
    if ([dicttionary[@"TrusteeInfo"][@"Trustee"] isKindOfClass:[NSDictionary class]]) {
        array=[NSArray arrayWithObject:dicttionary[@"TrusteeInfo"][@"Trustee"]];
    }else if ([dicttionary[@"TrusteeInfo"][@"Trustee"] isKindOfClass:[NSArray class]]){
        array=dicttionary[@"TrusteeInfo"][@"Trustee"];
    }

    if (array) {
        for (NSDictionary *dict in array) {
            NSString *str=[NSString stringWithFormat:@"##trusteeName%@##",dict[@"ID"]];
            page=[page stringByReplacingString:str withString:dict[@"TrusteeName"]];
            NSString *icNO=dict[@"TRNewIC"][@"TRNewICNo"];
            if (icNO.length==12) {
                str=[NSString stringWithFormat:@"##TrustICNo%@.1##",dict[@"ID"]];
                page=[page stringByReplacingString:str withString:[icNO substringToIndex:6]];
                icNO=[icNO substringFromIndex:6];
                str=[NSString stringWithFormat:@"##TrustICNo%@.2##",dict[@"ID"]];
                page=[page stringByReplacingString:str withString:[icNO substringToIndex:2]];
                str=[NSString stringWithFormat:@"##TrustICNo%@.3##",dict[@"ID"]];
                page=[page stringByReplacingString:str withString:[icNO substringFromIndex:2]];
            }
            str=[NSString stringWithFormat:@"##TrustOtherIDNo%@##",dict[@"ID"]];
            page=[page stringByReplacingString:str withString:dict[@"TROtherID"][@"TrusteeOtherID"]];
            if (dict[@"TrusteeAddr"]) {
                    NSString *addL1=[NSString stringWithFormat:@"%@ %@ %@",dict[@"TrusteeAddr"][@"Address1"],dict[@"TrusteeAddr"][@"Address2"],dict[@"TrusteeAddr"][@"Address3"]];
                    NSString *addL2=[NSString stringWithFormat:@"%@",dict[@"TrusteeAddr"][@"Town"]];
                    NSString *addL3=[NSString stringWithFormat:@"%@ %@",[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getStateByCode:dict[@"TrusteeAddr"][@"State"]],[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getCountryByCode:dict[@"TrusteeAddr"][@"Country"]]];

                
                    NSString *isSameAsPo = dict[@"TrusteeAddr"][@"AddressSameAsPO"];
                    if ([isSameAsPo isEqualToString:@"Y"]) {
                        str=[NSString stringWithFormat:@"##trustee%@.sameaspo.yes##",dict[@"ID"]];
                        page=[page stringByReplacingString:str withString:@"◼︎"];

                        str=[NSString stringWithFormat:@"##%@.6Line1##",dict[@"ID"]];
                        page=[page stringByReplacingString:str withString:@"Same address as Policy Owner"];
                        
                    }
                    else if ([isSameAsPo isEqualToString:@"N"]){
                        str=[NSString stringWithFormat:@"##trustee%@.sameaspo.no##",dict[@"ID"]];
                        page=[page stringByReplacingString:str withString:@"◼︎"];
                        
                        str=[NSString stringWithFormat:@"##%@.6Line1##",dict[@"ID"]];
                        page=[page stringByReplacingString:str withString:addL1];
                        str=[NSString stringWithFormat:@"##%@.6Line2##",dict[@"ID"]];
                        page=[page stringByReplacingString:str withString:addL2];
                        str=[NSString stringWithFormat:@"##%@.6Line3##",dict[@"ID"]];
                        page=[page stringByReplacingString:str withString:addL3];
                        str=[NSString stringWithFormat:@"##%@.6Postcode##",dict[@"ID"]];
                        page=[page stringByReplacingString:str withString:dict[@"TrusteeAddr"][@"Postcode"]];
                        
                    }
                
                   // page = [page stringByReplacingString:@"##addques.insured.No##" withString:@"◼︎??"];

            }
        }
    }
    
    
    
    NSString *str=[NSString stringWithFormat:@"##name4##"];
    page=[page stringByReplacingString:str withString:@""];
    str=[NSString stringWithFormat:@"##share4##"];
    page=[page stringByReplacingString:str withString:@""];
    str=[NSString stringWithFormat:@"##ICNo4.1##"];
    page=[page stringByReplacingString:str withString:@""];
    str=[NSString stringWithFormat:@"##ICNo4.2##"];
    page=[page stringByReplacingString:str withString:@""];
    str=[NSString stringWithFormat:@"##ICNo4.3##"];
    page=[page stringByReplacingString:str withString:@""];
    str=[NSString stringWithFormat:@"##otherIC4##"];
    page=[page stringByReplacingString:str withString:@""];
    str=[NSString stringWithFormat:@"##Relationship4##"];
    page=[page stringByReplacingString:str withString:@""];
    
    str=[NSString stringWithFormat:@"##nationality4.malaysian##"];
    page=[page stringByReplacingString:str withString:@"◻︎"];
    str=[NSString stringWithFormat:@"##nationality4.others##"];
    page=[page stringByReplacingString:str withString:@"◻︎"];
    str=[NSString stringWithFormat:@"##nationality4.others2##"];
    page=[page stringByReplacingString:str withString:@""];
    str=[NSString stringWithFormat:@"##nameofemployer4##"];
    page=[page stringByReplacingString:str withString:@""];
    str=[NSString stringWithFormat:@"##natureOfWork4##"];
    page=[page stringByReplacingString:str withString:@""];
    
    str=[NSString stringWithFormat:@"##sameaddr4.1##"];
    page=[page stringByReplacingString:str withString:@"◻︎"];
    str=[NSString stringWithFormat:@"##sameaddr4.2##"];
    page=[page stringByReplacingString:str withString:@"◻︎"];
    str=[NSString stringWithFormat:@"##N4.6Line1##"];
    page=[page stringByReplacingString:str withString:@""];
    str=[NSString stringWithFormat:@"##N4.6Line2##"];
    page=[page stringByReplacingString:str withString:@""];
    str=[NSString stringWithFormat:@"##N4.6bpostcode##"];
    page=[page stringByReplacingString:str withString:@""];

    str=[NSString stringWithFormat:@"##N4.6CRLine1##"];
    page=[page stringByReplacingString:str withString:@""];
    str=[NSString stringWithFormat:@"##N4.6CRLine2##"];
    page=[page stringByReplacingString:str withString:@""];
    str=[NSString stringWithFormat:@"##N4.6CRbpostcode##"];
    page=[page stringByReplacingString:str withString:@""];
    
    
    str=[NSString stringWithFormat:@"##day4##"];
    page=[page stringByReplacingString:str withString:@""];
    str=[NSString stringWithFormat:@"##month4##"];
    page=[page stringByReplacingString:str withString:@""];
    str=[NSString stringWithFormat:@"##year4##"];
    page=[page stringByReplacingString:str withString:@""];
    
    
    
    page = [page stringByReplacingString:@"##trusteeName1##" withString:@""];
    page = [page stringByReplacingString:@"##TrustICNo1.1##" withString:@""];
    page = [page stringByReplacingString:@"##TrustICNo1.2##" withString:@""];
    page = [page stringByReplacingString:@"##TrustICNo1.3##" withString:@""];
    page = [page stringByReplacingString:@"##TrustOtherIDNo1##" withString:@""];    
    page = [page stringByReplacingString:@"##1.6Line1##" withString:@""];
    page = [page stringByReplacingString:@"##1.6Line2##" withString:@""];
    page = [page stringByReplacingString:@"##1.6Line3##" withString:@""];
    page = [page stringByReplacingString:@"##1.6Postcode##" withString:@""];
    page = [page stringByReplacingString:@"##trustee1.sameaspo.yes##" withString:@"◻︎"];
    page = [page stringByReplacingString:@"##trustee1.sameaspo.no##" withString:@"◻︎"];
    
    page = [page stringByReplacingString:@"##trusteeName2##" withString:@""];
    page = [page stringByReplacingString:@"##TrustICNo2.1##" withString:@""];
    page = [page stringByReplacingString:@"##TrustICNo2.2##" withString:@""];
    page = [page stringByReplacingString:@"##TrustICNo2.3##" withString:@""];
    page = [page stringByReplacingString:@"##TrustOtherIDNo2##" withString:@""];    
    page = [page stringByReplacingString:@"##2.6Line1##" withString:@""];
    page = [page stringByReplacingString:@"##2.6Line2##" withString:@""];
    page = [page stringByReplacingString:@"##2.6Line3##" withString:@""];
    page = [page stringByReplacingString:@"##2.6Postcode##" withString:@""];    
    page = [page stringByReplacingString:@"##trustee2.sameaspo.yes##" withString:@"◻︎"];
    page = [page stringByReplacingString:@"##trustee2.sameaspo.no##" withString:@"◻︎"];
    
    page = [page stringByReplacingString:@"##husbandFatherName##" withString:@""];
    page = [page stringByReplacingString:@"##yearlyIncome##" withString:@""];
    page = [page stringByReplacingString:@"##addques.occupation##" withString:@""];
    page = [page stringByReplacingString:@"##addques.insured.Yes##" withString:@"◻︎"];
    page = [page stringByReplacingString:@"##addques.insured.No##" withString:@"◻︎"];
    page = [page stringByReplacingString:@"##addques.reason##" withString:@""];
    
    
    
    [PRHtmlHandler sharedPRHtmlHandler].currentPage++;
    page=[[PRHtmlHandler sharedPRHtmlHandler] handleWatermarkForString:page];
    return page;
}
@end
