//
//  LA1DetailsVC.m
//  iMobile Planner
//
//  Created by Juliana on 11/13/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "LA1DetailsVC.h"
#import "DataClass.h"
#import "textFields.h"
#import "Utility.h"
#import <sqlite3.h>

@interface LA1DetailsVC () {
	DataClass *obj;
    bool residence;
    bool office;
    bool isResidenceForiegnAddChecked;
    bool isOfficeForiegnAddChecked;
    NSString *haveChildren;
}

@end

@implementation LA1DetailsVC
NSString *databasePath;
sqlite3 *contactDB;
@synthesize IDTypeCodeSelected;
@synthesize TitleCodeSelected;
@synthesize Me, policyLifecycleLabel, asTheParent, NRIC;

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
	
	obj=[DataClass getInstance];
	_btnResidenceCountry.enabled = false;
	_btnOfficeCountry.enabled = false;

	
	
	[self displayData];
}



//get data for LA1
- (void)displayData {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    db = [FMDatabase databaseWithPath:path];
    [db open];
	
	stringID = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
	
	results = Nil;
	results = [db executeQuery:@"select * from  eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?", stringID, @"LA1", Nil];
	while ([results next]) {
		icLA1 = [results stringForColumn:@"LANewICNo"];
		poFlag = [results stringForColumn:@"POFlag"];
		//_titleLbl.text = [results stringForColumn:@"LATitle"];
       _titleLbl.text = [self getTitleDesc:[results stringForColumn:@"LATitle"]];
		_DOBLbl.text = [results stringForColumn:@"LADOB"];
		_nameLbl.text = [results stringForColumn:@"LAName"];
		_raceLbl.text = [results stringForColumn:@"LARace"];
		_nricLbl.text = [results stringForColumn:@"LANewICNo"];
		_nationalityLbl.text = [results stringForColumn:@"LANationality"];
		//_OtherTypeIDLbl.text = [results stringForColumn:@"LAOtherIDType"];
		_OtherTypeIDLbl.text = [self getIDTypeDesc:[results stringForColumn:@"LAOtherIDType"]];
		_otherIDLbl.text = [results stringForColumn:@"LAOtherID"];
		religion = [results stringForColumn:@"LAReligion"];
		_OccupationLbl.text = [results stringForColumn:@"LAOccupationCode"];
		_relationshipLbl.text = [results stringForColumn:@"LARelationship"];
		_maritalStatusLbl.text = [results stringForColumn:@"LAMaritalStatus"];
		_employerLbl.text = [results stringForColumn:@"LAEmployerName"];
		_businessLbl.text = [results stringForColumn:@"LATypeOfBusiness"];
		_exactDutiesLbl.text = [results stringForColumn:@"LAExactDuties"];
		_yearlyIncomeLbl.text = [results stringForColumn:@"LAYearlyIncome"];
		gender = [results stringForColumn:@"LASex"];
		smoker = [results stringForColumn:@"LASmoker"];
		
		corrAdd = [results stringForColumn:@"CorrespondenceAddress"];
		
		ownership = [results stringForColumn:@"ResidenceOwnRented"];
		_txtAdd1.text = [results stringForColumn:@"ResidenceAddress1"];
		_txtAdd12.text = [results stringForColumn:@"ResidenceAddress2"];
		_txtAdd13.text = [results stringForColumn:@"ResidenceAddress3"];
		_txtPostcode1.text = [results stringForColumn:@"ResidencePostcode"];
		_txtState1.text = [self getStateDesc:[results stringForColumn:@"ResidenceState"]];
		_txtTown1.text = [results stringForColumn:@"ResidenceTown"];
		_txtCountry1.text = [self getCountryDesc:[results stringForColumn:@"ResidenceCountry"]];
		resForeignAdd = [results stringForColumn:@"ResidenceForeignAddressFlag"];
		
		_txtAdd2.text = [results stringForColumn:@"OfficeAddress1"];
		_txtAdd22.text = [results stringForColumn:@"OfficeAddress2"];
		_txtAdd23.text = [results stringForColumn:@"OfficeAddress3"];
		_txtPostcode2.text = [results stringForColumn:@"OfficePostcode"];
		_txtState2.text = [self getStateDesc:[results stringForColumn:@"OfficeState"]];
		_txtTown2.text = [results stringForColumn:@"OfficeTown"];
		_txtCountry2.text = [self getCountryDesc:[results stringForColumn:@"OfficeCountry"]];
		ofcForeignAdd = [results stringForColumn:@"OfficeForeignAddressFlag"];
		
        _txtResidence1.text = [results stringForColumn:@"ResidencePhoneNoPrefix"];
		_txtResidence2.text = [results stringForColumn:@"ResidencePhoneNo"];
        _txtOffice1.text = [results stringForColumn:@"OfficePhoneNoPrefix"];
		_txtOffice2.text = [results stringForColumn:@"OfficePhoneNo"];
		_txtEmail.text = [results stringForColumn:@"EmailAddress"];
        _txtMobile1.text = [results stringForColumn:@"MobilePhoneNoPrefix"];
		_txtMobile2.text = [results stringForColumn:@"MobilePhoneNo"];
        _txtFax1.text = [results stringForColumn:@"FaxPhoneNoPrefix"];
		_txtFax2.text = [results stringForColumn:@"FaxPhoneNo"];
        
        haveChildren = [results stringForColumn:@"HaveChildren"];
		
		_titleLbl.textColor = [UIColor grayColor];
		_DOBLbl.textColor = [UIColor grayColor];
		_nameLbl.textColor = [UIColor grayColor];
		_raceLbl.textColor = [UIColor grayColor];
		_nricLbl.textColor = [UIColor grayColor];
		_nationalityLbl.textColor = [UIColor grayColor];
		_OtherTypeIDLbl.textColor = [UIColor grayColor];
		_otherIDLbl.textColor = [UIColor grayColor];
		_OccupationLbl.textColor = [UIColor grayColor];
		_relationshipLbl.textColor = [UIColor grayColor];
		_maritalStatusLbl.textColor = [UIColor grayColor];
		_employerLbl.textColor = [UIColor grayColor];
		_businessLbl.textColor = [UIColor grayColor];
		_exactDutiesLbl.textColor = [UIColor grayColor];
		_yearlyIncomeLbl.textColor = [UIColor grayColor];
		
		_txtAdd1.textColor = [UIColor grayColor];
		_txtAdd12.textColor = [UIColor grayColor];
		_txtAdd13.textColor = [UIColor grayColor];
		_txtPostcode1.textColor = [UIColor grayColor];
		_txtState1.textColor = [UIColor grayColor];
		_txtTown1.textColor = [UIColor grayColor];
		_txtCountry1.textColor = [UIColor grayColor];
				
		_txtAdd2.textColor = [UIColor grayColor];
		_txtAdd22.textColor = [UIColor grayColor];
		_txtAdd23.textColor = [UIColor grayColor];
		_txtPostcode2.textColor = [UIColor grayColor];
		_txtState2.textColor = [UIColor grayColor];
		_txtTown2.textColor = [UIColor grayColor];
		_txtCountry2.textColor = [UIColor grayColor];
		
		_txtResidence1.textColor = [UIColor grayColor];
		_txtResidence2.textColor = [UIColor grayColor];
        _txtOffice1.textColor = [UIColor grayColor];
		_txtOffice2.textColor = [UIColor grayColor];
		_txtEmail.textColor = [UIColor grayColor];
        _txtMobile1.textColor = [UIColor grayColor];
		_txtMobile2.textColor = [UIColor grayColor];
        _txtFax1.textColor = [UIColor grayColor];
		_txtFax2.textColor = [UIColor grayColor];
        
        _txtName.textColor = [UIColor grayColor];
        _txtIC.textColor = [UIColor grayColor];
		
		_policyOwnerType.enabled = false;
		_BtnResidenceForeignAdd.enabled = false;
		_BtnOfficeForeignAdd.enabled = false;
		_BtnOffice.enabled = false;
		_BtnResidence.enabled = false;
		_segOwnership.enabled = false;
		_btnPOFlag.enabled = false;
        
        _txtName.enabled = FALSE;
        _txtIC.enabled = FALSE;
		
		
		
	}
	
	if (![db open]) {
        NSLog(@"Could not open db.");
        db = [FMDatabase databaseWithPath:path];
		[db open];
    }
	
	results = Nil;
	results = [db executeQuery:@"select * from  eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?", stringID, @"PO", Nil];
	while ([results next]) {
		icPO = [results stringForColumn:@"LANewICNo"];
	}
	
	if (![db open]) {
        NSLog(@"Could not open db.");
        db = [FMDatabase databaseWithPath:path];
		[db open];
    }
	
	results = Nil;
	results = [db executeQuery:@"select * from  eProposal where eProposalNo = ?", stringID, Nil];
	while ([results next]) {
		_txtName.text = [results stringForColumn:@"GuardianName"];
		_txtIC.text = [results stringForColumn:@"GuardianNewICNo"];
	}
	
	[results close];
	
	if (![_txtName.text isEqualToString:@""]) {
		Me.textColor = [UIColor blackColor];
		asTheParent.textColor = [UIColor blackColor];
		NRIC.textColor = [UIColor blackColor];
		policyLifecycleLabel.textColor = [UIColor blackColor];
	}
	else {
		Me.textColor = [UIColor grayColor];
		asTheParent.textColor = [UIColor grayColor];
		NRIC.textColor = [UIColor grayColor];
		policyLifecycleLabel.textColor = [UIColor grayColor];
	}
    
	if (![db open]) {
        NSLog(@"Could not open db.");
        db = [FMDatabase databaseWithPath:path];
		[db open];
    }
	
    results = Nil;
    results = [db executeQuery:@"SELECT OccpDesc from Adm_Occp WHERE OccpCode = ?", _OccupationLbl.text, Nil];
    while ([results next]) {
        NSString *occpDesc = [results stringForColumn:@"OccpDesc"] != NULL ? [results stringForColumn:@"OccpDesc"] : @"";
        _OccupationLbl.text = occpDesc;
    }
    
	if (![db open]) {
        NSLog(@"Could not open db.");
        db = [FMDatabase databaseWithPath:path];
		[db open];
    }
	
    results = Nil;
    results = [db executeQuery:@"select * from eProposal_State where StateCode = ?", [textFields trimWhiteSpaces:_txtState1.text], nil];
    while ([results next]) {
        _txtState1.text = [results objectForColumnName:@"StateDesc"];
    }
    
	if (![db open]) {
        NSLog(@"Could not open db.");
        db = [FMDatabase databaseWithPath:path];
		[db open];
    }
	
    results = Nil;
    results = [db executeQuery:@"select * from eProposal_State where StateCode = ?", [textFields trimWhiteSpaces:_txtState2.text], nil];
    while ([results next]) {
        _txtState2.text = ![[results objectForColumnName:@"StateDesc"] isEqualToString:@"(null)"] ? [results objectForColumnName:@"StateDesc"] : @"";
    }
    
	[db close];
	
    if ([_txtState2.text isEqualToString:@"(null)"]) {
        _txtState2.text = @"";
    }
	
	if ([icLA1 isEqual:icPO] && ![icLA1 isEqualToString:@""]) {
		NSLog(@"1 case");
		[_btnPOFlag setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        NSString *status = [textFields trimWhiteSpaces:_maritalStatusLbl.text];
        if ([status isEqualToString:@"MARRIED"] ||[status isEqualToString:@"DIVORCED"] || [status isEqualToString:@"WIDOW"]|| [status isEqualToString:@"WIDOWER"]) {
            //_segHaveChildren.enabled = TRUE;
            if ([haveChildren isEqualToString:@"Y"]) {
                _segHaveChildren.selectedSegmentIndex = 0;
            }
            else if ([haveChildren isEqualToString:@"N"]) {
                _segHaveChildren.selectedSegmentIndex = 1;
            }
        }
        //[self enabledAddressFields];
	}
	else if ([poFlag isEqualToString:@"Y"]) {
		NSLog(@"2 case");
		[_btnPOFlag setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        NSString *status = [textFields trimWhiteSpaces:_maritalStatusLbl.text];
        if ([status isEqualToString:@"MARRIED"] ||[status isEqualToString:@"DIVORCED"] || [status isEqualToString:@"WIDOW"]|| [status isEqualToString:@"WIDOWER"]) {
            //_segHaveChildren.enabled = TRUE;
            if ([haveChildren isEqualToString:@"Y"]) {
                _segHaveChildren.selectedSegmentIndex = 0;
            }
            else if ([haveChildren isEqualToString:@"N"]) {
                _segHaveChildren.selectedSegmentIndex = 1;
            }
        }
		if ([corrAdd isEqualToString:@"residence"]) {
			[_BtnResidence setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
           // [_BtnResidence setBackgroundImage:[UIImage imageNamed:@"tickCheckbox.png"] forState:UIControlStateNormal];
			[_BtnOffice setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		}
        else if([corrAdd isEqualToString:@"office"]){
            [_BtnResidence setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
			[_BtnOffice setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        }
        //[self enabledAddressFields];
	}
	else if ([poFlag isEqualToString:@"N"]) {
		NSLog(@"3 case");
		[_btnPOFlag setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	
    _policyOwnerType.selectedSegmentIndex = 0;
	
	if ([[textFields trimWhiteSpaces:religion] hasPrefix:@"MUSLIM"]) {
		_segReligion.selectedSegmentIndex = 0;
	}
	else if ([[textFields trimWhiteSpaces:religion] hasPrefix:@"NON"]) {
		_segReligion.selectedSegmentIndex = 1;
	}
	
	if ([[textFields trimWhiteSpaces:gender] hasPrefix:@"M"]) {
		_segGender.selectedSegmentIndex = 0;
	}
	else if ([[textFields trimWhiteSpaces:gender] hasPrefix:@"F"]) {
		_segGender.selectedSegmentIndex = 1;
	}
	
	if ([[textFields trimWhiteSpaces:smoker] hasPrefix:@"Y"]) {
		_segSmoker.selectedSegmentIndex = 0;
	}
	else if ([[textFields trimWhiteSpaces:smoker] hasPrefix:@"N"]) {
		_segSmoker.selectedSegmentIndex = 1;
	}
	
	if ([[textFields trimWhiteSpaces:corrAdd] isEqualToString:@"R"]) {
		[_BtnResidence setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[_BtnOffice setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	else if ([[textFields trimWhiteSpaces:corrAdd] isEqualToString:@"O"]) {
		[_BtnOffice setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[_BtnResidence setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	
	if ([[textFields trimWhiteSpaces:ownership] isEqualToString:@"Own"]) {
		_segOwnership.selectedSegmentIndex = 0;
	}
	else if ([[textFields trimWhiteSpaces:ownership] isEqualToString:@"Rented"]) {
		_segOwnership.selectedSegmentIndex = 1;
	}
	
	if ([[textFields trimWhiteSpaces:resForeignAdd] isEqualToString:@"Y"]) {
		[_BtnResidenceForeignAdd setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
	}
	else if ([[textFields trimWhiteSpaces:resForeignAdd] isEqualToString:@"N"]) {
		[_BtnResidenceForeignAdd setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	
	if ([[textFields trimWhiteSpaces:ofcForeignAdd] isEqualToString:@"Y"]) {
		[_BtnOfficeForeignAdd setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
	}
	else if ([[textFields trimWhiteSpaces:ofcForeignAdd] isEqualToString:@"N"]) {
		[_BtnOfficeForeignAdd setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	
	if ([_OtherTypeIDLbl.text isEqualToString:@"EXPECTED DELIVERY DATE"])
	{
		_OccupationLbl.text = @"MINOR";
	}
}

- (void)enabledAddressFields {
    _BtnResidenceForeignAdd.enabled = TRUE;
    _segOwnership.enabled = TRUE;
    _txtAdd1.enabled = TRUE;
    _txtAdd12.enabled = TRUE;
    _txtAdd13.enabled = TRUE;
    _txtPostcode1.enabled = TRUE;
    if ([[textFields trimWhiteSpaces:resForeignAdd] isEqualToString:@"Y"]) {
		_txtTown1.enabled = TRUE;
        _txtState1.enabled = TRUE;
	}
    
    _BtnOfficeForeignAdd.enabled = TRUE;
    _txtAdd2.enabled = TRUE;
    _txtAdd22.enabled = TRUE;
    _txtAdd23.enabled = TRUE;
    _txtPostcode2.enabled = TRUE;
    if ([[textFields trimWhiteSpaces:ofcForeignAdd] isEqualToString:@"Y"]) {
        _txtTown2.enabled = TRUE;
		_txtState2.enabled = TRUE;
	}
}

- (IBAction)ActionResidenceCountry:(id)sender {
    
    residence = TRUE;
    office = FALSE;
    if (_CountryList == nil) {
        self.CountryList = [[Country alloc] initWithStyle:UITableViewStylePlain];
        _CountryList.delegate = self;
        self.CountryListPopover = [[UIPopoverController alloc] initWithContentViewController:_CountryList];
    }
    
    
    [self.CountryListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)ActionOfficeCountry:(id)sender {
    
    residence = FALSE;
    office = TRUE;
    if (_CountryList == nil) {
        self.CountryList = [[Country alloc] initWithStyle:UITableViewStylePlain];
        _CountryList.delegate = self;
        self.CountryListPopover = [[UIPopoverController alloc] initWithContentViewController:_CountryList];
    }
    
    
    [self.CountryListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)ActionCheckResidenceAddress:(id)sender
{
    isResidenceForiegnAddChecked = !isResidenceForiegnAddChecked;
    if(isResidenceForiegnAddChecked) {
        
        if([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickResidenceAdd"] isEqualToString:@"Y"])
        {    [Utility showAllert:@"Correspondence Address must be Malaysia address."];
            [_BtnResidenceForeignAdd setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
            isResidenceForiegnAddChecked = !isResidenceForiegnAddChecked;
            [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"ForeignResidenceAdd"];
            _txtTown1.enabled = false;
            _txtCountry1.enabled = false;
            _btnResidenceCountry.enabled = FALSE;
        }
        else
        {
            [_BtnResidenceForeignAdd setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"ForeignResidenceAdd"];
            _txtTown1.enabled = true;
            _txtState1.enabled = true;
            _txtCountry1.enabled = true;
            _txtCountry1.text = @"";
            _txtAdd1.text = @"";
            _txtAdd12.text = @"";
            _txtAdd13.text = @"";
            _txtPostcode1.text = @"";
            _txtTown1.text = @"";
            _txtState1.text = @"";
            _btnResidenceCountry.enabled = TRUE;
        }
    }
    else {
        
		[_BtnResidenceForeignAdd setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"ForeignResidenceAdd"];
        _txtTown1.enabled = false;
        _txtState1.enabled = false;
        _txtCountry1.enabled = false;
        _btnResidenceCountry.enabled = FALSE;
        _txtCountry1.text = @"MALAYSIA";
        _txtAdd1.text = @"";
        _txtAdd12.text = @"";
        _txtAdd13.text = @"";
        _txtPostcode1.text = @"";
        _txtTown1.text = @"";
        _txtState1.text = @"";
    }
    
    
    
}
- (IBAction)ActionCheckOfficeAddress:(id)sender
{
    isOfficeForiegnAddChecked = !isOfficeForiegnAddChecked;
    
    if(isOfficeForiegnAddChecked) {
        
        if([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickOfficeAdd"] isEqualToString:@"Y"])
        {
            [Utility showAllert:@"Correspondence Address must be Malaysia address."];
            [_BtnOfficeForeignAdd setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
            isOfficeForiegnAddChecked = !isOfficeForiegnAddChecked;
            [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"ForeignOfficeAdd"];
            _txtTown2.enabled = false;
            _txtCountry2.enabled = false;
            _btnOfficeCountry.enabled = FALSE;
        }
        else
        {
            [_BtnOfficeForeignAdd setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"ForeignOfficeAdd"];
            _txtTown2.enabled = true;
            _txtState2.enabled = true;
            _txtCountry2.enabled = true;
            _txtCountry2.text = @"";
            _txtAdd2.text = @"";
            _txtAdd22.text = @"";
            _txtAdd23.text = @"";
            _txtPostcode2.text = @"";
            _txtTown2.text = @"";
            _txtState2.text = @"";
            _btnOfficeCountry.enabled = TRUE;
            
        }
    }
    else {
		[_BtnOfficeForeignAdd setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"ForeignOfficeAdd"];
        _txtTown2.enabled = false;
        _txtState2.enabled = false;
        _txtCountry2.enabled = false;
        _btnOfficeCountry.enabled = FALSE;
        _txtCountry2.text = @"MALAYSIA";
        _txtAdd2.text = @"";
        _txtAdd22.text = @"";
        _txtAdd23.text = @"";
        _txtPostcode2.text = @"";
        _txtTown2.text = @"";
        _txtState2.text = @"";
    }
}

-(void)SelectedCountry:(NSString *)setCountry {
    if (residence) {
        _txtCountry1.text = setCountry;
    }
    else if (office) {
        _txtCountry2.text = setCountry;
    }
    residence = FALSE;
    office = FALSE;
    [_CountryListPopover dismissPopoverAnimated:YES];
}

-(IBAction)editingDidEndPostcode:(id)sender {
    UITextField *textField = (UITextField*)sender;
    UITextField *Town;
    UITextField *mailingAddressState;
    UITextField *mailingAddressCountry;
    if (textField == _txtPostcode1) {
        if ([[textFields trimWhiteSpaces:resForeignAdd] isEqualToString:@"Y"]) {
            return;
        }
        else if (textField.text.length < 5) {
            return;
        }
        Town = _txtTown1;
        mailingAddressState = _txtState1;
        mailingAddressCountry = _txtCountry1;
    }
    else if (textField == _txtPostcode2) {
        if ([[textFields trimWhiteSpaces:ofcForeignAdd] isEqualToString:@"Y"]) {
            return;
        }
        else if (textField.text.length < 5) {
            return;
        }
        Town = _txtTown2;
        mailingAddressState = _txtState2;
        mailingAddressCountry = _txtCountry2;
    }
    
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT Town, Statedesc, b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = ?", textField.text];
    Town.text = @"";
    mailingAddressState.text = @"";
    while ([result next]) {
        Town.text = [result stringForColumn:@"Town"];
        mailingAddressState.text = [result stringForColumn:@"Statedesc"];
    }
    [db close];
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
			}		}
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setNameLbl:nil];
    [self setNricLbl:nil];
    [self setOtherIDLbl:nil];
    [self setSegReligion:nil];
    [self setEmployerLbl:nil];
    [self setBusinessLbl:nil];
    [self setExactDutiesLbl:nil];
    [self setYearlyIncomeLbl:nil];
    [self setSegGender:nil];
    [self setSegSmoker:nil];
    [self setPolicyOwnerType:nil];
    [self setSegHaveChildren:nil];
    [super viewDidUnload];
}
//For NM Title
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
	
	if ([country isEqualToString:@""] || (country == NULL) || ([country isEqualToString:@"(null)"])) {
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


@end
