//
//  RiderDeducTb.h
//  HLA Ipad
//
//  Created by shawal sapuan on 11/21/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class RiderDeducTb;
@protocol RiderDeducTbDelegate
-(void)deductView:(RiderDeducTb *)inController didSelectItem:(NSString *)item desc:(NSString *)itemdesc;
@end

@interface RiderDeducTb : UITableViewController {
    NSString *databasePath;
    sqlite3 *contactDB;
    NSUInteger selectedIndex;
    id <RiderDeducTbDelegate> _delegate;
}

@property (nonatomic,strong) id <RiderDeducTbDelegate> delegate;
@property (readonly) NSString *selectedItem;
@property (readonly) NSString *selectedItemDesc;
@property(nonatomic , retain) NSMutableArray *itemValue;
@property(nonatomic , retain) NSMutableArray *itemDesc;

@property (nonatomic,strong) id requestCondition;
@property (nonatomic, assign,readwrite) double requestSA;
@property (nonatomic,strong) id requestOption;

-(id)initWithString:(NSString *)stringCode andSumAss:(NSString *)strSum andOption:(NSString *)strOpt;

@end