//
//  TitleViewController.m
//  iMobile Planner
//
//  Created by Erza on 6/5/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "TitleViewController.h"
#import "FMDatabase.h"

NSString *SelectedString;

@interface TitleViewController ()

{
      NSString *databasePath;
}
@end

@implementation TitleViewController
@synthesize TitleCode = _TitleCode;
@synthesize TitleDesc = _TitleDesc;
@synthesize FilteredData,isFiltered,FilteredCode;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

        _Title =  [[NSMutableArray alloc]init];
        _TitleCode =  [[NSMutableArray alloc]init];
        _TitleDesc =  [[NSMutableArray alloc]init];
        [_Title addObject:@"- SELECT -"];
        [_TitleCode addObject:@""];
        [_TitleDesc addObject:@"- SELECT -"];
        
      /*  NSString *file = [[NSBundle mainBundle] pathForResource:@"Title" ofType:@"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:file];
        */
        
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsDir = [dirPaths objectAtIndex:0];
        databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
        
       
        FMDatabase *database = [FMDatabase databaseWithPath:databasePath];
        if (![database open]) {
            NSLog(@"Could not open db.");
        }
        
        [database open];
        
        //GET THE TRAD/UL SI VERSION START
        FMResultSet *results2;
        //NSString *title;
        results2 =  [database executeQuery:@"SELECT TitleCode, TitleDesc from eProposal_Title ORDER BY TitleDesc asc"];
        
        while ([results2 next]) {
            
            //title = [results2 objectForColumnName:@"TitleDesc"];
            NSString *titlecode = [results2 objectForColumnName:@"TitleCode"];
            NSString *titleDesc = [results2 objectForColumnName:@"TitleDesc"];
            
            [_TitleDesc addObject:titleDesc];
            [_TitleCode addObject:titlecode];
           
             
        }
        [results2 close];

        [database close];
        
        self.clearsSelectionOnViewWillAppear = NO;
       
        NSInteger rowsCount = _TitleDesc.count;
       
        
        NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView
                                               heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSInteger totalRowsHeight = rowsCount * singleRowHeight;
        
        
        CGFloat largestLabelWidth = 0;
        for (NSString *Title in _TitleDesc) {
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
	// Do any additional setup after loading the view.
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
   
    
    if (isFiltered == false) {
        return [_TitleDesc count];
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
    
    
    // Configure the cell...
     if (isFiltered == false) {
          NSString *title = [_TitleDesc objectAtIndex:indexPath.row];
          cell.textLabel.text = title;
         
         

         if (title == SelectedString) {
             
             cell.accessoryType= UITableViewCellAccessoryCheckmark;
         }
         else
         {
             
             cell.accessoryType = UITableViewCellAccessoryNone;
         }

     }
     else
     {
         
         NSString *title = [FilteredData objectAtIndex:indexPath.row];
         cell.textLabel.text = title;
         
         if (title == SelectedString) {
             cell.accessoryType= UITableViewCellAccessoryCheckmark;
         }
         else
         {
             cell.accessoryType = UITableViewCellAccessoryNone;
         }
         if ([FilteredData objectAtIndex:indexPath.row] == SelectedString) {
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
        FilteredCode = [[NSMutableArray alloc] init ];
       
        
        for (int a =0; a<_TitleDesc.count; a++ ) {
            NSRange Occu = [[_TitleDesc objectAtIndex:a ] rangeOfString:text options:NSCaseInsensitiveSearch];
            
            if (Occu.location != NSNotFound) {
                [FilteredData addObject:[_TitleDesc objectAtIndex:a ] ];
                [FilteredCode addObject:[_TitleCode objectAtIndex:a ] ];
                          }
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   //Notify the delegate if it exists.
    if (_delegate != nil) {
        if (isFiltered == false)
        {
            [self resignFirstResponder];
           [self.view endEditing:TRUE];
            
            //NSString *selectedTitle = [_Title objectAtIndex:indexPath.row];
            //[_delegate selectedTitle:selectedTitle];
            
            NSString *selectedTitleDesc = [_TitleDesc objectAtIndex:indexPath.row];
            [_delegate selectedTitleDesc:selectedTitleDesc];
              
            NSString *selectedTitleCode = [_TitleCode objectAtIndex:indexPath.row];
            [_delegate selectedTitleCode:selectedTitleCode];
            
            SelectedString = [_TitleDesc objectAtIndex:indexPath.row ];
        }
        else
        {
            [self resignFirstResponder];
            [self.view endEditing:TRUE];
            NSString *selectedTitleDesc = [FilteredData objectAtIndex:indexPath.row];
            [_delegate selectedTitleDesc:selectedTitleDesc];
            NSString *selectedTitleCode = [FilteredData objectAtIndex:indexPath.row];
            [_delegate selectedTitleCode:selectedTitleCode];
             SelectedString = [FilteredData objectAtIndex:indexPath.row ];
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
