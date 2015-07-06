//
//  siListingSortBy.h
//  HLA
//
//  Created by Md. Nazmus Saadat on 9/26/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol siListingDelegate
- (void)SortBySelected:(NSMutableArray *)SortBySelected;
@end

@interface siListingSortBy : UITableViewController{
    NSMutableArray *_SortBy;
    
    id<siListingDelegate> _delegate;
}

@property (nonatomic, retain) NSMutableArray *SortBy;
@property (nonatomic, retain) NSMutableArray *SelectedSortBy;
@property (nonatomic, strong) id<siListingDelegate> delegate;
@property(retain) NSIndexPath* lastIndexPath;
@end
