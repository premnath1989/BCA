//
//  RelationshipPopoverViewController.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RelationshipPopoverViewControllerDelegate <NSObject>
@required
-(void)selectedRship:(NSString *)selectedRship;
@end


@interface RelationshipPopoverViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *IDTypes;
@property (nonatomic, weak) id<RelationshipPopoverViewControllerDelegate> delegate;

@property(nonatomic, assign) int rowToUpdate;


@end
