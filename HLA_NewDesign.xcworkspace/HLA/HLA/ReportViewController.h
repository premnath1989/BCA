//
//  ReportViewController.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 10/18/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class DataTable,DBController;
@interface ReportViewController : UIViewController
{
    NSString *databasePath, *RatesDatabasePath;
    sqlite3 *contactDB;
}
@property (nonatomic,strong) id SINo;
@property (nonatomic,strong) id YearlyIncome;
@property (nonatomic,strong) id CashDividend;
@property (nonatomic,strong) id CustCode;
@property (nonatomic,strong) id Name;
@property (nonatomic,strong) id strBasicAnnually, strBasicSemiAnnually, strBasicQuarterly, strBasicMonthly;
@property (nonatomic,strong) id strOriBasicAnnually, strOriBasicSemiAnnually, strOriBasicQuarterly, strOriBasicMonthly;
@property (nonatomic,strong) id sex, OccpClass,HealthLoading, HealthLoadingTerm, TempHealthLoading, TempHealthLoadingTerm ;
@property (retain, nonatomic) NSMutableArray *OccLoading;
//@property (nonatomic,strong) id strIncomeRiderAnnually;
@property (retain, nonatomic) NSMutableArray *aStrIncomeRiderAnnually;
@property (retain, nonatomic) NSMutableArray *aStrOtherRiderAnnually;
@property (retain, nonatomic) NSMutableArray *aStrIncomeRiderSemiAnnually;
@property (retain, nonatomic) NSMutableArray *aStrOtherRiderSemiAnnually;
@property (retain, nonatomic) NSMutableArray *aStrIncomeRiderQuarterly;
@property (retain, nonatomic) NSMutableArray *aStrOtherRiderQuarterly;
@property (retain, nonatomic) NSMutableArray *aStrIncomeRiderMonthly;
@property (retain, nonatomic) NSMutableArray *aStrOtherRiderMonthly;
@property (retain, nonatomic) NSMutableArray *aStrBasicSA;
@property (nonatomic, assign) int Age;
@property (nonatomic, assign) int PolicyTerm;
@property (nonatomic, assign) int BasicSA;
@property (nonatomic, assign) int PremiumPaymentOption;
@property (nonatomic, assign) int AdvanceYearlyIncome;
//@property (nonatomic, assign) int HealthLoading;
@property (retain, nonatomic) NSMutableArray *IncomeRiderCode;
@property (retain, nonatomic) NSMutableArray *IncomeRiderTerm;
@property (retain, nonatomic) NSMutableArray *IncomeRiderDesc;
@property (retain, nonatomic) NSMutableArray *IncomeRiderSA;
@property (retain, nonatomic) NSMutableArray *IncomeRiderPlanOption;
@property (retain, nonatomic) NSMutableArray *OtherRiderCode;
@property (retain, nonatomic) NSMutableArray *OtherRiderTerm;
@property (retain, nonatomic) NSMutableArray *OtherRiderDesc;
@property (retain, nonatomic) NSMutableArray *OtherRiderSA;
@property (retain, nonatomic) NSMutableArray *OtherRiderPlanOption;
@property (retain, nonatomic) NSMutableArray *OtherRiderDeductible;

//summary
@property (retain, nonatomic) NSMutableArray *SummaryGuaranteedTotalGYI;
@property (retain, nonatomic) NSMutableArray *SummaryGuaranteedSurrenderValue;
@property (retain, nonatomic) NSMutableArray *SummaryGuaranteedDBValueA;
@property (retain, nonatomic) NSMutableArray *SummaryGuaranteedDBValueB;
@property (retain, nonatomic) NSMutableArray *SummaryGuaranteedAddValue;
@property (retain, nonatomic) NSMutableArray *SummaryGuaranteedAddEndValue;
@property (retain, nonatomic) NSMutableArray *SummaryNonGuaranteedAccuYearlyIncomeA;
@property (retain, nonatomic) NSMutableArray *SummaryNonGuaranteedAccuYearlyIncomeB;
@property (retain, nonatomic) NSMutableArray *SummaryNonGuaranteedAccuCashDividendA;
@property (retain, nonatomic) NSMutableArray *SummaryNonGuaranteedAccuCashDividendB;
@property (retain, nonatomic) NSMutableArray *SummaryNonGuaranteedSurrenderValueA;
@property (retain, nonatomic) NSMutableArray *SummaryNonGuaranteedSurrenderValueB;
@property (retain, nonatomic) NSMutableArray *SummaryNonGuaranteedDBValueA;
@property (retain, nonatomic) NSMutableArray *SummaryNonGuaranteedDBValueB;

//for total sum Basic
@property (nonatomic, assign) double BasicTotalPremiumPaid;
@property (nonatomic, assign) double BasicMaturityValueA;
@property (nonatomic, assign) double BasicMaturityValueB;
@property (nonatomic, assign) double BasicTotalYearlyIncome;

//for total entire policy
@property (nonatomic, assign) double EntireTotalPremiumPaid;
@property (nonatomic, assign) double EntireMaturityValueA;
@property (nonatomic, assign) double EntireMaturityValueB;
@property (nonatomic, assign) double EntireTotalYearlyIncome;

//for total premium paid for basic plan and income rider only
@property (nonatomic, assign) double TotalPremiumBasicANDIncomeRider;

@property (strong, nonatomic) DBController* db;
@property (strong, nonatomic) DataTable * dataTable;

#define IsAtLeastiOSVersion(X) ([[[UIDevice currentDevice] systemVersion] compare:X options:NSNumericSearch] != NSOrderedAscending)

@end
