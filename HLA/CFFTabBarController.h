//
//  FSVerticalTabBarController.h
//  iOS-Platform
//
//  Created by Błażej Biesiada on 4/6/12.
//  Copyright (c) 2012 Future Simple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFFTabBar.h"

@class CFFTabBarController, CFFTabBar;


@protocol CFFTabBarControllerDelegate <NSObject>
@optional
- (void)tabBarController:(CFFTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
- (BOOL)tabBarController:(CFFTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;
@end



@interface CFFTabBarController : UIViewController <UITableViewDelegate>
{
    NSUInteger clickIndex;
}

@property (nonatomic, readwrite, assign) id<CFFTabBarControllerDelegate> delegate;
@property (nonatomic, readwrite, strong) CFFTabBar *tabBar;
@property (nonatomic, readwrite, copy) NSArray *viewControllers;
@property (nonatomic, readwrite, assign) UIViewController *selectedViewController;
@property (nonatomic, readwrite, assign) NSUInteger selectedIndex;
@property (nonatomic, readwrite, assign) CGFloat tabBarWidth;


- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated;
- (void)updateTabBar;
-(void)Test;
-(void)Reset;

@end
