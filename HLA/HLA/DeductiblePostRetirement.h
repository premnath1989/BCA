//
//  DeductiblePostRetirement.h
//  iMobile Planner
//
//  Created by Heng on 6/6/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class DeductiblePostRetirement;
@protocol DeductiblePostRetirementDelegate
-(void)deductViewRetirement:(DeductiblePostRetirement *)inController didSelectItem:(NSString *)item desc:(NSString *)itemdesc;
@end

@interface DeductiblePostRetirement : UITableViewController{
    NSString *databasePath;
    sqlite3 *contactDB;
    NSUInteger selectedIndex;
    id <DeductiblePostRetirementDelegate> _delegate;
}

@property (nonatomic,strong) id <DeductiblePostRetirementDelegate> delegate;
@property (readonly) NSString *selectedItem;
@property (readonly) NSString *selectedItemDesc;
@property(nonatomic , retain) NSMutableArray *itemValue;
@property(nonatomic , retain) NSMutableArray *itemDesc;

@property (nonatomic,strong) id requestCondition;
@property (nonatomic, assign,readwrite) double requestSA;
@property (nonatomic,strong) id requestOption;

-(id)initWithString:(NSString *)stringCode andSumAss:(NSString *)strSum andOption:(NSString *)strOpt;

@end
