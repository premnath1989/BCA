//
//  Act1VC.m
//  iMobile Planner
//
//  Created by Emi on 17/11/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import "Act1VC.h"
#import "ScheduleViewController.h"
#import "ViewControllerActivity.h"
#import "FMDatabase.h"

@interface Act1VC ()

@end

@implementation Act1VC

int state;

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
	
//	NSUserDefaults *Cdefaults = [NSUserDefaults standardUserDefaults];
//	state = [[Cdefaults stringForKey:@"StateAct"] integerValue];
//	state = state+1;
	
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
	[dateFormat setDateFormat:@"dd MMMM yyyy"];
	NSString *theDate = [dateFormat stringFromDate:dateFromString];
	_lblDate.text = theDate;
	
	// The Time
	[NSTimer scheduledTimerWithTimeInterval:1.0
									 target:self
								   selector:@selector(targetMethod:)
								   userInfo:nil
									repeats:YES];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangeState) name:@"ChangeState" object:nil];
	[self ChangeState];
	
    
}

-(void)targetMethod:(id)sender
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeStyle: NSDateFormatterShortStyle];
	
	NSString *currentTime = [dateFormatter stringFromDate: [NSDate date]];
	_lblTime.text = currentTime;
}

-(void)ChangeState {
	
	//Change activity status
	
	UIImage *YelImg = [UIImage imageNamed: @"button_round_yellow.png"];
	UIImage *BluImg = [UIImage imageNamed: @"button_round_navy.png"];
	
	NSUserDefaults *Cdefaults = [NSUserDefaults standardUserDefaults];
	state = [[Cdefaults stringForKey:@"StateAct"] integerValue];
	state = state+1;

	_descLbl.text = @"Video/presentation/image/link button that explain in the activity";
	_btnReject.enabled = true;
	_btnSchedule.enabled = true;
	_btnNext.title = @"NEXT";
	_btnNext.enabled = TRUE;
	
	if (state == 1 || state == 0) {
		_BarTitle.title = @"Activity: Introduction";
		[_Act1 setBackgroundImage:YelImg forState:UIControlStateNormal];
		[_Act2 setBackgroundImage:BluImg forState:UIControlStateNormal];
		[_Act3 setBackgroundImage:BluImg forState:UIControlStateNormal];
		[_Act4 setBackgroundImage:BluImg forState:UIControlStateNormal];
		[_Act5 setBackgroundImage:BluImg forState:UIControlStateNormal];
	}
	else if (state == 2) {
		_BarTitle.title = @"Activity: FNA";
		[_Act1 setBackgroundImage:YelImg forState:UIControlStateNormal];
		[_Act2 setBackgroundImage:YelImg forState:UIControlStateNormal];
		[_Act3 setBackgroundImage:BluImg forState:UIControlStateNormal];
		[_Act4 setBackgroundImage:BluImg forState:UIControlStateNormal];
		[_Act5 setBackgroundImage:BluImg forState:UIControlStateNormal];
	}
	else if (state == 3) {
		_BarTitle.title = @"Activity: RPQ";
		[_Act1 setBackgroundImage:YelImg forState:UIControlStateNormal];
		[_Act2 setBackgroundImage:YelImg forState:UIControlStateNormal];
		[_Act3 setBackgroundImage:YelImg forState:UIControlStateNormal];
		[_Act4 setBackgroundImage:BluImg forState:UIControlStateNormal];
		[_Act5 setBackgroundImage:BluImg forState:UIControlStateNormal];
	}
	else if (state == 4) {
		_BarTitle.title = @"Activity: Illustration";
		[_Act1 setBackgroundImage:YelImg forState:UIControlStateNormal];
		[_Act2 setBackgroundImage:YelImg forState:UIControlStateNormal];
		[_Act3 setBackgroundImage:YelImg forState:UIControlStateNormal];
		[_Act4 setBackgroundImage:YelImg forState:UIControlStateNormal];
		[_Act5 setBackgroundImage:BluImg forState:UIControlStateNormal];
	}
	else if (state == 5) {
		_BarTitle.title = @"Activity: Application";
		_btnNext.title = @"SUBMIT";
		_btnNext.enabled = TRUE;
		[_Act1 setBackgroundImage:YelImg forState:UIControlStateNormal];
		[_Act2 setBackgroundImage:YelImg forState:UIControlStateNormal];
		[_Act3 setBackgroundImage:YelImg forState:UIControlStateNormal];
		[_Act4 setBackgroundImage:YelImg forState:UIControlStateNormal];
		[_Act5 setBackgroundImage:YelImg forState:UIControlStateNormal];
	}
	else if (state == 6) {
		_BarTitle.title = @"Activity: Completed";
		_descLbl.text = @"Completed";
		_btnReject.enabled = false;
		_btnSchedule.enabled = false;
		_btnNext.title = @"SUBMIT";
		_btnNext.enabled = FALSE;
		[_Act1 setBackgroundImage:YelImg forState:UIControlStateNormal];
		[_Act2 setBackgroundImage:YelImg forState:UIControlStateNormal];
		[_Act3 setBackgroundImage:YelImg forState:UIControlStateNormal];
		[_Act4 setBackgroundImage:YelImg forState:UIControlStateNormal];
		[_Act5 setBackgroundImage:YelImg forState:UIControlStateNormal];
		
	}
	else if (state == 100) {
		_BarTitle.title = @"Activity";
		_descLbl.text = @"REJECT";
		_btnReject.enabled = false;
		_btnSchedule.enabled = false;
		[_Act1 setBackgroundImage:BluImg forState:UIControlStateNormal];
		[_Act2 setBackgroundImage:BluImg forState:UIControlStateNormal];
		[_Act3 setBackgroundImage:BluImg forState:UIControlStateNormal];
		[_Act4 setBackgroundImage:BluImg forState:UIControlStateNormal];
		[_Act5 setBackgroundImage:BluImg forState:UIControlStateNormal];
		
	}
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)btnBack:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableList" object:self];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"reloadActLog" object:self];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnSave:(id)sender {
	
	ViewControllerActivity *V2 = [[ViewControllerActivity alloc]
								  initWithNibName:@"ViewControllerActivity"
								  bundle:nil];
	
	V2.modalPresentationStyle = UIModalPresentationFormSheet;
    V2.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:V2 animated:YES completion:nil];
    V2.view.superview.frame = CGRectMake(0, 0, 477, 398);
    V2.view.superview.center = self.view.center;
	
	
//	NSUserDefaults *Cdefaults = [NSUserDefaults standardUserDefaults];
//	state = [[Cdefaults stringForKey:@"StateAct"] integerValue];
//	
//	[self ChangeState];

}

- (IBAction)btnSchedule:(id)sender {
	
	NSUserDefaults *Cdefaults = [NSUserDefaults standardUserDefaults];

	NSString *title = _BarTitle.title;
	
	if ([title isEqualToString:@"Activity: Application"]) {
		title = @"Application";
	}
	else if ([title isEqualToString:@"Activity: Introduction"]) {
		title = @"Introduction";
	}
	else if ([title isEqualToString:@"Activity: FNA"]) {
		title = @"FNA";
	}
	else if ([title isEqualToString:@"Activity: RPQ"]) {
		title = @"RPQ";
	}
	else if ([title isEqualToString:@"Activity: Illustration"]) {
		title = @"Illustration";
	}

	
	[Cdefaults setObject:title forKey:@"ScheduleFor"];
	[Cdefaults synchronize];
	
	
	ScheduleViewController *V2 = [[ScheduleViewController alloc]
								  initWithNibName:@"ScheduleViewController"
								  bundle:nil];
	
	V2.modalPresentationStyle = UIModalPresentationFormSheet;
    V2.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:V2 animated:YES completion:nil];
    V2.view.superview.frame = CGRectMake(0, 0, 441, 416);
    V2.view.superview.center = self.view.center;
}

- (IBAction)btnReject:(id)sender {

	NSString *title = _BarTitle.title;
	
	if ([title isEqualToString:@"Activity: Application"]) {
		title = @"Application";
	}
	else if ([title isEqualToString:@"Activity: Introduction"]) {
		title = @"Introduction";
	}
	else if ([title isEqualToString:@"Activity: FNA"]) {
		title = @"FNA";
	}
	else if ([title isEqualToString:@"Activity: RPQ"]) {
		title = @"RPQ";
	}
	else if ([title isEqualToString:@"Activity: Illustration"]) {
		title = @"Illustration";
	}
	
	
	NSUserDefaults *Cdefaults = [NSUserDefaults standardUserDefaults];
	NSInteger SalesActivity_ID = [Cdefaults integerForKey:@"SalesActivity_ID"];
//	NSString *state = [Cdefaults stringForKey:@"StateAct"];
	
//	int state2 = [state integerValue] + 1;
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsPath = [paths objectAtIndex:0];
	NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
	
	FMDatabase *db = [FMDatabase databaseWithPath:path];
	
	[db open];
	
	NSString *sqlQuery = @"";
	
	sqlQuery = [NSString stringWithFormat:@"UPDATE SalesAct_ActLogList SET StateAct = %@, Status = '%@', UpdateAt = %@ where SalesActivity_ID = %d", @"99", @"REJECT", @"datetime(\"now\", \"+8 hour\")", SalesActivity_ID ];
	
	
	NSString *sqlQuery2 = [NSString stringWithFormat:@"INSERT INTO SalesAct_LogActivity (SalesActivity_ID, Activity, Status, CreateAt) VALUES (%d, \"%@\", \"%@\", %@)", SalesActivity_ID, title, @"Rejected", @"datetime(\"now\", \"+8 hour\")"];
	
	BOOL success = [db executeUpdate: sqlQuery];
	BOOL success2 = [db executeUpdate: sqlQuery2];
	
	if (success && success2) {
		NSLog(@"Success Update");
	}
	
	[db close];
	
	
}
@end
