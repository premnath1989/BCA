//
//  IDTypeViewController.h
//  iMobile Planner
//
//  Created by Erza on 6/5/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>


@protocol IDTypeDelegate <NSObject>
@required
//- (void)selectedIDType:(NSString *)selectedIDType;
- (void)IDTypeDescSelected:(NSString *) IDTypeDesc;
- (void)IDTypeCodeSelected:(NSString *) IDTypeCode;
@end

@interface IDTypeViewController : UITableViewController {
	NSMutableArray *_IDTypeDesc;
    NSMutableArray *_IDTypeCode;
    NSString *databasePath;
    sqlite3 *contactDB;
    id<IDTypeDelegate> _delegate;
}
@property (nonatomic, strong) NSMutableArray *IDTypes;
@property (nonatomic, retain) NSMutableArray *IDTypeDesc;
@property (nonatomic, retain) NSMutableArray *IDTypeCode;
@property (nonatomic, strong) id<IDTypeDelegate> delegate;
@property (nonatomic, weak) id requestType;
@property (nonatomic, weak) id IDSelect;
@property(retain) NSIndexPath* lastIndexPath;

@end
