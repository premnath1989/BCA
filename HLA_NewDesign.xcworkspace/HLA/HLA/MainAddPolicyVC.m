//
//  MainAddPolicyVC.m
//  iMobile Planner
//
//  Created by Juliana on 9/18/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "MainAddPolicyVC.h"
#import "DataClass.h"
#import "TagObject.h"


@interface MainAddPolicyVC () {
	DataClass *obj;
	TagObject *saveObj;
}

@end

@implementation MainAddPolicyVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	AddPolicy = [self.storyboard instantiateViewControllerWithIdentifier:@"AddPolicy"];
	AddPolicy.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
//	NSLog(@"trustee: %f, %f", self.view.frame.size.width, self.view.frame.size.height);
	[self addChildViewController:AddPolicy];
	[self.mainView addSubview:AddPolicy.view];
	
	obj = [DataClass getInstance];
	
	saveObj = [TagObject tagObj];
//	[epl.tableView reloadData];
	num = 0;
	rrrnum = [[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] objectForKey:@"Count"] intValue];
	test = [[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] objectForKey:@"S"] intValue];
	whichpolicy = [[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] objectForKey:@"WhichPolicy"]intValue];
	//	NSLog(@"rrrnum: %d, rrrstr: %@", rrrnum, rrrstr);
//	NSLog(@"which policy: %d", whichpolicy);
	_mutArray = [[NSMutableArray alloc] init];
	if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] objectForKey:@"PolicyData"] count] != 0) {
		_mutArray = [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] objectForKey:@"PolicyData"];
	}
	
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] objectForKey:@"WhichPolicy"] != Nil) {
		
	_titleLbl.text = @"Existing Policy Details";
		AddPolicy.deleteBtn.hidden = FALSE;
		AddPolicy.row2.hidden = FALSE;
		AddPolicy.personTypeLbl.text = [[_mutArray objectAtIndex:whichpolicy]objectAtIndex:0];
		AddPolicy.compNameTF.text = [[_mutArray objectAtIndex:whichpolicy]objectAtIndex:1];
		AddPolicy.lifeTermTF.text = [[_mutArray objectAtIndex:whichpolicy]objectAtIndex:2];
		AddPolicy.accidentTF.text = [[_mutArray objectAtIndex:whichpolicy]objectAtIndex:3];
		AddPolicy.criticalIllnessTF.text = [[_mutArray objectAtIndex:whichpolicy]objectAtIndex:4];
		AddPolicy.dateIssuedLbl.text = [[_mutArray objectAtIndex:whichpolicy]objectAtIndex:5];
		}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
	[self setMainView:nil];
	[self setView:nil];
	[self setTitleLbl:nil];
	[super viewDidUnload];
}

- (IBAction)actionForDone:(id)sender {
//	num ++;
	
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] objectForKey:@"WhichPolicy"] == Nil) {
		NSLog(@"ddddd");
		
		if ([self checkAlert]) {
            [self saveExistingPolicy];
			_click++;
            [self.delegate saveData:0];
        }
	}
	else {

		if ([self checkAlert]) {
		[self editExistingPolicy];
			[[NSNotificationCenter defaultCenter]postNotificationName:@"TestNotification" object:self];}
//		[self dismissViewControllerAnimated:YES completion:Nil];
	}
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:YES];
	NSLog(@"how: %d", [[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] objectForKey:@"PolicyData"] count]);
	if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] objectForKey:@"PolicyData"] count] != 0) {
		[_delegate saveData:_click];
	}
	
}

- (IBAction)actionForCancel:(id)sender {
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] objectForKey:@"WhichPolicy"] == Nil) {
		[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] setValue:Nil forKey:@"PolicyData"]; }
	[self dismissViewControllerAnimated:YES completion:Nil];
}

- (BOOL)checkAlert {
	if (AddPolicy.personTypeLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Person Type is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
//		alert.tag = 300;
		[alert show];
		return FALSE;
	}
	else if (AddPolicy.compNameTF.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Company Name is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 100;
		[alert show];
		return FALSE;
	}
	else if (AddPolicy.lifeTermTF.text.length == 0 && AddPolicy.accidentTF.text.length == 0 && AddPolicy.criticalIllnessTF.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Either Life / Term (Sum Assured) or Accident (Sum Assured) or Critical Illness (Sum Assured) is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 200;
		[alert show];
		return FALSE;
	}
	else if (AddPolicy.dateIssuedLbl.text.length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Issued Date is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//		NSLog(@"no title");
		alert.tag = 300;
		[alert show];
		return FALSE;
	}
	else {
		[self dismissViewControllerAnimated:YES completion:Nil];
		return TRUE;
	}
}

- (void)saveExistingPolicy {
//		[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] setValue:AddPolicy.personTypeLbl.text forKey:@"PersonType"];
//	
//		[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] setValue:AddPolicy.compNameTF.text forKey:@"CompanyName"];
//	
//		[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] setValue:AddPolicy.lifeTermTF.text forKey:@"LifeTermSA"];
//	
//		[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] setValue:AddPolicy.accidentTF.text forKey:@"AccidentSA"];
//	
//		[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] setValue:AddPolicy.criticalIllnessTF.text forKey:@"CriticalIllness"];
//	
//		[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] setValue:AddPolicy.dateIssuedLbl.text forKey:@"DateIssued"];
	
	saveObj.personType = AddPolicy.personTypeLbl.text;
	saveObj.companyName = AddPolicy.compNameTF.text;
	saveObj.lifeTerm = AddPolicy.lifeTermTF.text;
	saveObj.accident = AddPolicy.accidentTF.text;
	saveObj.criticalIllness = AddPolicy.criticalIllnessTF.text;
	saveObj.dateIssued = AddPolicy.dateIssuedLbl.text;
	
	NSMutableArray *ma = [[NSMutableArray alloc] init];
	[ma addObject:saveObj.personType];
	[ma addObject:saveObj.companyName];
	[ma addObject:saveObj.lifeTerm];
	[ma addObject:saveObj.accident];
	[ma addObject:saveObj.criticalIllness];
	[ma addObject:saveObj.dateIssued];
	
//	_mutArray = [[NSMutableArray alloc] init];
	[_mutArray addObject:ma];
	
	[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] setValue:_mutArray forKey:@"PolicyData"];
}

- (void)editExistingPolicy {
	saveObj.personType = AddPolicy.personTypeLbl.text;
	saveObj.companyName = AddPolicy.compNameTF.text;
	saveObj.lifeTerm = AddPolicy.lifeTermTF.text;
	saveObj.accident = AddPolicy.accidentTF.text;
	saveObj.criticalIllness = AddPolicy.criticalIllnessTF.text;
	saveObj.dateIssued = AddPolicy.dateIssuedLbl.text;
	
	NSMutableArray *ma = [[NSMutableArray alloc] init];
	[ma addObject:saveObj.personType];
	[ma addObject:saveObj.companyName];
	[ma addObject:saveObj.lifeTerm];
	[ma addObject:saveObj.accident];
	[ma addObject:saveObj.criticalIllness];
	[ma addObject:saveObj.dateIssued];
	
	//	_mutArray = [[NSMutableArray alloc] init];
	[_mutArray replaceObjectAtIndex:whichpolicy withObject:ma];
	
	[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] setValue:_mutArray forKey:@"PolicyData"];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (alertView.tag == 100) {
		[AddPolicy.compNameTF becomeFirstResponder];
	}
	else if (alertView.tag == 200) {
		[AddPolicy.lifeTermTF becomeFirstResponder];
	}
}

- (void) dealloc
{
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

//- (void)deletePolicy:(int)policyNumber withPolicyCount:(int)policyCount {
//	NSLog(@"policyNumber: %d, policyCount: %d", policyNumber, policyCount);
//}

@end
