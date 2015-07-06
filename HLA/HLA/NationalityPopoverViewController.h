//
//  NationalityPopoverViewController.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NationalityPopoverViewControllerDelegate <NSObject>
@required
-(void)selectedNationality:(NSString *)selectedNationality;
@end

@interface NationalityPopoverViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *IDTypes;
@property (nonatomic, weak) id<NationalityPopoverViewControllerDelegate> delegate;

@end
