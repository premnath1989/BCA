//
//  FundAllocationViewController.h
//  iMobile Planner
//
//  Created by infoconnect on 6/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "AppDelegate.h"

@class EverFundAllocation;
@protocol EverFundDelegate
-(void)FundAllocationGlobalSave;
@end


@interface FundAllocationViewController : UIViewController<UITextFieldDelegate, UIScrollViewDelegate, UIAlertViewDelegate>{
	NSString *databasePath;
    sqlite3 *contactDB;
	UITextField *activeField;
	id <EverFundDelegate> _delegate;
	
	AppDelegate *appDel;
	BOOL Editable;
}

@property (nonatomic,strong) id <EverFundDelegate> delegate;

@property (nonatomic,strong) id EAPPorSI;

//--request
@property (nonatomic, copy) NSString *SINo;
@property (nonatomic, assign,readwrite) int getAge;
@property (nonatomic,strong) id requesteProposalStatus;
//--
@property (nonatomic,copy) NSString *get2023;
@property (nonatomic,copy) NSString *get2025;
@property (nonatomic,copy) NSString *get2028;
@property (nonatomic,copy) NSString *get2030;
@property (nonatomic,copy) NSString *get2035;
@property (nonatomic,copy) NSString *getCashFund;
@property (nonatomic,copy) NSString *getSecureFund;
@property (nonatomic,copy) NSString *getDanaFund;

@property (nonatomic,copy) NSString *getExpiredCashFund;
@property (nonatomic,copy) NSString *getExpiredSecureFund;
@property (nonatomic,copy) NSString *getExpiredDanaFund;
@property (nonatomic,copy) NSString *getSustainAge;


@property (weak, nonatomic) IBOutlet UITextField *txt2023;  
@property (weak, nonatomic) IBOutlet UITextField *txt2025;
@property (weak, nonatomic) IBOutlet UITextField *txt2028;
@property (weak, nonatomic) IBOutlet UITextField *txtDanaFund;
@property (weak, nonatomic) IBOutlet UITextField *txtExpireDanaFund;
@property (weak, nonatomic) IBOutlet UITextField *txt2030;
@property (weak, nonatomic) IBOutlet UITextField *txt2035;
@property (weak, nonatomic) IBOutlet UITextField *txtSecureFund;
@property (weak, nonatomic) IBOutlet UITextField *txtCashFund;
@property (weak, nonatomic) IBOutlet UITextField *txtExpireSecureFund;
@property (weak, nonatomic) IBOutlet UITextField *txtExpireCashFund;
@property (weak, nonatomic) IBOutlet UIButton *outletReset;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletSustain;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletAge;
@property (weak, nonatomic) IBOutlet UITextField *txtAge;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletDone;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletEAPP;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletSpace;
@property (weak, nonatomic) IBOutlet UITextField *txtVentureFlexi;
@property (weak, nonatomic) IBOutlet UITextField *txtExpireVentureFlexi;


@property (weak, nonatomic) IBOutlet UITextField *txtVentureGrowth;//
@property (weak, nonatomic) IBOutlet UITextField *txtVentureBlueChip;
@property (weak, nonatomic) IBOutlet UITextField *txtVentureDana;
@property (weak, nonatomic) IBOutlet UITextField *txtVentureManaged;
@property (weak, nonatomic) IBOutlet UITextField *txtVentureIncome;
@property (weak, nonatomic) IBOutlet UITextField *txtVenture6666;
@property (weak, nonatomic) IBOutlet UITextField *txtVenture7777;
@property (weak, nonatomic) IBOutlet UITextField *txtVenture8888;
@property (weak, nonatomic) IBOutlet UITextField *txtVenture9999;
@property (weak, nonatomic) IBOutlet UITextField *txtExpireVentureGrowth;
@property (weak, nonatomic) IBOutlet UITextField *txtExpireVentureBlueChip;
@property (weak, nonatomic) IBOutlet UITextField *txtExpireVentureDana;
@property (weak, nonatomic) IBOutlet UITextField *txtExpireVentureManaged;
@property (weak, nonatomic) IBOutlet UITextField *txtExpireVentureIncome;
@property (weak, nonatomic) IBOutlet UITextField *txtExpireVenture6666;
@property (weak, nonatomic) IBOutlet UITextField *txtExpireVenture7777;
@property (weak, nonatomic) IBOutlet UITextField *txtExpireVenture8888;
@property (weak, nonatomic) IBOutlet UITextField *txtExpireVenture9999;



- (IBAction)ActionEAPP:(id)sender;

- (IBAction)ActionDone:(id)sender;
- (IBAction)ActionReset:(id)sender;
- (IBAction)ActionSustain:(id)sender;
- (IBAction)ActionAge:(id)sender;
-(BOOL)NewDone;

@end
