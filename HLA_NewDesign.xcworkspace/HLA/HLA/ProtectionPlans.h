//
//  ProtectionPlans.h
//  iMobile Planner
//
//  Created by Meng Cheong on 8/20/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExistingProtectionPlans.h"

@class ProtectionPlans;

@protocol ProtectionPlansDelegate <NSObject>

-(void)ExistingProtectionPlansUpdate:(ExistingProtectionPlans *)controller rowToUpdate:(int)rowToUpdate;
-(void)ExistingProtectionPlansDelete:(ExistingProtectionPlans *)controller rowToUpdate:(int)rowToUpdate;
@end

@interface ProtectionPlans : UIViewController<UITextFieldDelegate>
- (IBAction)doCancel:(id)sender;
- (IBAction)doSave:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *myView;

@property (nonatomic, retain) ExistingProtectionPlans *ExistingProtectionPlansVC;
@property (nonatomic, weak) id <ProtectionPlansDelegate> delegate;
@property(nonatomic, assign) int rowToUpdate;

-(void)doDelete:(int)rowToUpdate;

@end
