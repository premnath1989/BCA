//
//  StatusViewController.h
//  iMobile Planner
//
//  Created by Meng Cheong on 9/18/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StatusViewControllerDelegate <NSObject>
@required
-(void)selectedStatusType:(NSString *)selectedStatusType;
@end

@interface StatusViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *StatusTypes;
@property (nonatomic, weak) id<StatusViewControllerDelegate> delegate;
@property (nonatomic, weak) NSString *priorityNumber;
@property (nonatomic, weak) NSString *currentVal;
@end
