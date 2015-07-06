//
//  RiderPlanTb.h
//  HLA Ipad
//
//  Created by shawal sapuan on 11/21/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class RiderPlanTb;
@protocol RiderPlanTbDelegate
-(void)PlanView:(RiderPlanTb *)inController didSelectItem:(NSString *)item desc:(NSString *)itemdesc;
@end

@interface RiderPlanTb : UITableViewController {
    NSString *databasePath;
    sqlite3 *contactDB;
    NSUInteger selectedIndex;
    id <RiderPlanTbDelegate> _delegate;
}



@property (nonatomic,strong) id <RiderPlanTbDelegate> delegate;
@property (readonly) NSString *selectedItem;
@property (readonly) NSString *selectedItemDesc;
@property(nonatomic , retain) NSMutableArray *itemValue;
@property(nonatomic , retain) NSMutableArray *itemDesc;

@property (nonatomic,strong) id requestCondition;
@property (nonatomic,strong) id requestOccpCat;
@property (nonatomic, assign,readwrite) double requestSA;

-(id)initWithString:(NSString *)stringCode andSumAss:(NSString *)valueSum andOccpCat:(NSString *)OccpCat andTradOrEver:(NSString *)TradOrEver getPlanChoose:(NSString *) getPlanChoose;

@end
