//
//  HealthQuestionnaire4.h
//  iMobile Planner
//
//  Created by Erza on 3/11/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagObject.h"

@interface HealthQuestionnaire4 : UITableViewController<UITextFieldDelegate, UIGestureRecognizerDelegate> {
    TagObject *tohq4;
}
@property (strong, nonatomic) IBOutlet UITextField *cigarettesPerDayTF;
@property (strong, nonatomic) IBOutlet UITextField *pipePerDayTF;
@property (strong, nonatomic) IBOutlet UITextField *cigarPerDayTF;
@property (strong, nonatomic) IBOutlet UITextField *eCigarPerDayTF;

@end
