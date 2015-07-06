//
//  MaritalStatus.h
//  iMobile Planner
//
//  Created by Administrator on 9/3/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MaritalStatusDelegate

-(void)selectedMaritalStatus:(NSString *)status;

@end



@interface MaritalStatus : UITableViewController{
    
    id <MaritalStatusDelegate> _delegate;
    NSMutableArray *_items;
}

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) id <MaritalStatusDelegate> delegate;


@end
