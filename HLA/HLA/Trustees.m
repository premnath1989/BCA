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
#import "textFields.h"

#define CHARACTER_LIMIT_ICNO 12
#define NUMBERS_ONLY @"0123456789"
#define CHARACTER_LIMIT_PC_F 12
#define CHARACTER_LIMIT_PC_NF 5
#define CHAR_ONLY @"ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz./@'()-"

@interface Trustees () {
	DataClass *obj;
    
    BOOL poIsMuslim;
    BOOL isforgeinAddChecked;
}

@end

@implementation Trustees
@synthesize IDTypeCodeSelected;
@synthesize TitleCodeSelected;
@synthesize StateCode;
@synthesize CountryListPopover = _CountryListPopover;
@synthesize btnSameAddAsPO = _btnSameAddAsPO;


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
    isforgeinAddChecked = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnDone:)];
	
	//db for postcode
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	//
	obj = [DataClass getInstance];
    
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	tap.delegate = self;
	[self.view addGestureRecognizer:tap];
	
	[_nameTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_icNoTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_otherIDTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_add1TF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_add2TF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_add3TF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_postcodeTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_townTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	
	[_icNoTF addTarget:self action:@selector(NewICDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
    [db open];
    FMResultSet *results = [db executeQuery:@"select LAReligion, LADOB, LAOtherIDType from eProposal_LA_Details where eProposalNo = ? AND POFlag = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"Y"];
    NSString *dob;
	NSString *LAOtherIDType;
    while ([results next]) {
        NSString *religion = [textFields trimWhiteSpaces:[results stringForColumn:@"LAReligion"]];
        if ([religion hasPrefix:@"M"]) {
            poIsMuslim = TRUE;
        }
        else {
            poIsMuslim = FALSE;
        }
        dob = [results stringForColumn:@"LADOB"];
		LAOtherIDType = [results stringForColumn:@"LAOtherIDType"];
    }
    
     NSString *MaritalStatus = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ProspectMarital"];
   
   
    if (!poIsMuslim && [MaritalStatus isEqualToString:@"DIVORCED"] )
    {
       
       // _btnPO.hidden=TRUE;
       // _LblSameAsPo.hidden=TRUE;
        _sameaspoCell.hidden=TRUE;
    }
	
	
    
    [db close];
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

- (void)btnDone:(id)sender
{
    //[self editingDidEndPostcode:nil];
    [self dismissModalViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneBtn:(id)sender {
	//[self editingDidEndPostcode:nil];
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
    [self setSameaspoCell:nil];
    [self setDeleteBtn:nil];
    [self setRelationshipLbl:nil];
	[self setBtnRelationship:nil];
	[super viewDidUnload];
}

- (IBAction)actionForSameAsPO:(id)sender {
    
   
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
	isSameAsPO = !isSameAsPO;

   	if(isSameAsPO) {
        
        
		[_btnPO setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		
		_titleLbl.text = @"";
		_titleLbl.textColor = [UIColor lightGrayColor];
		_btnTitlePO.enabled = NO;
		
		_nameTF.text = @"";
		_nameTF.textColor = [UIColor lightGrayColor];
		_nameTF.enabled = NO;
		
		_sexSC.enabled = NO;
		_sexSC.selectedSegmentIndex = -1;
		
		_dobLbl.text = @"";
		_dobLbl.textColor = [UIColor lightGrayColor];
		_btnDOBPO.enabled = NO;
		
		_icNoTF.text = @"";
		_icNoTF.textColor = [UIColor lightGrayColor];
		_icNoTF.enabled = NO;
		
		_otherIDTypeLbl.text = @"";
		_otherIDTypeLbl.textColor = [UIColor lightGrayColor];
		_btnOtherIDTypePO.enabled = NO;
		
		_otherIDTF.text = @"";
		_otherIDTF.textColor = [UIColor lightGrayColor];
		_otherIDTF.enabled = NO;
		
		_relationshipLbl.text = @"";
		_btnRelationship.enabled = NO;
		
		_btnForeignAddress.enabled = NO;
		
		_add1TF.text = @"";
		_add1TF.textColor = [UIColor lightGrayColor];
		_add1TF.enabled = NO;
		_add2TF.text = @"";
		_add2TF.textColor = [UIColor lightGrayColor];
		_add2TF.enabled = NO;
		_add3TF.text = @"";
		_add3TF.textColor = [UIColor lightGrayColor];
		_add3TF.enabled = NO;
		
		_postcodeTF.text = @"";
		_postcodeTF.textColor = [UIColor lightGrayColor];
		_postcodeTF.enabled = NO;
		
		_townTF.text = @"";
		_townTF.textColor = [UIColor lightGrayColor];
		_townTF.enabled = NO;
		
		_stateLbl.text = @"State";
		_stateLbl.textColor = [UIColor lightGrayColor];
		
		_countryLbl.text = @"";
		_countryLbl.textColor = [UIColor lightGrayColor];
		_btnCountryPO.enabled = NO;
        _po = TRUE;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
        FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
        [db open];
        FMResultSet *results = [db executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ? AND POFlag = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"Y"];
        while ([results next]) {
            _titleLbl.text = ![[results stringForColumn:@"LATitle"] isEqualToString:@"(null)"] ? [self getTitleDesc:[results stringForColumn:@"LATitle"]] : @"";
			TitleCodeSelected = [results stringForColumn:@"LATitle"];
            _nameTF.text = ![[results stringForColumn:@"LAName"] isEqualToString:@"(null)"] ? [results stringForColumn:@"LAName"] : @"";
            
            NSString *sex = [results stringForColumn:@"LASex"];
            if ([sex hasPrefix:@"M"]) {
                _sexSC.selectedSegmentIndex = 0;
            }
            else if ([sex hasPrefix:@"F"]) {
                _sexSC.selectedSegmentIndex = 1;
            }
            
            _dobLbl.text = ![[results stringForColumn:@"LADOB"] isEqualToString:@"(null)"] ? [results stringForColumn:@"LADOB"] : @"";
            _icNoTF.text = ![[results stringForColumn:@"LANewICNo"] isEqualToString:@"(null)"] ? [results stringForColumn:@"LANewICNo"] : @"";
            
            _otherIDTypeLbl.text = !([[results stringForColumn:@"LAOtherIDType"] isEqualToString:@"(null)"] || [[results stringForColumn:@"LAOtherIDType"] isEqualToString:@"- Select -"]) ? [self getIDTypeDesc:[results stringForColumn:@"LAOtherIDType"]] : @"";
			IDTypeCodeSelected = [results stringForColumn:@"LAOtherIDType"];
			
			if ([_otherIDTypeLbl.text isEqualToString:@"BIRTH CERTIFICATE"] || [_otherIDTypeLbl.text isEqualToString:@"OLD IDENTIFICATION NO"] || [_otherIDTypeLbl.text isEqualToString:@"PASSPORT"] || _otherIDTypeLbl.text == NULL || [_otherIDTypeLbl.text isEqualToString:@""] || [_otherIDTypeLbl.text isEqualToString:@"- SELECT -"]) {
				//_nricLbl.text = @"";
				_icNoTF.enabled = YES;
			}
			else {
				_icNoTF.text = @"";
				_icNoTF.enabled = NO;
				_dobLbl.text = @"";
				_btnDOBPO.enabled = TRUE;
				//ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
				_dobLbl.textColor = [UIColor blackColor];
				_sexSC.enabled = TRUE;
				_sexSC.selectedSegmentIndex = -1;
			}
			
            _otherIDTF.text = ![[results stringForColumn:@"LAOtherID"] isEqualToString:@"(null)"] ? [results stringForColumn:@"LAOtherID"] : @"";
            
            NSString *foreignAdd = [results stringForColumn:@"ResidenceForeignAddressFlag"];
            if ([foreignAdd isEqualToString:@"1"]) {
                [_btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            }
            else {
                [_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
            }
            
            _add1TF.text = ![[results stringForColumn:@"ResidenceAddress1"] isEqualToString:@"(null)"] ? [results stringForColumn:@"ResidenceAddress1"] : @"";
            _add2TF.text = ![[results stringForColumn:@"ResidenceAddress2"] isEqualToString:@"(null)"] ? [results stringForColumn:@"ResidenceAddress2"] : @"";
            _add3TF.text = ![[results stringForColumn:@"ResidenceAddress3"] isEqualToString:@"(null)"] ? [results stringForColumn:@"ResidenceAddress3"] : @"";
            _postcodeTF.text = ![[results stringForColumn:@"ResidencePostcode"] isEqualToString:@"(null)"] ? [results stringForColumn:@"ResidencePostcode"] : @"";
            _townTF.text = ![[results stringForColumn:@"ResidenceTown"] isEqualToString:@"(null)"] ? [results stringForColumn:@"ResidenceTown"] : @"";
            _stateLbl.text = ![[results stringForColumn:@"ResidenceState"] isEqualToString:@"(null)"] ? [results stringForColumn:@"ResidenceState"] : @"";
            _countryLbl.text = ![[results stringForColumn:@"ResidenceCountry"] isEqualToString:@"(null)"] ? [results stringForColumn:@"ResidenceCountry"] : @"";
        }
        
        results = Nil;
        results = [db executeQuery:@"select * from eProposal_State where StateCode = ?", [textFields trimWhiteSpaces:_stateLbl.text], nil];
        while ([results next]) {
            _stateLbl.text = ![[results objectForColumnName:@"StateDesc"] isEqualToString:@"(null)"] ? [results objectForColumnName:@"StateDesc"] : _stateLbl.text;
        }
        [results close];
        [db close];
        
        NSString *country = [self getCountryDesc:_countryLbl.text];
        if (![country isEqualToString:@"(null)"]) {
            _countryLbl.text = country;
        }
	}
	else {
		[_btnPO setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];

		_titleLbl.textColor = [UIColor blackColor];
        _titleLbl.text = @"";
		_btnTitlePO.enabled = YES;

		_nameTF.enabled = YES;
		_nameTF.textColor = [UIColor blackColor];
        _nameTF.text = @"";
		
		_sexSC.enabled = YES;
        _sexSC.selectedSegmentIndex = -1;
		
		_dobLbl.textColor = [UIColor blackColor];
		_btnDOBPO.enabled = YES;
        _dobLbl.text = @"";
		
		_icNoTF.enabled = YES;
		_icNoTF.textColor = [UIColor blackColor];
        _icNoTF.text = @"";
		
		_otherIDTypeLbl.text = @"";
		_otherIDTypeLbl.textColor = [UIColor blackColor];
		_btnOtherIDTypePO.enabled = YES;
		
		_otherIDTF.enabled = YES;
		_otherIDTF.textColor = [UIColor blackColor];
        _otherIDTF.text = @"";
		
		_btnRelationship.enabled = YES;
		
		_btnForeignAddress.enabled = YES;
		
		_add1TF.enabled = YES;
		_add2TF.enabled = YES;
		_add3TF.enabled = YES;
		
		_add1TF.textColor = [UIColor blackColor];
		_add2TF.textColor = [UIColor blackColor];
		_add3TF.textColor = [UIColor blackColor];
		
        _add1TF.text = @"";
        _add2TF.text = @"";
        _add3TF.text = @"";
		
		//		_postcodeTF.placeholder = @"Postcode";
		_postcodeTF.textColor = [UIColor blackColor];
		_postcodeTF.enabled = YES;
        _postcodeTF.text = @"";
		
		//		_townTF.placeholder = @"Town";
		_townTF.enabled = NO;
        _townTF.text = @"";
		_townTF.textColor = [UIColor lightGrayColor];
		
		_countryLbl.text = @"MALAYSIA";
		_countryLbl.textColor = [UIColor lightGrayColor];
		_btnCountryPO.enabled = YES;_po = FALSE;
	}
	
if ([_otherIDTypeLbl.text isEqualToString:@"BIRTH CERTIFICATE"] || [_otherIDTypeLbl.text isEqualToString:@"OLD IDENTIFICATION NO"] || [_otherIDTypeLbl.text isEqualToString:@"PASSPORT"] || _otherIDTypeLbl.text == NULL || [_otherIDTypeLbl.text isEqualToString:@""] || [_otherIDTypeLbl.text isEqualToString:@"- SELECT -"]) {
	//_nricLbl.text = @"";
	_icNoTF.enabled = YES;
}
else {
	_icNoTF.text = @"";
	_icNoTF.enabled = NO;
	_dobLbl.text = @"";
	_btnDOBPO.enabled = TRUE;
	//ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
	_dobLbl.textColor = [UIColor blackColor];
	_sexSC.enabled = TRUE;
	_sexSC.selectedSegmentIndex = -1;
}

}

- (IBAction)actionForSameAddAsPO:(id)sender {
		
		[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
		isSameAsPO = !isSameAsPO;
		
		if(isSameAsPO) {
			
			_po = TRUE;
			[_btnSameAddAsPO setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal]; //###CHECK THIS LATER, depend on BtnPo to use
			[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
			
			_btnForeignAddress.enabled = NO;
			
			_add1TF.text = @"";
			_add1TF.textColor = [UIColor lightGrayColor];
			_add1TF.enabled = NO;
			_add2TF.text = @"";
			_add2TF.textColor = [UIColor lightGrayColor];
			_add2TF.enabled = NO;
			_add3TF.text = @"";
			_add3TF.textColor = [UIColor lightGrayColor];
			_add3TF.enabled = NO;
			
			_postcodeTF.text = @"";
			_postcodeTF.textColor = [UIColor lightGrayColor];
			_postcodeTF.enabled = NO;
			
			_townTF.text = @"";
			_townTF.textColor = [UIColor lightGrayColor];
			_townTF.enabled = NO;
			
			_stateLbl.text = @"State";
			_stateLbl.textColor = [UIColor lightGrayColor];
			
			_countryLbl.text = @"";
			_countryLbl.textColor = [UIColor lightGrayColor];
			_btnCountryPO.enabled = NO;
			
			
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *documentsDirectory = [paths objectAtIndex:0];
			NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
			FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
			[db open];
			
			FMResultSet *results = [db executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ? AND POFlag = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"Y"];
			while ([results next]) {
	
				NSString *foreignAdd = [results stringForColumn:@"ResidenceForeignAddressFlag"];
				if ([foreignAdd isEqualToString:@"1"]) {
					[_btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
					_fa = TRUE;
					isForeignAddress = TRUE;
				}
				else {
					[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
					_fa = FALSE;
					isForeignAddress = FALSE;
				}
				
				_add1TF.text = ![[results stringForColumn:@"ResidenceAddress1"] isEqualToString:@"(null)"] ? [results stringForColumn:@"ResidenceAddress1"] : @"";
				_add2TF.text = ![[results stringForColumn:@"ResidenceAddress2"] isEqualToString:@"(null)"] ? [results stringForColumn:@"ResidenceAddress2"] : @"";
				_add3TF.text = ![[results stringForColumn:@"ResidenceAddress3"] isEqualToString:@"(null)"] ? [results stringForColumn:@"ResidenceAddress3"] : @"";
				_postcodeTF.text = ![[results stringForColumn:@"ResidencePostcode"] isEqualToString:@"(null)"] ? [results stringForColumn:@"ResidencePostcode"] : @"";
				_townTF.text = ![[results stringForColumn:@"ResidenceTown"] isEqualToString:@"(null)"] ? [results stringForColumn:@"ResidenceTown"] : @"";
				_stateLbl.text = ![[results stringForColumn:@"ResidenceState"] isEqualToString:@"(null)"] ? [results stringForColumn:@"ResidenceState"] : @"";
				_countryLbl.text = ![[results stringForColumn:@"ResidenceCountry"] isEqualToString:@"(null)"] ? [results stringForColumn:@"ResidenceCountry"] : @"";
			}
			
			results = Nil;
			results = [db executeQuery:@"select * from eProposal_State where StateCode = ?", [textFields trimWhiteSpaces:_stateLbl.text], nil];
			while ([results next]) {
				_stateLbl.text = ![[results objectForColumnName:@"StateDesc"] isEqualToString:@"(null)"] ? [results objectForColumnName:@"StateDesc"] : _stateLbl.text;
			}
			[results close];
			[db close];
			
			NSString *country = [self getCountryDesc:_countryLbl.text];
			if (![country isEqualToString:@"(null)"]) {
				_countryLbl.text = country;
			}
		}
	
		else {
			_po = FALSE;
			_fa = FALSE;
			isForeignAddress = FALSE;
			
			[_btnSameAddAsPO setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
			[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	
			_btnForeignAddress.enabled = YES;
			
			_add1TF.enabled = YES;
			_add2TF.enabled = YES;
			_add3TF.enabled = YES;
			
			_add1TF.textColor = [UIColor blackColor];
			_add2TF.textColor = [UIColor blackColor];
			_add3TF.textColor = [UIColor blackColor];
			
			_add1TF.text = @"";
			_add2TF.text = @"";
			_add3TF.text = @"";
			
			_postcodeTF.textColor = [UIColor blackColor];
			_postcodeTF.enabled = YES;
			_postcodeTF.text = @"";

			_townTF.enabled = NO;
			_townTF.text = @"";
			_townTF.textColor = [UIColor lightGrayColor];
			
			_countryLbl.text = @"MALAYSIA";
			_countryLbl.textColor = [UIColor lightGrayColor];
			_btnCountryPO.enabled = YES;
			
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

-(void)selectedTitleDesc:(NSString *)selectedTitleDesc
{
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
    _titleLbl.text = selectedTitleDesc;
//	_titleLbl.textColor = [UIColor blackColor];
    [self.TitlePickerPopover dismissPopoverAnimated:YES];
}

-(void)selectedTitleCode:(NSString *)selectedTitleCode
{
	TitleCodeSelected = selectedTitleCode;
}


- (IBAction)actionForDOB:(id)sender {
	
	[self hideKeyboard];
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
		//_dobLbl.text = dateString;
//	}
	mainStoryboard = nil;
	
}

-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
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
	[self hideKeyboard];
	if (_IDTypeVC == nil) {
        
        self.IDTypeVC = [[IDTypeViewController alloc] initWithStyle:UITableViewStylePlain];
        _IDTypeVC.delegate = self;
		_IDTypeVC.IDSelect = _otherIDTypeLbl.text;
        self.IDTypePopover = [[UIPopoverController alloc] initWithContentViewController:_IDTypeVC];
    }
    
    [self.IDTypePopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)IDTypeDescSelected:(NSString *)selectedIDType
{
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
    _otherIDTypeLbl.text = selectedIDType;
//	_otherIDTypeLbl.textColor =  [UIColor blackColor];
    [self.IDTypePopover dismissPopoverAnimated:YES];
	_otherIDTF.enabled = YES;
	//_icNoTF.text = @"";
	//_icNoTF.enabled = NO;
	if ([_otherIDTypeLbl.text isEqualToString:@"BIRTH CERTIFICATE"] || [_otherIDTypeLbl.text isEqualToString:@"OLD IDENTIFICATION NO"] || [_otherIDTypeLbl.text isEqualToString:@"PASSPORT"] || _otherIDTypeLbl.text == NULL || [_otherIDTypeLbl.text isEqualToString:@""] || [_otherIDTypeLbl.text isEqualToString:@"- SELECT -"]) {
		//_nricLbl.text = @"";
		_icNoTF.enabled = YES;
	}
	else {
		_icNoTF.text = @"";
		_icNoTF.enabled = NO;
		if (_btnDOBPO.enabled == FALSE) {
			_dobLbl.text = @"";
			_btnDOBPO.enabled = TRUE;
			_sexSC.enabled = TRUE;
			_sexSC.selectedSegmentIndex = -1;
		}
		//ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
		_dobLbl.textColor = [UIColor blackColor];
		
	}
}

-(void)IDTypeCodeSelected:(NSString *)IDTypeCode {
	IDTypeCodeSelected = IDTypeCode;
}

- (IBAction)actionForForeignAdd:(id)sender {
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
	isForeignAddress = !isForeignAddress;
	if(isForeignAddress) {
		[_btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		isforgeinAddChecked = NO;
		_add1TF.enabled = YES;
		_add2TF.enabled = YES;
		_add3TF.enabled = YES;
		
		_add1TF.text = @"";
        _add2TF.text = @"";
        _add3TF.text = @"";
		
		_postcodeTF.text = @"";
		//		_postcodeTF.textColor = [UIColor lightGrayColor];
		//		_postcodeTF.enabled = YES;
		//
		_townTF.text = @"";
		_townTF.enabled = YES;
		_townTF.textColor = [UIColor blackColor];
		//		_townTF.placeholder = @"Town";
		//_townTF.textColor = [UIColor lightGrayColor];
		
		//
		_stateLbl.text = @"State";
		_stateLbl.textColor = [UIColor lightGrayColor];
		
		_countryLbl.text = @"";
//		_countryLbl.textColor = [UIColor lightGrayColor];
		_btnCountryPO.enabled = YES;
		_countryLbl.textColor = [UIColor blackColor];
		_fa = TRUE;
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
		_townTF.textColor = [UIColor lightGrayColor];
		//
		//		_stateLbl.text = @"State";
		//		_stateLbl.textColor = [UIColor lightGrayColor];
		
		_countryLbl.text = @"MALAYSIA";
		_countryLbl.textColor = [UIColor lightGrayColor];
		_btnCountryPO.enabled = NO; _fa = FALSE;
	}
}

- (IBAction)editingDidEndPostcode:(id)sender {
	
	
	if (_fa == YES) {
		isForeignAddress = YES;
	}
	else {
		isForeignAddress = NO;
	}
	
	if (!isForeignAddress) {
		
		if (_postcodeTF.text.length < 5) {
			_townTF.text = @"";
			_stateLbl.text = @"State";
			_stateLbl.textColor = [UIColor lightGrayColor];
		}
		
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
		_townTF.textColor = [UIColor blackColor];
		_townTF.enabled = YES;
		
		_stateLbl.text = @"State";
		_stateLbl.textColor = [UIColor lightGrayColor];
	}
}


- (IBAction)actionForCountry:(id)sender {
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

- (IBAction)actionForDeleteTrustee:(id)sender {
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"1T"]) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Are you sure you want to delete selected record?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
		//		NSLog(@"no title");
		alert.tag = 1;
		[alert show];
	}
	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"AddTrustee"] isEqualToString:@"2T"]) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Are you sure you want to delete selected record?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
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
//-(void)selectedCountry:(NSString *)selectedCountry {
//    _countryLbl.text = selectedCountry;
//	_countryLbl.textColor = [UIColor blackColor];
//    [_CountryPopover dismissPopoverAnimated:YES];
//}

-(void)SelectedCountry:(NSString *)theCountry
{
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
	_countryLbl.text = theCountry;
	_countryLbl.textColor = [UIColor blackColor];
    
	[self.CountryListPopover dismissPopoverAnimated:YES];
	[self hideKeyboard];
	
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
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
	
	else if (textField == _icNoTF) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_ICNO));
	}
	else if (textField == _nameTF) {
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:CHAR_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 50));
	}
	else if (textField == _otherIDTF) {
		return ((newLength <= 30));
	}
	else if (textField == _townTF) {
		return ((newLength <= 40));
	}
	else if ((textField == _add1TF)|| (textField == _add2TF) || (textField == _add3TF)) {
		return ((newLength <= 30));
	}
	else return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
	
	if (textField == _postcodeTF) {
		if (_fa == YES) {
			isForeignAddress = YES;
		}
		else {
			isForeignAddress = NO;
		}
		
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
			_dobLbl.text = @"";
			_sexSC.selectedSegmentIndex = -1;
		}
		
		_btnDOBPO.enabled = TRUE;
		//ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
		_dobLbl.textColor = [UIColor blackColor];
		_sexSC.enabled = TRUE;
	}
	
}


#pragma mark - Get Desc or code
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
			}
		}
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


@end
