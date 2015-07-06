//
//  FullyReducePaidUpPopover.h
//  iMobile Planner
//
//  Created by Erza on 1/21/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FullyReducePaidUpPopover : UITableViewController

@property (strong, nonatomic) IBOutlet UISegmentedControl *paidUpSeg;
@property (strong, nonatomic) IBOutlet UITextField *yearTxt;
@property (strong, nonatomic) NSString *riderCode;
- (IBAction)paidUpChg:(id)sender;

@end
