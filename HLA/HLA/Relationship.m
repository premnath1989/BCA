//
//  Relationship.m
//  iMobile Planner
//
//  Created by shawal sapuan on 7/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "Relationship.h"
NSString *SelectedString;

@interface Relationship ()

@end

@implementation Relationship
@synthesize items,requestType;
@synthesize delegate = _delegate;
@synthesize FilteredData,isFiltered,FilteredCode;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[self.requestType description] isEqualToString:@"PO"]) {
        NSString *file = [[NSBundle mainBundle] pathForResource:@"RelationshipPO" ofType:@"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:file];
        self.items = [dict objectForKey:@"Title"];
    }
    else if ([[self.requestType description] isEqualToString:@"eCFF"]) {
        self.items = [[NSMutableArray alloc] initWithObjects:@"BROTHER", @"DAUGHTER", @"FATHER", @"GRAND DAUGHTER", @"GRANDFATHER", @"GRANDMOTHER", @"GRANDSON", @"GUARDIAN", @"HUSBAND", @"MOTHER", @"SISTER", @"SON", @"STEP DAUGHTER", @"STEP FATHER", @"STEP MOTHER", @"STEP SON", @"WIFE", nil];
    }
    else if ([[self.requestType description] isEqualToString:@"nominees"]) {
        NSString *file = [[NSBundle mainBundle] pathForResource:@"Relationship" ofType:@"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:file];
        self.items = [dict objectForKey:@"Title"];
    }
    else if ([[self.requestType description] isEqualToString:@"creditCard"]) {
        self.items = [[NSMutableArray alloc] initWithObjects:@"BROTHER", @"DAUGHTER", @"DAUGHTER IN LAW", @"EMPLOYEE", @"EMPLOYER", @"FATHER", @"FATHER IN LAW", @"GRAND DAUGHTER", @"GRANDFATHER", @"GRANDMOTHER", @"GRANDSON", @"GUARDIAN", @"HUSBAND", @"MOTHER", @"MOTHER IN LAW", @"SELF", @"SISTER", @"SISTER IN LAW", @"SON", @"SON-IN LAW", @"STEP DAUGHTER", @"STEP FATHER", @"STEP MOTHER", @"STEP SON", @"WIFE",nil];
    }
	else if ([[self.requestType description] isEqualToString:@"creditCard2"]) {
        self.items = [[NSMutableArray alloc] initWithObjects:@"BROTHER", @"DAUGHTER", @"DAUGHTER IN LAW", @"EMPLOYEE", @"EMPLOYER", @"FATHER", @"FATHER IN LAW", @"GRAND DAUGHTER", @"GRANDFATHER", @"GRANDMOTHER", @"GRANDSON", @"GUARDIAN", @"HUSBAND", @"MOTHER", @"MOTHER IN LAW", @"SISTER", @"SISTER IN LAW", @"SON", @"SON-IN LAW", @"STEP DAUGHTER", @"STEP FATHER", @"STEP MOTHER", @"STEP SON", @"WIFE",nil];
    }
    else {
        //contRel
        self.items = [[NSMutableArray alloc] initWithObjects:@"AUNT", @"BROTHER", @"FATHER", @"GRANDFATHER", @"GRANDMOTHER", @"MOTHER", @"SISTER", @"UNCLE", nil];
    }
    
    
    self.clearsSelectionOnViewWillAppear = NO;
    
    NSInteger rowsCount = [self.items count];
    NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView
                                           heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSInteger totalRowsHeight = rowsCount * singleRowHeight;
    
    
    CGFloat largestLabelWidth = 0;
    for (NSString *Title in self.items) {
        CGSize labelSize = [Title sizeWithFont:[UIFont boldSystemFontOfSize:20.0f]];
        if (labelSize.width > largestLabelWidth) {
            largestLabelWidth = labelSize.width;
        }
    }
    
    CGFloat popoverWidth = largestLabelWidth + 100;
    
    self.contentSizeForViewInPopover = CGSizeMake(popoverWidth, totalRowsHeight);
    UISearchBar *zzz = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 50) ];
    
    zzz.opaque = false;
    zzz.delegate = (id) self;
    self.tableView.tableHeaderView = zzz;
    CGRect searchbarFrame = zzz.frame;
    [self.tableView scrollRectToVisible:searchbarFrame animated:NO];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	
	[self.view addGestureRecognizer:tap];
}

-(void)hideKeyboard{
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
    
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
        return [self.items count];
    }
    else {
        return [FilteredData count ];
    }
    // return [self.items count];
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
        NSString *title = [self.items objectAtIndex:indexPath.row];
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
        
        
        for (int a =0; a<self.items.count; a++ ) {
            NSRange Occu = [[self.items objectAtIndex:a ] rangeOfString:text options:NSCaseInsensitiveSearch];
            
            if (Occu.location != NSNotFound) {
                [FilteredData addObject:[self.items objectAtIndex:a ] ];
                [FilteredCode addObject:[self.items objectAtIndex:a ] ];
            }
        }
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedIssuingBank = [self.items objectAtIndex:indexPath.row];
    NSString *zzz = [self.items objectAtIndex:indexPath.row];
    [_delegate selectedRelationship:zzz];
    
    if (_delegate != nil) {
        if (isFiltered == false)
        {
            [self resignFirstResponder];
            [self.view endEditing:TRUE];
            
            //NSString *selectedTitle = [_Title objectAtIndex:indexPath.row];
            //[_delegate selectedTitle:selectedTitle];
            
            NSString *selectedTitleDesc = [self.items objectAtIndex:indexPath.row];
            [_delegate selectedRelationship:selectedTitleDesc];
            
            NSString *selectedTitleCode = [self.items objectAtIndex:indexPath.row];
            [_delegate selectedRelationship:selectedTitleCode];
            
            SelectedString = [self.items objectAtIndex:indexPath.row ];
        }
        else
        {
            [self resignFirstResponder];
            [self.view endEditing:TRUE];
            NSString *selectedTitleDesc = [FilteredData objectAtIndex:indexPath.row];
            [_delegate selectedRelationship:selectedTitleDesc];
            NSString *selectedTitleCode = [FilteredData objectAtIndex:indexPath.row];
            [_delegate selectedRelationship:selectedTitleCode];
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