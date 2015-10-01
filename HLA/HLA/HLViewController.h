//
//  HLViewController.h
//  iMobile Planner
//
//  Created by shawal sapuan on 3/6/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "AppDelegate.h"
#import "HLValueList.h"

@class HLViewController;
@protocol HLViewControllerDelegate
-(void) HLInsert:(NSString *)aaBasicHL andBasicTempHL:(NSString *)aaBasicTempHL;
-(void)saveAll;
@end

@interface HLViewController : UIViewController <UITextFieldDelegate, HLValueListDelegate> {
    NSString *databasePath;
    sqlite3 *contactDB;
    id <HLViewControllerDelegate> _delegate;
	AppDelegate* appDelegate;
	BOOL Editable;
    UIPopoverController *_planPopover;
    HLValueList *_VaLueList;
}

@property (nonatomic,strong) id <HLViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *HLField;
@property (strong, nonatomic) IBOutlet UITextField *HLTermField;
@property (strong, nonatomic) IBOutlet UITextField *TempHLField;
@property (strong, nonatomic) IBOutlet UITextField *TempHLTermField;
@property (strong, nonatomic) IBOutlet UIToolbar *myToolBar;
@property (strong, nonatomic) IBOutlet UILabel *headerTitle;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletDone;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletEAPP;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletSpace;

- (IBAction)ActionEAPP:(id)sender;

- (IBAction)doSave:(id)sender;

@property (nonatomic,strong) id EAPPorSI;

//--request
@property (nonatomic, assign,readwrite) int ageClient;
@property (nonatomic,strong) NSString *planChoose;
@property (nonatomic, copy) NSString *SINo;
@property (nonatomic,strong) id requesteProposalStatus;
//--
@property (nonatomic, assign,readwrite) int getMOP;
@property (nonatomic, assign,readwrite) int termCover;
@property (nonatomic,copy) NSString *getHL;
@property (nonatomic,assign,readwrite) int getHLTerm;
@property (nonatomic,copy) NSString *getTempHL;
@property (nonatomic,assign,readwrite) int getTempHLTerm;

@property (nonatomic, retain) UIPopoverController *planPopover;
@property (nonatomic, retain) HLValueList *ValueList;

-(BOOL)validateSave;
- (BOOL)updateHL;
-(void)loadHL;

@end
