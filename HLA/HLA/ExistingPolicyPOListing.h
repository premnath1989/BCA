//
//  ExistingPolicyPOListing.h
//  iMobile Planner
//
//  Created by Juliana on 11/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainAddPolicyPOVC.h"

@interface ExistingPolicyPOListing : UITableViewController {
	NSMutableArray *viewArr;
}

@property (strong, nonatomic) IBOutlet UITableView *mainTableView;

@end
