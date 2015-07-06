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

@interface MainTrusteesVC () {
	DataClass *obj;
}

@end

@implementation MainTrusteesVC

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

- (void)show1stTrustee {
	//start 1st trustee
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"SamePO"] isEqualToString:@"true"]) {
		[trustees.btnPO setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		trustees.po = TRUE;
		trustees.fa = FALSE;
		[trustees.btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];

		trustees.nameTF.text = @"";
	}
	else {
		[trustees.btnPO setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		trustees.po = FALSE;
		
		trustees.nameTF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Name"];
	}
	trustees.titleLbl.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Title"];
	
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Sex"] isEqualToString:@"M"]) {
		trustees.sexSC.selectedSegmentIndex = 0;
	}
	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Sex"] isEqualToString:@"F"]) {
		trustees.sexSC.selectedSegmentIndex = 1;
	}
	trustees.dobLbl.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"DOB"];
	trustees.icNoTF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"ICNo"];
	trustees.otherIDTypeLbl.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"OtherIDType"];
	trustees.otherIDTF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"OtherID"];
	trustees.relationshipLbl.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Relationship"];
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"ForeignAddress"] isEqualToString:@"Y"]) {
		[trustees.btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		trustees.fa = TRUE;
	}
	else {
		[trustees.btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		trustees.fa = FALSE;
	}
	trustees.add1TF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Address1"];
	trustees.add2TF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Address2"];
	trustees.add3TF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Address3"];
	trustees.postcodeTF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Postcode"];
	trustees.townTF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Town"];
	trustees.stateLbl.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"State"];
	trustees.countryLbl.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Country"];
	
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
		[trustees.btnPO setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		trustees.po = TRUE;
		trustees.fa = FALSE;
		[trustees.btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		trustees.nameTF.text = @"";
	}
	else {
		[trustees.btnPO setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		trustees.po = FALSE;
		trustees.nameTF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TName"];
	}
	trustees.titleLbl.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TTitle"];
	
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TSex"] isEqualToString:@"M"]) {
		trustees.sexSC.selectedSegmentIndex = 0;
	}
	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TSex"] isEqualToString:@"F"]) {
		trustees.sexSC.selectedSegmentIndex = 1;
	}
	trustees.dobLbl.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TDOB"];
	trustees.icNoTF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TICNo"];
	trustees.otherIDTypeLbl.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TOtherIDType"];
	trustees.otherIDTF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TOtherID"];
	trustees.relationshipLbl.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TRelationship"];
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TForeignAddress"] isEqualToString:@"Y"]) {
		[trustees.btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		trustees.fa = TRUE;
	}
	else {
		[trustees.btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		trustees.fa = FALSE;
	}
	trustees.add1TF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TAddress1"];
	trustees.add2TF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TAddress2"];
	trustees.add3TF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TAddress3"];
	trustees.postcodeTF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TPostcode"];
	trustees.townTF.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TTown"];
	trustees.stateLbl.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TState"];
	trustees.countryLbl.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TCountry"];
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
	[self alertForTrustees];
	NSLog(@"done save");
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"1T"]) {
		[self save1stTrustee];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"1" forKey:@"Trustee1"];
	}
	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"2T"]) {
		[self save2ndTrustee];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"1" forKey:@"Trustee2"];
	}
	[_delegate setTrusteeLbl1:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"]objectForKey:@"Name"] andTrusteeLbl2:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"]objectForKey:@"2TName"]];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:YES];
	[_delegate setTrusteeLbl1:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"]objectForKey:@"Name"] andTrusteeLbl2:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"]objectForKey:@"2TName"]];
}

- (IBAction)selectCancel:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)save1stTrustee {
	//object
	if (trustees.po) {
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"true" forKey:@"SamePO"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@""  forKey:@"Title"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Name"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Sex"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"DOB"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"ICNo"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"OtherIDType"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"OtherID"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Relationship"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"ForeignAddress"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Address1"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Address2"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Address3"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Postcode"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Town"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"State"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Country"];
	}
	else {
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"false" forKey:@"SamePO"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.titleLbl.text forKey:@"Title"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.nameTF.text forKey:@"Name"];
		if (trustees.sexSC.selectedSegmentIndex == 0) {
			[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"M" forKey:@"Sex"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"F" forKey:@"Sex"];
		}
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.dobLbl.text forKey:@"DOB"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.icNoTF.text forKey:@"ICNo"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.otherIDTypeLbl.text forKey:@"OtherIDType"];
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
	//
}

- (void)save2ndTrustee {
	//object
	if (trustees.po) {
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"true" forKey:@"2TSamePO"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@""  forKey:@"2TTitle"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TName"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TSex"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TDOB"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TICNo"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TOtherIDType"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TOtherID"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TRelationship"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TForeignAddress"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TAddress1"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TAddress2"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TAddress3"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TPostcode"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TTown"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TState"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TCountry"];
	}
	else {
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"false" forKey:@"2TSamePO"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.titleLbl.text forKey:@"2TTitle"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.nameTF.text forKey:@"2TName"];
		if (trustees.sexSC.selectedSegmentIndex == 0) {
			[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"M" forKey:@"2TSex"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"F" forKey:@"2TSex"];
		}
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.dobLbl.text forKey:@"2TDOB"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.icNoTF.text forKey:@"2TICNo"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:trustees.otherIDTypeLbl.text forKey:@"2TOtherIDType"];
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
	//
}

- (void)alertForTrustees {
	//	NSString *stringDay = [trustees.icNoTF.text substringWithRange: NSMakeRange (4,2)];
	//	NSString *stringMonth = [trustees.icNoTF.text substringWithRange: NSMakeRange (2,2)];
	if (trustees.icNoTF.text.length == 12) {
		stringForIC = [trustees.icNoTF.text substringWithRange: NSMakeRange (0,6)];
		NSString *stringForSex = [trustees.icNoTF.text substringWithRange: NSMakeRange (11,1)];
		//	NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
		//	[f setNumberStyle:NSNumberFormatterDecimalStyle];
		//	NSNumber *myNumber = [f numberFromString:string2];
		
		//	NSInteger myIntDay = [stringDay integerValue];
		//	NSInteger myIntMonth = [stringMonth integerValue];
		
		NSInteger ss = [stringForSex integerValue];
		if (ss % 2 == 0) {
			isFemale = TRUE;
		}
		else { isFemale = FALSE; }}
	//	NSLog(@"what out: %ld %ld %ld", (long)myIntDay, (long)myIntMonth, (long)myIntYear);
	//	NSLog(@"what out2: %ld %ld %ld", (long)trustees.dobDay, (long)trustees.dobMonth, (long)trustees.dobYear);
	
	if (!trustees.po) {
		
		
		if (trustees.titleLbl.text.length == 0) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Title is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 100;
			[alert show];
		}
		else if (trustees.nameTF.text.length == 0) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Name is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 200;
			[alert show];
		}
		else if ([textFields validateString:trustees.nameTF.text])
		{
			NSLog(@"same");
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Invalid name format. Same alphabet cannot be repeated more than three times." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 300;
			[alert show];
		}
		else if (trustees.sexSC.selectedSegmentIndex == -1) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Sex is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 700;
			[alert show];
		}
		else if (trustees.dobLbl.text.length == 0) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Date of Birth is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 600;
			[alert show];
		}
		else if (trustees.icNoTF.text.length == 0 && trustees.otherIDTypeLbl.text.length == 0) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Either New IC No. or Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 400;
			[alert show];
		}
		else if (trustees.otherIDTypeLbl.text.length == 0 && !(trustees.dobLbl.text.length == 0) && !([stringForIC isEqualToString:trustees.hhh])) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Invalid New IC No. against DOB." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 401;
			[alert show];
		}
		else if ((trustees.otherIDTypeLbl.text.length == 0 && isFemale && (trustees.sexSC.selectedSegmentIndex == 0)) || (trustees.otherIDTypeLbl.text.length == 0 && !isFemale && (trustees.sexSC.selectedSegmentIndex == 1))) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"New IC No. entered does not match with Sex." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 402;
			[alert show];
		}
		else if (trustees.otherIDTypeLbl.text.length == 0 && !(trustees.icNoTF.text.length == 12)) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"New IC must be 12 digits characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 403;
			[alert show];
		}
		else if (!(trustees.otherIDTypeLbl.text.length == 0) && trustees.otherIDTF.text.length == 0) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 500;
			[alert show];
		}
//		else if (trustees.relationshipLbl.text.length == 0) {
//			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Relationship is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//			//		NSLog(@"no title");
//			//			alert.tag = 1400;
//			[alert show];
//		}
		else if (trustees.add1TF.text.length == 0) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 1200;
			[alert show];
		}
		else if (!trustees.fa && trustees.postcodeTF.text.length == 0) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Postcode is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 1300;
			[alert show];
		}
		else if (!trustees.fa && [trustees.stateLbl.text isEqualToString:@"State"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Invalid Postcode." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 1500;
			[alert show];
		}
		else if (trustees.fa && [trustees.countryLbl.text isEqualToString:@"Country"]) {
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Country is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			//		NSLog(@"no title");
			alert.tag = 1400;
			[alert show];
			
		}
		else {
			[self dismissModalViewControllerAnimated:YES];
		}
	}
	else {
		[self dismissModalViewControllerAnimated:YES];
	}
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

@end
