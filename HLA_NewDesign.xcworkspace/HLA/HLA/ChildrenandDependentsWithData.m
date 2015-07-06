//
//  ChildrenandDependents.m
//  iMobile Planner
//
//  Created by Juliana on 7/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ChildrenandDependentsWithData.h"
#import "ColorHexCode.h"

@interface ChildrenandDependentsWithData ()

@end

@implementation ChildrenandDependentsWithData

@synthesize btn1;

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

	ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"Children and Dependents";
    self.navigationItem.titleView = label;
	
	
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



- (IBAction)doDone:(id)sender {
    
    
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: NSLocalizedString(@"iMobile Planner",nil)
                          message: NSLocalizedString(@"Update to list?",nil)
                          delegate: self
                          cancelButtonTitle: NSLocalizedString(@"Yes",nil)
                          otherButtonTitles: NSLocalizedString(@"No",nil), nil];
    [alert setTag:1001];
    [alert show];
    alert = Nil;
    
    
    
	    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001)
    {
        [self dismissViewControllerAnimated:TRUE completion:nil];
    }
}

- (void)viewDidUnload {
	[self setBtn1:nil];
    [self setRelationship:nil];
	[super viewDidUnload];
}

- (IBAction)clickBtn1:(id)sender {
	btn1.selected = !btn1.selected;
	if (btn1.selected) {
		[btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
	}
	else {
		[btn1 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
	}
}

-(void)selectedRship:(NSString *)selectedRship{
    [_relationship setText:selectedRship];

    if (_RshipTypePickerPopover) {
        [_RshipTypePickerPopover dismissPopoverAnimated:YES];
        _RshipTypePickerPopover = nil;
    }
}

- (IBAction)doRelationship:(id)sender {
    if (_RshipTypePicker == nil) {
        _RshipTypePicker = [[RelationshipPopoverViewController alloc] initWithStyle:UITableViewStylePlain];
        _RshipTypePicker.delegate = self;
    }
    
    if (_RshipTypePickerPopover == nil) {
        
        _RshipTypePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_RshipTypePicker];
        [_RshipTypePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    } else {
        [_RshipTypePickerPopover dismissPopoverAnimated:YES];
        _RshipTypePickerPopover = nil;
    }

}

@end
