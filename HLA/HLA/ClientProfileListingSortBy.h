//
//  ClientProfileListingSortBy.h
//  iMobile Planner
//
//  Created by kuan on 12/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClientProfileListingDelegate
- (void)SortBySelected:(NSMutableArray *)SortBySelected;
@end

@interface ClientProfileListingSortBy : UITableViewController

{
    NSMutableArray *_SortBy;
    
    id<ClientProfileListingDelegate> _delegate;
}

@property (nonatomic, retain) NSMutableArray *SortBy;
@property (nonatomic, retain) NSMutableArray *SelectedSortBy;
@property (nonatomic, strong) id<ClientProfileListingDelegate> delegate;
@property(retain) NSIndexPath* lastIndexPath;
@end




  