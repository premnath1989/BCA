//
//  HLValueList.h
//  iMobile Planner
//
//  Created by Heng on 10/1/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HLValueListDelegate
- (void)PopulateTextBox:(NSString *)Selected;
@end

@interface HLValueList : UITableViewController{
    id <HLValueListDelegate> _delegate;
    NSMutableArray *item;
}

@property (nonatomic, strong) id <HLValueListDelegate> delegate;

@end

