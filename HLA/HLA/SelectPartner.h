//
//  SelectPartner.h
//  iMobile Planner
//
//  Created by Meng Cheong on 8/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//
#import "FMDatabase.h"
#import "FMResultSet.h"
#import <UIKit/UIKit.h>

@class SelectPartner;

@protocol SelectPartnerDelegate<NSObject>
- (void)PartnerViewDisplay:(NSString*)type;
- (void)DisplayPartnerCFF:(int)indexNo clientName:(NSString*)clientName clientID:(NSString*)clientID;
@end

@interface SelectPartner : UIViewController<UISearchDisplayDelegate, UISearchBarDelegate>{
    
}
@property (nonatomic, weak) id <SelectPartnerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *clientProfileTableView;

- (IBAction)doCancel:(id)sender;
- (IBAction)doAdd:(id)sender;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) UISearchDisplayController *controller;
@property bool child;
@end
