//
//  Trustees.m
//  iMobile Planner
//
//  Created by Erza on 7/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "Trustees.h"
#import "ColorHexCode.h"
#import "DataClass.h"

#define CHARACTER_LIMIT_ICNO 12
#define NUMBERS_ONLY @"0123456789"
#define CHARACTER_LIMIT_PC_F 12
#define CHARACTER_LIMIT_PC_NF 5

@interface Trustees () {
	DataClass *obj;
}

@end

@implementation Trustees

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
	ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"e-Application";
    self.navigationItem.titleView = label;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnDone:)];
	
	//db for postcode
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	//
	obj = [DataClass getInstance];
    
}

- (void)btnDone:(id)sender
{
    
    [self dismissModalViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneBtn:(id)sender {
     [self dismissModalViewControllerAnimated:YES];
}
- (void)viewDidUnload {
	[self setTitleLbl:nil];
	[self setNameTF:nil];
	[self setSexSC:nil];
	[self setDobLbl:nil];
	[self setIcNoTF:nil];
	[self setOtherIDTypeLbl:nil];
	[self setOtherIDTF:nil];
	[self setBtnForeignAddress:nil];
	[self setAdd1TF:nil];
	[self setAdd2TF:nil];
	[self setAdd3TF:nil];
	[self setPostcodeTF:nil];
	[self setTownTF:nil];
	[self setStateLbl:nil];
	[self setCountryLbl:nil];
	[self setBtnCountryPO:nil];
	[self setBtnOtherIDTypePO:nil];
	[self setBtnDOBPO:nil];
	[self setBtnTitlePO:nil];
	[self setBtnPO:nil];
    [self setDeleteCell:nil];
    [self setDeleteBtn:nil];
    [self setRelationshipLbl:nil];
	[self setBtnRelationship:nil];
	[super viewDidUnload];
}

- (IBAction)actionForSameAsPO:(id)sender {
	isSameAsPO = !isSameAsPO;
	if(isSameAsPO) {
		[_btnPO setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		
		_titleLbl.text = @"";
//		_titleLbl.textColor = [UIColor lightGrayColor];
		_btnTitlePO.enabled = NO;
		
		_nameTF.text = @"";
		_nameTF.enabled = NO;
		
		_sexSC.enabled = NO;
		_sexSC.selectedSegmentIndex = -1;
		
		_dobLbl.text = @"";
//		_dobLbl.textColor = [UIColor lightGrayColor];
		_btnDOBPO.enabled = NO;
		
		_icNoTF.text = @"";
		_icNoTF.enabled = NO;
		
		_otherIDTypeLbl.text = @"";
//		_otherIDTypeLbl.textColor = [UIColor lightGrayColor];
		_btnOtherIDTypePO.enabled = NO;
		
		_otherIDTF.text = @"";
		_otherIDTF.enabled = NO;
		
		_relationshipLbl.text = @"";
		_btnRelationship.enabled = NO;
		
		_btnForeignAddress.enabled = NO;
		
		_add1TF.text = @"";
		_add1TF.enabled = NO;
		_add2TF.text = @"";
		_add2TF.enabled = NO;
		_add3TF.text = @"";
		_add3TF.enabled = NO;
		
		_postcodeTF.text = @"";
		_postcodeTF.enabled = NO;
		
		_townTF.text = @"";
		_townTF.enabled = NO;
		
		_stateLbl.text = @"State";
		_stateLbl.textColor = [UIColor lightGrayColor];
		
		_countryLbl.text = @"";
//		_countryLbl.textColor = [UIColor lightGrayColor];
		_btnCountryPO.enabled = NO;_po = TRUE;
	}
	else {
		[_btnPO setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];

//		_titleLbl.textColor = [UIColor blackColor];
		_btnTitlePO.enabled = YES;

		_nameTF.enabled = YES;
		
		_sexSC.enabled = YES;

//		_dobLbl.textColor = [UIColor blackColor];
		_btnDOBPO.enabled = YES;

		_icNoTF.enabled = YES;

//		_otherIDTypeLbl.textColor = [UIColor blackColor];
		_btnOtherIDTypePO.enabled = YES;

		_otherIDTF.enabled = YES;

		_btnRelationship.enabled = YES;
		
		_btnForeignAddress.enabled = YES;
		
		_add1TF.enabled = YES;
		_add2TF.enabled = YES;
		_add3TF.enabled = YES;
		
		//		_postcodeTF.placeholder = @"Postcode";
		_postcodeTF.enabled = YES;
		
		//		_townTF.placeholder = @"Town";
		_townTF.enabled = YES;
		
		_countryLbl.text = @"MALAYSIA";
//		_countryLbl.textColor = [UIColor blackColor];
		_btnCountryPO.enabled = YES;_po = FALSE;
	}
}

- (IBAction)actionForTitle:(id)sender {
	if (_TitlePicker == nil) {
        _TitlePicker = [[TitleViewController alloc] initWithStyle:UITableViewStylePlain];
        _TitlePicker.delegate = self;
        self.TitlePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_TitlePicker];
    }
    
    [self.TitlePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)selectedTitle:(NSString *)selectedTitle
{
    _titleLbl.text = selectedTitle;
//	_titleLbl.textColor = [UIColor blackColor];
    [self.TitlePickerPopover dismissPopoverAnimated:YES];
}

- (IBAction)actionForDOB:(id)sender {
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
	
//	_dobLbl.textColor = [UIColor blackColor];

	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyMMdd"];
	_hhh = [df stringFromDate:[NSDate date]];
	NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:[NSDate date]];
	_dobDay = (long)[comps day];
	_dobMonth = (long)[comps month];
	_dobYear = (long)[comps year];
	
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    
    if (_SIDate == Nil) {
        
        self.SIDate = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIDate"];
        _SIDate.delegate = self;
        self.SIDatePopover = [[UIPopoverController alloc] initWithContentViewController:_SIDate];
    }
    
    [self.SIDatePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.SIDatePopover presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    
    dateFormatter = Nil;
//	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"1T"] && [[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"DOB"] isEqualToString:@""]) {
//		dateString = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"DOB"];
//		_dobLbl.text = dateString;
//	}
//	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"2T"] && [[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TDOB"] isEqualToString:@""]) {
//		dateString = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TDOB"];
//		_dobLbl.text = dateString;
//	}
//    else if ([_dobLbl.text isEqualToString:@""]) {
		dateString = nil;
		_dobLbl.text = dateString;
//	}
	mainStoryboard = nil;
	
}

-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
    _dobLbl.text = strDate;
//	_dobLbl.textColor = [UIColor blackColor];
	
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyMMdd"];
	_hhh = [df stringFromDate:_SIDate.outletDate.date];
	NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:_SIDate.outletDate.date];
	_dobDay = (long)[comps day];
	_dobMonth = (long)[comps month];
	_dobYear = (long)[comps year];
}

-(void)CloseWindow
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [self.SIDatePopover dismissPopoverAnimated:YES];
}

- (IBAction)actionForOtherIDType:(id)sender {
	if (_IDTypeVC == nil) {
        
        self.IDTypeVC = [[IDTypeViewController alloc] initWithStyle:UITableViewStylePlain];
        _IDTypeVC.delegate = self;
        self.IDTypePopover = [[UIPopoverController alloc] initWithContentViewController:_IDTypeVC];
    }
    
    [self.IDTypePopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)selectedIDType:(NSString *)selectedIDType
{
    _otherIDTypeLbl.text = selectedIDType;
//	_otherIDTypeLbl.textColor =  [UIColor blackColor];
    [self.IDTypePopover dismissPopoverAnimated:YES];
	_otherIDTF.enabled = YES;
	_icNoTF.text = @"";
	_icNoTF.enabled = NO;
}

- (IBAction)actionForForeignAdd:(id)sender {
	isForeignAddress = !isForeignAddress;
	if(isForeignAddress) {
		[_btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		
		_add1TF.enabled = YES;
		_add2TF.enabled = YES;
		_add3TF.enabled = YES;
		
		_postcodeTF.text = @"";
		//		_postcodeTF.textColor = [UIColor lightGrayColor];
		//		_postcodeTF.enabled = YES;
		//
		_townTF.text = @"";
		_townTF.enabled = YES;
		//		_townTF.placeholder = @"Town";
		////		_townTF.textColor = [UIColor lightGrayColor];
		
		//
		_stateLbl.text = @"State";
		_stateLbl.textColor = [UIColor lightGrayColor];
		
		_countryLbl.text = @"";
//		_countryLbl.textColor = [UIColor lightGrayColor];
		_btnCountryPO.enabled = YES;_fa = TRUE;
	}
	else {
		[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		
		_add1TF.text = @"";
		_add1TF.enabled = YES;
		_add2TF.text = @"";
		_add2TF.enabled = YES;
		_add3TF.text = @"";
		_add3TF.enabled = YES;
		
		_postcodeTF.text = @"";
		_postcodeTF.enabled = YES;
		
		_townTF.text = @"";
		_townTF.enabled = NO;
		//
		//		_stateLbl.text = @"State";
		//		_stateLbl.textColor = [UIColor lightGrayColor];
		
		_countryLbl.text = @"MALAYSIA";
//		_countryLbl.textColor = [UIColor blackColor];
		_btnCountryPO.enabled = NO; _fa = FALSE;
	}
}

- (IBAction)editingDidEndPostcode:(id)sender {
	if (!isForeignAddress) {
		
		const char *dbpath = [databasePath UTF8String];
		sqlite3_stmt *statement;
		if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
			NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", _postcodeTF.text];
			const char *query_stmt = [querySQL UTF8String];
			if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
			{
				if (sqlite3_step(statement) == SQLITE_ROW){
					NSString *Town = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
					NSString *State = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
					NSString *Statecode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
					
					_stateLbl.text = State;
					_stateLbl.textColor = [UIColor blackColor];
					_townTF.text = Town;
					_townTF.enabled = NO;
					//				_townTF.textColor = [UIColor blackColor];
					_countryLbl.text = @"MALAYSIA";
//					_countryLbl.textColor = [UIColor blackColor];
					_btnCountryPO.enabled = NO;
					//				SelectedOfficeStateCode = Statecode;
					//				gotRow = true;
					//				IsContinue = TRUE;
				}
				sqlite3_finalize(statement);
			}
			sqlite3_close(contactDB);
		}}
	else {
		_townTF.placeholder = @"Town";
		//		_townTF.textColor = [UIColor lightGrayColor];
		_townTF.enabled = YES;
		
		_stateLbl.text = @"State";
		_stateLbl.textColor = [UIColor lightGrayColor];
	}
}

- (IBAction)actionForCountry:(id)sender {
	if (_CountryVC == nil) {
        self.CountryVC = [[CountryPopoverViewController alloc] initWithStyle:UITableViewStylePlain];
        _CountryVC.delegate = self;
        self.CountryPopover = [[UIPopoverController alloc] initWithContentViewController:_CountryVC];
    }
    [self.CountryPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}

- (IBAction)actionForDeleteTrustee:(id)sender {
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"1T"]) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Are you sure you want to delete selected record?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
		//		NSLog(@"no title");
		alert.tag = 1;
		[alert show];
	}
	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"2T"]) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Are you sure you want to delete selected record?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
		//		NSLog(@"no title");
		alert.tag = 2;
		[alert show];
	}
}

- (IBAction)actionForRelationship:(id)sender {
	UIKeyboardOrderOutAutomatic();
	if (_RelationshipVC == nil) {
		
        self.RelationshipVC = [[Relationship alloc] initWithStyle:UITableViewStylePlain];
        _RelationshipVC.delegate = self;
        _RelationshipVC.requestType = @"LA";
        self.RelationshipPopover = [[UIPopoverController alloc] initWithContentViewController:_RelationshipVC];
    }
    [self.RelationshipPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)selectedRelationship:(NSString *)theRelation
{
    _relationshipLbl.text = theRelation;
//	_relationshipLbl.textColor = [UIColor blackColor];
    [self.RelationshipPopover dismissPopoverAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1 && buttonIndex == 0) {
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"1" forKey:@"Delete1st"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"Add Trustee (1)" forKey:@"TL1"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"SamePO"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"ForeignAddress"];
		_po = FALSE;
		_fa = FALSE;
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Name"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Title"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Sex"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"DOB"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"ICNo"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"OtherIDType"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"OtherID"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Relationship"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Address1"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Address2"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Address3"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Postcode"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Town"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"State"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Country"];
		[self dismissViewControllerAnimated:NO completion:Nil];
	}
//	else if (alertView.tag == 1 && buttonIndex == 1) {
//		[self dismissViewControllerAnimated:NO completion:Nil];
//	}
	else if (alertView.tag == 2 && buttonIndex == 0) {
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"1" forKey:@"Delete2nd"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"Add Trustee (2)" forKey:@"TL2"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TSamePO"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TForeignAddress"];
		_po = FALSE;
		_fa = FALSE;
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TName"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TTitle"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TSex"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TDOB"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TICNo"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TOtherIDType"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TOtherID"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TRelationship"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TAddress1"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TAddress2"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TAddress3"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TPostcode"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TTown"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TState"];
		[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TCountry"];
		[self dismissViewControllerAnimated:NO completion:Nil];
	}
//	else if (alertView.tag == 2 && buttonIndex == 1) {
//		[self dismissViewControllerAnimated:NO completion:Nil];
//	}
}
-(void)selectedCountry:(NSString *)selectedCountry {
    _countryLbl.text = selectedCountry;
//	_countryLbl.textColor = [UIColor blackColor];
    [_CountryPopover dismissPopoverAnimated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	if (textField == _postcodeTF) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		if (isForeignAddress) {
			return ((newLength <= CHARACTER_LIMIT_PC_F));
		}
		else {
			NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
			NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
			return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_PC_NF));
		}
	}
	
	else if (textField == _icNoTF) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_ICNO));
	}
	else return YES;
}

@end
