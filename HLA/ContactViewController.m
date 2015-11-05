//
//  ContactViewController.m
//  iMobile Planner
//
//  Created by Emi on 29/10/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ContactViewController.h"
#import "ViewControllerActivity.h"
#import "ScheduleViewController.h"
#import "FMDatabase.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

@synthesize frame;
@synthesize ScrollView;

int LastID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	LastID = 0;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ActionConActivity:(id)sender {
	
	ViewControllerActivity *V2 = [[ViewControllerActivity alloc]
										 initWithNibName:@"ViewControllerActivity"
										 bundle:nil];

	V2.modalPresentationStyle = UIModalPresentationFormSheet;
    V2.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:V2 animated:YES completion:nil];
    V2.view.superview.frame = CGRectMake(0, 0, 491, 170);
    V2.view.superview.center = self.view.center;

}

- (IBAction)ActionSchedule:(id)sender {
	
	ScheduleViewController *V2 = [[ScheduleViewController alloc]
								  initWithNibName:@"ScheduleViewController"
								  bundle:nil];
	
	V2.modalPresentationStyle = UIModalPresentationFormSheet;
    V2.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:V2 animated:YES completion:nil];
    V2.view.superview.frame = CGRectMake(0, 0, 440, 315);
    V2.view.superview.center = self.view.center;
}


- (IBAction)ActionHome:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)ActionSave:(id)sender {
	
	NSString *SumberReferal = @"";
	if (_segSumberReferral.selectedSegmentIndex == 0) {
		SumberReferal = @"Service";
	}
	else if (_segSumberReferral.selectedSegmentIndex == 1) {
		SumberReferal = @"Sales";
	}
	else if (_segSumberReferral.selectedSegmentIndex == 2) {
		SumberReferal = @"Other";
	}
	
	NSString *TpeReferral = @"";
	if (_SegTipeReferral.selectedSegmentIndex == 0) {
		TpeReferral = @"Prospect";
	}
	else if (_SegTipeReferral.selectedSegmentIndex == 1) {
		TpeReferral = @"Suspect";
	}
	
	NSString *Gender = @"";
	if (_segJenisKelamin.selectedSegmentIndex == 0) {
		Gender = @"MALE";
	}
	else if (_segJenisKelamin.selectedSegmentIndex == 1) {
		Gender = @"FEMALE";
	}
	
	NSString *Warganegara = @"";
	if (_segWarganegara.selectedSegmentIndex == 0) {
		Warganegara = @"WNI";
	}
	else if (_segWarganegara.selectedSegmentIndex == 1) {
		Warganegara = @"WNA";
	}
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd/MM/yyyy"];
	NSDate *dateDOB = [[NSDate alloc] init];
	dateDOB = [dateFormatter dateFromString:_txtTanggalLahir.text];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsPath = [paths objectAtIndex:0];
	NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
	
	FMDatabase *db = [FMDatabase databaseWithPath:path];
	
	[db open];
	
	NSString *sqlQuery = [NSString stringWithFormat:@"INSERT INTO SalesAct_contact (NIP, KodeCabang, KCU, NamaReferral, NamaCabang, Kanwil, SumberReferal, TipeReferral, NamaLengkap, JenisKelamin, TanggalLahir, TempatLahir, NoKTP_KITAS, Warganegara, NoHP, CreateAt) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", %@)", _txtNIP.text, _txtKodeCabang.text, _txtKCU.text, _TxtNamaReferral.text, _txtNamaCabang.text, _txtKanwil.text, SumberReferal, TpeReferral, _txtNama.text, Gender, dateDOB, _txtTempatLahir.text, _txtNoKTP.text, Warganegara, _txtNoHP.text, @"datetime(\"now\", \"+8 hour\")"];
	
	BOOL success = [db executeUpdate: sqlQuery];
	
	UIAlertView *SuccessAlert;
	if (success) {
		SuccessAlert = [[UIAlertView alloc] initWithTitle:@" "
												  message:@"A new record successfully inserted." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[SuccessAlert show];
		
		
		FMResultSet *result = [db executeQuery:@"select last_insert_rowid() from SalesAct_contact"];
		while ([result next]) {
			LastID = [result intForColumn:@"last_insert_rowid()"];
		}
		
		NSUserDefaults *Cdefaults = [NSUserDefaults standardUserDefaults];
		
		[Cdefaults setObject:[NSNumber numberWithInt:LastID] forKey:@"SalesActivity_ID"];
		[Cdefaults synchronize];
		
		_btnSave.enabled = FALSE;
		
//		[self ClearValue];
		
	}
	else {
		SuccessAlert = [[UIAlertView alloc] initWithTitle:@" "
												  message:@"Failed insert." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[SuccessAlert show];
	}
	
	[db close];
	
}

-(void) ClearValue {
	
	_txtNIP.text = @"";
	_txtKodeCabang.text = @"";
	_txtKCU.text= @"";
	_TxtNamaReferral.text= @"";
	_txtNamaCabang.text= @"";
	_txtKanwil.text= @"";
	_txtNama.text= @"";
	_txtTempatLahir.text= @"";
	_txtNoKTP.text= @"";
	_txtNoHP.text = @"";
	_txtTanggalLahir.text = @"";
	
	_segSumberReferral.selectedSegmentIndex = 0;
	_SegTipeReferral.selectedSegmentIndex = 0;
	_segJenisKelamin.selectedSegmentIndex = 0;
	_segWarganegara.selectedSegmentIndex = 0;
	
}


@end
