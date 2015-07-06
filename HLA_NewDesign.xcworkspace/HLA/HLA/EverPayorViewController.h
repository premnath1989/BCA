//
//  EverPayorViewController.h
//  iMobile Planner
//
//  Created by infoconnect on 6/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "ListingTbViewController.h"
#import "DateViewController.h"
#import "OccupationList.h"

@class EverPayorViewController;
@protocol EverPayorViewControllerDelegate
-(void)PayorIndexNo:(int)aaIndexNo andSmoker:(NSString *)aaSmoker andSex:(NSString *)aaSex andDOB:(NSString *)aaDOB andAge:(int)aaAge andOccpCode:(NSString *)aaOccpCode;
-(void)PayorDeleted;
-(void) RiderAdded;
-(void)payorSaved:(BOOL)aaTrue;
-(void)PayorGlobalSave;
@end


@interface EverPayorViewController : UIViewController<ListingTbViewControllerDelegate,UIPopoverControllerDelegate, DateViewControllerDelegate, OccupationListDelegate>{
	NSString *databasePath;
    sqlite3 *contactDB;
    UIPopoverController *popOverController;
    ListingTbViewController *_ProspectList;
	DateViewController *_LADate;
    id <EverPayorViewControllerDelegate> _delegate;
	UIPopoverController *_dobPopover;
	UIPopoverController *_OccupationListPopover;
    BOOL useExist;
    BOOL inserted;
	BOOL date1;
	BOOL isNewClient;
}
@property (nonatomic, retain) UIPopoverController *popOverController;
@property (nonatomic, retain) UIPopoverController *dobPopover;
@property (nonatomic, retain) UIPopoverController *OccupationListPopover;
@property (nonatomic, retain) ListingTbViewController *ProspectList;
@property (nonatomic, retain) OccupationList *OccupationList;
@property (nonatomic, retain) DateViewController *LADate;
@property (nonatomic,strong) id <EverPayorViewControllerDelegate> delegate;
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
@property(nonatomic , retain) NSString *SINo;
@property (nonatomic, assign,readwrite) int CustLastNo;
@property (nonatomic, copy) NSString *CustDate;
@property (nonatomic, copy) NSString *CustCode;
@property (nonatomic, copy) NSString *clientName;
@property (nonatomic, assign,readwrite) int clientID;
@property (nonatomic, copy) NSString *OccpDesc;
@property (nonatomic, copy) NSString *CheckRiderCode;
@property (nonatomic, copy) NSString *occuCode;
@property(nonatomic , retain) NSString *NamePP;
@property(nonatomic , retain) NSString *DOBPP;
@property(nonatomic , retain) NSString *GenderPP;
@property(nonatomic , retain) NSString *OccpCodePP;
@property(nonatomic , retain) NSString *Change;
@property(nonatomic , retain) NSString *LAView;

@property (weak, nonatomic) IBOutlet UIButton *btnDOB;
@property (weak, nonatomic) IBOutlet UIButton *btnOccpDesc;
@property (weak, nonatomic) IBOutlet UIButton *btnEnable;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletGender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletSmoker;
@property (weak, nonatomic) IBOutlet UITextField *outletDOB;
@property (weak, nonatomic) IBOutlet UITextField *txtALB;
@property (weak, nonatomic) IBOutlet UITextField *txtOccpDesc;
@property (weak, nonatomic) IBOutlet UITextField *txtOccpLoad;
@property (weak, nonatomic) IBOutlet UITextField *txtCPA;
@property (weak, nonatomic) IBOutlet UITextField *txtPA;
@property (weak, nonatomic) IBOutlet UIButton *outletDelete;

- (IBAction)ActionEnable:(id)sender;
- (IBAction)ActionDone:(id)sender;
- (IBAction)ActionDelete:(id)sender;
- (IBAction)ActionProspect:(id)sender;
- (IBAction)ActionGender:(id)sender;
- (IBAction)ACtionSmoker:(id)sender;
- (IBAction)ActionOccpDesc:(id)sender;
- (IBAction)ActionDOB:(id)sender;
-(BOOL)NewDone;


@end
