//
//  MainLA1DetailsVC.m
//  iMobile Planner
//
//  Created by Juliana on 11/13/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "MainLA1DetailsVC.h"
#import "DataClass.h"
#import "Utility.h"

@interface MainLA1DetailsVC () {
	DataClass *obj;
    UIAlertView *alert;
}

@end

@implementation MainLA1DetailsVC

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
	obj=[DataClass getInstance];
	
	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"WhichDetails"] isEqualToString:@"1"]) {
	
		_titleForDetails.text = @"1st Life Assured";
		LA1VC = [self.storyboard instantiateViewControllerWithIdentifier:@"LA1Details"];
		LA1VC.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[self addChildViewController:LA1VC];
		[self.mainView addSubview:LA1VC.view];
		
	}
	else if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"WhichDetails"] isEqualToString:@"2"]) {
		
		_titleForDetails.text = @"2nd Life Assured";
		LA2VC = [self.storyboard instantiateViewControllerWithIdentifier:@"LA2Details"];
		LA2VC.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[self addChildViewController:LA2VC];
		[self.mainView addSubview:LA2VC.view];
		
	}
	else if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"WhichDetails"] isEqualToString:@"3"]) {
		
		_titleForDetails.text = @"Payor";
		PayorVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PayorDetails"];
		PayorVC.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[self addChildViewController:PayorVC];
		[self.mainView addSubview:PayorVC.view];
		
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
	[self setView:nil];
	[self setMainView:nil];
	[self setTitle:nil];
	[self setTitle:nil];
	[self setTitle:nil];
	[super viewDidUnload];
}

- (IBAction)selectClose:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)selectDone:(id)sender {
	[self dismissModalViewControllerAnimated:NO];
}

@end
