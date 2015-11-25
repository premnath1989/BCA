//
//  ScheduleViewController.h
//  iMobile Planner
//
//  Created by Emi on 3/11/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimePicker.h"
#import "SIDate.h"

@interface ScheduleViewController : UIViewController <TimePickerDelegate, UIAlertViewDelegate, UITextFieldDelegate, UITextInputDelegate, UITextViewDelegate, SIDateDelegate>{

	TimePicker *_TimePicker;
	UIPopoverController *_timePickerPopover;
	SIDate *_SIDate;
	UIPopoverController *_SIDatePopover;

}

@property (nonatomic, retain) TimePicker *TimePicker;
@property (nonatomic, retain) UIPopoverController *timePickerPopover;
@property (nonatomic, retain) SIDate *SIDate;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *BtnBack;
@property (weak, nonatomic) IBOutlet UITextField *txtTanggal;
@property (weak, nonatomic) IBOutlet UIButton *BtnTanggal;
@property (weak, nonatomic) IBOutlet UITextField *txtWaktu;
@property (weak, nonatomic) IBOutlet UIButton *btnWaktu;
@property (weak, nonatomic) IBOutlet UITextView *txtCatatan;
@property (weak, nonatomic) IBOutlet UITextField *txtLokasi;
@property (weak, nonatomic) IBOutlet UITextField *txtStatus;
@property (weak, nonatomic) IBOutlet UIButton *btnStatus;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;


- (IBAction)actionBack:(id)sender;
- (IBAction)actionTanggal:(id)sender;
- (IBAction)actionWaktu:(id)sender;
- (IBAction)actionSave:(id)sender;
- (IBAction)actionStatus:(id)sender;





@end
