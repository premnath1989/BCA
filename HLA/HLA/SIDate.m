//
//  SIDate.m
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 10/4/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "SIDate.h"

@interface SIDate ()

@end

@implementation SIDate
@synthesize outletDate = _outletDate;
@synthesize delegate = _delegate;
@synthesize ProspectDOB;

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
    
    msg = @"";
    DBDate = @"";
    
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    msg = dateString;

    
    
  
    
    if (ProspectDOB != NULL ) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        NSDate *zzz = [dateFormatter dateFromString:ProspectDOB];
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
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        
        NSString *pickerDate = [dateFormatter stringFromDate:[_outletDate date]];
        
        msg = [NSString stringWithFormat:@"%@",pickerDate];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
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
        [formatter setDateFormat:@"dd/MM/yyyy"];
        
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
