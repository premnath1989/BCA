//
//  MainClient.h
//  iMobile Planner
//
//  Created by shawal sapuan on 6/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientTabBarController.h"

@interface MainClient : ClientTabBarController<ClientTabBarControllerDelegate>

@property (nonatomic, assign,readwrite) int indexNo;
@property (nonatomic, assign,readwrite) int IndexTab;

@end
