//
//  Religion.h
//  iMobile Planner
//
//  Created by Administrator on 9/3/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReligionDelegate

-(void)selectedReligion:(NSString *)setReligion;


@end

@interface Religion : UITableViewController{
    id <ReligionDelegate> _delegate;
    NSMutableArray *_items;
}
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) id <ReligionDelegate> delegate;


@end
