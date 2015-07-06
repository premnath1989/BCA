//
//  DeductiblePostRetirement.m
//  iMobile Planner
//
//  Created by Heng on 6/6/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import "DeductiblePostRetirement.h"

@interface DeductiblePostRetirement ()

@end

@implementation DeductiblePostRetirement
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
        //NSLog(@"condition:%@, sumA:%.2f, option:%@",self.requestCondition,self.requestSA,self.requestOption);
        
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getRiderCondition
{
    itemValue =[[NSMutableArray alloc] init];
    itemDesc = [[NSMutableArray alloc] init];
    
    if([requestCondition isEqualToString:@"0"]){
        [itemValue addObject:@"0"];
        [itemDesc addObject:@"0"];
        [itemValue addObject:@"10000"];
        [itemDesc addObject:@"10000"];

    }
    else if([requestCondition isEqualToString:@"20000"]){
        [itemValue addObject:@"0"];
        [itemDesc addObject:@"0"];
        [itemValue addObject:@"10000"];
        [itemDesc addObject:@"10000"];
        [itemValue addObject:@"20000"];
        [itemDesc addObject:@"20000"];
    }
    else if([requestCondition isEqualToString:@"50000"]){
        [itemValue addObject:@"0"];
        [itemDesc addObject:@"0"];
        [itemValue addObject:@"10000"];
        [itemDesc addObject:@"10000"];
        [itemValue addObject:@"20000"];
        [itemDesc addObject:@"20000"];
        [itemValue addObject:@"50000"];
        [itemDesc addObject:@"50000"];
    }

    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    return [itemDesc count];;
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = indexPath.row;
    //[_delegate deductView:self didSelectItem:self.selectedItem desc:self.selectedItemDesc];
    [_delegate deductViewRetirement:self didSelectItem:self.selectedItem desc:self.selectedItemDesc];
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
