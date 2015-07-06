//
//  EverSpecialViewController.h
//  iMobile Planner
//
//  Created by infoconnect on 7/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "AppDelegate.h"

@class EverSpecial;
@protocol EverSpecial
-(void)SpecialGlobalSave;
@end

@interface EverSpecialViewController : UIViewController<UITextFieldDelegate>{
	NSString *databasePath;
	sqlite3 *contactDB;
 	UITextField *activeField;
 	id <EverSpecial> _delegate;
	BOOL WithdrawExist;
	BOOL ReduceExist;
	
	AppDelegate *appDel;
	BOOL Editable;
}

@property (nonatomic,strong) id <EverSpecial> delegate;

//--request
@property (nonatomic, copy) NSString *SINo;
@property (nonatomic, assign,readwrite) int getAge;
@property (nonatomic, copy) NSString *getBasicSA;
@property (nonatomic, assign,readwrite) int getBasicTerm;
@property (nonatomic,strong) id requesteProposalStatus;
//--

@property (nonatomic,strong) id EAPPorSI;


@property (weak, nonatomic) IBOutlet UISegmentedControl *outletWithdrawal;
@property (weak, nonatomic) IBOutlet UITextField *txtStartFrom;
@property (weak, nonatomic) IBOutlet UITextField *txtStartTo;
@property (weak, nonatomic) IBOutlet UITextField *txtInterval;
@property (weak, nonatomic) IBOutlet UITextField *txtAmount;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletReduce;
@property (weak, nonatomic) IBOutlet UITextField *txtReduceAt;
@property (weak, nonatomic) IBOutlet UITextField *txtReduceTo;
@property (weak, nonatomic) IBOutlet UILabel *lblReduceAt;
@property (weak, nonatomic) IBOutlet UILabel *lblReduceTo;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletDone;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletEAPP;
- (IBAction)ActionEAPP:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletSpace;

- (IBAction)ActionDone:(id)sender;
- (IBAction)ActionWithdrawal:(id)sender;
- (IBAction)ActionReduce:(id)sender;
-(BOOL)NewDone;

@end
