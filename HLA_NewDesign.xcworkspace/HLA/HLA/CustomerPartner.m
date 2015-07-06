//
//  CustomerPartner.m
//  iMobile Planner
//
//  Created by shawal sapuan on 7/2/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "CustomerPartner.h"

@interface CustomerPartner ()

@end

@implementation CustomerPartner
@synthesize parnerIIVC = _parnerIIVC;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)goNext:(id)sender
{
    self.parnerIIVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PartnerIIView"];
    self.parnerIIVC.modalPresentationStyle = UIModalPresentationPageSheet;
    self.parnerIIVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:self.parnerIIVC animated:NO];
    self.parnerIIVC.view.superview.frame = CGRectMake(0, 50, 748, 974);
}

@end
