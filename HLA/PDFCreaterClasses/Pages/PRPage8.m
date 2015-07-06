//
//  PRPage8.m
//  PDF
//
//  Created by Travel Chu on 3/19/14.
//  Copyright (c) 2014 Nexstream. All rights reserved.
//

#import "PRPage8.h"
#import "PRHtmlHandler.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

@implementation PRPage8
+(NSString*)prPage8WithDictionary:(NSDictionary*)dicttionary{
    NSString *page=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PR_page8" ofType:@"al" inDirectory:@"PDFCreater.bundle"] encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    NSString *proposalNo= dicttionary[@"AssuredInfo"][@"eProposalNo"];
    
    NSArray *array=nil;
    if ([dicttionary[@"NomineeInfo"][@"Nominee"] isKindOfClass:[NSDictionary class]]) {
        array=[NSArray arrayWithObject:dicttionary[@"NomineeInfo"][@"Nominee"]];
    }else if ([dicttionary[@"NomineeInfo"][@"Nominee"] isKindOfClass:[NSArray class]]){
        array=dicttionary[@"NomineeInfo"][@"Nominee"];
    }
    if (array) {
        for (NSDictionary *dict in array) {
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
            NSString *sameAsPO;
            NSString *postcode;
            NSString *country;
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
                str=[NSString stringWithFormat:@"##%@.6Line1##",dict[@"ID"]];
                page=[page stringByReplacingString:str withString:addL1];
                str=[NSString stringWithFormat:@"##%@.6Line2##",dict[@"ID"]];
                page=[page stringByReplacingString:str withString:addL2];
                if  ((NSNull *) postcode == [NSNull null])
                    postcode = @"";
            
            
                str=[NSString stringWithFormat:@"##%@.6bpostcode##",dict[@"ID"]];
                page=[page stringByReplacingString:str withString:postcode];

        
            if ([sameAsPO isEqualToString:@"same"]) {
                str=[NSString stringWithFormat:@"##sameaddr%@.1##",dict[@"ID"]];
                page=[page stringByReplacingString:str withString:@"◼︎"];
                str=[NSString stringWithFormat:@"##%@.6CRLine1##",dict[@"ID"]];
                page=[page stringByReplacingString:str withString:@"Same address as Policy Owner"];
                
            }else{
                str=[NSString stringWithFormat:@"##sameaddr%@.2##",dict[@"ID"]];
                page=[page stringByReplacingString:str withString:@"◼︎"];
                
                // Correspondence Address
                NSString *CRaddL1=[NSString stringWithFormat:@"%@ %@ %@",CRadd1,CRadd2,CRadd3];
                NSString *CRaddL2=[NSString stringWithFormat:@"%@ %@ %@",CRtown,[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getStateByCode:CRstate],[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getCountryByCode:CRcountry]];
                str=[NSString stringWithFormat:@"##%@.6CRLine1##",dict[@"ID"]];
                page=[page stringByReplacingString:str withString:CRaddL1];
                str=[NSString stringWithFormat:@"##%@.6CRLine2##",dict[@"ID"]];
                page=[page stringByReplacingString:str withString:CRaddL2];
                str=[NSString stringWithFormat:@"##%@.6CRbpostcode##",dict[@"ID"]];
				if  ((NSNull *) CRpostcode == [NSNull null])
                    CRpostcode = @"";
                page=[page stringByReplacingString:str withString:CRpostcode];
            }

            
            
        }
    }
    for (int i=1; i<5; i++) {
        NSString *str=[NSString stringWithFormat:@"##name%d##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##share%d##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##ICNo%d.1##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##ICNo%d.2##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##ICNo%d.3##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##otherIC%d##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##Relationship%d##",i];
        page=[page stringByReplacingString:str withString:@""];
        
        str=[NSString stringWithFormat:@"##nationality%d.malaysian##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##nationality%d.others##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##nationality%d.others2##",i];
        page=[page stringByReplacingString:str withString:@""];
        
        str=[NSString stringWithFormat:@"##nameofemployer%d##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##natureOfWork%d##",i];
        page=[page stringByReplacingString:str withString:@""];
        
        str=[NSString stringWithFormat:@"##sameaddr%d.1##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##sameaddr%d.2##",i];
        page=[page stringByReplacingString:str withString:@"◻︎"];
        str=[NSString stringWithFormat:@"##%d.6Line1##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##%d.6Line2##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##%d.6bpostcode##",i];
        page=[page stringByReplacingString:str withString:@""];
        
        str=[NSString stringWithFormat:@"##%d.6CRLine1##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##%d.6CRLine2##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##%d.6CRbpostcode##",i];
        page=[page stringByReplacingString:str withString:@""];
        
        
        str=[NSString stringWithFormat:@"##day%d##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##month%d##",i];
        page=[page stringByReplacingString:str withString:@""];
        str=[NSString stringWithFormat:@"##year%d##",i];
        page=[page stringByReplacingString:str withString:@""];
    }
    [PRHtmlHandler sharedPRHtmlHandler].currentPage++;
    page=[[PRHtmlHandler sharedPRHtmlHandler] handleWatermarkForString:page];
    return page;
}
@end
