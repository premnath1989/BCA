//
//  RiderViewController.h
//  HLA
//
//  Created by shawal sapuan on 8/1/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "RiderPTypeTbViewController.h"
#import "RiderListTbViewController.h"
#import "BasicPlanHandler.h"
#import "RiderPlanTb.h"
#import "RiderDeducTb.h"
#import "AppDelegate.h"
#import "MainScreen.h"

@class RiderViewController;
@protocol RiderViewControllerDelegate
-(void) RiderAdded;
-(void) BasicSARevised:(NSString *)aabasicSA;
-(void) saveAll;
@end

@interface RiderViewController : UIViewController <RiderPTypeTbViewControllerDelegate,RiderListTbViewControllerDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,RiderDeducTbDelegate,RiderPlanTbDelegate>
{
    NSString *databasePath;
    NSString *RatesDatabasePath;
    sqlite3 *contactDB;
    UIPopoverController *_pTypePopOver;
    UIPopoverController *_RiderListPopover;
    UIPopoverController *_planPopover;
    UIPopoverController *_deducPopover;
    RiderPTypeTbViewController *_PTypeList;
    RiderListTbViewController *_RiderList;
    RiderPlanTb *_planList;
    RiderDeducTb *_deductList;
    id <RiderViewControllerDelegate> _delegate;
    BOOL term;
    BOOL sumA;
    BOOL plan;
    BOOL unit;
    BOOL deduc;
    BOOL hload;
    BOOL hloadterm;
    BOOL pressedPlan;
    BOOL pressedDeduc;
    BOOL incomeRider;
    BOOL PtypeChange;
    NSMutableArray *ItemToBeDeleted;
    NSMutableArray *indexPaths;
    UITextField *activeField;
	AppDelegate *appDelegate;

	
}

@property (nonatomic, retain) UIPopoverController *RiderListPopover;
@property (nonatomic, retain) UIPopoverController *planPopover;
@property (nonatomic, retain) UIPopoverController *deducPopover;
@property (nonatomic,strong) UIPopoverController *pTypePopOver;

@property (nonatomic,strong) BasicPlanHandler *riderBH;
@property (strong, nonatomic) NSMutableArray *dataInsert;
@property (nonatomic, retain) RiderListTbViewController *RiderList;
@property (nonatomic, retain) RiderPlanTb *planList;
@property (nonatomic, retain) RiderDeducTb *deductList;
@property (nonatomic, retain) RiderPTypeTbViewController *PTypeList;
@property (nonatomic,strong) id <RiderViewControllerDelegate> delegate;
//--request
@property (nonatomic,strong) id requestSINo;
@property (nonatomic,strong) id requestPlanCode;
@property (nonatomic,strong) id requestPlanChoose;
@property (nonatomic, assign,readwrite) int requestAge;
@property (nonatomic,strong) id requestSex;
@property (nonatomic,strong) id requestOccpCode;
@property (nonatomic, assign,readwrite) int requestOccpClass;
@property (nonatomic, assign,readwrite) int requestCoverTerm;
@property (nonatomic, strong) id requestBasicSA;
@property (nonatomic, strong) id requestBasicHL;
@property (nonatomic, strong) id requestBasicTempHL;
@property (nonatomic, assign,readwrite) int requestMOP;
@property (nonatomic, assign,readwrite) int requestAdvance;

@property (nonatomic,strong) NSString *getSINo;
@property (nonatomic,strong) NSString *getPlanCode;
@property (nonatomic,strong) NSString *getPlanChoose;
@property (nonatomic, assign,readwrite) int getAge;
@property (nonatomic,strong) NSString *getSex;
@property (nonatomic,strong) NSString *getOccpCode;
@property (nonatomic, assign,readwrite) int getOccpClass;
@property (nonatomic, assign,readwrite) int getTerm;
@property (nonatomic, assign,readwrite) double getBasicSA;
@property (nonatomic, assign,readwrite) double getBasicHL;
@property (nonatomic, assign,readwrite) double getBasicTempHL;
@property (nonatomic, assign,readwrite) int getMOP;
@property (nonatomic, assign,readwrite) int getAdvance;
//--

@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (retain, nonatomic) IBOutlet UIButton *btnPType;
@property (retain, nonatomic) IBOutlet UIButton *btnAddRider;
@property (retain, nonatomic) IBOutlet UILabel *termLabel;
@property (retain, nonatomic) IBOutlet UILabel *sumLabel;
@property (retain, nonatomic) IBOutlet UILabel *planLabel;
@property (retain, nonatomic) IBOutlet UILabel *cpaLabel;
@property (retain, nonatomic) IBOutlet UILabel *unitLabel;
@property (retain, nonatomic) IBOutlet UILabel *occpLabel;
@property (retain, nonatomic) IBOutlet UILabel *HLLabel;
@property (retain, nonatomic) IBOutlet UILabel *HLTLabel;
@property (strong, nonatomic) IBOutlet UILabel *tempHLLabel;
@property (strong, nonatomic) IBOutlet UILabel *tempHLTLabel;
@property (retain, nonatomic) IBOutlet UITextField *termField;
@property (retain, nonatomic) IBOutlet UITextField *sumField;
@property (retain, nonatomic) IBOutlet UITextField *cpaField;
@property (retain, nonatomic) IBOutlet UITextField *unitField;
@property (retain, nonatomic) IBOutlet UITextField *occpField;
@property (retain, nonatomic) IBOutlet UITextField *HLField;
@property (retain, nonatomic) IBOutlet UITextField *HLTField;
@property (strong, nonatomic) IBOutlet UITextField *tempHLField;
@property (strong, nonatomic) IBOutlet UITextField *tempHLTField;
@property (retain, nonatomic) IBOutlet UIButton *planBtn;
@property (retain, nonatomic) IBOutlet UIButton *deducBtn;
@property (retain, nonatomic) IBOutlet UILabel *minDisplayLabel;
@property (retain, nonatomic) IBOutlet UILabel *maxDisplayLabel;
@property (strong, nonatomic) IBOutlet UITextField *classField;
@property (strong, nonatomic) IBOutlet UIToolbar *myToolBar;
@property (strong, nonatomic) IBOutlet UILabel *headerTitle;

//get from popover
@property (nonatomic,copy) NSString *pTypeCode;
@property (nonatomic, assign,readwrite) int PTypeSeq;
@property (nonatomic,copy) NSString *pTypeDesc;
@property (nonatomic, assign,readwrite) int pTypeAge;
@property (nonatomic,copy) NSString *pTypeOccp;
@property (nonatomic,copy) NSString *riderCode;
@property (nonatomic,copy) NSString *riderDesc;
//setup form field
@property(nonatomic , retain) NSMutableArray *FLabelCode;
@property(nonatomic , retain) NSMutableArray *FLabelDesc;
@property(nonatomic , retain) NSMutableArray *FRidName;
@property(nonatomic , retain) NSMutableArray *FInputCode;
@property(nonatomic , retain) NSMutableArray *FTbName;
@property(nonatomic , retain) NSMutableArray *FFieldName;
@property(nonatomic , retain) NSMutableArray *FCondition;

@property (nonatomic,strong) NSString *planCondition;
@property (nonatomic,strong) NSString *deducCondition;
@property (nonatomic, assign,readwrite) int expAge;
@property (nonatomic, assign,readwrite) int minSATerm;
@property (nonatomic, assign,readwrite) int maxSATerm;
@property (nonatomic, assign,readwrite) int minTerm;
@property (nonatomic, assign,readwrite) int maxTerm;
@property (nonatomic, assign,readwrite) double maxRiderTerm;
@property (nonatomic, assign,readwrite) double maxRiderSA;
@property (nonatomic, assign,readwrite) double _maxRiderSA;
@property (nonatomic, assign,readwrite) double inputSA;
@property (nonatomic,strong) NSString *planOption;
@property (nonatomic,strong) NSString *deductible;
@property (nonatomic,strong) NSString *inputHL1KSA;
@property (nonatomic,assign,readwrite) int inputHL1KSATerm;
@property (nonatomic,strong) NSString *inputHL100SA;
@property (nonatomic,assign,readwrite) int inputHL100SATerm;
@property (nonatomic,strong) NSString *inputHLPercentage;
@property (nonatomic,assign,readwrite) int inputHLPercentageTerm;
@property(nonatomic , retain) NSMutableArray *atcRidCode;
@property(nonatomic , retain) NSMutableArray *atcPlanChoice;
@property (nonatomic,strong) NSString *existRidCode;
@property (nonatomic,strong) NSString *secondLARidCode;
@property (nonatomic,strong) NSString *payorRidCode;
@property (nonatomic, assign,readwrite) int GYI;
@property (nonatomic, assign,readwrite) int occLoad;
@property(nonatomic , assign,readwrite) int occCPA_PA;
@property (nonatomic, assign,readwrite) int occLoadRider;
@property (nonatomic,strong) NSString *occLoadType;
@property (nonatomic, assign,readwrite) int occClass;
@property(nonatomic , assign,readwrite) int occPA;
@property (nonatomic, assign,readwrite) int occCPA;
@property (nonatomic, assign,readwrite) int storedMaxTerm;
@property (nonatomic, assign,readwrite) int basicRate;
@property (nonatomic, assign,readwrite) int LSDRate;

@property (nonatomic, assign,readwrite) double inputGYI;
@property (nonatomic, assign,readwrite) double inputCSV;
@property (nonatomic, assign,readwrite) double inputIncomeAnn;

//setup tableview listing rider
@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@property (retain, nonatomic) IBOutlet UILabel *titleRidCode;
@property (retain, nonatomic) IBOutlet UILabel *titleSA;
@property (retain, nonatomic) IBOutlet UILabel *titleTerm;
@property (retain, nonatomic) IBOutlet UILabel *titleUnit;
@property (strong, nonatomic) IBOutlet UILabel *titleClass;
@property (strong, nonatomic) IBOutlet UILabel *titleLoad;
@property (strong, nonatomic) IBOutlet UILabel *titleHL1K;
@property (strong, nonatomic) IBOutlet UILabel *titleHL100;
@property (strong, nonatomic) IBOutlet UILabel *titleHLP;
@property (strong, nonatomic) IBOutlet UIButton *editBtn;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleHLPTerm;

@property (retain, nonatomic) NSMutableArray *LRiderCode;
@property (retain, nonatomic) NSMutableArray *LSumAssured;
@property (retain, nonatomic) NSMutableArray *LTerm;
@property (retain, nonatomic) NSMutableArray *LPlanOpt;
@property (retain, nonatomic) NSMutableArray *LUnits;
@property(nonatomic , retain) NSMutableArray *LDeduct;
@property(nonatomic , retain) NSMutableArray *LOccpCode;
@property(nonatomic , retain) NSMutableArray *LRidHL1K;
@property(nonatomic , retain) NSMutableArray *LRidHLTerm;
@property(nonatomic , retain) NSMutableArray *LRidHL100;
@property(nonatomic , retain) NSMutableArray *LRidHL100Term;
@property(nonatomic , retain) NSMutableArray *LRidHLP;
@property(nonatomic , retain) NSMutableArray *LRidHLPTerm;
@property(nonatomic , retain) NSMutableArray *LSmoker;
@property(nonatomic , retain) NSMutableArray *LSex;
@property(nonatomic , retain) NSMutableArray *LAge;
@property(nonatomic , retain) NSMutableArray *LTempRidHL1K;
@property(nonatomic , retain) NSMutableArray *LTempRidHLTerm;

@property (retain, nonatomic) NSMutableArray *LTypeRiderCode;
@property (retain, nonatomic) NSMutableArray *LTypeSumAssured;
@property (retain, nonatomic) NSMutableArray *LTypeTerm;
@property (retain, nonatomic) NSMutableArray *LTypePlanOpt;
@property (retain, nonatomic) NSMutableArray *LTypeUnits;
@property(nonatomic , retain) NSMutableArray *LTypeDeduct;
@property(nonatomic , retain) NSMutableArray *LTypeOccpCode;
@property(nonatomic , retain) NSMutableArray *LTypeRidHL1K;
@property(nonatomic , retain) NSMutableArray *LTypeRidHLTerm;
@property(nonatomic , retain) NSMutableArray *LTypeRidHL100;
@property(nonatomic , retain) NSMutableArray *LTypeRidHL100Term;
@property(nonatomic , retain) NSMutableArray *LTypeRidHLP;
@property(nonatomic , retain) NSMutableArray *LTypeRidHLPTerm;
@property(nonatomic , retain) NSMutableArray *LTypeSmoker;
@property(nonatomic , retain) NSMutableArray *LTypeSex;
@property(nonatomic , retain) NSMutableArray *LTypeAge;
@property(nonatomic , retain) NSMutableArray *LTypeTempRidHL1K;
@property(nonatomic , retain) NSMutableArray *LTypeTempRidHLTerm;

@property (nonatomic, assign,readwrite) int age;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic, assign,readwrite) double riderRate;
@property (nonatomic, assign,readwrite) int CombNo;
@property (nonatomic, assign,readwrite) int RBBenefit;
@property (nonatomic, assign,readwrite) int RBLimit;
@property (nonatomic, assign,readwrite) int RBGroup;
@property (nonatomic, assign,readwrite) int AllCombNo;
@property (nonatomic,strong) NSString *OccpCat;
@property (nonatomic,strong) NSString *pentaSQL;
@property (nonatomic,strong) NSString *medPentaSQL;
@property (nonatomic,strong) NSString *plnOptC;
@property (nonatomic,strong) NSString *planOptHMM;
@property (nonatomic,strong) NSString *deducHMM;
@property (nonatomic,strong) NSString *planHSPII;
@property (nonatomic,strong) NSString *planMGII;
@property (nonatomic,strong) NSString *planMGIV;
@property (nonatomic,strong) NSString *planCodeRider;
@property (nonatomic,strong) NSString *medPlanCodeRider;
@property (nonatomic,strong) NSString *medRiderCode;
@property (nonatomic,strong) NSString *medPlanOpt;
@property (nonatomic,strong) NSMutableArray *annualRiderPrem;
@property (nonatomic,strong) NSMutableArray *quarterRiderPrem;
@property (nonatomic,strong) NSMutableArray *halfRiderPrem;
@property (nonatomic,strong) NSMutableArray *monthRiderPrem;
@property (nonatomic, assign,readwrite) double annualRiderSum;
@property (nonatomic, assign,readwrite) double halfRiderSum;
@property (nonatomic, assign,readwrite) double quarterRiderSum;
@property (nonatomic, assign,readwrite) double monthRiderSum;
@property (nonatomic,strong) NSMutableArray *arrCombNo;
@property (nonatomic,strong) NSMutableArray *arrRBBenefit;

@property (nonatomic,strong) NSMutableArray *annualMedRiderPrem;
@property (nonatomic,strong) NSMutableArray *quarterMedRiderPrem;
@property (nonatomic,strong) NSMutableArray *halfMedRiderPrem;
@property (nonatomic,strong) NSMutableArray *monthMedRiderPrem;
@property (nonatomic, assign,readwrite) double annualMedRiderSum;
@property (nonatomic, assign,readwrite) double halfMedRiderSum;
@property (nonatomic, assign,readwrite) double quarterMedRiderSum;
@property (nonatomic, assign,readwrite) double monthMedRiderSum;

@property (nonatomic, assign,readwrite) double basicPremAnn;
@property (nonatomic, assign,readwrite) double basicPremHalf;
@property (nonatomic, assign,readwrite) double basicPremQuar;
@property (nonatomic, assign,readwrite) double basicPremMonth;
@property (nonatomic, assign,readwrite) double riderPrem;
@property (nonatomic, assign,readwrite) double medRiderPrem;
@property (nonatomic, assign,readwrite) double incomeRiderPrem;
@property (nonatomic, assign,readwrite) double basicCSVRate;
@property (nonatomic, assign,readwrite) double basicGYIRate;
@property (nonatomic, assign,readwrite) double riderCSVRate;

@property (nonatomic,strong) NSMutableArray *waiverRiderAnn;
@property (nonatomic,strong) NSMutableArray *waiverRiderQuar;
@property (nonatomic,strong) NSMutableArray *waiverRiderHalf;
@property (nonatomic,strong) NSMutableArray *waiverRiderMonth;
@property (nonatomic,strong) NSMutableArray *waiverRiderAnn2;
@property (nonatomic,strong) NSMutableArray *waiverRiderQuar2;
@property (nonatomic,strong) NSMutableArray *waiverRiderHalf2;
@property (nonatomic,strong) NSMutableArray *waiverRiderMonth2;
@property (nonatomic,strong) NSMutableArray *incomeRiderAnn;
@property (nonatomic,strong) NSMutableArray *incomeRiderQuar;
@property (nonatomic,strong) NSMutableArray *incomeRiderHalf;
@property (nonatomic,strong) NSMutableArray *incomeRiderMonth;
@property (nonatomic,strong) NSMutableArray *incomeRiderGYI;
@property (nonatomic,strong) NSMutableArray *incomeRiderCSV;
@property (nonatomic,strong) NSMutableArray *incomeRiderSA;
@property (nonatomic,strong) NSMutableArray *incomeRiderCode;
@property (nonatomic,strong) NSMutableArray *incomeRiderTerm;

- (IBAction)btnPTypePressed:(id)sender;
- (IBAction)btnAddRiderPressed:(id)sender;
- (IBAction)planBtnPressed:(id)sender;
- (IBAction)deducBtnPressed:(id)sender;
- (IBAction)doSaveRider:(id)sender;
- (IBAction)editPressed:(id)sender;
- (IBAction)deletePressed:(id)sender;
- (IBAction)btnSaveRiderPressed:(id)sender;

-(void)keyboardDidHide:(NSNotificationCenter *)notification;
-(void)loadRiderData;
-(void)clearField;

@end
