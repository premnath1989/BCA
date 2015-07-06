//
//  RiderPTypeTbViewController.m
//  HLA
//
//  Created by shawal sapuan on 8/29/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "RiderPTypeTbViewController.h"

@interface RiderPTypeTbViewController ()

@end

@implementation RiderPTypeTbViewController
@synthesize ptype,seqNo,desc,requestSINo,selectedCode,selectedDesc,selectedSeqNo,SINoPlan,age,Occp;
@synthesize selectedAge,selectedOccp, TradOrEver, sex;
@synthesize delegate = _delegate;

-(id)initWithString:(NSString *)stringCode str:(NSString *)getTradOrEver {
    self = [super init];
    if (self != nil) {
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsDir = [dirPaths objectAtIndex:0];
        databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
        
        NSLog(@"RIDERPTYPE initSINo:%@",stringCode);
        SINoPlan = [NSString stringWithFormat:@"%@",stringCode];
		TradOrEver = getTradOrEver;
        [self getPersonType];
    }
    return self;
}
/*
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    NSLog(@"RIDERPTYPE loadSINo:%@",[self.requestSINo description]);
    
    SINoPlan = [NSString stringWithFormat:@"%@",[self.requestSINo description]];
    [self getPersonType];
}*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - db

-(void)getPersonType
{
    ptype = [[NSMutableArray alloc] init];
    seqNo = [[NSMutableArray alloc] init];
    desc = [[NSMutableArray alloc] init];
    age = [[NSMutableArray alloc] init];
    Occp = [[NSMutableArray alloc] init];
	sex = [[NSMutableArray alloc] init];
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
		
		NSString *querySQL;
		if ([TradOrEver isEqualToString:@"TRAD"]) {
			querySQL = [NSString stringWithFormat:
								  @"SELECT a.PTypeCode,a.Sequence,b.PTypeDesc,c.ALB,c.OccpCode, c.Sex "
								  "FROM Trad_LAPayor a LEFT JOIN Adm_PersonType b ON a.PTypeCode=b.PTypeCode AND a.Sequence=b.Seq "
								  "LEFT JOIN Clt_Profile c ON a.CustCode=c.CustCode WHERE a.SINo=\"%@\"",SINoPlan];
		}
		else{
			querySQL = [NSString stringWithFormat:
						@"SELECT a.PTypeCode,a.Seq,b.PTypeDesc,c.ALB,c.OccpCode, c.Sex "
						"FROM UL_LAPayor a LEFT JOIN Adm_PersonType b ON a.PTypeCode=b.PTypeCode AND a.Seq=b.Seq "
						"LEFT JOIN Clt_Profile c ON a.CustCode=c.CustCode WHERE a.SINo=\"%@\"",SINoPlan];
		}
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                [ptype addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)]];
                [seqNo addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)]];
                [desc addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)]];
                [age addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)]];
                [Occp addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)]];
				[sex addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)]];
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
    return [ptype count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *itemDesc = [desc objectAtIndex:indexPath.row];
    if ([[ptype objectAtIndex:indexPath.row] isEqualToString:@"PY"]) {
        itemDesc = [itemDesc substringWithRange:NSMakeRange(0, 5)];
    }
    
	cell.textLabel.text = itemDesc;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    
	if (indexPath.row == selectedIndex) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
	else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = indexPath.row;
    [_delegate PTypeController:self didSelectCode:self.selectedCode
						 seqNo:self.selectedSeqNo desc:self.selectedDesc andAge:self.selectedAge andOccp:self.selectedOccp
						andSex:self.selectedSex];
    [tableView reloadData];
}

-(NSString *)selectedCode
{
    return [ptype objectAtIndex:selectedIndex];
}

-(NSString *)selectedSeqNo
{
    return [seqNo objectAtIndex:selectedIndex];
}

-(NSString *)selectedDesc
{
    return [desc objectAtIndex:selectedIndex];
}

-(NSString *)selectedAge
{
    return [age objectAtIndex:selectedIndex];
}

-(NSString *)selectedOccp
{
    return [Occp objectAtIndex:selectedIndex];
}

-(NSString *)selectedSex
{
    return [sex objectAtIndex:selectedIndex];
}


#pragma mark - Memory Management

- (void)viewDidUnload
{
    [self setDelegate:nil];
    [self setPtype:nil];
    [self setSeqNo:nil];
    [self setDesc:nil];
    [self setSINoPlan:nil];
    [self setOccp:nil];
    [super viewDidUnload];
}

@end
