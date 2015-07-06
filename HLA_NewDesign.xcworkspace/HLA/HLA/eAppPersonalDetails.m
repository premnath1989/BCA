//
//  eAppPersonalDetails.m
//  iMobile Planner
//
//  Created by shawal sapuan on 7/3/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "eAppPersonalDetails.h"
#import "ColorHexCode.h"
//#import "MainSubDetailsVC.h"
#import "MainLA1DetailsVC.h"
#import "DataClass.h"

#define CHARACTER_LIMIT_ICNO 12
#define NUMBERS_ONLY @"0123456789"
#define CHARACTER_LIMIT_PC_F 12
#define CHARACTER_LIMIT_PC_NF 5

@interface eAppPersonalDetails () {
	DataClass *obj;
}

@end

@implementation eAppPersonalDetails
@synthesize titleLbl,OtherIDLbl,DOBLbl,RelationshipLbl;
@synthesize IDTypePopover = _IDTypePopover;
@synthesize IDTypeVC = _IDTypeVC;
@synthesize SIDate = _SIDate;
@synthesize SIDatePopover = _SIDatePopover;
@synthesize TitlePicker = _TitlePicker;
@synthesize TitlePickerPopover = _TitlePickerPopover;
@synthesize RelationshipVC = _RelationshipVC;
@synthesize RelationshipPopover = _RelationshipPopover;
@synthesize checkAddress;
@synthesize checkForeign;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    checked = NO;
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
	
	
	//object start
	obj = [DataClass getInstance];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	
	results = Nil;
	results = [database executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"LA1", Nil];
	while ([results next]) {
		nameLA1 = [results stringForColumn:@"LAName"];
		[[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"LA1"] setValue:[results stringForColumn:@"POFlag"] forKey:@"POFlag"];
		[[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"LA1"] setValue:@"Personal" forKey:@"POFlagType"];
		[[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"LA1"] setValue:[results stringForColumn:@"LATitle"] forKey:@"Title"];
		[[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"LA1"] setValue:[results stringForColumn:@"LADOB"] forKey:@"DOB"];
		[[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"LA1"] setValue:[results stringForColumn:@"LAName"] forKey:@"Name"];
		[[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"LA1"] setValue:[results stringForColumn:@"LARace"] forKey:@"Race"];
		[[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"LA1"] setValue:[results stringForColumn:@"LANewICNo"] forKey:@"NRIC"];
		[[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"LA1"] setValue:[results stringForColumn:@"LANationality"] forKey:@"Nationality"];
		[[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"LA1"] setValue:[results stringForColumn:@"LAName"] forKey:@"Name"];
	}
	
	results = Nil;
	results = [database executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"LA2", Nil];
	while ([results next]) {
		nameLA2 = [results stringForColumn:@"LAName"];
	}
	
	results = Nil;
	results = [database executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"PY1", Nil];
	while ([results next]) {
		namePayor = [results stringForColumn:@"LAName"];
	}
	
	results = Nil;
	results = [database executeQuery:@"select ALB as Age from Clt_Profile as c where c.IndexNo = (select ClientProfileID from  eApp_Listing where ProposalNo = ?)", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
	while ([results next]) {
		ageForPart2 = [results intForColumn:@"Age"];
	}

	
	[results close];
	[database close];
	
	_firstLALbl.text = nameLA1;
	_secondLALbl.text = nameLA2;
	_payorLbl.text = namePayor;
//	NSLog(@"mm : %@", _secondLALbl.text);
	if (_firstLALbl.text.length == 0) {
		_L1Button.hidden = TRUE;
	}
	if (_secondLALbl.text.length == 0) {
		_L2Button.hidden = TRUE;
	}
	if (_payorLbl.text.length == 0) {
		_PYButton.hidden = TRUE;
	}
	
	
//	enable part 2 only if juvenile start
	if (ageForPart2 < 16)
		_btnPart2.enabled = TRUE;
	else
		_btnPart2.enabled = FALSE;
//	enable part 2 only if juvenile end
	
	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Title"]length] != 0) {
		[_btnPart2 setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
	}
	else {
		[_btnPart2 setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	titleLbl.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Title"];
	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Sex"] isEqualToString:@"M"]) {
		_sexSC.selectedSegmentIndex = 0;
	}
	else if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Sex"] isEqualToString:@"F"]){
		_sexSC.selectedSegmentIndex = 1;
	}
	_fullNameTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"FullName"];
	NSLog(@"name out: %@", _fullNameTF.text);
	
	//can be null
	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TelNo"] isEqualToString:@"(null)"]) {
		_telNoTF.text = @"";
	}
	else {
		_telNoTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TelNo"];
	}
	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"MobileNo"] isEqualToString:@"(null)"]) {
		_mobileTF.text = @"";
	}
	else {
		_mobileTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"MobileNo"];
	}
	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Email"] isEqualToString:@"(null)"]) {
		_emailTF.text = @"";
	}
	else {
		_emailTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Email"];
	}
	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ICNo"] isEqualToString:@"(null)"]) {
		_icNoTF.text = @"";
	}
	else {
		_icNoTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ICNo"];
	}
	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"OtherIDType"] isEqualToString:@"(null)"]) {
		OtherIDLbl.text = @"";
	}
	else {
		OtherIDLbl.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"OtherIDType"];
	}
	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"OtherID"] isEqualToString:@"(null)"]) {
		_otherIDTF.text = @"";
	}
	else {
		_otherIDTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"OtherID"];
	}
	//can be null
	
	DOBLbl.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"DOB"];
	RelationshipLbl.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Relationship"];
	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SameAddress"] isEqualToString:@"Y"]) {
		[_btnSameAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
	}
	else if([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SameAddress"] isEqualToString:@"N"]) {
		[_btnSameAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ForeignAddress"] isEqualToString:@"Y"]) {
		[_btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
	}
	else if([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ForeignAddress"] isEqualToString:@"N"]) {
		[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	_addressTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Address1"];
	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Address2"] isEqualToString:@"(null)"]) {
		_address2TF.text = @"";
	}
	else {
		_address2TF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Address2"];
	}
	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Address3"] isEqualToString:@"(null)"]) {
		_address3TF.text = @"";
	}
	else {
		_address3TF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Address3"];
	}
	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Postcode"] isEqualToString:@"(null)"]) {
		_postcodeTF.text = @"";
	}
	else {
		_postcodeTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Postcode"];
	}
	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Town"] isEqualToString:@"(null)"]) {
		_townTF.text = @"";
	}
	else {
		_townTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Town"];
	}
	if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"State"] isEqualToString:@"(null)"]) {
		_stateLbl.text = @"";
	}
	else {
		_stateLbl.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"State"];
	}
	
	_countryLbl.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Country"];
	//object end
}

- (void)viewWillAppear:(BOOL)animated
{
//    self.view.frame = CGRectMake(0, 0, 788, 1004);
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}


#pragma mark - action

- (void)btnDone:(id)sender
{
    
}

- (IBAction)btnLA1:(id)sender
{
	[[obj.eAppData objectForKey:@"SecA"] setValue:@"1" forKey:@"WhichDetails"];
    MainLA1DetailsVC *zzz = [self.storyboard instantiateViewControllerWithIdentifier:@"MainLA1Details"];
    zzz.modalPresentationStyle = UIModalPresentationPageSheet;
    zzz.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:zzz animated:NO];
}

- (IBAction)btnLA2:(id)sender
{
	[[obj.eAppData objectForKey:@"SecA"] setValue:@"2" forKey:@"WhichDetails"];
    MainLA1DetailsVC *zzz = [self.storyboard instantiateViewControllerWithIdentifier:@"MainLA1Details"];
    zzz.modalPresentationStyle = UIModalPresentationPageSheet;
    zzz.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:zzz animated:NO];
}

- (IBAction)btnPayor:(id)sender {
	[[obj.eAppData objectForKey:@"SecA"] setValue:@"3" forKey:@"WhichDetails"];
    MainLA1DetailsVC *zzz = [self.storyboard instantiateViewControllerWithIdentifier:@"MainLA1Details"];
    zzz.modalPresentationStyle = UIModalPresentationPageSheet;
    zzz.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:zzz animated:NO];
}

- (IBAction)ActionTitle:(id)sender
{
    if (_TitlePicker == nil) {
        _TitlePicker = [[TitleViewController alloc] initWithStyle:UITableViewStylePlain];
        _TitlePicker.delegate = self;
        self.TitlePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_TitlePicker];
    }
    
    [self.TitlePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)ActionOtherID:(id)sender
{
    if (_IDTypeVC == nil) {
        
        self.IDTypeVC = [[IDTypeViewController alloc] initWithStyle:UITableViewStylePlain];
        _IDTypeVC.delegate = self;
        self.IDTypePopover = [[UIPopoverController alloc] initWithContentViewController:_IDTypeVC];
    }
    
    [self.IDTypePopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)ActionDOB:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    DOBLbl.text = dateString;
	DOBLbl.textColor = [UIColor blackColor];
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

- (IBAction)ActionRelationship:(id)sender
{

    if (_RelationshipVC == nil) {

        self.RelationshipVC = [[Relationship alloc] initWithStyle:UITableViewStylePlain];
        _RelationshipVC.delegate = self;
        _RelationshipVC.requestType = @"LA";
        self.RelationshipPopover = [[UIPopoverController alloc] initWithContentViewController:_RelationshipVC];
    }
    [self.RelationshipPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)actionForPart2:(id)sender {
	isPart2Checked = !isPart2Checked;
	if(isPart2Checked) {
		[_btnPart2 setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[_btnSameAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		
		_btnTitlePO.enabled = YES;
//		titleLbl.textColor = [UIColor blackColor];
		
		_sexSC.enabled = YES;
		
//		_fullNameTF.placeholder = @"Full Name";
		_fullNameTF.enabled = YES;
		
//		_telNoTF.placeholder = @"Tel. No";
		_telNoTF.enabled = YES;
		
//		_sTelNoTF.placeholder = @"00";
		_sTelNoTF.enabled = YES;
		
//		_icNoTF.placeholder = @"New IC No";
		_icNoTF.enabled = YES;
		
//		_mobileTF.placeholder = @"Mobile";
		_mobileTF.enabled = YES;
		
//		_sMobileTF.placeholder = @"000";
		_sMobileTF.enabled = YES;
		
		_btnDOBPO.enabled = YES;
//		DOBLbl.textColor = [UIColor blackColor];
		
//		_emailTF.placeholder = @"Email";
		_emailTF.enabled = YES;
		
		_btnOtherIDTypePO.enabled = YES;
//		OtherIDLbl.textColor = [UIColor blackColor];
		
//		_otherIDTF.placeholder = @"Other ID";
//		_otherIDTF.enabled = YES;
		
//		RelationshipLbl.placeholder = @"Relationship with Life Assured";
		_btnRelationshipPO.enabled = YES;
//		RelationshipLbl.textColor = [UIColor blackColor];
		
		_btnSameAddress.enabled = YES;
		_btnForeignAddress.enabled = YES;
		
		_addressTF.enabled = YES;
		_address2TF.enabled = YES;
		_address3TF.enabled = YES;
		
//		_postcodeTF.placeholder = @"Postcode";
		_postcodeTF.enabled = YES;
		
//		_townTF.placeholder = @"Town";
		_townTF.enabled = YES;
		
//		_stateTF.placeholder = @"State";
//		_stateTF.enabled = YES;
		
		_btnCountryPO.enabled = YES;_p2 = TRUE;
	}
	else {
		[_btnPart2 setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnSameAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];

		titleLbl.text = @"";
//		titleLbl.textColor = [UIColor lightGrayColor];
		_btnTitlePO.enabled = NO;
		
		_sexSC.enabled = NO;
		_sexSC.selectedSegmentIndex = -1;

		_fullNameTF.text = @"";
		_fullNameTF.enabled = NO;

		_telNoTF.text = @"";
		_telNoTF.enabled = NO;
		
		_sTelNoTF.text = @"";
		_sTelNoTF.enabled = NO;

		_icNoTF.text = @"";
		_icNoTF.enabled = NO;

		_mobileTF.text = @"";
		_mobileTF.enabled = NO;
		
		_sMobileTF.text = @"";
		_sMobileTF.enabled = NO;
		
		DOBLbl.text = @"";
//		DOBLbl.textColor = [UIColor lightGrayColor];
		_btnDOBPO.enabled = NO;

		_emailTF.text = @"";
		_emailTF.enabled = NO;

		OtherIDLbl.text = @"";
//		OtherIDLbl.textColor = [UIColor lightGrayColor];
		_btnOtherIDTypePO.enabled = NO;

		_otherIDTF.text = @"";
		_otherIDTF.enabled = NO;

		RelationshipLbl.text = @"";
//		RelationshipLbl.textColor = [UIColor lightGrayColor];
		_btnRelationshipPO.enabled = NO;
		
		_btnSameAddress.enabled = NO;
		_btnForeignAddress.enabled = NO;

		_addressTF.text = @"";
		_addressTF.enabled = NO;
		_address2TF.text = @"";
		_address2TF.enabled = NO;
		_address3TF.text = @"";
		_address3TF.enabled = NO;

		_postcodeTF.text = @"";
		_postcodeTF.enabled = NO;
		
		_townTF.text = @"";
		_townTF.enabled = NO;
		
		_countryLbl.text = @"";
		_btnCountryPO.enabled = NO;_p2 = FALSE;
	}

}

- (IBAction)actionForSameAdd:(id)sender {
	isSameAddress = !isSameAddress;
	if(isSameAddress) {
		[_btnSameAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		
		_btnForeignAddress.enabled = NO;
		
		_addressTF.text = @"";
		_addressTF.enabled = NO;
		_address2TF.text = @"";
		_address2TF.enabled = NO;
		_address3TF.text = @"";
		_address3TF.enabled = NO;
		
		_postcodeTF.text = @"";
		_postcodeTF.enabled = NO;
		
		_townTF.text = @"";
		_townTF.enabled = NO;
		
		_stateLbl.text = @"State";
		_stateLbl.textColor = [UIColor lightGrayColor];
		
		_countryLbl.text = @"";
//		_countryLbl.textColor = [UIColor lightGrayColor];
		_btnCountryPO.enabled = NO;_sa = TRUE;
	}
	else {
		[_btnSameAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		
		_btnForeignAddress.enabled = YES;
		
		_addressTF.enabled = YES;
		_address2TF.enabled = YES;
		_address3TF.enabled = YES;
		
		//		_postcodeTF.placeholder = @"Postcode";
		_postcodeTF.enabled = YES;
		
		//		_townTF.placeholder = @"Town";
		_townTF.enabled = YES;
		
		_countryLbl.text = @"MALAYSIA";
//		_countryLbl.textColor = [UIColor blackColor];
		_btnCountryPO.enabled = YES;_sa = FALSE;
	}
}

- (IBAction)actionForForeignAdd:(id)sender {
	isForeignAddress = !isForeignAddress;
	if(isForeignAddress) {
		[_btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		
		_addressTF.enabled = YES;
		_address2TF.enabled = YES;
		_address3TF.enabled = YES;
		
		_postcodeTF.text = @"";
//		_postcodeTF.textColor = [UIColor lightGrayColor];
//		_postcodeTF.enabled = YES;
//		
		_townTF.text = @"";
//		_townTF.placeholder = @"Town";
////		_townTF.textColor = [UIColor lightGrayColor];
//		_townTF.enabled = YES;
//		
		_stateLbl.text = @"State";
		_stateLbl.textColor = [UIColor lightGrayColor];
		
//		_countryLbl.text = @"Country";
//		_countryLbl.textColor = [UIColor lightGrayColor];
		_btnCountryPO.enabled = YES;_fa = TRUE;
	}
	else {
		[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		
		_addressTF.text = @"";
		_addressTF.enabled = YES;
		_address2TF.text = @"";
		_address2TF.enabled = YES;
		_address3TF.text = @"";
		_address3TF.enabled = YES;
		
		_postcodeTF.text = @"";
		_postcodeTF.enabled = YES;
		
		_townTF.text = @"";
		_townTF.enabled = YES;
//
//		_stateLbl.text = @"State";
//		_stateLbl.textColor = [UIColor lightGrayColor];
		
		_countryLbl.text = @"MALAYSIA";
//		_countryLbl.textColor = [UIColor blackColor];
		_btnCountryPO.enabled = NO;_fa = FALSE;
	}
}

- (IBAction)actionForCountryPO:(id)sender {
	if (_CountryVC == nil) {
        self.CountryVC = [[CountryPopoverViewController alloc] initWithStyle:UITableViewStylePlain];
        _CountryVC.delegate = self;
        self.CountryPopover = [[UIPopoverController alloc] initWithContentViewController:_CountryVC];
    }
    [self.CountryPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
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
				_countryLbl.textColor = [UIColor blackColor];
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


#pragma mark - delegate

-(void)selectedIDType:(NSString *)selectedIDType
{
    OtherIDLbl.text = selectedIDType;
	OtherIDLbl.textColor =  [UIColor blackColor];
    [self.IDTypePopover dismissPopoverAnimated:YES];
	_otherIDTF.enabled = YES;
	_icNoTF.text = @"";
	_icNoTF.enabled = NO;
}

-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
    DOBLbl.text = strDate;
	DOBLbl.textColor = [UIColor blackColor];
}

-(void)CloseWindow
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [self.SIDatePopover dismissPopoverAnimated:YES];
}

-(void)selectedTitle:(NSString *)selectedTitle
{
    titleLbl.text = selectedTitle;
	titleLbl.textColor = [UIColor blackColor];
    [self.TitlePickerPopover dismissPopoverAnimated:YES];
}

-(void)selectedRelationship:(NSString *)theRelation
{
    RelationshipLbl.text = theRelation;
	RelationshipLbl.textColor = [UIColor blackColor];
    [self.RelationshipPopover dismissPopoverAnimated:YES];
}

-(void)selectedCountry:(NSString *)selectedCountry {
    _countryLbl.text = selectedCountry;
	_countryLbl.textColor = [UIColor blackColor];
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
	
	else if (textField == _telNoTF || textField == _mobileTF) {
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return ([string isEqualToString:filtered]);
	}

	return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
	
	if (textField == _postcodeTF) {
		if (!isForeignAddress) {
			_townTF.text = @"";
			_stateLbl.text = @"State";
			_stateLbl.textColor = [UIColor lightGrayColor];
			_countryLbl.text = @"MALAYSIA";
			_countryLbl.textColor = [UIColor blackColor];
		}
		else {
			_townTF.text = @"";
			_stateLbl.text = @"State";
			_stateLbl.textColor = [UIColor lightGrayColor];
			_countryLbl.text = @"Country";
			_countryLbl.textColor = [UIColor lightGrayColor];
		}
		
	}
}


#pragma mark - memory management


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTitleLbl:nil];
    [self setOtherIDLbl:nil];
    [self setDOBLbl:nil];
    [self setRelationshipLbl:nil];
    [self setCheckAddress:nil];
    [self setCheckForeign:nil];
	[self setRelationshipLbl:nil];
	[self setDOBLbl:nil];
	[self setTitleLbl:nil];
	[self setOtherIDLbl:nil];
	[self setFullNameTF:nil];
	[self setTelNoTF:nil];
	[self setIcNoTF:nil];
	[self setMobileTF:nil];
	[self setEmailTF:nil];
	[self setOtherIDTF:nil];
	[self setAddressTF:nil];
	[self setPostcodeTF:nil];
	[self setTownTF:nil];
	[self setBtnPart2:nil];
	[self setSexSC:nil];
	[self setBtnTitlePO:nil];
	[self setBtnDOBPO:nil];
	[self setBtnOtherIDTypePO:nil];
	[self setBtnRelationshipPO:nil];
	[self setSTelNoTF:nil];
	[self setSMobileTF:nil];
	[self setAddress2TF:nil];
	[self setAddress3TF:nil];
	[self setBtnSameAddress:nil];
	[self setBtnForeignAddress:nil];
	[self setStateLbl:nil];
	[self setCountryLbl:nil];
	[self setBtnCountryPO:nil];
	[self setRelationshipLbl:nil];
	[self setOtherIDLbl:nil];
	[self setDOBLbl:nil];
	[self setTitleLbl:nil];
	[self setFirstLALbl:nil];
    [self setSecondLALbl:nil];
    [self setPayorLbl:nil];
	[self setLa1cell:nil];
	[self setLa2cell:nil];
	[self setPayorcell:nil];
	[self setL1Button:nil];
	[self setL2Button:nil];
	[self setPYButton:nil];
    [super viewDidUnload];
}
@end
