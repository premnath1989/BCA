//
//  ELP1stLifeAssuredVC.h
//  iMobile Planner
//
//  Created by Juliana on 11/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIDate.h"
#import "MainAddPolicyVC.h"
#import "MainExistingPolicyListing.h"

#import "FMDatabase.h"
#import "FMResultSet.h"

@interface ELP1stLifeAssuredVC : UITableViewController<SIDateDelegate, MainAddPolicyVCDelegate, MainExistingPolicyListingDelegate> {
	BOOL isWithdrawCashDiv;
	BOOL isKeepCashDiv;
	BOOL isWithdrawTradGuaranteed;
	BOOL isKeepTradGuaranteed;
	BOOL isWithdrawEverGuaranteed;
	BOOL isReinvestEverGuaranteed;
	BOOL isPolicyBdt;
	BOOL isPolicyBdtPO;
	BOOL isPolicyBdtLA2;
    BOOL isChangeTick;
	NSMutableArray *items;
	int number;
	
	
	FMResultSet *results;
	NSString *stringID;
	NSString *whichPType;
}

- (IBAction)actionForSpecialReq:(id)sender;
- (IBAction)actionForDateSpecialReq:(id)sender;
- (IBAction)actionForNoticeA:(id)sender;
- (IBAction)actionForAddPolicy:(id)sender;
- (IBAction)actionForViewPolicy:(id)sender;
- (IBAction)actionForAddViewPolicy:(id)sender;
- (IBAction)segmentChange:(id)sender;
- (IBAction)segmentChange2:(id)sender;

@property (nonatomic, retain) SIDate *SIDate;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;

@property (strong, nonatomic) IBOutlet UILabel *forTradiotionalPlans;

@property (strong, nonatomic) IBOutlet UILabel *CashDividenQuest3;
@property (strong, nonatomic) IBOutlet UILabel *CashDividenQuest3Withdraw;
@property (strong, nonatomic) IBOutlet UILabel *CashDividenQuest3keep;

@property (strong, nonatomic) IBOutlet UILabel *GuarantedCashPaymentQuest3;
@property (strong, nonatomic) IBOutlet UILabel *GuarantedCashPaymentQuest3withdraw;
@property (strong, nonatomic) IBOutlet UILabel *GuarantedCashPaymentQuest3keep;

@property (strong, nonatomic) IBOutlet UIButton *prefferedLifeImage;
- (IBAction)preffredLifeButton2:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnTCDW;
@property (strong, nonatomic) IBOutlet UIButton *btnTCDK;
@property (strong, nonatomic) IBOutlet UIButton *btnTGW;
@property (strong, nonatomic) IBOutlet UIButton *btnTGK;
@property (strong, nonatomic) IBOutlet UIButton *btnEGW;
@property (strong, nonatomic) IBOutlet UIButton *btnEGI;
@property (strong, nonatomic) IBOutlet UIButton *btnPolicyBdt;
@property (strong, nonatomic) IBOutlet UIButton *btnDateSpecialReq;
@property (strong, nonatomic) IBOutlet UITextField *withdrawGuaranteedTF;
@property (strong, nonatomic) IBOutlet UILabel *pctWithdrawGuaranteed;
@property (strong, nonatomic) IBOutlet UITextField *keepGuaranteedTF;
@property (strong, nonatomic) IBOutlet UILabel *pctKeepGuaranteed;
@property (strong, nonatomic) IBOutlet UILabel *dateSpecialReqLbl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *noticeASC;
@property (strong, nonatomic) IBOutlet UISegmentedControl *noticeBSC;
@property (strong, nonatomic) IBOutlet UISegmentedControl *noticeCSC;
@property (strong, nonatomic) IBOutlet UISegmentedControl *noticeDSC;
@property (strong, nonatomic) IBOutlet UILabel *withdrawPctLbl;
@property (strong, nonatomic) IBOutlet UILabel *keepPctLbl;

@property (strong, nonatomic) IBOutlet UILabel *forTraditionalplansonlyLbl;
@property (strong, nonatomic) IBOutlet UILabel *forEverSeriesonlyLbl;

@property (strong, nonatomic) IBOutlet UILabel *cashdivforTraditionalplansonlyLbl;
@property (strong, nonatomic) IBOutlet UILabel *guarentedforTraditionalplansonlyLbl;
@property (strong, nonatomic) IBOutlet UILabel *withdrawwheneverdue1forTraditionalplansonlyLbl;
@property (strong, nonatomic) IBOutlet UILabel *withdrawwheneverdue2forTraditionalplansonlyLbl;
@property (strong, nonatomic) IBOutlet UILabel *keepwithcompany1forTraditionalplansonlyLbl;
@property (strong, nonatomic) IBOutlet UILabel *keepwithcompany2forTraditionalplansonlyLbl;



@property (strong, nonatomic) IBOutlet UILabel *guarentedforEverSeriesonlyLbl;
@property (strong, nonatomic) IBOutlet UILabel *withdrawwheneverdueforEverSeriesonlyLbl;
@property (strong, nonatomic) IBOutlet UILabel *reInvestforEverSeriesonlyLbl;




@property (strong, nonatomic) IBOutlet UISegmentedControl *Q1SC;

@property (strong, nonatomic) IBOutlet UISegmentedControl *Q2SC;

@property (assign, nonatomic) BOOL pb;
@property (strong, nonatomic) IBOutlet UIButton *addPolicyBtn;
@property (strong, nonatomic) IBOutlet UIButton *viewPolicyBtn;

@end
