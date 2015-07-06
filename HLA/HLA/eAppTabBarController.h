//
//  FSVerticalTabBarController.h
//  iOS-Platform
//
//  Created by Błażej Biesiada on 4/6/12.
//  Copyright (c) 2012 Future Simple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "eAppTabBar.h"

@class eAppTabBarController, eAppTabBar;


@protocol eAppTabBarControllerDelegate <NSObject>
@optional
- (void)tabBarController:(eAppTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
- (BOOL)tabBarController:(eAppTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;
@end



@interface eAppTabBarController : UIViewController <UITableViewDelegate>
{
    NSUInteger clickIndex;
}

@property (nonatomic, readwrite, assign) id<eAppTabBarControllerDelegate> delegate;
@property (nonatomic, readwrite, strong) eAppTabBar *tabBar;
@property (nonatomic, readwrite, copy) NSArray *viewControllers;
@property (nonatomic, readwrite, assign) UIViewController *selectedViewController;
@property (nonatomic, readwrite, assign) NSUInteger selectedIndex;
@property (nonatomic, readwrite, assign) CGFloat tabBarWidth;


- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated;
- (void)updateTabBar;
-(void)Test;
-(void)Reset;

@end
