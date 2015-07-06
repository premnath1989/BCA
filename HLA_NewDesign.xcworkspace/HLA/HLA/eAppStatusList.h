//
//  eAppStatusList.h
//  iMobile Planner
//
//  Created by shawal sapuan on 7/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol eAppStatusListDelegate
-(void)selectedStatus:(NSString *)theStatus;
@end

@interface eAppStatusList : UITableViewController {
    id <eAppStatusListDelegate> _delegate;
}

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) id <eAppStatusListDelegate> delegate;

@end
