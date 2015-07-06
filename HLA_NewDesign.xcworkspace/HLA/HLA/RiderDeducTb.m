//
//  RiderDeducTb.m
//  HLA Ipad
//
//  Created by shawal sapuan on 11/21/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "RiderDeducTb.h"

@interface RiderDeducTb ()

@end

@implementation RiderDeducTb
@synthesize selectedItem,itemDesc,itemValue,selectedItemDesc;
@synthesize delegate = _delegate;
@synthesize requestSA,requestCondition,requestOption;

-(id)initWithString:(NSString *)stringCode andSumAss:(NSString *)strSum andOption:(NSString *)strOpt
{
    self = [super init];
    if (self != nil) {
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsDir = [dirPaths objectAtIndex:0];
        databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
        
        requestCondition = [NSString stringWithFormat:@"%@",stringCode];
        requestSA = [strSum doubleValue];
        requestOption = [NSString stringWithFormat:@"%@",strOpt];
        [self getRiderCondition];
        NSLog(@"condition:%@, sumA:%.2f, option:%@",self.requestCondition,self.requestSA,self.requestOption);
        
        
        if (self.requestSA >= 25000 && [self.requestCondition isEqualToString:@"DeductibleHMM"] && [self.requestOption isEqualToString:@"HMM_1000"]) {
            [itemValue removeAllObjects];
            [itemDesc removeAllObjects];
            
            [itemValue addObject:@"4"];
            [itemDesc addObject:@"30000"];
        }
        
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
    
    [self getRiderCondition];
    
    if (self.requestSA >= 25000 && [self.requestCondition isEqualToString:@"DeductibleHMM"] && [self.requestOption isEqualToString:@"HMM_1000"]) {
        [itemValue removeAllObjects];
        [itemDesc removeAllObjects];
        
        [itemValue addObject:@"4"];
        [itemDesc addObject:@"30000"];
    }
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - db handling

-(void)getRiderCondition
{
    itemValue =[[NSMutableArray alloc] init];
    itemDesc = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Value,Desc FROM Trad_Sys_Other_Value WHERE Code=\"%@\"",self.requestCondition];
//        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                [itemValue addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                [itemDesc addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
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
    return [itemDesc count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	cell.textLabel.text = [itemDesc objectAtIndex:indexPath.row];
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
    [_delegate deductView:self didSelectItem:self.selectedItem desc:self.selectedItemDesc];
}

-(NSString *)selectedItem
{
    return [itemValue objectAtIndex:selectedIndex];
}

-(NSString *)selectedItemDesc
{
    return [itemDesc objectAtIndex:selectedIndex];
}

@end
