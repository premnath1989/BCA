//
//  Nationality.m
//  iMobile Planner
//
//  Created by shawal sapuan on 7/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "Nationality.h"

NSString *SelectedString;
@interface Nationality ()

@end

@implementation Nationality
@synthesize items = _items;
@synthesize delegate = _delegate;
@synthesize FilteredData,isFiltered;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        NSString *file = [[NSBundle mainBundle] pathForResource:@"Nationality" ofType:@"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:file];
        _items = [dict objectForKey:@"Nationality"];
    
        sorted = [[NSArray alloc]init];
        sorted  =  [_items sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        self.clearsSelectionOnViewWillAppear = NO;
        
        NSInteger rowsCount = [sorted count];
        NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView
                                               heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSInteger totalRowsHeight = rowsCount * singleRowHeight;
        
        
        CGFloat largestLabelWidth = 0;
        for (NSString *Title in sorted) {
            CGSize labelSize = [Title sizeWithFont:[UIFont boldSystemFontOfSize:20.0f]];
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
    
    UISearchBar *zzz = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 50) ];
    
    zzz.opaque = false;
    zzz.delegate = (id) self;
    self.tableView.tableHeaderView = zzz;
    CGRect searchbarFrame = zzz.frame;
    [self.tableView scrollRectToVisible:searchbarFrame animated:NO];
    
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
    
    
    if (isFiltered == false) {
        return [sorted count];
    }
    else {
        return [FilteredData count ];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
     if (isFiltered == false) {
         
         NSString *country = [sorted objectAtIndex:indexPath.row];
         cell.textLabel.text = country;
         
         if (country == SelectedString) {
             cell.accessoryType= UITableViewCellAccessoryCheckmark;
         }
         else
         {
             cell.accessoryType = UITableViewCellAccessoryNone;
         }

     }
     else
     {
         NSString *country = [FilteredData objectAtIndex:indexPath.row];
         cell.textLabel.text = country;
         
         if (country == SelectedString) {
             cell.accessoryType= UITableViewCellAccessoryCheckmark;
         }
         else
         {
             cell.accessoryType = UITableViewCellAccessoryNone;
         }

         
     }
        
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16 ];
    return cell;
}

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if (text.length == 0) {
        isFiltered = false;
        
    }
    else {
        isFiltered = true;
        FilteredData = [[NSMutableArray alloc] init ];
              
        for (int a =0; a<sorted.count; a++ ) {
            NSRange Occu = [[sorted objectAtIndex:a ] rangeOfString:text options:NSCaseInsensitiveSearch];
            
            if (Occu.location != NSNotFound) {
                [FilteredData addObject:[sorted objectAtIndex:a ] ];
              
            }
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_delegate != nil) {
        
        if (isFiltered == false) {
            
            NSString *zzz = [sorted objectAtIndex:indexPath.row];
            
            SelectedString = zzz;
            
            [_delegate selectedNationality:zzz];
        }
        else
        {
            
            NSString *zzz = [FilteredData objectAtIndex:indexPath.row];
            
            SelectedString = zzz;
            
            [_delegate selectedNationality:zzz];
        }
    }
    
    
    
    
    [tableView reloadData];
}

-(void) setTitle:(NSString *)title
{
    
    SelectedString = title;
    
    [self.tableView reloadData];
}
@end
