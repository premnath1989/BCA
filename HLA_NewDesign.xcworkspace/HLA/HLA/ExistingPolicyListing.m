//
//  ExistingPolicyListing.m
//  iMobile Planner
//
//  Created by Juliana on 9/19/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ExistingPolicyListing.h"
#import "DataClass.h"
//#import "AddPolicyTableVC.h"

@interface ExistingPolicyListing () {
	DataClass *obj;
}

@end

@implementation ExistingPolicyListing

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	obj =  [DataClass getInstance];
//	self.mainTableView.delegate = self;
//	self.mainTableView.dataSource = self;
//	add.delegate = self;
	[self.mainTableView reloadData];
	viewArr = [[NSMutableArray alloc] init];
	[viewArr addObject:[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] objectForKey:@"PolicyData"]];
	
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
	NSLog(@"number in here: %d", [[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] objectForKey:@"PolicyData"] count]);
	return [[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] objectForKey:@"PolicyData"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}
	
	
	for (id view in viewArr) {
		NSLog(@"fff: %@", [[view objectAtIndex:indexPath.row]objectAtIndex:1]);
		cell.textLabel.text = [[view objectAtIndex:indexPath.row]objectAtIndex:0];
		cell.detailTextLabel.text = [[view objectAtIndex:indexPath.row]objectAtIndex:1];
	}
			
	return cell;
	
		
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];

}

#pragma mark - Table view delegate
//-(void)reloadPolicyTable {
//	NSLog(@"delegate method");
//
////	[viewArr addObject:[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] objectForKey:@"PolicyData"]];
////	[self.mainTableView reloadData];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] setValue:[NSNumber numberWithInt:indexPath.row] forKey:@"WhichPolicy"];
	MainAddPolicyVC *mapvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainAddPolicy"];
	
	mapvc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:mapvc animated:YES completion:nil];
	[self.tableView reloadData];
//	NSLog(@"fff: %@", [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] objectForKey:@"WhichPolicy"]);
	mapvc = Nil;
}

- (void)viewDidUnload {
	[self setMainTableView:nil];
	[super viewDidUnload];
}

@end
