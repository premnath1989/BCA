//
//  PDSPagesController.h
//  iMobile Planner
//
//  Created by shawal sapuan on 4/24/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class PagesController;
@protocol PagesControllerDelegate
-(void)getPages:(NSString *)pdsPages;
@end

@interface PagesController : UITableViewController {
    NSString *databasePath;
    sqlite3 *contactDB;
    NSUInteger selectedIndex;
    id <PagesControllerDelegate> _delegate;
}

@property (nonatomic,strong) id <PagesControllerDelegate> delegate;
@property(nonatomic , retain) NSMutableArray *htmlName;
@property(nonatomic , retain) NSMutableArray *pageDesc;

@property(nonatomic , retain) NSString *PDSorSI;
@property(nonatomic , retain) NSString *TradOrEver;
@property(nonatomic, readwrite) int pdfTotalPage;

@end
