//
//  CardTypePopoverVCDC.h
//  iMobile Planner
//
//  Created by Premnath on 12/9/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@protocol CardTypePopoverVCDC <NSObject>


-(void)selectedCardType:(NSString *)selectedCardType;
@end

@interface CardTypePopoverVCDC : UITableViewController {
	//db
	NSString *databasePath;
    sqlite3 *contactDB;
	const char *dbpath;
	sqlite3_stmt *statement;
	//
}
@property (nonatomic, strong) NSMutableArray *CardType;
@property (nonatomic, weak) id<CardTypePopoverVCDC> delegate;

@end
