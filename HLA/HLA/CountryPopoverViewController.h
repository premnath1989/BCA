//
//  CountryPopoverViewController.h
//  iMobile Planner
//
//  Created by Juliana on 7/13/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CountryPopoverViewControllerDelegate <NSObject>
@required
-(void)selectedCountry:(NSString *)selectedCountry;
@end

@interface CountryPopoverViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *IDTypes;
@property (nonatomic, weak) id<CountryPopoverViewControllerDelegate> delegate;

@end
