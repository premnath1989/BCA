//
//  HealthQuestionnaire15.h
//  iMobile Planner
//
//  Created by Erza on 7/30/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagObject.h"

@interface HealthQuestionnaire15 : UITableViewController <UITextFieldDelegate>
{
    TagObject *tohq15;
}
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextField *weightTF;
@property (strong, nonatomic) IBOutlet UITextField *daysTF;

@end
