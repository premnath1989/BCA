//
//  IDTypeViewController.h
//  iMobile Planner
//
//  Created by Erza on 6/5/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IDTypeDelegate <NSObject>
@required
-(void)selectedIDType:(NSString *)selectedIDType;
@end
@interface IDTypeViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *IDTypes;
@property (nonatomic, weak) id<IDTypeDelegate> delegate;

@end
