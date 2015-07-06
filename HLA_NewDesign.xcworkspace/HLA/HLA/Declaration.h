//
//  Declaration.h
//  iMobile Planner
//
//  Created by Erza on 6/18/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FMDatabase.h"
#import "FMResultSet.h"

@interface Declaration : UITableViewController {
   // BOOL agreed;
    //BOOL disagreed;
	FMResultSet *results2;
	NSString *stringID;
	NSString *agree;
}

@property (strong, nonatomic) IBOutlet UIButton *btnAgree;
@property (strong, nonatomic) IBOutlet UIButton *btnDisagree;

@property BOOL agreed;
@property BOOL disagreed;

- (IBAction)isAgree:(id)sender;

@end
