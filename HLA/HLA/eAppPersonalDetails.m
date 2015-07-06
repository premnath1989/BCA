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
#import "textFields.h"

#define CHARACTER_LIMIT_ICNO 12
#define NUMBERS_ONLY @"0123456789"
#define CHARACTER_LIMIT_PC_F 12
#define CHARACTER_LIMIT_PC_NF 5
#define CHAR_ONLY @"ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz./@'()-"

@interface eAppPersonalDetails () {
	DataClass *obj;
    
     bool isCompany;
	BOOL skipUpdate;
    
}

@end

@implementation eAppPersonalDetails
@synthesize titleLbl,OtherIDLbl,DOBLbl,RelationshipLbl,OccupationLbl,NationalityLbl;
@synthesize IDTypePopover = _IDTypePopover;
@synthesize IDTypeVC = _IDTypeVC;
@synthesize SIDate = _SIDate;
@synthesize SIDatePopover = _SIDatePopover;
@synthesize TitlePicker = _TitlePicker;
@synthesize TitlePickerPopover = _TitlePickerPopover;
@synthesize RelationshipVC = _RelationshipVC;
@synthesize RelationshipPopover = _RelationshipPopover;
@synthesize checkAddress;
@synthesize checkCRAddress;
@synthesize checkForeign;
@synthesize checkCRForeign;
@synthesize IDTypeCodeSelected;
@synthesize TitleCodeSelected;
@synthesize POLbl = _POLbl;
@synthesize OccupationListPopover = _OccupationListPopover;
@synthesize nationalityPopover =_nationalityPopover;



- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"1");
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
        [[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"LA1"] setValue:[results stringForColumn:@"LAOccupationCode"] forKey:@"Occupation"];
		[[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"LA1"] setValue:[results stringForColumn:@"LAName"] forKey:@"Name"];
		PRelationship = [results stringForColumn:@"LARelationship"];
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
		PRelationship = [results stringForColumn:@"LARelationship"];
	}
	
	namePO = @"";
	results = Nil;
	results = [database executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"PO", Nil];
	while ([results next]) {
		namePO = [results stringForColumn:@"LAName"];
		PRelationship = [results stringForColumn:@"LARelationship"];
	}
	
//	results = Nil;
//	results = [database executeQuery:@"select ALB as Age from Clt_Profile as c where c.IndexNo = (select ClientProfileID from  eApp_Listing where ProposalNo = ?)", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
//	while ([results next]) {
//		ageForPart2 = [results intForColumn:@"Age"];
//	}
    //check POType whether if its Company or Personal
    results2 = nil;
    results2 = [database executeQuery:@"select LAOtherIDType from eProposal_LA_Details where POFlag = ? and eProposalNo = ?", @"Y", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], nil];
    while ([results2 next])
       {
        if (([[textFields trimWhiteSpaces:[results2 objectForColumnName:@"LAOtherIDType"]] caseInsensitiveCompare:@"Company Registration Number"] == NSOrderedSame) || ([[textFields trimWhiteSpaces:[results2 objectForColumnName:@"LAOtherIDType"]] caseInsensitiveCompare:@"CR"] == NSOrderedSame)){
            isCompany = TRUE;
        }
        else {
            isCompany = FALSE;
        }
    }

	
	results = Nil;
	results = [database executeQuery:@"select ALB as Age from Clt_Profile as c where c.IndexNo = (select ProspectProfileID from  eProposal_LA_Details where eProposalNo = ? and PTypeCode = ? )", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"LA1", Nil];
	while ([results next]) {
		ageForPart2 = [results intForColumn:@"Age"];
	}
    
    // for validation
    _icAry = [NSMutableArray array];
    _otherIDAry = [NSMutableArray array];
    _otherIDTypeAry = [NSMutableArray array];
    _nameAry = [NSMutableArray array];
    
    results = Nil;
    results = [database executeQuery:@"select LAName, LANewICNo, LAOtherIDType, LAOtherID from eProposal_LA_Details where eProposalNo = ? ORDER BY PTypeCode ASC", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
    while ([results next]) {
        [_icAry addObject:[results stringForColumn:@"LANewICNo"]];
        [_otherIDAry addObject:[results stringForColumn:@"LAOtherID"]];
        [_otherIDTypeAry addObject:[results stringForColumn:@"LAOtherIDType"]];
        [_nameAry addObject:[[results stringForColumn:@"LAName"] lowercaseString]];
    }

	
	[results close];
	[database close];
	
	_firstLALbl.text = nameLA1;
	_secondLALbl.text = nameLA2;
	_payorLbl.text = namePayor;
	if (![namePO isEqualToString:@""]) {
		_payorLbl.text = namePO;
		_POLbl.text = @"Policy Owner";
	}
	
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
	
	
    
    
    
	
    if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickPart2"] isEqualToString:@"Y"]) {
        [self actionForPart2:nil];
        [[obj.eAppData objectForKey:@"EAPP"] setValue:@"0" forKey:@"EAPPSave"];
        
        //titleLbl.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Title"];
        if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Title"] isEqualToString:@"(null)"]) {
            titleLbl.text = @"";
        }
        else {
            titleLbl.text = [self getTitleDesc:[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Title"]];
        }

        //titleLbl.text = [self getTitleDesc:[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Title"]];
        
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
            _telPhoneNoPrefixTF.text = @"";
        }
        else {
              NSString *TelNo = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TelNo"];
              NSArray *TelNoAry = [TelNo componentsSeparatedByString:@" "];
            if (TelNoAry.count > 1) {
            //_telNoTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TelNo"];
           // _telPhoneNoPrefixTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TelNoPrefix"];
            
            _telNoTF.text=[[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TelNo"] componentsSeparatedByString:@" "][1];
            _telPhoneNoPrefixTF.text=[[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TelNo"] componentsSeparatedByString:@" "][0];
            }
            else
            {
                _telNoTF.text=[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TelNo"];
                _telPhoneNoPrefixTF.text=[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TelNoPrefix"];
            }
                
        }
        
        if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"MobileNo"] isEqualToString:@"(null)"]) {
            _mobileTF.text = @"";
            _mobilePrefixTF.text = @"";
        }
        else {
            NSString *MobileNo = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"MobileNo"];
            NSArray *MobileNoAry = [MobileNo componentsSeparatedByString:@" "];
            if (MobileNoAry.count > 1) {
           // _mobileTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"MobileNo"];
           // _mobilePrefixTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"MobileNoPrefix"];
                
                 _mobileTF.text=[[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"MobileNo"] componentsSeparatedByString:@" "][1];
                _mobilePrefixTF.text=[[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"MobileNo"] componentsSeparatedByString:@" "][0];
            }
            else
            {
                _mobileTF.text=[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"MobileNo"];
                _mobilePrefixTF.text=[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"MobileNoPrefix"];
            }
            
        }
        if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Email"] isEqualToString:@"(null)"]) {
            _emailTF.text = @"";
        }
        else {
            _emailTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Email"];
        }
        
        if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Nationality"] isEqualToString:@"(null)"]) {
            NationalityLbl.text = @"";
        }
        else {
            NationalityLbl.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Nationality"];
        }
        
        if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Occupation"] isEqualToString:@"(null)"]) {
            OccupationLbl.text = @"";
        }
        else {
            OccupationLbl.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Occupation"];
        }

        
        if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"NameOfEmployer"] isEqualToString:@"(null)"])
        {
            _nameOfEmployerTF.text = @"";
        }
        else
        {
            
            if([OccupationLbl.text isEqualToString:@"HOUSEWIFE"]||[OccupationLbl.text isEqualToString:@"STUDENT"]||[OccupationLbl.text isEqualToString:@"JUVENILE"]||[OccupationLbl.text isEqualToString:@"RETIRED"]||[OccupationLbl.text isEqualToString:@"UNEMPLOYED"]||[OccupationLbl.text isEqualToString:@"TEMPORARILY UNEMPLOYED"])
            {
//                _nameOfEmployerTF.enabled =TRUE;
//                _nameOfEmployerTF.text =@"";
//                _nameOfEmployerTF.textColor = [UIColor blackColor];
                
                _nameOfEmployerTF.enabled =TRUE;
                _nameOfEmployerTF.text =[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"NameOfEmployer"];
                _nameOfEmployerTF.textColor = [UIColor blackColor];

          
            }
            
            else
            {
                _nameOfEmployerTF.enabled =TRUE;
                _nameOfEmployerTF.text =[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"NameOfEmployer"];
                _nameOfEmployerTF.textColor = [UIColor blackColor];
                

            }

            
           // _nameOfEmployerTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"NameOfEmployer"];
        }
        
        if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ExactNatureOfWork"] isEqualToString:@"(null)"]) {
            _exactNatureOfWorkTF.text = @"";
        }
        else
        {
            if([OccupationLbl.text isEqualToString:@"HOUSEWIFE"]||[OccupationLbl.text isEqualToString:@"STUDENT"]||[OccupationLbl.text isEqualToString:@"JUVENILE"]||[OccupationLbl.text isEqualToString:@"RETIRED"]||[OccupationLbl.text isEqualToString:@"UNEMPLOYED"]||[OccupationLbl.text isEqualToString:@"TEMPORARILY UNEMPLOYED"])
            {
                              
//                _exactNatureOfWorkTF.enabled =FALSE;
//                _exactNatureOfWorkTF.text =@"";
//                _exactNatureOfWorkTF.textColor = [UIColor blackColor];
                
                _exactNatureOfWorkTF.enabled =TRUE;
                _exactNatureOfWorkTF.text =[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ExactNatureOfWork"];
                _exactNatureOfWorkTF.textColor = [UIColor blackColor];

                
            }
            
            else
            {
                _exactNatureOfWorkTF.enabled =TRUE;
                _exactNatureOfWorkTF.text =[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ExactNatureOfWork"];
                _exactNatureOfWorkTF.textColor = [UIColor blackColor];
                
            }
         //   _exactNatureOfWorkTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ExactNatureOfWork"];
        }
        
        
        if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ICNo"] isEqualToString:@"(null)"]) {
            _icNoTF.text = @"";
			_btnDOBPO.enabled = TRUE;
			DOBLbl.textColor = [UIColor blackColor];
			_sexSC.enabled = TRUE;
        }
        else {
            _icNoTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ICNo"];
			_btnDOBPO.enabled = FALSE;
			DOBLbl.textColor = [UIColor grayColor];
			_sexSC.enabled = FALSE;
        }
        if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"OtherIDType"] isEqualToString:@"(null)"]) {
            OtherIDLbl.text = @"";
        }
        else {
            OtherIDLbl.text = [self getIDTypeDesc:[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"OtherIDType"]];
			IDTypeCodeSelected = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"OtherIDType"];
        }
        if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"OtherID"] isEqualToString:@"(null)"] || [[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"OtherID"] isEqualToString:@""]) {
            _otherIDTF.text = @"";
        }
        else {
            _otherIDTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"OtherID"];
			_otherIDTF.enabled = YES;
        }
		
		if ([OtherIDLbl.text isEqualToString:@"BIRTH CERTIFICATE"] || [OtherIDLbl.text isEqualToString:@"OLD IDENTIFICATION NO"] || [OtherIDLbl.text isEqualToString:@"PASSPORT"] || OtherIDLbl.text == NULL || [OtherIDLbl.text isEqualToString:@""] || [OtherIDLbl.text isEqualToString:@"- SELECT -"]) {
			//_nricLbl.text = @"";
			_icNoTF.enabled = YES;
		}
		else {
			_icNoTF.text = @"";
			_icNoTF.enabled = NO;
			
//			DOBLbl.text = @"";
//			_btnDOBPO.enabled = TRUE;
//			//ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
//			DOBLbl.textColor = [UIColor blackColor];
//			_sexSC.enabled = TRUE;
//			_sexSC.selectedSegmentIndex = -1;
		}
        //can be null
        
        DOBLbl.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"DOB"];
        RelationshipLbl.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Relationship"];
		
		if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ForeignAddress"] isEqualToString:@"Y"]) {
            [self actionForForeignAdd:nil];
        }
		else {
			_townTF.textColor = [UIColor grayColor];
			_countryLbl.textColor = [UIColor grayColor];
			_townTF.enabled = false;
			_btnCountryPO.enabled = false;
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
        NSLog(@"%@", [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Country"]);
        _countryLbl.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"Country"];
        
		if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRForeignAddress"] isEqualToString:@"Y"]) {
            [self actionForCRForeignAdd:nil];
        }
		else {
			_CRtownTF.textColor = [UIColor grayColor];
			_CRcountryLbl.textColor = [UIColor grayColor];
			_CRtownTF.enabled = false;
//			_btnCountryPO.enabled = false;
			_CRfa = false;
		}
        
//        _CRaddressTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRAddress1"];
		
		
		
		
		if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRAddress1"] isEqualToString:@"(null)"] || [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRAddress1"] == nil) {
            _CRaddressTF.text = @"";
        }
        else {
            _CRaddressTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRAddress1"];
        }
		
        if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRAddress2"] isEqualToString:@"(null)"]) {
            _CRaddress2TF.text = @"";
        }
        else {
            _CRaddress2TF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRAddress2"];
        }
        if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRAddress3"] isEqualToString:@"(null)"]) {
            _CRaddress3TF.text = @"";
        }
        else {
            _CRaddress3TF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRAddress3"];
        }
        if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRPostcode"] isEqualToString:@"(null)"]) {
            _CRpostcodeTF.text = @"";
        }
        else {
            _CRpostcodeTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRPostcode"];
        }
        if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRTown"] isEqualToString:@"(null)"]) {
            _CRtownTF.text = @"";
        }
        else {
            _CRtownTF.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRTown"];
        }
        if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"State"] isEqualToString:@"(null)"]) {
            _CRstateLbl.text = @"";
        }
        else {
            _CRstateLbl.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRState"];
        }
        
        
        
        _CRcountryLbl.text = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"CRCountry"];
        if (![_CRcountryLbl.text isEqualToString:@"MALAYSIA"])
        {
//			isCRForeignAddress = TRUE;
//			_CRfa = true;
//			//[_btnCRForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
//			[[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"CRForeignAddress"];
		}
		else
        {
			isCRForeignAddress = FALSE;
			_CRfa = FALSE;
			[_btnCRForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
			[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"CRForeignAddress"];
		}
		
		if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SameAddress"] isEqualToString:@"Y"])
        {
			skipUpdate = TRUE;
            [self actionForSameAdd:nil];
        }
		skipUpdate = FALSE;
		
        
    }
    else if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickPart2"] isEqualToString:@"N"]){
        isPart2Checked = TRUE;
        [self actionForPart2:nil];
        [[obj.eAppData objectForKey:@"EAPP"] setValue:@"0" forKey:@"EAPPSave"];
    }
    
    //	enable part 2 only if juvenile start
	if ( !isCompany && ![PRelationship isEqualToString:@"SELF"] && ageForPart2 < 16) {
		_btnPart2.enabled = TRUE;
	}
    else if( isCompany && ![PRelationship isEqualToString:@"SELF"] && ageForPart2 < 16) {
            _btnPart2.enabled = FALSE;
        _lblforparticularsofCO.enabled = NO;
        _lblforCOmustattainage16andabove.enabled = NO;
        _lblforTitle.enabled = NO;
        _lblforsex.enabled = NO;
        _lblforfullname.enabled = NO;
        _lblforTelno.enabled = NO;
        _lblforNewIcno.enabled = NO;
        _lblformobile.enabled = NO;
        _lblforOtherIdType.enabled = NO;
        _lblforEmail.enabled = NO;
        _lblforOtherId.enabled = NO;
        _lblforDOB.enabled = NO;
        _lblforRelationshipwithLA.enabled = NO;
        _lblforSameaddressasPO.enabled = NO;
        _lblforForeignAddress.enabled = NO;
        _lblforAddress.enabled = NO;
        _lblforPostcode.enabled = NO;
        _lblforTown.enabled = NO;
        _lblforState.enabled = NO;
        _lblforCountry.enabled = NO;
        
        _lblforCRForeignAddress.enabled = NO;
        _lblforCRAddress.enabled = NO;
        _lblforCRPostcode.enabled = NO;
        _lblforCRTown.enabled = NO;
        _lblforCRState.enabled = NO;
        _lblforCRCountry.enabled = NO;
        
        _lblforNationality.enabled = NO; // new fields for new proposal form
        _lblfornameOfEmployer.enabled = NO; // new fields for new proposal form
        _lblforOccupation.enabled = NO; // new fields for new proposal form
        _lblforExactDuty.enabled = NO; // new fields for new proposal form
        }

    else if ([PRelationship isEqualToString:@"SELF"] && ageForPart2 <= 16 )
    { 
        _btnPart2.enabled=FALSE;
        
        _lblforparticularsofCO.enabled = NO;
        _lblforCOmustattainage16andabove.enabled = NO;
        _lblforTitle.enabled = NO;
        _lblforsex.enabled = NO;
        _lblforfullname.enabled = NO;
        _lblforTelno.enabled = NO;
        _lblforNewIcno.enabled = NO;
        _lblformobile.enabled = NO;
        _lblforOtherIdType.enabled = NO;
        _lblforEmail.enabled = NO;
        _lblforOtherId.enabled = NO;
        _lblforDOB.enabled = NO;
        _lblforRelationshipwithLA.enabled = NO;
        _lblforSameaddressasPO.enabled = NO;
        _lblforForeignAddress.enabled = NO;
        _lblforAddress.enabled = NO;
        _lblforPostcode.enabled = NO;
        _lblforTown.enabled = NO;
        _lblforState.enabled = NO;
        _lblforCountry.enabled = NO;
        
        _lblforCRForeignAddress.enabled = NO;
        _lblforCRAddress.enabled = NO;
        _lblforCRPostcode.enabled = NO;
        _lblforCRTown.enabled = NO;
        _lblforCRState.enabled = NO;
        _lblforCRCountry.enabled = NO;
        
        _lblforNationality.enabled = NO; // new fields for new proposal form
        _lblfornameOfEmployer.enabled = NO; // new fields for new proposal form
        _lblforOccupation.enabled = NO; // new fields for new proposal form
        _lblforExactDuty.enabled = NO; // new fields for new proposal form
        
    }        
	else
		_btnPart2.enabled = FALSE;
    //	enable part 2 only if juvenile end

	if (_icNoTF.text.length ==12) {
		//_dobLbl.text = @"";
		_btnDOBPO.enabled = FALSE;
		DOBLbl.textColor = [UIColor grayColor];
		_sexSC.enabled = FALSE;
		//_sexSC.selectedSegmentIndex = -1;
	}
	else {
		//_dobLbl.text = @"";
		_btnDOBPO.enabled = FALSE;
		DOBLbl.textColor = [UIColor blackColor];
		_sexSC.enabled = FALSE;
		//_sexSC.selectedSegmentIndex = -1;
	}
	

	//object end
    
    _mobilePrefixTF.delegate = self;
    _telPhoneNoPrefixTF.delegate = self;
	_fullNameTF.delegate = self;
    _otherIDTF.delegate=self;
	_addressTF.delegate = self;
	_address2TF.delegate = self;
	_address3TF.delegate = self;
	_townTF.delegate = self;
    _CRtownTF.delegate = self;
    
	_CRaddressTF.delegate = self;
	_CRaddress2TF.delegate = self;
	_CRaddress3TF.delegate = self;
	_CRtownTF.delegate = self;
    
	_emailTF.delegate = self;
    _telNoTF.delegate =self;
    _telPhoneNoPrefixTF.delegate =self;
    _mobileTF.delegate =self;
    _mobilePrefixTF.delegate =self;
	_nameOfEmployerTF.delegate = self;
	_exactNatureOfWorkTF.delegate = self;

    
	//ADD BY EMI TO DETECT CHANGE
	[_mobilePrefixTF addTarget:self action:@selector(detectChanges1:) forControlEvents:UIControlEventEditingChanged];
	[_telPhoneNoPrefixTF addTarget:self action:@selector(detectChanges1:) forControlEvents:UIControlEventEditingChanged];
	[_fullNameTF addTarget:self action:@selector(detectChanges1:) forControlEvents:UIControlEventEditingChanged];
	[_addressTF addTarget:self action:@selector(detectChanges1:) forControlEvents:UIControlEventEditingChanged];
	[_address2TF addTarget:self action:@selector(detectChanges1:) forControlEvents:UIControlEventEditingChanged];
	[_address3TF addTarget:self action:@selector(detectChanges1:) forControlEvents:UIControlEventEditingChanged];
	[_townTF addTarget:self action:@selector(detectChanges1:) forControlEvents:UIControlEventEditingChanged];
    
	[_CRaddressTF addTarget:self action:@selector(detectChanges1:) forControlEvents:UIControlEventEditingChanged];
	[_CRaddress2TF addTarget:self action:@selector(detectChanges1:) forControlEvents:UIControlEventEditingChanged];
	[_CRaddress3TF addTarget:self action:@selector(detectChanges1:) forControlEvents:UIControlEventEditingChanged];
	[_CRtownTF addTarget:self action:@selector(detectChanges1:) forControlEvents:UIControlEventEditingChanged];
    
	[_emailTF addTarget:self action:@selector(detectChanges1:) forControlEvents:UIControlEventEditingChanged];
	[_otherIDTF addTarget:self action:@selector(detectChanges1:) forControlEvents:UIControlEventEditingChanged];
	
	[_icNoTF addTarget:self action:@selector(NewICDidChange:) forControlEvents:UIControlEventEditingChanged];
    
	[_nameOfEmployerTF addTarget:self action:@selector(detectChanges1:) forControlEvents:UIControlEventEditingChanged];
	[_exactNatureOfWorkTF addTarget:self action:@selector(detectChanges1:) forControlEvents:UIControlEventEditingChanged];
	
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
	if (![_POLbl.text isEqualToString:@"Policy Owner"]) 
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"3" forKey:@"WhichDetails"];
	else
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"4" forKey:@"WhichDetails"];
	
    MainLA1DetailsVC *zzz = [self.storyboard instantiateViewControllerWithIdentifier:@"MainLA1Details"];
    zzz.modalPresentationStyle = UIModalPresentationPageSheet;
    zzz.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:zzz animated:NO];
}

- (IBAction)ActionTitle:(id)sender
{
	[self hideKeyboard];
    if (_TitlePicker == nil) {
        _TitlePicker = [[TitleViewController alloc] initWithStyle:UITableViewStylePlain];
        _TitlePicker.delegate = self;
        self.TitlePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_TitlePicker];
    }
    
    [self.TitlePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(IBAction)ActionOccupation:(id)sender
{
    
    if (_OccupationList == nil)
    {
        self.OccupationList = [[OccupationList alloc] initWithStyle:UITableViewStylePlain];
        _OccupationList.delegate = self;
        self.OccupationListPopover = [[UIPopoverController alloc] initWithContentViewController:_OccupationList];
    }
    
    
    [self.OccupationListPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

- (void)OccupDescSelected:(NSString *) OccupDesc
{
    if([OccupDesc isEqualToString:@"HOUSEWIFE"]||[OccupDesc isEqualToString:@"STUDENT"]||[OccupDesc isEqualToString:@"JUVENILE"]||[OccupDesc isEqualToString:@"RETIRED"]||[OccupDesc isEqualToString:@"UNEMPLOYED"]||[OccupDesc isEqualToString:@"TEMPORARILY UNEMPLOYED"])
    {
        _nameOfEmployerTF.enabled =TRUE;
       // _nameOfEmployerTF.text =@"";
        
        _exactNatureOfWorkTF.enabled =TRUE;
       // _exactNatureOfWorkTF.text =@"";
        
    }
    
    else
    {
        _nameOfEmployerTF.enabled =TRUE;
       // _nameOfEmployerTF.text =[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"NameOfEmployer"];
        
        _exactNatureOfWorkTF.enabled =TRUE;
       // _exactNatureOfWorkTF.text =[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ExactNatureOfWork"];
        
        
    }

    
    
	self.OccupationLbl.text = OccupDesc;
	self.OccupationLbl.textColor = [UIColor blackColor];
    [self.OccupationListPopover dismissPopoverAnimated:YES];
}

- (void)OccupCodeSelected:(NSString *) OccupCode
{
//    [obj.eAppData setValue:OccupCode forKey:@"LAOccupationCode"];
//    
//    NSLog(@"occupCode %@",OccupCode);
	
}
- (void)OccupClassSelected:(NSString *) OccupClass {
	
}

- (IBAction)ActionNationality:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if (_nationalityList == nil) {
        self.nationalityList = [[Nationality alloc] initWithStyle:UITableViewStylePlain];
        _nationalityList.delegate = self;
        self.nationalityPopover = [[UIPopoverController alloc] initWithContentViewController:_nationalityList];
    }
    
    [self.nationalityPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    
}

-(void)selectedNationality:(NSString *)selectedNationality
{
    self.NationalityLbl.text = selectedNationality;
    self.NationalityLbl.textColor = [UIColor blackColor];
    [self.nationalityPopover dismissPopoverAnimated:YES];
    
    
    
}


//-(void)selectedNationality:(NSString *)selectedNationality
//{
//    self.nationalityLbl.text = selectedNationality;
//    self.nationalityLbl.textColor = [UIColor blackColor];
//    [self.nationalityPopover dismissPopoverAnimated:YES];
//}



- (IBAction)ActionOtherID:(id)sender
{
	[self hideKeyboard];
    if (_IDTypeVC == nil) {
        
        self.IDTypeVC = [[IDTypeViewController alloc] initWithStyle:UITableViewStylePlain];
        _IDTypeVC.delegate = self;
      // _IDTypeVC.requestType = @"CO";
        self.IDTypePopover = [[UIPopoverController alloc] initWithContentViewController:_IDTypeVC];
    }
    
    [self.IDTypePopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)ActionDOB:(id)sender
{
	[self hideKeyboard];
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
	[self hideKeyboard];
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
    
    //basvi Added for UAT Bug UATNBNXR0024
    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath1 = [paths1 objectAtIndex:0];
    NSString *path1 = [docsPath1 stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path1];
    [db open];
    
    NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
    NSString *POOtherIDType;
    NSString *selectPO = [NSString stringWithFormat:@"SELECT LAOtherIDType FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'",eProposalNo];
    
    FMResultSet *results1;
    results1 = [db executeQuery:selectPO];
    while ([results1 next]) {
        POOtherIDType = [results1 objectForColumnName:@"LAOtherIDType"];
    }
    
    

	
	if(isPart2Checked) {
//		if (ageForPart2 <= 16 && [PRelationship isEqualToString:@"SELF"] ) {
//            [self actionForPart2:nil];
//		
//		}
//        else if (ageForPart2 <= 16 && [POOtherIDType isEqualToString:@"CR"] )
//        {
//            [self actionForPart2:nil];
//        }
//		else {
			
        [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"TickPart2"];
		[_btnPart2 setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[_btnSameAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
		_btnTitlePO.enabled = YES;
		
		_sexSC.enabled = TRUE;
		_fullNameTF.enabled = YES;
		_telNoTF.enabled = YES;
        _telPhoneNoPrefixTF.enabled = YES;
        _sTelNoTF.enabled = YES;
		_icNoTF.enabled = YES;
		_mobileTF.enabled = YES;
        _mobilePrefixTF.enabled = YES;
		_sMobileTF.enabled = YES;
		
		_btnDOBPO.enabled = YES;
		_emailTF.enabled = YES;
        
        _nameOfEmployerTF.enabled = YES;
        _exactNatureOfWorkTF.enabled = YES;
		
		_btnOtherIDTypePO.enabled = YES;
		_btnRelationshipPO.enabled = YES;
        _btnOccupationPO.enabled =YES;
        _btnNationPO.enabled =YES;
        

		_btnNationality.enabled = YES; // new fields for new proposal form
        
		_btnSameAddress.enabled = YES;
		_btnForeignAddress.enabled = YES;
		_addressTF.enabled = YES;
		_address2TF.enabled = YES;
		_address3TF.enabled = YES;
		_postcodeTF.enabled = YES;
		_townTF.enabled = NO; // this should be NO if it is not Foreign Address
		_btnCountryPO.enabled = NO;_p2 = TRUE;_sa = FALSE;_fa = FALSE;
        
		_btnCRForeignAddress.enabled = YES;
        _CRaddressTF.enabled = YES;
		_CRaddress2TF.enabled = YES;
		_CRaddress3TF.enabled = YES;
		_CRpostcodeTF.enabled = YES;
		_CRtownTF.enabled = NO; // this should be NO if it is not Foreign Address
		_btnCRCountryPO.enabled = NO;_p2 = TRUE;_sa = FALSE;_CRfa = FALSE;
        
        
            
            _lblforparticularsofCO.textColor = [UIColor blackColor];
            _lblforCOmustattainage16andabove.textColor = [UIColor blackColor];
            _lblforTitle.textColor = [UIColor blackColor];
            _lblforsex.textColor = [UIColor blackColor];
            _lblforfullname.textColor = [UIColor blackColor];
            _lblforTelno.textColor = [UIColor blackColor];
            _lblforNewIcno.textColor = [UIColor blackColor];
            _lblformobile.textColor = [UIColor blackColor];
            _lblforOtherIdType.textColor = [UIColor blackColor];
            _lblforEmail.textColor = [UIColor blackColor];
            _lblforOtherId.textColor = [UIColor blackColor];
            _lblforDOB.textColor = [UIColor blackColor];
            _lblforRelationshipwithLA.textColor = [UIColor blackColor];
            _lblforSameaddressasPO.textColor = [UIColor blackColor];
            _lblforForeignAddress.textColor = [UIColor blackColor];
            _lblforAddress.textColor = [UIColor blackColor];
            _lblforPostcode.textColor = [UIColor blackColor];
            _lblforTown.textColor = [UIColor blackColor];
            _lblforState.textColor = [UIColor blackColor];
            _lblforCountry.textColor = [UIColor blackColor];
        
            _lblforCRForeignAddress.textColor = [UIColor blackColor];
            _lblforCRAddress.textColor = [UIColor blackColor];
            _lblforCRPostcode.textColor = [UIColor blackColor];
            _lblforCRTown.textColor = [UIColor blackColor];
            _lblforCRState.textColor = [UIColor blackColor];
            _lblforCRCountry.textColor = [UIColor blackColor];
        
            _lblforResidenceAddressTitle.textColor = [UIColor blackColor]; // new fields for new proposal form
            _lblforCorrespondenceAddressTitle.textColor = [UIColor blackColor]; // new fields for new proposal form
            _lblforNationality.textColor = [UIColor blackColor]; // new fields for new proposal form
            _lblfornameOfEmployer.textColor = [UIColor blackColor]; // new fields for new proposal form
            _lblforOccupation.textColor = [UIColor blackColor]; // new fields for new proposal form
            _lblforExactDuty.textColor = [UIColor blackColor]; // new fields for new proposal form
        
		}
	//}
	else {
        [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickPart2"];
		[_btnPart2 setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnSameAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
		titleLbl.text = @"";
//		titleLbl.textColor = [UIColor lightGrayColor];
		_btnTitlePO.enabled = NO;
		
		_sexSC.enabled = FALSE;
		_sexSC.selectedSegmentIndex = -1;

		_fullNameTF.text = @"";
		_fullNameTF.enabled = NO;

		_telNoTF.text = @"";
		_telNoTF.enabled = NO;
        _telPhoneNoPrefixTF.text = @"";
        _telPhoneNoPrefixTF.enabled = NO;
		
		_sTelNoTF.text = @"";
		_sTelNoTF.enabled = NO;

		_icNoTF.text = @"";
		_icNoTF.enabled = NO;

		_mobileTF.text = @"";
		_mobileTF.enabled = NO;
        _mobilePrefixTF.text = @"";
        _mobilePrefixTF.enabled = NO;
		
		_sMobileTF.text = @"";
		_sMobileTF.enabled = NO;
		
		DOBLbl.text = @"";
//		DOBLbl.textColor = [UIColor lightGrayColor];
		_btnDOBPO.enabled = NO;

		_emailTF.text = @"";
		_emailTF.enabled = NO;
        
        _nameOfEmployerTF.enabled = NO;
		_nameOfEmployerTF.text = @"";
        _exactNatureOfWorkTF.enabled = NO;
		_exactNatureOfWorkTF.text = @"";        

		OtherIDLbl.text = @"";
//		OtherIDLbl.textColor = [UIColor lightGrayColor];
		_btnOtherIDTypePO.enabled = NO;

		_otherIDTF.text = @"";
		_otherIDTF.enabled = NO;

		RelationshipLbl.text = @"";
        OccupationLbl.text = @"";
        NationalityLbl.text =@"";
        
        
//		RelationshipLbl.textColor = [UIColor lightGrayColor];
		_btnRelationshipPO.enabled = NO;
        _btnOccupationPO.enabled =NO;
        _btnNationPO.enabled =NO;

		_btnNationality.enabled = NO; 
        
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
		_stateLbl.text = @"";
		_stateLbl.enabled = NO;
		_countryLbl.text = @"";
		_btnCountryPO.enabled = NO;_p2 = FALSE;_sa = FALSE;_fa = FALSE;
        
		_btnCRForeignAddress.enabled = NO;
		_CRaddressTF.text = @"";
		_CRaddressTF.enabled = NO;
		_CRaddress2TF.text = @"";
		_CRaddress2TF.enabled = NO;
		_CRaddress3TF.text = @"";
		_CRaddress3TF.enabled = NO;
		_CRpostcodeTF.text = @"";
		_CRpostcodeTF.enabled = NO;
		_CRtownTF.text = @"";
		_CRtownTF.enabled = NO;
		_CRstateLbl.text = @"";
		_CRstateLbl.enabled = NO;
		_CRcountryLbl.text = @"";
		_btnCRCountryPO.enabled = NO;_p2 = FALSE;_sa = FALSE;_CRfa = FALSE;
        
        [_btnCRForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        
//        _lblforparticularsofCO.textColor = [UIColor grayColor];
//        _lblforCOmustattainage16andabove.textColor = [UIColor grayColor];
//        _lblforTitle.textColor = [UIColor grayColor];
//        _lblforsex.textColor = [UIColor grayColor];
//        _lblforfullname.textColor = [UIColor grayColor];
//        _lblforTelno.textColor = [UIColor grayColor];
//        _lblforNewIcno.textColor = [UIColor grayColor];
//        _lblformobile.textColor = [UIColor grayColor];
//        _lblforOtherIdType.textColor = [UIColor grayColor];
//        _lblforEmail.textColor = [UIColor grayColor];
//        _lblforOtherId.textColor = [UIColor grayColor];
//        _lblforDOB.textColor = [UIColor grayColor];
//        _lblforRelationshipwithLA.textColor = [UIColor grayColor];
//        _lblforSameaddressasPO.textColor = [UIColor grayColor];
//        _lblforForeignAddress.textColor = [UIColor grayColor];
//        _lblforAddress.textColor = [UIColor grayColor];
//        _lblforPostcode.textColor = [UIColor grayColor];
//        _lblforTown.textColor = [UIColor grayColor];
//        _lblforState.textColor = [UIColor grayColor];
//        _lblforCountry.textColor = [UIColor grayColor];
        
        

        
        
	}

}

- (IBAction)actionForSameAdd:(id)sender {
	if (!skipUpdate) {
		[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
	}
	isSameAddress = !isSameAddress;
	if(isSameAddress) {
		[_btnSameAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[_btnCRForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"SameAddress"];
		_btnCRForeignAddress.enabled = NO;
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"CRForeignAddress"];
		
		_CRaddressTF.text = @"";
		_CRaddressTF.enabled = NO;
		_CRaddress2TF.text = @"";
		_CRaddress2TF.enabled = NO;
		_CRaddress3TF.text = @"";
		_CRaddress3TF.enabled = NO;
		
		_CRpostcodeTF.text = @"";
		_CRpostcodeTF.enabled = NO;
		
		_CRtownTF.text = @"";
		_CRtownTF.enabled = NO;
		
		_CRstateLbl.text = @"State";
		
		_CRcountryLbl.text = @"";
//		_countryLbl.textColor = [UIColor lightGrayColor];
		_btnCRCountryPO.enabled = NO;_sa = TRUE;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsPath = [paths objectAtIndex:0];
        NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
        
        
        FMDatabase *database = [FMDatabase databaseWithPath:path];
        [database open];
        FMResultSet *results1 = [database executeQuery:@"select CorrespondenceAddress, ResidenceAddress1, ResidenceAddress2, ResidenceAddress3, ResidencePostcode, ResidenceTown, ResidenceState, ResidenceCountry, OfficeAddress1, OfficeAddress2, OfficeAddress3, OfficeTown ,OfficeState , OfficePostcode, OfficeCountry from eProposal_LA_Details where eProposalNo = ? and POFlag = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"Y",Nil];
         NSLog(@"result1: %@", [results1 resultDictionary]);
        NSLog(@"errror: %@", [database lastErrorMessage]);
        while ([results1 next]) {
           
			if ([[results1 stringForColumn:@"CorrespondenceAddress"] isEqualToString:@"residence"]) {
				_CRaddressTF.text = [results1 stringForColumn:@"ResidenceAddress1"];
				_CRaddress2TF.text = [results1 stringForColumn:@"ResidenceAddress2"];
				_CRaddress3TF.text = [results1 stringForColumn:@"ResidenceAddress3"];
				_CRpostcodeTF.text = [results1 stringForColumn:@"ResidencePostcode"];
				_CRtownTF.text = [results1 stringForColumn:@"ResidenceTown"];
				_CRstateLbl.text = [self getStateDesc:[results1 stringForColumn:@"ResidenceState"]];
				_CRcountryLbl.text = [self getCountryDesc:[results1 stringForColumn:@"ResidenceCountry"]];
				if (![_CRcountryLbl.text isEqualToString:@"MALAYSIA"]) {
					isCRForeignAddress = TRUE;
					_CRfa = true;
					[_btnCRForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
					[[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"CRForeignAddress"];
				}
				else {
					isCRForeignAddress = FALSE;
					_CRfa = FALSE;
					[_btnCRForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
					[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"CRForeignAddress"];
				}
			}
			else if ([[results1 stringForColumn:@"CorrespondenceAddress"] isEqualToString:@"office"]) {
				_CRaddressTF.text = [results1 stringForColumn:@"OfficeAddress1"];
				_CRaddress2TF.text = [results1 stringForColumn:@"OfficeAddress2"];
				_CRaddress3TF.text = [results1 stringForColumn:@"OfficeAddress3"];
				_CRpostcodeTF.text = [results1 stringForColumn:@"OfficePostcode"];
				_CRtownTF.text = [results1 stringForColumn:@"OfficeTown"];
				_CRstateLbl.text = [self getStateDesc:[results1 stringForColumn:@"OfficeState"]];
				_CRcountryLbl.text = [self getCountryDesc:[results1 stringForColumn:@"OfficeCountry"]];
				if (![_CRcountryLbl.text isEqualToString:@"MALAYSIA"]) {
					isCRForeignAddress = TRUE;
					_CRfa = true;
					[_btnCRForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
					[[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"CRForeignAddress"];
				}
				else {
					isCRForeignAddress = FALSE;
					_CRfa = FALSE;
					[_btnCRForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
					[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"CRForeignAddress"];
				}
			}
			
			
            
        }
        
        [results1 close];
        [database close];
        
        _CRcountryLbl.text = [self getCountryDesc:_CRcountryLbl.text];
		
		_CRaddressTF.textColor = [UIColor lightGrayColor];
		_CRaddress2TF.textColor = [UIColor lightGrayColor];
		_CRaddress3TF.textColor = [UIColor lightGrayColor];
		_CRpostcodeTF.textColor = [UIColor lightGrayColor];
		_CRtownTF.textColor = [UIColor lightGrayColor];
		_CRstateLbl.textColor = [UIColor lightGrayColor];
		_CRcountryLbl.textColor = [UIColor lightGrayColor];

	}
	else { //if not sameaddress
		[_btnSameAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnCRForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"SameAddress"];
		//[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"ForeignAddress"];
		isCRForeignAddress = false;
		_CRfa = FALSE;
		_btnCRForeignAddress.enabled = YES;
		
		_CRaddressTF.enabled = YES;
		_CRaddress2TF.enabled = YES;
		_CRaddress3TF.enabled = YES;
		
		//		_postcodeTF.placeholder = @"Postcode";
		_CRpostcodeTF.enabled = YES;
		
		//		_townTF.placeholder = @"Town";
		_CRtownTF.enabled = NO;  // This should be NO
		
		_CRcountryLbl.text = @"MALAYSIA";
//		_countryLbl.textColor = [UIColor blackColor];
		_btnCRCountryPO.enabled = NO;_sa = FALSE;
        
        _CRaddressTF.text = @"";
        _CRaddress2TF.text = @"";
        _CRaddress3TF.text = @"";
        _CRpostcodeTF.text = @"";
        _CRtownTF.text = @"";
//		_stateLbl.text = @"";
		_CRstateLbl.text = @"State";
		_CRstateLbl.textColor = [UIColor lightGrayColor];
		_CRcountryLbl.text = @"";
		
		_CRaddressTF.textColor = [UIColor blackColor];
		_CRaddress2TF.textColor = [UIColor blackColor];
		_CRaddress3TF.textColor = [UIColor blackColor];
		_CRpostcodeTF.textColor = [UIColor blackColor];
		//_townTF.textColor = [UIColor blackColor];
		//_stateLbl.textColor = [UIColor blackColor];
		//_countryLbl.textColor = [UIColor blackColor];
	}
}

- (IBAction)actionForForeignAdd:(id)sender {
	isForeignAddress = !isForeignAddress;
	if(isForeignAddress) {
		[_btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"ForeignAddress"];
		_addressTF.enabled = YES;
		_addressTF.text = @"";        
		_address2TF.enabled = YES;
		_address2TF.text = @"";        
		_address3TF.enabled = YES;
		_address3TF.text = @"";         
        
		
		_postcodeTF.text = @"";
//		_postcodeTF.textColor = [UIColor lightGrayColor];
//		_postcodeTF.enabled = YES;
//		
		_townTF.text = @"";
//		_townTF.placeholder = @"Town";
		_townTF.textColor = [UIColor blackColor];
		_townTF.enabled = YES;
//
		_stateLbl.text = @"";
		_stateLbl.textColor = [UIColor lightGrayColor];
        
	   _countryLbl.text = @"";
		
//		_countryLbl.text = @"Country";
		_countryLbl.textColor = [UIColor blackColor];
		_btnCountryPO.enabled = YES;_fa = TRUE;
	}
	else {
		[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"ForeignAddress"];
		_addressTF.text = @"";
		_addressTF.enabled = YES;
		_address2TF.text = @"";
		_address2TF.enabled = YES;
		_address3TF.text = @"";
		_address3TF.enabled = YES;
		
		_postcodeTF.text = @"";
		_postcodeTF.enabled = YES;
		
		_townTF.text = @"";
		_townTF.enabled = NO;
		_townTF.textColor = [UIColor lightGrayColor];
//
//		_stateLbl.text = @"State";
		_stateLbl.textColor = [UIColor lightGrayColor];
		
		_countryLbl.text = @"MALAYSIA";
		_countryLbl.textColor = [UIColor lightGrayColor];
		_btnCountryPO.enabled = NO;_fa = FALSE;
	}
}

- (IBAction)actionForCRForeignAdd:(id)sender {
	isCRForeignAddress = !isCRForeignAddress;
	if(isCRForeignAddress) {
		[_btnCRForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"CRForeignAddress"];
		_CRaddressTF.enabled = YES;
		_CRaddressTF.text = @"";
		_CRaddress2TF.enabled = YES;
		_CRaddress2TF.text = @"";
		_CRaddress3TF.enabled = YES;
		_CRaddress3TF.text = @"";
		_CRpostcodeTF.text = @"";
        //		_postcodeTF.textColor = [UIColor lightGrayColor];
        //		_postcodeTF.enabled = YES;
        //
		_CRtownTF.text = @"";
        //		_townTF.placeholder = @"Town";
		_CRtownTF.textColor = [UIColor blackColor];
		_CRtownTF.enabled = YES;
        //
		_CRstateLbl.text = @"";
		_CRstateLbl.textColor = [UIColor lightGrayColor];
        
        _CRcountryLbl.text = @"";
		
        //		_countryLbl.text = @"Country";
		_CRcountryLbl.textColor = [UIColor blackColor];
		_btnCRCountryPO.enabled = YES;
		_CRfa = TRUE;
	}
	else {
		[_btnCRForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"CRForeignAddress"];
		_CRaddressTF.text = @"";
		_CRaddressTF.enabled = YES;
		_CRaddress2TF.text = @"";
		_CRaddress2TF.enabled = YES;
		_CRaddress3TF.text = @"";
		_CRaddress3TF.enabled = YES;
		_CRpostcodeTF.text = @"";
		_CRpostcodeTF.enabled = YES;
		_CRtownTF.text = @"";
		_CRtownTF.enabled = NO;
		_CRtownTF.textColor = [UIColor lightGrayColor];
        //
        //_stateLbl.text = @"State";
		_CRstateLbl.textColor = [UIColor lightGrayColor];
		_CRcountryLbl.text = @"MALAYSIA";
		_CRcountryLbl.textColor = [UIColor lightGrayColor];
		_btnCRCountryPO.enabled = NO;
		_CRfa = FALSE;
	}
}

- (IBAction)actionForCountryPO:(id)sender {
    _isResidential=TRUE;
//	if (_CountryVC == nil) {
//        self.CountryVC = [[CountryPopoverViewController alloc] initWithStyle:UITableViewStylePlain];
//        _CountryVC.delegate = self;
//        self.CountryPopover = [[UIPopoverController alloc] initWithContentViewController:_CountryVC];
//    }
//    [self.CountryPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
	[self hideKeyboard];
	if (_CountryList == nil) {
		
		self.CountryList = [[Country alloc] initWithStyle:UITableViewStylePlain];
		_CountryList.delegate = self;
		self.CountryListPopover = [[UIPopoverController alloc] initWithContentViewController:_CountryList];
    }
    
    [self.CountryListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)actionForCRCountryPO:(id)sender {
    _isResidential=FALSE;
	[self hideKeyboard];
	if (_CountryList == nil) {
		
		self.CountryList = [[Country alloc] initWithStyle:UITableViewStylePlain];
		_CountryList.delegate = self;
		self.CountryListPopover = [[UIPopoverController alloc] initWithContentViewController:_CountryList];
    }
    
    [self.CountryListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)SelectedCountry:(NSString *)theCountry
{
    if (_isResidential) {
        _countryLbl.text = theCountry;
        _countryLbl.textColor = [UIColor blackColor];
    }else
    {
        _CRcountryLbl.text = theCountry;
        _CRcountryLbl.textColor = [UIColor blackColor];
    }
    
	[self.CountryListPopover dismissPopoverAnimated:YES];
	[self hideKeyboard];
	
}

//-(void)selectedCountry:(NSString *)selectedCountry {
//    _countryLbl.text = selectedCountry;
//	_countryLbl.textColor = [UIColor blackColor];
//    [_CountryPopover dismissPopoverAnimated:YES];
//}


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
				_stateLbl.textColor = [UIColor lightGrayColor];
				_townTF.text = Town;
				_townTF.enabled = NO;
				_townTF.textColor = [UIColor lightGrayColor];
				_countryLbl.text = @"MALAYSIA";
				_countryLbl.textColor = [UIColor lightGrayColor];
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

- (IBAction)editingDidEndCRPostcode:(id)sender {
	if (!isCRForeignAddress) {
		
        const char *dbpath = [databasePath UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
            NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", _CRpostcodeTF.text];
            const char *query_stmt = [querySQL UTF8String];
            if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_ROW){
                    NSString *Town = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    NSString *State = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    NSString *Statecode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                    
                    _CRstateLbl.text = State;
                    _CRstateLbl.textColor = [UIColor lightGrayColor];
                    _CRtownTF.text = Town;
                    _CRtownTF.enabled = NO;
                    _CRtownTF.textColor = [UIColor lightGrayColor];
                    _CRcountryLbl.text = @"MALAYSIA";
                    _CRcountryLbl.textColor = [UIColor lightGrayColor];
                    
                    
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }}
	else {
		_CRtownTF.placeholder = @"Town";
		_CRtownTF.enabled = YES;
		
		_CRstateLbl.text = @"State";
		_CRstateLbl.textColor = [UIColor lightGrayColor];
	}
}

#pragma mark - delegate

-(void)IDTypeDescSelected:(NSString *)selectedIDType
{
    OtherIDLbl.text = selectedIDType;
	OtherIDLbl.textColor =  [UIColor blackColor];
    [self.IDTypePopover dismissPopoverAnimated:YES];
	_otherIDTF.enabled = YES;
	
	if ([OtherIDLbl.text isEqualToString:@"BIRTH CERTIFICATE"] || [OtherIDLbl.text isEqualToString:@"OLD IDENTIFICATION NO"] || [OtherIDLbl.text isEqualToString:@"PASSPORT"] || OtherIDLbl.text == NULL || [OtherIDLbl.text isEqualToString:@""] || [OtherIDLbl.text isEqualToString:@"- SELECT -"]) {
		//_nricLbl.text = @"";
		_icNoTF.enabled = YES;
	}
	else {
		_icNoTF.text = @"";
		_icNoTF.enabled = NO;
		if (_btnDOBPO.enabled == FALSE) {
			DOBLbl.text = @"";
			_btnDOBPO.enabled = TRUE;
			//ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
			DOBLbl.textColor = [UIColor blackColor];
			_sexSC.enabled = TRUE;
			_sexSC.selectedSegmentIndex = -1;
		}
		
	}
	//_icNoTF.enabled = YES;
}

-(void)IDTypeCodeSelected:(NSString *)IDTypeCode {
	IDTypeCodeSelected = IDTypeCode;
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

//-(void)selectedTitle:(NSString *)selectedTitle
//{
//    titleLbl.text = selectedTitle;
//	titleLbl.textColor = [UIColor blackColor];
//    [self.TitlePickerPopover dismissPopoverAnimated:YES];
//}
-(void)selectedTitleDesc:(NSString *)selectedTitle
{
    titleLbl.text = selectedTitle;
	titleLbl.textColor = [UIColor blackColor];
    [self.TitlePickerPopover dismissPopoverAnimated:YES];
}

-(void)selectedTitleCode:(NSString *)Titlecode {
	TitleCodeSelected = Titlecode;
}

-(void)selectedRelationship:(NSString *)theRelation
{
    RelationshipLbl.text = theRelation;
	RelationshipLbl.textColor = [UIColor blackColor];
    [self.RelationshipPopover dismissPopoverAnimated:YES];
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    _postcodeTF.adjustsFontSizeToFitWidth = YES;
    _postcodeTF.minimumFontSize = 0;
    _icNoTF.adjustsFontSizeToFitWidth = YES;
    _icNoTF.minimumFontSize = 0;
    _fullNameTF.adjustsFontSizeToFitWidth = YES;
    _fullNameTF.minimumFontSize = 0;
    _emailTF.adjustsFontSizeToFitWidth = YES;
    _emailTF.minimumFontSize = 0;
    _townTF.adjustsFontSizeToFitWidth = YES;
    _townTF.minimumFontSize = 0;
    _otherIDTF.adjustsFontSizeToFitWidth = YES;
    _otherIDTF.minimumFontSize = 0;
    _telNoTF.adjustsFontSizeToFitWidth = YES;
    _telNoTF.minimumFontSize = 0;
    _mobileTF.adjustsFontSizeToFitWidth = YES;
    _mobileTF.minimumFontSize = 0;
    
    
    
    
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
	
	else if (textField == _CRpostcodeTF) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		if (isCRForeignAddress) {
			return ((newLength <= CHARACTER_LIMIT_PC_F));
		}
		else {
			NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
			NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
			return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_PC_NF));
		}
	}
	
	else if (textField == _icNoTF) {
        
        NSLog(@"icnumb");
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_ICNO));
	}
	
	else if (textField == _telNoTF || textField == _mobileTF)
    {
        
         NSLog(@"telNo");
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return ([string isEqualToString:filtered] && newLength <= 10);
        
        NSLog(@"telNo");
	}
    else if (textField == _telPhoneNoPrefixTF || textField == _mobilePrefixTF) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return ([string isEqualToString:filtered] && newLength <= 4);
        NSLog(@"telPrefix");
    }
	else if (textField == _fullNameTF) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:CHAR_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return ([string isEqualToString:filtered] && newLength <= 50);
    }
	else if (textField == _emailTF) {
        
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		return (newLength <= 40);
    }
    
    else if (textField ==_exactNatureOfWorkTF)
    {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		return (newLength <= 40);
    }
    else if (textField == _otherIDTF) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		return (newLength <= 30);
    }
	else if (textField == _addressTF || textField == _address2TF || textField == _address3TF) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		return (newLength <= 30);
    }
	else if (textField == _CRaddressTF || textField == _CRaddress2TF || textField == _CRaddress3TF) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		return (newLength <= 30);
    }
	else if (textField == _townTF || textField == _CRtownTF ) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		return (newLength <= 40);
    }
	else if (textField == _nameOfEmployerTF) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		return (newLength <= 50);
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
			_countryLbl.textColor = [UIColor lightGrayColor];
		}
		else {
			//_townTF.text = @"";
			_stateLbl.text = @"State";
			_stateLbl.textColor = [UIColor lightGrayColor];
			//_countryLbl.text = @"Country";
			_countryLbl.textColor = [UIColor blackColor];
		}
		
	}
    else if (textField == _CRpostcodeTF)
    {
		if (!isCRForeignAddress) {
			_CRtownTF.text = @"";
			_CRstateLbl.text = @"State";
			_CRstateLbl.textColor = [UIColor lightGrayColor];
			_CRcountryLbl.text = @"MALAYSIA";
			_CRcountryLbl.textColor = [UIColor lightGrayColor];
		}
		else {
			//_townTF.text = @"";
			_CRstateLbl.text = @"State";
			_CRstateLbl.textColor = [UIColor lightGrayColor];
			//_countryLbl.text = @"Country";
			_CRcountryLbl.textColor = [UIColor blackColor];
		}
		
	}
        
}

-(void)detectChanges1:(id) sender
{
    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
}

-(void)NewICDidChange:(id) sender
{
	NSString *gender;
    
	if (_icNoTF.text.length == 12) {
		
		BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[_icNoTF.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
        valid = [alphaNums isSupersetOfSet:inStringSet];
        if (!valid) {
           
        }
        else {
            
            NSString *last = [_icNoTF.text substringFromIndex:[_icNoTF.text length] -1];
            NSCharacterSet *oddSet = [NSCharacterSet characterSetWithCharactersInString:@"13579"];
            
            if ([last rangeOfCharacterFromSet:oddSet].location != NSNotFound) {
                NSLog(@"MALE");
                _sexSC.selectedSegmentIndex = 0;
                gender = @"MALE";
            } else {
                NSLog(@"FEMALE");
                _sexSC.selectedSegmentIndex = 1;
                gender = @"FEMALE";
            }
            _sexSC.enabled = FALSE;
			
            //get the DOB value from ic entered
            NSString *strDate = [_icNoTF.text substringWithRange:NSMakeRange(4, 2)];
            NSString *strMonth = [_icNoTF.text substringWithRange:NSMakeRange(2, 2)];
            NSString *strYear = [_icNoTF.text substringWithRange:NSMakeRange(0, 2)];
            
            //get value for year whether 20XX or 19XX
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy"];
            
            NSString *currentYear = [dateFormatter stringFromDate:[NSDate date]];
            NSString *strCurrentYear = [currentYear substringWithRange:NSMakeRange(2, 2)];
            if ([strYear intValue] > [strCurrentYear intValue] && !([strYear intValue] < 30)) {
                strYear = [NSString stringWithFormat:@"19%@",strYear];
            }
            else {
                strYear = [NSString stringWithFormat:@"20%@",strYear];
            }
            
            NSString *strDOB = [NSString stringWithFormat:@"%@/%@/%@",strDate,strMonth,strYear];
            NSString *strDOB2 = [NSString stringWithFormat:@"%@-%@-%@",strYear,strMonth,strDate];
            
            
            //determine day of february
            NSString *febStatus = nil;
            float devideYear = [strYear floatValue]/4;
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
            NSDate *d = [NSDate date];
            NSDate *d2 = [dateFormatter dateFromString:strDOB2];
            
            if ([d compare:d2] == NSOrderedAscending) {
                
                if([_otherIDTF.text isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    DOBLbl.text = @"";
                    _sexSC.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
            }
            else if ([strMonth intValue] > 12 || [strMonth intValue] < 1) {
                if([_otherIDTF.text isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    DOBLbl.text = @"";
                    _sexSC.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
            }
            else if([strDate intValue] < 1 || [strDate intValue] > 31)
            {
                
            }
            else if (([strMonth isEqualToString:@"01"] || [strMonth isEqualToString:@"03"] || [strMonth isEqualToString:@"05"] || [strMonth isEqualToString:@"07"] || [strMonth isEqualToString:@"08"] || [strMonth isEqualToString:@"10"] || [strMonth isEqualToString:@"12"]) && [strDate intValue] > 31) {
				
				if([_otherIDTF.text isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    DOBLbl.text = @"";
                    _sexSC.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
                
            }
            
            else if (([strMonth isEqualToString:@"04"] || [strMonth isEqualToString:@"06"] || [strMonth isEqualToString:@"09"] || [strMonth isEqualToString:@"11"]) && [strDate intValue] > 30) {
                
                
				if([_otherIDTF.text isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    DOBLbl.text = @"";
                    _sexSC.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
                
            }
            else if (([febStatus isEqualToString:@"Normal"] && [strDate intValue] > 28 && [strMonth isEqualToString:@"02"]) || ([febStatus isEqualToString:@"Jump"] && [strDate intValue] > 29 && [strMonth isEqualToString:@"02"])) {
			
                
				if([_otherIDTF.text isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    DOBLbl.text = @"";
                    _sexSC.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
            }
            else {
				
				DOBLbl.text = strDOB;
                _btnDOBPO.enabled = FALSE;
                //ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
                DOBLbl.textColor = [UIColor lightGrayColor];
            }
            
            last = nil, oddSet = nil;
            strDate = nil, strMonth = nil, strYear = nil, currentYear = nil, strCurrentYear = nil;
            dateFormatter = Nil, strDOB = nil, strDOB2 = nil, d = Nil, d2 = Nil;
        }
        
        alphaNums = nil, inStringSet = nil;

	}
	else {
		
		DOBLbl.text = @"";
		_btnDOBPO.enabled = TRUE;
		//ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
		DOBLbl.textColor = [UIColor blackColor];
		_sexSC.enabled = TRUE;
		_sexSC.selectedSegmentIndex = -1;
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
    [self setOccupationLbl:nil];
    [self setNationalityLbl:nil];
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
    [self setBtnOccupationPO:nil];
    [self setBtnNationPO:nil];
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
    [self setTelPhoneNoPrefixTF:nil];
    [self setMobilePrefixTF:nil];
    
	[self setCRaddressTF:nil];
	[self setCRaddress2TF:nil];
	[self setCRaddress3TF:nil];
	[self setCRpostcodeTF:nil];
	[self setCRtownTF:nil];
	[self setCRstateLbl:nil];
	[self setCRcountryLbl:nil];
	[self setBtnCRCountryPO:nil];
    
    
    [self setNameOfEmployerTF:nil];
    [self setExactNatureOfWorkTF:nil];
    
    [self setOccupationLbl:nil];
    [super viewDidUnload];
}

-(NSString*) getCountryCode : (NSString*)country
{
	
	if ([country isEqualToString:@""] || (country == NULL) || ([country isEqualToString:@"(NULL)"])) {
		return @"";
	}
	
    NSString *code;
    country = [country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT CountryCode FROM eProposal_Country WHERE CountryDesc = ?", country];
    
	NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        code =[result objectForColumnName:@"CountryCode"];
        
        NSLog(@"code");
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
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
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


-(NSString*) getIDTypeDesc : (NSString*)IDtype
{
    NSString *desc;
	IDtype = [IDtype stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
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

//For NM Title
-(NSString*) getTitleDesc : (NSString*)Title
{
    NSString *desc;
    Title = [Title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT TitleDesc FROM eProposal_Title WHERE TitleCode = ?", Title];
    
    NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        desc =[result objectForColumnName:@"TitleDesc"];
		TitleCodeSelected = Title;
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
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT TitleCode FROM eProposal_Title WHERE TitleDesc = ?", Title];
    
    while ([result next]) {
        code =[result objectForColumnName:@"TitleCode"];
    }
	
    [result close];
    [db close];
	
	TitleCodeSelected = code;
	
}
-(void)hideKeyboard{
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (![[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLA EverLife Plus"] || [[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"UV"] || [[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"UP"] || [[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLA EverGain Plus"])

    if (ageForPart2 < 16) {
       
        if (indexPath.section==1 ) {
            
            UITableViewCell *updateCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
            updateCell.userInteractionEnabled=YES;
            // updateCell.backgroundColor=[UIColor blackColor];
            _lblforparticularsofCO.textColor = [UIColor blackColor];
            _lblforCOmustattainage16andabove.textColor = [UIColor blackColor];
            _lblforTitle.textColor = [UIColor blackColor];
            _lblforsex.textColor = [UIColor blackColor];
            _lblforfullname.textColor = [UIColor blackColor];
            _lblforTelno.textColor = [UIColor blackColor];
            _lblforNewIcno.textColor = [UIColor blackColor];
            _lblformobile.textColor = [UIColor blackColor];
            _lblforOtherIdType.textColor = [UIColor blackColor];
            _lblforEmail.textColor = [UIColor blackColor];
            _lblforOtherId.textColor = [UIColor blackColor];
            _lblforDOB.textColor = [UIColor blackColor];
            _lblforRelationshipwithLA.textColor = [UIColor blackColor];
            _lblforSameaddressasPO.textColor = [UIColor blackColor];
            _lblforForeignAddress.textColor = [UIColor blackColor];
            _lblforAddress.textColor = [UIColor blackColor];
            _lblforPostcode.textColor = [UIColor blackColor];
            _lblforTown.textColor = [UIColor blackColor];
            _lblforState.textColor = [UIColor blackColor];
            _lblforCountry.textColor = [UIColor blackColor];
           // updateCell.alpha=0.6;
            
            _lblforCRForeignAddress.textColor = [UIColor blackColor];
            _lblforCRAddress.textColor = [UIColor blackColor];
            _lblforCRPostcode.textColor = [UIColor blackColor];
            _lblforCRTown.textColor = [UIColor blackColor];
            _lblforCRState.textColor = [UIColor blackColor];
            _lblforCRCountry.textColor = [UIColor blackColor];
            
            _lblforResidenceAddressTitle.textColor = [UIColor blackColor]; // new fields for new proposal form
            _lblforCorrespondenceAddressTitle.textColor = [UIColor blackColor]; // new fields for new proposal form
            _lblforNationality.textColor = [UIColor blackColor]; // new fields for new proposal form
            _lblfornameOfEmployer.textColor = [UIColor blackColor]; // new fields for new proposal form
            _lblforOccupation.textColor = [UIColor blackColor]; // new fields for new proposal form
            _lblforExactDuty.textColor = [UIColor blackColor]; // new fields for new proposal form
            
            
        }
        
    }
    
    else
    {
        UITableViewCell *updateCell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
        updateCell.userInteractionEnabled=YES;
        // updateCell.backgroundColor=[UIColor grayColor];
        _lblforparticularsofCO.textColor = [UIColor grayColor];
        _lblforCOmustattainage16andabove.textColor = [UIColor grayColor];
        _lblforTitle.textColor = [UIColor grayColor];
        _lblforsex.textColor = [UIColor grayColor];
        _lblforfullname.textColor = [UIColor grayColor];
        _lblforTelno.textColor = [UIColor grayColor];
        _lblforNewIcno.textColor = [UIColor grayColor];
        _lblformobile.textColor = [UIColor grayColor];
        _lblforOtherIdType.textColor = [UIColor grayColor];
        _lblforEmail.textColor = [UIColor grayColor];
        _lblforOtherId.textColor = [UIColor grayColor];
        _lblforDOB.textColor = [UIColor grayColor];
        _lblforRelationshipwithLA.textColor = [UIColor grayColor];
        _lblforSameaddressasPO.textColor = [UIColor grayColor];
        _lblforForeignAddress.textColor = [UIColor grayColor];
        _lblforAddress.textColor = [UIColor grayColor];
        _lblforPostcode.textColor = [UIColor grayColor];
        _lblforTown.textColor = [UIColor grayColor];
        _lblforState.textColor = [UIColor grayColor];
        _lblforCountry.textColor = [UIColor grayColor];
        
        _lblforCRForeignAddress.textColor = [UIColor grayColor];
        _lblforCRAddress.textColor = [UIColor grayColor];
        _lblforCRPostcode.textColor = [UIColor grayColor];
        _lblforCRTown.textColor = [UIColor grayColor];
        _lblforCRState.textColor = [UIColor grayColor];
        _lblforCRCountry.textColor = [UIColor grayColor];
        
        _lblforResidenceAddressTitle.textColor = [UIColor grayColor]; // new fields for new proposal form
        _lblforCorrespondenceAddressTitle.textColor = [UIColor grayColor]; // new fields for new proposal form
        _lblforNationality.textColor = [UIColor grayColor]; // new fields for new proposal form
        _lblfornameOfEmployer.textColor = [UIColor grayColor]; // new fields for new proposal form
        _lblforOccupation.textColor = [UIColor grayColor]; // new fields for new proposal form
        _lblforExactDuty.textColor = [UIColor grayColor]; // new fields for new proposal form
        
        
       // updateCell.alpha=0.6;
   
    }
    
    
}


@end
