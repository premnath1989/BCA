//
//  RelationshipPopoverViewController.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "RelationshipPopoverViewController.h"
#import "DataClass.h"

@interface RelationshipPopoverViewController (){
    DataClass *obj;
}

@end

@implementation RelationshipPopoverViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        NSString *file = [[NSBundle mainBundle] pathForResource:@"Relationship" ofType:@"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:file];
        
        //_IDTypes = [NSMutableArray array];
        _IDTypes = [dict objectForKey:@"Title"];//[NSMutableArray array];
        
        self.clearsSelectionOnViewWillAppear = NO;
        
        NSInteger rowsCount = [_IDTypes count];
        NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView
                                               heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSInteger totalRowsHeight = rowsCount * singleRowHeight;
        
        
        CGFloat largestLabelWidth = 0;
        for (NSString *IDType in _IDTypes) {
            //Checks size of text using the default font for UITableViewCell's textLabel.
            CGSize labelSize = [IDType sizeWithFont:[UIFont boldSystemFontOfSize:20.0f]];
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
    obj=[DataClass getInstance];
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
    return [_IDTypes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [_IDTypes objectAtIndex:indexPath.row];

    //NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:20 inSection: 0];
    //[tableView selectRowAtIndexPath:indexPath1 animated:NO scrollPosition:UITableViewScrollPositionNone];
    //if (indexPath.row == 5){
    //cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    //[cell setSelected:YES];
    //}
    

    
    
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
    NSString *selectedRelationshipType = [_IDTypes objectAtIndex:indexPath.row];
	NSLog(@"selected id :%@",selectedRelationshipType);
    
    if (_rowToUpdate == 0){
        [[obj.CFFData objectForKey:@"SecC"] setValue:[NSString stringWithFormat:@"%d",indexPath.row] forKey:@"Childen1RelationshipIndex"];
    }
    else if (_rowToUpdate == 1){
        [[obj.CFFData objectForKey:@"SecC"] setValue:[NSString stringWithFormat:@"%d",indexPath.row] forKey:@"Childen2RelationshipIndex"];        
    }
    else if (_rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecC"] setValue:[NSString stringWithFormat:@"%d",indexPath.row] forKey:@"Childen3RelationshipIndex"];
    }
    else if (_rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecC"] setValue:[NSString stringWithFormat:@"%d",indexPath.row] forKey:@"Childen4RelationshipIndex"];        
    }
    else if (_rowToUpdate == 4){
        [[obj.CFFData objectForKey:@"SecC"] setValue:[NSString stringWithFormat:@"%d",indexPath.row] forKey:@"Childen5RelationshipIndex"];
    }
    
    //NSLog(@"XXXX%d",_rowToUpdate);
    //NSLog(@"XXXX%d",indexPath.row);
    
    
    //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CurrentSection"]);
    
    //[[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1RelationshipIndex"];
    
    //Notify the delegate if it exists.
    if (_delegate != nil) {
        [_delegate selectedRship:selectedRelationshipType];
    }

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

    //UITableViewCell * cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    //cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    //if (indexPath.row == 20){
    //    [cell setSelected:YES];
    //NSLog(@"csacas");
    //}
    
    
    if (_rowToUpdate == 0){
        if (indexPath.row == [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1RelationshipIndex"] intValue]){
            [cell setSelected:YES];
        }
    }
    else if (_rowToUpdate == 1){
        if (indexPath.row == [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2RelationshipIndex"] intValue]){
            [cell setSelected:YES];
        }
    }
    else if (_rowToUpdate == 2){
        if (indexPath.row == [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3RelationshipIndex"] intValue]){
            [cell setSelected:YES];
        }
    }
    else if (_rowToUpdate == 3){
        if (indexPath.row == [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4RelationshipIndex"] intValue]){
            [cell setSelected:YES];
        }
    }
    else if (_rowToUpdate == 4){
        if (indexPath.row == [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5RelationshipIndex"] intValue]){
            [cell setSelected:YES];
        }
    }
    
    
}




- (void)viewWillAppear:(BOOL)animated {
    
    
    if (_rowToUpdate == 0){
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1RelationshipIndex"] intValue] inSection:0]
                              atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    else if (_rowToUpdate == 1){
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2RelationshipIndex"] intValue] inSection:0]
                              atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    else if (_rowToUpdate == 2){
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3RelationshipIndex"] intValue] inSection:0]
                              atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    else if (_rowToUpdate == 3){
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4RelationshipIndex"] intValue] inSection:0]
                              atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    else if (_rowToUpdate == 4){
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5RelationshipIndex"] intValue] inSection:0]
                              atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
}


@end
