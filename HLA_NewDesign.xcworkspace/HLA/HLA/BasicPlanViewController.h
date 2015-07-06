//
//  BasicPlanViewController.h
//  HLA
//
//  Created by shawal sapuan on 8/1/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "PlanList.h"
#import "BasicPlanHandler.h"
#import "PayorHandler.h"
#import "SecondLAHandler.h"
#import "AppDelegate.h"
#import "SIObj.h"

@class BasicPlanViewController;
@protocol BasicPlanViewControllerDelegate
-(void) BasicSI:(NSString *)aaSINo andAge:(int)aaAge andOccpCode:(NSString *)aaOccpCode andCovered:(int)aaCovered andBasicSA:(NSString *)aaBasicSA andBasicHL:(NSString *)aaBasicHL andBasicTempHL:(NSString *)aaBasicTempHL andMOP:(int)aaMOP andPlanCode:(NSString *)aaPlanCode andAdvance:(int)aaAdvance andBasicPlan:(NSString *)aabasicPlan;

-(void)RiderAdded;
-(void)BasicSARevised:(NSString *)aabasicSA;
-(void)saveAll;
-(void)isSaveBasicPlan:(BOOL)temp;
@end

@interface BasicPlanViewController : UIViewController <UITextFieldDelegate,PlanListDelegate>{
    NSString *databasePath;
    sqlite3 *contactDB;
    UITextField *activeField;
    UIPopoverController *_planPopover;
    PlanList *_planList;
    BOOL showHL;
    BOOL useExist;
    BOOL newSegment;
    id <BasicPlanViewControllerDelegate> _delegate;
	SIObj* basicPlanSIObj;
	AppDelegate* appDelegate;
}

@property (nonatomic, retain) UIPopoverController *planPopover;
@property (nonatomic, retain) PlanList *planList;
@property (nonatomic,strong) id <BasicPlanViewControllerDelegate> delegate;
@property (nonatomic,strong) BasicPlanHandler *basicBH;
@property (nonatomic,strong) PayorHandler *basicPH;
@property (nonatomic,strong) SecondLAHandler *basicLa2ndH;
@property (strong, nonatomic) NSMutableArray *dataInsert;
//--request from previous
@property (nonatomic, assign,readwrite) int requestAge;
@property (nonatomic,strong) id requestOccpCode;
@property (nonatomic, assign,readwrite) int requestOccpClass;
@property (nonatomic,strong) id requestSINo;
@property (nonatomic, assign,readwrite) int requestIDProf;
@property (nonatomic, assign,readwrite) int requestIDPay;
@property (nonatomic, assign,readwrite) int requestIndexPay;
@property (nonatomic,strong) id requestSmokerPay;
@property (nonatomic,strong) id requestSexPay;
@property (nonatomic,strong) id requestDOBPay;
@property (nonatomic, assign,readwrite) int requestAgePay;
@property (nonatomic,strong) id requestOccpPay;
@property (nonatomic, assign,readwrite) int requestIndex2ndLA;
@property (nonatomic,strong) id requestSmoker2ndLA;
@property (nonatomic,strong) id requestSex2ndLA;
@property (nonatomic,strong) id requestDOB2ndLA;
@property (nonatomic, assign,readwrite) int requestAge2ndLA;
@property (nonatomic,strong) id requestOccp2ndLA;

@property (nonatomic, assign,readwrite) int ageClient;
@property(nonatomic , retain) NSString *OccpCode;
@property (nonatomic, assign,readwrite) int OccpClass;
@property (nonatomic, copy) NSString *SINo;
@property (nonatomic, assign,readwrite) int idPay;
@property (nonatomic, assign,readwrite) int idProf;
@property (nonatomic, assign,readwrite) int PayorIndexNo;
@property (nonatomic, copy) NSString *PayorSmoker;
@property (nonatomic, copy) NSString *PayorSex;
@property (nonatomic, copy) NSString *PayorDOB;
@property (nonatomic, assign,readwrite) int PayorAge;
@property (nonatomic, copy) NSString *PayorOccpCode;
@property (nonatomic, assign,readwrite) int secondLAIndexNo;
@property (nonatomic, copy) NSString *secondLASmoker;
@property (nonatomic, copy) NSString *secondLASex;
@property (nonatomic, copy) NSString *secondLADOB;
@property (nonatomic, assign,readwrite) int secondLAAge;
@property (nonatomic, copy) NSString *secondLAOccpCode;
//--
@property (strong, nonatomic) IBOutlet UIButton *btnPlan;
@property (retain, nonatomic) IBOutlet UITextField *termField;
@property (retain, nonatomic) IBOutlet UITextField *yearlyIncomeField;
@property (retain, nonatomic) IBOutlet UILabel *minSALabel;
@property (retain, nonatomic) IBOutlet UILabel *maxSALabel;
@property (retain, nonatomic) IBOutlet UIButton *btnHealthLoading;
@property (retain, nonatomic) IBOutlet UIView *healthLoadingView;
@property (retain, nonatomic) IBOutlet UITextField *HLField;
@property (retain, nonatomic) IBOutlet UITextField *HLTermField;
@property (retain, nonatomic) IBOutlet UITextField *tempHLField;
@property (retain, nonatomic) IBOutlet UITextField *tempHLTermField;
@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (strong, nonatomic) IBOutlet UIToolbar *myToolBar;
@property (strong, nonatomic) IBOutlet UILabel *labelFour;
@property (strong, nonatomic) IBOutlet UILabel *labelFive;
@property (strong, nonatomic) IBOutlet UILabel *labelSix;
@property (strong, nonatomic) IBOutlet UILabel *labelSeven;
@property (strong, nonatomic) IBOutlet UILabel *labelParAcc;
@property (strong, nonatomic) IBOutlet UILabel *labelParPayout;
@property (strong, nonatomic) IBOutlet UILabel *labelPercent1;
@property (strong, nonatomic) IBOutlet UILabel *labelPercent2;
@property (strong, nonatomic) IBOutlet UITextField *parAccField;
@property (strong, nonatomic) IBOutlet UITextField *parPayoutField;
@property (retain, nonatomic) IBOutlet UISegmentedControl *MOPSegment;
@property (retain, nonatomic) IBOutlet UISegmentedControl *incomeSegment;
@property (retain, nonatomic) IBOutlet UISegmentedControl *cashDividendSegment;
@property (retain, nonatomic) IBOutlet UISegmentedControl *advanceIncomeSegment;
@property (strong, nonatomic) IBOutlet UISegmentedControl *cashDivSgmntCP;
@property (strong, nonatomic) IBOutlet UILabel *labelAddHL;
@property (strong, nonatomic) IBOutlet UILabel *headerTitle;
@property (weak, nonatomic) IBOutlet UISegmentedControl *quotationLangSegment;



//for SINo
@property (nonatomic, assign,readwrite) int SILastNo;
@property (nonatomic, assign,readwrite) int CustLastNo;
@property (nonatomic, copy) NSString *SIDate;
@property (nonatomic, copy) NSString *CustDate;

@property (nonatomic, copy) NSString *LACustCode;
@property (nonatomic, copy) NSString *PYCustCode;
@property (nonatomic, copy) NSString *secondLACustCode;
@property (nonatomic, assign,readwrite) int IndexNo;

@property (nonatomic, assign,readwrite) int termCover;
@property (nonatomic, assign,readwrite) int maxAge;
@property (nonatomic, assign,readwrite) int minSA;
@property (nonatomic, assign,readwrite) int maxSA;
@property (nonatomic,strong) NSString *planChoose;

@property(nonatomic , retain) NSString *NamePP;
@property(nonatomic , retain) NSString *DOBPP;
@property(nonatomic , retain) NSString *GenderPP;
@property(nonatomic , retain) NSString *OccpCodePP;
//use to calculate
@property (nonatomic, assign,readwrite) int MOP;
@property (nonatomic, assign,readwrite) int MOPHLAIB;
@property (nonatomic, assign,readwrite) int MOPHLACP;
@property (nonatomic, copy) NSString *yearlyIncome;
@property (nonatomic, copy) NSString *yearlyIncomeHLAIB;
@property (nonatomic, copy) NSString *cashDividend;
@property (nonatomic, copy) NSString *cashDividendHLAIB;
@property (nonatomic, copy) NSString *cashDividendHLACP;
@property (nonatomic, assign,readwrite) int advanceYearlyIncome;
@property (nonatomic, assign,readwrite) int advanceYearlyIncomeHLAIB;
@property (nonatomic, assign,readwrite) int advanceYearlyIncomeHLACP;
@property (nonatomic, assign,readwrite) int basicRate;      //mark
@property (nonatomic,strong) NSString *planCode;
@property (nonatomic, copy) NSString *quotationLang;
//to display
@property (nonatomic,strong) NSString *getSINo;
@property (nonatomic,assign,readwrite) int getPolicyTerm;
@property (nonatomic,assign,readwrite) double getSumAssured;
@property (nonatomic,copy) NSString *getHL;
@property (nonatomic,copy) NSString *getTempHL;
@property (nonatomic,assign,readwrite) int getTempHLTerm;
@property (nonatomic,assign,readwrite) int getHLTerm;
@property (nonatomic,assign,readwrite) int getParAcc;
@property (nonatomic,assign,readwrite) int getParPayout;

@property (retain, nonatomic) NSMutableArray *LRiderCode;
@property (retain, nonatomic) NSMutableArray *LSumAssured;
@property (retain, nonatomic) NSMutableArray *LTerm;
@property (retain, nonatomic) NSMutableArray *LPlanOpt;
@property (retain, nonatomic) NSMutableArray *LUnits;
@property(nonatomic , retain) NSMutableArray *LDeduct;
@property(nonatomic , retain) NSMutableArray *LOccpCode;
@property(nonatomic , retain) NSMutableArray *LRidHL1K;
@property(nonatomic , retain) NSMutableArray *LRidHL100;
@property(nonatomic , retain) NSMutableArray *LRidHLP;
@property(nonatomic , retain) NSMutableArray *LSmoker;
@property(nonatomic , retain) NSMutableArray *LSex;
@property(nonatomic , retain) NSMutableArray *LAge;
@property(nonatomic , retain) NSMutableArray *LTempRidHL1K;

@property (nonatomic, assign,readwrite) int age;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic, assign,readwrite) double riderRate;
@property (nonatomic,copy) NSString *pTypeOccp;
@property (nonatomic, assign,readwrite) int occLoadRider;
@property (nonatomic, assign,readwrite) double riderPrem;
@property (nonatomic, assign,readwrite) double medRiderPrem;
@property (nonatomic,strong) NSMutableArray *waiverRiderAnn;
@property (nonatomic,strong) NSMutableArray *waiverRiderQuar;
@property (nonatomic,strong) NSMutableArray *waiverRiderHalf;
@property (nonatomic,strong) NSMutableArray *waiverRiderMonth;
@property (nonatomic,strong) NSMutableArray *waiverRiderAnn2;
@property (nonatomic,strong) NSMutableArray *waiverRiderQuar2;
@property (nonatomic,strong) NSMutableArray *waiverRiderHalf2;
@property (nonatomic,strong) NSMutableArray *waiverRiderMonth2;
@property (nonatomic,strong) NSMutableArray *annualMedRiderPrem;
@property (nonatomic,strong) NSMutableArray *quarterMedRiderPrem;
@property (nonatomic,strong) NSMutableArray *halfMedRiderPrem;
@property (nonatomic,strong) NSMutableArray *monthMedRiderPrem;
@property (nonatomic, assign,readwrite) double annualRiderSum;
@property (nonatomic, assign,readwrite) double halfRiderSum;
@property (nonatomic, assign,readwrite) double quarterRiderSum;
@property (nonatomic, assign,readwrite) double monthRiderSum;
@property (nonatomic, assign,readwrite) double annualMedRiderSum;
@property (nonatomic, assign,readwrite) double halfMedRiderSum;
@property (nonatomic, assign,readwrite) double quarterMedRiderSum;
@property (nonatomic, assign,readwrite) double monthMedRiderSum;

@property (nonatomic,copy) NSString *riderCode;
@property (nonatomic, assign,readwrite) int expAge;
@property (nonatomic, assign,readwrite) int minSATerm;
@property (nonatomic, assign,readwrite) int maxSATerm;
@property (nonatomic, assign,readwrite) int minTerm;
@property (nonatomic, assign,readwrite) int maxTerm;
@property (nonatomic, assign,readwrite) double _maxRiderSA;
@property (nonatomic, assign,readwrite) double maxRiderSA;
@property (nonatomic, assign,readwrite) int GYI;
@property (nonatomic, assign,readwrite) int occLoad;
@property(nonatomic , assign,readwrite) int occCPA_PA;
@property (nonatomic, assign,readwrite) int LSDRate;
@property (nonatomic, assign,readwrite) double basicPremAnn;
@property (nonatomic, assign,readwrite) double basicPremHalf;
@property (nonatomic, assign,readwrite) double basicPremQuar;
@property (nonatomic, assign,readwrite) double basicPremMonth;

-(void)keyboardDidShow:(NSNotificationCenter *)notification;
-(void)keyboardDidHide:(NSNotificationCenter *)notification;

- (IBAction)btnPlanPressed:(id)sender;
- (IBAction)btnShowHealthLoadingPressed:(id)sender;
- (IBAction)doSavePlan:(id)sender;
- (IBAction)MOPSegmentPressed:(id)sender;
- (IBAction)incomeSegmentPressed:(id)sender;
- (IBAction)advanceIncomeSegmentPressed:(id)sender;
- (IBAction)cashDividendSegmentPressed:(id)sender;
- (IBAction)cashDivSgmntCPPressed:(id)sender;
- (IBAction)quotationLangSegmentPressed:(id)sender;

- (BOOL)validateSave;
-(BOOL)checkingSave;
-(void)checkingExisting;//added by Edwin
-(void)loadData;
-(BOOL)isBasicPlanSelected;

@end
