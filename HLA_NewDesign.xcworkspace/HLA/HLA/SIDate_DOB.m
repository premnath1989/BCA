//
//  SIDate.m
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 10/4/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "SIDate_DOB.h"
#import "DataClass.h"

@interface SIDate_DOB(){
    DataClass *obj;
}

@end

@implementation SIDate_DOB
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear:");
    
    //NSLog(@"WWWW%d",self.rowToUpdate);
    
    //_childDOB.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1DOB"];
    
    NSLog(@"PPPPP%@",self.receivedDOB);
    
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    [fmtDate setDateFormat:@"dd/MM/yyyy"];
    //NSDate *zzz = [fmtDate dateFromString:@""];
    //[_outletDate setDate:zzz animated:YES ];

    if (self.rowToUpdate == 0){
        if (![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1DOB"] isEqualToString:@""]){
            NSDate *zzz = [fmtDate dateFromString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1DOB"]];
            [_outletDate setDate:zzz animated:YES ];
        }
    }
    else if (self.rowToUpdate == 1){
        if (![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2DOB"] isEqualToString:@""]){
            NSDate *zzz = [fmtDate dateFromString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2DOB"]];
            [_outletDate setDate:zzz animated:YES ];
        }
    }
    else if (self.rowToUpdate == 2){
        if (![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3DOB"] isEqualToString:@""]){
            NSDate *zzz = [fmtDate dateFromString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3DOB"]];
            [_outletDate setDate:zzz animated:YES ];
        }
    }
    else if (self.rowToUpdate == 3){
        if (![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4DOB"] isEqualToString:@""]){
            NSDate *zzz = [fmtDate dateFromString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4DOB"]];
            [_outletDate setDate:zzz animated:YES ];
        }
    }
    else if (self.rowToUpdate == 4){
        if (![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5DOB"] isEqualToString:@""]){
            NSDate *zzz = [fmtDate dateFromString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5DOB"]];
            [_outletDate setDate:zzz animated:YES ];
        }
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    obj=[DataClass getInstance];

    /*
    if (ProspectDOB != NULL ) {
        NSLog(@"sadfas");
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        NSDate *zzz = [dateFormatter dateFromString:ProspectDOB];
        [_outletDate setDate:zzz animated:YES ];
         
    }
    else{
        NSLog(@"1111");
    }
     */
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
                
        NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
        [fmtDate setDateFormat:@"dd/MM/yyyy"];
        
        msg = [NSString stringWithFormat:@"%@",[fmtDate stringFromDate:[NSDate date]]];
        [fmtDate setDateFormat:@"yyyy-MM-dd"];
        //DBDate = [dateFormatter stringFromDate:[_outletDate date]];
        [_delegate DateSelected:msg :@""];
        
    }
    else{
        
        NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
        [fmtDate setDateFormat:@"dd/MM/yyyy"];

        
        
        NSString *start = msg; //dob
        NSString *end = [NSString stringWithFormat:@"%@",[fmtDate stringFromDate:[NSDate date]]]; //today
        
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        [f setDateFormat:@"dd/mm/yyyy"];
        NSDate *startDate = [f dateFromString:start];
        NSDate *endDate = [f dateFromString:end];

        
        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components1 = [gregorianCalendar components:NSDayCalendarUnit
                                                            fromDate:startDate
                                                              toDate:endDate
                                                             options:0];
        //NSLog(@"Age: %d", [components1 day]);
    
        if ([components1 day] < 0){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Date should not greater than current date."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            //alert.tag = 1000;
            [alert show];
            alert = Nil;
            return;
        }
        
        
        
        if (self.rowToUpdate == 0){
            [[obj.CFFData objectForKey:@"SecC"] setValue:msg forKey:@"Childen1DOB"];

        }
        else if (self.rowToUpdate == 1){
            [[obj.CFFData objectForKey:@"SecC"] setValue:msg forKey:@"Childen2DOB"];
        }
        else if (self.rowToUpdate == 2){
            [[obj.CFFData objectForKey:@"SecC"] setValue:msg forKey:@"Childen3DOB"];
        }
        else if (self.rowToUpdate == 3){
            [[obj.CFFData objectForKey:@"SecC"] setValue:msg forKey:@"Childen4DOB"];
        }
        else if (self.rowToUpdate == 4){
            [[obj.CFFData objectForKey:@"SecC"] setValue:msg forKey:@"Childen5DOB"];
        }
        
        
        [_delegate DateSelected:msg :DBDate];
    }
    
    
    
    
    [_delegate CloseWindow];
}

- (IBAction)doClear:(id)sender {
    
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
        [_delegate ClearDateSelected:msg :@""];
        
    }
    else{
        
        [_delegate ClearDateSelected:msg :@""];
    }
    
    
    
    
    [_delegate ClearCloseWindow];
}
@end
