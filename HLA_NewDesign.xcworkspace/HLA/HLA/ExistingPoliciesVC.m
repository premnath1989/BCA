//
//  ExistingPoliciesVC.m
//  iMobile Planner
//
//  Created by Juliana on 11/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ExistingPoliciesVC.h"

@interface ExistingPoliciesVC ()

@end

@implementation ExistingPoliciesVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
//    [self setPolicyView:nil];
	[self setPersonTypeLbl:nil];
	[self setMyTable:nil];
	[self setPolicyView:nil];
    [super viewDidUnload];
}

- (IBAction)actionForPersonTypeView:(id)sender {
	NSLog(@"select person type");
	if (_PersonTypePicker == nil) {
        _PersonTypePicker = [[ExistingPoliciesPersonType alloc] initWithStyle:UITableViewStylePlain];
		
        _PersonTypePicker.delegate = self;
        self.PersonTypePopover = [[UIPopoverController alloc] initWithContentViewController:_PersonTypePicker];
    }
    
    [self.PersonTypePopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)selectedPersonType:(NSString *)thePersonType {
	_personTypeLbl.text = thePersonType;
	[_PersonTypePopover dismissPopoverAnimated:YES];
	
	UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
	if ([thePersonType isEqualToString:@"1st Life Assured"]) {
		NSLog(@"in la1");
		Elp1 = [nextStoryboard instantiateViewControllerWithIdentifier:@"ELP1stLA"];
		[self addChildViewController:Elp1];
		[_policyView addSubview:Elp1.view];
	}
	else if ([thePersonType isEqualToString:@"Policy Owner"]) {
		NSLog(@"in po");
		Elppo = [nextStoryboard instantiateViewControllerWithIdentifier:@"ELPPO"];
		[self addChildViewController:Elppo];
		[_policyView addSubview:Elppo.view];
	}
	else if ([thePersonType isEqualToString:@"2nd Life Assured"]) {
		NSLog(@"in la2");
		Elp2 = [nextStoryboard instantiateViewControllerWithIdentifier:@"ELP2ndLA"];
		[self addChildViewController:Elp2];
		[_policyView addSubview:Elp2.view];
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	
    // configure your cell here...
	cell.textLabel.text = @"test";
	
    return cell;
}

@end
