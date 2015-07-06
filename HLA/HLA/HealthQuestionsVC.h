//
//  HealthQuestionsVC.h
//  iMobile Planner
//
//  Created by Erza on 11/15/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HealthQuestions1stLA.h"
#import "HealthQuestions2ndLA.h"
#import "HealthQuestionsPO.h"
#import "HealthQuestPersonType.h"
#import "TagObject.h"

@interface HealthQuestionsVC : UIViewController<HealthQuestPersonTypeDelegate> {
    BOOL checked;
    TagObject *to;
    
    HealthQuestPersonType *_RelationshipVC;
    
    UIPopoverController *_RelationshipPopover;
}

@property (nonatomic, strong) HealthQuestPersonType *RelationshipVC;
@property (nonatomic, retain) UIPopoverController *RelationshipPopover;
@property (nonatomic, retain) HealthQuestions1stLA *hq1stLA;
@property (nonatomic, retain) HealthQuestions2ndLA *hq2ndLA;
@property (nonatomic, retain) HealthQuestionsPO *hqPo;
@property (strong, nonatomic) IBOutlet UIView *mySubview;
@property (strong, nonatomic) IBOutlet UILabel *personTypeLbl;

- (IBAction)actionForPersonType:(id)sender;
@end
