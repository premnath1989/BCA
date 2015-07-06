//
//  GroupListing.m
//  iMobile Planner
//
//  Created by shawal sapuan on 6/5/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "GroupListing.h"
#import "ColorHexCode.h"

@interface GroupListing ()

@end

@implementation GroupListing
@synthesize itemInArray,memberLabel,groupLabel,txtName,deleteBtn,editBtn,FilteredTableData,isFiltered;
@synthesize arrCountGroup;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.separatorColor = [UIColor clearColor];
    ItemToBeDeleted = [[NSMutableArray alloc] init];
    indexPaths = [[NSMutableArray alloc] init];
    FilteredTableData = [[NSMutableArray alloc] init];
    arrCountGroup = [[NSMutableArray alloc] init];
    
    deleteBtn.hidden = TRUE;
    deleteBtn.enabled = FALSE;
    isFiltered = FALSE;
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    
    CGRect frame1=CGRectMake(0,204, 640, 50);
    groupLabel.frame = frame1;
    groupLabel.textAlignment = UITextAlignmentCenter;
    groupLabel.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    groupLabel.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    groupLabel.numberOfLines = 2;
    
    CGRect frame2=CGRectMake(640,204, 384, 50);
    memberLabel.frame = frame2;
    memberLabel.textAlignment = UITextAlignmentCenter;
    memberLabel.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    memberLabel.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    
    [self refreshData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    // Added by Benjamin Law on 16/10/2013 to fix bug 2526
    [self refreshData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (interfaceOrientation==UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        return YES;
    
    return NO;
}


#pragma mark - action

- (IBAction)addNew:(id)sender
{
    UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:@"Enter Group Name" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    [dialog setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    [[dialog textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeDefault];
    [dialog setTag:1001];
    [dialog show];
}

-(void)refreshData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"dataGroup.plist"];
	
	itemInArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
    arrCountGroup = [[NSMutableArray alloc] init];
    
    for (NSString *arr in itemInArray) {
        [self CalculateMember:arr];
    }
    
	[self.myTableView reloadData];
}

- (IBAction)search:(id)sender
{
    NSString *txt = txtName.text;
    if(txt.length == 0)
    {
        isFiltered = FALSE;
    }
    else
    {
        isFiltered = true;
        FilteredTableData = [[NSMutableArray alloc] init];
        
        for (NSString *zzz in itemInArray)
        {
            NSRange Fullname = [zzz  rangeOfString:txt options:NSCaseInsensitiveSearch];
            if (Fullname.location != NSNotFound) {
                [FilteredTableData addObject:zzz];
            }
        }
        
        arrCountGroup = [[NSMutableArray alloc] init];
        for (NSString *arr in FilteredTableData) {
            [self CalculateMember:arr];
        }
        
        [self.myTableView reloadData];
    }
    
}

- (IBAction)reset:(id)sender
{
    isFiltered = FALSE;
    txtName.text = @"";
    [self refreshData];
}

- (IBAction)editPressed:(id)sender
{
    [self resignFirstResponder];
    if ([self.myTableView isEditing]) {
        [self.myTableView setEditing:NO animated:TRUE];
        deleteBtn.hidden = true;
        deleteBtn.enabled = false;
        [editBtn setTitle:@"Delete" forState:UIControlStateNormal ];
        
        ItemToBeDeleted = [[NSMutableArray alloc] init];
        indexPaths = [[NSMutableArray alloc] init];
    }
    else{
        [self.myTableView setEditing:YES animated:TRUE];
        deleteBtn.hidden = FALSE;
        [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
        [editBtn setTitle:@"Cancel" forState:UIControlStateNormal ];
    }
}

- (IBAction)deletePressed:(id)sender
{
    NSString *ss;
    bool zz = false;
    int RecCount = 0;
    for (UITableViewCell *cell in [self.myTableView visibleCells])
    {
        if (cell.selected == TRUE) {
            NSIndexPath *selectedIndexPath = [self.myTableView indexPathForCell:cell];
            if (RecCount == 0) {
                ss = [itemInArray objectAtIndex:selectedIndexPath.row];
            }
            
            RecCount = RecCount + 1;
            // Remove by Benjamin on 16/10/2013 for bug 2436
//            if (RecCount > 1) {
//                break;
//            }
            if ([arrCountGroup objectAtIndex:selectedIndexPath.row] > 0) {
                zz = true;
            }
        }
    }
    
    NSString *msg;
    if (RecCount == 1 && !zz) {
        msg = [NSString stringWithFormat:@"Delete %@",ss];
    }
    else  if (RecCount == 1 && zz) {
        msg = [NSString stringWithFormat:@"Are you sure you want to delete Group %@? If yes, please note that all the related client profile will be untagged from this group?", ss];
    }
    else if (zz) {
        msg = @"One of the group contain member/s. Are you sure want to delete these Group(s)?";
    }
    else if (!zz) {
        msg = @"Are you sure want to delete these Group(s)?";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert setTag:1002];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001 && buttonIndex == 1) {
        
        NSString *str = [NSString stringWithFormat:@"%@",[[alertView textFieldAtIndex:0]text] ];
        if (str.length != 0) {
            
            NSMutableArray *array = [[NSMutableArray alloc] init];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsPath = [paths objectAtIndex:0];
            NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"dataGroup.plist"];
            [array addObjectsFromArray:[NSArray arrayWithContentsOfFile:plistPath]];
            
            BOOL Found = NO;
            
            for (NSString *existing in array) {
                
                if ([str isEqualToString:existing]) {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Group already exist" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                    [alert show];
                    
                    Found = YES;
                    break;
                }
            }
            
            if (!Found) {
                
                [array addObject:str];
                [array writeToFile:plistPath atomically: TRUE];
                
                [self refreshData];
            }
            
        }
        else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please insert data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            [alert show];
        }
    }
    else if (alertView.tag == 1002 && buttonIndex == 0)
    {
        NSLog(@"itemToBeDeleted:%d", ItemToBeDeleted.count);
        
        if (ItemToBeDeleted.count < 1) {
            return;
        }
        else{
            NSLog(@"itemToBeDeleted:%d", ItemToBeDeleted.count);
        }
        
        NSArray *sorted = [[NSArray alloc] init ];
        sorted = [ItemToBeDeleted sortedArrayUsingComparator:^(id firstObject, id secondObject){
            return [((NSString *)firstObject) compare:((NSString *)secondObject) options:NSNumericSearch];
        }];
        
        for(int a=0; a<sorted.count; a++) {
            int value = [[sorted objectAtIndex:a] intValue];
            value = value - a;
            
            [itemInArray removeObjectAtIndex:value];
        }
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0];
        NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"dataGroup.plist"];
        
        [itemInArray writeToFile:plistPath atomically: TRUE];
        [self.myTableView reloadData];
    }
}

-(void)CalculateMember:(NSString *)theGroup
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"select count(*) from prospect_profile where ProspectGroup=\"%@\" ", theGroup];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *str = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                [arrCountGroup addObject:str];
                
            } else {
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowCount;
    if(self.isFiltered)
        rowCount = FilteredTableData.count;
    else
        rowCount = itemInArray.count;
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
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    
    NSString *itemDisplay = nil;
    if(isFiltered) {
        itemDisplay = [FilteredTableData objectAtIndex:indexPath.row];
    }
    else {
        itemDisplay = [itemInArray objectAtIndex:indexPath.row];
    }
    
    CGRect frame=CGRectMake(-30,0, 670, 50);
    UILabel *label1=[[UILabel alloc]init];
    label1.frame=frame;
    label1.text= [NSString stringWithFormat:@"        %@",itemDisplay];
    label1.textAlignment = UITextAlignmentLeft;
    label1.tag = 2001;
    [cell.contentView addSubview:label1];
    
    CGRect frame2=CGRectMake(640,0, 384, 50);
    UILabel *label2=[[UILabel alloc]init];
    label2.frame=frame2;
    label2.text= [arrCountGroup objectAtIndex:indexPath.row];
    label2.textAlignment = UITextAlignmentCenter;
    label2.tag = 2002;
    [cell.contentView addSubview:label2];
    
    if (indexPath.row % 2 == 0) {
        label1.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label2.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        
        label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    }
    else {
        label1.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        label2.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        
        label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.myTableView isEditing] == TRUE ) {
        BOOL gotRowSelected = FALSE;
        
        for (UITableViewCell *zzz in [self.myTableView visibleCells])
        {
            if (zzz.selected  == TRUE) {
                gotRowSelected = TRUE;
                break;
            }
        }
        
        if (!gotRowSelected) {
            [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
            deleteBtn.enabled = FALSE;
        }
        else {
            [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            deleteBtn.enabled = TRUE;
        }
        
        NSString *zzz = [NSString stringWithFormat:@"%d", indexPath.row];
        [ItemToBeDeleted addObject:zzz];
        [indexPaths addObject:indexPath];
    }
    else {
        NSLog(@"go other page!");
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.myTableView isEditing] == TRUE ) {
        BOOL gotRowSelected = FALSE;
        
        for (UITableViewCell *zzz in [self.myTableView visibleCells])
        {
            if (zzz.selected  == TRUE) {
                gotRowSelected = TRUE;
                break;
            }
        }
        
        if (!gotRowSelected) {
            [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
            deleteBtn.enabled = FALSE;
        }
        else {
            [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            deleteBtn.enabled = TRUE;
        }
        
        NSString *zzz = [NSString stringWithFormat:@"%d", indexPath.row];
        [ItemToBeDeleted removeObject:zzz];
        [indexPaths removeObject:indexPath];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [self setMyTableView:nil];
    [self setGroupLabel:nil];
    [self setMemberLabel:nil];
    [self setTxtName:nil];
    [self setEditBtn:nil];
    [self setDeleteBtn:nil];
    [self setArrCountGroup:Nil];
    [self setItemInArray:nil];
    [super viewDidUnload];
}

@end
