//
//  ChildrenDependents.h
//  iMobile Planner
//
//  Created by Meng Cheong on 9/2/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildrenandDependents.h"
@class ChildrenDependents;

@protocol ChildrenDependentsDelegate <NSObject>
-(void)ChildrenDependentsUpdate:(ChildrenandDependents *)controller rowToUpdate:(int)rowToUpdate;
-(void)ChildrenDependentsDelete:(ChildrenandDependents *)controller rowToUpdate:(int)rowToUpdate;
@end

@interface ChildrenDependents : UIViewController
- (IBAction)doCancel:(id)sender;
- (IBAction)doSave:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *myView;


@property (nonatomic, retain) ChildrenandDependents *ChildrenandDependentsVC;
@property (nonatomic, weak) id <ChildrenDependentsDelegate> delegate;
@property(nonatomic, assign) int rowToUpdate;

-(void)doDelete:(int)rowToUpdate;

@end
