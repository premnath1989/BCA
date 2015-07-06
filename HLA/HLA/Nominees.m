//
//  Nominees.m
//  iMobile Planner
//
//  Created by shawal sapuan on 7/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "Nominees.h"
#import "ColorHexCode.h"
#import "DataClass.h"
#import "NomineesTrustees.h"
#import "FMDatabase.h"


#define CHARACTER_LIMIT_ICNO 12
#define NUMBERS_ONLY @"0123456789"
#define CHARACTER_LIMIT_PC_F 12
#define CHARACTER_LIMIT_PC_NF 5
#define CHARACTER_LIMIT_NAME 50
#define CHAR_ONLY @"ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz./@'()-"
#define CHAR_NO @"ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz./@'()-1234567890"

@interface Nominees ()
{
    DataClass *obj;
     int totalshare;
	BOOL employerMandatory;
    BOOL isforgeinAddChecked;
}
@end

@implementation Nominees
@synthesize isSameAddress;
@synthesize nameTF = _nameTF;
@synthesize IDTypeCodeSelected;
@synthesize TitleCodeSelected;
@synthesize StateCode,occupationLbl,nationalityLbl;
@synthesize CountryListPopover = _CountryListPopover;
@synthesize OccupationListPopover = _OccupationListPopover;
@synthesize nationalityPopover =_nationalityPopover;
int minus = 0;

void UIKeyboardOrderOutAutomatic();


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

	_nameTF.delegate = self;
    _exactDuty.delegate =self;
    _add1TF.delegate =self;
    _add2TF.delegate =self;
    _add3TF.delegate =self;
    _townTF.delegate =self;
    _nameOfEmployerTF.delegate = self;
    _CRadd1TF.delegate =self;
    _CRadd2TF.delegate =self;
    _CRadd3TF.delegate =self;
    _CRtownTF.delegate =self;
	
	_CRpostcodeTF.delegate = self;
	_postcodeTF.delegate = self;
    isforgeinAddChecked = NO;
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
    
    //KY Display the Nominee details from obj
    obj = [DataClass getInstance];
    _sexSC.selectedSegmentIndex = -1;
    
    _btnDelete.hidden = TRUE;
    _cellDelete.hidden = TRUE;
    
    //ky
     NSString *share ;
    if([[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"] == NULL)
    {
        share  = [NSString stringWithFormat:@"Current Total Share: 0%%"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"0" forKey:@"TotalShare"];
    }
    else
        share  = [NSString stringWithFormat:@"Current Total Share: %@%%", [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"]];
    
    _totalShareLbl.text = share;
    [_sharePercentageTF setDelegate:self];
    //ky
    
    _townTF.enabled = FALSE;
    _stateLbl.enabled = FALSE;
	_otherIDTF.enabled = FALSE;
	
    if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"1"])
    {
        _titleLbl.text = [self getTitleDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_title"]];
         TitleCodeSelected = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_title"];
        _titleLbl.textColor = [UIColor blackColor];
        _nameTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_name"];
		NSLog(@"naa: %@", _nameTF.text);
        _icNoTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_ic"];
        _otherIDTypeLbl2.text = [self getIDTypeDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_otherIDType"]];
		if (IDTypeCodeSelected == NULL)
		IDTypeCodeSelected = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_otherIDType"];
        _otherIDTypeLbl2.textColor = [UIColor blackColor];
        _otherIDTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_otherID"];
		if (_otherIDTypeLbl2.text.length > 0 && !([_otherIDTypeLbl2.text isEqualToString:@"- SELECT -"])) {
			_otherIDTF.enabled = TRUE;
		}
		else {
			_otherIDTF.enabled = FALSE;
		}
    
        _dobLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_dob"];
        _dobLbl.textColor = [UIColor blackColor];
        
        if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_gender"] isEqualToString:@"male"])
            _sexSC.selectedSegmentIndex = 0;
        else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_gender"] isEqualToString:@"female"])
            _sexSC.selectedSegmentIndex =1 ;
        
        _sharePercentageTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_share"];
		minus = [_sharePercentageTF.text intValue];
        _relationshipLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_relatioship"];
        _relationshipLbl.textColor = [UIColor blackColor];
        
        nationalityLbl.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_nationality"];
        nationalityLbl.textColor = [UIColor blackColor];
        nationalityLbl.enabled = FALSE;
        
        occupationLbl.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_Occupation"];
        occupationLbl.textColor = [UIColor blackColor];
        occupationLbl.enabled = FALSE;
        
//        if([occupationLbl.text isEqualToString:@"HOUSEWIFE"]||[occupationLbl.text isEqualToString:@"STUDENT"]||[occupationLbl.text isEqualToString:@"JUVENILE"]||[occupationLbl.text isEqualToString:@"RETIRED"]||[occupationLbl.text isEqualToString:@"UNEMPLOYED"]||[occupationLbl.text isEqualToString:@"TEMPORARILY UNEMPLOYED"])
//        {
//            _nameOfEmployerTF.enabled =FALSE;
//            _nameOfEmployerTF.text =@"";
//            _nameOfEmployerTF.textColor = [UIColor blackColor];
//            
//            _exactDuty.enabled =FALSE;
//            _exactDuty.text =@"";
//            _exactDuty.textColor = [UIColor blackColor];
//            
//        }
        
//        else
//        {
//            _nameOfEmployerTF.enabled =TRUE;
            _nameOfEmployerTF.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_nameofemployer"];
            _nameOfEmployerTF.textColor = [UIColor blackColor];
            
//            _exactDuty.enabled =TRUE;
            _exactDuty.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_ExactDuties"];
            _exactDuty.textColor = [UIColor blackColor];
            
//        }
//        _nameOfEmployerTF.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_nameofemployer"];
//        _nameOfEmployerTF.textColor = [UIColor blackColor];
        
        if(_nameTF.text == NULL || [_nameTF.text isEqual: @""])
        {
            _btnDelete.hidden = TRUE;
            _cellDelete.hidden = TRUE;
            
        }
        else
        {
            _btnDelete.hidden = FALSE;
            _cellDelete.hidden = FALSE;
        }
        
		
		_CRadd1TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRadd1TF"];
        _CRadd2TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRadd2TF"];
        _CRadd3TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRadd3TF"];
        _CRpostcodeTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRpostcodeTF"];
        _CRtownTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRtownTF"];
        //_CRstateLbl.text = @"State";
        _CRstateLbl.text = [self getStateDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRstateTF"]];
        //StateCode = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_stateTF"];
        _CRcountryLbl.text = [self getCountryDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRcountryTF"]];
		if (_CRcountryLbl.text == nil)
			_CRcountryLbl.text = @"";
		
//		_CRadd1TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_CRadd1TF"];
//        _CRadd2TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_CRadd2TF"];
//        _CRadd3TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_CRadd3TF"];
//        _CRpostcodeTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_CRpostcodeTF"];
//        _CRtownTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_CRtownTF"];
//       // _CRstateLbl.text = @"State";
//        _CRstateLbl.text = [self getStateDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_CRstateTF"]];
        //StateCode = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_stateTF"];
//        _CRcountryLbl.text = [self getCountryDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_CRcountryTF"]];
		
//        if ([_CRcountryLbl.text isEqualToString:@"MALAYSIA"]){
//			isCRForeignAddress = FALSE;
//			_CRfa = FALSE;
//			_CRcountryLbl.textColor = [UIColor lightGrayColor];
//			_CRbtnCountryPO.enabled = FALSE;
//			_CRtownTF.textColor = [UIColor lightGrayColor];
//			_CRtownTF.enabled = FALSE;
//			
//		}
//		else {
//			isCRForeignAddress = TRUE;
//			_CRfa = TRUE;
//			_CRcountryLbl.textColor = [UIColor blackColor];
//			_CRbtnCountryPO.enabled = TRUE;
//			[_btnCRForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
//			_btnCRForeignAddress.tag = 1;
//			_CRtownTF.textColor = [UIColor blackColor];
//			_CRtownTF.enabled = TRUE;
//		}
		
		if ([_CRcountryLbl.text isEqualToString:@"MALAYSIA"]){
			isCRForeignAddress = FALSE;
			_CRfa = FALSE;
			_CRcountryLbl.textColor = [UIColor lightGrayColor];
			_CRbtnCountryPO.enabled = FALSE;
			_CRtownTF.textColor = [UIColor lightGrayColor];
			_CRtownTF.enabled = FALSE;
			
		}
		else if (![_CRcountryLbl.text isEqualToString:@"MALAYSIA"] && ![_CRcountryLbl.text isEqualToString:@""]){
			isCRForeignAddress = TRUE;
			_CRfa = TRUE;
			_CRcountryLbl.textColor = [UIColor blackColor];
			_CRbtnCountryPO.enabled = TRUE;
			[_btnCRForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
			_btnCRForeignAddress.tag = 1;
			_CRtownTF.textColor = [UIColor blackColor];
			_CRtownTF.enabled = TRUE;
		}
		
        
        //[self SelectedCountry:_CRcountryLbl.text];
        
		
		
		_add1TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add1TF"];
		_add2TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add2TF"];
		_add3TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add3TF"];
		_postcodeTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_postcodeTF"];
		_townTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_townTF"];
		_stateLbl.text = @"State";
		_countryLbl.text = [self getCountryDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_countryTF"]];
		if (_countryLbl.text == nil)
			_countryLbl.text = @"";
		if ([_countryLbl.text isEqualToString:@"MALAYSIA"]){
			_stateLbl.text = [self getStateDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_stateTF"]];
			StateCode = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_stateTF"];
			_townTF.enabled = FALSE;
			_townTF.textColor = [UIColor lightGrayColor];
			_stateLbl.enabled = FALSE;
			_stateLbl.textColor = [UIColor lightGrayColor];
			_countryLbl.textColor = [UIColor lightGrayColor];
			_btnCountryPO.enabled = FALSE;
			_fa = FALSE;
        }
        else if (![_countryLbl.text isEqualToString:@"MALAYSIA"] && ![_countryLbl.text isEqualToString:@""])
		{
			_fa = TRUE;
			_countryLbl.textColor = [UIColor blackColor];
			_btnCountryPO.enabled = TRUE;
            isForeignAddress = TRUE;
			[_btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
//			[self actionForForeignAdd:nil];
			_btnForeignAddress.tag = 1;
		}

		
		if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_Address"] isEqualToString:@"same"])
		{   [_btnSameAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
			_btnSameAddress.tag = 1;
			//isSameAddress = true;
			[self actionForSameAdd:nil];
		}


    }

    else if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"2"])
    {
        _titleLbl.text = [self getTitleDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_title"]];
        TitleCodeSelected = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_title"];
        _titleLbl.textColor = [UIColor blackColor];
        
        _nameTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_name"];
        _icNoTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_ic"];
        _otherIDTypeLbl2.text = [self getIDTypeDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_otherIDType"]];
		if (IDTypeCodeSelected == NULL)
		IDTypeCodeSelected = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_otherIDType"];
        _otherIDTypeLbl2.textColor = [UIColor blackColor];
        
        _otherIDTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_otherID"];
        if (_otherIDTypeLbl2.text.length > 0 && !([_otherIDTypeLbl2.text isEqualToString:@"- SELECT -"])) {
			_otherIDTF.enabled = TRUE;
		}
			else {
				_otherIDTF.enabled = FALSE;
		}
        _dobLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_dob"];
        _dobLbl.textColor = [UIColor blackColor];
        
        if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_gender"] isEqualToString:@"male"])
            _sexSC.selectedSegmentIndex = 0;
         else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_gender"] isEqualToString:@"female"])
            _sexSC.selectedSegmentIndex =1 ;
        
        _sharePercentageTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_share"];
		minus = [_sharePercentageTF.text intValue];
        _relationshipLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_relatioship"];
        _relationshipLbl.textColor = [UIColor blackColor];
        
        nationalityLbl.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_nationality"];
        nationalityLbl.textColor = [UIColor blackColor];
        
        occupationLbl.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_Occupation"];
        occupationLbl.textColor = [UIColor blackColor];
        
//        if([occupationLbl.text isEqualToString:@"HOUSEWIFE"]||[occupationLbl.text isEqualToString:@"STUDENT"]||[occupationLbl.text isEqualToString:@"JUVENILE"]||[occupationLbl.text isEqualToString:@"RETIRED"]||[occupationLbl.text isEqualToString:@"UNEMPLOYED"]||[occupationLbl.text isEqualToString:@"TEMPORARILY UNEMPLOYED"])
//        {
//            _nameOfEmployerTF.enabled =FALSE;
//            _nameOfEmployerTF.text =@"";
//            _nameOfEmployerTF.textColor = [UIColor blackColor];
//            
//            _exactDuty.enabled =FALSE;
//            _exactDuty.text =@"";
//            _exactDuty.textColor = [UIColor blackColor];
//            
//        }
//        
//        else
//        {
//            _nameOfEmployerTF.enabled =TRUE;
            _nameOfEmployerTF.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_nameofemployer"];
            _nameOfEmployerTF.textColor = [UIColor blackColor];
            
//            _exactDuty.enabled =TRUE;
            _exactDuty.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_ExactDuties"];
            _exactDuty.textColor = [UIColor blackColor];
            
//        }

        
//        _exactDuty.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_ExactDuties"];
//        _exactDuty.textColor = [UIColor blackColor];
//        
//        _nameOfEmployerTF.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_nameofemployer"];
//        _nameOfEmployerTF.textColor = [UIColor blackColor];
        
        if(_nameTF.text == NULL || [_nameTF.text isEqual: @""])

        {
            _btnDelete.hidden = TRUE;
            _cellDelete.hidden = TRUE;
        }
        else
        {
            _btnDelete.hidden = FALSE;
            _cellDelete.hidden = FALSE;
        }
        
		_CRadd1TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_CRadd1TF"];
        _CRadd2TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_CRadd2TF"];
        _CRadd3TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_CRadd3TF"];
        _CRpostcodeTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_CRpostcodeTF"];
        _CRtownTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_CRtownTF"];
        //_CRstateLbl.text = @"State";
        _CRstateLbl.text = [self getStateDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_CRstateTF"]];
        //StateCode = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_stateTF"];
        _CRcountryLbl.text = [self getCountryDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_CRcountryTF"]];
		if (_CRcountryLbl.text == nil)
			_CRcountryLbl.text = @"";
		if ([_CRcountryLbl.text isEqualToString:@"MALAYSIA"]){
			isCRForeignAddress = FALSE;
			_CRfa = FALSE;
			_CRcountryLbl.textColor = [UIColor lightGrayColor];
			_CRbtnCountryPO.enabled = FALSE;
			_CRtownTF.textColor = [UIColor lightGrayColor];
			_CRtownTF.enabled = FALSE;
			
		}
		else if (![_CRcountryLbl.text isEqualToString:@"MALAYSIA"] && ![_CRcountryLbl.text isEqualToString:@""]){
			isCRForeignAddress = TRUE;
			_CRfa = TRUE;
			_CRcountryLbl.textColor = [UIColor blackColor];
			_CRbtnCountryPO.enabled = TRUE;
			[_btnCRForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
			_btnCRForeignAddress.tag = 1;
			_CRtownTF.textColor = [UIColor blackColor];
			_CRtownTF.enabled = TRUE;
		}

		
        if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_Address"] isEqualToString:@"same"])
        {   [_btnSameAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            _btnSameAddress.tag = 1;
            //isSameAddress = true;
            [self actionForSameAdd:nil];
        }
		
		_add1TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_add1TF"];
		_add2TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_add2TF"];
		_add3TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_add3TF"];
		
		_postcodeTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_postcodeTF"];
		_townTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_townTF"];
//		_stateLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_stateTF"];
//		_stateLbl.text = @"State";
		_countryLbl.text = [self getCountryDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_countryTF"]];
		
		if (_countryLbl.text == nil)
			_countryLbl.text = @"";
		if ([_countryLbl.text isEqualToString:@"MALAYSIA"]){
			_stateLbl.text = [self getStateDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_stateTF"]];
			StateCode = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_stateTF"];
			_townTF.enabled = FALSE;
			_townTF.textColor = [UIColor lightGrayColor];
			_stateLbl.enabled = FALSE;
			_stateLbl.textColor = [UIColor lightGrayColor];
			_countryLbl.textColor = [UIColor lightGrayColor];
			_btnCountryPO.enabled = FALSE;
			_fa = FALSE;
        }
        else if (![_countryLbl.text isEqualToString:@"MALAYSIA"] && ![_countryLbl.text isEqualToString:@""])
		{
			_fa = TRUE;
			_countryLbl.textColor = [UIColor blackColor];
			_btnCountryPO.enabled = TRUE;
			[_btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
			//			[self actionForForeignAdd:nil];
			_btnForeignAddress.tag = 1;
		}
            
    }
	
	
	
	
    else if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"3"])
    {
        _titleLbl.text = [self getTitleDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_title"]];
        TitleCodeSelected = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_title"];
        _titleLbl.textColor = [UIColor blackColor];
        
        _nameTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_name"];
        _icNoTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_ic"];
        _otherIDTypeLbl2.text = [self getIDTypeDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_otherIDType"]];
		if (IDTypeCodeSelected == NULL)
		IDTypeCodeSelected = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_otherIDType"];
         _otherIDTypeLbl2.textColor = [UIColor blackColor];
        
        _otherIDTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_otherID"];
		if (_otherIDTypeLbl2.text.length > 0 && !([_otherIDTypeLbl2.text isEqualToString:@"- SELECT -"])) {
			_otherIDTF.enabled = TRUE;
		}
		else {
			_otherIDTF.enabled = FALSE;
		}
        _dobLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_dob"];
        _dobLbl.textColor = [UIColor blackColor];
        
        if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_gender"] isEqualToString:@"male"])
            _sexSC.selectedSegmentIndex = 0;
         else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_gender"] isEqualToString:@"female"])
            _sexSC.selectedSegmentIndex =1 ;
        
        _sharePercentageTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_share"];
		minus = [_sharePercentageTF.text intValue];
        _relationshipLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_relatioship"];
        _relationshipLbl.textColor = [UIColor blackColor];
        
        nationalityLbl.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_nationality"];
        nationalityLbl.textColor = [UIColor blackColor];
        
        occupationLbl.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_Occupation"];
        occupationLbl.textColor = [UIColor blackColor];
     
//        if([occupationLbl.text isEqualToString:@"HOUSEWIFE"]||[occupationLbl.text isEqualToString:@"STUDENT"]||[occupationLbl.text isEqualToString:@"JUVENILE"]||[occupationLbl.text isEqualToString:@"RETIRED"]||[occupationLbl.text isEqualToString:@"UNEMPLOYED"]||[occupationLbl.text isEqualToString:@"TEMPORARILY UNEMPLOYED"])
//        {
//            _nameOfEmployerTF.enabled =FALSE;
//            _nameOfEmployerTF.text =@"";
//            _nameOfEmployerTF.textColor = [UIColor blackColor];
//            
//            _exactDuty.enabled =FALSE;
//            _exactDuty.text =@"";
//            _exactDuty.textColor = [UIColor blackColor];
//            
//        }
//        
//        else
//        {
//            _nameOfEmployerTF.enabled =TRUE;
            _nameOfEmployerTF.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_nameofemployer"];
            _nameOfEmployerTF.textColor = [UIColor blackColor];
            
//            _exactDuty.enabled =TRUE;
            _exactDuty.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_ExactDuties"];
            _exactDuty.textColor = [UIColor blackColor];
            
//        }

        
//        _exactDuty.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_ExactDuties"];
//        _exactDuty.textColor = [UIColor blackColor];
//        
//        _nameOfEmployerTF.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_nameofemployer"];
//        _nameOfEmployerTF.textColor = [UIColor blackColor];
        
	
        if(_nameTF.text == NULL || [_nameTF.text isEqual: @""])

        {
            _btnDelete.hidden = TRUE;
            _cellDelete.hidden = TRUE;
        }
        else
        {
            _btnDelete.hidden = FALSE;
            _cellDelete.hidden = FALSE;
        }
		
		_CRadd1TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_CRadd1TF"];
        _CRadd2TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_CRadd2TF"];
        _CRadd3TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_CRadd3TF"];
        _CRpostcodeTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_CRpostcodeTF"];
        _CRtownTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_CRtownTF"];
        //_CRstateLbl.text = @"State";
        _CRstateLbl.text = [self getStateDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_CRstateTF"]];
        //StateCode = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_stateTF"];
        _CRcountryLbl.text = [self getCountryDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_CRcountryTF"]];
		if (_CRcountryLbl.text == nil)
			_CRcountryLbl.text = @"";
        if ([_CRcountryLbl.text isEqualToString:@"MALAYSIA"]){
			isCRForeignAddress = FALSE;
			_CRfa = FALSE;
			_CRcountryLbl.textColor = [UIColor lightGrayColor];
			_CRbtnCountryPO.enabled = FALSE;
			_CRtownTF.textColor = [UIColor lightGrayColor];
			_CRtownTF.enabled = FALSE;
			
		}
		else if (![_CRcountryLbl.text isEqualToString:@"MALAYSIA"] && ![_CRcountryLbl.text isEqualToString:@""]){
			isCRForeignAddress = TRUE;
			_CRfa = TRUE;
			_CRcountryLbl.textColor = [UIColor blackColor];
			_CRbtnCountryPO.enabled = TRUE;
			[_btnCRForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
			_btnCRForeignAddress.tag = 1;
			_CRtownTF.textColor = [UIColor blackColor];
			_CRtownTF.enabled = TRUE;
		}
		
		
        if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_Address"] isEqualToString:@"same"])
        {   [_btnSameAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            _btnSameAddress.tag = 1;
            //isSameAddress = true;
            [self actionForSameAdd:nil];
        }
        
		_add1TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_add1TF"];
		_add2TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_add2TF"];
		_add3TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_add3TF"];
		
		_postcodeTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_postcodeTF"];
		_townTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_townTF"];
		_stateLbl.text = [self getStateDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_stateTF"]];
		StateCode = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_stateTF"];
		_countryLbl.text = [self getCountryDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_countryTF"]];
		
		if (_countryLbl.text == nil)
			_countryLbl.text = @"";
		
		if ([_countryLbl.text isEqualToString:@"MALAYSIA"]){
			_townTF.enabled = FALSE;
			_townTF.textColor = [UIColor lightGrayColor];
			_stateLbl.enabled = FALSE;
			_stateLbl.textColor = [UIColor lightGrayColor];
			_countryLbl.textColor = [UIColor lightGrayColor];
			_btnCountryPO.enabled = FALSE;
			_fa = FALSE;
        }
        else if (![_countryLbl.text isEqualToString:@"MALAYSIA"] && ![_countryLbl.text isEqualToString:@""])
		{
			_fa = TRUE;
			_countryLbl.textColor = [UIColor blackColor];
			_btnCountryPO.enabled = TRUE;
			[_btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
			//			[self actionForForeignAdd:nil];
			_btnForeignAddress.tag = 1;
			_stateLbl.text = @"State";
		}
		

        
    }
    else if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"4"])
    {
        _titleLbl.text = [self getTitleDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_title"]];
        TitleCodeSelected = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_title"];
        _titleLbl.textColor = [UIColor blackColor];
        
        _nameTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_name"];
        _icNoTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_ic"];
        _otherIDTypeLbl2.text = [self getIDTypeDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_otherIDType"]];
		if (IDTypeCodeSelected == NULL)
		IDTypeCodeSelected = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_otherIDType"];
        _otherIDTypeLbl2.textColor = [UIColor blackColor];
        
        _otherIDTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_otherID"];
		if (_otherIDTypeLbl2.text.length > 0 && !([_otherIDTypeLbl2.text isEqualToString:@"- SELECT -"])) {
			_otherIDTF.enabled = TRUE;
		}
		else {
			_otherIDTF.enabled = FALSE;
		}
        _dobLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_dob"];
        _dobLbl.textColor = [UIColor blackColor];
        
        if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_gender"] isEqualToString:@"male"])
            _sexSC.selectedSegmentIndex = 0;
        else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_gender"] isEqualToString:@"female"])
            _sexSC.selectedSegmentIndex =1 ;
        
        _sharePercentageTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_share"];
		minus = [_sharePercentageTF.text intValue];
        _relationshipLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_relatioship"];
        _relationshipLbl.textColor = [UIColor blackColor];
        
        nationalityLbl.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_nationality"];
        nationalityLbl.textColor = [UIColor blackColor];
        
        occupationLbl.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_Occupation"];
        occupationLbl.textColor = [UIColor blackColor];
        
//        if([occupationLbl.text isEqualToString:@"HOUSEWIFE"]||[occupationLbl.text isEqualToString:@"STUDENT"]||[occupationLbl.text isEqualToString:@"JUVENILE"]||[occupationLbl.text isEqualToString:@"RETIRED"]||[occupationLbl.text isEqualToString:@"UNEMPLOYED"]||[occupationLbl.text isEqualToString:@"TEMPORARILY UNEMPLOYED"])
//        {
//            _nameOfEmployerTF.enabled =FALSE;
//            _nameOfEmployerTF.text =@"";
//            _nameOfEmployerTF.textColor = [UIColor blackColor];
//            
//            _exactDuty.enabled =FALSE;
//            _exactDuty.text =@"";
//            _exactDuty.textColor = [UIColor blackColor];
//            
//        }
//        
//        else
//        {
//            _nameOfEmployerTF.enabled =TRUE;
            _nameOfEmployerTF.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_nameofemployer"];
            _nameOfEmployerTF.textColor = [UIColor blackColor];
            
//            _exactDuty.enabled =TRUE;
            _exactDuty.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_ExactDuties"];
            _exactDuty.textColor = [UIColor blackColor];
            
//        }

        
//        _exactDuty.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_ExactDuties"];
//        _exactDuty.textColor = [UIColor blackColor];
//        
//        _nameOfEmployerTF.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_nameofemployer"];
//        _nameOfEmployerTF.textColor = [UIColor blackColor];
        
	
        if(_nameTF.text == NULL || [_nameTF.text isEqual: @""])
        {
            _btnDelete.hidden = TRUE;
            _cellDelete.hidden = TRUE;
        }
        else
        {
            _btnDelete.hidden = FALSE;
            _cellDelete.hidden = FALSE;
        }

		_CRadd1TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_CRadd1TF"];
        _CRadd2TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_CRadd2TF"];
        _CRadd3TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_CRadd3TF"];
        _CRpostcodeTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_CRpostcodeTF"];
        _CRtownTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_CRtownTF"];
		// _CRstateLbl.text = @"State";
        _CRstateLbl.text = [self getStateDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_CRstateTF"]];
        //StateCode = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_stateTF"];
        _CRcountryLbl.text = [self getCountryDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_CRcountryTF"]];
		if (_CRcountryLbl.text == nil)
			_CRcountryLbl.text = @"";
        if ([_CRcountryLbl.text isEqualToString:@"MALAYSIA"]){
			isCRForeignAddress = FALSE;
			_CRfa = FALSE;
			_CRcountryLbl.textColor = [UIColor lightGrayColor];
			_CRbtnCountryPO.enabled = FALSE;
			_CRtownTF.textColor = [UIColor lightGrayColor];
			_CRtownTF.enabled = FALSE;
			
		}
		else if (![_CRcountryLbl.text isEqualToString:@"MALAYSIA"] && ![_CRcountryLbl.text isEqualToString:@""]){
			isCRForeignAddress = TRUE;
			_CRfa = TRUE;
			_CRcountryLbl.textColor = [UIColor blackColor];
			_CRbtnCountryPO.enabled = TRUE;
			[_btnCRForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
			_btnCRForeignAddress.tag = 1;
			_CRtownTF.textColor = [UIColor blackColor];
			_CRtownTF.enabled = TRUE;
		}
		
        if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_Address"] isEqualToString:@"same"])
        {   //[_btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
//            [self actionForForeignAdd:nil];
            _btnSameAddress.tag = 1;
            //isSameAddress = true;
            [self actionForSameAdd:nil];
        }
        
		_add1TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_add1TF"];
		_add2TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_add2TF"];
		_add3TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_add3TF"];
		
		_postcodeTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_postcodeTF"];
		_townTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_townTF"];
		_stateLbl.text = [self getStateDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_stateTF"]];
		StateCode = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_stateTF"];
		_countryLbl.text = [self getCountryDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_countryTF"]];
		
		if (_countryLbl.text == nil)
			_countryLbl.text = @"";
		
		if ([_countryLbl.text isEqualToString:@"MALAYSIA"]){
			_townTF.enabled = FALSE;
			_townTF.textColor = [UIColor lightGrayColor];
			_stateLbl.enabled = FALSE;
			_stateLbl.textColor = [UIColor lightGrayColor];
			_countryLbl.textColor = [UIColor lightGrayColor];
			_btnCountryPO.enabled = FALSE;
			_fa = FALSE;
			isForeignAddress = FALSE;
			[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
			_btnForeignAddress.tag = 0;
        }
        else if (![_countryLbl.text isEqualToString:@"MALAYSIA"] && ![_countryLbl.text isEqualToString:@""])
		{
			_fa = TRUE;
			_countryLbl.textColor = [UIColor blackColor];
			_btnCountryPO.enabled = TRUE;
			[_btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
			//			[self actionForForeignAdd:nil];
			_btnForeignAddress.tag = 1;
			_stateLbl.text = @"State";
			isForeignAddress = TRUE;
		}
		

        
    }

	if ([_otherIDTypeLbl2.text isEqualToString:@"BIRTH CERTIFICATE"] || [_otherIDTypeLbl2.text isEqualToString:@"OLD IDENTIFICATION NO"] || [_otherIDTypeLbl2.text isEqualToString:@"PASSPORT"] || _otherIDTypeLbl2.text == NULL || [_otherIDTypeLbl2.text isEqualToString:@""] || [_otherIDTypeLbl2.text isEqualToString:@"- SELECT -"]) {
		//_nricLbl.text = @"";
		_icNoTF.enabled = YES;
	}
	else {
		_icNoTF.text = @"";
		_icNoTF.enabled = NO;
//		_dobLbl.text = @"";
		_btnDOBPO.enabled = TRUE;
		//ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
		_dobLbl.textColor = [UIColor blackColor];
		_sexSC.enabled = TRUE;
//		_sexSC.selectedSegmentIndex = -1;
	}
	
	
	if (_icNoTF.text.length == 12) {
		//_dobLbl.text = @"";
		_btnDOBPO.enabled = false;
		_dobLbl.textColor = [UIColor grayColor];
		_sexSC.enabled = false;
		//_sexSC.selectedSegmentIndex = -1;
	}
	else {
		//_dobLbl.text = @"";
		_btnDOBPO.enabled = TRUE;
		_dobLbl.textColor = [UIColor blackColor];
		_sexSC.enabled = TRUE;
		//_sexSC.selectedSegmentIndex = -1;
	}
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	tap.delegate = self;
	[self.view addGestureRecognizer:tap];
    
    occupationLbl.enabled =false;
    nationalityLbl.enabled =FALSE;
	
	
	[_nameTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_icNoTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_otherIDTypeLbl2 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_sharePercentageTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_add1TF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_add2TF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_add3TF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_postcodeTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_townTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	
	[_icNoTF addTarget:self action:@selector(NewICDidChange:) forControlEvents:UIControlEventEditingDidEnd];
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

- (void)textFieldDidEndEditing:(UITextField*)textField {
    if (textField==_sharePercentageTF) {
        // [levelEntryTextField endEditing:YES];
        //[levelEntryTextField removeFromSuperview];
        // here is where you should do something with the data they entered
        // NSString *total =  [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"];
        int total = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"] intValue];
        int add = [_sharePercentageTF.text intValue];
        totalshare = total + add - minus;
//        if(total > 100)
//        {
//            UIAlertView *alert = [[UIAlertView alloc]
//                                  initWithTitle: @" "
//                                  message: @"Total Percentage of Share exceeded 100%"
//                                  delegate: self
//                                  cancelButtonTitle:@"OK"
//                                  otherButtonTitles:nil];
//            [alert setTag:1003];
//            [alert show];
//            alert = Nil;
//            _sharePercentageTF.text = @"";
//        }
//        else
//        {
            NSString  *share  = [NSString stringWithFormat:@"%i",totalshare];
            
            // [[obj.eAppData objectForKey:@"SecD"] setValue:share forKey:@"TotalShare"];
            
            NSString  *stringshare  = [NSString stringWithFormat:@"Current Total Share: %@%%", share];
            
            _totalShareLbl.text = stringshare;
//        }
    }
}

- (void)btnDone:(id)sender
{
    [self resignFirstResponder];
    [self dismissModalViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)donePressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)actionForCountry:(id)sender {
	
	[self hideKeyboard];
    _isResidential =TRUE;
	if (_CountryList == nil) {
		
	self.CountryList = [[Country alloc] initWithStyle:UITableViewStylePlain];
	_CountryList.delegate = self;
	self.CountryListPopover = [[UIPopoverController alloc] initWithContentViewController:_CountryList];
    }
    
    [self.CountryListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)actionForCRCountry:(id)sender
{
    [self hideKeyboard];
    _isResidential =FALSE;
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



- (IBAction)actionForForeignAdd:(id)sender {
	[self hideKeyboard];
	isForeignAddress = !isForeignAddress;
	if(isForeignAddress) {
        
        isforgeinAddChecked = YES;
		[_btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        _btnForeignAddress.tag = 1;
		isForeignAddress = YES;
		_add1TF.enabled = YES;
		_add2TF.enabled = YES;
		_add3TF.enabled = YES;
		
		_add1TF.textColor = [UIColor blackColor];
		_add2TF.textColor = [UIColor blackColor];
		_add3TF.textColor = [UIColor blackColor];
		
        _add1TF.text = @"";
        _add2TF.text = @"";
        _add3TF.text = @"";
        
		_postcodeTF.text = @"";
		_postcodeTF.textColor = [UIColor blackColor];
		//		_postcodeTF.textColor = [UIColor lightGrayColor];
		//		_postcodeTF.enabled = YES;
		//
		_townTF.text = @"";
		_townTF.enabled = YES;
		//		_townTF.placeholder = @"Town";
		_townTF.textColor = [UIColor blackColor];
		
		//
		_stateLbl.text = @"State";
		_stateLbl.textColor = [UIColor lightGrayColor];
		
		_countryLbl.text = @"";
		_countryLbl.textColor = [UIColor blackColor];
		_btnCountryPO.enabled = YES;
		_fa = TRUE;
	}
	else {
        isforgeinAddChecked = NO;
		[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        _btnForeignAddress.tag = 0;
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
		_townTF.textColor = [UIColor lightGrayColor];
		_countryLbl.text = @"MALAYSIA";
		_countryLbl.textColor = [UIColor lightGrayColor];
		_btnCountryPO.enabled = NO;
		_fa = FALSE;
	}
}

- (IBAction)actionForCRForeignAdd:(id)sender
{
    [self hideKeyboard];
	isCRForeignAddress= !isCRForeignAddress;
	if(isCRForeignAddress) {
		[_btnCRForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        _btnCRForeignAddress.tag = 1;
		
		_CRadd1TF.enabled = YES;
		_CRadd2TF.enabled = YES;
		_CRadd3TF.enabled = YES;
		
		_CRadd1TF.textColor = [UIColor blackColor];
		_CRadd2TF.textColor = [UIColor blackColor];
		_CRadd3TF.textColor = [UIColor blackColor];
		
        _CRadd1TF.text = @"";
        _CRadd2TF.text = @"";
        _CRadd3TF.text = @"";
        
		_CRpostcodeTF.text = @"";
		_CRpostcodeTF.textColor = [UIColor blackColor];
		//		_postcodeTF.textColor = [UIColor lightGrayColor];
		//		_postcodeTF.enabled = YES;
		//
		_CRtownTF.text = @"";
		_CRtownTF.enabled = YES;
		//		_townTF.placeholder = @"Town";
		_CRtownTF.textColor = [UIColor blackColor];
		
		//
		_CRstateLbl.text = @"State";
		_CRstateLbl.textColor = [UIColor lightGrayColor];
		
		_CRcountryLbl.text = @"";
		_CRcountryLbl.textColor = [UIColor blackColor];
		_CRbtnCountryPO.enabled = YES;
        _CRfa = TRUE;
	}
	else {
		[_btnCRForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        _btnCRForeignAddress.tag = 0;
		_CRadd1TF.text = @"";
		_CRadd1TF.enabled = YES;
		_CRadd2TF.text = @"";
		_CRadd2TF.enabled = YES;
		_CRadd3TF.text = @"";
		_CRadd3TF.enabled = YES;
		
		_CRpostcodeTF.text = @"";
		_CRpostcodeTF.enabled = YES;
		
		_CRtownTF.text = @"";
		_CRtownTF.enabled = NO;
		_CRtownTF.textColor = [UIColor lightGrayColor];
		//
		//		_stateLbl.text = @"State";
		//		_stateLbl.textColor = [UIColor lightGrayColor];
		
		_CRcountryLbl.text = @"MALAYSIA";
		_CRcountryLbl.textColor = [UIColor lightGrayColor];
		_CRbtnCountryPO.enabled = NO;
		_CRfa = FALSE;
	}
}

- (IBAction)actionForSameAdd:(id)sender {
	isSameAddress = !isSameAddress;
	if(isSameAddress) {
		[_btnSameAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[_btnCRForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"SameAddress"];
		_btnSameAddress.tag = 1;
		_btnCRForeignAddress.enabled = NO;
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"CRForeignAddress"];
		
		_CRadd1TF.text = @"";
		_CRadd1TF.enabled = NO;
		_CRadd2TF.text = @"";
		_CRadd2TF.enabled = NO;
		_CRadd3TF.text = @"";
		_CRadd3TF.enabled = NO;
		
		_CRpostcodeTF.text = @"";
		_CRpostcodeTF.enabled = NO;
		
		_CRtownTF.text = @"";
		_CRtownTF.enabled = NO;
		
		_CRstateLbl.text = @"State";
		
		_CRcountryLbl.text = @"";
        //		_countryLbl.textColor = [UIColor lightGrayColor];
		_CRbtnCountryPO.enabled = NO;_sa = TRUE;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsPath = [paths objectAtIndex:0];
        NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:path];
        [database open];
        FMResultSet *results1 = [database executeQuery:@"select ResidenceAddress1, ResidenceAddress2, ResidenceAddress3, ResidencePostcode, ResidenceTown, ResidenceState, ResidenceCountry from eProposal_LA_Details where eProposalNo = ? and POFlag = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"Y",Nil];
        NSLog(@"result1: %@", [results1 resultDictionary]);
        NSLog(@"errror: %@", [database lastErrorMessage]);
        while ([results1 next]) {
            
            _CRadd1TF.text = [results1 stringForColumn:@"ResidenceAddress1"];
            _CRadd2TF.text = [results1 stringForColumn:@"ResidenceAddress2"];
            _CRadd3TF.text = [results1 stringForColumn:@"ResidenceAddress3"];
            _CRpostcodeTF.text = [results1 stringForColumn:@"ResidencePostcode"];
            _CRtownTF.text = [results1 stringForColumn:@"ResidenceTown"];
            _CRstateLbl.text = [self getStateDesc:[results1 stringForColumn:@"ResidenceState"]];
            _CRcountryLbl.text = [self getCountryDesc:[results1 stringForColumn:@"ResidenceCountry"]];
        }
        
        [results1 close];
        [database close];
        
        _CRcountryLbl.text = [self getCountryDesc:_CRcountryLbl.text];
		
		_CRadd1TF.textColor = [UIColor lightGrayColor];
		_CRadd2TF.textColor = [UIColor lightGrayColor];
		_CRadd3TF.textColor = [UIColor lightGrayColor];
		_CRpostcodeTF.textColor = [UIColor lightGrayColor];
		_CRtownTF.textColor = [UIColor lightGrayColor];
		_CRstateLbl.textColor = [UIColor lightGrayColor];
		_CRcountryLbl.textColor = [UIColor lightGrayColor];
        
	}
	else { //if not sameaddress
		[_btnSameAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnCRForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"SameAddress"];
        _btnSameAddress.tag = 2;
        _CRcountryLbl.text = @"MALAYSIA";
		//[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"ForeignAddress"];
		isCRForeignAddress = false;
		
		_btnCRForeignAddress.enabled = YES;
		
		_CRadd1TF.enabled = YES;
		_CRadd2TF.enabled = YES;
		_CRadd3TF.enabled = YES;
		
		//		_postcodeTF.placeholder = @"Postcode";
		_CRpostcodeTF.enabled = YES;
		
		//		_townTF.placeholder = @"Town";
		_CRtownTF.enabled = NO;  // This should be NO
		
		_CRcountryLbl.text = @"MALAYSIA";
        //		_countryLbl.textColor = [UIColor blackColor];
		_btnCountryPO.enabled = NO;_sa = FALSE;
        
        _CRadd1TF.text = @"";
        _CRadd2TF.text = @"";
        _CRadd3TF.text = @"";
        _CRpostcodeTF.text = @"";
        _CRtownTF.text = @"";
        //		_stateLbl.text = @"";
		_CRstateLbl.text = @"State";
		_CRstateLbl.textColor = [UIColor lightGrayColor];
		_CRcountryLbl.text = @"";
		
		_CRadd1TF.textColor = [UIColor blackColor];
		_CRadd2TF.textColor = [UIColor blackColor];
		_CRadd3TF.textColor = [UIColor blackColor];
		_CRpostcodeTF.textColor = [UIColor blackColor];
		//_townTF.textColor = [UIColor blackColor];
		//_stateLbl.textColor = [UIColor blackColor];
		//_countryLbl.textColor = [UIColor blackColor];
	}
}

- (IBAction)actionForRelationship:(id)sender {
    
    UIKeyboardOrderOutAutomatic();
	if (_RelationshipVC == nil) {
		
        self.RelationshipVC = [[Relationship alloc] initWithStyle:UITableViewStylePlain];
        _RelationshipVC.delegate = self;
        _RelationshipVC.requestType = @"nominees";
        self.RelationshipPopover = [[UIPopoverController alloc] initWithContentViewController:_RelationshipVC];
    }
    [self.RelationshipPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)selectedRelationship:(NSString *)theRelation
{
    _relationshipLbl.text = theRelation;
	_relationshipLbl.textColor = [UIColor blackColor];
    [self.RelationshipPopover dismissPopoverAnimated:YES];
}

- (IBAction)actionForDOB:(id)sender {
    
    UIKeyboardOrderOutAutomatic();
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    //_dobLbl.text = dateString;
	_dobLbl.textColor = [UIColor blackColor];
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
    _dobLbl.text = strDate;
	_dobLbl.textColor = [UIColor blackColor];
}

-(void)CloseWindow
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [self.SIDatePopover dismissPopoverAnimated:YES];
}

- (IBAction)actionForOtherIDType:(id)sender {
    
    UIKeyboardOrderOutAutomatic();
	if (_IDTypeVC == nil) {
        
        self.IDTypeVC = [[IDTypeViewController alloc] initWithStyle:UITableViewStylePlain];
        _IDTypeVC.delegate = self;
		_IDTypeVC.IDSelect = _otherIDTypeLbl2.text;
        self.IDTypePopover = [[UIPopoverController alloc] initWithContentViewController:_IDTypeVC];
    }
    
    [self.IDTypePopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

}

-(void)IDTypeDescSelected:(NSString *)selectedIDType
{
    _otherIDTypeLbl2.text = selectedIDType;
	_otherIDTypeLbl2.textColor =  [UIColor blackColor];
    [self.IDTypePopover dismissPopoverAnimated:YES];
	_otherIDTF.enabled = YES;
	

	if ([_otherIDTypeLbl2.text isEqualToString:@"BIRTH CERTIFICATE"] || [_otherIDTypeLbl2.text isEqualToString:@"OLD IDENTIFICATION NO"] || [_otherIDTypeLbl2.text isEqualToString:@"PASSPORT"] || _otherIDTypeLbl2.text == NULL || [_otherIDTypeLbl2.text isEqualToString:@""] || [_otherIDTypeLbl2.text isEqualToString:@"- SELECT -"]) {
		//_nricLbl.text = @"";
		_icNoTF.enabled = YES;
	}
	else {
		if (_btnDOBPO.enabled == FALSE) {
			_dobLbl.text = @"";
			_btnDOBPO.enabled = TRUE;
			_sexSC.enabled = TRUE;
			_sexSC.selectedSegmentIndex = -1;
		}
		_icNoTF.text = @"";
		_icNoTF.enabled = NO;
		//ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
		_dobLbl.textColor = [UIColor blackColor];
	}
}

-(void)IDTypeCodeSelected:(NSString *)IDTypeCode {
	IDTypeCodeSelected = IDTypeCode;
}




- (IBAction)actionForTitle:(id)sender {
   
    UIKeyboardOrderOutAutomatic();
    
	if (_TitlePicker == nil) {
        _TitlePicker = [[TitleViewController alloc] initWithStyle:UITableViewStylePlain];
        _TitlePicker.delegate = self;
        self.TitlePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_TitlePicker];
    }
    
    [self.TitlePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

-(void)selectedTitleDesc:(NSString *)selectedTitle
{
    _titleLbl.text = selectedTitle;
	_titleLbl.textColor = [UIColor blackColor];
    [self.TitlePickerPopover dismissPopoverAnimated:YES];
}

-(void)selectedTitleCode:(NSString *)Titlecode {
	TitleCodeSelected = Titlecode;
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
    self.nationalityLbl.text = selectedNationality;
    self.nationalityLbl.textColor = [UIColor blackColor];
    [self.nationalityPopover dismissPopoverAnimated:YES];
    
    
    
}


//-(void)selectedNationality:(NSString *)selectedNationality
//{
//    self.nationalityLbl.text = selectedNationality;
//    self.nationalityLbl.textColor = [UIColor blackColor];
//    [self.nationalityPopover dismissPopoverAnimated:YES];
//}

-(IBAction)ActionOccupation:(id)sender
{
 
	[self hideKeyboard];
	
    if (_OccupationList == nil)
    {
        self.OccupationList = [[OccupationList alloc] initWithStyle:UITableViewStylePlain];
        _OccupationList.delegate = self;
        self.OccupationListPopover = [[UIPopoverController alloc] initWithContentViewController:_OccupationList];
    }
    
    
    [self.OccupationListPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    
    NSLog(@"t1");
}

- (void)OccupDescSelected:(NSString *) OccupDesc
{
    NSLog(@"t2 %@",OccupDesc);
    
//    if([OccupDesc isEqualToString:@"HOUSEWIFE"]||[OccupDesc isEqualToString:@"STUDENT"]||[OccupDesc isEqualToString:@"JUVENILE"]||[OccupDesc isEqualToString:@"RETIRED"]||[OccupDesc isEqualToString:@"UNEMPLOYED"]||[OccupDesc isEqualToString:@"TEMPORARILY UNEMPLOYED"])
//        {
//           // _nameOfEmployerTF.enabled =FALSE;
//            //_nameOfEmployerTF.text=@"";
//            _nameOfEmployerTF.text =[_nameOfEmployerTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//           // _exactDuty.enabled =FALSE;
//           // _exactDuty.text =@"";
//            _nameOfEmployerTF.text = [_nameOfEmployerTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//            _nameOfEmployerTF.text.length==0;
//            
//        }
//    
//    else
//    {
////         _nameOfEmployerTF.enabled =TRUE;
//       // _nameOfEmployerTF.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_nameofemployer"];
//        
//        _exactDuty.enabled =TRUE;
//       // _exactDuty.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_nameofemployer"];
//
//        
//    }
	
	self.occupationLbl.text = OccupDesc;
	self.occupationLbl.textColor = [UIColor blackColor];
    [self.OccupationListPopover dismissPopoverAnimated:YES];
    
    
}

- (void)OccupCodeSelected:(NSString *) OccupCode
{
    [obj.eAppData setValue:OccupCode forKey:@"LAOccupationCode"];
    
    NSLog(@"occupCode %@",OccupCode);
	
	
	
	
	
}

- (void)OccupClassSelected:(NSString *) OccupClass {
	
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
					StateCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
					
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


-(void)textFieldDidBeginEditing:(UITextField *)textField {
	
	if (textField == _postcodeTF) {
		if (!isForeignAddress) {
			_townTF.text = @"";
			_stateLbl.textColor = [UIColor lightGrayColor];
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
			//_countryLbl.textColor = [UIColor lightGrayColor];
		}
		
	}
}

-(NSString*) getStateDesc : (NSString*)state
{
    NSString *desc;
	state = [state stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT StateDesc FROM eProposal_state WHERE stateCode = ?", state];
    
    NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        desc =[result objectForColumnName:@"stateDesc"];
    }
	
    [result close];
    [db close];
    
	if (count == 0) {
		if (state.length > 0) {
			if ([state isEqualToString:@"State"]){
				desc = @"";
			}
			else {
				desc = state;
				[self getStateCode:state];
			}
		}
	}
    return desc;
}

-(void) getStateCode : (NSString*)state
{
    NSString *code;
	state = [state stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT stateCode FROM eProposal_state WHERE StateDesc = ?", state];
    
    while ([result next]) {
        code =[result objectForColumnName:@"StateDesc"];
    }
	
    [result close];
    [db close];
	
	StateCode = code;
	
}

- (IBAction)editingDidEndShare:(id)sender {
//	[_delegate updateTotalSharePct:_sharePercentageTF.text];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    _postcodeTF.adjustsFontSizeToFitWidth = YES;
    _postcodeTF.minimumFontSize = 0;
    _icNoTF.adjustsFontSizeToFitWidth = YES;
    _icNoTF.minimumFontSize = 0;
    _nameTF.adjustsFontSizeToFitWidth = YES;
    _nameTF.minimumFontSize = 0;
//    _exactDuty.adjustsFontSizeToFitWidth = YES;
//    _exactDuty.minimumFontSize = 0;
    _townTF.adjustsFontSizeToFitWidth = YES;
    _townTF.minimumFontSize = 0;
    _CRtownTF.adjustsFontSizeToFitWidth = YES;
    _CRtownTF.minimumFontSize = 0;
    _otherIDTF.adjustsFontSizeToFitWidth = YES;
    _otherIDTF.minimumFontSize = 0;
//    _nameOfEmployerTF.adjustsFontSizeToFitWidth = YES;
//    _nameOfEmployerTF.minimumFontSize = 0;


    
	NSUInteger newLength = [textField.text length] + [string length] - range.length;
	if (textField == _postcodeTF) {
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
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_ICNO));
	}
	else if (textField == _sharePercentageTF) {
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 3));
	}
	else if (textField == _nameTF) {
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:CHAR_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_NAME));
	}
    
//    else if (textField == _nameOfEmployerTF) {
//		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:CHAR_NO] invertedSet];
//		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//		return (([string isEqualToString:filtered])&&(newLength <= 60));
//	}

	else if (textField == _otherIDTF) {
		return ((newLength <= 30));
	}
	else if ((textField == _townTF)|| (textField == _CRtownTF))
    {
		return ((newLength <= 40));
	}
	else if ((textField == _add1TF)|| (textField == _add2TF) || (textField == _add3TF) || (textField == _CRadd1TF)|| (textField == _CRadd2TF) || (textField == _CRadd3TF)) {
		return ((newLength <= 30));
	}
	return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

	NSUInteger newLength = [textView.text length] + [text length] - range.length;
    if (textView == _nameOfEmployerTF) {
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:CHAR_NO] invertedSet];
		NSString *filtered = [[text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([text isEqualToString:filtered])&&(newLength <= 60));
	}
	else if (textView == _exactDuty)
    {
        return ((newLength <= 40));
    }
    return YES;
}

-(void)detectChanges:(id) sender
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
                    _dobLbl.text = @"";
                    _sexSC.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
            }
            else if ([strMonth intValue] > 12 || [strMonth intValue] < 1) {
                if([_otherIDTF.text isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    _dobLbl.text = @"";
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
                    _dobLbl.text = @"";
                    _sexSC.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
                
            }
            
            else if (([strMonth isEqualToString:@"04"] || [strMonth isEqualToString:@"06"] || [strMonth isEqualToString:@"09"] || [strMonth isEqualToString:@"11"]) && [strDate intValue] > 30) {
                
                
				if([_otherIDTF.text isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    _dobLbl.text = @"";
                    _sexSC.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
                
            }
            else if (([febStatus isEqualToString:@"Normal"] && [strDate intValue] > 28 && [strMonth isEqualToString:@"02"]) || ([febStatus isEqualToString:@"Jump"] && [strDate intValue] > 29 && [strMonth isEqualToString:@"02"])) {
				
                
				if([_otherIDTF.text isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    _dobLbl.text = @"";
                    _sexSC.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
            }
            else {
				
				_dobLbl.text = strDOB;
                _btnDOBPO.enabled = FALSE;
                //ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
                _dobLbl.textColor = [UIColor lightGrayColor];
            }
            
            last = nil, oddSet = nil;
            strDate = nil, strMonth = nil, strYear = nil, currentYear = nil, strCurrentYear = nil;
            dateFormatter = Nil, strDOB = nil, strDOB2 = nil, d = Nil, d2 = Nil;
        }
        
        alphaNums = nil, inStringSet = nil;
		
	}
	else {
		
		if (_btnDOBPO.enabled == FALSE) {
			_sexSC.selectedSegmentIndex = -1;
			_dobLbl.text = @"";
		}
		
		_btnDOBPO.enabled = TRUE;
		//ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
		_dobLbl.textColor = [UIColor blackColor];
		_sexSC.enabled = TRUE;
	}
	
}


- (IBAction)deleteNominee:(id)sender
{
    NSString *msg;
	msg = [NSString stringWithFormat:@"Are you sure you want to delete this Nominee?"];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
	[alert setTag:1001];
	[alert show];
	
    
    
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1001 && buttonIndex == 0) //delete
    {
        if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"1"])
		{
            
			int total = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"] intValue];
			
			int share1 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_share"] intValue];
			
			int new = total - share1;
			
			
			NSString* str_share = [NSString stringWithFormat:@"%i", new];
			
			
			//   NSLog(@"1 Total(%i) - share1(%i) = New share(%i)",total,share1, new );
			
			[[obj.eAppData objectForKey:@"SecD"] setValue:str_share forKey:@"TotalShare"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_share"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_title"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_name"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_ic"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_otherIDType"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_otherID"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_dob"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_gender"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_relatioship"];
            
             [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_nationality"];
             [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_ExactDuties"];
             [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_Occupation"];
             [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_nameofemployer"];
            
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_add1TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_add2TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_add3TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_postcodeTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_townTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_stateTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_countryTF"];
            
            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_CRadd1TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_CRadd2TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_CRadd3TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_CRpostcodeTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_CRtownTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_CRstateTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_CRcountryTF"];
			
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_Address"];
			
			_relationshipLbl.textColor = [UIColor blackColor];
			[self updateParentNominees];
			[self dismissModalViewControllerAnimated:YES];
			
			
			
		}
		
		else if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"2"])
		{
			
			
			int total = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"] intValue];
			
			int share1 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_share"] intValue];
			
			int new = total - share1;
			
			
			NSString* str_share = [NSString stringWithFormat:@"%i", new];
			
			
			[[obj.eAppData objectForKey:@"SecD"] setValue:str_share forKey:@"TotalShare"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_share"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_title"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_name"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_ic"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_otherIDType"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_otherID"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_dob"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_gender"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_relatioship"];
			
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_add1TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_add2TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_add3TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_postcodeTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_townTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_stateTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_countryTF"];
            
            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_nationality"];
            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_ExactDuties"];
            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_Occupation"];
            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_nameofemployer"];
            
            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_CRadd1TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_CRadd2TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_CRadd3TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_CRpostcodeTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_CRtownTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_CRstateTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_CRcountryTF"];
			
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_Address"];
			
			
			_relationshipLbl.textColor = [UIColor blackColor];
			[self updateParentNominees];
			[self dismissModalViewControllerAnimated:YES];
			
			
		}
		else if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"3"])
		{
			
			int total = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"] intValue];
			
			int share1 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_share"] intValue];
			
			int new = total - share1;
			
			
			NSString* str_share = [NSString stringWithFormat:@"%i", new];
			
			
			
			[[obj.eAppData objectForKey:@"SecD"] setValue:str_share forKey:@"TotalShare"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_share"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_title"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_name"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_ic"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_otherIDType"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_otherID"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_dob"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_gender"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_relatioship"];
			
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_add1TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_add2TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_add3TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_postcodeTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_townTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_stateTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_countryTF"];
            
            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_nationality"];
            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_ExactDuties"];
            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_Occupation"];
            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_nameofemployer"];
            
            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_CRadd1TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_CRadd2TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_CRadd3TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_CRpostcodeTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_CRtownTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_CRstateTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_CRcountryTF"];
			
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_Address"];
			
			
			_relationshipLbl.textColor = [UIColor blackColor];
			[self updateParentNominees];
			[self dismissModalViewControllerAnimated:YES];
			
			
			
			
		}
		else if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"4"])
		{
			
			int total = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"] intValue];
			
			int share1 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_share"] intValue];
			
			int new = total - share1;
			
			
			NSString* str_share = [NSString stringWithFormat:@"%i", new];
			
			
			
			[[obj.eAppData objectForKey:@"SecD"] setValue:str_share forKey:@"TotalShare"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_share"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_title"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_name"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_ic"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_otherIDType"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_otherID"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_dob"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_gender"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_relatioship"];
			
			
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_add1TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_add2TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_add3TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_postcodeTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_townTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_stateTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_countryTF"];
            
            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_nationality"];
            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_ExactDuties"];
            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_Occupation"];
            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_nameofemployer"];
            
            [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_CRadd1TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_CRadd2TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_CRadd3TF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_CRpostcodeTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_CRtownTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_CRstateTF"];
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_CRcountryTF"];

			
			[[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_Address"];
			
			_relationshipLbl.textColor = [UIColor blackColor];
			
			[self updateParentNominees];
			[self dismissModalViewControllerAnimated:YES];
			
			
		}

	}
}

-(void)updateParentNominees
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DeleteNominee" object:self];
}

- (void) dealloc
{
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (void)viewDidUnload {
	[self setTotalShareLbl:nil];
	[self setTitleLbl:nil];
	[self setNameTF:nil];
	[self setIcNoTF:nil];
	[self setOtherIDTypeLbl:nil];
	[self setOtherIDTF:nil];
	[self setDobLbl:nil];
	[self setSexSC:nil];
	[self setSharePercentageTF:nil];
	[self setRelationshipLbl:nil];
	[self setBtnSameAddress:nil];
	[self setBtnForeignAddress:nil];
	[self setAdd1TF:nil];
	[self setAdd2TF:nil];
	[self setAdd3TF:nil];
	[self setPostcodeTF:nil];
	[self setTownTF:nil];
	[self setStateLbl:nil];
	[self setCountryLbl:nil];
	[self setBtnTitlePO:nil];
    [self setOtherIDTypeLbl2:nil];
    [self setExactDuty:nil];
    [self setNationalityLbl:nil];
    [self setOccupationLbl:nil];
    [self setBtnCRForeignAddress:nil];
    [self setCRadd1TF:nil];
    [self setCRadd2TF:nil];
    [self setCRadd3TF:nil];
    [self setCRpostcodeTF:nil];
    [self setCRtownTF:nil];
    [self setCRstateLbl:nil];
    [self setCRcountryLbl:nil];
    [self setCRbtnCountryPO:nil];
	[super viewDidUnload];
}

-(NSString*) getCountryDesc : (NSString*)country
{
    NSString *desc;
    country = [country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT CountryDesc FROM eProposal_Country WHERE CountryCode = ?", country];
    
    NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        desc =[result objectForColumnName:@"CountryDesc"];
    }
    
	if (count == 0) {
		desc = country;
	}
	
    [result close];
    [db close];
    NSLog(@"Country: %@, code: %@", country ,desc);
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
			}		}
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

-(void) CheckOccuCat : (NSString*) occCode {
	
	NSString *code = @"";
	NSString *cat = @"";
	occCode = [occCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]; //occpDesc
	
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
	databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
	
	FMResultSet *result2 = [db executeQuery:@"select OccpCode from Adm_Occp where OccpDesc = ?", occCode, nil];
	
	while ([result2 next]) {
		code = [result2 stringForColumn:@"OccpCode"];
	}
	
    FMResultSet *result = [db executeQuery:@"select a.OccpCatCode, b.OccpCode from Adm_OccpCat a inner join Adm_OccpCat_Occp b on a.OccpCatCode = b.OccpCatCode where b.OccpCode = ?", code];
    
    while ([result next]) {
        cat = [result stringForColumn:@"OccpCatCode"];
        NSLog(@"cat: %@", cat);
		cat = [cat stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		
    }
	
	if ([cat isEqualToString:@"HSEWIFE"] || [cat isEqualToString:@"JUV"] || [cat isEqualToString:@"RET"] || [cat isEqualToString:@"STU"] || [cat isEqualToString:@"UNEMP"]) {
		employerMandatory = FALSE;
	}
	else
		employerMandatory = TRUE;
	
    [result close];
    [db close];
	
	
}
@end
