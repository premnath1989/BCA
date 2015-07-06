//
//  MainTrusteesVC.m
//  iMobile Planner
//
//  Created by Juliana on 9/5/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "MainTrusteesVC.h"
#import "textFields.h"
#import "DataClass.h"
#import <sqlite3.h>

@interface MainTrusteesVC () {
	DataClass *obj;
	NSString *databasePath;
    sqlite3 *contactDB;
}

@end

@implementation MainTrusteesVC
@synthesize age, DOB, ANB;
@synthesize commDate;
@synthesize IDTypeCodeSelected;
@synthesize TitleCodeSelected;

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
	trustees = [self.storyboard instantiateViewControllerWithIdentifier:@"Trustees"];
	trustees.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
	NSLog(@"trustee: %f, %f", self.view.frame.size.width, self.view.frame.size.height);
	[self addChildViewController:trustees];
	[self.mainView addSubview:trustees.view];
	
	obj = [DataClass getInstance];
//	NSLog(@"which trustee : %@", [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"]);
	
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"1T"]) {
		[self show1stTrustee];
	}
	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"2T"]) {
		[self show2ndTrustee];
	}

	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	tap.delegate = self;
	[self.view addGestureRecognizer:tap];
}

-(void)hideKeyboard{
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UITextField class]] ||
        [touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
//	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"1T"]) {
//		if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"TL1"] == NULL  ||  [[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"TL1"] isEqualToString:@"Add Trustee (1)"]) {
//			NSLog(@"hidden");
//			trustees.deleteCell.hidden = TRUE;
//			trustees.deleteBtn.hidden = TRUE;
//		}
//		else {
//			NSLog(@"not hidden");
//			trustees.deleteCell.hidden = FALSE;
//			trustees.deleteBtn.hidden = FALSE;
//		}
////		[self show1stTrustee];
//	}
//	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"2T"]) {
//		NSLog(@"title2: %@", [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"TL2"]);
//			if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"TL2"] == NULL  ||  [[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"TL2"] isEqualToString:@"Add Trustee (2)"]) {
//				NSLog(@"hidden");
//				trustees.deleteCell.hidden = TRUE;
//				trustees.deleteBtn.hidden = TRUE;
//			}
//			else {
//				NSLog(@"not hidden");
//				trustees.deleteCell.hidden = FALSE;
//				trustees.deleteBtn.hidden = FALSE;
//			}
////		[self show2ndTrustee];
//		}
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"1T"]) {
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"SamePO"] length] == 0) {
//		NSLog(@"HH");
		trustees.deleteCell.hidden = TRUE;
		trustees.deleteBtn.hidden = TRUE;
	}
	else {
//		NSLog(@"II");
		trustees.deleteCell.hidden = FALSE;
		trustees.deleteBtn.hidden = FALSE;
	}
	}
	
	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"2T"]) {
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TSamePO"] length] == 0) {
//		NSLog(@"JJ");
		trustees.deleteCell.hidden = TRUE;
		trustees.deleteBtn.hidden = TRUE;
	}
	else {
//		NSLog(@"KK");
		trustees.deleteCell.hidden = FALSE;
		trustees.deleteBtn.hidden = FALSE;
	}
	}
}

-(void)DateHHH:(NSString *)strDate
{	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];

	NSDate *strDt = [[NSDate alloc] init];
	strDt = [dateFormatter dateFromString:strDate];
	
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyMMdd"];
	trustees.hhh = [df stringFromDate:strDt];

}

- (void)show1stTrustee {
	//start 1st trustee
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"SamePO"] isEqualToString:@"true"]) {
		[trustees.btnSameAddAsPO setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		trustees.po = TRUE;
		trustees.fa = FALSE;
		[trustees.btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];

		//trustees.nameTF.text = @"";
		trustees.nameTF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Name"];
        [trustees actionForSameAddAsPO:nil];
        //return;
	}
	else {
		[trustees.btnSameAddAsPO setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		trustees.po = FALSE;
		
		trustees.nameTF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Name"];
	}
	
    previoustrusteName=trustees.nameTF.text;
	trustees.titleLbl.text = [self getTitleDesc:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Title"]];
	trustees.TitleCodeSelected = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Title"];
	
	
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Sex"] isEqualToString:@"M"]) {
		trustees.sexSC.selectedSegmentIndex = 0;
	}
	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Sex"] isEqualToString:@"F"]) {
		trustees.sexSC.selectedSegmentIndex = 1;
	}
	trustees.dobLbl.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"DOB"];
	[self DateHHH:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"DOB"]];
	trustees.icNoTF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"ICNo"];
    previoustrusteIcNo=trustees.icNoTF.text;
	trustees.otherIDTypeLbl.text = [self getIDTypeDesc:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"OtherIDType"]];
	if (trustees.IDTypeCodeSelected == NULL) 
	trustees.IDTypeCodeSelected = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"OtherIDType"];

	if ([trustees.otherIDTypeLbl.text isEqualToString:@"BIRTH CERTIFICATE"] || [trustees.otherIDTypeLbl.text isEqualToString:@"OLD IDENTIFICATION NO"] || [trustees.otherIDTypeLbl.text isEqualToString:@"PASSPORT"] || trustees.otherIDTypeLbl.text == NULL || [trustees.otherIDTypeLbl.text isEqualToString:@""] || [trustees.otherIDTypeLbl.text isEqualToString:@"- SELECT -"]) {
		//_nricLbl.text = @"";
		trustees.icNoTF.enabled = YES;
	}
	else {
		//trustees.icNoTF.text = @"";
		trustees.icNoTF.enabled = NO;
	}
	
	trustees.otherIDTF.text = [self getIDTypeDesc:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"OtherID"]];
	if (IDTypeCodeSelected == NULL)
		IDTypeCodeSelected = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"OtherID"];
	if (![trustees.otherIDTF.text isEqualToString:@""])
		trustees.otherIDTF.enabled = true;
	trustees.relationshipLbl.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Relationship"];
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"ForeignAddress"] isEqualToString:@"Y"]) {
		[trustees.btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		trustees.fa = TRUE;
        trustees.btnCountryPO.enabled = TRUE;
		trustees.townTF.enabled = TRUE;
		trustees.townTF.textColor = [UIColor blackColor];
		trustees.countryLbl.textColor = [UIColor blackColor];
	}
	else {
		[trustees.btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		trustees.fa = FALSE;
        trustees.btnCountryPO.enabled = FALSE;
		trustees.townTF.enabled = FALSE;
		trustees.townTF.textColor = [UIColor lightGrayColor];
		trustees.countryLbl.textColor = [UIColor lightGrayColor];
	}
	trustees.add1TF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Address1"];
	trustees.add2TF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Address2"];
	trustees.add3TF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Address3"];
	trustees.postcodeTF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Postcode"];
	trustees.townTF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Town"];
	
	trustees.stateLbl.text = [self getStateDesc:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"State"]];
	trustees.countryLbl.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Country"];
	
	if (trustees.icNoTF.text.length ==12) {
		//_dobLbl.text = @"";
		trustees.btnDOBPO.enabled = false;
		trustees.dobLbl.textColor = [UIColor grayColor];
		trustees.sexSC.enabled = false;
		//_sexSC.selectedSegmentIndex = -1;
	}
	else {
		//trustees.dobLbl.text = @"";
		trustees.btnDOBPO.enabled = TRUE;
		trustees.dobLbl.textColor = [UIColor blackColor];
		trustees.sexSC.enabled = TRUE;
		//trustees.sexSC.selectedSegmentIndex = -1;
	}
	
	
//	if ([trustees.titleLbl.text isEqualToString:@""]) {
//		trustees.deleteCell.hidden = TRUE;
//		trustees.deleteBtn.hidden = TRUE;
//	}
//	else {
//		trustees.deleteCell.hidden = FALSE;
//		trustees.deleteBtn.hidden = FALSE;
//	}
	//end 1st trustee
}

- (void)show2ndTrustee {
	//start 2nd trustee
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TSamePO"] isEqualToString:@"true"]) {
		[trustees.btnSameAddAsPO setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		trustees.po = TRUE;
		trustees.fa = FALSE;
		[trustees.btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	else {
		[trustees.btnSameAddAsPO setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		trustees.po = FALSE;
		
	}
	trustees.titleLbl.text = [self getTitleDesc:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TTitle"]];
	trustees.TitleCodeSelected = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TTitle"];
	trustees.nameTF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TName"];
     stringprevioustruste2TName=trustees.nameTF.text;
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TSex"] isEqualToString:@"M"]) {
		trustees.sexSC.selectedSegmentIndex = 0;
	}
	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TSex"] isEqualToString:@"F"]) {
		trustees.sexSC.selectedSegmentIndex = 1;
	}
	trustees.dobLbl.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TDOB"];
	[self DateHHH:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TDOB"]];
	
	trustees.icNoTF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TICNo"];
    previoustrusteIcNo2=trustees.icNoTF.text;
	trustees.otherIDTypeLbl.text = [self getIDTypeDesc:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TOtherIDType"]];
	if (trustees.IDTypeCodeSelected == NULL)
	trustees.IDTypeCodeSelected = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TOtherIDType"];
	trustees.otherIDTF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TOtherID"];
	if (![trustees.otherIDTF.text isEqualToString:@""])
		trustees.otherIDTF.enabled = true;
	trustees.relationshipLbl.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TRelationship"];
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TForeignAddress"] isEqualToString:@"Y"]) {
		[trustees.btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		trustees.fa = TRUE;
        trustees.btnCountryPO.enabled = TRUE;
		trustees.townTF.enabled = TRUE;
		trustees.townTF.textColor = [UIColor blackColor];
		trustees.countryLbl.textColor = [UIColor blackColor];
	}
	else {
		[trustees.btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		trustees.fa = FALSE;
        trustees.btnCountryPO.enabled = FALSE;
		trustees.townTF.enabled = FALSE;
		trustees.townTF.textColor = [UIColor lightGrayColor];
		trustees.countryLbl.textColor = [UIColor lightGrayColor];
	}
	
	trustees.add1TF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TAddress1"];
	trustees.add2TF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TAddress2"];
	trustees.add3TF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TAddress3"];
	trustees.postcodeTF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TPostcode"];
	trustees.townTF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TTown"];
	trustees.stateLbl.text = [self getStateDesc:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TState"]];
	trustees.countryLbl.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TCountry"];
	
	if (trustees.icNoTF.text.length ==12) {
		//_dobLbl.text = @"";
		trustees.btnDOBPO.enabled = false;
		trustees.dobLbl.textColor = [UIColor grayColor];
		trustees.sexSC.enabled = false;
		//_sexSC.selectedSegmentIndex = -1;
	}
	else {
		//trustees.dobLbl.text = @"";
		trustees.btnDOBPO.enabled = TRUE;
		trustees.dobLbl.textColor = [UIColor blackColor];
		trustees.sexSC.enabled = TRUE;
		//trustees.sexSC.selectedSegmentIndex = -1;
	}
	//end 2nd trustee
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMainView:nil];
    [super viewDidUnload];
}

- (IBAction)selectDone:(id)sender {
	[trustees editingDidEndPostcode:nil];
	//[self alertForTrustees];
	NSLog(@"done save");
	if ([self alertForTrustees]){
        
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"1T"]) {
		[self save1stTrustee];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"1" forKey:@"Trustee1"];
	}
	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"2T"]) {
		[self save2ndTrustee];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"1" forKey:@"Trustee2"];
	}
	}
	[_delegate setTrusteeLbl1:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"]objectForKey:@"Name"] andTrusteeLbl2:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"]objectForKey:@"2TName"]];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:YES];
	[_delegate setTrusteeLbl1:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"]objectForKey:@"Name"] andTrusteeLbl2:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"]objectForKey:@"2TName"]];
}

- (IBAction)selectCancel:(id)sender {
	
	[_delegate setTrusteeLbl1:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"]objectForKey:@"Name"] andTrusteeLbl2:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"]objectForKey:@"2TName"]];

	[self dismissModalViewControllerAnimated:YES];
	
}

- (void)save1stTrustee {
	//object
	if (trustees.po) {
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"true" forKey:@"SamePO"];
	}
	else {
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"false" forKey:@"SamePO"];
	}
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.TitleCodeSelected forKey:@"Title"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.nameTF.text forKey:@"Name"];
    previoustrusteName=trustees.nameTF.text;
		if (trustees.sexSC.selectedSegmentIndex == 0) {
			[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"M" forKey:@"Sex"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"F" forKey:@"Sex"];
		}
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.dobLbl.text forKey:@"DOB"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.icNoTF.text forKey:@"ICNo"];
    previoustrusteIcNo=trustees.icNoTF.text;
		//[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.otherIDTypeLbl.text forKey:@"OtherIDType"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.IDTypeCodeSelected forKey:@"OtherIDType"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.otherIDTF.text forKey:@"OtherID"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.relationshipLbl.text forKey:@"Relationship"];
		if (trustees.fa) {
			[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"Y" forKey:@"ForeignAddress"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"N" forKey:@"ForeignAddress"];
		}
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.add1TF.text forKey:@"Address1"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.add2TF.text forKey:@"Address2"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.add3TF.text forKey:@"Address3"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.postcodeTF.text forKey:@"Postcode"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.townTF.text forKey:@"Town"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.stateLbl.text forKey:@"State"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.countryLbl.text forKey:@"Country"];
	

}

- (void)save2ndTrustee {
	//object
	if (trustees.po) {
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"true" forKey:@"2TSamePO"];
	}
	else {
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"false" forKey:@"2TSamePO"];
	}
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.TitleCodeSelected forKey:@"2TTitle"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.nameTF.text forKey:@"2TName"];
    stringprevioustruste2TName=trustees.nameTF.text;
		if (trustees.sexSC.selectedSegmentIndex == 0) {
			[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"M" forKey:@"2TSex"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"F" forKey:@"2TSex"];
		}
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.dobLbl.text forKey:@"2TDOB"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.icNoTF.text forKey:@"2TICNo"];
    previoustrusteIcNo2=trustees.icNoTF.text;
		//[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.otherIDTypeLbl.text forKey:@"2TOtherIDType"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.IDTypeCodeSelected forKey:@"2TOtherIDType"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.otherIDTF.text forKey:@"2TOtherID"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.relationshipLbl.text forKey:@"2TRelationship"];
		if (trustees.fa) {
			[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"Y" forKey:@"2TForeignAddress"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"N" forKey:@"2TForeignAddress"];
		}
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.add1TF.text forKey:@"2TAddress1"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.add2TF.text forKey:@"2TAddress2"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.add3TF.text forKey:@"2TAddress3"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.postcodeTF.text forKey:@"2TPostcode"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.townTF.text forKey:@"2TTown"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.stateLbl.text forKey:@"2TState"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.countryLbl.text forKey:@"2TCountry"];
	
}

- (bool)alertForTrustees {
	//	NSString *stringDay = [trustees.icNoTF.text substringWithRange: NSMakeRange (4,2)];
	//	NSString *stringMonth = [trustees.icNoTF.text substringWithRange: NSMakeRange (2,2)];
	
	//Get PolicyOwner Name, IC and OtherID
		// Check if i/c no is the same as policy owner
		
		NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *docsDir = [dirPaths objectAtIndex:0];
    
        NSString *valid_msg;
        int *alert_response;
		databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
		
		FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
		[db open];
			
		results = [db executeQuery:@"select LAName, LANewICNo, LAOtherIDType, LAOtherID from eProposal_LA_Details where eProposalNo = ? AND POFlag = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"Y"];
		bool validIC = TRUE;
		bool validName = TRUE;
	
		while ([results next]) {
			NSString *LAName = [results objectForColumnName:@"LAName"];
			NSString *icNo = [results objectForColumnName:@"LANewICNo"];
			NSString *otherIDType = [results objectForColumnName:@"LAOtherIDType"];
			NSString *otherID = [results objectForColumnName:@"LAOtherID"];
            NSString *otherID_selected;
            
            FMResultSet *resultsOtherID = [db executeQuery:@"select * from eProposal_Identification where IdentityDesc = ?",trustees.otherIDTypeLbl.text];
            while ([resultsOtherID next]) {
                otherID_selected = [resultsOtherID stringForColumn:@"IdentityCode"];
            }
            
			
			
			NSLog(@"icnotf %@, icno %@", trustees.icNoTF.text, icNo);
            NSLog(@"icnotf %@, otherID %@", trustees.icNoTF.text, otherID);
			[self hideKeyboard];
			if ((trustees.icNoTF.text.length != 0 && [trustees.icNoTF.text isEqualToString:icNo])){
				validIC = FALSE;
//                valid_msg = @"Trustee's New IC No cannot be same as Policy Owner.";
//                alert_response = 400;
				UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Trustee's New IC No cannot be same as Policy Owner." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				//		NSLog(@"no title");
				alert.tag = 400;
				[alert show];
				return FALSE;
				
			}
			else if ((trustees.otherIDTypeLbl.text.length > 0) && (![trustees.otherIDTypeLbl.text isEqualToString:@"- SELECT -"]) && [otherID_selected isEqualToString:otherIDType] && [trustees.otherIDTF.text isEqualToString:otherID]) {
				validIC = FALSE;
//                valid_msg = @"Trustee's Other ID No cannot be same as Policy Owner.";
//                alert_response = 500;
				UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Trustee's Other ID No cannot be same as Policy Owner." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				//		NSLog(@"no title");
				alert.tag = 500;
				[alert show];
				return FALSE;
			}
           
			else {
				validIC = TRUE;
			}
			if ((trustees.nameTF.text.length != 0 && [trustees.nameTF.text caseInsensitiveCompare:LAName] == NSOrderedSame)){
				
				
				validName = FALSE;
			}
			else
				validName = TRUE;
		}
		
		[results close];
		[db close];

	//================
	NSString *strDOB2;
	NSString *strDate2;
	NSString *strMonth2;
	NSString *strYear2;
	NSString *febStatus = nil;
	
	NSDate *d;
	NSDate *d2;
    bool isMale = FALSE;
	
	if (trustees.icNoTF.text.length != 0 && trustees.icNoTF.text.length == 12) {
        NSString *last = [trustees.icNoTF.text substringFromIndex:[trustees.icNoTF.text length] -1];
        NSCharacterSet *oddSet = [NSCharacterSet characterSetWithCharactersInString:@"13579"];
        
        if ([last rangeOfCharacterFromSet:oddSet].location != NSNotFound) {
            isMale = TRUE;
        } else {
            isMale = FALSE;
        }
		
		//get the DOB value from ic entered
        strDate2 = [trustees.icNoTF.text substringWithRange:NSMakeRange(4, 2)];
        strMonth2 = [trustees.icNoTF.text substringWithRange:NSMakeRange(2, 2)];
        strYear2 = [trustees.icNoTF.text substringWithRange:NSMakeRange(0, 2)];
        
        //get value for year whether 20XX or 19XX
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy"];
        
        NSString *currentYear = [dateFormatter stringFromDate:[NSDate date]];
        NSString *strCurrentYear = [currentYear substringWithRange:NSMakeRange(2, 2)];
        if ([strYear2 intValue] > [strCurrentYear intValue] && !([strYear2 intValue] < 30)) {
            strYear2 = [NSString stringWithFormat:@"19%@",strYear2];
        }
        else {
            strYear2 = [NSString stringWithFormat:@"20%@",strYear2];
        }
        
        strDOB2 = [NSString stringWithFormat:@"%@/%@/%@",strDate2,strMonth2,strYear2];
		
		
        //		//CHECK DAY / MONTH / YEAR START
        //		//get the DOB value from ic entered
        //		NSString *strDate = [nominees.icNoTF.text substringWithRange:NSMakeRange(4, 2)];
        //		NSString *strMonth = [nominees.icNoTF.text substringWithRange:NSMakeRange(2, 2)];
        //		NSString *strYear = [nominees.icNoTF.text substringWithRange:NSMakeRange(0, 2)];
        //
        //		//get value for year whether 20XX or 19XX
        //		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //		[dateFormatter setDateFormat:@"yyyy"];
        //
        //		NSString *currentYear = [dateFormatter stringFromDate:[NSDate date]];
        //		NSString *strCurrentYear = [currentYear substringWithRange:NSMakeRange(2, 2)];
        //
        //		if ([strYear intValue] > [strCurrentYear intValue] && !([strYear intValue] < 30)) {
        //			strYear = [NSString stringWithFormat:@"19%@",strYear];
        //		}
        //		else {
        //			strYear = [NSString stringWithFormat:@"20%@",strYear];
        //		}
		
		NSString *strDOB3 = [NSString stringWithFormat:@"%@-%@-%@",strYear2,strMonth2,strDate2];
		
		//determine day of february
		
		float devideYear = [strYear2 floatValue]/4;
		int devideYear2 = devideYear;
		float minus = devideYear - devideYear2;
		if (minus > 0) {
			febStatus = @"Normal";
		}
		else {
			febStatus = @"Jump";
		}
		
		//compare year is valid or not
		[dateFormatter setDateFormat:@"yyyy-MM-dd"];
		d = [NSDate date];
		d2 = [dateFormatter dateFromString:strDOB3];
    }
    [self hideKeyboard];
	
	
	//	NSLog(@"what out: %ld %ld %ld", (long)myIntDay, (long)myIntMonth, (long)myIntYear);
	//	NSLog(@"what out2: %ld %ld %ld", (long)trustees.dobDay, (long)trustees.dobMonth, (long)trustees.dobYear);
	
//	if (!trustees.po) {
		[self hideKeyboard];
		//[self calculateAge];
		
		if ((trustees.titleLbl.text.length == 0) || ([trustees.titleLbl.text isEqualToString:@"- SELECT -"])) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Title is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 100;
			[alert show];
			return FALSE;
		}
		else if ([textFields trimWhiteSpaces:trustees.nameTF.text].length == 0) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Name is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 200;
			[alert show];
			return FALSE;
		}
        else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"1T"]  && [[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TOtherID"] isEqualToString:trustees.otherIDTF.text] && [[[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TOtherIDType"] lowercaseString] isEqualToString:[trustees.IDTypeCodeSelected lowercaseString]] ) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"1st Trustee’s Other ID cannot be same as 2nd Trustee’s Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //		NSLog(@"no title");
            alert.tag = 500;
            [alert show];
            return FALSE;
        }
        else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"2T"]  && [[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"OtherID"] isEqualToString:trustees.otherIDTF.text] && [[[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"OtherIDType"] lowercaseString] isEqualToString:[trustees.IDTypeCodeSelected lowercaseString]] ) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"2nd Trustee’s Other ID cannot be same as 1st Trustee’s Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //		NSLog(@"no title");
            alert.tag = 500;
            [alert show];
            return FALSE;
        }
        
        else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"1T"]  && [[[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TName"] lowercaseString] isEqualToString:[trustees.nameTF.text lowercaseString]] ) {
            
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"1st Trustee’s name cannot be same as 2nd Trustee’s name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //		NSLog(@"no title");
            alert.tag = 200;
            [alert show];
            return FALSE;
            
        }
        else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"2T"] && [[[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Name"] lowercaseString] isEqualToString:[trustees.nameTF.text lowercaseString]]) {
            
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"2nd Trustee’s name cannot be same as 1st Trustee’s name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //		NSLog(@"no title");
            alert.tag = 200;
            [alert show];
            return FALSE;
      
            
        }

        
		else if ([textFields validateString:trustees.nameTF.text])
		{
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid name format. Same alphabet cannot be repeated more than three times." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 300;
			[alert show];
			return FALSE;
		}
		else if ([textFields validateString3:trustees.nameTF.text])
		{
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid name format. Input must be alphabet A-Z, space, apostrophe('), alias(@), slash(/), dash(-),bracket(()) or dot(.)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 300;
			[alert show];
			return FALSE;
		}
		else if (!validName) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Trustee cannot be the same as Policy Owner" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 300;
			[alert show];
			return FALSE;
		}
		else if (trustees.icNoTF.text.length == 0 && trustees.otherIDTypeLbl.text.length == 0) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Either New IC No. or Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 400;
			[alert show];
			return FALSE;
		}
        
//        else if([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"ICNo"] isEqualToString:trustees.icNoTF.text] )
//            
//        {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"”2nd Trustee’s New IC No cannot be same as 1st Trustee’s New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//			//		NSLog(@"no title");
//			alert.tag = 400;
//			[alert show];
//			return FALSE;
//        }
        
        
//        else if([[[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"ICNo"] lowercaseString] isEqualToString:[trustees.icNoTF.text lowercaseString]] && previoustrusteIcNo!=trustees.icNoTF.text && ![trustees.icNoTF.text isEqualToString:@""])
//            
//        {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"”2nd Trustee’s New IC No cannot be same as 1st Trustee’s New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//			//		NSLog(@"no title");
//			alert.tag = 400;
//			[alert show];
//			return FALSE;
//        }
//        else if([[[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TICNo"] lowercaseString] isEqualToString:[trustees.icNoTF.text lowercaseString]] && previoustrusteIcNo2!=trustees.icNoTF.text && ![trustees.icNoTF.text isEqualToString:@""])
//            
//        {
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"”2nd Trustee’s New IC No cannot be same as 1st Trustee’s New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//			//		NSLog(@"no title");
//			alert.tag = 400;
//			[alert show];
//			return FALSE;
//        }
        
        else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"1T"]  && [[[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TICNo"] lowercaseString] isEqualToString:[trustees.icNoTF.text lowercaseString]] && ![trustees.icNoTF.text isEqualToString:@""] ) {
            
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"”2nd Trustee’s New IC No cannot be same as 1st Trustee’s New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //		NSLog(@"no title");
            alert.tag = 400;
            [alert show];
            return FALSE;
            
        }
        else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"2T"] && [[[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"ICNo"] lowercaseString] isEqualToString:[trustees.icNoTF.text lowercaseString]] && ![trustees.icNoTF.text isEqualToString:@""]) {
            
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"”2nd Trustee’s New IC No cannot be same as 1st Trustee’s New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //		NSLog(@"no title");
            alert.tag = 400;
            [alert show];
            return FALSE;
            
            
        }
        
       
		else if ((trustees.icNoTF.text == NULL || [trustees.icNoTF.text isEqualToString:@""]) && ([trustees.otherIDTypeLbl.text isEqualToString:@"- SELECT -"]) && (trustees.otherIDTF.text.length == 0)) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Either New IC No. or Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//alert.tag = 500;
			[alert show];
			return FALSE;
		}
		else if (trustees.otherIDTypeLbl.text.length == 0 && (trustees.icNoTF.text.length < 12)) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"New IC must be 12 digits characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 403;
			[alert show];
			return FALSE;
		}
		else if (trustees.icNoTF.text.length > 0 && (trustees.icNoTF.text.length < 12)) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"New IC must be 12 digits characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 403;
			[alert show];
			return FALSE;
		}
		//else if ([textFields trimWhiteSpaces:trustees.icNoTF.text].length != 0 && [textFields trimWhiteSpaces:trustees.icNoTF.text].length == 12) {
			
			else if ([textFields trimWhiteSpaces:trustees.icNoTF.text].length != 0 && [d compare:d2] == NSOrderedAscending) {
				
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
				alert.tag = 403;
				[alert show];
				
				return FALSE;;
			}
			else if ([textFields trimWhiteSpaces:trustees.icNoTF.text].length != 0 && ([strMonth2 intValue] > 12 || [strMonth2 intValue] < 1)) {
				
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC month must be between 1 and 12." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
				alert.tag = 403;
				[alert show];
				
				return FALSE;;
			}
			else if([textFields trimWhiteSpaces:trustees.icNoTF.text].length != 0 && ([strDate2 intValue] < 1 || [strDate2 intValue] > 31))
			{
				
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC day must be between 1 and 31." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
				alert.tag = 403;
				[alert show];
				
				return FALSE;;
				
			}
			else if ([textFields trimWhiteSpaces:trustees.icNoTF.text].length != 0 && (([strMonth2 isEqualToString:@"01"] || [strMonth2 isEqualToString:@"03"] || [strMonth2 isEqualToString:@"05"] || [strMonth2 isEqualToString:@"07"] || [strMonth2 isEqualToString:@"08"] || [strMonth2 isEqualToString:@"10"] || [strMonth2 isEqualToString:@"12"]) && [strDate2 intValue] > 31)) {
				
				
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
				alert.tag = 403;
				[alert show];
				
				return FALSE;;
			}
			
			else if ([textFields trimWhiteSpaces:trustees.icNoTF.text].length != 0 && (([strMonth2 isEqualToString:@"04"] || [strMonth2 isEqualToString:@"06"] || [strMonth2 isEqualToString:@"09"] || [strMonth2 isEqualToString:@"11"]) && [strDate2 intValue] > 30)) {
				
				
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
				alert.tag = 403;
				[alert show];
				
				return FALSE;;
			}
			else if ([textFields trimWhiteSpaces:trustees.icNoTF.text].length != 0 && (([febStatus isEqualToString:@"Normal"] && [strDate2 intValue] > 28 && [strMonth2 isEqualToString:@"02"]) || ([febStatus isEqualToString:@"Jump"] && [strDate2 intValue] > 29 && [strMonth2 isEqualToString:@"02"]))) {
				
				
				NSString *msg = [NSString stringWithFormat:@"February of %@ doesn’t have 29 days",strYear2] ;
				
				
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
				alert.tag = 403;
				[alert show];
				
				return FALSE;;
			}
		
//		else if (trustees.otherIDTypeLbl.text.length == 0 && !(trustees.dobLbl.text.length == 0) && !([stringForIC isEqualToString:trustees.hhh])) {
//        else if (strDOB2 && (![trustees.dobLbl.text isEqualToString:strDOB2])) {
//			NSLog(@"IC: %@ : %@", stringForIC, trustees.hhh);
//			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid New IC No. against DOB." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//			alert.tag = 401;
//			[alert show];
//			return FALSE;
//		}
//		else if ((trustees.otherIDTypeLbl.text.length == 0 && isFemale && (trustees.sexSC.selectedSegmentIndex == 0)) || (trustees.otherIDTypeLbl.text.length == 0 && !isFemale && (trustees.sexSC.selectedSegmentIndex == 1))) {
//			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"New IC No. entered does not match with Sex." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//			alert.tag = 402;
//			[alert show];
//			return FALSE;
//		}
	
		else if (([trustees.otherIDTypeLbl.text isEqualToString:@"- SELECT -"]) && trustees.otherIDTF.text.length > 0) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Other ID Type is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			//alert.tag = 500;
			[alert show];
			return FALSE;
		}
		else if (!(trustees.otherIDTypeLbl.text.length == 0) && !([trustees.otherIDTypeLbl.text isEqualToString:@"- SELECT -"]) &&[textFields trimWhiteSpaces:trustees.otherIDTF.text].length == 0 && [textFields trimWhiteSpaces:trustees.otherIDTF.text].length == 0) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 500;
			[alert show];
			return FALSE;
		}
		else if ((![trustees.otherIDTypeLbl.text isEqualToString:@"- SELECT -"]) && trustees.otherIDTypeLbl.text.length > 0 && ([textFields validateOtherID:trustees.otherIDTF.text])) {
			[trustees.otherIDTF becomeFirstResponder];
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 500;
			[alert show];
			return FALSE;
			
		}
		else if ([trustees.otherIDTF.text isEqualToString:trustees.icNoTF.text]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Other ID cannot be the same as New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 400;
			[alert show];
			return FALSE;
			
		}
		else if (trustees.dobLbl.text.length == 0) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Date of Birth is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 600;
			[alert show];
			return FALSE;
		}
		else if ((!trustees.dobLbl.text.length == 0) && [self calculateAge:trustees.dobLbl.text]){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Trustee age must at least 18 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
			[alert setTag:600];
			[alert show];
			return FALSE;
			
		}
		else if (trustees.sexSC.selectedSegmentIndex == -1) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Gender is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 700;
			[alert show];
			return FALSE;
		}
//		else if (!validIC) {
//			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:valid_msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//			//		NSLog(@"no title");
//			alert.tag = alert_response;
//			[alert show];
//			return FALSE;
//		}
//		else if (trustees.relationshipLbl.text.length == 0) {
//			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Relationship is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//			//		NSLog(@"no title");
//			//			alert.tag = 1400;
//			[alert show];
//		}
		else if ([textFields trimWhiteSpaces:trustees.add1TF.text].length == 0) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 1200;
			[alert show];
			return FALSE;
		}
		else if (!trustees.fa && trustees.postcodeTF.text.length == 0) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Postcode is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 1300;
			[alert show];
			return FALSE;
		}
		
		else if (!trustees.fa && [trustees.stateLbl.text isEqualToString:@"State"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid Postcode." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 1500;
			[alert show];
			return FALSE;
		}
		else if (trustees.fa && (trustees.countryLbl.text.length == 0 || [trustees.countryLbl.text isEqualToString:@"- SELECT -"])) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Country is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 1400;
			[alert show];
			return FALSE;
		}
		else {
			[self dismissModalViewControllerAnimated:YES];
			return TRUE;
		}
//	}
//	else {
//		[self dismissModalViewControllerAnimated:YES];
//		return TRUE;
//	}

[self hideKeyboard];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (alertView.tag == 200) {
		[trustees.nameTF becomeFirstResponder];
	}
	else if (alertView.tag == 300) {
		[trustees.nameTF becomeFirstResponder];
	}
	else if (alertView.tag == 400) {
		[trustees.icNoTF becomeFirstResponder];
	}
	else if (alertView.tag == 401) {
		[trustees.icNoTF becomeFirstResponder];
	}
	else if (alertView.tag == 402) {
		[trustees.icNoTF becomeFirstResponder];
	}
	else if (alertView.tag == 403) {
		[trustees.icNoTF becomeFirstResponder];
	}
	else if (alertView.tag == 500) {
		[trustees.otherIDTF becomeFirstResponder];
	}
	else if (alertView.tag == 1200) {
		[trustees.add1TF becomeFirstResponder];
	}
	else if (alertView.tag ==1300) {
		[trustees.postcodeTF becomeFirstResponder];
	}
	else if (alertView.tag ==1500) {
		[trustees.postcodeTF becomeFirstResponder];
	}
}

-(bool)calculateAge:(NSString *)Birthdate
{
    AgeLess = NO;
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    [fmtDate setDateFormat:@"dd/MM/yyyy"];
    NSString *textDate = [NSString stringWithFormat:@"%@",[fmtDate stringFromDate:[NSDate date]]];
    
    NSArray *curr = [textDate componentsSeparatedByString: @"/"];
    
    //NSArray *curr = [commDate componentsSeparatedByString: @"/"];
    NSString *currentDay = [curr objectAtIndex:0];
    NSString *currentMonth = [curr objectAtIndex:1];
    NSString *currentYear = [curr objectAtIndex:2];
    
    NSArray *foo = [Birthdate componentsSeparatedByString: @"/"];
    NSString *birthDay = [foo objectAtIndex: 0];
    NSString *birthMonth = [foo objectAtIndex: 1];
    NSString *birthYear = [foo objectAtIndex: 2];
    
    int yearN = [currentYear intValue];
    int yearB = [birthYear intValue];
    int monthN = [currentMonth intValue];
    int monthB = [birthMonth intValue];
    int dayN = [currentDay intValue];
    int dayB = [birthDay intValue];
    
    int ALB = yearN - yearB;
    int newALB;
    int newANB;
    
	
	NSString *msgAge;
    if (yearN >= yearB)
    {
        if (monthN < monthB) {
            newALB = ALB - 1;
        } else if (monthN == monthB && dayN < dayB) {
            newALB = ALB - 1;
        } else {
            newALB = ALB;
        }
        
        if (monthN > monthB) {
            newANB = ALB + 1;
        } else if (monthN == monthB && dayN >= dayB) {
            newANB = ALB + 1;
        } else {
            newANB = ALB;
        }
        msgAge = [[NSString alloc] initWithFormat:@"%d",newALB];
		
        age = newALB;
        ANB = newANB;

		if (age < 18) {
            //AgeLess = YES;
			return true;
        }
		
		
        //msgAge = [[NSString alloc] initWithFormat:@"%d days",diffDays];
        //        NSLog(@"birthday:%@, today:%@, diff:%d",selectDate,todayDate,diffDays);
        
        age = 0;
        ANB = 1;
    }
    //    NSLog(@"msgAge:%@",msgAge);
	return false;
}

-(NSString*) getIDTypeDesc : (NSString*)IDtype
{
    NSString *desc;
	IDtype = [IDtype stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
	databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
	
	NSString *sql = [NSString stringWithFormat:@"SELECT IdentityDesc FROM eProposal_identification WHERE IdentityCode = '%@'", IDtype];
    FMResultSet *result = [db executeQuery:sql];
    
    NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        desc =[result objectForColumnName:@"IdentityDesc"];
    }
	
    [result close];
    [db close];
    
	if (count == 0) {
		if (IDtype.length > 0) {
			if ([IDtype isEqualToString:@"- SELECT -"] || [IDtype isEqualToString:@"- Select -"]) {
				desc = @"";
			}
			else {
				desc = IDtype;
				[self getIDTypeCode:IDtype];
			}

		}
	}
    return desc;
}
-(void) getIDTypeCode : (NSString*)IDtype
{
    NSString *code;
	IDtype = [IDtype stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
	databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT IdentityCode FROM eProposal_identification WHERE IdentityDesc = ?", IDtype];
    
    while ([result next]) {
        code =[result objectForColumnName:@"IdentityCode"];
    }
	
    [result close];
    [db close];
	
	IDTypeCodeSelected = code;
	
}

-(NSString*) getTitleDesc : (NSString*)Title
{

    NSString *desc;
    Title = [Title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
	databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT TitleDesc FROM eProposal_Title WHERE TitleCode = ?", Title];
    
    NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        desc =[result objectForColumnName:@"TitleDesc"];
    }
	
    [result close];
    [db close];
    
	if (count == 0) {
		if (Title.length > 0) {
			if ([Title isEqualToString:@"- SELECT -"] || [Title isEqualToString:@"- Select -"]) {
				desc = @"";
			}
			else {
				desc = Title;
				[self getTitleCode:Title];
			}		}
	}
    return desc;
}
-(void) getTitleCode : (NSString*)Title
{
    NSString *code;
	Title = [Title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
	databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT TitleCode FROM eProposal_Title WHERE TitleDesc = ?", Title];
    
    while ([result next]) {
        code =[result objectForColumnName:@"TitleCode"];
    }
	
    [result close];
    [db close];
	
	trustees.TitleCodeSelected = code;
	
}

-(NSString*) getStateCode : (NSString*)state
{
	if ([state isEqualToString:@""] || (state == NULL) || ([state isEqualToString:@"(NULL)"])) {
		return @"";
	}
    NSString *code;
    state = [state stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT StateCode FROM eProposal_State WHERE StateDesc = ?", state];
    
	int count = 0;
    while ([result next]) {
		count = count + 1;
        code =[result objectForColumnName:@"StateCode"];
    }
    
	if (count == 0){
		code = state;
	}
	
    [result close];
    [db close];
    
    return code;
    
}

-(NSString*) getStateDesc : (NSString*)state
{
	if ([state isEqualToString:@""] || (state == NULL) || ([state isEqualToString:@"(NULL)"])) {
		return @"";
	}
	
    NSString *desc;
    state = [state stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT StateDesc FROM eProposal_State WHERE StateCode = ?", state];
    
	NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        desc = [result objectForColumnName:@"StateDesc"];
    }
    
    [result close];
    [db close];
	
	if (count == 0) {
		desc = state;
	}
    
    return desc;
    
}



@end
