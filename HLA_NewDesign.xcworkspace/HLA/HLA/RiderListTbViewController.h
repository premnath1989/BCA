//
//  RiderListTbViewController.h
//  HLA
//
//  Created by shawal sapuan on 8/29/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class RiderListTbViewController;
@protocol RiderListTbViewControllerDelegate
-(void)RiderListController:(RiderListTbViewController *)inController didSelectCode:(NSString *)code desc:(NSString *)desc;
@end

@interface RiderListTbViewController : UITableViewController {
    NSString *databasePath;
    sqlite3 *contactDB;
    NSUInteger selectedIndex;
    id <RiderListTbViewControllerDelegate> _delegate;
}

@property (nonatomic,strong) id <RiderListTbViewControllerDelegate> delegate;
@property (readonly) NSString *selectedCode;
@property (readonly) NSString *selectedDesc;
@property(nonatomic , retain) NSMutableArray *ridCode;
@property(nonatomic , retain) NSMutableArray *ridDesc;

//request from previous controller
@property (nonatomic,strong) id requestPtype;
@property (nonatomic,strong) id requestPlan;
@property (nonatomic, assign,readwrite) int requestSeq;
@property (nonatomic, assign,readwrite) int requestOccpClass;
@property (nonatomic, assign,readwrite) int requestAge;
@property (nonatomic,strong) id requestOccpCat;
@property (nonatomic,strong) id TradOrEver;
@property (nonatomic,strong) id requestSmoker;
@property (nonatomic,strong) id request2ndSmoker;
@property (nonatomic,strong) id requestPayorSmoker;
@property (nonatomic,strong) id requestOccpCPA;
@end
