//
//  ActivityViewController.m
//  iMobile Planner
//
//  Created by Emi on 9/11/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ActivityViewController.h"

@interface ActivityViewController ()

@end

@implementation ActivityViewController

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
    // Do any additional setup after loading the view from its nib.
	
	NSLocale *en_US_POSIX = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
	assert(en_US_POSIX != nil);
	
	// The Date
	
	//set the date label correctly
	//format the date to July 9 2013 - MMMM d yyyy
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setLocale:en_US_POSIX];
	[dateFormatter setDateFormat:@"dd-MM-yyyy"];
	NSDate *dateFromString = [[NSDate alloc] init];
	//    dateFromString = [dateFormatter dateFromString:curDate];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"dd MMMM yyyy"];
	NSString *theDate = [dateFormat stringFromDate:dateFromString];
	_lblDate.text = [NSString stringWithFormat:@"Tanggal: %@", theDate];
	
	// The Time
	[NSTimer scheduledTimerWithTimeInterval:1.0
									 target:self
								   selector:@selector(targetMethod:)
								   userInfo:nil
									repeats:YES];
	
	
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

- (IBAction)btnSceduleMeeting:(id)sender {
}

- (IBAction)btnReject:(id)sender {
}

- (IBAction)btnNext:(id)sender {
}

- (IBAction)actionBack:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)actionSave:(id)sender {
}
@end
