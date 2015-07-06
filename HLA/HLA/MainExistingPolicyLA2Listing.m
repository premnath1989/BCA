//
//  MainExistingPolicyLA2Listing.m
//  iMobile Planner
//
//  Created by Juliana on 11/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "MainExistingPolicyLA2Listing.h"
#import "DataClass.h"

@interface MainExistingPolicyLA2Listing () {
	DataClass *obj;
}

@end

@implementation MainExistingPolicyLA2Listing

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	PolicyListing = [self.storyboard instantiateViewControllerWithIdentifier:@"ExistingPolicyLA2Listing"];
	PolicyListing.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
	//	NSLog(@"trustee: %f, %f", self.view.frame.size.width, self.view.frame.size.height);
	[self addChildViewController:PolicyListing];
	[self.mainView addSubview:PolicyListing.view];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(receiveTestNotification:)
												 name:@"TestNotificationLA2"
											   object:nil];
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
	
    if ([[notification name] isEqualToString:@"TestNotificationLA2"])
        [PolicyListing.mainTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
	[self setMainView:nil];
	[super viewDidUnload];
}

- (IBAction)actionForDone:(id)sender {
	if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy2ndLA"] objectForKey:@"PolicyData"] count] == 0) {
		[_delegate haveDataLA2:FALSE];
	}
	else {
		[_delegate haveDataLA2:TRUE];
	}
	
	[self dismissViewControllerAnimated:YES completion:Nil];
}

@end
