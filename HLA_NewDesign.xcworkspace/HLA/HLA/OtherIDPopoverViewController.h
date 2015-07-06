//
//  IDTypeViewController.h
//  testViewer
//
//  Created by Meng Cheong on 6/3/13.
//  Copyright (c) 2013 Meng Cheong. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "OtherIDPopoverViewController.h"





@protocol OtherIDPopoverViewControllerDelegate <NSObject>
@required
-(void)selectedOtherIDType:(NSString *)selectedOtherIDType;
//-(void)selectedIDType2:(NSString *)selectedIDType priority:(int)index;
//-(void)selectedIDType3:(NSString *)selectedIDType priority:(int)index;
//-(void)selectedIDType4:(NSString *)selectedIDType priority:(int)index;
//-(void)selectedIDType5:(NSString *)selectedIDType priority:(int)index;
@end

@interface OtherIDPopoverViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *IDTypes;
@property (nonatomic, weak) id<OtherIDPopoverViewControllerDelegate> delegate;
@property (nonatomic, weak) NSString *priorityNumber;
@end