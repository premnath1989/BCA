//
//  SelectCFF.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/15/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterMenuCFF.h"
#import "PersonalDataViewController.h"

@class SelectCFF;

@protocol SelectCFFDelegate <NSObject>

//- (void)playerDetailsViewControllerDidCancel:(PlayerDetailsViewController *)controller;
//- (void)playerDetailsViewController:(PlayerDetailsViewController *)controller didAddPlayer:(Player *)player;
-(void)displayCFF;
-(void)updateChecklistCFF;
@end

@interface SelectCFF : UIViewController <UISearchBarDelegate, MasterMenuCFFDelegate, PersonalDetialsViewControllerDelegate>
- (IBAction)doAdd:(id)sender;
- (IBAction)doCancel:(id)sender;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, weak) id <SelectCFFDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *clientData;
@property (strong, nonatomic) NSMutableArray *arrName;
@property (strong, nonatomic) NSMutableArray *arrIdNo;
@property (strong, nonatomic) NSMutableArray *arrDate;
@property (strong, nonatomic) NSMutableArray *arrCFFID;
@property (strong, nonatomic) NSMutableArray *arrStatus;
@property (strong, nonatomic) NSMutableArray *arrClientProfileID;
@property (strong, nonatomic) IBOutlet UINavigationBar *naviBar;

- (void)loadDBData:(int)indexNo clientName:(NSString*)clientName clientID:(NSString*)clientID CFFID:(NSString*)CFFID;
@end
