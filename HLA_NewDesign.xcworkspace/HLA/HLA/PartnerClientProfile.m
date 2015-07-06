//
//  PartnerClientProfile.m
//  iMobile Planner
//
//  Created by Meng Cheong on 8/30/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "PartnerClientProfile.h"
#import "PartnerViewController.h"

@interface PartnerClientProfile ()

@end

@implementation PartnerClientProfile

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
	// Do any additional setup after loading the view.
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
    
    self.PartnerVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"PartnerViewController"];
    [self addChildViewController:self.PartnerVC];
    [self.contentView addSubview:self.PartnerVC.view];
    
    //self.contentView
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDoneBtn:nil];
    [self setPartnerTitle:nil];
    [self setContentView:nil];
    [super viewDidUnload];
}
- (IBAction)doDone:(id)sender {
    [self.delegate partnerUpdate];
    
}
- (IBAction)doDelete:(id)sender {
    [self.delegate partnerDelete];
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}
@end
