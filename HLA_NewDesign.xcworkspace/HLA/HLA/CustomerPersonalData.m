//
//  CustomerPersonalData.m
//  iMobile Planner
//
//  Created by Erza on 6/18/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "CustomerPersonalData.h"
#import "CustomerPartner.h"
#import "CustomerChildren.h"

@interface CustomerPersonalData ()

@end

@implementation CustomerPersonalData

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
	
}

- (void)viewWillAppear:(BOOL)animated
{
    self.view.frame = CGRectMake(0, 0, 788, 1004);
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
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (IBAction)addParner:(id)sender
{
    CustomerPartner *partner = [self.storyboard instantiateViewControllerWithIdentifier:@"PartnerView"];
    partner.modalPresentationStyle = UIModalPresentationPageSheet;
    partner.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:partner animated:NO];
//    partner.view.superview.frame = CGRectMake(50, 0, 970, 748);
    partner.view.superview.frame = CGRectMake(0, 50, 748, 974);
}

- (IBAction)addChildren:(id)sender
{
    CustomerChildren *partnerChild = [self.storyboard instantiateViewControllerWithIdentifier:@"ChildrenView"];
    partnerChild.modalPresentationStyle = UIModalPresentationPageSheet;
    partnerChild.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:partnerChild animated:NO];
    partnerChild.view.superview.frame = CGRectMake(0, 50, 748, 974);
}
@end
