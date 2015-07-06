//
//  RacePopoverViewController.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RacePopoverViewControllerDelegate <NSObject>
@required
-(void)selectedRace:(NSString *)selectedRace;
@end

@interface RacePopoverViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *IDTypes;
@property (nonatomic, weak) id<RacePopoverViewControllerDelegate> delegate;

@end
