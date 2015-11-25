//
//  TimePicker.m
//  iMobile Planner
//
//  Created by Emi on 17/11/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import "TimePicker.h"

@interface TimePicker ()

@end

@implementation TimePicker
@synthesize TimePicker = _TimePicker;
@synthesize Adelegate = _delegate;
@synthesize time;

id msg, DBDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
	msg = @"";
    DBDate = @"";
    
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:mm:ss a"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    msg = dateString;
	
    _TimePicker.datePickerMode = UIDatePickerModeTime;
    
    if (time != NULL ) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"h:mm:ss a"];
        NSDate *zzz = [dateFormatter dateFromString:time];
        [_TimePicker setDate:zzz animated:YES ];
		
    }

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)ActionTime:(id)sender {
	
	if (_delegate != Nil) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"h:mm:ss a"];
        
        NSString *pickerDate = [dateFormatter stringFromDate:[_TimePicker date]];
        
        msg = [NSString stringWithFormat:@"%@",pickerDate];
        [dateFormatter setDateFormat:@"h:mm:ss a"];
        DBDate = [dateFormatter stringFromDate:[_TimePicker date]];
        //[_delegate DateSelected:msg :DBDate];
        
    }
	
}

- (IBAction)ActionDone:(id)sender {
	
//	if (msg == NULL) {
    
        // if msg = null means user din rotate the date...and choose the default date value
        NSDateFormatter *formatter;
        NSString        *dateString;
        
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"h:mm:ss a"];
        
        dateString = [formatter stringFromDate:[NSDate date]];
        msg = dateString;
    
		NSUserDefaults *TimeSelect = [NSUserDefaults standardUserDefaults];
		[TimeSelect setObject:dateString forKey:@"TimeStr"];
	
		[[NSNotificationCenter defaultCenter] postNotificationName:@"TimeSelect" object:nil];
		[_delegate TimeSelected:msg :DBDate];
		
    
    [_delegate CloseWindow];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
