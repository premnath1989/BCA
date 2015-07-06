//
//  MainAdditionalQuestions.h
//  iMobile Planner
//
//  Created by kuan on 9/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddtionalQuestInsured.h"
#import "DataClass.h"
@protocol ProcessDataDelegate <NSObject>
@required
- (void) processSuccessful: (BOOL)success;
@end

@interface MainAdditionalQuestInsureds : UIViewController <UIGestureRecognizerDelegate>
{
    AddtionalQuestInsured *addtionalQuestInsured;
    DataClass *obj;
    id <ProcessDataDelegate> delegate;
}

@property (strong, nonatomic) IBOutlet UIView *mainView;
- (IBAction)actionForDone:(id)sender;
- (IBAction)actionForClose:(id)sender;
@property (strong, nonatomic) NSMutableArray *insuredArray;
@property (retain) id delegate;
@end
