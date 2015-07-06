//
//  MasterMenuEApp.m
//  iMobile Planner
//
//  Created by shawal sapuan on 6/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "eSubMenu.h"
#import "DataClass.h"
#import "pendingVC.h"

@interface eSubMenu (){
    NSString *alertMsg;
    DataClass *obj;
}

@end

@implementation eSubMenu
@synthesize SummaryVC = _SummaryVC;
@synthesize pendVC = _pendVC;
@synthesize submittedVC = _submittedVC;
@synthesize PolicyVC = _PolicyVC;
@synthesize NomineesVC = _NomineesVC;
@synthesize HealthVC = _HealthVC;
@synthesize AddQuestVC = _AddQuestVC;
@synthesize DeclareVC = _DeclareVC;
@synthesize eAppPersonalDataVC = _eAppPersonalDataVC;
@synthesize HealthVC2 = _HealthVC2;
@synthesize HealthVC3 = _HealthVC3;
//@synthesize part4 = _part4;
@synthesize myTableView,rightView,ListOfSubMenu;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    alertMsg = @"eApp saved sucessfully";
    
    obj = [DataClass getInstance];
    
    self.myTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-linen.png"]];
    
    ListOfSubMenu = [[NSMutableArray alloc] initWithObjects:@"Pending Submission", @"Submitted Cases", nil ];
    myTableView.rowHeight = 44;
    [myTableView reloadData];
    
    UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
    self.pendVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"Pending"];
    [self addChildViewController:self.pendVC];
    [self.rightView addSubview:self.pendVC.view];
    selectedPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
/*
 
    UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
    if ([[obj.eAppData objectForKey:@"Proposal"] objectForKey:@"Complete"] != Nil){
        self.SummaryVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"SummaryScreenComplete"];
        [self addChildViewController:self.SummaryVC];
        [self.rightView addSubview:self.SummaryVC.view];
        selectedPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else{
        
        self.SummaryVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"SummaryScreen"];
        [self addChildViewController:self.SummaryVC];
        [self.rightView addSubview:self.SummaryVC.view];
        selectedPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
 */


    
    nextStoryboard = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	
    self.myTableView.frame = CGRectMake(0, 0, 220, 748);
    [self hideSeparatorLine];
//    self.rightView.frame = CGRectMake(223, 0, 801, 748);
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

-(void)hideSeparatorLine
{
    CGRect frame = myTableView.frame;
    frame.size.height = MIN(44 * [ListOfSubMenu count], 748);
    myTableView.frame = frame;
}

#pragma mark - table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)myTableView numberOfRowsInSection:(NSInteger)section
{
    return ListOfSubMenu.count;
}

- (UITableViewCell *)tableView:(UITableView *)myTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [ListOfSubMenu objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"";
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:18];
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    
    return cell;
}


#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    selectedPath = indexPath;
    UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
    
    if (indexPath.row == 0)     //pending
    {
        UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
        self.pendVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"Pending"];
        [self addChildViewController:self.pendVC];
        [self.rightView addSubview:self.pendVC.view];
    }
    
    else if (indexPath.row == 1)
    {
        UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
        self.submittedVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"Submitted"];
        [self addChildViewController:self.submittedVC];
        [self.rightView addSubview:self.submittedVC.view];
    }
 

    nextStoryboard = nil;
    
}

-(void)selectedMenu:(NSString *)menu
{
    NSLog(@"receive menu %@",menu);
    UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
    
    if ([menu isEqualToString:@"1"]) {
        
        NSLog(@"1");
        self.eAppPersonalDataVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"eAppDataScreen"];
        [self addChildViewController:self.eAppPersonalDataVC];
        [self.rightView addSubview:self.eAppPersonalDataVC.view];
        
        selectedPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    if ([menu isEqualToString:@"2"]) {
        
        self.PolicyVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"MainPolicyScreen"];
        [self addChildViewController:self.PolicyVC];
        [self.rightView addSubview:self.PolicyVC.view];
        
        selectedPath = [NSIndexPath indexPathForRow:2 inSection:0];
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    if ([menu isEqualToString:@"3"]) {
        
        self.NomineesVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"MainNomineesScreen"];
        [self addChildViewController:self.NomineesVC];
        [self.rightView addSubview:self.NomineesVC.view];
        
        selectedPath = [NSIndexPath indexPathForRow:3 inSection:0];
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    if ([menu isEqualToString:@"4"]) {
        
        self.HealthVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"HealthQuestScreen"];
        _HealthVC.delegate = self;
        [self addChildViewController:self.HealthVC];
        [self.rightView addSubview:self.HealthVC.view];
        
        selectedPath = [NSIndexPath indexPathForRow:4 inSection:0];
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    if ([menu isEqualToString:@"5"]) {
        
        self.AddQuestVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"AddQuestScreen"];
        [self addChildViewController:self.AddQuestVC];
        [self.rightView addSubview:self.AddQuestVC.view];
        
        selectedPath = [NSIndexPath indexPathForRow:5 inSection:0];
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    if ([menu isEqualToString:@"6"]) {
        
        self.DeclareVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"DeclareEAppScreen"];
        [self addChildViewController:self.DeclareVC];
        [self.rightView addSubview:self.DeclareVC.view];
        
        selectedPath = [NSIndexPath indexPathForRow:6 inSection:0];
        [self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

-(void) swipeToHQ2{
    self.HealthVC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"HQ2"];
    _HealthVC2.delegate = self;
    [self addChildViewController:self.HealthVC2];
    [self.rightView addSubview:self.HealthVC2.view];
    
}

-(void) swipeToHQ3 {
    self.HealthVC3 = [self.storyboard instantiateViewControllerWithIdentifier:@"HQ3"];
    [self addChildViewController:self.HealthVC3];
    [self.rightView addSubview:self.HealthVC3.view];
    
}



#pragma mark - memory managemnet

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [self setMyTableView:nil];
    [self setRightView:nil];
    [super viewDidUnload];
}

- (IBAction)doeAppChecklist:(id)sender {
        [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)doDone:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
    /*
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"iMobile Planner"
                          message: alertMsg
                          delegate: self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert setTag:1001];
    [alert show];
    alert = Nil;
    */
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001 && buttonIndex == 0)
    {
        alertMsg = @"eApp saved sucessfully";
    }
}
@end
