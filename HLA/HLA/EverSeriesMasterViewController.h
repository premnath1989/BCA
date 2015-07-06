//
//  EverSeriesMasterViewController.h
//  iMobile Planner
//
//  Created by infoconnect on 6/10/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "EverLAViewController.h"
#import "BasicAccountViewController.h"
#import "EverRiderViewController.h"
#import "EverSecondLAViewController.h"
#import "EverPayorViewController.h"
#import "EverHLoadingViewController.h"
#import "FundAllocationViewController.h"
#import "EverSpecialViewController.h"
#import "EverFundMaturityViewController.h"
#import "FSVerticalTabBarController.h"
#import "NDHTMLtoPDF.h"
#import "FMDatabase.h"
#import "CustomView.h"
#import "AppDelegate.h"

typedef enum {
    
    EVERSIMENU_LIFEASSURED = 0,
    EVERSIMENU_SECOND_LIFE_ASSURED, //1
    EVERSIMENU_PAYOR, //2
    EVERSIMENU_BASIC_PLAN, //3
    EVERSIMENU_FUND_ALLOCATION, //4
	EVERSIMENU_RIDER, //5
	EVERSIMENU_HEALTH_LOADING, //6
    EVERSIMENU_SPECIAL_OPTION, //7
    EVERSIMENU_FUND_MATURITY_OPTIONS, //8
	EVERSIMENU_QUOTATION, //9
    //SIMENU_PROPOSAL,
    EVERSIMENU_EXP_QUOTATION, //10
    EVERSIMENU_PRODUCT_DISCLOSURE_SHEET, //11
    EVERSIMENU_EXP_PDS, //12
    //SIMENU_PDS_ENG,
    //SIMENU_PDS_BM,
    EVERSIMENU_SAVE_AS
	
	
    
} EVERSIMENU;

@interface EverSeriesMasterViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, EverLAViewControllerDelegate,
											EverBasicPlanViewControllerDelegate, EverRiderViewControllerDelegate,
											EverSecondLAViewControllerDelegate, EverPayorViewControllerDelegate,
											EverHLViewControllerDelegate, EverFundDelegate, EverSpecial, EverFundMaturity,
											FSTabBarControllerDelegate, NDHTMLtoPDFDelegate,EverCustom, UIAlertViewDelegate>{
	NSString *databasePath;
	NSString *UL_RatesDatabasePath;
    sqlite3 *contactDB;
	NSIndexPath *selectedPath;
	NSIndexPath *previousPath;
	UIActivityIndicatorView *spinner_SI;
    BOOL blocked;
    BOOL saved;
    BOOL payorSaved;
    BOOL added;
	BOOL PlanEmpty;
	NSString *PDSorSI;
	EverLAViewController *_EverLAController;
	BasicAccountViewController *_BasicAccount;
	EverRiderViewController*_EverRider;
	EverSecondLAViewController*_EverSecondLA;
	EverPayorViewController*_EverPayor;
	EverHLoadingViewController*_EverHLoad;
	FundAllocationViewController*_EverFund;
	EverSpecialViewController*_EverSpecial;
	EverFundMaturityViewController*_EverFundMaturity;
	FSVerticalTabBarController *_FS;
    CustomView *_CV;
    NSMutableArray *arrTempLA;
    NSMutableArray *arrTempLATwo;
	NSMutableDictionary * dictBP;
    NSMutableArray *arrCustomerCode;
    NSMutableArray *arrRiderCode;
    NSMutableArray *arrTempRider;
												
												int SILastNo;
												int CustLastNo;
												NSString* saveAsSINo;
												NSString* saveAsCustCode;
												NSString* SIDateSIMenu;
												NSString* CustDate;
												NSString *eProposalStatus;
												BOOL LA_EDD;
												AppDelegate *appDel;

}

@property (nonatomic, strong) NDHTMLtoPDF *PDFCreator;
@property (nonatomic, retain) EverLAViewController *EverLAController;
@property (nonatomic, retain) BasicAccountViewController *BasicAccount;
@property (nonatomic, retain) EverRiderViewController *EverRider;
@property (nonatomic, retain) EverSecondLAViewController *EverSecondLA;
@property (nonatomic, retain) EverPayorViewController *EverPayor;
@property (nonatomic, retain) EverHLoadingViewController *EverHLoad;
@property (nonatomic, retain) FundAllocationViewController *EverFund;
@property (nonatomic, retain) EverSpecialViewController *EverSpecial;
@property (nonatomic, retain) EverFundMaturityViewController *EverFundMaturity;
@property (nonatomic,retain) FSVerticalTabBarController *FS;
@property (nonatomic,retain) CustomView *CV;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIView *RightView;

@property (retain, nonatomic) NSMutableArray *ListOfSubMenu;
@property (retain, nonatomic) NSMutableArray *SelectedRow;
@property (nonatomic,strong) id requestSINo;
@property (nonatomic,strong) id requestSINo2;

@property (nonatomic, strong) NSMutableDictionary *riderCode;

//--from delegate
@property (nonatomic ,assign ,readwrite) int getAge;
@property (nonatomic, retain) NSString *getLADOB;
@property (nonatomic ,assign ,readwrite) int getOccpClass;
@property (nonatomic, retain) NSString *getOccpCPA;
@property (nonatomic, retain) NSString *getSex;
@property (nonatomic, retain) NSString *getSmoker;
@property (nonatomic, retain) NSString *getOccpCode;
@property (nonatomic, retain) NSString *getCommDate;
@property (nonatomic, retain) NSString *getBumpMode;
@property (nonatomic ,assign ,readwrite) int getIdProf;
@property (nonatomic ,assign ,readwrite) int getIdPay;
@property (nonatomic ,assign ,readwrite) int getLAIndexNo;

@property (nonatomic ,assign ,readwrite) int getPayorIndexNo;
@property (nonatomic, retain) NSString *getPaySmoker;
@property (nonatomic, retain) NSString *getPaySex;
@property (nonatomic, retain) NSString *getPayDOB;
@property (nonatomic ,assign ,readwrite) int getPayAge;
@property (nonatomic, retain) NSString *getPayOccp;

@property (nonatomic ,assign ,readwrite) int get2ndLAIndexNo;
@property (nonatomic, retain) NSString *get2ndLASmoker;
@property (nonatomic, retain) NSString *get2ndLASex;
@property (nonatomic, retain) NSString *get2ndLADOB;
@property (nonatomic ,assign ,readwrite) int get2ndLAAge;
@property (nonatomic, retain) NSString *get2ndLAOccp;

@property (nonatomic, retain) NSString *getSINo;
@property (nonatomic ,assign ,readwrite) int getTerm;
@property (nonatomic, retain) NSString *getbasicSA;
@property (nonatomic, retain) NSString *getbasicHL;
@property (nonatomic, retain) NSString *getbasicHLPct;
@property (nonatomic, retain) NSString *getPlanCode;
@property (nonatomic, retain) NSString *getBasicPlan;
@property (nonatomic, retain) NSString *getOccLoading;


//----

@property (nonatomic, copy) NSString *payorSINo;
@property (nonatomic, copy) NSString *payorCustCode;
@property (nonatomic, assign,readwrite) int clientID2;
@property (nonatomic, copy) NSString *CustCode2;
@property(nonatomic , retain) NSString *NameLA;
@property(nonatomic , retain) NSString *Name2ndLA;
@property(nonatomic , retain) NSString *NamePayor;
@property (nonatomic,strong) id EAPPorSI;



-(void)Reset;
-(void)copySIToDoc;

-(BOOL)performSaveSI:(BOOL)saveChanges;//to save or to revert SI upon pressing fs vertical bar
-(void)storeSIOriginal;//to store for revert

@end
