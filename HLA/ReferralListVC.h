//
//  ReferralListVC.h
//  iMobile Planner
//
//  Created by Emi on 19/11/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReferralListVC : UIViewController


@property (weak, nonatomic) IBOutlet UINavigationBar *titleBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)actionContactList:(id)sender;
- (IBAction)actionActLog:(id)sender;
- (IBAction)btnBack:(id)sender;


@end
