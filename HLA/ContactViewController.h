//
//  ContactViewController.h
//  iMobile Planner
//
//  Created by Emi on 29/10/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIDate.h"

@interface ContactViewController : UIViewController <UIAlertViewDelegate, UITextFieldDelegate, UITextInputDelegate, UITextViewDelegate, SIDateDelegate> {
	
	UITextField *activeField;
	SIDate *_SIDate;
	UIPopoverController *_SIDatePopover;
	
}
@property(nonatomic) CGRect frame;

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@property (nonatomic, retain) SIDate *SIDate;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;

@property (weak, nonatomic) IBOutlet UIButton *btnDOB;
- (IBAction)DOBUpdate:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblDay;



@property (weak, nonatomic) IBOutlet UITextField *txtNIP;
@property (weak, nonatomic) IBOutlet UITextField *txtKodeCabang;
@property (weak, nonatomic) IBOutlet UITextField *txtKCU;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segSumberReferral;
@property (weak, nonatomic) IBOutlet UITextField *TxtNamaReferral;
@property (weak, nonatomic) IBOutlet UITextField *txtNamaCabang;
@property (weak, nonatomic) IBOutlet UITextField *txtKanwil;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SegTipeReferral;

@property (weak, nonatomic) IBOutlet UITextField *txtNama;
@property (weak, nonatomic) IBOutlet UITextField *txtTanggalLahir;
@property (weak, nonatomic) IBOutlet UITextField *txtNoKTP;
@property (weak, nonatomic) IBOutlet UITextField *txtNoHP;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segJenisKelamin;
@property (weak, nonatomic) IBOutlet UITextField *txtTempatLahir;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segWarganegara;

@property (weak, nonatomic) IBOutlet UIButton *btnActivity;
@property (weak, nonatomic) IBOutlet UIButton *btnSchedule;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnHome;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;

- (IBAction)ActionConActivity:(id)sender;
- (IBAction)ActionSchedule:(id)sender;

- (IBAction)ActionHome:(id)sender;
- (IBAction)ActionSave:(id)sender;

@end
