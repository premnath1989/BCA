//
//  PersonTypePopoverVC.m
//  iMobile Planner
//
//  Created by Juliana on 8/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "PersonTypePopoverVC.h"

@interface PersonTypePopoverVC ()

@end

@implementation PersonTypePopoverVC
@synthesize items,requestType;
@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	[super viewDidLoad];
    NSLog(@"requestType: %@", [self.requestType description]);
    if ([[self.requestType description] isEqualToString:@"LA"]) {
        self.items = [[NSMutableArray alloc] initWithObjects:@"1st Life Assured", @"Other Payor", nil];
    }
    else if ([[self.requestType description] isEqualToString:@"LA2"]) {
        self.items = [[NSMutableArray alloc] initWithObjects:@"1st Life Assured", @"2nd Life Assured", @"Other Payor" ,nil];
    }
	else if ([[self.requestType description] isEqualToString:@"PY1"]) {
        self.items = [[NSMutableArray alloc] initWithObjects:@"1st Life Assured", @"Payor", @"Other Payor" ,nil];
    }
	else if ([[self.requestType description] isEqualToString:@"LA3"]) {
        self.items = [[NSMutableArray alloc] initWithObjects:@"1st Life Assured",  @"2nd Life Assured", @"Payor", @"Other Payor" ,nil];
    }
	else if ([[self.requestType description] isEqualToString:@"PO"]) {
        self.items = [[NSMutableArray alloc] initWithObjects:@"1st Life Assured",  @"Policy Owner", @"Other Payor" ,nil];
    }
	else {
		self.items = [[NSMutableArray alloc] initWithObjects:@"1st Life Assured", @"Other Payor", nil];
	}
    
    self.clearsSelectionOnViewWillAppear = NO;
    
    NSInteger rowsCount = [self.items count];
    NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView
                                           heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSInteger totalRowsHeight = rowsCount * singleRowHeight;
    
    
    CGFloat largestLabelWidth = 0;
    for (NSString *Title in self.items) {
        CGSize labelSize = [Title sizeWithFont:[UIFont boldSystemFontOfSize:20.0f]];
        if (labelSize.width > largestLabelWidth) {
            largestLabelWidth = labelSize.width;
        }
    }
    
    CGFloat popoverWidth = largestLabelWidth + 100;
    
    self.contentSizeForViewInPopover = CGSizeMake(popoverWidth, totalRowsHeight);
	
	
	
	
}

- (id)initWithStyle:(UITableViewStyle)style
{
	/* self = [super initWithStyle:style];
	 if (self) {
	 // Custom initialization
	 
	 _PersonType = [[NSMutableArray alloc] initWithObjects:@"1st Life Assured", @"Other Payor" ,nil];
	 self.clearsSelectionOnViewWillAppear = NO;
	 
	 
	 NSInteger rowsCount = [_PersonType count];
	 NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView
	 heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
	 NSInteger totalRowsHeight = rowsCount * singleRowHeight;
	 
	 
	 CGFloat largestLabelWidth = 0;
	 for (NSString *FPT in _PersonType) {
	 //Checks size of text using the default font for UITableViewCell's textLabel.
	 CGSize labelSize = [FPT sizeWithFont:[UIFont boldSystemFontOfSize:20.0f]];
	 if (labelSize.width > largestLabelWidth) {
	 largestLabelWidth = labelSize.width;
	 }
	 }
	 
	 CGFloat popoverWidth = largestLabelWidth + 100;
	 
	 self.contentSizeForViewInPopover = CGSizeMake(popoverWidth, totalRowsHeight);
	 }
	 return self;
	 
	 */
	
	self = [super initWithStyle:style];
    if (self) {
    }
    return self;
	
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
    //return [_PersonType count];
	return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*static NSString *CellIdentifier = @"Cell";
	 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	 
	 if (cell==nil) {
	 cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	 
	 }
	 
	 
	 // Configure the cell...
	 cell.textLabel.text = [_PersonType objectAtIndex:indexPath.row];
	 
	 return cell; */
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    
    return cell;
	
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*NSString *selectedPersonType = [_PersonType objectAtIndex:indexPath.row];
	 
	 //Notify the delegate if it exists.
	 if (_delegate != nil) {
	 [_delegate selectedPersonType:selectedPersonType];
	 }
	 
	 */
	
	NSString *selectedPersonType = [self.items objectAtIndex:indexPath.row];
	NSLog(@"ENS Person Type selected: %@", selectedPersonType);
    [_delegate selectedPersonType:selectedPersonType];
}

@end