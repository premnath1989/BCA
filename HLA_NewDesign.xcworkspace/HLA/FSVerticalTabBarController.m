//
//  FSVerticalTabBarController.m
//  iOS-Platform
//
//  Created by Błażej Biesiada on 4/6/12.
//  Copyright (c) 2012 Future Simple. All rights reserved.
//

#import "FSVerticalTabBarController.h"
#import "Login.h"

#import "MainScreen.h"
#import "BasicPlanHandler.h"
#import "SIMenuViewController.h"
#import "NewLAViewController.h"
#import "PayorViewController.h"
#import "SecondLAViewController.h"
#import "BasicPlanViewController.h"
#import "RiderViewController.h"
#import "PremiumViewController.h"
#import "SIListing.h"
#import "AppDelegate.h"
#import "ProspectListing.h"
#import "SIListing.h"

#define DEFAULT_TAB_BAR_HEIGHT 60.0


@interface FSVerticalTabBarController ()
- (void)_performInitialization;
@end

int rrr;

@implementation FSVerticalTabBarController


@synthesize delegate = _delegate;
@synthesize tabBar = _tabBar;
@synthesize viewControllers = _viewControllers;
@synthesize selectedIndex = _selectedIndex;
@synthesize tabBarWidth = _tabBarWidth;


- (FSVerticalTabBar *)tabBar
{
    if (_tabBar == nil)
    {
        _tabBar = [[FSVerticalTabBar alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _tabBar.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleRightMargin;
        _tabBar.delegate = self;
    }
    return _tabBar;
}

- (void)setViewControllers:(NSArray *)viewControllers
{
    _viewControllers = [viewControllers copy];
    
    // create tab bar items
    if (self.tabBar != nil)
    {
        NSMutableArray *tabBarItems = [NSMutableArray arrayWithCapacity:[self.viewControllers count]];
        for (UIViewController *vc in self.viewControllers)
        {
            [tabBarItems addObject:vc.tabBarItem];
        }
        self.tabBar.items = tabBarItems;
    }
    
    // select first VC from the new array
    // sets the value for the first time as -1 for the viewController to load itself properly
    _selectedIndex = -1;
    
    self.selectedIndex = [viewControllers count] > 0 ? 0 : INT_MAX;
}


- (UIViewController *)selectedViewController
{
    if (self.selectedIndex < [self.viewControllers count])
    {
        return [self.viewControllers objectAtIndex:self.selectedIndex];
    }
    return nil;
}


- (void)setSelectedViewController:(UIViewController *)selectedViewController
{
    self.selectedIndex = [self.viewControllers indexOfObject:selectedViewController];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    AppDelegate *MenuOption = (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    if (selectedIndex != _selectedIndex && selectedIndex < [self.viewControllers count])
    {
        [self.view endEditing:YES];
        [self resignFirstResponder];
        
        Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
        id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
        [activeInstance performSelector:@selector(dismissKeyboard)];
        
        // add new view controller to hierarchy
        UIViewController *selectedViewController = [self.viewControllers objectAtIndex:selectedIndex];
        
        if (selectedIndex == MenuOption.HomeIndex) {
            
            AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
            if (!zzz.SICompleted) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Are you sure you want to discard all the changes?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel",nil];
                [alert setTag:2001];
                [alert show];
                alert = Nil;
            }
            else if (!zzz.ExistPayor) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Please attach Payor as Life Assured is below 10 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                alert = Nil;
            }
            else {
                zzz.SICompleted = YES;
                zzz.ExistPayor = YES;
                [self presentViewController:selectedViewController animated:NO completion:Nil];
					
                [self updateTabBar];
            }
            zzz = Nil;
        }
        else {
            
            if (selectedIndex == MenuOption.ProspectListingIndex) {
                
//                [(ProspectListing *)selectedViewController ReloadTableData];
                AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
                if (!zzz.SICompleted) {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Are you sure you want to discard all the changes?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: @"Cancel",nil];
                    [alert setTag:3001];
                    [alert show];
                    alert = Nil;
                }
                else if (!zzz.ExistPayor) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Please attach Payor as Life Assured is below 10 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                    [alert show];
                    alert = Nil;
                }
                else {
                    [self addChildViewController:selectedViewController];
                    selectedViewController.view.frame = CGRectMake(self.tabBarWidth,
                                                                   0,
                                                                   self.view.bounds.size.width-self.tabBarWidth,
                                                                   self.view.bounds.size.height);
                    selectedViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
                    [self.view addSubview:selectedViewController.view];
                    
                    [self updateTabBar];
                }
                
                zzz = Nil;
            }
            
            if (selectedIndex == MenuOption.NewProspectIndex) {
                
                AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
                if (!zzz.SICompleted) {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Are you sure you want to discard all the changes?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: @"Cancel",nil];
                    [alert setTag:3001];
                    [alert show];
                    alert = Nil;
                }
                else if (!zzz.ExistPayor) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Please attach Payor as Life Assured is below 10 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                    [alert show];
                    alert = Nil;
                }
                else {
                    [self addChildViewController:selectedViewController];
                    selectedViewController.view.frame = CGRectMake(self.tabBarWidth,
                                                                   0,
                                                                   self.view.bounds.size.width-self.tabBarWidth,
                                                                   self.view.bounds.size.height);
                    selectedViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
                    [self.view addSubview:selectedViewController.view];
                    
                    [self updateTabBar];
                }
                zzz = Nil;
            }
            
            if (selectedIndex == MenuOption.SIListingIndex) {
                
                [(SIListing *)selectedViewController RefreshZZZ];
                AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
                if (!zzz.SICompleted) {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Are you sure you want to discard all the changes?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: @"Cancel",nil];
                    [alert setTag:3001];
                    [alert show];
                    alert = Nil;
                }
                else if (!zzz.ExistPayor) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Please attach Payor as Life Assured is below 10 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                    [alert show];
                    alert = Nil;
                }
                else {
                    [self addChildViewController:selectedViewController];
                    selectedViewController.view.frame = CGRectMake(self.tabBarWidth,
                                                                   0,
                                                                   self.view.bounds.size.width-self.tabBarWidth,
                                                                   self.view.bounds.size.height);
                    selectedViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
                    [self.view addSubview:selectedViewController.view];
                    
                    [self updateTabBar];
                }
                zzz = Nil;
            }
            
            if (selectedIndex == MenuOption.NewSIIndex) {
                
                [(SIMenuViewController *)selectedViewController Reset];
                
                [self addChildViewController:selectedViewController];
                selectedViewController.view.frame = CGRectMake(self.tabBarWidth,
                                                               0,
                                                               self.view.bounds.size.width-self.tabBarWidth,
                                                               self.view.bounds.size.height);
                selectedViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
                [self.view addSubview:selectedViewController.view];
                
                [self updateTabBar];
            }
            //move code to updateTabBar
        }
        selectedViewController = Nil;
    }
    
    MenuOption = Nil;
}

-(void)updateTabBar
{
    UIViewController *selectedViewController = [self.viewControllers objectAtIndex:clickIndex];
	
    // remove previously selected view controller (if any)
    if (-1 < _selectedIndex && _selectedIndex < INT_MAX)
    {
        UIViewController *previousViewController = [self.viewControllers objectAtIndex:_selectedIndex];
        [previousViewController.view removeFromSuperview];
        [previousViewController removeFromParentViewController];
        previousViewController = Nil;
    }
 
    
    if ([self.view subviews].count > 1) {

		UIViewController *previousViewController = [self.viewControllers objectAtIndex:_selectedIndex];
		
		if (_selectedIndex == 2) {
			//[(SIListing *)previousViewController SIListingClear];
		}

        [previousViewController.view removeFromSuperview];
        [previousViewController removeFromParentViewController];
        previousViewController = Nil;
    }
    
    
    // set new selected index
    _selectedIndex = clickIndex;
    
    // update tab bar
    if (clickIndex < [self.tabBar.items count])
    {
        self.tabBar.selectedItem = [self.tabBar.items objectAtIndex:clickIndex];
    }
    
    // inform delegate
    if ([self.delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)])
    {
        [self.delegate tabBarController:self didSelectViewController:selectedViewController];
    }
    selectedViewController = Nil;
}

-(void)updateTabBar2
{
    UIViewController *selectedViewController = [self.viewControllers objectAtIndex:clickIndex];
    
    // set new selected index
    _selectedIndex = clickIndex;
    
    // update tab bar
    if (clickIndex < [self.tabBar.items count])
    {
        self.tabBar.selectedItem = [self.tabBar.items objectAtIndex:clickIndex];
    }
    
    // inform delegate
    if ([self.delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)])
    {
        [self.delegate tabBarController:self didSelectViewController:selectedViewController];
    }
    selectedViewController = Nil;
}

- (void)_performInitialization
{
    self.tabBarWidth = DEFAULT_TAB_BAR_HEIGHT;
    self.selectedIndex = INT_MAX;
}

#pragma mark -
#pragma mark UIViewController
- (id)init
{
    if ((self = [super init]))
    {
        [self _performInitialization];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self _performInitialization];
    }
    return self;
}


- (void)loadView
{
    UIView *layoutContainerView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    layoutContainerView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    layoutContainerView.autoresizesSubviews = YES;
    
    // create tab bar
    self.tabBar.frame = CGRectMake(0, 0, self.tabBarWidth, layoutContainerView.bounds.size.height);
    
    [layoutContainerView addSubview:self.tabBar];
    
    // return a ready view
    self.view = layoutContainerView;
}	


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    UIViewController *selectedViewController = self.selectedViewController;
    if (selectedViewController != nil)
    {
        return [selectedViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
    }
    return YES;
}


#pragma mark -
#pragma mark FSVerticalTabBarController
- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated
{
    self.viewControllers = viewControllers;
}


#pragma mark -
#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(rrr == 2){
		
	}
	else{
	
		clickIndex = indexPath.row;
    
		AppDelegate *MenuOption = (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    
		if (indexPath.row == MenuOption.ExitIndex) {
        
			UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: NSLocalizedString(@"Log Out",nil)
                              message: NSLocalizedString(@"Are you sure you want to log out?",nil)
                              delegate: self
                              cancelButtonTitle: NSLocalizedString(@"Yes",nil)
                              otherButtonTitles: NSLocalizedString(@"No",nil), nil];
			[alert setTag:1001];
			[alert show];
			alert = Nil;
		}
		else {
			[self setSelectedIndex:indexPath.row];
		}
    
		MenuOption = Nil;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001 && buttonIndex == 0)
    {
        [self updateDateLogout];
    }
    
    else if (alertView.tag == 1001 && buttonIndex == 1)
    {
//        clickIndex = 3;
//        clickIndex = _selectedIndex;
//        [self updateTabBar];
        
        //--edited by bob
        clickIndex = _selectedIndex;
        [self updateTabBar2];
    }
    
    else  if (alertView.tag == 2001 && buttonIndex == 0)
    {
        AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
        zzz.SICompleted = YES;
        zzz.ExistPayor = YES;
        
        UIViewController *selectedViewController = [self.viewControllers objectAtIndex:clickIndex];
        [self presentViewController:selectedViewController animated:NO completion:Nil];
        
        [self updateTabBar];
    }
    
    else  if (alertView.tag == 2001 && buttonIndex == 1)
    {
        clickIndex = _selectedIndex;
        [self updateTabBar2];
    }
    
    else if (alertView.tag == 3001 && buttonIndex == 0)
    {
        AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
        zzz.SICompleted = YES;
        zzz.ExistPayor = YES;
        
        UIViewController *selectedViewController = [self.viewControllers objectAtIndex:clickIndex];
        [self addChildViewController:selectedViewController];
        selectedViewController.view.frame = CGRectMake(self.tabBarWidth,
                                                       0,
                                                       self.view.bounds.size.width-self.tabBarWidth,
                                                       self.view.bounds.size.height);
        selectedViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:selectedViewController.view];
        
        [self updateTabBar];
    }
    
    else  if (alertView.tag == 3001 && buttonIndex == 1)
    {
        clickIndex = _selectedIndex;
        [self updateTabBar2];
    }
	else if (alertView.tag == 9001 && buttonIndex == 0) //YES
    {
        NSLog(@"Do you want to save changes?");
        BOOL pass = NO;
        if ([self.delegate respondsToSelector:@selector(shouldProceedToSelectedViewControllerSave:)]) {
            UIViewController *newController = [self.viewControllers objectAtIndex:selectedIndexPath.row];
            pass = [self.delegate shouldProceedToSelectedViewControllerSave:newController];
            [self handleTableViewSelection:pass];
        }
        if (pass) {
            AppDelegate *delegate= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
            delegate.isNeedPromptSaveMsg = NO;
        }
    }
	
    else if (alertView.tag == 9001 && buttonIndex == 1) //NO
    {
        BOOL pass = NO;
		
        NSLog(@"Do you want to save changes?");
        
        if ([self.delegate respondsToSelector:@selector(shouldProceedToSelectedViewControllerDiscard:)]) {
            UIViewController *newController = [self.viewControllers objectAtIndex:selectedIndexPath.row];
            pass = [self.delegate shouldProceedToSelectedViewControllerDiscard:newController];
            [self handleTableViewSelection:pass];
			
        }
        if (pass) {
            AppDelegate *delegate= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
            delegate.isNeedPromptSaveMsg = NO;
        }
        
    }
    
    else if (alertView.tag == 9002)
    {
        
        [self handleTableViewSelection:YES];
		
		
    }
}

-(void)updateDateLogout
{
    NSString *databasePath;
    sqlite3 *contactDB;
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    Login *mainLogin = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
    mainLogin.modalPresentationStyle = UIModalPresentationFullScreen;
    mainLogin.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:mainLogin animated:YES];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE User_Profile SET LastLogoutDate= \"%@\" WHERE IndexNo=\"%d\"",dateString, 1];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"date update!");
                
            } else {
                NSLog(@"date update Failed!");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    databasePath = Nil;
    contactDB = Nil, dirPaths = Nil, docsDir = Nil, databasePath= Nil, mainLogin = Nil, dateFormatter = Nil, dateString = Nil;
    dbpath = Nil, statement = Nil, contactDB = Nil;
    
    
    exit(0);
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    fsTableView = tableView;
	AppDelegate *delegate= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    
    delegate.bpMsgPrompt = nil;
	/*
	BOOL result;
	 
    if ([self.delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) {
        UIViewController *newController = [self.viewControllers objectAtIndex:indexPath.row];
        result = [self.delegate tabBarController:self shouldSelectViewController:newController];
    }
    
    if (result) {
		if (rrr == 2) {
			return tableView.indexPathForSelectedRow;
		}
		else{
			return indexPath;
		}
        
    }
    else {
        return tableView.indexPathForSelectedRow;
    }
	 */
	if(delegate.isNeedPromptSaveMsg && delegate.isSIExist)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Do you want to save changes?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
        [alert setTag:9001];
        [alert show];
        currentIndexPath = [tableView indexPathForSelectedRow];
        selectedIndexPath = indexPath;
        
        return currentIndexPath;
		
    }
	
	return indexPath;
}

- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}

-(void)Test{
	
	rrr = 2;
	
}

-(void)handleTableViewSelection:(BOOL)result
{
    AppDelegate *delegate= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    
	if(delegate.bpMsgPrompt)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:delegate.bpMsgPrompt delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
		
        [alert setTag:9002];
        
        [alert show];
        delegate.bpMsgPrompt = nil;
        
    }
    
    else if (result && rrr != 2) {
		
        [fsTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self setSelectedIndex:selectedIndexPath.row];
        
    }
    else {
        [fsTableView selectRowAtIndexPath:currentIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self setSelectedIndex:currentIndexPath.row];
		
    }
    
}

-(void)Reset{
	
	rrr = 0;
	
}

@end
