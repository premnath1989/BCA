//
//  SubDetailsData.m
//  iMobile Planner
//
//  Created by shawal sapuan on 7/13/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "SubDetailsData.h"
#import "ColorHexCode.h"

#import "DataClass.h"

@interface SubDetailsData (){
    DataClass *obj;
}

@end

@implementation SubDetailsData

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
    
    obj = [DataClass getInstance];

    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    
    label.text = [[obj.eAppData objectForKey:@"PolicyOwner"] objectForKey:@"Title"];//@"e-Application(1st Life Assured)";
    
    self.navigationItem.titleView = label;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnDone:)];
    
    obj=[DataClass getInstance];
    
}

- (void)btnDone:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    [_delegate selectedPO:@"YES"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)viewDidUnload {
    [self setIsPolicyOwner:nil];
    [super viewDidUnload];
}
- (IBAction)isPolicyOwnerBtn:(id)sender {
    _isPolicyOwner.selected = !_isPolicyOwner.selected;
	if (_isPolicyOwner.selected) {
		[_isPolicyOwner setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        [[obj.eAppData objectForKey:@"PolicyOwner"] setValue:@"1st Life Assured" forKey:@"PolicyOwner"];
	}
	else {
		[_isPolicyOwner setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        [[obj.eAppData objectForKey:@"PolicyOwner"] setValue:Nil forKey:@"PolicyOwner"];
	}
}
@end
