//
//  GroupViewVC.m
//  iMobile Planner
//
//  Created by Emi on 16/12/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import "GroupViewVC.h"
#import "ColorHexCode.h"
#import "FMDatabase.h"

@interface GroupViewVC ()

@end

@implementation GroupViewVC
@synthesize Backbtn, tableViewGroup, UDGroup, LblTitle;

FMDatabase *db;
NSMutableArray *groupArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	UDGroup = [NSUserDefaults standardUserDefaults];
	
	groupArr = [NSMutableArray array];
	
	LblTitle.text = [NSString stringWithFormat:@"Grouping for %@", [UDGroup stringForKey:@"ProspectName"]];

	groupArr = [UDGroup objectForKey:@"groupArr"];
	[self.tableViewGroup reloadData];
	
}

- (IBAction)backPressed:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return groupArr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *tempArray = nil;
	
	tempArray = groupArr;
    
	
    static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    
    // Configure the cell...
    cell.textLabel.text = [[tempArray objectAtIndex:indexPath.row] objectForKey:@"name"];
	cell.textLabel.font = [UIFont fontWithName:@"Tret MS" size:16];
	
	ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
	if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
    }
    else {
        cell.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
    }
    
	//    cell.selectionStyle = UITableViewCellSelectionStyleGray;
	
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
  
}

@end
