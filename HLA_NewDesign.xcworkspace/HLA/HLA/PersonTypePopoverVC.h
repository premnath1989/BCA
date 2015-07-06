//
//  PersonTypePopoverVC.h
//  iMobile Planner
//
//  Created by Juliana on 8/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PersonTypePopoverDelegate <NSObject>

-(void)selectedPersonType:(NSString *)selectedPersonType;

@end

@interface PersonTypePopoverVC : UITableViewController {
	
}
@property (nonatomic, strong) NSMutableArray *PersonType;
@property (nonatomic, weak) id<PersonTypePopoverDelegate> delegate;

@end
