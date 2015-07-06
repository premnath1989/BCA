//
//  SubDetails.m
//  iMobile Planner
//
//  Created by shawal sapuan on 7/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "SubDetails.h"
#import "ColorHexCode.h"
#import "DataClass.h"
#import "Utility.h"
#import "PolicyOwner.h"
#import "textFields.h"
#import "FMDatabase.h"
#import "textFields.h"
#import "eAppCheckList.h"
@interface SubDetails (){
    DataClass *obj;
    NSDictionary *details;
    bool isPO;
    int age;
    NSString *prevPType;
    bool residence;
    bool office;
    bool employerMandatory;
	BOOL frmPropect;
	NSString *prospExactDuties;
	NSString *GST_registered;
	NSString *GST_registrationNo;
	NSString *GST_registrationDate;
	NSString *GST_exempted;
    
}

@end

@implementation SubDetails

@synthesize TitlePicker = _TitlePicker;
@synthesize IDTypePopover = _IDTypePopover;
@synthesize SIDatePopover = _SIDatePopover;
@synthesize RelationshipPopover = _RelationshipPopover;

@synthesize OccupationListPopover = _OccupationListPopover;
@synthesize RaceListPopover = _RaceListPopover;
@synthesize MaritalStatusPopover = _MaritalStatusPopover;
@synthesize nationalityPopover = _nationalityPopover;
@synthesize checkPolicyOwner;

@synthesize employerLbl = _employerLbl;
@synthesize businessLbl = _businessLbl;
@synthesize IDTypeCodeSelected, TitleCodeSelected;

#define CHARACTER_LIMIT_EMPLOYERNAME 60
#define CHARACTER_LIMIT_BUSINESSTYPE 60
#define CHARACTER_LIMIT_RECIDENCEADDRESS 30
#define CHARACTER_LIMIT_OFFICEADDRESS 30
#define CHARACTER_LIMIT_TOWN 40
#define CHARACTER_LIMIT_EMAIL 40
#define CHAR_ONLY @"ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz./@'()-"

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
    
    NSLog(@"secPole");
    
    _ClearExaxtDuties.hidden =YES;
    _ClearExaxtDuties.enabled =YES;
    
	_btnMalPOB.enabled = FALSE;
	_SegOfficePOB.enabled = FALSE;
	_SegResidencePOB.enabled = FALSE;
    
    
    //self.firstNameTexField_.autocapitalizationType = UITextAutocapitalizationTypeWords;
    isMoifiedData=NO;
    isFirstTime=YES;
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    if ([[self.LADetails objectForKey:@"PTypeCode"] isEqualToString:@"PO"]) {
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnDone:)];
        UIBarButtonItem *delete = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStyleBordered target:self action:@selector(doDelete)];
        self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:done, delete, nil];
    }
    else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnDone:)];
    }
    NSLog(@"SubDetails");
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(btnCancel:)];
    obj=[DataClass getInstance];
    
    //db for postcode
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    //NEW PO SECTION
    if ([[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"SecPO_1LA"] isEqualToString:@"Y"])
    {
        [self getPO_Oject];
        //[self displayRecord];
        NSLog(@"SecPO_1LA!!!!");
    }
    
    
    if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickPart2"] isEqualToString:@"Y"])
    {
		[checkPolicyOwner setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        
        _BtnOffice.enabled = YES;
        _BtnResidence.enabled = YES;
        _txtState1.enabled = false;
        _txtState2.enabled = false;
		
		_SegOfficePOB.enabled = TRUE;
		_SegResidencePOB.enabled = TRUE;
        
        
        //        _LARPOLbl.hidden=TRUE;
        //        _PORLALbl.hidden=FALSE;
        
        if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SecA_savedSubDetails"] isEqualToString:@"Y"]) {
            [self displayRecord];
        }
        
    }
	else {
        
		[checkPolicyOwner setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        _LblCorrespondenceAdd.enabled = TRUE;
        _LblResidence.enabled = TRUE;
        _LblOffice.enabled = TRUE;
        _BtnResidence.enabled = FALSE;
        
        _segOwnership.enabled =TRUE;
        _LblResidenceAdd.enabled = TRUE;
        _LblForeignAdd.enabled = TRUE;
        _LblOwnership.enabled = TRUE;
        _LblAddress1.enabled = TRUE;
        _LblPostcode1.enabled = TRUE;
        _LblTown1.enabled = TRUE;
        _LblState1.enabled = TRUE;
        _LblCountry1.enabled = TRUE;
        
        
        _txtPostcode1.enabled = FALSE;
        _txtState1.enabled = FALSE;
        _txtCountry1.enabled = FALSE;
        _txtTown1.enabled = FALSE;
        
        
        _txtAdd1.enabled = FALSE;
        _txtAdd12.enabled = FALSE;
        _txtAdd13.enabled = FALSE;
        
        _BtnResidenceForeignAdd.enabled =true;
        
        //        _LARPOLbl.hidden=FALSE;
        //        _PORLALbl.hidden=TRUE;
        
        _LblOfficeAdd2.enabled = true;
        _LblForeignAdd2.enabled = true;
        _LblAddress2.enabled = true;
        _LblPostcode2.enabled =true;
        _LblState2.enabled = true;
        _LblTown2.enabled = true;
        //_LblCountry2.enabled = true;
        
        _txtPostcode2.enabled = FALSE;
        _txtState2.enabled = FALSE;
        _txtCountry2.enabled = FALSE;
        _txtTown2.enabled = FALSE;
        
        _txtAdd2.enabled = FALSE;
        _txtAdd22.enabled = FALSE;
        _txtAdd23.enabled = FALSE;
		
		_txtAdd2.textColor = [UIColor grayColor];
        _txtAdd22.textColor = [UIColor grayColor];
        _txtAdd23.textColor = [UIColor grayColor];
		_txtPostcode2.textColor = [UIColor grayColor];
		_txtCountry2.textColor = [UIColor grayColor];
		
        
        _BtnOfficeForeignAdd.enabled = FALSE;
        _LblContactTitle3.enabled = TRUE;
        _LblResidence3.enabled = TRUE;
        _LblOffice3.enabled = TRUE;
        
        
        _LblEmail3.enabled = TRUE;
        _LblMobile3.enabled = TRUE;
        _LblFax3.enabled = TRUE;
        
        _txtResidence1.enabled = FALSE;
        _txtResidence2.enabled = FALSE;
        
        _txtOffice1.enabled = FALSE;
        _txtOffice2.enabled = FALSE;
        _txtEmail.enabled = FALSE;
        _txtMobile1.enabled = FALSE;
        _txtMobile2.enabled = FALSE;
        _txtFax1.enabled = FALSE;
        _txtFax2.enabled = FALSE;
		
		_BtnResidenceForeignAdd.enabled = FALSE;
        _segOwnership.enabled = FALSE;
        
		
	}
    
    [self displayRecord];
    
    _employerLbl.delegate = self;
	_businessLbl.delegate = self;
	_txtAdd1.delegate = self;		//Recidence Address
	_txtAdd12.delegate = self;
	_txtAdd13.delegate =self;
	_txtAdd2.delegate = self;		//Office Address
	_txtAdd22.delegate = self;
	_txtAdd23.delegate = self;
    _txtTown1.delegate = self;
    _txtTown2.delegate = self;
	_txtEmail.delegate = self;
	_txtMobile1.delegate = self;	//Mobile
	_txtMobile1.keyboardType = UIKeyboardTypeNumberPad;
	_txtMobile2.delegate = self;
	_txtOffice1.delegate = self;	//Office Phone
	_txtOffice1.keyboardType = UIKeyboardTypeNumberPad;
	_txtOffice2.delegate = self;
	_txtFax1.delegate = self;		//Fax No
	_txtFax1.keyboardType = UIKeyboardTypeNumberPad;
	_txtFax2.delegate = self;
    _txtResidence1.delegate = self;
	_txtResidence1.keyboardType = UIKeyboardTypeNumberPad;
    _txtResidence2.delegate = self;
	_txtName.delegate = self;		// guardian name
    _txtIC.delegate = self; //IC No
    _exaxtDutiesLbl.delegate =self;
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	tap.delegate = self;
	[self.view addGestureRecognizer:tap];
	
	NSString *proposalStatus = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ProposalStatus"];
	
	if ([proposalStatus isEqualToString:@"Confirmed"] || [proposalStatus isEqualToString:@"3"]) {
		[self disableAll];
	}
    
    //if(textfiedl.text.lenth==0){
    //texfiel.enadle=YES;
    //else   exfiel.enadle=NO;
	
	//ADD BY EMI, detect change make by user
	
	[_employerLbl addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_businessLbl addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_txtAdd1 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_txtAdd12 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_txtAdd13 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_txtAdd2 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_txtAdd2 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_txtAdd22 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_txtAdd23 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [_txtTown1 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [_txtTown2 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_txtEmail addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_txtMobile1 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_txtMobile1 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_txtMobile2 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_txtOffice1 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_txtOffice1 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_txtOffice2 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_txtFax1 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_txtFax1 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_txtFax2 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [_txtResidence1 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_txtResidence1 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [_txtResidence2 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_txtName addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_segHaveChildren addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_segOwnership addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    
   
    
    
    NSString *dataData= [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickResidenceAdd"];
    
    NSLog(@"datadata %@",dataData);
    
    
    //    if([[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOccupationDesc"]] isEqualToString:@"STUDENT"]||[[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOccupationDesc"]] isEqualToString:@"JUVENILE"]||[[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOccupationDesc"]] isEqualToString:@"HOUSEWIFE"]||[[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOccupationDesc"]] isEqualToString:@"RETIRED"]|| [[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOccupationDesc"]] isEqualToString:@"UNEMPLOYED"])
    //    {
    //        NSLog(@"testuuu");
    //        _exaxtDutiesLbl.editable = TRUE;
    //        _exaxtDutiesLbl.textColor = [UIColor blackColor];
    //        _ClearExaxtDuties.hidden =NO;
    //
    //    }
    
	if (isPO) {
		_LARPOLbl.hidden = TRUE;
		_PORLALbl.hidden = FALSE;
		
		_SegOfficePOB.enabled = TRUE;
		_SegResidencePOB.enabled = TRUE;
	}
	else
	{
		_LARPOLbl.hidden = FALSE;
		_PORLALbl.hidden = TRUE;
	}
	
}


-(void)CheckRangeInTextView
{
    //    if ( [_exaxtDutiesLbl.text isEqualToString:@""] )
    //    {
    //        _exaxtDutiesLbl.textColor =[UIColor blackColor];
    //        NSLog(@"string 0");
    //    }else
    //    {
    //        _exaxtDutiesLbl.textColor =[UIColor blackColor];
    //        NSLog(@"string 1");
    //    }
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

- (IBAction)ActionCheckCorrespondenceResidence:(id)sender
{
    if (isFirstTime) {
        isFirstTime=NO;
    }
    else
        isMoifiedData=YES;
	
	
    if (isResidenceForiegnAddChecked) {
        [Utility showAllert:@"Correspondence Address must be Malaysia address."];
        return;
    }
    [_BtnResidence setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    [_BtnOffice setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"TickResidenceAdd"];
    [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickOfficeAdd"];
    iscorrespondenceResidenceChecked = TRUE;
    iscorrespondenceOfficeChecked = FALSE;
    //[self.LADetails setValue:@"residence" forKey:@"CorrespondenceAddress"];
    
}
- (IBAction)ActionCheckCorrespondenceOffice:(id)sender
{
    
    
    if (isFirstTime) {
        isFirstTime=NO;
    }
    else
        isMoifiedData=YES;
	
    if (isOfficeForiegnAddChecked) {
        [Utility showAllert:@"Correspondence Address must be Malaysia address."];
        return;
    }
    [_BtnOffice setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    [_BtnResidence setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"TickOfficeAdd"];
    [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickResidenceAdd"];
    iscorrespondenceResidenceChecked = FALSE;
    iscorrespondenceOfficeChecked = TRUE;
    
    //[self.LADetails setValue:@"office" forKey:@"CorrespondenceAddress"];
}

-(void)CheckResidenceAddress
{
	isResidenceForiegnAddChecked = !isResidenceForiegnAddChecked;
    if(isResidenceForiegnAddChecked) {
        
        if([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickResidenceAdd"] isEqualToString:@"Y"])
        {
            [Utility showAllert:@"Correspondence Address must be Malaysia address."];
            [_BtnResidenceForeignAdd setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
            isResidenceForiegnAddChecked = !isResidenceForiegnAddChecked;
            //[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"ForeignResidenceAdd"];
            _txtTown1.enabled = false;
            _txtCountry1.enabled = false;
            _residenceCountryBtn.enabled = FALSE;
            _txtCountry1.enabled =false;
			_txtTown1.textColor = [UIColor grayColor];
			_txtCountry1.textColor = [UIColor grayColor];
			_residenceCountryBtn.enabled = false;
			//_officeCountryBtn.enabled = false;
            
        }
        else
        {
            
            [_BtnResidenceForeignAdd setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            //[[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"ForeignResidenceAdd"];
            _txtTown1.enabled = true;
            _txtState1.enabled = false;
            //_txtCountry1.enabled = true;
            _txtCountry1.text = @"";
            _txtAdd1.text = @"";
            _txtAdd12.text = @"";
            _txtAdd13.text = @"";
            _txtPostcode1.text = @"";
            _txtTown1.text = @"";
            _txtState1.text = @"";
            _residenceCountryBtn.enabled = TRUE;
            _txtCountry1.enabled =false;
			_txtTown1.textColor = [UIColor blackColor];
			_txtCountry1.textColor = [UIColor blackColor];
			_residenceCountryBtn.enabled = true;
			//_officeCountryBtn.enabled = false;
            
            
        }
    }
    else
    {
        
		[_BtnResidenceForeignAdd setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        //[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"ForeignResidenceAdd"];
        _txtTown1.enabled = false;
        _txtState1.enabled = false;
        _txtCountry1.enabled = false;
        _residenceCountryBtn.enabled = FALSE;
        //commented this to avoid auto fill country
        //_txtCountry1.text = @"MALAYSIA";
        //_txtCountry2.text = @"MALAYSIA";
        _txtCountry1.text = @"MALAYSIA";
        _txtAdd1.text = @"";
        _txtAdd12.text = @"";
        _txtAdd13.text = @"";
        _txtPostcode1.text = @"";
        _txtTown1.text = @"";
        _txtState1.text = @"";
		_txtTown1.textColor = [UIColor grayColor];
		_txtCountry1.textColor = [UIColor grayColor];
		_residenceCountryBtn.enabled = false;
		//_officeCountryBtn.enabled = false;
    }
	
	[self CheckPOBOX];
    
}


- (IBAction)ActionCheckResidenceAddress:(id)sender
{
    isMoifiedData=YES;
	[self CheckResidenceAddress];
}

- (IBAction)ActionCheckOfficeAddress:(id)sender
{
    
	isMoifiedData=YES;
	[self CheckOfficeAddress];
}

-(void)CheckOfficeAddress {
	
	isOfficeForiegnAddChecked = !isOfficeForiegnAddChecked;
    
    if(isOfficeForiegnAddChecked) {
        
        if([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickOfficeAdd"] isEqualToString:@"Y"])
        {
            [Utility showAllert:@"Correspondence Address must be Malaysia address."];
            [_BtnOfficeForeignAdd setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
            isOfficeForiegnAddChecked = !isOfficeForiegnAddChecked;
			// [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"ForeignOfficeAdd"];
            _txtTown2.enabled = false;
            _txtCountry2.enabled = false;
            _officeCountryBtn.enabled = FALSE;
			_txtTown2.textColor = [UIColor grayColor];
			_txtCountry2.textColor = [UIColor grayColor];
			//_residenceCountryBtn.enabled = false;
			_officeCountryBtn.enabled = false;
        }
        else
        {
            [_BtnOfficeForeignAdd setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            //[[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"ForeignOfficeAdd"];
            _txtTown2.enabled = true;
            _txtState2.enabled = false;
            _txtCountry2.enabled = FALSE;
            _txtCountry2.text = @"";
            _txtAdd2.text = @"";
            _txtAdd22.text = @"";
            _txtAdd23.text = @"";
            _txtPostcode2.text = @"";
            _txtTown2.text = @"";
            _txtState2.text = @"";
            _officeCountryBtn.enabled = TRUE;
			_txtTown2.textColor = [UIColor blackColor];
			_txtCountry2.textColor = [UIColor blackColor];
			//_residenceCountryBtn.enabled = false;
			_officeCountryBtn.enabled = true;
        }
    }
    else {
		[_BtnOfficeForeignAdd setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		// [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"ForeignOfficeAdd"];
        _txtTown2.enabled = false;
        _txtState2.enabled = false;
        _txtCountry2.enabled = false;
        _officeCountryBtn.enabled = FALSE;
        _txtCountry2.text = @"MALAYSIA";
        _txtAdd2.text = @"";
        _txtAdd22.text = @"";
        _txtAdd23.text = @"";
        _txtPostcode2.text = @"";
        _txtTown2.text = @"";
        _txtState2.text = @"";
		_txtTown2.textColor = [UIColor grayColor];
		_txtCountry2.textColor = [UIColor grayColor];
		//_residenceCountryBtn.enabled = false;
		_officeCountryBtn.enabled = false;
    }
	
	[self CheckPOBOX];
    
}


- (IBAction)ActionCheckPolicyOwner:(id)sender
{
    
    isMoifiedData=YES;
    isPart2Checked = !isPart2Checked;
	if(isPart2Checked)
    {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsPath = [paths objectAtIndex:0];
        NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:path];
        [database open];
        FMResultSet *results = [database executeQuery:@"select count(*) as count from eProposal_LA_Details where eProposalNo = ? and POFlag = 'Y'", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
        bool poExist = FALSE;
        while ([results next]) {
            NSLog(@"count: %d", [results intForColumn:@"count"]);
            if ([results intForColumn:@"count"] > 0) {
                poExist = TRUE;
            }
        }
        if (poExist) {
            results = Nil;
            results = [database executeQuery:@"select LANewICNo, LAOtherIDType, LAOtherID from eProposal_LA_Details where eProposalNo = ? and POFlag = 'Y'", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
            while ([results next]) {
                if ([[self.LADetails objectForKey:@"LANewICNO"] isEqualToString:[results stringForColumn:@"LANewICNo"]]) {
                    poExist = FALSE;
                }
                else if (([results stringForColumn:@"LAOtherIDType"].length != 0 && [results stringForColumn:@"LAOtherID"].length != 0) && [[self.LADetails objectForKey:@"LAOtherIDType"] isEqualToString:[results stringForColumn:@"LAOtherIDType"]] && [[self.LADetails objectForKey:@"LAOtherID"] isEqualToString:[results stringForColumn:@"LAOtherID"]]) {
                    poExist = FALSE;
                }
                else {
                    poExist = TRUE;
                }
            }
        }
        if (poExist) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Policy Owner already exist. Are you sure you want to overwrite the existing Policy Owner?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO",nil];
            alert.tag = 1008;
            [alert show];
            alert = Nil;
            return;
        }
		[checkPolicyOwner setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        
        [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"TickPart2"];
        
        _LblCorrespondenceAdd.enabled = TRUE;
        _LblResidence.enabled = TRUE;
        _LblOffice.enabled = TRUE;
        _BtnResidence.enabled = TRUE;
        _BtnOffice.enabled = TRUE;
        
        _segOwnership.enabled =TRUE;
        _LblResidenceAdd.enabled = TRUE;
        _LblForeignAdd.enabled = TRUE;
        _LblOwnership.enabled = TRUE;
        _LblAddress1.enabled = TRUE;
        _LblPostcode1.enabled = TRUE;
        _LblTown1.enabled = TRUE;
        _LblState1.enabled = true;
        _LblCountry1.enabled = true;
        
        _txtPostcode1.enabled = TRUE;
        _txtState1.enabled = FALSE;
        _txtCountry1.enabled = FALSE;
        _txtTown1.enabled = FALSE;
        _txtTown2.enabled = FALSE;
        
        _txtAdd1.enabled = TRUE;
        _txtAdd12.enabled = TRUE;
        _txtAdd13.enabled = TRUE;
        
        _BtnResidenceForeignAdd.enabled =TRUE;
        
		_SegResidencePOB.enabled = TRUE;
		_SegOfficePOB.enabled = TRUE;
        
        _PORLALbl.hidden=NO;
        _LARPOLbl.hidden=YES;
        
        _LblOfficeAdd2.enabled = TRUE;
        _LblForeignAdd2.enabled = TRUE;
        _LblAddress2.enabled = TRUE;
        _LblPostcode2.enabled =TRUE;
        _LblState2.enabled = true;
        _LblTown2.enabled = TRUE;
        _LblCountry2.enabled = TRUE;
        
        _txtPostcode2.enabled = TRUE;
        _txtState2.enabled = FALSE;
        _txtCountry2.enabled = false;
        _txtTown2.enabled = FALSE;
        
        
        _txtAdd2.enabled = TRUE;
        _txtAdd22.enabled = TRUE;
        _txtAdd23.enabled = TRUE;
        
        _BtnOfficeForeignAdd.enabled = TRUE;
        
        _LblContactTitle3.enabled = TRUE;
        _LblResidence3.enabled = TRUE;
        _LblOffice3.enabled = TRUE;
        
        _LblEmail3.enabled = TRUE;
        _LblMobile3.enabled = TRUE;
        _LblFax3.enabled = TRUE;
        
        _txtResidence1.enabled = TRUE;
        _txtResidence2.enabled = TRUE;
        
        _txtOffice1.enabled = TRUE;
        _txtOffice2.enabled = TRUE;
        _txtEmail.enabled = TRUE;
        _txtMobile1.enabled = TRUE;
        _txtMobile2.enabled = TRUE;
        _txtFax1.enabled = TRUE;
        _txtFax2.enabled = TRUE;
        //        _txtName.enabled = TRUE;
        //        _txtIC.enabled = TRUE;
        
		
//		NSLog(@"ENS GUARDIAN 2: check policy owner");
        if (age > 9 && age < 16) {
            _txtName.enabled = TRUE;
            _txtIC.enabled = TRUE;
            _policyLifecycleLabel.textColor =[UIColor blackColor];
            _Me.textColor =[UIColor blackColor];
            _asTheParent.textColor =[UIColor blackColor];
            _NRIC.textColor =[UIColor blackColor];
            
        }
		else {
			_txtName.enabled = FALSE;
            _txtIC.enabled = FALSE;
			_txtName.text = @"";
            _txtIC.text = @"";
            _policyLifecycleLabel.textColor =[UIColor grayColor];
            _Me.textColor =[UIColor grayColor];
            _asTheParent.textColor =[UIColor grayColor];
            _NRIC.textColor =[UIColor grayColor];
		}
        
		if (([[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"CR"]) || ([[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"COMPANY REGISTRATION NUMBER"]))
		{
			_txtName.enabled = FALSE;
			_txtIC.enabled = FALSE;
			_policyLifecycleLabel.textColor =[UIColor grayColor];
			_Me.textColor =[UIColor grayColor];
			_asTheParent.textColor =[UIColor grayColor];
			_NRIC.textColor =[UIColor grayColor];
		}
		
		
		
        //        if(age ==0)
        //        {
        //            _txtName.enabled = FALSE;
        //            _txtIC.enabled = FALSE;
        //            _policyLifecycleLabel.textColor =[UIColor grayColor];
        //            _Me.textColor =[UIColor grayColor];
        //            _asTheParent.textColor =[UIColor grayColor];
        //            _NRIC.textColor =[UIColor grayColor];
        //
        //        }
        //
        //        if(age ==10)
        //        {
        //            NSLog(@"age14Flase");
        //            _txtName.enabled = TRUE;
        //            _txtIC.enabled = TRUE;
        //            _policyLifecycleLabel.textColor =[UIColor blackColor];
        //            _Me.textColor =[UIColor blackColor];
        //            _asTheParent.textColor =[UIColor blackColor];
        //            _NRIC.textColor =[UIColor blackColor];
        //        }
        
        //        if(age ==11)
        //        {
        //            _txtName.enabled = TRUE;
        //            _txtIC.enabled = TRUE;
        //            _policyLifecycleLabel.textColor =[UIColor blackColor];
        //            _Me.textColor =[UIColor blackColor];
        //            _asTheParent.textColor =[UIColor blackColor];
        //            _NRIC.textColor =[UIColor blackColor];
        //		}
        //        if(age ==12)
        //        {
        //            NSLog(@"age14Flase");
        //            _txtName.enabled = FALSE;
        //            _txtIC.enabled = FALSE;
        //            _policyLifecycleLabel.textColor =[UIColor grayColor];
        //            _Me.textColor =[UIColor grayColor];
        //            _asTheParent.textColor =[UIColor grayColor];
        //            _NRIC.textColor =[UIColor grayColor];
        //        }
        //
        //        if(age ==13)
        //        {
        //            _txtName.enabled = TRUE;
        //            _txtIC.enabled = TRUE;
        //            _policyLifecycleLabel.textColor =[UIColor blackColor];
        //            _Me.textColor =[UIColor blackColor];
        //            _asTheParent.textColor =[UIColor blackColor];
        //            _NRIC.textColor =[UIColor blackColor];
        //        }
        //
        //        if(age ==14)
        //        {
        //            _txtName.enabled = TRUE;
        //            _txtIC.enabled = TRUE;
        //            _policyLifecycleLabel.textColor =[UIColor blackColor];
        //            _Me.textColor =[UIColor blackColor];
        //            _asTheParent.textColor =[UIColor blackColor];
        //            _NRIC.textColor =[UIColor blackColor];
        //        }
        //
        //        if(age ==15)
        //        {
        //            _txtName.enabled = TRUE;
        //            _txtIC.enabled = TRUE;
        //            _policyLifecycleLabel.textColor =[UIColor blackColor];
        //            _Me.textColor =[UIColor blackColor];
        //            _asTheParent.textColor =[UIColor blackColor];
        //            _NRIC.textColor =[UIColor blackColor];
        //        }
        
		_txtAdd1.textColor = [UIColor blackColor];
		_txtAdd1.textColor = [UIColor blackColor];
        _txtAdd12.textColor = [UIColor blackColor];
        _txtAdd13.textColor = [UIColor blackColor];
        _txtPostcode1.textColor = [UIColor blackColor];
        _txtState1.textColor=[UIColor grayColor];
		
		if ([_txtCountry1.text isEqualToString:@"MALAYSIA"]){
			_txtCountry1.textColor=[UIColor grayColor];
			_txtTown1.textColor=[UIColor grayColor];
		}
		else{
			_txtCountry1.textColor=[UIColor blackColor];
			_txtTown1.textColor=[UIColor blackColor];
		}
		
        NSLog(@"blackColor");
		
		_txtAdd2.textColor = [UIColor blackColor];
        _txtAdd22.textColor = [UIColor blackColor];
        _txtAdd23.textColor = [UIColor blackColor];
		_txtPostcode2.textColor = [UIColor blackColor];
		_txtState2.textColor=[UIColor grayColor];   //state never be in blackcolor
		if ([_txtCountry2.text isEqualToString:@"MALAYSIA"]){
			_txtCountry2.textColor=[UIColor grayColor];
			_txtState2.textColor=[UIColor grayColor];
			_txtTown2.textColor=[UIColor grayColor];
		}
		else {
			_txtCountry2.textColor=[UIColor blackColor];
			_txtTown2.textColor=[UIColor blackColor];
		}
        NSLog(@"blackColor1");
		
		_txtResidence1.textColor = [UIColor blackColor];
        _txtResidence2.textColor = [UIColor blackColor];
        _txtMobile1.textColor = [UIColor blackColor];
        _txtMobile2.textColor = [UIColor blackColor];
        _txtOffice1.textColor = [UIColor blackColor];
        _txtOffice2.textColor = [UIColor blackColor];
        _txtFax1.textColor = [UIColor blackColor];
        _txtFax2.textColor = [UIColor blackColor];
        _txtEmail.textColor = [UIColor blackColor];
        
        if ([_martialStatusLbl.text isEqualToString:@"DIVORCED"] || [_martialStatusLbl.text isEqualToString:@"WIDOW"] || [_martialStatusLbl.text isEqualToString:@"WIDOWER"])
        {
            _segHaveChildren.enabled = TRUE;
        }
        
        
        isPO = TRUE;
        
        NSString *test = [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickResidenceAdd"];
        
        if([test isEqualToString:@"Y"])
        {
            [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"TickPart2"];
        }
        else
        {
            [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"TickPart2"];
        }
        
        
        
    }
    else {
		[checkPolicyOwner setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        
        
        _BtnOffice.enabled = false;
        _BtnResidence.enabled = false;
        [self.segOwnership setSelectedSegmentIndex:UISegmentedControlNoSegment];
        iscorrespondenceResidenceChecked = FALSE;
        iscorrespondenceOfficeChecked = FALSE;
        
        [_BtnResidence setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        
        [_BtnOffice setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        
        [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickPart2"];
        _LblCorrespondenceAdd.enabled = TRUE;
        _LblResidence.enabled = TRUE;
        _LblOffice.enabled = TRUE;
        _BtnResidence.enabled = FALSE;
        
        _segOwnership.enabled =FALSE;
        _LblResidenceAdd.enabled = TRUE;
        _LblForeignAdd.enabled = TRUE;
        _LblOwnership.enabled = TRUE;
        _LblAddress1.enabled = TRUE;
        _LblPostcode1.enabled = TRUE;
        _LblTown1.enabled = TRUE;
        _LblState1.enabled = TRUE;
        _LblCountry1.enabled = TRUE;
        
        _txtPostcode1.enabled = FALSE;
        _txtState1.enabled = FALSE;
        _txtCountry1.enabled = FALSE;
        _txtTown1.enabled = FALSE;
        
        
        _txtAdd1.enabled = FALSE;
        _txtAdd12.enabled = FALSE;
        _txtAdd13.enabled = FALSE;
        
        _BtnResidenceForeignAdd.enabled =FALSE;
        
        _LARPOLbl.hidden=NO;
        _PORLALbl.hidden=YES;
        
        _LblOfficeAdd2.enabled = TRUE;
        _LblForeignAdd2.enabled = TRUE;
        _LblAddress2.enabled = TRUE;
        _LblPostcode2.enabled =TRUE;
        _LblState2.enabled = TRUE;
        _LblTown2.enabled = TRUE;
        _LblCountry2.enabled = TRUE;
        
        _txtPostcode2.enabled = FALSE;
        _txtState2.enabled = FALSE;
        _txtCountry2.enabled = FALSE;
        _txtTown2.enabled = FALSE;
        
        _txtAdd2.enabled = FALSE;
        _txtAdd22.enabled = FALSE;
        _txtAdd23.enabled = FALSE;
        
        _BtnOfficeForeignAdd.enabled = FALSE;
		_officeCountryBtn.enabled = false;
		_residenceCountryBtn.enabled = false;
        _txtCountry1.enabled =false;
        
        _LblContactTitle3.enabled = TRUE;
        _LblResidence3.enabled = TRUE;
        _LblOffice3.enabled = TRUE;
        
        _LblEmail3.enabled = TRUE;
        _LblMobile3.enabled = TRUE;
        _LblFax3.enabled = TRUE;
        
        
        _txtResidence1.enabled = FALSE;
        _txtResidence2.enabled = FALSE;
        
        _txtOffice1.enabled = FALSE;
        _txtOffice2.enabled = FALSE;
        _txtEmail.enabled = FALSE;
        _txtMobile1.enabled = FALSE;
        _txtMobile2.enabled = FALSE;
        _txtFax1.enabled = FALSE;
        _txtFax2.enabled = FALSE;
        _segHaveChildren.enabled = FALSE;
		_segHaveChildren.selectedSegmentIndex = -1;
        
        _BtnResidenceForeignAdd.enabled = FALSE;
        
        _SegOfficePOB.enabled = FALSE;
		_SegResidencePOB.enabled = FALSE;
		
//		isResidencePOBOXChecked = FALSE;
//		isOfficePOBOXChecked = FALSE;
		
		_SegOfficePOB.selectedSegmentIndex = -1;
		_SegResidencePOB.selectedSegmentIndex = -1;
		
		[self CheckPOBOX];
        
        _txtAdd1.textColor = [UIColor grayColor];
		_txtAdd1.textColor = [UIColor grayColor];
        _txtAdd12.textColor = [UIColor grayColor];
        _txtAdd13.textColor = [UIColor grayColor];
        _txtPostcode1.textColor = [UIColor grayColor];
        _txtState1.textColor=[UIColor grayColor];
        _txtTown1.textColor = [UIColor grayColor];
        _txtCountry1.textColor=[UIColor grayColor];
        
        NSLog(@"txtColorGrayColor");
		
		_txtAdd2.textColor = [UIColor grayColor];
        _txtAdd22.textColor = [UIColor grayColor];
        _txtAdd23.textColor = [UIColor grayColor];
		_txtPostcode2.textColor = [UIColor grayColor];
        _txtState2.textColor=[UIColor grayColor];
        _txtTown2.textColor = [UIColor grayColor];
        _txtCountry2.textColor=[UIColor grayColor];
        
        NSLog(@"txtColorGrayColor1");
        
		
		_txtResidence1.textColor = [UIColor grayColor];
        _txtResidence2.textColor = [UIColor grayColor];
        _txtMobile1.textColor = [UIColor grayColor];
        _txtMobile2.textColor = [UIColor grayColor];
        _txtOffice1.textColor = [UIColor grayColor];
        _txtOffice2.textColor = [UIColor grayColor];
        _txtFax1.textColor = [UIColor grayColor];
        _txtFax2.textColor = [UIColor grayColor];
        _txtEmail.textColor = [UIColor grayColor];
		
		
		//DISABLE GUARDIAN IF NOT PO, FOR ALL AGE..
		
		_txtName.enabled = FALSE;
		_txtIC.enabled = FALSE;
		_txtName.text = @"";
		_txtIC.text = @"";
		_policyLifecycleLabel.textColor =[UIColor grayColor];
		_Me.textColor =[UIColor grayColor];
		_asTheParent.textColor =[UIColor grayColor];
		_NRIC.textColor =[UIColor grayColor];
        
        
        //        if(age ==0)
        //        {
        //            _txtName.enabled = FALSE;
        //            _txtIC.enabled = FALSE;
        //            _policyLifecycleLabel.textColor =[UIColor grayColor];
        //            _Me.textColor =[UIColor grayColor];
        //            _asTheParent.textColor =[UIColor grayColor];
        //            _NRIC.textColor =[UIColor grayColor];
        //
        //        }
        //
        //
        //        if(age ==10)
        //        {
        //            NSLog(@"age14True");
        //            _txtName.enabled = FALSE;
        //            _txtIC.enabled = FALSE;
        //            _policyLifecycleLabel.textColor =[UIColor grayColor];
        //            _Me.textColor =[UIColor grayColor];
        //            _asTheParent.textColor =[UIColor grayColor];
        //            _NRIC.textColor =[UIColor grayColor];
        //        }
        //
        //        if(age ==11)
        //        {
        //            NSLog(@"age14True");
        //            _txtName.enabled = FALSE;
        //            _txtIC.enabled = FALSE;
        //            _policyLifecycleLabel.textColor =[UIColor grayColor];
        //            _Me.textColor =[UIColor grayColor];
        //            _asTheParent.textColor =[UIColor grayColor];
        //            _NRIC.textColor =[UIColor grayColor];
        //        }
        //
        //        if(age ==12)
        //        {
        //            NSLog(@"age14True");
        //            _txtName.enabled = FALSE;
        //            _txtIC.enabled = FALSE;
        //            _policyLifecycleLabel.textColor =[UIColor grayColor];
        //            _Me.textColor =[UIColor grayColor];
        //            _asTheParent.textColor =[UIColor grayColor];
        //            _NRIC.textColor =[UIColor grayColor];
        //        }
        //
        //        if(age ==13)
        //        {
        //            NSLog(@"age14True");
        //            _txtName.enabled = FALSE;
        //            _txtIC.enabled = FALSE;
        //            _policyLifecycleLabel.textColor =[UIColor grayColor];
        //            _Me.textColor =[UIColor grayColor];
        //            _asTheParent.textColor =[UIColor grayColor];
        //            _NRIC.textColor =[UIColor grayColor];
        //        }
        //
        //        if(age ==14)
        //        {
        //            NSLog(@"age14True");
        //            _txtName.enabled = FALSE;
        //            _txtIC.enabled = FALSE;
        //            _policyLifecycleLabel.textColor =[UIColor grayColor];
        //            _Me.textColor =[UIColor grayColor];
        //            _asTheParent.textColor =[UIColor grayColor];
        //            _NRIC.textColor =[UIColor grayColor];
        //        }
        //
        //        if(age ==15)
        //        {
        //            NSLog(@"age14True");
        //            _txtName.enabled = FALSE;
        //            _txtIC.enabled = FALSE;
        //            _policyLifecycleLabel.textColor =[UIColor grayColor];
        //            _Me.textColor =[UIColor grayColor];
        //            _asTheParent.textColor =[UIColor grayColor];
        //            _NRIC.textColor =[UIColor grayColor];
        //        }
        
        
        
        
        //_txtName.enabled = FALSE;
        //_txtIC.enabled = FALSE;
        
        //[_BtnResidence setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        //[_BtnOffice setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        //[_BtnResidenceForeignAdd setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        //[_BtnOfficeForeignAdd setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        
        //[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickResidenceAdd"];
        //[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickOfficeAdd"];
        //[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"ForeignResidenceAdd"];
        //[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"ForeignOfficeAdd"];
        if (isPO) {
            [[obj.eAppData objectForKey:@"SecPO"] setValue:@"" forKey:@"PORelationship"];
        }
		else
			[[obj.eAppData objectForKey:@"SecPO"] setValue:@"" forKey:@"LA1Relationship"];
        isPO = FALSE;
        
        
        
        //[self.LADetails setValue:prevPType forKey:@"PTypeCode"];
        //prevPType = @"PO";
    }
    
}
- (IBAction)ActionCheckMalPOB:(id)sender {
	
}

- (IBAction)ActionResidencePOB:(id)sender {
	isMoifiedData=YES;
	
	if (_SegResidencePOB.selectedSegmentIndex == 0) {
		isResidencePOBOXChecked = TRUE;
	}
	else if (_SegResidencePOB.selectedSegmentIndex == 1) {
		isResidencePOBOXChecked = FALSE;
	}
	
	[self CheckPOBOX];
	
}

- (IBAction)ActionOfficePOB:(id)sender {
	isMoifiedData=YES;
	
	if (_SegOfficePOB.selectedSegmentIndex == 0) {
		isOfficePOBOXChecked = TRUE;
	}
	else if (_SegOfficePOB.selectedSegmentIndex == 1) {
		isOfficePOBOXChecked = FALSE;
	}
	
	[self CheckPOBOX];
}


-(void) CheckPOBOX {

	if (isResidencePOBOXChecked && isOfficePOBOXChecked && !isOfficeForiegnAddChecked && !isResidenceForiegnAddChecked && [_nationalityLbl.text isEqualToString:@"MALAYSIAN"]) {
		[_btnMalPOB setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		isMalPOBOXchecked = TRUE;
	}
	else {
		[_btnMalPOB setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isMalPOBOXchecked = FALSE;
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

- (IBAction)ActionOtherID:(id)sender
{
	[self hideKeyboard];
    if (_IDTypeVC == nil) {
        
        self.IDTypeVC = [[IDTypeViewController alloc] initWithStyle:UITableViewStylePlain];
        _IDTypeVC.delegate = self;
        self.IDTypePopover = [[UIPopoverController alloc] initWithContentViewController:_IDTypeVC];
    }
    
    [self.IDTypePopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}
- (IBAction)ActionDOB:(id)sender;
{
    
	[self hideKeyboard];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    self.DOBLbl.text = dateString;
	self.DOBLbl.textColor = [UIColor blackColor];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    
    if (_SIDate == Nil) {
        
        self.SIDate = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIDate"];
        _SIDate.delegate = self;
        self.SIDatePopover = [[UIPopoverController alloc] initWithContentViewController:_SIDate];
    }
    
    [self.SIDatePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.SIDatePopover presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    
    
    
}
- (IBAction)ActionRelationship:(id)sender;
{
	[self hideKeyboard];
    // to make sure the request type is updated
    //_RelationshipVC = nil;
    if (_RelationshipVC == nil) {
        
        self.RelationshipVC = [[Relationship alloc] initWithStyle:UITableViewStylePlain];
        _RelationshipVC.delegate = self;
        //_RelationshipVC.requestType = [self.LADetails objectForKey:@"PTypeCode"];
        // Regards of the person type, the list will be same.
        _RelationshipVC.requestType = @"PO";
        self.RelationshipPopover = [[UIPopoverController alloc] initWithContentViewController:_RelationshipVC];
    }
    [self.RelationshipPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
- (IBAction)ActionRace:(id)sender;
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if (_raceList == nil) {
        self.raceList = [[Race alloc] initWithStyle:UITableViewStylePlain];
        _raceList.delegate = self;
        self.raceListPopover = [[UIPopoverController alloc] initWithContentViewController:_raceList];
    }
    
    
    [self.RaceListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    
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
- (IBAction)ActionMartialStatus:(id)sender
{
    
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if (_MaritalStatusList == nil) {
        self.MaritalStatusList = [[MaritalStatus alloc] initWithStyle:UITableViewStylePlain];
        _MaritalStatusList.delegate = self;
        self.MaritalStatusPopover = [[UIPopoverController alloc] initWithContentViewController:_MaritalStatusList];
    }
    
    
    [self.MaritalStatusPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}
- (IBAction)ActionOccupation:(id)sender
{
    
    
    if (_OccupationList == nil) {
        self.OccupationList = [[OccupationList alloc] initWithStyle:UITableViewStylePlain];
        _OccupationList.delegate = self;
        self.OccupationListPopover = [[UIPopoverController alloc] initWithContentViewController:_OccupationList];
    }
    
    
    [self.OccupationListPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}




- (void)OccupDescSelected:(NSString *) OccupDesc
{
	self.OccupationLbl.text = OccupDesc;
	self.OccupationLbl.textColor = [UIColor blackColor];
    [self.OccupationListPopover dismissPopoverAnimated:YES];
}

- (void)OccupCodeSelected:(NSString *) OccupCode {
    [self.LADetails setValue:OccupCode forKey:@"LAOccupationCode"];
	
}
- (void)OccupClassSelected:(NSString *) OccupClass {
	
}



-(void)selectedNationality:(NSString *)selectedNationality
{
    self.nationalityLbl.text = selectedNationality;
    self.nationalityLbl.textColor = [UIColor blackColor];
    [self.nationalityPopover dismissPopoverAnimated:YES];
}

-(void)selectedRace:(NSString *)theRace
{
    
    self.raceLbl.text = theRace;
    self.raceLbl.textColor = [UIColor blackColor];
    [self.RaceListPopover dismissPopoverAnimated:YES];
    
    
}
-(void)selectedMaritalStatus:(NSString *)status
{
    
    self.martialStatusLbl.text = status;
    self.martialStatusLbl.textColor = [UIColor blackColor];
    // outletMaritalStatus.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // [self.raceLbl setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",status]forState:UIControlStateNormal];
    [self.MaritalStatusPopover dismissPopoverAnimated:YES];
    
    
}



-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
    self.DOBLbl.text = strDate;
	self.DOBLbl.textColor = [UIColor blackColor];
}

- (void)CloseWindow //Override SIDate delegate method
{
    [self.SIDatePopover dismissPopoverAnimated:YES];
}

-(void)selectedIDType:(NSString *)selectedIDType
{
    self.OtherTypeIDLbl.text = selectedIDType;
	self.OtherTypeIDLbl.textColor =  [UIColor blackColor];
    [self.IDTypePopover dismissPopoverAnimated:YES];
	//_otherIDTF.enabled = YES;
	//_icNoTF.text = @"";
	//_icNoTF.enabled = NO;
}

-(void)selectedRelationship:(NSString *)theRelation
{
    self.relationshipLbl.text = theRelation;
	self.relationshipLbl.textColor = [UIColor blackColor];
    
    if (isPO) {
        [[obj.eAppData objectForKey:@"SecPO"] setValue:theRelation forKey:@"PORelationship"];
    }
	else {
		if ([[self.LADetails objectForKey:@"PTypeCode"] isEqualToString:@"LA1"])
			[[obj.eAppData objectForKey:@"SecPO"] setValue:theRelation forKey:@"LA1Relationship"];
		else if ([[self.LADetails objectForKey:@"PTypeCode"] isEqualToString:@"LA2"])
			[[obj.eAppData objectForKey:@"SecPO"] setValue:theRelation forKey:@"LA2Relationship"];
		else if ([[self.LADetails objectForKey:@"PTypeCode"] isEqualToString:@"PY1"])
			[[obj.eAppData objectForKey:@"SecPO"] setValue:theRelation forKey:@"PYRelationship"];
        
	}
    [self.RelationshipPopover dismissPopoverAnimated:YES];
	isMoifiedData=YES;
}

-(void)selectedTitle:(NSString *)selectedTitle
{
    
    self.titleLbl.text = selectedTitle;
	self.titleLbl.textColor = [UIColor blackColor];
    [self.TitlePickerPopover dismissPopoverAnimated:YES];
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

- (IBAction)editingDidEndPostcode:(id)sender {
	if (!isResidenceForiegnAddChecked) {
        
        const char *dbpath = [databasePath UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
            NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", _txtPostcode1.text];
            const char *query_stmt = [querySQL UTF8String];
            if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_ROW){
                    NSString *Town = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    NSString *State = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    //NSString *Statecode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                    
                    _txtState1.text = State;
                    _txtState1.textColor = [UIColor grayColor];
                    _txtTown1.text = Town;
                    _txtTown1.textColor = [UIColor grayColor];
                    
                    _txtCountry1.text = @"MALAYSIA";
                    // _countryLbl.textColor = [UIColor blackColor];
                    
                }
                else {
                    _txtState1.text = @"";
                    //_txtState1.textColor = [UIColor grayColor];
                    _txtTown1.text = @"";
                    //_txtTown1.textColor = [UIColor grayColor];
                    
                    _txtCountry1.text = @"";
                    
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
    }
    
}


- (IBAction)editingDidEndPostcode2:(id)sender {
	if (!isOfficeForiegnAddChecked) {
        
        const char *dbpath = [databasePath UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
            NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", _txtPostcode2.text];
            const char *query_stmt = [querySQL UTF8String];
            if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_ROW){
                    NSString *Town = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    NSString *State = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    //NSString *Statecode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                    
                    _txtState2.text = State;
                    _txtState2.textColor = [UIColor grayColor];
                    _txtTown2.text = Town;
                    _txtTown2.textColor = [UIColor grayColor];
                    
                    _txtCountry2.text = @"MALAYSIA";
                    // _countryLbl.textColor = [UIColor blackColor];
                    
                }
                else {
                    _txtState2.text = @"";
                    //_txtState1.textColor = [UIColor grayColor];
                    _txtTown2.text = @"";
                    //_txtTown1.textColor = [UIColor grayColor];
                    
                    _txtCountry2.text = @"";
                    
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
    }
	
	[self CheckPOBOX];
    /*	else {
     _townTF.placeholder = @"Town";
     //		_townTF.textColor = [UIColor lightGrayColor];
     _townTF.enabled = YES;
     
     _stateLbl.text = @"State";
     _stateLbl.textColor = [UIColor lightGrayColor];
     }
     */
}
-(void)getPO_Oject
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDeleteNominee:) name:@"PolicyOwner_ProspectProfile" object:nil];
    
}

-(void)displayRecord
{
    [self extractDB];
    NSString *plan =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"];
	NSString *sitype = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"];
    NSString *pcode = [self.LADetails objectForKey:@"PTypeCode"];
    NSString *POFLAG =    [self.LADetails objectForKey:@"POFlag"];
	
    NSString   *eproposalNo = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    
    //GET THE LATEST POFLAG FROM eProposal_LA_Details
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    [db open];
    
    FMResultSet *results = [db executeQuery:@"select POFlag, CorrespondenceAddress from eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?", [self.LADetails objectForKey:@"eProposalNo"], [self.LADetails objectForKey:@"PTypeCode"],nil];
    
    int noValue = 0;
    while ([results next]) {
        POFLAG = [results stringForColumn:@"POFlag"];
		[self.LADetails  setValue:[results stringForColumn:@"CorrespondenceAddress"] forKey:@"CorrespondenceAddress"];
		noValue = noValue + 1;
    }
    [results close];
    [db close];
    
    NSLog(@"SubDetails displayRecord - name -%@  || ptype - %@ || poflag - %@ | eProposalNo - %@ |PTypeCode - %@", plan, pcode, POFLAG, [self.LADetails objectForKey:@"eProposalNo"],[self.LADetails objectForKey:@"PTypeCode"]);
    
    
    // Check on owner type
    
    if([pcode isEqualToString:@"PO"])
    {
        if([POFLAG isEqualToString:@"Y"])
        {
            [checkPolicyOwner setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            
            _txtState1.enabled = false;
            _txtState2.enabled = false;
            isPO = TRUE;
            isPart2Checked = TRUE;
            checkPolicyOwner.enabled = FALSE;
			
            //			_LARPOLbl.hidden = TRUE;
            //			_PORLALbl.hidden = FALSE;
        }
        
    }
    else
    {
        //[[obj.eAppData objectForKey:@"SecPO"] setValue:@"N" forKey:@"CheckNewPO"];
        
        if ([POFLAG isEqualToString:@"Y"]) {
            if([sitype isEqualToString:@"TRAD"]){
                
                [checkPolicyOwner setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
                
                _txtState1.enabled = false;
                _txtState2.enabled = false;
                isPO = TRUE;
                isPart2Checked = TRUE;
				
            }
            else if([sitype isEqualToString:@""]){
                [checkPolicyOwner setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
                
                _txtState1.enabled = false;
                _txtState2.enabled = false;
                isPO = TRUE;
                isPart2Checked = TRUE;
            }
            
            if([pcode isEqualToString:@"PY1"])
                checkPolicyOwner.enabled = FALSE;
            else if([pcode isEqualToString:@"LA2"] && [sitype isEqualToString:@"TRAD"] )
                checkPolicyOwner.enabled = FALSE;
            else
                checkPolicyOwner.enabled = TRUE;
            
        }
        else //PO isEqualToString:@"N"
        {
			NSLog(@"EEEE Plan: %@",plan);
            if([sitype isEqualToString:@"TRAD"])
            {
                
                NSString *isNewPO =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"AddNewPO"];
                
                
                NSString *NewPOName =  [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"NewPOName"];
                
                
                
                if ([pcode isEqualToString:@"LA1"] && ([isNewPO isEqualToString:@"Y"]) )
                {
                    
                    if([NewPOName isEqualToString:@""] ||  [NewPOName isEqualToString:@"(null)"] || (NewPOName == nil) ||NewPOName ==NULL)
                        
                        checkPolicyOwner.enabled = TRUE; //FOR LA1 AND NEW PO - ENABLE CHECK BOX
                    else
                        checkPolicyOwner.enabled = FALSE; //FOR LA1 & LA2 - DISABLE CHECK BOX FOR LA1
                }
                else  if ([pcode isEqualToString:@"LA1"] && (![isNewPO isEqualToString:@"Y"]) )
                {
                    if([NewPOName isEqualToString:@""] ||  [NewPOName isEqualToString:@"(null)"] || (NewPOName == nil) ||NewPOName ==NULL)
                    {
                        checkPolicyOwner.enabled = TRUE;
                    }
                }
                else
                    checkPolicyOwner.enabled = FALSE; //FOR LA1 & LA2 - DISABLE CHECK BOX FOR LA1
                
            }
            else if([sitype isEqualToString:@"ES"])
            {
                
                //  if ([pcode isEqualToString:@"LA2"])
                //    checkPolicyOwner.enabled = FALSE;
                NSString *isNewPO =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"AddNewPO"];
                
                
                NSString *NewPOName =  [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"NewPOName"];
                
                
                if(isNewPO == NULL || isNewPO == nil || [isNewPO isEqualToString:@"(null)"])
                    isNewPO = @"N";
                
                NSLog(@"UV -pcode- %@ ||isNewPO - |%@| ",pcode, isNewPO );
                
                if ([pcode isEqualToString:@"LA1"] && ([isNewPO isEqualToString:@"Y"]) )
                {
                    
                    if([NewPOName isEqualToString:@""] ||  [NewPOName isEqualToString:@"(null)"] || (NewPOName == nil) ||NewPOName ==NULL)
                        
                        checkPolicyOwner.enabled = TRUE; //FOR LA1 AND NEW PO - ENABLE CHECK BOX
                    else
                        checkPolicyOwner.enabled = FALSE; //FOR LA1 & LA2 - DISABLE CHECK BOX FOR LA1
                }
				else if ([pcode isEqualToString:@"LA1"] && ([isNewPO isEqualToString:@"N"]))
                {
                    if([NewPOName isEqualToString:@""] ||  [NewPOName isEqualToString:@"(null)"] || (NewPOName == nil) ||NewPOName ==NULL)
                    {
                        checkPolicyOwner.enabled = TRUE;
                    }
                    
                }
                else if ([pcode isEqualToString:@"LA2"] && ([isNewPO isEqualToString:@"N"]))
                {
                    NSLog(@"LA2 - N ");
                    checkPolicyOwner.enabled = TRUE;
                }
                
                else
                    checkPolicyOwner.enabled = FALSE; //FOR LA1 & LA2 - DISABLE CHECK BOX FOR LA1
                
                
            }
            
            /*  else if([pcode isEqualToString:@"PY1"])
             {
             checkPolicyOwner.enabled = FALSE;
             }
             */
            [checkPolicyOwner setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
            _BtnOffice.enabled = false;
            _BtnResidence.enabled = false;
            [_BtnResidence setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
            
            [_BtnOffice setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
            isPart2Checked = FALSE;
            
            
        }
    }
	
	//ADD BY EMI: REMOVE FLAG FROM POLICY OWNER WHEN USER ADD NEW POLICY OWNER (12/07/2014)
	if (![pcode isEqualToString:@"PO"] && [POFLAG isEqualToString:@"Y"] && [[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"RemovePOFLAG"] isEqualToString:@"Y"]) {
		[checkPolicyOwner setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isPart2Checked = FALSE;
		isPO = FALSE;
	}
	//After add new policy owner, compulsory to save
	if ([[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"RemovePOFLAG"] isEqualToString:@"Y"])
		isMoifiedData = YES;
    
    bool reloadData = FALSE;
	
    NSLog(@"%@", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"LA1_ClientProfileUpdated"]);
    if ([pcode isEqualToString:@"LA1"]) {
        if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"LA1_ClientProfileUpdated"] isEqualToString:@"Y"]) {
            // Load Client Profile Data
            reloadData = TRUE;
        }
    }
    else if ([pcode isEqualToString:@"LA2"]) {
        if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"LA2_ClientProfileUpdated"] isEqualToString:@"Y"]) {
            reloadData = TRUE;
        }
    }
    else if ([pcode isEqualToString:@"PY1"]) {
        if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"PY1_ClientProfileUpdated"] isEqualToString:@"Y"]) {
            reloadData = TRUE;
        }
    }
    
	
	
    if (reloadData) {
        // get the prospect_profile indexno
        
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsDir = [dirPaths objectAtIndex:0];
        NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
        FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
        [db open];
		
        FMResultSet *results = [db executeQuery:@"select ProspectProfileID from eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?", [self.LADetails objectForKey:@"eProposalNo"], [self.LADetails objectForKey:@"PTypeCode"],nil];
        
        NSString *indexNo;
        while ([results next]) {
            indexNo = [results stringForColumn:@"ProspectProfileID"];
			[self.LADetails setValue:indexNo forKey:@"ClientProfileID"];
        }
        
        results = nil;
        results = [db executeQuery:@"select * from prospect_profile where indexNo = ?", indexNo];
        
        while ([results next]) {
            
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"IndexNo"]] forKey:@"indexNo"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"ProspectTitle"]] forKey:@"LATitle"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"ProspectDOB"]] forKey:@"LADOB"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"ProspectName"]] forKey:@"LAName"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"Race"]] forKey:@"LARace"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"IDTypeNo"]] forKey:@"LANewICNO"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"Nationality"]] forKey:@"LANationality"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"OtherIDType"]] forKey:@"LAOtherIDType"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"OtherIDTypeNo"]] forKey:@"LAOtherID"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"Religion"]] forKey:@"LAReligion"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"MaritalStatus"]] forKey:@"LAMaritalStatus"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"ProspectOccupationCode"]] forKey:@"LAOccupationCode"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"ExactDuties"]] forKey:@"LAExactDuties"];
			
			frmPropect = TRUE;
			prospExactDuties = [textFields trimWhiteSpaces:[results stringForColumn:@"ExactDuties"]];
			
			
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"AnnualIncome"]] forKey:@"LAYearlyIncome"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"ProspectGender"]] forKey:@"LASex"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"Smoker"]] forKey:@"LASmoker"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"BussinessType"]] forKey:@"LATypeOfBusiness"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"ResidenceAddress1"]] forKey:@"ResidenceAddress1"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"ResidenceAddress2"]] forKey:@"ResidenceAddress2"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"ResidenceAddress3"]] forKey:@"ResidenceAddress3"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"ResidenceAddressPostcode"]] forKey:@"ResidencePostcode"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"ResidenceAddressTown"]] forKey:@"ResidenceTown"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"ResidenceAddressState"]] forKey:@"ResidenceState"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"ResidenceAddressCountry"]] forKey:@"ResidenceCountry"];
            
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"OfficeAddress1"]] forKey:@"OfficeAddress1"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"OfficeAddress2"]] forKey:@"OfficeAddress2"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"OfficeAddress3"]] forKey:@"ROfficeAddress3"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"OfficeAddressPostcode"]] forKey:@"OfficePostcode"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"OfficeAddressTown"]] forKey:@"OfficeTown"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"OfficeAddressState"]] forKey:@"OfficeState"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"OfficeAddressCountry"]] forKey:@"OfficeCountry"];
            
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"GST_registered"]] forKey:@"GST_registered"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"GST_registrationNo"]] forKey:@"GST_registrationNo"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"GST_registrationDate"]] forKey:@"GST_registrationDate"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"GST_exempted"]] forKey:@"GST_exempted"];
            
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"ProspectProfileChangesCounter"]] forKey:@"ProspectProfileChangesCounter"];
            
        }
        
        results = nil;
        results = [db executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?", indexNo, @"CONT006", nil];
        while ([results next]) {
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"Prefix"]] forKey:@"ResidencePhoneNoPrefix"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"ContactNo"]] forKey:@"ResidencePhoneNo"];
        }
        
        results = nil;
        results = [db executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?", indexNo, @"CONT007", nil];
        while ([results next]) {
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"Prefix"]] forKey:@"OfficePhoneNoPrefix"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"ContactNo"]] forKey:@"OfficePhoneNo"];
        }
        
        results = nil;
        results = [db executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?", indexNo, @"CONT008", nil];
        while ([results next]) {
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"Prefix"]] forKey:@"MobilePhoneNoPrefix"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"ContactNo"]] forKey:@"MobilePhoneNo"];
        }
        
        results = nil;
        results = [db executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?", indexNo, @"CONT009", nil];
        while ([results next]) {
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"Prefix"]] forKey:@"FaxPhoneNoPrefix"];
            [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"ContactNo"]] forKey:@"FaxPhoneNo"];
        }
        
        results = [db executeQuery:@"SELECT OccpDesc from Adm_Occp WHERE OccpCode = ?", [self.LADetails objectForKey:@"LAOccupationCode"], Nil];
        while ([results next]) {
            NSString *occpDesc = [results stringForColumn:@"OccpDesc"] != NULL ? [results stringForColumn:@"OccpDesc"] : @"";
            [self.LADetails setValue:occpDesc forKey:@"LAOccupationDesc"];
        }
        [db close];
    }
    

    [db open];
    NSString *eproposal_typeofBussiness = @"";
    results = [db executeQuery:@"select ProspectProfileID, LATypeOfBusiness from eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?", [self.LADetails objectForKey:@"eProposalNo"], [self.LADetails objectForKey:@"PTypeCode"],nil];
    
    NSString *indexNo;
    while ([results next]) {
        indexNo = [results stringForColumn:@"ProspectProfileID"];
        eproposal_typeofBussiness = [results stringForColumn:@"LATypeOfBusiness"];
    }
    
    
    if  (((NSNull *) indexNo == [NSNull null]) || (indexNo == Nil) || ([indexNo isEqualToString:@"nil"]))
        indexNo = [self.LADetails objectForKey:@"indexNo"];
    
    results = nil;
    results = [db executeQuery:@"select * from prospect_profile where indexNo = ?", indexNo];
    while ([results next]) {
        [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"ProspectProfileChangesCounter"]] forKey:@"counter"];
        [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"GST_registered"]] forKey:@"GST_registered"];
        [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"GST_registrationNo"]] forKey:@"GST_registrationNo"];
        [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"GST_registrationDate"]] forKey:@"GST_registrationDate"];
        [self.LADetails setValue:[textFields trimWhiteSpaces:[results stringForColumn:@"GST_exempted"]] forKey:@"GST_exempted"];
        
    }
	
    
    
    _policyOwnerType.selectedSegmentIndex = 0;
    _titleLbl.text = [self getTitleDesc:[self.LADetails objectForKey:@"LATitle"]];
    _DOBLbl.text = [self.LADetails objectForKey:@"LADOB"];
    _nameLbl.text = [self.LADetails objectForKey:@"LAName"];
    _raceLbl.text = [self.LADetails objectForKey:@"LARace"];
    _nricLbl.text = [self.LADetails objectForKey:@"LANewICNO"];
    _nationalityLbl.text = [self.LADetails objectForKey:@"LANationality"];
    _OtherTypeIDLbl.text = [self getIDTypeDesc:[self.LADetails objectForKey:@"LAOtherIDType"]];
	if (IDTypeCodeSelected == NULL)
        IDTypeCodeSelected = [self.LADetails objectForKey:@"LAOtherIDType"];
	
    _otherIDLbl.text = [self.LADetails objectForKey:@"LAOtherID"];
    // Check db contents 1st
    //    if ([[self.LADetails objectForKey:@"LAReligion"] rangeOfString:@"NON"].location != NSNotFound) {
    //        _segReligion.selectedSegmentIndex = 1;
    //    }
    //    else if([[self.LADetails objectForKey:@"LAReligion"] rangeOfString:@"NON"].location == NSNotFound) {
    //        _segReligion.selectedSegmentIndex = 0;
    //    }
	
	
    
    //Basvi Changes
    if ([[self.LADetails objectForKey:@"LAReligion"] hasPrefix:@"NON-MUSLIM"]) {
        _segReligion.selectedSegmentIndex = 1;
    }
    else if ([[self.LADetails objectForKey:@"LAReligion"] hasPrefix:@"MUSLIM"]) {
        _segReligion.selectedSegmentIndex = 0;
    }
    
    if (([[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"CR"]) && ([[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"COMPANY REGISTRATION NUMBER"])) {
        _segReligion.selectedSegmentIndex = -1;
        [[obj.eAppData objectForKey:@"SecPO"] setValue:@"Y" forKey:@"gotCompany"];
        NSLog(@"gotCompany: %@", [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"gotCompany"]);
    }
    
    _martialStatusLbl.text = [self.LADetails objectForKey:@"LAMaritalStatus"];
    _relationshipLbl.text = [self.LADetails objectForKey:@"LARelationship"];
    _OccupationLbl.text = [self.LADetails objectForKey:@"LAOccupationDesc"];
    
    GST_registered = [self.LADetails objectForKey:@"GST_registered"];
    GST_registrationNo = [self.LADetails objectForKey:@"GST_registrationNo"];
    GST_registrationDate = [self.LADetails objectForKey:@"GST_registrationDate"];
    GST_exempted = [self.LADetails objectForKey:@"GST_exempted"];
    
    _employerLbl.text = [self.LADetails objectForKey:@"LAEmployerName"];
	_employerLbl.enabled = TRUE;
	
    if (([[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"CR"]) || ([[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"COMPANY REGISTRATION NUMBER"])){
        _employerLbl.enabled = FALSE;
        _employerLbl.text = @"";
    }
    
    //Compare exactDuties
	_exaxtDutiesLbl.text = [self.LADetails objectForKey:@"LAExactDuties"];
    
    if([_exaxtDutiesLbl.text isEqualToString:@""] || [[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOccupationDesc"]] isEqualToString:@"STUDENT"]||[[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOccupationDesc"]] isEqualToString:@"JUVENILE"]||[[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOccupationDesc"]] isEqualToString:@"HOUSEWIFE"]||[[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOccupationDesc"]] isEqualToString:@"RETIRED"]|| [[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOccupationDesc"]] isEqualToString:@"UNEMPLOYED"])
    {
        _exaxtDutiesLbl.editable = TRUE;
        _exaxtDutiesLbl.textColor = [UIColor blackColor];
        _ClearExaxtDuties.hidden =NO;
        
    }
	
	if (!frmPropect) {
		if (db.close)
			[db open];
		
		results = nil;
		if (indexNo == nil)
			indexNo = [self.LADetails objectForKey:@"indexNo"];
		
		results = [db executeQuery:@"select ExactDuties from prospect_profile where indexNo = ?", indexNo];
		while ([results next]) {
			prospExactDuties = [textFields trimWhiteSpaces:[results stringForColumn:@"ExactDuties"]];
		}
	}
	
	//if from prospect exact duties is empty, enable exact duties
	if ([prospExactDuties isEqualToString:@""]) {
		_exaxtDutiesLbl.editable = TRUE;
        _exaxtDutiesLbl.textColor = [UIColor blackColor];
        _ClearExaxtDuties.hidden =NO;
	}
	else {
		_exaxtDutiesLbl.editable = FALSE;
        _exaxtDutiesLbl.textColor = [UIColor lightGrayColor];
	}
	
	if ([[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOccupationDesc"]] isEqualToString:@"BABY"]) {
		_exaxtDutiesLbl.editable = FALSE;
        _exaxtDutiesLbl.textColor = [UIColor lightGrayColor];
	}
    
    _yearlyIncomeLbl.text = [self.LADetails objectForKey:@"LAYearlyIncome"];
    /* if ([self.LADetails objectForKey:@"POFlag"]) {
     [checkPolicyOwner setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
     isPO = TRUE;
     }
     */
	
	_titleLbl.textColor = [UIColor grayColor];
    _DOBLbl.textColor = [UIColor grayColor];
    _nameLbl.textColor = [UIColor grayColor];
    _raceLbl.textColor = [UIColor grayColor];
    _nricLbl.textColor = [UIColor grayColor];
    _nationalityLbl.textColor = [UIColor grayColor];
    _OtherTypeIDLbl.textColor = [UIColor grayColor];
    _otherIDLbl.textColor = [UIColor grayColor];
	_martialStatusLbl.textColor = [UIColor grayColor];
    _OccupationLbl.textColor = [UIColor grayColor];
	
    _yearlyIncomeLbl.textColor = [UIColor grayColor];
	
    if ([pcode isEqualToString:@"LA1"]) {
        [_policyOwnerType setSelectedSegmentIndex:0];
        [_policyOwnerType setEnabled:FALSE];
    }
	
    if ([[self.LADetails objectForKey:@"ResidenceOwnRented"] isEqualToString:@"Rented"]) {
        _segOwnership.selectedSegmentIndex = 1;
    }
    else if ([[self.LADetails objectForKey:@"ResidenceOwnRented"] isEqualToString:@"Own"]) {
        _segOwnership.selectedSegmentIndex = 0;
    }
    if ([[self.LADetails objectForKey:@"LASex"] hasPrefix:@"F"]) {
        _segGender.selectedSegmentIndex = 1;
    }
    else if ([[self.LADetails objectForKey:@"LASex"] hasPrefix:@"M"]) {
        _segGender.selectedSegmentIndex = 0;
    }
    
    // No smoker field
    if ([[self.LADetails objectForKey:@"LASmoker"] hasPrefix:@"Y"]) {
        _segSmoker.selectedSegmentIndex = 0;
    }
    else if ([[self.LADetails objectForKey:@"LASmoker"] hasPrefix:@"N"]) {
        _segSmoker.selectedSegmentIndex = 1;
    }
    
    //KY
    NSString *prospect_bussinesstype = @"";
    results = [db executeQuery:@"select BussinessType from prospect_profile where indexNo = ?", indexNo];
    
    while ([results next]) {
        prospect_bussinesstype =   [results stringForColumn:@"BussinessType"];
    }
    
    
    if(eproposal_typeofBussiness==NULL)
        eproposal_typeofBussiness=@"";
	
    _businessLbl.text = [self.LADetails objectForKey:@"LATypeOfBusiness"];
	_businessLbl.textColor = [UIColor grayColor];
	
    _businessLbl.delegate = self;
    // if its empty, enabled it.
    if (_businessLbl.text.length == 0) {
        _businessLbl.enabled = TRUE;
		_businessLbl.textColor = [UIColor grayColor];
        _businessLbl.textColor = [UIColor blackColor];
        
    }
	if (![_businessLbl.text isEqualToString:[self.LADetails objectForKey:@"LATypeOfBusiness"]]) {
		_businessLbl.enabled = TRUE;
		//_businessLbl.textColor = [UIColor grayColor];
        _businessLbl.textColor = [UIColor blackColor];
	}
    else if(![_businessLbl.text isEqualToString:prospect_bussinesstype])
    {
        _businessLbl.enabled = TRUE;
		//_businessLbl.textColor = [UIColor grayColor];
        _businessLbl.textColor = [UIColor blackColor];
    }
    if (([[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"CR"]) || ([[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"COMPANY REGISTRATION NUMBER"])){
        
        
        _businessLbl.enabled = FALSE;
        // _employerLbl.text = @"";
        _businessLbl.textColor = [UIColor grayColor];
        
        
        
        
    }
    
    //Check on corresponde address
    [self.LADetails objectForKey:@"CorrespondenceAddress"];
    
	if ([[self.LADetails objectForKey:@"CorrespondenceAddress"] isEqualToString:@"residence"]){
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"TickResidenceAdd"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickOfficeAdd"];
	}
	else if ([[self.LADetails objectForKey:@"CorrespondenceAddress"] isEqualToString:@"office"]){
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickResidenceAdd"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"TickOfficeAdd"];
	}
	else {
		//[self.LADetails setValue:@"" forKey:@"CorrespondenceAddress"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickResidenceAdd"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickOfficeAdd"];
	}
    
    if([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickResidenceAdd"] isEqualToString:@"Y"])
        [_BtnResidence setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    
    
    else if([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickOfficeAdd"] isEqualToString:@"Y"])
        [_BtnOffice setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    
    
    if([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ForeignResidenceAdd"] isEqualToString:@"Y"])
        [_BtnResidenceForeignAdd setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    
    if([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ForeignOfficeAdd"] isEqualToString:@"Y"])
        [_BtnOfficeForeignAdd setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    
    
    if ([[self getCountryDesc:[self.LADetails objectForKey:@"ResidenceCountry"]] rangeOfString:@"MALAYSIA"].location != NSNotFound) {
        [_BtnResidenceForeignAdd setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        _residenceCountryBtn.enabled = FALSE;
        _txtCountry1.enabled =false;
		_txtCountry1.textColor = [UIColor grayColor];
        
        //[self ActionCheckResidenceAddress:nil];
    }
    else if ([[self getCountryDesc:[self.LADetails objectForKey:@"ResidenceCountry"]] rangeOfString:@"MALAYSIA"].location == NSNotFound) {
        [_BtnResidenceForeignAdd setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        _residenceCountryBtn.enabled = TRUE;
        _txtCountry1.enabled =FALSE;
        [self CheckResidenceAddress];
    }
    
    _txtAdd1.text = [self.LADetails objectForKey:@"ResidenceAddress1"];
    _txtAdd12.text = [self.LADetails objectForKey:@"ResidenceAddress2"];
    _txtAdd13.text = [self.LADetails objectForKey:@"ResidenceAddress3"];
    _txtPostcode1.text = [self.LADetails objectForKey:@"ResidencePostcode"];
    _txtTown1.text = [self.LADetails objectForKey:@"ResidenceTown"];
    _txtState1.text = [self.LADetails objectForKey:@"ResidenceState"];
    _txtCountry1.text = [self getCountryDesc:[self.LADetails objectForKey:@"ResidenceCountry"]] != NULL ? [self getCountryDesc:[self.LADetails objectForKey:@"ResidenceCountry"]] : [self.LADetails objectForKey:@"ResidenceCountry"];
    
	
	
    //NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *docsDir = [dirPaths objectAtIndex:0];
    //NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    //FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    [db open];
    results = nil;
    results = [db executeQuery:@"select * from eProposal_State where StateCode = ?", [textFields trimWhiteSpaces:_txtState1.text], nil];
    while ([results next]) {
        _txtState1.text = [results objectForColumnName:@"StateDesc"];
    }
    [db close];
    if ([_txtState1.text isEqualToString:@"(null)"]) {
        _txtState1.text = @"";
    }
    
    if ([[self getCountryDesc:[self.LADetails objectForKey:@"OfficeCountry"]] rangeOfString:@"MALAYSIA"].location != NSNotFound) {
        [_BtnOfficeForeignAdd setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        _officeCountryBtn.enabled = FALSE;
		_txtCountry2.textColor = [UIColor grayColor];
        //[self ActionCheckOfficeAddress:nil];
    }
    else if ([[self getCountryDesc:[self.LADetails objectForKey:@"OfficeCountry"]] rangeOfString:@"MALAYSIA"].location == NSNotFound) {
        [_BtnOfficeForeignAdd setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        _officeCountryBtn.enabled = TRUE;
        [self CheckOfficeAddress];
    }
    
    _txtAdd2.text = [self.LADetails objectForKey:@"OfficeAddress1"];
    _txtAdd22.text = [self.LADetails objectForKey:@"OfficeAddress2"];
    _txtAdd23.text = [self.LADetails objectForKey:@"OfficeAddress3"];
    _txtPostcode2.text = [self.LADetails objectForKey:@"OfficePostcode"];
    _txtTown2.text = [self.LADetails objectForKey:@"OfficeTown"];
    _txtState2.text = [self.LADetails objectForKey:@"OfficeState"];
    _txtCountry2.text = ![[self getCountryDesc:[self.LADetails objectForKey:@"OfficeCountry"]] isEqualToString:@"(null)"] ? [self getCountryDesc:[self.LADetails objectForKey:@"OfficeCountry"]] : [self.LADetails objectForKey:@"OfficeCountry"];
    
    [db open];
    results = [db executeQuery:@"select * from eProposal_State where StateCode = ?", [textFields trimWhiteSpaces:_txtState2.text], nil];
    while ([results next]) {
        _txtState2.text = [results objectForColumnName:@"StateDesc"];
    }
    [db close];
    
    if ([_txtState2.text isEqualToString:@"(null)"]) {
        _txtState2.text = @"";
    }
    
    
    
    // Not sure, just put for placeholder
    if ([pcode isEqualToString:@"PO"] || [POFLAG isEqualToString:@"Y"]) {
        _BtnResidence.enabled = TRUE;
        _BtnOffice.enabled = TRUE;
        
        if ([[self.LADetails objectForKey:@"CorrespondenceAddress"] isEqualToString:@"residence"]) {
            //[_BtnResidence setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            //[_BtnOffice setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
            [self ActionCheckCorrespondenceResidence:nil];
            
        }
        else if ([[self.LADetails objectForKey:@"CorrespondenceAddress"] isEqualToString:@"office"]) {
            //[_BtnOffice setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            //[_BtnResidence setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
            [self ActionCheckCorrespondenceOffice:nil];
        }
        
        _BtnResidenceForeignAdd.enabled = TRUE;
        _segOwnership.enabled = TRUE;
        _txtAdd1.enabled = TRUE;
        _txtAdd12.enabled = TRUE;
        _txtAdd13.enabled = TRUE;
        _txtPostcode1.enabled = TRUE;
        
        _BtnOfficeForeignAdd.enabled = TRUE;
        _txtAdd2.enabled = TRUE;
        _txtAdd22.enabled = TRUE;
        _txtAdd23.enabled = TRUE;
        _txtPostcode2.enabled = TRUE;
        
        _txtResidence1.enabled = TRUE;
        _txtResidence2.enabled = TRUE;
        _txtMobile1.enabled = TRUE;
        _txtMobile2.enabled = TRUE;
        _txtOffice1.enabled = TRUE;
        _txtOffice2.enabled = TRUE;
        _txtFax1.enabled = TRUE;
        _txtFax2.enabled = TRUE;
        _txtEmail.enabled = TRUE;
		
		_txtAdd1.textColor = [UIColor blackColor];
		_txtAdd1.textColor = [UIColor blackColor];
        _txtAdd12.textColor = [UIColor blackColor];
        _txtAdd13.textColor = [UIColor blackColor];
        _txtPostcode1.textColor = [UIColor blackColor];
		
		_txtAdd2.textColor = [UIColor blackColor];
        _txtAdd22.textColor = [UIColor blackColor];
        _txtAdd23.textColor = [UIColor blackColor];
		_txtPostcode2.textColor = [UIColor blackColor];
		
		_txtResidence1.textColor = [UIColor blackColor];
        _txtResidence2.textColor = [UIColor blackColor];
        _txtMobile1.textColor = [UIColor blackColor];
        _txtMobile2.textColor = [UIColor blackColor];
        _txtOffice1.textColor = [UIColor blackColor];
        _txtOffice2.textColor = [UIColor blackColor];
        _txtFax1.textColor = [UIColor blackColor];
        _txtFax2.textColor = [UIColor blackColor];
        _txtEmail.textColor = [UIColor blackColor];
    }
    else
    {
		_BtnResidenceForeignAdd.enabled = FALSE;
        _segOwnership.enabled = FALSE;
        _BtnResidence.enabled = FALSE;
        _BtnOffice.enabled = FALSE;
		_txtTown1.enabled = FALSE;
		_txtAdd1.textColor = [UIColor grayColor];
		_txtAdd1.textColor = [UIColor grayColor];
        _txtAdd12.textColor = [UIColor grayColor];
        _txtAdd13.textColor = [UIColor grayColor];
        _txtPostcode1.textColor = [UIColor grayColor];
		_txtTown1.textColor = [UIColor grayColor];
		_txtTown2.textColor = [UIColor grayColor];
		_txtCountry1.textColor = [UIColor grayColor];
		_txtCountry2.textColor = [UIColor grayColor];
		
		
		_residenceCountryBtn.enabled = false;
        _txtCountry1.enabled =false;
		_officeCountryBtn.enabled = false;
		_txtTown1.enabled = false;
		_txtTown2.enabled = false;
        _txtState1.enabled = false;
        _txtState2.enabled = false;
		
		_txtResidence1.textColor = [UIColor grayColor];
        _txtResidence2.textColor = [UIColor grayColor];
        _txtMobile1.textColor = [UIColor grayColor];
        _txtMobile2.textColor = [UIColor grayColor];
        _txtOffice1.textColor = [UIColor grayColor];
        _txtOffice2.textColor = [UIColor grayColor];
        _txtFax1.textColor = [UIColor grayColor];
        _txtFax2.textColor = [UIColor grayColor];
        _txtEmail.textColor = [UIColor grayColor];
		
        [_BtnOffice setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        [_BtnResidence setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    }
    
    // Confirm
    _txtResidence1.text = [self.LADetails objectForKey:@"ResidencePhoneNoPrefix"];
    _txtResidence2.text = [self.LADetails objectForKey:@"ResidencePhoneNo"];
    
    _txtMobile1.text = [self.LADetails objectForKey:@"MobilePhoneNoPrefix"];
    _txtMobile2.text = [self.LADetails objectForKey:@"MobilePhoneNo"];
    
    
    _txtOffice1.text = [self.LADetails objectForKey:@"OfficePhoneNoPrefix"];
    _txtOffice2.text = [self.LADetails objectForKey:@"OfficePhoneNo"];
    
    _txtFax1.text = [self.LADetails objectForKey:@"FaxPhoneNoPrefix"];
    _txtFax2.text = [self.LADetails objectForKey:@"FaxPhoneNo"];
    
    _txtEmail.text = [self.LADetails objectForKey:@"EmailAddress"];
    
    _txtName.text = [self.LADetails objectForKey:@"GuardianName"];
    
    _txtIC.text = [self.LADetails objectForKey:@"GuardianNRIC"];
    
    //_txtIC.delegate = self;
    
    //    if ((![[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"Company Registration Number"]) || (![[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"CR"])) {
    //        [self calculateAge];
    //    }
    //changes by basvi for bug 3006
	
    //	NSLog(@"%@", [textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]]);
    if ((![[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"CR"]) && (![[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"COMPANY REGISTRATION NUMBER"]))
        [self calculateAge];
    //
    //	NSLog(@"ENS GUARDIAN 3: display record");
    //
    //    NSLog(@"age: %d: IDTYPE: %@,  Tick: %@, ID Type: %@", age, [self.LADetails objectForKey:@"LAOtherIDType"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickPart2"], self.OtherTypeIDLbl.text);
    
    if (isPO && (age > 9 && age < 16))
    {
        _txtName.enabled = TRUE;
        _txtIC.enabled = TRUE;
        _policyLifecycleLabel.textColor =[UIColor blackColor];
        _Me.textColor =[UIColor blackColor];
        _asTheParent.textColor =[UIColor blackColor];
        _NRIC.textColor =[UIColor blackColor];
        
    }
	
	if ((age < 10 || age >=16) || !isPO){
		_txtName.enabled = FALSE;
        _txtIC.enabled = FALSE;
        _policyLifecycleLabel.textColor =[UIColor grayColor];
        _Me.textColor =[UIColor grayColor];
        _asTheParent.textColor =[UIColor grayColor];
        _NRIC.textColor =[UIColor grayColor];
		_txtName.text = @"";
        _txtIC.text = @"";
	}
	
	if (([[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"CR"]) || ([[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"COMPANY REGISTRATION NUMBER"]) || [self.OtherTypeIDLbl.text isEqualToString:@"COMPANY REGISTRATION NUMBER"] )
	{
		_txtName.enabled = FALSE;
        _txtIC.enabled = FALSE;
        _policyLifecycleLabel.textColor =[UIColor grayColor];
        _Me.textColor =[UIColor grayColor];
        _asTheParent.textColor =[UIColor grayColor];
        _NRIC.textColor =[UIColor grayColor];
	}
	
	
    //    if (age < 16) {
    //        _txtName.enabled = TRUE;
    //        _txtIC.enabled = TRUE;
    //        _policyLifecycleLabel.textColor =[UIColor blackColor];
    //        _Me.textColor =[UIColor blackColor];
    //        _asTheParent.textColor =[UIColor blackColor];
    //        _NRIC.textColor =[UIColor blackColor];
    //    }
    //
    //	if (age < 10){
    //		_txtName.enabled = FALSE;
    //        _txtIC.enabled = FALSE;
    //        _policyLifecycleLabel.textColor =[UIColor grayColor];
    //        _Me.textColor =[UIColor grayColor];
    //        _asTheParent.textColor =[UIColor grayColor];
    //        _NRIC.textColor =[UIColor grayColor];
    //	}
    
    employerMandatory = TRUE;
    [db open];
    results = [db executeQuery:@"select a.OccpCatCode, b.OccpCode from Adm_OccpCat a inner join Adm_OccpCat_Occp b on a.OccpCatCode = b.OccpCatCode where b.OccpCode = ?", [self.LADetails objectForKey:@"LAOccupationCode"]];
    while ([results next]) {
        NSString *cat = [results stringForColumn:@"OccpCatCode"];
        NSLog(@"cat: %@", cat);
        if ([[textFields trimWhiteSpaces:cat] isEqualToString:@"HSEWIFE"] || [[textFields trimWhiteSpaces:cat] isEqualToString:@"JUV"] || [[textFields trimWhiteSpaces:cat] isEqualToString:@"RET"] || [[textFields trimWhiteSpaces:cat] isEqualToString:@"STU"] || [[textFields trimWhiteSpaces:cat] isEqualToString:@"UNEMP"]) {
            employerMandatory = FALSE;
        }
    }
	
    //if ([[textFields trimWhiteSpaces:_OtherTypeIDLbl.text] caseInsensitiveCompare:@"Company Registration Number"] == NSOrderedSame) {
	if ([_OtherTypeIDLbl.text isEqualToString:@"COMPANY REGISTRATION NUMBER"])
	{
        employerMandatory = FALSE;
        _employerLbl.enabled = FALSE;
        _relationshipLbl.text = @"EMPLOYER";
        _btnRelationship.enabled = FALSE;
        _policyOwnerType.selectedSegmentIndex = 1;
        [[obj.eAppData objectForKey:@"SecPO"] setValue:@"EMPLOYER" forKey:@"PORelationship"];
        [[obj.eAppData objectForKey:@"SecPO"] setValue:@"Y" forKey:@"gotCompany"];
    }
	if ([_OtherTypeIDLbl.text isEqualToString:@"EXPECTED DELIVERY DATE"])
	{
        //		self.OccupationLbl.text = @"";
		_btnRelationship.enabled = FALSE;
		[[obj.eAppData objectForKey:@"SecPO"] setValue:@"BABY" forKey:@"LA1Relationship"];
		
		_relationshipLbl.textColor = [UIColor grayColor];
		_relationshipLbl.text = @"BABY";
		_OccupationLbl.text = @"MINOR";
	}
	
    if (isPO && ([_martialStatusLbl.text isEqualToString:@"DIVORCED"] || [_martialStatusLbl.text isEqualToString:@"WIDOW"] || [_martialStatusLbl.text isEqualToString:@"WIDOWER"])) {
        _segHaveChildren.enabled = TRUE;
        
        if ([[self.LADetails objectForKey:@"HaveChildren"] isEqualToString:@"Y"]) {
            _segHaveChildren.selectedSegmentIndex = 0;
        }
        else if ([[self.LADetails objectForKey:@"HaveChildren"] isEqualToString:@"N"]) {
            _segHaveChildren.selectedSegmentIndex = 1;
        }
    }
    
    [results close];
    [db close];
	
	
	if (isPO) {
		if ([[self.LADetails objectForKey:@"ResidencePOBOX"] isEqualToString:@"Y"]) {
			_SegResidencePOB.selectedSegmentIndex = 0;
			isResidencePOBOXChecked = true;
		}
		else if ([[self.LADetails objectForKey:@"ResidencePOBOX"] isEqualToString:@"N"]) {
			_SegResidencePOB.selectedSegmentIndex = 1;
			isResidencePOBOXChecked = FALSE;
		}
		else {
			_SegResidencePOB.selectedSegmentIndex = -1;
//			isResidencePOBOXChecked = ;
		}
		
		if ([[self.LADetails objectForKey:@"OfficePOBOX"] isEqualToString:@"Y"]) {
			_SegOfficePOB.selectedSegmentIndex = 0;
			isOfficePOBOXChecked = true;
		}
		else if ([[self.LADetails objectForKey:@"OfficePOBOX"] isEqualToString:@"N"]) {
			_SegOfficePOB.selectedSegmentIndex = 1;
			isOfficePOBOXChecked = FALSE;
		}
		else {
			_SegOfficePOB.selectedSegmentIndex = -1;
//			isOfficePOBOXChecked = FALSE;
		}
		
		if ([[self.LADetails objectForKey:@"MalPOBOX"] isEqualToString:@"Y"]) {
			[_btnMalPOB setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
			isMalPOBOXchecked = TRUE;
		}
		else {
			[_btnMalPOB setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
			isMalPOBOXchecked = FALSE;
		}
	}
	
	
}
-(void)displayRecord_PO
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDeleteNominee:) name:@"DeleteNominee" object:nil];
    
    
    
}


-(void)disableAll {
	
	checkPolicyOwner.enabled = FALSE;
	_btnRelationship.enabled = FALSE;
	
	_LblCorrespondenceAdd.enabled = FALSE;
	_LblResidence.enabled = FALSE;
	_LblOffice.enabled = FALSE;
	_BtnResidence.enabled = FALSE;
	
	_segOwnership.enabled =FALSE;
	_LblResidenceAdd.enabled = FALSE;
	_LblForeignAdd.enabled = FALSE;
	_LblOwnership.enabled = FALSE;
	_LblAddress1.enabled = FALSE;
	_LblPostcode1.enabled = FALSE;
	_LblTown1.enabled = FALSE;
	_LblState1.enabled = FALSE;
	_LblCountry1.enabled = FALSE;
	
	_txtPostcode1.enabled = FALSE;
	_txtState1.enabled = FALSE;
	_txtCountry1.enabled = FALSE;
	_txtTown1.enabled = FALSE;
	
	
	_txtAdd1.enabled = FALSE;
	_txtAdd12.enabled = FALSE;
	_txtAdd13.enabled = FALSE;
	
	_BtnResidenceForeignAdd.enabled =FALSE;
	
	_LblOfficeAdd2.enabled = FALSE;
	_LblForeignAdd2.enabled = FALSE;
	_LblAddress2.enabled = FALSE;
	_LblPostcode2.enabled =FALSE;
	_LblState2.enabled = FALSE;
	_LblTown2.enabled = FALSE;
	//_LblCountry2.enabled = true;
	
	_txtPostcode2.enabled = FALSE;
	_txtState2.enabled = FALSE;
	_txtCountry2.enabled = FALSE;
	_txtTown2.enabled = FALSE;
	
	_txtAdd2.enabled = FALSE;
	_txtAdd22.enabled = FALSE;
	_txtAdd23.enabled = FALSE;
	
	_txtAdd2.textColor = [UIColor grayColor];
	_txtAdd22.textColor = [UIColor grayColor];
	_txtAdd23.textColor = [UIColor grayColor];
	_txtPostcode2.textColor = [UIColor grayColor];
	_txtCountry2.textColor = [UIColor grayColor];
	
	
	_BtnOfficeForeignAdd.enabled = FALSE;
	
	_LblContactTitle3.enabled = FALSE;
	_LblResidence3.enabled = FALSE;
	_LblOffice3.enabled = FALSE;
	
	_LblEmail3.enabled = FALSE;
	_LblMobile3.enabled = FALSE;
	_LblFax3.enabled = FALSE;
	
	_txtResidence1.enabled = FALSE;
	_txtResidence2.enabled = FALSE;
	
	_txtOffice1.enabled = FALSE;
	_txtOffice2.enabled = FALSE;
	_txtEmail.enabled = FALSE;
	_txtMobile1.enabled = FALSE;
	_txtMobile2.enabled = FALSE;
	_txtFax1.enabled = FALSE;
	_txtFax2.enabled = FALSE;
	
	_BtnResidenceForeignAdd.enabled = FALSE;
	_segOwnership.enabled = FALSE;
	
	_btnMalPOB.enabled = FALSE;
	_SegOfficePOB.enabled = FALSE;
	_SegResidencePOB.enabled = FALSE;
	
}

-(void)calculateAge {
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    [fmtDate setDateFormat:@"dd/MM/yyyy"];
    NSString *textDate = [NSString stringWithFormat:@"%@",[fmtDate stringFromDate:[NSDate date]]];
    
    NSArray *curr = [textDate componentsSeparatedByString: @"/"];
    NSString *currentDay = [curr objectAtIndex:0];
    NSString *currentMonth = [curr objectAtIndex:1];
    NSString *currentYear = [curr objectAtIndex:2];
    
    //    NSArray *foo =[[NSArray alloc]init];
    //
    //    if([foo isEqual:[NSNull null]]);
    //    {
    //        return;
    //    }
    //    [_DOBLbl.text componentsSeparatedByString: @"/"];
    //    NSString *birthDay = [foo objectAtIndex:0];
    //    NSString *birthMonth = [foo objectAtIndex:1];
    //    NSString *birthYear = [foo objectAtIndex:2];
	
	NSArray *foo = [_DOBLbl.text componentsSeparatedByString: @"/"];
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
    }
    else {
        newALB = 0;
    }
    age = newALB;
}
//-(void)showchangesAlert{
//
//    if(delegate.isNeedPromptSaveMsg == YES)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Do you want to save changes?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
//        [alert setTag:1234];
//        [alert show];
//
//        alert=nil;
//
//
//
//    }
//}


- (void)btnDone:(id)sender
{
    
    if (![self validation]) {
        return;
    }
    else {
        
        
		[[obj.eAppData objectForKey:@"SecPO"] setValue:@"N" forKey:@"RemovePOFLAG"];
		if (iscorrespondenceResidenceChecked == TRUE){
			[self.LADetails setValue:@"residence" forKey:@"CorrespondenceAddress"];
			[[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"TickResidenceAdd"];
			[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickOfficeAdd"];
		}
		else if (iscorrespondenceOfficeChecked == TRUE){
			[self.LADetails setValue:@"office" forKey:@"CorrespondenceAddress"];
			[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickResidenceAdd"];
			[[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"TickOfficeAdd"];
		}
		else {
			[self.LADetails setValue:@"" forKey:@"CorrespondenceAddress"];
			[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickResidenceAdd"];
			[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickOfficeAdd"];
		}
		
		if (isResidenceForiegnAddChecked == true)
			[[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"ForeignResidenceAdd"];
		else
			[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"ForeignResidenceAdd"];
		
		if (isOfficeForiegnAddChecked == true)
			[[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"ForeignOfficeAdd"];
		else
			[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"ForeignOfficeAdd"];
        
        [self.LADetails setValue:_txtIC.text forKey:@"GuardianNRIC"];
        [self.LADetails setValue:_txtName.text forKey:@"GuardianName"];
        
        
        
        [self.LADetails setValue:_txtEmail.text forKey:@"EmailAddress"];
        [self.LADetails setValue:_txtFax2.text forKey:@"FaxPhoneNo"];
        [self.LADetails setValue:_txtFax1.text forKey:@"FaxPhoneNoPrefix"];
        [self.LADetails setValue:_txtOffice2.text forKey:@"OfficePhoneNo"];
        [self.LADetails setValue:_txtOffice1.text forKey:@"OfficePhoneNoPrefix"];
        [self.LADetails setValue:_txtMobile2.text forKey:@"MobilePhoneNo"];
        [self.LADetails setValue:_txtMobile1.text forKey:@"MobilePhoneNoPrefix"];
        [self.LADetails setValue:_txtResidence2.text forKey:@"ResidencePhoneNo"];
        [self.LADetails setValue:_txtResidence1.text forKey:@"ResidencePhoneNoPrefix"];
        //check on correspondence address
        [self.LADetails setValue:_txtCountry2.text forKey:@"OfficeCountry"];
        [self.LADetails setValue:_txtState2.text forKey:@"OfficeState"];
        [self.LADetails setValue:_txtTown2.text forKey:@"OfficeTown"];
        [self.LADetails setValue:_txtPostcode2.text forKey:@"OfficePostcode"];
        [self.LADetails setValue:_txtAdd23.text forKey:@"OfficeAddress3"];
        [self.LADetails setValue:_txtAdd22.text forKey:@"OfficeAddress2"];
        [self.LADetails setValue:_txtAdd2.text forKey:@"OfficeAddress1"];
        [self.LADetails setValue:_txtCountry1.text forKey:@"ResidenceCountry"];
        [self.LADetails setValue:_txtState1.text forKey:@"ResidenceState"];
        [self.LADetails setValue:_txtTown1.text forKey:@"ResidenceTown"];
        [self.LADetails setValue:_txtPostcode1.text forKey:@"ResidencePostcode"];
        
        [self.LADetails setValue:_txtAdd13.text forKey:@"ResidenceAddress3"];
        [self.LADetails setValue:_txtAdd12.text forKey:@"ResidenceAddress2"];
        [self.LADetails setValue:_txtAdd1.text forKey:@"ResidenceAddress1"];
        [self.LADetails setValue:_businessLbl.text forKey:@"LATypeOfBusiness"];
		
        if (_segGender.selectedSegmentIndex == 1) {
            [self.LADetails setValue:@"F" forKey:@"LASex"];
        }
        else if (_segGender.selectedSegmentIndex == 0) {
            [self.LADetails setValue:@"M" forKey:@"LASex"];
        }
        if (_segOwnership.selectedSegmentIndex == 1) {
            [self.LADetails setValue:@"Rented" forKey:@"ResidenceOwnRented"];
        }
        else if (_segOwnership.selectedSegmentIndex == 0) {
            [self.LADetails setValue:@"Own" forKey:@"ResidenceOwnRented"];
        }
        
		if (_SegResidencePOB.selectedSegmentIndex == 0) {
			[self.LADetails setValue:@"Y" forKey:@"ResidencePOBOX"];
		}
		else if (_SegResidencePOB.selectedSegmentIndex == 1){
			[self.LADetails setValue:@"N" forKey:@"ResidencePOBOX"];
		}
		else if (_SegResidencePOB.selectedSegmentIndex == -1){
			[self.LADetails setValue:@"" forKey:@"ResidencePOBOX"];
		}
		
		if (_SegOfficePOB.selectedSegmentIndex == 0) {
			[self.LADetails setValue:@"Y" forKey:@"OfficePOBOX"];
		}
		else if (_SegOfficePOB.selectedSegmentIndex == 1) {
			[self.LADetails setValue:@"N" forKey:@"OfficePOBOX"];
		}
		else if (_SegOfficePOB.selectedSegmentIndex == -1) {
			[self.LADetails setValue:@"" forKey:@"OfficePOBOX"];
		}
		
		if (isMalPOBOXchecked) {
			[self.LADetails setValue:@"Y" forKey:@"MalPOBOX"];
		}
		else {
			[self.LADetails setValue:@"N" forKey:@"MalPOBOX"];
		}
		
		
        
        if (isPO) {
            
            [self.LADetails setValue:@"Y" forKey:@"POFlag"];
            
            [[obj.eAppData objectForKey:@"SecPO"] setValue:_nameLbl.text forKey:@"Confirm_POName"];
            
            [[obj.eAppData objectForKey:@"SecPO"] setValue:_nricLbl.text forKey:@"Confirm_POIC"];
            [[obj.eAppData objectForKey:@"SecPO"] setValue:_otherIDLbl.text forKey:@"Confirm_POOtherID"];
            
            
            [[obj.eAppData objectForKey:@"SecPO"] setValue:[self.LADetails objectForKey:@"PTypeCode"] forKey:@"Confirm_POType"];
            [[obj.eAppData objectForKey:@"EAPP"] setValue:@"Y" forKey:@"POFlag"];
            eAppCheckList* aeappchecklist=[[eAppCheckList alloc]init];
            [aeappchecklist updateCffForCompany];
            [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"data"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
        else {
            //[[obj.eAppData objectForKey:@"SecPO"] setValue:@"" forKey:@"Confirm_POType"];
            [self.LADetails setValue:@"N" forKey:@"POFlag"];
            [[obj.eAppData objectForKey:@"EAPP"] setValue:@"N" forKey:@"POFlag"];
        }
        [self.LADetails setValue:_yearlyIncomeLbl.text forKey:@"LAYearlyIncome"];
        
        if([_relationshipLbl.text isEqualToString:@"(null)"])
            _relationshipLbl.text = @"";
        
        [self.LADetails setValue:_relationshipLbl.text forKey:@"LARelationship"];
        //[self.LADetails setValue:_OccupationLbl.text forKey:@"LAOccupationCode"];
        
        
        
        [self.LADetails setValue:_employerLbl.text forKey:@"LAEmployerName"];
        [self.LADetails setValue:_exaxtDutiesLbl.text forKey:@"LAExactDuties"];
        
        if([_martialStatusLbl.text isEqualToString:@"(null)"])
            _martialStatusLbl.text = @"";
        
        
        [self.LADetails setValue:_martialStatusLbl.text forKey:@"LAMaritalStatus"];
        
        
        if (_segReligion.selectedSegmentIndex == 1) {
            [self.LADetails setValue:@"NON-MUSLIM" forKey:@"LAReligion"];
        }
        else if (_segReligion.selectedSegmentIndex == 0) {
            [self.LADetails setValue:@"MUSLIM" forKey:@"LAReligion"];
        }
        //        if ([[self.LADetails objectForKey:@"LAReligion"] hasPrefix:@"NON-MUSLIM"]) {
        //            _segReligion.selectedSegmentIndex = 1;
        //        }
        //        else if ([[self.LADetails objectForKey:@"LAReligion"] hasPrefix:@"MUSLIM"]) {
        //            _segReligion.selectedSegmentIndex = 0;
        //        }
        
        
        
        [self.LADetails setValue:_otherIDLbl.text forKey:@"LAOtherID"];
        [self.LADetails setValue:IDTypeCodeSelected forKey:@"LAOtherIDType"];
        if ([self.LADetails objectForKey:@"LAOtherIDType"] == NULL)
            [self.LADetails setValue:@"" forKey:@"LAOtherIDType"];
        [self.LADetails setValue:_nationalityLbl.text forKey:@"LANationality"];
        [self.LADetails setValue:_nricLbl.text forKey:@"LANewICNO"];
        [self.LADetails setValue:_raceLbl.text forKey:@"LARace"];
        [self.LADetails setValue:_nameLbl.text forKey:@"LAName"];
        
        if (_segSmoker.selectedSegmentIndex == 0) {
            [self.LADetails setValue:@"Y" forKey:@"LASmoker"];
        }
        else if (_segSmoker.selectedSegmentIndex == 1) {
            [self.LADetails setValue:@"N" forKey:@"LASmoker"];
        }
        
        NSString *officeCountry = [self getCountryCode:_txtCountry2.text];
        NSString *residenceCountry =@"";
        residenceCountry = [self getCountryCode:_txtCountry1.text];
        if([residenceCountry isEqualToString:@"(null)"] || [residenceCountry isEqualToString:@""] ||  (residenceCountry ==NULL))
            residenceCountry = @"";
        
        [self.LADetails setValue:officeCountry forKey:@"OfficeCountry"];
        [self.LADetails setValue:residenceCountry forKey:@"ResidenceCountry"];
        
        _DOBLbl.text =  [_DOBLbl.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [self.LADetails setValue:_DOBLbl.text forKey:@"LADOB"];
        
        if ([[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ForeignResidenceAdd"] == NULL)
            [[obj.eAppData objectForKey:@"SecA"] setValue:@"" forKey:@"ForeignResidenceAdd"];
        if ([[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ForeignOfficeAdd"] == NULL)
            [[obj.eAppData objectForKey:@"SecA"] setValue:@"" forKey:@"ForeignOfficeAdd"];
        
        NSString *counter =@"";
        
        counter =   [self.LADetails objectForKey:@"ProspectProfileChangesCounter"];
        if ([counter isEqualToString:@"(null)" ] ||[counter isEqualToString:@"" ] || (counter==NULL))
            counter = @"";
        
        if (isPO) {
            if (_segHaveChildren.selectedSegmentIndex == 0) {
                [self.LADetails setValue:@"Y" forKey:@"HaveChildren"];
            }
            else if (_segHaveChildren.selectedSegmentIndex == 1) {
                [self.LADetails setValue:@"N" forKey:@"HaveChildren"];
            }
        }
        
        [self.LADetails setValue:[self getTitleCode2:_titleLbl.text ] forKey:@"LATitle"];
        
        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        NSString *currentdate = [dateFormatter2 stringFromDate:[NSDate date]];
        
        [self.LADetails setValue:currentdate forKey:@"UpdatedAt"];
        
        int index = [[self.LADetails objectForKey:@"index"] intValue];
        [[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LADetails"] removeObjectAtIndex:index];
        [[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LADetails"] insertObject:[self.LADetails mutableCopy] atIndex:index];
        
        const char *dbpath = [databasePath UTF8String];
        sqlite3_stmt *stmt;
        
		
        if ([[self.LADetails objectForKey:@"PTypeCode"] isEqualToString:@"PO"])
        {
            
			if (![self CheckPOExist]) {
				
				NSString *insertQuery = [NSString stringWithFormat:@"INSERT INTO eProposal_LA_Details(eProposalNo, PTypeCode, LAName, ProspectProfileID) VALUES('%@', '%@', '%@', '%@')", [self.LADetails objectForKey:@"eProposalNo"], [self.LADetails objectForKey:@"PTypeCode"], [self.LADetails objectForKey:@"LAName"], [self.LADetails objectForKey:@"ProspectProfileID"]];
				
				if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
					NSLog(@"open success");
					const char *query = [insertQuery UTF8String];
					
					if (sqlite3_prepare_v2(contactDB, query, -1, &stmt, NULL) == SQLITE_OK)
					{
						sqlite3_step(stmt);
					}
					else {
						NSLog(@"error: %s", sqlite3_errmsg(contactDB));
					}
					NSLog(@"done successs");
					sqlite3_finalize(stmt);
				}
                
			}
        }
        
        
        NSLog(@"IDTYPE: %@",[self.LADetails objectForKey:@"LAOtherIDType"]);
		
		if ([[self.LADetails objectForKey:@"LAOtherIDType"] isEqualToString:@"EDD"]) {
			[self.LADetails setValue:@"BABY" forKey:@"LARelationship"];
			[self.LADetails setValue:@"" forKey:@"LAOccupationCode"];
			
		}
		
		NSString *title = [self.LADetails objectForKey:@"LATitle"];
		if (title == nil)
			title = @"";
        
        NSString *pental_declaration = @"False";
        
        if ([[self.LADetails objectForKey:@"PTypeCode"] isEqualToString:@"PO"] && [[self.LADetails objectForKey:@"LAOtherIDType"] isEqualToString:@"CR"]) {
            pental_declaration = @"True";
        }
		
        NSString *sqlQuery = [NSString stringWithFormat:@"Update eProposal_LA_Details SET \"eProposalNo\" = \"%@\", \"PTypeCode\" = \"%@\", \"LATitle\" = \"%@\", \"LAName\" = \"%@\", \"LASex\" = \"%@\", \"LADOB\" = \"%@\", \"LANewICNO\" = \"%@\", \"LAOtherIDType\" = \"%@\", \"LAOtherID\" = \"%@\", \"LAMaritalStatus\" = \"%@\", \"LARace\" = \"%@\", \"LAReligion\" = \"%@\", \"LANationality\" = \"%@\", \"LAOccupationCode\" = \"%@\", \"LAExactDuties\" = \"%@\", \"LATypeOfBusiness\" = \"%@\", \"LAEmployerName\" = \"%@\", \"LAYearlyIncome\" = \"%@\", \"LARelationship\" = \"%@\", \"POFlag\" = \"%@\", \"CorrespondenceAddress\" = \"%@\", \"ResidenceOwnRented\" = \"%@\", \"ResidenceAddress1\" = \"%@\", \"ResidenceAddress2\" = \"%@\", \"ResidenceAddress3\" = \"%@\", \"ResidenceTown\" = \"%@\", \"ResidenceState\" = \"%@\", \"ResidencePostcode\" = \"%@\", \"ResidenceCountry\" = \"%@\", \"OfficeAddress1\" = \"%@\", \"OfficeAddress2\" = \"%@\", \"OfficeAddress3\" = \"%@\", \"OfficeTown\" = \"%@\", \"OfficeState\" = \"%@\", \"OfficePostcode\" = \"%@\", \"OfficeCountry\" = \"%@\", \"ResidencePhoneNo\" = \"%@\", \"OfficePhoneNo\" = \"%@\", \"FaxPhoneNo\" = \"%@\", \"MobilePhoneNo\" = \"%@\", \"EmailAddress\" = \"%@\", \"PentalHealthStatus\" = \"%@\", \"PentalFemaleStatus\" = \"%@\", \"PentalDeclarationStatus\" = \"%@\", \"LACompleteFlag\" = \"%@\", \"AddPO\" = \"%@\", \"CreatedAt\" = \"%@\", \"UpdatedAt\" = \"%@\", \"ResidencePhoneNoPrefix\" = \"%@\", \"OfficePhoneNoPrefix\" = \"%@\", \"FaxPhoneNoPrefix\" = \"%@\", \"MobilePhoneNoPrefix\" = \"%@\", \"LASmoker\" = \"%@\", \"ProspectProfileChangesCounter\" = \"%@\", \"ResidenceForeignAddressFlag\" = \"%@\", \"OfficeForeignAddressFlag\" = \"%@\", \"GST_registered\" = \"%@\", \"GST_registrationNo\" = \"%@\", \"GST_registrationDate\" = \"%@\", \"GST_exempted\" = \"%@\", \"LABirthCountry\" = \"%@\", \"MalaysianWithPOBox\" = \"%@\", \"Residence_POBOX\" = \"%@\", \"Office_POBOX\" = \"%@\" WHERE eProposalNo = \"%@\" AND PTypeCode = \"%@\";", [self.LADetails objectForKey:@"eProposalNo"], [self.LADetails objectForKey:@"PTypeCode"], title, [self.LADetails objectForKey:@"LAName"], [self.LADetails objectForKey:@"LASex"], [self.LADetails objectForKey:@"LADOB"], [self.LADetails objectForKey:@"LANewICNO"], [self.LADetails objectForKey:@"LAOtherIDType"], [self.LADetails objectForKey:@"LAOtherID"], [self.LADetails objectForKey:@"LAMaritalStatus"], [self.LADetails objectForKey:@"LARace"], [self.LADetails objectForKey:@"LAReligion"], [self.LADetails objectForKey:@"LANationality"], [self.LADetails objectForKey:@"LAOccupationCode"], [self.LADetails objectForKey:@"LAExactDuties"], [self.LADetails objectForKey:@"LATypeOfBusiness"], [self.LADetails objectForKey:@"LAEmployerName"], [self.LADetails objectForKey:@"LAYearlyIncome"], [self.LADetails objectForKey:@"LARelationship"], [self.LADetails objectForKey:@"POFlag"], [self.LADetails objectForKey:@"CorrespondenceAddress"], [self.LADetails objectForKey:@"ResidenceOwnRented"], [self.LADetails objectForKey:@"ResidenceAddress1"], [self.LADetails objectForKey:@"ResidenceAddress2"], [self.LADetails objectForKey:@"ResidenceAddress3"], [self.LADetails objectForKey:@"ResidenceTown"], [self.LADetails objectForKey:@"ResidenceState"], [self.LADetails objectForKey:@"ResidencePostcode"], residenceCountry, [self.LADetails objectForKey:@"OfficeAddress1"], [self.LADetails objectForKey:@"OfficeAddress2"], [self.LADetails objectForKey:@"OfficeAddress3"], [self.LADetails objectForKey:@"OfficeTown"], [self.LADetails objectForKey:@"OfficeState"], [self.LADetails objectForKey:@"OfficePostcode"], officeCountry, [self.LADetails objectForKey:@"ResidencePhoneNo"], [self.LADetails objectForKey:@"OfficePhoneNo"], [self.LADetails objectForKey:@"FaxPhoneNo"],  [self.LADetails objectForKey:@"MobilePhoneNo"], [self.LADetails objectForKey:@"EmailAddress"], @"False", @"False", pental_declaration, @"1", [self.LADetails objectForKey:@"AddPO"], [self.LADetails objectForKey:@"CreatedAt"], [self.LADetails objectForKey:@"UpdatedAt"], [self.LADetails objectForKey:@"ResidencePhoneNoPrefix"],  [self.LADetails objectForKey:@"OfficePhoneNoPrefix"], [self.LADetails objectForKey:@"FaxPhoneNoPrefix"], [self.LADetails objectForKey:@"MobilePhoneNoPrefix"], [self.LADetails objectForKey:@"LASmoker"], counter , [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ForeignResidenceAdd"], [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ForeignOfficeAdd"],[self.LADetails objectForKey:@"GST_registered"],[self.LADetails objectForKey:@"GST_registrationNo"],[self.LADetails objectForKey:@"GST_registrationDate"],[self.LADetails objectForKey:@"GST_exempted"],[self.LADetails objectForKey:@"BirthCountry"],[self.LADetails objectForKey:@"MalPOBOX"],[self.LADetails objectForKey:@"ResidencePOBOX"],[self.LADetails objectForKey:@"OfficePOBOX"],[self.LADetails objectForKey:@"eProposalNo"], [self.LADetails objectForKey:@"PTypeCode"]];
        
        
        
        
        //Update POFlag = N for other PTypeCode
        NSString *updateOtherPOFlag = [NSString stringWithFormat:@"Update eProposal_LA_Details SET POFlag = 'N', UpdatedAt = '%@'  WHERE eProposalNo = '%@' AND PTypeCode != '%@'",[self.LADetails objectForKey:@"UpdatedAt"], [self.LADetails objectForKey:@"eProposalNo"], [self.LADetails objectForKey:@"PTypeCode"]];
        
        
        //Update "eProposal" - save Guardian Name & Guardian NIRC
        NSString *update_eproposal = [NSString stringWithFormat:@"Update eProposal SET GuardianName = '%@', GuardianNewICNo = '%@'  WHERE eProposalNo = '%@'",_txtName.text, _txtIC.text,[self.LADetails objectForKey:@"eProposalNo"]];
        
        
        sqlite3_stmt *statement;
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
            const char *query_stmt = [sqlQuery UTF8String];
            const char *updateOtherpoflag = [updateOtherPOFlag UTF8String];
            const char *update_eproposal_Query = [update_eproposal UTF8String];
            
            //UPDATE "eProposal_LA_Details" THE 'POFlag' for SELECTED PO to 'Y'
            if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                sqlite3_step(statement);
            }
            sqlite3_finalize(statement);
            
            //UPDATE "eProposal_LA_Details" THE 'POFlag' for OTHERS  PO to 'N'
            if (isPO) {
                if (sqlite3_prepare_v2(contactDB, updateOtherpoflag, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    
                }
                sqlite3_finalize(statement);
            }
            //Update "eProposal" - save Guardian Name & Guardian NIRC
            //            if(_txtName.text.length != 0 && _txtIC.text !=0)
            //            {
            if (sqlite3_prepare_v2(contactDB, update_eproposal_Query, -1, &statement, NULL) == SQLITE_OK)
            {
                sqlite3_step(statement);
            }
            sqlite3_finalize(statement);
            //            }
            
        }
        sqlite3_close(contactDB);
        
        // Update have children
        if (isPO && ([_martialStatusLbl.text isEqualToString:@"DIVORCED"] || [_martialStatusLbl.text isEqualToString:@"WIDOW"] || [_martialStatusLbl.text isEqualToString:@"WIDOWER"])) {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *docsPath = [paths objectAtIndex:0];
            NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
            
            FMDatabase *database = [FMDatabase databaseWithPath:path];
            [database open];
            bool success = [database executeUpdate:[NSString stringWithFormat:@"Update eProposal_LA_Details SET HaveChildren = \"%@\" where eProposalNo = \"%@\" and POFlag = 'Y'", [self.LADetails objectForKey:@"HaveChildren"], [self.LADetails objectForKey:@"eProposalNo"]]];
            if (success) {
                NSLog(@"update have children success");
            }
            else {
                NSLog(@"%@", [database lastErrorMessage]);
            }
            [database close];
        }
        
        if (![obj.eAppData objectForKey:@"CFF"]) {
            [obj.eAppData setValue:[[NSMutableDictionary alloc] init] forKey:@"CFF"];
        }
        [[obj.eAppData objectForKey:@"SecPO"] setValue:@"1" forKey:@"POCompleted"];
        [[obj.eAppData objectForKey:@"EAPP"] setValue:@"Y" forKey:@"CompletePO"];
        if (isPO) {
            [[obj.eAppData objectForKey:@"SecPO"] setValue:_relationshipLbl.text forKey:@"PORelationship"];
        }
        else {
            if ([[self.LADetails objectForKey:@"PTypeCode"] isEqualToString:@"LA1"])
                [[obj.eAppData objectForKey:@"SecPO"] setValue:_relationshipLbl.text forKey:@"LA1Relationship"];
            else if ([[self.LADetails objectForKey:@"PTypeCode"] isEqualToString:@"LA2"])
                [[obj.eAppData objectForKey:@"SecPO"] setValue:_relationshipLbl.text forKey:@"LA2Relationship"];
            else if ([[self.LADetails objectForKey:@"PTypeCode"] isEqualToString:@"PY1"])
                [[obj.eAppData objectForKey:@"SecPO"] setValue:_relationshipLbl.text forKey:@"PYRelationship"];
        }
		//[[obj.eAppData objectForKey:@"SecPO"] setValue:_relationshipLbl.text forKey:@"LA1Relationship"];
		
        //enable the 'Policy Owner' label in the PolicyOwner table cell
        //   [_delegate updatePOLabel:[self.LADetails objectForKey:@"PTypeCode"]];
        
        
        // NSLog(@"upatePOLabel: %@", [[obj.eAppData objectForKey:@"SecPO"]  objectForKey:@"Confirm_POType"]);
        
        //PASS VALUE TO PolicyOwnerData
        //[self.delegate  updatePOLabel:[[obj.eAppData objectForKey:@"SecPO"]  objectForKey:@"Confirm_POType"]];
        
        NSLog(@"PO: %d", isPart2Checked);
        if (isPart2Checked) {
            [[obj.eAppData objectForKey:@"SecPO"] setValue:[self.LADetails objectForKey:@"LAName"] forKey:@"POName"];
            [[obj.eAppData objectForKey:@"SecPO"] setValue:[self.LADetails objectForKey:@"ProspectProfileID"] forKey:@"ProspectProfileID"];
            [self.delegate updatePO:YES];
            //[self.delegate updateChecklistCFF:YES];
        }
        else{
            [self.delegate updatePO:NO];
        }
        // [[obj.eAppData objectForKey:@"SecPO"] setValue:[self.LADetails objectForKey:@"PTypeCode"] forKey:@"SavedPOType"];
        
	}
    if (isMoifiedData)
    {
		NSString *eProposalNo = [self.LADetails objectForKey:@"eProposalNo"];
		[self Clear_EAppProposal_Value:eProposalNo];
		[self DeleteEAppCFF:eProposalNo];
        ClearData *ClData =[[ClearData alloc]init];
		[ClData deleteOldPdfs:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];

		
		
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"SecA_Saved"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"SecB_Saved"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"SecC_Saved"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"SecD_Saved"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"SecE_Saved"];
		[[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"SecF_Saved"];
		[[obj.eAppData objectForKey:@"EAPP"] setValue:@"N" forKey:@"Proposal_Confirmation"];
    }
    [self dismissModalViewControllerAnimated:YES];
}

-(void)Clear_EAppProposal_Value:(NSString *)proposal {
	
	FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
	
	NSString *query = @"";
	query = [NSString stringWithFormat:@"UPDATE eProposal SET ProposalCompleted = 'N', COMandatoryFlag = '', PolicyDetailsMandatoryFlag = '', QuestionnaireMandatoryFlag = '', NomineesMandatoryFlag = '', AdditionalQuestionsMandatoryFlag = 'N', DeclarationMandatoryFlag = '', DeclarationAuthorization = '', COTitle = '', COSex = '', COName = '', COPhoneNo = '', CONewICNo = '', COMobileNo = '', CODOB = '', COEmailAddress = '', CONationality = '', COOccupation = '', CONameOfEmployer = '', COExactNatureOfWork = '', COOtherIDType = '', COOtherID = '', CORelationship = '', COSameAddressPO = '', COAddress1 = '', COAddress2 = '', COAddress3 = '', COPostcode = '', COTown = '', COState = '', COCountry = '', COCRAddress1 = '', COCRAddress2 = '', COCRAddress3 = '', COCRPostcode = '', COCRTown = '', COCRState = '', COCRCountry = '', LAMandatoryFlag = 'N', COForeignAddressFlag = '', COCRForeignAddressFlag = '', PaymentMode = '', BasicPlanTerm = '', BasicPlanSA = '', BasicPlanModalPremium ='', TotalModalPremium ='', FirstTimePayment = '', PaymentUponFinalAcceptance = '' ,EPP='', RecurringPayment = '', SecondAgentCode = '', SecondAgentContactNo = '', SecondAgentName = '', PTypeCode = '', CreditCardBank = '', CreditCardType = '', CardMemberAccountNo = '', CardExpiredDate = '', CardMemberName = '', CardMemberSex = '', CardMemberDOB = '', CardMemberNewICNo = '', CardMemberOtherIDType = '', CardMemberOtherID = '', CardMemberContactNo = '', CardMemberRelationship = '', FTPTypeCode = '', FTCreditCardBank = '', FTCreditCardType = '', FTCardMemberAccountNo = '', FTCardExpiredDate = '', FTCardMemberName = '', FTCardMemberSex = '', FTCardMemberDOB = '', FTCardMemberNewICNo = '', FTCardMemberOtherIDType = '', FTCardMemberOtherID = '', FTCardMemberContactNo = '', FTCardMemberRelationship = '', SameAsFT = '', FullyPaidUpOption = '', FullyPaidUpTerm = '', RevisedSA = '', AmtRevised = '', PolicyDetailsMandatoryFlag = '', LIEN = '', ExistingPoliciesMandatoryFlag = 'N' WHERE eProposalNo = '%@'", proposal, nil];
	[db executeUpdate:query];
	
	
	//Delete eProposal_Existing_Policy_1
	if (![db executeUpdate:@"Delete from eProposal_Existing_Policy_1 where eProposalNo = ?", proposal, nil]) {
		NSLog(@"Error in Delete Statement - eProposal_Existing_Policy_1");
	}
	
	//Delete eProposal_Existing_Policy_2
	if (![db executeUpdate:@"Delete from eProposal_Existing_Policy_2 where eProposalNo = ?", proposal, nil]) {
		NSLog(@"Error in Delete Statement - eProposal_Existing_Policy_2");
	}
	
	//Delete eProposal_NM_Details
	if (![db executeUpdate:@"Delete from eProposal_NM_Details where eProposalNo = ?", proposal, nil]) {
		NSLog(@"Error in Delete Statement - eProposal_NM_Details");
	}
	
	//Delete eProposal_Trustee_Details
	if (![db executeUpdate:@"Delete from eProposal_Trustee_Details where eProposalNo = ?", proposal, nil]) {
		NSLog(@"Error in Delete Statement - eProposal_Trustee_Details");
	}
	
	//Delete eProposal_QuestionAns
	if (![db executeUpdate:@"Delete from eProposal_QuestionAns where eProposalNo = ?", proposal, nil]) {
		NSLog(@"Error in Delete Statement - eProposal_QuestionAns");
	}
	
	//Delete eProposal_Additional_Questions_1
	if (![db executeUpdate:@"Delete from eProposal_Additional_Questions_1 where eProposalNo = ?", proposal, nil]) {
		NSLog(@"Error in Delete Statement - eProposal_Additional_Questions_1");
	}
	
	//Delete eProposal_Additional_Questions_2
	if (![db executeUpdate:@"Delete from eProposal_Additional_Questions_2 where eProposalNo = ?", proposal, nil]) {
		NSLog(@"Error in Delete Statement - eProposal_Additional_Questions_2");
	}
	
}

-(void)DeleteEAppCFF:(NSString *)proposal {
    
	
	FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
	
    //Delete eApp_Listing
	NSLog(@"Delete eAPP_CFF %@", proposal);
	
	NSString *status;
	//ADD BY EMI: Delete only for status created and Confirmed
	FMResultSet *result = [db executeQuery:[NSString stringWithFormat:@"Select status from eApp_listing where ProposalNo = '%@'", proposal]];
	
    while ([result next]) {
		status = [result objectForColumnName:@"status"];
	}
	
	
	if ([status isEqualToString:@"2"]) {
		//DELETE CFF START
		
		//Delete eProposal_CFF_Master
		if (![db executeUpdate:@"Delete from eProposal_CFF_Master where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Master");
		}
		
		//Delete eProposal_CFF_CA
		if (![db executeUpdate:@"Delete from eProposal_CFF_CA where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_CA");
		}
		
		//Delete eProposal_CFF_CA_Recommendation
		if (![db executeUpdate:@"Delete from eProposal_CFF_CA_Recommendation where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_CA_Recommendation");
		}
		
		//Delete eProposal_CFF_CA_Recommendation_Rider
		if (![db executeUpdate:@"Delete from eProposal_CFF_CA_Recommendation where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_CA_Recommendation_Rider");
		}
		
		//Delete eProposal_CFF_Education
		if (![db executeUpdate:@"Delete from eProposal_CFF_Education where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Education");
		}
		
		//Delete eProposal_CFF_Education_Details
		if (![db executeUpdate:@"Delete from eProposal_CFF_Education_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Education_Details");
		}
		
		//Delete eProposal_CFF_Family_Details
		if (![db executeUpdate:@"Delete from eProposal_CFF_Family_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Family_Details");
		}
		
		//Delete eProposal_CFF_Personal_Details
		if (![db executeUpdate:@"Delete from eProposal_CFF_Personal_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Personal_Details");
		}
		
		//Delete eProposal_CFF_Protection
		if (![db executeUpdate:@"Delete from eProposal_CFF_Protection where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Protection");
		}
		
		//Delete eProposal_CFF_Protection_Details
		if (![db executeUpdate:@"Delete from eProposal_CFF_Protection_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Protection_Details");
		}
		
		//Delete eProposal_CFF_RecordOfAdvice
		if (![db executeUpdate:@"Delete from eProposal_CFF_RecordOfAdvice where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_RecordOfAdvice");
		}
		
		//Delete eProposal_CFF_RecordOfAdvice_Rider
		if (![db executeUpdate:@"Delete from eProposal_CFF_RecordOfAdvice_Rider where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_RecordOfAdvice_Rider");
		}
		
		//Delete eProposal_CFF_Retirement
		if (![db executeUpdate:@"Delete from eProposal_CFF_Retirement where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Retirement");
		}
		
		//Delete eProposal_CFF_Retirement_Details
		if (![db executeUpdate:@"Delete from eProposal_CFF_Retirement_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_Retirement_Details");
		}
		
		//Delete eProposal_CFF_SavingsInvest
		if (![db executeUpdate:@"Delete from eProposal_CFF_SavingsInvest where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest");
		}
		
		//Delete eProposal_CFF_SavingsInvest_Details
		if (![db executeUpdate:@"Delete from eProposal_CFF_SavingsInvest_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest_Details");
		}
		
		//Delete eProposal_CFF_SavingsInvest_Details
		if (![db executeUpdate:@"Delete from eProposal_CFF_SavingsInvest_Details where eProposalNo = ?", proposal, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest_Details");
		}
		//DELETE CFF END
	}
	
}


-(void)btnCancel:(id)sender {
    if (isMoifiedData)
    {
        
        [self hideKeyboard];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Do you want to save the changes?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
        
        NSLog(@"here1");
        [alert setTag:1234];
        [alert show];
        
        alert=nil;
        
    }
    else
        [self dismissViewControllerAnimated:YES completion:Nil];
    
}


-(void)doDelete {
    if ([[self.LADetails objectForKey:@"PTypeCode"] isEqualToString:@"PO"]) {
        int index = [[self.LADetails objectForKey:@"index"] intValue];
        [[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LADetails"] removeObjectAtIndex:index];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsPath = [paths objectAtIndex:0];
        NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:path];
        [database open];
        [database executeUpdate:@"DELETE FROM eProposal_LA_Details WHERE eProposalNo = ? AND PTypeCode = 'PO'", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
		
		
		NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
		NSDate *currDate = [NSDate date];
		[dateFormatter2 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
		NSString *dateString = [dateFormatter2 stringFromDate:currDate];
		
		NSString *UpdateQuery = [NSString stringWithFormat:@"UPDATE eApp_Listing SET PONAME = '', IDNumber = '', OtherIDNo = '', DateUpdated = '%@'  WHERE ProposalNo = '%@' ", dateString, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
		
		
		
		
		
		BOOL UpdateSuccess = [database executeUpdate:UpdateQuery];
		
		if (!UpdateSuccess) {
			NSLog(@"Problem with this query:>> %@",UpdateQuery);
		}
		
		
        [database close];
        
        [[obj.eAppData objectForKey:@"SecPO"] setValue:@"" forKey:@"NewPOName"];
        [self.delegate doneDelete];
        [self dismissViewControllerAnimated:TRUE completion:nil];
    }
}

-(NSString*) getCountryCode : (NSString*)country
{
    NSString *code;
    country = [country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT CountryCode FROM eProposal_Country WHERE CountryDesc = ?", country];
    
    while ([result next]) {
        code =[result objectForColumnName:@"CountryCode"];
        
    }
    [result close];
    [db close];
    NSLog(@"country: %@, code: %@", country, code);
    return code;
    
}



-(NSString*) getCountryDesc : (NSString*)country
{
    NSString *code;
    country = [country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT CountryDesc FROM eProposal_Country WHERE CountryCode = ?", country];
    
    while ([result next]) {
        code =[result objectForColumnName:@"CountryDesc"];
        
    }
    
    [result close];
    [db close];
    
    return code;
    
}


-(void)extractDB
{
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results;
    NSString* poname;
    results =  [database executeQuery:@"SELECT LAName FROM eProposal_LA_Details WHERE eProposalNo = ? AND POFlag = 'Y'", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
    while ([results next]) {
        
        poname = [results objectForColumnName:@"LAName"];
        
        
    }
    
    [database close];
    
    [[obj.eAppData objectForKey:@"SecPO"] setValue:poname forKey:@"NewPOName"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)viewDidUnload {
    [self setPolicyOwnerType:nil];
    [self setNameLbl:nil];
    [self setNricLbl:nil];
    [self setOtherIDLbl:nil];
    [self setSegReligion:nil];
    [self setEmployerLbl:nil];
    [self setBusinessLbl:nil];
    [self setExaxtDutiesLbl:nil];
    [self setYearlyIncomeLbl:nil];
    [self setSegGender:nil];
    [self setSegSmoker:nil];
    [self setTxtNRIC:nil];
    [self setResidenceCountryBtn:nil];
    [self setOfficeCountryBtn:nil];
    [self setBtnRelationship:nil];
    [self setSegHaveChildren:nil];
    [self setClearExaxtDuties:nil];
    [super viewDidUnload];
}


-(BOOL)validation {
    [self hideKeyboard];
    
    
	BOOL isEDD;  //unbornchild
	
	if (([[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"EDD"]) || ([[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"EXPECTED DELIVERY DATE"]))
	{
		isEDD = TRUE;
	}
	else
		isEDD = FALSE;
    
    
    if (isPO && ([_martialStatusLbl.text isEqualToString:@"DIVORCED"] || [_martialStatusLbl.text isEqualToString:@"WIDOW"] || [_martialStatusLbl.text isEqualToString:@"WIDOWER"]) && _segHaveChildren.selectedSegmentIndex == UISegmentedControlNoSegment) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Have Children question need to be answered" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = Nil;
        return FALSE;
    }
    
    if (_relationshipLbl.text.length == 0 && !isEDD) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Relationship is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = Nil;
        return FALSE;
    }
    else if (isPO && ![_relationshipLbl.text isEqualToString:@"SELF"] && [[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LADetails"] count] == 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Relationship must be SELF." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = Nil;
        return FALSE;
    }
    // if ([POFLAG isEqualToString:@"Y"])
    else if (isPO && [_relationshipLbl.text isEqualToString:@"SELF"] && [[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LADetails"] count] != 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Relationship cannot be SELF." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = Nil;
        return FALSE;
    }
	else if (!isPO && [_relationshipLbl.text isEqualToString:@"SELF"] ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Relationship cannot be SELF." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = Nil;
        return FALSE;
    }
    
    
    if (!isPO && [[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"PORelationship"] isEqualToString:_relationshipLbl.text] && !isEDD) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Relationship for both Policy Owner and 1st Life Assured cannot be the same." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = Nil;
        return FALSE;
    }
	NSLog(@"EEEEEELA: LA1 %@, LA2 %@, PY1 %@, Current: %@",[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LA1Relationship"], [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LA2Relationship"], [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"PYRelationship"], _relationshipLbl.text);
	if (isPO && [[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LA1Relationship"] isEqualToString:_relationshipLbl.text] && (![[self.LADetails objectForKey:@"PTypeCode"] isEqualToString:@"LA1"])) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Relationship for both Policy Owner and 1st Life Assured cannot be the same." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = Nil;
        return FALSE;
    }
	if (isPO && [[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LA2Relationship"] isEqualToString:_relationshipLbl.text] && (![[self.LADetails objectForKey:@"PTypeCode"] isEqualToString:@"LA2"])) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Relationship for both Policy Owner and 2nd Life Assured cannot be the same." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = Nil;
        return FALSE;
    }
    NSLog(@"a: %@, b %@, c %@", [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"gotCompany"], [textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]], _relationshipLbl.text);
    if ([[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"gotCompany"] isEqualToString:@"Y"]) {
		if (([[self.LADetails objectForKey:@"LAOtherIDType"] isEqualToString:@"COMPANY REGISTRATION NUMBER"]) || ([[self.LADetails objectForKey:@"LAOtherIDType"] isEqualToString:@"CR"])){
			if (![_relationshipLbl.text isEqualToString:@"EMPLOYER"]) {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Relationship for Company case must be EMPLOYEE vs EMPLOYER." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
				alert = Nil;
				return FALSE;
			}
		}
	}
    
	if (!isPO && [[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"gotCompany"] isEqualToString:@"Y"] && [[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"PORelationship"] isEqualToString:@"EMPLOYER"]) {
		if (![_relationshipLbl.text isEqualToString:@"EMPLOYEE"]) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Life Assured’s Relationship with Policy Owner must be Employee" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			alert = Nil;
            return FALSE;
		}
    }
	
    
	
    if (!(isEDD)) {
        
        if ((![[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"CR"]) && (![[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"COMPANY REGISTRATION NUMBER"])) {
            
            if ([textFields trimWhiteSpaces:_employerLbl.text].length == 0 && employerMandatory) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Name of Employer is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 1003;
                [alert show];
                alert = Nil;
                return FALSE;
            }
            
            if ([textFields trimWhiteSpaces:_employerLbl.text].length > 0 && [textFields validateOtherID:_employerLbl.text]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid name format. Input must be alphabet A to Z, space, apostrophe('), alias(@), slash(/), dash(-), bracket(()) or dot(.)." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 1003;
                [alert show];
                alert = Nil;
                return FALSE;
            }
            
            if ([textFields trimWhiteSpaces:_employerLbl.text].length > 0 && [textFields validateString:_employerLbl.text]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid name format. Same alphabet cannot be repeated more than three times." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 1003;
                [alert show];
                alert = Nil;
                return FALSE;
            }
        }
        if ([textFields trimWhiteSpaces:_businessLbl.text].length == 0 && employerMandatory ) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Type of Business is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 1009;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        
        if (!iscorrespondenceOfficeChecked && !iscorrespondenceResidenceChecked && isPO) {
            NSLog(@"checkingCor2");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Correspondence Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = Nil;
            return FALSE;
        }
        
        
        if (isPO && _txtAdd1.text.length == 0 && (!([[self.LADetails objectForKey:@"LAOtherIDType"] isEqualToString:@"COMPANY REGISTRATION NUMBER"]) && !([[self.LADetails objectForKey:@"LAOtherIDType"] isEqualToString:@"CR"]))) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Residential Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = Nil;
            return FALSE;
        }
        else if (isPO && _txtAdd1.text.length == 0 && isResidenceForiegnAddChecked) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Residential Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = Nil;
            return FALSE;
        }
        else if (isPO && _txtAdd1.text.length == 0 && iscorrespondenceResidenceChecked)
        {
            
            NSLog(@"checkingCor1");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Residential Address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = Nil;
            return FALSE;
        }
        else if (isPO && _txtPostcode1.text.length == 0 && !isResidenceForiegnAddChecked && (!([[self.LADetails objectForKey:@"LAOtherIDType"] isEqualToString:@"COMPANY REGISTRATION NUMBER"]) && !([[self.LADetails objectForKey:@"LAOtherIDType"] isEqualToString:@"CR"]))) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Postcode for Residential Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = Nil;
            return FALSE;
        }
        
        
        if (((![[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"CR"]) && (![[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"COMPANY REGISTRATION NUMBER"])) || iscorrespondenceResidenceChecked) {
            if ([textFields trimWhiteSpaces:_txtAdd1.text].length == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Residential Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 1004;
                [alert show];
                alert = Nil;
                return FALSE;
            }
            
            if ([textFields trimWhiteSpaces:_txtPostcode1.text].length == 0 && !isResidenceForiegnAddChecked) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Residential Postcode is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 1005;
                [alert show];
                alert = Nil;
                return FALSE;
            }
            
            if ([textFields trimWhiteSpaces:_txtState1.text].length == 0 && !isResidenceForiegnAddChecked) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Postcode for Residential Address is invalid." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 1005;
                [alert show];
                alert = Nil;
                return FALSE;
            }
            
            if (_txtCountry1.text.length == 0 || [_txtCountry1.text isEqualToString:@"- SELECT -"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Country for Residential Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return FALSE;
            }
        }
        
		if (_SegResidencePOB.selectedSegmentIndex == -1 && isPO && _txtAdd1.text.length != 0) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Is this a P.O Box address for Residential Adress is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			alert = Nil;
			return FALSE;
		}
		
        if (([textFields trimWhiteSpaces:_txtAdd2.text].length == 0) && employerMandatory) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Office Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 1006;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        else if (isPO && ([textFields trimWhiteSpaces:_txtAdd2.text].length == 0) && isOfficeForiegnAddChecked)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Office Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 1006;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        
        if ([textFields trimWhiteSpaces:_txtPostcode2.text].length == 0  && !isOfficeForiegnAddChecked && employerMandatory ) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Postcode for Office Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 1007;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        
        if ([textFields trimWhiteSpaces:_txtState2.text].length == 0 && employerMandatory && !isOfficeForiegnAddChecked) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Postcode for Office Address is invalid." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 1007;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        
        if ((_txtCountry2.text.length == 0 || [_txtCountry2.text isEqualToString:@"- SELECT -"]) && employerMandatory) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Country for Office Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = Nil;
            return FALSE;
        }
        
        if (isOfficeForiegnAddChecked || _txtAdd2.text.length > 0 || _txtPostcode2.text.length > 0 || iscorrespondenceOfficeChecked) {
            if ([textFields trimWhiteSpaces:_txtAdd2.text].length == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Office Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 1006;
                [alert show];
                alert = Nil;
                return FALSE;
            }
            if ([textFields trimWhiteSpaces:_txtPostcode2.text].length == 0  && !isOfficeForiegnAddChecked) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Postcode for Office Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 1007;
                [alert show];
                alert = Nil;
                return FALSE;
            }
            if ([textFields trimWhiteSpaces:_txtState2.text].length == 0 && !isOfficeForiegnAddChecked) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Postcode for Office Address is invalid." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 1007;
                [alert show];
                alert = Nil;
                return FALSE;
            }
            if (_txtCountry2.text.length == 0 || [_txtCountry2.text isEqualToString:@"- SELECT -"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Country for Office Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return FALSE;
            }
        }
        
        if ((([[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"CR"]) || ([[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"COMPANY REGISTRATION NUMBER"]))) {
            
            if (([textFields trimWhiteSpaces:_txtAdd2.text].length == 0)) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Office Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 1006;
                [alert show];
                alert = Nil;
                return FALSE;
            }
            
            if ([textFields trimWhiteSpaces:_txtPostcode2.text].length == 0  && !isOfficeForiegnAddChecked) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Postcode for Office Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 1007;
                [alert show];
                alert = Nil;
                return FALSE;
            }
            
            if ([textFields trimWhiteSpaces:_txtState2.text].length == 0 && !isOfficeForiegnAddChecked) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Postcode for Office Address is invalid." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 1007;
                [alert show];
                alert = Nil;
                return FALSE;
            }
            
            if ((_txtCountry2.text.length == 0 || [_txtCountry2.text isEqualToString:@"- SELECT -"])) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Country for Office Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                alert = Nil;
                return FALSE;
            }
            
            if (isOfficeForiegnAddChecked || _txtAdd2.text.length > 0 || _txtPostcode2.text.length > 0) {
                if ([textFields trimWhiteSpaces:_txtAdd2.text].length == 0) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Office Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    alert.tag = 1006;
                    [alert show];
                    alert = Nil;
                    return FALSE;
                }
                if ([textFields trimWhiteSpaces:_txtPostcode2.text].length == 0  && !isOfficeForiegnAddChecked) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Postcode for Office Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    alert.tag = 1007;
                    [alert show];
                    alert = Nil;
                    return FALSE;
                }
                if ([textFields trimWhiteSpaces:_txtState2.text].length == 0 && !isOfficeForiegnAddChecked) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Postcode for Office Address is invalid." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    alert.tag = 1007;
                    [alert show];
                    alert = Nil;
                    return FALSE;
                }
                if (_txtCountry2.text.length == 0 || [_txtCountry2.text isEqualToString:@"- SELECT -"]) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Country for Office Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    alert = Nil;
                    return FALSE;
                }
            }
        }
		
		if (_SegOfficePOB.selectedSegmentIndex == -1 && isPO && _txtAdd2.text.length != 0) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Is this a P.O Box address for Office Adress is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			alert = Nil;
			return FALSE;
		}
        
        
        if (([textFields trimWhiteSpaces:_txtResidence1.text].length != 0 && ([textFields trimWhiteSpaces:_txtResidence2.text].length == 0 || [textFields trimWhiteSpaces:_txtResidence2.text].length < 6))) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Residential number’s length must be at least 6 digits or more." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 1019;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        
        if (([textFields trimWhiteSpaces:_txtResidence1.text].length == 0 && [textFields trimWhiteSpaces:_txtResidence2.text].length != 0)) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Prefix for residential number is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 1018;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        
        
        if (([textFields trimWhiteSpaces:_txtOffice1.text].length == 0 && [textFields trimWhiteSpaces:_txtOffice2.text].length != 0)) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Prefix for office number is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 1011;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        
        if (([textFields trimWhiteSpaces:_txtOffice1.text].length != 0 && ([textFields trimWhiteSpaces:_txtOffice2.text].length == 0 || [textFields trimWhiteSpaces:_txtOffice2.text].length < 6))) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Office number’s length must be at least 6 digits or more." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 1012;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        
        
        if (([textFields trimWhiteSpaces:_txtMobile1.text].length != 0 && ([textFields trimWhiteSpaces:_txtMobile2.text].length == 0 || [textFields trimWhiteSpaces:_txtMobile2.text].length < 6))) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Mobile number’s length must be at least 6 digits or more." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 1014;
            [alert show];
            alert = Nil;
            return FALSE;
            
        }
        
        if (([textFields trimWhiteSpaces:_txtMobile1.text].length == 0 && [textFields trimWhiteSpaces:_txtMobile2.text].length != 0)) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Prefix for mobile number is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 1013;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        
        if (([textFields trimWhiteSpaces:_txtFax1.text].length != 0 && ([textFields trimWhiteSpaces:_txtFax2.text].length == 0 || [textFields trimWhiteSpaces:_txtFax2.text].length < 6))) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Fax number’s length must be at least 6 digits or more." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 1017;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        
		
        if ([textFields trimWhiteSpaces:_txtFax1.text].length == 0 && [textFields trimWhiteSpaces:_txtFax2.text].length != 0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Prefix for fax number is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 1015;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        
        if (_txtEmail.text.length != 0 && ![textFields validateEmail:[textFields trimWhiteSpaces:_txtEmail.text]]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"You have entered an invalid email. Please key in the correct email." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 1010;
            [alert show];
            alert = Nil;
            return FALSE;
        }
        
        if (isPO && [textFields trimWhiteSpaces:_txtFax1.text].length == 0 && [textFields trimWhiteSpaces:_txtResidence1.text].length == 0 && [textFields trimWhiteSpaces:_txtOffice1.text].length == 0 && [textFields trimWhiteSpaces:_txtMobile1.text].length == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please complete at least one contact details." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = Nil;
            return FALSE;
        }
        
        
        //    if (iscorrespondenceResidenceChecked &&)
        //    {
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please complete at least one contact details." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        //        [alert show];
        //        alert = Nil;
        //        return FALSE;
        //    }
        //
        //    BOOL iscorrespondenceResidenceChecked;
        //    BOOL iscorrespondenceOfficeChecked;
        
        else if (isPO &&!iscorrespondenceResidenceChecked && !iscorrespondenceOfficeChecked )
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Correspondence Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = Nil;
            return FALSE;
            
        }
        
        else if ((!isResidenceForiegnAddChecked && !iscorrespondenceOfficeChecked) || (!isResidenceForiegnAddChecked && !iscorrespondenceOfficeChecked ))
        {
            
        }
        
        if ([textFields trimWhiteSpaces:_txtFax1.text].length == 0 && [textFields trimWhiteSpaces:_txtResidence1.text].length == 0 && [textFields trimWhiteSpaces:_txtOffice1.text].length == 0 && [textFields trimWhiteSpaces:_txtMobile1.text].length == 0 && [textFields trimWhiteSpaces:_txtEmail.text].length == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please complete at least one contact details." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = Nil;
            return FALSE;
        }
        
    }
    
	
	
	
	
	
	
	
	NSLog(@"PTYPECODE: %@", [self.LADetails objectForKey:@"PTypeCode"]);
    if ((![[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"CR"]) && (![[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"COMPANY REGISTRATION NUMBER"])){
        if (age < 16 && isPart2Checked && [[self.LADetails objectForKey:@"PTypeCode"] isEqualToString:@"LA1"]) {
            if ([textFields trimWhiteSpaces:_txtName.text].length == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Parent/Guardian's name is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 1001;
                [alert show];
                alert = Nil;
                return FALSE;
            }
            else if ([textFields validateString:_txtName.text]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid name format. Same alphabet cannot be repeated for more than three times." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 1001;
                [alert show];
                alert = Nil;
                return FALSE;
            }
            else if ([textFields validateString3:_txtName.text]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 1001;
                [alert show];
                alert = Nil;
                return FALSE;
            }
            else if ([textFields trimWhiteSpaces:_txtIC.text].length == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Parent/Guardian's New IC No. is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 1002;
                [alert show];
                alert = Nil;
                return FALSE;
            }
            else if ([textFields trimWhiteSpaces:_txtIC.text].length != 12) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC must be 12 digits characters." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alert.tag = 1002;
                [alert show];
                alert = Nil;
                return FALSE;
            }
            else if ([textFields trimWhiteSpaces:_txtIC.text].length != 0 && [textFields trimWhiteSpaces:_txtIC.text].length == 12) {
                //CHECK DAY / MONTH / YEAR START
                //get the DOB value from ic entered
                NSString *strDate = [_txtIC.text substringWithRange:NSMakeRange(4, 2)];
                NSString *strMonth = [_txtIC.text substringWithRange:NSMakeRange(2, 2)];
                NSString *strYear = [_txtIC.text substringWithRange:NSMakeRange(0, 2)];
                
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
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                    alert.tag = 1002;
                    [alert show];
                    
                    return false;
                }
                else if ([strMonth intValue] > 12 || [strMonth intValue] < 1) {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC month must be between 1 and 12." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                    alert.tag = 1002;
                    [alert show];
                    
                    return false;
                }
                else if([strDate intValue] < 1 || [strDate intValue] > 31)
                {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC day must be between 1 and 31." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                    alert.tag = 1002;
                    [alert show];
                    
                    return false;
                    
                }
                else if (([strMonth isEqualToString:@"01"] || [strMonth isEqualToString:@"03"] || [strMonth isEqualToString:@"05"] || [strMonth isEqualToString:@"07"] || [strMonth isEqualToString:@"08"] || [strMonth isEqualToString:@"10"] || [strMonth isEqualToString:@"12"]) && [strDate intValue] > 31) {
                    
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                    alert.tag = 1002;
                    [alert show];
                    
                    return false;
                }
                
                else if (([strMonth isEqualToString:@"04"] || [strMonth isEqualToString:@"06"] || [strMonth isEqualToString:@"09"] || [strMonth isEqualToString:@"11"]) && [strDate intValue] > 30) {
                    
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                    alert.tag = 1002;
                    [alert show];
                    
                    return false;
                }
                else if (([febStatus isEqualToString:@"Normal"] && [strDate intValue] > 28 && [strMonth isEqualToString:@"02"]) || ([febStatus isEqualToString:@"Jump"] && [strDate intValue] > 29 && [strMonth isEqualToString:@"02"])) {
                    
                    
                    NSString *msg = [NSString stringWithFormat:@"February of %@ doesn’t have 29 days",strYear] ;
                    
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                    alert.tag = 1002;
                    [alert show];
                    
                    return false;
                }
            }
        }
    }
    
    
    return TRUE;
}


//-(BOOL)validation {
//    [self hideKeyboard];
//
//
//
//    if (isPO && ([_martialStatusLbl.text isEqualToString:@"DIVORCED"] || [_martialStatusLbl.text isEqualToString:@"WIDOW"] || [_martialStatusLbl.text isEqualToString:@"WIDOWER"]) && _segHaveChildren.selectedSegmentIndex == UISegmentedControlNoSegment) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Have Children question need to be answered" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//
//    if (_relationshipLbl.text.length == 0) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Relationship is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//    else if (isPO && ![_relationshipLbl.text isEqualToString:@"SELF"] && [[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LADetails"] count] == 1) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Relationship must be SELF." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//   // if ([POFLAG isEqualToString:@"Y"])
//    else if (isPO && [_relationshipLbl.text isEqualToString:@"SELF"] && [[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LADetails"] count] != 1) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Relationship cannot be SELF." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//    else if (isPO && _txtCountry1.text.length == 0 && isResidenceForiegnAddChecked) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Country is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//
//    else if (isPO && _txtAdd1.text.length == 0 && iscorrespondenceResidenceChecked)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Correspondence Address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//
//
//    else if (isPO && [textFields trimWhiteSpaces:_txtFax1.text].length == 0 && [textFields trimWhiteSpaces:_txtResidence1.text].length == 0 && [textFields trimWhiteSpaces:_txtOffice1.text].length == 0 && [textFields trimWhiteSpaces:_txtMobile1.text].length == 0)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please complete at least one contact details." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//    else if (!isPO && [_relationshipLbl.text isEqualToString:@"SELF"] ) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Relationship cannot be SELF." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//
//    if (!isPO && [[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"PORelationship"] isEqualToString:_relationshipLbl.text]) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Relationship for both Policy Owner and 1st Life Assured cannot be the same." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//	NSLog(@"EEEEEELA: LA1 %@, LA2 %@, PY1 %@, Current: %@",[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LA1Relationship"], [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LA2Relationship"], [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"PYRelationship"], _relationshipLbl.text);
//	if (isPO && [[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LA1Relationship"] isEqualToString:_relationshipLbl.text] && (![[self.LADetails objectForKey:@"PTypeCode"] isEqualToString:@"LA1"])) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Relationship for both Policy Owner and 1st Life Assured cannot be the same." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//	if (isPO && [[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LA2Relationship"] isEqualToString:_relationshipLbl.text] && (![[self.LADetails objectForKey:@"PTypeCode"] isEqualToString:@"LA2"])) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Relationship for both Policy Owner and 2nd Life Assured cannot be the same." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//    NSLog(@"a: %@, b %@, c %@", [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"gotCompany"], [textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]], _relationshipLbl.text);
//    if ([[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"gotCompany"] isEqualToString:@"Y"]) {
//		if (([[self.LADetails objectForKey:@"LAOtherIDType"] isEqualToString:@"COMPANY REGISTRATION NUMBER"]) || ([[self.LADetails objectForKey:@"LAOtherIDType"] isEqualToString:@"CR"])){
//			if (![_relationshipLbl.text isEqualToString:@"EMPLOYER"]) {
//				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Relationship for Company case must be EMPLOYEE vs EMPLOYER." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//				[alert show];
//				alert = Nil;
//				return FALSE;
//			}
//		}
//	}
//
//	if (!isPO && [[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"gotCompany"] isEqualToString:@"Y"] && [[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"PORelationship"] isEqualToString:@"EMPLOYER"]) {
//		if (![_relationshipLbl.text isEqualToString:@"EMPLOYEE"]) {
//			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Relationship for Company case must be employee vs employer" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//			[alert show];
//			alert = Nil;
//            return FALSE;
//		}
//    }
//
//
//
//
//
////	if ([[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"gotCompany"] isEqualToString:@"Y"] && (![[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] caseInsensitiveCompare:@"Company Registration Number"] == NSOrderedSame || ![[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] caseInsensitiveCompare:@"CR"] == NSOrderedSame) && ![_relationshipLbl.text isEqualToString:@"EMPLOYEE"]) {
////        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Relationship for Company case must be EMPLOYEE vs EMPLOYER." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
////        [alert show];
////        alert = Nil;
////        return FALSE;
////    }
//    if ((![[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"CR"]) && (![[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"COMPANY REGISTRATION NUMBER"])) {
//
//    if ([textFields trimWhiteSpaces:_employerLbl.text].length == 0 && employerMandatory) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Name of Employer is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        alert.tag = 1003;
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//
//	if ([textFields trimWhiteSpaces:_employerLbl.text].length > 0 && [textFields validateOtherID:_employerLbl.text]) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid name format. Input must be alphabet A to Z, space, apostrophe('), alias(@), slash(/), dash(-), bracket(()) or dot(.)." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        alert.tag = 1003;
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//
//	if ([textFields trimWhiteSpaces:_employerLbl.text].length > 0 && [textFields validateString:_employerLbl.text]) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid name format. Same alphabet cannot be repeated more than three times." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        alert.tag = 1003;
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//    }
//    if ([textFields trimWhiteSpaces:_businessLbl.text].length == 0 && employerMandatory) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Type of Business is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        alert.tag = 1009;
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//
//    if (!iscorrespondenceOfficeChecked && !iscorrespondenceResidenceChecked && isPO) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Correspondence Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//
//    if (((![[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"CR"]) && (![[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"COMPANY REGISTRATION NUMBER"])) || iscorrespondenceResidenceChecked) {
//        if ([textFields trimWhiteSpaces:_txtAdd1.text].length == 0) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Residence Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            alert.tag = 1004;
//            [alert show];
//            alert = Nil;
//            return FALSE;
//        }
//
//        if ([textFields trimWhiteSpaces:_txtPostcode1.text].length == 0 && !isResidenceForiegnAddChecked) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Residence Postcode is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            alert.tag = 1005;
//            [alert show];
//            alert = Nil;
//            return FALSE;
//        }
//
//        if ([textFields trimWhiteSpaces:_txtState1.text].length == 0 && !isResidenceForiegnAddChecked) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid Postcode." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            alert.tag = 1005;
//            [alert show];
//            alert = Nil;
//            return FALSE;
//        }
//
//        if (_txtCountry1.text.length == 0 || [_txtCountry1.text isEqualToString:@"- SELECT -"]) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Residence Country is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//            alert = Nil;
//            return FALSE;
//        }
//    }
//
//    if ([textFields trimWhiteSpaces:_txtAdd2.text].length == 0 && employerMandatory) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Office Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        alert.tag = 1006;
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//
//    if ([textFields trimWhiteSpaces:_txtPostcode2.text].length == 0  && !isOfficeForiegnAddChecked && employerMandatory ) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Office Postcode is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        alert.tag = 1007;
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//
//    if ([textFields trimWhiteSpaces:_txtState2.text].length == 0 && employerMandatory && !isOfficeForiegnAddChecked) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid Postcode." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        alert.tag = 1007;
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//
//    if ((_txtCountry2.text.length == 0 || [_txtCountry2.text isEqualToString:@"- SELECT -"]) && employerMandatory) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Office Country is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//
//	if (isOfficeForiegnAddChecked || _txtAdd2.text.length > 0 || _txtPostcode2.text.length > 0 || iscorrespondenceOfficeChecked) {
//		if ([textFields trimWhiteSpaces:_txtAdd2.text].length == 0) {
//			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Office Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//			alert.tag = 1006;
//			[alert show];
//			alert = Nil;
//			return FALSE;
//		}
//		if ([textFields trimWhiteSpaces:_txtPostcode2.text].length == 0  && !isOfficeForiegnAddChecked) {
//			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Office Postcode is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//			alert.tag = 1007;
//			[alert show];
//			alert = Nil;
//			return FALSE;
//		}
//		if ([textFields trimWhiteSpaces:_txtState2.text].length == 0 && !isOfficeForiegnAddChecked) {
//			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid Postcode." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//			alert.tag = 1007;
//			[alert show];
//			alert = Nil;
//			return FALSE;
//		}
//		if (_txtCountry2.text.length == 0 || [_txtCountry2.text isEqualToString:@"- SELECT -"]) {
//			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Office Country is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//			[alert show];
//			alert = Nil;
//			return FALSE;
//		}
//	}
//
//    if (([textFields trimWhiteSpaces:_txtResidence1.text].length != 0 && ([textFields trimWhiteSpaces:_txtResidence2.text].length == 0 || [textFields trimWhiteSpaces:_txtResidence2.text].length < 6))) {
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Residence Contact Number length must be 6 digits or more." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		alert.tag = 1019;
//        [alert show];
//        alert = Nil;
//        return FALSE;
//	}
//
//	if (([textFields trimWhiteSpaces:_txtResidence1.text].length == 0 && [textFields trimWhiteSpaces:_txtResidence2.text].length != 0)) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Prefix for Residence No. is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		alert.tag = 1018;
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//
//
//    if (([textFields trimWhiteSpaces:_txtOffice1.text].length == 0 && [textFields trimWhiteSpaces:_txtOffice2.text].length != 0)) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Prefix for Office Contact No. is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		alert.tag = 1011;
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//
//	if (([textFields trimWhiteSpaces:_txtOffice1.text].length != 0 && ([textFields trimWhiteSpaces:_txtOffice2.text].length == 0 || [textFields trimWhiteSpaces:_txtOffice2.text].length < 6))) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Office Contact Number length must be 6 digits or more." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		alert.tag = 1012;
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//
//
//    if (([textFields trimWhiteSpaces:_txtMobile1.text].length != 0 && ([textFields trimWhiteSpaces:_txtMobile2.text].length == 0 || [textFields trimWhiteSpaces:_txtMobile2.text].length < 6))) {
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Mobile Contact Number length must be 6 digits or more." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		alert.tag = 1014;
//        [alert show];
//        alert = Nil;
//        return FALSE;
//
//	}
//
//	if (([textFields trimWhiteSpaces:_txtMobile1.text].length == 0 && [textFields trimWhiteSpaces:_txtMobile2.text].length != 0)) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Prefix for Mobile No. is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		alert.tag = 1013;
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//
//    if (([textFields trimWhiteSpaces:_txtFax1.text].length != 0 && ([textFields trimWhiteSpaces:_txtFax2.text].length == 0 || [textFields trimWhiteSpaces:_txtFax2.text].length < 6))) {
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Fax Contact Number length must be 6 digits or more." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		alert.tag = 1017;
//        [alert show];
//        alert = Nil;
//        return FALSE;
//	}
//
//
//	if ([textFields trimWhiteSpaces:_txtFax1.text].length == 0 && [textFields trimWhiteSpaces:_txtFax2.text].length != 0){
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Prefix for Fax No. is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		alert.tag = 1015;
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//
//    if ([textFields trimWhiteSpaces:_txtEmail.text].length != 0 && ![textFields validateEmail:[textFields trimWhiteSpaces:_txtEmail.text]]) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"You have entered an invalid email." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        alert.tag = 1010;
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//
//    if ([textFields trimWhiteSpaces:_txtFax1.text].length == 0 && [textFields trimWhiteSpaces:_txtResidence1.text].length == 0 && [textFields trimWhiteSpaces:_txtOffice1.text].length == 0 && [textFields trimWhiteSpaces:_txtMobile1.text].length == 0 && [textFields trimWhiteSpaces:_txtEmail.text].length == 0) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please complete at least one contact details." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        alert = Nil;
//        return FALSE;
//    }
//
//	NSLog(@"PTYPECODE: %@", [self.LADetails objectForKey:@"PTypeCode"]);
//    if ((![[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"CR"]) && (![[textFields trimWhiteSpaces:[self.LADetails objectForKey:@"LAOtherIDType"]] isEqualToString:@"COMPANY REGISTRATION NUMBER"])){
//        if (age < 16 && isPart2Checked && [[self.LADetails objectForKey:@"PTypeCode"] isEqualToString:@"LA1"]) {
//            if ([textFields trimWhiteSpaces:_txtName.text].length == 0) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Parent/Guardian Name is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                alert.tag = 1001;
//                [alert show];
//                alert = Nil;
//                return FALSE;
//            }
//            else if ([textFields validateString:_txtName.text]) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid name format. Same alphabet cannot be repeated for more than three times." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                alert.tag = 1001;
//                [alert show];
//                alert = Nil;
//                return FALSE;
//            }
//            else if ([textFields validateString3:_txtName.text]) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                alert.tag = 1001;
//                [alert show];
//                alert = Nil;
//                return FALSE;
//            }
//            else if ([textFields trimWhiteSpaces:_txtIC.text].length == 0) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Parent/Guardian's New IC No. is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                alert.tag = 1002;
//                [alert show];
//                alert = Nil;
//                return FALSE;
//            }
//            else if ([textFields trimWhiteSpaces:_txtIC.text].length != 12) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC must be 12 digits characters." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                alert.tag = 1002;
//                [alert show];
//                alert = Nil;
//                return FALSE;
//            }
//            else if ([textFields trimWhiteSpaces:_txtIC.text].length != 0 && [textFields trimWhiteSpaces:_txtIC.text].length == 12) {
//                //CHECK DAY / MONTH / YEAR START
//                //get the DOB value from ic entered
//                NSString *strDate = [_txtIC.text substringWithRange:NSMakeRange(4, 2)];
//                NSString *strMonth = [_txtIC.text substringWithRange:NSMakeRange(2, 2)];
//                NSString *strYear = [_txtIC.text substringWithRange:NSMakeRange(0, 2)];
//
//                //get value for year whether 20XX or 19XX
//                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                [dateFormatter setDateFormat:@"yyyy"];
//
//                NSString *currentYear = [dateFormatter stringFromDate:[NSDate date]];
//                NSString *strCurrentYear = [currentYear substringWithRange:NSMakeRange(2, 2)];
//                if ([strYear intValue] > [strCurrentYear intValue] && !([strYear intValue] < 30)) {
//                    strYear = [NSString stringWithFormat:@"19%@",strYear];
//                }
//                else {
//                    strYear = [NSString stringWithFormat:@"20%@",strYear];
//                }
//
//                NSString *strDOB2 = [NSString stringWithFormat:@"%@-%@-%@",strYear,strMonth,strDate];
//
//                //determine day of february
//                NSString *febStatus = nil;
//                float devideYear = [strYear floatValue]/4;
//                int devideYear2 = devideYear;
//                float minus = devideYear - devideYear2;
//                if (minus > 0) {
//                    febStatus = @"Normal";
//                }
//                else {
//                    febStatus = @"Jump";
//                }
//
//                //compare year is valid or not
//                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//                NSDate *d = [NSDate date];
//                NSDate *d2 = [dateFormatter dateFromString:strDOB2];
//
//                if ([d compare:d2] == NSOrderedAscending) {
//
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
//                    alert.tag = 1002;
//                    [alert show];
//
//                    return false;
//                }
//                else if ([strMonth intValue] > 12 || [strMonth intValue] < 1) {
//
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC month must be between 1 and 12." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
//                    alert.tag = 1002;
//                    [alert show];
//
//                    return false;
//                }
//                else if([strDate intValue] < 1 || [strDate intValue] > 31)
//                {
//
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC day must be between 1 and 31." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
//                    alert.tag = 1002;
//                    [alert show];
//
//                    return false;
//
//                }
//                else if (([strMonth isEqualToString:@"01"] || [strMonth isEqualToString:@"03"] || [strMonth isEqualToString:@"05"] || [strMonth isEqualToString:@"07"] || [strMonth isEqualToString:@"08"] || [strMonth isEqualToString:@"10"] || [strMonth isEqualToString:@"12"]) && [strDate intValue] > 31) {
//
//
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
//                    alert.tag = 1002;
//                    [alert show];
//
//                    return false;
//                }
//
//                else if (([strMonth isEqualToString:@"04"] || [strMonth isEqualToString:@"06"] || [strMonth isEqualToString:@"09"] || [strMonth isEqualToString:@"11"]) && [strDate intValue] > 30) {
//
//
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
//                    alert.tag = 1002;
//                    [alert show];
//
//                    return false;
//                }
//                else if (([febStatus isEqualToString:@"Normal"] && [strDate intValue] > 28 && [strMonth isEqualToString:@"02"]) || ([febStatus isEqualToString:@"Jump"] && [strDate intValue] > 29 && [strMonth isEqualToString:@"02"])) {
//
//
//                    NSString *msg = [NSString stringWithFormat:@"February of %@ doesn’t have 29 days",strYear] ;
//
//
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
//                    alert.tag = 1002;
//                    [alert show];
//
//                    return false;
//                }
//            }
//        }
//    }
//
//    return TRUE;
//}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag==1234) {
        if (buttonIndex==0)
        {
            [self btnDone:nil];
            NSLog(@"testingME");
        }
        else if (buttonIndex!=0)
        {
            //             NSLog(@"testingU");
			//EMI: remove newPO if user click cancel, and not save
			if ([[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"RemovePOFLAG"] isEqualToString:@"Y"])
            {
				[self.delegate doneDelete];
			}
            [self dismissViewControllerAnimated:YES completion:Nil];
            
        }
    }
    if (alertView.tag == 1001) {
        [_txtName becomeFirstResponder];
    }
    else if (alertView.tag == 1002) {
        [_txtIC becomeFirstResponder];
    }
    else if (alertView.tag == 1003) {
        [_employerLbl becomeFirstResponder];
    }
    else if (alertView.tag == 1004) {
        [_txtAdd1 becomeFirstResponder];
    }
    else if (alertView.tag == 1005) {
        [_txtPostcode1 becomeFirstResponder];
    }
    else if (alertView.tag == 1006) {
        [_txtAdd2 becomeFirstResponder];
    }
    else if (alertView.tag == 1007) {
        [_txtPostcode2 becomeFirstResponder];
    }
    else if (alertView.tag == 1008) {
        // click yes
        if (buttonIndex == 0) {
            [checkPolicyOwner setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            
            [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"TickPart2"];
            
            _LblCorrespondenceAdd.enabled = TRUE;
            _LblResidence.enabled = TRUE;
            _LblOffice.enabled = TRUE;
            _BtnResidence.enabled = TRUE;
            _BtnOffice.enabled = TRUE;
            
            _segOwnership.enabled =TRUE;
            _LblResidenceAdd.enabled = TRUE;
            _LblForeignAdd.enabled = TRUE;
            _LblOwnership.enabled = TRUE;
            _LblAddress1.enabled = TRUE;
            _LblPostcode1.enabled = TRUE;
            _LblTown1.enabled = TRUE;
            _LblState1.enabled = true;
            _LblCountry1.enabled = true;
            
            _txtPostcode1.enabled = TRUE;
            //   _txtState1.enabled = TRUE;
            //_txtCountry1.enabled = TRUE;
            _txtTown1.enabled = TRUE;
            
            _txtAdd1.enabled = TRUE;
            _txtAdd12.enabled = TRUE;
            _txtAdd13.enabled = TRUE;
            
            _BtnResidenceForeignAdd.enabled =TRUE;
            
            _LblOfficeAdd2.enabled = TRUE;
            _LblForeignAdd2.enabled = TRUE;
            _LblAddress2.enabled = TRUE;
            _LblPostcode2.enabled =TRUE;
            _LblState2.enabled = FALSE;
            _LblTown2.enabled = TRUE;
            //_LblCountry2.enabled = TRUE;
            
            _txtPostcode2.enabled = TRUE;
            //  _txtState2.enabled = TRUE;
            _txtCountry2.enabled = FALSE;
            _txtTown2.enabled = TRUE;
            
            _txtAdd2.enabled = TRUE;
            _txtAdd22.enabled = TRUE;
            _txtAdd23.enabled = TRUE;
            
            _BtnOfficeForeignAdd.enabled = TRUE;
            
            _LblContactTitle3.enabled = TRUE;
            _LblResidence3.enabled = TRUE;
            _LblOffice3.enabled = TRUE;
            
            _LblEmail3.enabled = TRUE;
            _LblMobile3.enabled = TRUE;
            _LblFax3.enabled = TRUE;
            
            _txtResidence1.enabled = TRUE;
            _txtResidence2.enabled = TRUE;
            
            _txtOffice1.enabled = TRUE;
            _txtOffice2.enabled = TRUE;
            _txtEmail.enabled = TRUE;
            _txtMobile1.enabled = TRUE;
            _txtMobile2.enabled = TRUE;
            _txtFax1.enabled = TRUE;
            _txtFax2.enabled = TRUE;
            //            _txtName.enabled = TRUE;
            //            _txtIC.enabled = TRUE;
            
			NSLog(@"ENS GUARDIAN 1, cancel");
			
            //            if (age > 9 && age < 16) {
            //                _txtName.enabled = TRUE;
            //                _txtIC.enabled = TRUE;
            //                _policyLifecycleLabel.textColor =[UIColor blackColor];
            //                _Me.textColor =[UIColor blackColor];
            //                _asTheParent.textColor =[UIColor blackColor];
            //                _NRIC.textColor =[UIColor blackColor];
            //            }
            //
            //            if (age < 10 && age >=16){
            //                _txtName.enabled = FALSE;
            //                _txtIC.enabled = FALSE;
            //				_txtName.text = @"";
            //                _txtIC.text = @"";
            //                _policyLifecycleLabel.textColor =[UIColor grayColor];
            //                _Me.textColor =[UIColor grayColor];
            //                _asTheParent.textColor =[UIColor grayColor];
            //                _NRIC.textColor =[UIColor grayColor];
            //            }
            
            
            
            isPO = TRUE;
        }
        // click no
		
        else if (buttonIndex == 1) {
            // do nothing
        }
    }
    else if (alertView.tag == 1009) {
        [_businessLbl becomeFirstResponder];
    }
    else if (alertView.tag == 1010) {
        [_txtEmail becomeFirstResponder];
    }
	else if (alertView.tag == 1011) {
        [_txtOffice1 becomeFirstResponder];
    }
	else if (alertView.tag == 1012) {
        [_txtOffice2 becomeFirstResponder];
    }
	else if (alertView.tag == 1013) {
        [_txtMobile1 becomeFirstResponder];
    }
	else if (alertView.tag == 1014) {
        [_txtMobile2 becomeFirstResponder];
    }
	else if (alertView.tag == 1015) {
        [_txtFax1 becomeFirstResponder];
    }
	else if (alertView.tag == 1017) {
        [_txtFax2 becomeFirstResponder];
    }
	else if (alertView.tag == 1018) {
        [_txtResidence1 becomeFirstResponder];
    }
	else if (alertView.tag == 1019) {
        [_txtResidence2 becomeFirstResponder];
    }
	
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _txtIC) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 12));
    }
    else if (textField == _txtPostcode1) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if (!isResidenceForiegnAddChecked) {
            return (([string isEqualToString:filtered])&&(newLength <= 5));
        }
		else {
            return (newLength <= 12);
        }
    }
    else if (textField == _txtPostcode2) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if (!isOfficeForiegnAddChecked) {
            return (([string isEqualToString:filtered])&&(newLength <= 5));
        }
		else {
            return (newLength <= 12);
        }
    }
    else if (textField == _businessLbl) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 60;
    }
    
    else if (textField == _employerLbl) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 60;
    }
	
    //    if (textView == _exaxtDutiesLbl)
    //    {
    //
    //		NSUInteger newLength = [textView.text length] + [text length] - range.length;
    //
    //		return ((newLength <= 40));
    //	}
    //    return TRUE;
    
    
    
	NSUInteger newLength = [textField.text length] + [string length] - range.length;
	if (textField == _txtAdd1 || textField == _txtAdd12 || textField == _txtAdd13 ) {
		return ((newLength <= CHARACTER_LIMIT_RECIDENCEADDRESS));
	}
	
	if (textField == _txtAdd2 || textField == _txtAdd22 || textField == _txtAdd23 ) {
		return ((newLength <= CHARACTER_LIMIT_OFFICEADDRESS));
	}
    
    if (textField == _txtTown1||textField ==_txtTown2)
    {
        return ((newLength <= CHARACTER_LIMIT_TOWN));
    }
	
	if (textField == _txtEmail) {
		return ((newLength <= CHARACTER_LIMIT_EMAIL));
	}
	
	if (textField == _txtMobile1) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 4));
    }
	
	if (textField == _txtMobile2) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 10));
    }
	
	if (textField == _txtOffice1) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 4));
    }
	
	if (textField == _txtOffice2) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 10));
    }
	
	if (textField == _txtFax1) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 4));
    }
	
	if (textField == _txtFax2) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 10));
    }
    if (textField == _txtResidence1) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 4));
    }
	
	if (textField == _txtResidence2) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 10));
    }
	
	if (textField == _txtName) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:CHAR_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 50));
        
    }
    if (textField == _txtTown2) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 40;
    }
    //    if (textField == _txtTown1) {
    //        NSUInteger newLength = [textField.text length] + [string length] - range.length;
    //        return newLength <= 40;
    //    }
    if (textField == _txtTown1) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:CHAR_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= 40));
        
    }
    return TRUE;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == _exaxtDutiesLbl)
    {
        
		NSUInteger newLength = [textView.text length] + [text length] - range.length;
        
		return ((newLength <= 40));
	}
    return TRUE;
}


-(void)detectChanges:(id) sender
{
    isMoifiedData = YES;
}

- (IBAction)ActionOwnership:(id)sender {
    isMoifiedData = YES;
}
- (IBAction)ActionHaveChildren:(id)sender
{
    isMoifiedData = YES;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (IBAction)postChanged:(id)sender {
    UITextField *textField = (UITextField*)sender;
    UITextField *Town;
    UITextField *mailingAddressState;
    UITextField *mailingAddressCountry;
    if (textField == _txtPostcode1) {
        if (isResidenceForiegnAddChecked) {
            return;
        }
        else if (textField.text.length < 5) {
			_txtTown1.text = @"";
			_txtState1.text = @"";
            return;
        }
        Town = _txtTown1;
        
        mailingAddressState = _txtState1;
        mailingAddressCountry = _txtCountry1;
    }
    else if (textField == _txtPostcode2) {
		
        
        if (isOfficeForiegnAddChecked) {
            return;
        }
        else if (textField.text.length < 5) {
			_txtTown2.text = @"";
			_txtState2.text = @"";
            return;
        }
        Town = _txtTown2;
        mailingAddressState = _txtState2;
        mailingAddressCountry = _txtCountry2;
		
		_txtTown2.enabled = FALSE;
		_txtTown2.textColor = [UIColor grayColor];
		_txtCountry2.textColor = [UIColor grayColor];
    }
	
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT Town, Statedesc, b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = ?", textField.text];
    Town.text = @"";
    mailingAddressState.text = @"";
    while ([result next]) {
        Town.text = [result objectForColumnName:@"Town"];
        mailingAddressState.text = [result objectForColumnName:@"Statedesc"];
		mailingAddressCountry.text = @"MALAYSIA";
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressForeign"] isEqualToString:@"0"]) {
            mailingAddressCountry.text = @"MALAYSIA";
        }
    }
    [db close];
	
}

-(NSString*) getIDTypeDesc : (NSString*)IDtype
{
    NSString *desc;
	IDtype = [IDtype stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	NSLog(@"idtype: %@ desc: %@", IDtype, desc);
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
	
	if ([desc isEqualToString:@"(null)"])
		desc = @"";
	
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

-(NSString*) getTitleCode2 : (NSString*)Title
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
	
	return code;
	
}

-(BOOL) CheckPOExist {
	
	FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *results;
	
	NSString *selectQuery = [NSString stringWithFormat:@"Select * from eProposal_LA_Details where eProposalNo = '%@' and PTypeCode = 'PO'", [self.LADetails objectForKey:@"eProposalNo"]];
	[db open];
	results = [db executeQuery:selectQuery];
	int count = 0;
	while ([results next]) {
		count = count + 1;
	}
	
	if (count == 0)
		return FALSE;
	else
		return TRUE;
	
	//	[db close];
}



-(IBAction)CleatAllinDutied:(id)sender
{
    
    NSLog(@"everytime");
    _exaxtDutiesLbl.text=nil;
    
}



@end//prem//
