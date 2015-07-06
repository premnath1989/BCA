//
//  Declaration.h
//  iMobile Planner
//
//  Created by Erza on 6/18/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FMDatabase.h"
#import "FMResultSet.h"

@interface Declaration : UITableViewController {
   // BOOL agreed;
    //BOOL disagreed;
	FMResultSet *results2;
	NSString *stringID;
	NSString *agree;
	NSString *POBox,*OfficeForeign,*ResidenceForeign,*ResidenceForeign_POBOX,*OfficeForeign_POBOX;
}

@property (strong, nonatomic) IBOutlet UIButton *btnAgree;
@property (strong, nonatomic) IBOutlet UIButton *btnDisagree;
//indidual
@property (strong, nonatomic) IBOutlet UIButton *btnIndidual10a;
@property (strong, nonatomic) IBOutlet UIButton *btnIndidual10b;
@property (strong, nonatomic) IBOutlet UIButton *btnIndidual10c;
//company
@property (strong, nonatomic) IBOutlet UIButton *btnCompany10a;
@property (strong, nonatomic) IBOutlet UIButton *btnCompany10a1;

@property (strong, nonatomic) IBOutlet UIButton *btnCompany10b;
@property (strong, nonatomic) IBOutlet UIButton *btnCompany10c;
@property (strong, nonatomic) IBOutlet UIButton *btnCompany10d;

@property (strong, nonatomic) IBOutlet UITextView *FATCATV;
@property (strong, nonatomic) IBOutlet UITextField *GIINTF;

@property (strong, nonatomic) IBOutlet UIButton *btnCompany10e;
@property (strong, nonatomic) IBOutlet UIButton *btnCompany10e1;
@property (strong, nonatomic) IBOutlet UIButton *btnCompany10e2;

@property (strong, nonatomic) IBOutlet UIButton *btnCompany10f;
@property (strong, nonatomic) IBOutlet NSString *CaseType;
@property (strong, nonatomic) IBOutlet NSString *PersonChoice;
@property (strong, nonatomic) IBOutlet NSString *BizCategoryChoice;
@property (strong, nonatomic) IBOutlet NSString *BizCategoryChoiceQuest4;
@property (strong, nonatomic) IBOutlet NSString *EntityType, *POBox,*OfficeForeign,*ResidenceForeign,*ResidenceForeign_POBOX,*OfficeForeign_POBOX;


@property BOOL agreed;
@property BOOL disagreed;
@property BOOL QuestionSElectOne;

- (IBAction)isAgree:(id)sender;

- (IBAction)isIndidual10a:(id)sender;
- (IBAction)isIndidual10b:(id)sender;
- (IBAction)isIndidual10c:(id)sender;

- (IBAction)isCompany10a:(id)sender;
- (IBAction)isCompany10a1:(id)sender;

- (IBAction)isCompany10b:(id)sender;
- (IBAction)isCompany10c:(id)sender;
- (IBAction)isCompany10d:(id)sender;

- (IBAction)isCompany10e:(id)sender;
- (IBAction)isCompany10e1:(id)sender;
- (IBAction)isCompany10e2:(id)sender;

- (IBAction)isCompany10f:(id)sender;

@end
