//
//  CustomerViewController.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/5/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "CustomerViewController.h"
#import "ColorHexCode.h"
#import "DataClass.h"
#import "textFields.h"
#import <sqlite3.h>

#define NUMBERS_ONLY @"1234567890"

@interface CustomerViewController ()
{
    DataClass *obj;
    FMDatabase *db;
	NSString *databasePath;
    sqlite3 *contactDB;
	BOOL isMailCountry;
}

@end

@implementation CustomerViewController

@synthesize btn1;
@synthesize IDTypeCodeSelected;
@synthesize TitleCodeSelected;

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

//    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docsDir = [dirPaths objectAtIndex:0];
//    NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
//    db = [FMDatabase databaseWithPath:dbPath];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //UIColor *tintColor = [UIColor colorWithRed:195/255.0f green:212/255.0f blue:255/255.0f alpha:1];
    //[self.navigationController.navigationBar setTintColor:tintColor];
    /*
	ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"Customer";
    self.navigationItem.titleView = label;
     */
    obj=[DataClass getInstance];
    
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerReadOnly"] isEqualToString:@"1"]){
        _prospectTitle.enabled = FALSE;
        _prospectName.enabled = FALSE;
        _IDTypeNo.enabled = FALSE;
        _otherIDType.enabled = FALSE;
        _OtherIDTypeNo.enabled = FALSE;
        _race.enabled = FALSE;
        _religion.enabled = FALSE;
        _nationality.enabled = FALSE;
        _gender.enabled = FALSE;
        _smoker.enabled = FALSE;
        _DOB.enabled = FALSE;
        _age.enabled = FALSE;
        _maritalStatus.enabled = FALSE;
//        _mailingAddressForeign.enabled = FALSE;
//        _mailingAddress1.enabled = FALSE;
//        _mailingAddress2.enabled = FALSE;
//        _mailingAddress3.enabled = FALSE;
//        _PostCode.enabled = FALSE;
//        _Town.enabled = FALSE;
//        _mailingAddressState.enabled = FALSE;
//        _mailingAddressCountry.enabled = FALSE;
        
        _titlePickerBtn.hidden = TRUE;
        _otherIDTypePickerBtn.hidden = TRUE;
        _racePickerBtn.hidden = TRUE;
        _nationalityPickerBtn.hidden = TRUE;
//        _mailingCountryPickerBtn.hidden = TRUE;
//        _permanentCountryPickerBtn.hidden = TRUE;
        
        
        //NSLog(@"Imhere");
    }
	
	//fix for bug 2494 start
    NSString *titleTrim = [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerTitle"] stringByReplacingOccurrencesOfString:@" " withString:@""];
	
	if ([titleTrim isEqualToString:@"- SELECT -"]) {
		_prospectTitle.text = @"";
	}
	else {
		_prospectTitle.text = [self getTitleDesc:[textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerTitle"]]];
		TitleCodeSelected = [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerTitle"]];
	}
	
    _prospectName.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerName"];
    _IDTypeNo.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerNRIC"];
    _otherIDType.text = [self getIDTypeDesc:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerOtherIDType"]];
	if (IDTypeCodeSelected == NULL) 
	IDTypeCodeSelected = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerOtherIDType"];
	
    _OtherIDTypeNo.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerOtherID"];
	NSString *raceTrim = [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerRace"] stringByReplacingOccurrencesOfString:@" " withString:@""];
	if ([raceTrim isEqualToString:@"- SELECT -"]) {
		_race.text = @"";
	}
	else {
		_race.text = [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerRace"]];
	}
	
	NSString *relTrim = [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerReligion"] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([relTrim isEqualToString:@"NON-MUSLIM"]){
        [_religion setSelectedSegmentIndex:1];
    }
    else if ([relTrim isEqualToString:@"- SELECT -"]){
        [_religion setSelectedSegmentIndex:-1];
    }
	else{
		[_religion setSelectedSegmentIndex:0];
	}
	
	NSString *nationTrim = [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerNationality"] stringByReplacingOccurrencesOfString:@" " withString:@""];
	if ([nationTrim isEqualToString:@"- SELECT -"]) {
		_nationality.text = @"";
	}
	else {
		_nationality.text = [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerNationality"]];
	}
	
	NSString *sexTrim = [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerSex"] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([sexTrim isEqualToString:@"MALE"]){
        [_gender setSelectedSegmentIndex:0];
    }
    else if ([sexTrim isEqualToString:@"(null)"]){
        [_gender setSelectedSegmentIndex:-1];
    }
	else {
		[_gender setSelectedSegmentIndex:1];
	}
	
	NSString *smokerTrim = [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerSmoker"] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([smokerTrim isEqualToString:@"Y"]){
        [_smoker setSelectedSegmentIndex:0];
    }
    else if ([smokerTrim isEqualToString:@"(null)"]){
        [_smoker setSelectedSegmentIndex:-1];
    }
	else if ([smokerTrim isEqualToString:@"N"]){
		[_smoker setSelectedSegmentIndex:1];
	}
	
	NSString *dobTrim = [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerDOB"] stringByReplacingOccurrencesOfString:@" " withString:@""];
	if ([dobTrim isEqualToString:@"-Select-"]) {
		_DOB.text = @"";
	}
	else {
		_DOB.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerDOB"];
	}
	
	NSString *statusTrim = [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMaritalStatus"] stringByReplacingOccurrencesOfString:@" " withString:@""];
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
	else if ([statusTrim isEqualToString:@"- SELECT -"]){
        [_maritalStatus setSelectedSegmentIndex:-1];
    }
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressForeign"] isEqualToString:@"1"]){
        [_mailingAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        _foreignAddress = TRUE;
        _Town.enabled = TRUE;
        //_mailingAddressCountry.enabled = TRUE;
        _mailingCountryPickerBtn.enabled = TRUE;
        _mailingAddressState.textColor = [UIColor lightGrayColor];
        _Town.textColor = [UIColor blackColor];
        _mailingAddressCountry.textColor = [UIColor blackColor];
        _mailingAddressState.placeholder = @"";
        _Town.placeholder = @"Town";
    }
    else{
        [_mailingAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        _foreignAddress = FALSE;
        _mailingAddressState.enabled = FALSE;
        _Town.enabled = FALSE;
        _mailingAddressCountry.text = @"MALAYSIA";
        _mailingAddressCountry.enabled = FALSE;
        _mailingCountryPickerBtn.enabled = FALSE;
        _mailingAddressState.textColor = [UIColor lightGrayColor];
        _Town.textColor = [UIColor lightGrayColor];
        _mailingAddressCountry.textColor = [UIColor lightGrayColor];
        _mailingAddressState.placeholder = @"State";
        _Town.placeholder = @"Town";
    }
    _mailingAddress1.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress1"];
    _mailingAddress2.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress2"];
    _mailingAddress3.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress3"];
    _PostCode.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingPostcode"];
    _Town.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressTown"];
    
    _mailingAddressState.text = [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressState"]];
    [db open];
    FMResultSet *results = [db executeQuery:@"select * from eProposal_State where StateCode = ?", [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressState"]], nil];
    while ([results next]) {
        _mailingAddressState.text = [results objectForColumnName:@"StateDesc"];
    }
    [db close];
    
    _mailingAddressCountry.text = [self getCountryDesc:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressCountry"]];
        
    _mailingAddressState.enabled = FALSE;
    
    
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressForeign"] isEqualToString:@"1"]){
        [_permanentAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        _permanentForeignAddress = TRUE;
        _permanentAddressTown.placeholder = @"Town";
        _permanentAddressState.placeholder = @"";
    }
    else{
        [_permanentAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        _permanentForeignAddress = FALSE;
        _permanentAddressTown.placeholder = @"Town";
        _permanentAddressState.placeholder = @"State";
    }
	//fix for bug 2494 end
	
	
	//NSLog(@"address %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressForeign"]);
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddress1"] isEqualToString:@""] || [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddress1"] == nil)
    {
        _permanentAddress1.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress1"];
        _permanentAddress2.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress2"];
        _permanentAddress3.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress3"];
        _permanentAddressPostCode.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingPostcode"];
        _permanentAddressTown.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressTown"];
        _permanentAddressState.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressState"];
        
        [db open];
        FMResultSet *results = [db executeQuery:@"select * from eProposal_State where StateCode = ?", [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressState"]], nil];
        while ([results next]) {
            _permanentAddressState.text = [results objectForColumnName:@"StateDesc"];
        }
        [db close];
        
        _permanentAddressCountry.text = [self getCountryDesc:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressCountry"]];
        
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressForeign"] isEqualToString:@"1"]){
            [_permanentAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            _permanentForeignAddress = TRUE;
        }
        else{
            [_permanentAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            _permanentForeignAddress = FALSE;
        }
    }
    else {

        _permanentAddress1.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddress1"];
        _permanentAddress2.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddress2"];
        _permanentAddress3.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddress3"];
        _permanentAddressPostCode.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentPostcode"];
        _permanentAddressTown.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressTown"];
        _permanentAddressState.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressState"];
        _permanentAddressCountry.text= [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressCountry"];
		
        [db open];
        FMResultSet *results = [db executeQuery:@"select * from eProposal_State where StateCode = ?", [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressState"]], nil];
        while ([results next]) {
            _permanentAddressState.text = [results objectForColumnName:@"StateDesc"];
        }
        [db close];
        
        _permanentAddressCountry.text = [self getCountryDesc:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressCountry"]];
        
//        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressForeign"] isEqualToString:@"1"]){
//            [_permanentAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
//            [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"CustomerPermanentAddressForeign"];
//            _permanentForeignAddress = TRUE;
//        }
//        else{
//            [_permanentAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
//            [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"CustomerPermanentAddressForeign"];
//            _permanentForeignAddress = FALSE;
//        }

	
    }
	
    _ResidenceTelExt.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ResidenceTelExt"];
    _ResidenceTel.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ResidenceTel"];
    
    _OfficeTelExt.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"OfficeTelExt"];
    _OfficeTel.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"OfficeTel"];
    
	//fix for bug 2646 start
	_MobileTelExt.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"MobileTelExt"];
	_MobileTel.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"MobileTel"];
	//fix for bug 2646 end
	
    _FaxExt.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"FaxTelExt"];
    _Fax.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"FaxTel"];
    
    _Email.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Email"];
    
	NSString *eApp = [[obj.CFFData objectForKey:@"CFF"] objectForKey:@"isEAPP"];
	//NSLog(@"test %@", eApp);
	
//	_permanentAddressForeign.enabled = TRUE;
//	_permanentAddress1.enabled = TRUE;
//	_permanentAddress2.enabled = TRUE;
//	_permanentAddress3.enabled = TRUE;
//	_permanentAddressPostCode.enabled = TRUE;
//	_permanentAddressTown.enabled = TRUE;
//	_permanentAddressState.enabled = TRUE;
//	_permanentAddressCountry.enabled = TRUE;
//	
//	_permanentAddress1.textColor = [UIColor blackColor];
//	_permanentAddress2.textColor = [UIColor blackColor];
//	_permanentAddress3.textColor = [UIColor blackColor];
//	_permanentAddressPostCode.textColor = [UIColor blackColor];
//	_permanentAddressTown.textColor = [UIColor blackColor];
//	_permanentAddressState.textColor = [UIColor blackColor];
//	_permanentAddressCountry.textColor = [UIColor blackColor];
	
	if ([eApp isEqualToString:@"Y"]) {
		_permanentAddressForeign.enabled = TRUE;
		_permanentAddress1.enabled = TRUE;
		_permanentAddress2.enabled = TRUE;
		_permanentAddress3.enabled = TRUE;
		_permanentAddressPostCode.enabled = TRUE;
		_permanentAddressTown.enabled = TRUE;
		_permanentAddressState.enabled = TRUE;
		//_permanentAddressCountry.enabled = TRUE;
		
		_permanentAddress1.textColor = [UIColor blackColor];
		_permanentAddress2.textColor = [UIColor blackColor];
		_permanentAddress3.textColor = [UIColor blackColor];
		_permanentAddressPostCode.textColor = [UIColor blackColor];
		_permanentAddressTown.textColor = [UIColor blackColor];
		_permanentAddressState.textColor = [UIColor blackColor];
		_permanentAddressCountry.textColor = [UIColor blackColor];
		
		_permanentCountryPickerBtn.enabled = TRUE;
		
		if (_permanentForeignAddress == FALSE) {
			_permanentAddressTown.enabled = FALSE;
			_permanentAddressState.enabled = FALSE;
			//_permanentAddressCountry.enabled = FALSE;
			
			_permanentAddressTown.textColor = [UIColor grayColor];
			_permanentAddressState.textColor = [UIColor grayColor];
			_permanentAddressCountry.textColor = [UIColor grayColor];
			
			_permanentCountryPickerBtn.enabled = FALSE;
		}
	}
	else {
		_permanentAddressForeign.enabled = FALSE;
		_permanentAddress1.enabled = FALSE;
		_permanentAddress2.enabled = FALSE;
		_permanentAddress3.enabled = FALSE;
		_permanentAddressPostCode.enabled = FALSE;
		_permanentAddressTown.enabled = FALSE;
		_permanentAddressState.enabled = FALSE;
		//_permanentAddressCountry.enabled = FALSE;
		
		_permanentAddress1.textColor = [UIColor grayColor];
		_permanentAddress2.textColor = [UIColor grayColor];
		_permanentAddress3.textColor = [UIColor grayColor];
		_permanentAddressPostCode.textColor = [UIColor grayColor];
		_permanentAddressTown.textColor = [UIColor grayColor];
		_permanentAddressState.textColor = [UIColor grayColor];
		_permanentAddressCountry.textColor = [UIColor grayColor];
		
		_permanentCountryPickerBtn.enabled = FALSE;
	}
	
	if ([eApp isEqualToString:@"Y"]){
		_ResidenceTel.enabled = TRUE;
		_ResidenceTelExt.enabled = TRUE;
		_OfficeTel.enabled = TRUE;
		_OfficeTelExt.enabled = TRUE;
		_MobileTel.enabled = TRUE;
		_MobileTelExt.enabled = TRUE;
		_Fax.enabled = TRUE;
		_FaxExt.enabled = TRUE;
		_Email.enabled = TRUE;
		
		_ResidenceTel.textColor = [UIColor blackColor];
		_ResidenceTelExt.textColor = [UIColor blackColor];
		_OfficeTel.textColor = [UIColor blackColor];
		_OfficeTelExt.textColor = [UIColor blackColor];
		_MobileTel.textColor = [UIColor blackColor];
		_MobileTelExt.textColor = [UIColor blackColor];
		_Fax.textColor = [UIColor blackColor];
		_FaxExt.textColor = [UIColor blackColor];
		_Email.textColor = [UIColor blackColor];
	}
	else {
		_ResidenceTel.enabled = FALSE;
		_ResidenceTelExt.enabled = FALSE;
		_OfficeTel.enabled = FALSE;
		_OfficeTelExt.enabled = FALSE;
		_MobileTel.enabled = FALSE;
		_MobileTelExt.enabled = FALSE;
		_Fax.enabled = FALSE;
		_FaxExt.enabled = FALSE;
		_Email.enabled = FALSE;
		
		_ResidenceTel.textColor = [UIColor grayColor];
		_ResidenceTelExt.textColor = [UIColor grayColor];
		_OfficeTel.textColor = [UIColor grayColor];
		_OfficeTelExt.textColor = [UIColor grayColor];
		_MobileTel.textColor = [UIColor grayColor];
		_MobileTelExt.textColor = [UIColor grayColor];
		_Fax.textColor = [UIColor grayColor];
		_FaxExt.textColor = [UIColor grayColor];
		_Email.textColor = [UIColor grayColor];
	}

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
    
    _age.text = [NSString stringWithFormat:@"%d",[components year]];
    
    _occupation.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerOccupation"];
    
    _mailingAddress1.delegate = self;
    _mailingAddress2.delegate = self;
    _mailingAddress3.delegate = self;
    _permanentAddress1.delegate = self;
    _permanentAddress2.delegate = self;
    _permanentAddress3.delegate = self;
    _permanentAddressPostCode.delegate = self;
    _PostCode.delegate = self;
	_ResidenceTel.delegate = self;
	_ResidenceTelExt.delegate = self;
	_OfficeTel.delegate = self;
	_OfficeTelExt.delegate = self;
	_MobileTel.delegate = self;
	_MobileTelExt.delegate = self;
	_Fax.delegate = self;
	_FaxExt.delegate = self;
	_Email.delegate = self;
    
    fmtDate = Nil;
    components = Nil;

	_mailAddressCountry.enabled = FALSE;
	_mailingAddressState.enabled = FALSE;
	_permanentAddressCountry.enabled = FALSE;
	_permanentAddressState.enabled = FALSE;
	
    //_mailingAddressForeign
    
    _mailingAddress1.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mailingAddress2.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _mailingAddress3.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _Town.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _permanentAddress1.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _permanentAddress2.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _permanentAddress3.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _permanentAddressTown.autocapitalizationType = UITextAutocapitalizationTypeWords;

    [self calculateAge];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	
	[self.view addGestureRecognizer:tap];
	
	//[self.permanentAddressPostCode addTarget:self action:@selector(PermanentpostChanged) forControlEvents:UIControlEventEditingDidBegin];
    
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



- (IBAction)CustomerViewClose:(id)sender {
    //NSLog(@"call delegate");
    //[self.delegate addedCustomerDisplay:@"Display"];
    [self dismissViewControllerAnimated:TRUE completion:Nil];
}

- (IBAction)doCancel:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:Nil];
}

- (IBAction)MailingAddressChanged:(id)sender {
    if (self.mailingAddress.selectedSegmentIndex == 0) {
        //_mailAddressPostcode.text = @"";
        
        //_mailAddressTown.enabled = false;
        //_mailAddressTown.placeholder = @"Auto Populate from Postcode";
        
        //_mailAddressCountry.text = @"MALAYSIA";
        //_mailingAddressCountrySelector.hidden = true;
    
    }
    else{
        //_mailAddressPostcode.text = @"";
        
        //_mailAddressTown.enabled = true;
        //_mailAddressTown.placeholder = @"Town";
        
        //_mailAddressCountry.text = @"";
        //_mailingAddressCountrySelector.hidden = false;
        
    }
    /*
    if (self.mailingAddress.selectedSegmentIndex == 0) {
        _mailAddress1.text = @"43, Jalan Rejang 3";
        _mailAddress1.enabled = FALSE;
        _mailAddress1.borderStyle = UITextBorderStyleNone;
        
        _mailAddress2.text = @"Setapak Jaya";
        _mailAddress2.enabled = FALSE;
        _mailAddress2.borderStyle = UITextBorderStyleNone;
        
        _mailAddress3.text = @"Kuala Lumpur";
        _mailAddress3.enabled = FALSE;
        _mailAddress3.borderStyle = UITextBorderStyleNone;
        
        _mailAddressPostcode.text = @"53300";
        _mailAddressPostcode.enabled = FALSE;
        _mailAddressPostcode.borderStyle = UITextBorderStyleNone;
        _mailAddressPostcode.textColor = [UIColor scrollViewTexturedBackgroundColor];
        
        _mailAddressTown.text = @"KUALA LUMPUR";
        _mailAddressTown.enabled = FALSE;
        _mailAddressTown.borderStyle = UITextBorderStyleNone;
        _mailAddressTown.textColor = [UIColor scrollViewTexturedBackgroundColor];
        
        _mailAddressCountry.text = @"MALAYSIA";
        _mailAddressCountry.enabled = FALSE;
        _mailAddressCountry.borderStyle = UITextBorderStyleNone;
        _mailAddressCountry.textColor = [UIColor scrollViewTexturedBackgroundColor];
    
    } else {
        _mailAddress1.text = @"";
        _mailAddress1.enabled = TRUE;
        _mailAddress1.borderStyle = UITextBorderStyleLine;
        
        _mailAddress2.text = @"";
        _mailAddress2.enabled = TRUE;
        _mailAddress2.borderStyle = UITextBorderStyleLine;
        
        _mailAddress3.text = @"";
        _mailAddress3.enabled = TRUE;
        _mailAddress3.borderStyle = UITextBorderStyleLine;
        
        _mailAddressPostcode.text = @"";
        _mailAddressPostcode.enabled = TRUE;
        _mailAddressPostcode.borderStyle = UITextBorderStyleLine;
        _mailAddressPostcode.textColor = [UIColor blackColor];
        
        _mailAddressTown.text = @"";
        _mailAddressTown.enabled = TRUE;
        _mailAddressTown.borderStyle = UITextBorderStyleLine;
        _mailAddressTown.textColor = [UIColor blackColor];
        
        _mailAddressCountry.text = @"";
        //_mailAddressCountry.enabled = TRUE;
        //_mailAddressCountry.borderStyle = UITextBorderStyleLine;
        _mailAddressCountry.textColor = [UIColor blackColor];
    }
     */
    
}
- (void)viewDidUnload {
    [self setMailAddress1:nil];
    [self setMailAddress2:nil];
    [self setMailAddress3:nil];
    [self setMailAddressPostcode:nil];
    [self setMailAddressTown:nil];
    [self setMailAddressPostcode:nil];
    [self setMailAddressTown:nil];
    [self setMailAddressCountry:nil];
    [self setMailingAddress:nil];
    [self setMailingAddressCountrySelector:nil];
    [self setPersonalDetailsTitle:nil];
    [self setOtherIDType:nil];
    [self setRace:nil];
    [self setNationality:nil];
    [self setBtn1:nil];
    [self setMailingAddressCountrySelector:nil];
    [self setProspectTitle:nil];
    [self setProspectName:nil];
    //[self setIDTYpeNo:nil];
    [self setIDTypeNo:nil];
    [self setOtherIDTypeNo:nil];
    [self setReligion:nil];
    [self setGender:nil];
    [self setSmoker:nil];
    [self setDOB:nil];
    [self setAge:nil];
    [self setMaritalStatus:nil];
    [self setMailingAddressForeign:nil];
    [self setMailingAddress1:nil];
    [self setMailingAddress2:nil];
    [self setMailingAddress3:nil];
    [self setMailingAddressState:nil];
    [self setMailingAddressCountry:nil];
    [self setPermanentAddressForeign:nil];
    [self setPermanentAddress1:nil];
    [self setPermanentAddress2:nil];
    [self setPermanentAddress3:nil];
    [self setPermanentAddressPostCode:nil];
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
    [self setPostCode:nil];
    [self setTown:nil];
    [self setTitlePickerBtn:nil];
    [self setOtherIDTypePickerBtn:nil];
    [self setRacePickerBtn:nil];
    [self setNationalityPickerBtn:nil];
    [self setMailingCountryPickerBtn:nil];
    [self setPermanentCountryPickerBtn:nil];
    [self setMobileTelExt:nil];	
    [self setMobileTel:nil];
    [self setOccupation:nil];
    [self setForeignPermanentButton:nil];
    [super viewDidUnload];
}

-(void)selectedTitleType:(NSString *)selectedTitleType{
    [_PersonalDetailsTitle setText:selectedTitleType];
    
    if (_TitleTypePickerPopover) {
        [_TitleTypePickerPopover dismissPopoverAnimated:YES];
        _TitleTypePickerPopover = nil;
    }
}


- (IBAction)doPersonalDetailsTitle:(id)sender {
    if (_TitleTypePicker == nil) {
        _TitleTypePicker = [[TitlePopoverViewController alloc] initWithStyle:UITableViewStylePlain];
        _TitleTypePicker.delegate = self;
    }
    
    if (_TitleTypePickerPopover == nil) {
        
        _TitleTypePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_TitleTypePicker];
        [_TitleTypePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    } else {
        [_TitleTypePickerPopover dismissPopoverAnimated:YES];
        _TitleTypePickerPopover = nil;
    }

}

-(void)selectedOtherIDType:(NSString *)selectedOtherIDType{
    [_otherIDType setText:selectedOtherIDType];
    
    if (_OtherIDTypePickerPopover) {
        [_OtherIDTypePickerPopover dismissPopoverAnimated:YES];
        _OtherIDTypePickerPopover = nil;
    }
}

- (IBAction)doOtherIDType:(id)sender {
    if (_OtherIDTypePicker == nil) {
        _OtherIDTypePicker = [[OtherIDPopoverViewController alloc] initWithStyle:UITableViewStylePlain];
        _OtherIDTypePicker.delegate = self;
    }
    
    if (_OtherIDTypePickerPopover == nil) {
        
        _OtherIDTypePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_OtherIDTypePicker];
        [_OtherIDTypePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    } else {
        [_OtherIDTypePickerPopover dismissPopoverAnimated:YES];
        _OtherIDTypePickerPopover = nil;
    }

}
- (IBAction)doRace:(id)sender {
    if (_RaceTypePicker == nil) {
        _RaceTypePicker = [[RacePopoverViewController alloc] initWithStyle:UITableViewStylePlain];
        _RaceTypePicker.delegate = self;
    }
    
    if (_RaceTypePickerPopover == nil) {
        
        _RaceTypePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_RaceTypePicker];
        [_RaceTypePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    } else {
        [_RaceTypePickerPopover dismissPopoverAnimated:YES];
        _RaceTypePickerPopover = nil;
    }
}

-(void)selectedRace:(NSString *)selectedRace {
    [_race setText:selectedRace];
    
    if (_RaceTypePickerPopover) {
        [_RaceTypePickerPopover dismissPopoverAnimated:YES];
        _RaceTypePickerPopover = nil;
    }
}

-(void)selectedNationality:(NSString *)selectedNationality {
    [_nationality setText:selectedNationality];
    
    if (_NationalityTypePickerPopover) {
        [_NationalityTypePickerPopover dismissPopoverAnimated:YES];
        _NationalityTypePickerPopover = nil;
    }
}

- (IBAction)doNation:(id)sender {
    if (_CountryList == nil) {
        self.CountryList = [[Country alloc] initWithStyle:UITableViewStylePlain];
        _CountryList.delegate = self;
        self.CountryListPopover = [[UIPopoverController alloc] initWithContentViewController:_CountryList];
    }
    
    isMailCountry = NO;
    [self.CountryListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


- (IBAction)doPermanentAddressCountry:(id)sender {
    if (_CountryList == nil) {
        self.CountryList = [[Country alloc] initWithStyle:UITableViewStylePlain];
        _CountryList.delegate = self;
        self.CountryListPopover = [[UIPopoverController alloc] initWithContentViewController:_CountryList];
    }
    
    
    [self.CountryListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

- (IBAction)clickBtn1:(id)sender {
    btn1.selected = !btn1.selected;
	if (btn1.selected) {
		[btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        _foreignAddress = TRUE;
	}
	else {
		[btn1 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        _foreignAddress = FALSE;
	}
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}

- (IBAction)doCountry:(id)sender {
    //NSLog(@"do country");
    if (_CountryTypePicker == nil) {
        _CountryTypePicker = [[CountryPopoverViewController alloc] initWithStyle:UITableViewStylePlain];
        _CountryTypePicker.delegate = self;
    }
    
    if (_CountryTypePickerPopover == nil) {
        
        _CountryTypePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_CountryTypePicker];
        [_CountryTypePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    } else {
        [_CountryTypePickerPopover dismissPopoverAnimated:YES];
        _CountryTypePickerPopover = nil;
    }
}

-(void)selectedCountry:(NSString *)selectedCountry
{
    //NSLog(@"selectCountry");
    [_mailAddressCountry setText:selectedCountry];
    [_permanentAddressCountry setText:selectedCountry];
    
    if (_CountryTypePickerPopover) {
        [_CountryTypePickerPopover dismissPopoverAnimated:YES];
        _CountryTypePickerPopover = nil;
    }
}



- (IBAction)PostCode:(id)sender
{
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

#pragma mark - textfield delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _mailingAddress1 || textField == _mailingAddress2 || textField == _mailingAddress3)
    {
        if (range.location >= 30)
            return NO; // return NO to not change text
    }
    
    if (textField == _permanentAddress1 || textField == _permanentAddress2 || textField == _permanentAddress3)
    {
        if (range.location >= 30)
            return NO; // return NO to not change text
    }

    else if (textField == _PostCode) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if (_foreignAddress) {
            return ((newLength <= 12));
        }
        return (([string isEqualToString:filtered])&&(newLength <= 5));
    }
    
    else if (textField == _permanentAddressPostCode)
        
    {
        //NSLog(@"_permanentAddressPostcode");
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if (_permanentForeignAddress)
        {
            return ((newLength <= 12));
        }
        return (([string isEqualToString:filtered])&&(newLength <= 5));
        
        
    }
	else if (textField == _ResidenceTel) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= 10));
    }
	else if (textField == _ResidenceTelExt) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= 4));
    }
	else if (textField == _OfficeTel) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= 10));
    }
	else if (textField == _OfficeTelExt) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= 4));
    }
	else if (textField == _MobileTel) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= 10));
    }
	else if (textField == _MobileTelExt) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= 4));
    }
	else if (textField == _Fax) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= 10));
    }
	else if (textField == _FaxExt) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= 4));
    }
	

	//_Email.enabled = TRUE;
	
	
	
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
    return YES;
}

/*-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _PostCode && !_foreignAddress && textField.text.length == 5) {
        [db open];
        FMResultSet *result = [db executeQuery:@"SELECT Town, Statedesc, b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = ?", textField.text];
        while ([result next]) {
            _Town.text = [result objectForColumnName:@"Town"];
            _mailingAddressState.text = [result objectForColumnName:@"Statedesc"];
            if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressForeign"] isEqualToString:@"0"]) {
                _mailingAddressCountry.text = @"MALAYSIA";
            }
            else {
                _mailingAddressCountry.text = @"";
            }
        }
        [db close];
        [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
    }
}*/

- (IBAction)btnForeign:(id)sender {
    _foreignAddress = !_foreignAddress;
    if (_foreignAddress) {
        [_mailingAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        //[[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"CustomerMailingAddressForeign"];
        _mailingAddressState.enabled = FALSE;
        _Town.enabled = TRUE;
        _mailingAddressCountry.text = @"";
        //_mailingAddressCountry.enabled = TRUE;
        _mailingCountryPickerBtn.enabled = TRUE;
        _mailingAddressState.text = @"";
        _mailingAddress1.text = @"";
        _mailingAddress2.text = @"";
        _mailingAddress3.text = @"";
        _PostCode.text = @"";
        _Town.text = @"";
        _mailingAddressCountry.text = @"";
        _mailingAddressState.textColor = [UIColor lightGrayColor];
        _mailingAddressCountry.textColor = [UIColor blackColor];
        _mailingAddressState.textColor = [UIColor blackColor];
        _Town.textColor = [UIColor blackColor];
        _mailingAddressCountrySelector.enabled = TRUE;
        _Town.placeholder = @"Town";
        _mailingAddressState.placeholder = @"";
    }
    else if (!_foreignAddress) {
        [_mailingAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        //[[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"CustomerMailingAddressForeign"];
        _mailingAddressState.enabled = FALSE;
        _Town.enabled = FALSE;
        _mailingAddressCountry.text = @"MALAYSIA";
        _mailingAddressCountry.enabled = FALSE;
        _mailingCountryPickerBtn.enabled = FALSE;
        _mailingAddress1.text = @"";
        _mailingAddress2.text = @"";
        _mailingAddress3.text = @"";
        _PostCode.text = @"";
        _Town.text = @"";
        _mailingAddressState.text = @"";
        _mailingAddressState.textColor = [UIColor lightGrayColor];
        _Town.textColor = [UIColor lightGrayColor];
        _mailingAddressCountry.textColor = [UIColor lightGrayColor];
        _mailingAddressCountrySelector.enabled = FALSE;
        _Town.placeholder = @"Town";
        _mailingAddressState.placeholder = @"State";
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
        _permanentCountryPickerBtn.enabled = TRUE;
        _permanentAddressState.text = @"";
        _permanentAddress1.text = @"";
        _permanentAddress2.text = @"";
        _permanentAddress3.text = @"";
        _permanentAddressPostCode.text = @"";
        _permanentAddressTown.text = @"";
        _permanentAddressCountry.text = @"";
        _permanentAddressState.textColor = [UIColor lightGrayColor];
        _permanentAddressCountry.textColor = [UIColor blackColor];
        _permanentAddressState.textColor = [UIColor blackColor];
        _permanentAddressTown.textColor = [UIColor blackColor];
        _mailingAddressCountrySelector.enabled = TRUE;
        _permanentAddressTown.placeholder = @"Town";
        _permanentAddressState.placeholder = @"";
    }
    else if (!_permanentForeignAddress) {
        [_permanentAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        //[[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"CustomerMailingAddressForeign"];
        _permanentAddressState.enabled = FALSE;
        _permanentAddressTown.enabled = FALSE;
        _permanentAddressCountry.text = @"MALAYSIA";
       // _permanentAddressCountry.enabled = FALSE;
        _permanentCountryPickerBtn.enabled = FALSE;
        _permanentAddress1.text = @"";
        _permanentAddress2.text = @"";
        _permanentAddress3.text = @"";
        _permanentAddressPostCode.text = @"";
        _permanentAddressTown.text = @"";
        _permanentAddressState.text = @"";
        _permanentAddressState.textColor = [UIColor lightGrayColor];
        _permanentAddressTown.textColor = [UIColor lightGrayColor];
        _permanentAddressCountry.textColor = [UIColor lightGrayColor];
        _mailingAddressCountrySelector.enabled = FALSE;
        _permanentAddressTown.placeholder = @"Town";
        _permanentAddressState.placeholder = @"State";
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}

- (IBAction)btnCountry:(id)sender {
    if (_CountryList == nil) {
        self.CountryList = [[Country alloc] initWithStyle:UITableViewStylePlain];
        _CountryList.delegate = self;
        self.CountryListPopover = [[UIPopoverController alloc] initWithContentViewController:_CountryList];
    }
	
	isMailCountry = YES;
    [self.CountryListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)SelectedCountry:(NSString *)theCountry
{
    //NSLog(@"selectCountry2");
	if (isMailCountry)
		_mailingAddressCountry.text = theCountry;
	else
		_permanentAddressCountry.text = theCountry;
    [self.CountryListPopover dismissPopoverAnimated:YES];
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
	
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
	databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	
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
- (IBAction)postChanged:(id)sender {
    UITextField *textField = (UITextField*)sender;
    if (_foreignAddress) {
        return;
    }
    else if (textField.text.length < 5) {
		_Town.text = @"";
		_mailingAddressState.text = @"";
        return;
    }
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT Town, Statedesc, b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = ?", textField.text];
    _Town.text = @"";
    _mailingAddressState.text = @"";
    while ([result next]) {
        _Town.text = [result objectForColumnName:@"Town"];
        _mailingAddressState.text = [result objectForColumnName:@"Statedesc"];
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressForeign"] isEqualToString:@"0"]) {
            _mailingAddressCountry.text = @"MALAYSIA";
        }
    }
    [db close];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}

- (IBAction)PermanentpostcodeChanged:(UITextField *)sender
{
    //NSLog(@"poscode");
	UITextField *textField = (UITextField*)sender;
	if (_permanentForeignAddress) {
		return;
	}
	if (textField.text.length < 5)
    {
		_permanentAddressTown.text = @"";
		_permanentAddressState.text = @"";
		return;
	}
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT Town, Statedesc, b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = ?", textField.text];
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
