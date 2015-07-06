//
//  ExistingPoliciesPersonType.h
//  iMobile Planner
//
//  Created by Juliana on 11/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FMDatabase.h"
#import "FMResultSet.h"

@protocol EPPersonTypeDelegate
-(void)selectedPersonType:(NSString *)thePersonType;
@end

@interface ExistingPoliciesPersonType : UITableViewController {
	id <EPPersonTypeDelegate> delegate;
	FMResultSet *results;
	NSString *stringID;
	NSString *code;
	NSString *desc;
}

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) id <EPPersonTypeDelegate> delegate;
@end
