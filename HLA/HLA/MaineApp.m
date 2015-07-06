//
//  MaineApp.m
//  iMobile Planner
//
//  Created by shawal sapuan on 6/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "MaineApp.h"
#import "CarouselViewController.h"
#import "eSubmission.h"
#import "Logout.h"
#import "MasterMenuEApp.h"
#import "eAppMenu.h"
#import "pendingVC.h"
#import "submittedVC.h"

@interface MaineApp () {
    NSArray* viewControllers;
}

@end

@implementation MaineApp
@synthesize IndexTab,indexNo,getMenu,getSI;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.delegate = self;
	
    NSMutableArray* controllersToAdd = [[NSMutableArray alloc] init];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    
    CarouselViewController* carouselPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"carouselView"];
    carouselPage.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:[UIImage imageNamed:@"btn_home.png"] tag: 0];
    [controllersToAdd addObject:carouselPage];
    viewControllers = [NSArray arrayWithArray:controllersToAdd];
    
    if ([[self.getMenu description] isEqualToString:@"eAPP"]) {
        
        MasterMenuEApp *menuEApp = [self.storyboard instantiateViewControllerWithIdentifier:@"eAppMaster"];
        menuEApp.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"eApp" image:[UIImage imageNamed:@"btn_newSI_off.png"] tag: 0];
        [controllersToAdd addObject:menuEApp];
        viewControllers = [NSArray arrayWithArray:controllersToAdd];
    }
    else {
        eSubmission *eAppListing = [self.storyboard instantiateViewControllerWithIdentifier:@"eAppsNavi"];
        eAppListing.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"eApp" image:[UIImage imageNamed:@"btn_SIlisting_off.png"] tag: 0];
        [controllersToAdd addObject:eAppListing];
        viewControllers = [NSArray arrayWithArray:controllersToAdd];
        
        eAppListing = nil;
    }
    AppDelegate *appobj=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    appobj.DeletePDF=YES;
    appobj.FormsTickMark=YES;
    UIStoryboard *nextStoryboard2 = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
    pendingVC *pendVC = [nextStoryboard2 instantiateViewControllerWithIdentifier:@"Pending"];
    pendVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Pending" image:[UIImage imageNamed:@"btn_SIlisting_off.png"] tag: 0];
    [controllersToAdd addObject:pendVC];
    
    
    
    
    submittedVC *submittedVC = [nextStoryboard2 instantiateViewControllerWithIdentifier:@"Submitted"];
    submittedVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Submitted" image:[UIImage imageNamed:@"btn_SIlisting_off.png"] tag: 0];
    [controllersToAdd addObject:submittedVC];

    Logout* LogoutPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"Logout"];
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
    
    colors = Nil, controllersToAdd = Nil, carouselPage = Nil, LogoutPage = Nil, mainStoryboard = Nil;
    pendVC=nil;
    submittedVC=nil;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tap.cancelsTouchesInView = NO;
    tap.numberOfTapsRequired = 1;
    
    [self.view addGestureRecognizer:tap];

}

-(void)hideKeyboard{
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
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
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(BOOL)tabBarController:(eAppTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if ([viewControllers indexOfObject:viewController] == 6) {
        return NO;
    }
    else {
        return YES;
    }
}

@end
