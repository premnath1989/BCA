//
//  ReferralListVC.m
//  iMobile Planner
//
//  Created by Emi on 19/11/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ReferralListVC.h"

@interface ReferralListVC ()

@end

@implementation ReferralListVC

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionContactList:(id)sender {
}

- (IBAction)actionActLog:(id)sender {
}

- (IBAction)btnBack:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowCount=5;
//    if(self.isFiltered)
//        rowCount = FilteredTableData.count;
//    else
//        rowCount = itemInArray.count;
	
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    [[cell.contentView viewWithTag:2001] removeFromSuperview ];
    [[cell.contentView viewWithTag:2002] removeFromSuperview ];
    
//    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    
	//    NSString *itemDisplay = nil;
	//    if(isFiltered) {
	//        itemDisplay = [[FilteredTableData objectAtIndex:indexPath.row ]objectForKey:@"NamaLengkap"];
	//    }
	//    else {
	//        itemDisplay = [[itemInArray objectAtIndex:indexPath.row] objectForKey:@"NamaLengkap"];
	//    }
    
//    CGRect frame=CGRectMake(0,0, 200, 50);
//    UILabel *label1=[[UILabel alloc]init];
//    label1.frame=frame;
//    label1.text= [[itemInArray objectAtIndex:indexPath.row] objectForKey:@"NIP"];
//	//    label1.textAlignment = UITextAlignmentLeft;
//    label1.tag = 2001;
//    [cell.contentView addSubview:label1];
//    
//    CGRect frame2=CGRectMake(205,0, 600, 50);
//    UILabel *label2=[[UILabel alloc]init];
//    label2.frame=frame2;
//    label2.text= [[itemInArray objectAtIndex:indexPath.row] objectForKey:@"NamaLengkap"];
//	//    label2.textAlignment = UITextAlignmentCenter;
//    label2.tag = 2002;
//    [cell.contentView addSubview:label2];
//	
//	CGRect frame3=CGRectMake(810,10, 65, 40);
//    UIButton *btnView= [UIButton buttonWithType:UIButtonTypeRoundedRect];
//	btnView.frame = frame3;
//    [btnView setTitle:@"VIEW" forState:UIControlStateNormal];
//    [cell addSubview:btnView];
//	
//	CGRect frame4=CGRectMake(880, 10, 65, 40);
//    UIButton *btnAct= [UIButton buttonWithType:UIButtonTypeRoundedRect];
//	btnAct.frame = frame4;
//    [btnAct setTitle:@"Act" forState:UIControlStateNormal];
//    [cell addSubview:btnAct];
//	
//    
//    if (indexPath.row % 2 == 0) {
//        label1.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
//        label2.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
//        
//        label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
//        label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
//    }
//    else {
//        label1.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
//        label2.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
//        
//        label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
//        label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
//    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

@end
