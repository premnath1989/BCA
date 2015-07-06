//
//  RiderPlanTb.m
//  HLA Ipad
//
//  Created by shawal sapuan on 11/21/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "RiderPlanTb.h"

@interface RiderPlanTb ()

@end


@implementation RiderPlanTb
@synthesize selectedItem,itemDesc,itemValue,selectedItemDesc;
@synthesize delegate = _delegate;
@synthesize requestSA,requestCondition,requestOccpCat;

-(id)initWithString:(NSString *)stringCode andSumAss:(NSString *)valueSum andOccpCat:(NSString *)OccpCat andTradOrEver:(NSString *)TradOrEver getPlanChoose:(NSString *) getPlanChoose
{
    self = [super init];
    if (self != nil) {
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsDir = [dirPaths objectAtIndex:0];
        databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
        
        requestCondition = [NSString stringWithFormat:@"%@",stringCode];
        requestSA = [valueSum doubleValue];
        [self getRiderCondition];
        NSLog(@"condition:%@, sumA:%.2f",self.requestCondition,self.requestSA);
        
		if ([TradOrEver isEqualToString:@"TRAD"]) {if([getPlanChoose isEqualToString:@"HLAWP"])
            {
                if (self.requestSA >= 500000 && [OccpCat isEqualToString:@"EMP"]  && [self.requestCondition isEqualToString:@"PlanChoiceHMM"] ){
                    [itemValue addObject:@"HMM1000"];
                    [itemDesc addObject:@"HMM_1000"];
                }
            }
            else if([getPlanChoose isEqualToString:@"S100"] || [getPlanChoose isEqualToString:@"L100"])
            {
                if (self.requestSA >= 500000 && [OccpCat isEqualToString:@"EMP"]  && [self.requestCondition isEqualToString:@"PlanChoiceHMM"] ){
                    [itemValue addObject:@"HMM1000"];
                    [itemDesc addObject:@"HMM_1000"];
                }
            }
            else if([getPlanChoose isEqualToString:@"HLACP"])
            {
                if (self.requestSA >= 25000 && [self.requestCondition isEqualToString:@"PlanChoiceHMM"] &&
                    ![OccpCat isEqualToString:@"UNEMP"]) {
                    [itemValue addObject:@"HMM1000"];
                    [itemDesc addObject:@"HMM_1000"];
                }
            }
		}
		else{
			if ([stringCode isEqualToString:@"PlanChoiceHMM"]) {
				
				if (self.requestSA >= 500000 && ![OccpCat isEqualToString:@"UNEMP"]){
					[itemValue addObject:@"HMM1000"];
					[itemDesc addObject:@"HMM_1000"];
				}

			}
            else if ([stringCode isEqualToString:@"TSR"]) {
				
                //valuesum  = age, occpcat = riderterm
                if ([valueSum intValue] <= 55 && ([OccpCat intValue] + [valueSum intValue]) > 60 ) {
                    [itemValue addObject:@"UpTo60"];
                    [itemDesc addObject:@"Up to age 60"];
                }
                
                [itemValue addObject:@"WRT"];
                [itemDesc addObject:@"Whole Rider Term"];

			}
            else if ([stringCode isEqualToString:@"PlanChoiceMDSR1"]) {
                
                [itemValue addObject:@"MS_200"];
                [itemDesc addObject:@"MS_200"];
                [itemValue addObject:@"MS_300"];
                [itemDesc addObject:@"MS_300"];
                [itemValue addObject:@"MS_500"];
                [itemDesc addObject:@"MS_500"];
                
			}
            else if ( [stringCode isEqualToString:@"PlanChoiceMDSR2"] ) {
                
                [itemValue addObject:@"MS_200"];
                [itemDesc addObject:@"MS_200"];
                [itemValue addObject:@"MS_300"];
                [itemDesc addObject:@"MS_300"];
                [itemValue addObject:@"MS_500"];
                [itemDesc addObject:@"MS_500"];
                
			}
			else{
				if (![stringCode isEqualToString:@"PlanChoiceMGIV"]) {
					itemValue =[[NSMutableArray alloc] init];
					itemDesc = [[NSMutableArray alloc] init];
					[itemValue addObject:@"6"];
					[itemDesc addObject:@"6"];
					[itemValue addObject:@"10"];
					[itemDesc addObject:@"10"];
					[itemValue addObject:valueSum];
					[itemDesc addObject:valueSum];
				}
				

			}
		}
		
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)getRiderCondition
{
    itemValue =[[NSMutableArray alloc] init];
    itemDesc = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Value,Desc FROM Trad_Sys_Other_Value WHERE Code=\"%@\"",self.requestCondition];
//		NSLog(@"%@", querySQL);
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
    [_delegate PlanView:self didSelectItem:self.selectedItem desc:self.selectedItemDesc];
    [tableView reloadData];
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
