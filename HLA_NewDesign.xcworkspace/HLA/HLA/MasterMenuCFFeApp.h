//
//  MasterMenuCFF.h
//  iMobile Planner
//
//  Created by shawal sapuan on 6/28/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisclosureStatus.h"
#import "CustomerChoice.h"
#import "CustomerPersonalData.h"
#import "PotentialAreas.h"
#import "Preference.h"
#import "FinancialAnalysis.h"
#import "Retirement.h"
#import "RecordofAdvice.h"
#import "Declare.h"
#import "ConfirmationCFF.h"

@class MasterMenuCFFeApp;

@protocol MasterMenuCFFeAppDelegate <NSObject>

-(void)selectedCFF;

@end

@interface MasterMenuCFFeApp : UIViewController {
    NSIndexPath *selectedPath;
    NSIndexPath *previousPath;
    DisclosureStatus *_DisclosureVC;
    CustomerChoice *_CustomerVC;
    CustomerPersonalData *_CustomerDataVC;
    PotentialAreas *_PotentialVC;
    Preference *_PreferenceVC;
    FinancialAnalysis *_FinancialVC;
    Retirement *_RetirementVC;
    RecordofAdvice *_RecordVC;
    Declare *_DeclareCFFVC;
    ConfirmationCFF *_ConfirmCFFVC;
}
- (IBAction)doCancel:(id)sender;
- (IBAction)doDone:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *RightView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
//@property (strong, nonatomic) IBOutlet UITableView *myTableView;
//@property (strong, nonatomic) IBOutlet UIView *RightView;

//@property (strong, nonatomic) IBOutlet UIView *RightView;
//@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (retain, nonatomic) NSMutableArray *ListOfSubMenu;
@property (nonatomic, retain) DisclosureStatus *DisclosureVC;
@property (nonatomic, retain) CustomerChoice *CustomerVC;
@property (nonatomic, retain) CustomerPersonalData *CustomerDataVC;
@property (nonatomic, retain) PotentialAreas *PotentialVC;
@property (nonatomic, retain) Preference *PreferenceVC;
@property (nonatomic, retain) FinancialAnalysis *FinancialVC;
@property (nonatomic, retain) Retirement *RetirementVC;
@property (nonatomic, retain) RecordofAdvice *RecordVC;
@property (nonatomic, retain) Declare *DeclareCFFVC;
@property (nonatomic, retain) ConfirmationCFF *ConfirmCFFVC;

// current cff details
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *idNo;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *cffID;
@property (nonatomic, retain) NSString *clientProfileID;

@property (nonatomic, weak) id <MasterMenuCFFeAppDelegate> delegate;

@end
