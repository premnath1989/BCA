//
//  Country2.m
//  iMobile Planner
//
//  Created by Emi on 6/5/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import "Country2.h"
#import "FMDatabase.h"

NSString *SelectedString;
@interface Country2 ()

@end

@implementation Country2

@synthesize isFiltered,FilteredData;

@synthesize items = _items;
@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
		NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsPath = [paths objectAtIndex:0];
		
		databasePath = [documentsPath stringByAppendingPathComponent:@"hladb.sqlite"];
		FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
		[db open];
		NSString *strQuery;
		
		 _items = [NSMutableArray array];
		
		strQuery = [NSString stringWithFormat:@"select * from eProposal_Country"];
		
		FMResultSet *result = [db executeQuery:strQuery];
		
		while ([result next]) {
			[_items addObject:[result objectForColumnName:@"CountryDesc"]];
		}
		[result close];
		[db close];
		
		[self.tableView reloadData];
		
		sorted = [[NSArray alloc]init];
		sorted  =  [_items sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
		
		
        self.clearsSelectionOnViewWillAppear = NO;
        
        NSInteger rowsCount = [sorted count];
        NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView
                                               heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSInteger totalRowsHeight = rowsCount * singleRowHeight;
        
        
        CGFloat largestLabelWidth = 0;
        for (NSString *Title in sorted) {
            CGSize labelSize = [Title sizeWithFont:[UIFont boldSystemFontOfSize:20.0f]];
            if (labelSize.width > largestLabelWidth) {
                largestLabelWidth = labelSize.width;
            }
        }
        
        CGFloat popoverWidth = largestLabelWidth + 100;
        
        self.contentSizeForViewInPopover = CGSizeMake(popoverWidth, totalRowsHeight);
        
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
    UISearchBar *zzz = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 50) ];
    
    zzz.opaque = false;
    zzz.delegate = (id) self;
    self.tableView.tableHeaderView = zzz;
    CGRect searchbarFrame = zzz.frame;
    [self.tableView scrollRectToVisible:searchbarFrame animated:NO];
}

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if (text.length == 0) {
        isFiltered = false;
        
    }
    else {
        isFiltered = true;
        FilteredData = [[NSMutableArray alloc] init ];
		
        
        for (int a =0; a<sorted.count; a++ ) {
            NSRange Occu = [[sorted objectAtIndex:a ] rangeOfString:text options:NSCaseInsensitiveSearch];
            
            if (Occu.location != NSNotFound) {
                [FilteredData addObject:[sorted objectAtIndex:a ] ];
				
            }
        }
    }
    
    [self.tableView reloadData];
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
    if(isFiltered ==false)
        
        return [sorted count];
    else
        
        return [FilteredData count];
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
	
    if (isFiltered == false)
    {
        
        NSString *country = [sorted objectAtIndex:indexPath.row];
        cell.textLabel.text = country;
        
        
        if (country == SelectedString) {
            cell.accessoryType= UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
		
    }
    else
    {
        
        
        NSString *country = [FilteredData objectAtIndex:indexPath.row];
        cell.textLabel.text = country;
        
        
        if (country == SelectedString) {
            cell.accessoryType= UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
		
    }
	
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16 ];
    
    // Configure the cell...
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    
    if(_delegate != nil)
    {
        if (isFiltered == false)
        {
            NSString *country = [sorted objectAtIndex:indexPath.row];
            SelectedString = country;
			
            [_delegate Selected2Country:country];
        }
        else
        {
            NSString *country = [FilteredData objectAtIndex:indexPath.row];
            SelectedString = country;
            
            [_delegate Selected2Country:country];
			
        }
    }
	
    [tableView reloadData];
	
    
}

-(void) setTitle:(NSString *)title
{
    
    SelectedString = title;
    
    [self.tableView reloadData];
}

@end

