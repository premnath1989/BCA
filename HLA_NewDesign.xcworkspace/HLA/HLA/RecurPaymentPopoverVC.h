//
//  RecurPaymentPopoverVC.h
//  iMobile Planner
//
//  Created by Juliana on 8/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@protocol RecurPaymentDelegate <NSObject>

-(void)selectedRecurPaymentType:(NSString *)selectedRecurPaymentType;
@end

@interface RecurPaymentPopoverVC : UITableViewController {
	//db
	NSString *databasePath;
    sqlite3 *contactDB;
	const char *dbpath;
	sqlite3_stmt *statement;
	//
}
@property (nonatomic, strong) NSMutableArray *RecurPaymentType;
@property (nonatomic, weak) id<RecurPaymentDelegate> delegate;

@end
