//
//  OccupationList.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 10/1/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>


@protocol OccupationListDelegate
- (void)OccupDescSelected:(NSString *) OccupDesc;
- (void)OccupCodeSelected:(NSString *) OccupCode;
- (void)OccupClassSelected:(NSString *) OccupClass;
@end

@interface OccupationList : UITableViewController<UISearchBarDelegate, UISearchDisplayDelegate>
{
    NSMutableArray *_OccupDesc;
    NSMutableArray *_OccupCode;
    NSMutableArray *_OccupClass;
    NSString *databasePath;
    sqlite3 *contactDB;
    id<OccupationListDelegate> _delegate;
}

@property (nonatomic, retain) NSMutableArray *OccupDesc;
@property (nonatomic, retain) NSMutableArray *OccupCode;
@property (nonatomic, retain) NSMutableArray *OccupClass;
@property (nonatomic, strong) id<OccupationListDelegate> delegate;
@property(retain) NSIndexPath* lastIndexPath;
@property (strong, nonatomic) NSMutableArray* FilteredData;
@property (strong, nonatomic) NSMutableArray* FilteredCode;
@property (strong, nonatomic) NSMutableArray* FilteredClass;
@property (nonatomic, assign) bool isFiltered;


@end
