//
//  ExistingPolicyListing.h
//  iMobile Planner
//
//  Created by Juliana on 9/19/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainAddPolicyVC.h"
//#import "AddPolicyTableVC.h"
//@class AddPolicyTableVC;
//@protocol AddPolicyTableVCDelegate;
@interface ExistingPolicyListing : UITableViewController<UITableViewDelegate, UITableViewDataSource> {
//	AddPolicyTableVC *add;
	NSMutableArray *viewArr;
//	AddPolicyTableVC *add;
}
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;

@end
