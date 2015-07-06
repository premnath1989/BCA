//
//  BasicAccountViewController.h
//  iMobile Planner
//
//  Created by infoconnect on 6/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlanList.h"
#import <sqlite3.h>

@class EverBasicPlanViewController;
@protocol EverBasicPlanViewControllerDelegate
-(void) BasicSI:(NSString *)aaSINo andAge:(int)aaAge andOccpCode:(NSString *)aaOccpCode andCovered:(int)aaCovered
		andBasicSA:(NSString *)aaBasicSA andBasicHL:(NSString *)aaBasicHL andBasicHLTerm:(int)aaBasicHLTerm
		andBasicHLPct:(NSString *)aaBasicHLPct andBasicHLPctTerm:(int)aaBasicHLPctTerm andPlanCode:(NSString *)aaPlanCode
		andBumpMode:(NSString *)aaBumpMode;

-(void)RiderAdded;
-(void) BasicSARevised:(NSString *)aabasicSA;
-(void)BasicGlobalSave;
@end


@interface BasicAccountViewController : UIViewController<UITextFieldDelegate,PlanListDelegate, UIScrollViewDelegate>{
	NSString *databasePath;
	NSString *UL_databasePath;
    sqlite3 *contactDB;
    UITextField *activeField;
    UIPopoverController *_planPopover;
	id temp;
    PlanList *_planList;
	    BOOL useExist;
	id <EverBasicPlanViewControllerDelegate> _delegate;
}

@property (nonatomic, retain) UIPopoverController *planPopover;
@property (nonatomic, retain) PlanList *planList;
@property (nonatomic,strong) id <EverBasicPlanViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIButton *outletBasic;
- (IBAction)ACtionBasic:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtPolicyTerm;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segPremium;
@property (weak, nonatomic) IBOutlet UITextField *txtBasicPremium;
@property (weak, nonatomic) IBOutlet UITextField *txtBasicSA;
@property (weak, nonatomic) IBOutlet UITextField *txtGrayRTUP;
@property (weak, nonatomic) IBOutlet UITextField *txtRTUP;
@property (weak, nonatomic) IBOutlet UITextField *txtCommFrom;
@property (weak, nonatomic) IBOutlet UITextField *txtFor;
@property (weak, nonatomic) IBOutlet UITextField *txtBUMP;
@property (weak, nonatomic) IBOutlet UITextField *txtTotalBAPremium;
@property (weak, nonatomic) IBOutlet UITextField *txtPremiumPayable;
@property (weak, nonatomic) IBOutlet UILabel *Label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *labelComm;
@property (weak, nonatomic) IBOutlet UILabel *labelFor;
- (IBAction)ActionPremium:(id)sender;


//--request from previous
@property (nonatomic,strong) id requestSexLA;
@property (nonatomic,strong) id requestSmokerLA;
@property (nonatomic, assign,readwrite) int requestAge;
@property (nonatomic,strong) id requestOccpCode;
@property (nonatomic, assign,readwrite) int requestOccpClass;
@property (nonatomic,strong) id requestSINo;
@property (nonatomic, assign,readwrite) int requestIDProf;
@property (nonatomic,strong) id requestPlanCommDate;
@property (nonatomic,strong) id requestDOB;
@property (nonatomic,strong) id requestOccLoading;

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

@property (nonatomic, assign,readwrite) double minSA;
@property (nonatomic, assign,readwrite) double minPremium;

- (IBAction)ActionDone:(id)sender;

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
@property (nonatomic,strong) NSString *planChoose;

@property(nonatomic , retain) NSString *NamePP;
@property(nonatomic , retain) NSString *DOBPP;
@property(nonatomic , retain) NSString *GenderPP;
@property(nonatomic , retain) NSString *OccpCodePP;

//to display
@property (nonatomic,strong) NSString *getSINo;
@property (nonatomic,assign,readwrite) int getPolicyTerm;
@property (nonatomic,assign,readwrite) double getSumAssured;
@property (nonatomic,copy) NSString *getHL;
@property (nonatomic,copy) NSString *getHLPct;
@property (nonatomic,assign,readwrite) int getHLPctTerm;
@property (nonatomic,assign,readwrite) int getHLTerm;
@property (nonatomic,copy) NSString *getBumpMode;
@property (nonatomic,assign,readwrite) double getBasicPrem;
@property (nonatomic,strong) NSString *getPlanCode;
@property (nonatomic,strong) NSString *getCommFrom;
@property (nonatomic,strong) NSString *getFor;
@property (nonatomic,strong) NSString *getRTUP;
@property (nonatomic,assign, readwrite) double getGrayRTUP;
@property (nonatomic,strong) NSString *getSexLA;
@property (nonatomic,strong) NSString *getSmokerLA;
@property (nonatomic,strong) NSString *getPlanCommDate;
@property (nonatomic,strong) NSString *getDOB;
@property (nonatomic,strong) NSString *getOccLoading;

-(BOOL)NewDone;
@end
