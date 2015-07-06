//
//  MainCustomer.m
//  iMobile Planner
//
//  Created by shawal sapuan on 6/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "MainCustomer.h"
#import "CarouselViewController.h"
#import "CustomerProfile.h"
#import "Logout.h"
#import "MasterMenuCFF.h"

@interface MainCustomer () {
    NSArray* viewControllers;
}

@end

@implementation MainCustomer
@synthesize indexNo,IndexTab;

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
	
    self.delegate = self;
	
    NSMutableArray* controllersToAdd = [[NSMutableArray alloc] init];
    UIStoryboard *newStoryboard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:Nil];
    
    UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:Nil];
    
    CarouselViewController* carouselPage = [self.storyboard instantiateViewControllerWithIdentifier:@"carouselView"];
    carouselPage.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:[UIImage imageNamed:@"btn_home.png"] tag: 0];
    [controllersToAdd addObject:carouselPage];
    viewControllers = [NSArray arrayWithArray:controllersToAdd];
    
    CustomerProfile *CFFListingPage = [secondStoryboard instantiateViewControllerWithIdentifier:@"customerProfile"];
    CFFListingPage.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Listing" image:[UIImage imageNamed:@"btn_SIlisting_off.png"] tag: 0];
    [controllersToAdd addObject:CFFListingPage];
    viewControllers = [NSArray arrayWithArray:controllersToAdd];
    
    /*
    MasterMenuCFF *masterCFF = [newStoryboard instantiateViewControllerWithIdentifier:@"MenuCFFView"];
    masterCFF.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"New CFF" image:[UIImage imageNamed:@"btn_newSI_off.png"] tag: 0];
    [controllersToAdd addObject:masterCFF];
    viewControllers = [NSArray arrayWithArray:controllersToAdd];
    */
    
    
    Logout* LogoutPage = [self.storyboard instantiateViewControllerWithIdentifier:@"Logout"];
    LogoutPage.indexNo = self.indexNo;
    LogoutPage.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Logout" image:[UIImage imageNamed:@"btn_exit.png"] tag: 0];
    [controllersToAdd addObject:LogoutPage];
    viewControllers = [NSArray arrayWithArray:controllersToAdd];
    
    [self setViewControllers:viewControllers];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor,(id)[UIColor lightGrayColor].CGColor, nil];
    self.tabBar.backgroundGradientColors = colors;
    
    if (self.IndexTab) {
        clickIndex = IndexTab;
        self.selectedViewController = ((UIViewController*)[viewControllers objectAtIndex:IndexTab]);
        
    }
    else {
        self.selectedViewController = ((UIViewController*)[viewControllers objectAtIndex:1]);
    }
    
    colors = Nil, controllersToAdd = Nil, carouselPage = Nil, CFFListingPage = Nil, LogoutPage = Nil, newStoryboard = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (interfaceOrientation==UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        return YES;
    
    return NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(BOOL)tabBarController:(CFFTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewControllers indexOfObject:viewController] == 6) {
        return NO;
    }
    else {
        return YES;
    }
}

@end
