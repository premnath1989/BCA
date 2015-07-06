//
//  HealthQuestionnaire3.h
//  iMobile Planner
//
//  Created by Erza on 7/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagObject.h"

@interface HealthQuestionnaire3 : UITableViewController<UITextFieldDelegate>{
	TagObject *tohq3;
}

@property (weak, nonatomic) IBOutlet UITextField *beerTF;
@property (weak, nonatomic) IBOutlet UITextField *wineTF;
@property (weak, nonatomic) IBOutlet UITextField *wboTF;

@property (strong, nonatomic) IBOutlet UITextField *ftf;

@end
