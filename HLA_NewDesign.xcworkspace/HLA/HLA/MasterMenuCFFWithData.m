//
//  MasterMenuCFF.m
//  iMobile Planner
//
//  Created by shawal sapuan on 6/28/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "MasterMenuCFFWithData.h"

@interface MasterMenuCFFWithData (){
NSString *alertMsg;
}

@end

@implementation MasterMenuCFFWithData
@synthesize DisclosureVC = _DisclosureVC;
@synthesize CustomerVC = _CustomerVC;
@synthesize CustomerDataVC = _CustomerDataVC;
@synthesize PotentialVC = _PotentialVC;
@synthesize PreferenceVC = _PreferenceVC;
@synthesize FinancialVC = _FinancialVC;
@synthesize RetirementVC = _RetirementVC;
@synthesize RecordVC = _RecordVC;
@synthesize DeclareCFFVC = _DeclareCFFVC;
@synthesize ConfirmCFFVC = _ConfirmCFFVC;
@synthesize ListOfSubMenu,myTableView,RightView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    alertMsg = @"CFF saved sucessfully";
    
    self.myTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-linen.png"]];
    
    ListOfSubMenu = [[NSMutableArray alloc] initWithObjects:@"Disclosure of Intermediary Status", @"Customer's Choice", @"Customer's Personal Data", @"Potential Area for Discussion", @"Preference", @"Financial Needs Analysis", @"Record of Advice", @"Declaration and Acknowledgement", @"Confirmation of Advice Given to", nil ];
    myTableView.rowHeight = 57;
    
    //selectedPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //[self.myTableView selectRowAtIndexPath:selectedPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
/*    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
    

    self.CustomerDataVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"CustDetailsView"];
    //self.CustomerDataVC.wantsFullScreenLayout = FALSE;
    //self.RightView.frame = CGRectMake(0, 10, 0, 20)
    [self addChildViewController:self.CustomerDataVC];
    [self.RightView addSubview:self.CustomerDataVC.view];
    //self.RightView.frame = CGRectMake(self.RightView.frame.origin.x, self.RightView.frame.origin.y, self.RightView.frame.size.width - 200, self.RightView.frame.size.height);
    
    //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    //[myTableView.delegate tableView:myTableView didSelectRowAtIndexPath:indexPath];
  */  
    //[myTableView reloadData];




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
    NSIndexPath *indexPathq = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPathq];
    [self.myTableView selectRowAtIndexPath:indexPathq animated:NO scrollPosition:UITableViewScrollPositionNone];
    
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [ListOfSubMenu objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"";
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:18];
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    
    if (indexPath.row == 2){
        //cell.selected = TRUE;
        //cell.selectionStyle = uis
    }
    
    return cell;
}


#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //self.RightView.frame = CGRectMake(self.RightView.frame.origin.x, self.RightView.frame.origin.y, self.RightView.frame.size.width+1, self.RightView.frame.size.height);
    selectedPath = indexPath;
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard CFF" bundle:nil];
    
    if (indexPath.row == 0)     //disclosure
    {
        /*
        self.DisclosureVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DisclosureView"];
        [self addChildViewController:self.DisclosureVC];
        [self.RightView addSubview:self.DisclosureVC.view];
        */
        self.DisclosureVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"DisclosureView"];
        [self addChildViewController:self.DisclosureVC];
        [self.RightView addSubview:self.DisclosureVC.view];
    }
    
    else if (indexPath.row == 1)     //customer choice
    {
        /*
        self.CustomerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CustomerView"];
        [self addChildViewController:self.CustomerVC];
        [self.RightView addSubview:self.CustomerVC.view];
        */
        self.CustomerVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"CustomerChoiceView"];
        [self addChildViewController:self.CustomerVC];
        [self.RightView addSubview:self.CustomerVC.view];
    }
    
    else if (indexPath.row == 2)     //customer data
    {
        /*
        self.CustomerDataVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CustDetailView"];
        [self addChildViewController:self.CustomerDataVC];
        [self.RightView addSubview:self.CustomerDataVC.view];
         */
        self.CustomerDataVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"CustDetailsView"];
        [self addChildViewController:self.CustomerDataVC];
        [self.RightView addSubview:self.CustomerDataVC.view];
        
    }
    
    else if (indexPath.row == 3)     //potential area
    {
        /*
        self.PotentialVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PotentialView"];
        [self addChildViewController:self.PotentialVC];
        [self.RightView addSubview:self.PotentialVC.view];
         */
        self.PotentialVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"PotentialAreasView"];
        [self addChildViewController:self.PotentialVC];
        [self.RightView addSubview:self.PotentialVC.view];
    }
    
    else if (indexPath.row == 4)     //preference
    {
        /*
        self.PreferenceVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PreferenceView"];
        [self addChildViewController:self.PreferenceVC];
        [self.RightView addSubview:self.PreferenceVC.view];
         */
        self.PreferenceVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"PreferenceView"];
        [self addChildViewController:self.PreferenceVC];
        [self.RightView addSubview:self.PreferenceVC.view];
    }
    
    else if (indexPath.row == 5)     //financial analysis
    {
        /*
        self.FinancialVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FinancialView"];
        _FinancialVC.delegate = self;
        [self addChildViewController:self.FinancialVC];
        [self.RightView addSubview:self.FinancialVC.view];
         */
        
        self.FinancialVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FinancialView"];
        [self addChildViewController:self.FinancialVC];
        [self.RightView addSubview:self.FinancialVC.view];
    }
    
    else if (indexPath.row == 6)     //record
    {
        /*
        self.RecordVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RecordView"];
        [self addChildViewController:self.RecordVC];
        [self.RightView addSubview:self.RecordVC.view];
         */
        self.RecordVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"RecordofAdvice"];
        [self addChildViewController:self.RecordVC];
        [self.RightView addSubview:self.RecordVC.view];
    }
    
    else if (indexPath.row == 7)     //declare
    {
        /*
        self.DeclareCFFVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DeclareCFFView"];
        [self addChildViewController:self.DeclareCFFVC];
        [self.RightView addSubview:self.DeclareCFFVC.view];
         */
        self.DeclareCFFVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"DeclareView"];
        [self addChildViewController:self.DeclareCFFVC];
        [self.RightView addSubview:self.DeclareCFFVC.view];
    }
    
    else if (indexPath.row == 8)     //declare
    {
        /*
        self.ConfirmCFFVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ConfirmCFFView"];
        [self addChildViewController:self.ConfirmCFFVC];
        [self.RightView addSubview:self.ConfirmCFFVC.view];
        */
        //self.ConfirmCFFVC
        self.ConfirmCFFVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ConfirmationView"];
        [self addChildViewController:self.ConfirmCFFVC];
        [self.RightView addSubview:self.ConfirmCFFVC.view];
    }
}

#pragma mark - delegate action

-(void)swipeToRetirement
{
    self.RetirementVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RetirementView"];
    [self addChildViewController:self.RetirementVC];
    [self.RightView addSubview:self.RetirementVC.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [self setRightView:nil];
    [self setMyTableView:nil];
    [self setMyTableView:nil];
    [self setRightView:nil];
    [self setMyTableView:nil];
    [self setRightView:nil];
    [super viewDidUnload];
}
- (IBAction)doCancel:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)doDone:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: @"iMobile Planner"
                          message: alertMsg
                          delegate: self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert setTag:1001];
    [alert show];
    alert = Nil;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001 && buttonIndex == 0)
    {
        alertMsg = @"CFF saved sucessfully";
    }
}
@end
