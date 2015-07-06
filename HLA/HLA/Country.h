//
//  Country.h
//  iMobile Planner
//
//  Created by Administrator on 9/6/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CountryDelegate

-(void)SelectedCountry:(NSString *)setCountry;

@end

@interface Country : UITableViewController<UISearchBarDelegate,UISearchDisplayDelegate>{
    id <CountryDelegate> _delegate;
    NSMutableArray *_items;
    NSArray *sorted;
    
}


@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) id <CountryDelegate> delegate;
@property (nonatomic, assign) bool isFiltered;
@property (strong, nonatomic) NSMutableArray* FilteredData;
@end
