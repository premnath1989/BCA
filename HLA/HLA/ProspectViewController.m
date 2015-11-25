//
//  ProspectViewController.m
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 9/30/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//
//  KUAN - 18 OCTOBER 2013 - Deployment Version - 1.4.0.11


#import "ProspectViewController.h"
#import "ProspectListing.h"
#import <QuartzCore/QuartzCore.h>
#import "ColorHexCode.h"
#import "IDTypeViewController.h"
#import "TitleViewController.h"
#import "DBController.h"
#import "DataTable.h"
#import "FMDatabase.h"
#import "textFields.h"

#define NUMBERS_ONLY @"0123456789"
#define NUMBERS_MONEY @"0123456789."
#define CHARACTER_LIMIT_PC_F 16
#define CHARACTER_LIMIT_FULLNAME 70
#define CHARACTER_LIMIT_OtherID 30
#define CHARACTER_LIMIT_Bussiness 60
#define CHARACTER_LIMIT_ExactDuties 40
#define CHARACTER_LIMIT_Address 30
#define CHARACTER_LIMIT_POSTCODE 5
#define CHARACTER_LIMIT_FOREIGN_POSTCODE 12
#define CHARACTER_LIMIT_ANNUALINCOME 20
#define CHARACTER_LIMIT_GSTREGNO 15




@interface ProspectViewController ()
{
    BOOL name_morethan3times;
    BOOL DATE_OK;
    BOOL Update_record;
    BOOL IC_Hold_Alert;
    
    BOOL OTHERID_Hold_Alert;
    BOOL isDOBDate;
	BOOL isGSTDate;

    NSString *annualIncome_original;
    
    NSString *temp_pre1;
    NSString *temp_pre2;
    NSString *temp_pre3;
    NSString *temp_pre4;
    
    NSString *temp_cont1;
    NSString *temp_cont2;
    NSString *temp_cont3;
    NSString *temp_cont4;
    
    NSString *getSameRecord_Indexno;
	
	int clickDone;		//if user click done, = 1
    
}

@end

@implementation ProspectViewController
@synthesize prospectprofile;
@synthesize txtPrefix1;
@synthesize txtPrefix2;
@synthesize txtPrefix3;
@synthesize txtPrefix4;
@synthesize lblOfficeAddr;
@synthesize lblPostCode;
@synthesize txtRemark;
@synthesize txtEmail;
@synthesize txtContact1;
@synthesize txtContact2;
@synthesize txtContact3;
@synthesize txtContact4;
@synthesize outletDOB;
@synthesize txtHomeAddr1;
@synthesize txtHomeAddr2;
@synthesize txtHomeAddr3;
@synthesize txtHomePostCode;
@synthesize txtHomeTown;
@synthesize txtHomeState;
@synthesize txtHomeCountry;
@synthesize txtOfficeAddr1;
@synthesize txtOfficeAddr2;
@synthesize txtOfficeAddr3;
@synthesize txtOfficePostcode;
@synthesize txtOfficeTown;
@synthesize txtOfficeState,btnHomeCountry,txtDOB;
@synthesize txtOfficeCountry,btnForeignHome,btnForeignOffice;
@synthesize txtExactDuties,txtBussinessType,txtAnnIncome,txtClass;
@synthesize outletOccup,ClientSmoker,btnOfficeCountry,GSTRigperson,GSTRigExempted,outletRigDate;
@synthesize myScrollView,outletGroup,OtherIDType,txtIDType,txtOtherIDType;
@synthesize txtFullName, ContactTypeTracker,segSmoker,outletTitle,outletNationality,outletRace,outletMaritalStatus,outletReligion,segRigPerson,txtRigDate,txtRigNO,segRigExempted,btnregDare;
@synthesize segGender, ContactType, DOB, gender, SelectedStateCode, SelectedOfficeStateCode, IDTypeCodeSelected,OccupCodeSelected,pp,OccpCatCode,btnRegistnDate;
@synthesize OccupationList = _OccupationList;
@synthesize OccupationListPopover = _OccupationListPopover;
@synthesize SIDate = _SIDate;
@synthesize SIDatePopover = _SIDatePopover;
@synthesize delegate = _delegate;
@synthesize IDTypePicker = _IDTypePicker;
@synthesize TitlePicker = _TitlePicker;
@synthesize raceListPopover = _raceListPopover;
@synthesize MaritalStatusPopover = _MaritalStatusPopover;
@synthesize TitlePickerPopover = _TitlePickerPopover;
@synthesize ReligionListPopover = _ReligionListPopover;
@synthesize nationalityList = _nationalityList;
@synthesize nationalityPopover = _nationalityPopover;
@synthesize nationalityList2 = _nationalityList2;
@synthesize nationalityPopover2 = _nationalityPopover2;
@synthesize CountryListPopover = _CountryListPopover;
@synthesize Country2ListPopover = _Country2ListPopover;
//@synthesize CountryListPopover_Office = _CountryListPopoverOffice;
@synthesize EditProspect = _EditProspect;
@synthesize TitleCodeSelected;
@synthesize UDGroup, btnAddGroup, btnViewGroup, segIsGrouping;
@synthesize btnCoutryOfBirth;

bool PostcodeContinue = TRUE;
bool HomePostcodeContinue = false;
bool OfficePostcodeContinue = false;
int name_repeat = 0;
bool RegDatehandling;

- (void)viewDidLoad
{
    RegDatehandling =YES;
    
    [super viewDidLoad];
	

	UDGroup = [NSUserDefaults standardUserDefaults];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideHandler:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.txtFullName.autocapitalizationType = UITextAutocapitalizationTypeWords;
    name_morethan3times = FALSE;
    DATE_OK = YES;
    Update_record = NO;
    IC_Hold_Alert = NO;
    OTHERID_Hold_Alert = NO;
	
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    [txtRigNO setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    
    
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    txtRemark.layer.borderWidth = 1.0f;
    txtRemark.layer.borderColor = [[UIColor grayColor] CGColor];
    
    
    
    txtRigDate.userInteractionEnabled=FALSE;
    //easysqlite---------start
    self.db = [DBController sharedDatabaseController:@"hladb.sqlite"];
    NSString *sqlStmt1 = [NSString stringWithFormat:@"SELECT IndexNo, IDtypeNo, otheridtype and otheridtypeno FROM prospect_profile where idtypeno and otheridtype is not null"];
    _tableDB = [_db  ExecuteQuery:sqlStmt1];
    
    
    NSString *sqlStmt2 = [NSString stringWithFormat:@"SELECT OtherIDTypeNo, OtherIDType, IndexNo FROM prospect_profile where OtherIDTypeNo  is not null and  OtherIDTypeNo != ''"];
    _tableCheckSameRecord = [_db  ExecuteQuery:sqlStmt2];
    
    //---------end
    
    [txtHomePostCode addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    [txtOfficePostcode addTarget:self action:@selector(OfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    [txtHomePostCode addTarget:self action:@selector(EditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [txtOfficePostcode addTarget:self action:@selector(OfficeEditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [txtIDType addTarget:self action:@selector(NewICDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    //  [txtIDType addTarget:self action:@selector(NewICTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [txtAnnIncome addTarget:self action:@selector(AnnualIncomeChange:) forControlEvents:UIControlEventEditingDidEnd];
    [txtOtherIDType addTarget:self action:@selector(OtheriDDidChange:) forControlEvents:UIControlEventEditingDidEnd];
	
	
	
	//to detect change
	[txtEmail addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[txtIDType addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[txtOtherIDType addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [txtHomeAddr1 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [txtHomeAddr2 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [txtHomeAddr3 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[txtHomeTown addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[txtHomeState addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[txtHomePostCode addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [txtOfficeAddr1 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [txtOfficeAddr2 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [txtOfficeAddr3 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[txtOfficeTown addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[txtOfficeState addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[txtOfficePostcode addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [txtFullName addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [txtPrefix1 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [txtContact1 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [txtContact2 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [txtContact3 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [txtContact4 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [txtPrefix2 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [txtPrefix3 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [txtPrefix4 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [segGender addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[segSmoker addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [outletDOB addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[txtAnnIncome addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventAllTouchEvents];
	[txtBussinessType addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CheckValidation) name:@"NewProfileValidate" object:nil];
    //	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btnSave_EditOrNew) name:@"NewProfileSave" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(btnSave) name:@"NewProfileSave" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CheckIfEmpty) name:@"CheckIfEmpty" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ClearAll) name:@"ClearAll" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateAfterSave) name:@"UpdateAfterSave" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(record_exist) name:@"new_exist" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnToListing) name:@"returnProspect" object:nil];
	
    //	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector() name:@"new_confirmCase" object:nil];
	
    txtRigNO.userInteractionEnabled=NO;
    btnRegistnDate.userInteractionEnabled=NO;
    segRigExempted.enabled =YES;
     outletRigDate.enabled=FALSE;
    outletRigDate.titleLabel.textColor = [UIColor grayColor];
    GSTRigperson = @"N";
    GSTRigExempted = @"";
    
//    if (!(prospectprofile.registrationDate == NULL || [prospectprofile.registrationDate isEqualToString:@"- SELECT -"])) {
//        [outletRigDate setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", prospectprofile.registrationDate]forState:UIControlStateNormal];
//        outletRigDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    }
//    else {
//        [outletRigDate setTitle:@"- SELECT -" forState:UIControlStateNormal];
//    }
   // outletRigDate.hidden=YES;
    if ([pp.registration isEqualToString:@"Y"]) {
        GSTRigperson = @"Y";
        segRigPerson.selectedSegmentIndex=0;
        txtRigNO.userInteractionEnabled=YES;
       // outletRigDate.hidden=NO;
        btnRegistnDate.userInteractionEnabled=YES;
        segRigExempted.enabled =TRUE;
        GSTRigExempted = @"";
        [outletRigDate setTitle:@"- SELECT -" forState:UIControlStateNormal];
        outletRigDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        outletRigDate.enabled=TRUE;
    }
    else if([pp.registration isEqualToString:@"N"]){
        GSTRigperson = @"N";
        segRigPerson.selectedSegmentIndex=1;
        txtRigNO.enabled=FALSE;
       // outletRigDate.hidden=YES;
        txtRigDate.enabled =FALSE;
        segRigExempted.enabled =TRUE;
        segRigExempted.selectedSegmentIndex = 1;
        txtRigNO.userInteractionEnabled=NO;
        btnRegistnDate.userInteractionEnabled=NO;
        [outletRigDate setTitle:@"- SELECT -" forState:UIControlStateNormal];
        outletRigDate.enabled=FALSE;
        outletRigDate.titleLabel.textColor = [UIColor grayColor];
        
    }
    else
        segRigPerson.selectedSegmentIndex = 1;
        segRigExempted.selectedSegmentIndex = 1;
    outletRigDate.titleLabel.textColor = [UIColor grayColor];
    ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
    
    txtHomeTown.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtHomeState.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtHomeCountry.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtOfficeTown.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtOfficeState.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtOfficeCountry.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtClass.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    btnOfficeCountry.hidden = YES;
    btnHomeCountry.hidden = YES;
    txtOtherIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtOtherIDType.enabled = NO;
    outletDOB.hidden = YES;
    txtDOB.enabled = NO;
    segGender.enabled = FALSE;
    segRigPerson.selectedSegmentIndex=1;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnSave_EditOrNew)];
	
    checked = NO;
    checked2 = NO;
    isHomeCountry = NO;
    isOffCountry = NO;
    companyCase = NO;
    
    txtEmail.delegate = self;
    txtAnnIncome.delegate = self;
    txtAnnIncome.keyboardType = UIKeyboardTypeNumberPad;
    txtIDType.delegate = self;
    txtFullName.delegate = self;
    txtOtherIDType.delegate = self;
    txtBussinessType.delegate = self;
    txtExactDuties.delegate = self;
    txtHomeAddr1.delegate = self;
    txtHomeAddr2.delegate = self;
    txtHomeAddr3.delegate = self;
    
    txtOfficeAddr1.delegate = self;
    txtOfficeAddr2.delegate = self;
    txtOfficeAddr3.delegate =self;
    txtRigDate.delegate=self;
    txtRigNO.delegate=self;
    txtHomePostCode.delegate = self;
    txtOfficePostcode.delegate = self;
	
	txtRemark.delegate = self;
    
    CustomColor = Nil;
    
    [myScrollView setScrollEnabled:YES];
    [myScrollView setContentSize:CGSizeMake(1024, 1180)];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Client Profile Listing" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
	
    NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"NEW" forKey:@"ChangedOn"];
	[ClientProfile setObject:@"NO" forKey:@"TabBar"];
	[ClientProfile setObject:@"" forKey:@"TabBar1"];
	[ClientProfile setObject:@"" forKey:@"Update_record"];
	NSMutableArray *groupArr = [NSMutableArray array];
	[UDGroup setObject:groupArr forKey:@"groupArr"];
    
    btnAddGroup.enabled = NO;
    btnAddGroup.alpha = 0.5;
    
//	btnViewGroup.enabled = NO;
    
    segIsGrouping.selectedSegmentIndex =1;
	
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	
	[self.view addGestureRecognizer:tap];
    
}

-(void)returnToListing {
	[self resignFirstResponder];
	[self.view endEditing:YES];
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)hideKeyboard{
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
    
}

- (void) keyboardWillHideHandler:(NSNotification *)notification {
    self.navigationItem.rightBarButtonItem.enabled = TRUE;
}

- (void) back
{
    
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"NO" forKey:@"TabBar"];
	
    NSString *name = [txtFullName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *ic = [txtIDType.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *income = [txtAnnIncome.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *home1 = [txtHomeAddr1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *home2 = [txtHomeAddr2.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *home3 = [txtHomeAddr3.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *office1 = [txtOfficeAddr1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *office2 = [txtOfficeAddr2.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *office3 = [txtOfficeAddr3.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *contact1 = [txtContact1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *contact2 = [txtContact2.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *contact3 = [txtContact3.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *contact4 = [txtContact4.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *otherid = [txtOtherIDType.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *dob = [outletDOB.titleLabel.text  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    NSString *title = [outletTitle.titleLabel.text stringByTrimmingCharactersInSet:
                       [NSCharacterSet whitespaceCharacterSet]];
	[self PopulateTitle];
    
    NSString *type = [OtherIDType.titleLabel.text stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *race = [outletRace.titleLabel.text stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *nation = [outletNationality.titleLabel.text stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceCharacterSet]];
    
    
    NSString *religion = [outletReligion.titleLabel.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceCharacterSet]];
    
    
    NSString *marital = [outletMaritalStatus.titleLabel.text stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *occup = [outletOccup.titleLabel.text stringByTrimmingCharactersInSet:
                       [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *group = [outletGroup.titleLabel.text stringByTrimmingCharactersInSet:
                       [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *navgtitle = self.navigationItem.title;
    
    if(txtOfficeCountry.text== NULL)
        txtOfficeCountry.text = @"";
    
    if([navgtitle isEqualToString:@"Add Client Profile"])
    {
        [txtOtherIDType removeTarget:self action:@selector(OtheriDDidChange:) forControlEvents:UIControlEventEditingDidEnd];
        [txtIDType removeTarget:self action:@selector(NewICDidChange:) forControlEvents:UIControlEventEditingDidEnd];
        
        [self IDValidation2];
        [self OtherIDValidation2];
        
        if(IC_Hold_Alert || OTHERID_Hold_Alert)
        {
            
            
            [self hideKeyboard];
            
            UIAlertView *back_alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                 message:@"Do you want to save?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
            back_alert.tag = 5000;
            [back_alert show];
            back_alert=nil;
            
            
        }
        else
            
            
            if(![type isEqualToString:@"- SELECT -"] )
            {
                [self hideKeyboard];
                
                UIAlertView *back_alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                     message:@"Do you want to save?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
                back_alert.tag = 5000;
                [back_alert show];
                back_alert=nil;
                
                
            }
        
            else  if(name.length==0 && ic.length==0 && income.length ==0 && home1.length==0 && home2.length ==0 && home3.length==0 && office1.length==0 && office2.length ==0 && office3.length==0 && txtPrefix1.text.length==0 && txtPrefix2.text.length==0 && txtPrefix3.text.length==0 && txtPrefix4.text.length==0 && contact1.length==0 && contact2.length ==0 && contact3.length ==0  && contact4.length ==0     && otherid.length==0 && [title isEqualToString:@"- SELECT -"] && [race isEqualToString:@"- SELECT -"] && [nation isEqualToString:@"- SELECT -"] && [religion isEqualToString:@"- SELECT -"] && [marital isEqualToString:@"- SELECT -"] && [occup isEqualToString:@"- SELECT -"] && [group isEqualToString:@"- SELECT -"] && txtRemark.text.length==0 && txtEmail.text.length==0 && txtExactDuties.text.length==0 && txtBussinessType.text.length==0 && segGender.selectedSegmentIndex==-1 && segSmoker.selectedSegmentIndex==-1 && txtOfficePostcode.text.length==0 && txtHomePostCode.text.length==0 && checked==NO && checked2 == NO)
            {
                [self resignFirstResponder];
                [self.view endEditing:YES];
                [self.navigationController popViewControllerAnimated:YES];
            }
        
            else{
                [self hideKeyboard];
				
                UIAlertView *back_alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                     message:@"Do you want to save?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
                back_alert.tag = 5000;
                [back_alert show];
                back_alert=nil;
				
				[txtIDType addTarget:self action:@selector(NewICDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                
                
            }
        
    }
    else if([navgtitle isEqualToString:@"Edit Client Profile"])
    {
        
        
        prospectprofile.ProspectTitle = [prospectprofile.ProspectTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		
		prospectprofile.ProspectTitle = [self getTitleDesc:prospectprofile.ProspectTitle];
        
        prospectprofile.ProspectName = [prospectprofile.ProspectName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        prospectprofile.IDTypeNo = [prospectprofile.IDTypeNo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        prospectprofile.OtherIDType = [prospectprofile.OtherIDType stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		
		prospectprofile.OtherIDType = [self getOtherTypeDesc:prospectprofile.OtherIDType];
		
		
        
        prospectprofile.OtherIDTypeNo = [prospectprofile.OtherIDTypeNo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        prospectprofile.ProspectDOB = [prospectprofile.ProspectDOB stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        prospectprofile.ProspectGender = [prospectprofile.ProspectGender stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        prospectprofile.Race = [prospectprofile.Race stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        prospectprofile.Nationality = [prospectprofile.Nationality stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        prospectprofile.Religion = [prospectprofile.Religion stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        prospectprofile.MaritalStatus = [prospectprofile.MaritalStatus stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        prospectprofile.ProspectOccupationCode = [prospectprofile.ProspectOccupationCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        prospectprofile.ProspectGroup = [prospectprofile.ProspectGroup stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        prospectprofile.ResidenceAddressCountry  = [prospectprofile.ResidenceAddressCountry stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        prospectprofile.OfficeAddressCountry  = [prospectprofile.OfficeAddressCountry stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        
        //  NSLog(@"prospectprofile.Smoker - |%@|   prospectprofile.ProspectGender - |%@|   ",prospectprofile.Smoker,prospectprofile.ProspectGender );
        int get_smoker= -1;
        // if([prospectprofile.Smoker isEqualToString:@""] || (prospectprofile.Smoker==NULL))
        //     get_smoker = -1;
        if([prospectprofile.Smoker isEqualToString:@"Y"])
            get_smoker = 0; // by segment 0 - yes 1 - no
        else if([prospectprofile.Smoker isEqualToString:@"N"])
            get_smoker = 1; // by segment 0 - yes 1 - no
        
        
        
        int get_gender = -1;
        //  if([prospectprofile.ProspectGender isEqualToString:@""] || (prospectprofile.ProspectGender==NULL))
        //      get_gender = -1;
        
        
        if([prospectprofile.ProspectGender isEqualToString:@"M"] || [prospectprofile.ProspectGender isEqualToString:@"MALE"])
        {
            get_gender = 0; // by segment 0 - yes 1 - no
            segGender.selectedSegmentIndex = 0;
            
        }
        else if([prospectprofile.ProspectGender isEqualToString:@"F"] || [prospectprofile.ProspectGender isEqualToString:@"FEMALE"])
        {
            get_gender = 1; // by segment 0 - yes 1 - no
            segGender.selectedSegmentIndex = 1;
            
        }
        [self getcontact];
        NSString *pre1 = [txtPrefix1.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceCharacterSet]];
        
        NSString *pre2 = [txtPrefix2.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceCharacterSet]];
        NSString *pre3 = [txtPrefix3.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceCharacterSet]];
        NSString *pre4 = [txtPrefix4.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceCharacterSet]];
        
        NSString *cont1 = [txtContact1.text stringByTrimmingCharactersInSet:
                           [NSCharacterSet whitespaceCharacterSet]];
        
        NSString *cont2 = [txtContact2.text stringByTrimmingCharactersInSet:
                           [NSCharacterSet whitespaceCharacterSet]];
        NSString *cont3 = [txtContact3.text stringByTrimmingCharactersInSet:
                           [NSCharacterSet whitespaceCharacterSet]];
        NSString *cont4 = [txtContact4.text stringByTrimmingCharactersInSet:
                           [NSCharacterSet whitespaceCharacterSet]];
        
        NSString *dob_trim = [txtDOB.text stringByTrimmingCharactersInSet:
                              [NSCharacterSet whitespaceCharacterSet]];
        
        
        if(gender == nil || gender==NULL)
            segGender.selectedSegmentIndex = -1;
        
        if(prospectprofile.OfficeAddressCountry == NULL)
            prospectprofile.OfficeAddressCountry = @"";
        
        if(txtHomeCountry.text == NULL)
            txtHomeCountry.text = @"";
        
        //		NSLog(@"ENS:  PP: %@, inp: %@:: %@, %@, %@, %@", prospectprofile.OtherIDType, type, otherid, prospectprofile.OtherIDTypeNo, title, prospectprofile.ProspectTitle);
        
        if([dob_trim isEqualToString:prospectprofile.ProspectDOB]
           && [title isEqualToString:prospectprofile.ProspectTitle]
           && [name isEqualToString:prospectprofile.ProspectName]
           && [ic isEqualToString:prospectprofile.IDTypeNo]
           && [type isEqualToString:prospectprofile.OtherIDType]
           && [otherid isEqualToString:prospectprofile.OtherIDTypeNo]
           
           && (segGender.selectedSegmentIndex == get_gender)
           && [race isEqualToString:prospectprofile.Race]
           && [nation isEqualToString:prospectprofile.Nationality]
           && [religion isEqualToString:prospectprofile.Religion]
           && [marital isEqualToString:prospectprofile.MaritalStatus]
           && (segSmoker.selectedSegmentIndex == get_smoker)
           && (OccupCodeSelected == prospectprofile.ProspectOccupationCode)
           &&  [txtExactDuties.text isEqualToString:prospectprofile.ExactDuties]
           && [txtAnnIncome.text isEqualToString:prospectprofile.AnnualIncome]
           && [group isEqualToString:prospectprofile.ProspectGroup]
           && [txtHomeAddr1.text isEqualToString:prospectprofile.ResidenceAddress1]
           && [txtHomeAddr2.text isEqualToString:prospectprofile.ResidenceAddress2]
           && [txtHomeAddr3.text isEqualToString:prospectprofile.ResidenceAddress3]
           && [txtHomePostCode.text isEqualToString:prospectprofile.ResidenceAddressPostCode]
           && [txtHomeCountry.text isEqualToString:prospectprofile.ResidenceAddressCountry]
           
           && [txtOfficeAddr1.text isEqualToString:prospectprofile.OfficeAddress1]
           && [txtOfficeAddr2.text isEqualToString:prospectprofile.OfficeAddress2]
           && [txtOfficeAddr3.text isEqualToString:prospectprofile.OfficeAddress3]
           && [txtOfficePostcode.text isEqualToString:prospectprofile.OfficeAddressPostCode]
           && [txtOfficeCountry.text isEqualToString:prospectprofile.OfficeAddressCountry]
           && [temp_pre1 isEqualToString:pre1]
           && [temp_pre2 isEqualToString:pre2]
           && [temp_pre3 isEqualToString:pre3]
           && [temp_pre4 isEqualToString:pre4]
           && [temp_cont1 isEqualToString:cont1]
           && [temp_cont2 isEqualToString:cont2]
           && [temp_cont3 isEqualToString:cont3]
           && [temp_cont4 isEqualToString:cont4]
           && [txtEmail.text isEqualToString:prospectprofile.ProspectEmail]
           && [txtRemark.text isEqualToString:prospectprofile.ProspectRemark]
           )
        {
            [self resignFirstResponder];
            [self.view endEditing:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        else{
            [self hideKeyboard];
            UIAlertView *back_alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                 message:@"Do you want to save?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
            back_alert.tag = 5000;
            [back_alert show];
            back_alert=nil;
            
            
        }
        
        
        
        
    }
    
    
}


- (void) getcontact
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT ContactCode, ContactNo, Prefix FROM contact_input where indexNo = %@ ", pp.ProspectID];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            int a = 0;
            while (sqlite3_step(statement) == SQLITE_ROW){
                
                NSString *ContactCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *ContactNo = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *Prefix = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                
                if (a==0) {
                    if ([ContactCode isEqualToString:@"CONT008"]) { //mobile
                        txtContact2.text  = ContactNo;
                        txtPrefix2.text = Prefix;
                        
                        temp_pre2=Prefix;
                        temp_cont2 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT006"]) { //home
                        txtContact1.text = ContactNo;
                        txtPrefix1.text = Prefix;
                        
                        temp_pre1=Prefix;
                        temp_cont1 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT009"]) { //fax
                        txtContact4.text = ContactNo;
                        txtPrefix4.text = Prefix;
                        
                        temp_pre4=Prefix;
                        temp_cont4 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT007"]) { //office
                        txtContact3.text = ContactNo;
                        txtPrefix3.text = Prefix;
                        
                        temp_pre3=Prefix;
                        temp_cont3 = ContactNo;
                    }
                }
                else if (a==1) {
                    if ([ContactCode isEqualToString:@"CONT008"]) { //mobile
                        txtContact2.text  = ContactNo;
                        txtPrefix2.text = Prefix;
                        
                        temp_pre2=Prefix;
                        temp_cont2 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT006"]) { //home
                        txtContact1.text = ContactNo;
                        txtPrefix1.text = Prefix;
                        
                        temp_pre1=Prefix;
                        temp_cont1 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT009"]) { //fax
                        txtContact4.text = ContactNo;
                        txtPrefix4.text = Prefix;
                        
                        temp_pre4=Prefix;
                        temp_cont4 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT007"]) { //office
                        txtContact3.text = ContactNo;
                        txtPrefix3.text = Prefix;
                        
                        temp_pre3=Prefix;
                        temp_cont3 = ContactNo;
                    }
                }
                else if (a==2) {
                    if ([ContactCode isEqualToString:@"CONT008"]) { //mobile
                        txtContact2.text  = ContactNo;
                        txtPrefix2.text = Prefix;
                        
                        temp_pre2=Prefix;
                        temp_cont2 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT006"]) { //home
                        txtContact1.text = ContactNo;
                        txtPrefix1.text = Prefix;
                        
                        temp_pre1=Prefix;
                        temp_cont1 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT009"]) { //fax
                        txtContact4.text = ContactNo;
                        txtPrefix4.text = Prefix;
                        
                        temp_pre4=Prefix;
                        temp_cont4 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT007"]) { //office
                        txtContact3.text = ContactNo;
                        txtPrefix3.text = Prefix;
                        
                        temp_pre3=Prefix;
                        temp_cont3 = ContactNo;
                    }
                }
                else if (a==3) {
                    if ([ContactCode isEqualToString:@"CONT008"]) { //mobile
                        txtContact2.text  = ContactNo;
                        txtPrefix2.text = Prefix;
                        
                        temp_pre2=Prefix;
                        temp_cont2 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT006"]) { //home
                        txtContact1.text = ContactNo;
                        txtPrefix1.text = Prefix;
                        
                        temp_pre1=Prefix;
                        temp_cont1 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT009"]) { //fax
                        txtContact4.text = ContactNo;
                        txtPrefix4.text = Prefix;
                        
                        temp_pre4=Prefix;
                        temp_cont4 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT007"]) { //office
                        txtContact3.text = ContactNo;
                        txtPrefix3.text = Prefix;
                        
                        temp_pre3=Prefix;
                        temp_cont3 = ContactNo;
                    }
                }
                a = a + 1;
            }
            sqlite3_finalize(statement);
        }
    }
    sqlite3_close(contactDB);
}
- (void)viewWillAppear:(BOOL)animated
{
    txtRigDate.userInteractionEnabled=FALSE;
    [btnHomeCountry setTitle:@"- SELECT -" forState:UIControlStateNormal];
    btnHomeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [_btnTitle setTitle:@"- SELECT -" forState:UIControlStateNormal];
    _btnTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [outletRace setTitle:@"- SELECT -" forState:UIControlStateNormal];
    outletRace.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [outletNationality setTitle:@"- SELECT -" forState:UIControlStateNormal];
    outletNationality.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [outletNationality setTitle:@"- SELECT -" forState:UIControlStateNormal];
    outletNationality.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [outletReligion setTitle:@"- SELECT -" forState:UIControlStateNormal];
    outletReligion.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [outletMaritalStatus setTitle:@"- SELECT -" forState:UIControlStateNormal];
    outletMaritalStatus.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [outletGroup setTitle:@"- SELECT -" forState:UIControlStateNormal];
    outletGroup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    
    [outletRigDate setTitle:@"- SELECT -" forState:UIControlStateNormal];
    outletRigDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    outletRigDate.titleLabel.textColor = [UIColor grayColor];
    
    [btnHomeCountry setTitle:@"- SELECT -" forState:UIControlStateNormal];
    btnHomeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [btnOfficeCountry setTitle:@"- SELECT -" forState:UIControlStateNormal];
    btnOfficeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [OtherIDType setTitle:@"- SELECT -" forState:UIControlStateNormal];
    OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [outletOccup setTitle:@"- SELECT -" forState:UIControlStateNormal];
    outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    
    //CHANGE SEGMENTATION CONTROL FONT SIZE
    UIFont *font= [UIFont fontWithName:@"TreBuchet MS" size:16.0f];
    
    
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:UITextAttributeFont];
    [segSmoker setTitleTextAttributes:attributes
                             forState:UIControlStateNormal];
    
    [segGender setTitleTextAttributes:attributes
                             forState:UIControlStateNormal];
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    
	[super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (interfaceOrientation==UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        return YES;
    
    return NO;
}


#pragma mark - keyboard

-(void)keyboardDidShow:(NSNotificationCenter *)notification
{
    self.myScrollView.frame = CGRectMake(0, -44, 1024, 748-352);
    self.myScrollView.contentSize = CGSizeMake(1024, 900);
    
    CGRect textFieldRect = [activeField frame];
    textFieldRect.origin.y += 15;
    [self.myScrollView scrollRectToVisible:textFieldRect animated:YES];
    txtRemark.hidden = FALSE;
    
    if ([txtAnnIncome isFirstResponder]) {
        [myScrollView setContentOffset:CGPointMake(0,400) animated:YES];
    }
    
    else if([txtRigNO isFirstResponder]) {
        [myScrollView setContentOffset:CGPointMake(0,430) animated:YES];

    }

    else if([txtOfficePostcode isFirstResponder])
    {
        [myScrollView setContentOffset:CGPointMake(0,70) animated:YES];
    }
    else if ([txtPrefix1 isFirstResponder])
    {
        [myScrollView setContentOffset:CGPointMake(0,200) animated:YES];
    }
    else if ([txtContact1 isFirstResponder])
    {
        [myScrollView setContentOffset:CGPointMake(0,200) animated:YES];
    }
    else if([txtPrefix2 isFirstResponder])
    {
        [myScrollView setContentOffset:CGPointMake(0,200) animated:YES];
    }
    else if([txtContact2 isFirstResponder])
    {
        [myScrollView setContentOffset:CGPointMake(0,200) animated:YES];
    }
    else if([txtPrefix3 isFirstResponder])
    {
        [myScrollView setContentOffset:CGPointMake(0,250) animated:YES];
    }
    else if([txtContact3 isFirstResponder])
    {
        [myScrollView setContentOffset:CGPointMake(0,250) animated:YES];
    }
    else if([txtPrefix4 isFirstResponder])
    {
        [myScrollView setContentOffset:CGPointMake(0,250) animated:YES];
    }
    else if([txtContact4 isFirstResponder])
    {
        [myScrollView setContentOffset:CGPointMake(0,250) animated:YES];
    }
    else if([txtEmail isFirstResponder])
    {
        [myScrollView setContentOffset:CGPointMake(0,350) animated:YES];
    }
    else if([txtBussinessType isFirstResponder])
    {
        [myScrollView setContentOffset:CGPointMake(0,400) animated:YES];
    }
    
    
    
}

-(void)keyboardDidHide:(NSNotificationCenter *)notification
{
    self.myScrollView.frame = CGRectMake(0, -44, 1024, 748);
}

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}

-(BOOL)Contains:(NSString *)StrSearchTerm on:(NSString *)StrText
{
    return  [StrText rangeOfString:StrSearchTerm options:NSCaseInsensitiveSearch].location==NSNotFound?FALSE:TRUE;
}

-(void)textFieldDidChange:(id) sender
{
    BOOL gotRow = false;
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    
    //CHECK INVALID SYMBOLS
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
    
    
    BOOL valid;
    BOOL valid_symbol;
    
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtHomePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    valid = [alphaNums isSupersetOfSet:inStringSet];
    valid_symbol = [set isSupersetOfSet:inStringSet];
    
    if(txtHomePostCode.text.length < 5)
    {
        /* rrr = [[UIAlertView alloc] initWithTitle:@" "
         message:@"Postcode for Home Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         
         rrr.tag = 2001;
         [rrr show];
         rrr=nil;
         */
        txtHomeState.text = @"";
        txtHomeTown.text = @"";
        txtHomeCountry.text = @"";
        SelectedStateCode = @"";
        
    }
    
    else  if (!valid_symbol) {
        
        /*  rrr = [[UIAlertView alloc] initWithTitle:@" "
         message:@"Postcode for Home Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         
         rrr.tag = 2001;
         [rrr show];
         */
        txtHomeState.text = @"";
        txtHomeTown.text = @"";
        txtHomeCountry.text = @"";
        SelectedStateCode = @"";
        
    }
    
    
    else if (!valid) {
        
        /*    rrr = [[UIAlertView alloc] initWithTitle:@" "
         message:@"Home post code must be in numeric." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         
         rrr.tag = 2001;
         [rrr show];
         
         */
        
        txtHomeState.text = @"";
        txtHomeTown.text = @"";
        txtHomeCountry.text = @"";
        SelectedStateCode = @"";
        PostcodeContinue = FALSE;
        
    }
    else {
        
        
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
            NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", txtHomePostCode.text];
            
            
            
            const char *query_stmt = [querySQL UTF8String];
            if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW){
                    NSString *Town = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    NSString *State = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    NSString *Statecode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                    
                    txtHomeState.text = State;
                    txtHomeTown.text = Town;
                    txtHomeCountry.text = @"MALAYSIA";
                    SelectedStateCode = Statecode;
                    gotRow = true;
                    PostcodeContinue = TRUE;
                    
                    self.navigationItem.rightBarButtonItem.enabled = TRUE;
                }
                sqlite3_finalize(statement);
            }
            else{
                txtHomeState.text = @"";
                txtHomeTown.text = @"";
                txtHomeCountry.text = @"";
                
            }
            
            
            
            sqlite3_close(contactDB);
        }
        
    }
}

-(void)OfficePostcodeDidChange:(id) sender
{
    
    BOOL gotRow = false;
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    txtOfficePostcode.text = [txtOfficePostcode.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    
    
    
    //CHECK INVALID SYMBOLS
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
    
    
    BOOL valid;
    BOOL valid_symbol;
    
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtOfficePostcode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    valid = [alphaNums isSupersetOfSet:inStringSet];
    valid_symbol = [set isSupersetOfSet:inStringSet];
    PostcodeContinue = TRUE;
    
    if(txtOfficePostcode.text.length < 5)
    {
        /* rrr = [[UIAlertView alloc] initWithTitle:@" "
         message:@"Postcode for Home Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         
         rrr.tag = 2001;
         [rrr show];
         rrr=nil;
         */
        txtOfficeState.text = @"";
        txtOfficeTown.text = @"";
        txtOfficeCountry.text = @"";
        SelectedOfficeStateCode = @"";
    }
    
    
    else if (!valid_symbol) {
        
        /*   rrr = [[UIAlertView alloc] initWithTitle:@" "
         message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         
         rrr.tag = 3001;
         [rrr show];
         */
        txtOfficeState.text = @"";
        txtOfficeTown.text = @"";
        txtOfficeCountry.text = @"";
        SelectedOfficeStateCode = @"";
        
    }
    
    
    
    else if (!valid) {
        
        
        
        /*rrr = [[UIAlertView alloc] initWithTitle:@" "
         message:@"Office post code must be in numeric" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         rrr.tag = 3001;
         [rrr show];
         */
        
        txtOfficeState.text = @"";
        txtOfficeTown.text = @"";
        txtOfficeCountry.text = @"";
        SelectedOfficeStateCode = @"";
        PostcodeContinue = FALSE;
        
    }
    else {
        
        if(!checked2)
        {
            if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
                NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", txtOfficePostcode.text];
                
                
                
                const char *query_stmt = [querySQL UTF8String];
                if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    while (sqlite3_step(statement) == SQLITE_ROW){
                        NSString *OfficeTown = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                        NSString *OfficeState = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                        NSString *Statecode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                        
                        
                        
                        txtOfficeState.text = OfficeState;
                        txtOfficeTown.text = OfficeTown;
                        txtOfficeCountry.text = @"MALAYSIA";
                        SelectedOfficeStateCode = Statecode;
                        gotRow = true;
                        PostcodeContinue = TRUE;
                        self.navigationItem.rightBarButtonItem.enabled = TRUE;
                    }
                    sqlite3_finalize(statement);
                    
                    
                    sqlite3_close(contactDB);
                }
                else{
                    txtOfficeState.text = @"";
                    txtOfficeTown.text = @"";
                    txtOfficeCountry.text = @"";
                }
            }
        }
    }
    
    
}

-(void)EditTextFieldBegin:(id)sender
{
    // self.navigationItem.rightBarButtonItem.enabled = FALSE;
    
    [txtHomePostCode addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
}

-(void)OfficeEditTextFieldBegin:(id)sender
{
    
    /*  if ([self OptionalOccp] == FALSE) {
     self.navigationItem.rightBarButtonItem.enabled = FALSE;
     }
     */
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isNew"];
	
    NSUInteger newLength = [textView.text length] + [text length] - range.length;
    
    if (textView == txtExactDuties) {
        return ((newLength <= CHARACTER_LIMIT_ExactDuties));
    }
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    //IN EDIT CLIENT PROFILE ALSO
    
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isNew"];
    
    NSString *myString = nil;
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    if((checked && textField == txtHomePostCode ) || (checked2 && textField == txtOfficePostcode))
    {
        return ((newLength <= CHARACTER_LIMIT_FOREIGN_POSTCODE));
    }
    else if (textField == txtOfficePostcode || textField == txtHomePostCode)
    {
        return ((newLength <= CHARACTER_LIMIT_POSTCODE));
    }
    
    if (textField == txtEmail) {
        
        return ((newLength <= CHARACTER_LIMIT_ExactDuties));
    }
    
    if (textField == txtPrefix1) {
        myString = [txtPrefix1.text stringByReplacingCharactersInRange:range withString:string];
        if (myString.length > 4) {
            return NO;
        }
    }
    
    if (textField == txtPrefix2) {
        myString = [txtPrefix2.text stringByReplacingCharactersInRange:range withString:string];
        if (myString.length > 4) {
            return NO;
        }
    }
    
    if (textField == txtPrefix3) {
        myString = [txtPrefix3.text stringByReplacingCharactersInRange:range withString:string];
        if (myString.length > 4) {
            return NO;
        }
    }
    
    if (textField == txtPrefix4) {
        myString = [txtPrefix4.text stringByReplacingCharactersInRange:range withString:string];
        if (myString.length > 4) {
            return NO;
        }
    }
    
    if (textField == txtContact1) {
        myString = [txtContact1.text stringByReplacingCharactersInRange:range withString:string];
        if (myString.length > 10) {
            return NO;
        }
    }
    
    if (textField == txtContact2) {
        myString = [txtContact2.text stringByReplacingCharactersInRange:range withString:string];
        if (myString.length > 10) {
            return NO;
        }
    }
    
    if (textField == txtContact3) {
        myString = [txtContact3.text stringByReplacingCharactersInRange:range withString:string];
        if (myString.length > 10) {
            return NO;
        }
    }
    
    if (textField == txtContact4) {
        myString = [txtContact4.text stringByReplacingCharactersInRange:range withString:string];
        if (myString.length > 10) {
            return NO;
        }
    }
    
    
    if (textField == txtIDType) {
        
        //      [txtIDType addTarget:self action:@selector(NewICDidChange:) forControlEvents:UIControlEventEditingDidEnd];
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_PC_F));
    }
    
    
    if (textField == txtRigNO) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_GSTREGNO));
	}
    
    
    
    
    if (textField == txtAnnIncome) {
        
		NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
		[ClientProfile setObject:@"YES" forKey:@"isNew"];
		
        BOOL return13digit = FALSE;
        
        //KY - IMPORTANT - PUT THIS LINE TO DETECT THE FIRST CHARACTER PRESSED....
        //This method is being called before the content of textField.text is changed.
        NSString * AI = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        
        
        
        
        if ([AI rangeOfString:@"."].length == 1) {
            
            NSArray  *comp = [AI componentsSeparatedByString:@"."];
            
            NSString *get_num = [[comp objectAtIndex:0] stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            int c = [get_num length];
            
            if(c > 13)
            {
                /* rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"Annual income must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 rrr.tag = 1008;
                 [rrr show];
                 rrr = nil;
                 */
                return13digit = TRUE;
                
            }
            
            
            
        }else  if([AI rangeOfString:@"."].length == 0){
            
            
            NSArray  *comp = [AI componentsSeparatedByString:@"."];
            
            NSString *get_num = [[comp objectAtIndex:0] stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            int c = [get_num length];
            
            
            
            if(c  > 13)
            {
                
                /*rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"Annual income must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 rrr.tag = 1008;
                 [rrr show];
                 rrr = nil;
                 */
                return13digit = TRUE;
                
                
            }
            
            
            
        }
        
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_MONEY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        
        
        
        if( return13digit == TRUE)
            return (([string isEqualToString:filtered])&&(newLength <= 13));
        else
            return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_ANNUALINCOME));
        
        
        
        
    }
    
    
    if (textField == txtFullName) {
        
        return ((newLength <= CHARACTER_LIMIT_FULLNAME));
    }
    
    if (textField == txtOtherIDType) {
        
        return ((newLength <= CHARACTER_LIMIT_OtherID));
    }
    if (textField == txtBussinessType) {
        
        return ((newLength <= CHARACTER_LIMIT_Bussiness));
    }
    if (textField == txtHomeAddr1 || textField == txtHomeAddr2 ||textField == txtHomeAddr3 || txtOfficeAddr1 ||txtOfficeAddr2 ||txtOfficeAddr3)
    {
        
        return ((newLength <= CHARACTER_LIMIT_Address));
    }
    if (textField == txtOfficePostcode || textField == txtHomePostCode)
    {
        
        return ((newLength <= CHARACTER_LIMIT_POSTCODE));
    }
    
    return YES;
}

-(void)AnnualIncomeChange:(id) sender
{
    
    txtAnnIncome.text = [txtAnnIncome.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    txtAnnIncome.text = [txtAnnIncome.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    txtAnnIncome.text = [txtAnnIncome.text stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *result;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setMaximumFractionDigits:2];
    [formatter setUsesGroupingSeparator:YES];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    double entryFieldFloat = [txtAnnIncome.text doubleValue];
    
    
    if ([txtAnnIncome.text rangeOfString:@".00"].length == 3) {
        
        formatter.alwaysShowsDecimalSeparator = YES;
        result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
        result = [result stringByAppendingFormat:@"00"];
        
    }
    else  if ([txtAnnIncome.text rangeOfString:@"."].length == 1) {
        
        
        formatter.alwaysShowsDecimalSeparator = YES;
        result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
        
        
        
    }else if ([txtAnnIncome.text rangeOfString:@"."].length != 1)
    {
        
        formatter.alwaysShowsDecimalSeparator = NO;
        
        result =[formatter stringFromNumber:[NSNumber numberWithDouble:entryFieldFloat]];
        result = [result stringByAppendingFormat:@".00"];
        
    }
    
    annualIncome_original = txtAnnIncome.text;
    
    if(txtAnnIncome.text.length==0)
        txtAnnIncome.text = @"";
    else
        txtAnnIncome.text = result;
    
    
    
}


-(void)OtheriDDidChange:(id) sender
{
    [self OtherIDValidation];
}



-(void)NewICDidChange:(id) sender
{
    
    
    txtIDType.text = [txtIDType.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([txtIDType.text isEqualToString:@""]) {
        
        
        if([OtherIDType.titleLabel.text isEqualToString:@"PASSPORT"])
        {
            companyCase = NO;
            
            // check if ic field is empty
            if ([txtIDType.text isEqualToString:@""]) {
                
                
                txtIDType.backgroundColor = [UIColor whiteColor];
                txtIDType.enabled = YES;
                segGender.enabled = YES;
                segSmoker.enabled = YES;
                
                // Reset dob
                //txtDOB.text = @"";
                outletDOB.hidden = NO;
                outletDOB.enabled = TRUE;
                
                //[outletDOB setTitle:@"- SELECT -" forState:UIControlStateNormal];
            }
            
            
            outletTitle.enabled = YES;
            outletTitle.titleLabel.textColor = [UIColor blackColor];
            
            OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            txtOtherIDType.enabled = YES;
            txtOtherIDType.backgroundColor = [UIColor whiteColor];
            
            outletOccup.enabled = YES;
            outletOccup.titleLabel.textColor = [UIColor blackColor];
            
            
            outletRace.titleLabel.textColor = [UIColor blackColor];
            outletRace.enabled = YES;
            
            outletReligion.enabled = YES;
            outletReligion.titleLabel.textColor = [UIColor blackColor];
            
            outletNationality.enabled = YES;
            outletNationality.titleLabel.textColor = [UIColor blackColor];
            
            outletMaritalStatus.enabled = YES;
            outletMaritalStatus.titleLabel.textColor = [UIColor blackColor];
            
            
        } else {
            
            segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
            segGender.enabled = YES;
            
            
            txtDOB.hidden = YES;
            outletDOB.hidden = NO;
            outletDOB.enabled = YES;
            //  [outletDOB setTitle:@"- SELECT -" forState:UIControlStateNormal];
            txtDOB.backgroundColor = [UIColor whiteColor];
            
            
        }
        
        txtIDType.text = @"";
        
        self.navigationItem.rightBarButtonItem.enabled = TRUE;
        
        return;
        
        
    }else if (txtIDType.text.length > 0 && txtIDType.text.length < 12) {
        
        if([OtherIDType.titleLabel.text isEqualToString:@"PASSPORT"])
        {
            companyCase = NO;
            
            // check if ic field is empty
            if ([txtIDType.text isEqualToString:@""]) {
                
                txtIDType.backgroundColor = [UIColor whiteColor];
                txtIDType.enabled = YES;
                segGender.enabled = YES;
                segSmoker.enabled = YES;
                outletDOB.hidden = NO;
                outletDOB.enabled = TRUE;
                
                //[outletDOB setTitle:@"- SELECT -" forState:UIControlStateNormal];
            }
            
            
            
            outletTitle.enabled = YES;
            outletTitle.titleLabel.textColor = [UIColor blackColor];
            
            OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            txtOtherIDType.enabled = YES;
            txtOtherIDType.backgroundColor = [UIColor whiteColor];
            
            outletOccup.enabled = YES;
            outletOccup.titleLabel.textColor = [UIColor blackColor];
            
            
            outletRace.titleLabel.textColor = [UIColor blackColor];
            outletRace.enabled = YES;
            
            outletReligion.enabled = YES;
            outletReligion.titleLabel.textColor = [UIColor blackColor];
            
            outletNationality.enabled = YES;
            outletNationality.titleLabel.textColor = [UIColor blackColor];
            
            outletMaritalStatus.enabled = YES;
            outletMaritalStatus.titleLabel.textColor = [UIColor blackColor];
            
            
            
        } else{
            
            txtDOB.text = @"";
            segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        }
        
        self.navigationItem.rightBarButtonItem.enabled = TRUE;
        
        // return;
    }
    else if(txtIDType.text.length == 16)
    {
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtIDType.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
        valid = [alphaNums isSupersetOfSet:inStringSet];
        if (!valid) {

            txtIDType.text = @"";
            if([OtherIDType.titleLabel.text isEqualToString:@"PASSPORT"])
            {
                
            }else{
                txtDOB.text = @"";
                segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
            }
        }
        else {
            
            NSString *strDate = [txtIDType.text substringWithRange:NSMakeRange(6, 2)];
			NSString *strMonth = [txtIDType.text substringWithRange:NSMakeRange(8, 2)];
			NSString *strYear = [txtIDType.text substringWithRange:NSMakeRange(10, 2)];
			NSString *strGender;
			
			int intDate = [strDate integerValue];
			if (intDate > 40 && intDate < 72) {
				strGender = @"F";
				gender = @"FEMALE";
				segGender.selectedSegmentIndex = 1;
				intDate = intDate - 40;
				if (intDate <10)
					strDate = [NSString stringWithFormat:@"0%d", intDate];
				else
					strDate = [NSString stringWithFormat:@"%d", intDate];
			}
			else if (intDate > 0 && intDate < 31) {
				strGender = @"M";
				segGender.selectedSegmentIndex = 0;
				gender = @"MALE";
			}
			segGender.enabled = FALSE;
            
		
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
                
                if([OtherIDType.titleLabel.text isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    txtDOB.text = @"";
                    segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
            }
            else if ([strMonth intValue] > 12 || [strMonth intValue] < 1) {
                
                /*    rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC month must be between 1 and 12." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                 rrr.tag = 1002;
                 [rrr show];
                 */
                if([OtherIDType.titleLabel.text isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    txtDOB.text = @"";
                    segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
            }
            else if([strDate intValue] < 1 || [strDate intValue] > 31)
            {
                
                /*    rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC day must be between 1 and 31." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                 rrr.tag = 1002;
                 [rrr show];
                 */
                //self.navigationItem.rightBarButtonItem.enabled = FALSE;
                
            }
            else if (([strMonth isEqualToString:@"01"] || [strMonth isEqualToString:@"03"] || [strMonth isEqualToString:@"05"] || [strMonth isEqualToString:@"07"] || [strMonth isEqualToString:@"08"] || [strMonth isEqualToString:@"10"] || [strMonth isEqualToString:@"12"]) && [strDate intValue] > 31) {
                
                txtIDType.text = @"";
                if([OtherIDType.titleLabel.text isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    txtDOB.text = @"";
                    segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
            }
            
            else if (([strMonth isEqualToString:@"04"] || [strMonth isEqualToString:@"06"] || [strMonth isEqualToString:@"09"] || [strMonth isEqualToString:@"11"]) && [strDate intValue] > 30) {
                
                txtIDType.text = @"";
                if([OtherIDType.titleLabel.text isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    txtDOB.text = @"";
                    segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
            }
            else if (([febStatus isEqualToString:@"Normal"] && [strDate intValue] > 28 && [strMonth isEqualToString:@"02"]) || ([febStatus isEqualToString:@"Jump"] && [strDate intValue] > 29 && [strMonth isEqualToString:@"02"])) {
                
                
                //    NSString *msg = [NSString stringWithFormat:@"February of %@ doesn’t have 29 days",strYear] ;
                
                /*
                 rrr = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                 
                 [rrr show];
                 */
                
                if([OtherIDType.titleLabel.text isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    txtDOB.text = @"";
                    segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
            }
            else {
                outletDOB.hidden = YES;
                outletDOB.enabled = FALSE;
                txtDOB.enabled = FALSE;
                txtDOB.hidden = NO;
                txtDOB.text = strDOB;
                [outletDOB setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",strDOB]forState:UIControlStateNormal];
                
                ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
                txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            }
            
            strDate = nil, strMonth = nil, strYear = nil, currentYear = nil, strCurrentYear = nil;
            dateFormatter = Nil, strDOB = nil, strDOB2 = nil, d = Nil, d2 = Nil;
        }
        
        alphaNums = nil, inStringSet = nil;
    }
    
    //  [txtIDType removeTarget:self action:@selector(NewICDidChange:) forControlEvents:UIControlEventEditingDidEnd];
	
    [self IDValidation];
    
    self.navigationItem.rightBarButtonItem.enabled = TRUE;

    
    
}

-(void)detectChanges:(id)sender {
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isNew"];
}


-(void)NewICTextFieldBegin:(id)sender {
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
    
    //   self.navigationItem.rightBarButtonItem.enabled = false;
    
    if([OtherIDType.titleLabel.text isEqualToString:@"PASSPORT"])
    {
        outletDOB.hidden = NO;
        outletDOB.enabled = FALSE;
        txtDOB.hidden = YES;
        //[outletDOB setBackgroundColor:[CustomColor colorWithHexString:@"EEEEEE"]];
        
    }else{
        
        outletDOB.hidden = YES;
        txtDOB.hidden = NO;
        
    }
    
    txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    segGender.enabled = NO;
    
    
    
}

#pragma mark - action

- (IBAction)ActionGender:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isNew"];
	
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    
    
    if ([segGender selectedSegmentIndex]==0) {
        gender = @"MALE";
    }
    else if([segGender selectedSegmentIndex]==1) {
        gender = @"FEMALE";
    }
    
}

- (IBAction)ActionSmoker:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isNew"];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if ([segSmoker selectedSegmentIndex]==0) {
        ClientSmoker = @"Y";
    }
    else if ([segSmoker selectedSegmentIndex]==1){
        ClientSmoker = @"N";
    }
}

- (IBAction)ActionRigperson:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isNew"];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if ([segRigPerson selectedSegmentIndex]==0) {
        GSTRigperson = @"Y";
        txtRigNO.enabled=TRUE;
        txtRigDate.enabled =TRUE;
        segRigExempted.enabled =TRUE;
    //    segRigExempted.selectedSegmentIndex = 1;
        btnRegistnDate.userInteractionEnabled=YES;
        btnRegistnDate.enabled=YES;
        outletRigDate.enabled=TRUE;
        txtRigNO.userInteractionEnabled=YES;
        [outletRigDate setTitle:@"- SELECT -" forState:UIControlStateNormal];
         outletRigDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
       // outletRigDate.hidden=NO;
    }
    else if ([segRigPerson selectedSegmentIndex]==1){
        //outletRigDate.hidden=YES;
        GSTRigperson = @"N";
        txtRigNO.enabled=FALSE;
        txtRigDate.enabled =FALSE;
        segRigExempted.enabled =TRUE;
      //  segRigExempted.selectedSegmentIndex = 1;
        btnRegistnDate.enabled = FALSE;
        btnRegistnDate.userInteractionEnabled=NO;
        txtRigNO.userInteractionEnabled=NO;
        [outletRigDate setTitle:@"- SELECT -" forState:UIControlStateNormal];
         outletRigDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        outletRigDate.enabled=FALSE;
        txtRigDate.text=@"";
        txtRigNO.text=@"";
         outletRigDate.titleLabel.textColor = [UIColor grayColor];
    }
}

- (IBAction)ActionExempted:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isNew"];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if ([segRigExempted selectedSegmentIndex]==0) {
        GSTRigExempted = @"Y";
        
    }
    else if ([segRigExempted selectedSegmentIndex]==1){
        GSTRigExempted = @"N";
    }
}

//- (IBAction)ActionforRigdate:(id)sender {
//- (IBAction)ActionforregistrationDte:(id)sender {
//  - (IBAction)ActionforRigdate:(id)sender {  
//   
//	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
//    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
//    
//    //_dobLbl.text = dateString;
//	txtRigDate.textColor = [UIColor blackColor];
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
//    
//    if (_SIDate == Nil) {
//        
//        self.SIDate = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIDate"];
//        _SIDate.delegate = self;
//        self.SIDatePopover = [[UIPopoverController alloc] initWithContentViewController:_SIDate];
//    }
//    
//    [self.SIDatePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
//    [self.SIDatePopover presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
//    
//    
//    dateFormatter = Nil;
//    dateString = Nil, mainStoryboard = nil;
//    
//    RegDatehandling =NO;
//}





- (IBAction)btnDOB:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
	
    isDOBDate = YES;
	isGSTDate = NO;

	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isNew"];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    outletDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    if([txtDOB.text isEqualToString:@""]){
        [outletDOB setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", dateString] forState:UIControlStateNormal];
        txtDOB.text = dateString;
        
    }else{
        [outletDOB setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", outletDOB.titleLabel.text] forState:UIControlStateNormal];
    }
    
    
    
    if (_SIDate == Nil) {
        
        self.SIDate = [self.storyboard instantiateViewControllerWithIdentifier:@"SIDate"];
        _SIDate.delegate = self;
        self.SIDatePopover = [[UIPopoverController alloc] initWithContentViewController:_SIDate];
    }
    
    [self.SIDatePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    
    [self.SIDatePopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionLeft animated:NO];
    
    dateFormatter = Nil;
    dateString = Nil;
    
}

- (IBAction)btnOccup:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isNew"];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if (_OccupationList == nil) {
        self.OccupationList = [[OccupationList alloc] initWithStyle:UITableViewStylePlain];
        _OccupationList.delegate = self;
        self.OccupationListPopover = [[UIPopoverController alloc] initWithContentViewController:_OccupationList];
    }
    
    
    [self.OccupationListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}

- (IBAction)isForeign:(id)sender
{
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isNew"];
	
    UIButton *btnPressed = (UIButton*)sender;
    ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
    
    if (btnPressed.tag == 0) {
        
        if (checked) {
            [btnForeignHome setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
            checked = NO;
            
            txtHomeAddr1.text=@"";
            txtHomeAddr2.text=@"";
            txtHomeAddr3.text=@"";
            
            
            txtHomePostCode.text = @"";
            txtHomeTown.text = @"";
            txtHomeState.text = @"";
            txtHomeCountry.text = @"";
            txtHomeTown.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            txtHomeState.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            txtHomeCountry.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            txtHomeTown.enabled = NO;
            txtHomeState.enabled = NO;
            txtHomeCountry.hidden = NO;
            btnHomeCountry.hidden = YES;
            
            [txtHomePostCode addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
            [txtHomePostCode addTarget:self action:@selector(EditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
        }
        else {
            [btnForeignHome setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            checked = YES;
            
            txtHomeAddr1.text = @"";
            txtHomeAddr2.text = @"";
            txtHomeAddr3.text = @"";
            
            txtHomePostCode.text = @"";
            txtHomeTown.text = @"";
            txtHomeState.text = @"";
            [btnHomeCountry setTitle:@"- SELECT -" forState:UIControlStateNormal];
            btnHomeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            txtHomeTown.backgroundColor = [UIColor whiteColor];
            txtHomeState.backgroundColor = [UIColor whiteColor];
            txtHomeCountry.backgroundColor = [UIColor whiteColor];
            txtHomeTown.enabled = YES;
            txtHomeState.enabled = YES;
            txtHomeCountry.hidden = YES;
            btnHomeCountry.hidden = NO;
            
            txtHomeState.enabled = NO;
            txtHomeState.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            
            
            
            [txtHomePostCode removeTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
            [txtHomePostCode removeTarget:self action:@selector(EditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
			
			
			
        }
        
    }
    
    else if (btnPressed.tag == 1) {
        
        if (checked2) {
            [btnForeignOffice setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
            checked2 = NO;
            
            txtOfficeAddr1.text=@"";
            txtOfficeAddr2.text=@"";
            txtOfficeAddr3.text=@"";
            
            txtOfficePostcode.text = @"";
            txtOfficeTown.text = @"";
            txtOfficeState.text = @"";
            txtOfficeCountry.text = @"";
            txtOfficeTown.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            txtOfficeState.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            txtOfficeCountry.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            txtOfficeTown.enabled = NO;
            txtOfficeState.enabled = NO;
            txtOfficeCountry.hidden = NO;
            btnOfficeCountry.hidden = YES;
            
            [txtOfficePostcode addTarget:self action:@selector(OfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
            [txtOfficePostcode addTarget:self action:@selector(OfficeEditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
        }
        else {
            [btnForeignOffice setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            checked2 = YES;
            
            txtOfficeAddr1.text = @"";
            txtOfficeAddr2.text = @"";
            txtOfficeAddr3.text = @"";
            
            txtOfficePostcode.text = @"";
            txtOfficeTown.text = @"";
            txtOfficeState.text = @"";
            [btnOfficeCountry setTitle:@"- SELECT -" forState:UIControlStateNormal];
            btnOfficeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            txtOfficeTown.backgroundColor = [UIColor whiteColor];
            txtOfficeState.backgroundColor = [UIColor whiteColor];
            txtOfficeCountry.backgroundColor = [UIColor whiteColor];
            txtOfficeTown.enabled = YES;
            txtOfficeState.enabled = YES;
            txtOfficeCountry.hidden = YES;
            btnOfficeCountry.hidden = NO;
            
            txtOfficeState.enabled = NO;
            txtOfficeState.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            
            [txtOfficePostcode removeTarget:self action:@selector(OfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
            [txtOfficePostcode removeTarget:self action:@selector(OfficeEditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
        }
        
    }
}
-(NSString*) getCountryCode : (NSString*)country
{
    NSString *code = @"";
    country = [country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT CountryCode FROM eProposal_Country WHERE CountryDesc = ?", country];
    
    while ([result next]) {
        code =[result objectForColumnName:@"CountryCode"];
        
    }
    
    [result close];
    [db close];
    
    return code;
    
}

-(void)btnSave_EditOrNew
{
	clickDone = 1;
    bool exist =  [self record_exist];
    if(exist)
    {
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"All changes will be updated to related SI, CFF and eApp. Do you want to proceed?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        [alert setTag:1004];
        [alert show];
        
        
    }
    else{
        
        [self btnSave];
    }
}

- (NSString*) getGroupID:(NSString*)groupname
{
    
    groupname = [groupname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *groupid = @"";
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    NSLog(@"groupname - %@",groupname);
    FMResultSet *result = [db executeQuery:@"SELECT id from prospect_groups WHERE name = ?", groupname];
    while ([result next]) {
        groupid =  [result stringForColumn:@"id"];
        
    }
    [result close];
    [result close];
    
    return groupid;
    
}

- (void)btnSave
{
    
    // [self OtherIDValidation];
    // [self IDValidation];
    
    
    NSLog(@"btnSave");
    [self.view endEditing:YES];
    [self resignFirstResponder];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    _OccupationList = Nil;
    NSString *strDOB = @"";
    NSString *othertype = @"";
    NSString *marital  = @"";
    NSString *race =@"";
    NSString *Rigdateoutlet = @"";
    NSString *religion = @"";
    NSString *nation  = @"";
    
    NSString *OffCountry = @"";
    NSString *HomeCountry = @"";
    NSString *RegNumber = @"";
    NSString *RegDate = @"";
    int counter = 0;
    
	
    if ([self Validation] == TRUE && DATE_OK == YES) {
        
        sqlite3_stmt *statement;
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            txtFullName.text = [txtFullName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            
            if (checked) {
                HomeCountry = btnHomeCountry.titleLabel.text;
                
                SelectedStateCode = txtHomeState.text;
            }
            else {
                HomeCountry = txtHomeCountry.text;
            }
            RegNumber = txtRigNO.text;
            //RegDate = txtRigDate.text;
            
            Rigdateoutlet = outletRigDate.titleLabel.text;
            if (checked2) {
                OffCountry = btnOfficeCountry.titleLabel.text;
                SelectedOfficeStateCode = txtOfficeState.text;
            }
            else {
                OffCountry = txtOfficeCountry.text;
            }
            
            
            if (txtDOB.text.length == 0) {
                strDOB = [outletDOB.titleLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            }
            else {
                strDOB = outletDOB.titleLabel.text;
            }
            
            if(gender == nil || gender==NULL)
                gender=@"";
			
			if (segGender.selectedSegmentIndex == -1) {
				gender = @"";
			}
			
            if(ClientSmoker == nil || ClientSmoker ==NULL)
                ClientSmoker=@"";
			
			if (segSmoker.selectedSegmentIndex == -1) {
				ClientSmoker=@"";
			}

            if(OccupCodeSelected == nil || OccupCodeSelected==NULL )
                OccupCodeSelected=@"";
            
            
            
            HomeCountry =  [self getCountryCode:HomeCountry];
            OffCountry =  [self getCountryCode:OffCountry];
            
            //NSString *title = [outletTitle.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            //			NSString *title = TitleCodeSelected;
            
			NSString *title = [outletTitle.titleLabel.text stringByTrimmingCharactersInSet:
							   [NSCharacterSet whitespaceCharacterSet]];
            //			[self PopulateTitle];
			
			
            marital = [outletMaritalStatus.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            nation = [outletNationality.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            
            race  = [outletRace.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
             Rigdateoutlet  = [outletRigDate.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            religion = [outletReligion.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            
            //othertype = [OtherIDType.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            //ENS: Save othertype with code
			othertype = IDTypeCodeSelected;
			if (IDTypeCodeSelected == NULL)
				othertype = @"";
			
			NSString *type = [OtherIDType.titleLabel.text stringByTrimmingCharactersInSet:
							  [NSCharacterSet whitespaceCharacterSet]];
			if (type.length != 0) {
				type = [self getOtherTypeCode:type];
				othertype = type;
			}
			
            
            strDOB = [strDOB stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
			
            
            NSString *insertSQL;
            
            NSString *group = outletGroup.titleLabel.text;
            
            //            if([group isEqualToString:@"- SELECT -"])
            //                group = @"";
            //
            //             group = [self getGroupID:group];
			group = @"";
            
            if([othertype isEqualToString:@"- SELECT -"])
                othertype = @"";
            
            if([title isEqualToString:@"- SELECT -"])
                title = @"";
            
            if([strDOB isEqualToString:@"- SELECT -"] || [strDOB isEqualToString:@"-SELECT-"])
                strDOB = @"";
			
            if ([strDOB isEqualToString:@""] && [textFields trimWhiteSpaces:txtDOB.text].length != 0 && ![[textFields trimWhiteSpaces:txtDOB.text] isEqualToString:@"- SELECT -"] && ![[textFields trimWhiteSpaces:txtDOB.text]isEqualToString:@"-SELECT-"]) {
				strDOB = [txtDOB.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
			}
			
            if([marital isEqualToString:@"- SELECT -"])
                marital = @"";
            
            if([race isEqualToString:@"- SELECT -"])
                race = @"";
            if([Rigdateoutlet isEqualToString:@"- SELECT -"])
                Rigdateoutlet = @"";
            
            if([religion isEqualToString:@"- SELECT -"])
                religion = @"";
            
            if([nation isEqualToString:@"- SELECT -"])
                nation = @"";
            
            if([nation isEqualToString:@"- SELECT -"])
                nation = @"";
            
            if([HomeCountry isEqualToString:@"(null)"]  || (HomeCountry == NULL))
                HomeCountry = @"";
            
            if([SelectedStateCode isEqualToString:@"(null)"]  || (SelectedStateCode == NULL))
                SelectedStateCode = @"";
			
			if([TitleCodeSelected isEqualToString:@"(null)"]  || (TitleCodeSelected == NULL))
                TitleCodeSelected = @"";
            
			if ([TitleCodeSelected isEqualToString:@""] && ![title isEqualToString:@""]) {
				TitleCodeSelected = [self getTitleCode:title];
			}
            
			NSString *isGrouping = @"";
			
			if (segIsGrouping.selectedSegmentIndex == 0) {
				isGrouping = @"Y";
				group = [self ProspectGroup_toString];
			}
			else {
				isGrouping = @"N";
				group = @"";
			}
            
			NSString *CountryOfBirth = @"";
			CountryOfBirth = btnCoutryOfBirth.titleLabel.text;
			CountryOfBirth = [self getCountryCode:CountryOfBirth];
            
            if(Update_record == YES)
            {
                
                
                //GET PP  CHANGES COUNTER
                
                FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
                [db open];
                FMResultSet *result = [db executeQuery:@"SELECT ProspectProfileChangesCounter from prospect_profile WHERE indexNo = ?", pp.ProspectID];
                while ([result next]) {
                    counter =  [result intForColumn:@"ProspectProfileChangesCounter"];
                    
                    // NSLog(@"si - %@  || pp.ProspectID-%@",si_name,pp.ProspectID);
                    
                }
                [result close];
                [result close];
                
                
                counter = counter+1;
                
                NSString *str_counter = [NSString stringWithFormat:@"%i",counter];
                
				NSString *prosID = prospectprofile.ProspectID;
				
				if (prospectprofile.ProspectID == Nil) {
					NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
					prospectprofile.ProspectID = [ClientProfile objectForKey:@"LastID"];
					prosID = [ClientProfile objectForKey:@"LastID"];
				}
				
                //				NSLog(@"ENS: idtype: %@, dob: %@, otherid: %@, title: %@ %@",othertype,strDOB, txtOtherIDType.text, TitleCodeSelected, title);
                
				if ([db close]) {
					[db open];
				}
				NSLog(@"gender %@", gender);
				
                insertSQL = [NSString stringWithFormat:
                             @"UPDATE prospect_profile set \"ProspectName\"=\'%@\', \"ProspectDOB\"=\"%@\",\"GST_registered\"=\"%@\",\"GST_registrationNo\"=\"%@\",\"GST_registrationDate\"=\"%@\",\"GST_exempted\"=\"%@\", \"ProspectGender\"=\"%@\", \"ResidenceAddress1\"=\"%@\", \"ResidenceAddress2\"=\"%@\", \"ResidenceAddress3\"=\"%@\", \"ResidenceAddressTown\"=\"%@\", \"ResidenceAddressState\"=\"%@\", \"ResidenceAddressPostCode\"=\"%@\", \"ResidenceAddressCountry\"=\"%@\", \"OfficeAddress1\"=\"%@\", \"OfficeAddress2\"=\"%@\", \"OfficeAddress3\"=\"%@\", \"OfficeAddressTown\"=\"%@\",\"OfficeAddressState\"=\"%@\", \"OfficeAddressPostCode\"=\"%@\", \"OfficeAddressCountry\"=\"%@\", \"ProspectEmail\"= \"%@\", \"ProspectOccupationCode\"=\"%@\", \"ExactDuties\"=\"%@\", \"ProspectRemark\"=\"%@\", \"DateModified\"=%@,\"ModifiedBy\"=\"%@\", \"ProspectGroup\"=\"%@\", \"ProspectTitle\"=\"%@\", \"IDTypeNo\"=\"%@\", \"OtherIDType\"=\"%@\", \"OtherIDTypeNo\"=\"%@\", \"Smoker\"=\"%@\", \"AnnualIncome\"=\"%@\", \"BussinessType\"=\"%@\", \"Race\"=\"%@\", \"MaritalStatus\"=\"%@\", \"Nationality\"=\"%@\", \"Religion\"=\"%@\",\"ProspectProfileChangesCounter\"=\"%@\", \"Prospect_IsGrouping\"=\"%@\", \"CountryOfBirth\"=\"%@\" where IndexNo = \"%@\" "
                             "", txtFullName.text, strDOB, GSTRigperson, txtRigNO.text, Rigdateoutlet,GSTRigExempted,gender, txtHomeAddr1.text, txtHomeAddr2.text, txtHomeAddr3.text, txtHomeTown.text, SelectedStateCode, txtHomePostCode.text, HomeCountry, txtOfficeAddr1.text, txtOfficeAddr2.text, txtOfficeAddr3.text, txtOfficeTown.text, SelectedOfficeStateCode, txtOfficePostcode.text, OffCountry, txtEmail.text, OccupCodeSelected, txtExactDuties.text, txtRemark.text, @"datetime(\"now\", \"+8 hour\")", @"1", group, TitleCodeSelected, txtIDType.text, othertype, txtOtherIDType.text, ClientSmoker, txtAnnIncome.text, txtBussinessType.text, race, marital, nation, religion, str_counter,isGrouping, CountryOfBirth, prosID];

            }
            else {
                insertSQL = [NSString stringWithFormat:
                             @"INSERT INTO prospect_profile(\'ProspectName\', \"ProspectDOB\", \"GST_registered\", \"GST_registrationNo\", \"GST_registrationDate\", \"GST_exempted\",\"ProspectGender\", \"ResidenceAddress1\", \"ResidenceAddress2\", \"ResidenceAddress3\", \"ResidenceAddressTown\", \"ResidenceAddressState\",\"ResidenceAddressPostCode\", \"ResidenceAddressCountry\", \"OfficeAddress1\", \"OfficeAddress2\", \"OfficeAddress3\",\"OfficeAddressTown\", \"OfficeAddressState\", \"OfficeAddressPostCode\", \"OfficeAddressCountry\", \"ProspectEmail\",\"ProspectOccupationCode\", \"ExactDuties\", \"ProspectRemark\", \"DateCreated\", \"CreatedBy\", \"DateModified\",\"ModifiedBy\", \"ProspectGroup\", \"ProspectTitle\", \"IDTypeNo\", \"OtherIDType\", \"OtherIDTypeNo\", \"Smoker\", \"AnnualIncome\", \"BussinessType\", \"Race\", \"MaritalStatus\", \"Religion\", \"Nationality\", \"QQFlag\",\"ProspectProfileChangesCounter\",\"prospect_IsGrouping\", \"CountryOfBirth\") "
                             "VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\",\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", %@, \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%s\",\"%@\",\"%@\", \"%@\")", txtFullName.text, strDOB, GSTRigperson, txtRigNO.text, Rigdateoutlet,GSTRigExempted,gender, txtHomeAddr1.text, txtHomeAddr2.text, txtHomeAddr3.text, txtHomeTown.text, SelectedStateCode, txtHomePostCode.text, HomeCountry, txtOfficeAddr1.text, txtOfficeAddr2.text, txtOfficeAddr3.text, txtOfficeTown.text, SelectedOfficeStateCode, txtOfficePostcode.text, OffCountry, txtEmail.text, OccupCodeSelected, txtExactDuties.text, txtRemark.text,
                             @"datetime(\"now\", \"+8 hour\")", @"1", @"", @"1", group, TitleCodeSelected , txtIDType.text, othertype, txtOtherIDType.text, ClientSmoker, txtAnnIncome.text, txtBussinessType.text,race,marital,religion,nation,"false",@"1", isGrouping, CountryOfBirth];
                
            }
            
//            NSLog(@"insertSQL insertSQL %@",insertSQL);
			
			
            const char *insert_stmt = [insertSQL UTF8String];
            if(sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    [self GetLastID];
                    
                } else {
                    
                    UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" " message:@"Fail in inserting into profile table" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [failAlert show];
                }
                sqlite3_finalize(statement);
            }
            else {
                
                NSLog(@"Error Statement");
            }
            sqlite3_close(contactDB);
            
            insertSQL = Nil, insert_stmt = Nil;
        }
        else {
            NSLog(@"Error Open");
        }
        
        statement = Nil;
        dbpath = Nil;
        
        
    }
    else
        NSLog(@"Either validation return false or 'DATE_OK' =  NO");
    
    
    PostcodeContinue = TRUE;
    
    
    
    
    //******** START ****************  UPDATE CLIENT OF LA1, LA2, PO IN EAPP   *********************************
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    
    FMResultSet *result = [db executeQuery:@"SELECT COUNT(*) as COUNT FROM eProposal_LA_Details WHERE ProspectProfileID = ? AND POFlag = 'N'", prospectprofile.ProspectID];
    
    
    
    while ([result next]) {
        
        int count = [result intForColumn:@"COUNT"];
        
        
        
        if(count > 0 )
            
        {
            
            NSString *str_counter = [NSString stringWithFormat:@"%i",counter];
            
            NSString *contact1 =  [NSString stringWithFormat:@"%@%@",txtPrefix1.text, txtContact1.text ];
            NSString *contact2 =  [NSString stringWithFormat:@"%@%@",txtPrefix2.text, txtContact2.text ];
            NSString *contact3 =  [NSString stringWithFormat:@"%@%@",txtPrefix3.text, txtContact3.text ];
            NSString *contact4 =  [NSString stringWithFormat:@"%@%@",txtPrefix4.text, txtContact4.text ];
            
            
            
            
            [db executeUpdate:@"Update eProposal_LA_Details SET \"LATitle\" = \"%@\", \"LAName\" = \"%@\", \"LASex\" = \"%@\", \"LADOB\" = \"%@\", \"LANewICNO\" = \"%@\", \"LAOtherIDType\" = \"%@\", \"LAOtherID\" = \"%@\", \"LAMaritalStatus\" = \"%@\", \"LARace\" = \"%@\", \"LAReligion\" = \"%@\", \"LANationality\" = \"%@\", \"LAOccupationCode\" = \"%@\", \"LAExactDuties\" = \"%@\", \"LATypeOfBusiness\" = \"%@\", \"ResidenceAddress1\" = \"%@\", \"ResidenceAddress2\" = \"%@\", \"ResidenceAddress3\" = \"%@\", \"ResidenceTown\" = \"%@\", \"ResidenceState\" = \"%@\", \"ResidencePostcode\" = \"%@\", \"ResidenceCountry\" = \"%@\", \"OfficeAddress1\" = \"%@\", \"OfficeAddress2\" = \"%@\", \"OfficeAddress3\" = \"%@\", \"OfficeTown\" = \"%@\", \"OfficeState\" = \"%@\", \"OfficePostcode\" = \"%@\", \"OfficeCountry\" = \"%@\", \"ResidencePhoneNo\" = \"%@\", \"OfficePhoneNo\" = \"%@\", \"FaxPhoneNo\" = \"%@\", \"MobilePhoneNo\" = \"%@\", \"EmailAddress\" = \"%@\", \"LASmoker\" = \"%@\", \"ProspectProfileChangesCounter\" = \"%@\" WHERE  ProspectProfileID = \"%@\";",
             
			 TitleCodeSelected,
             txtFullName.text,
             gender,
             strDOB,
             txtIDType.text,
             othertype,
             txtOtherIDType.text,
             
             marital,
             race,
             religion,
             nation,
             OccupCodeSelected,
             txtExactDuties.text,
             txtBussinessType.text,
             
             txtHomeAddr1.text,
             txtHomeAddr2.text,
             txtHomeAddr3.text,
             
             txtHomeTown.text,
             SelectedStateCode,
             txtHomePostCode.text,
             HomeCountry,
             
             txtOfficeAddr1.text,
             txtOfficeAddr2.text,
             txtOfficeAddr3.text,
             txtOfficeTown.text,
             SelectedOfficeStateCode,
             txtOfficePostcode.text,
             OffCountry,
             
             contact1,
             contact2,
             contact3,
             contact4,
             txtEmail.text,
             ClientSmoker,
             str_counter,
             prospectprofile.ProspectID];
            
            
        }
    }
    
    
    [db close];
    
    //********* END ***************  UPDATE CLIENT OF LA1, LA2, PO IN EAPP   *********************************
    
    
}


- (IBAction)addNewGroup:(id)sender
{
	//    UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:@" " message:@"Enter Group Name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
	//    [dialog setAlertViewStyle:UIAlertViewStylePlainTextInput];
	//
	//    [[dialog textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeDefault];
	//    [dialog setTag:1001];
	//    [dialog show];
	
	UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MengCheong_Storyboard_eApp" bundle:nil];
	ProspectViewController *groupPage = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ClientGroup"];
	
	[UDGroup setObject:pp.ProspectGroup forKey:@"Group"];
	[UDGroup setObject:@"00" forKey:@"ProspectID"];
	[UDGroup setObject:txtFullName.text forKey:@"ProspectName"];
	[UDGroup setObject:@"Add" forKey:@"Mode"];
	
	[self presentModalViewController:groupPage animated:YES];
}

- (IBAction)ViewGroup:(id)sender {
	UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MengCheong_Storyboard_eApp" bundle:nil];
	ProspectViewController *groupPage = [secondStoryBoard instantiateViewControllerWithIdentifier:@"GroupViewVC"];
	
	[UDGroup setObject:pp.ProspectGroup forKey:@"Group"];
	[UDGroup setObject:@"00" forKey:@"ProspectID"];
	[UDGroup setObject:txtFullName.text forKey:@"ProspectName"];
	[UDGroup setObject:@"Add" forKey:@"Mode"];
	
	[self presentModalViewController:groupPage animated:YES];
	
}

- (IBAction)ActionIsGrouping:(id)sender {
	
	if (segIsGrouping.selectedSegmentIndex == 0) {
		btnAddGroup.enabled = YES;
		btnAddGroup.alpha = 1.0;
//		btnViewGroup.enabled = YES;
	}
	else {
		btnAddGroup.enabled = NO;
		btnAddGroup.alpha = 0.5;
//		btnViewGroup.enabled = NO;
	}
}

-(NSString *) ProspectGroup_toString {
	
	
	NSMutableArray *ProsGroupArr = [UDGroup objectForKey:@"groupArr"];
	
	
	NSString * prosGroup2 = @"";
	NSString *GroupID = @"";
	if (ProsGroupArr.count != 0) {
		for (int b=0; b <= ProsGroupArr.count-1; b++) {
			
			NSLog(@"b: %d, ID: %@, group name: %@", b, [[ProsGroupArr objectAtIndex:b] objectForKey:@"id"], [[ProsGroupArr objectAtIndex:b] objectForKey:@"name"]);
			
			if (b==0) {
				if ([[[ProsGroupArr objectAtIndex:b] objectForKey:@"id"] isEqualToString:@"00"]) {
					GroupID = [self SaveToGroup:[[ProsGroupArr objectAtIndex:b] objectForKey:@"name"]];
				}
				else
					GroupID = [[ProsGroupArr objectAtIndex:b] objectForKey:@"id"];
				
				prosGroup2 = [NSString stringWithFormat:@"%@", GroupID];
			}
			else {
				
				if ([[[ProsGroupArr objectAtIndex:b] objectForKey:@"id"] isEqualToString:@"00"]) {
					GroupID = [self SaveToGroup:[[ProsGroupArr objectAtIndex:b] objectForKey:@"name"]];
				}
				else
					GroupID = [[ProsGroupArr objectAtIndex:b] objectForKey:@"id"];
				
				prosGroup2 = [NSString stringWithFormat:@"%@,%@", prosGroup2, GroupID];
			}
		}
		
		NSLog(@"prosGroup %@", prosGroup2);
	}
	else
		return @"";
	
	return prosGroup2;
}

-(NSString *) SaveToGroup: (NSString *) prosGroup {
	NSString *pID;
	NSString *Trim_GroupName = [prosGroup stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	FMDatabase *db;
	
	if (!db) {
		NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *docsDir = [dirPaths objectAtIndex:0];
		NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
		db = [FMDatabase databaseWithPath:dbPath];
	}
	if ([db close]) {
		[db open];
	}
	
	
	[db executeUpdate:[NSString stringWithFormat:@"INSERT INTO prospect_groups (name) values ('%@')", Trim_GroupName]];
	
	FMResultSet *result = [db executeQuery:@"select seq from sqlite_sequence where name = 'prospect_groups'"];
	while ([result next]) {
		pID = [result stringForColumn:@"seq"];
	}
	
	return pID;
}


- (IBAction)actionHomeCountry:(id)sender
{
    isHomeCountry = YES;
    isOffCountry = NO;
	
    [self resignFirstResponder];
    [self.view endEditing:YES];
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isNew"];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    //  if (_CountryList == nil) {
    self.CountryList = [[Country alloc] initWithStyle:UITableViewStylePlain];
    _CountryList.delegate = self;
    self.CountryListPopover = [[UIPopoverController alloc] initWithContentViewController:_CountryList];
    //  }
    
    
    [self.CountryListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)actionMaritalStatus:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isNew"];
    
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


- (IBAction)actionNationality:(id)sender
{
    
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isNew"];
	
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if (_nationalityList == nil) {
        self.nationalityList = [[Nationality alloc] initWithStyle:UITableViewStylePlain];
        _nationalityList.delegate = self;
        self.nationalityPopover = [[UIPopoverController alloc] initWithContentViewController:_nationalityList];
    }
    
    //CGRect butt = [sender frame];
    //int y = butt.origin.y - 44;
    //butt.origin.y = y;
    [self.nationalityPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


- (IBAction)actionRace:(id)sender
{
    
    [self resignFirstResponder];
    [self.view endEditing:YES];
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isNew"];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if (_raceList == nil) {
        self.raceList = [[Race alloc] initWithStyle:UITableViewStylePlain];
        _raceList.delegate = self;
        self.raceListPopover = [[UIPopoverController alloc] initWithContentViewController:_raceList];
    }
    
    
    [self.raceListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
- (IBAction)ActionforRigdate:(id)sender {
    
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
	isDOBDate = NO;
	isGSTDate = YES;
	
    NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isNew"];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    

    
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    //_dobLbl.text = dateString;
	txtRigDate.textColor = [UIColor blackColor];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    
    if (_SIDate == Nil) {
        
        self.SIDate = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIDate"];
        _SIDate.delegate = self;
        self.SIDatePopover = [[UIPopoverController alloc] initWithContentViewController:_SIDate];
    }
    
    [self.SIDatePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.SIDatePopover presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    
    dateFormatter = Nil;
    dateString = Nil, mainStoryboard = nil;
    
    RegDatehandling =NO;
}


- (IBAction)actionReligion:(id)sender
{
    
    [self resignFirstResponder];
    [self.view endEditing:YES];
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isNew"];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if (_ReligionList == nil) {
        self.ReligionList = [[Religion alloc] initWithStyle:UITableViewStylePlain];
        _ReligionList.delegate = self;
        self.ReligionListPopover = [[UIPopoverController alloc] initWithContentViewController:_ReligionList];
    }
    
    
    [self.ReligionListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
}





- (IBAction)actionOfficeCountry:(id)sender
{
    isOffCountry = YES;
    isHomeCountry = NO;
	
    [self resignFirstResponder];
    [self.view endEditing:YES];
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isNew"];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    // if (_CountryList == nil) {
    self.CountryList = [[Country alloc] initWithStyle:UITableViewStylePlain];
    _CountryList.delegate = self;
    self.CountryListPopover = [[UIPopoverController alloc] initWithContentViewController:_CountryList];
    // }
    
    
    [self.CountryListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)actionCountryOfBirth:(id)sender
{

    [self resignFirstResponder];
    [self.view endEditing:YES];
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isNew"];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    self.Country2List = [[Country2 alloc] initWithStyle:UITableViewStylePlain];
    _Country2List.delegate = self;
    self.Country2ListPopover = [[UIPopoverController alloc] initWithContentViewController:_Country2List];
    
    [self.Country2ListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)btnGroup:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if (_GroupList == nil) {
        
        self.GroupList = [[GroupClass alloc] initWithStyle:UITableViewStylePlain];
        _GroupList.delegate = self;
        self.GroupPopover = [[UIPopoverController alloc] initWithContentViewController:_GroupList];
    }
    
    
    [self.GroupPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}

- (IBAction)btnTitle:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isNew"];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if (_TitlePicker == nil) {
        _TitlePicker = [[TitleViewController alloc] initWithStyle:UITableViewStylePlain];
        _TitlePicker.delegate = self;
        self.TitlePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_TitlePicker];
    }
    
    
    [self.TitlePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSString *indexNo;
    if (alertView.tag == 1) {
        if (_delegate != Nil) {
            [_delegate FinishInsert ];
        }
        
        [self resignFirstResponder];
        [self.view endEditing:YES];
        [self.navigationController popViewControllerAnimated:YES];
        
        //		NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
        //		[ClientProfile setObject:@"YES" forKey:@"isNew"];
        
        
    }
    else if(alertView.tag == 80)
    {
        [txtFullName becomeFirstResponder];
    }
    else if(alertView.tag == 81 || alertView.tag == 82)
    {
        [txtOtherIDType becomeFirstResponder];
    }
    else if(alertView.tag == 83)
    {
        outletDOB.titleLabel.textColor = [UIColor redColor];
    }
    else if(alertView.tag == 84)
    {
        outletOccup.titleLabel.textColor = [UIColor redColor];
    }
    
    
    
    else if ((alertView.tag == 2000 || alertView.tag == 2001) && buttonIndex == 0) {
        [txtHomePostCode becomeFirstResponder];
    }
    else if ((alertView.tag == 3000 || alertView.tag == 3001) && buttonIndex == 0) {
        [txtOfficePostcode becomeFirstResponder];
        
        [myScrollView setContentOffset:CGPointMake(0,70) animated:YES];
    }
    else if (alertView.tag == 1001 && buttonIndex == 1) {
        
        NSString *str = [NSString stringWithFormat:@"%@",[[alertView textFieldAtIndex:0]text] ];
        if (str.length != 0) {
            
            NSMutableArray *array = [[NSMutableArray alloc] init];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsPath = [paths objectAtIndex:0];
            NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"dataGroup.plist"];
            [array addObjectsFromArray:[NSArray arrayWithContentsOfFile:plistPath]];
            
            FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
            [db open];
            FMResultSet *result = [db executeQuery:@"select * from prospect_groups"];
            [array removeAllObjects];
            while ([result next]) {
                [array addObject:[result objectForColumnName:@"name"]];
            }
            
            BOOL Found = NO;
            
            for (NSString *existing in array) {
                
                if ([str isEqualToString:existing]) {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Group already exist" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                    [alert show];
                    
                    Found = YES;
                    break;
                }
            }
            
            if (!Found) {
                
                [array addObject:str];
                [array writeToFile:plistPath atomically: TRUE];
                
                [db executeUpdate:@"insert into prospect_groups (name) values (?)", str, nil];
                
                outletGroup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [outletGroup setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",str]forState:UIControlStateNormal];
            }
            [result close];
            [db close];
            
        }
        else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please insert data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            [alert show];
        }
    }
    else if (alertView.tag == 1002 || alertView.tag == 1003 ) {
        [txtIDType becomeFirstResponder];
    }
    
    else if(alertView.tag == 1004 && buttonIndex == 0)
    {
        [self btnSave];
        
        
    }
    else if(alertView.tag == 1004 && buttonIndex == 1)
    {
        NSLog(@"NO UPDATE");
		
        
    }
    
    else if (alertView.tag == 1005) {
        
        outletNationality.titleLabel.textColor = [UIColor redColor];
    }
    
    else if (alertView.tag == 1006) {
        
        outletTitle.titleLabel.textColor = [UIColor redColor];
    }
    else if (alertView.tag == 1007) {
        
        [txtExactDuties becomeFirstResponder];
    }
    
    else if (alertView.tag == 1008) {
        
        
        [txtAnnIncome becomeFirstResponder];
        [myScrollView setContentOffset:CGPointMake(0,400) animated:YES];
    }
    else if (alertView.tag == 1009) {
        
        outletMaritalStatus.titleLabel.textColor = [UIColor redColor];
    }
    
    else if (alertView.tag == 1010) {
        
        outletRace.titleLabel.textColor = [UIColor redColor];
    }
    else if (alertView.tag == 1011) {
        
        outletReligion.titleLabel.textColor = [UIColor redColor];
    }
    else if (alertView.tag == 1012) {
        
        [txtHomeAddr1 becomeFirstResponder];
    }
	else if (alertView.tag == 1013) {
        
        btnCoutryOfBirth.titleLabel.textColor = [UIColor redColor];
    }
    
    else if (alertView.tag == 2002) {
        
        [txtOfficeAddr1 becomeFirstResponder];
    }
    
    else if (alertView.tag == 2003) {
        
        [txtPrefix1 becomeFirstResponder];
        [myScrollView setContentOffset:CGPointMake(0,200) animated:YES];
    }
    else if(alertView.tag == 2004)
    {
        [txtContact1 becomeFirstResponder];
        [myScrollView setContentOffset:CGPointMake(0,200) animated:YES];
    }
    else if(alertView.tag == 2005)
    {
        [txtPrefix2 becomeFirstResponder];
        [myScrollView setContentOffset:CGPointMake(0,200) animated:YES];
    }
    else if(alertView.tag == 2006)
    {
        [txtContact2 becomeFirstResponder];
        [myScrollView setContentOffset:CGPointMake(0,200) animated:YES];
    }
    else if(alertView.tag == 2007)
    {
        [txtPrefix3 becomeFirstResponder];
        [myScrollView setContentOffset:CGPointMake(0,250) animated:YES];
    }
    else if(alertView.tag == 2008)
    {
        [txtContact3 becomeFirstResponder];
        [myScrollView setContentOffset:CGPointMake(0,250) animated:YES];
    }
    else if(alertView.tag == 2009)
    {
        [txtPrefix4 becomeFirstResponder];
        [myScrollView setContentOffset:CGPointMake(0,250) animated:YES];
    }
    else if(alertView.tag == 2010)
    {
        [txtContact4 becomeFirstResponder];
        [myScrollView setContentOffset:CGPointMake(0,250) animated:YES];
    }
    else if(alertView.tag == 2050)
    {
        [txtEmail becomeFirstResponder];
        [myScrollView setContentOffset:CGPointMake(0,350) animated:YES];
    }
    else if(alertView.tag == 2060)
    {
        [txtBussinessType becomeFirstResponder];
        [myScrollView setContentOffset:CGPointMake(0,400) animated:YES];
    }
    
    else if(alertView.tag == 5000) //YES
    {
        bool exist =  [self record_exist];
        if(buttonIndex == 0) //YES
        {
            if(IC_Hold_Alert || OTHERID_Hold_Alert)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Customer profile has been created using this ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag = 6000;
                [alert show];
                
                IC_Hold_Alert = NO;
                OTHERID_Hold_Alert = NO;
				
				NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
				[ClientProfile setObject:@"NO" forKey:@"isNew"];
                
            }
            else if(exist)
            {
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"All changes will be updated to related SI, CFF and eApp. Do you want to proceed?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
                [alert setTag:1004];
                [alert show];
                
                
            }
            else
            {
                
                
                [self btnSave];
                
            }
        }
        
        else
        {
            
            // [txtIDType removeTarget:self action:@selector(NewICDidChange:) forControlEvents:UIControlEventEditingDidEnd];
            
            [self resignFirstResponder];
            [self.view endEditing:YES];
            [self.navigationController popViewControllerAnimated:YES];
			
			NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
			[ClientProfile setObject:@"NO" forKey:@"isNew"];
            
        }
        
    }
    
    else if(alertView.tag == 5001)
    {
        btnHomeCountry.titleLabel.textColor = [UIColor redColor];
    }
    else if(alertView.tag == 5002)
    {
        btnOfficeCountry.titleLabel.textColor = [UIColor redColor];
    }
    
    else if(alertView.tag == 6000)
    {
        
        self.navigationItem.title = @"Edit Client Profile";
        
        
        txtIDType.text = [txtIDType.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceCharacterSet]];
        
        if(txtIDType.text.length ==12)
            
            [self getSameIDRecord:@"IC" :getSameRecord_Indexno ];
        else
            [self getSameIDRecord:@"OTHERID" :getSameRecord_Indexno];
        
        
        [self displaySameRecord];
        
        
    }
    
}
-(void) displaySameRecord

{
    
    
    
    Update_record = YES;
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"Update_record"];
    txtExactDuties.delegate= self;
    
    prospectprofile.OtherIDType = [prospectprofile.OtherIDType uppercaseString];
    
    // strChanges = @"No";
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    prospectprofile.ProspectTitle = [prospectprofile.ProspectTitle stringByTrimmingCharactersInSet:
                                     [NSCharacterSet whitespaceCharacterSet]];
    
    if (!(prospectprofile.ProspectGroup == NULL || [prospectprofile.ProspectGroup isEqualToString:@"- SELECT -"])) {
        
        [outletGroup setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", prospectprofile.ProspectGroup]forState:UIControlStateNormal];
        outletGroup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    else {
        [outletGroup setTitle:@"- SELECT -" forState:UIControlStateNormal];
    }
	
	//BirthCountry
	NSString *COB = @"";
	if (![prospectprofile.countryOfBirth isEqualToString:@"(null)"] && prospectprofile.countryOfBirth != NULL && ![prospectprofile.countryOfBirth isEqualToString:@""]) {
        COB = [self getCountryDesc:prospectprofile.countryOfBirth];
        prospectprofile.countryOfBirth =   [self getCountryDesc:prospectprofile.countryOfBirth];
			
		[btnCoutryOfBirth setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", prospectprofile.countryOfBirth]forState:UIControlStateNormal];
        btnCoutryOfBirth.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    else {
         [btnCoutryOfBirth setTitle:@"- SELECT -" forState:UIControlStateNormal];
    }
	
	
    
    if (!(prospectprofile.ProspectTitle == NULL || [prospectprofile.ProspectTitle isEqualToString:@"- SELECT -"])) {
        //[outletTitle setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", prospectprofile.ProspectTitle]forState:UIControlStateNormal];
        
        // [outletTitle setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", prospectprofile.ProspectTitle]forState:UIControlStateNormal];
        [outletTitle setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", [self getTitleDesc:prospectprofile.ProspectTitle]]forState:UIControlStateNormal];
        
		//outletTitle.titleLabel.text = [self getTitleDesc:prospectprofile.ProspectTitle];
        outletTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    else {
        [outletTitle setTitle:@"- SELECT -" forState:UIControlStateNormal];
    }
    if (!(prospectprofile.Race == NULL || [prospectprofile.Race isEqualToString:@"- SELECT -"])) {
        [outletRace setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", prospectprofile.Race]forState:UIControlStateNormal];
        outletRace.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    else {
        [outletRace setTitle:@"- SELECT -" forState:UIControlStateNormal];
    }
    
    if (!(prospectprofile.registrationDate == NULL || [prospectprofile.registrationDate isEqualToString:@"- SELECT -"])) {
        [outletRigDate setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", prospectprofile.registrationDate]forState:UIControlStateNormal];
        outletRigDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    else {
        [outletRigDate setTitle:@"- SELECT -" forState:UIControlStateNormal];
    }
    
    if (!(prospectprofile.MaritalStatus == NULL || [prospectprofile.MaritalStatus isEqualToString:@"- SELECT -"])) {
        [outletMaritalStatus setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", prospectprofile.MaritalStatus]forState:UIControlStateNormal];
        outletMaritalStatus.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    else {
        [outletMaritalStatus setTitle:@"- SELECT -" forState:UIControlStateNormal];
    }
    
    if (!(prospectprofile.Religion == NULL || [prospectprofile.Religion isEqualToString:@"- SELECT -"])) {
        [outletReligion setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", prospectprofile.Religion]forState:UIControlStateNormal];
        outletReligion.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    else {
        [outletReligion setTitle:@"- SELECT -" forState:UIControlStateNormal];
    }
    if (!(prospectprofile.Nationality == NULL || [prospectprofile.Nationality isEqualToString:@"- SELECT -"])) {
        [outletNationality setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", prospectprofile.Nationality]forState:UIControlStateNormal];
        outletNationality.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    else {
        [outletNationality setTitle:@"- SELECT -" forState:UIControlStateNormal];
    }
    
    if (!(prospectprofile.OtherIDType == NULL || [prospectprofile.OtherIDType isEqualToString:@"- SELECT -"] || [prospectprofile.OtherIDType isEqualToString:@"(NULL)"])) {
        
        [OtherIDType setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", prospectprofile.OtherIDType]forState:UIControlStateNormal];
        txtOtherIDType.text = prospectprofile.OtherIDTypeNo;
        
        
        OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        //for company case
        if ([[prospectprofile.OtherIDType stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"COMPANYREGISTRATIONNUMBER"] || [prospectprofile.OtherIDType isEqualToString:@"CR"]) {
            
            companyCase = YES;
            outletOccup.enabled = NO;
            segSmoker.enabled = NO;
            segSmoker.selectedSegmentIndex = UISegmentedControlNoSegment;
            
            segGender.enabled = NO;
            segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
            
            
            outletRace.enabled = NO;
            outletRace.titleLabel.textColor = [UIColor grayColor];
            outletMaritalStatus.enabled = NO;
            outletMaritalStatus.titleLabel.textColor = [UIColor grayColor];
            outletReligion.enabled = NO;
            outletReligion.titleLabel.textColor = [UIColor grayColor];
            outletNationality.enabled = NO;
            outletNationality.titleLabel.textColor = [UIColor grayColor];
            
            outletTitle.enabled = NO;
			[outletTitle setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
            outletTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            outletTitle.titleLabel.textColor =  [UIColor grayColor];
            
            //annual income
            
            txtAnnIncome.text = prospectprofile.AnnualIncome;
            
            txtAnnIncome.enabled = TRUE;
            txtAnnIncome.backgroundColor = [UIColor whiteColor];
            
            txtDOB.hidden = YES;
            [outletDOB setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
            outletDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            outletDOB.titleLabel.textColor = [UIColor grayColor];
            
            segGender.enabled = NO;
            txtDOB.enabled = FALSE;
            
            
            
            //OCCUPATION
            outletOccup.enabled = NO;
            outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [outletOccup setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
            outletOccup.titleLabel.textColor = [UIColor grayColor];
            
            
            
        }
        else {
            companyCase = NO;
            outletOccup.enabled = YES;
        }
        
        
    }
    else {
        [self.OtherIDType setTitle:@"- SELECT -" forState:UIControlStateNormal];
        txtOtherIDType.text = @"";
        
        
    }
    
    
    
    if ([prospectprofile.IDTypeNo isEqualToString:@""] || prospectprofile.IDTypeNo == NULL) {
        
        prospectprofile.IDTypeNo = @"";
        
        
        [outletDOB setTitle:[[NSString stringWithFormat:@" "]stringByAppendingFormat:@"%@",prospectprofile.ProspectDOB] forState:UIControlStateNormal];
        outletDOB.hidden = NO;
        if ([[prospectprofile.OtherIDType stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"COMPANYREGISTRATIONNUMBER"])
            segGender.enabled = NO;
        else
            segGender.enabled = YES;
        txtDOB.hidden = YES;
        
        
        
        
        
        //  txtIDType.backgroundColor = [UIColor whiteColor];
        //    txtIDType.enabled = YES;
        
    }
    else {
        txtIDType.text = prospectprofile.IDTypeNo;
        
        
        txtIDType.enabled = NO;
        
        
        txtIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        
        txtDOB.text = prospectprofile.ProspectDOB;
        
        segGender.enabled = NO;
    }
    
    //HOME ADD - Eliminate "null" value
    if ([prospectprofile.OtherIDTypeNo isEqualToString:@"(NULL)"] || prospectprofile.OtherIDTypeNo == NULL) {
        txtOtherIDType.text = @"";
    }
    else {
        txtOtherIDType.text = prospectprofile.OtherIDTypeNo;
        
    }
    
    
    
    if (![prospectprofile.ResidenceAddress1 isEqualToString:@"(NULL)"] || prospectprofile.ResidenceAddress1 != NULL) {
        txtHomeAddr1.text = prospectprofile.ResidenceAddress1;
    }
    else {
        txtHomeAddr1.text = @"";
    }
    
    
    if (![prospectprofile.ResidenceAddress2 isEqualToString:@"(null)"] || prospectprofile.ResidenceAddress2 != NULL) {
        txtHomeAddr2.text = prospectprofile.ResidenceAddress2;
    }
    else {
        txtHomeAddr2.text = @"";
    }
    
    if (![prospectprofile.ResidenceAddress3 isEqualToString:@"(null)"] || prospectprofile.ResidenceAddress3 != NULL) {
        txtHomeAddr3.text = prospectprofile.ResidenceAddress3;
    }
    else {
        txtHomeAddr3.text = @"";
    }
    
    if (![prospectprofile.ResidenceAddressCountry isEqualToString:@"(null)"] || prospectprofile.ResidenceAddressCountry != NULL) {
        txtHomeCountry.text = [self getCountryDesc:prospectprofile.ResidenceAddressCountry];
        prospectprofile.ResidenceAddressCountry =   [self getCountryDesc:prospectprofile.ResidenceAddressCountry];
    }
    else {
        txtHomeCountry.text = @"";
    }
    
    
    if (![prospectprofile.ResidenceAddressPostCode isEqualToString:@"(null)"] || prospectprofile.ResidenceAddressPostCode != NULL) {
        txtHomePostCode.text = prospectprofile.ResidenceAddressPostCode;
    }
    else {
        txtHomeCountry.text = @"";
    }
    
    if (![prospectprofile.ResidenceAddressTown isEqualToString:@"(null)"] || prospectprofile.ResidenceAddressTown != NULL) {
        txtHomeTown.text = prospectprofile.ResidenceAddressTown;
    }
    else {
        txtHomeTown.text = @"";
    }
    
    
    
    //Office Add  - Eliminate "null" value
    
    
    if (![prospectprofile.OfficeAddress1 isEqualToString:@"(null)"] || prospectprofile.OfficeAddress1 != NULL) {
        txtOfficeAddr1.text = prospectprofile.OfficeAddress1;
    }
    else {
        txtOfficeAddr1.text = @"";
    }
    
    if (![prospectprofile.OfficeAddress2 isEqualToString:@"(null)"] || prospectprofile.OfficeAddress2 != NULL ) {
        txtOfficeAddr2.text = prospectprofile.OfficeAddress2;
    }
    else {
        txtOfficeAddr2.text = @"";
    }
    
    
    if (![prospectprofile.OfficeAddress3 isEqualToString:@"(null)"] || prospectprofile.OfficeAddress3 != NULL) {
        txtOfficeAddr3.text = prospectprofile.OfficeAddress3;
    }
    else {
        txtOfficeAddr3.text = @"";
    }
    
    if (![prospectprofile.OfficeAddressPostCode isEqualToString:@"(null)"] || prospectprofile.OfficeAddressPostCode != NULL) {
        txtOfficePostcode.text = prospectprofile.OfficeAddressPostCode;
    }
    else {
        txtOfficePostcode.text = @"";
    }
    
    
    if (![prospectprofile.OfficeAddressCountry isEqualToString:@"(null)"] || prospectprofile.OfficeAddressCountry != NULL) {
        txtOfficeCountry.text = [self getCountryDesc:prospectprofile.OfficeAddressCountry];
        
        prospectprofile.OfficeAddressCountry =   [self getCountryDesc:prospectprofile.OfficeAddressCountry];
        
    }
    else {
        txtOfficeCountry.text = @"";
    }
    
    
    if (![prospectprofile.OfficeAddressTown isEqualToString:@"(null)"] || prospectprofile.OfficeAddressTown != NULL) {
        txtOfficeTown.text = prospectprofile.OfficeAddressTown;
    }
    else {
        txtOfficeTown.text = @"";
    }
    
    if (![prospectprofile.ProspectRemark isEqualToString:@"(null)"] || prospectprofile.ProspectRemark != NULL) {
        txtRemark.text = prospectprofile.ProspectRemark;
    }
    else {
        txtRemark.text = @"";
    }
    
    
    if ([prospectprofile.ProspectEmail isEqualToString:@"(null)"] || prospectprofile.ProspectEmail == NULL) {
        
        txtEmail.text = @"";
    }
    else {
        
        txtEmail.text = prospectprofile.ProspectEmail;
        
        
    }
    
    if (![prospectprofile.ExactDuties isEqualToString:@"(null)"] || prospectprofile.ExactDuties != NULL) {
        txtExactDuties.text = prospectprofile.ExactDuties;
    }
    else {
        txtExactDuties.text = @"";
    }
    
    
    
    txtFullName.text = prospectprofile.ProspectName;
    
    
    
    if (!([prospectprofile.ResidenceAddressCountry isEqualToString:@""]||prospectprofile.ResidenceAddressCountry == NULL) && ![prospectprofile.ResidenceAddressCountry isEqualToString:@"MALAYSIA"]) {
        
        checked = YES;
        txtHomeTown.backgroundColor = [UIColor whiteColor];
        txtHomeState.backgroundColor = [UIColor whiteColor];
        txtHomeTown.enabled = YES;
        txtHomeState.enabled = YES;
        txtHomeCountry.hidden = YES;
        btnHomeCountry.hidden = NO;
        [btnForeignHome setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        
        btnHomeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btnHomeCountry setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",prospectprofile.ResidenceAddressCountry] forState:UIControlStateNormal];
    }
    else {
        
        btnHomeCountry.hidden = YES;
        txtHomeCountry.text = prospectprofile.ResidenceAddressCountry;
    }
    
    
    if (!([prospectprofile.OfficeAddressCountry isEqualToString:@""]||prospectprofile.OfficeAddressCountry == NULL) && ![prospectprofile.OfficeAddressCountry isEqualToString:@"MALAYSIA"]) {
        
        checked2 = YES;
        
        
        txtOfficeTown.backgroundColor = [UIColor whiteColor];
        txtOfficeState.backgroundColor = [UIColor whiteColor];
        txtOfficeTown.enabled = YES;
        txtOfficeState.enabled = YES;
        txtOfficeCountry.hidden = YES;
        btnOfficeCountry.hidden = NO;
        [btnForeignOffice setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        
        btnOfficeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btnOfficeCountry setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",prospectprofile.OfficeAddressCountry] forState:UIControlStateNormal];
    }
    else {
        
        btnOfficeCountry.hidden = YES;
        txtOfficeCountry.text = prospectprofile.OfficeAddressCountry;
    }
    
    
    if (![prospectprofile.AnnualIncome isEqualToString:@"(null)"]) {
        txtAnnIncome.text = prospectprofile.AnnualIncome;
    }
    else {
        txtAnnIncome.text = @"";
    }
    
    if (![prospectprofile.BussinessType isEqualToString:@"(null)"]) {
        txtBussinessType.text = prospectprofile.BussinessType;
    }
    else {
        txtBussinessType.text = @"";
    }
    
    if ([prospectprofile.Smoker isEqualToString:@"Y"]) {
        ClientSmoker = @"Y";
        segSmoker.selectedSegmentIndex = 0;
    }
    else if([prospectprofile.Smoker isEqualToString:@"N"]){
        ClientSmoker = @"N";
        segSmoker.selectedSegmentIndex = 1;
    }
    else
        segSmoker.selectedSegmentIndex = UISegmentedControlNoSegment;
    
    
    
    if ([prospectprofile.ProspectGender isEqualToString:@"MALE"] || [prospectprofile.ProspectGender isEqualToString:@"M"] ) {
        gender = @"MALE";
        segGender.selectedSegmentIndex = 0;
    }
    else if ([prospectprofile.ProspectGender isEqualToString:@"FEMALE"] || [prospectprofile.ProspectGender isEqualToString:@"F"]) {
        gender = @"FEMALE";
        segGender.selectedSegmentIndex = 1;
    }
    else
        segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
    
    
    
    if ([[prospectprofile.OtherIDType stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"COMPANYREGISTRATIONNUMBER"] || [prospectprofile.OtherIDType isEqualToString:@"CR"]) {
        
        
        
        companyCase = YES;
        
        
        
        outletOccup.enabled = NO;
        segSmoker.enabled = NO;
        segSmoker.selectedSegmentIndex = UISegmentedControlNoSegment;
        
        segGender.enabled = NO;
        segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        
        
        outletRace.enabled = NO;
        outletRace.titleLabel.textColor = [UIColor grayColor];
        outletMaritalStatus.enabled = NO;
        outletMaritalStatus.titleLabel.textColor = [UIColor grayColor];
        outletReligion.enabled = NO;
        outletReligion.titleLabel.textColor = [UIColor grayColor];
        outletNationality.enabled = NO;
        outletNationality.titleLabel.textColor = [UIColor grayColor];
        
        outletTitle.enabled = NO;
        outletTitle.titleLabel.textColor =  [UIColor grayColor];
        
        //annual income
        txtAnnIncome.enabled = TRUE;
        txtAnnIncome.backgroundColor = [UIColor whiteColor];
        txtAnnIncome.text = prospectprofile.AnnualIncome;
        
        
        //IC
        txtIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtIDType.enabled = NO;
        
        
        txtDOB.hidden = YES;
        [outletDOB setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
        outletDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        outletDOB.titleLabel.textColor = [UIColor grayColor];
        
        segGender.enabled = NO;
        txtDOB.enabled = FALSE;
        
        
        
        //OCCUPATION
        outletOccup.enabled = NO;
        outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [outletOccup setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
        outletOccup.titleLabel.textColor = [UIColor grayColor];
        
        if(prospectprofile.ProspectGender == NULL)
            prospectprofile.ProspectGender = @"";
        if(prospectprofile.ResidenceAddressState == NULL)
            prospectprofile.ResidenceAddressState = @"";
        if(prospectprofile.ResidenceAddressCountry == NULL)
            prospectprofile.ResidenceAddressCountry = @"";
        if(prospectprofile.ProspectOccupationCode ==  NULL)
            prospectprofile.ProspectOccupationCode = @"";
        
        if(prospectprofile.Smoker ==NULL)
            prospectprofile.Smoker =@"";
        //ky
    }
    else {
        companyCase = NO;
        outletOccup.enabled = YES;
    }
    
    txtContact1.text = @"";
    txtContact2.text = @"";
    txtContact3.text = @"";
    txtContact4.text = @"";
    
    txtPrefix1.text = @"";
    txtPrefix2.text = @"";
    txtPrefix3.text = @"";
    txtPrefix4.text = @"";
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT ContactCode, ContactNo, Prefix FROM contact_input where indexNo = %@ ", prospectprofile.ProspectID];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            int a = 0;
            while (sqlite3_step(statement) == SQLITE_ROW){
                
                NSString *ContactCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *ContactNo = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *Prefix = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                
                if (a==0) {
                    if ([ContactCode isEqualToString:@"CONT008"]) { //mobile
                        txtContact2.text  = ContactNo;
                        txtPrefix2.text = Prefix;
                        
                        temp_pre2 = Prefix;
                        temp_cont2 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT006"]) { //home
                        txtContact1.text = ContactNo;
                        txtPrefix1.text = Prefix;
                        
                        temp_pre1 = Prefix;
                        temp_cont1 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT009"]) { //fax
                        txtContact4.text = ContactNo;
                        txtPrefix4.text = Prefix;
                        
                        temp_pre4 = Prefix;
                        temp_cont4 = ContactNo;
                        
                    }
                    else if ([ContactCode isEqualToString:@"CONT007"]) { //office
                        txtContact3.text = ContactNo;
                        txtPrefix3.text = Prefix;
                        
                        temp_pre3 = Prefix;
                        temp_cont3 = ContactNo;
                    }
                }
                else if (a==1) {
                    if ([ContactCode isEqualToString:@"CONT008"]) { //mobile
                        txtContact2.text  = ContactNo;
                        txtPrefix2.text = Prefix;
                        
                        temp_pre2 = Prefix;
                        temp_cont2 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT006"]) { //home
                        txtContact1.text = ContactNo;
                        txtPrefix1.text = Prefix;
                        
                        temp_pre1 = Prefix;
                        temp_cont1 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT009"]) { //fax
                        txtContact4.text = ContactNo;
                        txtPrefix4.text = Prefix;
                        
                        temp_pre4 = Prefix;
                        temp_cont4 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT007"]) { //office
                        txtContact3.text = ContactNo;
                        txtPrefix3.text = Prefix;
                        
                        temp_pre3 = Prefix;
                        temp_cont3 = ContactNo;
                    }
                }
                else if (a==2) {
                    if ([ContactCode isEqualToString:@"CONT008"]) { //mobile
                        txtContact2.text  = ContactNo;
                        txtPrefix2.text = Prefix;
                        
                        temp_pre2 = Prefix;
                        temp_cont2 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT006"]) { //home
                        txtContact1.text = ContactNo;
                        txtPrefix1.text = Prefix;
                        
                        temp_pre1 = Prefix;
                        temp_cont1 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT009"]) { //fax
                        txtContact4.text = ContactNo;
                        txtPrefix4.text = Prefix;
                        
                        temp_pre4 = Prefix;
                        temp_cont4 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT007"]) { //office
                        txtContact3.text = ContactNo;
                        txtPrefix3.text = Prefix;
                        
                        temp_pre3 = Prefix;
                        temp_cont3 = ContactNo;
                    }
                }
                else if (a==3) {
                    if ([ContactCode isEqualToString:@"CONT008"]) { //mobile
                        txtContact2.text  = ContactNo;
                        txtPrefix2.text = Prefix;
                        
                        temp_pre2 = Prefix;
                        temp_cont2 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT006"]) { //home
                        txtContact1.text = ContactNo;
                        txtPrefix1.text = Prefix;
                        
                        temp_pre1 = Prefix;
                        temp_cont1 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT009"]) { //fax
                        txtContact4.text = ContactNo;
                        txtPrefix4.text = Prefix;
                        
                        temp_pre4 = Prefix;
                        temp_cont4 = ContactNo;
                    }
                    else if ([ContactCode isEqualToString:@"CONT007"]) { //office
                        txtContact3.text = ContactNo;
                        txtPrefix3.text = Prefix;
                        
                        temp_pre3 = Prefix;
                        temp_cont3 = ContactNo;
                    }
                }
                a = a + 1;
            }
            sqlite3_finalize(statement);
            [self PopulateOccupCode];
            
            NSString *otherIDType = [OtherIDType.titleLabel.text stringByTrimmingCharactersInSet:
                                     [NSCharacterSet whitespaceCharacterSet]];
            [self PopulateOtherIDCode];
            
            if([otherIDType isEqualToString:@"EXPECTED DELIVERY DATE"])
            {
                //Enable DOB
                //Disable - New IC field and Other ID field
                
                //TITLE
                txtBussinessType.enabled = false;
                txtBussinessType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
                
                txtRemark.editable = false;
                txtRemark.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
                
                outletTitle.enabled = NO;
                outletTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                [outletTitle setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
                outletTitle.titleLabel.textColor = [UIColor grayColor];
                [_TitlePicker setTitle:@"- SELECT -"];
                
                //RACE
                outletRace.enabled = NO;
                outletRace.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                [outletRace setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
                outletRace.titleLabel.textColor = [UIColor grayColor];
                
                
                //NATIONALITY
                outletNationality.enabled = NO;
                outletNationality.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                [outletNationality setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
                outletNationality.titleLabel.textColor = [UIColor grayColor];
                
                
                //RELIGION
                outletReligion.enabled = NO;
                outletReligion.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                [outletReligion setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
                outletReligion.titleLabel.textColor = [UIColor grayColor];
                
                
                //MARITAL
                outletMaritalStatus.enabled = NO;
                outletMaritalStatus.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                [outletMaritalStatus setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
                outletMaritalStatus.titleLabel.textColor = [UIColor grayColor];
                
                //OCCUPATION
                outletOccup.enabled = NO;
                outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                [outletOccup setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
                outletOccup.titleLabel.textColor = [UIColor grayColor];
                
                //group
                outletGroup.enabled = NO;
                outletGroup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                [outletGroup setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
                outletGroup.titleLabel.textColor = [UIColor grayColor];
                
                
                
                txtEmail.enabled = false;
                
                
                
                txtAnnIncome.text = @"";
                txtAnnIncome.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
                txtAnnIncome.enabled =false;
                
                outletTitle.enabled = NO;
                outletTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                
                [outletTitle setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
                outletTitle.titleLabel.textColor = [UIColor grayColor];
                [_TitlePicker setTitle:@"- SELECT -"];
                
                companyCase = NO;
                segGender.enabled = FALSE;
                segSmoker.enabled = FALSE;
                segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                txtIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
                txtIDType.text = @"";
                txtIDType.enabled = NO;
                
                
                
                txtDOB.hidden = YES;
                outletDOB.hidden = NO;
                outletDOB.enabled = YES;
                //  [outletDOB setTitle:@"- SELECT -" forState:UIControlStateNormal];
                txtDOB.backgroundColor = [UIColor whiteColor];
                
                
                
                OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                txtOtherIDType.enabled = NO;
                txtOtherIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
                txtOtherIDType.text =@"";
                
                txtExactDuties.editable = NO;
                txtExactDuties.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
                
                
                txtHomeAddr1.enabled = NO;
                txtHomeAddr1.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
                
                
                txtHomeAddr2.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
                txtHomeAddr2.enabled = NO;
                
                txtHomeAddr3.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
                txtHomeAddr3.enabled = NO;
                
                txtHomePostCode.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
                txtHomePostCode.enabled = NO;
                
                txtOfficeAddr1.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
                txtOfficeAddr1.enabled = NO;
                
                txtOfficeAddr2.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
                txtOfficeAddr2.enabled = NO;
                
                txtOfficeAddr3.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
                txtOfficeAddr3.enabled = NO;
                
                txtOfficePostcode.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
                txtOfficePostcode.enabled = NO;
               
                txtRigNO.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
                txtRigNO.enabled = NO;
                txtRigNO.text =@"";
                
                txtRigDate.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
                outletRigDate.enabled=FALSE;
                txtRigDate.text =@"";
                
                
                segRigPerson.selectedSegmentIndex=0;
                segRigPerson.enabled =NO;
//                txtRigNO.userInteractionEnabled=YES;
//                btnRegistnDate.userInteractionEnabled=YES;
//                segRigExempted.enabled =FALSE;
//                GSTRigExempted = @"";

                
            }
            
            
            
            if(([OccpCatCode isEqualToString:@"HSEWIFE"])
               || ([OccpCatCode isEqualToString:@"JUV"])
               //  || ([OccpCatCode isEqualToString:@"RET"])
               || ([OccpCatCode isEqualToString:@"STU"]))
                //  || ([OccpCatCode isEqualToString:@"UNEMP"]))
            {
                
                
                ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
                
                
                
                if (![[prospectprofile.OtherIDType stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"COMPANYREGISTRATIONNUMBER"])
                {
                    txtAnnIncome.text = @"";
                    txtAnnIncome.enabled = NO;
                    txtAnnIncome.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
                }
                
            }
            else{
                txtAnnIncome.enabled = YES;
                txtAnnIncome.backgroundColor = [UIColor whiteColor];
                
            }
            
            
            NSString *homestate, *officestate;
            FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
            [db open];
            
            //GET HOME ADD STATE DESC
            FMResultSet *result = [db executeQuery:@"SELECT StateDesc FROM eProposal_State WHERE StateCode = ?", prospectprofile.ResidenceAddressState];
            
            while ([result next]) {
                
                
                homestate = [result objectForColumnName:@"StateDesc"];
            }
            
            //GET THE OFFICE STATE DESC
            
            result = [db executeQuery:@"SELECT StateDesc FROM eProposal_State WHERE StateCode = ?", prospectprofile.OfficeAddressState];
            
            while ([result next]) {
                
                officestate = [result objectForColumnName:@"StateDesc"];
            }
            
            [result close];
            [db close];
            
            
            
            if (![[txtHomePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"" ] && [txtHomeCountry.text isEqualToString:@"MALAYSIA"]) {
                
                txtHomeState.text = homestate;
                //   [self PopulateState];
                //  [txtHomePostCode addTarget:self action:@selector(EditTextFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                [txtHomePostCode addTarget:self action:@selector(EditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
            }
            else if (![[txtHomePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"" ] && ![txtHomeCountry.text isEqualToString:@"MALAYSIA"]) {
                
                
                
                txtHomeState.text = prospectprofile.ResidenceAddressState;
                
                
            }
            else{
                
                txtHomeState.text = @"";
                //    [txtHomePostCode addTarget:self action:@selector(EditTextFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                [txtHomePostCode addTarget:self action:@selector(EditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
            }
            
            
            if (![[txtOfficePostcode.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"" ] && [txtOfficeCountry.text isEqualToString:@"MALAYSIA"]) {
                
                txtOfficeState.text = officestate;
                [txtOfficePostcode addTarget:self action:@selector(OfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                [txtOfficePostcode addTarget:self action:@selector(OfficeEditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
            }
            else if (![[txtOfficePostcode.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"" ] && ![txtOfficeCountry.text isEqualToString:@"MALAYSIA"]) {
                
                txtOfficeState.text = prospectprofile.OfficeAddressState;
            }
            else{
                
                txtOfficeState.text = @"";
                [txtOfficePostcode addTarget:self action:@selector(OfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                [txtOfficePostcode addTarget:self action:@selector(OfficeEditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
            }
        }
        sqlite3_close(contactDB);
        
    }
    else {
        NSLog(@"Error opening database");
    }
    
	dbpath = Nil;
	statement = Nil;
    
    // WHEHN EDIT CLIENT PROFILE - USER NOT ABLE TO EDIT THE NEW IC NO, OTHER ID TYPE, OTHER ID
    
    if ([prospectprofile.IDTypeNo isEqualToString:@""] || prospectprofile.IDTypeNo == NULL) {
        
        NSString *otherIDTypeTrim = [OtherIDType.titleLabel.text stringByTrimmingCharactersInSet:
                                     [NSCharacterSet whitespaceCharacterSet]];
        
        
        
        if (([otherIDTypeTrim isEqualToString:@"PASSPORT"] || [otherIDTypeTrim  isEqualToString:@"BIRTH CERTIFICATE"] || [otherIDTypeTrim  isEqualToString:@"OLD IDENTIFICATION NO"] )) {
            
            txtIDType.enabled = YES;
            txtIDType.backgroundColor = [UIColor whiteColor];
            
            [txtIDType removeTarget:self action:@selector(NewICDidChange:) forControlEvents:UIControlEventEditingDidEnd];
        }
        else
        {
            txtIDType.enabled = NO;
            txtIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        }
    }
    else{
        
        txtIDType.enabled = NO;
        txtIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        
    }
    
    
    
    
    
    txtOtherIDType.enabled = NO;
    txtOtherIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    
    OtherIDType.enabled = NO;
    OtherIDType.titleLabel.textColor = [UIColor grayColor];
    
    segGender.enabled = NO;
    
    
    NSString *trim_otheridtype = [OtherIDType.titleLabel.text stringByTrimmingCharactersInSet:
                                  [NSCharacterSet whitespaceCharacterSet]];
    
    if ([trim_otheridtype isEqualToString:@"EXPECTED DELIVERY DATE"])
    {
        
        
        
        txtEmail.enabled = false;
        txtEmail.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        
        txtPrefix1.enabled = false;
        txtPrefix2.enabled = false;
        txtPrefix3.enabled = false;
        txtPrefix4.enabled = false;
        
        txtPrefix1.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtPrefix2.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtPrefix3.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtPrefix4.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        
        txtContact1.enabled = false;
        txtContact2.enabled = false;
        txtContact3.enabled = false;
        txtContact4.enabled = false;
        
        txtContact1.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtContact2.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtContact3.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtContact4.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        
        
        
        txtAnnIncome.text = @"";
        txtExactDuties.text = @"";
        txtHomeAddr1.text = @"";
        txtHomeAddr2.text = @"";
        txtHomeAddr3.text = @"";
        
        txtOfficeAddr1.text = @"";
        txtOfficeAddr2.text =@"";
        txtOfficeAddr3.text = @"";
        
        
        
        txtAnnIncome.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtAnnIncome.enabled =false;
        
        
        txtHomeAddr1.enabled = NO;
        txtHomeAddr1.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
        
        
        txtHomeAddr2.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
        txtHomeAddr2.enabled = NO;
        
        txtHomeAddr3.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
        txtHomeAddr3.enabled = NO;
        
        txtHomePostCode.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
        txtHomePostCode.enabled = NO;
        
        txtOfficeAddr1.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
        txtOfficeAddr1.enabled = NO;
        
        txtOfficeAddr2.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
        txtOfficeAddr2.enabled = NO;
        
        txtOfficeAddr3.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
        txtOfficeAddr3.enabled = NO;
        
        txtOfficePostcode.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
        txtOfficePostcode.enabled = NO;
        
        
        
        txtExactDuties.editable = NO;
        txtExactDuties.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        
        [btnForeignHome setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        [btnForeignOffice setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        
        btnForeignHome.enabled = false;
        btnForeignOffice.enabled = false;
        btnHomeCountry.enabled = false;
        btnOfficeCountry.enabled = false;
        
    }
    
    
    
    
    prospectprofile.ProspectDOB = [prospectprofile.ProspectDOB stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
    
    
    if([prospectprofile.ProspectDOB isEqualToString:@"- SELECT -"] || [prospectprofile.ProspectDOB isEqualToString:@"-SELECT-"])
    {
        
        txtDOB.text = @"- SELECT -";
        prospectprofile.ProspectDOB = @"- SELECT -";
        
        txtDOB.hidden = YES;
        outletDOB.hidden = NO;
        
        outletDOB.enabled = NO;
        outletDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [outletDOB setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
        outletDOB.titleLabel.textColor = [UIColor grayColor];
        
        
    }
    else{
        txtDOB.text = pp.ProspectDOB;
        outletDOB.hidden = YES;
        txtDOB.hidden = NO;
        txtDOB.enabled = NO;
        txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        
    }
    
    
    if (![[prospectprofile.OtherIDType stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"COMPANYREGISTRATIONNUMBER"] && ![prospectprofile.OtherIDType isEqualToString:@"CR"])
    {
        
        if([outletOccup.titleLabel.text isEqualToString:@"-SELECT -"])
            
            outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        else
            outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		
        if([outletOccup.titleLabel.text isEqualToString:@""])
            [outletOccup setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
        else
            [outletOccup setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", outletOccup.titleLabel.text]forState:UIControlStateNormal];
        
        if(prospectprofile.ProspectDOB != NULL && ![prospectprofile.ProspectDOB isEqualToString:@""])
            txtDOB.text = prospectprofile.ProspectDOB;
    }
    
    //  NSLog(@"11 DISPLAY SAME prospectprofile.ProspectGender - %@ || seg - %i",prospectprofile.ProspectGender, segGender.selectedSegmentIndex);
}
-(void) PopulateOccupCode
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
        
        NSString *querySQL = [NSString stringWithFormat:@"SELECT OccpDesc, Class FROM Adm_Occp_Loading_Penta where OccpCode = \"%@\"", prospectprofile.ProspectOccupationCode];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW){
                NSString *OccpDesc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *OccpClass = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                
                OccupCodeSelected = prospectprofile.ProspectOccupationCode;
                if([OccpDesc isEqualToString:@""])
                    [outletOccup setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
                else
                    [outletOccup setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", OccpDesc]forState:UIControlStateNormal];
                txtClass.text = OccpClass;
                outletOccup.titleLabel.text = OccpDesc;
                
                
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
}

-(void) PopulateOtherIDCode
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
        
        NSString *querySQL = [NSString stringWithFormat:@"SELECT IdentityDesc FROM eProposal_Identification where IdentityCode = \"%@\"", prospectprofile.OtherIDType];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW){
                NSString *OtherIDDesc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
				
                
                //OtherIdtypeSelected = prospectprofile.Prospect; please look this back
                if([OtherIDDesc isEqualToString:@""])
                    [OtherIDType setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
                else
                    [OtherIDType setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", OtherIDDesc]forState:UIControlStateNormal];
                OtherIDType.titleLabel.text = OtherIDDesc;
                
                
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
	
}

-(void) PopulateTitle
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
        
        NSString *querySQL = [NSString stringWithFormat:@"SELECT TitleDesc FROM eProposal_Title WHERE TitleCode = \"%@\"", prospectprofile.ProspectTitle];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW){
                NSString *TitleDesc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
				
                
                //OccupCodeSelected = pp.ProspectOccupationCode;
                if([TitleDesc isEqualToString:@""])
                    [outletTitle setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
                else
                    [outletTitle setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", TitleDesc]forState:UIControlStateNormal];
				
                //                outletTitle.titleLabel.text = TitleDesc;
                //[self PopulateTitle];
                
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
	
}

-(void) getSameIDRecord :(NSString*)type : (NSString*)index
{
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    NSString *ProspectID = @"";
    NSString *NickName = @"";
    NSString *ProspectName = @"";
    NSString *ProspectDOB = @"" ;
    
    NSString *RigNumber = @"" ;
    
    NSString *RigDate = @"" ;
    
    NSString *ProspectGender = @"";
    NSString *ResidenceAddress1 = @"";
    NSString *ResidenceAddress2 = @"";
    NSString *ResidenceAddress3 = @"";
    NSString *ResidenceAddressTown = @"";
    NSString *ResidenceAddressState = @"";
    NSString *ResidenceAddressPostCode = @"";
    NSString *ResidenceAddressCountry = @"";
    NSString *OfficeAddress1 = @"";
    NSString *OfficeAddress2 = @"";
    NSString *OfficeAddress3 = @"";
    NSString *OfficeAddressTown = @"";
    NSString *OfficeAddressState = @"";
    NSString *OfficeAddressPostCode = @"";
    NSString *OfficeAddressCountry = @"";
    NSString *ProspectEmail = @"";
    NSString *ProspectOccupationCode = @"";
    NSString *ExactDuties = @"";
    NSString *ProspectRemark = @"";
    //basvi added
    NSString *DateCreated = @"";
    NSString *CreatedBy = @"";
    NSString *DateModified = @"";
    NSString *ModifiedBy = @"";
    //
    NSString *ProspectGroup = @"";
    NSString *ProspectTitle = @"";
    NSString *IDTypeNo = @"";
    NSString *OtherIDType2 = @"";
    NSString *OtherIDTypeNo = @"";
    NSString *Smoker = @"";
    
    NSString *Race = @"";
    
    NSString *Nationality = @"";
    NSString *MaritalStatus = @"";
    NSString *Religion = @"";
    
    NSString *AnnIncome = @"";
    NSString *BussinessType = @"";
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL;
        
        if([type isEqualToString:@"IC"])
            //IC
            querySQL = [NSString stringWithFormat:@"SELECT * FROM prospect_profile WHERE QQFlag = 'false' and  IDTypeNo = \"%@\" and IndexNo = \"%@\"",txtIDType.text, index];
        
        else if([type isEqualToString:@"OTHERID"])
            //OtherID
            querySQL = [NSString stringWithFormat:@"SELECT * FROM prospect_profile WHERE QQFlag = 'false' and  LOWER(OtherIDTypeNo) = LOWER(\"%@\") and IndexNo = \"%@\"" ,txtOtherIDType.text, index];
        
        
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                
                ProspectID = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                const char *name = (const char*)sqlite3_column_text(statement, 1);
                NickName = name == NULL ? nil : [[NSString alloc] initWithUTF8String:name];
                
                ProspectName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                ProspectDOB = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                ProspectGender = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                
                const char *Address1 = (const char*)sqlite3_column_text(statement, 5);
                ResidenceAddress1 = Address1 == NULL ? nil : [[NSString alloc] initWithUTF8String:Address1];
                
                const char *Address2 = (const char*)sqlite3_column_text(statement, 6);
                ResidenceAddress2 = Address2 == NULL ? nil : [[NSString alloc] initWithUTF8String:Address2];
                
                const char *Address3 = (const char*)sqlite3_column_text(statement, 7);
                ResidenceAddress3 = Address3 == NULL ? nil : [[NSString alloc] initWithUTF8String:Address3];
                
                const char *AddressTown = (const char*)sqlite3_column_text(statement, 8);
                ResidenceAddressTown = AddressTown == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressTown];
                
                const char *AddressState = (const char*)sqlite3_column_text(statement, 9);
                ResidenceAddressState = AddressState == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressState];
                
                const char *AddressPostCode = (const char*)sqlite3_column_text(statement, 10);
                ResidenceAddressPostCode = AddressPostCode == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressPostCode];
                
                const char *AddressCountry = (const char*)sqlite3_column_text(statement, 11);
                ResidenceAddressCountry = AddressCountry == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressCountry];
                
                const char *AddressOff1 = (const char*)sqlite3_column_text(statement, 12);
                OfficeAddress1 = AddressOff1 == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOff1];
                
                const char *AddressOff2 = (const char*)sqlite3_column_text(statement, 13);
                OfficeAddress2 = AddressOff2 == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOff2];
                
                const char *AddressOff3 = (const char*)sqlite3_column_text(statement, 14);
                OfficeAddress3 = AddressOff3 == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOff3];
                
                const char *AddressOffTown = (const char*)sqlite3_column_text(statement, 15);
                OfficeAddressTown = AddressOffTown == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffTown];
                
                const char *AddressOffState = (const char*)sqlite3_column_text(statement, 16);
                OfficeAddressState = AddressOffState == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffState];
                
                const char *AddressOffPostCode = (const char*)sqlite3_column_text(statement, 17);
                OfficeAddressPostCode = AddressOffPostCode == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffPostCode];
                
                const char *AddressOffCountry = (const char*)sqlite3_column_text(statement, 18);
                OfficeAddressCountry = AddressOffCountry == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffCountry];
                
                const char *Email = (const char*)sqlite3_column_text(statement, 19);
                ProspectEmail = Email == NULL ? nil : [[NSString alloc] initWithUTF8String:Email];
                
                ProspectOccupationCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 20)];
                
                const char *Duties = (const char*)sqlite3_column_text(statement, 21);
                ExactDuties = Duties == NULL ? nil : [[NSString alloc] initWithUTF8String:Duties];
                
                const char *Remark = (const char*)sqlite3_column_text(statement, 22);
                ProspectRemark = Remark == NULL ? nil : [[NSString alloc] initWithUTF8String:Remark];
                //basvi added
                const char *DateCr = (const char*)sqlite3_column_text(statement, 23);
                DateCreated = DateCr == NULL ? nil : [[NSString alloc] initWithUTF8String:DateCr];
                
                const char *CrBy = (const char*)sqlite3_column_text(statement, 24);
                CreatedBy = CrBy == NULL ? nil : [[NSString alloc] initWithUTF8String:CrBy];
                
                const char *DateMod = (const char*)sqlite3_column_text(statement, 25);
                DateModified = DateMod == NULL ? nil : [[NSString alloc] initWithUTF8String:DateMod];
                
                const char *ModBy = (const char*)sqlite3_column_text(statement, 26);
                ModifiedBy = ModBy == NULL ? nil : [[NSString alloc] initWithUTF8String:ModBy];
                //
                const char *Group = (const char*)sqlite3_column_text(statement, 27);
                ProspectGroup = Group == NULL ? nil : [[NSString alloc] initWithUTF8String:Group];
                
                const char *Title = (const char*)sqlite3_column_text(statement, 28);
                ProspectTitle = Title == NULL ? nil : [[NSString alloc] initWithUTF8String:Title];
                
                const char *typeNo = (const char*)sqlite3_column_text(statement, 29);
                IDTypeNo = typeNo == NULL ? nil : [[NSString alloc] initWithUTF8String:typeNo];
                
                const char *OtherType = (const char*)sqlite3_column_text(statement, 30);
                OtherIDType2 = OtherType == NULL ? nil : [[NSString alloc] initWithUTF8String:OtherType];
                
                const char *OtherTypeNo = (const char*)sqlite3_column_text(statement, 31);
                OtherIDTypeNo = OtherTypeNo == NULL ? nil : [[NSString alloc] initWithUTF8String:OtherTypeNo];
                
                const char *smok = (const char*)sqlite3_column_text(statement, 32);
                Smoker = smok == NULL ? nil : [[NSString alloc] initWithUTF8String:smok];
                
                const char *ann = (const char*)sqlite3_column_text(statement, 33);
                AnnIncome = ann == NULL ? nil : [[NSString alloc] initWithUTF8String:ann];
                
                const char *buss = (const char*)sqlite3_column_text(statement, 34);
                BussinessType = buss == NULL ? nil : [[NSString alloc] initWithUTF8String:buss];
                
                const char *rac = (const char*)sqlite3_column_text(statement, 35);
                Race = rac == NULL ? nil : [[NSString alloc] initWithUTF8String:rac];
                
                const char *marstat = (const char*)sqlite3_column_text(statement, 36);
                MaritalStatus = marstat == NULL ? nil : [[NSString alloc] initWithUTF8String:marstat];
                
                const char *rel = (const char*)sqlite3_column_text(statement, 37);
                Religion = rel == NULL ? nil : [[NSString alloc] initWithUTF8String:rel];
                
                const char *nat = (const char*)sqlite3_column_text(statement, 38);
                Nationality = nat == NULL ? nil : [[NSString alloc] initWithUTF8String:nat];
                
                const char *reg = (const char*)sqlite3_column_text(statement, 41);
                NSString *registrationNo = reg == NULL ? nil : [[NSString alloc] initWithUTF8String:reg];
                
                
                const char *isreg = (const char*)sqlite3_column_text(statement, 40);
                NSString *registration = isreg == NULL ? nil : [[NSString alloc] initWithUTF8String:isreg];
                
                const char *regdate = (const char*)sqlite3_column_text(statement, 42);
                NSString *registrationDate = regdate == NULL ? nil : [[NSString alloc] initWithUTF8String:regdate];
                
                const char *exempted = (const char*)sqlite3_column_text(statement, 43);
                NSString *regExempted = exempted == NULL ? nil : [[NSString alloc] initWithUTF8String:exempted];
                
                const char *isG = (const char*)sqlite3_column_text(statement, 45);
                NSString *isGrouping = isG == NULL ? nil : [[NSString alloc] initWithUTF8String:isG];
                
                const char *CountryOfBirth = (const char*)sqlite3_column_text(statement, 46);
                NSString *COB = CountryOfBirth == NULL ? nil : [[NSString alloc] initWithUTF8String:CountryOfBirth];
                
                
                
                if  ((NSNull *) OfficeAddressCountry == [NSNull null])
                    OfficeAddressCountry = @"";
                
                
                OccupCodeSelected = ProspectOccupationCode;
                [self get_unemploy];
                
                
                
                if (![ResidenceAddressCountry isEqualToString:@"MAL"] && ![ResidenceAddressCountry isEqualToString:@""] &&(ResidenceAddressCountry!=NULL) && ![ResidenceAddressCountry isEqualToString:@"(null)"] && ResidenceAddressCountry!= nil) {
                    
                    checked = YES;
                }
                
                if (![OfficeAddressCountry isEqualToString:@"MAL"] && ![OfficeAddressCountry isEqualToString:@""] &&(OfficeAddressCountry!=NULL) && ![OfficeAddressCountry isEqualToString:@"(null)"] && OfficeAddressCountry!= nil) {
                    
                    
                    checked2 = YES;
                    
                    
                }
                
                prospectprofile = [[ProspectProfile alloc] initWithName:NickName AndProspectID:ProspectID AndProspectName:ProspectName
                                                       AndProspecGender:ProspectGender AndResidenceAddress1:ResidenceAddress1
                                                   AndResidenceAddress2:ResidenceAddress2 AndResidenceAddress3:ResidenceAddress3
                                                AndResidenceAddressTown:ResidenceAddressTown AndResidenceAddressState:ResidenceAddressState
                                            AndResidenceAddressPostCode:ResidenceAddressPostCode AndResidenceAddressCountry:ResidenceAddressCountry
                                                      AndOfficeAddress1:OfficeAddress1 AndOfficeAddress2:OfficeAddress2 AndOfficeAddress3:OfficeAddress3 AndOfficeAddressTown:OfficeAddressTown
                                                  AndOfficeAddressState:OfficeAddressState AndOfficeAddressPostCode:OfficeAddressPostCode
                                                AndOfficeAddressCountry:OfficeAddressCountry AndProspectEmail:ProspectEmail AndProspectRemark:ProspectRemark AndDateCreated:DateCreated AndDateModified:DateModified AndCreatedBy:CreatedBy AndModifiedBy:ModifiedBy
                                              AndProspectOccupationCode:ProspectOccupationCode AndProspectDOB:ProspectDOB AndExactDuties:ExactDuties AndGroup:ProspectGroup AndTitle:ProspectTitle AndIDTypeNo:IDTypeNo AndOtherIDType:OtherIDType2 AndOtherIDTypeNo:OtherIDTypeNo AndSmoker:Smoker AndAnnIncome:AnnIncome AndBussType:BussinessType AndRace:Race AndMaritalStatus:MaritalStatus AndReligion:Religion AndNationality:Nationality AndRegistrationNo:registrationNo AndRegistration:registration AndRegistrationDate:registrationDate AndRegistrationExempted:regExempted AndProspect_IsGrouping:isGrouping AndCountryOfBirth:COB];
                
                
            }
            sqlite3_finalize(statement);
            
        }
        sqlite3_close(contactDB);
        query_stmt = Nil, query_stmt = Nil;
    }
    
    dirPaths = Nil, docsDir = Nil, dbpath = Nil, statement = Nil, statement = Nil;
    ProspectID = Nil;
    NickName = Nil;
    ProspectName = Nil ;
    ProspectDOB = Nil  ;
    ProspectGender = Nil;
    ResidenceAddress1 = Nil;
    ResidenceAddress2 = Nil;
    ResidenceAddress3 = Nil;
    ResidenceAddressTown = Nil;
    ResidenceAddressState = Nil;
    ResidenceAddressPostCode = Nil;
    ResidenceAddressCountry = Nil;
    OfficeAddress1 = Nil;
    OfficeAddress2 = Nil;
    OfficeAddress3 = Nil;
    OfficeAddressTown = Nil;
    OfficeAddressState = Nil;
    OfficeAddressPostCode = Nil;
    OfficeAddressCountry = Nil;
    ProspectEmail = Nil;
    ProspectOccupationCode = Nil;
    ExactDuties = Nil;
    ProspectRemark = Nil;
    ProspectTitle = Nil, ProspectGroup = Nil, IDTypeNo = Nil, OtherIDType2 = Nil, OtherIDTypeNo = Nil, Smoker = Nil;
    Race = Nil, Religion = Nil, MaritalStatus = Nil, Nationality = Nil;
}
- (IBAction)btnOtherIDType:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isNew"];
    
    if (_IDTypePicker == nil) {
        
        self.IDTypePicker = [[IDTypeViewController alloc] initWithStyle:UITableViewStylePlain];
		_IDTypePicker.delegate = self;
        _IDTypePicker.requestType = @"CO";
        self.IDTypePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_IDTypePicker];
    }
    
    
    [self.IDTypePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}


#pragma mark - validation

- (BOOL) OtherIDValidation2
{
    OTHERID_Hold_Alert = NO;
    NSString *otherIDType = [OtherIDType.titleLabel.text stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceCharacterSet]];
    NSString *input = [txtOtherIDType.text lowercaseString];
    NSString *str_otherid;
    
    for (NSArray* row in _tableCheckSameRecord.rows)
    {
        str_otherid  = [[row objectAtIndex:0] lowercaseString];
        NSString *db_otherid = [[row objectAtIndex:1] stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
        NSString *indexno = [row objectAtIndex:2];
        
        db_otherid = [db_otherid uppercaseString];
        
        //   NSLog(@"22 str_otherid - %@ | input - %@ | otherIDType - %@ | db_otherid - %@ ", str_otherid, input, otherIDType, db_otherid);
        
        if ([input isEqualToString:str_otherid] && [otherIDType isEqualToString:db_otherid]) {
            
            if(Update_record == FALSE){
                
                getSameRecord_Indexno = indexno;
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Customer profile has been created using this ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag = 6000;
                [alert show];
                
				NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
				[ClientProfile setObject:@"NO" forKey:@"isNew"];
                OTHERID_Hold_Alert = YES;
                
                return false;
            }
            
        }
        
    }
    
    
    
    
    return true;
}



- (BOOL) OtherIDValidation
{
    OTHERID_Hold_Alert = NO;
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	//[ClientProfile setObject:@"NEW" forKey:@"TabBar1"];
	
	NSLog(@"tabbar1: %@", [ClientProfile objectForKey:@"TabBar1"]);
	
	if (![[ClientProfile objectForKey:@"TabBar1"] isEqualToString:@"1"] && clickDone != 1) {
		
		
		NSString *otherIDType = [OtherIDType.titleLabel.text stringByTrimmingCharactersInSet:
								 [NSCharacterSet whitespaceCharacterSet]];
		NSString *input = [txtOtherIDType.text lowercaseString];
		NSString *str_otherid;
		
		for (NSArray* row in _tableCheckSameRecord.rows){
			
			str_otherid  = [[row objectAtIndex:0] lowercaseString];
			NSString *db_otherid = [[row objectAtIndex:1] stringByTrimmingCharactersInSet:
									[NSCharacterSet whitespaceCharacterSet]];
			NSString *indexno = [row objectAtIndex:2];
			
			db_otherid = [db_otherid uppercaseString];
			
			//convert db_otherid to desc
			db_otherid = [self getOtherTypeDesc:db_otherid];
			
            //			NSLog(@"Input: Type: %@ ID: %@  Cpr: type: %@ ID: %@", otherIDType, input, db_otherid, str_otherid);
			
			if ([input isEqualToString:str_otherid] && [otherIDType isEqualToString:db_otherid]) {
                //			if ([txtOtherIDType.text isEqualToString:[row objectAtIndex:0]]) {
				
				if(Update_record == FALSE)
				{
                    //					getSameRecord_Indexno = [row objectAtIndex:2];
					getSameRecord_Indexno = indexno;
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
																	message:@"Customer profile has been created using this ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					
					alert.tag = 6000;
					[alert show];
					
                    //					segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
					
					NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
					[ClientProfile setObject:@"NO" forKey:@"isNew"];
					OTHERID_Hold_Alert = YES;
					
					return false;
				}
				
			}
		}
	}
	
    
    return true;
}

-(BOOL) IDValidation2
{
    IC_Hold_Alert = NO;
    
    for (NSArray* row in _tableDB.rows){
        
        if ([txtIDType.text isEqualToString:[row objectAtIndex:1]]) {
            
            if(Update_record == FALSE)
            {
                IC_Hold_Alert = YES;
                
                getSameRecord_Indexno = [row objectAtIndex:0];
            }
            
        }
    }
    
    
    
    //
    
    
    return true;
}

-(BOOL) IDValidation
{
    IC_Hold_Alert = NO;
	
	//test
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	//[ClientProfile setObject:@"NEW" forKey:@"TabBar1"];
	
	if (![[ClientProfile objectForKey:@"TabBar1"] isEqualToString:@"1"] && clickDone != 1) {
		for (NSArray* row in _tableDB.rows){
			
			if ([txtIDType.text isEqualToString:[row objectAtIndex:1]]) {
				
				if(Update_record == FALSE)
				{
					
					
					getSameRecord_Indexno = [row objectAtIndex:0];
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
																	message:@"Customer profile has been created using this ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					
					alert.tag = 6000;
					[alert show];
					
					segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
					NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
					[ClientProfile setObject:@"NO" forKey:@"isNew"];
					IC_Hold_Alert = YES;
					return false;
					
				}
				
			}
		}
	}
    return true;
}


- (bool) Validation
{
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
    int annual_income =  [txtAnnIncome.text integerValue];
    
    
    
    NSString *otherIDTypeTrim = [OtherIDType.titleLabel.text stringByTrimmingCharactersInSet:
                                 [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *title   = [outletTitle.titleLabel.text stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    
    
    NSString *religion = [outletReligion.titleLabel.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *race = [outletRace.titleLabel.text stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *RigDateOutlet = [outletRigDate.titleLabel.text stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    
    
    NSString *occupTrim = [outletOccup.titleLabel.text stringByTrimmingCharactersInSet:
                           [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *nation = [outletNationality.titleLabel.text stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceCharacterSet]];
    
    
    NSString *marital = [outletMaritalStatus.titleLabel.text stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    
    
    NSString *home1_trim = [txtHomeAddr1.text stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *homePostcode_trim = [txtHomePostCode.text stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *office1_trim = [txtOfficeAddr1.text stringByTrimmingCharactersInSet:
                              [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *officePostcode_trim = [txtOfficePostcode.text stringByTrimmingCharactersInSet:
                                     [NSCharacterSet whitespaceCharacterSet]];
	
	NSString *BCountry = [btnCoutryOfBirth.titleLabel.text stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    
    
	//ENS: 29/09/2014
	
	[ClientProfile setObject:@"" forKey:@"TabBar1"];
	clickDone = 2; //to allow prompt same id checking, can use any number as long not 1
	
	if ([textFields trimWhiteSpaces:txtIDType.text].length == 16) {
		if (![self IDValidation]) {
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
			return FALSE;
		}
	}
	
	if (![otherIDTypeTrim isEqualToString:@"- SELECT -"] && ![otherIDTypeTrim isEqualToString:@""] && ![textFields trimWhiteSpaces:txtOtherIDType.text].length == 0) {
		if (![self OtherIDValidation]) {
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
			return FALSE;
		}
	}
	
    if(!companyCase){
        
        if([title isEqualToString:@"- SELECT -"] && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Title is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 1006;
            
            [alert show];
			
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
    }
    
    //check 3 times repeat alphabetic
    NSArray  *repeat = [txtFullName.text componentsSeparatedByString:@" "];
    
    for(int x=0; x<repeat.count;x++)
    {
        NSString *substring = [repeat objectAtIndex:x];
        if([substring length] > 3)
        {
            
            
            
            for(int y =0; y<substring.length;y++)
            {
                
                
                int range2 = y+1;
                int range3 = y+2;
                int range4 = y+3;
                
                if(range4 < substring.length) // the forth digit index cannot > than substring.length else get execption!
                {
                    NSString *first = [substring substringWithRange:NSMakeRange(y,1)];
                    NSString *second = [substring substringWithRange:NSMakeRange(range2,1)];
                    NSString *third = [substring substringWithRange:NSMakeRange(range3,1)];
                    NSString *forth = [substring substringWithRange:NSMakeRange(range4,1)];
                    
                    first = [first lowercaseString];
                    second = [second lowercaseString];
                    third = [third lowercaseString];
                    forth = [forth lowercaseString];
                    
                    
                    
                    if ([first isEqualToString:second] &&  [second isEqualToString:third] && [third isEqualToString:forth]) {
                        
                        name_repeat = name_repeat +1;
                        
                        
                        
                    }
                    
                }
            }
            
            
        }
    }
    
    
    
    
    
    if([[txtFullName.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]){
        errormsg = [[UIAlertView alloc] initWithTitle:@" "
                                              message:@"Full Name is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        errormsg.tag = 80;
        [errormsg show];
        errormsg = nil;
		[ClientProfile setObject:@"NO" forKey:@"TabBar"];
        return false;
    }
    else if([textFields validateString3:txtFullName.text]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Invalid name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 80;
        [alert show];
        alert = Nil;
		[ClientProfile setObject:@"NO" forKey:@"TabBar"];
        return false;
    }
    else if( name_repeat > 0)
    {
        
        
        if(name_morethan3times == TRUE && name_repeat == 100)
        {
            NSLog(@" -1 ");
        }
        
        else
        {
            name_repeat = 0;
            name_morethan3times = false;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Invalid Name format. Same alphabet cannot be repeated more than three times." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 80;
            
            [alert show];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
            
        }
        
    }
    else {
        BOOL valid;
        NSString *strToBeTest = [txtFullName.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] ;
        
        for (int i=0; i<strToBeTest.length; i++) {
            int str1=(int)[strToBeTest characterAtIndex:i];
            
            if((str1 >96 && str1 <123)  || (str1 >64 && str1 <91) || str1 == 39 || str1 == 40 || str1 == 41 || str1 == 64 || str1 == 47 || str1 == 45 || str1 == 46){
                valid = TRUE;
                
            }else {
                valid = FALSE;
                break;
            }
        }
        if (!valid) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Invalid Name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 80;
            
            [alert show];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
    }
    
    
    
    
    //KY START COMPANY
    if(companyCase) {
        
        if ([[txtOtherIDType.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 82;
            [alert show];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        else if([textFields validateOtherID:txtOtherIDType.text]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Invalid Other ID."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 81;
            [alert show];
            alert = Nil;
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
        if (txtOtherIDType.text.length > 30) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Invalid Other ID length. Other ID length should be not more 30 characters long" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [txtOtherIDType becomeFirstResponder];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
        if ([[txtOtherIDType.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 82;
            
            [alert show];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        else if([textFields validateOtherID:txtOtherIDType.text]){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"Invalid Other ID."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 81;
            [alert show];
            alert = Nil;
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
        if (txtExactDuties.text.length > 40) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Invalid Exact Duties length. Only 40 characters allowed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 1007;
            [alert show];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
        
        if ([txtBussinessType.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Type of business is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 2060;
            [alert show];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
        
        if (txtBussinessType.text.length > 60) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Invalid Type of Business length. Only 60 characters allowed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag=2060;
            [alert show];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
        
        
        
        NSString * AI = [annualIncome_original stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
        
        NSArray  *comp = [AI componentsSeparatedByString:@"."];
        
        
        
        int AI_Length = [[comp objectAtIndex:0] length];
        
        if ([txtAnnIncome.text isEqualToString:@""] && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"]) {
            if((![OccpCatCode isEqualToString:@"HSEWIFE"])
               && (![OccpCatCode isEqualToString:@"JUV"])
               && (![OccpCatCode isEqualToString:@"RET"])
               && (![OccpCatCode isEqualToString:@"STU"])
               && (![OccpCatCode isEqualToString:@"UNEMP"])) {
                
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Annual Income is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag = 1008;
                [alert show];
                
                [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
        }
        else if (AI_Length >13  && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"]) {
            if((![OccpCatCode isEqualToString:@"HSEWIFE"])
               && (![OccpCatCode isEqualToString:@"JUV"])
               && (![OccpCatCode isEqualToString:@"RET"])
               && (![OccpCatCode isEqualToString:@"STU"])
               && (![OccpCatCode isEqualToString:@"UNEMP"])) {
                
                
                
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Annual income must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag = 1008;
                [rrr show];
                rrr = nil;
                
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
        }
        
        else if (AI_Length < 13 && annual_income == 0)
        {
            
            rrr = [[UIAlertView alloc] initWithTitle:@" "
                                             message:@"Annual income must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            rrr.tag = 1008;
            [rrr show];
            rrr = nil;
            
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
            
        }
        
        
        //###### ky Home address START#######
        NSString *homecountry = [btnHomeCountry.titleLabel.text stringByTrimmingCharactersInSet:
                                 [NSCharacterSet whitespaceCharacterSet]];
        
        
        if ( home1_trim.length==0 && checked == YES )
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Residential Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 1012;
            
            [alert show];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        else  if ([homecountry isEqualToString:@"- SELECT -"] && checked == YES )
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Country for residential address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            alert.tag = 5001;
            [alert show];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
            
        }
        
        
        else if ( ( home1_trim.length !=0 || ![txtHomeAddr2.text isEqualToString:@""] || ![txtHomeAddr3.text isEqualToString:@""])&& homePostcode_trim.length==0)
        {
            if(checked == NO)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Postcode for residential address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag=2000;
                
                [alert show];
                [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
        }
        else  if ( home1_trim.length==0 && homePostcode_trim.length!=0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Residential Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 1012;
            
            [alert show];
            [ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
        
        else if (![txtHomePostCode.text isEqualToString:@""])
        {
            
            
            //HOME POSTCODE START
            //CHECK INVALID SYMBOLS
            NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
            
            HomePostcodeContinue = false;
            BOOL valid;
            BOOL valid_symbol;
            
            NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
            
            NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtHomePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
            
            valid = [alphaNums isSupersetOfSet:inStringSet];
            valid_symbol = [set isSupersetOfSet:inStringSet];
            
            txtHomePostCode.text = [txtHomePostCode.text stringByTrimmingCharactersInSet:
                                    [NSCharacterSet whitespaceCharacterSet]];
            
            if(txtHomePostCode.text.length < 5)
            {
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Postcode for Residential Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                rrr.tag = 2001;
                [rrr show];
                rrr=nil;
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            else if (!valid_symbol && !checked) {
                txtHomeState.text=@"";
                txtHomeState.text = @"";
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Postcode for Residential Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                rrr.tag = 2001;
                [rrr show];
                rrr=nil;
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
                
            }
            
            
            else if (!valid && !checked) {
                txtHomeState.text=@"";
                txtHomeState.text = @"";
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Postcode for Residential Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                rrr.tag = 2001;
                [rrr show];
                
                rrr=nil;
                
                txtHomeState.text = @"";
                txtHomeTown.text = @"";
                txtHomeCountry.text = @"";
                SelectedStateCode = @"";
                PostcodeContinue = FALSE;
                [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            else{
                
                BOOL gotRow = false;
                const char *dbpath = [databasePath UTF8String];
                sqlite3_stmt *statement;
                
                
                if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
                    NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", txtHomePostCode.text];
                    
                    
                    const char *query_stmt = [querySQL UTF8String];
                    if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                    {
                        
                        while (sqlite3_step(statement) == SQLITE_ROW){
                            NSString *Town = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                            NSString *State = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                            NSString *Statecode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                            
                            txtHomeState.text = State;
                            txtHomeTown.text = Town;
                            txtHomeCountry.text = @"MALAYSIA";
                            SelectedStateCode = Statecode;
                            gotRow = true;
                            HomePostcodeContinue = TRUE;
                            
                            self.navigationItem.rightBarButtonItem.enabled = TRUE;
                        }
                        sqlite3_finalize(statement);
                    }
                    else{
                        txtHomeState.text = @"";
                        txtHomeTown.text = @"";
                        txtHomeCountry.text = @"";
                    }
                    
                    
                    sqlite3_close(contactDB);
                }
                
                if(!HomePostcodeContinue && !checked)
                {
                    txtHomeState.text = @"";
                    txtHomeTown.text = @"";
                    txtHomeCountry.text = @"";
                    SelectedStateCode = @"";
                    
                    
                    txtHomeState.text=@"";
                    txtHomeState.text = @"";
                    rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                     message:@"Postcode for Residential Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    rrr.tag = 2001;
                    [rrr show];
                    rrr=nil;
                    [txtHomePostCode addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
					[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                    
                    
                }
                
                
            }
            //HOME POSTCODE END
            
            
            
            
        }
        
        //###### Home address END#######
        
        //######office address#######
        if(checked2){
            
            NSString *officecountry = [btnOfficeCountry.titleLabel.text stringByTrimmingCharactersInSet:
                                       [NSCharacterSet whitespaceCharacterSet]];
            
            
            if(office1_trim.length==0 && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag = 2002;
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
                
            }
            if([officecountry isEqualToString:@"- SELECT -"])
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Country for office address is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag=5002;
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
        }
        else{
            
            
            if(office1_trim.length==0  && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag = 2002;
                
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
                
            }
            
            else if (![txtOfficePostcode.text isEqualToString:@""])
            {
                
                //HOME POSTCODE START
                //CHECK INVALID SYMBOLS
                NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
                
                
                BOOL valid;
                BOOL valid_symbol;
                
                NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                
                NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtOfficePostcode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
                
                valid = [alphaNums isSupersetOfSet:inStringSet];
                valid_symbol = [set isSupersetOfSet:inStringSet];
                
                if(officePostcode_trim.length < 5)
                {
                    rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                     message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    rrr.tag = 3001;
                    [rrr show];
                    rrr=nil;
					[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                }
                
                else if (!valid_symbol) {
                    
                    txtOfficeState.text = @"";
                    txtOfficeTown.text = @"";
                    rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                     message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    rrr.tag = 3001;
                    [rrr show];
                    rrr=nil;
                    
                    [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                    
                }
                
                
                else if (!valid) {
                    
                    rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                     message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    rrr.tag = 3001;
                    [rrr show];
                    
                    rrr=nil;
                    
                    txtHomeState.text = @"";
                    txtHomeTown.text = @"";
                    txtHomeCountry.text = @"";
                    SelectedStateCode = @"";
					[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                }
                
                
                else{
                    const char *dbpath = [databasePath UTF8String];
                    sqlite3_stmt *statement;
                    
                    txtOfficePostcode.text = [txtOfficePostcode.text stringByReplacingOccurrencesOfString:@" " withString:@""];
                    
                    
                    
                    
                    
                    //CHECK INVALID SYMBOLS
                    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
                    
                    
                    BOOL valid;
                    BOOL valid_symbol;
                    
                    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                    
                    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtOfficePostcode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
                    
                    valid = [alphaNums isSupersetOfSet:inStringSet];
                    valid_symbol = [set isSupersetOfSet:inStringSet];
                    OfficePostcodeContinue = false;
                    
                    if(!checked2)
                    {
                        
                        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
                            NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", txtOfficePostcode.text];
                            
                            
                            const char *query_stmt = [querySQL UTF8String];
                            if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                            {
                                while (sqlite3_step(statement) == SQLITE_ROW){
                                    NSString *OfficeTown = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                                    NSString *OfficeState = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                                    NSString *Statecode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                                    
                                    txtOfficeState.text = OfficeState;
                                    txtOfficeTown.text = OfficeTown;
                                    txtOfficeCountry.text = @"MALAYSIA";
                                    SelectedOfficeStateCode = Statecode;
                                    
                                    OfficePostcodeContinue = TRUE;
                                    self.navigationItem.rightBarButtonItem.enabled = TRUE;
                                }
                                sqlite3_finalize(statement);
                                
                                
                                sqlite3_close(contactDB);
                            }
                            else{
                                txtOfficeState.text = @"";
                                txtOfficeTown.text = @"";
                                txtOfficeCountry.text = @"";
                            }
                        }
                        if(!OfficePostcodeContinue)
                        {
                            txtOfficeState.text = @"";
                            txtOfficeTown.text = @"";
                            txtOfficeCountry.text = @"";
                            SelectedStateCode = @"";
                            
                            
                            
                            rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                             message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            
                            rrr.tag = 3001;
                            [rrr show];
                            rrr=nil;
                            [txtOfficePostcode addTarget:self action:@selector(OfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                            [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                            return false;
                            
                            
                        }
                        
                    }
                }
                
                
                //HOME POSTCODE END
                
            }
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
    }  //END COMPANY
    else{
        NSString *occupation = [outletOccup.titleLabel.text stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
        
        NSString *str_dob = [outletDOB.titleLabel.text stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceCharacterSet]];
        
        
        //Check if baby
        if([occupation isEqualToString:@"BABY"] && [otherIDTypeTrim isEqualToString:@"BIRTH CERTIFICATE"]) {
            
            
            segGender.enabled = YES;
            if(txtOtherIDType.text.length==0 && txtIDType.text.length == 0)
            {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No or Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag = 1003;
                [rrr show];
                segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
                
                
                
            }
            else if (txtOtherIDType.text.length==0){
                [txtOtherIDType becomeFirstResponder];
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag = 82;
                [rrr show];
                segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
                
                
            }
            else if([textFields validateOtherID:txtOtherIDType.text]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Invalid Other ID."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 81;
                [alert show];
                alert = Nil;
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
        }
        
        
        
        if(([otherIDTypeTrim isEqualToString:@"- SELECT -"] && ![otherIDTypeTrim isEqualToString:@"OLD IDENTIFICATION NO"]) && ![occupation isEqualToString:@"BABY"] ){
            
            
            ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
            txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            
            
            if ([otherIDTypeTrim isEqualToString:@"- SELECT -"] && ([txtIDType.text isEqualToString:@""] || (txtIDType.text.length == 0) )) {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No or Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag = 1003;
                [rrr show];
                txtIDType.text = @"";
                txtDOB.text = @"";
                segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
                
            }
            else if([txtIDType.text isEqualToString:@""] || (txtIDType.text.length == 0) ){
                
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag = 1002;
                [rrr show];
                txtIDType.text = @"";
                txtDOB.text = @"";
                segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
                
            }
            
            
            
            
            else  if (txtIDType.text.length != 16) {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No must be 16 digits characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag = 1002;
                [rrr show];
                rrr=nil;
                
                
                [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            else  if (![[txtIDType.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
                
                BOOL valid;
                NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:txtIDType.text];
                valid = [alphaNums isSupersetOfSet:inStringSet];
                if (!valid) {
                    
                    rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                     message:@"NIK No must be numeric" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    rrr.tag = 1002;
                    [rrr show];
                    rrr = nil;
                    [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                }
                
                if (txtIDType.text.length != 16) {
                    
                    
                    
                    
                    
                    rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                     message:@"NIK No must be 16 digits characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    rrr.tag = 1002;
                    [rrr show];
                    rrr = nil;
                    
					[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                }
            }
            
            
            //GET DOB
            
            NSString *last = [txtIDType.text substringFromIndex:[txtIDType.text length] -1];
            NSCharacterSet *oddSet = [NSCharacterSet characterSetWithCharactersInString:@"13579"];
            
//            if ([last rangeOfCharacterFromSet:oddSet].location != NSNotFound) {
//                
//                segGender.selectedSegmentIndex = 0;
//                gender = @"MALE";
//            } else {
//                
//                segGender.selectedSegmentIndex = 1;
//                gender = @"FEMALE";
//            }
//            
//            //CHECK DAY / MONTH / YEAR START
//            //get the DOB value from ic entered
//            NSString *strDate = [txtIDType.text substringWithRange:NSMakeRange(4, 2)];
//            NSString *strMonth = [txtIDType.text substringWithRange:NSMakeRange(2, 2)];
//            NSString *strYear = [txtIDType.text substringWithRange:NSMakeRange(0, 2)];
			
			
			NSString *strDate = [txtIDType.text substringWithRange:NSMakeRange(6, 2)];
			NSString *strMonth = [txtIDType.text substringWithRange:NSMakeRange(8, 2)];
			NSString *strYear = [txtIDType.text substringWithRange:NSMakeRange(10, 2)];
			NSString *strGender;
			
			int intDate = [strDate integerValue];
			if (intDate > 40 && intDate < 72) {
				strGender = @"F";
				gender = @"FEMALE";
				intDate = intDate - 40;
				if (intDate <10)
					strDate = [NSString stringWithFormat:@"0%d", intDate];
				else
					strDate = [NSString stringWithFormat:@"%d", intDate];
			}
			else if (intDate > 0 && intDate < 31) {
				strGender = @"M";
//				segGender.selectedSegmentIndex = 0;
				gender = @"MALE";
			}
            
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
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                rrr.tag = 1002;
                [rrr show];
                
                if([otherIDTypeTrim isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    txtDOB.text = @"";
                    segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            else if ([strMonth intValue] > 12 || [strMonth intValue] < 1) {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK month must be between 1 and 12." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                rrr.tag = 1002;
                [rrr show];
                
                if([otherIDTypeTrim isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    txtDOB.text = @"";
                    segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            else if([strDate intValue] < 1 || [strDate intValue] > 31)
            {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK day must be between 1 and 31 or between 41 and 71" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                rrr.tag = 1002;
                [rrr show];
                [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
                
            }
            else if (([strMonth isEqualToString:@"01"] || [strMonth isEqualToString:@"03"] || [strMonth isEqualToString:@"05"] || [strMonth isEqualToString:@"07"] || [strMonth isEqualToString:@"08"] || [strMonth isEqualToString:@"10"] || [strMonth isEqualToString:@"12"]) && [strDate intValue] > 31) {
                
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                rrr.tag = 1002;
                [rrr show];
                
                txtIDType.text = @"";
                if([otherIDTypeTrim isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    txtDOB.text = @"";
                    segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            else if (([strMonth isEqualToString:@"04"] || [strMonth isEqualToString:@"06"] || [strMonth isEqualToString:@"09"] || [strMonth isEqualToString:@"11"]) && [strDate intValue] > 30) {
                
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK no not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                rrr.tag = 1002;
                [rrr show];
                
                txtIDType.text = @"";
                if([otherIDTypeTrim isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    txtDOB.text = @"";
                    segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
                [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            else if (([febStatus isEqualToString:@"Normal"] && [strDate intValue] > 28 && [strMonth isEqualToString:@"02"]) || ([febStatus isEqualToString:@"Jump"] && [strDate intValue] > 29 && [strMonth isEqualToString:@"02"])) {
                
                
                NSString *msg = [NSString stringWithFormat:@"February of %@ doesn’t have 29 days",strYear] ;
                
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                
                [rrr show];
                
                
                if([otherIDTypeTrim isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    txtDOB.text = @"";
                    segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
                [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            else {
                outletDOB.hidden = YES;
                outletDOB.enabled = FALSE;
                txtDOB.enabled = FALSE;
                txtDOB.hidden = NO;
                txtDOB.text = strDOB;
                [outletDOB setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",strDOB]forState:UIControlStateNormal];
            }
            
            //CHECK DAY / MONTH / YEAT END
            
        }
        
        else if(![otherIDTypeTrim isEqualToString:@"- SELECT -"]  && (txtIDType.text.length > 0 && txtIDType.text.length<16) )
        {
            
            if (txtIDType.text.length != 16) {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No must be 16 digits characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag = 1002;
                [rrr show];
                rrr=nil;
                
                
                [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
        }
        
        //KY START CHECK IC
        
        
        
        
        txtIDType.text = [txtIDType.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if (txtIDType.text.length > 0 && txtIDType.text.length < 16) {
            rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No must be 16 digits characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            rrr.tag = 1002;
            [rrr show];
            rrr = nil;
            
            [ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        else if(txtIDType.text.length == 16)
        {
            BOOL valid;
            NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
            NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtIDType.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
            valid = [alphaNums isSupersetOfSet:inStringSet];
            if (!valid) {
                
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No must be in numeric" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                rrr.tag = 1002;
                [rrr show];
                txtIDType.text = @"";
                [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            else {
                
                
                //get the DOB value from ic entered
                NSString *strDate = [txtIDType.text substringWithRange:NSMakeRange(6, 2)];
                NSString *strMonth = [txtIDType.text substringWithRange:NSMakeRange(8, 2)];
                NSString *strYear = [txtIDType.text substringWithRange:NSMakeRange(10, 2)];
                
				
				int intDate = [strDate integerValue];
				if (intDate > 40 && intDate < 72) {
					intDate = intDate - 40;
					if (intDate <10)
						strDate = [NSString stringWithFormat:@"0%d", intDate];
					else
						strDate = [NSString stringWithFormat:@"%d", intDate];
				}
				else if (intDate > 0 && intDate < 31) {

				}
				
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
                NSLog(@"DOB:%@",strDOB);
                
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
                    
                    rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                    rrr.tag = 1002;
                    [rrr show];
                    [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                    
                }
                else if ([strMonth intValue] > 12 || [strMonth intValue] < 1) {
                    
                    rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK month must be between 1 and 12." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                    rrr.tag = 1002;
                    [rrr show];
                    [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                }
                else if([strDate intValue] < 1 || [strDate intValue] > 31)
                {
                    
                    rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK day must be between 1 and 31 or 41 and 71" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                    rrr.tag = 1002;
                    [rrr show];
                    [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                    
                }
                else if (([strMonth isEqualToString:@"01"] || [strMonth isEqualToString:@"03"] || [strMonth isEqualToString:@"05"] || [strMonth isEqualToString:@"07"] || [strMonth isEqualToString:@"08"] || [strMonth isEqualToString:@"10"] || [strMonth isEqualToString:@"12"]) && [strDate intValue] > 31) {
                    
                    
                    rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                    rrr.tag = 1002;
                    [rrr show];
                    [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                    
                }
                
                else if (([strMonth isEqualToString:@"04"] || [strMonth isEqualToString:@"06"] || [strMonth isEqualToString:@"09"] || [strMonth isEqualToString:@"11"]) && [strDate intValue] > 30) {
                    
                    
                    rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                    rrr.tag = 1002;
                    [rrr show];
                    [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                    
                }
                else if (([febStatus isEqualToString:@"Normal"] && [strDate intValue] > 28 && [strMonth isEqualToString:@"02"]) || ([febStatus isEqualToString:@"Jump"] && [strDate intValue] > 29 && [strMonth isEqualToString:@"02"])) {
                    
                    
                    NSString *msg = [NSString stringWithFormat:@"February of %@ doesn’t have 29 days",strYear] ;
                    
                    
                    rrr = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                    
                    [rrr show];
                    [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                }
                
                
                
                strDate = nil, strMonth = nil, strYear = nil, currentYear = nil, strCurrentYear = nil;
                dateFormatter = Nil, strDOB = nil, strDOB2 = nil, d = Nil, d2 = Nil;
            }
            
            alphaNums = nil, inStringSet = nil;
        }
        
        //   [txtIDType removeTarget:self action:@selector(NewICDidChange:) forControlEvents:UIControlEventEditingDidEnd];
        
		
        //   self.navigationItem.rightBarButtonItem.enabled = TRUE;
        
        
        
        
        //KY END CHECK IC
        
        
        
        if ((txtOtherIDType.text.length == 0 ) && ![otherIDTypeTrim isEqualToString:@"- SELECT -"] && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"] && ![otherIDTypeTrim isEqualToString:@""])
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag= 82;
            [alert show];
            [ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        else if (txtOtherIDType.text.length!=0){
            
            if([textFields validateOtherID:txtOtherIDType.text])
            {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @" "
                                      message:@"Invalid Other ID."
                                      delegate: self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                alert.tag = 81;
                [alert show];
                alert = Nil;
                [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
        }
        
        //ky add DOB AND GENDER CHECKING !!!
        if(txtIDType.text.length==0 && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
        {
            if([str_dob isEqualToString:@"- SELECT -"]){
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Date of Birth is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag = 83;
                
                [alert show];
                [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            else  if(segGender.selectedSegmentIndex == -1 ){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Gender is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                
                [alert show];
                [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
        }
        
        
        
        if ([txtOtherIDType.text isEqualToString:txtIDType.text] && txtOtherIDType.text.length != 0 && txtIDType.text.length !=0 )
        {
            
            rrr = [[UIAlertView alloc] initWithTitle:@" "
                                             message:@"Other ID cannot be same as New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            rrr.tag = 81;
            [rrr show];
            rrr = nil;
            
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
        
        
        //Other ID Type as ‘SINGAPOREAN IDENTIFICATION NUMBER’, then the “Nationality” must be “Singaporean”.
        NSString *otherIDtype = [otherIDTypeTrim stringByTrimmingCharactersInSet:
                                 [NSCharacterSet whitespaceCharacterSet]];
        
        if ([otherIDtype isEqualToString:@"SINGAPOREAN IDENTIFICATION NUMBER"] && ![nation isEqualToString:@"SINGAPOREAN"]  )
        {
            
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Nationality must be Singaporean" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            alert.tag= 1005;
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
		
		
        //COMPARE THE DATE
        
        
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd/MM/yyyy"];
        NSDate *d = [NSDate date];
        
        
        NSString *strDate =[outletDOB.titleLabel.text stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]];
        
        
        
        NSDate* d2 = [df dateFromString:strDate];
        
        
        NSDateFormatter *formatter;
        NSString        *today;
        
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        
        today = [formatter stringFromDate:[NSDate date]];
        
        
        NSString        *dateString;
        dateString = [formatter stringFromDate:[NSDate date]];
        
        
        
        if([otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"] && [dateString isEqualToString:strDate])
            
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Expected Delivery Date must be future date." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            [alert show];
            
            
            outletDOB.titleLabel.textColor =  [UIColor redColor];
            alert = Nil;
            DATE_OK = NO;
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        /*
         else if(![OtherIDType.titleLabel.text isEqualToString:@"EXPECTED DELIVERY DATE"] && [dateString isEqualToString:strDate])
         
         {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
         message:@"Date of Birth cannot be current date." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
         [alert show];
         
         
         outletDOB.titleLabel.textColor =  [UIColor redColor];
         alert = Nil;
         DATE_OK = NO;
         return false;
         }
         */
        
        
        else if ([otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"] && [d compare:d2] == NSOrderedDescending) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Expected Delivery Date must be future date." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            [alert show];
            
            
            outletDOB.titleLabel.textColor =  [UIColor redColor];
            alert = Nil;
            DATE_OK = NO;
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
        else if (![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"] && ![otherIDTypeTrim isEqualToString:@"- SELECT -"] &&  ![otherIDTypeTrim isEqualToString:@"Birth Certification"] && [d compare:d2] == NSOrderedAscending) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Date of Birth cannot be greater than today’s date." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            [alert show];
            
            
            outletDOB.titleLabel.textColor =  [UIColor redColor];
            alert = Nil;
            DATE_OK = NO;
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
		//CHECK Country of Birth
		if([BCountry isEqualToString:@"- SELECT -"]&& ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Country Of Birth is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			alert.tag = 1013;
            [alert show];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
        
        if([race isEqualToString:@"- SELECT -"] && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Race is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag= 1010;
            [alert show];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
        //CHECK NATIONALITY
        if([nation isEqualToString:@"- SELECT -"]&& ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
        {
            rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"Nationality is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            rrr.tag = 1005;
            [rrr show];
            
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
//        else if (txtIDType.text.length != 0 && ![nation isEqualToString:@"MALAYSIAN"]) {
//            
//            rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"Nationality didn’t match with New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            rrr.tag = 1005;
//            [rrr show];
//            
//			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
//            return false;
//        }
        //check for singaporean
        else if ([otherIDTypeTrim isEqualToString:@"SINGAPORE IDENTIFICATION NUMBER"] && ![nation isEqualToString:@"SINGAPOREAN"]) {
            
            rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"Nationality didn’t match with Other ID No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            rrr.tag = 1005;
            [rrr show];
            
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        //check for MALAYSIAN FOR OTHER ID
        //The Nationality must be 'Malaysian'
        else if (([otherIDTypeTrim isEqualToString:@"ARMY IDENTIFICATION NUMBER"] || [otherIDTypeTrim  isEqualToString:@"BIRTH CERTIFICATE"] || [otherIDTypeTrim  isEqualToString:@"OLD IDENTIFICATION NO"] || [otherIDTypeTrim  isEqualToString:@"POLICE IDENTIFICATION NUMBER"]) && ![nation isEqualToString:@"MALAYSIAN"]) {
            
            rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"Nationality didn’t match with Other ID No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            rrr.tag = 1005;
            [rrr show];
            
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
        //the Nationality must NOT be “Malaysian
        else if (([otherIDTypeTrim isEqualToString:@"FOREIGNER BIRTH CERTIFICATE"] || [otherIDTypeTrim  isEqualToString:@"FOREIGNER IDENTIFICATION NUMBER"] || [otherIDTypeTrim  isEqualToString:@"PERMANENT RESIDENT"]) && [nation isEqualToString:@"MALAYSIAN"]) {
            
            rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"Nationality didn’t match with Other ID No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            rrr.tag = 1005;
            [rrr show];
            
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
        //START ....IC MUST MATCH DOB, GENDER WHEN DISPLAY THE EXISTING RECORD
        // if ([prospectprofile.IDTypeNo isEqualToString:@""] || prospectprofile.IDTypeNo == NULL) {
        
        
        
        if(getSameRecord_Indexno != NULL){
            
            NSString *otherIDTypeTrim = [OtherIDType.titleLabel.text stringByTrimmingCharactersInSet:
                                         [NSCharacterSet whitespaceCharacterSet]];
            
            if(([otherIDTypeTrim isEqualToString:@"PASSPORT"] || [otherIDTypeTrim  isEqualToString:@"BIRTH CERTIFICATE"] || [otherIDTypeTrim  isEqualToString:@"OLD IDENTIFICATION NO"] )  && (txtIDType.text.length==12) )
            {
                
                //ky
                //get the DOB value from ic entered
                
                NSString *strDate = [txtIDType.text substringWithRange:NSMakeRange(4, 2)];
                NSString *strMonth = [txtIDType.text substringWithRange:NSMakeRange(2, 2)];
                NSString *strYear = [txtIDType.text substringWithRange:NSMakeRange(0, 2)];
                
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
                
                
                NSString *dob_trim = [txtDOB.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                
                //ky - crash bec of  '- SELECT -'
                if(![dob_trim isEqualToString:@"- SELECT -"]){
                    NSArray  *temp_dob = [txtDOB.text componentsSeparatedByString:@"/"];
                    
                    NSString *day = [temp_dob objectAtIndex:0];
                    day = [day stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    NSString *month = [temp_dob objectAtIndex:1];
                    NSString *year = [temp_dob objectAtIndex:2];
                    
                    
                    NSString *ic_gender;
                    
                    NSString *last = [txtIDType.text substringFromIndex:[txtIDType.text length] -1];
                    NSCharacterSet *oddSet = [NSCharacterSet characterSetWithCharactersInString:@"13579"];
                    
                    if ([last rangeOfCharacterFromSet:oddSet].location != NSNotFound) {
                        // NSLog(@"IC MALE");
                        ic_gender = @"MALE";
                        
                    } else {
                        //NSLog(@"IC  FEMALE");
                        ic_gender = @"FEMALE";
                        
                    }
                    
                    
                    
                    if(![day isEqualToString:strDate] || ![month isEqualToString:strMonth] || ![year isEqualToString:strYear])
                    {
                        rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No does not match with Date of Birth." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                        rrr.tag = 1002;
                        [rrr show];
                        rrr = nil;
                        [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                        return false;
                        
                    }
                    else if(([ic_gender isEqualToString:@"MALE"] && segGender.selectedSegmentIndex !=0) || ([ic_gender isEqualToString:@"FEMALE"] && segGender.selectedSegmentIndex !=1))
                    {
                        
                        rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No does not match with Gender." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                        rrr.tag = 1002;
                        [rrr show];
                        rrr = nil;
                        [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                        return false;
                    }
                }
                
                
            }
        }
        //END  .....
        
		
		
		
		
		
        //CHECK NATIONALITY
        
        if([nation isEqualToString:@"- SELECT -"]&& ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Nationality is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 1005;
            [alert show];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
        //CHECK RELIGION
        if([religion isEqualToString:@"- SELECT -"] && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Religion is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 1011;
            [alert show];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
        
        //CHECK MARITAL STATUS
        if([marital isEqualToString:@"- SELECT -"] && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Marital status is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 1009;
            [alert show];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
        
        
        
        //START CHECK SMOKING
        if((segSmoker.selectedSegmentIndex == -1) && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Smoking status is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [self resignFirstResponder];
            [self.view endEditing:TRUE];
            
            [alert show];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
        
        if((segRigPerson.selectedSegmentIndex == 0) && (txtRigNO.text.length<=0))
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"GST Registered No is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [self resignFirstResponder];
            [self.view endEditing:TRUE];
            [alert show];
            return false;
        }
        
                if((segRigPerson.selectedSegmentIndex == 0) && [RigDateOutlet isEqualToString:@"- SELECT -"])
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                    message:@"GST Registration Date is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [self resignFirstResponder];
                    [self.view endEditing:TRUE];
                    [alert show];
                    outletRigDate.titleLabel.textColor = [UIColor redColor];
                    return false;
                }
        
//       if([d compare:d2] == NSOrderedAscending)
//       {
//           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
//                                                           message:@"Date of Birth cannot be greater than today’s date." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
//           [alert show];
//           
//           
//           outletDOB.titleLabel.textColor =  [UIColor redColor];
//           alert = Nil;
//           DATE_OK = NO;
//
//       }
        
        
//        if((segRigPerson.selectedSegmentIndex == 0) && (txtRigDate.text.length >0) && (txtRigNO.text.length >0) && (segRigPerson.selectedSegmentIndex == -1))
//        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
//                                                            message:@"GST Registered Date cannot be blank. Please fill up the date in order to proceed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [self resignFirstResponder];
//            [self.view endEditing:TRUE];
//            [alert show];
//            
//            return false;
//        }
        
        
        
        if(segRigExempted.selectedSegmentIndex == -1)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"GST Exempted is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [self resignFirstResponder];
            [self.view endEditing:TRUE];
            [alert show];
            
            return false;
        }


        
        
        
        // CHECK OCCUPATION
        if(([OccupCodeSelected isEqualToString:@""]  && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"]) ||(OccupCodeSelected == NULL && !companyCase && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Occupation is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            alert.tag = 84;
            [alert show];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
        
        
        if([OccpCatCode isEqualToString:@"HSEWIFE"]
           ||[OccpCatCode isEqualToString:@"JUV"]
           ||[OccpCatCode isEqualToString:@"RET"]
           ||[OccpCatCode isEqualToString:@"STU"]
           ||[OccpCatCode isEqualToString:@"UNEMP"]
           ||([otherIDTypeTrim isEqualToString:@"COMPANY REGISTRATION NUMBER"] && txtOtherIDType.text.length != 0)){
            
            NSLog(@"here if");
        }
        else{
            
            
            if (txtExactDuties.text.length < 1 && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Exact nature of work is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag = 1007;
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            else if (txtExactDuties.text.length > 40) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Invalid Exact Duties length. Only 40 characters allowed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag = 1007;
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
            if ([txtBussinessType.text isEqualToString:@""] && [otherIDTypeTrim isEqualToString:@"COMPANY REGISTRATION NUMBER"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Type of business is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag=2060;
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
            if (txtBussinessType.text.length > 60 && ![otherIDTypeTrim isEqualToString:@"COMPANY REGISTRATION NUMBER"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Invalid Type of Business length. Only 60 characters allowed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag=2060;
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
            
            NSString * AI = [annualIncome_original stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceCharacterSet]];
            
            NSArray  *comp = [AI componentsSeparatedByString:@"."];
            
            
            
            int AI_Length = 0;
            
            if([comp objectAtIndex:0]==nil)
                
                AI_Length = 0;
            else
                AI_Length = [[comp objectAtIndex:0] length];
            
            
            
            if ([txtAnnIncome.text isEqualToString:@""] && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"]) {
                
                
                
                if((![OccpCatCode isEqualToString:@"HSEWIFE"])
                   && (![OccpCatCode isEqualToString:@"JUV"])
                   && (![OccpCatCode isEqualToString:@"RET"])
                   && (![OccpCatCode isEqualToString:@"STU"])
                   && (![OccpCatCode isEqualToString:@"UNEMP"])) {
                    
                    
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                    message:@"Annual Income is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    alert.tag = 1008;
                    [alert show];
                    
                    [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                }
                
                
                
                
            }
            
            
            else if (AI_Length >13  && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"]) {
                
                
                if((![OccpCatCode isEqualToString:@"HSEWIFE"])
                   && (![OccpCatCode isEqualToString:@"JUV"])
                   && (![OccpCatCode isEqualToString:@"RET"])
                   && (![OccpCatCode isEqualToString:@"STU"])
                   && (![OccpCatCode isEqualToString:@"UNEMP"])) {
                    
                    
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                    message:@"Annual income must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    alert.tag = 1008;
                    [alert show];
                    
                    [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                }
                
                
                
                
                
            }
            else if(AI_Length < 13 && annual_income == 0 && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
            {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Annual income must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag = 1008;
                [rrr show];
                rrr = nil;
                
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            else if([otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"] && [strDate isEqualToString:@"- SELECT -"]){
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Date of Birth is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag = 83;
	
                [alert show];
				
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
            
            
        }
        
        if(checked){
            
            NSString *homecountry = [btnHomeCountry.titleLabel.text stringByTrimmingCharactersInSet:
                                     [NSCharacterSet whitespaceCharacterSet]];
            if(home1_trim.length==0  && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Residential Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag = 1012;
                
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
                
            }
            else   if([homecountry isEqualToString:@"- SELECT -"])
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Country for residential address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag = 5001;
                [alert show];
                [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
            
            
            
            
        }
        else{
            
            
            //FOR RETIRED/UNEMPLOY - IS OPTIONAL TO KEY IN ANNUAL INCOME, IF KEY IN NEED TO CHECK ALSO
            NSString * AI = [annualIncome_original stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceCharacterSet]];
            
            NSArray  *comp = [AI componentsSeparatedByString:@"."];
            
            int AI_Length = [[comp objectAtIndex:0] length];
            
            if (AI_Length < 13 && annual_income == 0 && txtAnnIncome.text.length!=0)
            {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Annual income must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag = 1008;
                [rrr show];
                rrr = nil;
                
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
                
            }
            
            
            if(home1_trim.length==0  && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Residential Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag = 1012;
                
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
                
            }else if (homePostcode_trim.length==0 && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
            {
                if (homePostcode_trim.length==0) {
                    
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                    message:@"Postcode for residential address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    alert.tag=2000;
                    
                    [alert show];
					[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                }else if(home1_trim.length==0){
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                    message:@"Residential Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    alert.tag = 1012;
                    
                    [alert show];
					[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                }
                
            }
            else if (![txtHomePostCode.text isEqualToString:@""] && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
            {
                
                //HOME POSTCODE START
                //CHECK INVALID SYMBOLS
                NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
                
                HomePostcodeContinue = false;
                BOOL valid;
                BOOL valid_symbol;
                
                NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                
                NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtHomePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
                
                valid = [alphaNums isSupersetOfSet:inStringSet];
                valid_symbol = [set isSupersetOfSet:inStringSet];
                
                txtHomePostCode.text = [txtHomePostCode.text stringByTrimmingCharactersInSet:
                                        [NSCharacterSet whitespaceCharacterSet]];
                
                if(txtHomePostCode.text.length < 5)
                {
                    rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                     message:@"Postcode for Residential Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    rrr.tag = 2001;
                    [rrr show];
                    rrr=nil;
					[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                }
                
                else if (!valid_symbol && !checked) {
                    txtHomeState.text=@"";
                    txtHomeState.text = @"";
                    rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                     message:@"Postcode for Residential Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    rrr.tag = 2001;
                    [rrr show];
                    rrr=nil;
                    [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                    
                }
                
                
                else if (!valid && !checked) {
                    txtHomeState.text=@"";
                    txtHomeState.text = @"";
                    rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                     message:@"Postcode for Residential Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    rrr.tag = 2001;
                    [rrr show];
                    
                    rrr=nil;
                    
                    txtHomeState.text = @"";
                    txtHomeTown.text = @"";
                    txtHomeCountry.text = @"";
                    SelectedStateCode = @"";
                    PostcodeContinue = FALSE;
                    
					[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                }
                else{
                    
                    BOOL gotRow = false;
                    const char *dbpath = [databasePath UTF8String];
                    sqlite3_stmt *statement;
                    
                    
                    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
                        NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", txtHomePostCode.text];
                        
                        
                        const char *query_stmt = [querySQL UTF8String];
                        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                        {
                            
                            while (sqlite3_step(statement) == SQLITE_ROW){
                                NSString *Town = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                                NSString *State = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                                NSString *Statecode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                                
                                txtHomeState.text = State;
                                txtHomeTown.text = Town;
                                txtHomeCountry.text = @"MALAYSIA";
                                SelectedStateCode = Statecode;
                                gotRow = true;
                                HomePostcodeContinue = TRUE;
                                
                                self.navigationItem.rightBarButtonItem.enabled = TRUE;
                            }
                            sqlite3_finalize(statement);
                        }
                        else{
                            txtHomeState.text = @"";
                            txtHomeTown.text = @"";
                            txtHomeCountry.text = @"";
                        }
                        
                        
                        sqlite3_close(contactDB);
                    }
                    
                    if(!HomePostcodeContinue && !checked)
                    {
                        txtHomeState.text = @"";
                        txtHomeTown.text = @"";
                        txtHomeCountry.text = @"";
                        SelectedStateCode = @"";
                        
                        
                        txtHomeState.text=@"";
                        txtHomeState.text = @"";
                        rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                         message:@"Postcode for Residential Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        rrr.tag = 2001;
                        [rrr show];
                        rrr=nil;
                        [txtHomePostCode addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
						[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                        return false;
                        
                        
                    }
                    
                    
                }
                //HOME POSTCODE END
                
                
                
                
            }
            
            
            
        }
        
        
        
        
        
        //office post code  end
        
        // Office address
        // Added by Benjamin Law on 17/10/2013 for bug 2561
        
        if(!([OccpCatCode isEqualToString:@"HSEWIFE"]
             ||[OccpCatCode isEqualToString:@"JUV"]
             ||[OccpCatCode isEqualToString:@"RET"]
             ||[OccpCatCode isEqualToString:@"STU"]
             ||[OccpCatCode isEqualToString:@"UNEMP"])) {
            
            if(checked2){
                
                
                NSString *officecountry = [btnOfficeCountry.titleLabel.text stringByTrimmingCharactersInSet:
                                           [NSCharacterSet whitespaceCharacterSet]];
                
                if(office1_trim.length==0 && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
                {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                    message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    alert.tag = 2002;
                    [alert show];
					[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                    
                }
                if([officecountry isEqualToString:@"- SELECT -"])
                {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                    message:@"Country for office address is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    alert.tag=5002;
                    
                    [alert show];
					[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                }
                
            }
            else{
                
                
                if(office1_trim.length==0  && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
                {
                    
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                    message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    alert.tag = 2002;
                    
                    [alert show];
					[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                    
                }else if (officePostcode_trim.length==0 && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
                {
                    if (office1_trim.length==0) {
                        
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                        message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        alert.tag = 2002;
                        [alert show];
						[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                        return false;
                    }else if(officePostcode_trim.length==0){
                        
                        
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                        message:@"Postcode for Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        alert.tag = 3001;
                        
                        [alert show];
						[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                        return false;
                    }
                    
                }
                else if (![txtOfficePostcode.text isEqualToString:@""] && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
                {
                    
                    //HOME POSTCODE START
                    //CHECK INVALID SYMBOLS
                    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
                    
                    
                    BOOL valid;
                    BOOL valid_symbol;
                    
                    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                    
                    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtOfficePostcode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
                    
                    valid = [alphaNums isSupersetOfSet:inStringSet];
                    valid_symbol = [set isSupersetOfSet:inStringSet];
                    
                    if(officePostcode_trim.length < 5)
                    {
                        rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                         message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        rrr.tag = 3001;
                        [rrr show];
                        rrr=nil;
						[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                        return false;
                    }
                    
                    else  if (!valid_symbol) {
                        
                        txtOfficeState.text = @"";
                        txtOfficeTown.text = @"";
                        rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                         message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        rrr.tag = 3001;
                        [rrr show];
                        rrr=nil;
						
                        [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                        return false;
                        
                    }
                    
                    
                    else if (!valid) {
                        
                        rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                         message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        rrr.tag = 3001;
                        [rrr show];
                        
                        rrr=nil;
                        
                        txtHomeState.text = @"";
                        txtHomeTown.text = @"";
                        txtHomeCountry.text = @"";
                        SelectedStateCode = @"";
						[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                        return false;
                    }
                    else{
                        const char *dbpath = [databasePath UTF8String];
                        sqlite3_stmt *statement;
                        
                        txtOfficePostcode.text = [txtOfficePostcode.text stringByReplacingOccurrencesOfString:@" " withString:@""];
                        
                        
                        
                        
                        
                        //CHECK INVALID SYMBOLS
                        NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
                        
                        
                        BOOL valid;
                        BOOL valid_symbol;
                        
                        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                        
                        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtOfficePostcode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
                        
                        valid = [alphaNums isSupersetOfSet:inStringSet];
                        valid_symbol = [set isSupersetOfSet:inStringSet];
                        OfficePostcodeContinue = false;
                        
                        if(!checked2)
                        {
                            if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
                                NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", txtOfficePostcode.text];
                                
                                
                                
                                const char *query_stmt = [querySQL UTF8String];
                                if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                                {
                                    while (sqlite3_step(statement) == SQLITE_ROW){
                                        NSString *OfficeTown = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                                        NSString *OfficeState = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                                        NSString *Statecode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                                        
                                        txtOfficeState.text = OfficeState;
                                        txtOfficeTown.text = OfficeTown;
                                        txtOfficeCountry.text = @"MALAYSIA";
                                        SelectedOfficeStateCode = Statecode;
                                        
                                        OfficePostcodeContinue = TRUE;
                                        self.navigationItem.rightBarButtonItem.enabled = TRUE;
                                    }
                                    sqlite3_finalize(statement);
                                    
                                    
                                    sqlite3_close(contactDB);
                                }
                                else{
                                    txtOfficeState.text = @"";
                                    txtOfficeTown.text = @"";
                                    txtOfficeCountry.text = @"";
                                }
                            }
                            if(!OfficePostcodeContinue)
                            {
                                txtOfficeState.text = @"";
                                txtOfficeTown.text = @"";
                                txtOfficeCountry.text = @"";
                                SelectedStateCode = @"";
                                
                                
                                
                                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                                 message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                
                                rrr.tag = 3001;
                                [rrr show];
                                rrr=nil;
                                [txtOfficePostcode addTarget:self action:@selector(OfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                                [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                                return false;
                                
                                
                            }
                        }
                    }
                    
                    
                    //HOME POSTCODE END
                    
                }
                
                
                
            }
            
        }
        //KY  START - IF USER KEY IN OFFICE ADDRESS PARTIALLY, SYSTEM SHOULD CHECK ON THIS
        else if (([OccpCatCode isEqualToString:@"HSEWIFE"]
                  ||[OccpCatCode isEqualToString:@"JUV"]
                  ||[OccpCatCode isEqualToString:@"RET"]
                  ||[OccpCatCode isEqualToString:@"STU"]
                  ||[OccpCatCode isEqualToString:@"UNEMP"]) && (![txtOfficeAddr1.text isEqualToString:@""] || ![txtOfficePostcode.text isEqualToString:@""]))
        {
            
            
            if((office1_trim.length!= 0  || ![txtOfficeAddr2.text isEqualToString:@""] ||![txtOfficeAddr3.text isEqualToString:@""] ) && officePostcode_trim.length==0 && (!checked2))
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Postcode for Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag = 3001;
                
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
                
            }
            else  if(office1_trim.length==0  && officePostcode_trim.length!= 0)
                
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag = 2002;
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
                
            }
            else if (![txtOfficePostcode.text isEqualToString:@""] && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
            {
                
                //HOME POSTCODE START
                //CHECK INVALID SYMBOLS
                NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
                
                
                BOOL valid;
                BOOL valid_symbol;
                
                NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                
                NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtOfficePostcode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
                
                valid = [alphaNums isSupersetOfSet:inStringSet];
                valid_symbol = [set isSupersetOfSet:inStringSet];
                
                
                if(officePostcode_trim.length < 5)
                {
                    rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                     message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    rrr.tag = 3001;
                    [rrr show];
                    rrr=nil;
					[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                }
                
                else if (!valid_symbol) {
                    
                    txtOfficeState.text = @"";
                    txtOfficeTown.text = @"";
                    rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                     message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    rrr.tag = 3001;
                    [rrr show];
                    rrr=nil;
                    [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                    
                }
                
                
                else if (!valid && !checked2) {
                    
                    rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                     message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    rrr.tag = 3001;
                    [rrr show];
                    
                    rrr=nil;
                    
                    txtHomeState.text = @"";
                    txtHomeTown.text = @"";
                    txtHomeCountry.text = @"";
                    SelectedStateCode = @"";
					[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                    return false;
                }
                else{
                    const char *dbpath = [databasePath UTF8String];
                    sqlite3_stmt *statement;
                    
                    txtOfficePostcode.text = [txtOfficePostcode.text stringByReplacingOccurrencesOfString:@" " withString:@""];
                    
                    
                    
                    
                    
                    //CHECK INVALID SYMBOLS
                    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
                    
                    
                    BOOL valid;
                    BOOL valid_symbol;
                    
                    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                    
                    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtOfficePostcode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
                    
                    valid = [alphaNums isSupersetOfSet:inStringSet];
                    valid_symbol = [set isSupersetOfSet:inStringSet];
                    OfficePostcodeContinue = false;
                    
                    if(!checked2)
                    {
                        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
                            NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", txtOfficePostcode.text];
                            
                            
                            
                            const char *query_stmt = [querySQL UTF8String];
                            if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                            {
                                while (sqlite3_step(statement) == SQLITE_ROW){
                                    NSString *OfficeTown = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                                    NSString *OfficeState = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                                    NSString *Statecode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                                    
                                    txtOfficeState.text = OfficeState;
                                    txtOfficeTown.text = OfficeTown;
                                    txtOfficeCountry.text = @"MALAYSIA";
                                    SelectedOfficeStateCode = Statecode;
                                    
                                    OfficePostcodeContinue = TRUE;
                                    self.navigationItem.rightBarButtonItem.enabled = TRUE;
                                }
                                sqlite3_finalize(statement);
                                
                                
                                sqlite3_close(contactDB);
                            }
                            else{
                                txtOfficeState.text = @"";
                                txtOfficeTown.text = @"";
                                txtOfficeCountry.text = @"";
                                
                            }
                        }
                        if(!OfficePostcodeContinue && !checked2)
                        {
                            txtOfficeState.text = @"";
                            txtOfficeTown.text = @"";
                            txtOfficeCountry.text = @"";
                            SelectedStateCode = @"";
                            
                            
                            
                            rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                             message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            
                            rrr.tag = 3001;
                            [rrr show];
                            rrr=nil;
                            [txtOfficePostcode addTarget:self action:@selector(OfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                            [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                            return false;
                            
                            
                        }
                    }
                    
                }
                
                
                //HOME POSTCODE END
                
            }
            
            
            
        }
        //KY  END - IF USER KEY IN OFFICE ADDRESS PARTIALLY, SYSTEM SHOULD CHECK ON THIS
        
    }
    
    
    
    
    //######office address#######
    
    if(checked2){
        NSString *officecountry = [btnOfficeCountry.titleLabel.text stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
        
        if(office1_trim.length==0 && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 2002;
            [alert show];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
            
        }
        if([officecountry isEqualToString:@"- SELECT -"])
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Country for office address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            alert.tag=5002;
            [alert show];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
    }
    
    
    else  if((![OccpCatCode isEqualToString:@"HSEWIFE"])
             && (![OccpCatCode isEqualToString:@"JUV"])
             && (![OccpCatCode isEqualToString:@"RET"])
             && (![OccpCatCode isEqualToString:@"STU"])
             && (![OccpCatCode isEqualToString:@"UNEMP"])) {
        
        
        if(office1_trim.length==0 && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
        {
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 2002;
            [alert show];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
            
        }else if (  ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
        {
            
            
            BOOL valid;
            BOOL valid_symbol;
            
            NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
            
            NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtOfficePostcode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
            
            NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
            
            valid = [alphaNums isSupersetOfSet:inStringSet];
            valid_symbol = [set isSupersetOfSet:inStringSet];
            
            
            
            
            
            if (office1_trim.length==0) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag = 2002;
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }else if(officePostcode_trim.length==0){
                
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Postcode for Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag = 3001;
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
            //CHECK OFFICE POSTCODE- START
            
            
            else  if(officePostcode_trim.length < 5)
            {
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                rrr.tag = 3001;
                [rrr show];
                rrr=nil;
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            else  if (!valid_symbol) {
                
                txtOfficeState.text = @"";
                txtOfficeTown.text = @"";
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                rrr.tag = 3001;
                [rrr show];
                rrr=nil;
                
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
                
            }
            
            
            else if (!valid) {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                rrr.tag = 3001;
                [rrr show];
                
                rrr=nil;
                
                txtHomeState.text = @"";
                txtHomeTown.text = @"";
                txtHomeCountry.text = @"";
                SelectedStateCode = @"";
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            else{
                const char *dbpath = [databasePath UTF8String];
                sqlite3_stmt *statement;
                
                txtOfficePostcode.text = [txtOfficePostcode.text stringByReplacingOccurrencesOfString:@" " withString:@""];
                
                
                
                
                
                //CHECK INVALID SYMBOLS
                NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
                
                
                BOOL valid;
                BOOL valid_symbol;
                
                NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                
                NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtOfficePostcode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
                
                valid = [alphaNums isSupersetOfSet:inStringSet];
                valid_symbol = [set isSupersetOfSet:inStringSet];
                OfficePostcodeContinue = false;
                
                if(!checked2)
                {
                    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
                        NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", txtOfficePostcode.text];
                        
                        
                        
                        const char *query_stmt = [querySQL UTF8String];
                        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                        {
                            while (sqlite3_step(statement) == SQLITE_ROW){
                                NSString *OfficeTown = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                                NSString *OfficeState = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                                NSString *Statecode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                                
                                txtOfficeState.text = OfficeState;
                                txtOfficeTown.text = OfficeTown;
                                txtOfficeCountry.text = @"MALAYSIA";
                                SelectedOfficeStateCode = Statecode;
                                
                                OfficePostcodeContinue = TRUE;
                                self.navigationItem.rightBarButtonItem.enabled = TRUE;
                            }
                            sqlite3_finalize(statement);
                            
                            
                            sqlite3_close(contactDB);
                        }
                        else{
                            txtOfficeState.text = @"";
                            txtOfficeTown.text = @"";
                            txtOfficeCountry.text = @"";
                        }
                    }
                    if(!OfficePostcodeContinue)
                    {
                        txtOfficeState.text = @"";
                        txtOfficeTown.text = @"";
                        txtOfficeCountry.text = @"";
                        SelectedStateCode = @"";
                        
                        
                        
                        rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                         message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        rrr.tag = 3001;
                        [rrr show];
                        rrr=nil;
                        [txtOfficePostcode addTarget:self action:@selector(OfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                        [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                        return false;
                        
                        
                    }
                    
                }
            }
            
            //CHECK OFFICE POSTCODE - END
            
        }
        
        
        
        
        
    }
    
    
    
    //######office address#######
    
    
    if([txtPrefix1.text isEqualToString:@""]&&[txtContact1.text isEqualToString:@""]&&[txtPrefix2.text isEqualToString:@""]&&[txtContact2.text isEqualToString:@""]&&[txtPrefix3.text isEqualToString:@""]&&[txtContact3.text isEqualToString:@""]&&[txtPrefix4.text isEqualToString:@""]&&[txtContact4.text isEqualToString:@""] && ![otherIDTypeTrim isEqualToString:@"EXPECTED DELIVERY DATE"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"Please enter at least one of the contact numbers (Residential, Office, Mobile or Fax)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        alert.tag = 2003;
        [alert show];
		[ClientProfile setObject:@"NO" forKey:@"TabBar"];
        return false;
        
    }
    else{
        
        //##Contact######
        
        //Home number
        
        if (![txtPrefix1.text isEqualToString:@""])
        {
            
            if(txtPrefix1.text.length > 4) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Prefix length cannot be more than 4 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag=2003;
                
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
            NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init] ;
            
            NSNumber* prefix1 = [numberFormatter numberFromString:txtPrefix1.text];
            
            NSNumber* contact1 = [numberFormatter numberFromString:txtContact1.text];
            
            
            //KY START
            
            
            BOOL valid;
            BOOL valid2;
            NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
            NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:txtContact1.text];
            NSCharacterSet *inStringSet2 = [NSCharacterSet characterSetWithCharactersInString:txtPrefix1.text];
            
            valid = [alphaNums isSupersetOfSet:inStringSet];
            valid2 = [alphaNums isSupersetOfSet:inStringSet2];
            if (!valid2) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag = 2003;
                
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            if (!valid) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag= 2004;
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            //KY END
            
            
            
            if([txtContact1.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Residential number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag=2004;
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
                
                
            }
            else if (txtContact1.text.length < 6) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Residential number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag=2004;
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            else if(prefix1==nil)
            {
                rrr  = [[UIAlertView alloc] initWithTitle:@" "
                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag=2003;
                [rrr show];
                rrr = nil;
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            else  if(contact1==nil)
            {
                rrr  = [[UIAlertView alloc] initWithTitle:@" "
                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag=2004;
                [rrr show];
                rrr = nil;
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
        }
        else{
            
            if(![txtContact1.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Prefix for residential number is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                
                alert.tag=2003;
                [alert show];
                [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
        }
        
        //#####mobile number#####
        
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init] ;
        
        NSNumber* prefix2 = [numberFormatter numberFromString:txtPrefix2.text];
        
        NSNumber* contact2 = [numberFormatter numberFromString:txtContact2.text];
        
        if (![txtPrefix2.text isEqualToString:@""])
        {
            
            if(txtPrefix2.text.length > 4) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Prefix length cannot be more than 4 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag=2005;
                
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            BOOL valid;
            BOOL valid2;
            NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
            NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:txtContact2.text];
            NSCharacterSet *inStringSet2 = [NSCharacterSet characterSetWithCharactersInString:txtPrefix2.text];
            
            valid = [alphaNums isSupersetOfSet:inStringSet];
            valid2 = [alphaNums isSupersetOfSet:inStringSet2];
            if (!valid2) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag = 2005;
                
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            if (!valid) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag= 2006;
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
            
            
            if([txtContact2.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Mobile number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag=2006;
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
                
                
            }
            else if (txtContact2.text.length < 6) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Mobile number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag=2006;
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
            else if(prefix2==nil)
            {
                rrr  = [[UIAlertView alloc] initWithTitle:@" "
                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag=2003;
                [rrr show];
                rrr = nil;
                [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            else  if(contact2==nil)
            {
                rrr  = [[UIAlertView alloc] initWithTitle:@" "
                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag=2004;
                [rrr show];
                rrr = nil;
                [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
            
            
        }
        else{
            if(![txtContact2.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Prefix for mobile number is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                
                alert.tag=2005;
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
        }
        
        
        //####office number
        
        if (![txtPrefix3.text isEqualToString:@""])
        {
            
            if(txtPrefix3.text.length > 4) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Prefix length cannot be more than 4 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag=2007;
                
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init] ;
            
            NSNumber* prefix3 = [numberFormatter numberFromString:txtPrefix3.text];
            
            NSNumber* contact3 = [numberFormatter numberFromString:txtContact3.text];
            
            BOOL valid;
            BOOL valid2;
            NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
            NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:txtContact3.text];
            NSCharacterSet *inStringSet2 = [NSCharacterSet characterSetWithCharactersInString:txtPrefix3.text];
            
            valid = [alphaNums isSupersetOfSet:inStringSet];
            valid2 = [alphaNums isSupersetOfSet:inStringSet2];
            if (!valid2) {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                rrr.tag =2007;
                [rrr show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            if (!valid) {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                rrr.tag = 2008;
                [rrr show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
            
            
            if([txtContact3.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Office number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag=2008;
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
                
                
            }
            else if (txtContact3.text.length < 6) {
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Office number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                rrr.tag = 2008;
                [rrr show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
            else if(prefix3==nil)
            {
                rrr  = [[UIAlertView alloc] initWithTitle:@" "
                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag=2007;
                [rrr show];
                rrr = nil;
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            else  if(contact3==nil)
            {
                rrr  = [[UIAlertView alloc] initWithTitle:@" "
                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag=2008;
                [rrr show];
                rrr = nil;
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
            
            
        }
        else{
            if(![txtContact3.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Prefix for office number is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                
                alert.tag=2007;
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
        }
        
        
        //####office fax number
        
        if (![txtPrefix4.text isEqualToString:@""])
        {
            
            if(txtPrefix4.text.length > 4) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Prefix length cannot be more than 4 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag=2009;
                
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init] ;
            
            NSNumber* prefix4 = [numberFormatter numberFromString:txtPrefix4.text];
            
            NSNumber* contact4 = [numberFormatter numberFromString:txtContact4.text];
            
            
            BOOL valid;
            BOOL valid2;
            NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
            NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:txtContact4.text];
            NSCharacterSet *inStringSet2 = [NSCharacterSet characterSetWithCharactersInString:txtPrefix4.text];
            
            valid = [alphaNums isSupersetOfSet:inStringSet];
            valid2 = [alphaNums isSupersetOfSet:inStringSet2];
            if (!valid2) {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                rrr.tag=2009;
                
                [rrr show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
            
            if (!valid) {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                rrr.tag =2010;
                
                [rrr show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
            
            if([txtContact4.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Fax number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag=2010;
                [alert show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
                
                
            }
            else if (txtContact4.text.length < 6) {
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Fax number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag = 2010;
                
                [rrr show];
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
            else if(prefix4==nil)
            {
                rrr  = [[UIAlertView alloc] initWithTitle:@" "
                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag=2003;
                [rrr show];
                rrr = nil;
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            else  if(contact4==nil)
            {
                rrr  = [[UIAlertView alloc] initWithTitle:@" "
                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag=2004;
                [rrr show];
                rrr = nil;
				[ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
            
            
        }
        else{
            if(![txtContact4.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Prefix for fax number is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                
                alert.tag=2009;
                [alert show];
                [ClientProfile setObject:@"NO" forKey:@"TabBar"];
                return false;
            }
            
            
        }
        
        
    }
    
    
    
    if(![txtEmail.text isEqualToString:@""]){
        if( [self NSStringIsValidEmail:txtEmail.text] == FALSE){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"You have entered an invalid email. Please key in the correct email." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            alert.tag = 2050;
            
            [alert show];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
        
        if (txtEmail.text.length > 40) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Invalid Email length. Only 40 characters allowed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 2050;
            [alert show];
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
            return false;
        }
    }
    
	if((segIsGrouping.selectedSegmentIndex == 0) && ([[self ProspectGroup_toString] isEqualToString:@""]))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"Group cannot be empty" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [self resignFirstResponder];
        [self.view endEditing:TRUE];
        [alert show];
        return false;
    }
    
    
    return true;
}


-(void)CheckValidation {
	
    NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	
    //	NSString *exist;
    //	NSString *confirmCase;
    //	if ([self record_exist])
    //		exist = @"1";
    //	else
    //		exist = @"0";
    //
    //	if ([self confirm_case])
    //		confirmCase = @"1";
    //	else
    //		confirmCase = @"0";
    //
    //	[ClientProfile setObject:exist forKey:@"exist"];
    //	[ClientProfile setObject:confirmCase forKey:@"confirmCase"];
	
    if ([self Validation] == TRUE) {
		[ClientProfile setObject:@"1" forKey:@"Validation"];
	}
	else
		[ClientProfile setObject:@"0" forKey:@"Validation"];
	
	[self hideKeyboard];
	
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(void) CheckIfEmpty {
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	
	if (![[ClientProfile objectForKey:@"isNew"] isEqualToString:@"YES"]) {
		
		if (![[textFields trimWhiteSpaces:txtFullName.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtIDType.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtOtherIDType.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtDOB.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtExactDuties.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtAnnIncome.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtHomeAddr1.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtHomeAddr2.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtHomeAddr3.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtHomeCountry.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtHomePostCode.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtHomeState.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtHomeTown.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtOfficeAddr1.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtOfficeAddr2.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtOfficeAddr3.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtOfficeCountry.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtOfficePostcode.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtOfficeState.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtOfficeTown.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtPrefix1.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtPrefix2.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtPrefix3.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtPrefix4.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtContact1.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtContact2.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtContact3.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtContact4.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtClass.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtEmail.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtRemark.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:txtBussinessType.text] isEqualToString:@""]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (segGender.selectedSegmentIndex != -1){
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (segSmoker.selectedSegmentIndex != -1){
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:outletTitle.titleLabel.text] isEqualToString:@""] && ![[textFields trimWhiteSpaces:outletTitle.titleLabel.text] isEqualToString:@"- SELECT -"]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:outletDOB.titleLabel.text] isEqualToString:@""] && ![[textFields trimWhiteSpaces:outletDOB.titleLabel.text] isEqualToString:@"- SELECT -"] && ![[textFields trimWhiteSpaces:outletDOB.titleLabel.text] isEqualToString:@"- Select -"]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:outletRace.titleLabel.text] isEqualToString:@""] && ![[textFields trimWhiteSpaces:outletRace.titleLabel.text] isEqualToString:@"- SELECT -"]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:outletNationality.titleLabel.text] isEqualToString:@""] && ![[textFields trimWhiteSpaces:outletNationality.titleLabel.text] isEqualToString:@"- SELECT -"]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:outletReligion.titleLabel.text] isEqualToString:@""] && ![[textFields trimWhiteSpaces:outletReligion.titleLabel.text] isEqualToString:@"- SELECT -"]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:outletMaritalStatus.titleLabel.text] isEqualToString:@""] && ![[textFields trimWhiteSpaces:outletMaritalStatus.titleLabel.text] isEqualToString:@"- SELECT -"]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (![[textFields trimWhiteSpaces:outletOccup.titleLabel.text] isEqualToString:@""] && ![[textFields trimWhiteSpaces:outletOccup.titleLabel.text] isEqualToString:@"- SELECT -"]) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (checked) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		else if (checked2) {
			[ClientProfile setObject:@"YES" forKey:@"isNew"];
		}
		
		
		[self IDValidation];
        //		[self OtherIDValidation];
	}
    
    
}

-(void) NIK_checking {
	
	//	Nomor Induk Kependudukan
	//	Indonesia number indentification checking
	//	16digit 
	//	31-02-01-44-03-91-0312
	//	31: kode provinsi.
	//	02: Kode kota/kabupaten
	//	01: Kode kecamatan
	//	44: Tanggal lahir. Kode laki-laki: 01-31. perempuan: tanggal lahir ditambah 40, 41-71. Jadi kalau kamu seorang perempuan yang lahir tanggal 12 maka kodenya adalah 40 + 12 yaitu 52.
	//	03: bulan
	//	91: Tahun lahir
	//	0312: Nomor komputerisasi
	

//	NSString *otherIDType = [OtherIDType.titleLabel.text stringByTrimmingCharactersInSet:
//							 [NSCharacterSet whitespaceCharacterSet]];
//	NSString *input = [txtOtherIDType.text lowercaseString];
//	NSString *str_otherid;
	
	NSString *NIK_Str = @"3102011403910312";
	
	NSString *strDate = [NIK_Str substringWithRange:NSMakeRange(6, 2)];
	NSString *strMonth = [NIK_Str substringWithRange:NSMakeRange(8, 2)];
	NSString *strYear = [NIK_Str substringWithRange:NSMakeRange(10, 2)];
	NSString *strGender;
	
	int intDate = [strDate integerValue];
	if (intDate > 40 && intDate < 72) {
		strGender = @"F";
		intDate = intDate - 40;
		if (intDate <10)  
			strDate = [NSString stringWithFormat:@"0%d", intDate];
		else
			strDate = [NSString stringWithFormat:@"%d", intDate];
	}
	else if (intDate > 0 && intDate < 31) {
		strGender = @"M";
	}
	
	NSLog(@"DOB %@/%@/%@", strDate, strMonth, strYear);
	NSLog(@"Gender: %@", strGender);
	
}


-(void)ClearAll {
    
	ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
    
    txtHomeTown.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtHomeState.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtHomeCountry.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtOfficeTown.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtOfficeState.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtOfficeCountry.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtClass.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    btnOfficeCountry.hidden = YES;
    btnHomeCountry.hidden = YES;
    txtOtherIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtOtherIDType.enabled = NO;
    outletDOB.hidden = YES;
    txtDOB.enabled = NO;
    segGender.enabled = FALSE;
	
    checked = NO;
    checked2 = NO;
    isHomeCountry = NO;
    isOffCountry = NO;
    companyCase = NO;
	
	txtFullName.text = @"";
	txtIDType.text = @"";
	txtOtherIDType.text = @"";
	txtDOB.text = @"";
	txtExactDuties.text  = @"";
	txtAnnIncome.text = @"";
	txtHomeAddr1.text = @"";
	txtHomeAddr2.text = @"";
	txtHomeAddr3.text = @"";
	txtHomeCountry.text = @"";
	txtHomePostCode.text  = @"";
	txtHomeState.text = @"";
	txtHomeTown.text = @"";
	txtOfficeAddr1.text = @"";
	txtOfficeAddr2.text = @"";
	txtOfficeAddr3.text = @"";
	txtOfficeCountry.text = @"";
	txtOfficePostcode.text = @"";
	txtOfficeState.text = @"";
	txtOfficeTown.text = @"";
	txtPrefix1.text = @"";
	txtPrefix2.text = @"";
	txtPrefix3.text = @"";
	txtPrefix4.text = @"";
	txtContact1.text = @"";
	txtContact2.text = @"";
	txtContact3.text = @"";
	txtContact4.text = @"";
	txtClass.text = @"";
	txtEmail.text = @"";
	txtRemark.text = @"";
	txtBussinessType.text = @"";
    txtRigNO.text = @"";
    txtRigDate.text = @"";
	segRigPerson.selectedSegmentIndex = -1;
	segGender.selectedSegmentIndex = -1;
	segSmoker.selectedSegmentIndex = -1;
	
	outletTitle.titleLabel.text = @"- SELECT -";
	outletDOB.titleLabel.text = @"- SELECT -";
	outletRace.titleLabel.text = @"- SELECT -";
	outletReligion.titleLabel.text = @"- SELECT -";
	outletNationality.titleLabel.text = @"- SELECT -";
	outletMaritalStatus.titleLabel.text = @"- SELECT -";
	outletOccup.titleLabel.text = @"- SELECT -";
	
	OtherIDType.titleLabel.text = @"- SELECT -";
	[self IDTypeDescSelected:OtherIDType.titleLabel.text];
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"NO" forKey:@"isNew"];
}


#pragma mark - db handling

-(void) GetLastID
{
    sqlite3_stmt *statement2;
    sqlite3_stmt *statement3;
    NSString *lastID;
    NSString *contactCode;
    
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
        NSString *GetLastIdSQL = [NSString stringWithFormat:@"Select indexno  from prospect_profile order by \"indexNo\" desc limit 1"];
        const char *SelectLastId_stmt = [GetLastIdSQL UTF8String];
        if(sqlite3_prepare_v2(contactDB, SelectLastId_stmt, -1, &statement2, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement2) == SQLITE_ROW)
            {
                lastID = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 0)];
                sqlite3_finalize(statement2);
                [ClientProfile setObject:lastID forKey:@"LastID"];
            }
            
        }
    }
	
	
    
    for (int a = 0; a<4; a++) {
        
        switch (a) {
            case 0:
                
                contactCode = @"CONT006";
                break;
                
            case 1:
                contactCode = @"CONT008";
                break;
                
            case 2:
                contactCode = @"CONT007";
                break;
                
            case 3:
                contactCode = @"CONT009";
                break;
                
            default:
                break;
        }
        
        if(Update_record == YES)
        {
            //KY
            NSString *insertContactSQL = @"";
            if (a==0) {
                
                insertContactSQL = [NSString stringWithFormat:
                                    @"UPDATE  contact_input SET \"ContactNo\"=\"%@\",  \"Prefix\"=\"%@\" WHERE \"IndexNo\" =\"%@\" AND  \"contactCode\" =\"%@\"",txtContact1.text,txtPrefix1.text,prospectprofile.ProspectID, contactCode];
                
            }
            else if (a==1) {
                
                insertContactSQL = [NSString stringWithFormat:
                                    @"UPDATE  contact_input SET \"ContactNo\"=\"%@\",  \"Prefix\"=\"%@\" WHERE \"IndexNo\" =\"%@\" AND  \"contactCode\" =\"%@\" ",txtContact2.text,txtPrefix2.text,prospectprofile.ProspectID,contactCode];
                
            }
            else if (a==2) {
                
                insertContactSQL = [NSString stringWithFormat:
                                    @"UPDATE  contact_input SET \"ContactNo\"=\"%@\",  \"Prefix\"=\"%@\" WHERE \"IndexNo\" =\"%@\" AND  \"contactCode\" =\"%@\"",txtContact3.text,txtPrefix3.text,prospectprofile.ProspectID, contactCode];
                
            }
            else if (a==3) {
                
                insertContactSQL = [NSString stringWithFormat:
                                    @"UPDATE  contact_input SET \"ContactNo\"=\"%@\",  \"Prefix\"=\"%@\" WHERE \"IndexNo\" =\"%@\" AND  \"contactCode\" =\"%@\"",txtContact4.text,txtPrefix4.text,prospectprofile.ProspectID, contactCode];
                
            }
            
            
            
            const char *insert_contactStmt = [insertContactSQL UTF8String];
            if(sqlite3_prepare_v2(contactDB, insert_contactStmt, -1, &statement3, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement3) == SQLITE_DONE){
                    sqlite3_finalize(statement3);
                    
                }
                else {
                    NSLog(@"Error - 4");
                }
            }
            else {
                NSLog(@"Error - 3");
            }
            
            insert_contactStmt = Nil, insertContactSQL = Nil;
            
            
            
        }
        else{
            
            if (![contactCode isEqualToString:@""]) {
                
                NSString *insertContactSQL = @"";
                if (a==0) {
                    insertContactSQL = [NSString stringWithFormat:
                                        @"INSERT INTO contact_input(\"IndexNo\",\"contactCode\", \"ContactNo\", \"Primary\", \"Prefix\") "
                                        " VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", lastID, contactCode, txtContact1.text, @"N", txtPrefix1.text];
                }
                else if (a==1) {
                    insertContactSQL = [NSString stringWithFormat:
                                        @"INSERT INTO contact_input(\"IndexNo\",\"contactCode\", \"ContactNo\", \"Primary\", \"Prefix\") "
                                        " VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", lastID, contactCode, txtContact2.text, @"N", txtPrefix2.text];
                }
                else if (a==2) {
                    insertContactSQL = [NSString stringWithFormat:
                                        @"INSERT INTO contact_input(\"IndexNo\",\"contactCode\", \"ContactNo\", \"Primary\", \"Prefix\") "
                                        " VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", lastID, contactCode, txtContact3.text, @"N", txtPrefix3.text];
                }
                else if (a==3) {
                    insertContactSQL = [NSString stringWithFormat:
                                        @"INSERT INTO contact_input(\"IndexNo\",\"contactCode\", \"ContactNo\", \"Primary\", \"Prefix\") "
                                        " VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", lastID, contactCode, txtContact4.text, @"N", txtPrefix4.text];
                }
                
                
                
                const char *insert_contactStmt = [insertContactSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, insert_contactStmt, -1, &statement3, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement3) == SQLITE_DONE){
                        sqlite3_finalize(statement3);
                        
                    }
                    else {
                        NSLog(@"Error - 4");
                    }
                }
                else {
                    NSLog(@"Error - 3");
                }
                
                insert_contactStmt = Nil, insertContactSQL = Nil;
                
            }
        }
        
        
    }
    UIAlertView *SuccessAlert;
    if(Update_record == YES)
    {
		if (![[ClientProfile objectForKey:@"TabBar"] isEqualToString:@"YES"]) {
            SuccessAlert = [[UIAlertView alloc] initWithTitle:@" "
                                                      message:@"Changes have been updated successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		}
		SuccessAlert.tag = 1;
		[SuccessAlert show];
		
        //		NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
		[ClientProfile setObject:@"NO" forKey:@"isNew"];
        //		[self ClearAll];
    }
    else
    {
		
		if (![[ClientProfile objectForKey:@"TabBar"] isEqualToString:@"YES"]) {
			SuccessAlert = [[UIAlertView alloc] initWithTitle:@" "
													  message:@"A new client record successfully inserted." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		}
		SuccessAlert.tag = 1;
		[SuccessAlert show];
		[ClientProfile setObject:@"NO" forKey:@"isNew"];
		
        //		[self ClearAll];
    }
	
    statement2 = Nil;
    statement3 = Nil;
    lastID = Nil;
    contactCode = Nil;
    dbpath = Nil;
    
}

-(BOOL)get_unemploy
{
    sqlite3_stmt *statement;
    BOOL valid = FALSE;
    
    if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT \"OccpCatCode\" from Adm_OccpCat_Occp WHERE OccpCode = \"%@\" ", OccupCodeSelected];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String ], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW){
                OccpCatCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                
                OccpCatCode = [OccpCatCode stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
                
                if ([[OccpCatCode stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@"EMP"]) {
                    valid = FALSE;
                }
                else {
                    valid = TRUE;
                }
                
            }
            sqlite3_finalize(statement);
        }
        else {
            valid = FALSE;
        }
        
        sqlite3_close(contactDB);
    }
    return valid;
    
}


#pragma mark - delegate

-(void)selectedGroup:(NSString *)aaGroup
{
    
    if([aaGroup isEqualToString:@"- SELECT -"])
        outletGroup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    else
        outletGroup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [outletGroup setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",aaGroup]forState:UIControlStateNormal];
    [self.GroupPopover dismissPopoverAnimated:YES];
}

-(void)selectedTitleDesc:(NSString *)selectedTitleDesc
{
    if([selectedTitleDesc isEqualToString:@"- SELECT -"])
        outletTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    else
        outletTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
	[outletTitle setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@",selectedTitleDesc]forState:UIControlStateNormal];
    
    [self.TitlePickerPopover dismissPopoverAnimated:YES];
    
}

-(void)selectedTitleCode:(NSString *)selectedTitleCode {
	TitleCodeSelected = selectedTitleCode;
}

-(void)selectedNationality:(NSString *)selectedNationality
{
    
    if([selectedNationality isEqualToString:@"- SELECT -"])
        outletNationality.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    else
        outletNationality.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    outletNationality.titleLabel.text = selectedNationality;
    
    [outletNationality setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",selectedNationality]forState:UIControlStateNormal];
    [self.nationalityPopover dismissPopoverAnimated:YES];
}

-(void)selectedReligion:(NSString *)setReligion
{
    if([setReligion isEqualToString:@"- SELECT -"])
        outletReligion.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    else
        outletReligion.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    outletReligion.titleLabel.text = setReligion;
    
    [outletReligion setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",setReligion]forState:UIControlStateNormal];
    [self.ReligionListPopover dismissPopoverAnimated:YES];
}

-(void)CloseWindow
{
    
    NSLog(@"Propsect CloseWindow");
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [_SIDatePopover dismissPopoverAnimated:YES];
}

-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
    //NSLog(@"DateSelected -  strDate - %@ || dbDate - %@", strDate,dbDate);
    
    DATE_OK = YES;
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    NSDate *d = [NSDate date];
    NSDate* d2 = [df dateFromString:strDate];
    
    
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    
    if(RegDatehandling ==NO && isGSTDate)
    {
       //outletRigDate.titleLabel.text = strDate;
        outletRigDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [outletRigDate setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",strDate]forState:UIControlStateNormal];
      //  txtRigDate.textColor = [UIColor blackColor];

    }
    if(txtRigDate.text.length>0){
       // outletRigDate.hidden=YES;
    }
    else
    {
        //outletRigDate.hidden=NO;
    }
    
        
    NSString *otherIDType_trim = [OtherIDType.titleLabel.text stringByTrimmingCharactersInSet:
                                  [NSCharacterSet whitespaceCharacterSet]];
    
    
    
    //KY
    
    if (isDOBDate) {
		[outletDOB setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", strDate] forState:UIControlStateNormal];
	}

    
    if([otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"] && [dateString isEqualToString:strDate])
        
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"Expected Delivery Date must be future date." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
        
        
        outletDOB.titleLabel.textColor =  [UIColor redColor];
        alert = Nil;
        DATE_OK = NO;
    }
    
    else if ([otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"] && [d compare:d2] == NSOrderedDescending) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"Expected Delivery Date must be future date." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
        
        
        outletDOB.titleLabel.textColor =  [UIColor redColor];
        alert = Nil;
        DATE_OK = NO;
    }
    
    else if (![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"] && ![OtherIDType.titleLabel.text isEqualToString:@"- SELECT -"] &&  ![otherIDType_trim isEqualToString:@"BIRTH CERTIFICATION"] && [d compare:d2] == NSOrderedAscending) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"Date of Birth cannot be greater than today’s date." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
        
        
        outletDOB.titleLabel.textColor =  [UIColor redColor];
        alert = Nil;
        DATE_OK = NO;
        
    }
    else{
        if (isDOBDate) {
			outletDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
			[outletDOB setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", strDate] forState:UIControlStateNormal];
		}

    }
    
    if((segRigPerson.selectedSegmentIndex == 0) && [d compare:d2] == NSOrderedAscending)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"GST Registration date cannot be greater than today’s date." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];

        
        txtRigDate.textColor = [UIColor redColor];
        [outletRigDate setTitle:@"- SELECT -" forState:UIControlStateNormal];
        outletRigDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        outletRigDate.titleLabel.textColor = [UIColor redColor];
        txtRigDate.text =@"";
        //outletRigDate.hidden=NO;
        
        
    }
    
    isDOBDate = NO;
	isGSTDate = NO;
    
		
    df = Nil, d = Nil, d2 = Nil;
}

-(void)IDTypeDescSelected:(NSString *)selectedIDType
{
    ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
	
	if (outletOccup.enabled == FALSE) {
		outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [outletOccup setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
        txtClass.text=@"";
	}
	
    txtOtherIDType.text=@"";
	
	
    
    
    
    //default start
    //TITLE
    
    txtBussinessType.enabled = true;
    txtBussinessType.backgroundColor = [UIColor whiteColor];
    
    txtRemark.editable = true;
    txtRemark.backgroundColor = [UIColor whiteColor];
    
    
    outletTitle.enabled = YES;
    
	//RACE
    btnCoutryOfBirth.enabled = YES;
    btnCoutryOfBirth.titleLabel.textColor = [UIColor blackColor];
    
    //RACE
    outletRace.enabled = YES;
    outletRace.titleLabel.textColor = [UIColor blackColor];
    
    
    //NATIONALITY
    outletNationality.enabled = YES;
    
    outletNationality.titleLabel.textColor = [UIColor blackColor];
    
    
    //RELIGION
    outletReligion.enabled = YES;
    
    outletReligion.titleLabel.textColor = [UIColor blackColor];
    
    
    //MARITAL
    outletMaritalStatus.enabled = YES;
    outletMaritalStatus.titleLabel.textColor = [UIColor blackColor];
    
    //OCCUPATION
    outletOccup.enabled = YES;
    outletOccup.titleLabel.textColor = [UIColor blackColor];
    
    //group
    outletGroup.enabled = YES;
    outletGroup.titleLabel.textColor = [UIColor blackColor];
    
    txtEmail.enabled = true;
    segSmoker.enabled = true;
    
    txtPrefix1.enabled = true;
    txtPrefix2.enabled = true;
    txtPrefix3.enabled = true;
    txtPrefix4.enabled = true;
    
    txtPrefix1.backgroundColor = [UIColor whiteColor];
    txtPrefix2.backgroundColor = [UIColor whiteColor];
    txtPrefix3.backgroundColor = [UIColor whiteColor];
    txtPrefix4.backgroundColor = [UIColor whiteColor];
    
    txtContact1.enabled = true;
    txtContact2.enabled = true;
    txtContact3.enabled = true;
    txtContact4.enabled = true;
    
    txtContact1.backgroundColor = [UIColor whiteColor];
    txtContact2.backgroundColor = [UIColor whiteColor];
    txtContact3.backgroundColor = [UIColor whiteColor];
    txtContact4.backgroundColor = [UIColor whiteColor];
    
    
    
    btnForeignHome.enabled = true;
    btnForeignOffice.enabled = true;
    btnHomeCountry.enabled = true;
    btnOfficeCountry.enabled = true;
    
    
    
    
    
    
    
    txtAnnIncome.backgroundColor =[UIColor whiteColor];
    txtAnnIncome.enabled =true;
    
    
    txtExactDuties.editable = YES;
    txtExactDuties.backgroundColor = [UIColor whiteColor];
    
    
    txtHomeAddr1.enabled = YES;
    txtHomeAddr1.backgroundColor  = [UIColor whiteColor];
    
    
    txtHomeAddr2.backgroundColor  = [UIColor whiteColor];
    txtHomeAddr2.enabled = YES;
    
    txtHomeAddr3.backgroundColor  = [UIColor whiteColor];
    txtHomeAddr3.enabled = YES;
    
    txtHomePostCode.backgroundColor  = [UIColor whiteColor];
    txtHomePostCode.enabled = YES;
    
    txtOfficeAddr1.backgroundColor  = [UIColor whiteColor];
    txtOfficeAddr1.enabled = YES;
    
    txtOfficeAddr2.backgroundColor  = [UIColor whiteColor];
    txtOfficeAddr2.enabled = YES;
    
    txtOfficeAddr3.backgroundColor  = [UIColor whiteColor];
    txtOfficeAddr3.enabled = YES;
    
    txtOfficePostcode.backgroundColor  = [UIColor whiteColor];
    txtOfficePostcode.enabled = YES;
    
    
    //default end
    
    
    OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [OtherIDType setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",selectedIDType]forState:UIControlStateNormal];
    
    
    OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    OtherIDType.titleLabel.text = selectedIDType;
    
    
    NSString *occupation = [outletOccup.titleLabel.text stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]];
    
    
    
    if ([selectedIDType isEqualToString:@"- SELECT -"]){
        
        
        OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        
        if(txtIDType.text.length!=0)
        {
            segGender.enabled = NO;
            
            outletDOB.enabled = NO;
            outletDOB.hidden = TRUE;
            //  outletDOB.titleLabel.text =@"";
            txtDOB.enabled = FALSE;
            txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            txtDOB.hidden = NO;
            
            txtOtherIDType.enabled = NO;
            txtOtherIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            //  txtOtherIDType.text =@"";
            
            
        }
        else{
            segGender.enabled = YES;
            
            segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
            
            outletDOB.enabled = YES;
            outletDOB.hidden = TRUE;
            outletDOB.titleLabel.text =@"";
            txtDOB.enabled = YES;
            txtDOB.backgroundColor = [UIColor whiteColor];
            txtDOB.hidden = NO;
            
            txtOtherIDType.enabled = YES;
            txtOtherIDType.backgroundColor = [UIColor whiteColor];
            // txtOtherIDType.text =@"";
            
        }
		
		if ([selectedIDType isEqualToString:@"- SELECT -"]) {
			txtOtherIDType.enabled = false;
			txtOtherIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
		}
		
        segSmoker.enabled = YES;
        companyCase = NO;
        // segGender.enabled = NO;
        
        // segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        txtIDType.backgroundColor = [UIColor whiteColor];
        txtIDType.enabled = YES;
        
        /*
         outletDOB.enabled = NO;
         outletDOB.hidden = TRUE;
         outletDOB.titleLabel.text =@"";
         
         txtDOB.enabled = FALSE;
         txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
         txtDOB.hidden = NO;
         */
        
        OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        /* txtOtherIDType.enabled = NO;
         txtOtherIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
         txtOtherIDType.text =@"";
         */
        outletTitle.enabled = YES;
        outletTitle.titleLabel.textColor = [UIColor blackColor];
        
        outletOccup.enabled = YES;
        //outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        // outletOccup.titleLabel.text = @"- SELECT -";
        outletOccup.titleLabel.textColor = [UIColor blackColor];
        
        
        outletRace.titleLabel.textColor = [UIColor blackColor];
        outletRace.enabled = YES;
        
        outletReligion.enabled = YES;
        outletReligion.titleLabel.textColor = [UIColor blackColor];
        
        outletNationality.enabled = YES;
        outletNationality.titleLabel.textColor = [UIColor blackColor];
        
        outletMaritalStatus.enabled = YES;
        outletMaritalStatus.titleLabel.textColor = [UIColor blackColor];
        
    }
    else  if ([selectedIDType isEqualToString:@"EXPECTED DELIVERY DATE"]){
        
        
        //TITLE
        outletTitle.enabled = NO;
        outletTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [outletTitle setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
        [_TitlePicker setTitle:@"- SELECT -"];
        
        
        outletTitle.titleLabel.textColor = [UIColor grayColor];
        
		//BIRTH COUNTRY
        btnCoutryOfBirth.enabled = NO;
        btnCoutryOfBirth.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btnCoutryOfBirth setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
        btnCoutryOfBirth.titleLabel.textColor = [UIColor grayColor];
        
        //RACE
        outletRace.enabled = NO;
        outletRace.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [outletRace setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
        outletRace.titleLabel.textColor = [UIColor grayColor];
        [_raceList setTitle:@"- SELECT -"];
        
        
        //NATIONALITY
        outletNationality.enabled = NO;
        outletNationality.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [outletNationality setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
        outletNationality.titleLabel.textColor = [UIColor grayColor];
        [_nationalityList setTitle:@"- SELECT -"];
        
        
        //RELIGION
        outletReligion.enabled = NO;
        outletReligion.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [outletReligion setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
        outletReligion.titleLabel.textColor = [UIColor grayColor];
        [_ReligionList setTitle:@"- SELECT -"];
        
        //MARITAL
        outletMaritalStatus.enabled = NO;
        outletMaritalStatus.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [outletMaritalStatus setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
        outletMaritalStatus.titleLabel.textColor = [UIColor grayColor];
        [_MaritalStatusList setTitle:@"- SELECT -"];
        
        //OCCUPATION
        outletOccup.enabled = NO;
        //        outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        //        [outletOccup setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
        //        txtClass.text=@"";
		
		//OccupationDesc = MINOR (AUTO SET)
		outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [outletOccup setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"MINOR"]forState:UIControlStateNormal];
		outletOccup.titleLabel.textColor = [UIColor grayColor];
		txtClass.text = @"2";
		OccupCodeSelected = @"OCC01360";
		[_OccupationList setTitle:@"MINOR"];
        
        //group
        outletGroup.enabled = NO;
        outletGroup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [outletGroup setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
        outletGroup.titleLabel.textColor = [UIColor grayColor];
        [_GroupList setTitle:@"- SELECT -"];
        
        txtBussinessType.text=@"";
        txtBussinessType.enabled = false;
        txtBussinessType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        
        txtRemark.text=@"";
        txtRemark.editable = false;
        txtRemark.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        
        txtEmail.text=@"";
        txtEmail.enabled = false;
        txtEmail.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
        
        txtPrefix1.text=@"";
        txtPrefix2.text=@"";
        txtPrefix3.text=@"";
        txtPrefix4.text=@"";
        
        txtPrefix1.enabled = false;
        txtPrefix2.enabled = false;
        txtPrefix3.enabled = false;
        txtPrefix4.enabled = false;
        
        txtPrefix1.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtPrefix2.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtPrefix3.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtPrefix4.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        
        txtContact1.text=@"";
        txtContact2.text=@"";
        txtContact3.text=@"";
        txtContact4.text=@"";
        
        txtContact1.enabled = false;
        txtContact2.enabled = false;
        txtContact3.enabled = false;
        txtContact4.enabled = false;
        
        txtContact1.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtContact2.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtContact3.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtContact4.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        
        
        
        
        txtAnnIncome.text = @"";
        txtExactDuties.text = @"";
        txtHomeAddr1.text = @"";
        txtHomeAddr2.text = @"";
        txtHomeAddr3.text = @"";
        
        txtOfficeAddr1.text = @"";
        txtOfficeAddr2.text =@"";
        txtOfficeAddr3.text = @"";
        
        
        
        txtAnnIncome.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtAnnIncome.enabled =false;
        
        btnForeignHome.enabled = false;
        btnForeignOffice.enabled = false;
        btnHomeCountry.enabled = false;
        btnOfficeCountry.enabled = false;
        
        
        
        companyCase = NO;
        segGender.enabled = FALSE;
        gender = @"MALE";//Default value
        ClientSmoker = @"N";//Default value
        segSmoker.enabled = FALSE;
        segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        txtIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtIDType.text = @"";
        txtIDType.enabled = NO;
        
        
        txtDOB.hidden = YES;
        //CLEAR DOB
        txtDOB.text =@"";
        outletDOB.hidden = NO;
        outletDOB.enabled = YES;
        outletDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        [outletDOB setTitle:@"- SELECT -" forState:UIControlStateNormal];
        txtDOB.backgroundColor = [UIColor whiteColor];
        
        
        
        OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        txtOtherIDType.enabled = NO;
        txtOtherIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtOtherIDType.text =@"";
        
        txtExactDuties.editable = NO;
        txtExactDuties.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        
        
        txtHomeAddr1.enabled = NO;
        txtHomeAddr1.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
        
        
        txtHomeAddr2.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
        txtHomeAddr2.enabled = NO;
        
        txtHomeAddr3.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
        txtHomeAddr3.enabled = NO;
        
        txtHomePostCode.text=@"";
        txtHomeState.text=@"";
        txtHomeTown.text=@"";
        txtHomeCountry.text=@"";
        
        txtHomePostCode.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
        txtHomePostCode.enabled = NO;
        
        txtOfficeAddr1.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
        txtOfficeAddr1.enabled = NO;
        
        txtOfficeAddr2.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
        txtOfficeAddr2.enabled = NO;
        
        txtOfficeAddr3.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
        txtOfficeAddr3.enabled = NO;
        
        txtOfficePostcode.text=@"";
        txtOfficeCountry.text=@"";
        txtOfficeState.text=@"";
        txtOfficeTown.text=@"";
        
        txtOfficePostcode.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
        txtOfficePostcode.enabled = NO;
        
        
        txtRigNO.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtRigNO.enabled = NO;
        txtRigNO.text =@"";
        
        txtRigDate.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        outletRigDate.enabled = NO;
        outletRigDate.titleLabel.textColor = [UIColor grayColor];
        txtRigDate.text =@"";
        
        
        segRigPerson.selectedSegmentIndex=1;
        segRigPerson.enabled =NO;
        
        segRigExempted.selectedSegmentIndex =0;
        segRigExempted.enabled =NO;
        
        
        
        //                txtRigNO.userInteractionEnabled=YES;
                        btnRegistnDate.userInteractionEnabled=NO;
        //                segRigExempted.enabled =FALSE;
        //                GSTRigExempted = @"";
        
    }
    
    else if([selectedIDType isEqualToString:@"BIRTH CERTIFICATE"] && [occupation isEqualToString:@"BABY"])
    {
        
        
        // outletDOB.hidden = NO;
        //  outletDOB.enabled = TRUE;
        //  segGender.enabled = TRUE;
        txtOtherIDType.enabled = YES;
        txtOtherIDType.backgroundColor = [UIColor whiteColor];
        txtDOB.hidden = YES;
        txtDOB.text = @"";
        outletDOB.hidden = NO;
        if(txtIDType.text.length !=0)
        {
            outletDOB.enabled = NO;
            
        }
        else
        {
            outletDOB.enabled = YES;
            [outletDOB setTitle:@"- SELECT -" forState:UIControlStateNormal];
        }
        
    }
    else if(([selectedIDType isEqualToString:@"BIRTH CERTIFICATE"]||[selectedIDType isEqualToString:@"OLD IDENTIFICATION NO"]) && ![occupation isEqualToString:@"BABY"])
    {
        
        
        
        companyCase = NO;
        
        
        if(txtIDType.text.length !=0)
        {
            
            outletDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            
            //  txtDOB.enabled = FALSE;
            
            
            // outletDOB.enabled = FALSE;
            //  outletDOB.hidden = YES;
            // txtDOB.hidden = NO;
            
            
            txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            
            
            
            
        }
        else
        {
            txtDOB.hidden = YES;
            txtDOB.text = @"";
            outletDOB.hidden = NO;
            
            outletDOB.enabled = YES;
            [outletDOB setTitle:@"- SELECT -" forState:UIControlStateNormal]; //ENABLE DOB OUTLETS
            outletDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
        
        
        // check if ic field is empty
        if ([txtIDType.text isEqualToString:@""]) {
            
            
            txtIDType.backgroundColor = [UIColor whiteColor];
            txtIDType.enabled = YES;
            segGender.enabled = YES;
            segSmoker.enabled = YES;
            
            //  txtDOB.hidden = NO;
            //  txtDOB.backgroundColor = [UIColor whiteColor];
            
            // Reset gender
            segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
            
        }
        else if (![txtIDType.text isEqualToString:@""]) {
            
            
            segGender.enabled = FALSE;
            
        }
        
        
        
        
        outletTitle.enabled = YES;
        outletTitle.titleLabel.textColor = [UIColor blackColor];
        
        OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        txtOtherIDType.enabled = YES;
        txtOtherIDType.backgroundColor = [UIColor whiteColor];
        
        outletOccup.enabled = YES;
        
        outletOccup.titleLabel.textColor = [UIColor blackColor];
        
        
        outletRace.titleLabel.textColor = [UIColor blackColor];
        outletRace.enabled = YES;
        
        outletReligion.enabled = YES;
        outletReligion.titleLabel.textColor = [UIColor blackColor];
        
        outletNationality.enabled = YES;
        outletNationality.titleLabel.textColor = [UIColor blackColor];
        
        outletMaritalStatus.enabled = YES;
        outletMaritalStatus.titleLabel.textColor = [UIColor blackColor];
        
        
        
    }
    
    else if([selectedIDType isEqualToString:@"BIRTH CERTIFICATE"]||[selectedIDType isEqualToString:@"OLD IDENTIFICATION NO"])
    {
        segGender.enabled = TRUE;
        
    }
    else if([selectedIDType isEqualToString:@"COMPANY REGISTRATION NUMBER"])
    {
        
        
        companyCase = YES;
        txtOtherIDType.backgroundColor = [UIColor whiteColor];
        txtOtherIDType.enabled = YES;
        
        txtIDType.enabled = NO;
        txtIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtIDType.text=@"";
        
        segGender.enabled = FALSE;
        
        segSmoker.enabled = YES;
        segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        
	
        outletTitle.hidden = NO;
        outletTitle.enabled = NO;
        [outletTitle setTitle:@"- SELECT -" forState:UIControlStateNormal];
        outletTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        outletTitle.titleLabel.textColor = [UIColor grayColor];
        
        
        
        outletOccup.hidden = NO;
        outletOccup.enabled = NO;
        [outletOccup setTitle:@"- SELECT -" forState:UIControlStateNormal];
        outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        outletOccup.titleLabel.textColor = [UIColor grayColor];
        
        
        segSmoker.enabled = NO;
        
		
		//BIRTH COUNTRY
        btnCoutryOfBirth.enabled = NO;
        btnCoutryOfBirth.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btnCoutryOfBirth setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
        btnCoutryOfBirth.titleLabel.textColor = [UIColor grayColor];
        
        
        outletRace.hidden = NO;
        outletRace.enabled = NO;
        [outletRace setTitle:@"- SELECT -" forState:UIControlStateNormal];
        outletRace.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        outletRace.titleLabel.textColor = [UIColor grayColor];
        
        
        
        
        outletReligion.hidden = NO;
        outletReligion.enabled = NO;
        [outletReligion setTitle:@"- SELECT -" forState:UIControlStateNormal];
        outletReligion.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        outletReligion.titleLabel.textColor = [UIColor grayColor];
        
        
        
        outletMaritalStatus.hidden = NO;
        outletMaritalStatus.enabled = NO;
        [outletMaritalStatus setTitle:@"- SELECT -" forState:UIControlStateNormal];
        outletMaritalStatus.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        outletMaritalStatus.titleLabel.textColor = [UIColor grayColor];
        
        
        outletNationality.hidden = NO;
        outletNationality.enabled = NO;
        [outletNationality setTitle:@"- SELECT -" forState:UIControlStateNormal];
        outletNationality.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        outletNationality.titleLabel.textColor = [UIColor grayColor];
        
        segSmoker.selectedSegmentIndex = UISegmentedControlNoSegment;
        
        
        
        //DISABLE DOB
        //  txtDOB.hidden = YES;
        // txtDOB.text = @"";
        outletDOB.hidden = NO;
        outletDOB.enabled = NO;
        [outletDOB setTitle:@"- SELECT -" forState:UIControlStateNormal];
        outletDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        outletDOB.titleLabel.textColor = [UIColor grayColor];
        
    }
    
    else if([selectedIDType isEqualToString:@"PASSPORT"])
    {
        companyCase = NO;
        
        // check if ic field is empty
        if ([txtIDType.text isEqualToString:@""]) {
            
            
            txtIDType.backgroundColor = [UIColor whiteColor];
            txtIDType.enabled = YES;
            segGender.enabled = YES;
            segSmoker.enabled = YES;
            
            
            txtDOB.hidden = YES;
            
            txtDOB.backgroundColor = [UIColor whiteColor];
            
            // Reset gender
            segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
            
            // Reset dob
            txtDOB.text = @"";
            outletDOB.hidden = NO;
            outletDOB.enabled = TRUE;
            
            [outletDOB setTitle:@"- SELECT -" forState:UIControlStateNormal];
            outletDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
        else if (![txtIDType.text isEqualToString:@""]) {
            
            segSmoker.enabled = YES;
            segGender.enabled = FALSE;
            txtDOB.enabled = FALSE;
            txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            outletDOB.enabled = FALSE;
        }
        
        
        
        //[outletDOB setTitle:@"" forState:UIControlStateNormal];
        
        
        //outletDOB.enabled = NO;
        
        outletTitle.enabled = YES;
        outletTitle.titleLabel.textColor = [UIColor blackColor];
        
        OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        txtOtherIDType.enabled = YES;
        txtOtherIDType.backgroundColor = [UIColor whiteColor];
        
        outletOccup.enabled = YES;
        //outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        // outletOccup.titleLabel.text = @"- SELECT -";
        outletOccup.titleLabel.textColor = [UIColor blackColor];
        
        
        outletRace.titleLabel.textColor = [UIColor blackColor];
        outletRace.enabled = YES;
        
        outletReligion.enabled = YES;
        outletReligion.titleLabel.textColor = [UIColor blackColor];
        
        outletNationality.enabled = YES;
        outletNationality.titleLabel.textColor = [UIColor blackColor];
        
        outletMaritalStatus.enabled = YES;
        outletMaritalStatus.titleLabel.textColor = [UIColor blackColor];
        
        
        //txtDOB.enabled = TRUE;
        //txtDOB.backgroundColor = [UIColor whiteColor];
        //txtDOB.hidden = NO;
        
        
    }
    
    else{
        
        
        
        txtIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtIDType.enabled = NO;
        txtIDType.text = @"";
        
        txtOtherIDType.backgroundColor = [UIColor whiteColor];
        txtOtherIDType.enabled = YES;
        
        outletOccup.enabled = YES;
        //outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        // outletOccup.titleLabel.text = @"- SELECT -";
        outletOccup.titleLabel.textColor = [UIColor blackColor];
        
        
        outletTitle.enabled = YES;
        
        outletTitle.titleLabel.textColor = [UIColor blackColor];
        outletOccup.enabled = YES;
        segGender.enabled = YES;
        segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        segSmoker.enabled = YES;
        companyCase = NO;
        txtDOB.hidden = YES;
        txtDOB.text = @"";
        outletDOB.hidden = NO;
        outletDOB.enabled = YES;
        [outletDOB setTitle:@"- SELECT -" forState:UIControlStateNormal];
        outletDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        
        
        
        txtDOB.backgroundColor = [UIColor whiteColor];
        outletRace.enabled = YES;
        outletRace.titleLabel.textColor = [UIColor blackColor];
        outletReligion.enabled = YES;
        outletReligion.titleLabel.textColor = [UIColor blackColor];
        outletNationality.enabled = YES;
        outletNationality.titleLabel.textColor = [UIColor blackColor];
        outletMaritalStatus.enabled = YES;
        outletMaritalStatus.titleLabel.textColor = [UIColor blackColor];
        
        
          }
	
	if ([selectedIDType isEqualToString:@"- Select -"]||[selectedIDType isEqualToString:@"ARMY IDENTIFICATION NUMBER"]||[selectedIDType isEqualToString:@"BIRTH CERTIFICATE"]||[selectedIDType isEqualToString:@"COMPANY REGISTRATION NUMBER"]||[selectedIDType isEqualToString:@"FOREIGNER BIRTH CERTIFICATE"]|[selectedIDType isEqualToString:@"FOREIGNER IDENTIFICATION NUMBER"]||[selectedIDType isEqualToString:@"OLD IDENTIFICATION NO"]||[selectedIDType isEqualToString:@"PASSPORT"]||[selectedIDType isEqualToString:@"PERMANENT RESIDENT"]||[selectedIDType isEqualToString:@"POLICE IDENTIFICATION NUMBER"]||[selectedIDType isEqualToString:@"SINGAPORE IDENTIFICATION NUMBER"])
    {
        
        txtRigNO.backgroundColor = [UIColor whiteColor];
        txtRigNO.enabled = YES;
        txtRigNO.text =@"";
        
        txtRigDate.backgroundColor = [UIColor whiteColor];
        outletRigDate.enabled=YES;
        outletRigDate.titleLabel.textColor = [UIColor grayColor];
        txtRigDate.text =@"";
        
        
        segRigPerson.selectedSegmentIndex=1;
        segRigPerson.enabled =YES;
        
        segRigExempted.selectedSegmentIndex =1;
        segRigExempted.enabled =YES;
        
		// btnRegistnDate.enabled =YES
		
    }
    
    if([selectedIDType isEqualToString:@"- SELECT -"])
        OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    else
        OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [self.IDTypePickerPopover dismissPopoverAnimated:YES];
    
    NSString *otherIDType = [OtherIDType.titleLabel.text stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceCharacterSet]];
    
    
    if(([OccpCatCode isEqualToString:@"HSEWIFE"])
       || ([OccpCatCode isEqualToString:@"JUV"])
       || ([OccpCatCode isEqualToString:@"STU"]))
        
    {
        txtAnnIncome.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtAnnIncome.enabled =false;
    }
    else if(![otherIDType isEqualToString:@"EXPECTED DELIVERY DATE"])
    {
        txtAnnIncome.backgroundColor = [UIColor whiteColor];
        txtAnnIncome.enabled =true;
    }
    
    
    
    
}

-(void)IDTypeCodeSelected:(NSString *)IDTypeCode {
	IDTypeCodeSelected = IDTypeCode;
}

- (void)OccupCodeSelected:(NSString *)OccupCode{
    
    OccupCodeSelected = OccupCode;
    BOOL result_getOccpCatCode = [self get_unemploy];
    ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
    
    if(([OccpCatCode isEqualToString:@"HSEWIFE"])
       || ([OccpCatCode isEqualToString:@"JUV"])
       || ([OccpCatCode isEqualToString:@"STU"]))
        
    {
        txtAnnIncome.enabled = NO;
        txtAnnIncome.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtAnnIncome.text = @"";
    }
    else if([OccpCatCode isEqualToString:@"JUV"] && [OtherIDType.titleLabel.text isEqualToString:@"BIRTH CERTIFICATE"]
            && txtIDType.text.length == 0)
    {
        
        
        txtAnnIncome.enabled = NO;
        txtAnnIncome.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtAnnIncome.text = @"";
        
        txtDOB.enabled = YES;
        
        txtDOB.hidden = YES;
        txtDOB.text = @"";
        outletDOB.hidden = NO;
        outletDOB.enabled = YES;
        [outletDOB setTitle:@"- SELECT -" forState:UIControlStateNormal]; //ENABLE DOB OUTLETS
        outletDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        outletDOB.enabled = TRUE;
        segGender.enabled = TRUE;
    }
    else
    {
        txtAnnIncome.enabled = YES;
        txtAnnIncome.backgroundColor = [UIColor whiteColor];
    }
    
    
    
}

- (void)OccupDescSelected:(NSString *)color
{
    
    
    
    
    [outletOccup setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", color]forState:UIControlStateNormal];
    
    
    
    
    [self.OccupationListPopover dismissPopoverAnimated:YES];
    
    
    
    [self.view endEditing:YES];
    [self resignFirstResponder];
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if([color isEqualToString:@"- SELECT -"])
        outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    else
        outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
}

-(void)OccupClassSelected:(NSString *)OccupClass
{
    
    txtClass.text = OccupClass;
    
}

-(void)selectedRace:(NSString *)theRace
{
    
    outletRace.titleLabel.text = theRace;
    if([theRace isEqualToString:@"- SELECT -"])
        outletRace.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    else
        outletRace.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [outletRace setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",theRace]forState:UIControlStateNormal];
    [self.raceListPopover dismissPopoverAnimated:YES];
    
    
}

-(void)selectedRigDate:(NSString *)therigdate
{
    
    outletRigDate.titleLabel.text = therigdate;
    if([therigdate isEqualToString:@"- SELECT -"])
        outletRigDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    else
        outletRigDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [outletRigDate setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",therigdate]forState:UIControlStateNormal];
    [self.SIDatePopover dismissPopoverAnimated:YES];
    
    
}
-(void)selectedMaritalStatus:(NSString *)status
{
    
    if([status isEqualToString:@"- SELECT -"])
        outletMaritalStatus.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    else
        outletMaritalStatus.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    outletMaritalStatus.titleLabel.text = status;
    [outletMaritalStatus setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",status]forState:UIControlStateNormal];
    [self.MaritalStatusPopover dismissPopoverAnimated:YES];
    
    
}



-(void)SelectedCountry:(NSString *)theCountry
{
    if (isOffCountry) {
        if([theCountry isEqualToString:@"- SELECT -"])
            btnOfficeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        else
            
            btnOfficeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btnOfficeCountry setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",theCountry] forState:UIControlStateNormal];
        
        [self.CountryListPopover dismissPopoverAnimated:YES];
    }
    else if (isHomeCountry) {
        if([theCountry isEqualToString:@"- SELECT -"])
            btnHomeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        else
            btnHomeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btnHomeCountry setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",theCountry] forState:UIControlStateNormal];
        
        [self.CountryListPopover dismissPopoverAnimated:YES];
    }

    
    isOffCountry = NO;
    isHomeCountry = NO;
	
}

-(void)Selected2Country:(NSString *)theCountry
{
    
		if([theCountry isEqualToString:@"- SELECT -"]) {
            btnCoutryOfBirth.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
		}
        else {
			btnCoutryOfBirth.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
			[btnCoutryOfBirth setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",theCountry] forState:UIControlStateNormal];
		}
    
        [self.Country2ListPopover dismissPopoverAnimated:YES];
	
}


-(NSString*) getCountryDesc : (NSString*)country
{
    NSString *code;
    country = [country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT CountryDesc FROM eProposal_Country WHERE CountryCode = ?", country];
    
    while ([result next]) {
        code =[result objectForColumnName:@"CountryDesc"];
        
    }
    
    [result close];
    [db close];
    
    return code;
    
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
			}
		}
	}
    return desc;
}

-(NSString*) getTitleCode : (NSString*)Title
{
	
    NSString *Code;
    Title = [Title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT TitleCode FROM eProposal_Title WHERE TitleDesc = ?", Title];
    
    NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        Code =[result objectForColumnName:@"TitleCode"];
    }
	
    [result close];
    [db close];
    
	if (count == 0) {
		if (Title.length > 0) {
			if ([Title isEqualToString:@"- SELECT -"] || [Title isEqualToString:@"- Select -"]) {
				Code = @"";
			}
			else {
				Code = Title;
			}
		}
	}
    return Code;
}

-(NSString*) getOtherTypeDesc : (NSString*)otherId
{
	
    NSString *desc;
    otherId = [otherId stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT IdentityDesc FROM eProposal_Identification WHERE IdentityCode = ?", otherId];
    
    NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        desc =[result objectForColumnName:@"IdentityDesc"];
    }
	
    [result close];
    //    [db close];
    
	if (count == 0) {
		if (otherId.length > 0) {
			if ([otherId isEqualToString:@"- SELECT -"] || [otherId isEqualToString:@"- Select -"]) {
				desc = @"";
			}
			else {
				desc = otherId;
			}
		}
	}
    return desc;
}

-(NSString*) getOtherTypeCode : (NSString*)otherId
{
	
    NSString *code;
    otherId = [otherId stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT IdentityCode FROM eProposal_Identification WHERE IdentityDesc = ?", otherId];
    
    NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        code =[result objectForColumnName:@"IdentityCode"];
    }
	
    [result close];
    //    [db close];
    
	if (count == 0) {
		if (otherId.length > 0) {
			if ([otherId isEqualToString:@"- SELECT -"] || [otherId isEqualToString:@"- Select -"]) {
				code = @"";
			}
			else {
				code = otherId;
			}
		}
	}
    return code;
}

-(BOOL) record_exist
{
    NSString *si_name;
    NSString *eapp_name;
    NSString *cff_id;
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT Name from Clt_Profile WHERE indexNo = ?", prospectprofile.ProspectID];
    while ([result next]) {
        si_name =  [result objectForColumnName:@"Name"];
        
        NSLog(@"si - %@  || pp.ProspectID-%@",si_name,prospectprofile.ProspectID);
    }
    
    FMResultSet *result2 = [db executeQuery:@"SELECT POName from eApp_Listing WHERE ClientProfileID = ?", prospectprofile.ProspectID];
    while ([result2 next]) {
        eapp_name =  [result2 objectForColumnName:@"POName"];
        
        NSLog(@"si - %@", eapp_name);
    }
    
    FMResultSet *result3 = [db executeQuery:@"SELECT ID from CFF_Master WHERE ClientProfileID = ?", prospectprofile.ProspectID];
    while ([result3 next]) {
        cff_id =  [result3 objectForColumnName:@"ID"];
        NSLog(@"cff - %@", cff_id);
    }
    
    [result close];
    [result2 close];
    [result3 close];
    [db close];
    
    
    if(si_name==nil && eapp_name ==nil  && cff_id==nil )
        return false;
    else
        return  true;
    
    
    
}

-(void) UpdateAfterSave {
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	self.navigationItem.title = @"Edit Client Profile";
	prospectprofile.ProspectID = [ClientProfile objectForKey:@"LastID"];
	Update_record = YES;
	[ClientProfile setObject:@"YES" forKey:@"Update_record"];
	
	if ([textFields trimWhiteSpaces:txtIDType.text].length > 0){
		txtIDType.enabled = FALSE;
		outletDOB.enabled = NO;
		outletDOB.titleLabel.textColor = [UIColor grayColor];
		segGender.enabled = NO;
	}
	
	NSString *otherIDType = [OtherIDType.titleLabel.text stringByTrimmingCharactersInSet:
							 [NSCharacterSet whitespaceCharacterSet]];
	if(![otherIDType isEqualToString:@"- SELECT -"]) {
		txtOtherIDType.enabled = FALSE;
		OtherIDType.enabled = FALSE;
		OtherIDType.titleLabel.textColor = [UIColor grayColor];
	}
	
	if([otherIDType isEqualToString:@"EXPECTED DELIVERY DATE"]) {
		outletDOB.enabled = NO;
		outletDOB.titleLabel.textColor = [UIColor grayColor];
	}
    
	
	
	
}

#pragma mark - memory management

- (void)viewDidUnload
{
    [self setTxtFullName:nil];
    [self setSegGender:nil];
    [self setOutletDOB:nil];
    [self setTxtHomeAddr1:nil];
    [self setTxtHomeAddr2:nil];
    [self setTxtHomeAddr3:nil];
    [self setTxtHomePostCode:nil];
    [self setTxtHomeTown:nil];
    [self setTxtHomeState:nil];
    [self setTxtHomeCountry:nil];
    [self setTxtOfficeAddr1:nil];
    [self setTxtOfficeAddr2:nil];
    [self setTxtOfficeAddr3:nil];
    [self setTxtOfficePostcode:nil];
    [self setTxtOfficeTown:nil];
    [self setTxtOfficeState:nil];
    [self setTxtOfficeCountry:nil];
    [self setTxtExactDuties:nil];
    [self setOutletOccup:nil];
    [self setTxtRemark:nil];
    [self setMyScrollView:nil];
    [self setTxtEmail:nil];
    [self OccupCodeSelected:nil];
    [self setTxtContact1:nil];
    [self setTxtContact2:nil];
    [self setTxtContact3:nil];
    [self setTxtContact4:nil];
    [self setTxtPrefix1:nil];
    [self setTxtPrefix2:nil];
    [self setTxtPrefix3:nil];
    [self setTxtPrefix4:nil];
    [self setLblOfficeAddr:nil];
    [self setLblPostCode:nil];
    [self setOutletTitle:nil];
    [self setOutletReligion:nil];
    [self setOutletNationality:nil];
    [self setOutletMaritalStatus:nil];
    [self setOutletRace:nil];
    [self setSegSmoker:nil];
    [self setOutletGroup:nil];
    [self setOtherIDType:nil];
    [self setTxtOtherIDType:nil];
    [self setTxtIDType:nil];
    [self setTxtAnnIncome:nil];
    [self setTxtBussinessType:nil];
    [self setTxtExactDuties:nil];
    [self setTxtClass:nil];
    [self setBtnForeignHome:nil];
    [self setBtnForeignOffice:nil];
    [self setBtnOfficeCountry:nil];
    [self setBtnHomeCountry:nil];
    [self setTxtDOB:nil];
    [self setBtnTitle:nil];
    [self setBtnOtherIdType:nil];
    [self setBtnAddGroup:nil];
    [self setBtnViewGroup:nil];
    [self setBtnregDare:nil];
    [self setBtnRegistnDate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


@end
