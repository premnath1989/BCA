//
//  ViewInsuredRecord.h
//  iMobile Planner
//
//  Created by kuan on 9/19/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewInsuredRecordDelegate <NSObject>


@end

@interface ViewInsuredRecord : UITableViewController

{
    id <ViewInsuredRecordDelegate> _delegate;
}

@property (strong, nonatomic) IBOutlet UITableView *tableRecord;

- (IBAction)btnClose:(id)sender;
-(void)reloadTableRecord;
- (void) setDelegate:(id)delegate;

@end
