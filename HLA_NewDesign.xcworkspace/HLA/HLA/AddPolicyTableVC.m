//
//  AddPolicyTableVC.m
//  iMobile Planner
//
//  Created by Juliana on 9/18/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "AddPolicyTableVC.h"
#import "DataClass.h"
//#import "ExistingPolicyListing.h"

#define CURRENCY @".0123456789"
#define CHARACTER_LIMIT_CURRENCY 13

@interface AddPolicyTableVC () {
	DataClass *obj;
//	ExistingPolicyListing *epl;
}

@end

@implementation AddPolicyTableVC

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
	obj = [DataClass getInstance];
	pn = [[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] objectForKey:@"WhichPolicy"]intValue];
	pc = [[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] objectForKey:@"Count"] intValue];
	pcm = pc-1;
	_arrayPolicy = [[NSMutableArray alloc] init];
	if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] objectForKey:@"PolicyData"] count] != 0) {
		_arrayPolicy = [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] objectForKey:@"PolicyData"];
	}
//	[epl.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionForDeletePolicy:(id)sender {
	
//	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] objectForKey:@"WhichPolicy"] != Nil) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Are you sure you want to delete selected record?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
		//		NSLog(@"no title");
		alert.tag = 11;
		[alert show];		
//	}
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 11 && buttonIndex == 0)
    {
        [_arrayPolicy removeObjectAtIndex:pn];
		
		[self dismissViewControllerAnimated:NO completion:^{
			NSLog(@"close");
			[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] setValue:_arrayPolicy  forKey:@"PolicyData"];
			[[NSNotificationCenter defaultCenter]postNotificationName:@"TestNotification" object:self];
//			[delegate reloadPolicyTable];
		}];
		
		
	}
//	else if (alertView.tag == 11 && buttonIndex == 1) {
//		[self dismissViewControllerAnimated:NO completion:Nil];
//	}
}

- (void)viewDidDisappear:(BOOL)animated {
	NSLog(@"viewDidDisappear");
	
//	NSLog(@"number: %@", [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] objectForKey:@"Count"]);
//	[epl.mainTableView reloadData];
}


- (IBAction)actionForPersonType:(id)sender {
	if (_PersonTypePicker == nil) {
        _PersonTypePicker = [[HealthQuestPersonType alloc] initWithStyle:UITableViewStylePlain];
        _PersonTypePicker.delegate = self;
        self.PersonTypePopover = [[UIPopoverController alloc] initWithContentViewController:_PersonTypePicker];
    }
    
    [self.PersonTypePopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)selectedPersonType:(NSString *)thePersonType {
	_personTypeLbl.text = thePersonType;
	[_PersonTypePopover dismissPopoverAnimated:YES];
}

- (IBAction)actionForDateIssued:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    _dateIssuedLbl.text = dateString;
	//	_memberDOBLbl.textColor = [UIColor blackColor];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    
    if (_SIDate == Nil) {
        
        self.SIDate = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIDate"];
        _SIDate.delegate = self;
        self.SIDatePopover = [[UIPopoverController alloc] initWithContentViewController:_SIDate];
    }
    
    [self.SIDatePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.SIDatePopover presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    
    dateFormatter = Nil;
    dateString = Nil, mainStoryboard = nil;
}

-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
    _dateIssuedLbl.text = strDate;
	//	_memberDOBLbl.textColor = [UIColor blackColor];
}

-(void)CloseWindow
{NSLog(@"close");
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [self.SIDatePopover dismissPopoverAnimated:YES];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	if (textField == _lifeTermTF || textField == _accidentTF || textField == _criticalIllnessTF) {
//		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
//		[formatter setMaximumFractionDigits:2];
		
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:CURRENCY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered]) && (newLength <= CHARACTER_LIMIT_CURRENCY));	
	}
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    // Configure the cell...
//	int y;
//	//	for (y=0; y < [[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] objectForKey:@"Count"] intValue]; y++) {
//	
//	if (cell == nil)
//	{
//		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//	}
//	
//    cell.textLabel.text = [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] objectForKey:[NSString stringWithFormat:@"PersonType%d", (indexPath.row + 1)]];
//	cell.detailTextLabel.text = [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] objectForKey:[NSString stringWithFormat:@"CompanyName%d", (indexPath.row+1)]];
//    return cell;
//	
//}


- (void)viewDidUnload {
	[self setDateIssuedLbl:nil];
	[self setCriticalIllnessTF:nil];
	[self setAccidentTF:nil];
	[self setLifeTermTF:nil];
	[self setCompNameTF:nil];
	[self setPersonTypeLbl:nil];
	[self setDeleteBtn:nil];
	[self setRow2:nil];
	[super viewDidUnload];
}

- (void) dealloc
{
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

//NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
//[formatter setMaximumFractionDigits:2];

@end
