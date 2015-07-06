//
//  MainViewInsured.m
//  iMobile Planner
//
//  Created by kuan on 9/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "MainViewInsured.h"

@interface MainViewInsured ()

@end

@implementation MainViewInsured

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
    
    //    obj = [DataClass getInstance];
    //   insuredArray = [[NSMutableArray alloc]init];
	// Do any additional setup after loading the view.
    viewInsuredRecord = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewInsuredRecord"];
	viewInsuredRecord.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
	//	NSLog(@"trustee: %f, %f", self.view.frame.size.width, self.view.frame.size.height);
	[self addChildViewController:viewInsuredRecord];
	[self.mainView addSubview:viewInsuredRecord.view];
    
	// Do any additional setup after loading the view.
}

- (IBAction)actionForClose:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"APPEAR - MainViewInsured.");
}

@end
