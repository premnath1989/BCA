//
//  GroupClass.h
//  iMobile Planner
//
//  Created by shawal sapuan on 7/7/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GroupDelegate
-(void)selectedGroup:(NSString *)aaGroup;
@end

@interface GroupClass : UITableViewController {
    NSMutableArray *_group;
    id <GroupDelegate> _delegate;
}

@property (nonatomic, strong) NSMutableArray *group;
@property (nonatomic, strong) id <GroupDelegate> delegate;

@end
