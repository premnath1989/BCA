//
//  HealthQuestionnaire.h
//  iMobile Planner
//
//  Created by Erza on 6/18/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagObject.h"

@protocol HealthQuestionnaireDelegate
-(void)swipeToHQ2;
@end

@interface HealthQuestionnaire : UITableViewController<UITextFieldDelegate>{
    id <HealthQuestionnaireDelegate> _delegate;
	TagObject *tohq1;
}

- (IBAction)swipeNext:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textField1;

@property (nonatomic,strong) id <HealthQuestionnaireDelegate> delegate;
- (IBAction)endEditing:(id)sender;

@end
