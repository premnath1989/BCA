//
//  EditProspect_OLD.h
//  iMobile Planner
//
//  Created by infoconnect on 11/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProspectProfile.h"
#import <sqlite3.h>
#import "OccupationList.h"
#import "ContactTypeClass.h"
#import "SIDate.h"

@protocol EditProspect_OLDDelegate
- (void)FinishEdit;
@end

@interface EditProspect_OLD : UIViewController<OccupationListDelegate, ContactTypeClassDelegate, SIDateDelegate, UITextViewDelegate>{
	NSString *databasePath;
    sqlite3 *contactDB;
    UITextField *activeField;
    OccupationList *_OccupationList;
    UIPopoverController *_OccupationListPopover;
    ContactTypeClass *_ContactTypeClass;
    UIPopoverController *_ContactTypePopover;
    SIDate *_SIDate;
    UIPopoverController *_SIDatePopover;
    id<EditProspect_OLDDelegate> _delegate;
    
    UIAlertView *rrr;

}

@property (strong, nonatomic) ProspectProfile* pp;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *DOB;
@property (nonatomic, copy) NSString *OccupCodeSelected;
@property (nonatomic, copy) NSString *SelectedStateCode;
@property (nonatomic, copy) NSString *SelectedOfficeStateCode;
@property (nonatomic, copy) NSString *strChanges;
@property (nonatomic, strong) id<EditProspect_OLDDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *txtPreferredName;
@property (weak, nonatomic) IBOutlet UITextField *txtrFullName;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segGender;
@property (weak, nonatomic) IBOutlet UIButton *outletDOB;
@property (weak, nonatomic) IBOutlet UIButton *outletType1;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
- (IBAction)btnDOB:(id)sender;
- (IBAction)btnContactType1:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtHomeAddr1;
@property (weak, nonatomic) IBOutlet UITextField *txtHomeAddr2;
@property (weak, nonatomic) IBOutlet UITextField *txtHomeAddr3;
@property (weak, nonatomic) IBOutlet UITextField *txtHomePostCode;
@property (weak, nonatomic) IBOutlet UITextField *txtHomeTown;
@property (weak, nonatomic) IBOutlet UITextField *txtHomeState;
@property (weak, nonatomic) IBOutlet UITextField *txtHomeCountry;
@property (weak, nonatomic) IBOutlet UITextField *txtOfiiceAddr1;
@property (weak, nonatomic) IBOutlet UITextField *txtOfficeAddr2;
@property (weak, nonatomic) IBOutlet UITextField *txtOfficeAddr3;
@property (weak, nonatomic) IBOutlet UITextField *txtOfficePostCode;
@property (weak, nonatomic) IBOutlet UITextField *txtOfficeTown;
@property (weak, nonatomic) IBOutlet UITextField *txtOfficeState;
@property (weak, nonatomic) IBOutlet UITextField *txtOfficeCountry;
@property (weak, nonatomic) IBOutlet UITextField *txtExactDuties;
- (IBAction)btnOccup:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *txtRemark;
@property (strong, nonatomic) NSArray* ContactType;
@property (nonatomic, copy) NSString *ContactTypeTracker;
@property (nonatomic, retain) OccupationList *OccupationList;
@property (nonatomic, retain) ContactTypeClass *ContactTypeClass;
@property (weak, nonatomic) IBOutlet UITextField *txtContact1;
@property (nonatomic, retain) UIPopoverController *OccupationListPopover;
@property (nonatomic, retain) UIPopoverController *ContactTypePopover;
@property (nonatomic, retain) SIDate *SIDate;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIButton *outletOccup;
- (IBAction)ActionGender:(id)sender;
- (IBAction)btnDelete:(id)sender;



-(void)keyboardDidShow:(NSNotificationCenter *)notification;
-(void)keyboardDidHide:(NSNotificationCenter *)notification;
- (IBAction)btnSave:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletDelete;
@property (weak, nonatomic) IBOutlet UIButton *outletType2;
@property (weak, nonatomic) IBOutlet UIButton *outletType3;
@property (weak, nonatomic) IBOutlet UIButton *outletType4;
@property (weak, nonatomic) IBOutlet UIButton *outletType5;
@property (weak, nonatomic) IBOutlet UITextField *txtContact2;
@property (weak, nonatomic) IBOutlet UITextField *txtContact3;
@property (weak, nonatomic) IBOutlet UITextField *txtContact4;
@property (weak, nonatomic) IBOutlet UITextField *txtContact5;
- (IBAction)btnContact2:(id)sender;
- (IBAction)btnContact3:(id)sender;
- (IBAction)btnContact4:(id)sender;
- (IBAction)btnContact5:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtPrefix1;
@property (weak, nonatomic) IBOutlet UITextField *txtPrefix2;
@property (weak, nonatomic) IBOutlet UITextField *txtPrefix3;
@property (weak, nonatomic) IBOutlet UITextField *txtPrefix4;
@property (weak, nonatomic) IBOutlet UITextField *txtPrefix5;
- (IBAction)btnCancel:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblOfficeAddr;
@property (weak, nonatomic) IBOutlet UILabel *lblPostCode;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outletDone;


@end
