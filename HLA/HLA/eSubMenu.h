//
//  MasterMenuEApp.h
//  iMobile Planner
//
//  Created by shawal sapuan on 6/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Summary.h"
#import "PolicyDetails.h"
#import "NomineesTrustees.h"
#import "HealthQuestionnaire.h"
#import "AdditionalQuestions.h"
#import "Declaration.h"
#import "CustomerPersonalData.h"
#import "eAppPersonalDetails.h"
#import "HealthQuestionnaire2.h"
#import "HealthQuestionnaire3.h"
//#import "ExistingLifePolicies.h"

#import "pendingVC.h"
#import "submittedVC.h"

@interface eSubMenu : UIViewController <HealthQuestionnaireDelegate, HealthQuestionnaire2Delegate,SummaryDelegate>  {
    NSIndexPath *selectedPath;
    NSIndexPath *previousPath;
    Summary *_SummaryVC;
    
    pendingVC *_pendVC;
    submittedVC *_submittedVC;
    
    PolicyDetails *_PolicyVC;
    NomineesTrustees *_NomineesVC;
    HealthQuestionnaire *_HealthVC;
    AdditionalQuestions *_AddQuestVC;
    Declaration *_DeclareVC;
    CustomerPersonalData *_CustomerDataVC;
     eAppPersonalDetails *_eAppPersonalDataVC;
    HealthQuestionnaire2 *_HealthVC2;
    HealthQuestionnaire3 *_HealthVC3;
//    ExistingLifePolicies *_part4;
}

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIView *rightView;
- (IBAction)doeAppChecklist:(id)sender;

- (IBAction)doDone:(id)sender;

@property (retain, nonatomic) NSMutableArray *ListOfSubMenu;
@property (nonatomic, retain) Summary *SummaryVC;

@property (nonatomic, retain) pendingVC *pendVC;
@property (nonatomic, retain) submittedVC *submittedVC;

@property (nonatomic, retain) PolicyDetails *PolicyVC;
@property (nonatomic, retain) NomineesTrustees *NomineesVC;
@property (nonatomic, retain) HealthQuestionnaire *HealthVC;
@property (nonatomic, retain) AdditionalQuestions *AddQuestVC;
@property (nonatomic, retain) Declaration *DeclareVC;
@property (nonatomic, retain) CustomerPersonalData *CustomerDataVC;
@property (nonatomic, retain) eAppPersonalDetails *eAppPersonalDataVC;
@property (nonatomic, retain) HealthQuestionnaire2 *HealthVC2;
@property (nonatomic, retain) HealthQuestionnaire3 *HealthVC3;
//@property (nonatomic, retain) ExistingLifePolicies *part4;


@end
