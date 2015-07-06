//
//  EverSpecialViewController.h
//  iMobile Planner
//
//  Created by infoconnect on 7/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

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
}

@property (nonatomic,strong) id <EverSpecial> delegate;

//--request
@property (nonatomic, copy) NSString *SINo;
@property (nonatomic, assign,readwrite) int getAge;
@property (nonatomic, copy) NSString *getBasicSA;
//--

- (IBAction)ActionDone:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletWithdrawal;
- (IBAction)ActionWithdrawal:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtStartFrom;
@property (weak, nonatomic) IBOutlet UITextField *txtStartTo;
@property (weak, nonatomic) IBOutlet UITextField *txtInterval;
@property (weak, nonatomic) IBOutlet UITextField *txtAmount;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletReduce;
- (IBAction)ActionReduce:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtReduceAt;
@property (weak, nonatomic) IBOutlet UITextField *txtReduceTo;
@property (weak, nonatomic) IBOutlet UILabel *lblReduceAt;
@property (weak, nonatomic) IBOutlet UILabel *lblReduceTo;

-(BOOL)NewDone;

@end
