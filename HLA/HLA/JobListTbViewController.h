//
//  JobListTbViewController.h
//  HLA
//
//  Created by shawal sapuan on 9/25/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class JobListTbViewController;
@protocol JobListTbViewControllerDelegate
-(void)joblist:(JobListTbViewController *)inController selectCode:(NSString *)aaCode selectDesc:(NSString *)aaDesc;
@end

@interface JobListTbViewController : UITableViewController {
    NSString *databasePath;
    sqlite3 *contactDB;
    NSUInteger selectedIndex;
    id <JobListTbViewControllerDelegate> _delegate;
}

@property(nonatomic , retain) NSMutableArray *occDesc;
@property(nonatomic , retain) NSMutableArray *occCode;
@property (nonatomic,strong) id <JobListTbViewControllerDelegate> delegate;
@property (readonly) NSString *selectedCode;
@property (readonly) NSString *selectedDesc;

@end
