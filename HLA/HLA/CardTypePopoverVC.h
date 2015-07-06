//
//  CardTypePopoverVC.h
//  iMobile Planner
//
//  Created by Juliana on 8/30/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@protocol CardTypeDelegate <NSObject>

-(void)selectedCardType:(NSString *)selectedCardType;
@end

@interface CardTypePopoverVC : UITableViewController {
	//db
	NSString *databasePath;
    sqlite3 *contactDB;
	const char *dbpath;
	sqlite3_stmt *statement;
	//
}
@property (nonatomic, strong) NSMutableArray *CardType;
@property (nonatomic, weak) id<CardTypeDelegate> delegate;

@end
