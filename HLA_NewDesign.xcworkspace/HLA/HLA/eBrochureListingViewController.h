//
//  eBrochureListingViewController.h
//  HLA Ipad
//
//  Created by infoconnect on 1/16/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface eBrochureListingViewController : UITableViewController

@property (strong,nonatomic) NSMutableArray *dataItems;

- (IBAction)btnClose:(id)sender;

@end
