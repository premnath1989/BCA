//
//  GroupClass.m
//  iMobile Planner
//
//  Created by shawal sapuan on 7/7/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "GroupClass.h"
#import "FMDatabase.h"

NSString *SelectedString;
	
@interface GroupClass ()

@end

@implementation GroupClass
@synthesize group = _group;
@synthesize delegate = _delegate;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsPath = [paths objectAtIndex:0];
    
    
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(300.0, 400.0);
	
    _group = [NSMutableArray array];

	NSString *databasePath = [documentsPath stringByAppendingPathComponent:@"hladb.sqlite"];
	FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
	[db open];
	NSString *strQuery;
	
	if (!_needFiltered)
		strQuery = [NSString stringWithFormat:@"select * from prospect_groups"];
		
	else {
		strQuery = [NSString stringWithFormat:@"select * from prospect_groups where ID NOT IN (%@)", self.blacklist];
	}
	
	FMResultSet *result = [db executeQuery:strQuery];
	
	while ([result next]) {
		[_group addObject:[result objectForColumnName:@"name"]];
	}
	[result close];
	[db close];
    
	[self.tableView reloadData];
	
	self.clearsSelectionOnViewWillAppear = NO;
	
	NSInteger rowsCount = [_group count];
	NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView
										   heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
	NSInteger totalRowsHeight = rowsCount * singleRowHeight;
	
	
	CGFloat largestLabelWidth = 0;
    CGSize labelSize;
	for (NSString *Title in _group) {
		labelSize = [Title sizeWithFont:[UIFont boldSystemFontOfSize:20.0f]];
		if (labelSize.width > largestLabelWidth) {
			largestLabelWidth = labelSize.width;
		}
	}
	
	CGFloat popoverWidth = largestLabelWidth + 100;
	
	self.contentSizeForViewInPopover = CGSizeMake(popoverWidth, totalRowsHeight);	
	
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
    
    return [_group count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
	
	cell.textLabel.text = [_group objectAtIndex:indexPath.row];
    
    if ([_group objectAtIndex:indexPath.row] == SelectedString) {
        
        cell.accessoryType= UITableViewCellAccessoryCheckmark;
    }
    else
    {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16 ];
	
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedGroup = [_group objectAtIndex:indexPath.row];
    if (_delegate != nil) {
        [_delegate selectedGroup:selectedGroup];
         SelectedString = [_group objectAtIndex:indexPath.row ];        
    }
    
    [tableView reloadData];
}

-(void) setTitle:(NSString *)title
{    
    SelectedString = title;    
    [self.tableView reloadData];
}
@end
