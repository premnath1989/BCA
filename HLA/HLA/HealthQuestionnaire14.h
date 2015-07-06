//
//  HealthQuestionnaire14.h
//  iMobile Planner
//
//  Created by Erza on 7/30/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthQuestionnaire14 : UITableViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *outsideTF;
@property (strong, nonatomic) IBOutlet UITextField *monthsTF;

@end
