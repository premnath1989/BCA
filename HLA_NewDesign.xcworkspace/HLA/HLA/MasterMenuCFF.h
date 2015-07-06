//
//  MasterMenuCFF.h
//  iMobile Planner
//
//  Created by shawal sapuan on 6/28/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DisclosureStatus.h"
#import "CustomerChoice.h"
#import "CustomerPersonalData.h"
#import "PotentialAreas.h"
#import "Preference.h"
#import "FinancialAnalysis.h"

#import "FNAProtection.h"
#import "FNARetirement.h"
#import "FNAEducation.h"
#import "FNASavings.h"

#import "Retirement.h"
#import "RecordofAdvice.h"
#import "Declare.h"
#import "ConfirmationCFF.h"
#import "TableCheckBox.h"//disclosure

#import "PersonalDataViewController.h"

@class MasterMenuCFF;

@protocol MasterMenuCFFDelegate <NSObject>

-(void)selectedCFF;

@end

@interface MasterMenuCFF : UIViewController<TableCheckBoxDelegate> {
    
    NSIndexPath *selectedPath;
    NSIndexPath *previousPath;
    
    TableCheckBox *_DisclosureVC;
    CustomerChoice *_CustomerVC;
    CustomerPersonalData *_CustomerDataVC;
    PotentialAreas *_PotentialVC;
    Preference *_PreferenceVC;
    
    FinancialAnalysis *_FinancialVC;
    FNAProtection *_FNAProtectionVC;
    FNARetirement *_FNARetirementVC;
    FNAEducation *_FNAEducationVC;
    FNASavings *_FNASavingsVC;
    
    
    Retirement *_RetirementVC;
    RecordofAdvice *_RecordVC;
    Declare *_DeclareCFFVC;
    ConfirmationCFF *_ConfirmCFFVC;
	
	PersonalDataViewController *PersonalDataVC;
    
    //int fLoad;
}
- (IBAction)doCancel:(id)sender;
- (IBAction)doDone:(id)sender;


@property (strong, nonatomic) IBOutlet UIView *RightView;
@property (strong, nonatomic) IBOutlet UIView *SecBView;
@property (strong, nonatomic) IBOutlet UIView *SecCView;
@property (strong, nonatomic) IBOutlet UIView *SecDView;
@property (strong, nonatomic) IBOutlet UIView *SecEView;

@property (strong, nonatomic) IBOutlet UIView *SecFView;
@property (weak, nonatomic) IBOutlet UIView *SecFViewTab;
@property (weak, nonatomic) IBOutlet UIView *SecFViewProtection;
@property (weak, nonatomic) IBOutlet UIView *SecFViewRetirement;
@property (weak, nonatomic) IBOutlet UIView *SecFViewEducation;
@property (weak, nonatomic) IBOutlet UIView *SecFViewSavings;
@property (weak, nonatomic) IBOutlet UISegmentedControl *secFTab;
- (IBAction)doSecFTab:(id)sender;



@property (strong, nonatomic) IBOutlet UIView *SecGView;
@property (strong, nonatomic) IBOutlet UIView *SecHView;
@property (strong, nonatomic) IBOutlet UIView *SecIView;






@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UILabel *CFFTitle;






//@property (strong, nonatomic) IBOutlet UITableView *myTableView;
//@property (strong, nonatomic) IBOutlet UIView *RightView;

//@property (strong, nonatomic) IBOutlet UIView *RightView;
//@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (retain, nonatomic) NSMutableArray *ListOfSubMenu;
@property (nonatomic, retain) TableCheckBox *DisclosureVC;
@property (nonatomic, retain) CustomerChoice *CustomerVC;
@property (nonatomic, retain) CustomerPersonalData *CustomerDataVC;
@property (nonatomic, retain) PotentialAreas *PotentialVC;
@property (nonatomic, retain) Preference *PreferenceVC;

@property (nonatomic, retain) FinancialAnalysis *FinancialVC;
@property (nonatomic, retain) FNAProtection *FNAProtectionVC;
@property (nonatomic, retain) FNARetirement *FNARetirementVC;
@property (nonatomic, retain) FNAEducation *FNAEducationVC;
@property (nonatomic, retain) FNASavings *FNASavingsVC;

@property (weak, nonatomic) IBOutlet UINavigationBar *myBar;


@property (nonatomic, retain) Retirement *RetirementVC;
@property (nonatomic, retain) RecordofAdvice *RecordVC;
@property (nonatomic, retain) Declare *DeclareCFFVC;
@property (nonatomic, retain) ConfirmationCFF *ConfirmCFFVC;

@property (weak, nonatomic) NSString *fLoad;
@property (nonatomic, assign) BOOL eApp;

-(BOOL)validSecA;
-(BOOL)validSecB;
-(BOOL)validSecC;
-(BOOL)validSecD;
-(BOOL)validSecE;
-(BOOL)validSecF;
-(BOOL)validSecFProtection;
-(BOOL)validSecFRetirement;
-(BOOL)validSecFEducation;
-(BOOL)validSecFSavings;
-(BOOL)validSecG;
-(BOOL)validSecH;
-(BOOL)validSecI;

-(void)saveCreateCFF:(int)toSave;

@property (nonatomic, weak) id <MasterMenuCFFDelegate> delegate;

// current cff details for eApp
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *idNo;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *cffID;
@property (nonatomic, retain) NSString *clientProfileID;

@end
