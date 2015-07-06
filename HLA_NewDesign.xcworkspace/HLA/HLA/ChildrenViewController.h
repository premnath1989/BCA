//
//  ChildrenViewController.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/8/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

@class ChildrenViewController;

@protocol ChildrenViewControllerDelegate<NSObject>
- (void)ChildrenViewDisplay;
@end

@interface ChildrenViewController : UITableViewController
@property (nonatomic, weak) id <ChildrenViewControllerDelegate> delegate;
- (IBAction)childrenViewCancel:(id)sender;
- (IBAction)childrenViewDone:(id)sender;
@end
