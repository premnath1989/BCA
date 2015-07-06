//
//  ExistingPoliciesPersonType.m
//  iMobile Planner
//
//  Created by Juliana on 11/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ExistingPoliciesPersonType.h"
#import "DataClass.h"

@interface ExistingPoliciesPersonType () {
	DataClass *obj;
}

@end

@implementation ExistingPoliciesPersonType
@synthesize delegate = delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
		obj = [DataClass getInstance];
//		self.items = [[NSMutableArray alloc] initWithObjects:@"1st Life Assured", @"Policy Owner", @"2nd Life Assured", nil];
		_items = [[NSMutableArray alloc] init];
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *docsPath = [paths objectAtIndex:0];
		NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
		
		FMDatabase *database = [FMDatabase databaseWithPath:path];
		[database open];
		stringID = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
		//	NSLog(@"string id: %@, si: %@", stringID, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"]);
		
		results = Nil;
		results = [database executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ?",stringID,Nil];
		while ([results next]) {
			code = [results stringForColumn:@"PTypeCode"];
			if ([code isEqualToString:@"LA1"]) {
				desc = @"1st Life Assured";
			}
			else if ([code isEqualToString:@"LA2"]) {
				desc = @"2nd Life Assured";
			}
			else if ([code isEqualToString:@"PY1"]) {
				desc = @"Policy Owner";
			}
			else if ([code isEqualToString:@"PO"]) {
				desc = @"Policy Owner";
			}
			[_items addObject:desc];
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
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
	if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];

    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *zzz = [self.items objectAtIndex:indexPath.row];
    [delegate selectedPersonType:zzz];
}

@end
