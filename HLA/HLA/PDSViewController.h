//
//  PDSViewController.h
//  HLA Ipad
//
//  Created by infoconnect on 1/7/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class DataTable,DBController;
@interface PDSViewController : UIViewController{
    NSString *databasePath, *RatesDatabasePath;
    sqlite3 *contactDB;
}

@property (nonatomic,strong) id SINo;
@property (nonatomic,strong) id PDSLanguage;
@property (nonatomic,strong) id PDSPlanCode;
@property (strong, nonatomic) DBController* db;
@property (strong, nonatomic) DataTable * dataTable;
@property (nonatomic,strong) id strBasicAnnually, strBasicSemiAnnually, strBasicQuarterly, strBasicMonthly;
@property (nonatomic,strong) id strOriBasicAnnually, strOriBasicSemiAnnually, strOriBasicQuarterly, strOriBasicMonthly;
@property (nonatomic, assign) int Age;
@property (nonatomic, assign) int PayorAge;
@property (nonatomic, assign) int PolicyTerm;
@property (nonatomic, assign) double BasicSA;
@property (nonatomic,strong) id sex, OccpClass,HealthLoading, HealthLoadingTerm, TempHealthLoading, TempHealthLoadingTerm ;
@property (nonatomic,strong) id YearlyIncome;
@property (nonatomic,strong) id CashDividend;
@property (nonatomic, assign) int PartialAcc;
@property (nonatomic, assign) int PartialPayout;
@property (retain, nonatomic) NSMutableArray *aStrOtherRiderAnnually;
@property (retain, nonatomic) NSMutableArray *aStrOtherRiderSemiAnnually;
@property (retain, nonatomic) NSMutableArray *aStrOtherRiderQuarterly;
@property (retain, nonatomic) NSMutableArray *aStrOtherRiderMonthly;
@property (retain, nonatomic) NSMutableArray *OccLoading;
@property (retain, nonatomic) NSMutableArray *aStrBasicSA;

@property (retain, nonatomic) NSMutableArray *OtherRiderCode;
@property (retain, nonatomic) NSMutableArray *OtherRiderTerm;
@property (retain, nonatomic) NSMutableArray *OtherRiderDesc;
@property (retain, nonatomic) NSMutableArray *OtherRiderSA;
@property (retain, nonatomic) NSMutableArray *OtherRiderPlanOption;
@property (retain, nonatomic) NSMutableArray *OtherRiderDeductible;
@property (retain, nonatomic) NSMutableArray *OtherRiderHL1kSA;
@property (retain, nonatomic) NSMutableArray *OtherRiderHL1kSATerm;
@property (retain, nonatomic) NSMutableArray *OtherRiderHL100SA;
@property (retain, nonatomic) NSMutableArray *OtherRiderHL100SATerm;
@property (retain, nonatomic) NSMutableArray *OtherRiderHLPercentage;
@property (retain, nonatomic) NSMutableArray *OtherRiderHLPercentageTerm;
@property (retain, nonatomic) NSMutableArray *OtherRiderTempHL;
@property (retain, nonatomic) NSMutableArray *OtherRiderTempHLTerm;


#define IsAtLeastiOSVersion(X) ([[[UIDevice currentDevice] systemVersion] compare:X options:NSNumericSearch] != NSOrderedAscending)
@end
