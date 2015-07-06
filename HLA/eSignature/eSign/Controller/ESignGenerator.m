//
//  ESignGenerator.m
//  eSignature
//
//  Created by Danial D. Moghaddam on 5/19/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//

#import "ESignGenerator.h"
#import "NSObject_ConstantTags.h"
#include <string.h>
#include <errno.h>
#include "SPSignDocCAPI.h"
#import "test.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

#define cFFCustomer     @"0"
#define ifirstLA        @"1"
#define isecondLA       @"2"
#define ipolicyOwner    @"3"
#define icontigentOwner @"4"
#define ifirstTrustee   @"5"
#define isecondTrustee  @"6"
#define igardian        @"7"
#define iintermediary   @"8"
#define kwitness        @"9"
#define imanager        @"10"
#define icreditCard     @"11"
@implementation ESignGenerator


#pragma mark - Local Method
-(NSString *)eApplicationForProposalNo:(NSString *)proposalNo fromInfoDic:(NSDictionary *)infoDic
{
//    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
//    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
//    documentDirectory = [documentDirectory stringByAppendingString:@"/Forms/"];
//    NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_AU.pdf",proposalNo]];
//    //File was filled out with data --- Must Load it
//    if ([[NSFileManager defaultManager]fileExistsAtPath:documentDirectoryFilename]) {
//        isReOpen= YES;
//    }
    isRookie = FALSE;
    NSMutableArray *array = nil;
    cFFSignatureRequired = YES;
    if ([[[infoDic objectForKey:@"AssuredInfo"]objectForKey:@"Party"]isKindOfClass:[NSArray class]]) { //Check if its an array
        array = [[infoDic objectForKey:@"AssuredInfo"]objectForKey:@"Party"];
    }
    else //If its a dictionary; put it in an array to continue
    {
        array = [[NSMutableArray alloc]initWithObjects:[[infoDic objectForKey:@"AssuredInfo"]objectForKey:@"Party"], nil];
    }
    
    for (id obj in array) { //Check if it a company
        if ([[obj objectForKey:@"PTypeCode"]isEqualToString:@"PO"]) {
            if ([[[obj objectForKey:@"LAOtherID"]objectForKey:@"LAOtherIDType"]isEqualToString:@"CR"]) {
                cFFSignatureRequired = NO;
            }
        }
    }
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
   // NSString *agentName;
    
    
    if (infoDic) {
        
        _signAssured1 = [[infoDic objectForKey:@"SignInfo"]objectForKey:@"SIGNFASSURED1"];
        _signAssured2 = [[infoDic objectForKey:@"SignInfo"]objectForKey:@"SIGNFASSURED2"];
        _signPOOwner = [[infoDic objectForKey:@"SignInfo"]objectForKey:@"SIGNFPOLOWNER"];
        _signCOOwner = [[infoDic objectForKey:@"SignInfo"]objectForKey:@"SIGNFCONOWNER"];
        _signTrustee1 = [[infoDic objectForKey:@"SignInfo"]objectForKey:@"SIGNFTRUSTEE1"];
        _signTrustee2 = [[infoDic objectForKey:@"SignInfo"]objectForKey:@"SIGNFTRUSTEE2"];
        _signParent = [[infoDic objectForKey:@"SignInfo"]objectForKey:@"SIGNFPARENTS"];
        _signWitness = [[infoDic objectForKey:@"SignInfo"]objectForKey:@"SIGNFWITNESS"];
        _signCardholder = [[infoDic objectForKey:@"SignInfo"]objectForKey:@"SIGNFCARDHOLDER"];

        //NSString *getIC;
        
        FMResultSet *getAgent = [database executeQuery:@"select * from Agent_profile "];
        while ([getAgent next]) {
            _intermediaryName = [getAgent objectForColumnName:@"AgentName"];
            _getIC = [getAgent objectForColumnName:@"AgentICNo"];
//            intermediaryNICNo_Int = [getIC intValue];
            _intermediaryCode = [getAgent objectForColumnName:@"AgentCode"];
            _intermediaryContractDate = [getAgent objectForColumnName:@"AgentContractDate"];
//            _intermediaryManagerName = [getAgent objectForColumnName:@"ImmediateLeaderName"];
//            _intermediaryManagerIDNumber = [getAgent objectForColumnName:@"ImmediateLeaderCode"];
        }
        
        FMResultSet *getAgentManaer = [database executeQuery:@"select * from eProposal_CFF_Master where eProposalNo = ?",proposalNo];
        while ([getAgentManaer next]) {
            _intermediaryManagerName = [getAgentManaer objectForColumnName:@"IntermediaryManagerName"];
            _intermediaryManagerIDNumber = @"";
        }
        
            _intermediaryNICNo = [NSString stringWithFormat:@"%lld",[_getIC longLongValue]];
        
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        NSString *dateString = [dateFormat stringFromDate:today];
        NSLog(@"date: %@", dateString);
        
        NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
        [dateFormat1 setDateFormat:@"dd/MM/yyyy"];
        NSDate *date2 = [dateFormat1 dateFromString:dateString];

        NSDate *date3 = [dateFormat1 dateFromString:_intermediaryContractDate];
        
        
        numberOfDays = [self daysBetweenDate:date3 andDate:date2];
        if (numberOfDays < 366) {
            isRookie = TRUE;
        }
        
        if ([[[infoDic objectForKey:@"AgentInfo"]objectForKey:@"AgentCount"] isEqualToString:@"2"]) {
            
        FMResultSet *getAgent2 = [database executeQuery:@"select * from eProposal where eProposalNo = ?",proposalNo];
        while ([getAgent2 next]) {
            _intermediaryName2 = [getAgent2 objectForColumnName:@"SecondAgentName"];
            _intermediaryCode2 = [getAgent2 objectForColumnName:@"SecondAgentCode"];
        }
        }
        else
        {
            _intermediaryName2 = @"";
            _intermediaryCode2 = @"";
        
        }
        
        
        
        _proposalNumber = proposalNo;
//        _intermediaryName = [[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryName"];
//        _intermediaryNICNo = [[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryNRIC"];
//        _intermediaryCode = [[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryCode"];
//        _intermediaryContractDate = [[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryContractDate"];
//        _intermediaryManagerName = [[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryManagerName"];
        
        // get Parent / Gardian Name
        _gardianName = [[[infoDic objectForKey:@"iMobileExtraInfo"]objectForKey:@"Guardian"]objectForKey:@"GuardianName"];
        _gardianICNo = [[[infoDic objectForKey:@"iMobileExtraInfo"]objectForKey:@"Guardian"]objectForKey:@"GuardianNewIC"];
        
        id objT = [[infoDic objectForKey:@"TrusteeInfo"]objectForKey:@"Trustee"];
        NSArray *partiesArrT;
        if (![objT isKindOfClass:[NSArray class]]) {
            partiesArrT = [[NSArray alloc]initWithObjects:objT, nil];
        }
        else
        {
            partiesArrT = objT;
        }
        for (id partyy in partiesArrT) {
            if([[partyy objectForKey:@"Seq"]hasPrefix:@"1"]){
               _trusteeName = [partyy objectForKey:@"TrusteeName"];

                _TrusteeIDNumber = [[partyy objectForKey:@"TRNewIC"]objectForKey:@"TRNewICNo"];
                if (_TrusteeIDNumber.length==0) {
                   _TrusteeIDNumber = [[partyy objectForKey:@"TROtherID"]objectForKey:@"TrusteeOtherID"]; 
                }
            }
            if([[partyy objectForKey:@"Seq"]hasPrefix:@"2"]){
                _secondTrusteeName = [partyy objectForKey:@"TrusteeName"];
                
                _SecondTrusteeIDNumber = [[partyy objectForKey:@"TRNewIC"]objectForKey:@"TRNewICNo"];
                if (_SecondTrusteeIDNumber.length==0) {
                    _SecondTrusteeIDNumber = [[partyy objectForKey:@"TROtherID"]objectForKey:@"TrusteeOtherID"];
                }
            }
            
        }
        
        id obj = [[infoDic objectForKey:@"AssuredInfo"]objectForKey:@"Party"];
        NSArray *partiesArr;
        if (![obj isKindOfClass:[NSArray class]]) {
            partiesArr = [[NSArray alloc]initWithObjects:obj, nil];
        }
        else
        {
            partiesArr = obj;
        }
        for (id party in partiesArr) {
            if ([[party objectForKey:@"PTypeCode"]hasPrefix:@"LA"]&&[[party objectForKey:@"Seq"]hasPrefix:@"1"]) {
                //_lAName = [NSString stringWithFormat:@"%@ %@",[party objectForKey:@"LATitle"],[party objectForKey:@"LAName"]];
                _lAName = [party objectForKey:@"LAName"];
                _lAIDNumber = [[party objectForKey:@"LAOtherID"]objectForKey:@"LAOtherID"];
                _lAICNO = [[party objectForKey:@"LANewIC"]objectForKey:@"LANewICNo"];
                if(_lAICNO.length==0){
                   _lAICNO = [[party objectForKey:@"LAOtherID"]objectForKey:@"LAOtherID"]; 
                }
                _laICType = [[party objectForKey:@"LANewIC"]objectForKey:@"LANewICCode"];
                _lADOB = [party objectForKey:@"LADOB"];
                _agree = [party objectForKey:@"DeclarationAuth"];
                
                if (![_lAICNO length]) {
                    //_lAICNO = [[party objectForKey:@"LAOtherID"]objectForKey:@"LAOtherID"];
                    _lAICNO = @"";
                    _laICType = @"Other";
                }
                
            }
            if ([[party objectForKey:@"PTypeCode"]hasPrefix:@"LA"]&&[[party objectForKey:@"Seq"]hasPrefix:@"2"]) {
                //_secondLAName = [NSString stringWithFormat:@"%@ %@",[party objectForKey:@"LATitle"],[party objectForKey:@"LAName"]];
                _secondLAName = [party objectForKey:@"LAName"];
                _secondLAIDNumber = [[party objectForKey:@"LAOtherID"]objectForKey:@"LAOtherID"];
                _secondLAICNO = [[party objectForKey:@"LANewIC"]objectForKey:@"LANewICNo"];
                _secondLAICType = [[party objectForKey:@"LANewIC"]objectForKey:@"LANewICCode"];
                if (![_secondLAICNO length]) {
                    _secondLAICNO = [[party objectForKey:@"LAOtherID"]objectForKey:@"LAOtherID"];
                    _secondLAICType = @"Other";
                }
                
            }
            if ([[party objectForKey:@"PTypeCode"]hasPrefix:@"PO"]) {
                //_policyOwnerNamel = [NSString stringWithFormat:@"%@ %@",[party objectForKey:@"LATitle"],[party objectForKey:@"LAName"]];
                _policyOwnerNamel = [party objectForKey:@"LAName"];
                _policyOwnerIDNumber = [[party objectForKey:@"LAOtherID"]objectForKey:@"LAOtherID"];
                _policyOwnerICNO = [[party objectForKey:@"LANewIC"]objectForKey:@"LANewICNo"];
                _policyOwnerICType = [[party objectForKey:@"LANewIC"]objectForKey:@"LANewICCode"];
                
                if (![_policyOwnerICNO length]) {
                    _policyOwnerICNO = [[party objectForKey:@"LAOtherID"]objectForKey:@"LAOtherID"];
                    _policyOwnerICType = @"Other";
                }
                
            }
        }
        
        
        FMResultSet *getCC = [database executeQuery:@"select * from eProposal where eProposalNo = ?",proposalNo];
        while ([getCC next]) {
            _cardMemberAccNO = [getCC objectForColumnName:@"FTCardMemberAccountNo"];
             _cardMemberIDNumber = [getCC objectForColumnName:@"FTCardMemberOtherID"];
            _creditCardBank = [getCC objectForColumnName:@"FTCreditCardBank"];
            _cardExpiredDate = [getCC objectForColumnName:@"FTCardExpiredDate"];
            _cardMemberName = [getCC objectForColumnName:@"FTCardMemberName"];
             _cardMemberNewICNo = [getCC objectForColumnName:@"FTCardMemberNewICNo"];
            _cardMemberNameC = [getCC objectForColumnName:@"FTCardMemberName"];
            _cardMemberNewICNoC = [getCC objectForColumnName:@"FTCardMemberNewICNo"];

            if  ((NSNull *) _cardMemberNameC == [NSNull null] || [_cardMemberNameC isEqualToString:@""])
//            if (![_cardMemberNameC length] || [_cardMemberNameC isEqualToString:@"nil"]) 
            {
                _cardMemberNameC = [getCC objectForColumnName:@"CardMemberName"];
            }

            if  ((NSNull *) _cardMemberNewICNoC == [NSNull null] || [_cardMemberNewICNoC isEqualToString:@""])
            {
                _cardMemberNewICNoC = [getCC objectForColumnName:@"CardMemberOtherID"];
            }
            if  ((NSNull *) _cardMemberNewICNo == [NSNull null] || [_cardMemberNewICNo isEqualToString:@""])
            {
                _cardMemberNewICNoC = [getCC objectForColumnName:@"CardMemberNewICNo"];
            }

            if  ((NSNull *) _cardMemberNewICNo == [NSNull null] || [_cardMemberNewICNo isEqualToString:@""])
            {
                 _cardMemberNewICNo = [getCC objectForColumnName:@"FTCardMemberOtherID"];
            }
            
            
//            if ((_cardMemberName.length==0)) {
//                _cardMemberNameC = [getCC objectForColumnName:@"CardMemberName"];
//            }
            
            
//            if (_cardMemberNewICNoC.length==0) {
//                _cardMemberNewICNoC = [getCC objectForColumnName:@"CardMemberOtherID"];
//            }
//            if (_cardMemberNewICNo.length==0) {
//                _cardMemberNewICNoC = [getCC objectForColumnName:@"CardMemberNewICNo"];
//            }

            _totalModalPremium = [[infoDic objectForKey:@"PaymentInfo"]objectForKey:@"TotalModalPremium"];
           
//            if (_cardMemberNewICNo.length==0) {
//                 _cardMemberNewICNo = [getCC objectForColumnName:@"FTCardMemberOtherID"];
//            }
            _cardMemberRelationship = [getCC objectForColumnName:@"FTCardMemberRelationship"];
            // _cardMemberNameC = [getCC objectForColumnName:@"CardMemberName"];
            //_cardMemberNewICNoC = [getCC objectForColumnName:@"CardMemberNewICNo"];
           
        }
        
        if  ((NSNull *) _cardMemberName == [NSNull null])
            _cardMemberName = @"";
        if  ((NSNull *) _cardMemberIDNumber == [NSNull null])
            _cardMemberIDNumber = @"";

        if  ((NSNull *) _cardMemberNameC == [NSNull null])
            _cardMemberNameC = @"";
        if  ((NSNull *) _cardMemberIDNumberC == [NSNull null])
            _cardMemberIDNumberC = @"";
        
        
        
//         _TrusteeIDNumber = [[infoDic objectForKey:@"TrusteeInfo"]objectForKey:@"TrusteeOtherID"];
        
        _debitUpon = [[infoDic objectForKey:@"PaymentInfo"]objectForKey:@"PaymentFinalAcceptance"];
        _firstTimePayment = [[infoDic objectForKey:@"PaymentInfo"]objectForKey:@"FirstTimePayment"];

        
        
        _clientChoice = [[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"ClientChoice"];
        _clientAck = [[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"ClientAck"];
        
        //_cOName = [NSString stringWithFormat:@"%@ %@",[[infoDic objectForKey:@"ContigentInfo"]objectForKey:@"COTitle"],[[infoDic objectForKey:@"ContigentInfo"]objectForKey:@"COName"]];
        _cOName = [[infoDic objectForKey:@"ContigentInfo"]objectForKey:@"COName"];
         _cOIDNumber = [[infoDic objectForKey:@"ContigentInfo"]objectForKey:@"COOtherID"];
        _cOICNo = [[[infoDic objectForKey:@"ContigentInfo"]objectForKey:@"CONewIC"]objectForKey:@"CONewICNo"];
        _cOICType = [[[infoDic objectForKey:@"ContigentInfo"]objectForKey:@"CONewIC"]objectForKey:@"CONewICCode"];
        if (![_cOICNo length]) {
            _cOICNo = [[[infoDic objectForKey:@"ContigentInfo"]objectForKey:@"COOtherID"]objectForKey:@"COOtherID"];
            _cOICType = @"Other";
        }
        
        return [self fillOutPDF];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid XML File/Format." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];

    }

    return nil;
}

#pragma mark - Fill PDF
-(NSString *)fillOutPDF
{
 
    // See if a set saved file already exists.
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    documentDirectory = [documentDirectory stringByAppendingString:@"/Forms/"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:documentDirectory]){
        [[NSFileManager defaultManager] createDirectoryAtPath:documentDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }

    NSError * error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentDirectory
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&error];
    NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_AU.pdf",_proposalNumber]];
    
    NSString *path = documentDirectoryFilename;
    
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSString *filePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"E-Application.pdf"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager copyItemAtPath:filePathFromApp toPath:path error:nil];
        
        isReOpen = NO;
    }
    else
    {
        isReOpen = YES;
    }
    
    SetPDFPath(path);
    [self getRequiredSnapList];
    initTest();
    
    

    if (isReOpen) {
        return path;
    }
    
//    for (int i=0; i<_proposalNumber.length; i++) {
//        setValueToField([_proposalNumber substringWithRange:NSMakeRange(i, 1)], [NSString stringWithFormat:@"%@%i",kpolicyNo,i]);
//    }
    
    setValueToField(_intermediaryName, kagentName);
    setValueToField(_proposalNumber, krefNo);
//    if (_intermediaryName2 == nil || [_intermediaryName2 isEqualToString:NULL]) {
//        _intermediaryName2 = @"";
//        _intermediaryCode2 = @"";        
//    }
    setValueToField(_intermediaryName2, kagentName2);
    
    for (int i=0; i<_intermediaryCode.length; i++) {
        setValueToField([_intermediaryCode substringWithRange:NSMakeRange(i, 1)], [NSString stringWithFormat:@"%@%i",kagentCode,i]);
    }

    for (int i=0; i<_intermediaryCode2.length; i++) {
        setValueToField([_intermediaryCode2 substringWithRange:NSMakeRange(i, 1)], [NSString stringWithFormat:@"%@%i",ksecondAgentCode,i]);
    }
    
    
    setValueToField(_lAName, klAName);
    setValueToField(_lAICNO, klAICNO);
//    setValueToField(_secondLAName, ksecondLaName); // this is only for supplementary proposal
//    setValueToField(_secondLAICNO, ksecondLaICNO); // this is only for supplementary proposal
    setValueToField(_policyOwnerNamel, kpolicyOwnerName);
    setValueToField(_policyOwnerICNO, kpolicyOwnerICNO);
    
    
// only display this if First Time Payment is by Credit Card
    if ([_firstTimePayment isEqualToString:@"05"]) {
        if ([_debitUpon isEqualToString:@"Yes"]) {
            setValueToField(@"", kdebitUponSub);
            setValueToField(@"X", kdebitUponAccept);
        }
        else if ([_debitUpon isEqualToString:@"No"]) {
            setValueToField(@"X", kdebitUponSub);
            setValueToField(@"", kdebitUponAccept);
        }
        else {
            setValueToField(@"", kdebitUponSub);
            setValueToField(@"", kdebitUponAccept);
        }
        
        for (int i=0; i<_cardMemberAccNO.length; i++) {
            setValueToField([_cardMemberAccNO substringWithRange:NSMakeRange(i, 1)], [NSString stringWithFormat:@"%@%i",kcardMemberAccount,i]);
        }
        setValueToField(_creditCardBank, kissuedBy);
        
        for (int i=0; i<_cardExpiredDate.length; i++) {
            setValueToField([_cardExpiredDate substringWithRange:NSMakeRange(i, 1)], [NSString stringWithFormat:@"%@%i",kcardExpiry,i]);
        }
        
        NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
        [fmt setMaximumFractionDigits:2];
        [fmt setPositiveFormat:@"#,##0.00"];
        
        setValueToField(_cardMemberName, kcardMemberName);
        setValueToField([fmt stringFromNumber:[fmt numberFromString:_totalModalPremium]], kpolicyPerimium);
        setValueToField(_cardMemberNewICNo, kcardMemberIC);
        setValueToField(_cardMemberRelationship, kcardmemberRelation);
        //    setValueToField(_clientChoice, kquestion1);
    
    }
	else if([_recurringPayment isEqualToString:@"05"]) {
        if ([_debitUpon isEqualToString:@"Yes"]) {
            setValueToField(@"", kdebitUponSub);
            setValueToField(@"X", kdebitUponAccept);
        }
        else if ([_debitUpon isEqualToString:@"No"]) {
            setValueToField(@"X", kdebitUponSub);
            setValueToField(@"", kdebitUponAccept);
        }
        else {
            setValueToField(@"", kdebitUponSub);
            setValueToField(@"", kdebitUponAccept);
        }
        
        for (int i=0; i<_cardMemberAccNO.length; i++) {
            setValueToField([_cardMemberAccNO substringWithRange:NSMakeRange(i, 1)], [NSString stringWithFormat:@"%@%i",kcardMemberAccount,i]);
        }
        setValueToField(_creditCardBank, kissuedBy);
        
        for (int i=0; i<_cardExpiredDate.length; i++) {
            setValueToField([_cardExpiredDate substringWithRange:NSMakeRange(i, 1)], [NSString stringWithFormat:@"%@%i",kcardExpiry,i]);
        }
        
        NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
        [fmt setMaximumFractionDigits:2];
        [fmt setPositiveFormat:@"#,##0.00"];
        
        setValueToField(_cardMemberName, kcardMemberName);
        setValueToField([fmt stringFromNumber:[fmt numberFromString:_totalModalPremium]], kpolicyPerimium);
        setValueToField(_cardMemberNewICNo, kcardMemberIC);
        setValueToField(_cardMemberRelationship, kcardmemberRelation);
        //    setValueToField(_clientChoice, kquestion1);
		
    }

    
//    setValueToField(@"X", kno15AcknowledgeEng);
//    setValueToField(@"X", kno15AcknowledgeMalay);
    
    if ([_clientChoice hasPrefix:@"1"]) {
        setValueToField(@"  X", kq1cho1);
        setValueToField(@"", kq1cho2);
        setValueToField(@"", kq1cho3);
    }
    if ([_clientChoice hasPrefix:@"2"]) {
        setValueToField(@"", kq1cho1);
        setValueToField(@"  X", kq1cho2);
        setValueToField(@"", kq1cho3);
    }
    if ([_clientChoice hasPrefix:@"3"]) {
        setValueToField(@"", kq1cho1);
        setValueToField(@"", kq1cho2);
        setValueToField(@"  X", kq1cho3);
    }
    
    if ([_clientAck hasPrefix:@"1"]) {
        setValueToField(@"  X", kq2cho1);
        setValueToField(@"", kq2cho2);
    }
    if ([_clientAck hasPrefix:@"2"]) {
        setValueToField(@"", kq2cho1);
        setValueToField(@"  X", kq2cho2);
    }
    
    if ([_agree isEqualToString:@"True"]) {
        setValueToField(@"  X", kno14AgreeEng);
        setValueToField(@"  X", kno14AgreeMalay);
        setValueToField(@"", kno14DisagreeEng);
        setValueToField(@"", kno14DisagreeMalay);
    }
    else if ([_agree isEqualToString:@"False"]) {
        setValueToField(@"", kno14AgreeEng);
        setValueToField(@"", kno14AgreeMalay);
        setValueToField(@"  X", kno14DisagreeEng);
        setValueToField(@"  X", kno14DisagreeMalay);
    }
    
    
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/YYYY"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];

    //setValueToField(dateString, kdate1);
    setValueToField(_intermediaryName, kintermediaryName);
    setValueToField(_intermediaryNICNo, kintermediaryICNO);
    setValueToField(_intermediaryName, ksecondLaName2);
    setValueToField(_intermediaryNICNo, ksecondLaICNO2);
    setValueToField(_gardianName, kGardian);
    setValueToField(_gardianICNo, kGardianICNO);
    
    

    //setValueToField(_intermediaryManagerName, kmanagerName);
    if(numberOfDays<366){
        setValueToField(_intermediaryManagerName, kmanagerName);
    }
    
    saveField();
    
    return path;
}

- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}


-(void)getRequiredSnapList
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    FMResultSet *results4;
//    [dic setObject:[NSNumber numberWithBool:NO] forKey:kCustomerSign];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
    [db open];
    NSString *POOtherIDType;
    results4 = [db executeQuery:@"select LAOtherIDType from eProposal_LA_Details where eProposalNo = ? AND POFlag = ?", _proposalNumber, @"N"];
	
	while ([results4 next]) {
		POOtherIDType = [results4 objectForColumnName:@"LAOtherIDType"];
    }
    
    
    _requiredArr = [[NSMutableArray alloc]init];
    if ([_lAName length] && ![POOtherIDType isEqualToString:@"EDD"]) {
        [_requiredArr addObject:ifirstLA];
        [dic setObject:[NSNumber numberWithBool:NO] forKey:kLASign];
    }
//    if ([_secondLAName length]) {
//        [_requiredArr addObject:isecondLA];
//        [dic setObject:[NSNumber numberWithBool:NO] forKey:kLA2Sign];
//    }
    if ([_policyOwnerNamel length]) {
        [_requiredArr addObject:ipolicyOwner];
        [dic setObject:[NSNumber numberWithBool:NO] forKey:kPOSign];
    }
    if ([_cOICNo length]) {
        [_requiredArr addObject:icontigentOwner];
        [dic setObject:[NSNumber numberWithBool:NO] forKey:kCOSign];
    }
    if ([_trusteeName length]) {
        [_requiredArr addObject:ifirstTrustee];
        [dic setObject:[NSNumber numberWithBool:NO] forKey:k1stTrusteeSign];
    }
    if ([_secondTrusteeName length]) {
        [_requiredArr addObject:isecondTrustee];
        [dic setObject:[NSNumber numberWithBool:NO] forKey:k2ndTrusteeSign];
    }
    if ([_gardianName length]) {
        [_requiredArr addObject:igardian];
        [dic setObject:[NSNumber numberWithBool:NO] forKey:kGardianSign];
    }
    if ([_intermediaryName length]) {
        [_requiredArr addObject:kwitness];
        [_requiredArr addObject:iintermediary];
        [dic setObject:[NSNumber numberWithBool:NO] forKey:kAgentSign];
    }
//    if ([_intermediaryManagerName length]) {
//        if ([self dateDiff:intermediaryContractDate]<1) {
//            [_requiredArr addObject:imanager];
//            [dic setObject:[NSNumber numberWithBool:NO] forKey:kManagerSign];
//        }
//    }
    if(numberOfDays<366 && cFFSignatureRequired) {
        [_requiredArr addObject:imanager];
        [dic setObject:[NSNumber numberWithBool:NO] forKey:kManagerSign];
    }
    if ([_cardMemberName length] || [_cardMemberNameC length] ) {
        [_requiredArr addObject:icreditCard];
        [dic setObject:[NSNumber numberWithBool:NO] forKey:kCardHolderSign];
    }
//    if(numberOfDays < 365){
//        
//    }
    
    if (cFFSignatureRequired) {
        [_requiredArr addObject:cFFCustomer];
        [dic setObject:[NSNumber numberWithBool:NO] forKey:kCustomerSign];
    }
    
    if (!isReOpen) {
        SetProposalObject(dic, _proposalNumber);
    }
    
}
-(int)dateDiff:(NSString *)fromDate
{
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:fromDate]];
    int allDays = (((time/60)/60)/24);
    int days = allDays%365;
    int years = (allDays-days)/365;
    return years;
}


@end
