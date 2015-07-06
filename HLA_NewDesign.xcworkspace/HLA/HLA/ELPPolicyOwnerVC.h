//
//  ELPPolicyOwnerVC.h
//  iMobile Planner
//
//  Created by Juliana on 11/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIDate.h"
#import "MainAddPolicyVC.h"
#import "MainExistingPolicyPOListing.h"
@interface ELPPolicyOwnerVC : UITableViewController<SIDateDelegate, MainAddPolicyPOVCDelegate, MainExistingPolicyPOListingDelegate>

- (IBAction)addViewPolicy:(id)sender;
- (IBAction)actionForNoticeA:(id)sender;
- (IBAction)actionForBackDate:(id)sender;
- (IBAction)actionForBackDateBtn:(id)sender;
- (IBAction)viewPolicyAction:(id)sender;
- (IBAction)segmentChange:(id)sender;


@property (strong, nonatomic) IBOutlet UISegmentedControl *q1SC;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
@property (strong, nonatomic) IBOutlet UIButton *viewBtn;
@property (strong, nonatomic) IBOutlet UISegmentedControl *q2aSC;
@property (strong, nonatomic) IBOutlet UISegmentedControl *q2bSC;
@property (strong, nonatomic) IBOutlet UISegmentedControl *q2cSC;
@property (strong, nonatomic) IBOutlet UISegmentedControl *q2dSC;
@property (strong, nonatomic) IBOutlet UIButton *cdwwdBtn;
@property (strong, nonatomic) IBOutlet UIButton *cdkwtcBtn;
@property (strong, nonatomic) IBOutlet UIButton *gcpwndBtn;
@property (strong, nonatomic) IBOutlet UIButton *gcpkwtcBtn;
@property (strong, nonatomic) IBOutlet UILabel *wndLbl;
@property (strong, nonatomic) IBOutlet UILabel *kwtcLbl;
@property (strong, nonatomic) IBOutlet UIButton *egcpwndBtn;
@property (strong, nonatomic) IBOutlet UIButton *gcprBtn;
@property (strong, nonatomic) IBOutlet UILabel *backdateLbl;
@property (strong, nonatomic) IBOutlet UIButton *backdateBtn;
- (IBAction)addPolicyAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *backdateCheck;

@property (nonatomic, retain) SIDate *SIDate;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;

@end
