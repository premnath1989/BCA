//
//  AddPolicyLA2TableVC.h
//  iMobile Planner
//
//  Created by Juliana on 11/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIDate.h"

@interface AddPolicyLA2TableVC : UITableViewController<SIDateDelegate, UITextFieldDelegate, UIAlertViewDelegate> {
	int pn;
	int pc;
	int pcm;
	int counter;
	//	id<AddPolicyTableVCDelegate> delegate;
	
}

@property (nonatomic, retain) SIDate *SIDate;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;
@property (strong, nonatomic) NSMutableArray *arrayPolicy;
@property (strong, nonatomic) IBOutlet UILabel *personTypeLbl;
@property (strong, nonatomic) IBOutlet UITextField *compNameTF;
@property (strong, nonatomic) IBOutlet UITextField *lifeTermTF;
@property (strong, nonatomic) IBOutlet UITextField *accidentTF;
@property (strong, nonatomic) IBOutlet UITextField *criticalIllnessTF;
@property (strong, nonatomic) IBOutlet UITextField *dailyHospitalIncomeTF;
@property (strong, nonatomic) IBOutlet UITextField *dateIssuedTF;
@property (strong, nonatomic) IBOutlet UILabel *dateIssuedLbl;
//@property (weak, nonatomic) id<AddPolicyTableVCDelegate> delegate;
- (IBAction)actionForPersonType:(id)sender;
- (IBAction)actionForDateIssued:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong, nonatomic) IBOutlet UITableViewCell *row2;
@property BOOL click;
@property BOOL change;

@end
