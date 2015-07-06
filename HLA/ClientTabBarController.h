//
//  FSVerticalTabBarController.h
//  iOS-Platform
//
//  Created by Błażej Biesiada on 4/6/12.
//  Copyright (c) 2012 Future Simple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientTabBar.h"
#import "EditProspect.h"

@class ClientTabBarController, ClientTabBar;


@protocol ClientTabBarControllerDelegate <NSObject>
@optional
- (void)tabBarController:(ClientTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
- (BOOL)tabBarController:(ClientTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;

@end



@interface ClientTabBarController : UIViewController <UITableViewDelegate, EditProspectDelegate>
{
    NSUInteger clickIndex;
	UITableView *ClientTableView;
	NSIndexPath *currentIndexPath;
    NSIndexPath *selectedIndexPath;
	EditProspect *editProspect;
}

@property (nonatomic, readwrite, assign) id<ClientTabBarControllerDelegate> delegate;
@property (nonatomic, readwrite, strong) ClientTabBar *tabBar;
@property (nonatomic, readwrite, copy) NSArray *viewControllers;
@property (nonatomic, readwrite, assign) UIViewController *selectedViewController;
@property (nonatomic, readwrite, assign) NSUInteger selectedIndex;
@property (nonatomic, readwrite, assign) CGFloat tabBarWidth;

@property (nonatomic, readwrite, assign) id<EditProspectDelegate> delegateEdit;
@property (nonatomic, retain) EditProspect *EditProspect;


- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated;
- (void)updateTabBar;
-(void)Test;
-(void)Reset;

@end
