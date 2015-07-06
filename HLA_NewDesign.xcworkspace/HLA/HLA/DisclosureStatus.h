//
//  DisclosureStatus.h
//  iMobile Planner
//
//  Created by Erza on 6/14/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisclosureStatus : UIViewController {
    BOOL checked;
}
@property (strong, nonatomic) IBOutlet UIButton *checkButton;
- (IBAction)checkboxButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *checkButton1;
- (IBAction)checkboxButton1:(id)sender;

@end
