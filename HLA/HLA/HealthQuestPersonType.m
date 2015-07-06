//
//  HealthQuestPersonType.m
//  iMobile Planner
//
//  Created by kuan on 9/14/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "HealthQuestPersonType.h"
#import "DataClass.h"
#import "AppDelegate.h"
@interface HealthQuestPersonType ()


@end

@implementation HealthQuestPersonType
@synthesize items,requestType;
@synthesize delegate = _delegate;
DataClass *obj;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    obj = [DataClass getInstance];
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    NSString *POOtherIDType;
    FMResultSet  *results4 = [database executeQuery:@"select LAOtherIDType from eProposal_LA_Details where eProposalNo = ? AND POFlag = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"N"];
    
    while ([results4 next]) {
        POOtherIDType = [results4 objectForColumnName:@"LAOtherIDType"];
    }
    
    AppDelegate *appobj=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    //if(){
    NSLog(@"Total LA: %@", [self.requestType description]);
    if ([[self.requestType description] isEqualToString:@"LA"]) {
        self.items = [[NSMutableArray alloc] initWithObjects:@"1st Life Assured", nil];
    }
    else if ([[self.requestType description] isEqualToString:@"LA2"]) {
        self.items = [[NSMutableArray alloc] initWithObjects:@"1st Life Assured", @"2nd Life Assured",nil];
    }
	else if ([[self.requestType description] isEqualToString:@"PY1"] && (appobj.HandlingEDDCase==YES)) {
        self.items = [[NSMutableArray alloc] initWithObjects:@"1st Life Assured", @"Payor",nil];
    }
    else if ([[self.requestType description] isEqualToString:@"PY1"] && (appobj.HandlingEDDCase==NO)) {
        self.items = [[NSMutableArray alloc] initWithObjects:@"Payor",nil];
    }
	else if ([[self.requestType description] isEqualToString:@"PO"]) {
        self.items = [[NSMutableArray alloc] initWithObjects:@"1st Life Assured", @"Policy Owner",nil];
    }
	else if ([[self.requestType description] isEqualToString:@"AddPolicy"]) {
        self.items = [[NSMutableArray alloc] initWithObjects:@"1st Life Assured", @"Payor",nil];
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
    
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    NSString *zzz = [self.items objectAtIndex:indexPath.row];
	NSLog(@"Selected personType: %@", zzz);
	
	obj = [DataClass getInstance];
	[[obj.eAppData objectForKey:@"SecE"] setValue:zzz forKey:@"PersonType"];
	NSLog(@"TEST: %@", [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"PersonType"]);
	
    [_delegate selectedPersonType:zzz];
}

@end
