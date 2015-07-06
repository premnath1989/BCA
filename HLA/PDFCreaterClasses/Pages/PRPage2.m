//
//  PRPage2.m
//  PDF
//
//  Created by Travel Chu on 3/13/14.
//  Copyright (c) 2014 Nexstream. All rights reserved.
//

#import "PRPage2.h"
#import "PRHtmlHandler.h"
#import "TBXML+NSDictionary.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

NSString *la_icno;

@implementation PRPage2
@synthesize CountyDesc;




+(NSString*)prPage2WithDictionary:(NSDictionary*)dicttionary{
     NSString *page2=[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PR_page2" ofType:@"al" inDirectory:@"PDFCreater.bundle"] encoding:NSUTF8StringEncoding error:nil];

    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setMaximumFractionDigits:2];
    [fmt setPositiveFormat:@"#,##0.00"];
    
    NSString *la1_icno;
    NSString *la1_otherIDType;
    NSString *la1_otherIDNo;
    
    for (NSDictionary *dict in dicttionary[@"AssuredInfo"][@"Party"]) {
        
        if ([dict[@"ID"] isEqualToString:@"1"] && [dict[@"Seq"] isEqualToString:@"1"]) {
            page2=[page2 stringByReplacingString:@"##LAName##" withString:dict[@"LAName"]];
            la1_icno = dict[@"LANewIC"][@"LANewICNo"];
            la1_otherIDType=dict[@"iLAOtherID"][@"iLAOtherIDType"];
            la1_otherIDNo=dict[@"iLAOtherID"][@"iLAOtherIDNo"];
            
            NSString *icNO=dict[@"LANewIC"][@"LANewICNo"];
            if (icNO.length==12) {
                page2=[page2 stringByReplacingString:@"##LANewICNo.1##" withString:[icNO substringToIndex:6]];
                icNO=[icNO substringFromIndex:6];
                page2=[page2 stringByReplacingString:@"##LANewICNo.2##" withString:[icNO substringToIndex:2]];
                page2=[page2 stringByReplacingString:@"##LANewICNo.3##" withString:[icNO substringFromIndex:2]];
            }
            if (dict[@"iLAOtherID"]) {
                page2=[page2 stringByReplacingString:@"##LAOtherID##" withString:dict[@"iLAOtherID"][@"iLAOtherIDNo"]];
            }
            page2=[page2 stringByReplacingString:[NSString stringWithFormat:@"##LASex%@##◻︎",dict[@"LASex"]] withString:@"◼︎"];
            NSArray *birth=[dict[@"LADOB"] componentsSeparatedByString:@"/"];
            if (birth.count==3) {
                page2=[page2 stringByReplacingString:@"##LADOB.1##" withString:birth[0]];
                page2=[page2 stringByReplacingString:@"##LADOB.2##" withString:birth[1]];
                page2=[page2 stringByReplacingString:@"##LADOB.3##" withString:birth[2]];
            }
			
			if (dict[@"LABirthCountry"])
				{
					
					FMDatabase*db;
					
					NSString *country =dict[@"LABirthCountry"];
					
					NSString *code;
					country = [country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
					
					NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
					NSString *docsPath = [paths objectAtIndex:0];
					NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
					
					if (![db open]) {
						NSLog(@"Could not open db.");
						db = [FMDatabase databaseWithPath:path];
						
						[db open];
					}
					FMResultSet *result = [db executeQuery:@"SELECT CountryDesc FROM eProposal_Country WHERE CountryCode = ?", country];
					
					while ([result next]) {
						code =[result objectForColumnName:@"CountryDesc"];
						page2=[page2 stringByReplacingString:@"##LABirthCountry2##" withString:code];
						
						
						
					}
					
					
					
					[result close];
					// [db close];
					
					
					
					
                }
            
            if ([dict[@"LARace"] isEqualToString:@"M"]) {
                page2=[page2 stringByReplacingString:@"##LARaceM##◻︎" withString:@"◼︎"];
            }else if ([dict[@"LARace"] isEqualToString:@"I"]){
                page2=[page2 stringByReplacingString:@"##LARaceI##◻︎" withString:@"◼︎"];
            }else if ([dict[@"LARace"] isEqualToString:@"C"]){
                page2=[page2 stringByReplacingString:@"##LARaceC##◻︎" withString:@"◼︎"];
            }else
			{
			  if([dict[@"LAOtherIDType"] isEqualToString:@"EDD"])
			   {

					   page2=[page2 stringByReplacingString:@"##LARaceO##◻︎" withString:@"◻︎"];
					//   page2=[page2 stringByReplacingString:@"##LARace##" withString:dict[@"LARace"]];
					   
				}
				else
				{
                page2=[page2 stringByReplacingString:@"##LARaceO##◻︎" withString:@"◼︎"];
                page2=[page2 stringByReplacingString:@"##LARace##" withString:dict[@"LARace"]];
				}
				   
            }
            if ([dict[@"LANationality"] isEqualToString:@"MY"]){
                page2=[page2 stringByReplacingString:@"##LANationalityMY##◻︎" withString:@"◼︎"];
            }else
			
			{
				if([dict[@"LAOtherIDType"] isEqualToString:@"EDD"])
				{
					
					page2=[page2 stringByReplacingString:@"##LANationalityO##◻︎" withString:@"◻︎"];
//					NSString *nation=[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getNationalityByCode:dict[@"LANationality"]];
//					page2=[page2 stringByReplacingString:@"##LANationality##" withString:nation];
					
				}
				else
				{
				
                page2=[page2 stringByReplacingString:@"##LANationalityO##◻︎" withString:@"◼︎"];
                NSString *nation=[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getNationalityByCode:dict[@"LANationality"]];
                page2=[page2 stringByReplacingString:@"##LANationality##" withString:nation];
				}
            }
            
            if ([dict[@"LAReligion"] isEqualToString:@"REL001"]) {
                page2=[page2 stringByReplacingString:@"##LAReligionM##◻︎" withString:@"◼︎"];
            }else
			{
				if([dict[@"LAOtherIDType"] isEqualToString:@"EDD"])
				{
					
					page2=[page2 stringByReplacingString:@"##LAReligionN##◻︎" withString:@"◻︎"];
					
				}
				else
				{

					page2=[page2 stringByReplacingString:@"##LAReligionN##◻︎" withString:@"◼︎"];
					
				}
            }
            page2=[page2 stringByReplacingString:[NSString stringWithFormat:@"##LAMaritalStatus%@##◻︎",dict[@"LAMaritalStatus"]] withString:@"◼︎"];
            for (NSDictionary *dict0 in dict[@"Contacts"][@"Contact"]) {
                if ([dict0[@"ContactCode"] isEqualToString:@"CONT011"]) {
                    page2=[page2 stringByReplacingString:@"##ContactNo##" withString:dict0[@"ContactNo"]];
                }
            }
            NSString *occupation=[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getOccupationByCode:dict[@"LAOccupationCode"]];
            page2=[page2 stringByReplacingString:@"##LAOccupationCode##" withString:occupation];
            page2=[page2 stringByReplacingString:@"##LAExactDuties##" withString:dict[@"LAExactDuties"]];
            page2=[page2 stringByReplacingString:@"##LATypeOfBusiness##" withString:dict[@"LATypeOfBusiness"]];
            page2=[page2 stringByReplacingString:@"##LAEmployerName##" withString:dict[@"LAEmployerName"]];
            page2=[page2 stringByReplacingString:@"##LAYearlyIncome##" withString:[fmt stringFromNumber:[fmt numberFromString:dict[@"LAYearlyIncome"]]]];
            
            

        }
        if ([dict[@"PTypeCode"] isEqualToString:@"PO"]) {
            NSString *po_icno=dict[@"LANewIC"][@"LANewICNo"];
            NSString *po_otherIDType=dict[@"iLAOtherID"][@"iLAOtherIDType"];
            NSString *po_otherIDNo=dict[@"iLAOtherID"][@"iLAOtherIDNo"];
            if (![po_icno isEqualToString:la1_icno] && ![po_otherIDType isEqualToString:la1_otherIDType] && ![po_otherIDNo isEqualToString:la1_otherIDNo]) {
                
                page2=[page2 stringByReplacingString:@"##LAName2##" withString:dict[@"LAName"]];
                NSString *icNO=dict[@"LANewIC"][@"LANewICNo"];
                if (icNO.length==12) {
                    page2=[page2 stringByReplacingString:@"##LANewICNo2.1##" withString:[icNO substringToIndex:6]];
                    icNO=[icNO substringFromIndex:6];
                    page2=[page2 stringByReplacingString:@"##LANewICNo2.2##" withString:[icNO substringToIndex:2]];
                    page2=[page2 stringByReplacingString:@"##LANewICNo2.3##" withString:[icNO substringFromIndex:2]];
                }
                if (dict[@"LAOtherID"]) {
                    page2=[page2 stringByReplacingString:@"##LAOtherID2##" withString:dict[@"LAOtherID"]];
                }
                
                page2=[page2 stringByReplacingString:[NSString stringWithFormat:@"##LASex%@2##◻︎",dict[@"LASex"]] withString:@"◼︎"];
                NSArray *birth=[dict[@"LADOB"] componentsSeparatedByString:@"/"];
                if (birth.count==3) {
                    page2=[page2 stringByReplacingString:@"##LADOB2.1##" withString:birth[0]];
                    page2=[page2 stringByReplacingString:@"##LADOB2.2##" withString:birth[1]];
                    page2=[page2 stringByReplacingString:@"##LADOB2.3##" withString:birth[2]];
                }
				if (dict[@"LABirthCountry"]) {
					
					FMDatabase*db;
					
					NSString *country =dict[@"LABirthCountry"];
					
					NSString *code;
					country = [country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
					
					NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
					NSString *docsPath = [paths objectAtIndex:0];
					NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
					
					if (![db open]) {
						NSLog(@"Could not open db.");
						db = [FMDatabase databaseWithPath:path];
						
						[db open];
					}
					FMResultSet *result = [db executeQuery:@"SELECT CountryDesc FROM eProposal_Country WHERE CountryCode = ?", country];
					
					while ([result next]) {
						code =[result objectForColumnName:@"CountryDesc"];
						page2=[page2 stringByReplacingString:@"##LABirthCountry##" withString:code];
						

						
					}
					
					
					
					[result close];
					// [db close];
					

					
					
                }
                if ([dict[@"LARace"] isEqualToString:@"M"]) {
                    page2=[page2 stringByReplacingString:@"##LARaceM2##◻︎" withString:@"◼︎"];
                }else if ([dict[@"LARace"] isEqualToString:@"I"]){
                    page2=[page2 stringByReplacingString:@"##LARaceI2##◻︎" withString:@"◼︎"];
                }else if ([dict[@"LARace"] isEqualToString:@"C"]){
                    page2=[page2 stringByReplacingString:@"##LARaceC2##◻︎" withString:@"◼︎"];
                }else{
                    page2=[page2 stringByReplacingString:@"##LARaceO2##◻︎" withString:@"◼︎"];
                    page2=[page2 stringByReplacingString:@"##LARace2##" withString:dict[@"LARace"]];
                }
                if ([dict[@"LANationality"] isEqualToString:@"MY"]){
                    page2=[page2 stringByReplacingString:@"##LANationalityMY2##◻︎" withString:@"◼︎"];
                }else{
                    page2=[page2 stringByReplacingString:@"##LANationalityO2##◻︎" withString:@"◼︎"];
                    page2=[page2 stringByReplacingString:@"##LANationality2##" withString:dict[@"LANationality"]];
                }
                if ([dict[@"LAReligion"] isEqualToString:@"REL001"]) {
                    page2=[page2 stringByReplacingString:@"##LAReligionM2##◻︎" withString:@"◼︎"];
                }else{
                    page2=[page2 stringByReplacingString:@"##LAReligionN2##◻︎" withString:@"◼︎"];
                }
                page2=[page2 stringByReplacingString:[NSString stringWithFormat:@"##LAMaritalStatus%@2##◻︎",dict[@"LAMaritalStatus"]] withString:@"◼︎"];
                for (NSDictionary *dict0 in dict[@"Contacts"][@"Contact"]) {
                    if ([dict0[@"Type"] isEqualToString:@"Email"]) {
                        page2=[page2 stringByReplacingString:@"##ContactNo2##" withString:dict0[@"ContactNo"]];
                    }
                }
                NSString *occupation=[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getOccupationByCode:dict[@"LAOccupationCode"]];
                page2=[page2 stringByReplacingString:@"##LAOccupationCode2##" withString:occupation];
                page2=[page2 stringByReplacingString:@"##LAExactDuties2##" withString:dict[@"LAExactDuties"]];
                page2=[page2 stringByReplacingString:@"##LATypeOfBusiness2##" withString:dict[@"LATypeOfBusiness"]];
                page2=[page2 stringByReplacingString:@"##LAEmployerName2##" withString:dict[@"LAEmployerName"]];
                page2=[page2 stringByReplacingString:@"##LAYearlyIncome2##" withString:[fmt stringFromNumber:[fmt numberFromString:dict[@"LAYearlyIncome"]]]];
                
            }
            
            if ([dict[@"LARelationship"] isEqualToString:@"FA"] || [dict[@"LARelationship"] isEqualToString:@"MO"]) {
                page2=[page2 stringByReplacingString:@"##LARelationshipP##◻︎" withString:@"◼︎"];
            }else if ([dict[@"LARelationship"] isEqualToString:@"HU"] || [dict[@"LARelationship"] isEqualToString:@"WI"]){
                page2=[page2 stringByReplacingString:@"##LARelationshipL##◻︎" withString:@"◼︎"];
            }else if ([dict[@"LARelationship"] isEqualToString:@"ER"]){
                page2=[page2 stringByReplacingString:@"##LARelationshipE##◻︎" withString:@"◼︎"];
            }else{
                page2=[page2 stringByReplacingString:@"##LARelationshipO##◻︎" withString:@"◼︎"];
                NSString *relation=[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getRelationByCode:dict[@"LARelationship"]];
                page2=[page2 stringByReplacingString:@"##LARelationship##" withString:relation];
            }
            
        }
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsPath = [paths objectAtIndex:0];
        NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
        FMDatabase *database = [FMDatabase databaseWithPath:path];
        [database open];
        NSString *ResidencePhoneNo;
        NSString *ResidencePhoneNoPrefix;
        NSString *OfficePhoneNo;
        NSString *OfficePhoneNoPrefix;
        NSString *FaxPhoneNo;
        NSString *FaxPhoneNoPrefix;
        NSString *MobilePhoneNo;
        NSString *MobilePhoneNoPrefix;


        
        if ([dict[@"ID"] isEqualToString:@"1"] && [dict[@"PTypeCode"] isEqualToString:@"LA"] ) {
            la_icno=dict[@"LANewIC"][@"LANewICNo"];
            
            FMResultSet *getLAContact = [database executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ? and LAName = ?",dicttionary[@"AssuredInfo"][@"eProposalNo"],dict[@"LAName"]];
            while ([getLAContact next]) {
                ResidencePhoneNo=[getLAContact objectForColumnName:@"ResidencePhoneNo"];
                ResidencePhoneNoPrefix=[getLAContact objectForColumnName:@"ResidencePhoneNoPrefix"];
                OfficePhoneNo=[getLAContact objectForColumnName:@"OfficePhoneNo"];
                OfficePhoneNoPrefix=[getLAContact objectForColumnName:@"OfficePhoneNoPrefix"];
                MobilePhoneNo=[getLAContact objectForColumnName:@"MobilePhoneNo"];
                MobilePhoneNoPrefix=[getLAContact objectForColumnName:@"MobilePhoneNoPrefix"];
            }
            
            
            for (NSDictionary *dict0 in dict[@"Contacts"][@"Contact"]) {
                if ([dict0[@"ContactCode"] isEqualToString:@"CONT006"]) {
                    NSString *num=dict0[@"ContactNo"];
                    NSString *s1;
                    NSString *s2;
                    NSArray *contactNoAry = [num componentsSeparatedByString:@" "];
                    if (contactNoAry.count > 1) {
                        s1 = [contactNoAry objectAtIndex:0];
                        s2 = [contactNoAry objectAtIndex:1];
                    }
                    else {
                        s1 = [contactNoAry objectAtIndex:0];
                    }
                    page2=[page2 stringByReplacingString:@"##LAContactNoP.1##" withString:ResidencePhoneNoPrefix];
                    page2=[page2 stringByReplacingString:@"##LAContactNoP.2##" withString:ResidencePhoneNo];
                }
                
                if ([dict0[@"ContactCode"] isEqualToString:@"CONT007"]) {
                    NSString *num=dict0[@"ContactNo"];
                    NSString *s1;
                    NSString *s2;
                    NSArray *contactNoAry = [num componentsSeparatedByString:@" "];
                    if (contactNoAry.count > 1) {
                        s1 = [contactNoAry objectAtIndex:0];
                        s2 = [contactNoAry objectAtIndex:1];
                    }
                    else {
                        s1 = [contactNoAry objectAtIndex:0];
                    }
                    page2=[page2 stringByReplacingString:@"##LAContactNoO.1##" withString:OfficePhoneNoPrefix];
                    page2=[page2 stringByReplacingString:@"##LAContactNoO.2##" withString:OfficePhoneNo];
                }
                
                if ([dict0[@"ContactCode"] isEqualToString:@"CONT008"]) {
                    NSString *num=dict0[@"ContactNo"];
                    NSString *s1;
                    NSString *s2;
                    NSArray *contactNoAry = [num componentsSeparatedByString:@" "];
                    if (contactNoAry.count > 1) {
                        s1 = [contactNoAry objectAtIndex:0];
                        s2 = [contactNoAry objectAtIndex:1];
                    }
                    else {
                        s1 = [contactNoAry objectAtIndex:0];
                    }
                    page2=[page2 stringByReplacingString:@"##LAContactNoM.1##" withString:MobilePhoneNoPrefix];
                    page2=[page2 stringByReplacingString:@"##LAContactNoM.2##" withString:MobilePhoneNo];
                }
            }
        }
                
        if ([dict[@"PTypeCode"] isEqualToString:@"PO"] ) {
            NSString *po_icno=dict[@"LANewIC"][@"LANewICNo"];
            NSString *ptypeCodeTest = dict[@"PTypeCode"];
            for (NSDictionary *addr in dict[@"Addresses"][@"Address"]) {
                if ([addr[@"Type"] isEqualToString:@"Residence"]) {
                    NSString *addL1=[NSString stringWithFormat:@"%@ %@ %@",addr[@"Address1"],addr[@"Address2"],addr[@"Address3"]];
                    NSString *addL2=[NSString stringWithFormat:@"%@ %@ %@",addr[@"Town"],[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getStateByCode:addr[@"State"]],[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getCountryByCode:addr[@"Country"]]];
                    page2=[page2 stringByReplacingString:@"##14bLine1##" withString:addL1];
                    page2=[page2 stringByReplacingString:@"##14bLine2##" withString:addL2];
                    page2=[page2 stringByReplacingString:@"##14bpostcode##" withString:addr[@"Postcode"]];
                }else{
                    if ([addr[@"Type"] isEqualToString:@"Office"]) {
                        NSString *addL1=[NSString stringWithFormat:@"%@ %@ %@",addr[@"Address1"],addr[@"Address2"],addr[@"Address3"]];
                        NSString *addL2=[NSString stringWithFormat:@"%@ %@ %@",addr[@"Town"],[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getStateByCode:addr[@"State"]],[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getCountryByCode:addr[@"Country"]]];
                        page2=[page2 stringByReplacingString:@"##14cLine1##" withString:addL1];
                        page2=[page2 stringByReplacingString:@"##14cLine2##" withString:addL2];
                        page2=[page2 stringByReplacingString:@"##14cpostcode##" withString:addr[@"Postcode"]];
                    }
                }
            }
            
            if ([dict[@"CorrespondenceAddress"] isEqualToString:@"ADR001"]) {
                page2=[page2 stringByReplacingString:@"##po.correspondence.address.residence##" withString:@"◼︎"];
            }else{
                page2=[page2 stringByReplacingString:@"##po.correspondence.address.office##" withString:@"◼︎"];
            }
			
			if ([dict[@"MalaysianWithPOBox"] isEqualToString:@"Y"]) {
                page2=[page2 stringByReplacingString:@"##po.box.yes##" withString:@"◼︎"];
				page2=[page2 stringByReplacingString:@"##po.box.no##" withString:@"◻︎"];
            }else{
                page2=[page2 stringByReplacingString:@"##po.box.no##" withString:@"◻︎"];
				page2=[page2 stringByReplacingString:@"##po.box.yes##" withString:@"◻︎"];
            }


            if ([dict[@"ResidenceOwnRented"] isEqualToString:@"Own"]) {
                page2=[page2 stringByReplacingString:@"##po.own##" withString:@"◼︎"];
            }else if ([dict[@"ResidenceOwnRented"] isEqualToString:@"Rented"]){
                page2=[page2 stringByReplacingString:@"##po.rented##" withString:@"◼︎"];
            }
            
            if (![po_icno isEqualToString:la_icno]) {

            for (NSDictionary *dict0 in dict[@"Contacts"][@"Contact"]) {
                FMResultSet *getLAContact = [database executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ? and LAName = ?",dicttionary[@"AssuredInfo"][@"eProposalNo"],dict[@"LAName"]];
                while ([getLAContact next]) {
                    ResidencePhoneNo=[getLAContact objectForColumnName:@"ResidencePhoneNo"];
                    ResidencePhoneNoPrefix=[getLAContact objectForColumnName:@"ResidencePhoneNoPrefix"];
                    OfficePhoneNo=[getLAContact objectForColumnName:@"OfficePhoneNo"];
                    OfficePhoneNoPrefix=[getLAContact objectForColumnName:@"OfficePhoneNoPrefix"];
                    MobilePhoneNo=[getLAContact objectForColumnName:@"MobilePhoneNo"];
                    MobilePhoneNoPrefix=[getLAContact objectForColumnName:@"MobilePhoneNoPrefix"];
                }
                
                
                if ([dict0[@"ContactCode"] isEqualToString:@"CONT006"]) {
                    NSString *num=dict0[@"ContactNo"];
                    NSString *s1;
                    NSString *s2;
                    NSArray *contactNoAry = [num componentsSeparatedByString:@" "];
                    if (contactNoAry.count > 1) {
                        s1 = [contactNoAry objectAtIndex:0];
                        s2 = [contactNoAry objectAtIndex:1];
                    }
                    else {
                        s1 = [contactNoAry objectAtIndex:0];
                    }
                    page2=[page2 stringByReplacingString:@"##ContactNoP.1##" withString:ResidencePhoneNoPrefix];
                    page2=[page2 stringByReplacingString:@"##ContactNoP.2##" withString:ResidencePhoneNo];
                }
                if ([dict0[@"ContactCode"] isEqualToString:@"CONT007"]) {
                    NSString *num=dict0[@"ContactNo"];
                    NSString *s1;
                    NSString *s2;
                    NSArray *contactNoAry = [num componentsSeparatedByString:@" "];
                    if (contactNoAry.count > 1) {
                        s1 = [contactNoAry objectAtIndex:0];
                        s2 = [contactNoAry objectAtIndex:1];
                    }
                    else {
                        s1 = [contactNoAry objectAtIndex:0];
                    }
                    page2=[page2 stringByReplacingString:@"##ContactNoO.1##" withString:OfficePhoneNoPrefix];
                    page2=[page2 stringByReplacingString:@"##ContactNoO.2##" withString:OfficePhoneNo];
                }
                if ([dict0[@"ContactCode"] isEqualToString:@"CONT008"]) {
                    NSString *num=dict0[@"ContactNo"];
                    NSString *s1;
                    NSString *s2;
                    NSArray *contactNoAry = [num componentsSeparatedByString:@" "];
                    if (contactNoAry.count > 1) {
                        s1 = [contactNoAry objectAtIndex:0];
                        s2 = [contactNoAry objectAtIndex:1];
                    }
                    else {
                        s1 = [contactNoAry objectAtIndex:0];
                    }
                    page2=[page2 stringByReplacingString:@"##ContactNoM.1##" withString:MobilePhoneNoPrefix];
                    page2=[page2 stringByReplacingString:@"##ContactNoM.2##" withString:MobilePhoneNo];
                }
            }

        }
            
            // for GST section
            if ([dict[@"LAGST"][@"GSTRegPerson"] isEqualToString:@"Y"]) {
                page2=[page2 stringByReplacingString:@"##GSTRegPerson.Yes##" withString:@"◼︎"];
                page2=[page2 stringByReplacingString:@"##GSTRegPerson.No##" withString:@"◻︎"];
            }else if ([dict[@"LAGST"][@"GSTRegPerson"] isEqualToString:@"N"])
            {
                page2=[page2 stringByReplacingString:@"##GSTRegPerson.Yes##" withString:@"◻︎"];
                page2=[page2 stringByReplacingString:@"##GSTRegPerson.No##" withString:@"◼︎"];
            }
            
            page2=[page2 stringByReplacingString:@"##GSTRegNo##" withString:dict[@"LAGST"][@"GSTRegNo"]];
            NSArray *GSTRegDate=[dict[@"LAGST"][@"GSTRegDate"] componentsSeparatedByString:@"/"];
            if (GSTRegDate.count==3) {
                page2=[page2 stringByReplacingString:@"##GSTRegDate.1##" withString:GSTRegDate[0]];
                page2=[page2 stringByReplacingString:@"##GSTRegDate.2##" withString:GSTRegDate[1]];
                page2=[page2 stringByReplacingString:@"##GSTRegDate.3##" withString:GSTRegDate[2]];
            }
            if ([dict[@"LAGST"][@"GSTExempted"] isEqualToString:@"Y"]) {
                page2=[page2 stringByReplacingString:@"##GSTExempted.Yes##" withString:@"◼︎"];
                page2=[page2 stringByReplacingString:@"##GSTExempted.No##" withString:@"◻︎"];
            }else if ([dict[@"LAGST"][@"GSTExempted"] isEqualToString:@"N"])
            {
                page2=[page2 stringByReplacingString:@"##GSTExempted.Yes##" withString:@"◻︎"];
                page2=[page2 stringByReplacingString:@"##GSTExempted.No##" withString:@"◼︎"];
            }
            
            else
            {
                page2=[page2 stringByReplacingString:@"##GSTExempted.Yes##" withString:@"◻︎"];
                page2=[page2 stringByReplacingString:@"##GSTExempted.No##" withString:@"◼︎"];
            }
            
            
        }
                
    }
    


    
    
    page2=[page2 stringByReplacingString:@"##LAName##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LANewICNo.1##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LANewICNo.2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LANewICNo.3##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAOtherID##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LASexF##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LASexM##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LADOB.1##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LADOB.2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LADOB.3##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LARaceI##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LARaceM##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LARaceC##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LARaceO##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LARace##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LANationalityMY##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LANationalityO##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LANationality##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAReligionM##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAReligionN##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAMaritalStatusS##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAMaritalStatusW##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAMaritalStatusM##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAMaritalStatusD##" withString:@""];
    page2=[page2 stringByReplacingString:@"##ContactNo##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAOccupationCode##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAExactDuties##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LATypeOfBusiness##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAEmployerName##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAYearlyIncome##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LARelationship##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LARelationshipP##◻︎" withString:@"◻︎"];
    page2=[page2 stringByReplacingString:@"##LARelationshipL##◻︎" withString:@"◻︎"];
    page2=[page2 stringByReplacingString:@"##LARelationshipE##◻︎" withString:@"◻︎"];
    page2=[page2 stringByReplacingString:@"##LARelationshipO##◻︎" withString:@"◻︎"];
    page2=[page2 stringByReplacingString:@"##LAName2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LANewICNo2.1##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LANewICNo2.2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LANewICNo2.3##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAOtherID2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LASexF2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LASexM2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LARaceI2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LARaceM2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LARaceC2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LARaceO2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LARace2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LADOB2.1##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LADOB2.2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LADOB2.3##" withString:@""];
	page2=[page2 stringByReplacingString:@"##LABirthCountry##" withString:@""];
	page2=[page2 stringByReplacingString:@"##LABirthCountry2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LANationalityMY2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LANationalityO2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LANationality2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAReligionM2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAReligionN2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAMaritalStatusS2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAMaritalStatusW2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAMaritalStatusM2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAMaritalStatusD2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##ContactNo2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAOccupationCode2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAExactDuties2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LATypeOfBusiness2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAEmployerName2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAYearlyIncome2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LARelationship2##◻︎" withString:@""];
    page2=[page2 stringByReplacingString:@"##LARelationshipP2##◻︎" withString:@"◻︎"];
    page2=[page2 stringByReplacingString:@"##LARelationshipL2##◻︎" withString:@"◻︎"];
    page2=[page2 stringByReplacingString:@"##LARelationshipE2##◻︎" withString:@"◻︎"];
    page2=[page2 stringByReplacingString:@"##LARelationshipO2##◻︎" withString:@"◻︎"];
    
    page2=[page2 stringByReplacingString:@"##po.correspondence.address.residence##" withString:@"◻︎"];
    page2=[page2 stringByReplacingString:@"##po.correspondence.address.office##" withString:@"◻︎"];
    page2=[page2 stringByReplacingString:@"##po.own##" withString:@"◻︎"];
    page2=[page2 stringByReplacingString:@"##po.rented##" withString:@"◻︎"];
    page2=[page2 stringByReplacingString:@"##14bLine1##" withString:@""];
    page2=[page2 stringByReplacingString:@"##14bLine2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##14bpostcode##" withString:@""];
    page2=[page2 stringByReplacingString:@"##14cLine1##" withString:@""];
    page2=[page2 stringByReplacingString:@"##14cLine2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##14cpostcode##" withString:@""];
    page2=[page2 stringByReplacingString:@"##part2FullName##" withString:@""];
    page2=[page2 stringByReplacingString:@"##newIC.1##" withString:@""];
    page2=[page2 stringByReplacingString:@"##newIC.2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##newIC.3##" withString:@""];
    page2=[page2 stringByReplacingString:@"##coOtherID##" withString:@""];
    page2=[page2 stringByReplacingString:@"##part2Bith.1##" withString:@""];
    page2=[page2 stringByReplacingString:@"##part2Bith.2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##part2Bith.3##" withString:@""];
    page2=[page2 stringByReplacingString:@"##part2relationship##" withString:@""];
    page2=[page2 stringByReplacingString:@"##part2.5.Y##◻︎" withString:@"◻︎"];
    page2=[page2 stringByReplacingString:@"##part2.5.N##◻︎" withString:@"◻︎"];
    page2=[page2 stringByReplacingString:@"##part2.5.Addr##" withString:@""];
    page2=[page2 stringByReplacingString:@"##part2.5.Postcode##" withString:@""];
    page2=[page2 stringByReplacingString:@"##part2.5.country##" withString:@""];

    page2=[page2 stringByReplacingString:@"##LAContactNoP.1##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAContactNoP.2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAContactNoO.1##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAContactNoO.2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAContactNoM.1##" withString:@""];
    page2=[page2 stringByReplacingString:@"##LAContactNoM.2##" withString:@""];
    
    page2=[page2 stringByReplacingString:@"##ContactNoP.1##" withString:@""];
    page2=[page2 stringByReplacingString:@"##ContactNoP.2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##ContactNoO.1##" withString:@""];
    page2=[page2 stringByReplacingString:@"##ContactNoO.2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##ContactNoM.1##" withString:@""];
    page2=[page2 stringByReplacingString:@"##ContactNoM.2##" withString:@""];
    
    page2=[page2 stringByReplacingString:@"##part2.5.mob.1##" withString:@""];
    page2=[page2 stringByReplacingString:@"##part2.5.mob.2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##part2.5.tel.1##" withString:@""];
    page2=[page2 stringByReplacingString:@"##part2.5.tel.2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##part2.5.email##" withString:@""];
    page2=[page2 stringByReplacingString:@"##basicPlan##" withString:@""];
    page2=[page2 stringByReplacingString:@"##term##" withString:@""];
    page2=[page2 stringByReplacingString:@"##sumassured##" withString:@""];
    page2=[page2 stringByReplacingString:@"##modalPrem##" withString:@""];
    
    page2=[page2 stringByReplacingString:@"##GSTRegPerson.Yes##" withString:@"◻︎"];
    page2=[page2 stringByReplacingString:@"##GSTRegPerson.No##" withString:@"◻︎"];    
    page2=[page2 stringByReplacingString:@"##GSTRegNo##" withString:@""];
    page2=[page2 stringByReplacingString:@"##GSTRegDate.1##" withString:@""];
    page2=[page2 stringByReplacingString:@"##GSTRegDate.2##" withString:@""];
    page2=[page2 stringByReplacingString:@"##GSTRegDate.3##" withString:@""];
    page2=[page2 stringByReplacingString:@"##GSTExempted.Yes##" withString:@"◻︎"];
    page2=[page2 stringByReplacingString:@"##GSTExempted.No##" withString:@"◻︎"];    

    
    
    [PRHtmlHandler sharedPRHtmlHandler].currentPage++;
    page2=[[PRHtmlHandler sharedPRHtmlHandler] handleWatermarkForString:page2];
    return page2;
}

-(NSString*) getCountryDesc : (NSString*)country passdb:(FMDatabase*)db
{
    NSString *code;
    country = [country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        db = [FMDatabase databaseWithPath:path];
        
        [db open];
    }
    FMResultSet *result = [db executeQuery:@"SELECT CountryDesc FROM eProposal_Country WHERE CountryCode = ?", country];
    
    while ([result next]) {
        code =[result objectForColumnName:@"CountryDesc"];
        
    }
    
    [result close];
    // [db close];
    
    return code;
    
}

@end
