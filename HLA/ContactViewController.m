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
#import "Act1VC.h"


@interface ContactViewController ()

@end

@implementation ContactViewController

@synthesize frame;
@synthesize myScrollView;
@synthesize SIDate = _SIDate;
@synthesize SIDatePopover = _SIDatePopover;
@synthesize txtNama, txtTempatLahir, txtKodeCabang;


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
	
	txtNama.delegate = self;
	txtTempatLahir.delegate = self;
	txtKodeCabang.delegate = self;
	
	[myScrollView setScrollEnabled:YES];
    [myScrollView setContentSize:CGSizeMake(1024, 704)];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideHandler:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
	
	
	NSLocale *en_US_POSIX = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
	assert(en_US_POSIX != nil);
	// The Date
	
	//set the date label correctly
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setLocale:en_US_POSIX];
	[dateFormatter setDateFormat:@"dd-MM-yyyy"];
	NSDate *dateFromString = [[NSDate alloc] init];
	//    dateFromString = [dateFormatter dateFromString:curDate];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"dd MMM yyyy"];
	NSString *theDate = [dateFormat stringFromDate:dateFromString];
	_lblDate.text = theDate;
	
	//the day
	
	dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"EEEE"];
	NSString *week = [dateFormatter stringFromDate:dateFromString];
	_lblDay.text = week;
	
	
	// The Time
	[NSTimer scheduledTimerWithTimeInterval:1.0
									 target:self
								   selector:@selector(targetMethod:)
								   userInfo:nil
									repeats:YES];
	
	
	NSUserDefaults *Cdefaults = [NSUserDefaults standardUserDefaults];
	NSString *TitleSetting = [Cdefaults stringForKey:@"TitleSetting"];
	
	if ([TitleSetting isEqualToString:@"Update Contact"]) {
		[self loadData];
	}
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	
	[self.view addGestureRecognizer:tap];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
}


-(void)targetMethod:(id)sender
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeStyle: NSDateFormatterShortStyle];
	
	NSString *currentTime = [dateFormatter stringFromDate: [NSDate date]];
	_lblTime.text = currentTime;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ActionConActivity:(id)sender {
	
	NSUserDefaults *Cdefaults = [NSUserDefaults standardUserDefaults];
	NSInteger SalesActivity_ID = [Cdefaults integerForKey:@"SalesActivity_ID"];
	
	NSLog(@"SA: %d %d", SalesActivity_ID, LastID);
	
	if (SalesActivity_ID != 0) {
		
		Act1VC *controller = [[Act1VC alloc]
							  initWithNibName:@"Act1VC"
							  bundle:nil];
		[self presentViewController:controller animated:NO completion:Nil];
	}
	else {
		UIAlertView *AAlert;
		AAlert = [[UIAlertView alloc] initWithTitle:@" "
											message:@"Please save contact first before proceed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[AAlert show];
	}
	


}

- (IBAction)ActionSchedule:(id)sender {
	
	NSUserDefaults *Cdefaults = [NSUserDefaults standardUserDefaults];
	NSInteger SalesActivity_ID = [Cdefaults integerForKey:@"SalesActivity_ID"];
	
	[Cdefaults setObject:[NSString stringWithFormat:@"Contact"] forKey:@"ScheduleFor"];
	[Cdefaults synchronize];
	
	NSLog(@"SA: %d %d", SalesActivity_ID, LastID);
	
	if (SalesActivity_ID != 0) {
		ScheduleViewController *V2 = [[ScheduleViewController alloc]
									  initWithNibName:@"ScheduleViewController"
									  bundle:nil];
		
		V2.modalPresentationStyle = UIModalPresentationFormSheet;
		V2.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
		[self presentViewController:V2 animated:YES completion:nil];
		V2.view.superview.frame = CGRectMake(0, 0, 441, 416);
		V2.view.superview.center = self.view.center;
	}
	else {
		UIAlertView *AAlert;
		AAlert = [[UIAlertView alloc] initWithTitle:@" "
												  message:@"Please save contact first before proceed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[AAlert show];
	}
}


- (IBAction)ActionHome:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableList" object:self];
	[self dismissViewControllerAnimated:YES completion:Nil];

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
	
	NSUserDefaults *Cdefaults = [NSUserDefaults standardUserDefaults];
	NSString *TitleSetting = [Cdefaults stringForKey:@"TitleSetting"];
	NSInteger SalesActivity_ID = [Cdefaults integerForKey:@"SalesActivity_ID"];
	
	NSString *sqlQuery = @"";
	
	if ([TitleSetting isEqualToString:@"Update Contact"]) {
		sqlQuery = [NSString stringWithFormat:@"UPDATE SalesAct_contact SET NIP = \"%@\", KodeCabang = \"%@\", KCU = \"%@\", NamaReferral = \"%@\", NamaCabang = \"%@\", Kanwil = \"%@\", SumberReferal = \"%@\", TipeReferral = \"%@\", NamaLengkap = \"%@\", JenisKelamin = \"%@\", TanggalLahir = \"%@\", TempatLahir = \"%@\", NoKTP_KITAS = \"%@\", Warganegara = \"%@\", NoHP = \"%@\", UpdateAt = %@ where ID = %d", _txtNIP.text, txtKodeCabang.text, _txtKCU.text, _TxtNamaReferral.text, _txtNamaCabang.text, _txtKanwil.text, SumberReferal, TpeReferral, txtNama.text, Gender, dateDOB, txtTempatLahir.text, _txtNoKTP.text, Warganegara, _txtNoHP.text, @"datetime(\"now\", \"+8 hour\")", SalesActivity_ID];
	}
	else {
		sqlQuery = [NSString stringWithFormat:@"INSERT INTO SalesAct_contact (NIP, KodeCabang, KCU, NamaReferral, NamaCabang, Kanwil, SumberReferal, TipeReferral, NamaLengkap, JenisKelamin, TanggalLahir, TempatLahir, NoKTP_KITAS, Warganegara, NoHP, CreateAt) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", %@)", _txtNIP.text, txtKodeCabang.text, _txtKCU.text, _TxtNamaReferral.text, _txtNamaCabang.text, _txtKanwil.text, SumberReferal, TpeReferral, txtNama.text, Gender, dateDOB, txtTempatLahir.text, _txtNoKTP.text, Warganegara, _txtNoHP.text, @"datetime(\"now\", \"+8 hour\")"];
	}
	
	BOOL success = [db executeUpdate: sqlQuery];
	
	UIAlertView *SuccessAlert;
	
	if (success) {
		SuccessAlert = [[UIAlertView alloc] initWithTitle:@" "
												  message:@"A new record successfully inserted." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[SuccessAlert show];
		
		if (![TitleSetting isEqualToString:@"Update Contact"]) {
			
			FMResultSet *result = [db executeQuery:@"select last_insert_rowid() from SalesAct_contact"];
			while ([result next]) {
				LastID = [result intForColumn:@"last_insert_rowid()"];
			}
			
			sqlQuery = [NSString stringWithFormat:@"INSERT INTO SalesAct_ActLogList (SalesActivity_ID, StateAct, Status, CreateAt) VALUES (%d, \"%@\", \"%@\", %@)", LastID, @"0", @"Created", @"datetime(\"now\", \"+8 hour\")"];
			[db executeUpdate: sqlQuery];
			
			[Cdefaults setObject:[NSNumber numberWithInt:LastID] forKey:@"SalesActivity_ID"];
			[Cdefaults setObject:[NSString stringWithFormat:@"0"] forKey:@"StateAct"];
			[Cdefaults synchronize];
			
		}
		
	}
	else {
		SuccessAlert = [[UIAlertView alloc] initWithTitle:@" "
												  message:@"Failed insert." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[SuccessAlert show];
	}
	
	[db close];
	
}

-(void)loadData {
	
	
	NSUserDefaults *Cdefaults = [NSUserDefaults standardUserDefaults];
	NSInteger SalesActivity_ID = [Cdefaults integerForKey:@"SalesActivity_ID"];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsPath = [paths objectAtIndex:0];
	NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
	
	FMDatabase *db = [FMDatabase databaseWithPath:path];
	
	[db open];
	
	NSString *strSQL = [NSString stringWithFormat:@"select * from SalesAct_contact where ID = %d", SalesActivity_ID];
	
	FMResultSet *result = [db executeQuery:strSQL];
    while ([result next]) {
		
		_txtNIP.text = [result stringForColumn:@"NIP"];
		txtKodeCabang.text = [result stringForColumn:@"KodeCabang"];
		_txtKCU.text = [result stringForColumn:@"KCU"];
		_TxtNamaReferral.text = [result stringForColumn:@"NamaReferral"];
		_txtNamaCabang.text = [result stringForColumn:@"NamaCabang"];
		_txtKanwil.text = [result stringForColumn:@"Kanwil"];
		NSString *SumberReferal = [result stringForColumn:@"SumberReferal"];
		if ([SumberReferal isEqualToString:@""]) {
			_segSumberReferral.selectedSegmentIndex = 0;
		}
		else
			_segSumberReferral.selectedSegmentIndex = 1;
		
		NSString *tipe = [result stringForColumn:@"TipeReferral"];
		if ([tipe isEqualToString:@""]) {
			_SegTipeReferral.selectedSegmentIndex = 0;
		}
		else
			_SegTipeReferral.selectedSegmentIndex = 1;

	
		txtNama.text = [result stringForColumn:@"NamaLengkap"];
		NSString *gender = [result stringForColumn:@"JenisKelamin"];
		if ([gender isEqualToString:@""]) {
			_segJenisKelamin.selectedSegmentIndex = 0;
		}
		else
			_segJenisKelamin.selectedSegmentIndex = 1;

		NSString *DOB = [result stringForColumn:@"TanggalLahir"];
		
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ; 
		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"]; 
		
		NSDate *date = [dateFormatter dateFromString:DOB];
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"dd/MM/yyyy"];;
		
		DOB = [dateFormatter stringFromDate:date];
		
		_txtTanggalLahir.text = DOB;
		
		txtTempatLahir.text = [result stringForColumn:@"TempatLahir"];
		_txtNoKTP.text = [result stringForColumn:@"NoKTP_KITAS"];
		NSString *warganegara = [result stringForColumn:@"Warganegara"];
		if ([warganegara isEqualToString:@""]) {
			_segWarganegara.selectedSegmentIndex = 0;
		}
		else
			_segWarganegara.selectedSegmentIndex = 1;

		_txtNoHP.text = [result stringForColumn:@"NoHP"];
		
    }
	
	[db close];
	
	
	
}

-(void) ClearValue {
	
	_txtNIP.text = @"";
	txtKodeCabang.text = @"";
	_txtKCU.text= @"";
	_TxtNamaReferral.text= @"";
	_txtNamaCabang.text= @"";
	_txtKanwil.text= @"";
	txtNama.text= @"";
	txtTempatLahir.text= @"";
	_txtNoKTP.text= @"";
	_txtNoHP.text = @"";
	_txtTanggalLahir.text = @"";
	
	_segSumberReferral.selectedSegmentIndex = 0;
	_SegTipeReferral.selectedSegmentIndex = 0;
	_segJenisKelamin.selectedSegmentIndex = 0;
	_segWarganegara.selectedSegmentIndex = 0;
	
}

- (IBAction)DOBUpdate:(id)sender {
	 
	[self resignFirstResponder];
    [self.view endEditing:YES];
	
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
//	_txtTanggalLahir.text = dateString;
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    
    if (_SIDate == Nil) {
        
        self.SIDate = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIDate"];
        _SIDate.delegate = self;
        self.SIDatePopover = [[UIPopoverController alloc] initWithContentViewController:_SIDate];
    }
    
    [self.SIDatePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.SIDatePopover presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    
    
    dateFormatter = Nil;
    dateString = Nil, mainStoryboard = nil;

	
}

-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
    _txtTanggalLahir.text = strDate;
}

-(void)CloseWindow
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [self.SIDatePopover dismissPopoverAnimated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	
//	if (textField == txtNama)
//		[myScrollView setContentOffset:CGPointMake(0,400) animated:YES];
//	else if (textField == txtTempatLahir)
//		[myScrollView setContentOffset:CGPointMake(0,450) animated:YES];
	
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
	
	if (textField == txtKodeCabang)
		_txtNamaCabang.text = @"Jakarta";
	
	
}

#pragma mark - keyboard

-(void)hideKeyboard{
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
    
}

- (void) keyboardWillHideHandler:(NSNotification *)notification {
//    self.navigationItem.rightBarButtonItem.enabled = TRUE;
}

-(void)keyboardDidShow:(NSNotificationCenter *)notification
{
    self.myScrollView.frame = CGRectMake(0, -44, 1024, 748-352);
    self.myScrollView.contentSize = CGSizeMake(1024, 900);
    
    CGRect textFieldRect = [activeField frame];
    textFieldRect.origin.y += 20;
    [self.myScrollView scrollRectToVisible:textFieldRect animated:YES];

	
}

-(void)keyboardDidHide:(NSNotificationCenter *)notification
{
    self.myScrollView.frame = CGRectMake(0, 50, 1024, 704);

}


@end
