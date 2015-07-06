//
//  ExistingPolicyPOListing.m
//  iMobile Planner
//
//  Created by Juliana on 11/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ExistingPolicyPOListing.h"
#import "DataClass.h"

@interface ExistingPolicyPOListing () {
	DataClass *obj;
}

@end

@implementation ExistingPolicyPOListing

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
	[self.mainTableView reloadData];
	viewArr = [[NSMutableArray alloc] init];
	[viewArr addObject:[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyPO"] objectForKey:@"PolicyData"]];
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
    return [[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyPO"] objectForKey:@"PolicyData"] count];
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
		NSLog(@"fff2: %@", [[view objectAtIndex:indexPath.row]objectAtIndex:1]);
		cell.textLabel.text =  [NSString stringWithFormat:@"Company Name: %@",[[view objectAtIndex:indexPath.row]objectAtIndex:1]];//[[view objectAtIndex:indexPath.row]objectAtIndex:1];
        
        
        NSString *thisValue = [NSString stringWithFormat:@"Person Type: %@    Date: %@",[[view objectAtIndex:indexPath.row]objectAtIndex:0],[[view objectAtIndex:indexPath.row]objectAtIndex:6]];
        
        
        
		cell.detailTextLabel.text =thisValue;
	}
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyPO"] setValue:[NSNumber numberWithInt:indexPath.row] forKey:@"WhichPolicy"];
	MainAddPolicyPOVC *mappovc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainAddPolicyPO"];
	
	mappovc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:mappovc animated:YES completion:nil];
	[self.tableView reloadData];
	//	NSLog(@"fff: %@", [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] objectForKey:@"WhichPolicy"]);
	mappovc = Nil;

}

- (void)viewDidUnload {
	[self setMainTableView:nil];
	[super viewDidUnload];
}

@end
