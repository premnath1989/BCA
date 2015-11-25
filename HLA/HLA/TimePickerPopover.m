//
//  TimePickerPopover.m
//  iMobile Planner
//
//  Created by Emi on 9/11/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import "TimePickerPopover.h"

@interface TimePickerPopover ()

@end

@implementation TimePickerPopover
@synthesize outletDate = _outletDate;
@synthesize delegate = _delegate;
@synthesize Time2;

id msg, DBDate;

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
	// Do any additional setup after loading the view.
	
	msg = @"";
    DBDate = @"";
    
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:mm:ss a"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    msg = dateString;
	
    _outletDate.datePickerMode = UIDatePickerModeTime;
    
    if (Time2 != NULL ) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"h:mm:ss a"];
        NSDate *zzz = [dateFormatter dateFromString:Time2];
        [_outletDate setDate:zzz animated:YES ];
		
    }

}
- (void)viewDidUnload
{
    [self setOutletDate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)ActionDate:(id)sender {
    
	
    if (_delegate != Nil) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"h:mm:ss a"];
        
        NSString *pickerDate = [dateFormatter stringFromDate:[_outletDate date]];
        
        msg = [NSString stringWithFormat:@"%@",pickerDate];
        [dateFormatter setDateFormat:@"h:mm:ss a"];
        DBDate = [dateFormatter stringFromDate:[_outletDate date]];
        //[_delegate DateSelected:msg :DBDate];
        
		
    }
    
    
}
- (IBAction)btnClose:(id)sender {
    [_delegate CloseWindow];
}

- (IBAction)btnDone:(id)sender {
	
    if (msg == NULL) {
        
        // if msg = null means user din rotate the date...and choose the default date value
        NSDateFormatter *formatter;
        NSString        *dateString;
        
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"h:mm:ss a"];
        
        dateString = [formatter stringFromDate:[NSDate date]];
        msg = dateString;
        
		[_delegate DateSelected:msg :DBDate];
    }
    else{
        
		
		[_delegate DateSelected:msg :DBDate];
    }
    
    [_delegate CloseWindow];
}

@end
