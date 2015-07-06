//
//  eBrochureListingViewController.m
//  HLA Ipad
//
//  Created by infoconnect on 1/16/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "eBrochureListingViewController.h"
#import "eBrochureViewController.h"
#import "ColorHexCode.h"

@interface eBrochureListingViewController ()

@end

@implementation eBrochureListingViewController
@synthesize dataItems;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pdfData" ofType:@"plist"]];
    dataItems = [[NSMutableArray alloc] initWithArray:[dict objectForKey:@"pdfFiles"]];
    
//    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"eBrochure Listing";
    self.navigationItem.titleView = label;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
    else{
        return  NO;
    }
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return [dataItems count];
	return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[dataItems objectAtIndex:section] count];
}

/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
//    return [NSString stringWithFormat:@"Section %i",section];
    NSString *title = nil;
    switch (section) {
        case 0:
            title = @"HLA Income Builder";
            break;
        case 1:
            title = @"HLA Major Medi";
            break;
        case 2:
            title = @"HLA MedGLOBAL IV Plus";
            break;
        case 3:
            title = @"C+ Secure (Standalone)";
            break;
        case 4:
            title = @"Premier Life";
            break;
        case 5:
            title = @"PA Care";
            break;
        case 6:
            title = @"HLA Major Medi Plus";
            break;
        case 7:
            title = @"HLA MedGLOBAL II";
            break;
        case 8:
            title = @"Hospital & Surgical Plan II";
            break;
            
        default:
            break;
    }
    return title;
}*/

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = nil;
    switch (section) {
        /*
		case 0:
            title = @"HLA Cash Promise";
            break;
        case 1:
            title = @"HLA Major Medi";
            break;
        case 2:
            title = @"HLA MedGLOBAL IV Plus";
            break;
        case 3:
            title = @"C+ Secure (Standalone)";
            break;
        case 4:
            title = @"Premier Life";
            break;
        case 5:
            title = @"PA Care";
            break;
        case 6:
            title = @"HLA Major Medi Plus";
            break;
        case 7:
            title = @"HLA MedGLOBAL II";
            break;
        case 8:
            title = @"Hospital & Surgical Plan II";
            break;
		*/
        
		case 0:
            title = @"Basic Plan";
            break;
        case 1:
            title = @"Rider";
			break;
		case 2:
            title = @"Standalone";
            break;
			
        default:
            break;
    }
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    
	UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 40)];
    [v setBackgroundColor:[CustomColor colorWithHexString:@"4F81BD"]];
    
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10,3, tableView.bounds.size.width - 10,40)];
	label.text = title;
//	label.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.60];
    label.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:14];
	label.backgroundColor = [UIColor clearColor];
	[v addSubview:label];
    
	return v;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [[[dataItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:0];
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    
    /*
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    if (indexPath.row % 2 == 0) {
        cell.textLabel.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
    }
    else {
        cell.textLabel.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
    }*/
    
    return cell;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    eBrochureViewController *Brochure = [self.storyboard instantiateViewControllerWithIdentifier:@"eBrochure"];
//    Brochure.title = [[[dataItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:0];
    Brochure.fileTitle = [[[dataItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:0];
    Brochure.fileName = [[[dataItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:1];
    
    [self.navigationController pushViewController:Brochure animated:YES];
}

- (IBAction)btnClose:(id)sender
{
	dataItems = Nil;
    [self dismissModalViewControllerAnimated:YES];
}
@end

