//
//  HealthQuestionnaire.h
//  iMobile Planner
//
//  Created by Erza on 6/18/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagObject.h"
#import "HealthQuestionsVC.h"


@protocol HealthQuestionnaireDelegate
-(void)swipeToHQ2;
-(void)Titlelabel;
@end

@interface HealthQuestionnaire : UITableViewController<UITextViewDelegate>{
    id <HealthQuestionnaireDelegate> _delegate;
	HealthQuestionsVC *_HealthQuestionsVC;
	TagObject *tohq1;
}

- (IBAction)swipeNext:(id)sender;
- (IBAction)detectChanges1:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textField1;
@property (strong, nonatomic) IBOutlet UITextView *textView1;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (nonatomic, retain) HealthQuestionsVC *HealthQuestionsVC;


@property (nonatomic,strong) id <HealthQuestionnaireDelegate> delegate;
- (IBAction)endEditing:(id)sender;

@end
