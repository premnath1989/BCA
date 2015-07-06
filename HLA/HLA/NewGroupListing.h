//
//  NewGroupListing.h
//  iMobile Planner
//
//  Created by Erza on 11/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewGroupListing : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBtn;
@property (strong, nonatomic) IBOutlet UINavigationBar *naviBar;
@property (strong, nonatomic) IBOutlet UIButton *leftBtn;
@property (strong, nonatomic) IBOutlet UIButton *rightBtn;
@property (strong, nonatomic) IBOutlet UITableView *nonMemberTV;
@property (strong, nonatomic) IBOutlet UITableView *memberTV;

@property (strong, nonatomic) NSDictionary *data;

- (IBAction)doneBtnPressed:(id)sender;
- (IBAction)rightBtnPressed:(id)sender;
- (IBAction)leftBtnPressed:(id)sender;
@end
