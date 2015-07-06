//
//  eAppStatusListforSubmitted.h
//  iMobile Planner
//
//  Created by Basvi on 7/08/14.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol eAppStatusListforSubmittedDelegate
-(void)selectedStatus:(NSString *)theStatus;
@end

@interface eAppStatusListforSubmitted : UITableViewController {
    id <eAppStatusListforSubmittedDelegate> _delegate;
}

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) id <eAppStatusListforSubmittedDelegate> delegate;

@end
