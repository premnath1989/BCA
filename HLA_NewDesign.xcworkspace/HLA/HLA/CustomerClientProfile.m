//
//  CustomerClientProfile.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "CustomerClientProfile.h"
#import "CustomerViewController.h"
#import "DataClass.h"

@interface CustomerClientProfile () {
	DataClass *obj;
}

@end

@implementation CustomerClientProfile
@synthesize CustomerVC = _CustomerVC;

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
    
    self.CustomerVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"CustomerViewController"];
    [self addChildViewController:self.CustomerVC];
    [self.contentView addSubview:self.CustomerVC.view];
	
	obj = [DataClass getInstance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDoneBtn:nil];
    [self setCustomerTitle:nil];
    [self setContentView:nil];
    [super viewDidUnload];
}
- (IBAction)doDone:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
	
	if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressForeign"] isEqualToString:@"1"]){
        [_CustomerVC.mailingAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
    }
    else{
        [_CustomerVC.mailingAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    }
    _CustomerVC.mailingAddress1.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress1"];
    _CustomerVC.mailingAddress2.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress2"];
    _CustomerVC.mailingAddress3.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress3"];
    _CustomerVC.PostCode.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingPostcode"];
    _CustomerVC.Town.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressTown"];
    _CustomerVC.mailingAddressState.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressState"];
    _CustomerVC.mailingAddressCountry.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressCountry"];
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
