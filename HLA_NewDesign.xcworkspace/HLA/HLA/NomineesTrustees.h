//
//  NomineesTrustees.h
//  iMobile Planner
//
//  Created by Erza on 6/18/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainNomineesTrusteesVC.h"
#import "MainTrusteesVC.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
//#import "Nominees.h"


@interface NomineesTrustees : UITableViewController <MainNomineesTrusteesDelegate, MainTrusteesVCProtocol> {
	FMResultSet *results;
	FMResultSet *results2;
	NSString *stringID;
}

- (IBAction)addNominees:(id)sender;
- (IBAction)addTrustee:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *totalShareLbl;
@property (strong, nonatomic) IBOutlet UILabel *trusteeLbl1;
@property (strong, nonatomic) IBOutlet UILabel *trusteeLbl2;
@property (strong, nonatomic) IBOutlet UILabel *Nominee1Lbl;
@property (strong, nonatomic) IBOutlet UILabel *Nominee2Lbl;
@property (strong, nonatomic) IBOutlet UILabel *Nominee3Lbl;
@property (strong, nonatomic) IBOutlet UILabel *Nominee4Lbl;

@end
