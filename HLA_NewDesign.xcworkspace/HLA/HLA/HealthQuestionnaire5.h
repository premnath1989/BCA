//
//  HealthQuestionnaire5.h
//  iMobile Planner
//
//  Created by Juliana on 7/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagObject.h"

@interface HealthQuestionnaire5 : UITableViewController<UITextFieldDelegate>{
	TagObject *tohq5;
}
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
