//
//  NewGroupListing.m
//  iMobile Planner
//
//  Created by Erza on 11/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "NewGroupListing.h"
#import "FMDatabase.h"

@interface NewGroupListing () {
    FMDatabase *db;
    NSMutableArray *member;
    NSMutableArray *nonMember;
    bool memberSelect;
    bool nonMemberSelect;
    int selectedRow;
}

@end

@implementation NewGroupListing

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
	// Do any additional setup after loading the view.
    member = [NSMutableArray array];
    nonMember = [NSMutableArray array];
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"select IndexNo, ProspectName from prospect_profile where ProspectGroup = ? order by ProspectName ASC", [self.data objectForKey:@"id"]];
    while ([result next]) {
        NSDictionary *tempData = [[NSDictionary alloc] initWithObjectsAndKeys:[result objectForColumnName:@"IndexNo"], @"id", [result objectForColumnName:@"ProspectName"], @"name", nil];
        [member addObject:[tempData copy]];
    }
    
    result = nil;
    result = [db executeQuery:@"select * from prospect_profile where (ProspectGroup IS NULL or ProspectGroup = '' or ProspectGroup = '- SELECT -') AND QQFlag = 'false' order by ProspectName ASC"];
    while ([result next]) {
        NSDictionary *tempData = [[NSDictionary alloc] initWithObjectsAndKeys:[result objectForColumnName:@"IndexNo"], @"id", [result objectForColumnName:@"ProspectName"], @"name", nil];
        [nonMember addObject:[tempData copy]];
    }
    [result close];
    [db close];
    
    self.naviBar.topItem.title = [self.data objectForKey:@"name"];

    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMemberTV:nil];
    [self setNonMemberTV:nil];
    [self setRightBtn:nil];
    [self setLeftBtn:nil];
    [self setDoneBtn:nil];
    [self setNaviBar:nil];
    [super viewDidUnload];
}

#pragma mark - Table Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (tableView == self.memberTV) {
        return member.count;
    }
    else if (tableView == self.nonMemberTV) {
        return nonMember.count;
    }
    
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.memberTV) {
        memberSelect = TRUE;
        nonMemberSelect = FALSE;
        
        
    }
    else if (tableView == self.nonMemberTV) {
        memberSelect = FALSE;
        nonMemberSelect = TRUE;
    }
    
    selectedRow = indexPath.row;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *tempArray = nil;
    if (tableView == self.memberTV) {
        tempArray = member;
    }
    else if (tableView == self.nonMemberTV) {
        tempArray = nonMember;
    }
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    
    // Configure the cell...
    cell.textLabel.text = [[tempArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;
}
#pragma mark - action
- (IBAction)doneBtnPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)rightBtnPressed:(id)sender {
    if (memberSelect && selectedRow > -1 && selectedRow < member.count) {
        
        //[member sortUsingSelector:@selector(compare:)];
        //[nonMember sortUsingSelector:@selector(compare:)];
        
        if (!db) {
            NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *docsDir = [dirPaths objectAtIndex:0];
            NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
            db = [FMDatabase databaseWithPath:databasePath];
        }
        [db open];
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE prospect_profile SET ProspectGroup = '' WHERE IndexNo = %@", [[member objectAtIndex:selectedRow] objectForKey:@"id"]]];
        [db close];
        
        [nonMember addObject:[[member objectAtIndex:selectedRow] copy]];
        [member removeObjectAtIndex:selectedRow];
        selectedRow = -1;
        nonMemberSelect = FALSE;
        memberSelect = FALSE;
        [self.memberTV reloadData];
        [self.nonMemberTV reloadData];
    }
}

- (IBAction)leftBtnPressed:(id)sender {
    if (nonMemberSelect && selectedRow > -1 && selectedRow < nonMember.count) {
        if (!db) {
            NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *docsDir = [dirPaths objectAtIndex:0];
            NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
            db = [FMDatabase databaseWithPath:databasePath];
        }
        [db open];
        [db executeUpdate:[NSString stringWithFormat:@"UPDATE prospect_profile SET ProspectGroup = %@ WHERE IndexNo = %@", [self.data objectForKey:@"id"] ,[[nonMember objectAtIndex:selectedRow] objectForKey:@"id"]]];
        [db close];
        
        [member addObject:[[nonMember objectAtIndex:selectedRow] copy]];
        [nonMember removeObjectAtIndex:selectedRow];
        //[member sortUsingSelector:@selector(compare:)];
        //[nonMember sortUsingSelector:@selector(compare:)];
        selectedRow = -1;
        nonMemberSelect = FALSE;
        memberSelect = FALSE;
        [self.memberTV reloadData];
        [self.nonMemberTV reloadData];
    }
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
@end
