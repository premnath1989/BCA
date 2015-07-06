//
//  ClientGroup.m
//  iMobile Planner
//
//  Created by Emi on 9/12/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ClientGroup.h"
#import "GroupClass.h"
#import "FMDatabase.h"
#import "ColorHexCode.h"

@interface ClientGroup ()

@end

@implementation ClientGroup

@synthesize Backbtn, donebtn, BtnAddNew, BtnCancel, BtnDelete, BtnNewGroup, BtnSelectGroup, LblTitle, lbltitleGroup, GroupName;
@synthesize GroupTableData;
@synthesize data, indexPaths, itemToBeDeleted, tableViewGroup, UDGroup;
@synthesize GroupList = _GroupList;
@synthesize groupPopover = _GroupPopover;

FMDatabase *db;
NSMutableArray *groupArr;
NSMutableArray *groupArrDB;
NSMutableArray *DelGroupArr;

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
	
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsDir = [dirPaths objectAtIndex:0];
	NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	db = [FMDatabase databaseWithPath:databasePath];
	
	itemToBeDeleted = [NSMutableArray array];
	groupArrDB = [NSMutableArray array];
	DelGroupArr = [NSMutableArray array];
	
//	GroupName.hidden = YES;
//	BtnAddNew.hidden = YES;
	
	
	BtnDelete.hidden = YES;
	[BtnCancel setTitle:@"Delete" forState:UIControlStateNormal];

	UDGroup = [NSUserDefaults standardUserDefaults];
	 
	LblTitle.text = [NSString stringWithFormat:@"Grouping for %@", [UDGroup stringForKey:@"ProspectName"]];
	
	[self LoadDataTable];
	
	
	
}

- (void) LoadDataTable {
	
	groupArr = [NSMutableArray array];
	
	NSMutableArray *tempArr = [UDGroup objectForKey:@"groupArr"];
	groupArr = [tempArr mutableCopy];
	
	groupArrDB = [[NSMutableArray alloc] init];
	
	[db open];
	FMResultSet *result = [db executeQuery:@"select * from prospect_groups"];
	[groupArrDB removeAllObjects];
	
	while ([result next]) {
		[groupArrDB addObject:[result objectForColumnName:@"name"]];
	}
	
	[self.tableViewGroup reloadData];
}


- (IBAction)backPressed:(id)sender {
	
	//Save array in NSUserDefault
	[UDGroup setObject:groupArr forKey:@"groupArr"];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"DismissGroup" object:self];
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)AddNewPress:(id)sender {
	
	NSString *aaID = @"00"; //data not save in DB yet, set ID as 00
	NSString *gName = [GroupName.text stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
	 
	if (![gName isEqualToString:@""]) {
		
		BOOL found = NO;
		for (NSString *existing in groupArrDB) {
			if ([gName caseInsensitiveCompare:existing] == NSOrderedSame) {
//			if ([gName isEqualToString:existing]) {
				
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Group already exist" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
				[alert show];
				found = YES;
				break;
			}
		}
		if (!found) {
			NSDictionary *tempData = [[NSDictionary alloc] initWithObjectsAndKeys:aaID, @"id", gName, @"name", nil];
			[groupArr addObject:[tempData copy]];
			
			NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
			[ClientProfile setObject:@"YES" forKey:@"isEdited"];
			
//			GroupName.hidden = NO;
//			BtnAddNew.hidden = NO;
		}
	}
	
	[self.groupPopover dismissPopoverAnimated:YES];
	[self.tableViewGroup reloadData];
	
	GroupName.text = @"";
	
	[self hideKeyboard];
	
	
}

-(void)hideKeyboard{
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
    
}

- (IBAction)DeletePressed:(id)sender{
	int RecCount = 0;
	BOOL alertC = NO;
	NSString *Gname = @"";
	
	
    for (UITableViewCell *cell in [self.tableViewGroup visibleCells])
    {
		NSString *ss;
		NSString *groupID;
		
		int count;
        if (cell.selected == TRUE) {
            NSIndexPath *selectedIndexPath = [self.tableViewGroup indexPathForCell:cell];
            if (RecCount == 0) {
                ss = [[groupArr objectAtIndex:selectedIndexPath.row] objectForKey:@"name"];
            }
			
			groupID = [[groupArr objectAtIndex:selectedIndexPath.row] objectForKey:@"id"];
			count = [self calculateGroup:groupID];
			
			if (count == 1) {
				alertC = YES;
				
				NSDictionary *tempData = [[NSDictionary alloc] initWithObjectsAndKeys:[[groupArr objectAtIndex:selectedIndexPath.row] objectForKey:@"id"], @"id", [[groupArr objectAtIndex:selectedIndexPath.row] objectForKey:@"name"], @"name", nil];
				[DelGroupArr addObject:[tempData copy]];
//				[DelGroupArr addObject:[[groupArr objectAtIndex:selectedIndexPath.row] objectForKey:@"id"]];
				
				if ([Gname isEqualToString:@""]) {
					Gname = [[groupArr objectAtIndex:selectedIndexPath.row] objectForKey:@"name"];
				}
				else {
					Gname = [NSString stringWithFormat:@"%@, %@", Gname, [[groupArr objectAtIndex:selectedIndexPath.row] objectForKey:@"name"]];
				}
			}
			
            RecCount = RecCount + 1;
        }
    }
	
	if (alertC) {
		NSString *GroupAlert=[NSString stringWithFormat:@"Group %@ will be auto deleted by system as no member attached to this group.",Gname];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:GroupAlert delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
		[alert setTag:1001];
		[alert show];
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Are you sure want to delete?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
		[alert setTag:1001];
		[alert show];
	}
	
	
}

- (int) calculateGroup:(NSString*)groupID {
	
	int countGroup;
	[db open];
	FMResultSet *result2;
	
	NSString *queryStr = [NSString stringWithFormat:@"select count(*) as count from prospect_profile where (ProspectGroup = %@ OR ProspectGroup LIKE '%%,%@' OR ProspectGroup LIKE '%@,%%' OR ProspectGroup LIKE '%%,%@,%%')", groupID, groupID, groupID, groupID];
	result2 = [db executeQuery:queryStr];
	
	while ([result2 next]) {
		countGroup = [[result2 objectForColumnName:@"count"] integerValue];
	}
	
	return countGroup;
}

- (IBAction)CancelPressed:(id)sender {
	
	if ([BtnCancel.titleLabel.text isEqualToString:@"Delete"]) {
		[BtnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
		BtnDelete.hidden = NO;
		[self.tableViewGroup setEditing:YES animated:TRUE];
	}
	else {
		[BtnCancel setTitle:@"Delete" forState:UIControlStateNormal];
		BtnDelete.hidden = YES;
		[self.tableViewGroup setEditing:NO animated:TRUE];
	}
	
}

- (IBAction)NewGroupPressed:(id)sender {
	GroupName.hidden = NO;
	BtnAddNew.hidden = NO;
}
- (IBAction)SelectGroupPressed:(id)sender {
	
	[self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
//    if (_GroupList == nil) {
    
        	self.GroupList = [[GroupClass alloc] initWithStyle:UITableViewStylePlain];
	
        _GroupList.delegate = self;
		
		if (groupArr.count !=0) {
			NSString *blacklist = @"";
			_GroupList.needFiltered = YES;
			for (int i = 0; i <= groupArr.count-1; i++) {
				NSLog(@"id %@", [[groupArr objectAtIndex:i] objectForKey:@"id"]);
				if ([[groupArr objectAtIndex:i] objectForKey:@"id"] != nil && ![[[groupArr objectAtIndex:i] objectForKey:@"id"] isEqualToString:@"(null)"]) {
				if (i==0)
					blacklist = [[groupArr objectAtIndex:i] objectForKey:@"id"];
				else
					blacklist = [NSString stringWithFormat:@"%@,%@", blacklist, [[groupArr objectAtIndex:i] objectForKey:@"id"]];
				}
			}
			NSLog(@"indxNO: %@", blacklist);
			_GroupList.blacklist = blacklist;
			
		}
	
	
		
        self.groupPopover = [[UIPopoverController alloc] initWithContentViewController:_GroupList];

	
//    }
    
    CGRect butt = [sender frame];
    int y = butt.origin.y;
    butt.origin.y = y;
	
    [self.groupPopover presentPopoverFromRect:butt inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}

-(void)selectedGroup:(NSString *)aaGroup
{
//	[groupArr addObject:aaGroup];
	
	NSString *aaID = [self getGroupID:aaGroup];
	
	NSDictionary *tempData = [[NSDictionary alloc] initWithObjectsAndKeys:aaID, @"id", aaGroup, @"name", nil];
	[groupArr addObject:[tempData copy]];
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
	
	[self.groupPopover dismissPopoverAnimated:YES];
	[self.tableViewGroup reloadData];
	
}

- (NSString*) getGroupID:(NSString*)groupname
{
	groupname = [groupname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSString *groupid = @"";
//	FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
	[db open];
    
	FMResultSet *result = [db executeQuery:@"SELECT id from prospect_groups WHERE name = ?", groupname];
	while ([result next]) {
		groupid =  [result stringForColumn:@"id"];
        
	}
	[result close];
	[result close];
    
	return groupid;
    
}

- (NSString*) getGroupName:(NSString*)groupid
{
    
	groupid = [groupid stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSString *groupname = @"";
//	FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
	[db open];
    
	FMResultSet *result = [db executeQuery:@"SELECT name from prospect_groups WHERE id = ?", groupid];
	while ([result next]) {
		groupname =  [result stringForColumn:@"name"];
		
	}
	
	[result close];
    
	return groupname;
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([self.tableViewGroup isEditing] == TRUE ) {
        BOOL gotRowSelected = FALSE;
        
        for (UITableViewCell *zzz in [self.tableViewGroup visibleCells])
        {
            if (zzz.selected  == TRUE) {
                gotRowSelected = TRUE;
                break;
            }
        }
        
        if (!gotRowSelected) {
            [BtnDelete setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
            BtnDelete.enabled = FALSE;
        }
        else {
            [BtnDelete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            BtnDelete.enabled = TRUE;
        }
        
        NSString *zzz = [NSString stringWithFormat:@"%d", indexPath.row];
        [itemToBeDeleted addObject:zzz];
		//        [indexPaths addObject:indexPath];
    }
	
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.tableViewGroup isEditing] == TRUE ) {
        BOOL gotRowSelected = FALSE;
        
        for (UITableViewCell *zzz in [self.tableViewGroup visibleCells])
        {
            if (zzz.selected  == TRUE) {
                gotRowSelected = TRUE;
                break;
            }
        }
        
        if (!gotRowSelected) {
            [BtnDelete setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
            BtnDelete.enabled = FALSE;
        }
        else {
            [BtnDelete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            BtnDelete.enabled = TRUE;
        }
        
        NSString *zzz = [NSString stringWithFormat:@"%d", indexPath.row];
        [itemToBeDeleted removeObject:zzz];
		
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (alertView.tag == 1001 && buttonIndex == 0)
    {
        if (itemToBeDeleted.count < 1) {
            return;
        }
        else{
            NSLog(@"itemToBeDeleted:%d", itemToBeDeleted.count);
        }
	
		//sorted deleted valued
		NSArray *sorted = [[NSArray alloc] init ];
		sorted = [itemToBeDeleted sortedArrayUsingComparator:^(id firstObject, id secondObject){
			return [((NSString *)firstObject) compare:((NSString *)secondObject) options:NSNumericSearch];
		}];
		
	
		//remove from data table
		int j = sorted.count;
		while (j != 0) {
			NSString *indexNodel = [sorted objectAtIndex:(j-1)];
			int idxNo = [indexNodel integerValue];

			[groupArr removeObjectAtIndex:idxNo];
			j = j - 1;
			
			NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
			[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		}
		
		[UDGroup setObject:DelGroupArr forKey:@"DelGroupArr"];
			
		[itemToBeDeleted removeAllObjects]; //clear all in delete array
		[self.tableViewGroup reloadData];
    }
	if (alertView.tag == 1001 && buttonIndex == 1) //NO cancel delete
    {
        
    }
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

@end
