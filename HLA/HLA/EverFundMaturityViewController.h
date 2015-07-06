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
#import "AppDelegate.h"

@class EverFundMaturity;
@protocol EverFundMaturity
-(void)FundMaturityGlobalSave;
@end

@interface EverFundMaturityViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource,
											FundListDelegate>{
	NSString *databasePath;
	sqlite3 *contactDB;
 	UITextField *activeField;
	UIPopoverController *_FundPopover;
	PopOverFundViewController *_FundList;
 	id <EverFundMaturity> _delegate;
												
	AppDelegate *appDel;
	BOOL Editable;
												
}

@property (nonatomic, retain) PopOverFundViewController *FundList;
@property (nonatomic, retain) UIPopoverController *FundPopover;
@property (nonatomic,strong) id <EverFundMaturity> delegate;

//--request
@property (nonatomic, copy) NSString *SINo;
@property (nonatomic, copy) NSString *PlanCode;
@property (nonatomic, copy) NSString *BasicTerm;
@property (nonatomic,strong) id requesteProposalStatus;
//--

@property (nonatomic,strong) id EAPPorSI;


@property (weak, nonatomic) IBOutlet UIButton *outletFund;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletOptions;
@property (weak, nonatomic) IBOutlet UITextField *txtPercentageReinvest;
@property (weak, nonatomic) IBOutlet UITextField *txt2025;
@property (weak, nonatomic) IBOutlet UITextField *txt2030;
@property (weak, nonatomic) IBOutlet UITextField *txtSecureFund;
@property (weak, nonatomic) IBOutlet UITextField *txt2028;
@property (weak, nonatomic) IBOutlet UITextField *txt2035;
@property (weak, nonatomic) IBOutlet UITextField *txtCashFund;
@property (weak, nonatomic) IBOutlet UITextField *txtDanaFund;
@property (weak, nonatomic) IBOutlet UIButton *outletDelete;
@property (weak, nonatomic) IBOutlet UIButton *outletEdit;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIView *outletTableLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletDone;
@property (weak, nonatomic) IBOutlet UIButton *OutletSave;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletEAPP;
@property (weak, nonatomic) IBOutlet UITextField *txtVentureFlexi;

///
@property (weak, nonatomic) IBOutlet UITextField *txtVentureGrowth;
@property (weak, nonatomic) IBOutlet UITextField *txtVentureBlueChip;
@property (weak, nonatomic) IBOutlet UITextField *txtVentureDana;
@property (weak, nonatomic) IBOutlet UITextField *txtVentureManaged;
@property (weak, nonatomic) IBOutlet UITextField *txtVentureIncome;
@property (weak, nonatomic) IBOutlet UITextField *txtVenture6666;
@property (weak, nonatomic) IBOutlet UITextField *txtVenture7777;
@property (weak, nonatomic) IBOutlet UITextField *txtVenture8888;
@property (weak, nonatomic) IBOutlet UITextField *txtVenture9999;

///
@property (strong, nonatomic) NSMutableArray *aVentureGrowth;
@property (strong, nonatomic) NSMutableArray *aVentureBlueChip;
@property (strong, nonatomic) NSMutableArray *aVentureDana;
@property (strong, nonatomic) NSMutableArray *aVentureManaged;
@property (strong, nonatomic) NSMutableArray *aVentureIncome;
@property (strong, nonatomic) NSMutableArray *aVenture6666;
@property (strong, nonatomic) NSMutableArray *aVenture7777;
@property (strong, nonatomic) NSMutableArray *aVenture8888;
@property (strong, nonatomic) NSMutableArray *aVenture9999;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletSpace;

- (IBAction)ActionEAPP:(id)sender;

- (IBAction)ACtionDone:(id)sender;
- (IBAction)ActionOptions:(id)sender;
- (IBAction)ACtionFund:(id)sender;
- (IBAction)ActionDelete:(id)sender;
- (IBAction)ActionEdit:(id)sender;
- (IBAction)ActionAdd:(id)sender;





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
@property (retain, nonatomic) NSMutableArray *aSmartFund;
@property (retain, nonatomic) NSMutableArray *aVentureFund;

@property (retain, nonatomic) NSMutableArray *ItemToBeDeleted;
@property (retain, nonatomic) NSMutableArray *indexPaths;

@property(strong,nonatomic)IBOutlet UICollectionView *collectionView;
@property(strong, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (nonatomic, strong) NSIndexPath *selectedItemIndexPath;
@end
