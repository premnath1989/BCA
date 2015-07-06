//
//  ExistingLifePolicies.h
//  iMobile Planner
//
//  Created by Erza on 7/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIDate.h"
#import "MainAddPolicyVC.h"
#import "MainAddPolicyPOVC.h"
#import "MainAddPolicyLA2VC.h"
#import "MainExistingPolicyListing.h"
#import "MainExistingPolicyPOListing.h"
#import "MainExistingPolicyLA2Listing.h"
//#import "HealthQuestPersonType.h" HealthQuestPersonTypeDelegate
#import "ExistingPoliciesPersonType.h"

#import "FMDatabase.h"
#import "FMResultSet.h"

//@class ExistingLifePolicies;

//@protocol ExistingLifePoliciesDelegate <NSObject>
//
//-(void)setCount:(int)countPolicy;
//
//@end

@interface ExistingLifePolicies : UITableViewController<SIDateDelegate, UITableViewDataSource, UITableViewDelegate, EPPersonTypeDelegate, MainAddPolicyVCDelegate, MainExistingPolicyListingDelegate, MainAddPolicyPOVCDelegate, MainExistingPolicyPOListingDelegate, MainAddPolicyLA2VCDelegate, MainExistingPolicyLA2ListingDelegate> {
	BOOL isWithdrawCashDiv;
	BOOL isKeepCashDiv;
	BOOL isWithdrawTradGuaranteed;
	BOOL isKeepTradGuaranteed;
	BOOL isWithdrawEverGuaranteed;
	BOOL isReinvestEverGuaranteed;
	BOOL isPolicyBdt;
	BOOL isPolicyBdtPO;
	BOOL isPolicyBdtLA2;
	NSMutableArray *items;
	int number;
	
	
	FMResultSet *results;
	NSString *stringID;
	NSString *whichPType;
}

- (IBAction)actionForTradCashDiv:(id)sender;
- (IBAction)actionForTradGuaranteed:(id)sender;
- (IBAction)actionForEverGuaranteed:(id)sender;
- (IBAction)actionForSpecialReq:(id)sender;
- (IBAction)actionForSpecialReqPO:(id)sender;
- (IBAction)actionForSpecialReqLA2:(id)sender;
- (IBAction)actionForDateSpecialReq:(id)sender;
- (IBAction)actionForDateSpecialReqPO:(id)sender;
- (IBAction)actionForDateSpecialReqLA2:(id)sender;
- (IBAction)actionForNoticeA:(id)sender;
- (IBAction)actionForNoticeAPO:(id)sender;
- (IBAction)actionForNoticeALA2:(id)sender;
//@property (nonatomic, weak) id<ExistingLifePoliciesDelegate> delegate;
@property (nonatomic, retain) ExistingPoliciesPersonType *PersonTypePicker;
@property (nonatomic, retain) UIPopoverController *PersonTypePopover;
@property (nonatomic, retain) SIDate *SIDate;
@property (nonatomic, retain) SIDate *SIDatePO;
@property (nonatomic, retain) SIDate *SIDateLA2;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;
@property (nonatomic, retain) UIPopoverController *SIDatePOPopover;
@property (nonatomic, retain) UIPopoverController *SIDateLA2Popover;

@property (strong, nonatomic) IBOutlet UIButton *btnTCDW;
@property (strong, nonatomic) IBOutlet UIButton *btnTCDK;
@property (strong, nonatomic) IBOutlet UIButton *btnTGW;
@property (strong, nonatomic) IBOutlet UIButton *btnTGK;
@property (strong, nonatomic) IBOutlet UIButton *btnEGW;
@property (strong, nonatomic) IBOutlet UIButton *btnEGI;
@property (strong, nonatomic) IBOutlet UIButton *btnPolicyBdt;
@property (strong, nonatomic) IBOutlet UIButton *btnPolicyBdtPO;
@property (strong, nonatomic) IBOutlet UIButton *btnPolicyBdtLA2;
@property (strong, nonatomic) IBOutlet UIButton *btnDateSpecialReq;
@property (strong, nonatomic) IBOutlet UIButton *btnDateSpecialReqPO;
@property (strong, nonatomic) IBOutlet UIButton *btnDateSpecialReqLA2;

@property (strong, nonatomic) IBOutlet UITextField *withdrawGuaranteedTF;
@property (strong, nonatomic) IBOutlet UILabel *pctWithdrawGuaranteed;
@property (strong, nonatomic) IBOutlet UITextField *keepGuaranteedTF;
@property (strong, nonatomic) IBOutlet UILabel *pctKeepGuaranteed;
@property (strong, nonatomic) IBOutlet UILabel *dateSpecialReqLbl;
@property (strong, nonatomic) IBOutlet UILabel *dateSpecialReqPOLbl;
@property (strong, nonatomic) IBOutlet UILabel *dateSpecialReqLA2Lbl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *noticeASC;
@property (strong, nonatomic) IBOutlet UISegmentedControl *noticeAPOSC;
@property (strong, nonatomic) IBOutlet UISegmentedControl *noticeALA2SC;
@property (strong, nonatomic) IBOutlet UISegmentedControl *noticeBSC;
@property (strong, nonatomic) IBOutlet UISegmentedControl *noticeBPOSC;
@property (strong, nonatomic) IBOutlet UISegmentedControl *noticeBLA2SC;
@property (strong, nonatomic) IBOutlet UISegmentedControl *noticeCSC;
@property (strong, nonatomic) IBOutlet UISegmentedControl *noticeCPOSC;
@property (strong, nonatomic) IBOutlet UISegmentedControl *noticeCLA2SC;
@property (strong, nonatomic) IBOutlet UISegmentedControl *noticeDSC;
@property (strong, nonatomic) IBOutlet UISegmentedControl *noticeDPOSC;
@property (strong, nonatomic) IBOutlet UISegmentedControl *noticeDLA2SC;

@property (strong, nonatomic) IBOutlet UILabel *withdrawPctLbl;
@property (strong, nonatomic) IBOutlet UILabel *keepPctLbl;
@property (strong, nonatomic) IBOutlet UILabel *personTypeLbl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *Q1SC;
@property (strong, nonatomic) IBOutlet UISegmentedControl *Q1POSC;
@property (strong, nonatomic) IBOutlet UISegmentedControl *Q1LA2SC;
@property (assign, nonatomic) BOOL pb;
@property (assign, nonatomic) BOOL pbPO;
@property (assign, nonatomic) BOOL pbLA2;
@property (strong, nonatomic) IBOutlet UITableView *existingPolicyTbV;
@property (strong, nonatomic) IBOutlet UIButton *addPolicyBtn;
@property (strong, nonatomic) IBOutlet UIButton *addPolicyPOBtn;
@property (strong, nonatomic) IBOutlet UIButton *addPolicyLA2Btn;
@property (strong, nonatomic) IBOutlet UIButton *viewPolicyBtn;
@property (strong, nonatomic) IBOutlet UIButton *viewPolicyPOBtn;
@property (strong, nonatomic) IBOutlet UIButton *viewPolicyLA2Btn;


//@property (assign, nonatomic) int num;
- (IBAction)actionForAddPolicy:(id)sender;
- (IBAction)actionForAddPolicyPO:(id)sender;
- (IBAction)actionForAddPolicyLA2:(id)sender;
- (IBAction)actionForViewPolicy:(id)sender;
- (IBAction)actionForViewPolicyPO:(id)sender;
- (IBAction)actionForViewPolicyLA2:(id)sender;
- (IBAction)actionForAddViewPolicy:(id)sender;
- (IBAction)actionForAddViewPolicyPO:(id)sender;
- (IBAction)actionForAddViewPolicyLA2:(id)sender;
- (IBAction)actionForPersonType:(id)sender;


@property (strong, nonatomic) IBOutlet UITableViewCell *la1cell;
@property (strong, nonatomic) IBOutlet UITableViewCell *la2cell;
@property (strong, nonatomic) IBOutlet UITableViewCell *la3cell;
@property (strong, nonatomic) IBOutlet UITableViewCell *la4cell;

@property (strong, nonatomic) IBOutlet UITableViewCell *po1cell;
@property (strong, nonatomic) IBOutlet UITableViewCell *po2cell;
@property (strong, nonatomic) IBOutlet UITableViewCell *po3cell;
@property (strong, nonatomic) IBOutlet UITableViewCell *po4cell;

- (IBAction)actionForSelectedPT:(id)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *selectedPTSC;
@end
