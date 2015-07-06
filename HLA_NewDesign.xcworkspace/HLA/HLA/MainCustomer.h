//
//  MainCustomer.h
//  iMobile Planner
//
//  Created by shawal sapuan on 6/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFFTabBarController.h"

@interface MainCustomer : CFFTabBarController<CFFTabBarControllerDelegate>

@property (nonatomic, assign,readwrite) int indexNo;
@property (nonatomic, assign,readwrite) int IndexTab;

@end
