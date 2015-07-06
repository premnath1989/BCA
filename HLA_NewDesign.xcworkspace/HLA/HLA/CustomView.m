//
//  CustomView.m
//  iMobile Planner
//
//  Created by infoconnect on 10/10/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "CustomView.h"

@interface CustomView ()

@end

@implementation CustomView
@synthesize outletBtn1,outletBtn2,outletBtn3,outletBtn4,MsgBtn1,MsgBtn2,MsgBtn3,MsgBtn4, lblMsg, LabelMsg, Input1, Input2;
@synthesize  delegate = _delegate;

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
	
	self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
	self.view.opaque = NO;
	
	if ([LabelMsg isEqual:@""]) {
		lblMsg.text = @"";
	}
	else{
		lblMsg.text = [LabelMsg substringFromIndex:2];
	}
	
	if ([MsgBtn1 isEqual:@""]) {
		outletBtn1.hidden = TRUE;
	}
	else{
		[outletBtn1 setTitle:[@"" stringByAppendingFormat:@"%@", [MsgBtn1 substringFromIndex:2 ]] forState:UIControlStateNormal ];
		outletBtn1.tag = 1;
	}
	
	if ([MsgBtn2 isEqual:@""]) {
		outletBtn2.hidden = TRUE;
	}
	else{
		[outletBtn2 setTitle:[@"" stringByAppendingFormat:@"%@", [MsgBtn2 substringFromIndex:2 ]] forState:UIControlStateNormal ];
		outletBtn1.tag = 2;
	}
	
	if ([MsgBtn3 isEqual:@""]) {
		outletBtn3.hidden = TRUE;
	}
	else{
		[outletBtn3 setTitle:[@"" stringByAppendingFormat:@"%@", [MsgBtn3 substringFromIndex:2 ]] forState:UIControlStateNormal ];
		outletBtn1.tag = 3;
	}
	
	if ([MsgBtn4 isEqual:@""]) {
		outletBtn4.hidden = TRUE;
	}
	else{
		[outletBtn4 setTitle:[@"" stringByAppendingFormat:@"%@", [MsgBtn4 substringFromIndex:2 ]] forState:UIControlStateNormal ];
		outletBtn1.tag = 4;
	}
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
	[self setOutletBtn1:nil];
	[self setOutletBtn2:nil];
	[self setOutletBtn3:nil];
	[self setOutletBtn4:nil];
	[self setLblMsg:nil];
	[self setLblMsg:nil];
	[self setOutletBtn1:nil];
	[self setOutletBtn2:nil];
	[self setOutletBtn3:nil];
	[self setOutletBtn4:nil];
	[super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (interfaceOrientation==UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        return YES;
    
    return NO;
}











- (IBAction)ActionBtn1:(id)sender {
	if ([LabelMsg isEqualToString:@""]) {
		[_delegate ReturnSelection:[MsgBtn1 substringToIndex:2 ] andMsg:[MsgBtn1 substringFromIndex:2 ]  ];
	}
	else{
		if ([[LabelMsg substringToIndex:2 ] isEqualToString:@"X1"] || [[LabelMsg substringToIndex:2 ] isEqualToString:@"X2"] ) {
			[_delegate ReturnSelection:[MsgBtn1 substringToIndex:2 ] andMsg:Input1];
		}
		else if([[LabelMsg substringToIndex:2 ] isEqualToString:@"X3"]){
			[_delegate ReturnSelection:[MsgBtn1 substringToIndex:2 ] andMsg:[Input1 stringByAppendingFormat:@",%@", Input2 ] ];
		}
		else{
			[_delegate ReturnSelection:[MsgBtn1 substringToIndex:2 ] andMsg:[MsgBtn1 substringFromIndex:2 ]  ];
		}
	}
	
	
}

- (IBAction)ActionBtn2:(id)sender {
	[_delegate ReturnSelection:[MsgBtn2 substringToIndex:2 ] andMsg:[MsgBtn2 substringFromIndex:2 ]  ];
	//[self dismissModalViewControllerAnimated:YES];
	
}

- (IBAction)ActionBtn3:(id)sender {
	[_delegate ReturnSelection:[MsgBtn3 substringToIndex:2 ] andMsg:[MsgBtn3 substringFromIndex:2 ]  ];
	//[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)ActionBtn4:(id)sender {
	[_delegate ReturnSelection:[MsgBtn4 substringToIndex:2 ] andMsg:[MsgBtn4 substringFromIndex:2 ]  ];
	//[self dismissModalViewControllerAnimated:YES];
}



@end
