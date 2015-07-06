//
//  RetirementPlans.h
//  iMobile Planner
//
//  Created by Meng Cheong on 8/22/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExistingRetirementPlans.h"

@class RetirementPlans;

@protocol RetirementPlansDelegate <NSObject>
-(void)ExistingRetirementPlansUpdate:(ExistingRetirementPlans *)controller rowToUpdate:(int)rowToUpdate;
-(void)ExistingRetirementPlansDelete:(ExistingRetirementPlans *)controller rowToUpdate:(int)rowToUpdate;
@end

@interface RetirementPlans : UIViewController

- (IBAction)doSave:(id)sender;
- (IBAction)doCancel:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *myView;


@property (nonatomic, retain) ExistingRetirementPlans *ExistingRetirementPlansVC;
@property (nonatomic, weak) id <RetirementPlansDelegate> delegate;
@property(nonatomic, assign) int rowToUpdate;

-(void)doDelete:(int)rowToUpdate;
@end
