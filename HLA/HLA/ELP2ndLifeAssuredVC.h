//
//  ELP2ndLifeAssuredVC.h
//  iMobile Planner
//
//  Created by Juliana on 11/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIDate.h"
#import "MainAddPolicyVC.h"
#import "MainExistingPolicyLA2Listing.h"
@interface ELP2ndLifeAssuredVC : UITableViewController<SIDateDelegate, MainAddPolicyLA2VCDelegate, MainExistingPolicyLA2ListingDelegate>
- (IBAction)addViewPolicyAction:(id)sender;
- (IBAction)addPolicyAction:(id)sender;
- (IBAction)actionForNoticeA:(id)sender;
- (IBAction)actionForBackDate:(id)sender;
- (IBAction)viewPolicyAction:(id)sender;
- (IBAction)actionForBackDateBtn:(id)sender;
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
@property (strong, nonatomic) IBOutlet UIButton *gcpwwdBtn;
@property (strong, nonatomic) IBOutlet UIButton *gcpkwtcBtn;
@property (strong, nonatomic) IBOutlet UILabel *wwdLbl;
@property (strong, nonatomic) IBOutlet UILabel *kwtcLbl;
@property (strong, nonatomic) IBOutlet UIButton *egcpwwdBtn;
@property (strong, nonatomic) IBOutlet UIButton *gcprBtn;
@property (strong, nonatomic) IBOutlet UIButton *backdateBtn;
@property (strong, nonatomic) IBOutlet UILabel *backdateLbl;
@property (strong, nonatomic) IBOutlet UIButton *backdateCheck;

@property (nonatomic, retain) SIDate *SIDate;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;

@end
