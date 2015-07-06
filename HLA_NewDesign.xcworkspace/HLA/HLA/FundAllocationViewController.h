//
//  FundAllocationViewController.h
//  iMobile Planner
//
//  Created by infoconnect on 6/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class EverFundAllocation;
@protocol EverFundDelegate
-(void)FundAllocationGlobalSave;
@end


@interface FundAllocationViewController : UIViewController<UITextFieldDelegate, UIScrollViewDelegate, UIAlertViewDelegate>{
	NSString *databasePath;
    sqlite3 *contactDB;
	UITextField *activeField;
	id <EverFundDelegate> _delegate;
}

@property (nonatomic,strong) id <EverFundDelegate> delegate;

//--request
@property (nonatomic, copy) NSString *SINo;
@property (nonatomic, assign,readwrite) int getAge;
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

- (IBAction)ActionDone:(id)sender;
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
- (IBAction)ActionReset:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletSustain;
- (IBAction)ActionSustain:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletAge;
- (IBAction)ActionAge:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtAge;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

-(BOOL)NewDone;

@end
