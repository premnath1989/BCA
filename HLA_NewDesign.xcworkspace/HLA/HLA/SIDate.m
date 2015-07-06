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
        /*
        if (ProspectDOB != NULL) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd/MM/yyyy"];
            msg = [NSString stringWithFormat:@"%@", ProspectDOB];
            NSDate *zzz = [dateFormatter dateFromString:ProspectDOB];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            DBDate = [dateFormatter stringFromDate:zzz];
        }
        else{
            
        }
          */
        
    }
    else{
        
        [_delegate DateSelected:msg :DBDate];
    }
    
    
    
    
    [_delegate CloseWindow];
}
@end
