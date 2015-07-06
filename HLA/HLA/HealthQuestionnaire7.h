//
//  HealthQuestionnaire7.h
//  iMobile Planner
//
//  Created by Erza on 7/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagObject.h"

@interface HealthQuestionnaire7 : UITableViewController<UITextFieldDelegate>{
	TagObject *tohq7;
}
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@end
