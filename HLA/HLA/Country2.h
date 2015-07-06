//
//  Country2.h
//  iMobile Planner
//
//  Created by Emi on 6/5/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Country2Delegate

-(void)Selected2Country:(NSString *)setCountry;

@end

@interface Country2 : UITableViewController<UISearchBarDelegate,UISearchDisplayDelegate>{
    id <Country2Delegate> _delegate;
    NSMutableArray *_items;
    NSArray *sorted;
	NSString *databasePath;
    
}


@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) id <Country2Delegate> delegate;
@property (nonatomic, assign) bool isFiltered;
@property (strong, nonatomic) NSMutableArray* FilteredData;

@end
