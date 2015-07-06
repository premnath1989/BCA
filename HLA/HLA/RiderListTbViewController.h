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
-(void)RiderPopOverCount: (double)aaCount;
@end

@interface RiderListTbViewController : UITableViewController {
    NSString *databasePath;
    sqlite3 *contactDB;
    NSUInteger selectedIndex;
    NSIndexPath *selectedIndexPath;
    NSMutableArray *RiderGroup1;
    NSMutableArray *RiderGroup2;
    NSMutableArray *RiderGroup3;
    NSMutableArray *RiderGroup4;
    NSMutableArray *RiderGroup5;
    NSMutableArray *RiderGroup6;
    NSMutableArray *RiderGroup7;
    
    NSMutableArray *RiderDescGroup1;
    NSMutableArray *RiderDescGroup2;
    NSMutableArray *RiderDescGroup3;
    NSMutableArray *RiderDescGroup4;
    NSMutableArray *RiderDescGroup5;
    NSMutableArray *RiderDescGroup6;
    NSMutableArray *RiderDescGroup7;
    
    
    id <RiderListTbViewControllerDelegate> _delegate;
}

@property (nonatomic,strong) id <RiderListTbViewControllerDelegate> delegate;
@property (readonly) NSString *selectedCode;
@property (readonly) NSString *selectedDesc;
@property(nonatomic , retain) NSMutableArray *ridCode;
@property(nonatomic , retain) NSMutableArray *ridDesc;
@property(nonatomic , assign) BOOL isRiderListEmpty;

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
@property (nonatomic,strong) id requestLASex;
@property (nonatomic, assign) BOOL requestEDD;
@property (nonatomic, assign,readwrite) int requestCovPeriod;

@property(nonatomic , strong) NSMutableArray *everRiderGroup1;
@property(nonatomic , strong) NSMutableArray *everRiderGroup2;
@property(nonatomic , strong) NSMutableArray *everRiderGroup3;
@property(nonatomic , strong) NSMutableArray *everRiderGroup4;
@property(nonatomic , strong) NSMutableArray *everRiderGroup5;
@property(nonatomic , strong) NSMutableArray *everRiderGroup6;
@property(nonatomic , strong) NSMutableArray *everRiderGroup7;
@property(nonatomic , strong) NSMutableArray *everRiderGroup8;
@property(nonatomic , strong) NSMutableArray *everRiderGroup9;

@property(nonatomic , strong) NSMutableArray *everRiderDescGroup1;
@property(nonatomic , strong) NSMutableArray *everRiderDescGroup2;
@property(nonatomic , strong) NSMutableArray *everRiderDescGroup3;
@property(nonatomic , strong) NSMutableArray *everRiderDescGroup4;
@property(nonatomic , strong) NSMutableArray *everRiderDescGroup5;
@property(nonatomic , strong) NSMutableArray *everRiderDescGroup6;
@property(nonatomic , strong) NSMutableArray *everRiderDescGroup7;
@property(nonatomic , strong) NSMutableArray *everRiderDescGroup8;
@property(nonatomic , strong) NSMutableArray *everRiderDescGroup9;


@property(nonatomic , strong) NSMutableArray *everEddRiderGroup1;
@property(nonatomic , strong) NSMutableArray *everEddRiderGroup2;

@property(nonatomic , strong) NSMutableArray *everEddRiderDescGroup1;
@property(nonatomic , strong) NSMutableArray *everEddRiderDescGroup2;

@property(nonatomic , strong) NSString *requestOccpCode;
@end
