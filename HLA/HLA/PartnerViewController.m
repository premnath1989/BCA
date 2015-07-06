//
//  PartnerViewController.m
//  iMobile Planner
//
//  Created by Meng Cheong on 8/30/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "PartnerViewController.h"
#import "DataClass.h"
#import "textFields.h"
#import <sqlite3.h>

#define NUMBERS_ONLY @"1234567890"

@interface PartnerViewController (){
    DataClass *obj;
    FMDatabase *db;
	NSString *databasePath;
    sqlite3 *contactDB;
	BOOL isMailCountry;
}

@end

@implementation PartnerViewController
@synthesize IDTypeCodeSelected, TitleCodeSelected;
@synthesize isEAPP;


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
    
    obj=[DataClass getInstance];
	
    NSString *eApp = [[obj.CFFData objectForKey:@"CFF"] objectForKey:@"isEAPP"];
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerReadOnly"] isEqualToString:@"1"]){
        _PartnerTitle.enabled = FALSE;
        _name.enabled = FALSE;
        _IDTypeNo.enabled = FALSE;
        _otherIDType.enabled = FALSE;
        _otherIDTypeNo.enabled = FALSE;
        _race.enabled = FALSE;
        _religion.enabled = FALSE;
        _nationality.enabled = FALSE;
        _gender.enabled = FALSE;
        _smoker.enabled = FALSE;
        _DOB.enabled = FALSE;
        _age.enabled = FALSE;
        _maritalStatus.enabled = FALSE;
        //_mailingAddressForeign.enabled = FALSE;
        //_mailingAddress1.enabled = FALSE;
        //_mailingAddress2.enabled = FALSE;
        //_mailingAddress3.enabled = FALSE;
        //_mailingAddressPostcode.enabled = FALSE;
        //_mailingAddressTown.enabled = FALSE;
        //_mailingAddressState.enabled = FALSE;
        //_mailingAddressCountry.enabled = FALSE;
        
//        _permanentAddress1.enabled = FALSE;
//        _permanentAddress2.enabled = FALSE;
//        _permanentAddress3.enabled = FALSE;
//        _permanentAddressCountry.enabled = FALSE;
//        _permanentAddressForeign.enabled = FALSE;
//        _permanentAddressTown.enabled = FALSE;
//        _permanentAddressPostcode.enabled = FALSE;
//        _permanentAddressState.enabled = FALSE;
        
		
		NSString *eApp = [[obj.CFFData objectForKey:@"CFF"] objectForKey:@"isEAPP"];
		NSLog(@"test1 %@", eApp);
		
		isEAPP = eApp;
		
		if ([eApp isEqualToString:@"Y"]){
			_residenceTel.enabled = TRUE;
			_residenceTelExt.enabled = TRUE;
			_officeTel.enabled = TRUE;
			_officeTelExt.enabled = TRUE;
			_mobileTel.enabled = TRUE;
			_mobileTelExt.enabled = TRUE;
			_fax.enabled = TRUE;
			_faxExt.enabled = TRUE;
			_email.enabled = TRUE;
			
			_residenceTel.textColor = [UIColor blackColor];
			_residenceTelExt.textColor = [UIColor blackColor];
			_officeTel.textColor = [UIColor blackColor];
			_officeTelExt.textColor = [UIColor blackColor];
			_mobileTel.textColor = [UIColor blackColor];
			_mobileTelExt.textColor = [UIColor blackColor];
			_fax.textColor = [UIColor blackColor];
			_faxExt.textColor = [UIColor blackColor];
			_email.textColor = [UIColor blackColor];
			
		}
		else {
			_residenceTel.enabled = FALSE;
			_residenceTelExt.enabled = FALSE;
			_officeTel.enabled = FALSE;
			_officeTelExt.enabled = FALSE;
			_mobileTel.enabled = FALSE;
			_mobileTelExt.enabled = FALSE;
			_fax.enabled = FALSE;
			_faxExt.enabled = FALSE;
			_email.enabled = FALSE;
		}
		
        _titlePickerBtn.hidden = TRUE;
        _otherIDTypePickerBtn.hidden = TRUE;
        _racePickerBtn.hidden = TRUE;
        _nationalityPickerBtn.hidden = TRUE;
        
        _mailingAddressCountryPickerBtn.hidden = FALSE;
        _permanentAddressCountryPickerBtn.hidden = FALSE;
    }
    
    _PartnerTitle.text = [self getTitleDesc:[textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerTitle"]]];
    _name.text = [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerName"]];
    _IDTypeNo.text = [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerNRIC"]];
    _otherIDType.text = [self getIDTypeDesc:[textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOtherIDType"]]];
	if (IDTypeCodeSelected == NULL)
	IDTypeCodeSelected = [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOtherIDType"]];
    _otherIDTypeNo.text = [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOtherID"]];
    _race.text = [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerRace"]];
    NSString *religionStr = [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerReligion"]];
    if ([religionStr hasPrefix:@"M"]){
        [_religion setSelectedSegmentIndex:0];
    }
    else if ([religionStr hasPrefix:@"NON"]){
        [_religion setSelectedSegmentIndex:1];
    }
    _nationality.text = [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerNationality"]];
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerSex"] isEqualToString:@"M"]){
        [_gender setSelectedSegmentIndex:0];
    }
    else{
        [_gender setSelectedSegmentIndex:1];
    }
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerSmoker"] isEqualToString:@"Y"]){
        [_smoker setSelectedSegmentIndex:0];
    }
    else{
        [_smoker setSelectedSegmentIndex:1];
    }
    _DOB.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerDOB"];
    
    NSString *statusTrim = [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMaritalStatus"] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([statusTrim isEqualToString:@"DIVORCED"]){
        [_maritalStatus setSelectedSegmentIndex:0];
    }
    else if ([statusTrim isEqualToString:@"MARRIED"]){
        [_maritalStatus setSelectedSegmentIndex:1];
    }
    else if ([statusTrim isEqualToString:@"SINGLE"]){
        [_maritalStatus setSelectedSegmentIndex:2];
    }
    else if ([statusTrim isEqualToString:@"WIDOW"]){
        [_maritalStatus setSelectedSegmentIndex:3];
    }
    else if ([statusTrim isEqualToString:@"WIDOWER"]){
        [_maritalStatus setSelectedSegmentIndex:4];
    }
    else {
        [_maritalStatus setSelectedSegmentIndex:-1];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressForeign"] isEqualToString:@"0"]){
        [_mailingAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        _foreignAddress = FALSE;
        _mailingAddressTown.enabled = FALSE;
        _mailingAddressState.enabled = FALSE;
//        _mailingAddressCountry.enabled = FALSE;
        _mailingAddressCountryPickerBtn.enabled = FALSE;
        _mailingAddressCountry.text = @"MALAYSIA";
        _mailingAddressCountry.textColor = [UIColor lightGrayColor];
        _mailingAddressState.textColor = [UIColor lightGrayColor];
        _mailingAddressTown.textColor = [UIColor lightGrayColor];
        _mailingAddressTown.placeholder = @"Town";
        _mailingAddressState.placeholder = @"State";
    }
    else{
        [_mailingAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        _foreignAddress = TRUE;
        _mailingAddressTown.enabled = TRUE;
        _mailingAddressState.enabled = FALSE;
        _mailingAddressCountryPickerBtn.enabled = TRUE;
        _mailingAddressCountry.textColor = [UIColor blackColor];
        _mailingAddressState.textColor = [UIColor lightGrayColor];
        _mailingAddressTown.textColor = [UIColor blackColor];
        _mailingAddressTown.placeholder = @"Town";
        _mailingAddressState.placeholder = @"";
    }
    _mailingAddress1.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress1"];
    _mailingAddress2.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress2"];
    _mailingAddress3.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress3"];
    _mailingAddressPostcode.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingPostcode"];
    _mailingAddressTown.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressTown"];
    _mailingAddressState.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressState"];
    _mailingAddressCountry.text = [self getCountryDesc:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressCountry"]];
    
    
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddressForeign"] isEqualToString:@"0"]){
        [_permanentAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        _permanentForeignAddress = FALSE;
        _permanentAddressTown.placeholder = @"Town";
        _permanentAddressState.placeholder = @"State";
    }
    else{
        [_permanentAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        _permanentForeignAddress = TRUE;
        _permanentAddressTown.placeholder = @"Town";
        _permanentAddressState.placeholder = @"";
    }

    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddress1"] isEqualToString:@"0"] || [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddress1"] isEqualToString:@""])
    {
        [_permanentAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        _permanentAddress1.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress1"];
        _permanentAddress2.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress2"];
        _permanentAddress3.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress3"];
        _permanentAddressPostcode.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingPostcode"];
        _permanentAddressTown.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressTown"];
        _permanentAddressState.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressState"];
        
        [db open];
        FMResultSet *results = [db executeQuery:@"select * from eProposal_State where StateCode = ?", [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressState"]], nil];
        while ([results next]) {
            _permanentAddressState.text = [results objectForColumnName:@"StateDesc"];
        }
        [db close];
        
        _permanentAddressCountry.text = [self getCountryDesc:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressCountry"]];
        
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressForeign"] isEqualToString:@"1"]){
            [_permanentAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            _permanentForeignAddress = TRUE;
        }
        else{
            [_permanentAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            _permanentForeignAddress = FALSE;
        }
    }
    else {
        
        _permanentAddress1.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddress1"];
        _permanentAddress2.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddress2"];
        _permanentAddress3.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddress3"];
        _permanentAddressPostcode.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentPostcode"];
        _permanentAddressTown.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddressTown"];
        _permanentAddressState.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddressState"];
		
		[db open];
        FMResultSet *results = [db executeQuery:@"select * from eProposal_State where StateCode = ?", [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddressState"]], nil];
        while ([results next]) {
            _permanentAddressState.text = [results objectForColumnName:@"StateDesc"];
        }
        [db close];
        
        _permanentAddressCountry.text = [self getCountryDesc:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddressCountry"]];
        
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddressForeign"] isEqualToString:@"1"]){
            [_permanentAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            _permanentForeignAddress = TRUE;
        }
        else{
            [_permanentAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            _permanentForeignAddress = FALSE;
        }
        
//		if ([_permanentAddress1.text isEqualToString:@""]) {
//			_permanentAddress1.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress1"];
//			_permanentAddress2.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress2"];
//			_permanentAddress3.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress3"];
//			_permanentAddressPostcode.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingPostcode"];
//			_permanentAddressTown.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressTown"];
//			_permanentAddressState.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressState"];
//			
//		}
	
        
        //     [[obj.CFFData objectForKey:@"SecC"] setValue:_permanentAddress1.text forKey:@"CustomerPermanentAddress1"];
        //     [[obj.CFFData objectForKey:@"SecC"] setValue:_permanentAddress2.text forKey:@"CustomerPermanentAddress2"];
        //     [[obj.CFFData objectForKey:@"SecC"] setValue:_permanentAddress3.text forKey:@"CustomerPermanentAddress3"];
        //     [[obj.CFFData objectForKey:@"SecC"] setValue:_permanentAddressPostCode.text forKey:@"CustomerPermanentPostcode"];
        //     [[obj.CFFData objectForKey:@"SecC"] setValue:_permanentAddressTown.text forKey:@"CustomerPermanentAddressTown"];
        //     [[obj.CFFData objectForKey:@"SecC"] setValue:_permanentAddressState.text forKey:@"CustomerPermanentAddressState"];
    }

	NSLog(@"test %@", eApp);
	
	if ([eApp isEqualToString:@"Y"]) {
		_permanentAddressForeign.enabled = TRUE;
		_permanentAddress1.enabled = TRUE;
		_permanentAddress2.enabled = TRUE;
		_permanentAddress3.enabled = TRUE;
		_permanentAddressPostcode.enabled = TRUE;
		_permanentAddressTown.enabled = TRUE;
//		_permanentAddressState.enabled = TRUE;
//		_permanentAddressCountry.enabled = TRUE;
		
		_permanentAddress1.textColor = [UIColor blackColor];
		_permanentAddress2.textColor = [UIColor blackColor];
		_permanentAddress3.textColor = [UIColor blackColor];
		_permanentAddressPostcode.textColor = [UIColor blackColor];
		_permanentAddressTown.textColor = [UIColor blackColor];
		_permanentAddressState.textColor = [UIColor blackColor];
		_permanentAddressCountry.textColor = [UIColor blackColor];
		
		_permanentAddressCountryPickerBtn.enabled = TRUE;
		
		if (_permanentForeignAddress == FALSE) {
			_permanentAddressTown.enabled = FALSE;
//			_permanentAddressState.enabled = FALSE;
//			_permanentAddressCountry.enabled = FALSE;
			
			_permanentAddressTown.textColor = [UIColor grayColor];
			_permanentAddressState.textColor = [UIColor grayColor];
			_permanentAddressCountry.textColor = [UIColor grayColor];
			
			_permanentAddressCountryPickerBtn.enabled = FALSE;
		}
	}
	else {
		_permanentAddressForeign.enabled = FALSE;
		_permanentAddress1.enabled = FALSE;
		_permanentAddress2.enabled = FALSE;
		_permanentAddress3.enabled = FALSE;
		_permanentAddressPostcode.enabled = FALSE;
		_permanentAddressTown.enabled = FALSE;
//		_permanentAddressState.enabled = FALSE;
//		_permanentAddressCountry.enabled = FALSE;
		
		_permanentAddress1.textColor = [UIColor grayColor];
		_permanentAddress2.textColor = [UIColor grayColor];
		_permanentAddress3.textColor = [UIColor grayColor];
		_permanentAddressPostcode.textColor = [UIColor grayColor];
		_permanentAddressTown.textColor = [UIColor grayColor];
		_permanentAddressState.textColor = [UIColor grayColor];
		_permanentAddressCountry.textColor = [UIColor grayColor];
		
		_permanentAddressCountryPickerBtn.enabled = FALSE;
	}
	
	
	if ([eApp isEqualToString:@"Y"]) {
		_residenceTel.enabled = TRUE;
		_residenceTelExt.enabled = TRUE;
		_officeTel.enabled = TRUE;
		_officeTelExt.enabled = TRUE;
		_mobileTel.enabled = TRUE;
		_mobileTelExt.enabled = TRUE;
		_fax.enabled = TRUE;
		_faxExt.enabled = TRUE;
		_email.enabled = TRUE;
		
		_residenceTel.textColor = [UIColor blackColor];
		_residenceTelExt.textColor = [UIColor blackColor];
		_officeTel.textColor = [UIColor blackColor];
		_officeTelExt.textColor = [UIColor blackColor];
		_mobileTel.textColor = [UIColor blackColor];
		_mobileTelExt.textColor = [UIColor blackColor];
		_fax.textColor = [UIColor blackColor];
		_faxExt.textColor = [UIColor blackColor];
		_email.textColor = [UIColor blackColor];
	}
	
	else {
		_residenceTel.enabled = FALSE;
		_residenceTelExt.enabled = FALSE;
		_officeTel.enabled = FALSE;
		_officeTelExt.enabled = FALSE;
		_mobileTel.enabled = FALSE;
		_mobileTelExt.enabled = FALSE;
		_fax.enabled = FALSE;
		_faxExt.enabled = FALSE;
		_email.enabled = FALSE;
		
		_residenceTel.textColor = [UIColor grayColor];
		_residenceTelExt.textColor = [UIColor grayColor];
		_officeTel.textColor = [UIColor grayColor];
		_officeTelExt.textColor = [UIColor grayColor];
		_mobileTel.textColor = [UIColor grayColor];
		_mobileTelExt.textColor = [UIColor grayColor];
		_fax.textColor = [UIColor grayColor];
		_faxExt.textColor = [UIColor grayColor];
		_email.textColor = [UIColor grayColor];
	}
    

    
    _residenceTelExt.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerResidenceTelExt"];
    _residenceTel.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerResidenceTel"];
    
    _officeTelExt.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOfficeTelExt"];
    _officeTel.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOfficeTel"];
	
	_mobileTelExt.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMobileTelExt"];
    _mobileTel.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMobileTel"];
    
    _faxExt.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerFaxTelExt"];
    _fax.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerFaxTel"];
    
    _email.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerEmail"];
    
    
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    [fmtDate setDateFormat:@"dd/mm/yyyy"];
    NSDate *startDate = [fmtDate dateFromString:_DOB.text];
    NSString *textDate = [NSString stringWithFormat:@"%@",[fmtDate stringFromDate:[NSDate date]]];
    NSDate *endDate = [fmtDate dateFromString:textDate];
    
    NSDateComponents* components = [[NSCalendar currentCalendar]
                                    components:NSYearCalendarUnit
                                    fromDate:startDate
                                    toDate:endDate
                                    options:0];
    
    // The year returned is always 1 year less then the actual age
    _age.text = [NSString stringWithFormat:@"%d",[components year]];
     
    _occupation.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOccupation"];
    _mailingAddress1.delegate = self;
    _mailingAddress2.delegate = self;
    _mailingAddress3.delegate = self;
    _permanentAddress1.delegate = self;
    _permanentAddress2.delegate = self;
    _permanentAddress3.delegate = self;
    _permanentAddressPostcode.delegate = self;
    _residenceTel.delegate = self;
    _residenceTelExt.delegate = self;
    _officeTel.delegate = self;
    _officeTelExt.delegate = self;
    _mobileTelExt.delegate = self;
    _mobileTel.delegate = self;
    _faxExt.delegate = self;
    _fax.delegate = self;
    _mailingAddressPostcode.delegate = self;
    _mailingAddressTown.delegate = self;
    
    fmtDate = Nil;
    components = Nil;
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    db = [FMDatabase databaseWithPath:dbPath];
    
    [db open];
    FMResultSet *results = [db executeQuery:@"select * from eProposal_State where StateCode = ?", [textFields trimWhiteSpaces:_permanentAddressState.text], nil];
    while ([results next]) {
        _permanentAddressState.text = [results objectForColumnName:@"StateDesc"];
    }
    results = [db executeQuery:@"select * from eProposal_State where StateCode = ?", [textFields trimWhiteSpaces:_mailingAddressState.text], nil];
    while ([results next]) {
        _mailingAddressState.text = [results objectForColumnName:@"StateDesc"];
    }
    [db close];
    
    _mailingAddress1.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mailingAddress2.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mailingAddress3.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mailingAddressTown.autocapitalizationType = UITextAutocapitalizationTypeWords;
	
	_permanentAddressState.enabled = FALSE;
	_mailingAddressState.enabled = FALSE;
    
    [self calculateAge];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	
	[self.view addGestureRecognizer:tap];
    
}

-(void)hideKeyboard{
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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


    [self setPartnerTitle:nil];
    [self setName:nil];
    [self setIDTypeNo:nil];
    [self setOtherIDType:nil];
    [self setOtherIDTypeNo:nil];
    [self setRace:nil];
    [self setReligion:nil];
    [self setNationality:nil];
    [self setGender:nil];
    [self setSmoker:nil];
    [self setDOB:nil];
    [self setAge:nil];
    [self setMaritalStatus:nil];
    [self setMailingAddressForeign:nil];
    [self setMailingAddress1:nil];
    [self setMailingAddress2:nil];
    [self setMailingAddress3:nil];
    [self setMailingAddressPostcode:nil];
    [self setMailingAddressTown:nil];
    [self setMailingAddressState:nil];
    [self setMailingAddressCountry:nil];
    [self setPermanentAddressForeign:nil];
    [self setPermanentAddress1:nil];
    [self setPermanentAddress2:nil];
    [self setPermanentAddress3:nil];
    [self setPermanentAddressPostcode:nil];
    [self setPermanentAddressTown:nil];
    [self setPermanentAddressState:nil];
    [self setPermanentAddressCountry:nil];
    [self setResidenceTelExt:nil];
    [self setResidenceTel:nil];
    [self setOfficeTelExt:nil];
    [self setOfficeTel:nil];
    [self setFaxExt:nil];
    [self setFax:nil];
    [self setEmail:nil];
    [self setTitlePickerBtn:nil];
    [self setOtherIDTypePickerBtn:nil];
    [self setNationalityPickerBtn:nil];
    //[self setDoNationality:nil];
    [self setMailingAddressCountryPickerBtn:nil];
    [self setPermanentAddressCountryPickerBtn:nil];
    //[self setDoPermanentAddressCountry:nil];
    [self setDoNationality:nil];
    [self setRacePickerBtn:nil];
    [self setDoPermanentAddressCountry:nil];
    [self setAge:nil];
    [self setMobileTelExt:nil];
    [self setMobileTel:nil];
    [self setOccupation:nil];
    [super viewDidUnload];
}
- (IBAction)doTitle:(id)sender
{
    
}

- (IBAction)doOtherIDType:(id)sender {
}



- (IBAction)doNationality:(id)sender {
}
- (IBAction)doPermanentAddressCountry:(id)sender {
    if (_CountryList == nil) {
        self.CountryList = [[Country alloc] initWithStyle:UITableViewStylePlain];
        _CountryList.delegate = self;
        self.CountryListPopover = [[UIPopoverController alloc] initWithContentViewController:_CountryList];
		
    }
    
    isMailCountry = NO;
    [self.CountryListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

}

- (IBAction)doMailingAddressCountry:(id)sender {
    if (_CountryList == nil) {
        self.CountryList = [[Country alloc] initWithStyle:UITableViewStylePlain];
        _CountryList.delegate = self;
        self.CountryListPopover = [[UIPopoverController alloc] initWithContentViewController:_CountryList];
    }
    
    isMailCountry = YES;
    [self.CountryListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)doRace:(id)sender {
}

- (IBAction)btnForeign:(id)sender {
    _foreignAddress = !_foreignAddress;
    if (_foreignAddress) {
        [_mailingAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        //[[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"PartnerMailingAddressForeign"];
        _mailingAddressState.enabled = FALSE;
        _mailingAddressTown.enabled = TRUE;
        _mailingAddressCountry.text = @"";
        //_mailingAddressCountry.enabled = FALSE;
        _mailingAddressCountryPickerBtn.enabled = TRUE;
        _mailingAddressState.text = @"";
        _mailingAddress1.text = @"";
        _mailingAddress2.text = @"";
        _mailingAddress3.text = @"";
        _mailingAddressPostcode.text = @"";
        _mailingAddressTown.text = @"";
        _mailingAddressCountry.text = @"";
        _mailingAddressState.textColor = [UIColor lightGrayColor];
        _mailingAddressCountry.textColor = [UIColor blackColor];
        _mailingAddressState.textColor = [UIColor blackColor];
        _mailingAddressTown.textColor = [UIColor blackColor];
        _mailingAddressCountryPickerBtn.enabled = TRUE;
        _mailingAddressState.placeholder = @"";
        _mailingAddressTown.placeholder = @"Town";
    }
    else if (!_foreignAddress) {
        [_mailingAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        //[[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerMailingAddressForeign"];
        _mailingAddressState.enabled = FALSE;
        _mailingAddressTown.enabled = FALSE;
        _mailingAddressCountry.text = @"MALAYSIA";
//        _mailingAddressCountry.enabled = FALSE;
        _mailingAddressCountryPickerBtn.enabled = FALSE;
        _mailingAddress1.text = @"";
        _mailingAddress2.text = @"";
        _mailingAddress3.text = @"";
        _mailingAddressPostcode.text = @"";
        _mailingAddressTown.text = @"";
        _mailingAddressState.text = @"";
        _mailingAddressState.textColor = [UIColor lightGrayColor];
        _mailingAddressTown.textColor = [UIColor lightGrayColor];
        _mailingAddressCountry.textColor = [UIColor lightGrayColor];
        _mailingAddressCountryPickerBtn.enabled = FALSE;
        _mailingAddressState.placeholder = @"State";
        _mailingAddressTown.placeholder = @"Town";
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}


-(IBAction)btnForeignPerm:(id)sender
{
    _permanentForeignAddress = !_permanentForeignAddress;
    if (_permanentForeignAddress) {
        [_permanentAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        //[[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"CustomerMailingAddressForeign"];
        _permanentAddressState.enabled = FALSE;
        _permanentAddressTown.enabled = TRUE;
        _permanentAddressCountry.text = @"";
        //_mailingAddressCountry.enabled = TRUE;
        _permanentAddressCountryPickerBtn.enabled = TRUE;
        _permanentAddressState.text = @"";
        _permanentAddress1.text = @"";
        _permanentAddress2.text = @"";
        _permanentAddress3.text = @"";
        _permanentAddressPostcode.text = @"";
        _permanentAddressTown.text = @"";
        _permanentAddressCountry.text = @"";
        _permanentAddressState.textColor = [UIColor lightGrayColor];
        _permanentAddressCountry.textColor = [UIColor blackColor];
        _permanentAddressState.textColor = [UIColor blackColor];
        _permanentAddressTown.textColor = [UIColor blackColor];
    //    _mailingAddressCountrySelector.enabled = TRUE;
        _permanentAddressTown.placeholder = @"Town";
        _permanentAddressState.placeholder = @"";
    }
    else if (!_permanentForeignAddress) {
        [_permanentAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        //[[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"CustomerMailingAddressForeign"];
        _permanentAddressState.enabled = FALSE;
        _permanentAddressTown.enabled = FALSE;
        _permanentAddressCountry.text = @"MALAYSIA";
//        _permanentAddressCountry.enabled = FALSE;
        _permanentAddressCountryPickerBtn.enabled = FALSE;
        _permanentAddress1.text = @"";
        _permanentAddress2.text = @"";
        _permanentAddress3.text = @"";
        _permanentAddressPostcode.text = @"";
        _permanentAddressTown.text = @"";
        _permanentAddressState.text = @"";
        _permanentAddressState.textColor = [UIColor lightGrayColor];
        _permanentAddressTown.textColor = [UIColor lightGrayColor];
        _permanentAddressCountry.textColor = [UIColor lightGrayColor];
   //     _mailingAddressCountrySelector.enabled = FALSE;
        _permanentAddressTown.placeholder = @"Town";
        _permanentAddressState.placeholder = @"State";
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}

-(void)SelectedCountry:(NSString *)theCountry
{
	if (isMailCountry)
		_mailingAddressCountry.text = theCountry;
	else
		_permanentAddressCountry.text = theCountry;
    
    [_CountryListPopover dismissPopoverAnimated:YES];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}

-(NSString*) getIDTypeDesc : (NSString*)IDtype
{
    NSString *desc;
	IDtype = [IDtype stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
	databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	
    db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT IdentityDesc FROM eProposal_identification WHERE IdentityCode = ?", IDtype];
    
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
	
    db = [FMDatabase databaseWithPath:databasePath];
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
	
    db = [FMDatabase databaseWithPath:databasePath];
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
	
    db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT TitleCode FROM eProposal_Title WHERE TitleDesc = ?", Title];
    
    while ([result next]) {
        code =[result objectForColumnName:@"TitleCode"];
    }
	
    [result close];
    [db close];
	
	TitleCodeSelected = code;
	
}

-(NSString*) getCountryCode : (NSString*)country
{
	
	if ([country isEqualToString:@""] || (country == NULL) || ([country isEqualToString:@"(NULL)"])) {
		return @"";
	}
	
    NSString *code;
    country = [country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

	db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT CountryCode FROM eProposal_Country WHERE CountryDesc = ?", country];
    
	NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        code =[result objectForColumnName:@"CountryCode"];
    }
    
    [result close];
    [db close];
    
	if (count == 0) {
		code = country;
	}
	
    return code;
    
}

-(NSString*) getCountryDesc : (NSString*)country
{
	
	if ([country isEqualToString:@""] || (country == NULL) || ([country isEqualToString:@"(NULL)"])) {
		return @"";
	}
	
    NSString *code;
    country = [country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
   
	db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT CountryDesc FROM eProposal_Country WHERE CountryCode = ?", country];
    
	NSInteger *count = 0;
    while ([result next]) {
        code =[result objectForColumnName:@"CountryDesc"];
        count = count + 1;
    }
    
    [result close];
    [db close];
    
	if (count == 0) {
		code = country;
	}
	
    return code;
    
}

-(NSString*) getStateCode : (NSString*)state
{
	if ([state isEqualToString:@""] || (state == NULL) || ([state isEqualToString:@"(NULL)"])) {
		return @"";
	}
    NSString *code;
    state = [state stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
   
	db = [FMDatabase databaseWithPath:databasePath];
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

    db = [FMDatabase databaseWithPath:databasePath];
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

#pragma mark - textfield delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _mailingAddress1 || textField == _mailingAddress2 || textField == _mailingAddress3) {
        if (range.location >= 30)
            return NO; // return NO to not change text
    }
    
    if (textField == _permanentAddress1 || textField == _permanentAddress2 || textField == _permanentAddress3) {
        if (range.location >= 30)
            return NO; // return NO to not change text
    }
    if (textField == _residenceTelExt || textField == _officeTelExt || textField == _mobileTelExt || textField == _faxExt) {
        if (range.location >= 4) {
            return NO;
        }
    }
    if (textField == _residenceTel || textField == _officeTel || textField == _mobileTel || textField == _fax) {
        if (range.location >= 10) {
            return NO;
        }
    }
    if (textField == _mailingAddressPostcode)
    {
        NSLog(@"Changing1_numb");
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if (_foreignAddress)
        {
            return ((newLength <= 12));
        }
        return (([string isEqualToString:filtered])&&(newLength <= 5));
    }
    
    if (textField == _permanentAddressPostcode)
        
    {
        NSLog(@"Changing_numb");
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if (_permanentForeignAddress)
        {
            return ((newLength <= 12));
        }
        return (([string isEqualToString:filtered])&&(newLength <= 5));
    }

    if (textField == _mailingAddressTown) {
        if (range.location >= 40 && _foreignAddress) {
            return NO;
        }
    }
    
    if (textField == _permanentAddressTown) {
        if (range.location >= 40 && _permanentForeignAddress) {
            return NO;
        }
    }
    if (textField == _email) {
        if (range.location >= 40) {
            return NO;
        }
    }
	else if (textField == _residenceTel) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= 10));
    }
	else if (textField == _residenceTelExt) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= 4));
    }
	else if (textField == _officeTel) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= 10));
    }
	else if (textField == _officeTelExt) {
        NSUInteger newLengt = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLengt <= 4));
    }
	else if (textField == _mobileTel) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= 10));
    }
	else if (textField == _mobileTelExt) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= 4));
    }
	else if (textField == _fax) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= 10));
    }
	else if (textField == _faxExt) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= 4));
    }
	
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
    return YES;
}

/*-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _mailingAddressPostcode && !_foreignAddress && textField.text.length == 5) {
        [db open];
        FMResultSet *result = [db executeQuery:@"SELECT Town, Statedesc, b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = ?", textField.text];
        while ([result next]) {
            _mailingAddressTown.text = [result objectForColumnName:@"Town"];
            _mailingAddressState.text = [result objectForColumnName:@"Statedesc"];
            if (!_foreignAddress) {
                _mailingAddressCountry.text = @"MALAYSIA";
            }
            else if (_foreignAddress) {
                _mailingAddressCountry.text = @"";
            }
        }
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}
*/
#pragma mark - age formula
-(void)calculateAge {
    
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    [fmtDate setDateFormat:@"dd/MM/yyyy"];
    NSString *textDate = [NSString stringWithFormat:@"%@",[fmtDate stringFromDate:[NSDate date]]];
    
    NSArray *curr = [textDate componentsSeparatedByString: @"/"];
    NSString *currentDay = [curr objectAtIndex:0];
    NSString *currentMonth = [curr objectAtIndex:1];
    NSString *currentYear = [curr objectAtIndex:2];
    
    NSArray *foo = [_DOB.text componentsSeparatedByString: @"/"];
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
    if (yearN > yearB)
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
        _age.text = msgAge;
    }
}
- (IBAction)postcodeChanged:(UITextField *)sender
{
	if (_foreignAddress) {
		return;
	}
	if (sender.text.length < 5) {
		_mailingAddressTown.text = @"";
		_mailingAddressState.text = @"";
		return;
	}
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT Town, Statedesc, b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = ?", sender.text];
    _mailingAddressTown.text = @"";
    _mailingAddressState.text = @"";
    while ([result next]) {
        _mailingAddressTown.text = [result objectForColumnName:@"Town"];
        _mailingAddressState.text = [result objectForColumnName:@"Statedesc"];
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressForeign"] isEqualToString:@"0"])
        {
            _mailingAddressCountry.text = @"MALAYSIA";
        }
    }
    [db close];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}

- (IBAction)PermanentpostcodeChanged:(UITextField *)sender
{
    NSLog(@"poscode");
	if (_permanentForeignAddress) {
		return;
	}
	if (sender.text.length < 5)
    {
		_permanentAddressTown.text = @"";
		_permanentAddressState.text = @"";
		return;
	}
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT Town, Statedesc, b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = ?", sender.text];
    _permanentAddressTown.text = @"";
    _permanentAddressState.text = @"";
    while ([result next]) {
        _permanentAddressTown.text = [result objectForColumnName:@"Town"];
        _permanentAddressState.text = [result objectForColumnName:@"Statedesc"];
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressForeign"] isEqualToString:@"0"])
        {
            _permanentAddressCountry.text = @"MALAYSIA";
        }
    }
    [db close];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}


@end
