//
//  ESignGenerator.h
//  eSignature
//
//  Created by Danial D. Moghaddam on 5/19/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDFViewController.h"
#import "PDF.h"
#import "PDFDocument.h"
#import "PDFFormContainer.h"
#import "ConstantStr.h"

@interface ESignGenerator : NSObject
{
    int numberOfDays;
    NSString *proposalNumber;
    NSString *intermediaryName;
    NSString *intermediaryCode;
    NSString *intermediaryName2;
    NSString *intermediaryCode2;
    NSString *intermediaryNICNo;
    int intermediaryNICNo_Int;
    NSString *intermediaryICType;
    NSString *intermediaryContractDate;
    NSString *intermediaryManagerName;
    NSString *lAName;
    NSString *lAICNO;
    NSString *laICType;
    NSString *lADOB;
    NSString *secondLAName;
    NSString *secondLAICNO;
    NSString *secondLAICType;
    NSString *policyOwnerNamel;
    NSString *policyOwnerICNO;
    NSString *policyOwnerICType;
    NSString *cardMemberAccNO;
    NSString *cardExpiredDate;
    NSString *creditCardBank;
    NSString *cardMemberName;
    NSString *totalModalPremium;
    NSString *cardMemberNewICNo;
    NSString *cardMemberRelationship;
    NSString *clientChoice;
    NSString *clientAck;
    NSString *cOName;
    NSString *cOICNo;
    NSString *cOICType;
    NSString *trusteeName;
    NSString *trusteeICNo;
    NSString *trusteeICType;
    NSString *secondTrusteeName;
    NSString *secondTrusteeICNo;
    NSString *secondTrusteeICType;
    NSString *gardianName;
    NSString *gardianICNo;
    NSString *gardianICType;
    NSString *agree;
    NSString *debitUpon;
    NSString *firstTimePayment;
     NSString *getIC;
    
    BOOL isReOpen;
    BOOL cFFSignatureRequired;
    BOOL isRookie;
    
}
@property (nonatomic, strong) PDFViewController *pdfViewController;
@property (strong, nonatomic) NSMutableArray *requiredArr;
@property (nonatomic)NSString *proposalNumber,*getIC;
@property (nonatomic)NSString *intermediaryName;
@property (nonatomic)NSString *intermediaryCode;
@property (nonatomic)NSString *intermediaryName2;
@property (nonatomic)NSString *intermediaryCode2;
@property (nonatomic)NSString *intermediaryNICNo;
@property (nonatomic)NSString *intermediaryICType;
@property (nonatomic)NSString *intermediaryContractDate;
@property (nonatomic)NSString *intermediaryManagerName;
@property (nonatomic)NSString *intermediaryManagerIDNumber;
@property (nonatomic)NSString *lAName;
@property (nonatomic)NSString *lAIDNumber;
@property (nonatomic)NSString *lAICNO;
@property (nonatomic)NSString *laICType;
@property (nonatomic)NSString *lADOB;
@property (nonatomic)NSString *secondLAName;
@property (nonatomic)NSString *secondLAIDNumber;
@property (nonatomic)NSString *secondLAICNO;
@property (nonatomic)NSString *secondLAICType;
@property (nonatomic)NSString *policyOwnerNamel;
@property (nonatomic)NSString *policyOwnerIDNumber;
@property (nonatomic)NSString *policyOwnerICNO;
@property (nonatomic)NSString *policyOwnerICType;
@property (nonatomic)NSString *cardMemberAccNO;
@property (nonatomic)NSString *cardMemberIDNumber;
@property (nonatomic)NSString *cardMemberIDNumberC;
@property (nonatomic)NSString *cardMemberNameC;
@property (nonatomic)NSString *cardMemberNewICNoC;
@property (nonatomic)NSString *cardExpiredDate;
@property (nonatomic)NSString *creditCardBank;
@property (nonatomic)NSString *cardMemberName;
@property (nonatomic)NSString *totalModalPremium;
@property (nonatomic)NSString *cardMemberNewICNo;
@property (nonatomic)NSString *cardMemberRelationship;
@property (nonatomic)NSString *clientChoice;
@property (nonatomic)NSString *clientAck;
@property (nonatomic)NSString *cOName;
@property (nonatomic)NSString *cOIDNumber;
@property (nonatomic)NSString *cOICNo;
@property (nonatomic)NSString *cOICType;
@property (nonatomic)NSString *trusteeName;
@property (nonatomic)NSString *trusteeICNo;
@property (nonatomic)NSString *trusteeICType;
@property (nonatomic)NSString *secondTrusteeName;
@property (nonatomic)NSString *secondTrusteeICNo;
@property (nonatomic)NSString *secondTrusteeICType;
@property (nonatomic)NSString *gardianName;
@property (nonatomic)NSString *gardianICNo;
@property (nonatomic)NSString *gardianICType;
@property (nonatomic)NSString *agree;
@property (nonatomic)NSString *debitUpon;
@property (nonatomic)NSString *TrusteeIDNumber;
@property (nonatomic)NSString *SecondTrusteeIDNumber;
@property (nonatomic)NSString *firstTimePayment;
@property (nonatomic)NSString *recurringPayment;

@property (nonatomic)NSString *signAssured1;
@property (nonatomic)NSString *signAssured2;
@property (nonatomic)NSString *signPOOwner;
@property (nonatomic)NSString *signCOOwner;
@property (nonatomic)NSString *signTrustee1;
@property (nonatomic)NSString *signTrustee2;
@property (nonatomic)NSString *signParent;
@property (nonatomic)NSString *signWitness;
@property (nonatomic)NSString *signCardholder;

-(NSString *)eApplicationForProposalNo:(NSString *)proposalNo fromInfoDic:(NSDictionary *)infoDic;

@end
