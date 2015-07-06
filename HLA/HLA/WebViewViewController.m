//
//  WebViewViewController.m
//  iMobile Planner
//
//  Created by Emi on 21/4/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import "WebViewViewController.h"
#import "Reachability.h"

@interface WebViewViewController ()

@end

@implementation WebViewViewController

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
	
	NSString *urlString = @"http://www.hla.com.my/termsandconditions.aspx?action=policy";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:urlRequest];
    // Do any additional setup after loading the view from its nib.
	
	
	
    if ([[Reachability reachabilityWithHostname:@"www.hla.com.my"] currentReachabilityStatus] == NotReachable) {
		// Show alert because no wifi or 3g is available..
	//	[MBProgressHUD hideHUDForView:self.view animated:YES];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
														message:@"Error in connecting to Web service. Please check your internet connection"
													   delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		
		alert = Nil;
	}
	
	else
	{
		
	}
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CloseModal:(id)sender
{
	[self dismissViewControllerAnimated:NO completion:nil];
}
@end
