//
//  ContactViewController.h
//  iMobile Planner
//
//  Created by Emi on 29/10/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactViewController : UIViewController <UIAlertViewDelegate>
@property(nonatomic) CGRect frame;

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
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
