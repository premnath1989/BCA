//
//  IssuingBankPopoverVC.h
//  iMobile Planner
//
//  Created by Juliana on 8/30/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@protocol IssuingBankDelegate <NSObject>

-(void)selectedIssuingBank:(NSString *)selectedIssuingBank;
@end

@interface IssuingBankPopoverVC : UITableViewController {
	//db
	NSString *databasePath;
    sqlite3 *contactDB;
	const char *dbpath;
	sqlite3_stmt *statement;
	//
}
@property (nonatomic, strong) NSMutableArray *IssuingBank;
@property (nonatomic, weak) id<IssuingBankDelegate> delegate;

@end
