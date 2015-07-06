//
//  ClientProfileListingSortBy.m
//  iMobile Planner
//
//  Created by kuan on 12/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ClientProfileListingSortBy.h"

@interface ClientProfileListingSortBy ()

@end

@implementation ClientProfileListingSortBy
@synthesize SortBy = _SortBy;
@synthesize lastIndexPath;
@synthesize delegate = _delegate;
@synthesize SelectedSortBy;

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
    self.SortBy = [NSMutableArray array];
   
    [_SortBy addObject:@"Name"];
     [_SortBy addObject:@"Group"];
   // [_SortBy addObject:@"Yearly Income"];
   // [_SortBy addObject:@"Date Created"];
    SelectedSortBy = [[NSMutableArray alloc] init ];

	// Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    cell.textLabel.text = [_SortBy objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    for (UITableViewCell *zzz in tableView.visibleCells) {
        NSIndexPath *IndexpathItem = [tableView indexPathForCell:zzz];
        if (zzz.selected == TRUE) {
            if (zzz.accessoryType == UITableViewCellAccessoryCheckmark) {
                [SelectedSortBy removeObject:[_SortBy objectAtIndex:IndexpathItem.row]];
            }
            else {
                [SelectedSortBy addObject: [_SortBy objectAtIndex:IndexpathItem.row ] ];
                
            }
        }
    }
    
    UITableViewCell *zzz = [tableView cellForRowAtIndexPath:indexPath];
    if (zzz.accessoryType == UITableViewCellAccessoryCheckmark) {
        zzz.accessoryType = UITableViewCellAccessoryNone;
    }
    else {
        zzz.accessoryType = UITableViewCellAccessoryCheckmark;
    }
 
    
    if (_delegate != nil) {
        
        [_delegate SortBySelected:SelectedSortBy];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
