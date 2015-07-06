//
//  EverHLoadingViewController.h
//  iMobile Planner
//
//  Created by infoconnect on 6/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "AppDelegate.h"

@class EverHLViewController;
@protocol EverHLViewControllerDelegate
-(void) HLInsert:(NSString *)aaBasicHL andBasicTempHL:(NSString *)aaBasicTempHL;
-(void)HLGlobalSave;
@end


@interface EverHLoadingViewController : UIViewController<UITextFieldDelegate>{
	NSString *databasePath;
    sqlite3 *contactDB;
    id <EverHLViewControllerDelegate> _delegate;
	
	AppDelegate *appDel;
	BOOL Editable;
}
@property (nonatomic,strong) id <EverHLViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *txtHLoad;
@property (weak, nonatomic) IBOutlet UITextField *txtHloadTerm;
@property (weak, nonatomic) IBOutlet UITextField *txtHloadPct;
@property (weak, nonatomic) IBOutlet UITextField *txtHLoadPctTerm;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletMedical;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletDone;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletEAPP;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletSpace;

- (IBAction)ActionMedical:(id)sender;
- (IBAction)ActionDone:(id)sender;
- (IBAction)ActionEAPP:(id)sender;

@property (nonatomic,strong) id EAPPorSI;

//--request
@property (nonatomic, assign,readwrite) int ageClient;
@property (nonatomic,strong) NSString *planChoose;
@property (nonatomic, copy) NSString *SINo;
@property (nonatomic,strong) id requesteProposalStatus;
//--
@property (nonatomic, assign,readwrite) int termCover;
@property (nonatomic,copy) NSString *getHL;
@property (nonatomic,assign,readwrite) int getHLTerm;
@property (nonatomic,copy) NSString *getHLPct;
@property (nonatomic,assign,readwrite) int getHLTermPct;
@property (nonatomic,assign,readwrite) int getMed;

-(BOOL)NewDone;

@end
