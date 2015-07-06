//
//  ReportToPdf.h
//  iMobile Planner
//
//  Created by infoconnect on 1/8/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDHTMLtoPDF.h"
#import <sqlite3.h>

@interface ReportToPdf : UIViewController<NDHTMLtoPDFDelegate>{
	NSString *databasePath;
	sqlite3 *contactDB;
	NSString *getMOP;
	NSString *getTerm;
	NSString *getBasicSA;
}

@property (nonatomic, retain) NSString *NeedFurtherInfo;
@property (nonatomic, strong) NDHTMLtoPDF *PDFCreator;
@property (nonatomic, retain) NSString *getSINo;
@property (nonatomic, retain) NSString *getModule;
@property (nonatomic, retain) NSString *getPlanCode;
@property (nonatomic, retain) NSString *Language;
@property (nonatomic, retain) NSString *CustCode;
@property (nonatomic, retain) NSString *CustCode2nd;
@property (nonatomic, retain) NSString *CustCodePayor;
@property (nonatomic, retain) NSString *OccpCode;
@property (nonatomic, retain) NSString *OccpCode2nd;
@property (nonatomic, retain) NSString *OccpCodePayor;
@property (nonatomic, retain) NSString *getOccLoading;
@property (nonatomic, retain) NSString *getCommDate;
@property (nonatomic, retain) NSString *getDOB;
@property (nonatomic, retain) NSString *getSex;
@property (nonatomic, retain) NSString *getSmoker;
@property (nonatomic, retain) NSString *getOccpClass;
@property (nonatomic, retain) NSString *getDOB2nd;
@property (nonatomic, retain) NSString *getSex2nd;
@property (nonatomic, retain) NSString *getSmoker2nd;
@property (nonatomic, retain) NSString *getOccpClass2nd;
@property (nonatomic, retain) NSString *getDOBPayor;
@property (nonatomic, retain) NSString *getSexPayor;
@property (nonatomic, retain) NSString *getSmokerPayor;
@property (nonatomic, retain) NSString *getOccpClassPayor;
@end
