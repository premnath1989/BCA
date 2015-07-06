//
//  eAppMenu.m
//  iMobile Planner
//
//  Created by shawal sapuan on 7/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "eAppMenu.h"
#import "ColorHexCode.h"
#import "MaineApp.h"
#import "MasterMenuEApp.h"

@interface eAppMenu ()

@end

@implementation eAppMenu
@synthesize eAppsVC,getSI,items,getEAPP;
@synthesize getPO,getECFF,getESignature;
@synthesize subPOVC = _subPOVC;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    items = [[NSMutableArray alloc] initWithObjects:@"Select SI", @"Select Policy Owner", @"Select eCFF",@"e-Application",@"e-Signature",nil];
    
    clickPO = NO;
    
    
    
    NSLog(@"cadsfadsf");

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = [items objectAtIndex:indexPath.row];
    
    if (getSI && indexPath.row == 0) {
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Selected SINo:%@",[self.getSI description]];
        UIImageView *imgIcon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconComplete.png"]];
        imgIcon2.frame = CGRectMake(885, 15, 16, 16);
        [cell.contentView addSubview:imgIcon2];
        
    }
    else if (getPO) {
        
        if (indexPath.row == 1) {
            
            cell.detailTextLabel.text = @"";
            UIImageView *imgIcon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconComplete.png"]];
            imgIcon2.frame = CGRectMake(885, 15, 16, 16);
            [cell.contentView addSubview:imgIcon2];
        }
        else {
            
            cell.detailTextLabel.text = @"";
            UIImageView *imgIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconNotComplete.png"]];
            imgIcon.frame = CGRectMake(885, 15, 16, 16);
            [cell.contentView addSubview:imgIcon];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    else if (getEAPP) {
        
        if (indexPath.row == 0) {
            
            cell.detailTextLabel.text = @"Selected SINo:SI20130712-0001";
            UIImageView *imgIcon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconComplete.png"]];
            imgIcon2.frame = CGRectMake(885, 15, 16, 16);
            [cell.contentView addSubview:imgIcon2];
            
        }
        else if (indexPath.row == 1) {
            
            cell.detailTextLabel.text = @"";
            UIImageView *imgIcon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconComplete.png"]];
            imgIcon2.frame = CGRectMake(885, 15, 16, 16);
            [cell.contentView addSubview:imgIcon2];
        }
        else if (indexPath.row == 3) {
            cell.detailTextLabel.text = @"";
            UIImageView *imgIcon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconComplete.png"]];
            imgIcon2.frame = CGRectMake(885, 15, 16, 16);
            [cell.contentView addSubview:imgIcon2];
        }
        else {
            
            cell.detailTextLabel.text = @"";
            UIImageView *imgIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconNotComplete.png"]];
            imgIcon.frame = CGRectMake(885, 15, 16, 16);
            [cell.contentView addSubview:imgIcon];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    else {
        
        cell.detailTextLabel.text = @"";
        UIImageView *imgIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconNotComplete.png"]];
        imgIcon.frame = CGRectMake(885, 15, 16, 16);
        [cell.contentView addSubview:imgIcon];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {   //go SI listing
        
        UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:Nil];
        self.eAppsVC = [nextStoryboard instantiateViewControllerWithIdentifier:@"eAppList"];
        self.eAppsVC.modalPresentationStyle = UIModalPresentationFullScreen;
        self.eAppsVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:self.eAppsVC animated:YES];
    }
    
    else if (indexPath.row == 1) { //go policy owner
        
        UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboardData" bundle:Nil];
        self.subPOVC = [secondStoryboard instantiateViewControllerWithIdentifier:@"subDataScreen2"];
        _subPOVC.delegate = self;
        
        clickPO = YES;
        self.subPOVC.modalPresentationStyle = UIModalPresentationPageSheet;
        self.subPOVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentModalViewController:self.subPOVC animated:YES];
        
        [self.myTableView reloadData];
        secondStoryboard = nil;
    }
    
    else if (indexPath.row == 2) { //go ecff
        
    }
    
    else if (indexPath.row == 3) {  //go eapp
        
        /*
        UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:Nil];
        MaineApp *zzz= [secondStoryboard instantiateViewControllerWithIdentifier:@"maineApp"];
        zzz.modalPresentationStyle = UIModalPresentationFullScreen;
        zzz.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        zzz.IndexTab = 1;
        zzz.getMenu = @"eAPP";
        [self presentViewController:zzz animated:NO completion:Nil];
        zzz = Nil, secondStoryboard = nil; */
        
        UIStoryboard *Storyboard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:Nil];
        MasterMenuEApp *main = [Storyboard instantiateViewControllerWithIdentifier:@"eAppMaster"];
        main.modalPresentationStyle = UIModalPresentationFullScreen;
        main.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:main animated:YES completion:nil];
        
        Storyboard = nil, main = nil;
    }
    
    else if (indexPath.row == 4) {
        
    }
}

- (void)viewDidUnload
{
    [self setMyTableView:nil];
    [super viewDidUnload];
}

- (IBAction)ActionClose:(id)sender
{
    UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:Nil];
    MaineApp *zzz= [secondStoryboard instantiateViewControllerWithIdentifier:@"maineApp"];
    zzz.modalPresentationStyle = UIModalPresentationFullScreen;
    self.eAppsVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    zzz.IndexTab = 1;
    [self presentViewController:zzz animated:YES completion:Nil];
    zzz = Nil, secondStoryboard = nil;
}

-(void)selectedPO:(NSString *)theStr
{
    getPO = theStr;
    NSLog(@"delegatePO:%@",theStr);
}

@end
