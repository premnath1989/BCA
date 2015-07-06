//
//  ConstantStr.h
//  eSignature
//
//  Created by Danial D. Moghaddam on 5/19/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//

#ifndef eSignature_ConstantStr_h
#define eSignature_ConstantStr_h


#define SetSigNameObject(obj) [[NSUserDefaults standardUserDefaults]setObject:obj forKey:@"signatureName"];[[NSUserDefaults standardUserDefaults]synchronize]
#define GetObjectSigName      [[NSUserDefaults standardUserDefaults]stringForKey:@"signatureName"]

#define SetProposalObject(obj,proposalNo) [[NSUserDefaults standardUserDefaults]setObject:obj forKey:proposalNo];[[NSUserDefaults standardUserDefaults]synchronize]
#define GetProposalObject(proposalNo)      [[NSUserDefaults standardUserDefaults]objectForKey:proposalNo]

#define SetPDFPath(obj) [[NSUserDefaults standardUserDefaults]setObject:obj forKey:@"pdfPath"];[[NSUserDefaults standardUserDefaults]synchronize]
#define GetPDFPath      [[NSUserDefaults standardUserDefaults]objectForKey:@"pdfPath"]

#define SetSignerName(obj) [[NSUserDefaults standardUserDefaults]setObject:obj forKey:@"signerName"];[[NSUserDefaults standardUserDefaults]synchronize]
#define GetSignerName      [[NSUserDefaults standardUserDefaults]objectForKey:@"signerName"]

#define SetFormDataModel(obj) [[NSUserDefaults standardUserDefaults]setObject:obj forKey:@"dataModel"];[[NSUserDefaults standardUserDefaults]synchronize]
#define GetFormDataModel      [[NSUserDefaults standardUserDefaults]objectForKey:@"dataModel"]

#define kCustomerSign @"kCustomerSign"
#define kAgentSign    @"kAgentSign"
#define kManagerSign  @"kManagerSign"
#define kLASign       @"kLASign"
#define kLA2Sign      @"kLA2Sign"
#define kPOSign       @"kPOSign"
#define kCOSign       @"kCOSign"
#define k1stTrusteeSign   @"k1stTrusteeSign"
#define k2ndTrusteeSign   @"k2ndTrusteeSign"
#define kGardianSign      @"kGardianSign"
#define kWitnessSign      @"kWitnessSign"
#define kCardHolderSign   @"kCardHolderSign"

#endif
