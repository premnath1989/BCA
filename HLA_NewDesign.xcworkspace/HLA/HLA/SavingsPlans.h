//
//  SavingsPlans.h
//  iMobile Planner
//
//  Created by Meng Cheong on 8/26/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExistingSavingAndInvestmentPlans.h"

@class SavingsPlans;

@protocol SavingsPlansDelegate <NSObject>
-(void)ExistingSavingsPlansUpdate:(ExistingSavingAndInvestmentPlans *)controller rowToUpdate:(int)rowToUpdate;
-(void)ExistingSavingsPlansDelete:(ExistingSavingAndInvestmentPlans *)controller rowToUpdate:(int)rowToUpdate;
@end

@interface SavingsPlans : UIViewController
- (IBAction)doSave:(id)sender;
- (IBAction)doCancel:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *myView;


@property (nonatomic, retain) ExistingSavingAndInvestmentPlans *ExistingSavingsPlansVC;
@property (nonatomic, weak) id <SavingsPlansDelegate> delegate;
@property(nonatomic, assign) int rowToUpdate;

-(void)doDelete:(int)rowToUpdate;

@end
