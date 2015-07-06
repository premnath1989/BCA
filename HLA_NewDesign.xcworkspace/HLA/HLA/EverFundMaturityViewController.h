//
//  EverFundMaturityViewController.h
//  iMobile Planner
//
//  Created by infoconnect on 7/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "PopOverFundViewController.h"

@class EverFundMaturity;
@protocol EverFundMaturity
-(void)FundMaturityGlobalSave;
@end

@interface EverFundMaturityViewController : UIViewController<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource,
											FundListDelegate>{
	NSString *databasePath;
	sqlite3 *contactDB;
 	UITextField *activeField;
	UIPopoverController *_FundPopover;
	PopOverFundViewController *_FundList;
 	id <EverFundMaturity> _delegate;
}

@property (nonatomic, retain) PopOverFundViewController *FundList;
@property (nonatomic, retain) UIPopoverController *FundPopover;
@property (nonatomic,strong) id <EverFundMaturity> delegate;

//--request
@property (nonatomic, copy) NSString *SINo;
//--


- (IBAction)ACtionDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletFund;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletOptions;
- (IBAction)ActionOptions:(id)sender;
- (IBAction)ACtionFund:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtPercentageReinvest;
@property (weak, nonatomic) IBOutlet UITextField *txt2025;
@property (weak, nonatomic) IBOutlet UITextField *txt2030;
@property (weak, nonatomic) IBOutlet UITextField *txtSecureFund;
@property (weak, nonatomic) IBOutlet UITextField *txt2028;
@property (weak, nonatomic) IBOutlet UITextField *txt2035;
@property (weak, nonatomic) IBOutlet UITextField *txtCashFund;
@property (weak, nonatomic) IBOutlet UITextField *txtDanaFund;


@property (weak, nonatomic) IBOutlet UIButton *outletDelete;
- (IBAction)ActionDelete:(id)sender;
- (IBAction)ActionEdit:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletEdit;
- (IBAction)ActionAdd:(id)sender;



@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIView *outletTableLabel;

@property (retain, nonatomic) NSMutableArray *aMaturityFund;
@property (retain, nonatomic) NSMutableArray *aFundOption;
@property (retain, nonatomic) NSMutableArray *aPercent;
@property (retain, nonatomic) NSMutableArray *a2025;
@property (retain, nonatomic) NSMutableArray *a2028;
@property (retain, nonatomic) NSMutableArray *a2030;
@property (retain, nonatomic) NSMutableArray *a2035;
@property (retain, nonatomic) NSMutableArray *aCashFund;
@property (retain, nonatomic) NSMutableArray *aSecureFund;
@property (retain, nonatomic) NSMutableArray *aDanaFund;

@property (retain, nonatomic) NSMutableArray *ItemToBeDeleted;
@property (retain, nonatomic) NSMutableArray *indexPaths;
@end
