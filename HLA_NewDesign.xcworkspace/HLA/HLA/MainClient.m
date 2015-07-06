//
//  MainClient.m
//  iMobile Planner
//
//  Created by shawal sapuan on 6/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "MainClient.h"
#import "CarouselViewController.h"
#import "ProspectListing.h"
#import "Logout.h"
#import "GroupListing.h"

@interface MainClient () {
    NSArray* viewControllers;
}

@end

@implementation MainClient
@synthesize indexNo,IndexTab;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;
	
    NSMutableArray* controllersToAdd = [[NSMutableArray alloc] init];
    
    CarouselViewController* carouselPage = [self.storyboard instantiateViewControllerWithIdentifier:@"carouselView"];
    carouselPage.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:[UIImage imageNamed:@"btn_home.png"] tag: 0];
    [controllersToAdd addObject:carouselPage];
    viewControllers = [NSArray arrayWithArray:controllersToAdd];
    
    ProspectListing* ProspectListingPage = [self.storyboard instantiateViewControllerWithIdentifier:@"clientListing"];
	//ProspectListing* ProspectListingPage = [self.storyboard instantiateViewControllerWithIdentifier:@"ProspectListing"];
    ProspectListingPage.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Client" image:[UIImage imageNamed:@"btn_prospect_off.png"] tag: 0];
    [controllersToAdd addObject:ProspectListingPage];
    viewControllers = [NSArray arrayWithArray:controllersToAdd];
    
    GroupListing *groupPage = [self.storyboard instantiateViewControllerWithIdentifier:@"groupListing"];
    groupPage.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Group" image:[UIImage imageNamed:@"btn_prospect_off.png"] tag:0];
    [controllersToAdd addObject:groupPage];
    viewControllers = [NSArray arrayWithArray:controllersToAdd];
    
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
    
    colors = Nil, controllersToAdd = Nil, carouselPage = Nil, ProspectListingPage = Nil, LogoutPage = Nil;
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

-(BOOL)tabBarController:(ClientTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewControllers indexOfObject:viewController] == 6) {
        return NO;
    }
    else {
        return YES;
    }
}

@end
