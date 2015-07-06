//
//  ListingTbViewController.h
//  HLA
//
//  Created by shawal sapuan on 8/7/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class ListingTbViewController;
@protocol ListingTbViewControllerDelegate

-(void)listing:(ListingTbViewController *)inController didSelectIndex:(NSString *)aaIndex andName:(NSString *)aaName andDOB:(NSString *)aaDOB andGender:(NSString *)aaGender andOccpCode:(NSString *)aaCode andSmoker:(NSString *)aaSmoker andMaritalStatus:(NSString *)aaMaritalStatus;
 

@end

@interface ListingTbViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate> {
    NSString *databasePath;
    sqlite3 *contactDB;
    NSUInteger selectedIndex;
    id <ListingTbViewControllerDelegate> _delegate;
    NSMutableArray *_indexNo;
    NSMutableArray *_NameList;
    NSMutableArray *_DOBList;
    NSMutableArray *_GenderList;
    NSMutableArray *_OccpCodeList;
    NSMutableArray *_SmokerList;
    NSMutableArray *_OtherIDList;
    NSMutableArray *_IDList;
    NSMutableArray *_OtherIDTypeList;
    NSMutableArray *_MaritalStatus;
}

@property (nonatomic,strong) id <ListingTbViewControllerDelegate> delegate;
@property(nonatomic , retain) NSMutableArray *indexNo;
@property(nonatomic , retain) NSMutableArray *NameList;
@property(nonatomic , retain) NSMutableArray *DOBList;
@property(nonatomic , retain) NSMutableArray *GenderList;
@property(nonatomic , retain) NSMutableArray *OccpCodeList;
@property(nonatomic , retain) NSMutableArray *SmokerList;
@property(nonatomic , retain) NSMutableArray *OtherIDList;
@property(nonatomic , retain) NSMutableArray *IDList;
@property(nonatomic , retain) NSMutableArray *OtherIDTypeList;
@property(nonatomic , retain) NSMutableArray *MaritalStatus;

@property (strong, nonatomic) NSMutableArray *FilteredIndex;
@property (strong, nonatomic) NSMutableArray *FilteredName;
@property (strong, nonatomic) NSMutableArray *FilteredDOB;
@property (strong, nonatomic) NSMutableArray *FilteredGender;
@property (strong, nonatomic) NSMutableArray *FilteredOccp;
@property (strong, nonatomic) NSMutableArray *FilteredSmoker;
@property (strong, nonatomic) NSMutableArray *FilteredOtherID;
@property (strong, nonatomic) NSMutableArray *FilteredID;
@property (strong, nonatomic) NSMutableArray *FilteredOtherIDType;
@property (strong, nonatomic) NSMutableArray *FilteredMaritalStatus;
@property (nonatomic, assign) bool isFiltered;
@property (nonatomic, assign) bool needFiltered;
@property (strong, nonatomic) NSString *SIOrEAPPS;
@property (strong, nonatomic) NSString *blacklistedIndentificationNos;
@property (strong, nonatomic) NSString *blacklistedOtherIDType;
@property (strong, nonatomic) NSString *blacklistedOtherID;
@end
