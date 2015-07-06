//
//  Race.h
//  iMobile Planner
//
//  Created by Administrator on 9/2/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RaceDelegate

-(void)selectedRace:(NSString *)theRace;

@end

@interface Race : UITableViewController{
    id <RaceDelegate> _delegate;
    NSMutableArray *_items;
}
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) id <RaceDelegate> delegate;


@end
