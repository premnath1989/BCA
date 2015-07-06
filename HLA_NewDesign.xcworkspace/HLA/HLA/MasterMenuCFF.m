//
//  MasterMenuCFF.m
//  iMobile Planner
//
//  Created by shawal sapuan on 6/28/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "MasterMenuCFF.h"
#import "DataClass.h"
#import "textFields.h"
#import "Utility.h"



@interface MasterMenuCFF (){
    NSString *alertMsg;
    DataClass *obj;
    NSString *tableNamePrefix;
    //int fistLoad;
}

@end

@implementation MasterMenuCFF

int firstLoad = 0;

@synthesize DisclosureVC = _DisclosureVC;
@synthesize CustomerVC = _CustomerVC;
@synthesize CustomerDataVC = _CustomerDataVC;
@synthesize PotentialVC = _PotentialVC;
@synthesize PreferenceVC = _PreferenceVC;
@synthesize FinancialVC = _FinancialVC;
@synthesize FNAProtectionVC = _FNAProtectionVC;
@synthesize FNARetirementVC = _FNARetirementVC;
@synthesize FNAEducationVC = _FNAEducationVC;
@synthesize FNASavingsVC = _FNASavingsVC;


@synthesize RetirementVC = _RetirementVC;
@synthesize RecordVC = _RecordVC;
@synthesize DeclareCFFVC = _DeclareCFFVC;
@synthesize ConfirmCFFVC = _ConfirmCFFVC;
@synthesize ListOfSubMenu,myTableView,RightView;

@synthesize eApp;


-(void)createAction:(id)sender {
    //[self removeFromSuperView];
    [self doDone:nil];
}

-(void)deleteAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: NSLocalizedString(@"iMobile Planner",nil)
                          message: NSLocalizedString(@"Are you sure you want to delete this CFF?",nil)
                          delegate: self
                          cancelButtonTitle: NSLocalizedString(@"No",nil)
                          otherButtonTitles: NSLocalizedString(@"Yes",nil), nil];
    
    alert.tag = 444;
    [alert show];
    alert = nil;
}

-(void)listingAction:(id)sender {
    [self doCancel:nil];
}

-(void)eAppChecklistAction:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

-(void)eAppDoneAction:(id)sender {
    
    if ([self doDoneEApp]) {
        if ([obj.eAppData objectForKey:@"CFF"] == NULL) {
            [obj.eAppData setObject:[[NSMutableDictionary alloc] init] forKey:@"CFF"];
        }
        [[obj.eAppData objectForKey:@"CFF"] setValue:self.cffID forKey:@"CustomerCFF"];
        [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"CFFSelected"];
        [[obj.eAppData objectForKey:@"EAPP"] setValue:self.name forKey:@"CFFName"];
        [[obj.eAppData objectForKey:@"EAPP"] setValue:self.idNo forKey:@"CFFIDNo"];
        [[obj.eAppData objectForKey:@"EAPP"] setValue:self.date forKey:@"CFFDate"];
        [[obj.eAppData objectForKey:@"EAPP"] setValue:self.status forKey:@"CFFStatus"];
        [[obj.eAppData objectForKey:@"EAPP"] setValue:self.cffID forKey:@"CFFID"];
        
        [[obj.eAppData objectForKey:@"EAPP"] setValue:self.clientProfileID forKey:@"CFFClientProfileID"];
        
        [self.delegate selectedCFF];
        [self dismissViewControllerAnimated:TRUE completion:nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    alertMsg = @"New CFF created sucessfully";
    
    self.myTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ios-linen.png"]];
    
    ListOfSubMenu = [[NSMutableArray alloc] initWithObjects:@"Disclosure of\nIntermediary Status", @"Customer's Choice", @"Customer's Personal Data", @"Potential Area for\nDiscussion", @"Preference", @"Financial Needs Analysis", @"Record of Advice", @"Declaration and\nAcknowledgement", @"Confirmation of Advice\nGiven to", nil ];
    myTableView.rowHeight = 57;
    
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@""];
    
    if (!eApp) {
        UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"Delete CFF" style:UIBarButtonItemStyleDone target:self action:@selector(deleteAction:)];
        
        UIBarButtonItem *listingButton = [[UIBarButtonItem alloc] initWithTitle:@"CFF Listing"
                                                                          style:UIBarButtonItemStyleDone target:self action:@selector(listingAction:)];
        
        UIBarButtonItem *createNewBtn = [[UIBarButtonItem alloc] initWithTitle:@"Save All" style:UIBarButtonItemStyleDone target:self action:@selector(createAction:)];
        
        
        NSArray *myButtonArray = [[NSArray alloc] initWithObjects:listingButton,deleteButton, nil];
        
        
        if ([_fLoad isEqualToString:@"1"])
            item.leftBarButtonItems = myButtonArray;
        else if ([_fLoad isEqualToString:@"0"]){
            item.leftBarButtonItem = listingButton;
        }
        
        
        
        item.rightBarButtonItem = createNewBtn;
        item.hidesBackButton = YES;
        [_myBar pushNavigationItem:item animated:NO];
        
        tableNamePrefix = @"";
    }
    else {
        UIBarButtonItem *checklistButton = [[UIBarButtonItem alloc] initWithTitle:@"eApp Checklist"
                                                                            style:UIBarButtonItemStyleDone target:self action:@selector(eAppChecklistAction:)];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(eAppDoneAction:)];
        item.leftBarButtonItem = checklistButton;
        item.rightBarButtonItem = doneButton;
        [_myBar pushNavigationItem:item animated:NO];
        
        tableNamePrefix = @"eProposal_";
        
        [self loadDBData];
    }
    
    //self.navigationItem.rightBarButtonItems = myButtonArray;
    
    
    //selectedPath = [NSIndexPath indexPathForRow:2 inSection:0];
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
    
    obj=[DataClass getInstance];
    _CFFTitle.text = [NSString stringWithFormat:@"%@%@%@", _CFFTitle.text, @" for ", [[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CFFClientName"]];
    
    
    //_SecFViewTab.backgroundColor =
    //[_SecFViewTab setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    
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
    //select the 2nd row
    //if (firstLoad == 0){
    if ([_fLoad isEqualToString:@"0"]){
        NSIndexPath *indexPathq = [NSIndexPath indexPathForRow:1 inSection:0];
        [self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPathq];
        [self.myTableView selectRowAtIndexPath:indexPathq animated:NO scrollPosition:UITableViewScrollPositionNone];
        selectedPath = indexPathq;
    }
    else if ([_fLoad isEqualToString:@"1"]){
        NSIndexPath *indexPathq = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.myTableView.delegate tableView:self.myTableView didSelectRowAtIndexPath:indexPathq];
        [self.myTableView selectRowAtIndexPath:indexPathq animated:NO scrollPosition:UITableViewScrollPositionNone];
        selectedPath = indexPathq;
    }
    
    
    
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil || indexPath.row == 7) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [ListOfSubMenu objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"";
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Trebuchet MS" size:18];
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.textAlignment = UITextAlignmentLeft;
    cell.tag = indexPath.row;
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *imgIcon2;
    imgIcon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconComplete.png"]];
    imgIcon2.hidden = true;
    //imgIcon2.tag = 3000+indexPath.row;
    //if (indexPath.row == 0){
    //    imgIcon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconComplete.png"]];
    //}
    //else{
    //    imgIcon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconNotComplete.png"]];
    //}
    imgIcon2.frame = CGRectMake(230, 22, 16, 16);
    imgIcon2.tag = 3000+indexPath.row;
    [cell.contentView addSubview:imgIcon2];
    if (indexPath.row == 0){
        if ([[[obj.CFFData objectForKey:@"SecA"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            imgIcon2.hidden = false;
        }
    }
    else if (indexPath.row == 1){
        if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            imgIcon2.hidden = false;
        }
    }
    else if (indexPath.row == 2){
        if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            cell.textLabel.textColor = [UIColor grayColor];
            cell.userInteractionEnabled = NO;
        }
        
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            imgIcon2.hidden = false;
        }
    }
    else if (indexPath.row == 3){
        if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            cell.textLabel.textColor = [UIColor grayColor];
            cell.userInteractionEnabled = NO;
        }
        if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            imgIcon2.hidden = false;
        }
    }
    else if (indexPath.row == 4){
        if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            cell.textLabel.textColor = [UIColor grayColor];
            cell.userInteractionEnabled = NO;
        }
        if ([[[obj.CFFData objectForKey:@"SecE"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            imgIcon2.hidden = false;
        }
    }
    else if (indexPath.row == 5){
        
        if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            cell.textLabel.textColor = [UIColor grayColor];
            cell.userInteractionEnabled = NO;
        }
        
        
        if (!self.CustomerVC.checkboxButton3.selected){
            cell.textLabel.textColor = [UIColor grayColor];
            cell.userInteractionEnabled = NO;
            //NSLog(@"QQQ%d",self.CustomerVC.checkboxButton3.selected);
        }
        else if (!self.CustomerVC.checkboxButton3.selected && !self.CustomerVC.checkboxButton2.selected && !self.CustomerVC.checkboxButton1.selected){
            cell.textLabel.textColor = [UIColor grayColor];
            cell.userInteractionEnabled = NO;
            //NSLog(@"RRR%d",self.CustomerVC.checkboxButton3.selected);
        }
        
        
        
        
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            imgIcon2.hidden = false;
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.userInteractionEnabled = YES;
            
            /*
             MasterMenuCFF *parent = (MasterMenuCFF *) self.parentViewController;
             UITableViewCell * cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
             cell.textLabel.textColor = [UIColor grayColor];
             cell.userInteractionEnabled = NO;
             parent = nil;
             */
            //NSLog(@"QQQ%d",self.CustomerVC.checkboxButton3.selected);
        }
        else{
            cell.textLabel.textColor = [UIColor grayColor];
            cell.userInteractionEnabled = NO;
        }
        
        
        //[[obj.CFFData objectForKey:@"SecB"] setValue:[results stringForColumn:@"ClientChoice"] forKey:@"ClientChoice"];
        
        
        if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"1"]){
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.userInteractionEnabled = YES;
            }
            else if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"2"]){
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.userInteractionEnabled = YES;
            }
            else if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"3"]){
                cell.textLabel.textColor = [UIColor grayColor];
                cell.userInteractionEnabled = NO;
            }
            
        }
        
    }
    else if (indexPath.row == 6){
        if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            cell.textLabel.textColor = [UIColor grayColor];
            cell.userInteractionEnabled = NO;
        }
        
        if ([[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            imgIcon2.hidden = false;
        }
    }
    else if (indexPath.row == 7){
        if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            cell.textLabel.textColor = [UIColor grayColor];
            cell.userInteractionEnabled = NO;
        }
        
        if ([[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            imgIcon2.hidden = false;
        }
        else {
            [imgIcon2 removeFromSuperview];
        }
    }
    else if (indexPath.row == 8){
        if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            cell.textLabel.textColor = [UIColor grayColor];
            cell.userInteractionEnabled = NO;
        }
        
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Completed"] isEqualToString:@"1"]){
            imgIcon2.hidden = false;
        }
    }
    
    
    return cell;
}


#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    selectedPath = indexPath;
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
    
    if (indexPath.row == 0)     //disclosure
    {
        //firstLoad = 1;
        self.RightView.hidden = FALSE;
        self.SecBView.hidden = TRUE;
        self.SecCView.hidden = TRUE;
        self.SecDView.hidden = TRUE;
        self.SecEView.hidden = TRUE;
        self.SecFView.hidden = TRUE;
        self.SecGView.hidden = TRUE;
        self.SecHView.hidden = TRUE;
        self.SecIView.hidden = TRUE;
        
        self.SecFViewTab.hidden = TRUE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecA" forKey:@"CurrentSection"];
        
        BOOL doesContain = [self.RightView.subviews containsObject:self.DisclosureVC.view];
        if (!doesContain){
            self.DisclosureVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"DisclosureView"];
            [self addChildViewController:self.DisclosureVC];
            [self.RightView addSubview:self.DisclosureVC.view];
            
        }
    }
    
    else if (indexPath.row == 1)     //customer choice
    {
        self.RightView.hidden = TRUE;
        self.SecBView.hidden = FALSE;
        self.SecCView.hidden = TRUE;
        self.SecDView.hidden = TRUE;
        self.SecEView.hidden = TRUE;
        self.SecFView.hidden = TRUE;
        self.SecGView.hidden = TRUE;
        self.SecHView.hidden = TRUE;
        self.SecIView.hidden = TRUE;
        
        self.SecFViewTab.hidden = TRUE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecB" forKey:@"CurrentSection"];
        
        BOOL doesContain = [self.SecBView.subviews containsObject:self.CustomerVC.view];
        if (!doesContain){
            self.CustomerVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"CustomerChoiceView"];
            [self addChildViewController:self.CustomerVC];
            [self.SecBView addSubview:self.CustomerVC.view];
        }
    }
    
    else if (indexPath.row == 2)     //customer data
    {
        self.RightView.hidden = TRUE;
        self.SecBView.hidden = TRUE;
        self.SecCView.hidden = FALSE;
        self.SecDView.hidden = TRUE;
        self.SecEView.hidden = TRUE;
        self.SecFView.hidden = TRUE;
        self.SecGView.hidden = TRUE;
        self.SecHView.hidden = TRUE;
        self.SecIView.hidden = TRUE;
        
        self.SecFViewTab.hidden = TRUE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecC" forKey:@"CurrentSection"];
        
        BOOL doesContain = [self.SecCView.subviews containsObject:self.CustomerDataVC.view];
        if (!doesContain){
            self.CustomerDataVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"CustDetailsView"];
            [self addChildViewController:self.CustomerDataVC];
            [self.SecCView addSubview:self.CustomerDataVC.view];
        }
    }
    
    else if (indexPath.row == 3)     //potential area
    {
        //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"]);
        self.RightView.hidden = TRUE;
        self.SecBView.hidden = TRUE;
        self.SecCView.hidden = TRUE;
        self.SecDView.hidden = FALSE;
        self.SecEView.hidden = TRUE;
        self.SecFView.hidden = TRUE;
        self.SecGView.hidden = TRUE;
        self.SecHView.hidden = TRUE;
        self.SecIView.hidden = TRUE;
        
        self.SecFViewTab.hidden = TRUE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecD" forKey:@"CurrentSection"];
        
        BOOL doesContain = [self.SecDView.subviews containsObject:self.PotentialVC.view];
        if (!doesContain){
            self.PotentialVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"PotentialAreasView"];
            [self addChildViewController:self.PotentialVC];
            [self.SecDView addSubview:self.PotentialVC.view];
        }
    }
    
    else if (indexPath.row == 4)     //preference
    {
        self.RightView.hidden = TRUE;
        self.SecBView.hidden = TRUE;
        self.SecCView.hidden = TRUE;
        self.SecDView.hidden = TRUE;
        self.SecEView.hidden = FALSE;
        self.SecFView.hidden = TRUE;
        self.SecGView.hidden = TRUE;
        self.SecHView.hidden = TRUE;
        self.SecIView.hidden = TRUE;
        
        self.SecFViewTab.hidden = TRUE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecE" forKey:@"CurrentSection"];
        
        BOOL doesContain = [self.SecEView.subviews containsObject:self.PreferenceVC.view];
        if (!doesContain){
            self.PreferenceVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"PreferenceView"];
            [self addChildViewController:self.PreferenceVC];
            [self.SecEView addSubview:self.PreferenceVC.view];
        }
    }
    
    else if (indexPath.row == 5 && ![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"3"])     //financial analysis
    {
        self.RightView.hidden = TRUE;
        self.SecBView.hidden = TRUE;
        self.SecCView.hidden = TRUE;
        self.SecDView.hidden = TRUE;
        self.SecEView.hidden = TRUE;
        self.SecFView.hidden = TRUE;//this one
        self.SecGView.hidden = TRUE;
        self.SecHView.hidden = TRUE;
        self.SecIView.hidden = TRUE;
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ProtectionNeedValidation"];
        
        
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        
        
        _secFTab.selectedSegmentIndex = 0;
        
        UIFont *font = [UIFont boldSystemFontOfSize:16.0f];
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                               forKey:UITextAttributeFont];
        [_secFTab setTitleTextAttributes:attributes
                                forState:UIControlStateNormal];
        
        //tab protection start
        if (![[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Priority"] isEqualToString:@""]){
            if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Priority"] isEqualToString:@"5"]){
                [_secFTab setTitle:@"Protection (4)" forSegmentAtIndex:0];
            }
            else{
                [_secFTab setTitle:[NSString stringWithFormat:@"Protection (%@)", [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Priority"]] forSegmentAtIndex:0];
            }
        }
        else{
            [_secFTab setTitle:@"Protection" forSegmentAtIndex:0];
        }
        //tab protection end
        
        //tab retirement start
        if (![[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Priority"] isEqualToString:@""]){
            if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Priority"] isEqualToString:@"5"]){
                [_secFTab setTitle:@"Retirement (4)" forSegmentAtIndex:1];
            }
            else{
                [_secFTab setTitle:[NSString stringWithFormat:@"Retirement (%@)", [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Priority"]] forSegmentAtIndex:1];
            }
        }
        else{
            [_secFTab setTitle:@"Retirement" forSegmentAtIndex:1];
        }
        //tab retirement end
        
        //tab education start
        if (![[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Priority"] isEqualToString:@""]){
            if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Priority"] isEqualToString:@"5"]){
                [_secFTab setTitle:@"Education (4)" forSegmentAtIndex:2];
            }
            else{
                [_secFTab setTitle:[NSString stringWithFormat:@"Education (%@)", [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Priority"]] forSegmentAtIndex:2];
            }
        }
        else{
            [_secFTab setTitle:@"Education" forSegmentAtIndex:2];
        }
        //tab education end
        
        //tab savings (savings) start
        if (![[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Priority"] isEqualToString:@""]){
            if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Priority"] isEqualToString:@"5"]){
                [_secFTab setTitle:@"Savings (4)" forSegmentAtIndex:3];
            }
            else{
                [_secFTab setTitle:[NSString stringWithFormat:@"Savings (%@)", [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Priority"]] forSegmentAtIndex:3];
            }
        }
        else{
            [_secFTab setTitle:@"Savings" forSegmentAtIndex:3];
        }
        //tab savings (savings) end
        
        //tab savings (investment) start
        if (![[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Priority"] isEqualToString:@""]){
            if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Priority"] isEqualToString:@"5"]){
                [_secFTab setTitle:@"Savings (4)" forSegmentAtIndex:3];
            }
            else{
                [_secFTab setTitle:[NSString stringWithFormat:@"Savings (%@)", [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Priority"]] forSegmentAtIndex:3];
            }
        }
        else{
            [_secFTab setTitle:@"Savings" forSegmentAtIndex:3];
        }
        //tab savings (investment) end
        
        
        
        /*
         if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Priority"] isEqualToString:@"1"]){
         [_secFTab setTitle:@"Protection (1)" forSegmentAtIndex:0];
         }
         else if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Priority"] isEqualToString:@"2"]){
         [_secFTab setTitle:@"Retirement (1)" forSegmentAtIndex:1];
         }
         else if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Priority"] isEqualToString:@"3"]){
         [_secFTab setTitle:@"Education (1)" forSegmentAtIndex:2];
         }
         else if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Priority"] isEqualToString:@"4"]){
         [_secFTab setTitle:@"Savings (1)" forSegmentAtIndex:3];
         }
         else if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Priority"] isEqualToString:@"5"]){
         [_secFTab setTitle:@"Savings (1)" forSegmentAtIndex:3];
         }
         */
        
        //[segmentedControl setTitle:<YourLocalizedString> forSegmentAtIndex:0];
        
        
        BOOL doesContain = [self.SecFViewProtection.subviews containsObject:self.FNAProtectionVC.view];
        if (!doesContain){
            self.FNAProtectionVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FinancialProtectionView"];
            [self addChildViewController:self.FNAProtectionVC];
            [self.SecFViewProtection addSubview:self.FNAProtectionVC.view];
        }
        else{
            //[self.FinancialVC.myTableView setContentOffset:CGPointZero animated:NO];
        }
        
        BOOL doesContainRetirement = [self.SecFViewRetirement.subviews containsObject:self.FNARetirementVC.view];
        if (!doesContainRetirement){
            self.FNARetirementVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FinancialRetirementView"];
            [self addChildViewController:self.FNARetirementVC];
            [self.SecFViewRetirement addSubview:self.FNARetirementVC.view];
        }
        
        BOOL doesContainEducation = [self.SecFViewEducation.subviews containsObject:self.FNAEducationVC.view];
        if (!doesContainEducation){
            self.FNAEducationVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FinancialEducationView"];
            [self addChildViewController:self.FNAEducationVC];
            [self.SecFViewEducation addSubview:self.FNAEducationVC.view];
        }
        
        BOOL doesContainSavings = [self.SecFViewSavings.subviews containsObject:self.FNASavingsVC.view];
        if (!doesContainSavings){
            self.FNASavingsVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FinancialSavingsView"];
            [self addChildViewController:self.FNASavingsVC];
            [self.SecFViewSavings addSubview:self.FNASavingsVC.view];
        }
    }
    
    else if (indexPath.row == 6)     //record
    {
        self.RightView.hidden = TRUE;
        self.SecBView.hidden = TRUE;
        self.SecCView.hidden = TRUE;
        self.SecDView.hidden = TRUE;
        self.SecEView.hidden = TRUE;
        self.SecFView.hidden = TRUE;
        self.SecGView.hidden = FALSE;
        self.SecHView.hidden = TRUE;
        self.SecIView.hidden = TRUE;
        
        self.SecFViewTab.hidden = TRUE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecG" forKey:@"CurrentSection"];
        
        BOOL doesContain = [self.SecGView.subviews containsObject:self.RecordVC.view];
        if (!doesContain){
            self.RecordVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"RecordofAdvice"];
            [self addChildViewController:self.RecordVC];
            [self.SecGView addSubview:self.RecordVC.view];
        }
    }
    
    else if (indexPath.row == 7)     //declare
    {
        self.RightView.hidden = TRUE;
        self.SecBView.hidden = TRUE;
        self.SecCView.hidden = TRUE;
        self.SecDView.hidden = TRUE;
        self.SecEView.hidden = TRUE;
        self.SecFView.hidden = TRUE;
        self.SecGView.hidden = TRUE;
        self.SecHView.hidden = FALSE;
        self.SecIView.hidden = TRUE;
        
        self.SecFViewTab.hidden = TRUE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecH" forKey:@"CurrentSection"];
        
        BOOL doesContain = [self.SecHView.subviews containsObject:self.DeclareCFFVC.view];
        if (!doesContain){
            self.DeclareCFFVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"DeclareView"];
            [self addChildViewController:self.DeclareCFFVC];
            [self.SecHView addSubview:self.DeclareCFFVC.view];
        }
    }
    
    else if (indexPath.row == 8)     //confirmation
    {
        self.RightView.hidden = TRUE;
        self.SecBView.hidden = TRUE;
        self.SecCView.hidden = TRUE;
        self.SecDView.hidden = TRUE;
        self.SecEView.hidden = TRUE;
        self.SecFView.hidden = TRUE;
        self.SecGView.hidden = TRUE;
        self.SecHView.hidden = TRUE;
        self.SecIView.hidden = FALSE;
        
        self.SecFViewTab.hidden = TRUE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecI" forKey:@"CurrentSection"];
        
        BOOL doesContain = [self.SecIView.subviews containsObject:self.ConfirmCFFVC.view];
        if (!doesContain){
            self.ConfirmCFFVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ConfirmationView"];
            [self addChildViewController:self.ConfirmCFFVC];
            [self.SecIView addSubview:self.ConfirmCFFVC.view];
        }
    }
}

- (NSIndexPath *)tableView: (UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (selectedPath.row == indexPath.row){//when trying to select the same row
        return nil;
    }
    
    
    if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecA"]){
        if (self.DisclosureVC.checkButton.selected){
            [[obj.CFFData objectForKey:@"SecA"] setValue:@"1" forKey:@"Disclosure"];
            [[obj.CFFData objectForKey:@"SecA"] setValue:@"" forKey:@"BrokerName"];
        }
        else if (self.DisclosureVC.checkButton2.selected){
            //bool returnVal = [textFields validateEmpty:self.DisclosureVC.textDisclosure.text];
            if ([self.DisclosureVC.textDisclosure.text length] == 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Insurance broker/financial advicer name is required."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [self.DisclosureVC.textDisclosure becomeFirstResponder];
                [alert show];
                alert = Nil;
                return nil;
            }
            [[obj.CFFData objectForKey:@"SecA"] setValue:@"2" forKey:@"Disclosure"];
            [[obj.CFFData objectForKey:@"SecA"] setValue:self.DisclosureVC.textDisclosure.text forKey:@"BrokerName"];
            [self.DisclosureVC.textDisclosure resignFirstResponder];
        }
    }
    
    //section B start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecB"]){
        if (![self validSecB]){
            return nil;
        }
        else{
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3001];
            imageView.hidden = FALSE;
            imageView = nil;
        }
    }
    //section B end
    
    //section D start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecD"]){
        
        if ([[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFValidate"] isEqualToString:@"1"]){
            if (![self validSecD]){
                return nil;
            }
            else{
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3003];
                imageView.hidden = FALSE;
                imageView = nil;
            }
        }
    }
    //section D end
    
    //section E start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecE"]){
        if ([[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFValidate"] isEqualToString:@"1"]){
            if (![self validSecE]){
                return nil;
            }
            else{
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3004];
                imageView.hidden = FALSE;
                imageView = nil;
            }
        }
    }
    //section E end
    
    //section F start (default protection)
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFProtection"]){
        if ([[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFValidate"] isEqualToString:@"1"]){
            if (![self validSecF]){
                return nil;
            }
            else{
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
                imageView.hidden = FALSE;
                imageView = nil;
            }
        }
    }
    //section F end (default protection)
    
    //section G start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecG"]){
        if ([[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFValidate"] isEqualToString:@"1"]){
            if (![self validSecG]){
                return nil;
            }
            else{
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3006];
                imageView.hidden = FALSE;
                imageView = nil;
            }
        }
    }
    //section G end
    
    //section H start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecH"]){
        if ([[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFValidate"] isEqualToString:@"1"]){
            if (![self validSecH]){
                return nil;
            }
            else{
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3007];
                imageView.hidden = FALSE;
                imageView = nil;
            }
        }
    }
    //section H end
    
    //section I start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecI"]){
        if ([[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFValidate"] isEqualToString:@"1"]){
            if (![self validSecI]){
                return nil;
            }
            else{
                UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3008];
                imageView.hidden = FALSE;
                imageView = nil;
            }
        }
    }
    //section I end
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"0" forKey:@"CFFValidate"];//no need to validate since user not yet make any changes
    return indexPath;
    
    
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
    [self setCFFTitle:nil];
    [self setSecFViewTab:nil];
    [self setSecFViewProtection:nil];
    [self setSecFViewRetirement:nil];
    [self setSecFViewEducation:nil];
    [self setSecFViewSavings:nil];
    [self setSecFTab:nil];
    [self setMyBar:nil];
    [super viewDidUnload];
}
- (IBAction)doCancel:(id)sender {
    if ([[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFSave"] isEqualToString:@"1"]){
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: NSLocalizedString(@"iMobile Planner",nil)
                              message: NSLocalizedString(@"Do you want to save?",nil)
                              delegate: self
                              cancelButtonTitle: NSLocalizedString(@"Yes",nil)
                              otherButtonTitles: NSLocalizedString(@"No",nil), nil];
        [alert setTag:8001];
        [alert show];
        alert = Nil;
        
        //[Utility showAllert:@"Please save."];
    }
    else{
        [self dismissViewControllerAnimated:TRUE completion:nil];
    }
}

- (IBAction)doDone:(id)sender {
    [self.view endEditing:YES];
    
    //if (![[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFValidate"] isEqualToString:@"1"]){
    //    [self saveCreateCFF:0];
    //    [Utility showAllert:@"Record Saved Successfully."];
    //    return;
    //}
    
    //section A start
    if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecA"]){
        if ([self validSecA]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3000];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
        }
    }
    //section A end
    
    //section B start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecB"]){
        if ([self validSecB]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3001];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
        }
    }
    //section B end
    
    //section C start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecC"]){
        if ([self validSecC]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3002];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
        }
    }
    //section C end
    
    //section D start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecD"]){
        if ([self validSecD]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3003];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
        }
    }
    //section D end
    
    //section E start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecE"]){
        if ([self validSecE]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3004];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
        }
    }
    //section E end
    
    //section SecFProtection start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFProtection"]){
        if ([self validSecF]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
        }
    }
    
    //section SecFRetirement start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFRetirement"]){
        if ([self validSecF]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
        }
    }
    //section SecFRetirement end
    
    //section SecFEducation start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFEducation"]){
        if ([self validSecF]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
        }
    }
    //section SecFEducation end
    
    //section SecFSavings start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFSavings"]){
        if ([self validSecF]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
        }
    }
    
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecG"]){
        if ([self validSecG]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3006];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
        }
    }
    
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecH"]){
        NSLog(@"1");
        if ([self validSecH]){
            NSLog(@"2");
            [self saveCreateCFF:0];
            NSLog(@"3");
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3007];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
        }
    }
    
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecI"]){
        if ([self validSecI]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3008];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
        }
    }
    //section SecFSavings end
    
    //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"]);
    
}

- (BOOL)doDoneEApp {
    [self.view endEditing:YES];
    
    //if (![[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFValidate"] isEqualToString:@"1"]){
    //    [self saveCreateCFF:0];
    //    [Utility showAllert:@"Record Saved Successfully."];
    //    return;
    //}
    
    //section A start
    if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecA"]){
        if ([self validSecA]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3000];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    //section A end
    
    //section B start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecB"]){
        if ([self validSecB]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3001];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    //section B end
    
    //section C start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecC"]){
        if ([self validSecC]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3002];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    //section C end
    
    //section D start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecD"]){
        if ([self validSecD]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3003];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    //section D end
    
    //section E start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecE"]){
        if ([self validSecE]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3004];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    //section E end
    
    //section SecFProtection start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFProtection"]){
        if ([self validSecF]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    
    //section SecFRetirement start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFRetirement"]){
        if ([self validSecF]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    //section SecFRetirement end
    
    //section SecFEducation start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFEducation"]){
        if ([self validSecF]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    //section SecFEducation end
    
    //section SecFSavings start
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFSavings"]){
        if ([self validSecF]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3005];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecG"]){
        if ([self validSecG]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3006];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecH"]){
        if ([self validSecH]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3007];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    
    else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecI"]){
        if ([self validSecI]){
            [self saveCreateCFF:0];
            UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3008];
            imageView.hidden = FALSE;
            imageView = nil;
            [Utility showAllert:@"Record saved successfully."];
            return TRUE;
        }
        return FALSE;
    }
    //section SecFSavings end
    
    //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"]);
    return FALSE;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 8001){ //eCFF listing
        if (buttonIndex == 0){
            if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecA"]){
                if ([self validSecA]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecB"]){
                if ([self validSecB]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecC"]){
                if ([self validSecB]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecD"]){
                if ([self validSecD]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecE"]){
                if ([self validSecE]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFProtection"]){
                if ([self validSecF]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFRetirement"]){
                if ([self validSecF]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFEducation"]){
                if ([self validSecF]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFSavings"]){
                if ([self validSecF]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecG"]){
                if ([self validSecG]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecH"]){
                if ([self validSecH]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecI"]){
                if ([self validSecI]){
                    [self saveCreateCFF:1];
                }
            }
        }
        else if (buttonIndex == 1){
            [self dismissViewControllerAnimated:TRUE completion:nil];
        }
    }
    
    
    
    else if (alertView.tag == 8002){ //eCFF listing
        if (buttonIndex == 0){
            if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecA"]){
                if ([self validSecA]){
                    [self saveCreateCFF:1];
                }
            }
            else if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecB"]){
                if ([self validSecB]){
                    [self saveCreateCFF:1];
                }
            }
        }
    }
    
    //Section F Protection
    else if (alertView.tag == 9000){
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
    }
    
    else if (alertView.tag == 9001){
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.current1 becomeFirstResponder];
    }
    else if (alertView.tag == 9002){
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.required1 becomeFirstResponder];
    }
    else if (alertView.tag == 9003){
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.required2 becomeFirstResponder];
    }
    else if (alertView.tag == 9023){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.current2 becomeFirstResponder];
    }
    else if (alertView.tag == 9004){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.required3 becomeFirstResponder];
    }
    else if (alertView.tag == 9024){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.current3 becomeFirstResponder];
    }
    else if (alertView.tag == 9005){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.required4 becomeFirstResponder];
    }
    else if (alertView.tag == 9025){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.current4 becomeFirstResponder];
    }
    else if (alertView.tag == 9006){
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.customerAlloc becomeFirstResponder];
    }
    else if (alertView.tag == 9010){
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.partnerAlloc becomeFirstResponder];
    }
    else if (alertView.tag == 9007){
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.required1 becomeFirstResponder];
    }
    else if (alertView.tag == 9032){
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.required1 becomeFirstResponder];
    }
    else if (alertView.tag == 9033){
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.required2 becomeFirstResponder];
    }
    else if (alertView.tag == 9034){
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.required3 becomeFirstResponder];
    }
    else if (alertView.tag == 9035){
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:0];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        [self.FNAProtectionVC.required4 becomeFirstResponder];
    }
    
    //section F Retirement
    else if (alertView.tag == 9100){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
    }
    
    else if (alertView.tag == 9101){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.current1 becomeFirstResponder];
    }
    
    else if (alertView.tag == 9102){
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.required1 becomeFirstResponder];
    }
    
    else if (alertView.tag == 9107){
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.required1 becomeFirstResponder];
    }
    
    else if (alertView.tag == 9106){
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.customerAlloc becomeFirstResponder];
    }
    
    else if (alertView.tag == 9116){
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.partnerAlloc becomeFirstResponder];
    }
    
    else if (alertView.tag == 9117){
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.customerRely becomeFirstResponder];
    }
    
    else if (alertView.tag == 9118){
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.partnerRely becomeFirstResponder];
    }
    
    else if (alertView.tag == 9141){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.current1 becomeFirstResponder];
    }
    else if (alertView.tag == 9142){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.required1 becomeFirstResponder];
    }
    else if (alertView.tag == 9146){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.customerAlloc becomeFirstResponder];
    }
    else if (alertView.tag == 9147){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:1];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        [self.FNARetirementVC.partnerAlloc becomeFirstResponder];
    }
    
    // Section F Education
    else if (alertView.tag == 9200){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = FALSE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:2];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFEducation" forKey:@"CurrentSection"];
    }
    else if (alertView.tag == 9201){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = FALSE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:2];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFEducation" forKey:@"CurrentSection"];
        [self.FNAEducationVC.current1 becomeFirstResponder];
    }
    else if (alertView.tag == 9202){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = FALSE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:2];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFEducation" forKey:@"CurrentSection"];
        [self.FNAEducationVC.required1 becomeFirstResponder];
    }
    else if (alertView.tag == 9203){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = FALSE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:2];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFEducation" forKey:@"CurrentSection"];
        [self.FNAEducationVC.required2 becomeFirstResponder];
    }
    else if (alertView.tag == 9204){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = FALSE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:2];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFEducation" forKey:@"CurrentSection"];
        [self.FNAEducationVC.required3 becomeFirstResponder];
    }
    else if (alertView.tag == 9205){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = FALSE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:2];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFEducation" forKey:@"CurrentSection"];
        [self.FNAEducationVC.required4 becomeFirstResponder];
    }
    else if (alertView.tag == 9206){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = FALSE;
        self.SecFViewSavings.hidden = TRUE;
        [_secFTab setSelectedSegmentIndex:2];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFEducation" forKey:@"CurrentSection"];
        [self.FNAEducationVC.customerAlloc becomeFirstResponder];
    }
    
    //section F Savings
    else if (alertView.tag == 9300){
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = FALSE;
        [_secFTab setSelectedSegmentIndex:3];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFSavings" forKey:@"CurrentSection"];
    }
    else if (alertView.tag == 9301){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = FALSE;
        [_secFTab setSelectedSegmentIndex:3];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFSavings" forKey:@"CurrentSection"];
        [self.FNASavingsVC.current1 becomeFirstResponder];
    }
    else if (alertView.tag == 9302){
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = FALSE;
        [_secFTab setSelectedSegmentIndex:3];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFSavings" forKey:@"CurrentSection"];
        [self.FNASavingsVC.required1 becomeFirstResponder];
    }
    else if (alertView.tag == 9304){
        
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = FALSE;
        [_secFTab setSelectedSegmentIndex:3];
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFSavings" forKey:@"CurrentSection"];
        [self.FNASavingsVC.customerAlloc becomeFirstResponder];
    }
    
    
    else if (alertView.tag == 10001){
        //[myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        //[myTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        //[myTableView setContentOffset:CGPointZero animated:YES];
        [self.RecordVC.ReasonP1 becomeFirstResponder];
    }
    
    else if (alertView.tag == 10002){
        [self.RecordVC.TypeOfPlanP2 becomeFirstResponder];
    }
    else if (alertView.tag == 10003){
        [self.RecordVC.TermP2 becomeFirstResponder];
    }
    else if (alertView.tag == 10004){
        [self.RecordVC.SumAssuredP2 becomeFirstResponder];
    }
    else if (alertView.tag == 10005){
        [self.RecordVC.NameofInsuredP2 becomeFirstResponder];
    }
    else if (alertView.tag == 10006){
        [self.RecordVC.ReasonP2 becomeFirstResponder];
    }
    
    else if (alertView.tag == 20001){
        [self.DeclareCFFVC.IntermediaryCodeContractDate becomeFirstResponder];
    }
    
    else if (alertView.tag == 20012) {
        [self.DeclareCFFVC.IntermediaryCode becomeFirstResponder];
    }
    
    else if (alertView.tag == 20013) {
        [self.DeclareCFFVC.NameOfIntermediary becomeFirstResponder];
    }
    
    else if (alertView.tag == 20014) {
        [self.DeclareCFFVC.IntermediaryNRIC becomeFirstResponder];
    }
    
    else if (alertView.tag == 20002){
        [self.DeclareCFFVC.IntermediaryAddress1 becomeFirstResponder];
    }
    
    else if (alertView.tag == 20003){
        [self.DeclareCFFVC.IntermediaryCodeContractDate becomeFirstResponder];
    }
    else if (alertView.tag == 20009){
        [self.DeclareCFFVC.NameOfManager becomeFirstResponder];
    }
    
    else if (alertView.tag == 444){
        if (buttonIndex == 1){
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *docsPath = [paths objectAtIndex:0];
            NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
            
            FMDatabase *db = [FMDatabase databaseWithPath:path];
            [db open];
            //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"lastId"]);
            NSString *CFFID;
            CFFID = [[obj.CFFData objectForKey:@"CFF"] objectForKey:@"lastId"];
            
            [db executeUpdate:@"DELETE FROM CFF_Master WHERE ID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_Protection WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_Retirement WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_Education WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_Education_Details WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_SavingsInvest WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_SavingsInvest_Details WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_Family_Datails WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_CA WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_CA_Recommendation WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_Recommendation_Rider WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_RecordOfAdvice WHERE CFFID = ?", CFFID];
            [db executeUpdate:@"DELETE FROM CFF_RecordOFAdvice_Rider WHERE CFFID = ?", CFFID];
            //[db executeUpdate:@"DELETE FROM CFF_Personal_Details WHERE CFFID = ?", CFFID];
            [db close];
            [self dismissViewControllerAnimated:TRUE completion:nil];
        }
    }
    
    
    /*
     if (alertView.tag == 2000 && buttonIndex == 0)
     {
     [self.view endEditing:YES];
     }
     else if (alertView.tag == 2001 && buttonIndex == 0)
     {
     alertMsg = @"CFF saved sucessfully.";
     }
     else if (alertView.tag == 2002 && buttonIndex == 0)
     {
     UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3001];
     imageView.hidden = FALSE;
     alertMsg = @"CFF saved sucessfully.";
     }
     else if (alertView.tag == 2003 && buttonIndex == 0)
     {
     //UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3001];
     //imageView.hidden = FALSE;
     //alertMsg = @"CFF saved sucessfully.";
     }
     else if (alertView.tag == 2004 && buttonIndex == 0)
     {
     UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3003];
     imageView.hidden = FALSE;
     alertMsg = @"CFF saved sucessfully.";
     }
     else if (alertView.tag == 2005 && buttonIndex == 0)
     {
     UIImageView *imageView=(UIImageView *)[self.view viewWithTag:3004];
     imageView.hidden = FALSE;
     alertMsg = @"CFF saved sucessfully.";
     }
     */
}

-(void)logger{
    //NSLog(@"sadasdas");
}


- (IBAction)doSecFTab:(id)sender {
    [self.view endEditing:YES];
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
    
    if (_secFTab.selectedSegmentIndex == 0){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = FALSE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ProtectionNeedValidation"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"RetirementNeedValidation"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"EducationNeedValidation"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"SavingsNeedValidation"];
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFProtection" forKey:@"CurrentSection"];
        BOOL doesContain = [self.SecFViewProtection.subviews containsObject:self.FNAProtectionVC.view];
        if (!doesContain){
            self.FNAProtectionVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FinancialProtectionView"];
            [self addChildViewController:self.FNAProtectionVC];
            [self.SecFViewProtection addSubview:self.FNAProtectionVC.view];
        }
        else{
            //[self.FinancialVC.myTableView setContentOffset:CGPointZero animated:NO];
        }
    }
    else if (_secFTab.selectedSegmentIndex == 1){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = FALSE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = TRUE;
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ProtectionNeedValidation"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"RetirementNeedValidation"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"EducationNeedValidation"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"SavingsNeedValidation"];
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFRetirement" forKey:@"CurrentSection"];
        BOOL doesContain = [self.SecFViewRetirement.subviews containsObject:self.FNARetirementVC.view];
        if (!doesContain){
            self.FNARetirementVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FinancialRetirementView"];
            [self addChildViewController:self.FNARetirementVC];
            [self.SecFViewRetirement addSubview:self.FNARetirementVC.view];
        }
        else{
            //[self.FinancialVC.myTableView setContentOffset:CGPointZero animated:NO];
        }
    }
    else if (_secFTab.selectedSegmentIndex == 2){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = FALSE;
        self.SecFViewSavings.hidden = TRUE;
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ProtectionNeedValidation"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"RetirementNeedValidation"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"EducationNeedValidation"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"SavingsNeedValidation"];
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFEducation" forKey:@"CurrentSection"];
        BOOL doesContain = [self.SecFViewEducation.subviews containsObject:self.FNAEducationVC.view];
        if (!doesContain){
            self.FNAEducationVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FinancialEducationView"];
            [self addChildViewController:self.FNAEducationVC];
            [self.SecFViewEducation addSubview:self.FNAEducationVC.view];
        }
        else{
            //[self.FinancialVC.myTableView setContentOffset:CGPointZero animated:NO];
        }
    }
    else if (_secFTab.selectedSegmentIndex == 3){
        self.SecFViewTab.hidden = FALSE;
        self.SecFViewProtection.hidden = TRUE;
        self.SecFViewRetirement.hidden = TRUE;
        self.SecFViewEducation.hidden = TRUE;
        self.SecFViewSavings.hidden = FALSE;
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ProtectionNeedValidation"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"RetirementNeedValidation"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"EducationNeedValidation"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"SavingsNeedValidation"];
        
        [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecFSavings" forKey:@"CurrentSection"];
        BOOL doesContain = [self.SecFViewSavings.subviews containsObject:self.FNASavingsVC.view];
        if (!doesContain){
            self.FNASavingsVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"FinancialSavingsView"];
            [self addChildViewController:self.FNASavingsVC];
            [self.SecFViewSavings addSubview:self.FNASavingsVC.view];
        }
        else{
            //[self.FinancialVC.myTableView setContentOffset:CGPointZero animated:NO];
        }
    }
    
}
-(BOOL)validSecA{
    if (self.DisclosureVC.checkButton.selected){
        [[obj.CFFData objectForKey:@"SecA"] setValue:@"1" forKey:@"Disclosure"];
        [[obj.CFFData objectForKey:@"SecA"] setValue:@"" forKey:@"BrokerName"];
    }
    else if (self.DisclosureVC.checkButton2.selected){
        //bool returnVal = [textFields validateEmpty:self.DisclosureVC.textDisclosure.text];
        if ([self.DisclosureVC.textDisclosure.text length]  == 0){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Insurance broker/financial advicer name is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            //[self.DisclosureVC.textDisclosure becomeFirstResponder];
            [alert show];
            alert = Nil;
            return FALSE;
        }
        [[obj.CFFData objectForKey:@"SecA"] setValue:@"2" forKey:@"Disclosure"];
        [[obj.CFFData objectForKey:@"SecA"] setValue:self.DisclosureVC.textDisclosure.text forKey:@"BrokerName"];
        //[self.DisclosureVC.textDisclosure resignFirstResponder];
    }
    return TRUE;
}

-(BOOL)validSecB{
    if (!self.CustomerVC.checkboxButton1.selected && !self.CustomerVC.checkboxButton2.selected && !self.CustomerVC.checkboxButton3.selected){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Customer's Choice is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        alert = Nil;
        return FALSE;
    }
    return TRUE;
}

-(BOOL)validSecC{
    return TRUE;
}

-(BOOL)validSecD{
    
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"0" forKey:@"Completed"];
    
    if (self.PotentialVC.planned1.selectedSegmentIndex == -1 && self.PotentialVC.planned2.selectedSegmentIndex == -1 && self.PotentialVC.planned3.selectedSegmentIndex == -1 && self.PotentialVC.planned4.selectedSegmentIndex == -1 && self.PotentialVC.planned5.selectedSegmentIndex == -1 && self.PotentialVC.discussion1.selectedSegmentIndex == -1 && self.PotentialVC.discussion2.selectedSegmentIndex == -1 && self.PotentialVC.discussion3.selectedSegmentIndex == -1 && self.PotentialVC.discussion4.selectedSegmentIndex == -1 && self.PotentialVC.discussion5.selectedSegmentIndex == -1){
        [Utility showAllert:@"At least 1 option of Potential Area for Discussion is required."];
        return FALSE;
    }
    bool option1Done = FALSE;
    bool option2Done = FALSE;
    bool option3Done = FALSE;
    bool option4Done = FALSE;
    bool option5Done = FALSE;
    
    bool option1Partial = FALSE;
    bool option2Partial = FALSE;
    bool option3Partial = FALSE;
    bool option4Partial = FALSE;
    bool option5Partial = FALSE;
    
    if (self.PotentialVC.planned1.selectedSegmentIndex != -1 && self.PotentialVC.discussion1.selectedSegmentIndex != -1 && ![self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"N/A"]){
        option1Done = TRUE;
    }
    if (self.PotentialVC.planned2.selectedSegmentIndex != -1 && self.PotentialVC.discussion2.selectedSegmentIndex != -1 && ![self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"N/A"]){
        option2Done = TRUE;
    }
    if (self.PotentialVC.planned3.selectedSegmentIndex != -1 && self.PotentialVC.discussion3.selectedSegmentIndex != -1 && ![self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"N/A"]){
        option3Done = TRUE;
    }
    if (self.PotentialVC.planned4.selectedSegmentIndex != -1 && self.PotentialVC.discussion4.selectedSegmentIndex != -1 && ![self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"N/A"]){
        option4Done = TRUE;
    }
    if (self.PotentialVC.planned5.selectedSegmentIndex != -1 && self.PotentialVC.discussion5.selectedSegmentIndex != -1 && ![self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"N/A"]){
        option5Done = TRUE;
    }
    
    if (self.PotentialVC.planned1.selectedSegmentIndex != -1 || self.PotentialVC.discussion1.selectedSegmentIndex != -1 || ![self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"N/A"]){
        option1Partial = TRUE;
    }
    if (self.PotentialVC.planned2.selectedSegmentIndex != -1 || self.PotentialVC.discussion2.selectedSegmentIndex != -1 || ![self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"N/A"]){
        option2Partial = TRUE;
    }
    if (self.PotentialVC.planned3.selectedSegmentIndex != -1 || self.PotentialVC.discussion3.selectedSegmentIndex != -1 || ![self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"N/A"]){
        option3Partial = TRUE;
    }
    if (self.PotentialVC.planned4.selectedSegmentIndex != -1 || self.PotentialVC.discussion4.selectedSegmentIndex != -1 || ![self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"N/A"]){
        option4Partial = TRUE;
    }
    if (self.PotentialVC.planned5.selectedSegmentIndex != -1 || self.PotentialVC.discussion5.selectedSegmentIndex != -1 || ![self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"N/A"]){
        option5Partial = TRUE;
    }
    
    
    if (option1Done){
        if (!option2Done){
            if (option2Partial){
                [Utility showAllert:@"Please answer all question for Option 2."];
                return FALSE;
            }
        }
        if (!option3Done){
            if (option3Partial){
                [Utility showAllert:@"Please answer all question for Option 3."];
                return FALSE;
            }
        }
        if (!option4Done){
            if (option4Partial){
                [Utility showAllert:@"Please answer all question for Option 4."];
                return FALSE;
            }
        }
        if (!option5Done){
            if (option5Partial){
                [Utility showAllert:@"Please answer all question for Option 5."];
                return FALSE;
            }
        }
        //if (![self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"1"]){
        //    [Utility showAllert:@"Priority should be 1 if ONLY 1 option being selected."];
        //    return nil;
        //}
    }
    else{
        if (option1Partial){
            [Utility showAllert:@"Please answer all question for Option 1."];
            return FALSE;
        }
    }
    
    if (option2Done){
        if (!option1Done){
            if (option1Partial){
                [Utility showAllert:@"Please answer all question for Option 1."];
                return FALSE;
            }
        }
        if (!option3Done){
            if (option3Partial){
                [Utility showAllert:@"Please answer all question for Option 3."];
                return FALSE;
            }
        }
        if (!option4Done){
            if (option4Partial){
                [Utility showAllert:@"Please answer all question for Option 4."];
                return FALSE;
            }
        }
        if (!option5Done){
            if (option5Partial){
                [Utility showAllert:@"Please answer all question for Option 5."];
                return FALSE;
            }
        }
    }
    else{
        if (option2Partial){
            [Utility showAllert:@"Please answer all question for Option 2."];
            return FALSE;
        }
    }
    
    if (option3Done){
        if (!option1Done){
            if (option1Partial){
                [Utility showAllert:@"Please answer all question for Option 1."];
                return FALSE;
            }
        }
        if (!option2Done){
            if (option2Partial){
                [Utility showAllert:@"Please answer all question for Option 2."];
                return FALSE;
            }
        }
        if (!option4Done){
            if (option4Partial){
                [Utility showAllert:@"Please answer all question for Option 4."];
                return FALSE;
            }
        }
        if (!option5Done){
            if (option5Partial){
                [Utility showAllert:@"Please answer all question for Option 5."];
                return FALSE;
            }
        }
    }
    else{
        if (option3Partial){
            [Utility showAllert:@"Please answer all question for Option 3."];
            return FALSE;
        }
    }
    
    if (option4Done){
        if (!option1Done){
            if (option1Partial){
                [Utility showAllert:@"Please answer all question for Option 1."];
                return FALSE;
            }
        }
        if (!option2Done){
            if (option2Partial){
                [Utility showAllert:@"Please answer all question for Option 2."];
                return FALSE;
            }
        }
        if (!option3Done){
            if (option3Partial){
                [Utility showAllert:@"Please answer all question for Option 3."];
                return FALSE;
            }
        }
        if (!option5Done){
            if (option5Partial){
                [Utility showAllert:@"Please answer all question for Option 5."];
                return FALSE;
            }
        }
    }
    else{
        if (option4Partial){
            [Utility showAllert:@"Please answer all question for Option 4."];
            return FALSE;
        }
    }
    
    if (option5Done){
        if (!option1Done){
            if (option1Partial){
                [Utility showAllert:@"Please answer all question for Option 1."];
                return FALSE;
            }
        }
        if (!option2Done){
            if (option2Partial){
                [Utility showAllert:@"Please answer all question for Option 2."];
                return FALSE;
            }
        }
        if (!option3Done){
            if (option3Partial){
                [Utility showAllert:@"Please answer all question for Option 3."];
                return FALSE;
            }
        }
        if (!option4Done){
            if (option4Partial){
                [Utility showAllert:@"Please answer all question for Option 4."];
                return FALSE;
            }
        }
    }
    else{
        if (option5Partial){
            [Utility showAllert:@"Please answer all question for Option 5."];
            return FALSE;
        }
    }
    
    if (option1Done && !option2Done && !option3Done && !option4Done && !option5Done){
        if (![self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority should be 1 if ONLY 1 option being selected."];
            return FALSE;
        }
    }
    
    if (option2Done && !option1Done && !option3Done && !option4Done && !option5Done){
        if (![self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority should be 1 if ONLY 1 option being selected."];
            return FALSE;
        }
    }
    
    if (option3Done && !option2Done && !option1Done && !option4Done && !option5Done){
        if (![self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority should be 1 if ONLY 1 option being selected."];
            return FALSE;
        }
    }
    
    if (option4Done && !option3Done && !option2Done && !option4Done && !option5Done){
        if (![self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority should be 1 if ONLY 1 option being selected."];
            return FALSE;
        }
    }
    
    if (option5Done && !option1Done && !option3Done && !option4Done && !option2Done){
        if (![self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority should be 1 if ONLY 1 option being selected."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"1"]){
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"2"]){
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"2"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"2"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"2"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"2"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"3"]){
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"3"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"3"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"3"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"3"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"4"]){
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"4"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"4"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"4"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"4"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"5"]){
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"5"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"5"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"5"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"5"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"1"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"2"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"2"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"2"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"2"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"2"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"3"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"3"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"3"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"3"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"3"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"4"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"4"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"4"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"4"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"4"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"5"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"5"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"5"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"5"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"5"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"1"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"2"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"2"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"2"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"2"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"2"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"3"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"3"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"3"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"3"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"3"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"4"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"4"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"4"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"4"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"4"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"5"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"5"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"5"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"5"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"5"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"1"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"2"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"2"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"2"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"2"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"2"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"3"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"3"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"3"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"3"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"3"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"4"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"4"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"4"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"4"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"4"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"5"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"5"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"5"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"5"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"5"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"1"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"1"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"2"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"2"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"2"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"2"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"2"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"3"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"3"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"3"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"3"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"3"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"4"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"4"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"4"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"4"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"4"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    if ([self.PotentialVC.Priority5.titleLabel.text isEqualToString:@"5"]){
        if ([self.PotentialVC.Priority1.titleLabel.text isEqualToString:@"5"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority2.titleLabel.text isEqualToString:@"5"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority3.titleLabel.text isEqualToString:@"5"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
        if ([self.PotentialVC.Priority4.titleLabel.text isEqualToString:@"5"]){
            [Utility showAllert:@"Priority is not in correct order."];
            return FALSE;
        }
    }
    
    
    
    
    
    /*
     if (self.PotentialVC.Priority1.titleLabel.text){
     [[obj.CFFData objectForKey:@"SecA"] setValue:@"Disclosure of Intermediary Status" forKey:@"Title"];
     }
     */
    //NSLog(@"OK");
    
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ1_Ans1"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ1_Ans2"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ1_Priority"];
    
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ2_Ans1"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ2_Ans2"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ2_Priority"];
    
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ3_Ans1"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ3_Ans2"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ3_Priority"];
    
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ4_Ans1"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ4_Ans2"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ4_Priority"];
    
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ5_Ans1"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ5_Ans2"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"" forKey:@"NeedsQ5_Priority"];
    
    if (option1Done){
        if (self.PotentialVC.planned1.selectedSegmentIndex == 0){
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"Y" forKey:@"NeedsQ1_Ans1"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"N" forKey:@"NeedsQ1_Ans1"];
        }
        
        if (self.PotentialVC.discussion1.selectedSegmentIndex == 0){
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"Y" forKey:@"NeedsQ1_Ans2"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"N" forKey:@"NeedsQ1_Ans2"];
        }
        [[obj.CFFData objectForKey:@"SecD"] setValue:self.PotentialVC.Priority1.titleLabel.text forKey:@"NeedsQ1_Priority"];
    }
    if (option2Done){
        if (self.PotentialVC.planned2.selectedSegmentIndex == 0){
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"Y" forKey:@"NeedsQ2_Ans1"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"N" forKey:@"NeedsQ2_Ans1"];
        }
        
        if (self.PotentialVC.discussion2.selectedSegmentIndex == 0){
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"Y" forKey:@"NeedsQ2_Ans2"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"N" forKey:@"NeedsQ2_Ans2"];
        }
        [[obj.CFFData objectForKey:@"SecD"] setValue:self.PotentialVC.Priority2.titleLabel.text forKey:@"NeedsQ2_Priority"];
    }
    if (option3Done){
        if (self.PotentialVC.planned3.selectedSegmentIndex == 0){
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"Y" forKey:@"NeedsQ3_Ans1"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"N" forKey:@"NeedsQ3_Ans1"];
        }
        
        if (self.PotentialVC.discussion3.selectedSegmentIndex == 0){
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"Y" forKey:@"NeedsQ3_Ans2"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"N" forKey:@"NeedsQ3_Ans2"];
        }
        [[obj.CFFData objectForKey:@"SecD"] setValue:self.PotentialVC.Priority3.titleLabel.text forKey:@"NeedsQ3_Priority"];
    }
    
    if (option4Done){
        if (self.PotentialVC.planned4.selectedSegmentIndex == 0){
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"Y" forKey:@"NeedsQ4_Ans1"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"N" forKey:@"NeedsQ4_Ans1"];
        }
        
        if (self.PotentialVC.discussion4.selectedSegmentIndex == 0){
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"Y" forKey:@"NeedsQ4_Ans2"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"N" forKey:@"NeedsQ4_Ans2"];
        }
        [[obj.CFFData objectForKey:@"SecD"] setValue:self.PotentialVC.Priority4.titleLabel.text forKey:@"NeedsQ4_Priority"];
    }
    
    if (option5Done){
        if (self.PotentialVC.planned5.selectedSegmentIndex == 0){
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"Y" forKey:@"NeedsQ5_Ans1"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"N" forKey:@"NeedsQ5_Ans1"];
        }
        
        if (self.PotentialVC.discussion5.selectedSegmentIndex == 0){
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"Y" forKey:@"NeedsQ5_Ans2"];
        }
        else{
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"N" forKey:@"NeedsQ5_Ans2"];
        }
        [[obj.CFFData objectForKey:@"SecD"] setValue:self.PotentialVC.Priority5.titleLabel.text forKey:@"NeedsQ5_Priority"];
    }
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"1" forKey:@"Completed"];
    return TRUE;
}

-(BOOL)validSecE{
    if ([self.PreferenceVC.sliderValue isEqualToString:@"0"]){
        [Utility showAllert:@"Preference is required."];
        return FALSE;
    }
    return TRUE;
}

-(BOOL)validSecF{
    
    //[[obj.CFFData objectForKey:@"SecB"] setValue:@"2" forKey:@"ClientChoice"];
    //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"]);
    
    [self.view endEditing:YES];
    if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"1"]){
        if (![self validSecFProtection]){
            return FALSE;
        }
        if (![self validSecFRetirement]){
            return FALSE;
        }
        if (![self validSecFEducation]){
            return FALSE;
        }
        if (![self validSecFSavings]){
            return FALSE;
        }
    }
    else if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"2"]){
        //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"]);
        
        
        if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFProtection"]){
            if (![self validSecFProtection]){
                return FALSE;
            }
        }
        if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFRetirement"]){
            if (![self validSecFRetirement]){
                return FALSE;
            }
        }
        if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFEducation"]){
            if (![self validSecFEducation]){
                return FALSE;
            }
        }
        if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFSavings"]){
            if (![self validSecFSavings]){
                return FALSE;
            }
        }
        
        /*
         if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFProtection"]){
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFProtection]){
         return FALSE;
         }
         }
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFRetirement]){
         return FALSE;
         }
         }
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFEducation]){
         return FALSE;
         }
         }
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFSavings]){
         return FALSE;
         }
         }
         }
         if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFRetirement"]){
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFRetirement]){
         return FALSE;
         }
         }
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFProtection]){
         return FALSE;
         }
         }
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFEducation]){
         return FALSE;
         }
         }
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFSavings]){
         return FALSE;
         }
         }
         }
         
         */
        
        
        
        /*
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFProtection]){
         return FALSE;
         }
         }
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFRetirement]){
         return FALSE;
         }
         }
         
         
         if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFProtection"]){
         if (![self validSecFProtection]){
         return FALSE;
         }
         }
         
         
         
         if ([[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"] isEqualToString:@"SecFRetirement"]){
         if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementNeedValidation"] isEqualToString:@"1"]){
         if (![self validSecFRetirement]){
         return FALSE;
         }
         }
         else{
         
         }
         }
         
         */
        //[[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"RetirementNeedValidation"];
        
        
        //if (![self validSecFProtection]){
        //}
        
    }
    
    
    //if (![self validSecFProtection]){
    //    return FALSE;
    //}
    //if (![self validSecFRetirement]){
    //    return FALSE;
    //}
    //if (![self validSecFEducation]){
    //    return FALSE;
    //}
    //if (![self validSecFSavings]){
    //    return FALSE;
    //}
    [[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"1" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"1" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"1" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecFSavings"] setValue:@"1" forKey:@"Completed"];
    return TRUE;
}


-(BOOL)validSecFEducation{
    
    if (!self.FNAEducationVC.ChildrenSelected){
        [[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"1" forKey:@"Completed"];
        return true;
    }
    
    if (self.FNAEducationVC.EducationSelected){
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1"] isEqualToString:@"0"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Existing Children's Education Plan is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9200;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        //child 1 start
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1"] isEqualToString:@"1"]){
            if ([self.FNAEducationVC.current1.text length] == 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Current Amount for Child 1 is required."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9201;
                [alert show];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.current1.text isEqualToString:@"0.00"]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.current1.text length] != 0 && [self.FNAEducationVC.required1.text length] == 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Required Amount is required."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9202;
                [alert show];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.required1.text isEqualToString:@"0.00"]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Required Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9202;
                [alert show];
                alert = Nil;
                return FALSE;
            }
        }
        //child 1 end
        
        //child 2 start
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2"] isEqualToString:@"1"]){
            if ([self.FNAEducationVC.current2.text length] == 0 && [self.FNAEducationVC.required2.text length] == 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.current2.text isEqualToString:@"0.00"]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.current2.text length] == 0 && [self.FNAEducationVC.required2.text length] != 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.current2.text length] != 0 && [self.FNAEducationVC.required2.text length] == 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Required Amount is required."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9203;
                [alert show];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.required2.text isEqualToString:@"0.00"]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Required Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9203;
                [alert show];
                alert = Nil;
                return FALSE;
            }
        }
        else{
            if ([self.FNAEducationVC.current2.text length] != 0 || [self.FNAEducationVC.required2.text length] != 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return FALSE;
            }
        }
        //child 2 end
        
        //child 3 start
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3"] isEqualToString:@"1"]){
            if ([self.FNAEducationVC.current3.text length] == 0 && [self.FNAEducationVC.required3.text length] == 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.current3.text isEqualToString:@"0.00"]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.current3.text length] == 0 && [self.FNAEducationVC.required3.text length] != 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.current3.text length] != 0 && [self.FNAEducationVC.required3.text length] == 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Required Amount is required."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9204;
                [alert show];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.required3.text isEqualToString:@"0.00"]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Required Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9204;
                [alert show];
                alert = Nil;
                return FALSE;
            }
        }
        else{
            if ([self.FNAEducationVC.current3.text length] != 0 || [self.FNAEducationVC.required3.text length] != 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return FALSE;
            }
        }
        //child 3 end
        
        //child 4 start
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4"] isEqualToString:@"1"]){
            if ([self.FNAEducationVC.current4.text length] == 0 && [self.FNAEducationVC.required4.text length] == 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.current4.text isEqualToString:@"0.00"]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.current4.text length] == 0 && [self.FNAEducationVC.required4.text length] != 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.current4.text length] != 0 && [self.FNAEducationVC.required4.text length] != 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Required Amount is required."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9205;
                [alert show];
                alert = Nil;
                return FALSE;
            }
            else if ([self.FNAEducationVC.required4.text isEqualToString:@"0.00"]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Required Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 9205;
                [alert show];
                alert = Nil;
                return FALSE;
            }
        }
        else{
            if ([self.FNAEducationVC.current4.text length] != 0 || [self.FNAEducationVC.required4.text length] != 0){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"iMobile Planner"
                                      message:@"Please check Existing Children's coverage."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return FALSE;
            }
        }
        //child 4 end
        
        
        
        
    }
    else{
        if ([self.FNAEducationVC.required1.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Required Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9202;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNAEducationVC.required2.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Required Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9203;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNAEducationVC.required3.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Required Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9204;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNAEducationVC.required4.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Required Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9205;
            [alert show];
            alert = Nil;
            return FALSE;
        }
    }
    
    if ([self.FNAEducationVC.customerAlloc.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Current Income allocation is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9206;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    
    if ([self.FNAEducationVC.customerAlloc.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Allocate Income must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9206;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    
    
    /*
     if (self.FNAEducationVC.EducationSelected && [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1"] isEqualToString:@"0"]){
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @"iMobile Planner"
     message:@"Existing Children's Education Plan is required."
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     alert.tag = 9200;
     [alert show];
     alert = Nil;
     return FALSE;
     }
     else if (!self.FNAEducationVC.EducationSelected){ //ignore first
     if ([self.FNAEducationVC.current1.text length] != 0 && [self.FNAEducationVC.required1.text length] == 0){
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @"iMobile Planner"
     message:@"Required Amount is required."
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     alert.tag = 9202;
     [alert show];
     alert = Nil;
     return FALSE;
     }
     else if ([self.FNAEducationVC.customerAlloc.text length] == 0){
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @"iMobile Planner"
     message:@"Current Income allocation is required."
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     alert.tag = 9205;
     [alert show];
     alert = Nil;
     return FALSE;
     }
     }//ignore first
     
     
     
     else if ([self.FNAEducationVC.current1.text length] == 0){
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @"iMobile Planner"
     message:@"Current Amount for Child 1 is required."
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     alert.tag = 9201;
     [alert show];
     alert = Nil;
     return FALSE;
     }
     
     else if ([self.FNAEducationVC.current1.text length] != 0 && [self.FNAEducationVC.required1.text length] == 0){
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @"iMobile Planner"
     message:@"Required Amount is required."
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     alert.tag = 9202;
     [alert show];
     alert = Nil;
     return FALSE;
     }
     
     else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2"] isEqualToString:@"1"]){
     
     }
     
     
     
     
     
     
     
     else if (([self.FNAEducationVC.current2.text length] != 0 && [self.FNAEducationVC.required2.text length] == 0) || ([self.FNAEducationVC.current2.text length] == 0 && [self.FNAEducationVC.required2.text length] != 0)){
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @"iMobile Planner"
     message:@"Please check Existing Children's coverage."
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     alert.tag = 9203;
     [alert show];
     alert = Nil;
     return FALSE;
     }
     else if (([self.FNAEducationVC.current3.text length] != 0 && [self.FNAEducationVC.required3.text length] == 0) || ([self.FNAEducationVC.current3.text length] == 0 && [self.FNAEducationVC.required3.text length] != 0)){
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @"iMobile Planner"
     message:@"Please check Existing Children's coverage."
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     alert.tag = 9204;
     [alert show];
     alert = Nil;
     return FALSE;
     }
     else if (([self.FNAEducationVC.current4.text length] != 0 && [self.FNAEducationVC.required4.text length] == 0) || ([self.FNAEducationVC.current4.text length] == 0 && [self.FNAEducationVC.required4.text length] != 0)){
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @"iMobile Planner"
     message:@"Please check Existing Children's coverage."
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     alert.tag = 9204;
     [alert show];
     alert = Nil;
     return FALSE;
     }
     
     
     
     
     
     
     else if ([self.FNAEducationVC.customerAlloc.text length] == 0){
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @"iMobile Planner"
     message:@"Current Income allocation is required."
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     alert.tag = 9205;
     [alert show];
     alert = Nil;
     return FALSE;
     }
     */
    [[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"1" forKey:@"Completed"];
    return TRUE;
}

-(BOOL)validSecFSavings{
    if (self.FNASavingsVC.SavingsSelected && [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1"] isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Existing Savings and Investment Plan is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9300;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if (!self.FNASavingsVC.SavingsSelected){
        if ([self.FNASavingsVC.required1.text length] == 0){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Required Amount is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9302;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNASavingsVC.customerAlloc.text length] == 0){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Current Income allocation is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9304;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        
    }
    else if ([self.FNASavingsVC.current1.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Current Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9301;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNASavingsVC.current1.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Current Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9301;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNASavingsVC.current1.text length] != 0 && [self.FNASavingsVC.required1.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Required Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9302;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNASavingsVC.required1.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Required Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9302;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNASavingsVC.customerAlloc.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Current Income allocation is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9304;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNASavingsVC.customerAlloc.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Allocate Income must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9304;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ProtectionNeedValidation"];
    [[obj.CFFData objectForKey:@"SecFSavings"] setValue:@"1" forKey:@"Completed"];
    return TRUE;
}

-(BOOL)validSecFRetirement{
    if (self.FNARetirementVC.RetirementSelected && [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1"] isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Retirement Plan is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9100;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if (!self.FNARetirementVC.RetirementSelected){
        if ([self.FNARetirementVC.required1.text length] == 0){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Required Amount is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9107;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNARetirementVC.required1.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Required Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9142;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNARetirementVC.customerAlloc.text length] == 0){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Current Income allocation is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9106;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNARetirementVC.customerAlloc.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Allocate Income must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9146;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNARetirementVC.partnerAlloc.text length] == 0 && ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"])){ //fix for bug 2627
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Current Income allocation is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9116;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNARetirementVC.partnerAlloc.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Allocate Income must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9147;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNARetirementVC.customerRely.text length] == 0){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Source of Income is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9117;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        
        else if ([self.FNARetirementVC.partnerRely.text length] == 0 && ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"])){ //for partner --- //fix for bug 2627
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Source of Income is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9118;
            [alert show];
            alert = Nil;
            return FALSE;
        }
    }
    else if ([self.FNARetirementVC.current1.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Current Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9101;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    
    else if ([self.FNARetirementVC.current1.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Current Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9141;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    
    else if ([self.FNARetirementVC.current1.text length] != 0 && [self.FNARetirementVC.required1.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Required Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9102;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNARetirementVC.required1.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Required Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9142;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    
    else if ([self.FNARetirementVC.customerAlloc.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Current Income allocation is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9106;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNARetirementVC.customerAlloc.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Allocate Income must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9146;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNARetirementVC.partnerAlloc.text length] == 0 && ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"])){ //fix for bug 2627
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Current Income allocation is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9116;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNARetirementVC.partnerAlloc.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Allocate Income must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9147;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    
    else if ([self.FNARetirementVC.customerRely.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Source of Income is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9117;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    
    else if ([self.FNARetirementVC.partnerRely.text length] == 0 && ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"])){ //fix for bug 2627
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Source of Income is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9118;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"RetirementNeedValidation"];
    [[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"1" forKey:@"Completed"];
    return TRUE;
}

-(BOOL)validSecFProtection{
    if (self.FNAProtectionVC.ProtectionSelected && [[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1"] isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Existing Protection Plan is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9000;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    
    if (self.FNAProtectionVC.ProtectionSelected && [self.FNAProtectionVC.current1.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Please check Existing Protection's coverage."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        //alert.tag = 9000;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    
    
    /*
     else if ([self.FNAProtectionVC.current1.text isEqualToString:@"0.00"] && !self.FNAProtectionVC.ProtectionSelected){
     UIAlertView *alert = [[UIAlertView alloc]
     initWithTitle: @"iMobile Planner"
     message:@"Please check Existing Protection's coverage."
     delegate: self
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil];
     [alert show];
     alert = Nil;
     return FALSE;
     }
     */
    else if (!self.FNAProtectionVC.ProtectionSelected){
        if ([self.FNAProtectionVC.required1.text length] == 0 && [self.FNAProtectionVC.required2.text length] == 0 && [self.FNAProtectionVC.required3.text length] == 0 && [self.FNAProtectionVC.required4.text length] == 0){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"At least one Required Amount for Protection Plan is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9007;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNAProtectionVC.required1.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Required Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9032;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNAProtectionVC.required2.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Required Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9033;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNAProtectionVC.required3.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Required Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9034;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNAProtectionVC.required4.text isEqualToString:@"0.00"]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Required Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9035;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNAProtectionVC.customerAlloc.text length] == 0){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Current Income allocation is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9006;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        else if ([self.FNAProtectionVC.partnerAlloc.text length] == 0 && ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"])){ //fix for bug 2627
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Current Income allocation is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 9010;
            [alert show];
            alert = Nil;
            return FALSE;
        }
    }
    
    else if ([self.FNAProtectionVC.current1.text length] == 0 && [self.FNAProtectionVC.current2.text length] == 0 && [self.FNAProtectionVC.current3.text length] == 0 && [self.FNAProtectionVC.current4.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"At least one Current Amount for Protection is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9001;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.current1.text length] != 0 && [self.FNAProtectionVC.required1.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Required Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9002;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.required1.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Required Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9032;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    
    else if ([self.FNAProtectionVC.current2.text length] != 0 && [self.FNAProtectionVC.required2.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Required Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9003;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.required2.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Required Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9033;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.required2.text length] != 0 && [self.FNAProtectionVC.current2.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Current Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9023;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.current3.text length] != 0 && [self.FNAProtectionVC.required3.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Required Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9004;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.required3.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Required Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9034;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.required3.text length] != 0 && [self.FNAProtectionVC.current3.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Current Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9024;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    
    else if ([self.FNAProtectionVC.current4.text length] != 0 && [self.FNAProtectionVC.required4.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Required Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9005;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.required4.text isEqualToString:@"0.00"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Required Amount must be a numerical amount greater than 0 and, maximum 13 digits with 2 decimal points."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9035;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.required4.text length] != 0 && [self.FNAProtectionVC.current4.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Current Amount is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9025;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    
    else if ([self.FNAProtectionVC.customerAlloc.text length] == 0){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Current Income allocation is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9006;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if ([self.FNAProtectionVC.partnerAlloc.text length] == 0 && ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"])){ //fix for bug 2627
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Current Income allocation is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 9010;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    [[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"1" forKey:@"Completed"];
    return TRUE;
}

-(BOOL)validSecG{
    NSString *reasonP1;
    NSString *actionP1;
    
    NSString *additionalP2;
    NSString *reasonP2;
    
    
    
    reasonP1 = self.RecordVC.ReasonP1.text;
    actionP1 = self.RecordVC.ActionP1.text;
    
    additionalP2 = self.RecordVC.AdditionalBenefitsP2.text;
    reasonP2 = self.RecordVC.ReasonP2.text;
    
    if ([reasonP1 isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Reason for recommending is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 10001;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    
    //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CurrentSection"]);
    
    //P2 needs validation
    if ([self.RecordVC.TypeOfPlanP2.text isEqualToString:@""] && [self.RecordVC.TermP2.text isEqualToString:@""] && [self.RecordVC.SumAssuredP2.text isEqualToString:@""] && [self.RecordVC.NameofInsuredP2.text isEqualToString:@""] && [reasonP2 isEqualToString:@""]){
        NSLog(@"assa");
    }
    else{
        if ([self.RecordVC.TypeOfPlanP2.text isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Plan Type is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 10002;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        if ([self.RecordVC.TermP2.text isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Term is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 10003;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        if ([self.RecordVC.SumAssuredP2.text isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Sum Assured is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 10004;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        
        if ([self.RecordVC.NameofInsuredP2.text isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Name of insured is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 10005;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        if ([reasonP2 isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Reason for recommending is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 10006;
            [alert show];
            alert = Nil;
            return FALSE;
        }
    }
    
    //Priority 1
    [[obj.CFFData objectForKey:@"SecG"] setValue:self.RecordVC.NameOfInsurerP1.text forKey:@"NameOfInsurerP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:reasonP1 forKey:@"ReasonP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:actionP1 forKey:@"ActionP1"];
    
    //Priority 2
    [[obj.CFFData objectForKey:@"SecG"] setValue:self.RecordVC.TypeOfPlanP2.text forKey:@"TypeOfPlanP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:self.RecordVC.TermP2.text forKey:@"TermP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"SumAssuredP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:self.RecordVC.NameofInsurerP2.text forKey:@"NameOfInsurerP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:self.RecordVC.NameofInsuredP2.text forKey:@"NameOfInsuredP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:additionalP2 forKey:@"AdditionalP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:reasonP2 forKey:@"ReasonP2"];
    
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"1" forKey:@"Completed"];
    return TRUE;
}

-(BOOL)validSecH{
    if ([self.DeclareCFFVC.IntermediaryCodeContractDate.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Intermediary's Contract Date is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 20001;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    [fmtDate setDateFormat:@"dd/MM/yyyy"];
    NSDate *convertedDOB = [fmtDate dateFromString:self.DeclareCFFVC.IntermediaryCodeContractDate.text];
    if (convertedDOB == nil){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Invalid Date date format."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 20003;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    
    //if (![self.DeclareCFFVC.IntermediaryCodeContractDate.text isEqualToString:@""]){
    if ([self.DeclareCFFVC.NameOfManager.text isEqualToString:@""]){
        NSDate *startDate = [fmtDate dateFromString:self.DeclareCFFVC.IntermediaryCodeContractDate.text];
        NSString *textDate = [NSString stringWithFormat:@"%@",[fmtDate stringFromDate:[NSDate date]]];
        NSDate *endDate = [fmtDate dateFromString:textDate];
        
        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                            fromDate:startDate
                                                              toDate:endDate
                                                             options:0];
        
        if ([components day] < 365){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Name of Manager is required for agent's with contract 1 year and below."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 20009;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        else {
            self.DeclareCFFVC.NameOfManager.text = @"";
            [self.myTableView reloadData];
        }
    }
    else if (![self.DeclareCFFVC.NameOfManager.text isEqualToString:@""]){
        NSDate *startDate = [fmtDate dateFromString:self.DeclareCFFVC.IntermediaryCodeContractDate.text];
        NSString *textDate = [NSString stringWithFormat:@"%@",[fmtDate stringFromDate:[NSDate date]]];
        NSDate *endDate = [fmtDate dateFromString:textDate];
        
        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                            fromDate:startDate
                                                              toDate:endDate
                                                             options:0];
        
        if ([components day] > 365){
            self.DeclareCFFVC.NameOfManager.text = @"";
            [[obj.CFFData objectForKey:@"SecH"] setValue:@"0" forKey:@"Completed"];
            NSLog(@"SecH Completed: %@", [obj.CFFData objectForKey:@"SecH"]);
            [self.myTableView reloadData];
            return false;
        }
    }

    
    //fmtDate = Nil;
    
    if ([self.DeclareCFFVC.IntermediaryCode.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"iMobile Planner"
                              message:@"Intermediary Code is required"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 20012;
        [alert show];
        alert = nil;
        return FALSE;
    }
    
    if ([self.DeclareCFFVC.NameOfIntermediary.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"iMobile Planner"
                              message:@"Name of intermediary is required"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 20013;
        [alert show];
        alert = nil;
        return FALSE;
    }
    
    if ([self.DeclareCFFVC.IntermediaryNRIC.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"iMobile Planner"
                              message:@"NRIC of intermediary is required"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 20014;
        [alert show];
        alert = nil;
        return FALSE;
    }
    
    if ([self.DeclareCFFVC.IntermediaryAddress1.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Address of intermediary is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 20002;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    
    if ([self.DeclareCFFVC.selected isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Customer acknowledgement is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 21003;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    
    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.IntermediaryCodeContractDate.text forKey:@"IntermediaryCodeContractDate"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.IntermediaryCode.text forKey:@"IntermediaryCode"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.NameOfIntermediary.text forKey:@"NameOfIntermediary"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.IntermediaryNRIC.text forKey:@"IntermediaryNRIC"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.IntermediaryAddress1.text forKey:@"IntermediaryAddress1"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.IntermediaryAddress2.text forKey:@"IntermediaryAddress2"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.IntermediaryAddress3.text forKey:@"IntermediaryAddress3"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.IntermediaryAddress4.text forKey:@"IntermediaryAddress4"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.NameOfManager.text forKey:@"NameOfManager"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.selected forKey:@"CustomerAcknowledgement"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:self.DeclareCFFVC.AdditionalComment.text forKey:@"AdditionalComment"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:@"1" forKey:@"Completed"];
    return TRUE;
}

-(BOOL)validSecI{
    
    if ([self.ConfirmCFFVC.Advice1 isEqualToString:@"0"] && [self.ConfirmCFFVC.Advice2 isEqualToString:@"0"] && [self.ConfirmCFFVC.Advice3 isEqualToString:@"0"] && [self.ConfirmCFFVC.Advice4 isEqualToString:@"0"] && [self.ConfirmCFFVC.Advice5 isEqualToString:@"0"] && [self.ConfirmCFFVC.Advice6 isEqualToString:@"0"]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message:@"Confirmation of Adcice given is required."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 30001;
        [alert show];
        alert = Nil;
        return FALSE;
    }
    [[obj.CFFData objectForKey:@"SecI"] setValue:self.ConfirmCFFVC.Advice1 forKey:@"Advice1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:self.ConfirmCFFVC.Advice2 forKey:@"Advice2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:self.ConfirmCFFVC.Advice3 forKey:@"Advice3"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:self.ConfirmCFFVC.Advice4 forKey:@"Advice4"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:self.ConfirmCFFVC.Advice5 forKey:@"Advice5"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:self.ConfirmCFFVC.Advice6 forKey:@"Advice6"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:self.ConfirmCFFVC.othersField.text forKey:@"Advice6Others"];
    
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"1" forKey:@"Completed"];
    return TRUE;
}


-(void)saveCreateCFF:(int)toSave{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
    if (![db open]) {
        NSLog(@"Could not open db.");
    }
    [db beginTransaction];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *commDate = [dateFormatter stringFromDate:[NSDate date]];
    int lastId;
    
    //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecFProtection"] objectForKey:@"Completed"]);
    
    if ([[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"CFFCreate"] isEqualToString:@"1"]){
        [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@CFF_Master(ClientProfileID,CreatedAt,LastUpdatedAt,Status,CFFType) VALUES(?,?,?,?,?);", tableNamePrefix],[[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CFFClientIndex"],commDate,commDate,@"0",@"Master",nil];
        
        lastId = [db lastInsertRowId];
        [[obj.CFFData objectForKey:@"CFF"] setValue:[NSString stringWithFormat:@"%d",lastId] forKey:@"lastId"];
        
        
        
        
        NSString *query = @"";
        query = [NSString stringWithFormat:@"UPDATE %@CFF_Master SET IntermediaryCode = '%@', IntermediaryName = '%@', IntermediaryNRIC = '%@', IntermediaryContractDate = '%@', IntermediaryAddress1 = '%@', IntermediaryAddress2 = '%@', IntermediaryAddress3 = '%@', IntermediaryAddress4 = '%@', IntermediaryManagerName = '%@', ClientAck = '%@', ClientComments = '%@' WHERE ID = %d", tableNamePrefix, [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCode"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"NameOfIntermediary"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryNRIC"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCodeContractDate"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress1"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress2"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress3"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryAddress4"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"NameOfManager"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"CustomerAcknowledgement"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"AdditionalComment"], lastId];
        [db executeUpdate:query];
        
        
        
    }
    
    NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP" ] objectForKey:@"eProposalNo"];
    lastId = [[[obj.CFFData objectForKey:@"CFF"] objectForKey:@"lastId"] intValue];
    
    if (eApp) {
        FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM eProposal_CFF_MASTER WHERE eProposalNo = %@", eProposalNo]];
        if (![result next]) {
            [db executeUpdate:@"INSERT INTO eProposal_CFF_Master(ID, eProposalNo,ClientProfileID,CreatedAt,LastUpdatedAt,Status,CFFType) VALUES(?,?,?,?,?,?,?);", [NSString stringWithFormat:@"%d",lastId],eProposalNo, [[obj.CFFData objectForKey:@"Sections"] objectForKey:@"CFFClientIndex"],commDate,commDate,@"0",@"Master",nil];
        }
        
        NSString *query = @"";
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET IntermediaryCode = '%@', IntermediaryName = '%@', IntermediaryNRIC = '%@', IntermediaryContractDate = '%@', IntermediaryAddress1 = '%@', IntermediaryAddress2 = '%@', IntermediaryAddress3 = '%@', IntermediaryAddress4 = '%@', IntermediaryManagerName = '%@', ClientAck = '%@', ClientComments = '%@' WHERE ID = %d AND eProposalNo = %@", [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCode"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"NameOfIntermediary"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryNRIC"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCodeContractDate"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress1"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress2"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress3"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryAddress4"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"NameOfManager"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"CustomerAcknowledgement"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"AdditionalComment"], lastId, eProposalNo];
        [db executeUpdate:query];
    }
    
    
    
    //section A
    if ([[[obj.CFFData objectForKey:@"SecA"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        NSString *query = @"";
        query = [NSString stringWithFormat:@"UPDATE %@CFF_Master SET IntermediaryStatus= '%@', BrokerName = '%@' WHERE ID = %d", tableNamePrefix, [[obj.CFFData objectForKey:@"SecA"] objectForKey:@"Disclosure"],[[obj.CFFData objectForKey:@"SecA"] objectForKey:@"BrokerName"],lastId];
        [db executeUpdate:query];
    }
    
    //section B
    if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        NSString *query = @"";
        query = [NSString stringWithFormat:@"UPDATE %@CFF_Master SET ClientChoice= '%@' WHERE ID = %d", tableNamePrefix, [[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"],lastId];
        [db executeUpdate:query];
    }
    
    //section C
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        //NSLog(@"afasfasf");
        
        NSString *query = @"";
        query = [NSString stringWithFormat:@"UPDATE %@CFF_Master SET PartnerClientProfileID = '%@' WHERE ID = %d", tableNamePrefix, [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerProfileID"],lastId];
        [db executeUpdate:query];
        
        [db executeUpdate:@"DELETE FROM %@CFF_Family_Details WHERE CFFID = ?", tableNamePrefix,[NSString stringWithFormat:@"%d",lastId],Nil];
        
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden1"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Family_Details(CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport) VALUES(?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"-1",@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Name"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Relationship"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Support"],Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Family_Details(eProposalNo, CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo, [NSString stringWithFormat:@"%d",lastId],@"-1",@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Name"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Relationship"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Support"],Nil];
            }
            
        }
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden2"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Family_Details(CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport) VALUES(?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"-1",@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Name"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Relationship"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Support"],Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Family_Details(eProposalNo, CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo, [NSString stringWithFormat:@"%d",lastId],@"-1",@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Name"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Relationship"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Support"],Nil];
            }
            
        }
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden3"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Family_Details(CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport) VALUES(?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"-1",@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Name"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Relationship"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Support"],Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Family_Details(eProposalNo, CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"-1",@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Name"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Relationship"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Support"],Nil];
            }
            
        }
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden4"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Family_Details(CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport) VALUES(?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"-1",@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Name"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4R4elationship"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Support"],Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Family_Details(eProposalNo, CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo, [NSString stringWithFormat:@"%d",lastId],@"-1",@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Name"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4R4elationship"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Support"],Nil];
            }
            
        }
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden5"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Family_Details(CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport) VALUES(?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"-1",@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Name"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Relationship"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Support"],Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Family_Details(eProposal,CFFID,AddFromCFF,CompleteFlag,SameAsPO,PTypeCode,Name,Relationship,RelationshipIndexNo,DOB,Age,Sex,YearsToSupport) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"],eProposalNo, [NSString stringWithFormat:@"%d",lastId],@"-1",@"Y",@"0",@"",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Name"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Relationship"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5RelationshipIndex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5DOB"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Age"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Sex"],[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Support"],Nil];
            }
            
        }
        
    }
    
    
    //section D
    if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        NSString *query = @"";
        query = [NSString stringWithFormat:@"UPDATE %@CFF_Master SET NeedsQ1_Ans1 = '%@', NeedsQ1_Ans2 = '%@', NeedsQ1_Priority = '%@', NeedsQ2_Ans1 = '%@', NeedsQ2_Ans2 = '%@', NeedsQ2_Priority = '%@', NeedsQ3_Ans1 = '%@', NeedsQ3_Ans2 = '%@', NeedsQ3_Priority = '%@', NeedsQ4_Ans1 = '%@', NeedsQ4_Ans2 = '%@', NeedsQ4_Priority = '%@', NeedsQ5_Ans1 = '%@', NeedsQ5_Ans2 = '%@', NeedsQ5_Priority = '%@' WHERE ID = %d", tableNamePrefix,[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Ans1"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Ans2"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Priority"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Ans1"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Ans2"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Priority"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Ans1"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Ans2"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Priority"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Ans1"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Ans2"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Priority"],[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Ans1"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Ans2"], [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Priority"], lastId];
        [db executeUpdate:query];
    }
    
    //section E
    if ([[[obj.CFFData objectForKey:@"SecE"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        NSString *query = @"";
        query = [NSString stringWithFormat:@"UPDATE %@CFF_Master SET RiskReturnProfile = '%@' WHERE ID = %d",[[obj.CFFData objectForKey:@"SecE"] objectForKey:@"Preference"], tableNamePrefix,lastId];
        [db executeUpdate:query];
    }
    
    
    //section F Protection
    if ([[[obj.CFFData objectForKey:@"SecFProtection"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        //0 tick
        //-1 not tick
        if (!eApp) {
            [db executeUpdate:@"DELETE FROM CFF_Protection WHERE CFFID = ?", [NSString stringWithFormat:@"%d",lastId]];
            
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Protection(CFFID,NoExistingPlan,AllocateIncome_1,AllocateIncome_2,TotalSA_CurrentAmt,TotalSA_RequiredAmt,TotalSA_SurplusShortFall,TotalCISA_CurrentAmt,TotalCISA_RequiredAmt,TotalCISA_SurplusShortFall,TotalHB_CurrentAmt,TotalHB_RequiredAmt,TotalHB_SurplusShortFall,TotalPA_CurrentAmt,TotalPA_RequiredAmt,TotalPA_SurplusShortFall) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasProtection"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCustomerAlloc"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionPartnerAlloc"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference4"]];
            
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
        }
        else if (eApp) {
            [db executeUpdate:@"DELETE FROM eProposal_CFF_Protection WHERE CFFID = ? AND eProposalNo = ?", [NSString stringWithFormat:@"%d",lastId], eProposalNo];
            
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Protection(eProposalNo,CFFID,NoExistingPlan,AllocateIncome_1,AllocateIncome_2,TotalSA_CurrentAmt,TotalSA_RequiredAmt,TotalSA_SurplusShortFall,TotalCISA_CurrentAmt,TotalCISA_RequiredAmt,TotalCISA_SurplusShortFall,TotalHB_CurrentAmt,TotalHB_RequiredAmt,TotalHB_SurplusShortFall,TotalPA_CurrentAmt,TotalPA_RequiredAmt,TotalPA_SurplusShortFall) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?;"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasProtection"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCustomerAlloc"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionPartnerAlloc"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference4"]];
            
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
        }
        
        
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Protection_Details(CFFID,SeqNo,POName,CompanyName,PlanType,LifeAssuredName,Benefit1,Benefit2,Benefit3,Benefit4,Premium,Mode,MaturityDate) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"1",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1LifeAssured"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1DeathBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1DisabilityBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1CriticalIllnessBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1OtherBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1PremiumContribution"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1Mode"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1MaturityDate"]];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Protection_Details(eProposalNo, CFFID,SeqNo,POName,CompanyName,PlanType,LifeAssuredName,Benefit1,Benefit2,Benefit3,Benefit4,Premium,Mode,MaturityDate) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"1",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1LifeAssured"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1DeathBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1DisabilityBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1CriticalIllnessBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1OtherBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1PremiumContribution"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1Mode"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1MaturityDate"]];
            }
            
        }
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Protection_Details(CFFID,SeqNo,POName,CompanyName,PlanType,LifeAssuredName,Benefit1,Benefit2,Benefit3,Benefit4,Premium,Mode,MaturityDate) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2LifeAssured"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2DeathBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2DisabilityBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2CriticalIllnessBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2OtherBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2PremiumContribution"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2Mode"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2MaturityDate"]];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Protection_Details(eProposalNo,CFFID,SeqNo,POName,CompanyName,PlanType,LifeAssuredName,Benefit1,Benefit2,Benefit3,Benefit4,Premium,Mode,MaturityDate) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2LifeAssured"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2DeathBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2DisabilityBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2CriticalIllnessBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2OtherBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2PremiumContribution"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2Mode"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2MaturityDate"]];
            }
            
        }
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Protection_Details(CFFID,SeqNo,POName,CompanyName,PlanType,LifeAssuredName,Benefit1,Benefit2,Benefit3,Benefit4,Premium,Mode,MaturityDate) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"3",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3LifeAssured"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3DeathBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3DisabilityBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3CriticalIllnessBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3OtherBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3PremiumContribution"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3Mode"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3MaturityDate"]];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Protection_Details(eProposalNo,CFFID,SeqNo,POName,CompanyName,PlanType,LifeAssuredName,Benefit1,Benefit2,Benefit3,Benefit4,Premium,Mode,MaturityDate) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"3",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3LifeAssured"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3DeathBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3DisabilityBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3CriticalIllnessBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3OtherBenefit"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3PremiumContribution"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3Mode"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3MaturityDate"]];
            }
            
        }
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasProtection"] isEqualToString:@"-1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"],[NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"],[NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProsolaNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
            }
            
        }
        
        if (self.CustomerVC.checkboxButton3.selected){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection WHERE CFFID = ? AND eProposalNo = ?"],[NSString stringWithFormat:@"%d", lastId], lastId, eProposalNo];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo, Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo, Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Protection_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo, Nil];
            }
            
        }
        
    }
    
    if ([[[obj.CFFData objectForKey:@"SecFRetirement"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
            
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Retirement(CFFID,NoExistingPlan,AllocateIncome_1,AllocateIncome_2,CurrentAmt,RequiredAmt,SurplusShortFallAmt,OtherIncome_1,OtherIncome_2) VALUES(?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasRetirement"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementCustomerAlloc"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementPartnerAlloc"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementCurrent1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementRequired1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementDifference1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementCustomerRely"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementPartnerRely"]];
            
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
        }
        else if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
            
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Retirement(eProposalNo,CFFID,NoExistingPlan,AllocateIncome_1,AllocateIncome_2,CurrentAmt,RequiredAmt,SurplusShortFallAmt,OtherIncome_1,OtherIncome_2) VALUES(?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasRetirement"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementCustomerAlloc"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementPartnerAlloc"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementCurrent1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementRequired1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementDifference1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementCustomerRely"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementPartnerRely"]];
            
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1", eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
        }
        
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Retirement_Details(CFFID,SeqNo,POName,CompanyName,PlanType,Premium,Frequency,StartDate,MaturityDate,ProjectedLumSum,ProjectedAnnualIncome,AdditionalBenefits) VALUES(?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"1",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1SumMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1IncomeMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1AdditionalBenefit"],Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Retirement_Details(eProposalNo, CFFID,SeqNo,POName,CompanyName,PlanType,Premium,Frequency,StartDate,MaturityDate,ProjectedLumSum,ProjectedAnnualIncome,AdditionalBenefits) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"1",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1SumMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1IncomeMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1AdditionalBenefit"],Nil];
            }
        
        }
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Retirement_Details(CFFID,SeqNo,POName,CompanyName,PlanType,Premium,Frequency,StartDate,MaturityDate,ProjectedLumSum,ProjectedAnnualIncome,AdditionalBenefits) VALUES(?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2SumMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2IncomeMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2AdditionalBenefit"],Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Retirement_Details(eProposalNo,CFFID,SeqNo,POName,CompanyName,PlanType,Premium,Frequency,StartDate,MaturityDate,ProjectedLumSum,ProjectedAnnualIncome,AdditionalBenefits) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2SumMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2IncomeMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2AdditionalBenefit"],Nil];
            }
        
        }
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Retirement_Details(CFFID,SeqNo,POName,CompanyName,PlanType,Premium,Frequency,StartDate,MaturityDate,ProjectedLumSum,ProjectedAnnualIncome,AdditionalBenefits) VALUES(?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"3",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2SumMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3IncomeMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3AdditionalBenefit"],Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Retirement_Details(eProposalNo,CFFID,SeqNo,POName,CompanyName,PlanType,Premium,Frequency,StartDate,MaturityDate,ProjectedLumSum,ProjectedAnnualIncome,AdditionalBenefits) VALUES(?,?,?,?,?,?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"3",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement2SumMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3IncomeMaturity"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement3AdditionalBenefit"],Nil];
            }
            
        }
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasRetirement"] isEqualToString:@"-1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1", eProposalNo,Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2", eProposalNo, Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3", eProposalNo, Nil];
            }
            
        }
        
        if (self.CustomerVC.checkboxButton3.selected){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId], eProposalNo];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Retirement_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
            }
            
        }
    }
    
    //section F Education
    if ([[[obj.CFFData objectForKey:@"SecFEducation"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
            
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Education(CFFID,NoChild,NoExistingPlan,CurrentAmt_Child_1,RequiredAmt_Child_1,SurplusShortFallAmt_Child_1,CurrentAmt_Child_2,RequiredAmt_Child_2,SurplusShortFallAmt_Child_2,CurrentAmt_Child_3,RequiredAmt_Child_3,SurplusShortFallAmt_Child_3,CurrentAmt_Child_4,RequiredAmt_Child_4,SurplusShortFallAmt_Child_4,AllocateIncome_1) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasEducationChild"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasEducation"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCustomerAlloc"]];
            
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"4",Nil];
        }
        else if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
            
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Education(eProposalNo,CFFID,NoChild,NoExistingPlan,CurrentAmt_Child_1,RequiredAmt_Child_1,SurplusShortFallAmt_Child_1,CurrentAmt_Child_2,RequiredAmt_Child_2,SurplusShortFallAmt_Child_2,CurrentAmt_Child_3,RequiredAmt_Child_3,SurplusShortFallAmt_Child_3,CurrentAmt_Child_4,RequiredAmt_Child_4,SurplusShortFallAmt_Child_4,AllocateIncome_1) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);"],eProposalNo, [NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasEducationChild"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasEducation"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference2"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference3"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference4"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCustomerAlloc"]];
            
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"4",eProposalNo,Nil];
        }
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Education_Details(CFFID,SeqNo,Name,CompanyName,Premium,Frequency,StartDate,MaturityDate,ProjectedValueAtMaturity) VALUES(?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"1",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1ChildName"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1ValueMaturity"],Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Education_Details(eProposal, CFFID,SeqNo,Name,CompanyName,Premium,Frequency,StartDate,MaturityDate,ProjectedValueAtMaturity) VALUES(?,?,?,?,?,?,?,?,?,?);"], eProposalNo, [NSString stringWithFormat:@"%d",lastId],@"1",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1ChildName"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1ValueMaturity"],Nil];
            }
        
        }
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Education_Details(CFFID,SeqNo,Name,CompanyName,Premium,Frequency,StartDate,MaturityDate,ProjectedValueAtMaturity) VALUES(?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2ChildName"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2ValueMaturity"],Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Education_Details(eProposalNo, CFFID,SeqNo,Name,CompanyName,Premium,Frequency,StartDate,MaturityDate,ProjectedValueAtMaturity) VALUES(?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2ChildName"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2ValueMaturity"],Nil];
            }
        
        }
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Education_Details(CFFID,SeqNo,Name,CompanyName,Premium,Frequency,StartDate,MaturityDate,ProjectedValueAtMaturity) VALUES(?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"3",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3ChildName"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3ValueMaturity"],Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Education_Details(eProposalNo, CFFID,SeqNo,Name,CompanyName,Premium,Frequency,StartDate,MaturityDate,ProjectedValueAtMaturity) VALUES(?,?,?,?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"3",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3ChildName"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3ValueMaturity"],Nil];
            }
        
        }
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Education_Details(CFFID,SeqNo,Name,CompanyName,Premium,Frequency,StartDate,MaturityDate,ProjectedValueAtMaturity) VALUES(?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"4",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4ChildName"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4ValueMaturity"],Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Education_Details(eProposalNo, CFFID,SeqNo,Name,CompanyName,Premium,Frequency,StartDate,MaturityDate,ProjectedValueAtMaturity) VALUES(?,?,?,?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"4",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4ChildName"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Frequency"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4StartDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4MaturityDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4ValueMaturity"],Nil];
            }
        
        }
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasEducation"] isEqualToString:@"-1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"4",Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"4",eProposalNo,Nil];
            }
        }
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasEducationChild"] isEqualToString:@"-1"]){
            
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"4",Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
                
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_Education(CFFID,NoChild,NoExistingPlan,CurrentAmt_Child_1,RequiredAmt_Child_1,SurplusShortFallAmt_Child_1,CurrentAmt_Child_2,RequiredAmt_Child_2,SurplusShortFallAmt_Child_2,CurrentAmt_Child_3,RequiredAmt_Child_3,SurplusShortFallAmt_Child_3,CurrentAmt_Child_4,RequiredAmt_Child_4,SurplusShortFallAmt_Child_4,AllocateIncome_1) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasEducationChild"],@"0",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"4",eProposalNo,Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId], eProposalNo];
                
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_Education(eProposalNo,CFFID,NoChild,NoExistingPlan,CurrentAmt_Child_1,RequiredAmt_Child_1,SurplusShortFallAmt_Child_1,CurrentAmt_Child_2,RequiredAmt_Child_2,SurplusShortFallAmt_Child_2,CurrentAmt_Child_3,RequiredAmt_Child_3,SurplusShortFallAmt_Child_3,CurrentAmt_Child_4,RequiredAmt_Child_4,SurplusShortFallAmt_Child_4,AllocateIncome_1) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasEducationChild"],@"0",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",Nil];
            }
        }
        
        if (self.CustomerVC.checkboxButton3.selected){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"4",Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_Education WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],eProposalNo];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"4",eProposalNo,Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_Education WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId],eProposalNo];
            }
            
        }
    }
    
    if ([[[obj.CFFData objectForKey:@"SecFSavings"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_SavingsInvest WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
            
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_SavingsInvest(CFFID,NoExistingPlan,CurrentAmt,RequiredAmt,SurplusShortFallAmt,AllocateIncome_1) VALUES(?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasSavings"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsCurrent1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsRequired1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsDifference1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsCustomerAlloc"],Nil];
            
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
        }
        else if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
            
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_SavingsInvest(eProposalNo,CFFID,NoExistingPlan,CurrentAmt,RequiredAmt,SurplusShortFallAmt,AllocateIncome_1) VALUES(?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasSavings"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsCurrent1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsRequired1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsDifference1"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"SavingsCustomerAlloc"],Nil];
            
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
        }
        
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_SavingsInvest_Details(CFFID,SeqNo,POName,CompanyName,PlanType,Purpose,Premium,CommDate,MaturityAmt) VALUES(?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"1",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1Purpose"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1CommDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1AmountMaturity"],Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_SavingsInvest_Details(eProposalNo,CFFID,SeqNo,POName,CompanyName,PlanType,Purpose,Premium,CommDate,MaturityAmt) VALUES(?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"1",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirement1TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1Purpose"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1CommDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings1AmountMaturity"],Nil];
            }
        
        }
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_SavingsInvest_Details(CFFID,SeqNo,POName,CompanyName,PlanType,Purpose,Premium,CommDate,MaturityAmt) VALUES(?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirem2nt1TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2Purpose"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2CommDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2AmountMaturity"],Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_SavingsInvest_Details(ePropsalNo,CFFID,SeqNo,POName,CompanyName,PlanType,Purpose,Premium,CommDate,MaturityAmt) VALUES(?,?,?,?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirem2nt1TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2Purpose"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2CommDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings2AmountMaturity"],Nil];
            }
        
        }
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3"] isEqualToString:@"1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_SavingsInvest_Details(CFFID,SeqNo,POName,CompanyName,PlanType,Purpose,Premium,CommDate,MaturityAmt) VALUES(?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"3",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirem3nt1TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3Purpose"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3CommDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3AmountMaturity"],Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_SavingsInvest_Details(CFFID,SeqNo,POName,CompanyName,PlanType,Purpose,Premium,CommDate,MaturityAmt) VALUES(?,?,?,?,?,?,?,?,?,?);"], eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"3",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3PolicyOwner"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3Company"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingRetirem3nt1TypeOfPlan"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3Purpose"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3Premium"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3CommDate"],[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingSavings3AmountMaturity"],Nil];
            }
        
        }
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasSavings"] isEqualToString:@"-1"]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",Nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
            }
        }
        
        if (self.CustomerVC.checkboxButton3.selected){
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],eProposalNo];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"1",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"2",eProposalNo,Nil];
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE CFFID = ? AND SeqNo = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],@"3",eProposalNo,Nil];
        }
    }
    
    //section G
    if ([[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_RecordOfAdvice WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
            
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_RecordOfAdvice(CFFID,SameAsQuotation,Priority,InsurerName,ReasonRecommend,ActionRemark) VALUES(?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"-1",@"1",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"NameOfInsurerP1"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"ReasonP1"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"ActionP1"],nil];
            
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_RecordOfAdvice(CFFID,SameAsQuotation,Priority,PlanType,Term,InsurerName,InsuredName,SumAssured,ReasonRecommend) VALUES(?,?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"0",@"2",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"TypeOfPlanP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"TermP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"NameOfInsurerP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"NameOfInsuredP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"SumAssuredP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"ReasonP2"],nil];
        }
        else if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_RecordOfAdvice WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],eProposalNo];
            
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_RecordOfAdvice(eProposalNo,CFFID,SameAsQuotation,Priority,InsurerName,ReasonRecommend,ActionRemark) VALUES(?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"-1",@"1",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"NameOfInsurerP1"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"ReasonP1"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"ActionP1"],nil];
            
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_RecordOfAdvice(eProposalNo,CFFID,SameAsQuotation,Priority,PlanType,Term,InsurerName,InsuredName,SumAssured,ReasonRecommend) VALUES(?,?,?,?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"0",@"2",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"TypeOfPlanP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"TermP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"NameOfInsurerP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"NameOfInsuredP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"SumAssuredP2"],[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"ReasonP2"],nil];
        }
        
        
        if (![[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"AdditionalP2"] isEqualToString:@""]){
            if (!eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_RecordOfAdvice_Rider WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_RecordOfAdvice_Rider(CFFID,Priority,RiderName,Seq) VALUES(?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"AdditionalP2"],@"1",nil];
            }
            else if (eApp) {
                [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_RecordOfAdvice_Rider WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId], eProposalNo];
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_RecordOfAdvice_Rider(eProposalNo,CFFID,Priority,RiderName,Seq) VALUES(?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],@"2",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"AdditionalP2"],@"1",nil];
            }
        }
    }
    
    //section H
    if ([[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        NSString *query = @"";
        query = [NSString stringWithFormat:@"UPDATE %@CFF_Master SET IntermediaryCode = '%@', IntermediaryName = '%@', IntermediaryNRIC = '%@', IntermediaryContractDate = '%@', IntermediaryAddress1 = '%@', IntermediaryAddress2 = '%@', IntermediaryAddress3 = '%@', IntermediaryAddress4 = '%@', IntermediaryManagerName = '%@', ClientAck = '%@', ClientComments = '%@' WHERE ID = %d", tableNamePrefix, [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCode"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"NameOfIntermediary"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryNRIC"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCodeContractDate"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress1"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress2"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress3"], [[obj.CFFData objectForKey:@"SecH"]  objectForKey:@"IntermediaryAddress4"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"NameOfManager"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"CustomerAcknowledgement"], [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"AdditionalComment"], lastId];
        [db executeUpdate:query];
    }
    
    //section I
    if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        if (!eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_CA WHERE CFFID = ?"], [NSString stringWithFormat:@"%d",lastId]];
            
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_CA(CFFID,Choice1,Choice2,Choice3,Choice4,Choice5,Choice6,Choices6Desc) VALUES(?,?,?,?,?,?,?,?);"],[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice1"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice2"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice3"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice4"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice5"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice6"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice6Others"],nil];
            
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM CFF_CA_RECOMMENDATION WHERE CFFID = ?"], [NSString stringWithFormat:@"%d", lastId]];
            
            for (int i = 1; i < 6; i++) {
                NSString *strId = [[NSString alloc] initWithFormat:@"%d", lastId];
                NSString *insured = [[NSString alloc] initWithFormat:@"NameOfInsured%d", i];
                NSString *plan = [[NSString alloc] initWithFormat:@"ProductType%d", i];
                NSString *term = [[NSString alloc] initWithFormat:@"Term%d", i];
                NSString *premium = [[NSString alloc] initWithFormat:@"Premium%d", i];
                NSString *frequency = [[NSString alloc] initWithFormat:@"Frequency%d", i];
                NSString *sa = [[NSString alloc] initWithFormat:@"SumAssured%d", i];
                NSString *bought = [[NSString alloc] initWithFormat:@"Brought%d", i];
                NSString *benefits = [[NSString alloc] initWithFormat:@"AdditionalBenefit%d", i];
                
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO CFF_CA_RECOMMENDATION(CFFID, InsuredName, PlanType, Term, Premium, Frequency, SumAssured, BoughtOption, AddNew) VALUES(?,?,?,?,?,?,?,?,?);"], strId, [[obj.CFFData objectForKey:@"SecI"] objectForKey:insured], [[obj.CFFData objectForKey:@"SecI"] objectForKey:plan], [[obj.CFFData objectForKey:@"SecI"] objectForKey:term], [[obj.CFFData objectForKey:@"SecI"] objectForKey:premium], [[obj.CFFData objectForKey:@"SecI"] objectForKey:frequency], [[obj.CFFData objectForKey:@"SecI"] objectForKey:sa], [[obj.CFFData objectForKey:@"SecI"] objectForKey:bought], [[obj.CFFData objectForKey:@"SecI"] objectForKey:benefits], nil];
            }
        }
        else if (eApp) {
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_CA WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d",lastId],eProposalNo];
            
            [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_CA(eProposalNo,CFFID,Choice1,Choice2,Choice3,Choice4,Choice5,Choice6,Choices6Desc) VALUES(?,?,?,?,?,?,?,?,?);"],eProposalNo,[NSString stringWithFormat:@"%d",lastId],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice1"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice2"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice3"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice4"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice5"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice6"],[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice6Others"],nil];
            
            [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM eProposal_CFF_CA_RECOMMENDATION WHERE CFFID = ? AND eProposalNo = ?"], [NSString stringWithFormat:@"%d", lastId], eProposalNo];
            
            for (int i = 1; i < 6; i++) {
                NSString *strId = [[NSString alloc] initWithFormat:@"%d", lastId];
                NSString *insured = [[NSString alloc] initWithFormat:@"NameOfInsured%d", i];
                NSString *plan = [[NSString alloc] initWithFormat:@"ProductType%d", i];
                NSString *term = [[NSString alloc] initWithFormat:@"Term%d", i];
                NSString *premium = [[NSString alloc] initWithFormat:@"Premium%d", i];
                NSString *frequency = [[NSString alloc] initWithFormat:@"Frequency%d", i];
                NSString *sa = [[NSString alloc] initWithFormat:@"SumAssured%d", i];
                NSString *bought = [[NSString alloc] initWithFormat:@"Brought%d", i];
                NSString *benefits = [[NSString alloc] initWithFormat:@"AdditionalBenefit%d", i];
                
                [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO eProposal_CFF_CA_RECOMMENDATION(eProposalNo,CFFID, InsuredName, PlanType, Term, Premium, Frequency, SumAssured, BoughtOption, AddNew) VALUES(?,?,?,?,?,?,?,?,?,?);"], strId, [[obj.CFFData objectForKey:@"SecI"] objectForKey:insured], [[obj.CFFData objectForKey:@"SecI"] objectForKey:plan], [[obj.CFFData objectForKey:@"SecI"] objectForKey:term], [[obj.CFFData objectForKey:@"SecI"] objectForKey:premium], [[obj.CFFData objectForKey:@"SecI"] objectForKey:frequency], [[obj.CFFData objectForKey:@"SecI"] objectForKey:sa], [[obj.CFFData objectForKey:@"SecI"] objectForKey:bought], [[obj.CFFData objectForKey:@"SecI"] objectForKey:benefits], nil];
            }
        }
        
        
    }
    
    //CFF Status
    if ([[[obj.CFFData objectForKey:@"SecA"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecE"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecFProtection"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecFRetirement"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecFEducation"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecFSavings"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"Completed"] isEqualToString:@"1"] && [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        
        NSString *query = @"";
        if (!eApp) {
            query = [NSString stringWithFormat:@"UPDATE CFF_Master SET Status = '1' WHERE ID = %d",lastId];
        }
        else if (eApp) {
            query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET Status = '1' WHERE ID = %d AND eProposalNo = '%@'",lastId, eProposalNo];
        }
        
        [db executeUpdate:query];
        self.status = @"1";
    }
    else{
        NSString *query = @"";
        if (!eApp) {
            query = [NSString stringWithFormat:@"UPDATE CFF_Master SET Status = '0' WHERE ID = %d",lastId];
        }
        else if (eApp) {
            query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET Status = '0' WHERE ID = %d AND eProposalNo = %@",lastId, eProposalNo];
        }
        [db executeUpdate:query];
        self.status = @"0";
    }
    self.cffID = [[NSString alloc] initWithFormat:@"%d", lastId];
    self.date = commDate;
    [[obj.eAppData objectForKey:@"CFF"] setValue:self.status forKey:@"Completed"];
    
    //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"Completed"]);
    if (!eApp) {
        NSString *query = @"";
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecACompleted= '%@' WHERE ID = %d", [[obj.CFFData objectForKey:@"SecA"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecBCompleted= '%@' WHERE ID = %d", [[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecCCompleted= '%@' WHERE ID = %d", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecDCompleted= '%@' WHERE ID = %d", [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecECompleted= '%@' WHERE ID = %d", [[obj.CFFData objectForKey:@"SecE"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecFProtectionCompleted= '%@' WHERE ID = %d",[[obj.CFFData objectForKey:@"SecFProtection"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecFRetirementCompleted= '%@' WHERE ID = %d",[[obj.CFFData objectForKey:@"SecFRetirement"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecFEducationCompleted= '%@' WHERE ID = %d",[[obj.CFFData objectForKey:@"SecFEducation"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecFSavingsCompleted= '%@' WHERE ID = %d",[[obj.CFFData objectForKey:@"SecFSavings"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecGCompleted= '%@' WHERE ID = %d",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecHCompleted= '%@' WHERE ID = %d",[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE CFF_Master SET SecICompleted= '%@' WHERE ID = %d",[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Completed"],lastId];
        [db executeUpdate:query];
    }
    else if (eApp) {
        NSString *query = @"";
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecACompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'", [[obj.CFFData objectForKey:@"SecA"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecBCompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'", [[obj.CFFData objectForKey:@"SecB"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecCCompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecDCompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'", [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecECompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'", [[obj.CFFData objectForKey:@"SecE"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecFProtectionCompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'",[[obj.CFFData objectForKey:@"SecFProtection"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecFRetirementCompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'",[[obj.CFFData objectForKey:@"SecFRetirement"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecFEducationCompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'",[[obj.CFFData objectForKey:@"SecFEducation"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecFSavingsCompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'",[[obj.CFFData objectForKey:@"SecFSavings"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecGCompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecHCompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'",[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
        
        query = [NSString stringWithFormat:@"UPDATE eProposal_CFF_Master SET SecICompleted= '%@' WHERE ID = %d AND eProposalNo = '%@'",[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Completed"],lastId,eProposalNo];
        [db executeUpdate:query];
    }
    
    [db commit];
    [db close];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"0" forKey:@"CFFCreate"]; //create new CFF
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"0" forKey:@"CFFSave"]; //save CFF
    
    if (toSave == 1)
        [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

-(void)loadDBData {
    
    int indexNo;
    NSString *clientName;
    NSString *clientID;
    NSString *CFFID;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results;
    FMResultSet *eAppResults;
    
    obj=[DataClass getInstance];
    
    NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    
    results = [database executeQuery:@"SELECT ID FROM eProposal_CFF_MASTER WHERE eProposalNo = ?", eProposalNo];
    while ([results next]) {
        CFFID = [results objectForColumnName:@"ID"];
    }
    NSLog(@"eProposalNo = %@, CCFID = %@", eProposalNo, CFFID);
    if (!CFFID) {
        return;
        NSLog(@"Stop");
    }
    NSLog(@"Goes on");
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    
    obj.CFFData = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"CFF"];
    [data removeAllObjects];
    
    
    [obj.CFFData setObject:data forKey:@"Sections"];
    [data removeAllObjects];
    
    [obj.CFFData setObject:data forKey:@"SecA"];
    data = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"SecB"];
    data = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"SecC"];
    data = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"SecD"];
    data = [NSMutableDictionary dictionary];
    [obj.CFFData setObject:data forKey:@"SecE"];
    data = [NSMutableDictionary dictionary];
    [obj.CFFData setObject:data forKey:@"SecF"];
    data = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"SecFProtection"];
    data = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"SecFRetirement"];
    data = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"SecFEducation"];
    data = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"SecFSavings"];
    data = [NSMutableDictionary dictionary];
    
    [obj.CFFData setObject:data forKey:@"SecG"];
    data = [NSMutableDictionary dictionary];
    [obj.CFFData setObject:data forKey:@"SecH"];
    data = [NSMutableDictionary dictionary];
    [obj.CFFData setObject:data forKey:@"SecI"];
    
    //default settings for CFF
    [[obj.CFFData objectForKey:@"Sections"] setValue:@"SecA" forKey:@"CurrentSection"];
    [[obj.CFFData objectForKey:@"Sections"] setValue:clientName forKey:@"CFFClientName"];
    [[obj.CFFData objectForKey:@"Sections"] setValue:clientID forKey:@"CFFClientID"];
    [[obj.CFFData objectForKey:@"Sections"] setValue:[NSString stringWithFormat:@"%d", indexNo] forKey:@"CFFClientIndex"];
    
    //globals status
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"]; //to show do you want to save
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"SecChange"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"0" forKey:@"CFFCreate"]; //set to 0, dont create
    [[obj.CFFData objectForKey:@"CFF"] setValue:CFFID forKey:@"lastId"];
    
    
    
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"0" forKey:@"CFFValidate"]; //to validate CFF section
    
    //default for the rest of sections
    [[obj.CFFData objectForKey:@"SecB"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecD"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecE"] setValue:@"0" forKey:@"Completed"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecFSavings"] setValue:@"0" forKey:@"Completed"];
    
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecH"] setValue:@"0" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Completed"];
    
    results = nil;
    results= [database executeQuery:@"SELECT * FROM CFF_Master WHERE ID=?",CFFID];
    eAppResults = [database executeQuery:@"SELECT * FROM eProposal_CFF_MASTER WHERE ID=? AND eProposalNo = ?", CFFID, eProposalNo];
    
    bool eAppIsMoreUpdate = false;
    NSLog(@"Jello");
    while([results next])
	{
        bool eApp1 = [eAppResults next];
        if (eApp1) {
            NSLog(@"eApp available");
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"dd/MM/yyyy"];
            NSDate *standalone = [format dateFromString:[results stringForColumn:@"lastUpdatedAt"]];
            NSDate *eAppDate = [format dateFromString:[eAppResults stringForColumn:@"lastUpdatedAt"]];
            if (![eAppDate laterDate:standalone]) {
                eAppIsMoreUpdate = true;
            }
            indexNo = [[eAppResults stringForColumn:@"ClientProfileID"] intValue];
            FMResultSet *results2 = [database executeQuery:@"SELECT ProspectName, IDTypeNo FROM prospect_profile WHERE IndexNo = ?", [NSString stringWithFormat:@"%d", indexNo]];
            while ([results2 next]) {
                clientID = [results2 objectForColumnName:@"IDTypeNo"];
                clientName = [results2 objectForColumnName:@"ProspectName"];
            }
            [[obj.CFFData objectForKey:@"Sections"] setValue:clientName forKey:@"CFFClientName"];
            [[obj.CFFData objectForKey:@"Sections"] setValue:clientID forKey:@"CFFClientID"];
            [[obj.CFFData objectForKey:@"Sections"] setValue:[NSString stringWithFormat:@"%d", indexNo] forKey:@"CFFClientIndex"];
            NSLog(@"eProposalNo = %@, indexNo = %d, clientName = %@", eProposalNo, indexNo, clientName);
        }
        if (!eAppIsMoreUpdate) {
            //completed status
            [[obj.CFFData objectForKey:@"SecB"] setValue:[results stringForColumn:@"SecBCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"SecCCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"SecDCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecE"] setValue:[results stringForColumn:@"SecECompleted"] forKey:@"Completed"];
            
            
            [[obj.CFFData objectForKey:@"SecFProtection"] setValue:[results stringForColumn:@"SecFProtectionCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecFRetirement"] setValue:[results stringForColumn:@"SecFRetirementCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecFEducation"] setValue:[results stringForColumn:@"SecFEducationCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecFSavings"] setValue:[results stringForColumn:@"SecFSavingsCompleted"] forKey:@"Completed"];
            
            if ([[results stringForColumn:@"ClientChoice"] isEqualToString:@"1"]){
                if ([[results stringForColumn:@"SecFProtectionCompleted"] isEqualToString:@"1"] && [[results stringForColumn:@"SecFRetirementCompleted"] isEqualToString:@"1"] && [[results stringForColumn:@"SecFEducationCompleted"] isEqualToString:@"1"] && [[results stringForColumn:@"SecFSavingsCompleted"] isEqualToString:@"1"]){
                    [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"Completed"];
                }
            }
            else if ([[results stringForColumn:@"ClientChoice"] isEqualToString:@"2"]){
                if ([[results stringForColumn:@"SecFProtectionCompleted"] isEqualToString:@"1"] || [[results stringForColumn:@"SecFRetirementCompleted"] isEqualToString:@"1"] || [[results stringForColumn:@"SecFEducationCompleted"] isEqualToString:@"1"] || [[results stringForColumn:@"SecFSavingsCompleted"] isEqualToString:@"1"]){
                    [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"Completed"];
                }
            }
            
            
            [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"SecGCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"SecHCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"SecICompleted"] forKey:@"Completed"];
            
            //SecA
            [[obj.CFFData objectForKey:@"SecA"] setValue:@"1" forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecA"] setValue:[results stringForColumn:@"IntermediaryStatus"] forKey:@"Disclosure"];
            [[obj.CFFData objectForKey:@"SecA"] setValue:[results stringForColumn:@"BrokerName"] forKey:@"BrokerName"];
            
            //SecB
            [[obj.CFFData objectForKey:@"SecB"] setValue:[results stringForColumn:@"ClientChoice"] forKey:@"ClientChoice"];
            
            //SecC
            if ([[results stringForColumn:@"PartnerClientProfileID"] length] == 0){
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingPartner"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerProfileID"];
            }
            else{
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingPartner"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"PartnerClientProfileID"] forKey:@"PartnerProfileID"];
            }
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"CustomerReadOnly"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"PartnerReadOnly"];
            
            //SecD
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ1_Ans1"] forKey:@"NeedsQ1_Ans1"];
            //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Ans1"]);
            //NSLog(@"QQQ%@",[results stringForColumn:@"NeedsQ1_Ans1"]);
            
            
            
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ1_Ans2"] forKey:@"NeedsQ1_Ans2"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ1_Priority"] forKey:@"NeedsQ1_Priority"];
            
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ2_Ans1"] forKey:@"NeedsQ2_Ans1"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ2_Ans2"] forKey:@"NeedsQ2_Ans2"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ2_Priority"] forKey:@"NeedsQ2_Priority"];
            
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ3_Ans1"] forKey:@"NeedsQ3_Ans1"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ3_Ans2"] forKey:@"NeedsQ3_Ans2"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ3_Priority"] forKey:@"NeedsQ3_Priority"];
            
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ4_Ans1"] forKey:@"NeedsQ4_Ans1"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ4_Ans2"] forKey:@"NeedsQ4_Ans2"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ4_Priority"] forKey:@"NeedsQ4_Priority"];
            
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ5_Ans1"] forKey:@"NeedsQ5_Ans1"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ5_Ans2"] forKey:@"NeedsQ5_Ans2"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[results stringForColumn:@"NeedsQ5_Priority"] forKey:@"NeedsQ5_Priority"];
            
            //SecE
            [[obj.CFFData objectForKey:@"SecE"] setValue:[results stringForColumn:@"RiskReturnProfile"] forKey:@"Preference"];
            
            //Sec H
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryCode"] forKey:@"IntermediaryCode"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryName"] forKey:@"NameOfIntermediary"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryNRIC"] forKey:@"IntermediaryNRIC"];
            
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryContractDate"] forKey:@"IntermediaryCodeContractDate"];
            
            NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCodeContractDate"]);
            
            
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryAddress1"] forKey:@"IntermediaryAddress1"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryAddress2"] forKey:@"IntermediaryAddress2"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryAddress3"] forKey:@"IntermediaryAddress3"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryAddress4"] forKey:@"IntermediaryAddress4"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"IntermediaryManagerName"] forKey:@"NameOfManager"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"ClientAck"] forKey:@"CustomerAcknowledgement"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[results stringForColumn:@"ClientComments"] forKey:@"AdditionalComment"];
            
            
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryCode forKey:@"IntermediaryCode"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:NameOfIntermediary forKey:@"NameOfIntermediary"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryNRIC forKey:@"IntermediaryNRIC"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress1 forKey:@"IntermediaryAddress1"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress2 forKey:@"IntermediaryAddress2"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress3 forKey:@"IntermediaryAddress3"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress4 forKey:@"IntermediaryAddress4"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:@"" forKey:@"NameOfManager"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:@"0" forKey:@"CustomerAcknowledgement"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:@"" forKey:@"AdditionalComment"];
        } else if(eAppIsMoreUpdate) {
            //completed status
            [[obj.CFFData objectForKey:@"SecB"] setValue:[eAppResults stringForColumn:@"SecBCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[eAppResults stringForColumn:@"SecCCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"SecDCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecE"] setValue:[eAppResults stringForColumn:@"SecECompleted"] forKey:@"Completed"];
            
            
            [[obj.CFFData objectForKey:@"SecFProtection"] setValue:[eAppResults stringForColumn:@"SecFProtectionCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecFRetirement"] setValue:[eAppResults stringForColumn:@"SecFRetirementCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecFEducation"] setValue:[eAppResults stringForColumn:@"SecFEducationCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecFSavings"] setValue:[eAppResults stringForColumn:@"SecFSavingsCompleted"] forKey:@"Completed"];
            
            if ([[eAppResults stringForColumn:@"ClientChoice"] isEqualToString:@"1"]){
                if ([[eAppResults stringForColumn:@"SecFProtectionCompleted"] isEqualToString:@"1"] && [[eAppResults stringForColumn:@"SecFRetirementCompleted"] isEqualToString:@"1"] && [[results stringForColumn:@"SecFEducationCompleted"] isEqualToString:@"1"] && [[eAppResults stringForColumn:@"SecFSavingsCompleted"] isEqualToString:@"1"]){
                    [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"Completed"];
                }
            }
            else if ([[eAppResults stringForColumn:@"ClientChoice"] isEqualToString:@"2"]){
                if ([[eAppResults stringForColumn:@"SecFProtectionCompleted"] isEqualToString:@"1"] || [[eAppResults stringForColumn:@"SecFRetirementCompleted"] isEqualToString:@"1"] || [[results stringForColumn:@"SecFEducationCompleted"] isEqualToString:@"1"] || [[eAppResults stringForColumn:@"SecFSavingsCompleted"] isEqualToString:@"1"]){
                    [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"Completed"];
                }
            }
            
            
            [[obj.CFFData objectForKey:@"SecG"] setValue:[eAppResults stringForColumn:@"SecGCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"SecHCompleted"] forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[eAppResults stringForColumn:@"SecICompleted"] forKey:@"Completed"];
            
            //SecA
            [[obj.CFFData objectForKey:@"SecA"] setValue:@"1" forKey:@"Completed"];
            [[obj.CFFData objectForKey:@"SecA"] setValue:[eAppResults stringForColumn:@"IntermediaryStatus"] forKey:@"Disclosure"];
            [[obj.CFFData objectForKey:@"SecA"] setValue:[eAppResults stringForColumn:@"BrokerName"] forKey:@"BrokerName"];
            
            //SecB
            [[obj.CFFData objectForKey:@"SecB"] setValue:[eAppResults stringForColumn:@"ClientChoice"] forKey:@"ClientChoice"];
            
            //SecC
            if ([[eAppResults stringForColumn:@"PartnerClientProfileID"] length] == 0){
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingPartner"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerProfileID"];
            }
            else{
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingPartner"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[eAppResults stringForColumn:@"PartnerClientProfileID"] forKey:@"PartnerProfileID"];
            }
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"CustomerReadOnly"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"PartnerReadOnly"];
            
            //SecD
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ1_Ans1"] forKey:@"NeedsQ1_Ans1"];
            //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Ans1"]);
            //NSLog(@"QQQ%@",[results stringForColumn:@"NeedsQ1_Ans1"]);
            
            
            
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ1_Ans2"] forKey:@"NeedsQ1_Ans2"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ1_Priority"] forKey:@"NeedsQ1_Priority"];
            
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ2_Ans1"] forKey:@"NeedsQ2_Ans1"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ2_Ans2"] forKey:@"NeedsQ2_Ans2"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ2_Priority"] forKey:@"NeedsQ2_Priority"];
            
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ3_Ans1"] forKey:@"NeedsQ3_Ans1"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ3_Ans2"] forKey:@"NeedsQ3_Ans2"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ3_Priority"] forKey:@"NeedsQ3_Priority"];
            
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ4_Ans1"] forKey:@"NeedsQ4_Ans1"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ4_Ans2"] forKey:@"NeedsQ4_Ans2"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ4_Priority"] forKey:@"NeedsQ4_Priority"];
            
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ5_Ans1"] forKey:@"NeedsQ5_Ans1"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ5_Ans2"] forKey:@"NeedsQ5_Ans2"];
            [[obj.CFFData objectForKey:@"SecD"] setValue:[eAppResults stringForColumn:@"NeedsQ5_Priority"] forKey:@"NeedsQ5_Priority"];
            
            //SecE
            [[obj.CFFData objectForKey:@"SecE"] setValue:[eAppResults stringForColumn:@"RiskReturnProfile"] forKey:@"Preference"];
            
            //Sec H
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"IntermediaryCode"] forKey:@"IntermediaryCode"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"IntermediaryName"] forKey:@"NameOfIntermediary"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"IntermediaryNRIC"] forKey:@"IntermediaryNRIC"];
            
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"IntermediaryContractDate"] forKey:@"IntermediaryCodeContractDate"];
            
            NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCodeContractDate"]);
            
            
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"IntermediaryAddress1"] forKey:@"IntermediaryAddress1"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"IntermediaryAddress2"] forKey:@"IntermediaryAddress2"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"IntermediaryAddress3"] forKey:@"IntermediaryAddress3"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"IntermediaryAddress4"] forKey:@"IntermediaryAddress4"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"IntermediaryManagerName"] forKey:@"NameOfManager"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"ClientAck"] forKey:@"CustomerAcknowledgement"];
            [[obj.CFFData objectForKey:@"SecH"] setValue:[eAppResults stringForColumn:@"ClientComments"] forKey:@"AdditionalComment"];
            
            
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryCode forKey:@"IntermediaryCode"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:NameOfIntermediary forKey:@"NameOfIntermediary"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryNRIC forKey:@"IntermediaryNRIC"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress1 forKey:@"IntermediaryAddress1"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress2 forKey:@"IntermediaryAddress2"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress3 forKey:@"IntermediaryAddress3"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:IntermediaryAddress4 forKey:@"IntermediaryAddress4"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:@"" forKey:@"NameOfManager"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:@"0" forKey:@"CustomerAcknowledgement"];
            //[[obj.CFFData objectForKey:@"SecH"] setValue:@"" forKey:@"AdditionalComment"];
        }
        
        
        
        
        
    }
    
    //SecC Customer
    results = Nil;
    results = [database executeQuery:@"select * from prospect_profile where IndexNo = ?",[NSString stringWithFormat:@"%d", indexNo]];
	
	//fix for bug 2494 start
    FMResultSet *cont6 = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%d", indexNo], @"CONT006"];
	FMResultSet *cont7 = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%d", indexNo], @"CONT007"];
	//fix for bug 2646 start
	FMResultSet *cont8 = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%d", indexNo], @"CONT008"];
	//fix for bug 2646 end
	FMResultSet *cont9 = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%d", indexNo], @"CONT009"];
    //results = [database executeQuery:@"select * from prospect_profile where IndexNo = 3333"];
    
    while([results next]) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingCustomer"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectTitle"] forKey:@"CustomerTitle"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectName"] forKey:@"CustomerName"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"IDTypeNo"] forKey:@"CustomerNRIC"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"OtherIDType"] forKey:@"CustomerOtherIDType"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"OtherIDTypeNo"] forKey:@"CustomerOtherID"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Race"] forKey:@"CustomerRace"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Religion"] forKey:@"CustomerReligion"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Nationality"] forKey:@"CustomerNationality"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectGender"] forKey:@"CustomerSex"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Smoker"] forKey:@"CustomerSmoker"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectDOB"] forKey:@"CustomerDOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"CustomerAge"]; //auto calculate
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MaritalStatus"] forKey:@"CustomerMaritalStatus"]; //not yet
		
		if ([[results stringForColumn:@"ResidenceAddressCountry"] isEqualToString:@"MALAYSIA"]) {
			[[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"CustomerMailingAddressForeign"];
		}
		else {
			[[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"CustomerMailingAddressForeign"];
		}
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress1"] forKey:@"CustomerMailingAddress1"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress2"] forKey:@"CustomerMailingAddress2"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress3"] forKey:@"CustomerMailingAddress3"];
        
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressPostCode"] forKey:@"CustomerMailingPostcode"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressTown"] forKey:@"CustomerMailingAddressTown"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressState"] forKey:@"CustomerMailingAddressState"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressCountry"] forKey:@"CustomerMailingAddressCountry"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"CustomerPermanentAddressForeign"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"CustomerPermanentAddress1"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"CustomerPermanentAddress2"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"CustomerPermanentAddress3"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"CustomerPermanentPostcode"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"CustomerPermanentAddressTown"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"CustomerPermanentAddressState"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"CustomerPermanentAddressCountry"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectEmail"] forKey:@"Email"];
		
    }
	
	while ([cont6 next]) {
		[[obj.CFFData objectForKey:@"SecC"] setValue:[cont6 stringForColumn:@"Prefix"] forKey:@"ResidenceTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[cont6 stringForColumn:@"ContactNo"] forKey:@"ResidenceTel"];
	}
	
	while ([cont7 next]) {
		[[obj.CFFData objectForKey:@"SecC"] setValue:[cont7 stringForColumn:@"Prefix"] forKey:@"OfficeTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[cont7 stringForColumn:@"ContactNo"] forKey:@"OfficeTel"];
	}
	//fix for bug 2646 start
	while ([cont8 next]) {
		[[obj.CFFData objectForKey:@"SecC"] setValue:[cont8 stringForColumn:@"Prefix"] forKey:@"MobileTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[cont8 stringForColumn:@"ContactNo"] forKey:@"MobileTel"];
	}
	//fix for bug 2646 end
	while ([cont9 next]) {
		[[obj.CFFData objectForKey:@"SecC"] setValue:[cont9 stringForColumn:@"Prefix"] forKey:@"FaxTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[cont9 stringForColumn:@"ContactNo"] forKey:@"FaxTel"];
	}
	//fix for bug 2494 end
    
    //SecC Partner
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"]){
        results = Nil;
        results = [database executeQuery:@"select * from prospect_profile where IndexNo = ?",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerProfileID"]];
        while([results next]) {
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectTitle"] forKey:@"PartnerTitle"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectName"] forKey:@"PartnerName"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"IDTypeNo"] forKey:@"PartnerNRIC"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOtherIDType"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOtherID"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"CHINESE" forKey:@"PartnerRace"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"Non Muslim" forKey:@"PartnerReligion"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"MALAYSIA" forKey:@"PartnerNationality"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectGender"] forKey:@"PartnerSex"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Smoker"] forKey:@"PartnerSmoker"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectDOB"] forKey:@"PartnerDOB"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerAge"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"Married" forKey:@"PartnerMaritalStatus"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerMailingAddressForeign"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress1"] forKey:@"PartnerMailingAddress1"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress2"] forKey:@"PartnerMailingAddress2"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress3"] forKey:@"PartnerMailingAddress3"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"53300" forKey:@"PartnerMailingPostcode"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"KUALA LUMPUR" forKey:@"PartnerMailingAddressTown"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressState"] forKey:@"PartnerMailingAddressState"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressCountry"] forKey:@"PartnerMailingAddressCountry"];
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerPermanentAddressForeign"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress1"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress2"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress3"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentPostcode"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressTown"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressState"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressCountry"];
            
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"03" forKey:@"PartnerResidenceTelExt"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"40231538" forKey:@"PartnerResidenceTel"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOfficeTelExt"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOfficeTel"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerFaxTelExt"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerFaxTel"];
            [[obj.CFFData objectForKey:@"SecC"] setValue:@"mengcheo@yahoo.com" forKey:@"PartnerEmail"];
        }
    }
    else{ //SecC no Partner
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerTitle"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerName"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerNRIC"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOtherIDType"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOtherID"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerRace"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerReligion"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerNationality"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerSex"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerSmoker"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerDOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerAge"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMaritalStatus"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddressForeign"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddress1"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddress2"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddress3"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingPostcode"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddressTown"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddressState"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddressCountry"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressForeign"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress1"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress2"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress3"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentPostcode"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressTown"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressState"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressCountry"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"03" forKey:@"PartnerResidenceTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"40231538" forKey:@"PartnerResidenceTel"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOfficeTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOfficeTel"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerFaxTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerFaxTel"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"mengcheo@yahoo.com" forKey:@"PartnerEmail"];
    }
    
    //SecC Children
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingChilden1"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingChilden2"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingChilden3"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingChilden4"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingChilden5"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1Name"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1Sex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1DOB"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1Age"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1Relationship"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"-1" forKey:@"Childen1RelationshipIndex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1Support"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Name"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Sex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2DOB"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Age"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Relationship"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"-1" forKey:@"Childen2RelationshipIndex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2Support"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Name"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Sex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3DOB"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Age"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Relationship"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"-1" forKey:@"Childen3RelationshipIndex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3Support"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Name"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Sex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4DOB"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Age"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Relationship"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"-1" forKey:@"Childen4RelationshipIndex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4Support"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Name"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Sex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5DOB"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Age"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Relationship"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"-1" forKey:@"Childen5RelationshipIndex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5Support"];
    
    results = Nil;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select count(*) as cnt from CFF_Family_Details where CFFID = \"%@\"",CFFID]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select count(*) as cnt from eProposal_CFF_Family_Details where CFFID = \"%@\" AND eProposalNo = \"%@\"", CFFID,eProposalNo]];
    }
    int gotChild = 0;
    int gotChildCount = 0;
    while ([results next]) {
        NSLog(@"Hello got child: %d", [results intForColumn:@"cnt"]);
        if ([results intForColumn:@"cnt"] > 0){
            NSLog(@"Hello got child +1");
            gotChild = 1;
        }
    }
    if (gotChild == 1){
        results = Nil;
        if (!eAppIsMoreUpdate) {
            
            results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Family_Details where CFFID = \"%@\" order by ID asc",CFFID]];
        }
        else {
            
            results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Family_Details where CFFID = \"%@\" AND eProposalNo = \"%@\"", CFFID,eProposalNo]];
        }
        while ([results next]) {
            gotChildCount++;
            if (gotChildCount == 1){
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingChilden1"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Name"] forKey:@"Childen1Name"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Sex"] forKey:@"Childen1Sex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"DOB"] forKey:@"Childen1DOB"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Age"] forKey:@"Childen1Age"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Relationship"] forKey:@"Childen1Relationship"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"RelationshipIndexNo"] forKey:@"Childen1RelationshipIndex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"YearsToSupport"] forKey:@"Childen1Support"];
            }
            else if (gotChildCount == 2){
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingChilden2"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Name"] forKey:@"Childen2Name"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Sex"] forKey:@"Childen2Sex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"DOB"] forKey:@"Childen2DOB"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Age"] forKey:@"Childen2Age"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Relationship"] forKey:@"Childen2Relationship"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"RelationshipIndexNo"] forKey:@"Childen2RelationshipIndex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"YearsToSupport"] forKey:@"Childen2Support"];
            }
            else if (gotChildCount == 3){
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingChilden3"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Name"] forKey:@"Childen3Name"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Sex"] forKey:@"Childen3Sex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"DOB"] forKey:@"Childen3DOB"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Age"] forKey:@"Childen3Age"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Relationship"] forKey:@"Childen3Relationship"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"RelationshipIndexNo"] forKey:@"Childen3RelationshipIndex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"YearsToSupport"] forKey:@"Childen3Support"];
            }
            else if (gotChildCount == 4){
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingChilden4"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Name"] forKey:@"Childen4Name"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Sex"] forKey:@"Childen4Sex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"DOB"] forKey:@"Childen4DOB"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Age"] forKey:@"Childen4Age"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Relationship"] forKey:@"Childen4Relationship"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"RelationshipIndexNo"] forKey:@"Childen4RelationshipIndex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"YearsToSupport"] forKey:@"Childen4Support"];
            }
            else if (gotChildCount == 5){
                [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingChilden5"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Name"] forKey:@"Childen5Name"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Sex"] forKey:@"Childen5Sex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"DOB"] forKey:@"Childen5DOB"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Age"] forKey:@"Childen5Age"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Relationship"] forKey:@"Childen5Relationship"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"RelationshipIndexNo"] forKey:@"Childen5RelationshipIndex"];
                [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"YearsToSupport"] forKey:@"Childen5Support"];
            }
        }
    }
    
    //Section F Retirement
    //section F Protection
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ProtectionNeedValidation"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasProtection"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionCurrent1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionRequired1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionDifference1"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionCurrent2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionRequired2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionDifference2"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionCurrent3"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionRequired3"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionDifference3"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionCurrent4"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionRequired4"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionDifference4"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionCustomerAlloc"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionPartnerAlloc"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingProtection1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingProtection2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingProtection3"];
    
    
    
    //section F Protection
    results = Nil;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:@"select * from CFF_Protection where CFFID = ?",CFFID,Nil];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Protection where CFFID = \"%@\" and eProposalNo = \"%@\"",CFFID,eProposalNo]];
    }
    while ([results next]) {
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ProtectionNeedValidation"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"NoExistingPlan"] forKey:@"HasProtection"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalSA_CurrentAmt"] forKey:@"ProtectionCurrent1"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalSA_RequiredAmt"] forKey:@"ProtectionRequired1"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalSA_SurplusShortFall"] forKey:@"ProtectionDifference1"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalCISA_CurrentAmt"] forKey:@"ProtectionCurrent2"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalCISA_RequiredAmt"] forKey:@"ProtectionRequired2"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalCISA_SurplusShortFall"] forKey:@"ProtectionDifference2"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalHB_CurrentAmt"] forKey:@"ProtectionCurrent3"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalHB_RequiredAmt"] forKey:@"ProtectionRequired3"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalHB_SurplusShortFall"] forKey:@"ProtectionDifference3"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalPA_CurrentAmt"] forKey:@"ProtectionCurrent4"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalPA_RequiredAmt"] forKey:@"ProtectionRequired4"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"TotalHB_SurplusShortFall"] forKey:@"ProtectionDifference4"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"AllocateIncome_1"] forKey:@"ProtectionCustomerAlloc"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"AllocateIncome_2"] forKey:@"ProtectionPartnerAlloc"];
        
        
    }
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1LifeAssured"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1DeathBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1DisabilityBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1CriticalIllnessBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1OtherBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1PremiumContribution"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1Mode"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection1MaturityDate"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2LifeAssured"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2DeathBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2DisabilityBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2CriticalIllnessBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2OtherBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2PremiumContribution"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2Mode"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection2MaturityDate"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3LifeAssured"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3DeathBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3DisabilityBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3CriticalIllnessBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3OtherBenefit"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3PremiumContribution"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3Mode"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingProtection3MaturityDate"];
    
    //section F Protection Details
    results = Nil;
    int protectionCount;
    protectionCount = 0;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Protection_Details where CFFID = \"%@\" order by SeqNo asc",CFFID]];
    }
    else  {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Protection_Details where CFFID = \"%@\" and eProposalNo = \"%@\" order by SeqNo asc",CFFID,eProposalNo]];
    }
    while ([results next]) {
        protectionCount++;
        if (protectionCount == 1){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingProtection1"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"POName"] forKey:@"ExistingProtection1PolicyOwner"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingProtection1Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ExistingProtection1TypeOfPlan"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"LifeAssuredName"] forKey:@"ExistingProtection1LifeAssured"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit1"] forKey:@"ExistingProtection1DeathBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit2"] forKey:@"ExistingProtection1DisabilityBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit3"] forKey:@"ExistingProtection1CriticalIllnessBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit4"] forKey:@"ExistingProtection1OtherBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingProtection1PremiumContribution"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Mode"] forKey:@"ExistingProtection1Mode"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityDate"] forKey:@"ExistingProtection1MaturityDate"];
        }
        else if (protectionCount == 2){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingProtection2"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"POName"] forKey:@"ExistingProtection2PolicyOwner"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingProtection2Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ExistingProtection2TypeOfPlan"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"LifeAssuredName"] forKey:@"ExistingProtection2LifeAssured"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit1"] forKey:@"ExistingProtection2DeathBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit2"] forKey:@"ExistingProtection2DisabilityBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit3"] forKey:@"ExistingProtection2CriticalIllnessBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit4"] forKey:@"ExistingProtection2OtherBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingProtection2PremiumContribution"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Mode"] forKey:@"ExistingProtection2Mode"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityDate"] forKey:@"ExistingProtection2MaturityDate"];
        }
        else if (protectionCount == 3){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingProtection3"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"POName"] forKey:@"ExistingProtection3PolicyOwner"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingProtection3Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ExistingProtection3TypeOfPlan"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"LifeAssuredName"] forKey:@"ExistingProtection3LifeAssured"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit1"] forKey:@"ExistingProtection3DeathBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit2"] forKey:@"ExistingProtection3DisabilityBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit3"] forKey:@"ExistingProtection3CriticalIllnessBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Benefit4"] forKey:@"ExistingProtection3OtherBenefit"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingProtection3PremiumContribution"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Mode"] forKey:@"ExistingProtection3Mode"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityDate"] forKey:@"ExistingProtection1MaturityDate"];
        }
    }
    
    //section F Retirement
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"RetirementNeedValidation"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasRetirement"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementCurrent1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementRequired1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementDifference1"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementCustomerAlloc"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementPartnerAlloc"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementCustomerRely"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementPartnerRely"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingRetirement1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingRetirement2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingRetirement3"];
    
    
    results = Nil;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Retirement where CFFID = \"%@\"",CFFID]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Retirement where CFFID = \"%@\" and eProposalNo = \"%@\"",CFFID,eProposalNo]];
    }
    while ([results next]) {
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"NoExistingPlan"] forKey:@"HasRetirement"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CurrentAmt"] forKey:@"RetirementCurrent1"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"RequiredAmt"] forKey:@"RetirementRequired1"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"SurplusShortFallAmt"] forKey:@"RetirementDifference1"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"AllocateIncome_1"] forKey:@"RetirementCustomerAlloc"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"AllocateIncome_2"] forKey:@"RetirementPartnerAlloc"];
        
        //NSLog(@"TTT%@",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"RetirementPartnerAlloc"]);
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"OtherIncome_1"] forKey:@"RetirementCustomerRely"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"OtherIncome_2"] forKey:@"RetirementPartnerRely"];
    }
    
    //section F Retirement Details
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1Frequency"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1StartDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1MaturityDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1SumMaturity"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1IncomeMaturity"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement1AdditionalBenefit"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2Frequency"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2StartDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2MaturityDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2SumMaturity"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2IncomeMaturity"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement2AdditionalBenefit"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3Frequency"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3StartDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3MaturityDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3SumMaturity"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3IncomeMaturity"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingRetirement3AdditionalBenefit"];
    
    results = Nil;
    int retirementCount;
    retirementCount = 0;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Retirement_Details where CFFID = \"%@\" order by SeqNo asc",CFFID]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Retirement_Details where CFFID = \"%@\" and eProposalNo = \"%@\" order by SeqNo asc",CFFID,eProposalNo]];
    }
    while ([results next]) {
        retirementCount++;
        if (retirementCount == 1){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingRetirement1"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"POName"] forKey:@"ExistingRetirement1PolicyOwner"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingRetirement1Company"];
            
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ExistingRetirement1TypeOfPlan"];
            //NSLog(@"DDDD%@",[results stringForColumn:@"PlanType"]);
            
            
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingRetirement1Premium"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Frequency"] forKey:@"ExistingRetirement1Frequency"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"StartDate"] forKey:@"ExistingRetirement1StartDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityDate"] forKey:@"ExistingRetirement1MaturityDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"ProjectedLumSum"] forKey:@"ExistingRetirement1SumMaturity"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"ProjectedAnnualIncome"] forKey:@"ExistingRetirement1IncomeMaturity"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"AdditionalBenefits"] forKey:@"ExistingRetirement1AdditionalBenefit"];
        }
        else if (retirementCount == 2){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingRetirement2"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"POName"] forKey:@"ExistingRetirement2PolicyOwner"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingRetirement2Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ExistingRetirement2TypeOfPlan"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingRetirement2Premium"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Frequency"] forKey:@"ExistingRetirement2Frequency"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"StartDate"] forKey:@"ExistingRetirement2StartDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityDate"] forKey:@"ExistingRetirement2MaturityDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"ProjectedLumSum"] forKey:@"ExistingRetirement2SumMaturity"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"ProjectedAnnualIncome"] forKey:@"ExistingRetirement2IncomeMaturity"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"AdditionalBenefits"] forKey:@"ExistingRetirement2AdditionalBenefit"];
            
        }
        else if (retirementCount == 3){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingRetirement3"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"POName"] forKey:@"ExistingRetirement3PolicyOwner"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingRetirement3Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ExistingRetirement3TypeOfPlan"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingRetirement3Premium"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Frequency"] forKey:@"ExistingRetirement3Frequency"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"StartDate"] forKey:@"ExistingRetirement3StartDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityDate"] forKey:@"ExistingRetirement3MaturityDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"ProjectedLumSum"] forKey:@"ExistingRetirement3SumMaturity"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"ProjectedAnnualIncome"] forKey:@"ExistingRetirement3IncomeMaturity"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"AdditionalBenefits"] forKey:@"ExistingRetirement3AdditionalBenefit"];
        }
    }
    
    //Section F education
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"EducationNeedValidation"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasEducation"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasEducationChild"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"EducationRowToHide"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationCurrent1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationRequired1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationDifference1"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationCurrent2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationRequired2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationDifference2"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationCurrent3"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationRequired3"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationDifference3"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationCurrent4"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationRequired4"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationDifference4"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"EducationCustomerAlloc"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingEducation1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingEducation2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingEducation3"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingEducation4"];
    
    results = Nil;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Education where CFFID = \"%@\"",CFFID]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Education where CFFID = \"%@\" and eProposalNo = \"%@\"",CFFID,eProposalNo]];
    }
    while ([results next]) {
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"NoExistingPlan"] forKey:@"HasEducation"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"NoChild"] forKey:@"HasEducationChild"];
        
        if ([[results stringForColumn:@"NoChild"] isEqualToString:@"-1"]){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"2" forKey:@"EducationRowToHide"]; //special
        }
        else{
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"EducationRowToHide"];
        }
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CurrentAmt_Child_1"] forKey:@"EducationCurrent1"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"RequiredAmt_Child_1"] forKey:@"EducationRequired1"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"SurplusShortFallAmt_Child_1"] forKey:@"EducationDifference1"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CurrentAmt_Child_2"] forKey:@"EducationCurrent2"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"RequiredAmt_Child_2"] forKey:@"EducationRequired2"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"SurplusShortFallAmt_Child_2"] forKey:@"EducationDifference2"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CurrentAmt_Child_3"] forKey:@"EducationCurrent3"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"RequiredAmt_Child_3"] forKey:@"EducationRequired3"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"SurplusShortFallAmt_Child_3"] forKey:@"EducationDifference3"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CurrentAmt_Child_4"] forKey:@"EducationCurrent4"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"RequiredAmt_Child_4"] forKey:@"EducationRequired4"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"SurplusShortFallAmt_Child_4"] forKey:@"EducationDifference4"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"AllocateIncome_1"] forKey:@"EducationCustomerAlloc"];
    }
    
    //Sec F Education Details
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1ChildName"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1Frequency"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1StartDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1MaturityDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation1ValueMaturity"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2ChildName"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2Frequency"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2StartDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2MaturityDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation2ValueMaturity"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3ChildName"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3Frequency"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3StartDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3MaturityDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation3ValueMaturity"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4ChildName"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4Frequency"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4StartDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4MaturityDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingEducation4ValueMaturity"];
    
    results = Nil;
    int educationCount;
    educationCount = 0;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Education_Details where CFFID = \"%@\" order by SeqNo asc",CFFID]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Education_Details where CFFID = \"%@\" and eProposalNo = \"%@\" order by SeqNo asc",CFFID,eProposalNo]];
    }
    while ([results next]) {
        educationCount++;
        if (educationCount == 1){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingEducation1"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Name"] forKey:@"ExistingEducation1ChildName"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingEducation1Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingEducation1Premium"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Frequency"] forKey:@"ExistingEducation1Frequency"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"StartDate"] forKey:@"ExistingEducation1StartDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityDate"] forKey:@"ExistingEducation1MaturityDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"ProjectedValueAtMaturity"] forKey:@"ExistingEducation1ValueMaturity"];
        }
        else if (educationCount == 2){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingEducation2"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Name"] forKey:@"ExistingEducation2ChildName"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingEducation2Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingEducation2Premium"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Frequency"] forKey:@"ExistingEducation2Frequency"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"StartDate"] forKey:@"ExistingEducation2StartDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityDate"] forKey:@"ExistingEducation2MaturityDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"ProjectedValueAtMaturity"] forKey:@"ExistingEducation1ValueMaturity"];
        }
        else if (educationCount == 1){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingEducation3"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Name"] forKey:@"ExistingEducation3ChildName"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingEducation3Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingEducation3Premium"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Frequency"] forKey:@"ExistingEducation3Frequency"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"StartDate"] forKey:@"ExistingEducation3StartDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityDate"] forKey:@"ExistingEducation3MaturityDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"ProjectedValueAtMaturity"] forKey:@"ExistingEducation3ValueMaturity"];
        }
        else if (educationCount == 4){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingEducation4"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Name"] forKey:@"ExistingEducation4ChildName"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingEducation4Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingEducation4Premium"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Frequency"] forKey:@"ExistingEducation4Frequency"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"StartDate"] forKey:@"ExistingEducation4StartDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityDate"] forKey:@"ExistingEducation4MaturityDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"ProjectedValueAtMaturity"] forKey:@"ExistingEducation4ValueMaturity"];
        }
    }
    
    //Sec F Savings
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"SavingsNeedValidation"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasSavings"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"SavingsCurrent1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"SavingsRequired1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"SavingsDifference1"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"SavingsCustomerAlloc"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingSavings1"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingSavings2"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingSavings3"];
    
    results = Nil;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_SavingsInvest where CFFID = \"%@\"",CFFID]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_SavingsInvest where CFFID = \"%@\" and eProposalNo = \"%@\"",CFFID,eProposalNo]];
    }
    while ([results next]) {
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"NoExistingPlan"] forKey:@"HasSavings"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CurrentAmt"] forKey:@"SavingsCurrent1"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"RequiredAmt"] forKey:@"SavingsRequired1"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"SurplusShortFallAmt"] forKey:@"SavingsDifference1"];
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"AllocateIncome_1"] forKey:@"SavingsCustomerAlloc"];
    }
    
    //Sec F Savings Details
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1PolicyOwner"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1Company"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1TypeOfPlan"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1Purpose"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1Premium"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1CommDate"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ExistingSavings1AmountMaturity"];
    
    results = Nil;
    int savingsCount;
    savingsCount = 0;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_SavingsInvest_Details where CFFID = \"%@\" order by SeqNo asc",CFFID]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_SavingsInvest_Details where CFFID = \"%@\" and eProposalNo = \"%@\" order by SeqNo asc",CFFID,eProposalNo]];
    }
    while ([results next]) {
        savingsCount++;
        if (savingsCount == 1){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingSavings1"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"POName"] forKey:@"ExistingSavings1PolicyOwner"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingSavings1Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ExistingSavings1TypeOfPlan"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Purpose"] forKey:@"ExistingSavings1Purpose"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingSavings1Premium"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CommDate"] forKey:@"ExistingSavings1CommDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityAmt"] forKey:@"ExistingSavings1AmountMaturity"];
        }
        else if (savingsCount == 2){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingSavings2"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"POName"] forKey:@"ExistingSavings2PolicyOwner"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingSavings2Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ExistingSavings2TypeOfPlan"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Purpose"] forKey:@"ExistingSavings2Purpose"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingSavings2Premium"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CommDate"] forKey:@"ExistingSavings2CommDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityAmt"] forKey:@"ExistingSavings2AmountMaturity"];
        }
        else if (savingsCount == 3){
            [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingSavings3"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"POName"] forKey:@"ExistingSavings3PolicyOwner"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CompanyName"] forKey:@"ExistingSavings3Company"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ExistingSavings3TypeOfPlan"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Purpose"] forKey:@"ExistingSavings3Purpose"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"Premium"] forKey:@"ExistingSavings3Premium"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"CommDate"] forKey:@"ExistingSavings3CommDate"];
            [[obj.CFFData objectForKey:@"SecF"] setValue:[results stringForColumn:@"MaturityAmt"] forKey:@"ExistingSavings3AmountMaturity"];
        }
    }
    
    //Section G
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"1" forKey:@"FollowSI"];//selected
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"TypeOfPlanP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"TermP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"SumAssuredP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"Hong Leong Assurance Berhad" forKey:@"NameOfInsurerP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"NameOfInsuredP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"AdditionalP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"ReasonP1"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"ActionP1"];
    
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"0" forKey:@"ValidateP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"TypeOfPlanP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"TermP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"SumAssuredP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"Hong Leong Assurance Berhad" forKey:@"NameOfInsurerP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"NameOfInsuredP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"AdditionalP2"];
    [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"ReasonP2"];
    
    //Section G Priority 1
    results = Nil;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_RecordOfAdvice where CFFID = \"%@\" and Priority = '1'",CFFID]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_RecordOfAdvice where CFFID = \"%@\" and Priority = '1' and eProposalNo = \"%@\"",CFFID,eProposalNo]];
    }
    while ([results next]) {
        [[obj.CFFData objectForKey:@"SecG"] setValue:@"1" forKey:@"FollowSI"];//selected
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"PlanType"] forKey:@"TypeOfPlanP1"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"Term"] forKey:@"TermP1"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"SumAssured"] forKey:@"SumAssuredP1"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:@"Hong Leong Assurance Berhad" forKey:@"NameOfInsurerP1"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"InsuredName"] forKey:@"NameOfInsuredP1"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"AdditionalP1"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"ReasonRecommend"] forKey:@"ReasonP1"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"ActionRemark"] forKey:@"ActionP1"];
    }
    
    //Section G Priority 1 Riders
    results = Nil;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_RecordOfAdvice_Rider where CFFID = \"%@\" and Priority = '1' order by Seq asc",CFFID]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_RecordOfAdvice_Rider where CFFID = \"%@\" and Priority = '1' and eProposalNo = \"%@\" order by Seq asc",CFFID,eProposalNo]];
    }
    while ([results next]) {
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"RiderName"] forKey:@"AdditionalP1"]; //special
    }
    
    //Section G Priority 2
    results = Nil;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_RecordOfAdvice where CFFID = \"%@\" and Priority = '2'",CFFID]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_RecordOfAdvice where CFFID = \"%@\" and Priority = '2' and eProposalNo = \"%@\"",CFFID,eProposalNo]];
    }
    while ([results next]) {
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"PlanType"] forKey:@"TypeOfPlanP2"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"Term"] forKey:@"TermP2"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"SumAssured"] forKey:@"SumAssuredP2"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:@"Hong Leong Assurance Berhad" forKey:@"NameOfInsurerP2"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"InsuredName"] forKey:@"NameOfInsuredP2"];
        
        //[[obj.CFFData objectForKey:@"SecG"] setValue:@"" forKey:@"AdditionalP2"]; //special
        
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"ReasonRecommend"] forKey:@"ReasonP2"];
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"ActionRemark"] forKey:@"ActionP2"];
    }
    
    //Section G Priority 2 Riders
    results = Nil;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_RecordOfAdvice_Rider where CFFID = \"%@\" and Priority = '2' order by Seq asc",CFFID]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_RecordOfAdvice_Rider where CFFID = \"%@\" and Priority = '2' and eProposalNo = \"%@\" order by Seq asc",CFFID,eProposalNo]];
    }
    while ([results next]) {
        [[obj.CFFData objectForKey:@"SecG"] setValue:[results stringForColumn:@"RiderName"] forKey:@"AdditionalP2"]; //special
    }
    
    //section I
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Advice1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Advice2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Advice3"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Advice4"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Advice5"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Advice6"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Advice6Others"];
    
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommendedSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended3"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended4"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended5"];
    
    results = Nil;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_CA where CFFID = \"%@\"",CFFID]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_CA where CFFID = \"%@\" and eProposalNo = \"%@\"",CFFID,eProposalNo]];
    }
    while ([results next]) {
        [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Choice1"] forKey:@"Advice1"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Choice2"] forKey:@"Advice2"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Choice3"] forKey:@"Advice3"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Choice4"] forKey:@"Advice4"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Choice5"] forKey:@"Advice5"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Choice6"] forKey:@"Advice6"];
        [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Choices6Desc"] forKey:@"Advice6Others"];
    }
    
    //section I recommended
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"RecommendedSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"NameOfInsuredSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"ProductTypeSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"TermSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"PremiumSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"FrequencySI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssuredSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefitSI"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"1" forKey:@"BroughtSI"];
    
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"NameOfInsured1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"ProductType1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Term1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Premium1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssured1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefit1"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Brought1"];
    
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"NameOfInsured2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"ProductType2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Term2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Premium2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssured2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefit2"];
    [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"Brought2"];
    
    results = Nil;
    int recommendCount;
    recommendCount = 0;
    if (!eAppIsMoreUpdate) {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_CA_Recommendation where CFFID = \"%@\" order by Seq asc",CFFID]];
    }
    else {
        results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_CA_Recommendation where CFFID = \"%@\" and eProposalNo = \"%@\" order by Seq asc",CFFID,eProposalNo]];
    }
    while ([results next]) {
        recommendCount++;
        if (recommendCount == 1){
            [[obj.CFFData objectForKey:@"SecI"] setValue:@"1" forKey:@"ExistingRecommended1"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"InsuredName"] forKey:@"NameOfInsured1"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ProductType1"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Term"] forKey:@"Term1"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Premium"] forKey:@"Premium1"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Frequency"] forKey:@"Frequency1"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"SumAssured"] forKey:@"SumAssured1"];
            //[[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefit1"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"BoughtOption"] forKey:@"Brought1"];
        }
        else if (recommendCount == 2){
            [[obj.CFFData objectForKey:@"SecI"] setValue:@"1" forKey:@"ExistingRecommended2"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"InsuredName"] forKey:@"NameOfInsured2"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"PlanType"] forKey:@"ProductType2"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Term"] forKey:@"Term2"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"Premium"] forKey:@"Premium2"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"Frequency2"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"SumAssured2"];
            //[[obj.CFFData objectForKey:@"SecI"] setValue:@"" forKey:@"AdditionalBenefit2"];
            [[obj.CFFData objectForKey:@"SecI"] setValue:[results stringForColumn:@"BoughtOption"] forKey:@"Brought2"];
        }
    }
    
}
@end
