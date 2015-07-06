//
//  EverLifeViewController.h
//  iMobile Planner
//
//  Created by infoconnect on 8/15/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class DataTable,DBController;
@interface EverLifeViewController : UIViewController{
	NSString *databasePath, *RatesDatabasePath, *UL_RatesDatabasePath;
    sqlite3 *contactDB;
	
}

@property (nonatomic,strong) id SINo;
@property (nonatomic,strong) id PDSorSI;
@property (nonatomic,strong) id EngOrBm;
@property (nonatomic,strong) id YearlyIncome;
@property (nonatomic,strong) id CashDividend;
@property (nonatomic,strong) id CustCode;
@property (nonatomic,strong) id Name;
@property (nonatomic,strong) id sex, OccpClass,HealthLoading, HealthLoadingTerm, TempHealthLoading, TempHealthLoadingTerm ;
@property (nonatomic, assign) int Age;
@property (nonatomic, assign) int PayorAge;
@property (nonatomic, assign) int PolicyTerm;
@property (nonatomic, assign) int PolicySustainYear;
@property (nonatomic, assign) double BasicSA;
@property (nonatomic,strong) id requestOccLoading;
@property (nonatomic,strong) id requestPlanCommDate;
@property (nonatomic,strong) id getPlanCommDate;
@property (nonatomic,strong) id getDOB;
@property (nonatomic,strong) id requestDOB;
@property (nonatomic,strong) id requestSexLA;
@property (nonatomic,strong) id getSexLA;
@property (nonatomic,strong) id requestSmokerLA;
@property (nonatomic,strong) id getSmokerLA;
@property (nonatomic, assign) int requestOccpClass;
@property (nonatomic, assign) int getOccpClass;
@property (nonatomic,strong) id SimpleOrDetail;
@property (nonatomic,strong) id StopMessage1;
@property (nonatomic,strong) id StopMessage2;
@property (nonatomic,strong) id StopMessage3;
@property (nonatomic,strong) id StopMessage4;
@property (nonatomic,strong) id HeaderMsg;
@property (nonatomic,strong) id CheckSustainLevel;
@property (nonatomic,assign) BOOL StopExec;
@property (nonatomic,strong) id Solution1;
@property (nonatomic,strong) id Solution2;

@property (retain, nonatomic) NSMutableArray *OtherRiderCode;
@property (retain, nonatomic) NSMutableArray *OtherRiderTerm;
@property (retain, nonatomic) NSMutableArray *OtherRiderDesc;
@property (retain, nonatomic) NSMutableArray *OtherRiderSA;
@property (retain, nonatomic) NSMutableArray *OtherRiderPlanOption;
@property (retain, nonatomic) NSMutableArray *OtherRiderDeductible;
@property (retain, nonatomic) NSMutableArray *OtherRiderHL;
@property (retain, nonatomic) NSMutableArray *OtherRiderHLTerm;
@property (retain, nonatomic) NSMutableArray *OtherRiderHLP;
@property (retain, nonatomic) NSMutableArray *OtherRiderHLPTerm;
@property (retain, nonatomic) NSMutableArray *OtherRiderPremium;
@property (retain, nonatomic) NSMutableArray *OtherRiderPaymentTerm;

@property (retain, nonatomic) NSMutableArray *UnitizeRiderCode;
@property (retain, nonatomic) NSMutableArray *UnitizeRiderSA;
@property (retain, nonatomic) NSMutableArray *UnitizeRiderHL;
@property (retain, nonatomic) NSMutableArray *UnitizeRiderHLPct;
@property (retain, nonatomic) NSMutableArray *UnitizeRiderTerm;
//@property (retain, nonatomic) NSMutableArray *UnitizeRiderMort;
@property (retain, nonatomic) NSMutableArray *UnitizeRiderPlanChoice;
@property (retain, nonatomic) NSMutableArray *UnitizeRiderDeductible;
//@property (retain, nonatomic) NSMutableArray *UnitizeRiderAlloc;
@property (retain, nonatomic) NSMutableArray *UnitizeRiderPremium;
@property (retain, nonatomic) NSMutableArray *UniTotalRiderPremAtPolYear;
@property (retain, nonatomic) NSMutableArray *UniTotalRiderPremWithAlloc;

@property (retain, nonatomic) NSMutableArray *OverallTotalPremiumPaid;
@property (retain, nonatomic) NSMutableArray *OverallTPDBegin;
@property (retain, nonatomic) NSMutableArray *OverallTPDEOY;
@property (retain, nonatomic) NSMutableArray *OverallOADBegin;
@property (retain, nonatomic) NSMutableArray *OverallOADEOY;
@property (retain, nonatomic) NSMutableArray *OverallAddTPDBegin;
@property (retain, nonatomic) NSMutableArray *OverallAddTPDEOY;
@property (retain, nonatomic) NSMutableArray *OverallYearlyIncome;
@property (retain, nonatomic) NSMutableArray *OverallMonthlyIncome;
@property (retain, nonatomic) NSMutableArray *OverallFullSurrenderValue;
@property (retain, nonatomic) NSMutableArray *OverallTotalFundSurrenderValueBull;
@property (retain, nonatomic) NSMutableArray *OverallTotalFundSurrenderValueFlat;
@property (retain, nonatomic) NSMutableArray *OverallTotalFundSurrenderValueBear;
@property (retain, nonatomic) NSMutableArray *OverallEOYTotalTPDBull;
@property (retain, nonatomic) NSMutableArray *OverallEOYTotalTPDFlat;
@property (retain, nonatomic) NSMutableArray *OverallEOYTotalTPDBear;
@property (retain, nonatomic) NSMutableArray *OverallEOYTotalOADBull;
@property (retain, nonatomic) NSMutableArray *OverallEOYTotalOADFlat;
@property (retain, nonatomic) NSMutableArray *OverallEOYTotalOADBear;

@property (strong, nonatomic) DBController* db;
@property (strong, nonatomic) DataTable * dataTable;

-(double)PremRequired;
-(double)FromBasic :(NSString *)aaATPrem andGetHL :(NSString *)aaGetHL andGetHLPct :(NSString *)aaGetHLPct 
		andBumpMode :(NSString *)aaBumpMode andBasicSA :(NSString *)aaBasicSA andRTUPFrom :(NSString *)aaRTUPFrom andRTUPFor :(NSString *)aaRTUPFor
		andRTUPAmount :(NSString *)aaRTUPAmount andSmokerLA :(NSString *)aaSmokerLA andOccLoading :(NSString *)aaOccLoading
		andPlanCommDate :(NSString *)aaPlanCommDate andDOB :(NSString *)aaDOB andSexLA :(NSString *)aaSexLA andSino :(NSString *)aaSino
		andLAAge:(int)aaLAAge andGrayRTUO :(double)aaGrayRTUO ;

#define IsAtLeastiOSVersion(X) ([[[UIDevice currentDevice] systemVersion] compare:X options:NSNumericSearch] != NSOrderedAscending)
@end
