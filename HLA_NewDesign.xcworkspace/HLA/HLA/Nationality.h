//
//  Nationality.h
//  iMobile Planner
//
//  Created by shawal sapuan on 7/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NatinalityDelegate

-(void)selectedNationality:(NSString *)selectedNationality;

@end

@interface Nationality : UITableViewController {
    id <NatinalityDelegate> _delegate;
    NSMutableArray *_items;
}

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) id <NatinalityDelegate> delegate;

@end
