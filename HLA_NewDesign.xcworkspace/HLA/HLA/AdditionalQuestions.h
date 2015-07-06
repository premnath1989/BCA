//
//  AdditionalQuestions.h
//  iMobile Planner
//
//  Created by shawal sapuan on 6/21/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OccupationList.h"
#import "MainAdditionalQuestInsureds.h"

#import "FMDatabase.h"
#import "FMResultSet.h"


@interface AdditionalQuestions : UITableViewController<OccupationListDelegate, ProcessDataDelegate> {
	FMResultSet *results;
	NSString *occpToEnableSection;
}

@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UITextField *incomeTF;
@property (strong, nonatomic) IBOutlet UILabel *occupationLbl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *insuredSC;
@property (strong, nonatomic) IBOutlet UITableView *insuranceDetailsTblV;
@property (strong, nonatomic) IBOutlet UITextField *reasonTF;
@property (strong, nonatomic) IBOutlet UIButton *btnOccupationPO;
@property (strong, nonatomic) IBOutlet UIButton *addInsurerd;
@property (strong, nonatomic) IBOutlet UIButton *ViewAddInsurerdBtn;

@property (nonatomic, retain) OccupationList *OccupationVC;
@property (nonatomic, retain) UIPopoverController *OccupationPopover;

- (IBAction)actionForOccupationPO:(id)sender;
- (IBAction)AddInsured:(id)sender;
- (IBAction)viewInsured:(id)sender;
- (IBAction)SelectInsured:(id)sender;
@end
