//
//  PayorViewController.h
//  HLA
//
//  Created by shawal sapuan on 7/31/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "ListingTbViewController.h"
#import "BasicPlanHandler.h"
#import "PayorHandler.h"
#import "DateViewController.h"
#import "OccupationList.h"
#import "AppDelegate.h"
#import "SIObj.h"

@class PayorViewController;
@protocol PayorViewControllerDelegate
-(void)PayorIndexNo:(int)aaIndexNo andSmoker:(NSString *)aaSmoker andSex:(NSString *)aaSex andDOB:(NSString *)aaDOB andAge:(int)aaAge andOccpCode:(NSString *)aaOccpCode;
-(void)PayorDeleted;
-(void) RiderAdded;
-(void)payorSaved:(BOOL)aaTrue;
-(void)saveAll;
@end

@interface PayorViewController : UIViewController <ListingTbViewControllerDelegate,UIPopoverControllerDelegate, DateViewControllerDelegate, OccupationListDelegate,UITextFieldDelegate> {
    NSString *databasePath;
    sqlite3 *contactDB;
    UIPopoverController *popOverController;
    UIPopoverController *_dobPopover;
    UIPopoverController *_OccupationListPopover;
    ListingTbViewController *_ProspectList;
    DateViewController *_LADate;
    id <PayorViewControllerDelegate> _delegate;
    BOOL useExist;
    BOOL inserted;
    BOOL date1;
    BOOL isNewClient;
	SIObj* payorSIObj;
    AppDelegate* appDelegate;
}

@property (nonatomic, retain) UIPopoverController *popOverController;
@property (nonatomic, retain) UIPopoverController *dobPopover;
@property (nonatomic, retain) UIPopoverController *OccupationListPopover;
@property (nonatomic, retain) OccupationList *OccupationList;
@property (nonatomic, retain) ListingTbViewController *ProspectList;
@property (nonatomic, retain) DateViewController *LADate;
@property (nonatomic,strong) id <PayorViewControllerDelegate> delegate;

@property (nonatomic,strong) PayorHandler *payorHand;
@property (nonatomic,strong) BasicPlanHandler *basicHand;
@property (strong, nonatomic) NSMutableArray *dataInsert;
@property (strong, nonatomic) NSMutableArray *RiderToBeDeleted;

//--request
@property (nonatomic, assign,readwrite) int requestLAIndexNo;
@property (nonatomic, assign,readwrite) int requestLAAge;
@property (nonatomic,strong) id requestSINo;
@property (nonatomic,strong) id requestCommDate;
@property (nonatomic, assign,readwrite) int getLAIndexNo;
@property (nonatomic, assign,readwrite) int getLAAge;
@property(nonatomic , retain) NSString *getSINo;
@property (nonatomic, copy) NSString *getCommDate;
//--
@property (retain, nonatomic) IBOutlet UITextField *nameField;
@property (retain, nonatomic) IBOutlet UISegmentedControl *sexSegment;
@property (retain, nonatomic) IBOutlet UISegmentedControl *smokerSegment;
@property (strong, nonatomic) IBOutlet UITextField *DOBField;
@property (retain, nonatomic) IBOutlet UITextField *ageField;
@property (strong, nonatomic) IBOutlet UITextField *OccpField;
@property (retain, nonatomic) IBOutlet UITextField *occpLoadField;
@property (retain, nonatomic) IBOutlet UITextField *CPAField;
@property (retain, nonatomic) IBOutlet UITextField *PAField;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong, nonatomic) IBOutlet UIToolbar *myToolBar;
@property (strong, nonatomic) IBOutlet UILabel *headerTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnDOB;
@property (strong, nonatomic) IBOutlet UIButton *btnOccp;

@property (nonatomic, assign,readwrite) int IndexNo;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *smoker;
@property (nonatomic, copy) NSString *DOB;
@property (nonatomic, copy) NSString *jobDesc;
@property (nonatomic, assign,readwrite) int age;
@property (nonatomic, assign,readwrite) int ANB;
@property(nonatomic , retain) NSString *OccpCode;
@property(nonatomic , retain) NSString *occLoading;
@property(nonatomic , assign,readwrite) int occCPA_PA;
@property(nonatomic , assign,readwrite) int occPA;
@property (nonatomic, assign,readwrite) int occuClass;
@property (nonatomic, copy) NSString *occuCode;
@property (nonatomic, copy) NSString *occuDesc;
@property(nonatomic , retain) NSString *SINo;
@property (nonatomic, assign,readwrite) int CustLastNo;
@property (nonatomic, copy) NSString *CustDate;
@property (nonatomic, copy) NSString *CustCode;
@property (nonatomic, copy) NSString *clientName;
@property (nonatomic, assign,readwrite) int clientID;
@property (nonatomic, copy) NSString *OccpDesc;
@property (nonatomic, copy) NSString *CheckRiderCode;

@property(nonatomic , retain) NSString *NamePP;
@property(nonatomic , retain) NSString *DOBPP;
@property(nonatomic , retain) NSString *GenderPP;
@property(nonatomic , retain) NSString *OccpCodePP;

@property(nonatomic , retain) NSString *Change;
@property(nonatomic , retain) NSString *LAView;

- (IBAction)doSelectProspect:(id)sender;
- (IBAction)sexSegmentChange:(id)sender;
- (IBAction)smokerSegmentChange:(id)sender;
- (IBAction)doSave:(id)sender;
- (IBAction)doDelete:(id)sender;
- (IBAction)btnDOBPressed:(id)sender;
- (IBAction)btnOccpPressed:(id)sender;
- (IBAction)enableFields:(id)sender;
- (BOOL)validateSave;
-(BOOL)performSavePayor;
-(void) resetField;
-(BOOL)isPayorSelected;
-(void)loadData;

@end
