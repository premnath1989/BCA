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
#import "HealthQuestions.h"
#import "AdditionalQuestions.h"
#import "Declaration.h"
#import "CustomerPersonalData.h"
#import "eAppPersonalDetails.h"
#import "HealthQuestionnaire2.h"
#import "HealthQuestionnaire3.h"
#import "HealthQuestions1stLA.h"
#import "HealthQuestions2ndLA.h"
#import "HealthQuestionsPO.h"
#import "ExistingPoliciesVC.h"
#import "eSubmission.h"
#import "HealthQuestionsVC.h"
#import "ClearData.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

@interface MasterMenuEApp : UIViewController <HealthQuestionnaire2Delegate,SummaryDelegate, UIAlertViewDelegate, UIGestureRecognizerDelegate>  {
    NSIndexPath *selectedPath;
    NSIndexPath *previousPath;
    Summary *_SummaryVC;
    PolicyDetails *_PolicyVC;
    NomineesTrustees *_NomineesVC;
    HealthQuestions *_HealthVC;
    HealthQuestionsVC *_HealthQuestionsVC;
	HealthQuestions1stLA *_HealthQuestions1stLA;
	HealthQuestions2ndLA *_HealthQuestions2ndLA;
	HealthQuestionsPO * _HealthQuestionsPO;
    AdditionalQuestions *_AddQuestVC;
    Declaration *_DeclareVC;
    CustomerPersonalData *_CustomerDataVC;
     eAppPersonalDetails *_eAppPersonalDataVC;
    HealthQuestionnaire2 *_HealthVC2;
    HealthQuestionnaire3 *_HealthVC3;
    ExistingPoliciesVC *_part4;
	
	BOOL confirmStatus;
	
	FMResultSet *results;
	FMResultSet *results2;
	FMResultSet *results3;
    FMResultSet *results4;
	NSString *stringID;
    NSString *AdditionalQuestion_Occupation;
    BOOL *ChangeTheTick;
    UIImageView *imv;
}

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UIView *rightView;
@property BOOL *ChangeTheTick;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBtn;

- (IBAction)doeAppChecklist:(id)sender;
- (IBAction)doDone:(id)sender;
-(void) deleteEAppCase: (NSString *)SINO;

@property (retain, nonatomic) NSMutableArray *ListOfSubMenu;
@property (nonatomic, retain) Summary *SummaryVC;
@property (nonatomic, retain) PolicyDetails *PolicyVC;
@property (nonatomic, retain) NomineesTrustees *NomineesVC;
@property (nonatomic, retain) HealthQuestions *HealthVC;
@property (nonatomic, retain) HealthQuestionsVC *HealthQuestionsVC;
@property (nonatomic, retain) HealthQuestions1stLA *HealthQuestions1stLA;
@property (nonatomic, retain) HealthQuestions2ndLA *HealthQuestions2ndLA;
@property (nonatomic, retain) HealthQuestionsPO * _HealthQuestionsPO;
@property (nonatomic, retain) AdditionalQuestions *AddQuestVC;
@property (nonatomic, retain) Declaration *DeclareVC;
@property (nonatomic, retain) CustomerPersonalData *CustomerDataVC;
@property (nonatomic, retain) eAppPersonalDetails *eAppPersonalDataVC;
@property (nonatomic, retain) HealthQuestionnaire2 *HealthVC2;
@property (nonatomic, retain) HealthQuestionnaire3 *HealthVC3;
@property (nonatomic, retain) ExistingPoliciesVC *part4;
@property (strong, nonatomic) IBOutlet UILabel *nameLALbl;
@property (nonatomic, retain) UIImageView *imv;

//layers
@property (strong, nonatomic) IBOutlet UIView *SectGView;
@property (strong, nonatomic) IBOutlet UIView *SectFView;
@property (strong, nonatomic) IBOutlet UIView *SectEView;
@property (strong, nonatomic) IBOutlet UIView *SectDView;
@property (strong, nonatomic) IBOutlet UIView *SectCView;
@property (strong, nonatomic) IBOutlet UIView *SectBView;
@property (strong, nonatomic) IBOutlet UIView *SectAView;
//

-(BOOL)validSecA;
-(BOOL)validSecB;
-(BOOL)validSecC;
-(BOOL)validSecD;
-(BOOL)validSecE;
-(BOOL)validSecF;
-(BOOL)validSecG;

@end
