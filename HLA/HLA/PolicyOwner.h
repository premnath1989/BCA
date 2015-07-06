//
//  PolicyOwner.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/14/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "ListingTbViewController.h"
#import "PolicyOwnerData.h"
#import "ClearData.h"
 

@interface PolicyOwner : UITableViewController<UITableViewDelegate, ListingTbViewControllerDelegate, PolicyOwnerDataDelegate, SubDetailsDelegate>
{
    int row;
    NSString *databasePath;
    sqlite3 *contactDB;
    BOOL hide_1LA;
    BOOL hide_2LA;
    BOOL hide_payor;
    BOOL hide_newPO;
    UIPopoverController *_prospectPopover;
    ListingTbViewController *_ProspectList;
    
}
- (IBAction)doClose:(id)sender;

@property (nonatomic, retain) UIPopoverController *prospectPopover;

@property (nonatomic, retain) ListingTbViewController *ProspectList;
@property (strong, nonatomic) NSMutableArray* ProspectTableData;

@property (strong, nonatomic) IBOutlet UILabel *lbl_1LA;
@property (strong, nonatomic) IBOutlet UILabel *lbl_2LA;
@property (strong, nonatomic) IBOutlet UILabel *lbl_payor;
@property (strong, nonatomic) IBOutlet UILabel *lbl_NewPO;
@property (strong, nonatomic) IBOutlet UILabel *lbl_1LAStatus;
@property (strong, nonatomic) IBOutlet UILabel *lbl_2LAStatus;
@property (strong, nonatomic) IBOutlet UILabel *lbl_PayorStatus;
@property (strong, nonatomic) IBOutlet UILabel *lbl_1LA_2;
@property (strong, nonatomic) IBOutlet UILabel *lbl_2LA_2;
@property (strong, nonatomic) IBOutlet UILabel *lbl_payor_2;
@property (strong, nonatomic) IBOutlet UILabel *lbl_POName;


@property (strong, nonatomic) IBOutlet UILabel *po1;
@property (strong, nonatomic) IBOutlet UILabel *po2;
@property (strong, nonatomic) IBOutlet UILabel *po3;
@property (strong, nonatomic) IBOutlet UILabel *po4;

@property (nonatomic, strong) UILabel *proposalNo_display;

@property (weak, nonatomic) IBOutlet UILabel *lifeAssuredStatus;
@property (weak, nonatomic) IBOutlet UILabel *POStatus;

@property (weak, nonatomic) IBOutlet UIImageView *lifeAssuredPO;
@property (weak, nonatomic) IBOutlet UIImageView *PO;

@property (weak, nonatomic) IBOutlet UILabel *POName;
@property (weak, nonatomic) IBOutlet UITableViewCell *POcell;

@property (nonatomic, copy) NSString *IDTypeCodeSelected;
@end
