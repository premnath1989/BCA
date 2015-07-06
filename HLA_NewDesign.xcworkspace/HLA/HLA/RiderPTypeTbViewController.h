//
//  RiderPTypeTbViewController.h
//  HLA
//
//  Created by shawal sapuan on 8/29/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class RiderPTypeTbViewController;
@protocol RiderPTypeTbViewControllerDelegate
-(void)PTypeController:(RiderPTypeTbViewController *)inController didSelectCode:(NSString *)code seqNo:(NSString *)seq
				  desc:(NSString *)desc andAge:(NSString *)aage andOccp:(NSString *)aaOccp andSex:(NSString *)aaSex;
@end

@interface RiderPTypeTbViewController : UITableViewController {
    NSString *databasePath;
    sqlite3 *contactDB;
    NSUInteger selectedIndex;
    id <RiderPTypeTbViewControllerDelegate> _delegate;
}

@property (nonatomic,strong) NSString *SINoPlan;
@property (nonatomic,strong) NSString *TradOrEver;
@property (nonatomic,strong) id <RiderPTypeTbViewControllerDelegate> delegate;
@property (readonly) NSString *selectedCode;
@property (readonly) NSString *selectedSeqNo;
@property (readonly) NSString *selectedDesc;
@property (readonly) NSString *selectedAge;
@property (readonly) NSString *selectedOccp;
@property (readonly) NSString *selectedSex;
@property(nonatomic , retain) NSMutableArray *ptype;
@property(nonatomic , retain) NSMutableArray *seqNo;
@property(nonatomic , retain) NSMutableArray *desc;
@property(nonatomic , retain) NSMutableArray *age;
@property(nonatomic , retain) NSMutableArray *Occp;
@property(nonatomic , retain) NSMutableArray *sex;
@property (nonatomic,strong) id requestSINo;

-(id)initWithString:(NSString *)stringCode str:(NSString *)getTradOrEver;

@end
