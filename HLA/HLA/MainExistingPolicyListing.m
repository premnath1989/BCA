//
//  MainExistingPolicyListing.m
//  iMobile Planner
//
//  Created by Juliana on 9/19/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "MainExistingPolicyListing.h"
#import "DataClass.h"

@interface MainExistingPolicyListing () {
	DataClass *obj;
}

@end

@implementation MainExistingPolicyListing

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
    
    NSLog(@"4");
	// Do any additional setup after loading the view.
	AddPolicyTableVC *add = [[AddPolicyTableVC alloc]init];
//	add.delegate = self;
	obj = [DataClass getInstance];
//	[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] objectForKey:@"PolicyData"];
	PolicyListing = [self.storyboard instantiateViewControllerWithIdentifier:@"ExistingPolicyListing"];
	PolicyListing.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
	//	NSLog(@"trustee: %f, %f", self.view.frame.size.width, self.view.frame.size.height);
	[self addChildViewController:PolicyListing];
	[self.mainView addSubview:PolicyListing.view];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(receiveTestNotification:)
												 name:@"TestNotification"
											   object:nil];
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
	
    if ([[notification name] isEqualToString:@"TestNotification"])
        [PolicyListing.mainTableView reloadData];
}


//- (void)reloadPolicyTable {
//	NSLog(@"reloadPolicyTable");
//	[PolicyListing.mainTableView reloadData];
//}

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
	if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] objectForKey:@"PolicyData"] count] == 0) {
		[_delegate haveData:FALSE];
	}
	else {
		[_delegate haveData:TRUE];
	}
	
	[self dismissViewControllerAnimated:YES completion:Nil];
}

@end
