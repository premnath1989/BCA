//
//  ScheduleViewController.m
//  iMobile Planner
//
//  Created by Emi on 3/11/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ScheduleViewController.h"
#import "FMDatabase.h"
#import "TimePicker.h"
#import "SIDate.h"


@interface ScheduleViewController ()


@end

@implementation ScheduleViewController
bool isDate;
bool isTime;

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
	isTime = NO;
	isDate = NO;
	
	_txtStatus.text = @"NEW";
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TimeSelect) name:@"TimeSelect" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionBack:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)actionTanggal:(id)sender {
	
	isTime = NO;
	isDate = YES;
	
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

- (IBAction)actionWaktu:(id)sender {
	
	isTime = YES;
	isDate = NO;
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
//	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    
    if (_TimePicker == Nil) {
        
//        self.timePickerPopover = [mainStoryboard instantiateViewControllerWithIdentifier:@"TimePicker"];
		TimePicker *timePicker = [[TimePicker alloc]
									  initWithNibName:@"TimePicker"
									  bundle:nil];
		
		
//		TimePicker.delegate = self;
		
	
        self.timePickerPopover = [[UIPopoverController alloc] initWithContentViewController:timePicker];
    }
    
    [self.timePickerPopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.timePickerPopover presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionLeft animated:NO];
    
    
    dateFormatter = Nil;
    dateString = Nil;
	
}

-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
	
	NSLog(@"StrDate: %@", strDate);
	if (isDate)
		_txtTanggal.text = strDate;
	else if (isTime) 
		_txtWaktu.text = strDate;
	
	isTime = NO;
	isDate = NO;
	
}

-(void)TimeSelected:(NSString *)strTime :(NSString *)dbDate {
	_txtWaktu.text = strTime;
}


-(void)TimeSelect {
	
	NSUserDefaults *TimeSelect = [NSUserDefaults standardUserDefaults];
	NSString *myString = [TimeSelect stringForKey:@"TimeStr"];
	_txtWaktu.text = myString;
	
	[self.timePickerPopover dismissPopoverAnimated:YES];
	
}
-(void)CloseWindow
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [self.SIDatePopover dismissPopoverAnimated:YES];
	[self.timePickerPopover dismissPopoverAnimated:YES];
}


- (IBAction)actionSave:(id)sender {
	
	NSUserDefaults *Cdefaults = [NSUserDefaults standardUserDefaults];
	NSInteger SalesActivity_ID = [Cdefaults integerForKey:@"SalesActivity_ID"];
	NSString *type = [Cdefaults stringForKey:@"ScheduleFor"];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsPath = [paths objectAtIndex:0];
	NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
	
	FMDatabase *db = [FMDatabase databaseWithPath:path];
	
	[db open];
	
	NSString *sqlQuery = [NSString stringWithFormat:@"INSERT INTO SalesAct_LogActivity (SalesActivity_ID, Lokasi, Tanggal, Waktu, Catatan, Activity, Status, CreateAt) VALUES (%d, \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", %@)", SalesActivity_ID, _txtLokasi.text, _txtTanggal.text, _txtWaktu.text, _txtCatatan.text, type, _txtStatus.text ,@"datetime(\"now\", \"+8 hour\")"];
	
	BOOL success = [db executeUpdate: sqlQuery];
	
	UIAlertView *SuccessAlert;
	if (success) {
		SuccessAlert = [[UIAlertView alloc] initWithTitle:@" "
												  message:@"Record success." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[SuccessAlert show];
	}

	[db close];
	
	
}



- (IBAction)actionStatus:(id)sender {
}



@end
