//
//  HealthQuestPersonType.h
//  iMobile Planner
//
//  Created by kuan on 9/14/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HealthQuestPersonTypeDelegate
-(void)selectedPersonType:(NSString *)thePersonType;
@end

@interface HealthQuestPersonType : UITableViewController {
    id <HealthQuestPersonTypeDelegate> _delegate;
}

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) id <HealthQuestPersonTypeDelegate> delegate;
@property (nonatomic,strong) id requestType;

@end