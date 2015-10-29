//
//  EditProspect.m
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 10/1/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "EditProspect.h"
#import "ProspectListing.h"
#import <QuartzCore/QuartzCore.h>
#import "ColorHexCode.h"
#import "IDTypeViewController.h"
#import "DBController.h"
#import "DataTable.h"
#import "FMDatabase.h"
#import "textFields.h"
#import "DataClass.h"
#import "AppDelegate.h"

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

int name_repeat;

@interface EditProspect ()

{
    BOOL name_morethan3times;
    NSString *annualIncome_original;
    //BOOL edited;
    NSString *temp_pre1;
    NSString *temp_pre2;
    NSString *temp_pre3;
    NSString *temp_pre4;
    
    NSString *temp_cont1;
    NSString *temp_cont2;
    NSString *temp_cont3;
    NSString *temp_cont4;
	DataClass *obj;
	
	
	BOOL Update_record;
    BOOL IC_Hold_Alert;
    BOOL OTHERID_Hold_Alert;
	NSString *getSameRecord_Indexno;
	int clickDone;		//if user click done, = 1
	NSString *SameID_type;
	
}
@end

@implementation EditProspect
@synthesize prospectprofile;
@synthesize lblOfficeAddr;
@synthesize lblPostCode;
@synthesize txtPrefix1,strChanges;
@synthesize txtPrefix2;
@synthesize txtPrefix3;
@synthesize txtPrefix4;
@synthesize outletDelete,txtClass;
@synthesize txtContact2;
@synthesize txtContact3;
@synthesize txtContact4;
@synthesize txtRemark;
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
@synthesize txtOfficePostCode;
@synthesize txtOfficeTown;
@synthesize txtOfficeState;
@synthesize txtOfficeCountry,txtDOB;
@synthesize txtExactDuties,btnOfficeCountry;
@synthesize txtrFullName,segSmoker,txtBussinessType,txtAnnIncome,GSTRigperson,GSTRigExempted,outletRigDOB;
@synthesize segGender,txtIDType,txtOtherIDType,OccupCodeSelected,outletNationality,outletRace,outletMaritalStatus,outletReligion,segRigPerson,txtRigDate,txtRigNO,segRigExempted,btnregDate;
@synthesize outletDOB,outletGroup,outletTitle,OtherIDType;
@synthesize txtContact1, gender,btnHomeCountry;
@synthesize txtEmail, pp, DOB, SelectedStateCode,SelectedOfficeStateCode;
@synthesize OccupationList = _OccupationList;
@synthesize OccupationListPopover = _OccupationListPopover;
@synthesize myScrollView,ClientSmoker;
@synthesize outletOccup,btnForeignHome,btnForeignOffice,OccpCatCode;
@synthesize delegate = _delegate;
@synthesize SIDate = _SIDate;
@synthesize SIDatePopover = _SIDatePopover;
@synthesize IDTypePicker = _IDTypePicker;
@synthesize IDTypePickerPopover = _IDTypePickerPopover;
@synthesize TitlePicker = _TitlePicker;
@synthesize TitlePickerPopover = _TitlePickerPopover;
@synthesize GroupList = _GroupList;
@synthesize GroupPopover = _GroupPopover;
@synthesize nationalityPopover = _nationalityPopover;
@synthesize nationalityList = _nationalityList;
@synthesize nationalityPopover2 = _nationalityPopover2;
@synthesize nationalityList2 = _nationalityList2;
@synthesize CountryListPopover = _CountryListPopover;
@synthesize Country2ListPopover = _Country2ListPopover;
@synthesize TitleCodeSelected, IDTypeCodeSelected;
@synthesize edited;
@synthesize AddGroup, ViewGroup, SegIsGrouping;
@synthesize UDGroup, ProsGroupArr, ProsGroupStr, isGrouping;
@synthesize BtnCountryOfBirth;


bool IsContinue = TRUE;
bool HomePostcodeContinue;
bool OfficePostcodeContinue;
bool PolicyOwnerSigned = TRUE;
bool ToDissAlertforRegDate;
NSMutableArray *DelGroupArr;

- (void)viewDidLoad
{
	
    [super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoadDisplay) name:@"reloadEdit" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnTolisting) name:@"returnToListing" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disableGroup) name:@"DismissGroup" object:nil];
	
	//AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	UDGroup = [NSUserDefaults standardUserDefaults];
	ProsGroupArr = [NSMutableArray array];
	DelGroupArr = [NSMutableArray array];
	
	
    outletDelete.hidden = true;
    HomePostcodeContinue = FALSE;
    OfficePostcodeContinue = FALSE;
    name_repeat=0;
    ToDissAlertforRegDate = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideHandler:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
	
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eApp_SI) name:@"EditProspect_Done" object:nil];
    
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    [txtRigNO setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    txtRemark.layer.borderWidth = 1.0f;
    txtRemark.layer.borderColor = [[UIColor grayColor] CGColor];
    
    //easysqlite---------start
	self.db = [DBController sharedDatabaseController:@"hladb.sqlite"];
    NSString *sqlStmt1 = [NSString stringWithFormat:@"SELECT IndexNo, IDtypeNo, otheridtype and otheridtypeno FROM prospect_profile where idtypeno and otheridtype is not null"];
    _tableDB = [_db  ExecuteQuery:sqlStmt1];
    
    
	NSString *sqlStmt2 = [NSString stringWithFormat:@"SELECT OtherIDTypeNo, OtherIDType, IndexNo FROM prospect_profile where OtherIDTypeNo  is not null and  OtherIDTypeNo != ''"];
    _tableCheckSameRecord = [_db  ExecuteQuery:sqlStmt2];
    //---------end
    
    
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
	[txtOfficePostCode addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    [txtrFullName addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
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
	
	[txtRigNO addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	
	
	[txtAnnIncome addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventAllTouchEvents];
	[txtBussinessType addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	
    [txtAnnIncome addTarget:self action:@selector(AnnualIncomeChange:) forControlEvents:UIControlEventEditingDidEnd];
	//[txtAnnIncome addTarget:self action:@selector(AnnualIncomeChange:) forControlEvents:UIControlEventValueChanged];  //test
	
    
    
    [txtHomePostCode addTarget:self action:@selector(EditTextFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    [txtHomePostCode addTarget:self action:@selector(EditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
	
	//[txtHomeAddr1 addTarget:self action:@selector(EditTextFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
	
	//[txtRemark addTarget:self action:@selector(EditTextFieldBegin:) forControlEvents:];
    
    [txtOfficePostCode addTarget:self action:@selector(EditOfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    [txtOfficePostCode addTarget:self action:@selector(OfficeEditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
	
	//  [txtIDType addTarget:self action:@selector(NewICDidChange:) forControlEvents:UIControlEventEditingDidEnd];
	
    [txtIDType addTarget:self action:@selector(NewICTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
	
	
	//detect duplicate id
	[txtIDType addTarget:self action:@selector(IDValidation) forControlEvents:UIControlEventEditingDidEnd];
    [txtOtherIDType addTarget:self action:@selector(OtheriDDidChange:) forControlEvents:UIControlEventEditingDidEnd];
	
	
    txtRemark.delegate = self;
    txtExactDuties.delegate = self;
    txtEmail.delegate = self;
    txtIDType.delegate = self;
    txtrFullName.delegate = self;
    txtOtherIDType.delegate = self;
    txtBussinessType.delegate = self;
    
    txtRigNO.delegate = self;
    txtRigDate.delegate = self;
    
    txtIDType.enabled = YES;
	//    txtOtherIDType.enabled = YES;
    OtherIDType.enabled = YES;
	
    txtHomeAddr1.delegate = self;
    txtHomeAddr2.delegate = self;
    txtHomeAddr3.delegate = self;
    
    txtOfficeAddr1.delegate = self;
    txtOfficeAddr2.delegate = self;
    txtOfficeAddr3.delegate =self;
    
    txtHomePostCode.delegate = self;
    txtOfficePostCode.delegate = self;
    txtAnnIncome.delegate = self;
    txtAnnIncome.keyboardType = UIKeyboardTypeNumberPad;
    
    
    outletTitle.enabled = NO;
    outletReligion.enabled = NO;
    outletRace.enabled = NO;
    outletNationality.enabled = NO;
    outletMaritalStatus.enabled = NO;
    
    // By Benjamin Law on 17/10/2013 for bug 2584
    outletTitle.enabled = YES;
    outletReligion.enabled = YES;
    outletRace.enabled = YES;
    outletNationality.enabled = YES;
    outletMaritalStatus.enabled = YES;
    outletOccup.enabled = YES;
	// OtherIDType.enabled = NO;
    //txtOtherIDType.enabled = NO;
    segGender.enabled = NO;
    
    txtRigDate.userInteractionEnabled=FALSE;
    
   // outletRigDOB.hidden=YES;
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
	// OtherIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
	// txtOtherIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtHomeTown.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtHomeState.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtHomeCountry.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtOfficeTown.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtOfficeState.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtOfficeCountry.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtClass.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
	// txtAnnIncome.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    
    
    
    [outletDelete setBackgroundImage:[[UIImage imageNamed:@"iphone_delete_button.png"] stretchableImageWithLeftCapWidth:8.0f topCapHeight:0.0f]
                            forState:UIControlStateNormal];
    [outletDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    outletDelete.titleLabel.shadowColor = [UIColor lightGrayColor];
    outletDelete.titleLabel.shadowOffset = CGSizeMake(0, -1);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnSave:)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Client Profile Listing" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
    
    
	//  outletDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    checked = NO;
    checked2 = NO;
    isHomeCountry = NO;
    isOffCountry = NO;
	
    
    outletDOB.hidden = YES;
    txtDOB.enabled = NO;
    segGender.enabled = FALSE;
    txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    
    CustomColor = nil;
    
    [myScrollView setScrollEnabled:YES];
    [myScrollView setContentSize:CGSizeMake(1024, 1230)];
    
    txtIDType.delegate = self;
    txtrFullName.delegate = self;
    
    edited = NO;
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"NO" forKey:@"isEdited"];
	[ClientProfile setObject:@"NO" forKey:@"NeedToSave"];
	[ClientProfile setObject:@"NO" forKey:@"HasChanged"];
	[ClientProfile setInteger:1 forKey:@"validateCount"];  //TEST ONLY
	[ClientProfile setObject:@"NO" forKey:@"TabBar"];
	[ClientProfile setObject:@"EDIT" forKey:@"ChangedOn"];
	
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	
	[self.view addGestureRecognizer:tap];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SaveEdit2) name:@"EditProfile_validate" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveToDB) name:@"EditProfile_Save" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(check_edited) name:@"CheckEdited" object:nil];
}


-(void)SaveToUserDefault {
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	
	//[ClientProfile setObject:pp.ProspectID forKey:@"ProspectId"];
	
	NSString *group = @"";
    NSString *title = @"";
    NSString *otherID = @"";
    NSString *OffCountry = @"";
    NSString *HomeCountry = @"";
    NSString *strDOB = @"";
    NSString *marital = @"";
    NSString *nation = @"";
    NSString *race = @"";
    NSString *religion = @"";
	NSString *ResidenceForeignAddressFlag = @"";
	NSString *OfficeForeignAddressFlag = @"";
	
	marital = [outletMaritalStatus.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	nation = [outletNationality.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	race  = [outletRace.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	religion = [outletReligion.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	if([marital isEqualToString:@"- SELECT -"])
		marital = @"";
	if([race isEqualToString:@"- SELECT -"])
		race = @"";
	if([religion isEqualToString:@"- SELECT -"])
		religion = @"";
	if([nation isEqualToString:@"- SELECT -"])
		nation = @"";
	if (txtDOB.text.length == 0) {
		strDOB = [outletDOB.titleLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
	}
	else {
		strDOB = txtDOB.text;
	}
	if (![outletGroup.titleLabel.text isEqualToString:@"- SELECT -"]) {
		group =   [outletGroup.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	}
	else {
		group = outletGroup.titleLabel.text;
	}
	if([group isEqualToString:@"- SELECT -"])
		group = @"";
	group = [self getGroupID:group];
	
	if (![outletTitle.titleLabel.text isEqualToString:@"- SELECT -"]) {
		title = [outletTitle.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	}
	else {
		title = outletTitle.titleLabel.text;
	}
	
	if (![OtherIDType.titleLabel.text isEqualToString:@"- SELECT -"]) {
		otherID =  [OtherIDType.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	}
	else {
		otherID = OtherIDType.titleLabel.text;
	}
	if([otherID isEqualToString:@"- SELECT -"] || [otherID isEqualToString:@""])
		otherID = @"";
	if (otherID == NULL || [otherID isEqualToString:@"(NULL)"])
		otherID = @"";
	
	if (checked) {
		HomeCountry = btnHomeCountry.titleLabel.text;
		SelectedStateCode = txtHomeState.text;
		ResidenceForeignAddressFlag = @"Y";
	}
	else {
		HomeCountry = txtHomeCountry.text;
		ResidenceForeignAddressFlag = @"N";
	}
	
	if (checked2) {
		OffCountry = btnOfficeCountry.titleLabel.text;
		SelectedOfficeStateCode = txtOfficeState.text;
		OfficeForeignAddressFlag = @"Y";
	}
	else {
		OffCountry = txtOfficeCountry.text;
		OfficeForeignAddressFlag = @"N";
	}
	HomeCountry = [self getCountryCode:HomeCountry];
	OffCountry = [self getCountryCode:OffCountry];
	
	if([SelectedStateCode isEqualToString:@"(null)"]  || (SelectedStateCode == NULL))
		SelectedStateCode = @"";
	
	if([TitleCodeSelected isEqualToString:@"(null)"]  || (TitleCodeSelected == NULL))
		TitleCodeSelected = @"";
	if (IDTypeCodeSelected == NULL || [IDTypeCodeSelected isEqualToString:@"(NULL)"] || [IDTypeCodeSelected isEqualToString:@"(null)"])
		IDTypeCodeSelected = @"";
	
	
	if (HomeCountry == NULL || [HomeCountry isEqualToString:@"(NULL)"] || [HomeCountry isEqualToString:@"(null)"])
		HomeCountry = @"";
	if (OffCountry == NULL || [OffCountry isEqualToString:@"(NULL)"] || [OffCountry isEqualToString:@"(null)"])
		OffCountry = @"";
	
	if (SelectedOfficeStateCode == NULL || [SelectedOfficeStateCode isEqualToString:@"(NULL)"] || [SelectedOfficeStateCode isEqualToString:@"(null)"])
		SelectedOfficeStateCode = @"";
	
	if(gender == nil || gender==NULL || [gender isEqualToString:@"(null)"])
		gender=@"";
	
	if(ClientSmoker == nil || ClientSmoker ==NULL || [ClientSmoker isEqualToString:@"(null)"])
		ClientSmoker=@"";
	
	
	
	[ClientProfile setObject:pp.ProspectID forKey:@"ProspectId"];
	[ClientProfile setObject:title forKey:@"title"];
	[ClientProfile setObject:TitleCodeSelected forKey:@"TitleCodeSelected"];
	[ClientProfile setObject:txtrFullName.text forKey:@"txtrFullName"];
	[ClientProfile setObject:txtIDType.text forKey:@"IC"];
	
	[ClientProfile setObject:IDTypeCodeSelected forKey:@"IDTypeCodeSelected"];
	
	if ([IDTypeCodeSelected isEqualToString:@""]) {
		[ClientProfile setObject:@"" forKey:@"txtOtherIDType"];
	}
	else
		[ClientProfile setObject:txtOtherIDType.text forKey:@"txtOtherIDType"];
	
	[ClientProfile setObject:strDOB forKey:@"strDOB"];
	[ClientProfile setObject:gender forKey:@"gender"];
	
	[ClientProfile setObject:marital forKey:@"marital"];
	[ClientProfile setObject:race forKey:@"race"];
	[ClientProfile setObject:religion forKey:@"religion"];
	[ClientProfile setObject:nation forKey:@"nation"];
	
	[ClientProfile setObject:ClientSmoker forKey:@"ClientSmoker"];
	
	[ClientProfile setObject:pp.ProspectOccupationCode forKey:@"OccupCodeSelected"];
	[ClientProfile setObject:txtExactDuties.text forKey:@"txtExactDuties"];
	[ClientProfile setObject:txtAnnIncome.text forKey:@"txtAnnIncome"];
	[ClientProfile setObject:txtBussinessType.text forKey:@"txtBussinessType"];
	
	[ClientProfile setObject:group forKey:@"group"];
	
	[ClientProfile setObject:txtHomeAddr1.text forKey:@"txtHomeAddr1"];
	[ClientProfile setObject:txtHomeAddr2.text forKey:@"txtHomeAddr2"];
	[ClientProfile setObject:txtHomeAddr3.text forKey:@"txtHomeAddr3"];
	[ClientProfile setObject:txtHomePostCode.text forKey:@"txtHomePostCode"];
	[ClientProfile setObject:txtHomeTown.text forKey:@"txtHomeTown"];
	[ClientProfile setObject:HomeCountry forKey:@"HomeCountry"];
	[ClientProfile setObject:SelectedStateCode forKey:@"SelectedStateCode"];
	
	[ClientProfile setObject:txtOfficeAddr1.text forKey:@"txtOfficeAddr1"];
	[ClientProfile setObject:txtOfficeAddr2.text forKey:@"txtOfficeAddr2"];
	[ClientProfile setObject:txtOfficeAddr3.text forKey:@"txtOfficeAddr3"];
	[ClientProfile setObject:txtOfficeTown.text forKey:@"txtOfficeTown"];
	[ClientProfile setObject:txtOfficePostCode.text forKey:@"txtOfficePostCode"];
	[ClientProfile setObject:OffCountry forKey:@"OffCountry"];
	[ClientProfile setObject:SelectedOfficeStateCode forKey:@"SelectedOfficeStateCode"];
	
	[ClientProfile setObject:ResidenceForeignAddressFlag forKey:@"ResidenceForeignAddressFlag"];
	[ClientProfile setObject:OfficeForeignAddressFlag forKey:@"OfficeForeignAddressFlag"];
	
	[ClientProfile setObject:txtPrefix1.text forKey:@"txtPrefix1"];
	[ClientProfile setObject:txtContact1.text forKey:@"txtContact1"];
	[ClientProfile setObject:txtPrefix2.text forKey:@"txtPrefix2"];
	[ClientProfile setObject:txtContact2.text forKey:@"txtContact2"];
	[ClientProfile setObject:txtPrefix3.text forKey:@"txtPrefix3"];
	[ClientProfile setObject:txtContact3.text forKey:@"txtContact3"];
	[ClientProfile setObject:txtPrefix4.text forKey:@"txtPrefix4"];
	[ClientProfile setObject:txtContact4.text forKey:@"txtContact4"];
	
	[ClientProfile setObject:txtRemark.text forKey:@"txtRemark"];
	[ClientProfile setObject:txtEmail.text forKey:@"txtEmail"];
	
	
}

-(NSString *)SaveFromUserDefault {
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	
	NSString *group = @"";
    NSString *title = @"";
    //NSString *otherID = @"";
    NSString *OffCountry = @"";
    NSString *HomeCountry = @"";
    NSString *strDOB = @"";
    NSString *marital = @"";
    NSString *nation = @"";
    NSString *race = @"";
    NSString *gstdateoutlet = @"";
    NSString *religion = @"";
	NSString *ResidenceForeignAddressFlag = @"";
	NSString *OfficeForeignAddressFlag = @"";
	NSString *ProspectID;
	
	
	//TEST ONLY
	
	NSString *ErrMsg = @"";
	ErrMsg = [self Validation2];
	
	BOOL valid;
	
	if ([ErrMsg isEqualToString:@""])
		valid = true;
	else
		valid = false;
	
	
	if (valid)
		NSLog(@"PASS VALIDATION");
	
	//#### TEST END HERE
	
	NSString *FullName = [ClientProfile stringForKey:@"txtrFullName"];
	title = [ClientProfile stringForKey:@"title"];
	TitleCodeSelected = [ClientProfile stringForKey:@"TitleCodeSelected"];
	strDOB = [ClientProfile stringForKey:@"strDOB"];
	gender = [ClientProfile stringForKey:@"gender"];
	NSString *HomeAddr1 = [ClientProfile stringForKey:@"txtHomeAddr1"];
	NSString *HomeAddr2 = [ClientProfile stringForKey:@"txtHomeAddr2"];
	NSString *HomeAddr3 = [ClientProfile stringForKey:@"txtHomeAddr3"];
	NSString *HomeTown = [ClientProfile stringForKey:@"txtHomeTown"];
	SelectedStateCode = [ClientProfile stringForKey:@"SelectedStateCode"];
	NSString *HomePostCode = [ClientProfile stringForKey:@"txtHomePostCode"];
	HomeCountry = [ClientProfile stringForKey:@"HomeCountry"];
	if (![HomeCountry isEqualToString:@"MAL"])
		SelectedStateCode = @"";
	NSString *OfficeAddr1 = [ClientProfile stringForKey:@"txtOfficeAddr1"];
	NSString *OfficeAddr2 = [ClientProfile stringForKey:@"txtOfficeAddr2"];
	NSString *OfficeAddr3 = [ClientProfile stringForKey:@"txtOfficeAddr3"];
	NSString *OfficeTown = [ClientProfile stringForKey:@"txtOfficeTown"];
	SelectedOfficeStateCode = [ClientProfile stringForKey:@"SelectedOfficeStateCode"];
	NSString *OfficePostCode = [ClientProfile stringForKey:@"txtOfficePostCode"];
	OffCountry = [ClientProfile stringForKey:@"OffCountry"];
	if (![OffCountry isEqualToString:@"MAL"])
		SelectedOfficeStateCode = @"";
	
	ResidenceForeignAddressFlag = [ClientProfile stringForKey:@"ResidenceForeignAddressFlag"];
	OfficeForeignAddressFlag = [ClientProfile stringForKey:@"OfficeForeignAddressFlag"];
	
	NSString *Email = [ClientProfile stringForKey:@"txtEmail"];
	OccupCodeSelected = [ClientProfile stringForKey:@"OccupCodeSelected"];
	NSString *ExactDuties = [ClientProfile stringForKey:@"txtExactDuties"];
	NSString *Remark = [ClientProfile stringForKey:@"txtRemark"];
	group = [ClientProfile stringForKey:@"group"];
	
	NSString *IDType = [ClientProfile stringForKey:@"IC"];
	IDTypeCodeSelected = [ClientProfile stringForKey:@"IDTypeCodeSelected"];
	NSString *OtherIDType2 = [ClientProfile stringForKey:@"txtOtherIDType"];
	
	ClientSmoker = [ClientProfile stringForKey:@"ClientSmoker"];
	NSString *AnnIncome = [ClientProfile stringForKey:@"txtAnnIncome"];
	NSString *BussinessType = [ClientProfile stringForKey:@"txtBussinessType"];
	race = [ClientProfile stringForKey:@"race"];
	marital = [ClientProfile stringForKey:@"marital"];
	nation = [ClientProfile stringForKey:@"nation"];
	religion = [ClientProfile stringForKey:@"religion"];
	ProspectID = [ClientProfile stringForKey:@"ProspectId"];
	
	NSString *Prefix1 = [ClientProfile stringForKey:@"txtPrefix1"];
	NSString *Contact1 = [ClientProfile stringForKey:@"txtContact1"];
	NSString *Prefix2 = [ClientProfile stringForKey:@"txtPrefix2"];
	NSString *Contact2 = [ClientProfile stringForKey:@"txtContact2"];
	NSString *Prefix3 = [ClientProfile stringForKey:@"txtPrefix3"];
	NSString *Contact3 = [ClientProfile stringForKey:@"txtContact3"];
	NSString *Prefix4 = [ClientProfile stringForKey:@"txtPrefix4"];
	NSString *Contact4 = [ClientProfile stringForKey:@"txtContact4"];
	
	
	//sqlite3_stmt *statement;
    //const char *dbpath = [databasePath UTF8String];
	if (valid) {
		NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *docsDir = [dirPaths objectAtIndex:0];
		
		databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
		
		FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
		[db open];
		FMResultSet *result;
		
		int counter = 0;
		
		
        
        //GET PP  CHANGES COUNTER
        //int counter = 0;
        result = [db executeQuery:@"SELECT ProspectProfileChangesCounter from prospect_profile WHERE indexNo = ?", ProspectID];
        while ([result next]) {
            counter =  [result intForColumn:@"ProspectProfileChangesCounter"];
        }
		
        [result close];
        
        counter = counter+1;
		
        NSString *str_counter = [NSString stringWithFormat:@"%i",counter];
        NSString *insertSQL = [NSString stringWithFormat:
                               @"update prospect_profile set \"ProspectName\"=\'%@\', \"ProspectDOB\"=\"%@\", \"ProspectGender\"=\"%@\", \"ResidenceAddress1\"=\"%@\", \"ResidenceAddress2\"=\"%@\", \"ResidenceAddress3\"=\"%@\", \"ResidenceAddressTown\"=\"%@\", \"ResidenceAddressState\"=\"%@\", \"ResidenceAddressPostCode\"=\"%@\", \"ResidenceAddressCountry\"=\"%@\", \"OfficeAddress1\"=\"%@\", \"OfficeAddress2\"=\"%@\", \"OfficeAddress3\"=\"%@\", \"OfficeAddressTown\"=\"%@\",\"OfficeAddressState\"=\"%@\", \"OfficeAddressPostCode\"=\"%@\", \"OfficeAddressCountry\"=\"%@\", \"ProspectEmail\"= \"%@\", \"ProspectOccupationCode\"=\"%@\", \"ExactDuties\"=\"%@\", \"ProspectRemark\"=\"%@\", \"DateModified\"=%@,\"ModifiedBy\"=\"%@\", \"ProspectGroup\"=\"%@\", \"ProspectTitle\"=\"%@\", \"IDTypeNo\"=\"%@\", \"OtherIDType\"=\"%@\", \"OtherIDTypeNo\"=\"%@\", \"Smoker\"=\"%@\", \"AnnualIncome\"=\"%@\", \"BussinessType\"=\"%@\", \"Race\"=\"%@\", \"MaritalStatus\"=\"%@\", \"Nationality\"=\"%@\", \"Religion\"=\"%@\",\"ProspectProfileChangesCounter\"=\"%@\"   where indexNo = \"%@\" "
                               "", FullName, strDOB, gender, HomeAddr1, HomeAddr2, HomeAddr3, HomeTown, SelectedStateCode, HomePostCode, HomeCountry, OfficeAddr1, OfficeAddr2, OfficeAddr3, OfficeTown, SelectedOfficeStateCode, OfficePostCode, OffCountry, Email, OccupCodeSelected, ExactDuties, Remark, @"datetime(\"now\", \"+8 hour\")", @"1", group, TitleCodeSelected, IDType, IDTypeCodeSelected, OtherIDType2, ClientSmoker, AnnIncome, BussinessType,race, marital, nation, religion,str_counter,ProspectID];
        
		// NSLog(@"UPDATE PPSQL1: %@", insertSQL);
		
		bool success = [db executeUpdate:insertSQL];
		if (success) {
			[self GetLastID];
		}
		else {
			NSLog(@"Error at SaveClientProfile 559: %@", [db lastErrorMessage]);
		}
		
		//******** START ****************  UPDATE CLIENT OF LA1, LA2 (NOT PO) IN EAPP   *********************************
		
		
		// NSLog(@"pp: %@", pp.ProspectID);
		//Note: why only update LA_details when POFlag = N, need confirmation on this ##ENS
		
		NSString *query = [NSString stringWithFormat:@"SELECT COUNT(*) FROM eProposal_LA_Details WHERE ProspectProfileID = '%@'", ProspectID];
		result = [db executeQuery:query];
		
		while ([result next]) {
			int count = [result intForColumn:@"COUNT(*)"];
			if(count > 0 )
				
			{
				
				NSString *str_counter = [NSString stringWithFormat:@"%i",counter];
				
				if ([gender isEqualToString:@"MALE"]) {
					gender = @"M";
				}
				else if ([gender isEqualToString:@"FEMALE"]) {
					gender = @"F";
				}
				
				NSString *update_query = [NSString stringWithFormat:@"Update eProposal_LA_Details SET \"LAName\" = \"%@\", \"LASex\" = \"%@\", \"LADOB\" = \"%@\", \"LANewICNO\" = \"%@\", \"LAOtherIDType\" = \"%@\", \"LAOtherID\" = \"%@\", \"LAMaritalStatus\" = \"%@\", \"LARace\" = \"%@\", \"LAReligion\" = \"%@\", \"LANationality\" = \"%@\", \"LAOccupationCode\" = \"%@\", \"LAExactDuties\" = \"%@\", \"LATypeOfBusiness\" = \"%@\", \"ResidenceAddress1\" = \"%@\", \"ResidenceAddress2\" = \"%@\", \"ResidenceAddress3\" = \"%@\", \"ResidenceTown\" = \"%@\", \"ResidenceState\" = \"%@\", \"ResidencePostcode\" = \"%@\", \"ResidenceCountry\" = \"%@\", \"OfficeAddress1\" = \"%@\", \"OfficeAddress2\" = \"%@\", \"OfficeAddress3\" = \"%@\", \"OfficeTown\" = \"%@\", \"OfficeState\" = \"%@\", \"OfficePostcode\" = \"%@\", \"OfficeCountry\" = \"%@\", \"ResidenceForeignAddressFlag\" = \"%@\", \"OfficeForeignAddressFlag\" = \"%@\", \"ResidencePhoneNo\" = \"%@\", \"MobilePhoneNo\" = \"%@\", \"OfficePhoneNo\" = \"%@\", \"FaxPhoneNo\" = \"%@\",  \"ResidencePhoneNoPrefix\" = \"%@\", \"MobilePhoneNoPrefix\" = \"%@\", \"OfficePhoneNoPrefix\" = \"%@\", \"FaxPhoneNoPrefix\" = \"%@\", \"EmailAddress\" = \"%@\", \"LASmoker\" = \"%@\", \"ProspectProfileChangesCounter\" = \"%@\", \"GST_registered\" = \"%@\", \"GST_registrationNo\" = \"%@\", \"GST_registrationDate\" = \"%@\", \"GST_exempted\" = \"%@\" WHERE  ProspectProfileID = \"%@\";",
										  
										  FullName,
										  gender,
										  strDOB,
										  IDType,
										  IDTypeCodeSelected,
										  OtherIDType2,
										  
										  marital,
										  race,
										  religion,
										  nation,
										  OccupCodeSelected,
										  ExactDuties,
										  BussinessType,
										  
										  HomeAddr1,
										  HomeAddr2,
										  HomeAddr3,
										  
										  HomeTown,
										  SelectedStateCode,
										  HomePostCode,
										  HomeCountry,
										  
										  OfficeAddr1,
										  OfficeAddr2,
										  OfficeAddr3,
										  OfficeTown,
										  SelectedOfficeStateCode,
										  OfficePostCode,
										  OffCountry,
										  
										  ResidenceForeignAddressFlag,
										  OfficeForeignAddressFlag,
										  
										  Contact1,
										  Contact2,
										  Contact3,
										  Contact4,
										  Prefix1,
										  Prefix2,
										  Prefix3,
										  Prefix4,
										  Email,
										  ClientSmoker,
										  str_counter,
										  GSTRigperson,
										  txtRigNO.text,
										  gstdateoutlet,
										  GSTRigExempted,
										  ProspectID];
				
				[db executeUpdate:update_query];
				//NSLog(@"UPDATE PP QUERY: %@", update_query);
				
				
			}
		}
		[result close];
		
		//********* END ***************  UPDATE CLIENT OF LA1, LA2 (NOT PO) IN EAPP   *********************************
        
        //******** START ****************  DELETE CLIENT OF LA1, LA2, PO IN EAPP for CONFIRMED CASE   *********************************
        
        //Note: Only delete LA_details when Status = 3
        
        NSString *query_eApp = [NSString stringWithFormat:@"SELECT COUNT(*) FROM eApp_Listing WHERE ClientProfileID = '%@' AND Status = '%@'", ProspectID,@"3"];
        NSString *eProposalNo;
        NSString *ProposalNo_to_delete;
        result = [db executeQuery:query_eApp];
        [db open];
        
        count_eApp = 0;
        
        while ([result next]) {
            
            count_eApp = [result intForColumn:@"COUNT(*)"] + count_eApp;
            if ([result intForColumn:@"COUNT(*)"] > 0) {
				
                FMResultSet *result_get_proposal = [db executeQuery:@"SELECT * from eApp_Listing WHERE ClientProfileID = ? AND Status = ?", ProspectID,@"3"];
                while ([result_get_proposal next]) {
                    ProposalNo_to_delete =  [result_get_proposal objectForColumnName:@"ProposalNo"];
                    [self deleteConfirmCase:ProposalNo_to_delete database:db];
					
                }
            }
            
        }
        
        // Check Policy Owner, LA1, LA2
        FMResultSet *result_checkLA = [db executeQuery:@"SELECT * from eProposal_LA_Details WHERE ProspectProfileID = ?", ProspectID];
        while ([result_checkLA next]) {
            
            eProposalNo =  [result_checkLA objectForColumnName:@"eProposalNo"];
            
            FMResultSet *result_check_proposal = [db executeQuery:@"SELECT COUNT(*) from eApp_Listing WHERE ProposalNo = ? AND Status = ?", eProposalNo,@"3"];
            
            while ([result_check_proposal next]) {
                
                count_eApp = [result_check_proposal intForColumn:@"COUNT(*)"] + count_eApp;
                if ([result_check_proposal intForColumn:@"COUNT(*)"] > 0) {
                    ProposalNo_to_delete =  [result_checkLA objectForColumnName:@"eProposalNo"];
                    [self deleteConfirmCase:ProposalNo_to_delete database:db];
                }
                
            }
            
        }
        
        
        // Check Policy Owner Family
        FMResultSet *result_checkFamily = [db executeQuery:@"SELECT * from eProposal_CFF_Family_Details WHERE ClientProfileID = ?", ProspectID];
        while ([result_checkFamily next]) {
            
            eProposalNo =  [result_checkFamily objectForColumnName:@"eProposalNo"];
            
            FMResultSet *result_check_proposal2 = [db executeQuery:@"SELECT COUNT(*) from eApp_Listing WHERE ProposalNo = ? AND Status = ?", eProposalNo,@"3"];
            
            while ([result_check_proposal2 next]) {
                
                count_eApp = [result_check_proposal2 intForColumn:@"COUNT(*)"] + count_eApp;
                if ([result_check_proposal2 intForColumn:@"COUNT(*)"] > 0) {
                    ProposalNo_to_delete =  [result_checkFamily objectForColumnName:@"eProposalNo"];
                    [self deleteConfirmCase:ProposalNo_to_delete database:db];
                }
				
            }
            
        }
        
        // to get IC, OtherID and OtherIDNo
        NSString *IDTypeNo;
        NSString *OtherIDType;
        NSString *OtherIDTypeNo;
        FMResultSet *get_IC = [db executeQuery:@"SELECT * from prospect_profile WHERE IndexNo = ?", ProspectID];
        while ([get_IC next]) {
            IDTypeNo =  [get_IC objectForColumnName:@"IDTypeNo"];
            OtherIDType =  [get_IC objectForColumnName:@"OtherType"];
            OtherIDTypeNo =  [get_IC objectForColumnName:@"OtherTypeNo"];
        }
        
        // Check Policy Spouse
        FMResultSet *result_checkSpouse = [db executeQuery:@"SELECT * from eProposal_CFF_Personal_Details WHERE NewICNo = ? OR (OtherIDType = ? AND OtherID = ?)", IDTypeNo,OtherIDType,OtherIDTypeNo];
        while ([result_checkSpouse next]) {
            
            eProposalNo =  [result_checkSpouse objectForColumnName:@"eProposalNo"];
			
            FMResultSet *result_check_proposal3 = [db executeQuery:@"SELECT COUNT(*) from eApp_Listing WHERE ProposalNo = ? AND Status = ?", eProposalNo,@"3"];
            
            while ([result_check_proposal3 next]) {
                
                count_eApp = [result_check_proposal3 intForColumn:@"COUNT(*)"] + count_eApp;
                if ([result_check_proposal3 intForColumn:@"COUNT(*)"] > 0) {
                    ProposalNo_to_delete =  [result_checkSpouse objectForColumnName:@"eProposalNo"];
                    [self deleteConfirmCase:ProposalNo_to_delete database:db];
                }
				
                
            }
            
        }
        
        [result_checkLA close];
        [result_checkFamily close];
        [result_checkSpouse close];
        
        //******** END ****************  DELETE CLIENT OF LA1, LA2, PO IN EAPP for CONFIRMED CASE   *********************************
        
        
		
		//*** Update in CFF ***** ##Added by Emi
		
		
		//Get proposal No
		
		NSString *proposal = @"";
		//NSLog(@"PP: %@", pp.ProspectID);
		result = [db executeQuery:@"SELECT ProposalNo from eApp_Listing where ClientProfileID = ?", ProspectID];
		NSInteger *proposalNoCount = 0;
		while ([result next]) {
			proposalNoCount = proposalNoCount + 1;
			proposal = [result objectForColumnName:@"ProposalNo"];
		}
		
		NSString *update_query;
		if (proposalNoCount > 0) {
			NSLog(@"Proposal %@", proposal);
			
			
			update_query = [NSString stringWithFormat:@"Update eApp_Listing SET \"POName\" = \"%@\" WHERE  ClientProfileID = \"%@\";",
							txtrFullName.text,
							pp.ProspectID];
			[db executeUpdate:update_query];
			
			[result close];
			
			
			NSString *CFFID = @"";
			//NSLog(@"PP: %@", pp.ProspectID);
			result = [db executeQuery:@"SELECT ID from CFF_Master where ClientProfileID = ? and CFFType = 'Master'", ProspectID];
			int count = 0;
			while ([result next]) {
				count = count + 1;
				CFFID = [result objectForColumnName:@"ID"];
			}
			
			if (count > 0) {
				
				update_query = @"";
				update_query = [NSString stringWithFormat:@"Update CFF_Personal_Details SET \"Name\" = \"%@\", \"Sex\" = \"%@\", \"DOB\" = \"%@\", \"NewICNO\" = \"%@\", \"OtherIDType\" = \"%@\", \"OtherID\" = \"%@\", \"MaritalStatus\" = \"%@\", \"Race\" = \"%@\", \"Religion\" = \"%@\", \"Nationality\" = \"%@\", \"OccupationCode\" = \"%@\", \"MailingAddress1\" = \"%@\", \"MailingAddress2\" = \"%@\", \"MailingAddress3\" = \"%@\", \"MailingTown\" = \"%@\", \"MailingState\" = \"%@\", \"MailingPostCode\" = \"%@\", \"MailingCountry\" = \"%@\", \"ResidencePhoneNo\" = \"%@\", \"MobilePhoneNo\" = \"%@\",\"OfficePhoneNo\" = \"%@\", \"FaxPhoneNo\" = \"%@\",  \"EmailAddress\" = \"%@\", \"Smoker\" = \"%@\", \"ResidencePhoneNoExt\" = \"%@\", \"MobilePhoneNoExt\" = \"%@\", \"OfficePhoneNoExt\" = \"%@\", \"FaxPhoneNoExt\" = \"%@\" WHERE  CFFID = \"%@\";",
								
								FullName,
								gender,
								strDOB,
								txtIDType,
								IDTypeCodeSelected,
								OtherIDType2,
								
								marital,
								race,
								religion,
								nation,
								OccupCodeSelected,
								
								HomeAddr1,
								HomeAddr2,
								HomeAddr3,
								
								HomeTown,
								SelectedStateCode,
								HomePostCode,
								HomeCountry,
								
								Contact1,
								Contact2,
								Contact3,
								Contact4,
								Email,
								ClientSmoker,
								Prefix1,
								Prefix2,
								Prefix3,
								Prefix4,
								CFFID];
				
				[db executeUpdate:update_query];
			}
			
			
		}
		//****Update CFF end Here ********
		//**** Update eProposal start here *********
		
		NSString *CFFID = @"";
		//NSLog(@"PP: %@", pp.ProspectID);
		result = [db executeQuery:@"SELECT ID from eProposal_CFF_Master where ClientProfileID = ? and CFFType = 'Master'", ProspectID];
		int count = 0;
		while ([result next]) {
			count = count + 1;
			CFFID = [result objectForColumnName:@"ID"];
		}
		
		if (count > 0) {
			
			NSString *update_query  = [NSString stringWithFormat:@"Update eProposal_CFF_Personal_Details SET \"Name\" = \"%@\", \"Sex\" = \"%@\", \"DOB\" = \"%@\", \"NewICNO\" = \"%@\", \"OtherIDType\" = \"%@\", \"OtherID\" = \"%@\", \"MaritalStatus\" = \"%@\", \"Race\" = \"%@\", \"Religion\" = \"%@\", \"Nationality\" = \"%@\", \"OccupationCode\" = \"%@\", \"MailingAddress1\" = \"%@\", \"MailingAddress2\" = \"%@\", \"MailingAddress3\" = \"%@\", \"MailingTown\" = \"%@\", \"MailingState\" = \"%@\", \"MailingPostCode\" = \"%@\", \"MailingCountry\" = \"%@\", \"ResidencePhoneNo\" = \"%@\", \"MobilePhoneNo\" = \"%@\",\"OfficePhoneNo\" = \"%@\", \"FaxPhoneNo\" = \"%@\",  \"EmailAddress\" = \"%@\", \"Smoker\" = \"%@\", \"ResidencePhoneNoExt\" = \"%@\", \"MobilePhoneNoExt\" = \"%@\", \"OfficePhoneNoExt\" = \"%@\", \"FaxPhoneNoExt\" = \"%@\" WHERE  CFFID = \"%@\";",
									   
									   FullName,
									   gender,
									   strDOB,
									   IDType,
									   IDTypeCodeSelected,
									   OtherIDType2,
									   
									   marital,
									   race,
									   religion,
									   nation,
									   OccupCodeSelected,
									   
									   HomeAddr1,
									   HomeAddr2,
									   HomeAddr3,
									   
									   HomeTown,
									   SelectedStateCode,
									   HomePostCode,
									   HomeCountry,
									   
									   Contact1,
									   Contact2,
									   Contact3,
									   Contact4,
									   Email,
									   ClientSmoker,
									   Prefix1,
									   Prefix2,
									   Prefix3,
									   Prefix4,
									   CFFID];
			
			[db executeUpdate:update_query];
		}
		
		
		// ***** Update Proposal end here *********
		//Update address in nominee (If Nominee address set same as PO)
		
		if (proposalNoCount > 0) {
			NSString *update_query  = [NSString stringWithFormat:@"Update eProposal_NM_Details SET \"NMAddress1\" = \"%@\", \"NMAddress2\" = \"%@\", \"NMAddress3\" = \"%@\", \"NMTown\" = \"%@\", \"NMState\" = \"%@\", \"NMPostCode\" = \"%@\", \"NMCountry\" = \"%@\" WHERE  eProposalNo = \"%@\" and NMSamePOAddress = 'same';",
									   
									   HomeAddr1,
									   HomeAddr2,
									   HomeAddr3,
									   
									   HomeTown,
									   SelectedStateCode,
									   HomePostCode,
									   HomeCountry,
									   proposal];
			
			[db executeUpdate:update_query];
			
			update_query = @"";
			update_query  = [NSString stringWithFormat:@"Update eProposal_Trustee_Details SET \"TrusteeAddress1\" = \"%@\", \"TrusteeAddress2\" = \"%@\", \"TrusteeAddress3\" = \"%@\", \"TrusteeTown\" = \"%@\", \"TrusteeState\" = \"%@\", \"TrusteePostcode\" = \"%@\", \"TrusteeCountry\" = \"%@\" WHERE  eProposalNo = \"%@\" and TrusteeSameAsPO = 'Y';",
							 
							 HomeAddr1,
							 HomeAddr2,
							 HomeAddr3,
							 
							 HomeTown,
							 SelectedStateCode,
							 HomePostCode,
							 HomeCountry,
							 proposal];
			
			[db executeUpdate:update_query];
			
		}
		ErrMsg = @"Save Succeed";
		
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Save Succeed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[db close];
	}
	
	return ErrMsg;
	
}


-(void) deleteConfirmCase:(NSString *)ProposalNo_to_delete database:(FMDatabase *)db
{
	
	//    if(count_eApp > 0 )
	//    {
    
	[db executeUpdate:@"DELETE FROM eProposal WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_Additional_Questions_1 WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_Additional_Questions_1 Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_Additional_Questions_2 WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_Additional_Questions_2 Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_CA WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_CA Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_CA_Recommendation WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_CA_Recommendation Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_CA_Recommendation_Rider WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_CA_Recommendation_Rider Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_Education WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_Education Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_Education_Details WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_Education_Details Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_Family_Details WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_Family_Details Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_Master WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_Master Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_Personal_Details WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_Pesonal_Details Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_Protection WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_Protction Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_Protection_Details WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_Protection_Details Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_RecordOfAdvice WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_RecordOfAdvice Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_RecordOfAdvice_Rider WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_RecordOfAdvice_Rider Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_Retirement WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_Retirement Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_Retirement_Details WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_Retirement_Details Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_SavingsInvest WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_SavingsInvest Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_CFF_SavingsInvest_Details WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_CFF_SavingsInvest_Details Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_Existing_Policy_1 WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_Existing_Policy_1 Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_Existing_Policy_2 WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_Existing_Policy_2 Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_LA_Details WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_LA_Details Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_NM_Details WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_NM_Details Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eProposal_Trustee_Details WHERE eProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_Trustee_Details Table Cleaned for Confirmed Case.");
	
	[db executeUpdate:@"DELETE FROM eApp_Listing WHERE ProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eApp_Listing Table Cleaned for Confirmed Case.");
    
	[db executeUpdate:@"DELETE FROM eProposal_Signature WHERE ProposalNo = ?", ProposalNo_to_delete];
	NSLog(@"Prospect data changed. eProposal_Signature Table Cleaned for Confirmed Case.");
	//    }
	
}

-(void)hideKeyboard{
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
    
}

- (void) keyboardWillHideHandler:(NSNotification *)notification {
    self.navigationItem.rightBarButtonItem.enabled = TRUE;
}


-(void) check_edited
{
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	
    NSString *name = [txtrFullName.text stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *ic = [txtIDType.text stringByTrimmingCharactersInSet:
					[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *duties = [txtExactDuties.text stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *busstype = [txtBussinessType.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *income = [txtAnnIncome.text stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *home1 = [txtHomeAddr1.text stringByTrimmingCharactersInSet:
                       [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *home2 = [txtHomeAddr2.text stringByTrimmingCharactersInSet:
                       [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *home3 = [txtHomeAddr3.text stringByTrimmingCharactersInSet:
                       [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *home_postcode = [txtHomePostCode.text stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *office1 = [txtOfficeAddr1.text stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *office2 = [txtOfficeAddr2.text stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *office3 = [txtOfficeAddr3.text stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    
    
    NSString *office_postcode = [txtOfficePostCode.text stringByTrimmingCharactersInSet:
                                 [NSCharacterSet whitespaceCharacterSet]];
    
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
    
    NSString *email = [txtEmail.text stringByTrimmingCharactersInSet:
                       [NSCharacterSet whitespaceCharacterSet]];
    NSString *remark = [txtRemark.text stringByTrimmingCharactersInSet:
						[NSCharacterSet whitespaceCharacterSet]];
	
    pp.ResidenceAddress1 = [pp.ResidenceAddress1 stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]];
    
    pp.OfficeAddress1 = [pp.OfficeAddress1 stringByTrimmingCharactersInSet:
						 [NSCharacterSet whitespaceCharacterSet]];
	if (temp_pre4 == nil) {
		temp_pre4 = @"";
	}
	if (temp_pre3 == nil) {
		temp_pre3 = @"";
	}
	if (temp_pre2 == nil) {
		temp_pre2 = @"";
	}
	if (temp_pre1 == nil) {
		temp_pre1 = @"";
	}
	if (temp_cont4 == nil) {
		temp_cont4 = @"";
	}
	
    if(![name isEqualToString:pp.ProspectName])
    {
        edited = YES;
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		//   NSLog(@"1");
        
    }
    else if(![ic isEqualToString:pp.IDTypeNo])
    {
        edited = YES;
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		//   NSLog(@"2");
		
    }
    else if(![duties isEqualToString:pp.ExactDuties])
    {
        edited = YES;
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		//    NSLog(@"3");
		
    }
    else if(![busstype isEqualToString:pp.BussinessType])
    {
        edited = YES;
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		
		//     NSLog(@"4");
		
    }
    else if(![income isEqualToString:pp.AnnualIncome])
    {
        edited = YES;
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		//     NSLog(@"5");
		
    }
    else if(![home1 isEqualToString:pp.ResidenceAddress1])
    {
		//   NSLog(@"home1 - |%@|    pp.ResidenceAddress1 - |%@| ",home1,pp.ResidenceAddress1);
        edited = YES;
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		//    NSLog(@"6");
        
    }
    
    else if(![home2 isEqualToString:pp.ResidenceAddress2])
    {
        edited = YES;
		
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		//    NSLog(@"7");
		
    }
    else if(![home3 isEqualToString:pp.ResidenceAddress3])
    {
        edited = YES;
		
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		
		//     NSLog(@"8");
		
    }
    else if(![home_postcode isEqualToString:pp.ResidenceAddressPostCode])
    {
        edited = YES;
		
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		
		//       NSLog(@"9");
    }
    
    else if(![office1 isEqualToString:pp.OfficeAddress1])
    {
        edited = YES;
		
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		
		//     NSLog(@"10");
		
    }
    
    else if(![office2 isEqualToString:pp.OfficeAddress2])
    {
        edited = YES;
		
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		
		//        NSLog(@"11");
    }
    else if(![office3 isEqualToString:pp.OfficeAddress3])
    {
        edited = YES;
		
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		
		//    NSLog(@"12");
        
    }
    else if(![office_postcode isEqualToString:pp.OfficeAddressPostCode])
    {
        edited = YES;
		
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		
		//     NSLog(@"13");
		
    }
    else if(![pre1 isEqualToString:temp_pre1])
    {
        edited = YES;
		
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		
		//    NSLog(@"14");
		
    }
    else if(![pre2 isEqualToString:temp_pre2])
    {
        edited = YES;
		
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		
		//     NSLog(@"15");
		
    }
    else if(![pre3 isEqualToString:temp_pre3])
    {
        edited = YES;
		
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		
		//     NSLog(@"16");
		
    }
    else if(![pre4 isEqualToString:temp_pre4])
    {
        edited = YES;
		
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		
		//     NSLog(@"17");
		
    }
    
    else if(![cont1 isEqualToString:temp_cont1])
    {
        edited = YES;
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		
		//     NSLog(@"18");
		
    }
    else if(![cont2 isEqualToString:temp_cont2])
    {
        edited = YES;
		
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		
		//     NSLog(@"19");
		
    }
    else if(![cont3 isEqualToString:temp_cont3])
    {
        edited = YES;
		
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		
		//     NSLog(@"20");
		
    }
    else if(![cont4 isEqualToString:temp_cont4])
    {
        edited = YES;
		
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		//    NSLog(@"21");
		
    }
	
    else if(![email isEqualToString:pp.ProspectEmail])
    {
        edited = YES;
		
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		
		
		//     NSLog(@"22");
    }
    else if(![remark isEqualToString:pp.ProspectRemark])
    {
        edited = YES;
		[ClientProfile setObject:@"YES" forKey:@"isEdited"];
		
		//    NSLog(@"23");
    }

	//for group, edited not change to YES
	if ([[ClientProfile objectForKey:@"isEdited"] isEqualToString:@"YES"]) {
		edited = YES;
	}

}

-(void) returnTolisting {
	[self resignFirstResponder];
	[self.view endEditing:YES];
	[self.navigationController popViewControllerAnimated:YES];
}

- (void) back
{
    [self check_edited];
    
	
    if(!edited)
    {
        
        [self resignFirstResponder];
        [self.view endEditing:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        
        [self hideKeyboard];
        UIAlertView *back_alert = [[UIAlertView alloc] initWithTitle:@" "
                                                             message:@"Do you want to save?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        back_alert.tag = 5000;
        [back_alert show];
        
    }
	
    
}


-(void) eApp_SI
{
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(btnSave2:)];
    
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(btnCancel:)];
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    strChanges = @"Yes";
	
	//ADD by EMI 03/07/2014 : Detect Change when user touch text Field
	
	//	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	//	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
	
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
	
	//	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	//	[ClientProfile setObject:txtExactDuties.text forKey:@"txtExactDuties"];
	//	[ClientProfile setObject:txtRemark.text forKey:@"txtRemark"];
	//
	//	NSString *save = [ClientProfile stringForKey:@"NeedToSave"];
	//	if ([save isEqualToString:@"YES"]) {
	//		[self SaveFromUserDefault];
	//		NSLog(@"UIVIEW");
	//	}
	
}

- (void)textViewDidChange:(UITextView *)textView
{
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
	
	//NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:txtExactDuties.text forKey:@"txtExactDuties"];
	[ClientProfile setObject:txtRemark.text forKey:@"txtRemark"];
	
	//	NSString *save = [ClientProfile stringForKey:@"NeedToSave"];
	//	if ([save isEqualToString:@"YES"]) {
	//		[self SaveFromUserDefault];
	//		NSLog(@"UIVIEW");
	//	}
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (interfaceOrientation==UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        return YES;
    
    return NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    NSString *occup  = [outletOccup.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([occup isEqualToString:@"- SELECT -"])
        outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    else
        outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"" forKey:@"isNew"];
	[ClientProfile setObject:@"" forKey:@"isEdited"];
    
	/*  outletTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	 outletDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	 outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	 OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	 outletGroup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	 */
    [_delegate FinishEdit];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

-(void) check_OID_BirthCer_Passport
{
    if([pp.OtherIDType isEqualToString:@"OLD IDENTIFICATION NO"] || [pp.OtherIDType isEqualToString:@"BIRTH CERTIFICATE"] || [pp.OtherIDType isEqualToString:@"PASSPORT"] || [pp.OtherIDType isEqualToString:@"OLDIC"] || [pp.OtherIDType isEqualToString:@"BC"] || [pp.OtherIDType isEqualToString:@"PP"])
    {
		if ([pp.IDTypeNo isEqualToString:@""] || pp.IDTypeNo == NULL)
			
        {
            txtIDType.enabled=true;
            txtIDType.backgroundColor = [UIColor whiteColor];
        }
		
    }
	
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

- (NSString*) getGroupID:(NSString*)groupname
{
	groupname = [groupname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSString *groupid = @"";
	FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
	[db open];
    
	FMResultSet *result = [db executeQuery:@"SELECT id from prospect_groups WHERE name = ?", groupname];
	while ([result next]) {
		groupid =  [result stringForColumn:@"id"];
        
	}
	[result close];
	[result close];
    
	return groupid;
    
}

- (NSString*) getGroupName:(NSString*)groupid
{
    
	groupid = [groupid stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSString *groupname = @"";
	FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
	[db open];
    
	FMResultSet *result = [db executeQuery:@"SELECT name from prospect_groups WHERE id = ?", groupid];
	while ([result next]) {
		groupname =  [result stringForColumn:@"name"];
		
	}
	[result close];
	[result close];
    
	return groupname;
    
}

- (void) LoadGroupArr {
	
	NSString *GroupID;
	NSString *prosGroup = pp.ProspectGroup;
	NSString *groupName;
	NSMutableArray *groupArr = [NSMutableArray array];
	
	if (![prosGroup isEqualToString:@""]) {
		int noI = [[prosGroup componentsSeparatedByString:@","] count] - 1;
		for (int a=0; a <= noI; a++) {
			GroupID = [[prosGroup componentsSeparatedByString:@","] objectAtIndex:a];
			GroupID = [GroupID stringByReplacingOccurrencesOfString:@"," withString:@""];
			groupName = [self getGroupName:GroupID];
			if (![groupName isEqualToString:@""]) {
				NSDictionary *tempData = [[NSDictionary alloc] initWithObjectsAndKeys:GroupID, @"id", groupName, @"name", nil];
				[groupArr addObject:[tempData copy]];
			}
		}
	}
	
	[UDGroup setObject:groupArr forKey:@"groupArr"];
	
}


- (void)viewWillAppear:(BOOL)animated
{
    
    
	
	
	
    //GET THE OCCUPATION CODE
    
	BOOL result_getOccpCatCode = [self get_unemploy_initial];
    
	
    
	//GET THE COUNTRY DESC
    
	//	pp.ProspectGroup = [self getGroupName:pp.ProspectGroup];
	
	
	pp.OfficeAddressCountry =  [self getCountryDesc:pp.OfficeAddressCountry];
    
	pp.ResidenceAddressCountry  =  [self getCountryDesc:pp.ResidenceAddressCountry];
    
	txtOtherIDType.text = pp.OtherIDTypeNo;
    //CHANGE SEGMENTATION CONTROL FONT SIZE
    UIFont *font= [UIFont fontWithName:@"TreBuchet MS" size:16.0f];
    
    
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:UITextAttributeFont];
    [segSmoker setTitleTextAttributes:attributes
                             forState:UIControlStateNormal];
    [segRigPerson setTitleTextAttributes:attributes
								forState:UIControlStateNormal];
    
    [segGender setTitleTextAttributes:attributes
                             forState:UIControlStateNormal];
    
    
    pp.OtherIDType = [pp.OtherIDType uppercaseString];
    
    
    [btnHomeCountry setTitle:@"- SELECT -" forState:UIControlStateNormal];
    btnHomeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [outletTitle setTitle:@"- SELECT -" forState:UIControlStateNormal];
    outletTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
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
    
    [btnHomeCountry setTitle:@"- SELECT -" forState:UIControlStateNormal];
    btnHomeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [btnOfficeCountry setTitle:@"- SELECT -" forState:UIControlStateNormal];
    btnOfficeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	
	[BtnCountryOfBirth setTitle:@"- SELECT -" forState:UIControlStateNormal];
    BtnCountryOfBirth.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [OtherIDType setTitle:@"- SELECT -" forState:UIControlStateNormal];
    OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	
//	BtnCountryOfBirth.enabled = YES;
//	BtnCountryOfBirth.titleLabel.textColor = [UIColor blackColor];
	
    
    [outletOccup setTitle:@"- SELECT -" forState:UIControlStateNormal];
    outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	
    GSTRigExempted = @"";
	
	
	if ([pp.prospect_IsGrouping isEqualToString:@"Y"]) {
		SegIsGrouping.selectedSegmentIndex = 0;
		AddGroup.enabled = YES;
		AddGroup.alpha = 1.0;
//		ViewGroup.enabled = YES;
		isGrouping = @"Y";
		[self LoadGroupArr];
		
	}
	else if ([pp.prospect_IsGrouping isEqualToString:@"N"]) {
		SegIsGrouping.selectedSegmentIndex = 1;
		AddGroup.enabled = NO;
		AddGroup.alpha = 0.5;
//		ViewGroup.enabled = NO;
		isGrouping = @"N";
		//		[UDGroup setObject:nil forKey:@"groupArr"];
	}
	else {
		SegIsGrouping.selectedSegmentIndex = -1;
		AddGroup.enabled = NO;
		AddGroup.alpha = 0.5;
//		ViewGroup.enabled = NO;
		isGrouping = @"N";
		//		[UDGroup setObject:nil forKey:@"groupArr"];
	}
    
   
    txtExactDuties.delegate= self;
    if ([pp.registration isEqualToString:@"Y"]) {
        GSTRigperson = @"Y";
        segRigPerson.selectedSegmentIndex=0;
        txtRigNO.userInteractionEnabled=YES;
        btnregDate.userInteractionEnabled=YES;
        segRigExempted.enabled =TRUE;
        GSTRigExempted = @"";
        //outletRigDOB.hidden=NO;
        
    }
    else if([pp.registration isEqualToString:@"N"]){
        GSTRigperson = @"N";
        // outletRigDOB.hidden=YES;
        segRigPerson.selectedSegmentIndex=1;
        txtRigNO.enabled=FALSE;
        txtRigDate.enabled =FALSE;
        segRigExempted.enabled =TRUE;
        segRigExempted.selectedSegmentIndex = 1;
        txtRigNO.userInteractionEnabled=NO;
        btnregDate.userInteractionEnabled=NO;
        [outletRigDOB setTitle:@"- SELECT -" forState:UIControlStateNormal];
        outletRigDOB.enabled=FALSE;
        outletRigDOB.titleLabel.textColor = [UIColor grayColor];
    }

    else
        segRigPerson.selectedSegmentIndex = 1;
    
    strChanges = @"No";
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    
    txtRigDate.userInteractionEnabled=FALSE;
	
    txtRigNO.text = pp.registrationNo;
    //txtRigDate.text = pp.registrationDate;
  
   
    
    if (!(pp.registrationDate == NULL || [pp.registrationDate isEqualToString:@"- SELECT -"] || [pp.registrationDate isEqualToString:@""] )) {
		
        [outletRigDOB setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", pp.registrationDate]forState:UIControlStateNormal];
        outletRigDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    else {
        [outletRigDOB setTitle:@"- SELECT -" forState:UIControlStateNormal];
    }
	
    
    
    if ([pp.registrationExempted isEqualToString:@"Y"]) {
        GSTRigExempted = @"Y";
        segRigExempted.selectedSegmentIndex=0;
    }
    else if([pp.registrationExempted isEqualToString:@"N"]){
        GSTRigExempted = @"N";
        segRigExempted.selectedSegmentIndex=1;
    }
    else
        segRigExempted.selectedSegmentIndex = 1;
    
	
    if (!(pp.ProspectGroup == NULL || [pp.ProspectGroup isEqualToString:@"- SELECT -"] || [pp.ProspectGroup isEqualToString:@""] )) {
		
        [outletGroup setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", pp.ProspectGroup]forState:UIControlStateNormal];
        outletGroup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    else {
        [outletGroup setTitle:@"- SELECT -" forState:UIControlStateNormal];
    }
    
    pp.ProspectTitle = [pp.ProspectTitle stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceCharacterSet]];
    if (!(pp.ProspectTitle == NULL || [pp.ProspectTitle isEqualToString:@"(null)"] || [pp.ProspectTitle isEqualToString:@"- SELECT -"] || [pp.ProspectTitle isEqualToString:@""])) {
        [outletTitle setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", [self getTitleDesc:pp.ProspectTitle]]forState:UIControlStateNormal];
        outletTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		TitleCodeSelected = pp.ProspectTitle;
		//[self PopulateTitle
    }
    else {
        [outletTitle setTitle:@"- SELECT -" forState:UIControlStateNormal];
    }
    if (!(pp.Race == NULL || [pp.Race isEqualToString:@"- SELECT -"] || [pp.Race isEqualToString:@""])) {
        [outletRace setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", pp.Race]forState:UIControlStateNormal];
        outletRace.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    else {
        [outletRace setTitle:@"- SELECT -" forState:UIControlStateNormal];
    }
    
    if (!(pp.MaritalStatus == NULL || [pp.MaritalStatus isEqualToString:@"- SELECT -"] || [pp.MaritalStatus isEqualToString:@""])) {
        [outletMaritalStatus setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", pp.MaritalStatus]forState:UIControlStateNormal];
        outletMaritalStatus.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    else {
        [outletMaritalStatus setTitle:@"- SELECT -" forState:UIControlStateNormal];
    }
    
    if (!(pp.Religion == NULL || [pp.Religion isEqualToString:@"- SELECT -"] || [pp.Religion isEqualToString:@""])) {
        [outletReligion setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", pp.Religion]forState:UIControlStateNormal];
        outletReligion.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    else {
        [outletReligion setTitle:@"- SELECT -" forState:UIControlStateNormal];
    }
    if (!(pp.Nationality == NULL || [pp.Nationality isEqualToString:@"- SELECT -"] || [pp.Nationality isEqualToString:@""])) {
        [outletNationality setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", pp.Nationality]forState:UIControlStateNormal];
        outletNationality.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    else {
        [outletNationality setTitle:@"- SELECT -" forState:UIControlStateNormal];
    }
    
    
	
    if (!(pp.OtherIDType == NULL || [pp.OtherIDType isEqualToString:@"- SELECT -"] || [pp.OtherIDType isEqualToString:@""])) {
        
        [OtherIDType setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", [self getIDTypeDesc:pp.OtherIDType]]forState:UIControlStateNormal];
		
		if ([IDTypeCodeSelected isEqualToString:@""] || (IDTypeCodeSelected == NULL)) {
			IDTypeCodeSelected = pp.OtherIDType;
		}
        
        
        
        
        
        OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        //for company case
        if ([[pp.OtherIDType stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"CR"]) {
            companyCase = YES;
            
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
			
            txtAnnIncome.text = pp.AnnualIncome;
            
            txtAnnIncome.enabled = TRUE;
            txtAnnIncome.backgroundColor = [UIColor whiteColor];
			
            outletDOB.enabled = NO;
            outletDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [outletDOB setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
            outletDOB.titleLabel.textColor = [UIColor grayColor];
            
            
			
			
            
			
			
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
    
	
    
    if ([pp.IDTypeNo isEqualToString:@""] || pp.IDTypeNo == NULL) {
		
        pp.IDTypeNo = @"";
		
        
		if ([[pp.OtherIDType stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"COMPANYREGISTRATIONNUMBER"] || [pp.OtherIDType isEqualToString:@"CR"])
		{
			
			txtDOB.backgroundColor = [UIColor whiteColor];
			[outletDOB setTitle:@"- SELECT -" forState:UIControlStateNormal];
			outletDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
			
			segGender.enabled = NO;
			
			txtDOB.enabled = FALSE;
			outletOccup.enabled = NO;
			[outletOccup setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
			outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
			outletOccup.titleLabel.textColor = [UIColor grayColor];
		}
		else
		{
			segGender.enabled = YES;
			[outletDOB setTitle:[[NSString stringWithFormat:@" "]stringByAppendingFormat:@"%@",pp.ProspectDOB] forState:UIControlStateNormal];
			outletDOB.hidden = NO;
		}
        txtDOB.hidden = YES;
    }
    else {
        txtIDType.text = pp.IDTypeNo;
        txtIDType.enabled = NO;
        txtIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        
        txtDOB.text = pp.ProspectDOB;
        
        segGender.enabled = NO;
    }	
	
	NSString *COB = @"";
	if (![pp.countryOfBirth isEqualToString:@"(null)"] && pp.countryOfBirth != NULL && pp.countryOfBirth !=nil && ![pp.countryOfBirth isEqualToString: @""]) {
        COB = [self getCountryDesc:pp.countryOfBirth];
        pp.countryOfBirth =   [self getCountryDesc:pp.countryOfBirth];
		
		[BtnCountryOfBirth setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", pp.countryOfBirth]forState:UIControlStateNormal];
        BtnCountryOfBirth.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    else {
		[BtnCountryOfBirth setTitle:@"- SELECT -" forState:UIControlStateNormal];
    }

	
    
    //HOME ADD - Eliminate "null" value
    if ([pp.OtherIDTypeNo isEqualToString:@"(null)"] || pp.OtherIDTypeNo == NULL) {
        txtOtherIDType.text = @"";
    }
    else {
        txtOtherIDType.text = pp.OtherIDTypeNo;
		//[self selectedIDType:txtOtherIDType.text];
		
    }
	
    
    
    if (![pp.ResidenceAddress1 isEqualToString:@"(null)"] || pp.ResidenceAddress1 != NULL) {
        txtHomeAddr1.text = pp.ResidenceAddress1;
    }
    else {
        txtHomeAddr1.text = @"";
    }
    
	
    if (![pp.ResidenceAddress2 isEqualToString:@"(null)"] || pp.ResidenceAddress2 != NULL) {
        txtHomeAddr2.text = pp.ResidenceAddress2;
    }
    else {
        txtHomeAddr2.text = @"";
    }
    
    if (![pp.ResidenceAddress3 isEqualToString:@"(null)"] || pp.ResidenceAddress3 != NULL) {
        txtHomeAddr3.text = pp.ResidenceAddress3;
    }
    else {
        txtHomeAddr3.text = @"";
    }
    
    if (![pp.ResidenceAddressCountry isEqualToString:@"(null)"] || pp.ResidenceAddressCountry != NULL) {
        txtHomeCountry.text = pp.ResidenceAddressCountry;
    }
    else {
        txtHomeCountry.text = @"";
    }
    
    
    if (![pp.ResidenceAddressPostCode isEqualToString:@"(null)"] || pp.ResidenceAddressPostCode != NULL) {
        txtHomePostCode.text = pp.ResidenceAddressPostCode;
    }
    else {
        txtHomeCountry.text = @"";
    }
    
    if (![pp.ResidenceAddressTown isEqualToString:@"(null)"] || pp.ResidenceAddressTown != NULL) {
        txtHomeTown.text = pp.ResidenceAddressTown;
    }
    else {
        txtHomeTown.text = @"";
    }
    
	
    
    //Office Add  - Eliminate "null" value
	
    
    if (![pp.OfficeAddress1 isEqualToString:@"(null)"] || pp.OfficeAddress1 != NULL) {
        txtOfficeAddr1.text = pp.OfficeAddress1;
    }
    else {
        txtOfficeAddr1.text = @"";
    }
    
    if (![pp.OfficeAddress2 isEqualToString:@"(null)"] || pp.OfficeAddress2 != NULL ) {
        txtOfficeAddr2.text = pp.OfficeAddress2;
    }
    else {
        txtOfficeAddr2.text = @"";
    }
	
    
    if (![pp.OfficeAddress3 isEqualToString:@"(null)"] || pp.OfficeAddress3 != NULL) {
        txtOfficeAddr3.text = pp.OfficeAddress3;
    }
    else {
        txtOfficeAddr3.text = @"";
    }
	
    if (![pp.OfficeAddressPostCode isEqualToString:@"(null)"] || pp.OfficeAddressPostCode != NULL) {
        txtOfficePostCode.text = pp.OfficeAddressPostCode;
    }
    else {
        txtOfficePostCode.text = @"";
    }
	
    
    if (![pp.OfficeAddressCountry isEqualToString:@"(null)"] || pp.OfficeAddressCountry != NULL) {
        txtOfficeCountry.text = pp.OfficeAddressCountry;
    }
    else {
        txtOfficeCountry.text = @"";
    }
	
    
    if (![pp.OfficeAddressTown isEqualToString:@"(null)"] || pp.OfficeAddressTown != NULL) {
        txtOfficeTown.text = pp.OfficeAddressTown;
    }
    else {
        txtOfficeTown.text = @"";
    }
	
    if (![pp.ProspectRemark isEqualToString:@"(null)"] || pp.ProspectRemark != NULL) {
        txtRemark.text = pp.ProspectRemark;
    }
    else {
        txtRemark.text = @"";
    }
    
	
    if ([pp.ProspectEmail isEqualToString:@"(null)"] || pp.ProspectEmail == NULL) {
        
        txtEmail.text = @"";
	}
    else {
        
		txtEmail.text = pp.ProspectEmail;
		
		
    }
	
    if (![pp.ExactDuties isEqualToString:@"(null)"] || pp.ExactDuties != NULL) {
        txtExactDuties.text = pp.ExactDuties;
    }
    else {
        txtExactDuties.text = @"";
    }
	
    
    
    txtrFullName.text = pp.ProspectName;
	
	
    
    if (!([pp.ResidenceAddressCountry isEqualToString:@""]||pp.ResidenceAddressCountry == NULL) && ![pp.ResidenceAddressCountry isEqualToString:@"MALAYSIA"]) {
        
        checked = YES;
        txtHomeTown.backgroundColor = [UIColor whiteColor];
        txtHomeState.backgroundColor = [UIColor whiteColor];
        txtHomeTown.enabled = YES;
        txtHomeState.enabled = NO;
        txtHomeState.backgroundColor =  [CustomColor colorWithHexString:@"EEEEEE"];
        txtHomeCountry.hidden = YES;
        btnHomeCountry.hidden = NO;
        [btnForeignHome setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        
        btnHomeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btnHomeCountry setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",pp.ResidenceAddressCountry] forState:UIControlStateNormal];
    }
    else {
        
        btnHomeCountry.hidden = YES;
        txtHomeCountry.text = pp.ResidenceAddressCountry;
    }
    
    
    if (!([pp.OfficeAddressCountry isEqualToString:@""]||pp.OfficeAddressCountry == NULL) && ![pp.OfficeAddressCountry isEqualToString:@"MALAYSIA"]) {
        
        checked2 = YES;
        txtOfficeTown.backgroundColor = [UIColor whiteColor];
        txtOfficeState.backgroundColor = [UIColor whiteColor];
        txtOfficeTown.enabled = YES;
        txtOfficeState.enabled = NO;
        txtOfficeState.backgroundColor =  [CustomColor colorWithHexString:@"EEEEEE"];
        txtOfficeCountry.hidden = YES;
        btnOfficeCountry.hidden = NO;
        [btnForeignOffice setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        
        btnOfficeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btnOfficeCountry setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",pp.OfficeAddressCountry] forState:UIControlStateNormal];
    }
    else {
        
        btnOfficeCountry.hidden = YES;
        txtOfficeCountry.text = pp.OfficeAddressCountry;
    }
    
    
    if (![pp.AnnualIncome isEqualToString:@"(null)"]) {
        txtAnnIncome.text = pp.AnnualIncome;
    }
    else {
        txtAnnIncome.text = @"";
    }
    
    if (![pp.BussinessType isEqualToString:@"(null)"]) {
        txtBussinessType.text = pp.BussinessType;
    }
    else {
        txtBussinessType.text = @"";
    }
    
    if ([pp.Smoker isEqualToString:@"Y"]) {
        ClientSmoker = @"Y";
        segSmoker.selectedSegmentIndex = 0;
    }
    else if([pp.Smoker isEqualToString:@"N"]){
        ClientSmoker = @"N";
        segSmoker.selectedSegmentIndex = 1;
    }
    else
		segSmoker.selectedSegmentIndex = UISegmentedControlNoSegment;
	
	
    
    if ([pp.ProspectGender isEqualToString:@"MALE"]) {
        gender = @"MALE";
        segGender.selectedSegmentIndex = 0;
    }
    else if ([pp.ProspectGender isEqualToString:@"FEMALE"]) {
        gender = @"FEMALE";
        segGender.selectedSegmentIndex = 1;
    }
    else
        segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
    
	
    
    if ([[pp.OtherIDType stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"COMPANYREGISTRATIONNUMBER"] || [pp.OtherIDType isEqualToString:@"CR"]) {
        
        
		
        companyCase = YES;
		
        
		
		/*
		 txtDOB.text = @"- SELECT -";
		 txtDOB.backgroundColor = [UIColor whiteColor];
		 txtDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
		 txtDOB.textColor = [UIColor grayColor];
		 */
        
		
        
		
        
		// [outletOccup setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
        
		
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
        outletOccup.enabled = NO;
        outletOccup.titleLabel.textColor = [UIColor grayColor];
        
        outletTitle.enabled = NO;
        outletTitle.titleLabel.textColor =  [UIColor grayColor];
        
        //annual income
        txtAnnIncome.enabled = TRUE;
        txtAnnIncome.backgroundColor = [UIColor whiteColor];
        txtAnnIncome.text = pp.AnnualIncome;
        
        
        //IC
        txtIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtIDType.enabled = NO;
		
        
        
        
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
                [self PopulateTitle];
				
				BtnCountryOfBirth.enabled = NO;
                BtnCountryOfBirth.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                [BtnCountryOfBirth setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
                BtnCountryOfBirth.titleLabel.textColor = [UIColor grayColor];
                
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
				//                outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
				//                [outletOccup setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
				//                outletOccup.titleLabel.textColor = [UIColor grayColor];
				
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
				
                
				
                txtEmail.enabled = false;
                
                
                
                txtAnnIncome.text = @"";
                txtAnnIncome.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
                txtAnnIncome.enabled =false;
                
                outletTitle.enabled = NO;
                outletTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                
                [outletTitle setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
                outletTitle.titleLabel.textColor = [UIColor grayColor];
                
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
                txtDOB.backgroundColor = [UIColor whiteColor];
                
                
                
				
				OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
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
                
                txtOfficePostCode.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
                txtOfficePostCode.enabled = NO;
                
                txtRigNO.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
                txtRigNO.enabled = NO;
                txtRigNO.text =@"";
                
                txtRigDate.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
                outletRigDOB.enabled = NO;
                outletRigDOB.titleLabel.textColor = [UIColor grayColor];
                txtRigDate.text =@"";
                
                
                segRigPerson.selectedSegmentIndex=1;
                segRigPerson.enabled =NO;
                
                segRigExempted.selectedSegmentIndex =0;
                segRigExempted.enabled =NO;
				
            }
            
            
            
            if([OccpCatCode isEqualToString:@"HSEWIFE"]
               ||[OccpCatCode isEqualToString:@"JUV"]
               ||[OccpCatCode isEqualToString:@"STU"])
            {
                
				
                
                
                ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
                
                
                
                if (![[pp.OtherIDType stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"COMPANYREGISTRATIONNUMBER"] && ![pp.OtherIDType isEqualToString:@"CR"])
                {
                    txtAnnIncome.text = @"";
                    txtAnnIncome.enabled = NO;
                    txtAnnIncome.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
                }
				
                
            }
            else if([OccpCatCode isEqualToString:@"RET"] ||[OccpCatCode isEqualToString:@"UNEMP"])
            {
				// NSLog(@"ky ANNUAL INCOME");
                
                txtAnnIncome.enabled = YES;
                txtAnnIncome.backgroundColor = [UIColor whiteColor];
            }
            else{
                txtAnnIncome.enabled = YES;
                txtAnnIncome.backgroundColor = [UIColor whiteColor];
				
            }
            
            
            txtHomeState.text = @"";
            if (![[txtHomePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"" ] && [txtHomeCountry.text isEqualToString:@"MALAYSIA"]) {
                
                [self PopulateState];
                [txtHomePostCode addTarget:self action:@selector(EditTextFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                [txtHomePostCode addTarget:self action:@selector(EditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
            }
            else if (![[txtHomePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"" ] && ![txtHomeCountry.text isEqualToString:@"MALAYSIA"]) {
                
                txtHomeState.text = pp.ResidenceAddressState;
            }
            else{
                
                txtHomeState.text = @"";
                [txtHomePostCode addTarget:self action:@selector(EditTextFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                [txtHomePostCode addTarget:self action:@selector(EditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
            }
            
            
            if (![[txtOfficePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"" ] && [txtOfficeCountry.text isEqualToString:@"MALAYSIA"]) {
                
                [self PopulateOfficeState];
                [txtOfficePostCode addTarget:self action:@selector(EditOfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                [txtOfficePostCode addTarget:self action:@selector(OfficeEditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
            }
            else if (![[txtOfficePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"" ] && ![txtOfficeCountry.text isEqualToString:@"MALAYSIA"]) {
                
                txtOfficeState.text = pp.OfficeAddressState;
            }
            else{
                
                txtOfficeState.text = @"";
                [txtOfficePostCode addTarget:self action:@selector(EditOfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                [txtOfficePostCode addTarget:self action:@selector(OfficeEditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
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
	
	
    txtIDType.enabled = FALSE;
    txtIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
	if (![OtherIDType.titleLabel.text isEqualToString:@"- SELECT -"]) {
		txtOtherIDType.enabled = NO;
		txtOtherIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
		
		OtherIDType.enabled = NO;
		OtherIDType.titleLabel.textColor = [UIColor grayColor];
	}
	
    
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
        
        txtOfficePostCode.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
        txtOfficePostCode.enabled = NO;
		
        
        
        txtExactDuties.editable = NO;
        txtExactDuties.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        
        [btnForeignHome setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        [btnForeignOffice setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        
        btnForeignHome.enabled = false;
        btnForeignOffice.enabled = false;
        btnHomeCountry.enabled = false;
        btnOfficeCountry.enabled = false;
		
    }
    
    
    
    //KY - IF COMPANY , DISABLE DOB
    if ([[pp.OtherIDType stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"COMPANYREGISTRATIONNUMBER"] || [pp.OtherIDType isEqualToString:@"CR"])
    {
        //IMPORTANT ! - outletDOB AND txtDOB were overlap together, so when need to display the outletDOB button, u need to hide the txtDOB.
		
        txtDOB.hidden = YES;
        outletDOB.hidden = NO;
        
        outletDOB.enabled = NO;
        outletDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [outletDOB setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
        outletDOB.titleLabel.textColor = [UIColor grayColor];
		
		BtnCountryOfBirth.enabled = NO;
		BtnCountryOfBirth.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
		[BtnCountryOfBirth setTitle: [NSString stringWithFormat:@"- SELECT -"] forState:UIControlStateNormal];
		BtnCountryOfBirth.titleLabel.textColor = [UIColor grayColor];
		
    }
    else if([pp.ProspectDOB isEqualToString:@"- SELECT -"])
    {
        
		
        
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
	
	//fixed for dob missing value if IC exist:
	if (txtIDType.text.length == 12 && [[textFields trimWhiteSpaces:outletDOB.titleLabel.text] isEqualToString:@"- Select -"]) {
		[self GenerateDOB];
	}
	
    
	
    [self check_OID_BirthCer_Passport];
    
    [super viewWillAppear:animated];
	//    [self SaveToUserDefault];
    
    
}



-(void)NewICTextFieldBegin:(id)sender {
    
    outletDOB.hidden = YES;
    txtDOB.hidden = NO;
    segGender.enabled = NO;
	//  self.navigationItem.rightBarButtonItem.enabled = false;
}

-(void)NewICDidChange:(id) sender
{
    BOOL valid =  [self IDValidation];
    
	// self.navigationItem.rightBarButtonItem.enabled = TRUE;
    txtIDType.text = [txtIDType.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
	if(txtIDType.text.length == 16 && valid == true)
    {
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtIDType.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
        valid = [alphaNums isSupersetOfSet:inStringSet];
        if (!valid) {
            
            
            rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No must be in numeric" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            rrr.tag = 1002;
            [rrr show];
        }
        else {
            
			
			
            NSString *last = [txtIDType.text substringFromIndex:[txtIDType.text length] -1];
            NSCharacterSet *oddSet = [NSCharacterSet characterSetWithCharactersInString:@"13579"];
            //CANT CHANGE THE GENDER VIA IC IN EDIT
			/*
			 if ([last rangeOfCharacterFromSet:oddSet].location != NSNotFound) {
			 
			 segGender.selectedSegmentIndex = 0;
			 gender = @"MALE";
			 } else {
			 NSLog(@"FEMALE");
			 segGender.selectedSegmentIndex = 1;
			 gender = @"FEMALE";
			 }
			 
			 
			 
			 */
            //get the DOB value from ic entered
			
            NSString *strDate = [txtIDType.text substringWithRange:NSMakeRange(6, 2)];
			NSString *strMonth = [txtIDType.text substringWithRange:NSMakeRange(8, 2)];
			NSString *strYear = [txtIDType.text substringWithRange:NSMakeRange(10, 2)];
			NSString *strGender;
			
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
                
            }
            else if ([strMonth intValue] > 12 || [strMonth intValue] < 1) {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK month must be between 1 and 12." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                rrr.tag = 1002;
                [rrr show];
                
            }
            else if([strDate intValue] < 1 || [strDate intValue] > 31)
            {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK day must be between 1 and 31 or 41 and 71." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                rrr.tag = 1002;
                [rrr show];
                
                
                
            }
            else if (([strMonth isEqualToString:@"01"] || [strMonth isEqualToString:@"03"] || [strMonth isEqualToString:@"05"] || [strMonth isEqualToString:@"07"] || [strMonth isEqualToString:@"08"] || [strMonth isEqualToString:@"10"] || [strMonth isEqualToString:@"12"]) && [strDate intValue] > 31) {
                
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                rrr.tag = 1002;
                [rrr show];
                
				
				
            }
            
            else if (([strMonth isEqualToString:@"04"] || [strMonth isEqualToString:@"06"] || [strMonth isEqualToString:@"09"] || [strMonth isEqualToString:@"11"]) && [strDate intValue] > 30) {
                
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                rrr.tag = 1002;
                [rrr show];
                
            }
            else if (([febStatus isEqualToString:@"Normal"] && [strDate intValue] > 28 && [strMonth isEqualToString:@"02"]) || ([febStatus isEqualToString:@"Jump"] && [strDate intValue] > 29 && [strMonth isEqualToString:@"02"])) {
                
                
                NSString *msg = [NSString stringWithFormat:@"February of %@ doesn’t have 29 days",strYear] ;
                
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                
                [rrr show];
                
            }
			
            last = nil, oddSet = nil;
            strDate = nil, strMonth = nil, strYear = nil, currentYear = nil, strCurrentYear = nil;
            dateFormatter = Nil, strDOB = nil, strDOB2 = nil, d = Nil, d2 = Nil;
        }
        
        alphaNums = nil, inStringSet = nil;
    }
	else if (txtIDType.text.length > 0 && txtIDType.text.length < 16 && valid==true) {
		rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No must be 16 digits characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		rrr.tag = 1002;
		[rrr show];
		rrr = nil;
		
	}
    
	//  [txtIDType removeTarget:self action:@selector(NewICDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.navigationItem.rightBarButtonItem.enabled = TRUE;
    
    
    
    
    
}
-(void) checkIC_OID_BirthCert_Passport
{
    if (txtIDType.text.length != 12) {
        rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid New IC No length. IC No length should be 12 characters long" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        rrr.tag = 1002;
        [rrr show];
        txtIDType.text = @"";
        txtDOB.text = @"";
        segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        
        return;
    }
    
    BOOL valid;
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtIDType.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    valid = [alphaNums isSupersetOfSet:inStringSet];
    if (!valid) {
        
        rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No must be in numeric" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        rrr.tag = 1002;
        [rrr show];
        txtIDType.text = @"";
        txtDOB.text = @"";
        segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
    }
    else {
        
        NSString *last = [txtIDType.text substringFromIndex:[txtIDType.text length] -1];
        NSCharacterSet *oddSet = [NSCharacterSet characterSetWithCharactersInString:@"13579"];
        
        if ([last rangeOfCharacterFromSet:oddSet].location != NSNotFound) {
            
			//   segGender.selectedSegmentIndex = 0;
            gender = @"MALE";
        } else {
            
			//  segGender.selectedSegmentIndex = 1;
            gender = @"FEMALE";
        }
        
        //get the DOB value from ic entered
        NSString *strDate = [txtIDType.text substringWithRange:NSMakeRange(4, 2)];
        NSString *strMonth = [txtIDType.text substringWithRange:NSMakeRange(2, 2)];
        NSString *strYear = [txtIDType.text substringWithRange:NSMakeRange(0, 2)];
        
        
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
            rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            rrr.tag = 1002;
            [rrr show];
            
            txtIDType.text = @"";
            txtDOB.text = @"";
            segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        }
        else if ([strMonth intValue] > 12 || [strMonth intValue] < 1 || [strDate intValue] < 1 || [strDate intValue] > 31) {
            
            rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            rrr.tag = 1002;
            [rrr show];
            
            txtIDType.text = @"";
            txtDOB.text = @"";
            segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        }
        else if (([strMonth isEqualToString:@"01"] || [strMonth isEqualToString:@"03"] || [strMonth isEqualToString:@"05"] || [strMonth isEqualToString:@"07"] || [strMonth isEqualToString:@"08"] || [strMonth isEqualToString:@"10"] || [strMonth isEqualToString:@"12"]) && [strDate intValue] > 31) {
            
            rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            rrr.tag = 1002;
            [rrr show];
            
            txtIDType.text = @"";
            txtDOB.text = @"";
            segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        }
        
        else if (([strMonth isEqualToString:@"04"] || [strMonth isEqualToString:@"06"] || [strMonth isEqualToString:@"09"] || [strMonth isEqualToString:@"11"]) && [strDate intValue] > 30) {
            
            rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            rrr.tag = 1002;
            [rrr show];
            
            txtIDType.text = @"";
            txtDOB.text = @"";
            segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        }
        else if (([febStatus isEqualToString:@"Normal"] && [strDate intValue] > 28 && [strMonth isEqualToString:@"02"]) || ([febStatus isEqualToString:@"Jump"] && [strDate intValue] > 29 && [strMonth isEqualToString:@"02"])) {
            
            rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            rrr.tag = 1002;
            [rrr show];
            
            txtIDType.text = @"";
            txtDOB.text = @"";
            segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        }
        else {
            //ky
            NSArray  *temp_dob = [txtDOB.text componentsSeparatedByString:@"/"];
            
			
            
            NSString *day = [temp_dob objectAtIndex:0];
            day = [day stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
			NSString *month = [temp_dob objectAtIndex:1];
            NSString *year = [temp_dob objectAtIndex:2];
            
            
            if(![day isEqualToString:strDate] || ![month isEqualToString:strMonth] || ![year isEqualToString:strYear])
            {
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No does not match with Date of Birth." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                rrr.tag = 1002;
                [rrr show];
                rrr = nil;
				
            }
            else if(([gender isEqualToString:@"MALE"] && segGender.selectedSegmentIndex !=0) || ([gender isEqualToString:@"FEMALE"] && segGender.selectedSegmentIndex !=1))
            {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No does not match with Gender." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                rrr.tag = 1002;
                [rrr show];
				rrr = nil;
            }
        }
        
        last = nil, oddSet = nil;
        strDate = nil, strMonth = nil, strYear = nil, currentYear = nil, strCurrentYear = nil;
        dateFormatter = Nil, strDOB = nil, strDOB2 = nil, d = Nil, d2 = Nil;
    }
    
}


-(void)OtheriDDidChange:(id) sender
{
    [self OtherIDValidation];
}

-(void)EditTextFieldBegin:(id)sender{
    
	//  self.navigationItem.rightBarButtonItem.enabled = FALSE;
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
}



-(void)OfficeEditTextFieldBegin:(id)sender{
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
	[ClientProfile setObject:@"YES" forKey:@"HasChanged"];
}

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
    else if ([txtRigNO isFirstResponder]) {
        [myScrollView setContentOffset:CGPointMake(0,430) animated:YES];
    }
    else if([txtOfficePostCode isFirstResponder])
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
    else if([txtExactDuties isFirstResponder])
    {
        [myScrollView setContentOffset:CGPointMake(0,500) animated:YES];
    }
}

-(void)keyboardDidHide:(NSNotificationCenter *)notification
{
    self.myScrollView.frame = CGRectMake(0, -44, 1024, 748);
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    NSUInteger newLength = [textView.text length] + [text length] - range.length;
    
    if (textView == txtExactDuties) {
        
		
        return ((newLength <= CHARACTER_LIMIT_ExactDuties));
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    //IN EDIT CLIENT PROFILE ALSO
    
    
    //  name_morethan3times = FALSE;
    NSString *myString = nil;
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    if((checked && textField == txtHomePostCode ) || (checked2 && textField == txtOfficePostCode))
    {
        return ((newLength <= CHARACTER_LIMIT_FOREIGN_POSTCODE));
    }
    else if (textField == txtOfficePostCode || textField == txtHomePostCode)
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
        
		//   [txtIDType addTarget:self action:@selector(NewICDidChange:) forControlEvents:UIControlEventEditingDidEnd];
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_PC_F));
    }
    
    
    
    
    
    
    
    if (textField == txtAnnIncome) {
        
        
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
				/*  rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"Annual income must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
    
    
    if (textField == txtrFullName) {
        
        return ((newLength <= CHARACTER_LIMIT_FULLNAME));
    }
	
    if (textField == txtRigNO) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_GSTREGNO));
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
    if (textField == txtOfficePostCode || textField == txtHomePostCode)
    {
        
        return ((newLength <= CHARACTER_LIMIT_POSTCODE));
    }
    
    return YES;
}

- (IBAction)ActionRigPerson:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
	edited = YES;
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if ([segRigPerson selectedSegmentIndex]==0) {
        GSTRigperson = @"Y";
        txtRigNO.enabled=TRUE;
        txtRigDate.enabled =TRUE;
        segRigExempted.enabled =TRUE;
     //   segRigExempted.selectedSegmentIndex = 1;
        txtRigNO.userInteractionEnabled=YES;
        btnregDate.userInteractionEnabled=YES;
        //outletRigDOB.hidden=NO;
        GSTRigExempted = @"";
        [outletRigDOB setTitle:@"- SELECT -" forState:UIControlStateNormal];
        outletRigDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        outletRigDOB.enabled=TRUE;
    }
    else if ([segRigPerson selectedSegmentIndex]==1){
        GSTRigperson = @"N";
        //outletRigDOB.hidden=YES;
        txtRigNO.enabled=FALSE;
        txtRigDate.enabled =FALSE;
        segRigExempted.enabled =TRUE;
    //    segRigExempted.selectedSegmentIndex = 1;
        txtRigNO.userInteractionEnabled=NO;
        btnregDate.userInteractionEnabled=NO;
        txtRigDate.text=@"";
        [outletRigDOB setTitle:@"- SELECT -" forState:UIControlStateNormal];
         outletRigDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        outletRigDOB.enabled=FALSE;
        txtRigNO.text=@"";
         outletRigDOB.titleLabel.textColor = [UIColor grayColor];
    }
}

//- (IBAction)ActionforRegDate:(id)sender {
- (IBAction)ActionRigDate:(id)sender {   

    ToDissAlertforRegDate = NO;
    
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
    [self.SIDatePopover presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    
    
    dateFormatter = Nil;
    dateString = Nil, mainStoryboard = nil;
}

- (IBAction)ActionExempted:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
	edited = YES;
    
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



#pragma mark - action


- (IBAction)ActionHomeCountry:(id)sender
{
    isHomeCountry = YES;
    isOffCountry = NO;

	
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    //if (_CountryList == nil) {
	self.CountryList = [[Country alloc] initWithStyle:UITableViewStylePlain];
	_CountryList.delegate = self;
	self.CountryListPopover = [[UIPopoverController alloc] initWithContentViewController:_CountryList];
    //}
    
    
    [self.CountryListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	
}

- (IBAction)actionMaritalStatus:(id)sender
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


- (IBAction)actionGrouping:(id)sender {
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
	edited = YES;
	
	if (SegIsGrouping.selectedSegmentIndex == 1) {
		AddGroup.enabled = false;
//		ViewGroup.enabled = false;
		AddGroup.alpha = 0.5;
		isGrouping = @"N";
		[self LoadGroupArr];
		
		[self DeleteGroup2];
		
	}
	else {
		AddGroup.enabled = true;
//		ViewGroup.enabled = true;
		AddGroup.alpha = 1.0;
		isGrouping = @"Y";
		[self LoadGroupArr];
	}
	
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
	EditProspect *groupPage = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ClientGroup"];
	
	[UDGroup setObject:pp.ProspectGroup forKey:@"Group"];
	[UDGroup setObject:pp.ProspectID forKey:@"ProspectID"];
	[UDGroup setObject:pp.ProspectName forKey:@"ProspectName"];
	[UDGroup setObject:@"Edit" forKey:@"Mode"];
	
	[self presentModalViewController:groupPage animated:YES];
}

- (IBAction)ViewGroup:(id)sender{
	
	UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MengCheong_Storyboard_eApp" bundle:nil];
	EditProspect *groupPage = [secondStoryBoard instantiateViewControllerWithIdentifier:@"GroupViewVC"];
	
	[UDGroup setObject:pp.ProspectGroup forKey:@"Group"];
	[UDGroup setObject:pp.ProspectID forKey:@"ProspectID"];
	[UDGroup setObject:pp.ProspectName forKey:@"ProspectName"];
	[UDGroup setObject:@"Edit" forKey:@"Mode"];
	
	[self presentModalViewController:groupPage animated:YES];
	
}

- (void)disableGroup {
	
	ProsGroupArr = [UDGroup objectForKey:@"groupArr"];
	
	if (ProsGroupArr.count == 0) {
		SegIsGrouping.selectedSegmentIndex = 1;
		AddGroup.enabled = false;
		AddGroup.alpha = 0.5;
		isGrouping = @"N";
	}
}

- (IBAction)actionNationality:(id)sender
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
    
    //CGRect butt = [sender frame];
    //int y = butt.origin.y - 44;
    //butt.origin.y = y;
    [self.nationalityPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


- (IBAction)actionRace:(id)sender
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
    
    
    [self.raceListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


- (IBAction)actionReligion:(id)sender
{
    
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if (_ReligionList == nil) {
        self.ReligionList = [[Religion alloc] initWithStyle:UITableViewStylePlain];
        _ReligionList.delegate = self;
        self.ReligionListPopover = [[UIPopoverController alloc] initWithContentViewController:_ReligionList];
    }
    
	[self.ReligionListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
	//  [self.ReligionListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}




- (IBAction)ActionOfficeCountry:(id)sender
{
    isOffCountry = YES;
    isHomeCountry = NO;
	
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
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


- (IBAction)actionCountryOfBirth:(id)sender
{
	
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];

	self.Country2List = [[Country2 alloc] initWithStyle:UITableViewStylePlain];
	_Country2List.delegate = self;
	self.Country2ListPopover = [[UIPopoverController alloc] initWithContentViewController:_Country2List];
    
    
    [self.Country2ListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)isForeign:(id)sender
{
	
    UIButton *btnPressed = (UIButton*)sender;
    ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
    
    if (btnPressed.tag == 0) {
        
        if (checked) {
            [btnForeignHome setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
            checked = NO;
            
            txtHomeAddr1.text = @"";
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
            
            [txtHomePostCode addTarget:self action:@selector(EditTextFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
            [txtHomePostCode addTarget:self action:@selector(EditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
        }
        else {
			
            [btnForeignHome setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            checked = YES;
            
            self.navigationItem.rightBarButtonItem.enabled = TRUE; //ENABLE DONE BUTTON
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
			
            
            [txtHomePostCode removeTarget:self action:@selector(EditTextFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
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
            
            txtOfficePostCode.text = @"";
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
            
            [txtOfficePostCode addTarget:self action:@selector(EditOfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
            [txtOfficePostCode addTarget:self action:@selector(OfficeEditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
        }
        else {
            
			
            [btnForeignOffice setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            checked2 = YES;
            
            self.navigationItem.rightBarButtonItem.enabled = TRUE;
            txtOfficeAddr1.text = @"";
            txtOfficeAddr2.text = @"";
            txtOfficeAddr3.text = @"";
            
            
            txtOfficePostCode.text = @"";
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
            
            [txtOfficePostCode removeTarget:self action:@selector(EditOfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
            [txtOfficePostCode removeTarget:self action:@selector(OfficeEditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
        }
    }
    
    
	//###
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
	
	[ClientProfile setObject:@"YES" forKey:@"HasChanged"];
	NSString *ResidenceForeignAddressFlag = @"";
	NSString *OfficeForeignAddressFlag = @"";
	
	if (checked) {
		ResidenceForeignAddressFlag = @"Y";
	}
	else {
		ResidenceForeignAddressFlag = @"N";
	}
	
	if (checked2) {
		OfficeForeignAddressFlag = @"Y";
	}
	else {
		OfficeForeignAddressFlag = @"N";
	}
	
	[ClientProfile setObject:ResidenceForeignAddressFlag forKey:@"ResidenceForeignAddressFlag"];
	[ClientProfile setObject:OfficeForeignAddressFlag forKey:@"OfficeForeignAddressFlag"];
	//###
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
    
    CGRect butt = [sender frame];
    int y = butt.origin.y - 44;
    butt.origin.y = y;
    [self.GroupPopover presentPopoverFromRect:butt inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}

- (IBAction)btnTitle:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if (_TitlePicker == nil) {
        self.TitlePicker = [[TitleViewController alloc] initWithStyle:UITableViewStylePlain];
        _TitlePicker.delegate = self;
        self.TitlePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_TitlePicker];
    }
    
    CGRect butt = [sender frame];
    int y = butt.origin.y - 44;
    butt.origin.y = y;
    [self.TitlePickerPopover presentPopoverFromRect:butt inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}

- (IBAction)btnDOB:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    
    if (_SIDate == Nil) {
        
        self.SIDate = [self.storyboard instantiateViewControllerWithIdentifier:@"SIDate"];
        _SIDate.delegate = self;
        _SIDate.ProspectDOB = pp.ProspectDOB;
        self.SIDatePopover = [[UIPopoverController alloc] initWithContentViewController:_SIDate];
    }
    
    [self.SIDatePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    CGRect butt = [sender frame];
    int y = butt.origin.y - 44;
    butt.origin.y = y;
    [self.SIDatePopover presentPopoverFromRect:butt  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
}

- (IBAction)btnOccup:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
	
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if (_OccupationList == nil) {
        self.OccupationList = [[OccupationList alloc] initWithStyle:UITableViewStylePlain];
        _OccupationList.delegate = self;
        self.OccupationListPopover = [[UIPopoverController alloc] initWithContentViewController:_OccupationList];
    }
    
    CGRect butt = [sender frame];
    int y = butt.origin.y - 44;
    butt.origin.y = y;
    [self.OccupationListPopover presentPopoverFromRect:butt  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
    
    
}

- (IBAction)ActionGender:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if ([segGender selectedSegmentIndex]==0) {
        gender = @"MALE";
    }
    else if([segGender selectedSegmentIndex]==1){
        gender = @"FEMALE";
    }
	
	
}

- (IBAction)ActionSmoker:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if ([segSmoker selectedSegmentIndex]==0) {
        ClientSmoker = @"Y";
    }
    else {
        ClientSmoker = @"N";
    }
	edited = YES;
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
	
	[ClientProfile setObject:ClientSmoker forKey:@"ClientSmoker"];
	[ClientProfile setObject:@"YES" forKey:@"HasChanged"];
	
}

- (IBAction)btnDelete:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: NSLocalizedString(@" ",nil)
                          message: NSLocalizedString(@"Are you sure you want to delete this prospect profile?",nil)
                          delegate: self
                          cancelButtonTitle: NSLocalizedString(@"Yes",nil)
                          otherButtonTitles: NSLocalizedString(@"No",nil), nil];
    alert.tag = 1;
    [alert show];
}

- (void)btnSave:(id)sender
{
    
    clickDone = 1;
    [self.view endEditing:YES];
    [self resignFirstResponder];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    // self.myScrollView.frame = CGRectMake(0, 20, 1024, 748);
    
    _OccupationList = Nil;
    _SIDate = Nil;
    
    if ([strChanges isEqualToString:@"Yes"]) {
        [self SaveChanges];
    }
    else {
        [self SaveChanges];
    }
    
    IsContinue = TRUE;
}

- (void)btnCancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)btnSave2:(id)sender
{
    
    [self.view endEditing:YES];
    [self resignFirstResponder];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
	// self.myScrollView.frame = CGRectMake(0, 20, 1024, 748);
    
    _OccupationList = Nil;
    _SIDate = Nil;
    
    if ([strChanges isEqualToString:@"Yes"]) {
        [self SaveChanges2];
    }
    else {
        [self SaveChanges2];
    }
    
	IsContinue = TRUE;
}

-(void)EditOfficePostcodeDidChange:(id) sender
{
    
    BOOL gotRow = false;
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    txtOfficePostCode.text = [txtOfficePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //CHECK INVALID SYMBOLS
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
    
    
    BOOL valid;
    BOOL valid_symbol;
    
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtOfficePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    valid = [alphaNums isSupersetOfSet:inStringSet];
    valid_symbol = [set isSupersetOfSet:inStringSet];
    OfficePostcodeContinue = TRUE;
    
    //NSLog(@"valid_symbol - %i", valid_symbol);
    if(txtOfficePostCode.text.length < 5)
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
        OfficePostcodeContinue = FALSE;
        
    }
    else {
        
		if(!checked2)  {
			if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
				NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", txtOfficePostCode.text];
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
						OfficePostcodeContinue = TRUE;
						self.navigationItem.rightBarButtonItem.enabled = TRUE;
						
						NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
						
						[ClientProfile setObject:txtOfficePostCode.text forKey:@"txtOfficePostCode"];
						[ClientProfile setObject:OfficeTown forKey:@"txtOfficeTown"];
						[ClientProfile setObject:@"MAL" forKey:@"OffCountry"];
						[ClientProfile setObject:Statecode forKey:@"SelectedOfficeStateCode"];
						
					}
					sqlite3_finalize(statement);
					
					
					sqlite3_close(contactDB);
				}
				else {
					
					txtOfficeState.text = @"";
					txtOfficeTown.text = @"";
					txtOfficeCountry.text = @"";
				}
			}
		}
		
	}
}

-(void)EditTextFieldDidChange:(id) sender
{
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	
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
	
    
    else if (!valid_symbol) {
		/*
		 rrr = [[UIAlertView alloc] initWithTitle:@" "
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
		
        /*
		 rrr = [[UIAlertView alloc] initWithTitle:@" "
		 message:@"Home post code must be in numeric." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		 
		 rrr.tag = 2001;
		 [rrr show];
		 */
        
        
        txtHomeState.text = @"";
        txtHomeTown.text = @"";
        txtHomeCountry.text = @"";
        SelectedStateCode = @"";
        HomePostcodeContinue = FALSE;
        
    }
    else {
        
		if(!checked)
        {
            
			
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
						
						//   PostcodeContinue = TRUE;
						self.navigationItem.rightBarButtonItem.enabled = TRUE;
						
						[ClientProfile setObject:txtHomePostCode.text forKey:@"txtHomePostCode"];
						[ClientProfile setObject:Town forKey:@"txtHomeTown"];
						[ClientProfile setObject:@"MAL" forKey:@"HomeCountry"];
						[ClientProfile setObject:Statecode forKey:@"SelectedStateCode"];
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
}

- (IBAction)btnOtherIDType:(id)sender
{
	
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if (_IDTypePicker == nil) {
        
        self.IDTypePicker = [[IDTypeViewController alloc] initWithStyle:UITableViewStylePlain];
        _IDTypePicker.delegate = self;
        _IDTypePicker.requestType = @"COEdit";
        self.IDTypePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_IDTypePicker];
    }
    
    
    [self.IDTypePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
	
}

-(void)detectChanges:(id) sender
{
    strChanges = @"Yes";
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
	//	[ClientProfile setObject:txtHomeAddr1.text forKey:@"txtHomeAddr1"];
	//	NSLog(@"value2: %@", [ClientProfile stringForKey:@"txtHomeAddr1"]);
	//
	//[self SaveToUserDefault];
	
	
	[ClientProfile setObject:TitleCodeSelected forKey:@"TitleCodeSelected"];
	[ClientProfile setObject:txtrFullName.text forKey:@"txtrFullName"];
	[ClientProfile setObject:txtIDType.text forKey:@"IC"];
	
	//[ClientProfile setObject:IDTypeCodeSelected forKey:@"IDTypeCodeSelected"];
	
	
	[ClientProfile setObject:txtOtherIDType.text forKey:@"txtOtherIDType"];
	
	[ClientProfile setObject:gender forKey:@"gender"]; //check later
	
	//[ClientProfile setObject:ClientSmoker forKey:@"ClientSmoker"];
	
	//[ClientProfile setObject:pp.ProspectOccupationCode forKey:@"OccupCodeSelected"]; // check later
	[ClientProfile setObject:txtExactDuties.text forKey:@"txtExactDuties"];
	[ClientProfile setObject:txtAnnIncome.text forKey:@"txtAnnIncome"];
	[ClientProfile setObject:txtBussinessType.text forKey:@"txtBussinessType"];
	
	[ClientProfile setObject:txtHomeAddr1.text forKey:@"txtHomeAddr1"];
	[ClientProfile setObject:txtHomeAddr2.text forKey:@"txtHomeAddr2"];
	[ClientProfile setObject:txtHomeAddr3.text forKey:@"txtHomeAddr3"];
	[ClientProfile setObject:txtHomePostCode.text forKey:@"txtHomePostCode"];
	[ClientProfile setObject:txtHomeTown.text forKey:@"txtHomeTown"];
	//[ClientProfile setObject:SelectedStateCode forKey:@"SelectedStateCode"];
	
	[ClientProfile setObject:txtOfficeAddr1.text forKey:@"txtOfficeAddr1"];
	[ClientProfile setObject:txtOfficeAddr2.text forKey:@"txtOfficeAddr2"];
	[ClientProfile setObject:txtOfficeAddr3.text forKey:@"txtOfficeAddr3"];
	[ClientProfile setObject:txtOfficeTown.text forKey:@"txtOfficeTown"];
	[ClientProfile setObject:txtOfficePostCode.text forKey:@"txtOfficePostCode"];
	//[ClientProfile setObject:SelectedOfficeStateCode forKey:@"SelectedOfficeStateCode"];
	
	//[ClientProfile setObject:ResidenceForeignAddressFlag forKey:@"ResidenceForeignAddressFlag"];
	//[ClientProfile setObject:OfficeForeignAddressFlag forKey:@"OfficeForeignAddressFlag"];
	
	[ClientProfile setObject:txtPrefix1.text forKey:@"txtPrefix1"];
	[ClientProfile setObject:txtContact1.text forKey:@"txtContact1"];
	[ClientProfile setObject:txtPrefix2.text forKey:@"txtPrefix2"];
	[ClientProfile setObject:txtContact2.text forKey:@"txtContact2"];
	[ClientProfile setObject:txtPrefix3.text forKey:@"txtPrefix3"];
	[ClientProfile setObject:txtContact3.text forKey:@"txtContact3"];
	[ClientProfile setObject:txtPrefix4.text forKey:@"txtPrefix4"];
	[ClientProfile setObject:txtContact4.text forKey:@"txtContact4"];
	
	[ClientProfile setObject:txtRemark.text forKey:@"txtRemark"];
	[ClientProfile setObject:txtEmail.text forKey:@"txtEmail"];
	
	
	//NSLog(@"value2: %@", [ClientProfile stringForKey:@"ClientSmoker"]);
	
	//	NSString *save = [ClientProfile stringForKey:@"NeedToSave"];
	//	if ([save isEqualToString:@"YES"]) {
	//		[self SaveFromUserDefault];
	//		NSLog(@"TEXTFIELD");
	//	}
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    sqlite3_stmt *statement;
    sqlite3_stmt *statement2;
    
    switch (buttonIndex) {
        case 0:
        {
            if (alertView.tag == 1) { //delete mode
                
                const char *dbpath = [databasePath UTF8String];
                
                if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
                    NSString *DeleteProspectSQL = [NSString stringWithFormat:
                                                   @"Delete from prospect_profile where \"indexNo\" = \"%@\" ", pp.ProspectID];
                    
                    const char *Delete_prospectStmt = [DeleteProspectSQL UTF8String];
                    if(sqlite3_prepare_v2(contactDB, Delete_prospectStmt, -1, &statement, NULL) == SQLITE_OK)
                    {
                        int zzz = sqlite3_step(statement);
                        
                        if (zzz == SQLITE_DONE){
                            
                            /*
                             UIAlertView *SuccessAlert = [[UIAlertView alloc] initWithTitle:@" " message:@"Delete Success" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                             [SuccessAlert show];
                             
                             EditTableViewController *Listing = [self.storyboard instantiateViewControllerWithIdentifier:@"Listing"];
                             Listing.modalPresentationStyle = UIModalPresentationFullScreen;
                             Listing.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                             [self presentModalViewController:Listing animated:YES];
                             */
                        }
                        
                        sqlite3_finalize(statement);
                    }
                    
                    NSString *DeleteContactSQL = [NSString stringWithFormat:
                                                  @"Delete from contact_input where \"indexNo\" = %@ ", pp.ProspectID];
                    
                    const char *Delete_ContactStmt = [DeleteContactSQL UTF8String];
                    if(sqlite3_prepare_v2(contactDB, Delete_ContactStmt, -1, &statement2, NULL) == SQLITE_OK)
                    {
                        int delCount = sqlite3_step(statement2);
                        
                        if (delCount == SQLITE_DONE){
                            
                            sqlite3_finalize(statement);
                            
                            if (_delegate != nil) {
                                [_delegate FinishEdit];
                            }
                            
                            UIAlertView *SuccessAlert = [[UIAlertView alloc] initWithTitle:@" "
                                                                                   message:@"Prospect record successfully been deleted" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                            SuccessAlert.tag = 2;
                            [SuccessAlert show];
                            
                        }
                        sqlite3_finalize(statement2);
                        
                    }
                    
                    sqlite3_close(contactDB);
                }
                
            }
            
            else if (alertView.tag == 2) {
                [self resignFirstResponder];
                [self.view endEditing:YES];
                //[self dismissModalViewControllerAnimated:YES];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            else if (alertView.tag == 1003) {
                [self resignFirstResponder];
                [self.view endEditing:YES];
                [self dismissModalViewControllerAnimated:YES];
            }
            
			
            else if ((alertView.tag == 3000)  || (alertView.tag == 3001)) {
                
                [txtOfficePostCode becomeFirstResponder];
            }
            else if ((alertView.tag == 2000) || (alertView.tag == 2001) ) {
                
                [txtHomePostCode becomeFirstResponder];
            }
			else if(alertView.tag == 1004)
			{
				[[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"data"];
				[self saveToDB];
				
				
			}
        }
            break;
            
        case 1:
        {
            
            if (alertView.tag == 1) { //delete mode
				
            }
            else if (alertView.tag == 1003) { //save changes
                //[self SaveChanges];
            }
            else if (alertView.tag == 1001) {
                
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
			
            
        }
            break;
    }
    
	
    //
    if(alertView.tag == 80)
    {
        [txtrFullName becomeFirstResponder];
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
    
    else if (alertView.tag == 1002 || alertView.tag == 1003 ) {
        [txtIDType becomeFirstResponder];
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
        
        BtnCountryOfBirth.titleLabel.textColor = [UIColor redColor];
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
    else if (alertView.tag == 2020) {
        
        [txtPrefix3 becomeFirstResponder];
		[myScrollView setContentOffset:CGPointMake(0,250) animated:YES];
    }
    else if (alertView.tag == 2021) {
        
        [txtPrefix4 becomeFirstResponder];
		[myScrollView setContentOffset:CGPointMake(0,250) animated:YES];
    }
    else if (alertView.tag == 2022) {
        
        [txtContact1 becomeFirstResponder];
        [myScrollView setContentOffset:CGPointMake(0,200) animated:YES];
    }
    else if (alertView.tag == 2023) {
        
        [txtContact2 becomeFirstResponder];
        [myScrollView setContentOffset:CGPointMake(0,200) animated:YES];
    }
    else if (alertView.tag == 2024) {
        
        [txtContact3 becomeFirstResponder];
        [myScrollView setContentOffset:CGPointMake(0,250) animated:YES];
    }
    else if (alertView.tag == 2025) {
        
        [txtContact4 becomeFirstResponder];
        [myScrollView setContentOffset:CGPointMake(0,250) animated:YES];
    }
	
    else if(alertView.tag == 2060)
    {
        [txtBussinessType becomeFirstResponder];
		[myScrollView setContentOffset:CGPointMake(0,400) animated:YES];
    }
    
    
    
    
    else if(alertView.tag == 5000)
    {
        if(buttonIndex == 0) //YES
        {
            [self SaveChanges];
        }
        
        else
        {
            [self resignFirstResponder];
            [self.view endEditing:YES];
            [self.navigationController popViewControllerAnimated:YES];
			
			NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
			[ClientProfile setObject:@"NO" forKey:@"isEdited"];
			[ClientProfile setObject:@"NO" forKey:@"ReSave"];
            
            
            
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
    else if(alertView.tag == 9001)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
	else if (alertView.tag == 1113 && buttonIndex == 0) {
		[UDGroup setObject:DelGroupArr forKey:@"DelGroupArr"];
	}
	else if (alertView.tag == 1113 && buttonIndex == 1) {
		[DelGroupArr removeAllObjects];
		[UDGroup setObject:DelGroupArr forKey:@"DelGroupArr"];
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


#pragma mark - db

-(void) getSameIDRecord :(NSString*)type : (NSString*)index
{
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    NSString *ProspectID = @"";
    
    NSString *RigNumber = @"";
    NSString *RigDate = @"";
    NSString *registration = @"";
    NSString *registrationexempted = @"";
    
    NSString *NickName = @"";
    NSString *ProspectName = @"";
    NSString *ProspectDOB = @"" ;
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
        type = SameID_type;
		
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
                //basvi aaded
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
                
                const char *rigno = (const char*)sqlite3_column_text(statement, 41);
                RigNumber = rigno == NULL ? nil : [[NSString alloc] initWithUTF8String:rigno];
                
                const char *rigdate = (const char*)sqlite3_column_text(statement, 42);
                RigDate = rigdate == NULL ? nil : [[NSString alloc] initWithUTF8String:rigdate];
                
                const char *rig = (const char*)sqlite3_column_text(statement, 40);
                registration = rig== NULL ? nil : [[NSString alloc] initWithUTF8String:rig];
                
                const char *rigexempted = (const char*)sqlite3_column_text(statement, 43);
                registrationexempted = rigexempted == NULL ? nil : [[NSString alloc] initWithUTF8String:rigexempted];
                
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
											  AndProspectOccupationCode:ProspectOccupationCode AndProspectDOB:ProspectDOB AndExactDuties:ExactDuties AndGroup:ProspectGroup AndTitle:ProspectTitle AndIDTypeNo:IDTypeNo AndOtherIDType:OtherIDType2 AndOtherIDTypeNo:OtherIDTypeNo AndSmoker:Smoker AndAnnIncome:AnnIncome AndBussType:BussinessType AndRace:Race AndMaritalStatus:MaritalStatus AndReligion:Religion AndNationality:Nationality AndRegistrationNo:RigNumber AndRegistration:registration AndRegistrationDate:RigDate AndRegistrationExempted:registrationexempted AndProspect_IsGrouping:isGrouping AndCountryOfBirth:COB];
                
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
        
        [OtherIDType setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", [self getIDTypeDesc:prospectprofile.OtherIDType]] forState:UIControlStateNormal];
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
        if ([[prospectprofile.OtherIDType stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"COMPANYREGISTRATIONNUMBER"] || [[prospectprofile.OtherIDType stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"CR"])
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
        txtOfficePostCode.text = prospectprofile.OfficeAddressPostCode;
    }
    else {
        txtOfficePostCode.text = @"";
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
    
    
    
    txtrFullName.text = prospectprofile.ProspectName;
    
    
	
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
                
                
                 outletRigDOB.titleLabel.textColor = [UIColor grayColor];
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
                
                txtOfficePostCode.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
                txtOfficePostCode.enabled = NO;
                
            }
            
			
            
            if(([OccpCatCode isEqualToString:@"HSEWIFE"])
               || ([OccpCatCode isEqualToString:@"JUV"])
			   //  || ([OccpCatCode isEqualToString:@"RET"])
               || ([OccpCatCode isEqualToString:@"STU"]))
				//  || ([OccpCatCode isEqualToString:@"UNEMP"]))
            {
                
                
                ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
                
                
                
                if (![[prospectprofile.OtherIDType stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"COMPANYREGISTRATIONNUMBER"] && ![[prospectprofile.OtherIDType stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"CR"])
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
            
            
            if (![[txtOfficePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"" ] && [txtOfficeCountry.text isEqualToString:@"MALAYSIA"]) {
                
				txtOfficeState.text = officestate;
                [txtOfficePostCode addTarget:self action:@selector(OfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                [txtOfficePostCode addTarget:self action:@selector(OfficeEditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
            }
            else if (![[txtOfficePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"" ] && ![txtOfficeCountry.text isEqualToString:@"MALAYSIA"]) {
                
                txtOfficeState.text = prospectprofile.OfficeAddressState;
            }
            else{
                
                txtOfficeState.text = @"";
                [txtOfficePostCode addTarget:self action:@selector(OfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                [txtOfficePostCode addTarget:self action:@selector(OfficeEditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
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
        
        txtOfficePostCode.backgroundColor  = [CustomColor colorWithHexString:@"EEEEEE"];
        txtOfficePostCode.enabled = NO;
        
        
        
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
		pp.ProspectOccupationCode = prospectprofile.ProspectOccupationCode;
		[self PopulateOccupCode];
		
		//		NSLog(@"occ: %@ ", outletOccup.titleLabel.text);
		
		if([outletOccup.titleLabel.text isEqualToString:@"-SELECT -"])
			
			outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
		else
			outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		
		
		if([outletOccup.titleLabel.text isEqualToString:@""])
			[outletOccup setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
		else
			[outletOccup setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", outletOccup.titleLabel.text]forState:UIControlStateNormal];
		
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
        
        NSString *querySQL = [NSString stringWithFormat:@"SELECT OccpDesc, Class FROM Adm_Occp_Loading_Penta where OccpCode = \"%@\"", pp.ProspectOccupationCode];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW){
                NSString *OccpDesc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *OccpClass = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                
                OccupCodeSelected = pp.ProspectOccupationCode;
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
        
        NSString *querySQL = [NSString stringWithFormat:@"SELECT IdentityDesc FROM eProposal_Identification where IdentityCode = \"%@\"", pp.OtherIDType];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW){
                NSString *OtherIDDesc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
				
                
                OccupCodeSelected = pp.ProspectOccupationCode;
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
        
        NSString *querySQL = [NSString stringWithFormat:@"SELECT TitleDesc FROM eProposal_Title WHERE TitleCode = \"%@\"", pp.ProspectTitle];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW){
                NSString *TitleDesc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
				
                
                OccupCodeSelected = pp.ProspectOccupationCode;
                if([TitleDesc isEqualToString:@""])
                    [outletTitle setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
                else
                    [outletTitle setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", TitleDesc]forState:UIControlStateNormal];
				
                outletTitle.titleLabel.text = TitleDesc;
                
                
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
	
}

-(void) PopulateState
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT StateDesc FROM eProposal_state where status = \"A\" and StateCode = \"%@\"", pp.ResidenceAddressState];
        
		
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW){
                NSString *StateName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                txtHomeState.text = StateName;
                SelectedStateCode = pp.ResidenceAddressState;
            }
            sqlite3_finalize(statement);
            
        }
        sqlite3_close(contactDB);
    }
}

-(void) PopulateOfficeState
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT StateDesc FROM eProposal_state where status = \"A\" and StateCode = \"%@\"", pp.OfficeAddressState];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW){
                
                NSString *StateName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                txtOfficeState.text = StateName;
                SelectedOfficeStateCode = pp.OfficeAddressState;
                
            }
            
            sqlite3_finalize(statement);
            
        }
        
        sqlite3_close(contactDB);
    }
}

-(void) GetLastID
{
    sqlite3_stmt *statement3;
    NSString *lastID = @"";
    NSString *contactCode = @"";
	NSString *Contact1 = txtContact1.text;
	NSString *Contact2 = txtContact2.text;
	NSString *Contact3 = txtContact3.text;
	NSString *Contact4 = txtContact4.text;
	NSString *Prefix1 = txtPrefix1.text;
	NSString *Prefix2 = txtPrefix2.text;
	NSString *Prefix3 = txtPrefix3.text;
	NSString *Prefix4 = txtPrefix4.text;
	
	NSString *ProspectID = pp.ProspectID;
	if (ProspectID == nil) {
		NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
		ProspectID = [ClientProfile stringForKey:@"ProspectID"];
		Prefix1 = [ClientProfile stringForKey:@"txtPrefix1"];
		Contact1 = [ClientProfile stringForKey:@"txtContact1"];
		Prefix2 = [ClientProfile stringForKey:@"txtPrefix2"];
		Contact2 = [ClientProfile stringForKey:@"txtContact2"];
		Prefix3 = [ClientProfile stringForKey:@"txtPrefix3"];
		Contact3 = [ClientProfile stringForKey:@"txtContact3"];
		Prefix4 = [ClientProfile stringForKey:@"txtPrefix4"];
		Contact4 = [ClientProfile stringForKey:@"txtContact4"];
	}
    //delete record first
    [self DeleteRecord];
    
    for (int a=0; a<4; a++) {
        
        switch (a) {
                
            case 0:
                //home
                contactCode = @"CONT006";
                break;
                
            case 1:
                //mobile
                contactCode = @"CONT008";
                break;
                
            case 2:
                //office
                contactCode = @"CONT007";
                break;
                
            case 3:
                //fax
                contactCode = @"CONT009";
                break;
                
            default:
                break;
        }
        
        if (![contactCode isEqualToString:@""]) {
            
            lastID = ProspectID;
            NSString *insertContactSQL;
            
            if (a == 0) {
                insertContactSQL = [NSString stringWithFormat:
                                    @"INSERT INTO contact_input(\"IndexNo\",\"contactCode\", \"ContactNo\", \"Primary\", \"Prefix\") "
                                    " VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", lastID, contactCode, Contact1, @"N", Prefix1];
                
            }
            else if (a == 1) {
                insertContactSQL = [NSString stringWithFormat:
                                    @"INSERT INTO contact_input(\"IndexNo\",\"contactCode\", \"ContactNo\", \"Primary\", \"Prefix\") "
                                    " VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", lastID, contactCode, Contact2, @"N", Prefix2];
                
            }
            else if (a == 2) {
                insertContactSQL = [NSString stringWithFormat:
                                    @"INSERT INTO contact_input(\"IndexNo\",\"contactCode\", \"ContactNo\", \"Primary\", \"Prefix\") "
                                    " VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", lastID, contactCode, Contact3, @"N", Prefix3];
                
            }
            else if (a == 3) {
                insertContactSQL = [NSString stringWithFormat:
                                    @"INSERT INTO contact_input(\"IndexNo\",\"contactCode\", \"ContactNo\", \"Primary\", \"Prefix\") "
                                    " VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", lastID, contactCode, Contact4, @"N", Prefix4];
                
            }
            
            if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK) {
                
                const char *insert_contactStmt = [insertContactSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, insert_contactStmt, -1, &statement3, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement3) == SQLITE_DONE){
                        sqlite3_finalize(statement3);
                        //UIAlertView *SuccessAlert = [[UIAlertView alloc] initWithTitle:@" " message:@"Saved Successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        //[SuccessAlert show];
                        
                    }
                    else {
                        NSLog(@"Error - 4");
                    }
                }
                else {
                    NSLog(@"Error - 3");
                    
                }
                
                sqlite3_close(contactDB);
            }
        }
    }
    
    if (_delegate != nil) {
        [_delegate FinishEdit];
    }
}

- (void) DeleteRecord
{
    sqlite3_stmt *statement;
	
	NSString *ProspectID = pp.ProspectID;
	//NSLog(@"PP: %@",ProspectID);
	if (ProspectID == nil) {
		NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
		ProspectID = [ClientProfile stringForKey:@"ProspectID"];
	}
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *DeleteSQL = [NSString stringWithFormat:@"Delete from contact_input where indexNo = \"%@\"", ProspectID];
        const char *Delete_stmt = [DeleteSQL UTF8String];
        if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            sqlite3_step(statement);
            sqlite3_finalize(statement);
            
        }
        else {
            
            NSLog(@"Error in Delete Statement");
        }
        sqlite3_close(contactDB);
    }
}

- (void) CheckTrustee {
	
	//1) check if user change on religion or marital status
	BOOL NO_Trustee;
	
	NSString *marital = [outletMaritalStatus.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSString *religion = [outletReligion.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	if ([religion isEqualToString:@"MUSLIM"]){
		NO_Trustee = TRUE;
	}
	else if ([marital isEqualToString:@""]) {
		NO_Trustee = TRUE;
	}
	else
		NO_Trustee = FALSE;
	
	//2) check for trustee and nominee if exist
	
	//3) edit or update Trustee..
	
	
}

- (void) saveToDB
{
    
    sqlite3_stmt *statement;
    
    const char *dbpath = [databasePath UTF8String];
	
	FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
	[db open];
	FMResultSet *result;
	
    int counter = 0;
    NSString *group = @"";
    NSString *title = @"";
    NSString *otherID = @"";
    NSString *OffCountry = @"";
    NSString *HomeCountry = @"";
    NSString *strDOB = @"";
    NSString *strGstdate = @"";
    NSString *marital = @"";
    NSString *nation = @"";
    NSString *race = @"";
    NSString *religion = @"";
	NSString *ResidenceForeignAddressFlag = @"";
	NSString *OfficeForeignAddressFlag = @"";
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
		
        txtrFullName.text = [txtrFullName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		
		marital = [outletMaritalStatus.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        nation = [outletNationality.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        
        race  = [outletRace.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        religion = [outletReligion.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		
        if([marital isEqualToString:@"- SELECT -"])
			marital = @"";
		
		if([race isEqualToString:@"- SELECT -"])
			race = @"";
		
		if([religion isEqualToString:@"- SELECT -"])
			religion = @"";
		
		if([nation isEqualToString:@"- SELECT -"])
			nation = @"";
		
        
        if (txtDOB.text.length == 0) {
            strDOB = [outletDOB.titleLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
        else {
            strDOB = txtDOB.text;
        }
        
        if (![outletGroup.titleLabel.text isEqualToString:@"- SELECT -"]) {
            group =   [outletGroup.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
			
        }
        else {
            group = outletGroup.titleLabel.text;
        }
        
        if([group isEqualToString:@"- SELECT -"])
            group = @"";
        group = [self getGroupID:group];
        
         strGstdate = outletRigDOB.titleLabel.text;
        
        if([strGstdate isEqualToString:@"- SELECT -"])
        {
             strGstdate =@"";
        }
        
        if (![outletTitle.titleLabel.text isEqualToString:@"- SELECT -"]) {
            title = [outletTitle.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
			
        }
        else {
            title = outletTitle.titleLabel.text;
        }
        
        
        if (![OtherIDType.titleLabel.text isEqualToString:@"- SELECT -"]) {
            
            otherID =  [OtherIDType.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            
        }
        else {
            otherID = OtherIDType.titleLabel.text;
        }
        
        if([otherID isEqualToString:@"- SELECT -"] || [otherID isEqualToString:@""])
            otherID = @"";
		
		if (otherID == NULL || [otherID isEqualToString:@"(NULL)"])
			otherID = @"";
        
        if (checked) {
            HomeCountry = btnHomeCountry.titleLabel.text;
            SelectedStateCode = txtHomeState.text;
			ResidenceForeignAddressFlag = @"Y";
        }
        else {
            HomeCountry = txtHomeCountry.text;
			ResidenceForeignAddressFlag = @"N";
        }
        
        if (checked2) {
            OffCountry = btnOfficeCountry.titleLabel.text;
            SelectedOfficeStateCode = txtOfficeState.text;
			OfficeForeignAddressFlag = @"Y";
        }
        else {
            OffCountry = txtOfficeCountry.text;
			OfficeForeignAddressFlag = @"N";
        }
        
		
        HomeCountry = [self getCountryCode:HomeCountry];
        OffCountry = [self getCountryCode:OffCountry];
		
		
		
		if([SelectedStateCode isEqualToString:@"(null)"]  || (SelectedStateCode == NULL))
			SelectedStateCode = @"";
		
		if([TitleCodeSelected isEqualToString:@"(null)"]  || (TitleCodeSelected == NULL))
			TitleCodeSelected = @"";
        
        
        //GET PP  CHANGES COUNTER
        //int counter = 0;
        result = [db executeQuery:@"SELECT ProspectProfileChangesCounter from prospect_profile WHERE indexNo = ?", pp.ProspectID];
        while ([result next]) {
            counter =  [result intForColumn:@"ProspectProfileChangesCounter"];
            
			// NSLog(@"si - %@  || pp.ProspectID-%@",si_name,pp.ProspectID);
            
        }
		
        [result close];
        
        
        counter = counter+1;
		
		//eliminate empty or null value
		if (IDTypeCodeSelected == NULL || [IDTypeCodeSelected isEqualToString:@"(NULL)"] || [IDTypeCodeSelected isEqualToString:@"(null)"])
			IDTypeCodeSelected = @"";
		if (OffCountry == NULL || [OffCountry isEqualToString:@"(NULL)"] || [OffCountry isEqualToString:@"(null)"])
			OffCountry = @"";
		if (SelectedOfficeStateCode == NULL || [SelectedOfficeStateCode isEqualToString:@"(NULL)"] || [SelectedOfficeStateCode isEqualToString:@"(null)"])
			SelectedOfficeStateCode = @"";
		
		if(gender == nil || gender==NULL || [gender isEqualToString:@"(null)"])
			gender=@"";//Default value
		
		if(ClientSmoker == nil || ClientSmoker ==NULL || [ClientSmoker isEqualToString:@"(null)"])
			ClientSmoker=@"";
		
		if (segSmoker.enabled == FALSE) {
			ClientSmoker=@"";
		}
		
        NSLog(@"BB name: %@", txtrFullName.text);
		
		if (Update_record) {
			//change index number
			NSLog(@"ID before: %@", pp.ProspectID);
			pp.ProspectID = getSameRecord_Indexno;
			NSLog(@"ID after: %@", pp.ProspectID);
		}
		
		NSString *IsGrrouping = @"";
		if (SegIsGrouping.selectedSegmentIndex == 0) {
			IsGrrouping = @"Y";
			group = [self ProspectGroup_toString];
		}
		else if (SegIsGrouping.selectedSegmentIndex == 1) {
			IsGrrouping = @"N";
//			group = [self ProspectGroup_toString];
//			if (![group isEqualToString:@""]) {
//				[self DeleteGroup2];
//			}
			group = @"";
		}
		
		NSString *CountryOfBirth = @"";
		CountryOfBirth = [BtnCountryOfBirth.titleLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
		
		CountryOfBirth = [self getCountryCode:CountryOfBirth];
		
		
		NSLog(@"CS %@", ClientSmoker);
		//Delete Group if empty:
		[self DeleteGroup];
		
        NSString *str_counter = [NSString stringWithFormat:@"%i",counter];
        NSString *insertSQL = [NSString stringWithFormat:
                               @"update prospect_profile set \"ProspectName\"=\'%@\', \"ProspectDOB\"=\"%@\", \"GST_registered\"=\"%@\",\"GST_registrationNo\"=\"%@\",\"GST_registrationDate\"=\"%@\",\"GST_exempted\"=\"%@\",  \"ProspectGender\"=\"%@\", \"ResidenceAddress1\"=\"%@\", \"ResidenceAddress2\"=\"%@\", \"ResidenceAddress3\"=\"%@\", \"ResidenceAddressTown\"=\"%@\", \"ResidenceAddressState\"=\"%@\", \"ResidenceAddressPostCode\"=\"%@\", \"ResidenceAddressCountry\"=\"%@\", \"OfficeAddress1\"=\"%@\", \"OfficeAddress2\"=\"%@\", \"OfficeAddress3\"=\"%@\", \"OfficeAddressTown\"=\"%@\",\"OfficeAddressState\"=\"%@\", \"OfficeAddressPostCode\"=\"%@\", \"OfficeAddressCountry\"=\"%@\", \"ProspectEmail\"= \"%@\", \"ProspectOccupationCode\"=\"%@\", \"ExactDuties\"=\"%@\", \"ProspectRemark\"=\"%@\", \"DateModified\"=%@,\"ModifiedBy\"=\"%@\", \"ProspectGroup\"=\"%@\", \"ProspectTitle\"=\"%@\", \"IDTypeNo\"=\"%@\", \"OtherIDType\"=\"%@\", \"OtherIDTypeNo\"=\"%@\", \"Smoker\"=\"%@\", \"AnnualIncome\"=\"%@\", \"BussinessType\"=\"%@\", \"Race\"=\"%@\", \"MaritalStatus\"=\"%@\", \"Nationality\"=\"%@\", \"Religion\"=\"%@\",\"ProspectProfileChangesCounter\"=\"%@\", \"Prospect_IsGrouping\"=\"%@\", \"CountryOfBirth\"=\"%@\"   where indexNo = \"%@\" "
                               "", txtrFullName.text, strDOB,GSTRigperson,txtRigNO.text,strGstdate, GSTRigExempted,gender, txtHomeAddr1.text, txtHomeAddr2.text, txtHomeAddr3.text, txtHomeTown.text, SelectedStateCode, txtHomePostCode.text, HomeCountry, txtOfficeAddr1.text, txtOfficeAddr2.text, txtOfficeAddr3.text, txtOfficeTown.text, SelectedOfficeStateCode, txtOfficePostCode.text, OffCountry, txtEmail.text, OccupCodeSelected, txtExactDuties.text, txtRemark.text, @"datetime(\"now\", \"+8 hour\")", @"1", group, TitleCodeSelected, txtIDType.text, IDTypeCodeSelected, txtOtherIDType.text, ClientSmoker, txtAnnIncome.text, txtBussinessType.text,race, marital, nation,
                               religion,str_counter, IsGrrouping, CountryOfBirth, pp.ProspectID];
        
        NSLog(@"UPDATE PPSQL1: %@", insertSQL);
		
		
		
        const char *Update_stmt = [insertSQL UTF8String];
        if(sqlite3_prepare_v2(contactDB, Update_stmt, -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                [self GetLastID];
                
            } else {
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" " message:@"Fail in update" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
            }
            sqlite3_finalize(statement);
        }
        else {
            NSLog(@"Error Statement");
        }
        sqlite3_close(contactDB);
    }
    else {
        NSLog(@"Error Open");
    }
    
    
    //******** START ****************  UPDATE CLIENT OF LA1, LA2 (NOT PO) IN EAPP   *********************************
    
	//Note: why only update LA_details when POFlag = N, need confirmation on this ##ENS
    
	
    NSString *query = [NSString stringWithFormat:@"SELECT LANAME, eProposalNo FROM eProposal_LA_Details WHERE ProspectProfileID = '%@'", pp.ProspectID];
    
    
    result = [db executeQuery:query];
    NSString *ProposalNo;
	
	NSMutableArray *ProposalCount = [NSMutableArray array];
	int i;
	int countP = 0;
	
	// NSLog(@"KY QUERY - %@ SELECT COUNT(*) FROM eProposal_LA_Details WHERE ProspectProfileID = '%@' AND POFlag = 'N'", pp.ProspectID);
    
	NSLog(@"query: %@", query);
	
    while ([result next]) {
        
        //int count = [result intForColumn:@"COUNT(*)"];
        
		//ADD BY EMI, CHECK STATUS IN EAPP, ONLY UPDATE
        ProposalNo = [result stringForColumn:@"eProposalNo"];
        FMResultSet *resultStatus;
		NSString *queryStatus = [NSString stringWithFormat:@"SELECT proposalNo, status FROM eApp_Listing WHERE proposalNo = '%@' AND status in (2,3)", ProposalNo];
		resultStatus = [db executeQuery:queryStatus];
		
        //if(count > 0 )
		if ([resultStatus next])
        {
            
			//KEEP PROPOSAL NO THAT CAN BE UPDATE IN ARRAY
			[ProposalCount insertObject: ProposalNo atIndex: countP];
			countP = countP + 1;
			//
			
            NSString *str_counter = [NSString stringWithFormat:@"%i",counter];
            
			//            NSString *contact1 =  [NSString stringWithFormat:@"%@%@",txtPrefix1.text, txtContact1.text ];
			//            NSString *contact2 =  [NSString stringWithFormat:@"%@%@",txtPrefix2.text, txtContact2.text ];
			//            NSString *contact3 =  [NSString stringWithFormat:@"%@%@",txtPrefix3.text, txtContact3.text ];
			//            NSString *contact4 =  [NSString stringWithFormat:@"%@%@",txtPrefix4.text, txtContact4.text ];
			
			
            
            NSLog(@"ccName: %@", txtrFullName.text);
			
			if ([gender isEqualToString:@"MALE"]) {
				gender = @"M";
			}
			else if ([gender isEqualToString:@"FEMALE"]) {
				gender = @"F";
			}
			
            NSString *update_query = [NSString stringWithFormat:@"Update eProposal_LA_Details SET \"LATitle\" = \"%@\", \"LAName\" = \"%@\", \"LASex\" = \"%@\", \"LADOB\" = \"%@\", \"LANewICNO\" = \"%@\", \"LAOtherIDType\" = \"%@\", \"LAOtherID\" = \"%@\", \"LAMaritalStatus\" = \"%@\", \"LARace\" = \"%@\", \"LAReligion\" = \"%@\", \"LANationality\" = \"%@\", \"LAOccupationCode\" = \"%@\", \"LAExactDuties\" = \"%@\", \"LATypeOfBusiness\" = \"%@\", \"ResidenceAddress1\" = \"%@\", \"ResidenceAddress2\" = \"%@\", \"ResidenceAddress3\" = \"%@\", \"ResidenceTown\" = \"%@\", \"ResidenceState\" = \"%@\", \"ResidencePostcode\" = \"%@\", \"ResidenceCountry\" = \"%@\", \"OfficeAddress1\" = \"%@\", \"OfficeAddress2\" = \"%@\", \"OfficeAddress3\" = \"%@\", \"OfficeTown\" = \"%@\", \"OfficeState\" = \"%@\", \"OfficePostcode\" = \"%@\", \"OfficeCountry\" = \"%@\", \"ResidenceForeignAddressFlag\" = \"%@\", \"OfficeForeignAddressFlag\" = \"%@\", \"ResidencePhoneNo\" = \"%@\", \"MobilePhoneNo\" = \"%@\", \"OfficePhoneNo\" = \"%@\", \"FaxPhoneNo\" = \"%@\",  \"ResidencePhoneNoPrefix\" = \"%@\", \"MobilePhoneNoPrefix\" = \"%@\", \"OfficePhoneNoPrefix\" = \"%@\", \"FaxPhoneNoPrefix\" = \"%@\", \"EmailAddress\" = \"%@\", \"LASmoker\" = \"%@\", \"ProspectProfileChangesCounter\" = \"%@\", \"GST_registered\" = \"%@\", \"GST_registrationNo\" = \"%@\", \"GST_registrationDate\" = \"%@\", \"GST_exempted\" = \"%@\" WHERE  ProspectProfileID = \"%@\";",
                                      
									  TitleCodeSelected,
                                      txtrFullName.text,
                                      gender,
                                      strDOB,
                                      txtIDType.text,
                                      IDTypeCodeSelected,
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
                                      txtOfficePostCode.text,
                                      OffCountry,
                                      
									  ResidenceForeignAddressFlag,
									  OfficeForeignAddressFlag,
									  
                                      txtContact1.text,
									  txtContact2.text,
									  txtContact3.text,
									  txtContact4.text,
									  txtPrefix1.text,
									  txtPrefix2.text,
									  txtPrefix3.text,
									  txtPrefix4.text,
                                      txtEmail.text,
                                      ClientSmoker,
                                      str_counter,
                                      GSTRigperson,
                                      txtRigNO.text,
                                      strGstdate,
                                      GSTRigExempted,
                                      pp.ProspectID];
            
            [db executeUpdate:update_query];
			NSLog(@"UPDATE PP QUERY: %@", update_query);
            
            
        }
    }
    [result close];
	
	countP = [ProposalCount count];
	
	
	
	//********* END ***************  UPDATE CLIENT OF LA1, LA2 (NOT PO) IN EAPP   *********************************
	
    //******** START ****************  DELETE CLIENT OF LA1, LA2, PO IN EAPP for CONFIRMED CASE   *********************************
    
	//Note: Only delete LA_details when Status = 3
    
    NSString *query_eApp = [NSString stringWithFormat:@"SELECT COUNT(*) FROM eApp_Listing WHERE ClientProfileID = '%@' AND Status = '%@'", pp.ProspectID,@"3"];
    NSString *eProposalNo;
    NSString *ProposalNo_to_delete;
    result = [db executeQuery:query_eApp];
    [db open];
    
    count_eApp = 0;
    
    while ([result next]) {
        
        count_eApp = [result intForColumn:@"COUNT(*)"] + count_eApp;
        if ([result intForColumn:@"COUNT(*)"] > 0) {
            
            FMResultSet *result_get_proposal = [db executeQuery:@"SELECT * from eApp_Listing WHERE ClientProfileID = ? AND Status = ?", pp.ProspectID,@"3"];
            while ([result_get_proposal next]) {
                ProposalNo_to_delete =  [result_get_proposal objectForColumnName:@"ProposalNo"];
                [self deleteConfirmCase:ProposalNo_to_delete database:db];
                
            }
        }
        
    }
    
    // Check Policy Owner, LA1, LA2
    FMResultSet *result_checkLA = [db executeQuery:@"SELECT * from eProposal_LA_Details WHERE ProspectProfileID = ?", pp.ProspectID];
    while ([result_checkLA next]) {
        
        eProposalNo =  [result_checkLA objectForColumnName:@"eProposalNo"];
        
        FMResultSet *result_check_proposal = [db executeQuery:@"SELECT COUNT(*) from eApp_Listing WHERE ProposalNo = ? AND Status = ?", eProposalNo,@"3"];
        
        while ([result_check_proposal next]) {
            
            count_eApp = [result_check_proposal intForColumn:@"COUNT(*)"] + count_eApp;
            if ([result_check_proposal intForColumn:@"COUNT(*)"] > 0) {
                ProposalNo_to_delete =  [result_checkLA objectForColumnName:@"eProposalNo"];
                [self deleteConfirmCase:ProposalNo_to_delete database:db];
            }
            
        }
        
    }
    
    
    // Check Policy Owner Family
    FMResultSet *result_checkFamily = [db executeQuery:@"SELECT * from eProposal_CFF_Family_Details WHERE ClientProfileID = ?", pp.ProspectID];
    while ([result_checkFamily next]) {
        
        eProposalNo =  [result_checkFamily objectForColumnName:@"eProposalNo"];
        
        FMResultSet *result_check_proposal2 = [db executeQuery:@"SELECT COUNT(*) from eApp_Listing WHERE ProposalNo = ? AND Status = ?", eProposalNo,@"3"];
        
        while ([result_check_proposal2 next]) {
            
            count_eApp = [result_check_proposal2 intForColumn:@"COUNT(*)"] + count_eApp;
            if ([result_check_proposal2 intForColumn:@"COUNT(*)"] > 0) {
                ProposalNo_to_delete =  [result_checkFamily objectForColumnName:@"eProposalNo"];
                [self deleteConfirmCase:ProposalNo_to_delete database:db];
            }
            
        }
        
    }
    
    // to get IC, OtherID and OtherIDNo
    NSString *IDTypeNo;
    NSString *OtherIDType2;
    NSString *OtherIDTypeNo;
    FMResultSet *get_IC = [db executeQuery:@"SELECT * from prospect_profile WHERE IndexNo = ?", pp.ProspectID];
    while ([get_IC next]) {
        IDTypeNo =  [get_IC objectForColumnName:@"IDTypeNo"];
        OtherIDType2 =  [get_IC objectForColumnName:@"OtherType"];
        OtherIDTypeNo =  [get_IC objectForColumnName:@"OtherTypeNo"];
    }
    
    // Check Policy Spouse
    FMResultSet *result_checkSpouse = [db executeQuery:@"SELECT * from eProposal_CFF_Personal_Details WHERE NewICNo = ? OR (OtherIDType = ? AND OtherID = ?)", IDTypeNo,OtherIDType2,OtherIDTypeNo];
    while ([result_checkSpouse next]) {
        
        eProposalNo =  [result_checkSpouse objectForColumnName:@"eProposalNo"];
        
        FMResultSet *result_check_proposal3 = [db executeQuery:@"SELECT COUNT(*) from eApp_Listing WHERE ProposalNo = ? AND Status = ?", eProposalNo,@"3"];
        
        while ([result_check_proposal3 next]) {
            
            count_eApp = [result_check_proposal3 intForColumn:@"COUNT(*)"] + count_eApp;
            if ([result_check_proposal3 intForColumn:@"COUNT(*)"] > 0) {
                ProposalNo_to_delete =  [result_checkSpouse objectForColumnName:@"eProposalNo"];
                [self deleteConfirmCase:ProposalNo_to_delete database:db];
            }
            
            
        }
        
    }
	
	//#### DELETE EAPP CASE IF USER CHANGE OCCUPATION (FOR STATUS CREATE AND CONFIRMED)
	
	NSString *OldOcc = pp.ProspectOccupationCode;
	
	NSLog(@"OldOCC: %@, NEW OCC: %@", OldOcc, OccupCodeSelected);
	
	if (!([OldOcc isEqualToString:OccupCodeSelected]) && !([OccupCodeSelected isEqualToString:@""])) {
		for (i = 0; i < countP; i++) {
			NSLog (@"PropsalNOtoDelete %i = %@", i, [ProposalCount objectAtIndex: i]);
			ProposalNo_to_delete = [ProposalCount objectAtIndex: i];
			[self deleteConfirmCase:ProposalNo_to_delete database:db];
		}
	}
	
	
	//##### END
	
	//#### DELETE EAPP CASE IF USER CHANGE SMOKE (FOR STATUS CREATE AND CONFIRMED)
	
	NSString *OldSmoker = pp.Smoker;
	
	NSLog(@"Oldsmoker: %@, NEW: %@", OldSmoker, ClientSmoker);
	NSLog(@"countP: %d", countP);
	
	if (![OldSmoker isEqualToString:ClientSmoker]) {
		for (i = 0; i < countP; i++) {
			NSLog (@"PropsalNOtoDelete %i = %@", i, [ProposalCount objectAtIndex: i]);
			ProposalNo_to_delete = [ProposalCount objectAtIndex: i];
			[self deleteConfirmCase:ProposalNo_to_delete database:db];
		}
	}
	
	//##### END
	
	
	
    [result_checkLA close];
    [result_checkFamily close];
    [result_checkSpouse close];
    
	
	//### DELETE EAPP CASE IF PO IS ALREADY SIGN
	
	for (i = 0; i < countP; i++) {
		NSLog (@"PropsalNOtoDelete %i = %@", i, [ProposalCount objectAtIndex: i]);
		ProposalNo_to_delete = [ProposalCount objectAtIndex: i];
		NSString *PO_Sign;
		FMResultSet *result_eSign = [db executeQuery:@"SELECT * from eProposal_Signature WHERE eProposalNo = ? ", ProposalNo_to_delete];
		
		while ([result_eSign next]) {
			PO_Sign = [result_eSign objectForColumnName:@"isPOSign"];
			if  ((NSNull *) PO_Sign == [NSNull null])
				PO_Sign = @"";
			if ([PO_Sign isEqualToString:@"YES"]) {
				[self deleteConfirmCase:ProposalNo_to_delete database:db];
			}
		}
	}
	
	//#### END
	
	//delete trustee if religious change to Muslim
	
	if ([religion isEqualToString:@"MUSLIM"]) {
		for (i = 0; i < countP; i++) {
			NSLog (@"PropsalNOtoDelete %i = %@", i, [ProposalCount objectAtIndex: i]);
			ProposalNo_to_delete = [ProposalCount objectAtIndex: i];
			
			FMResultSet *result_trustee = [db executeQuery:@"SELECT * from eProposal_Trustee_Details WHERE eProposalNo = ? ", ProposalNo_to_delete];
			
			while ([result_trustee next]) {
				[db executeUpdate:@"DELETE FROM eProposal_Trustee_Details WHERE eProposalNo = ?", ProposalNo_to_delete];
				NSLog(@"Delete Trustee, religion is Muslim");
				ClearData *ClData =[[ClearData alloc]init];
				[ClData deleteOldPdfs:ProposalNo_to_delete];
			}
		}
	}
	
	//Delete trustee if change marital sttus (based on relation in nominee)
	
	//Check marital status
	
	NSLog(@"marital Ori: %@, change: %@", pp.MaritalStatus, marital);
	if (![marital isEqualToString:pp.MaritalStatus]) {
		for (i = 0; i < countP; i++) {
			NSLog (@"PropsalNOtoDelete %i = %@", i, [ProposalCount objectAtIndex: i]);
			ProposalNo_to_delete = [ProposalCount objectAtIndex: i];
			BOOL trust = [self validateTrust:ProposalNo_to_delete :marital database:db];
			
			if (!trust) {
				FMResultSet *result_trustee = [db executeQuery:@"SELECT * from eProposal_Trustee_Details WHERE eProposalNo = ? ", ProposalNo_to_delete];
				
				while ([result_trustee next]) {
					[db executeUpdate:@"DELETE FROM eProposal_Trustee_Details WHERE eProposalNo = ?", ProposalNo_to_delete];
					NSLog(@"Delete Trustee, non-trust");
					ClearData *ClData =[[ClearData alloc]init];
					[ClData deleteOldPdfs:ProposalNo_to_delete];
				}
			}
		}
	}
	
	
	
	//### ANY EDIT ON PROFILE DELETE PDF
	for (i = 0; i < countP; i++) {
		ProposalNo_to_delete = [ProposalCount objectAtIndex: i];
		ClearData *ClData =[[ClearData alloc]init];
		[ClData deleteOldPdfs:ProposalNo_to_delete];
	}
	
    //******** END ************  DELETE CLIENT OF LA1, LA2, PO IN EAPP for CONFIRMED CASE END HERE  *******************************
	
    
    
    
    //*** Update in CFF ***** ##Added by Emi
	
	
	//Get proposal No
	
	NSString *proposal = @"";
	//NSLog(@"PP: %@", pp.ProspectID);
	result = [db executeQuery:@"SELECT ProposalNo from eApp_Listing where ClientProfileID = ? AND status in (2,3)", pp.ProspectID];
	NSInteger *proposalNoCount = 0;
	while ([result next]) {
		proposalNoCount = proposalNoCount + 1;
		proposal = [result objectForColumnName:@"ProposalNo"];
		
		
		
		//	FMResultSet *result2;
		//	NSString *query2 = [NSString stringWithFormat:@"SELECT COUNT(*) FROM eProposal_LA_Details WHERE ProspectProfileID = '%@' and POFlag = 'Y' and eProposalNo = '%@'", pp.ProspectID, proposal];
		//    result2 = [db executeQuery:query2];
		//
		//	NSLog(@"QQQQQQ %@", query2);
		//
		//	int countPO = 0;
		//	while ([result2 next]) {
		//
		//		countPO = [result2 intForColumn:@"COUNT(*)"];
		//	}
		
		//	NSLog(@"%d", countPO);
		NSString *update_query;
		if (proposalNoCount > 0) {
			NSLog(@"Proposal %@", proposal);
			
			
			update_query = [NSString stringWithFormat:@"Update eApp_Listing SET \"POName\" = \"%@\" WHERE  ClientProfileID = \"%@\" and status in (2,3);",
							txtrFullName.text,
							pp.ProspectID];
			[db executeUpdate:update_query];
			
			[result close];
			
			
			NSString *CFFID = @"";
			//NSLog(@"PP: %@", pp.ProspectID);
			result = [db executeQuery:@"SELECT ID from CFF_Master where ClientProfileID = ? and CFFType = 'Master'", pp.ProspectID];
			int count = 0;
			while ([result next]) {
				count = count + 1;
				CFFID = [result objectForColumnName:@"ID"];
			}
			
			if (count > 0) {
				
				update_query = @"";
				update_query = [NSString stringWithFormat:@"Update CFF_Personal_Details SET \"Name\" = \"%@\", \"Sex\" = \"%@\", \"DOB\" = \"%@\", \"NewICNO\" = \"%@\", \"OtherIDType\" = \"%@\", \"OtherID\" = \"%@\", \"MaritalStatus\" = \"%@\", \"Race\" = \"%@\", \"Religion\" = \"%@\", \"Nationality\" = \"%@\", \"OccupationCode\" = \"%@\", \"MailingAddress1\" = \"%@\", \"MailingAddress2\" = \"%@\", \"MailingAddress3\" = \"%@\", \"MailingTown\" = \"%@\", \"MailingState\" = \"%@\", \"MailingPostCode\" = \"%@\", \"MailingCountry\" = \"%@\", \"ResidencePhoneNo\" = \"%@\", \"MobilePhoneNo\" = \"%@\",\"OfficePhoneNo\" = \"%@\", \"FaxPhoneNo\" = \"%@\",  \"EmailAddress\" = \"%@\", \"Smoker\" = \"%@\", \"ResidencePhoneNoExt\" = \"%@\", \"MobilePhoneNoExt\" = \"%@\", \"OfficePhoneNoExt\" = \"%@\", \"FaxPhoneNoExt\" = \"%@\" WHERE  CFFID = \"%@\";",
								
								txtrFullName.text,
								gender,
								strDOB,
								txtIDType.text,
								IDTypeCodeSelected,
								txtOtherIDType.text,
								
								marital,
								race,
								religion,
								nation,
								OccupCodeSelected,
								
								txtHomeAddr1.text,
								txtHomeAddr2.text,
								txtHomeAddr3.text,
								
								txtHomeTown.text,
								SelectedStateCode,
								txtHomePostCode.text,
								HomeCountry,
								
								txtContact1.text,
								txtContact2.text,
								txtContact3.text,
								txtContact4.text,
								txtEmail.text,
								ClientSmoker,
								txtPrefix1.text,
								txtPrefix2.text,
								txtPrefix3.text,
								txtPrefix4.text,
								CFFID];
				
				[db executeUpdate:update_query];
			}
		}
		
	}
	//****Update CFF end Here ********
	
	//**** Update eProposal start here *********
	
	NSString *CFFID = @"";
	//NSLog(@"PP: %@", pp.ProspectID);
	
	
	
	result = [db executeQuery:@"SELECT ID from eProposal_CFF_Master where ClientProfileID = ? and CFFType = 'Master'", pp.ProspectID];
	int count = 0;
	while ([result next]) {
		count = count + 1;
		CFFID = [result objectForColumnName:@"ID"];
	}
	
	NSString *ProposalToUpdate;
	for (i = 0; i < countP; i++) {
		NSLog (@"PropsalNOtoUpdate %i = %@", i, [ProposalCount objectAtIndex: i]);
		ProposalToUpdate = [ProposalCount objectAtIndex: i];
		
		
		
		if (count > 0) {
			
			
			NSString *update_query  = [NSString stringWithFormat:@"Update eProposal_CFF_Personal_Details SET \"Name\" = \"%@\", \"Sex\" = \"%@\", \"DOB\" = \"%@\", \"NewICNO\" = \"%@\", \"OtherIDType\" = \"%@\", \"OtherID\" = \"%@\", \"MaritalStatus\" = \"%@\", \"Race\" = \"%@\", \"Religion\" = \"%@\", \"Nationality\" = \"%@\", \"OccupationCode\" = \"%@\", \"MailingAddress1\" = \"%@\", \"MailingAddress2\" = \"%@\", \"MailingAddress3\" = \"%@\", \"MailingTown\" = \"%@\", \"MailingState\" = \"%@\", \"MailingPostCode\" = \"%@\", \"MailingCountry\" = \"%@\", \"ResidencePhoneNo\" = \"%@\", \"MobilePhoneNo\" = \"%@\",\"OfficePhoneNo\" = \"%@\", \"FaxPhoneNo\" = \"%@\",  \"EmailAddress\" = \"%@\", \"Smoker\" = \"%@\", \"ResidencePhoneNoExt\" = \"%@\", \"MobilePhoneNoExt\" = \"%@\", \"OfficePhoneNoExt\" = \"%@\", \"FaxPhoneNoExt\" = \"%@\" WHERE  CFFID = \"%@\" AND eProposalNo = \"%@\" ;",
									   
									   txtrFullName.text,
									   gender,
									   strDOB,
									   txtIDType.text,
									   IDTypeCodeSelected,
									   txtOtherIDType.text,
									   
									   marital,
									   race,
									   religion,
									   nation,
									   OccupCodeSelected,
									   
									   txtHomeAddr1.text,
									   txtHomeAddr2.text,
									   txtHomeAddr3.text,
									   
									   txtHomeTown.text,
									   SelectedStateCode,
									   txtHomePostCode.text,
									   HomeCountry,
									   
									   txtContact1.text,
									   txtContact2.text,
									   txtContact3.text,
									   txtContact4.text,
									   txtEmail.text,
									   ClientSmoker,
									   txtPrefix1.text,
									   txtPrefix2.text,
									   txtPrefix3.text,
									   txtPrefix4.text,
									   CFFID,
									   ProposalToUpdate];
			
			[db executeUpdate:update_query];
		}
		
		
		// ***** Update Proposal end here *********
		//Update address in nominee (If Nominee address set same as PO)
		
		if (proposalNoCount > 0) {
			NSString *update_query  = [NSString stringWithFormat:@"Update eProposal_NM_Details SET \"NMCRAddress1\" = \"%@\", \"NMCRAddress2\" = \"%@\", \"NMCRAddress3\" = \"%@\", \"NMCRTown\" = \"%@\", \"NMCRState\" = \"%@\", \"NMCRPostCode\" = \"%@\", \"NMCRCountry\" = \"%@\" WHERE  eProposalNo = \"%@\" and NMSamePOAddress = 'same';",
									   
									   txtHomeAddr1.text,
									   txtHomeAddr2.text,
									   txtHomeAddr3.text,
									   
									   txtHomeTown.text,
									   SelectedStateCode,
									   txtHomePostCode.text,
									   HomeCountry,
									   ProposalToUpdate];
			
			[db executeUpdate:update_query];
			
			
			//Update trustee address if set as same as PO
			
			//CREATE TABLE "eProposal_Trustee_Details""TrusteeTitle" TEXT,"TrusteeName" TEXT,"" TEXT,"TrusteeNewICNo" TEXT,"TrusteeDOB" TEXT,"TrusteeOtherIDType" TEXT,"TrusteeOtherID" TEXT,"TrusteeRelationship" TEXT,"TrusteeAddress1" TEXT,"TrusteeAddress2" TEXT,"TrusteeAddress3" TEXT,"TrusteePostcode" TEXT,"TrusteeState" TEXT,"TrusteeTown" TEXT,"TrusteeCountry" TEXT,"CreatedAt" TEXT,"UpdatedAt" TEXT,"TrusteeSameAsPO" TEXT, isForeignAddress TEXT)
			update_query = @"";
			update_query  = [NSString stringWithFormat:@"Update eProposal_Trustee_Details SET \"TrusteeAddress1\" = \"%@\", \"TrusteeAddress2\" = \"%@\", \"TrusteeAddress3\" = \"%@\", \"TrusteeTown\" = \"%@\", \"TrusteeState\" = \"%@\", \"TrusteePostcode\" = \"%@\", \"TrusteeCountry\" = \"%@\" WHERE  eProposalNo = \"%@\" and TrusteeSameAsPO = 'Y';",
							 
							 txtHomeAddr1.text,
							 txtHomeAddr2.text,
							 txtHomeAddr3.text,
							 
							 txtHomeTown.text,
							 SelectedStateCode,
							 txtHomePostCode.text,
							 HomeCountry,
							 ProposalToUpdate];
			
			[db executeUpdate:update_query];
			//for credit card name update
			update_query = @"";
			update_query  = [NSString stringWithFormat:@"Update eProposal SET \"CardMemberName\" = \"%@\" WHERE  eProposalNo = \"%@\" and (CardMemberNewICNo = \"%@\" or CardMemberOtherID = \"%@\");",
							 
							 txtrFullName.text,
							 
							 
							 ProposalToUpdate,IDTypeNo,OtherIDTypeNo];
			
			[db executeUpdate:update_query];
			
			update_query = @"";
			update_query  = [NSString stringWithFormat:@"Update eProposal SET \"FTCardMemberName\" = \"%@\" WHERE  eProposalNo = \"%@\" and (FTCardMemberNewICNo = \"%@\" or FTCardMemberOtherID = \"%@\");",
							 
							 txtrFullName.text,
							 
							 
							 ProposalToUpdate,IDTypeNo,OtherIDTypeNo];
			
			[db executeUpdate:update_query];
			
		}
	}
    
    
	//    NSString *CardMemberName = @"";
	//    result = [db executeQuery:@"SELECT CardMemberName from eProposal where CardMemberNewICNo = ? and status in (2,3)",pp.ProspectID];
	//    int countforName = 0;
	//	while ([result next]) {
	//		countforName = countforName + 1;
	//		CardMemberName = [result objectForColumnName:@"CardMemberName"];
	//	}
	//    if (countforName > 0) {
	//        NSString *update_query = @"";
	//		update_query  = [NSString stringWithFormat:@"Update eProposal SET \"CardMemberName\" = \"%@\" ;",
	//
	//                         txtrFullName.text];
	//
	//		[db executeUpdate:update_query];
	//
	//    }
    
    
    
    [db close];
    NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	
	
	if (![[ClientProfile objectForKey:@"TabBar"] isEqualToString:@"YES"]) {
		UIAlertView *SuccessAlert = [[UIAlertView alloc] initWithTitle:@" "
															   message:@"Changes have been updated successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		
		
		SuccessAlert.tag = 9001;
		[SuccessAlert show];
	}
	
	[ClientProfile setObject:@"Save Succeed" forKey:@"Message"];
	[ClientProfile setObject:@"NO" forKey:@"isEdited"];
	[ClientProfile setObject:@"NO" forKey:@"NeedToSave"];
	[ClientProfile setObject:@"NO" forKey:@"HasChanged"];
	
}

-(BOOL) validateTrust:(NSString *)ProposalNo :(NSString *)PO_MAritalStatus database:(FMDatabase *)db {
	
	NSArray *childrens = [[NSArray alloc] initWithObjects:@"DAUGHTER", @"SON",nil];
    NSArray *parents = [[NSArray alloc] initWithObjects:@"FATHER", @"MOTHER",nil];
    NSArray *childrensNSpouse = [[NSArray alloc] initWithObjects:@"HUSBAND", @"WIFE", @"DAUGHTER", @"SON", nil];
    NSArray *Mstatus = [[NSArray alloc] initWithObjects:@"DIVORCED", @"WIDOW", @"WIDOWER",nil];
	
	if ([db close])
		[db open];
	
	NSString *relationship1 = @"";
    NSString *relationship2 = @"";
    NSString *relationship3 = @"";
    NSString *relationship4 = @"";
	
	//GET Nominee Relationship
	int count = 0;
	FMResultSet *resultsStatus = [db executeQuery:@"select NMRelationship from eProposal_NM_Details where eProposalNo = ?", ProposalNo, Nil];
	
    while ([resultsStatus next]) {
        count = count + 1;
		if (count == 1)
			relationship1 = [resultsStatus stringForColumn:@"NMRelationship"];
		else if (count == 2)
			relationship2 = [resultsStatus stringForColumn:@"NMRelationship"];
		else if (count == 3)
			relationship3 = [resultsStatus stringForColumn:@"NMRelationship"];
		else if (count == 4)
			relationship4 = [resultsStatus stringForColumn:@"NMRelationship"];
    }
	
	PO_MAritalStatus = [textFields trimWhiteSpaces:PO_MAritalStatus];
	pp.MaritalStatus = [textFields trimWhiteSpaces:pp.MaritalStatus];
    if ([Mstatus containsObject:PO_MAritalStatus] || [Mstatus containsObject:pp.MaritalStatus]) {
        //if marital status before/after: divorce, widow, widower
		
		//clear value in Policy Owner
		[self Clear_EAppPolicyOwner:ProposalNo database:db];
		
		//Delete CFF
		[self DeleteEAppCFF:ProposalNo database:db];
		
		//Clear Proposal
		[self Clear_EAppProposal_Value:ProposalNo database:db];
		
		//Clear PDF
		ClearData *ClData =[[ClearData alloc]init];
		[ClData deleteOldPdfs:ProposalNo];
		//Clear eSign
		
		//delete eSignature
		if (![db executeUpdate:@"Delete from eProposal_Signature where eProposalNo = ?", ProposalNo, nil]) {
			NSLog(@"Error in Delete Statement - eProposal_Signature");
		}
		
    }
    else if ([PO_MAritalStatus isEqualToString:@"SINGLE"]) {
        if (relationship1) {
            if ([parents containsObject:relationship1]) {
                return TRUE;
            }
			if ([childrens containsObject:relationship1]) {
				return TRUE;
			}
        }
        if (relationship2) {
            if ([parents containsObject:relationship2]) {
                return TRUE;
            }
			if ([childrens containsObject:relationship2]) {
				return TRUE;
			}
        }
        if (relationship3) {
            if ([parents containsObject:relationship3]) {
                return TRUE;
            }
			if ([childrens containsObject:relationship3]) {
				return TRUE;
			}
        }
        if (relationship4) {
            if ([parents containsObject:relationship4]) {
                return TRUE;
            }
			if ([childrens containsObject:relationship4]) {
				return TRUE;
			}
        }
        return FALSE;
	}
    else if ([PO_MAritalStatus isEqualToString:@"MARRIED"]) {
        if (relationship1) {
            if ([childrensNSpouse containsObject:relationship1]) {
                return TRUE;
            }
        }
        if (relationship2) {
            if ([childrensNSpouse containsObject:relationship2]) {
                return TRUE;
            }
        }
        if (relationship3) {
            if ([childrensNSpouse containsObject:relationship3]) {
                return TRUE;
            }
        }
        if (relationship4) {
            if ([childrensNSpouse containsObject:relationship4]) {
                return TRUE;
            }
        }
        return FALSE;
    }
    return FALSE;
	
	
}

-(void)Clear_EAppPolicyOwner:(NSString *)proposal database:(FMDatabase *)db {
	
	//eApp_Listing
	NSString *query = @"";
	query = [NSString stringWithFormat:@"UPDATE eApp_Listing SET POName = '', IDNumber = '', OtherIDNo = '' WHERE ProposalNo = '%@'", proposal, nil];
	[db executeUpdate:query];
	
	
	//eProposal_LA_Details
	query = @"";
	query = [NSString stringWithFormat:@"UPDATE eProposal_LA_Details SET LAEmployerName = '', LARelationship = '', CorrespondenceAddress = '', HaveChildren = '', LACompleteFlag = '' WHERE eProposalNo = '%@'", proposal, nil];
	[db executeUpdate:query];
	
}

-(void)Clear_EAppProposal_Value:(NSString *)proposal database:(FMDatabase *)db {
	
	
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

-(void)DeleteEAppCFF:(NSString *)proposal database:(FMDatabase *)db {
    
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


-(void) DeleteGroup2 {
	
	DelGroupArr = [NSMutableArray array];
	
	ProsGroupArr = [UDGroup objectForKey:@"groupArr"];
	NSString *Gname = @"";
	NSString *groupID;
	int count;
	BOOL alertC = NO;
	
	if (ProsGroupArr.count != 0) {
		for (int b=0; b <= ProsGroupArr.count-1; b++) {
			groupID = [[ProsGroupArr objectAtIndex:b] objectForKey:@"id"];
			count = [self calculateGroup:groupID];
			
			if (count == 1) {
				alertC = YES;
				
				NSDictionary *tempData = [[NSDictionary alloc] initWithObjectsAndKeys:[[ProsGroupArr objectAtIndex:b] objectForKey:@"id"], @"id", [[ProsGroupArr objectAtIndex:b] objectForKey:@"name"], @"name", nil];
				[DelGroupArr addObject:[tempData copy]];
				
				if ([Gname isEqualToString:@""]) {
					Gname = [[ProsGroupArr objectAtIndex:b] objectForKey:@"name"];
				}
				else {
					Gname = [NSString stringWithFormat:@"%@, %@", Gname, [[ProsGroupArr objectAtIndex:b] objectForKey:@"name"]];
				}
			}
		}
	}
	if (alertC) {
		NSString *GroupAlert=[NSString stringWithFormat:@"Group %@ will be auto deleted by system as no member attached to this group.",Gname];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:GroupAlert delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
		[alert setTag:1113];
		[alert show];
	}
}

- (int) calculateGroup:(NSString*)groupID {
	
	FMDatabase *db;
	
	int countGroup;
	if (!db) {
		NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *docsDir = [dirPaths objectAtIndex:0];
		NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
		db = [FMDatabase databaseWithPath:dbPath];
	}
	 if ([db close]) {
		 [db open];
	 }

	FMResultSet *result2;
	
	NSString *queryStr = [NSString stringWithFormat:@"select count(*) as count from prospect_profile where (ProspectGroup = %@ OR ProspectGroup LIKE '%%,%@' OR ProspectGroup LIKE '%@,%%' OR ProspectGroup LIKE '%%,%@,%%')", groupID, groupID, groupID, groupID];
	result2 = [db executeQuery:queryStr];
	
	while ([result2 next]) {
		countGroup = [[result2 objectForColumnName:@"count"] integerValue];
	}
	
	return countGroup;
}

-(void) DeleteGroup {
	
	FMDatabase *db;
	
	NSMutableArray *DelGroup = [NSMutableArray array];
	
	NSMutableArray *tempArr = [UDGroup objectForKey:@"DelGroupArr"];
	DelGroup = [tempArr mutableCopy];
	
	if (!db) {
		NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *docsDir = [dirPaths objectAtIndex:0];
		NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
		db = [FMDatabase databaseWithPath:dbPath];
	}
	if ([db close]) {
		[db open];
	}
	
	if (DelGroup.count != 0) {
		for (int b=0; b <= DelGroup.count-1; b++) {
			[db executeUpdate:@"delete from prospect_groups where name = ? and id = ?", [[DelGroup objectAtIndex:b] objectForKey:@"name"], [[DelGroup objectAtIndex:b] objectForKey:@"id"], nil];
		}
	}
	
}



-(void) ProspectGroup_toArray: (NSString *) prosGroup {
	
	NSString *groupStr;
	ProsGroupArr = [NSMutableArray array];
	[ProsGroupArr removeAllObjects];
	
	if (![prosGroup isEqualToString:@""]){
		
		NSLog(@"bfore: prosGroup %@", prosGroup);
		int noI = [[prosGroup componentsSeparatedByString:@","] count] - 1;
		for (int a=0; a <= noI; a++) {
			groupStr = [[prosGroup componentsSeparatedByString:@","] objectAtIndex:a];
			groupStr = [groupStr stringByReplacingOccurrencesOfString:@"," withString:@""];
			
			[ProsGroupArr addObject:groupStr];
		}
	}
	
	else
		prosGroup = @"";
	
}

-(NSString *) Group_toStr {
	
	
	ProsGroupArr = [UDGroup objectForKey:@"groupArr"];
	
	
	NSString * prosGroup2 = @"";
	NSString *GroupID = @"";
	if (ProsGroupArr.count != 0) {
		for (int b=0; b <= ProsGroupArr.count-1; b++) {
			
			NSLog(@"b: %d, ID: %@, group name: %@", b, [[ProsGroupArr objectAtIndex:b] objectForKey:@"id"], [[ProsGroupArr objectAtIndex:b] objectForKey:@"name"]);
			
			if (b==0) {
//				if ([[[ProsGroupArr objectAtIndex:b] objectForKey:@"id"] isEqualToString:@"00"]) {
//					GroupID = [self SaveToGroup:[[ProsGroupArr objectAtIndex:b] objectForKey:@"name"]];
//				}
//				else
					GroupID = [[ProsGroupArr objectAtIndex:b] objectForKey:@"id"];
				
				prosGroup2 = [NSString stringWithFormat:@"%@", GroupID];
			}
			else {
				
//				if ([[[ProsGroupArr objectAtIndex:b] objectForKey:@"id"] isEqualToString:@"00"]) {
//					GroupID = [self SaveToGroup:[[ProsGroupArr objectAtIndex:b] objectForKey:@"name"]];
//				}
//				else
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

-(NSString *) ProspectGroup_toString {
	
	
	ProsGroupArr = [UDGroup objectForKey:@"groupArr"];
	
	
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

-(BOOL) record_exist
{
    NSString *si_name;
    NSString *eapp_name;
    NSString *eapp_family_name;
    NSString *eapp_spouse_name;
    NSString *cff_id;
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT Name from Clt_Profile WHERE indexNo = ?", pp.ProspectID];
    while ([result next]) {
		si_name =  [result objectForColumnName:@"Name"];
    }
    
    // check if Client exist in eAPP
    FMResultSet *result2 = [db executeQuery:@"SELECT POName from eApp_Listing WHERE ClientProfileID = ?", pp.ProspectID];
    while ([result2 next]) {
		eapp_name =  [result2 objectForColumnName:@"POName"];
    }
    
    FMResultSet *result3 = [db executeQuery:@"SELECT ID from CFF_Master WHERE ClientProfileID = ?", pp.ProspectID];
    while ([result3 next]) {
        cff_id =  [result3 objectForColumnName:@"ID"];
        NSLog(@"cff - %@", cff_id);
    }
	
    // check if Client exist in eApp - CFF Family
    FMResultSet *result4 = [db executeQuery:@"SELECT Name from eProposal_CFF_Family_Details WHERE ClientProfileID = ?", pp.ProspectID];
    while ([result4 next]) {
        eapp_family_name =  [result4 objectForColumnName:@"Name"];
    }
	
    // check if Client exist in eApp - CFF Spouse
    FMResultSet *result5 = [db executeQuery:@"SELECT Name from eProposal_CFF_Family_Details WHERE ClientProfileID = ?", pp.ProspectID];
    while ([result5 next]) {
        eapp_spouse_name =  [result5 objectForColumnName:@"Name"];
    }
    
    
    [result close];
    [result2 close];
    [result3 close];
    [result4 close];
    [db close];
    
    
    if(si_name==nil && eapp_name ==nil && eapp_family_name ==nil && cff_id==nil )
        return false;
    else
        return  true;
	
}

-(BOOL) confirm_case
{
    NSString *confirm_case;
    NSString *eProposalNo;
    NSString *test_name;
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    
    
	
    // Check Policy Owner, LA1, LA2 - Confirmed Case
    FMResultSet *result_checkLA = [db executeQuery:@"SELECT * from eProposal_LA_Details WHERE ProspectProfileID = ?", pp.ProspectID];
    while ([result_checkLA next]) {
        
        eProposalNo =  [result_checkLA objectForColumnName:@"eProposalNo"];
        
        FMResultSet *result_check_proposal = [db executeQuery:@"SELECT * from eApp_Listing WHERE ProposalNo = ? AND Status = ?", eProposalNo,@"3"];
        
        while ([result_check_proposal next]) {
            
            confirm_case =  [result_checkLA objectForColumnName:@"Name"];
            
        }
        
    }
    
    
    // Check Policy Owner Family  - Confirmed Case
    FMResultSet *result_checkFamily = [db executeQuery:@"SELECT * from eProposal_CFF_Family_Details WHERE ClientProfileID = ?", pp.ProspectID];
    while ([result_checkFamily next]) {
        
		eProposalNo =  [result_checkFamily objectForColumnName:@"eProposalNo"];
        
		FMResultSet *result_check_proposal = [db executeQuery:@"SELECT * from eApp_Listing WHERE ProposalNo = ? AND Status = ?", eProposalNo,@"3"];
        
        while ([result_check_proposal next]) {
            
            confirm_case =  [result_checkFamily objectForColumnName:@"Name"];
            
        }
		
    }
    
    
    
    // Check Policy Spouse  - Confirmed Case
    FMResultSet *result_checkSpouse = [db executeQuery:@"SELECT * from eProposal_CFF_Personal_Details WHERE NewICNo = ? AND (OtherIDType = ? AND OtherID = ?)", pp.IDTypeNo,pp.OtherIDType,pp.OtherIDTypeNo];
    while ([result_checkSpouse next]) {
        
		eProposalNo =  [result_checkSpouse objectForColumnName:@"eProposalNo"];
		test_name =  [result_checkSpouse objectForColumnName:@"Name"];
        
		FMResultSet *result_check_proposal = [db executeQuery:@"SELECT * from eApp_Listing WHERE ProposalNo = ? AND Status = ?", eProposalNo,@"3"];
        
        while ([result_check_proposal next]) {
            NSLog(@"proposalNo: %@, testname: %@", eProposalNo, test_name);
            confirm_case =  [result_checkSpouse objectForColumnName:@"Name"];
        }
    }
    
    
    [result_checkLA close];
    [result_checkFamily close];
    [result_checkSpouse close];
    
    [db close];
    
    
    if(confirm_case==nil)
        return false;
    else
        return  true;
}

-(BOOL) failed_case
{
    NSString *failed_case;
    NSString *eProposalNo;
    NSString *test_name;
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    
    
	
    // Check Policy Owner, LA1, LA2 - Failed Case
    FMResultSet *result_checkLA_failed = [db executeQuery:@"SELECT * from eProposal_LA_Details WHERE ProspectProfileID = ?", pp.ProspectID];
    while ([result_checkLA_failed next]) {
        
        eProposalNo =  [result_checkLA_failed objectForColumnName:@"eProposalNo"];
        
        FMResultSet *result_check_proposal_failed = [db executeQuery:@"SELECT * from eApp_Listing WHERE ProposalNo = ? AND Status = ?", eProposalNo,@"6"];
        
        while ([result_check_proposal_failed next]) {
            
            failed_case =  [result_checkLA_failed objectForColumnName:@"Name"];
            
        }
        
    }
    
    
    // Check Policy Owner Family  - Failed Case
    FMResultSet *result_checkFamily_failed = [db executeQuery:@"SELECT * from eProposal_CFF_Family_Details WHERE ClientProfileID = ?", pp.ProspectID];
    while ([result_checkFamily_failed next]) {
        
        eProposalNo =  [result_checkFamily_failed objectForColumnName:@"eProposalNo"];
        
        FMResultSet *result_check_proposal_failed = [db executeQuery:@"SELECT * from eApp_Listing WHERE ProposalNo = ? AND Status = ?", eProposalNo,@"6"];
        
        while ([result_check_proposal_failed next]) {
            
            failed_case =  [result_checkFamily_failed objectForColumnName:@"Name"];
            
        }
        
    }
    
    // Check Policy Spouse  - Failed Case
    FMResultSet *result_checkSpouse_failed = [db executeQuery:@"SELECT * from eProposal_CFF_Personal_Details WHERE NewICNo = ? AND (OtherIDType = ? AND OtherID = ?)", pp.IDTypeNo,pp.OtherIDType,pp.OtherIDTypeNo];
    while ([result_checkSpouse_failed next]) {
        
        eProposalNo =  [result_checkSpouse_failed objectForColumnName:@"eProposalNo"];
        test_name =  [result_checkSpouse_failed objectForColumnName:@"Name"];
        
        FMResultSet *result_check_proposal_failed = [db executeQuery:@"SELECT * from eApp_Listing WHERE ProposalNo = ? AND Status = ?", eProposalNo,@"6"];
        
        while ([result_check_proposal_failed next]) {
            NSLog(@"proposalNo: %@, testname: %@", eProposalNo, test_name);
            failed_case =  [result_check_proposal_failed objectForColumnName:@"Name"];
        }
    }
    
    
    [result_checkLA_failed close];
    [result_checkFamily_failed close];
    [result_checkSpouse_failed close];
    
    [db close];
    
    
    if(failed_case==nil)
        return false;
    else
        return  true;
}

-(BOOL) received_case
{
    NSString *received_case;
    NSString *eProposalNo;
    NSString *test_name;
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    
    
    
    // Check Policy Owner, LA1, LA2 - Received Case
    FMResultSet *result_checkLA_received = [db executeQuery:@"SELECT * from eProposal_LA_Details WHERE ProspectProfileID = ?", pp.ProspectID];
    while ([result_checkLA_received next]) {
        
        eProposalNo =  [result_checkLA_received objectForColumnName:@"eProposalNo"];
        
        FMResultSet *result_check_proposal_received = [db executeQuery:@"SELECT * from eApp_Listing WHERE ProposalNo = ? AND Status = ?", eProposalNo,@"7"];
        
        while ([result_check_proposal_received next]) {
            
            received_case =  [result_checkLA_received objectForColumnName:@"Name"];
            
        }
        
    }
    
    
    // Check Policy Owner Family  - Received Case
    FMResultSet *result_checkFamily_received = [db executeQuery:@"SELECT * from eProposal_CFF_Family_Details WHERE ClientProfileID = ?", pp.ProspectID];
    while ([result_checkFamily_received next]) {
        
        eProposalNo =  [result_checkFamily_received objectForColumnName:@"eProposalNo"];
        
        FMResultSet *result_check_proposal_received = [db executeQuery:@"SELECT * from eApp_Listing WHERE ProposalNo = ? AND Status = ?", eProposalNo,@"7"];
        
        while ([result_check_proposal_received next]) {
            
            received_case =  [result_checkFamily_received objectForColumnName:@"Name"];
            
        }
        
    }
    
    
    // Check Policy Spouse  - Received Case
    FMResultSet *result_checkSpouse_received = [db executeQuery:@"SELECT * from eProposal_CFF_Personal_Details WHERE NewICNo = ? AND (OtherIDType = ? AND OtherID = ?)", pp.IDTypeNo,pp.OtherIDType,pp.OtherIDTypeNo];
    while ([result_checkSpouse_received next]) {
        
        eProposalNo =  [result_checkSpouse_received objectForColumnName:@"eProposalNo"];
        test_name =  [result_checkSpouse_received objectForColumnName:@"Name"];
        
        FMResultSet *result_check_proposal_received = [db executeQuery:@"SELECT * from eApp_Listing WHERE ProposalNo = ? AND Status = ?", eProposalNo,@"7"];
        
        while ([result_check_proposal_received next]) {
            NSLog(@"proposalNo: %@, testname: %@", eProposalNo, test_name);
            received_case =  [result_check_proposal_received objectForColumnName:@"Name"];
        }
    }
    
    [result_checkLA_received close];
    [result_checkFamily_received close];
    [result_checkSpouse_received close];
    
    [db close];
    
    
    if(received_case==nil)
        return false;
    else
        return  true;
}

-(BOOL) submitted_case
{
    NSString *submitted_case;
    NSString *eProposalNo;
    NSString *test_name;
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    
    
    
    // Check Policy Owner, LA1, LA2 - Submitted Case
    FMResultSet *result_checkLA_submitted = [db executeQuery:@"SELECT * from eProposal_LA_Details WHERE ProspectProfileID = ?", pp.ProspectID];
    while ([result_checkLA_submitted next]) {
        
        eProposalNo =  [result_checkLA_submitted objectForColumnName:@"eProposalNo"];
        
        FMResultSet *result_check_proposal_submitted = [db executeQuery:@"SELECT * from eApp_Listing WHERE ProposalNo = ? AND Status = ?", eProposalNo,@"4"];
        
        while ([result_check_proposal_submitted next]) {
            
            submitted_case =  [result_checkLA_submitted objectForColumnName:@"Name"];
            
        }
        
    }
    
    
    // Check Policy Owner Family  - Submitted Case
    FMResultSet *result_checkFamily_submitted = [db executeQuery:@"SELECT * from eProposal_CFF_Family_Details WHERE ClientProfileID = ?", pp.ProspectID];
    while ([result_checkFamily_submitted next]) {
        
        eProposalNo =  [result_checkFamily_submitted objectForColumnName:@"eProposalNo"];
        
        FMResultSet *result_check_proposal_submitted = [db executeQuery:@"SELECT * from eApp_Listing WHERE ProposalNo = ? AND Status = ?", eProposalNo,@"4"];
        
        while ([result_check_proposal_submitted next]) {
            
            submitted_case =  [result_checkFamily_submitted objectForColumnName:@"Name"];
            
        }
        
    }
    
    
    // Check Policy Spouse  - Submitted Case
    FMResultSet *result_checkSpouse_submitted = [db executeQuery:@"SELECT * from eProposal_CFF_Personal_Details WHERE NewICNo = ? AND (OtherIDType = ? AND OtherID = ?)", pp.IDTypeNo,pp.OtherIDType,pp.OtherIDTypeNo];
    while ([result_checkSpouse_submitted next]) {
        
        eProposalNo =  [result_checkSpouse_submitted objectForColumnName:@"eProposalNo"];
        test_name =  [result_checkSpouse_submitted objectForColumnName:@"Name"];
        
        FMResultSet *result_check_proposal_submitted = [db executeQuery:@"SELECT * from eApp_Listing WHERE ProposalNo = ? AND Status = ?", eProposalNo,@"4"];
        
        while ([result_check_proposal_submitted next]) {
            NSLog(@"proposalNo: %@, testname: %@", eProposalNo, test_name);
            submitted_case =  [result_check_proposal_submitted objectForColumnName:@"Name"];
        }
    }
    
    [result_checkLA_submitted close];
    [result_checkFamily_submitted close];
    [result_checkSpouse_submitted close];
    
    [db close];
    
    
    if(submitted_case==nil)
        return false;
    else
        return  true;
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

-(NSString*) getIDTypeDesc : (NSString*)IDtype
{
    NSString *desc = @"";
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
    NSString *code = @"";
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
    return desc;
}

-(void) getTitleCode : (NSString*)Title
{
    NSString *code = @"";
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

-(void)SaveChanges
{
    
	clickDone = 1;
	bool exist =  [self record_exist];
	bool confirmCase =  [self confirm_case];
	bool failedCase =  [self failed_case];
	bool receivedCase =  [self received_case];
	bool submittedCase =  [self submitted_case];
	
    NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"" forKey:@"Message"];
	
	
	NSString *OldOcc = pp.ProspectOccupationCode;
	NSString *OldSmoker = pp.Smoker;
	
	
    if ([self Validation] == TRUE) {
        NSString *PO_Sign;
        NSString *eProposalNo;
		FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
        [db open];
		FMResultSet *result_checkLA = [db executeQuery:@"SELECT * from eProposal_LA_Details WHERE ProspectProfileID = ?", pp.ProspectID];
		while ([result_checkLA next]) {
            
            eProposalNo =  [result_checkLA objectForColumnName:@"eProposalNo"];
			
            
            
            FMResultSet *result_eSign = [db executeQuery:@"SELECT * from eProposal_Signature WHERE eProposalNo = ? ",eProposalNo];
            
            while ([result_eSign next]) {
                PO_Sign = [result_eSign objectForColumnName:@"isPOSign"];
                if  ((NSNull *) PO_Sign == [NSNull null])
                    PO_Sign = @"";
                if ([PO_Sign isEqualToString:@"YES"]) {
                    PolicyOwnerSigned=FALSE;
                }
				
            }
		}
        
        
        if(exist)
        {
			if (![OldSmoker isEqualToString:ClientSmoker] || (!([OldOcc isEqualToString:OccupCodeSelected]) && !([OccupCodeSelected isEqualToString:@""]))){
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There are pending eApp cases for this client. Should you wish to proceed, system will auto delete all the related pending eApp cases and you are required to recreate the necessary should you wish to resubmit the case." delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
				[alert setTag:1004];
                [alert show];
			}
            
			//            else if(confirmCase || [PO_Sign isEqualToString:@"YES"])
            else if(confirmCase)
            {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There are pending eApp cases for this client. Should you wish to proceed, system will auto delete all the related Confirmed eApp cases and you are required to recreate the necessary should you wish to resubmit the case." delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];[alert setTag:1004];
                [alert show];
            }
            else if([PO_Sign isEqualToString:@"YES"])
            {
                if (failedCase || receivedCase || submittedCase)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"All changes will be updated to related SI, CFF and eApp. Do you want to proceed?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
                    [alert setTag:1004];
                    [alert show];
                    
                }
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There are pending eApp cases for this client. Should you wish to proceed, system will auto delete all the related Confirmed eApp cases and you are required to recreate the necessary should you wish to resubmit the case." delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];[alert setTag:1004];
                    [alert show];
					
                }
				
            }
			//            else if([PO_Sign isEqualToString:@"YES"] && (!receivedCase))
			//            {
			//				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There are pending eApp cases for this client. Should you wish to proceed, system will auto delete all the related Confirmed eApp cases and you are required to recreate the necessary should you wish to resubmit the case." delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];[alert setTag:1004];
			//                [alert show];
			//            }
            
            else
            {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"All changes will be updated to related SI, CFF and eApp. Do you want to proceed?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
				[alert setTag:1004];
				[alert show];
            }
            
        }
        else{
			
            [self saveToDB];
			
			
		}
    }
    
}



-(void)SaveEdit2 {
	
    NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	//[ClientProfile setObject:@"" forKey:@"Message"];
	
	NSString *exist;
	NSString *confirmCase;
	NSString *failedCase;
    NSString *receivedCase;
    NSString *submittedCase;
    
	if ([self record_exist])
		exist = @"1";
	else
		exist = @"0";
	
	if ([self confirm_case])
		confirmCase = @"1";
	else
		confirmCase = @"0";
	
	if ([self failed_case])
		failedCase = @"1";
	else
		failedCase = @"0";
    
	if ([self received_case])
		receivedCase = @"1";
	else
		receivedCase = @"0";
    
	if ([self submitted_case])
		submittedCase = @"1";
	else
		submittedCase = @"0";
	
	
	[ClientProfile setObject:exist forKey:@"exist"];
	[ClientProfile setObject:confirmCase forKey:@"confirmCase"];
	
    if ([self Validation] == TRUE) {
		[ClientProfile setObject:@"1" forKey:@"Validation"];
	}
	else
		[ClientProfile setObject:@"0" forKey:@"Validation"];
	
	[self hideKeyboard];
	
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

-(void)SaveChanges2
{
    
    if ([self Validation] == TRUE) {
        
        sqlite3_stmt *statement;
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            NSString *group = nil;
            NSString *title = nil;
            NSString *otherID = nil;
            NSString *OffCountry = nil;
            NSString *HomeCountry = nil;
            NSString *strDOB = nil;
            
            txtrFullName.text = [txtrFullName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
			NSString *marital = [outletMaritalStatus.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            NSString *nation = [outletNationality.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            
            NSString *race  = [outletRace.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            NSString *religion = [outletReligion.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
			
            
            
            if (txtDOB.text.length == 0) {
                strDOB = [outletDOB.titleLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            }
            else {
                strDOB = txtDOB.text;
            }
            
            if (![outletGroup.titleLabel.text isEqualToString:@"- SELECT -"]) {
                group = [outletGroup.titleLabel.text substringWithRange:NSMakeRange(1,outletGroup.titleLabel.text.length - 1)];
            }
            else {
                group = outletGroup.titleLabel.text;
            }
            if([group isEqualToString:@"- SELECT -"])
                group=@"";
            
            group = [self getGroupID:group];
            
            if (![outletTitle.titleLabel.text isEqualToString:@"- SELECT -"]) {
                title =  [self getTitleDesc:[outletTitle.titleLabel.text stringByTrimmingCharactersInSet:
											 [NSCharacterSet whitespaceCharacterSet]]];
				TitleCodeSelected = [outletTitle.titleLabel.text stringByTrimmingCharactersInSet:
									 [NSCharacterSet whitespaceCharacterSet]];
				
            }
            else {
                title = [self getTitleDesc:outletTitle.titleLabel.text];
				TitleCodeSelected = outletTitle.titleLabel.text;
            }
            
            
            if (![OtherIDType.titleLabel.text isEqualToString:@"- SELECT -"]) {
                
                otherID =    [OtherIDType.titleLabel.text stringByTrimmingCharactersInSet:
                              [NSCharacterSet whitespaceCharacterSet]];
            }
            else {
                otherID = OtherIDType.titleLabel.text;
            }
            
            if([otherID isEqualToString:@"- SELECT -"])
                otherID = @"";
            
            if (checked) {
                HomeCountry = [btnHomeCountry.titleLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
                SelectedStateCode = txtHomeState.text;
            }
            else {
                HomeCountry = txtHomeCountry.text;
            }
            
            if (checked2) {
                OffCountry = [btnOfficeCountry.titleLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
                SelectedOfficeStateCode = txtOfficeState.text;
            }
            else {
                OffCountry = txtOfficeCountry.text;
            }
            
            HomeCountry = [self getCountryCode:HomeCountry];
            OffCountry = [self getCountryCode:OffCountry];
			
			NSString *CountryOfBirth = @"";
			CountryOfBirth = [BtnCountryOfBirth.titleLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
			
			CountryOfBirth = [self getCountryCode:CountryOfBirth];
			
			
			if(gender == nil || gender==NULL || [gender isEqualToString:@"(null)"])
                gender=@"";
            if(ClientSmoker == nil || ClientSmoker ==NULL || [ClientSmoker isEqualToString:@"(null)"])
                ClientSmoker=@"";
			
			
			NSLog(@"CP NAME: %@", txtrFullName.text);
            NSString *insertSQL = [NSString stringWithFormat:
                                   @"update prospect_profile set \"ProspectName\"=\'%@\', \"ProspectDOB\"=\"%@\", \"ProspectGender\"=\"%@\", \"ResidenceAddress1\"=\"%@\", \"ResidenceAddress2\"=\"%@\", \"ResidenceAddress3\"=\"%@\", \"ResidenceAddressTown\"=\"%@\", \"ResidenceAddressState\"=\"%@\", \"ResidenceAddressPostCode\"=\"%@\", \"ResidenceAddressCountry\"=\"%@\", \"OfficeAddress1\"=\"%@\", \"OfficeAddress2\"=\"%@\", \"OfficeAddress3\"=\"%@\", \"OfficeAddressTown\"=\"%@\",\"OfficeAddressState\"=\"%@\", \"OfficeAddressPostCode\"=\"%@\", \"OfficeAddressCountry\"=\"%@\", \"ProspectEmail\"= \"%@\", \"ProspectOccupationCode\"=\"%@\", \"ExactDuties\"=\"%@\", \"ProspectRemark\"=\"%@\", \"DateModified\"=%@,\"ModifiedBy\"=\"%@\", \"ProspectGroup\"=\"%@\", \"ProspectTitle\"=\"%@\", \"IDTypeNo\"=\"%@\", \"OtherIDType\"=\"%@\", \"OtherIDTypeNo\"=\"%@\", \"Smoker\"=\"%@\", \"AnnualIncome\"=\"%@\", \"BussinessType\"=\"%@\", \"Race\"=\"%@\", \"MaritalStatus\"=\"%@\", \"Nationality\"=\"%@\", \"Religion\"=\"%@\" , \"QQFlag\"=\"%@\", \"CountryOfBirth\"=\"%@\"  where indexNo = \"%@\" "
                                   "", txtrFullName.text, strDOB, gender, txtHomeAddr1.text, txtHomeAddr2.text, txtHomeAddr3.text, txtHomeTown.text, SelectedStateCode, txtHomePostCode.text, HomeCountry, txtOfficeAddr1.text, txtOfficeAddr2.text, txtOfficeAddr3.text, txtOfficeTown.text, SelectedOfficeStateCode, txtOfficePostCode.text, OffCountry, txtEmail.text, OccupCodeSelected, txtExactDuties.text, txtRemark.text, @"datetime(\"now\", \"+8 hour\")", @"1", group, TitleCodeSelected, txtIDType.text, IDTypeCodeSelected, txtOtherIDType.text, ClientSmoker, txtAnnIncome.text, txtBussinessType.text, race, marital, nation, religion,@"false" , CountryOfBirth ,pp.ProspectID];
            
			
            const char *Update_stmt = [insertSQL UTF8String];
            if(sqlite3_prepare_v2(contactDB, Update_stmt, -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    [self GetLastID];
                    
                } else {
                    
                    UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" " message:@"Fail in update" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [failAlert show];
                }
                sqlite3_finalize(statement);
            }
            else {
                NSLog(@"Error Statement");
            }
            sqlite3_close(contactDB);
        }
        else {
            NSLog(@"Error Open");
        }
        
        [self dismissModalViewControllerAnimated:YES];
		
		
		NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
		[ClientProfile setObject:@"NO" forKey:@"isEdited"];
		[ClientProfile setObject:@"NO" forKey:@"NeedToSave"];
		[ClientProfile setObject:@"NO" forKey:@"HasChanged"];
		
    }
	
}





#pragma mark - validation


-(BOOL) IDValidation
{
	IC_Hold_Alert = NO;
	
	//test
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	//[ClientProfile setObject:@"NEW" forKey:@"TabBar1"];
	
	if (![[ClientProfile objectForKey:@"TabBar1"] isEqualToString:@"1"] && clickDone != 1) {
		for (NSArray* row in _tableDB.rows){
			//			NSLog(@"idtype: %@, %@", txtIDType.text, [row objectAtIndex:1]);
			if ([txtIDType.text isEqualToString:[row objectAtIndex:1]]) {
				
				if(Update_record == FALSE)
				{
					
					
					getSameRecord_Indexno = [row objectAtIndex:0];
					SameID_type = @"IC";
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
																	message:@"Customer profile has been created using this ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					
					alert.tag = 6000;
					[alert show];
					
					segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
					
					[ClientProfile setObject:@"NO" forKey:@"isNew"];
					IC_Hold_Alert = YES;
					return false;
					
				}
				
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
			db_otherid = [self getIDTypeDesc:db_otherid];
			
			//			NSLog(@"Input: Type: %@ ID: %@  Cpr: type: %@ ID: %@", otherIDType, input, db_otherid, str_otherid);
			
			if ([input isEqualToString:str_otherid] && [otherIDType isEqualToString:db_otherid]) {
				//			if ([txtOtherIDType.text isEqualToString:[row objectAtIndex:0]]) {
				
				if(Update_record == FALSE)
				{
					//					getSameRecord_Indexno = [row objectAtIndex:2];
					getSameRecord_Indexno = indexno;
					
					SameID_type = @"OTHERID";
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
																	message:@"Customer profile has been created using this ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					
					alert.tag = 6000;
					[alert show];
					
					//					segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
					
					
					[ClientProfile setObject:@"NO" forKey:@"isNew"];
					OTHERID_Hold_Alert = YES;
					
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
    
    
	//  OtherIDType.titleLabel.text = [OtherIDType.titleLabel.text stringByTrimmingCharactersInSet:
	//                                 [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *title   = [outletTitle.titleLabel.text stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *religion = [outletReligion.titleLabel.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *race = [outletRace.titleLabel.text stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]];
    
    NSString *RigDateOutlet = [outletRigDOB.titleLabel.text stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]];
	
    NSString *otherIDType_trim = [OtherIDType.titleLabel.text stringByTrimmingCharactersInSet:
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
    
    NSString *officePostcode_trim = [txtOfficePostCode.text stringByTrimmingCharactersInSet:
									 [NSCharacterSet whitespaceCharacterSet]];
	
	NSString *BirthCountry = [BtnCountryOfBirth.titleLabel.text stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]];
	
	
	[ClientProfile setObject:@"" forKey:@"TabBar1"];
	clickDone = 2; //to allow prompt same id checking, can use any number as long not 1
	
	if ([textFields trimWhiteSpaces:txtIDType.text].length == 12 && [pp.IDTypeNo isEqualToString:@""]) {
		if (![self IDValidation]) {
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
			return FALSE;
		}
	}
	
	if (![otherIDType_trim isEqualToString:@"- SELECT -"] && ![otherIDType_trim isEqualToString:@""] && ![textFields trimWhiteSpaces:txtOtherIDType.text].length == 0 && [pp.OtherIDTypeNo isEqualToString:@""]) {
		if (![self OtherIDValidation]) {
			[ClientProfile setObject:@"NO" forKey:@"TabBar"];
			return FALSE;
		}
	}
	
	if ([otherIDType_trim isEqualToString:@"COMPANY REGISTRATION NUMBER"]) {
		companyCase = true;
	}
	else
		companyCase = false;
    
	
    if(!companyCase){
        
        if([title isEqualToString:@"- SELECT -"] && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Title is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 1006;
            
            [alert show];
            return false;
        }
    }
    
    //check 3 times repeat alphabetic
    NSArray  *repeat = [txtrFullName.text componentsSeparatedByString:@" "];
    
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
	
    
    
    
    
    if([[txtrFullName.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]){
        errormsg = [[UIAlertView alloc] initWithTitle:@" "
                                              message:@"Full Name is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        errormsg.tag = 80;
        [errormsg show];
        errormsg = nil;
        return false;
    }
    else if([textFields validateString3:txtrFullName.text]){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Invalid name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 80;
        [alert show];
        alert = Nil;
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
            return false;
            
        }
        
    }
    else {
        BOOL valid;
        NSString *strToBeTest = [txtrFullName.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] ;
        
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
            return false;
        }
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
         outletRigDOB.titleLabel.textColor = [UIColor redColor];
        return false;
    }
    
    if(segRigExempted.selectedSegmentIndex == -1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"GST Exempted is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [self resignFirstResponder];
        [self.view endEditing:TRUE];
        [alert show];
        
        return false;
    }

    
	
    //KY START COMPANY
	
    if(companyCase) {
        
        if ([[txtOtherIDType.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 82;
            [alert show];
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
            return false;
        }
        
        if (txtOtherIDType.text.length > 30) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Invalid Other ID length. Other ID length should be not more 30 characters long" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [txtOtherIDType becomeFirstResponder];
            return false;
        }
        
        if ([[txtOtherIDType.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 82;
            
            [alert show];
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
            return false;
        }
		
        
        if (txtExactDuties.text.length > 40) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Invalid Exact Duties length. Only 40 characters allowed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 1007;
            [alert show];
            return false;
        }
        
        
        if ([txtBussinessType.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Type of business is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 2060;
            [alert show];
            return false;
        }
        
        
        if (txtBussinessType.text.length > 60) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Invalid Type of Business length. Only 60 characters allowed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag=2060;
            [alert show];
            return false;
        }
        
        
        NSString * AI = [annualIncome_original stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
        
        NSArray  *comp = [AI componentsSeparatedByString:@"."];
        
        
        
        int AI_Length = [[comp objectAtIndex:0] length];
        
        if ([txtAnnIncome.text isEqualToString:@""] && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"]) {
            if((![OccpCatCode isEqualToString:@"HSEWIFE"])
               && (![OccpCatCode isEqualToString:@"JUV"])
               && (![OccpCatCode isEqualToString:@"RET"])
               && (![OccpCatCode isEqualToString:@"STU"])
               && (![OccpCatCode isEqualToString:@"UNEMP"])) {
                
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Annual Income is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                txtAnnIncome.enabled = true;
                txtAnnIncome.backgroundColor = [UIColor whiteColor];
                alert.tag = 1008;
                [alert show];
                
                
                return false;
            }
            
            
        }
        else if (AI_Length >13  && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"]) {
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
            
            return false;
            
        }
        //###### ky Home address START#######
        NSString *homecountry = [btnHomeCountry.titleLabel.text stringByTrimmingCharactersInSet:
                                 [NSCharacterSet whitespaceCharacterSet]];
        
        
        if (   home1_trim.length==0  && checked == YES )
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Residential Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 1012;
            
            [alert show];
            return false;
        }
        else  if ([homecountry isEqualToString:@"- SELECT -"] && checked == YES )
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Country for residential address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            alert.tag = 5001;
            [alert show];
            return false;
            
        }
        
        
        else if ( (home1_trim.length!=0 || ![txtHomeAddr2.text isEqualToString:@""] || ![txtHomeAddr3.text isEqualToString:@""])&& homePostcode_trim.length==0)
        {
            if(checked == NO)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Postcode for residential address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag=2000;
                
                [alert show];
                return false;
            }
            
            
        }
        else  if ( home1_trim.length==0 && ![txtHomePostCode.text isEqualToString:@""])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Residential Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 1012;
            
            [alert show];
            return false;
        }
		
		
        else if (![txtHomePostCode.text isEqualToString:@""] && checked == NO)
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
                return false;
            }
            
            else if (!valid_symbol) {
                txtHomeState.text=@"";
                txtHomeState.text = @"";
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Postcode for Residential Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                rrr.tag = 2001;
                [rrr show];
                rrr=nil;
                return false;
                
            }
            
            
            else if (!valid) {
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
                HomePostcodeContinue = FALSE;
                
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
                
                if(!HomePostcodeContinue)
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
                    [txtHomePostCode addTarget:self action:@selector(EditTextFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
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
            
            
            if(office1_trim.length==0 && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"])
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag = 2002;
                [alert show];
                return false;
                
            }
            if([officecountry isEqualToString:@"- SELECT -"])
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Country for office address is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag=5002;
                [alert show];
                return false;
            }
            
        }
        else{
            
            
            if(office1_trim.length==0  && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"])
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag = 2002;
                
                [alert show];
                return false;
                
            }
            
            else if (![txtOfficePostCode.text isEqualToString:@""])
            {
                
                //HOME POSTCODE START
                //CHECK INVALID SYMBOLS
                NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
                
                
                BOOL valid;
                BOOL valid_symbol;
                
                NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                
                NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtOfficePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
                
                valid = [alphaNums isSupersetOfSet:inStringSet];
                valid_symbol = [set isSupersetOfSet:inStringSet];
                
                
                if(officePostcode_trim.length < 5)
                {
                    rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                     message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    rrr.tag = 3001;
                    [rrr show];
                    rrr=nil;
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
                    return false;
                }
                else{
                    const char *dbpath = [databasePath UTF8String];
                    sqlite3_stmt *statement;
                    
                    txtOfficePostCode.text = [txtOfficePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""];
                    
                    
                    
                    
                    
                    //CHECK INVALID SYMBOLS
                    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
                    
                    
                    BOOL valid;
                    BOOL valid_symbol;
                    
                    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                    
                    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtOfficePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
                    
                    valid = [alphaNums isSupersetOfSet:inStringSet];
                    valid_symbol = [set isSupersetOfSet:inStringSet];
                    OfficePostcodeContinue = false;
                    
                    
                    
                    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
                        NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", txtOfficePostCode.text];
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
                        [txtOfficePostCode addTarget:self action:@selector(OfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                        return false;
                        
                        
                    }
                    
                }
                
                
                //HOME POSTCODE END
                
            }
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
    }
    else{
		
		
		// CHECK OTHER ID
		if ((txtOtherIDType.text.length == 0 ) && ![otherIDType_trim isEqualToString:@"- SELECT -"] && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"]  )
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag= 82;
            [alert show];
            
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
			    return false;
            }
        }
		
		
        NSString *occupation = [outletOccup.titleLabel.text stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
        
        
        //Check if baby
        if([OccpCatCode isEqualToString:@"JUV"] && [otherIDType_trim isEqualToString:@"BIRTH CERTIFICATE"]) {
			
            
			
            
            segGender.enabled = YES;
            if(txtOtherIDType.text.length==0 && txtIDType.text.length == 0)
            {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No or Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag = 1003;
                [rrr show];
                segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                return false;
                
                
                
            }
            else if (txtOtherIDType.text.length==0){
                [txtOtherIDType becomeFirstResponder];
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag = 82;
                [rrr show];
                segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                return false;
                
                
            }
        }
        
        
		
        if(([otherIDType_trim isEqualToString:@"- SELECT -"] && ![otherIDType_trim isEqualToString:@"OLD IDENTIFICATION NO"]) && ![OccpCatCode isEqualToString:@"JUV"] ){
            
            
            ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
            txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            
            
            if ([otherIDType_trim isEqualToString:@"- SELECT -"] && ([txtIDType.text isEqualToString:@""] || (txtIDType.text.length == 0) )) {
                
				
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No or Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag = 1003;
                [rrr show];
                txtIDType.text = @"";
                txtDOB.text = @"";
                segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                return false;
                
            }
            else if([txtIDType.text isEqualToString:@""] || (txtIDType.text.length == 0) ){
				
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag = 1002;
                [rrr show];
                txtIDType.text = @"";
                txtDOB.text = @"";
                segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                return false;
                
            }
            
            
            
            
            else  if (txtIDType.text.length != 16) {
				
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No must be 16 digits characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag = 1002;
                [rrr show];
                rrr=nil;
                
                
                
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
                    
                    return false;
                }
                
                if (txtIDType.text.length != 16) {
                    
                    
                    
                    
                    
                    rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                     message:@"NIK No must be 16 digits characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    rrr.tag = 1002;
                    [rrr show];
                    rrr = nil;
                    
                    
                    return false;
                }
            }
            
            
            //GET DOB
            
            NSString *last = [txtIDType.text substringFromIndex:[txtIDType.text length] -1];
            NSCharacterSet *oddSet = [NSCharacterSet characterSetWithCharactersInString:@"13579"];
            
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
                
                if([otherIDType_trim isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    txtDOB.text = @"";
                    segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
                return false;
            }
            else if ([strMonth intValue] > 12 || [strMonth intValue] < 1) {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK month must be between 1 and 12." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                rrr.tag = 1002;
                [rrr show];
                
                if([otherIDType_trim isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    txtDOB.text = @"";
                    segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
                return false;
            }
            else if([strDate intValue] < 1 || [strDate intValue] > 31)
            {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK day must be between 1 and 31 or between 41 and 71." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                rrr.tag = 1002;
                [rrr show];
                
                return false;
                
            }
            else if (([strMonth isEqualToString:@"01"] || [strMonth isEqualToString:@"03"] || [strMonth isEqualToString:@"05"] || [strMonth isEqualToString:@"07"] || [strMonth isEqualToString:@"08"] || [strMonth isEqualToString:@"10"] || [strMonth isEqualToString:@"12"]) && [strDate intValue] > 31) {
                
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                rrr.tag = 1002;
                [rrr show];
                
                txtIDType.text = @"";
                if([otherIDType_trim isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    txtDOB.text = @"";
                    segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
                return false;
            }
            
            else if (([strMonth isEqualToString:@"04"] || [strMonth isEqualToString:@"06"] || [strMonth isEqualToString:@"09"] || [strMonth isEqualToString:@"11"]) && [strDate intValue] > 30) {
                
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                rrr.tag = 1002;
                [rrr show];
                
                txtIDType.text = @"";
                if([otherIDType_trim isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    txtDOB.text = @"";
                    segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
                
                return false;
            }
            else if (([febStatus isEqualToString:@"Normal"] && [strDate intValue] > 28 && [strMonth isEqualToString:@"02"]) || ([febStatus isEqualToString:@"Jump"] && [strDate intValue] > 29 && [strMonth isEqualToString:@"02"])) {
                
                
                NSString *msg = [NSString stringWithFormat:@"February of %@ doesn’t have 29 days",strYear] ;
                
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                
                [rrr show];
                
                
                if([otherIDType_trim isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    txtDOB.text = @"";
                    segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
                
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
        //KY - IF USER KEY IN OTHER ID AND IC
        else if(![otherIDType_trim isEqualToString:@"- SELECT -"]  && (txtIDType.text.length > 0 && txtIDType.text.length<12) )
        {
            
            
            
			if (txtIDType.text.length != 16) {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No must be 16 digits characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag = 1002;
                [rrr show];
                rrr=nil;
                
                
                
                return false;
            }
			
            
        }
		else if(![otherIDType_trim isEqualToString:@"- SELECT -"]  && (txtIDType.text.length==16) )
        {
			
            //ky
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
				
				NSString *strDate = [txtIDType.text substringWithRange:NSMakeRange(6, 2)];
				NSString *strMonth = [txtIDType.text substringWithRange:NSMakeRange(8, 2)];
				NSString *strYear = [txtIDType.text substringWithRange:NSMakeRange(10, 2)];

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

				
				int intDate = [strDate integerValue];
				if (intDate > 40 && intDate < 72) {
				
					ic_gender = @"FEMALE";
					
					intDate = intDate - 40;
					if (intDate <10)
						strDate = [NSString stringWithFormat:@"0%d", intDate];
					else
						strDate = [NSString stringWithFormat:@"%d", intDate];
				}
				
				else if (intDate > 0 && intDate < 31) {
					
					ic_gender = @"MALE";
				}
			
				
				if(![day isEqualToString:strDate] || ![month isEqualToString:strMonth] || ![year isEqualToString:strYear])
				{
					rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No does not match with Date of Birth." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
					rrr.tag = 1002;
					[rrr show];
					rrr = nil;
					return false;
					
				}
				else if(([ic_gender isEqualToString:@"MALE"] && segGender.selectedSegmentIndex !=0) || ([ic_gender isEqualToString:@"FEMALE"] && segGender.selectedSegmentIndex !=1))
				{
					
					rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"NIK No does not match with Gender." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
					rrr.tag = 1002;
					[rrr show];
					rrr = nil;
					return false;
				}
            }
            
			
        }
        
        
        /*
		 
		 if ((txtOtherIDType.text.length == 0 ) && ![otherIDType_trim isEqualToString:@"- SELECT -"] && ![otherIDType_trim isEqualToString:@"- Select -"] && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"]  )
		 {
		 
		 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
		 message:@"3 Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		 alert.tag= 82;
		 [alert show];
		 
		 return false;
		 }
		 */
        
        if(txtOtherIDType.text.length == 1)
        {
            BOOL error = FALSE;
            NSString *strToBeTest = [txtOtherIDType.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] ;
            
            for (int i=0; i<strToBeTest.length; i++) {
                int str1=(int)[strToBeTest characterAtIndex:i];
                
                if( str1 ==34 ||  str1 == 38 || str1 == 39 || str1 == 40 || str1 == 41 || str1 == 64 || str1 == 47 || str1 == 45 || str1 == 46){
                    
                    error = TRUE;
                }
            }
            
            if(error)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Invalid Other ID." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [txtOtherIDType becomeFirstResponder];
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
            
            return false;
        }
        
        
        
        //Other ID Type as ‘SINGAPOREAN IDENTIFICATION NUMBER’, then the “Nationality” must be “Singaporean”.
        NSString *otherIDtype = [OtherIDType.titleLabel.text stringByTrimmingCharactersInSet:
                                 [NSCharacterSet whitespaceCharacterSet]];
        
        if ([otherIDtype isEqualToString:@"SINGAPOREAN IDENTIFICATION NUMBER"] && ![nation isEqualToString:@"SINGAPOREAN"]  )
        {
            
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Nationality must be Singaporean" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            alert.tag= 1005;
            return false;
        }
        
        //COMPARE THE DATE
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd"];
        NSString *dob =[outletDOB.titleLabel.text stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceCharacterSet]];
        
        
        NSDateFormatter *formatter;
        NSString        *today;
        
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        
        today = [formatter stringFromDate:[NSDate date]];
        
        
        
        if(([[txtDOB.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) && ([dob isEqualToString:@"- SELECT -"]) && (!dob.length == 0)){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Date of Birth is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            alert.tag = 83;
            
            [alert show];
            return false;
        }
		
        if([BirthCountry isEqualToString:@"- SELECT -"] && (![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"] && ![otherIDType_trim isEqualToString:@"COMPANY REGISTRATION NUMBER"]))
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Country of Birth is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag= 1013;
            [alert show];
            return false;
        }
        
        
        
        if(segGender.selectedSegmentIndex == -1 && ![otherIDType_trim isEqualToString:@"COMPANY REGISTRATION NUMBER"] && ![otherIDType_trim isEqualToString:@"Company Registration Number"] && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"] ){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Gender is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [self resignFirstResponder];
            [self.view endEditing:TRUE];
            
            [alert show];
            return false;
        }
        
		
        
        
        
        
        
        
        
        
        if([race isEqualToString:@"- SELECT -"] && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Race is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag= 1010;
            [alert show];
            return false;
        }
        
        //CHECK NATIONALITY
        if([nation isEqualToString:@"- SELECT -"]&& ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"])
        {
            rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"Nationality is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            rrr.tag = 1005;
            [rrr show];
            
            return false;
        }
        else if (txtIDType.text.length != 0 && ![nation isEqualToString:@"MALAYSIAN"]) {
            
            rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"Nationality didn’t match with New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            rrr.tag = 1005;
            [rrr show];
            
            return false;
        }
        //check for singaporean
        else if ([otherIDType_trim isEqualToString:@"SINGAPORE IDENTIFICATION NUMBER"] && ![nation isEqualToString:@"SINGAPOREAN"]) {
            
            rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"Nationality didn’t match with Other ID No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            rrr.tag = 1005;
            [rrr show];
            
            return false;
        }
        //check for MALAYSIAN FOR OTHER ID
        //The Nationality must be 'Malaysian'
        
        else if (([otherIDType_trim isEqualToString:@"ARMY IDENTIFICATION NUMBER"] || [otherIDType_trim  isEqualToString:@"BIRTH CERTIFICATE"] || [otherIDType_trim  isEqualToString:@"OLD IDENTIFICATION NO"] || [otherIDType_trim  isEqualToString:@"POLICE IDENTIFICATION NUMBER"]) && ![nation isEqualToString:@"MALAYSIAN"]) {
            
            rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"Nationality didn’t match with Other ID No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            rrr.tag = 1005;
            [rrr show];
            
            return false;
        }
        
        //the Nationality must NOT be “Malaysian
        else if (([otherIDType_trim isEqualToString:@"FOREIGNER BIRTH CERTIFICATE"] || [otherIDType_trim  isEqualToString:@"FOREIGNER IDENTIFICATION NUMBER"] || [otherIDType_trim  isEqualToString:@"PERMANENT RESIDENT"]) && [nation isEqualToString:@"MALAYSIAN"]) {
            
            rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"Nationality didn’t match with Other ID No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            rrr.tag = 1005;
            [rrr show];
            
            return false;
        }
        
        
        //CHECK NATIONALITY
        
        if([nation isEqualToString:@"- SELECT -"]&& ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Nationality is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 1005;
            [alert show];
            return false;
        }
        
        //CHECK RELIGION
        if([religion isEqualToString:@"- SELECT -"] && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Religion is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 1011;
            [alert show];
            return false;
        }
        
        
        //CHECK MARITAL STATUS
        if([marital isEqualToString:@"- SELECT -"] && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Marital status is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 1009;
            [alert show];
            return false;
        }
        
        
        
        
        //START CHECK SMOKING
        if((segSmoker.selectedSegmentIndex == -1) && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Smoking status is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [self resignFirstResponder];
            [self.view endEditing:TRUE];
            
            [alert show];
            return false;
        }
        
        // CHECK OCCUPATION
        if(([OccupCodeSelected isEqualToString:@""]  && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"]) ||(OccupCodeSelected == NULL && !companyCase && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"])){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Occupation is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            alert.tag = 84;
            [alert show];
            return false;
        }
        
        
        
		//    outletOccup.titleLabel.text = [outletOccup.titleLabel.text stringByTrimmingCharactersInSet:
		//                                  [NSCharacterSet whitespaceCharacterSet]];
        
        
		
        if([OccpCatCode isEqualToString:@"HSEWIFE"]
           ||[OccpCatCode isEqualToString:@"JUV"]
           ||[OccpCatCode isEqualToString:@"RET"]
           ||[OccpCatCode isEqualToString:@"STU"]
           ||[OccpCatCode isEqualToString:@"UNEMP"]
           ||([otherIDType_trim isEqualToString:@"COMPANY REGISTRATION NUMBER"] && txtOtherIDType.text.length != 0)){
            NSLog(@"here if");
        }
        else{
            
            
            if (txtExactDuties.text.length < 1 && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Exact nature of work is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag = 1007;
                [alert show];
                return false;
            }
            
            else if (txtExactDuties.text.length > 40) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Invalid Exact Duties length. Only 40 characters allowed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag = 1007;
                [alert show];
                return false;
            }
            
            
            if ([txtBussinessType.text isEqualToString:@""] && [otherIDType_trim isEqualToString:@"COMPANY REGISTRATION NUMBER"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Type of business is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag=2060;
                [alert show];
                return false;
            }
            
            
            if (txtBussinessType.text.length > 60 && ![otherIDType_trim isEqualToString:@"COMPANY REGISTRATION NUMBER"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Invalid Type of Business length. Only 60 characters allowed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag=2060;
                [alert show];
                return false;
            }
            
            NSString * AI = [annualIncome_original stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceCharacterSet]];
            
            NSArray  *comp = [AI componentsSeparatedByString:@"."];
            
            
            
            int AI_Length = [[comp objectAtIndex:0] length];
            
            if ([txtAnnIncome.text isEqualToString:@""] && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"]) {
                
                
                if((![OccpCatCode isEqualToString:@"HSEWIFE"])
                   && (![OccpCatCode isEqualToString:@"JUV"])
                   && (![OccpCatCode isEqualToString:@"RET"])
                   && (![OccpCatCode isEqualToString:@"STU"])
                   && (![OccpCatCode isEqualToString:@"UNEMP"])) {
                    
                    
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                    message:@"Annual Income is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    txtAnnIncome.enabled = true;
                    txtAnnIncome.backgroundColor = [UIColor whiteColor];
                    alert.tag = 1008;
                    [alert show];
                    
                    alert = nil;
                    return false;
                }
                
                
                
                
            }
            
            
            else if (AI_Length >13  && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"]) {
                
                
                if((![OccpCatCode isEqualToString:@"HSEWIFE"])
                   && (![OccpCatCode isEqualToString:@"JUV"])
                   && (![OccpCatCode isEqualToString:@"RET"])
                   && (![OccpCatCode isEqualToString:@"STU"])
                   && (![OccpCatCode isEqualToString:@"UNEMP"])) {
                    
                    
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                    message:@"Annual income must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    alert.tag = 1008;
                    [alert show];
                    
                    alert=nil;
                    return false;
                }
                
                
                
                
                
            }
            else if(AI_Length < 13 && annual_income == 0 && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"])
            {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Annual income must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag = 1008;
                [rrr show];
                rrr = nil;
                
                return false;
            }
            
        }
        
        if(checked){
            NSString *homecountry = [btnHomeCountry.titleLabel.text stringByTrimmingCharactersInSet:
									 [NSCharacterSet whitespaceCharacterSet]];
            if(home1_trim.length==0 && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"] )
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Residential Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag = 1012;
                
                [alert show];
                return false;
                
            }
			
            else if([homecountry isEqualToString:@"- SELECT -"])
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Country for residential address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag=5001;
                [alert show];
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
                
                return false;
                
            }
			
            
            if((home1_trim.length==0 && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"]))
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Residential Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag = 1012;
                
                [alert show];
                return false;
                
            }else if ([txtHomePostCode.text isEqualToString:@""] && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"])
            {
                if (homePostcode_trim.length==0) {
                    
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                    message:@"Postcode for residential address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    alert.tag=2000;
                    
                    [alert show];
                    return false;
                }else if (home1_trim.length==0){
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                    message:@"Residential Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    alert.tag = 1012;
                    
                    [alert show];
                    return false;
                }
                
            }
            else if (![txtHomePostCode.text isEqualToString:@""] && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"])
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
                
                //NSLog(@"valid_symbol - %i", valid_symbol);
                
                if(txtHomePostCode.text.length < 5)
                {
                    rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                     message:@"Postcode for Residential Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    rrr.tag = 2001;
                    [rrr show];
                    rrr=nil;
                    return false;
                }
				
                else if (!valid_symbol) {
                    txtHomeState.text=@"";
                    txtHomeState.text = @"";
                    rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                     message:@"Postcode for Residential Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    rrr.tag = 2001;
                    [rrr show];
                    rrr=nil;
                    return false;
                    
                }
                
                
                else if (!valid) {
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
                    HomePostcodeContinue = FALSE;
                    
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
					
                    if(!HomePostcodeContinue)
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
                        [txtHomePostCode addTarget:self action:@selector(EditTextFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                        return false;
                        
                        
                    }
                    
                    
                }
                //HOME POSTCODE END
                
                
                
                
            }
            
            
            
        }
        
        
        
        
        
        //office post code  end
        
        // Office address
        // Added by Benjamin Law on 17/10/2013 for bug 2561
        
		
        if(![OccpCatCode isEqualToString:@"HSEWIFE"]
		   && ![OccpCatCode isEqualToString:@"JUV"]
		   && ![OccpCatCode isEqualToString:@"UNEMP"]
		   && ![OccpCatCode isEqualToString:@"STU"]) {
            
            if(checked2){
                NSString *officecountry = [btnOfficeCountry.titleLabel.text stringByTrimmingCharactersInSet:
                                           [NSCharacterSet whitespaceCharacterSet]];
				
                
                if(office1_trim.length==0 && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"])
                {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                    message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    alert.tag = 2002;
                    [alert show];
                    return false;
                    
                }
                if([officecountry isEqualToString:@"- SELECT -"])
                {
					
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                    message:@"Country for office address is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    alert.tag=5002;
                    [alert show];
                    return false;
                }
                
            }
            else{
                
				if (![txtOfficePostCode.text isEqualToString:@""] && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"])
                {
                    
                    //HOME POSTCODE START
                    //CHECK INVALID SYMBOLS
                    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
                    
                    
                    BOOL valid;
                    BOOL valid_symbol;
                    
                    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                    
                    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtOfficePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
                    
                    valid = [alphaNums isSupersetOfSet:inStringSet];
                    valid_symbol = [set isSupersetOfSet:inStringSet];
                    
                    
                    if(txtOfficePostCode.text.length < 5)
                    {
                        txtOfficeState.text = @"";
                        txtOfficeTown.text = @"";
                        rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                         message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        rrr.tag = 3001;
                        [rrr show];
                        rrr=nil;
                        
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
                        return false;
                    }
                    else{
                        const char *dbpath = [databasePath UTF8String];
                        sqlite3_stmt *statement;
                        
                        txtOfficePostCode.text = [txtOfficePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""];
                        
                        
                        
                        
                        
                        //CHECK INVALID SYMBOLS
                        NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
                        
                        
                        BOOL valid;
                        BOOL valid_symbol;
                        
                        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                        
                        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtOfficePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
                        
                        valid = [alphaNums isSupersetOfSet:inStringSet];
                        valid_symbol = [set isSupersetOfSet:inStringSet];
                        OfficePostcodeContinue = false;
                        
                        
                        
                        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
                            NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", txtOfficePostCode.text];
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
                            [txtOfficePostCode addTarget:self action:@selector(EditOfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                            return false;
                            
                            
                        }
                        
                    }
                    
                    
                    //HOME POSTCODE END
                    
                }
                
                
                
            }
            
        }
        //KY - IF USER KEY IN OFFICE ADDRESS PARTIALLY, SYSTEM SHOULD CHECK ON THIS
        else if (([OccpCatCode isEqualToString:@"HSEWIFE"]
				  ||[OccpCatCode isEqualToString:@"JUV"]
				  ||[OccpCatCode isEqualToString:@"RET"]
				  ||[OccpCatCode isEqualToString:@"STU"]
				  ||[OccpCatCode isEqualToString:@"UNEMP"]) && (![txtOfficeAddr1.text isEqualToString:@""] || ![txtOfficePostCode.text isEqualToString:@""]))
        {
            
			//KY ADD FOR FOREIGN COUNTRY CHECKING START
            
            
            
            if(checked2){
                
                
                NSString *officecountry = [btnOfficeCountry.titleLabel.text stringByTrimmingCharactersInSet:
                                           [NSCharacterSet whitespaceCharacterSet]];
                
                if(office1_trim.length==0  && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"])
                {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                    message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    alert.tag = 2002;
                    [alert show];
                    return false;
                    
                }
                if([officecountry isEqualToString:@"- SELECT -"])
                {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                    message:@"Country for office address is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    alert.tag=5002;
                    
                    [alert show];
                    return false;
                }
                
            }
			else
			{
				
				if((office1_trim.length!=0 || ![txtOfficeAddr2.text isEqualToString:@""] ||![txtOfficeAddr3.text isEqualToString:@""] ) && officePostcode_trim.length==0)
				{
					
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
																	message:@"Postcode for Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					alert.tag = 3001;
					
					[alert show];
					return false;
					
				}
				else  if(office1_trim.length==0   && ![txtOfficePostCode.text isEqualToString:@""])
					
				{
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
																	message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					alert.tag = 2002;
					[alert show];
					return false;
					
				}
				else if (![txtOfficePostCode.text isEqualToString:@""] && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"])
				{
					
					//HOME POSTCODE START
					//CHECK INVALID SYMBOLS
					NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
					
					
					BOOL valid;
					BOOL valid_symbol;
					
					NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
					
					NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtOfficePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
					
					valid = [alphaNums isSupersetOfSet:inStringSet];
					valid_symbol = [set isSupersetOfSet:inStringSet];
					
					
					if(txtOfficePostCode.text.length < 5)
					{
						txtOfficeState.text = @"";
						txtOfficeTown.text = @"";
						rrr = [[UIAlertView alloc] initWithTitle:@" "
														 message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
						
						rrr.tag = 3001;
						[rrr show];
						rrr=nil;
						
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
						return false;
					}
					else{
						const char *dbpath = [databasePath UTF8String];
						sqlite3_stmt *statement;
						
						txtOfficePostCode.text = [txtOfficePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""];
						
						
						
						
						
						//CHECK INVALID SYMBOLS
						NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
						
						
						BOOL valid;
						BOOL valid_symbol;
						
						NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
						
						NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtOfficePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
						
						valid = [alphaNums isSupersetOfSet:inStringSet];
						valid_symbol = [set isSupersetOfSet:inStringSet];
						OfficePostcodeContinue = false;
						
						
						
						if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
							NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", txtOfficePostCode.text];
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
							[txtOfficePostCode addTarget:self action:@selector(EditOfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
							return false;
							
							
						}
						
					}
					
					
					//HOME POSTCODE END
					
				}
				
				
				
			}
		}
		
		
        
        
    }
    
	//######office address#######
    if(checked2){
        NSString *officecountry = [btnOfficeCountry.titleLabel.text  stringByTrimmingCharactersInSet:
								   [NSCharacterSet whitespaceCharacterSet]];
        
        if(office1_trim.length==0 && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"])
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 2002;
            [alert show];
            return false;
            
        }
        if([officecountry isEqualToString:@"- SELECT -"])
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Country for office address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag=5002;
            
            [alert show];
            return false;
        }
        
    }
    
    
    else  if((![OccpCatCode isEqualToString:@"HSEWIFE"])
             && (![OccpCatCode isEqualToString:@"JUV"])
             && (![OccpCatCode isEqualToString:@"RET"])
             && (![OccpCatCode isEqualToString:@"STU"])
             && (![OccpCatCode isEqualToString:@"UNEMP"])) {
        
        
        if(office1_trim.length==0 && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"])
        {
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 2002;
            [alert show];
            return false;
            
        }else if (office1_trim.length!=0 && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"])
        {
			if(officePostcode_trim.length ==0){
                
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Postcode for Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag = 3001;
                [alert show];
                return false;
            }
            
        }
        
        
        
        
        
    }
    
    
    
    //######office address#######
    
    if([txtPrefix1.text isEqualToString:@""]&&[txtContact1.text isEqualToString:@""]&&[txtPrefix2.text isEqualToString:@""]&&[txtContact2.text isEqualToString:@""]&&[txtPrefix3.text isEqualToString:@""]&&[txtContact3.text isEqualToString:@""]&&[txtPrefix4.text isEqualToString:@""]&&[txtContact4.text isEqualToString:@""] && ![otherIDType_trim isEqualToString:@"EXPECTED DELIVERY DATE"])
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"Please enter at least one of the contact numbers (Residential, Office, Mobile or Fax)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        alert.tag = 2003;
        [alert show];
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
                return false;
            }
            
            if (!valid) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag= 2004;
                [alert show];
                return false;
            }
            
            //KY END
            
            
            
            if([txtContact1.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Residential number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag=2004;
                [alert show];
                return false;
                
                
            }
            else if (txtContact1.text.length < 6) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Residential number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag=2004;
                [alert show];
                return false;
            }
            
            else if(prefix1==nil)
            {
                rrr  = [[UIAlertView alloc] initWithTitle:@" "
                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag=2003;
                [rrr show];
                rrr = nil;
                return false;
            }
            
            else  if(contact1==nil)
            {
                rrr  = [[UIAlertView alloc] initWithTitle:@" "
                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag=2004;
                [rrr show];
                rrr = nil;
                return false;
            }
            
            
        }
        else{
            
            if(![txtContact1.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Prefix for residential number is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                
                alert.tag=2003;
                [alert show];
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
                return false;
            }
            
            if (!valid) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag= 2006;
                [alert show];
                return false;
            }
            
            
            
            
            if([txtContact2.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Mobile number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag=2006;
                [alert show];
                return false;
                
                
            }
            else if (txtContact2.text.length < 6) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Mobile number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag=2006;
                [alert show];
                return false;
            }
            
            
            else if(prefix2==nil)
            {
                rrr  = [[UIAlertView alloc] initWithTitle:@" "
                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag=2003;
                [rrr show];
                rrr = nil;
                return false;
            }
            
            else  if(contact2==nil)
            {
                rrr  = [[UIAlertView alloc] initWithTitle:@" "
                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag=2004;
                [rrr show];
                rrr = nil;
                return false;
            }
            
            
            
            
        }
        else{
            if(![txtContact2.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Prefix for mobile number is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                
                alert.tag=2005;
                [alert show];
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
                return false;
            }
            
            if (!valid) {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                rrr.tag = 2008;
                [rrr show];
                return false;
            }
            
            
            
            
            if([txtContact3.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Office number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag=2008;
                [alert show];
                return false;
                
                
            }
            else if (txtContact3.text.length < 6) {
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Office number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                rrr.tag = 2008;
                [rrr show];
                return false;
            }
            
            
            else if(prefix3==nil)
            {
                rrr  = [[UIAlertView alloc] initWithTitle:@" "
                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag=2007;
                [rrr show];
                rrr = nil;
                return false;
            }
            
            else  if(contact3==nil)
            {
                rrr  = [[UIAlertView alloc] initWithTitle:@" "
                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag=2008;
                [rrr show];
                rrr = nil;
                return false;
            }
            
            
            
            
        }
        else{
            if(![txtContact3.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Prefix for office number is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                
                alert.tag=2007;
                [alert show];
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
                return false;
            }
            
            
            
            if (!valid) {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                rrr.tag =2010;
                
                [rrr show];
                return false;
            }
            
            
            
            if([txtContact4.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Fax number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                alert.tag=2010;
                [alert show];
                return false;
                
                
            }
            else if (txtContact4.text.length < 6) {
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Fax number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag = 2010;
                
                [rrr show];
                return false;
            }
            
            
            else if(prefix4==nil)
            {
                rrr  = [[UIAlertView alloc] initWithTitle:@" "
                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag=2003;
                [rrr show];
                rrr = nil;
                return false;
            }
            
            else  if(contact4==nil)
            {
                rrr  = [[UIAlertView alloc] initWithTitle:@" "
                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag=2004;
                [rrr show];
                rrr = nil;
                return false;
            }
            
            
            
            
        }
        else{
            if(![txtContact4.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"Prefix for fax number is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                
                alert.tag=2009;
                [alert show];
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
            return false;
        }
        
        if (txtEmail.text.length > 40) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Invalid Email length. Only 40 characters allowed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 2050;
            [alert show];
            return false;
        }
    }
    
	ProsGroupArr = [UDGroup objectForKey:@"groupArr"];
	if((SegIsGrouping.selectedSegmentIndex == 0) && ProsGroupArr.count == 0)
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

- (NSString *) Validation2
{
	
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	
    NSString *ErrMsg = @"";
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	
	NSString *group = @"";
    NSString *title = @"";
    //NSString *otherID = @"";
    NSString *OffCountry = @"";
    NSString *HomeCountry = @"";
    NSString *newDOB = @"";
    NSString *marital = @"";
    NSString *nation = @"";
    NSString *race = @"";
    NSString *religion = @"";
	NSString *ResidenceForeignAddressFlag = @"";
	NSString *OfficeForeignAddressFlag = @"";
	NSString *ProspectID;
	
	NSString *FullName = [ClientProfile stringForKey:@"txtrFullName"];
	txtrFullName.text = FullName;
	
	title = [ClientProfile stringForKey:@"title"];
	TitleCodeSelected = [ClientProfile stringForKey:@"TitleCodeSelected"];
	NSString *IDType = [ClientProfile stringForKey:@"IC"];
	IDTypeCodeSelected = [ClientProfile stringForKey:@"IDTypeCodeSelected"];
	NSString *OtherIDType2 = [ClientProfile stringForKey:@"txtOtherIDType"];
	newDOB = [ClientProfile stringForKey:@"strDOB"];
	gender = [ClientProfile stringForKey:@"gender"];
	
	NSString *HomeAddr1 = [ClientProfile stringForKey:@"txtHomeAddr1"];
	NSString *HomeAddr2 = [ClientProfile stringForKey:@"txtHomeAddr2"];
	NSString *HomeAddr3 = [ClientProfile stringForKey:@"txtHomeAddr3"];
	NSString *HomeTown = [ClientProfile stringForKey:@"txtHomeTown"];
	SelectedStateCode = [ClientProfile stringForKey:@"SelectedStateCode"];
	NSString *HomePostCode = [ClientProfile stringForKey:@"txtHomePostCode"];
	HomeCountry = [ClientProfile stringForKey:@"HomeCountry"];
	if (![HomeCountry isEqualToString:@"MAL"])
		SelectedStateCode = @"";
	
	NSString *OfficeAddr1 = [ClientProfile stringForKey:@"txtOfficeAddr1"];
	NSString *OfficeAddr2 = [ClientProfile stringForKey:@"txtOfficeAddr2"];
	NSString *OfficeAddr3 = [ClientProfile stringForKey:@"txtOfficeAddr3"];
	NSString *OfficeTown = [ClientProfile stringForKey:@"txtOfficeTown"];
	SelectedOfficeStateCode = [ClientProfile stringForKey:@"SelectedOfficeStateCode"];
	NSString *OfficePostCode = [ClientProfile stringForKey:@"txtOfficePostCode"];
	OffCountry = [ClientProfile stringForKey:@"OffCountry"];
	if (![OffCountry isEqualToString:@"MAL"])
		SelectedOfficeStateCode = @"";
	
	ResidenceForeignAddressFlag = [ClientProfile stringForKey:@"ResidenceForeignAddressFlag"];
	OfficeForeignAddressFlag = [ClientProfile stringForKey:@"OfficeForeignAddressFlag"];
	
	if ([ResidenceForeignAddressFlag isEqualToString:@"Y"])
		checked = YES;
	else
		checked = NO;
	
	if ([OfficeForeignAddressFlag isEqualToString:@"Y"])
		checked2 = YES;
	else
		checked2 = NO;
	
	
	OccupCodeSelected = [ClientProfile stringForKey:@"OccupCodeSelected"];
	NSString *ExactDuties = [ClientProfile stringForKey:@"txtExactDuties"];
	group = [ClientProfile stringForKey:@"group"];
	
	ClientSmoker = [ClientProfile stringForKey:@"ClientSmoker"];
	
	NSString *AnnIncome = [ClientProfile stringForKey:@"txtAnnIncome"];
	NSString *BussinessType = [ClientProfile stringForKey:@"txtBussinessType"];
	
	race = [ClientProfile stringForKey:@"race"];
	marital = [ClientProfile stringForKey:@"marital"];
	nation = [ClientProfile stringForKey:@"nation"];
	religion = [ClientProfile stringForKey:@"religion"];
	ProspectID = [ClientProfile stringForKey:@"ProspectId"];
	
	NSString *Prefix1 = [ClientProfile stringForKey:@"txtPrefix1"];
	NSString *Contact1 = [ClientProfile stringForKey:@"txtContact1"];
	NSString *Prefix2 = [ClientProfile stringForKey:@"txtPrefix2"];
	NSString *Contact2 = [ClientProfile stringForKey:@"txtContact2"];
	NSString *Prefix3 = [ClientProfile stringForKey:@"txtPrefix3"];
	NSString *Contact3 = [ClientProfile stringForKey:@"txtContact3"];
	NSString *Prefix4 = [ClientProfile stringForKey:@"txtPrefix4"];
	NSString *Contact4 = [ClientProfile stringForKey:@"txtContact4"];
	
	//NSString *Remark = [ClientProfile stringForKey:@"txtRemark"]; no validation for remark
	NSString *Email = [ClientProfile stringForKey:@"txtEmail"];
	
	int annual_income =  [AnnIncome integerValue];
    
    
	//    NSString *home1_trim = [txtHomeAddr1.text stringByTrimmingCharactersInSet:
	//                            [NSCharacterSet whitespaceCharacterSet]];
	//
	//    NSString *homePostcode_trim = [txtHomePostCode.text stringByTrimmingCharactersInSet:
	//								   [NSCharacterSet whitespaceCharacterSet]];
	//
	//    NSString *office1_trim = [txtOfficeAddr1.text stringByTrimmingCharactersInSet:
	//							  [NSCharacterSet whitespaceCharacterSet]];
	//
	//    NSString *officePostcode_trim = [txtOfficePostCode.text stringByTrimmingCharactersInSet:
	//									 [NSCharacterSet whitespaceCharacterSet]];
	
	NSString *otherIDType_trim = IDTypeCodeSelected;
	NSString *home1_trim = HomeAddr1;
	NSString *homePostcode_trim = HomePostCode;
	NSString *office1_trim = OfficeAddr1;
	NSString *officePostcode_trim = OfficePostCode;
	
	if ([otherIDType_trim isEqualToString:@"CR"]) {
		companyCase = true;
	}
	else
		companyCase = false;
    
	
    if(!companyCase){
        
        if([title isEqualToString:@"- SELECT -"] && ![otherIDType_trim isEqualToString:@"EDD"]){
            
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Title is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            alert.tag = 1006;
			//
			//            [alert show];
			
			ErrMsg = @"Title is required.";
            return ErrMsg;
        }
    }
    
    //check 3 times repeat alphabetic
    NSArray  *repeat = [FullName componentsSeparatedByString:@" "];
    
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
	
    
    
    
    
    if([[FullName stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]){
		//        errormsg = [[UIAlertView alloc] initWithTitle:@"Error"
		//                                              message:@"Full Name is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		//
		//        errormsg.tag = 80;
		//        [errormsg show];
		//        errormsg = nil;
		
		ErrMsg = @"Full Name is required.";
		return ErrMsg;
        //return false;
    }
    else if([textFields validateString3:FullName]){
		//        UIAlertView *alert = [[UIAlertView alloc]
		//                              initWithTitle: @"Error"
		//                              message:@"Invalid name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)."
		//                              delegate: self
		//                              cancelButtonTitle:@"OK"
		//                              otherButtonTitles:nil];
		//        alert.tag = 80;
		//        [alert show];
		//        alert = Nil;
        ErrMsg = @"Invalid name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.).";
		return ErrMsg;
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
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Invalid Name format. Same alphabet cannot be repeated more than three times." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            alert.tag = 80;
			//
			//            [alert show];
			ErrMsg = @"Invalid Name format. Same alphabet cannot be repeated more than three times.";
            return ErrMsg;
            
        }
        
    }
    else {
        BOOL valid;
        NSString *strToBeTest = [FullName stringByReplacingOccurrencesOfString:@" " withString:@"" ] ;
        
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
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Invalid Name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            alert.tag = 80;
			//
			//            [alert show];
			
			ErrMsg = @"Invalid Name format. Input must be alphabet A to Z, space, apostrophe(‘), alias(@), slash(/), dash(-), bracket(( )) or dot(.)";
            return ErrMsg;
        }
    }
    
    
	
    
    //KY START COMPANY
	
    if(companyCase) {
        
        if ([[OtherIDType2 stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
            
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            alert.tag = 82;
			//            [alert show];
			ErrMsg = @"Other ID is required.";
            return ErrMsg;
        }
        else if([textFields validateOtherID:OtherIDType2]){
			//            UIAlertView *alert = [[UIAlertView alloc]
			//                                  initWithTitle: @"Error"
			//                                  message:@"Invalid Other ID."
			//                                  delegate: self
			//                                  cancelButtonTitle:@"OK"
			//                                  otherButtonTitles:nil];
			//            alert.tag = 81;
			//            [alert show];
			//            alert = Nil;
			ErrMsg = @"Invalid Other ID.";
            return ErrMsg;
        }
        
        if (OtherIDType2.length > 30) {
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Invalid Other ID length. Other ID length should be not more 30 characters long" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            [alert show];
			//            [txtOtherIDType becomeFirstResponder];
			ErrMsg = @"Invalid Other ID length. Other ID length should be not more 30 characters long";
            return ErrMsg;
        }
        
        if ([[OtherIDType2 stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            alert.tag = 82;
			//
			//            [alert show];
			ErrMsg = @"Other ID is required.";
            return false;
        }
        else if([textFields validateOtherID:OtherIDType2]){
			//            UIAlertView *alert = [[UIAlertView alloc]
			//                                  initWithTitle: @"Error"
			//                                  message:@"Invalid Other ID."
			//                                  delegate: self
			//                                  cancelButtonTitle:@"OK"
			//                                  otherButtonTitles:nil];
			//            alert.tag = 81;
			//            [alert show];
			//            alert = Nil;
			ErrMsg = @"Invalid Other ID.";
            return ErrMsg;
        }
        
        if (ExactDuties.length > 40) {
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Invalid Exact Duties length. Only 40 characters allowed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            alert.tag = 1007;
			//            [alert show];
			ErrMsg = @"Invalid Exact Duties length. Only 40 characters allowed";
            return ErrMsg;
        }
        
        
        if ([BussinessType isEqualToString:@""]) {
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Type of business is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            alert.tag = 2060;
			//            [alert show];
			ErrMsg = @"Type of business is required";
            return ErrMsg;
        }
        
        
        if (BussinessType.length > 60) {
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Invalid Type of Business length. Only 60 characters allowed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            alert.tag=2060;
			//            [alert show];
			ErrMsg = @"Invalid Type of Business length. Only 60 characters allowed";
            return ErrMsg;
        }
        
        
        NSString * AI = [annualIncome_original stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
        
        NSArray  *comp = [AI componentsSeparatedByString:@"."];
        
        
        
        int AI_Length = [[comp objectAtIndex:0] length];
        
        if ([AnnIncome isEqualToString:@""] && ![otherIDType_trim isEqualToString:@"EDD"]) {
            if((![OccpCatCode isEqualToString:@"HSEWIFE"])
               && (![OccpCatCode isEqualToString:@"JUV"])
               && (![OccpCatCode isEqualToString:@"RET"])
               && (![OccpCatCode isEqualToString:@"STU"])
               && (![OccpCatCode isEqualToString:@"UNEMP"])) {
				
                
                
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Annual Income is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                txtAnnIncome.enabled = true;
				//                txtAnnIncome.backgroundColor = [UIColor whiteColor];
				//                alert.tag = 1008;
				//                [alert show];
                
                ErrMsg = @"Annual Income is required.";
                return ErrMsg;
            }
            
            
        }
        else if (AI_Length >13  && ![otherIDType_trim isEqualToString:@"EDD"]) {
            if((![OccpCatCode isEqualToString:@"HSEWIFE"])
               && (![OccpCatCode isEqualToString:@"JUV"])
               && (![OccpCatCode isEqualToString:@"RET"])
               && (![OccpCatCode isEqualToString:@"STU"])
               && (![OccpCatCode isEqualToString:@"UNEMP"])) {
                
                
                
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                 message:@"Annual income must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                rrr.tag = 1008;
				//                [rrr show];
				//                rrr = nil;
                
				ErrMsg = @"Annual income must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points.";
                return ErrMsg;
            }
            
            
        }
        else if (AI_Length < 13 && annual_income == 0)
        {
            
			//            rrr = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                             message:@"Annual income must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            rrr.tag = 1008;
			//            [rrr show];
			//            rrr = nil;
            ErrMsg = @"Annual income must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points.";
            return ErrMsg;
            
        }
        //###### ky Home address START#######
        //NSString *homecountry = [btnHomeCountry.titleLabel.text stringByTrimmingCharactersInSet:
		//                                 [NSCharacterSet whitespaceCharacterSet]];
        
        
        if (   home1_trim.length==0  && checked == YES )
        {
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Home address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            alert.tag = 1012;
			//
			//            [alert show];
			ErrMsg = @"Residential Address is required.";
            return ErrMsg;
        }
        else  if ([HomeCountry isEqualToString:@"- SELECT -"] && checked == YES )
        {
            
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Country for Home address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//
			//            alert.tag = 5001;
			//            [alert show];
			ErrMsg = @"Country for residential address is required.";
            return ErrMsg;
            
        }
        else if ( (home1_trim.length!=0 || ![txtHomeAddr2.text isEqualToString:@""] || ![txtHomeAddr3.text isEqualToString:@""])&& homePostcode_trim.length==0)
        {
            if(checked == NO)
            {
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Postcode for home address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                alert.tag=2000;
				//
				//                [alert show];
				ErrMsg = @"Postcode for residential address is required.";
                return ErrMsg;
            }
            
            
        }
        else  if ( home1_trim.length==0 && ![txtHomePostCode.text isEqualToString:@""])
        {
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Home address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            alert.tag = 1012;
			//
			//            [alert show];
			ErrMsg = @"Residential Address is required.";
            return ErrMsg;
        }
		
		
        else if (![HomePostCode isEqualToString:@""] && checked == NO)
        {
            
            //HOME POSTCODE START
            //CHECK INVALID SYMBOLS
            NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
            
            HomePostcodeContinue = false;
            BOOL valid;
            BOOL valid_symbol;
            
            NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
            
            NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[HomePostCode stringByReplacingOccurrencesOfString:@" " withString:@""]];
            
            valid = [alphaNums isSupersetOfSet:inStringSet];
            valid_symbol = [set isSupersetOfSet:inStringSet];
            
            HomePostCode = [HomePostCode stringByTrimmingCharactersInSet:
							[NSCharacterSet whitespaceCharacterSet]];
            
            if(HomePostCode.length < 5)
            {
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                 message:@"Postcode for Home Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                rrr.tag = 2001;
				//                [rrr show];
				//                rrr=nil;
				
				ErrMsg = @"Postcode for Residential Address is invalid.";
                return ErrMsg;
            }
            
            else if (!valid_symbol) {
                txtHomeState.text=@"";
                txtHomeState.text = @"";
                rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                 message:@"Postcode for Residential Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                rrr.tag = 2001;
                [rrr show];
                rrr=nil;
                return ErrMsg;
                
            }
            
            
            else if (!valid) {
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
                HomePostcodeContinue = FALSE;
                ErrMsg = @"";
                return ErrMsg;
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
							
							[ClientProfile setObject:Town forKey:@"txtHomeTown"];
							[ClientProfile setObject:Statecode forKey:@"SelectedStateCode"];
							[ClientProfile setObject:@"MAL" forKey:@"HomeCountry"];
							
							
                            
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
                
                if(!HomePostcodeContinue)
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
                    [txtHomePostCode addTarget:self action:@selector(EditTextFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
					ErrMsg = @"";
                    return ErrMsg;
                    
                    
                }
                
                
            }
            //HOME POSTCODE END
            
            
            
            
        }
		
        
        //###### Home address END#######
        
        //######office address#######
        if(checked2){
			// NEED TO CHECK HERE LATER #############################
            NSString *officecountry = [btnOfficeCountry.titleLabel.text stringByTrimmingCharactersInSet:
                                       [NSCharacterSet whitespaceCharacterSet]];
            
            
            if(office1_trim.length==0 && ![otherIDType_trim isEqualToString:@"EDD"])
            {
                
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                alert.tag = 2002;
				//                [alert show];
				ErrMsg = @"Office Address is required.";
				[txtOfficeAddr1 becomeFirstResponder];
                return ErrMsg;
                
            }
            if([officecountry isEqualToString:@"- SELECT -"])
            {
                
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Country for office address is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                alert.tag=5002;
				//                [alert show];
				ErrMsg = @"Country for office address is required";
                return ErrMsg;
            }
            
        }
        else{
            
            
            if(office1_trim.length==0  && ![otherIDType_trim isEqualToString:@"EDD"])
            {
                
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                alert.tag = 2002;
				//
				//                [alert show];
				ErrMsg = @"Office Address is required.";
				[txtOfficeAddr1 becomeFirstResponder];
                return ErrMsg;
                
            }
            
            else if (![OfficePostCode isEqualToString:@""])
            {
                
                //HOME POSTCODE START
                //CHECK INVALID SYMBOLS
                NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
                
                
                BOOL valid;
                BOOL valid_symbol;
                
                NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                
                NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[OfficePostCode stringByReplacingOccurrencesOfString:@" " withString:@""]];
                
                valid = [alphaNums isSupersetOfSet:inStringSet];
                valid_symbol = [set isSupersetOfSet:inStringSet];
                
                
                if(officePostcode_trim.length < 5)
                {
					//                    rrr = [[UIAlertView alloc] initWithTitle:@"Error"
					//                                                     message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					//
					//                    rrr.tag = 3001;
					//                    [rrr show];
					//                    rrr=nil;
					ErrMsg = @"Postcode for Office Address is invalid.";
					[txtOfficePostCode becomeFirstResponder];
                    return ErrMsg;
                }
				
                
				else if (!valid_symbol) {
                    
                    txtOfficeState.text = @"";
                    txtOfficeTown.text = @"";
					//                    rrr = [[UIAlertView alloc] initWithTitle:@"Error"
					//                                                     message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					//
					//                    rrr.tag = 3001;
					//                    [rrr show];
					//                    rrr=nil;
                    ErrMsg = @"Postcode for Office Address is invalid.";
					[txtOfficePostCode becomeFirstResponder];
                    return ErrMsg;
                    
                }
                
                
                else if (!valid) {
                    
					//                    rrr = [[UIAlertView alloc] initWithTitle:@" "
					//                                                     message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					//
					//                    rrr.tag = 3001;
					//                    [rrr show];
					//
					//                    rrr=nil;
					ErrMsg = @"Postcode for Office Address is invalid.";
					[txtOfficePostCode becomeFirstResponder];
                    
                    txtHomeState.text = @"";
                    txtHomeTown.text = @"";
                    txtHomeCountry.text = @"";
                    SelectedStateCode = @"";
                    return ErrMsg;
                }
                else{
                    const char *dbpath = [databasePath UTF8String];
                    sqlite3_stmt *statement;
                    
                    OfficePostCode = [OfficePostCode stringByReplacingOccurrencesOfString:@" " withString:@""];
                    
                    
                    
                    
                    
                    //CHECK INVALID SYMBOLS
                    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
                    
                    
                    BOOL valid;
                    BOOL valid_symbol;
                    
                    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                    
                    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[OfficePostCode stringByReplacingOccurrencesOfString:@" " withString:@""]];
                    
                    valid = [alphaNums isSupersetOfSet:inStringSet];
                    valid_symbol = [set isSupersetOfSet:inStringSet];
                    OfficePostcodeContinue = false;
                    
                    
                    
                    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
                        NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", OfficePostCode];
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
								
								[ClientProfile setObject:OfficeTown forKey:@"txtOfficeTown"];
								[ClientProfile setObject:Statecode forKey:@"SelectedOfficeStateCode"];
								[ClientProfile setObject:@"MAL" forKey:@"OffCountry"];
                                
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
                        
                        
                        
						//                        rrr = [[UIAlertView alloc] initWithTitle:@"Error"
						//                                                         message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
						//
						//                        rrr.tag = 3001;
						//                        [rrr show];
						//                        rrr=nil;
						ErrMsg = @"Postcode for Office Address is invalid.";
						[txtOfficePostCode becomeFirstResponder];
                        [txtOfficePostCode addTarget:self action:@selector(OfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                        return ErrMsg;
                    }
                    
                }
                
                
                //HOME POSTCODE END
                
            }
            
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
    }
    else{
        //NSString *occupation = [outletOccup.titleLabel.text stringByTrimmingCharactersInSet:
        //                        [NSCharacterSet whitespaceCharacterSet]];
		//NSString *occupation =
        
        
        //Check if baby
        if([OccpCatCode isEqualToString:@"JUV"] && [otherIDType_trim isEqualToString:@"BC"]) {
			
            
			
            
            segGender.enabled = YES;
            if(OtherIDType2.length==0 && IDType.length == 0)
            {
                
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New IC No or Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                rrr.tag = 1003;
				//                [rrr show];
				ErrMsg = @"New IC No or Other ID is required.";
                segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                return ErrMsg;
                
                
                
            }
            else if (OtherIDType2.length==0){
                [txtOtherIDType becomeFirstResponder];
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                rrr.tag = 82;
				//                [rrr show];
				ErrMsg = @"Other ID is required.";
                segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                return ErrMsg;
                
                
            }
        }
        
        
		
        if(([otherIDType_trim isEqualToString:@""] && ![otherIDType_trim isEqualToString:@"OLDIC"]) && ![OccpCatCode isEqualToString:@"JUV"] ){
            
            
            ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
            txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            
            
            if ([otherIDType_trim isEqualToString:@""] && ([IDType isEqualToString:@""] || (IDType.length == 0) )) {
                
				
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New IC No or Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                rrr.tag = 1003;
				//                [rrr show];
                txtIDType.text = @"";
                txtDOB.text = @"";
                segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
				ErrMsg = @"New IC No or Other ID is required.";
                return ErrMsg;
                
            }
            else if([IDType isEqualToString:@""] || (IDType.length == 0) ){
				
                
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New IC No is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                rrr.tag = 1002;
				//                [rrr show];
				ErrMsg = @"New IC No is required.";
                txtIDType.text = @"";
                txtDOB.text = @"";
                segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                return ErrMsg;
                
            }
            
            
            
            
            else  if (IDType.length != 12) {
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New IC No must be 12 digits characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                rrr.tag = 1002;
				//                [rrr show];
				//                rrr=nil;
                
                ErrMsg = @"New IC No must be 12 digits characters.";
                
                return ErrMsg;
            }
            
            else  if (![[IDType stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
                
                
                BOOL valid;
                NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:IDType];
                valid = [alphaNums isSupersetOfSet:inStringSet];
                if (!valid) {
                    
                    rrr = [[UIAlertView alloc] initWithTitle:@" "
                                                     message:@"New IC No must be numeric" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    rrr.tag = 1002;
                    [rrr show];
                    rrr = nil;
                    
                    return ErrMsg;
                }
                
                if (IDType.length != 12) {
					//                    rrr = [[UIAlertView alloc] initWithTitle:@"Error"
					//                                                     message:@"New IC No must be 12 digits characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					//                    rrr.tag = 1002;
					//                    [rrr show];
					//                    rrr = nil;
                    
                    ErrMsg = @"New IC No must be 12 digits characters.";
                    return ErrMsg;
                }
            }
            
            
            //GET DOB
            
            NSString *last = [IDType substringFromIndex:[IDType length] -1];
            NSCharacterSet *oddSet = [NSCharacterSet characterSetWithCharactersInString:@"13579"];
            
            if ([last rangeOfCharacterFromSet:oddSet].location != NSNotFound) {
                NSLog(@"MALE");
                segGender.selectedSegmentIndex = 0;
                gender = @"MALE";
            } else {
                NSLog(@"FEMALE");
                segGender.selectedSegmentIndex = 1;
                gender = @"FEMALE";
            }
            
            
            //CHECK DAY / MONTH / YEAR START
            //get the DOB value from ic entered
            NSString *strDate = [IDType substringWithRange:NSMakeRange(4, 2)];
            NSString *strMonth = [IDType substringWithRange:NSMakeRange(2, 2)];
            NSString *strYear = [IDType substringWithRange:NSMakeRange(0, 2)];
            
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
                
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
				//                rrr.tag = 1002;
				//                [rrr show];
				ErrMsg = @"New IC No not valid.";
                
                if([otherIDType_trim isEqualToString:@"PP"])
                {
                    
                }else{
                    txtDOB.text = @"";
                    segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
                return ErrMsg;
            }
            else if ([strMonth intValue] > 12 || [strMonth intValue] < 1) {
                
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New IC month must be between 1 and 12." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
				//                rrr.tag = 1002;
				//                [rrr show];
				
				ErrMsg = @"New IC month must be between 1 and 12.";
                
                if([otherIDType_trim isEqualToString:@"PP"])
                {
                    
                }else{
                    txtDOB.text = @"";
                    segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
                return ErrMsg;
            }
            else if([strDate intValue] < 1 || [strDate intValue] > 31)
            {
                
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New IC day must be between 1 and 31." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
				//                rrr.tag = 1002;
				//                [rrr show];
                
				ErrMsg = @"New IC day must be between 1 and 31.";
                return ErrMsg;
                
            }
            else if (([strMonth isEqualToString:@"01"] || [strMonth isEqualToString:@"03"] || [strMonth isEqualToString:@"05"] || [strMonth isEqualToString:@"07"] || [strMonth isEqualToString:@"08"] || [strMonth isEqualToString:@"10"] || [strMonth isEqualToString:@"12"]) && [strDate intValue] > 31) {
                
                
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
				//                rrr.tag = 1002;
				//                [rrr show];
                
				ErrMsg = @"New IC No not valid.";
                txtIDType.text = @"";
                if([otherIDType_trim isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    txtDOB.text = @"";
                    segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
                return ErrMsg;
            }
            
            else if (([strMonth isEqualToString:@"04"] || [strMonth isEqualToString:@"06"] || [strMonth isEqualToString:@"09"] || [strMonth isEqualToString:@"11"]) && [strDate intValue] > 30) {
                
                
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
				//                rrr.tag = 1002;
				//                [rrr show];
                
                txtIDType.text = @"";
				ErrMsg = @"New IC No not valid.";
                if([otherIDType_trim isEqualToString:@"PP"])
                {
                    
                }else{
                    txtDOB.text = @"";
                    segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
                
                return ErrMsg;
            }
            else if (([febStatus isEqualToString:@"Normal"] && [strDate intValue] > 28 && [strMonth isEqualToString:@"02"]) || ([febStatus isEqualToString:@"Jump"] && [strDate intValue] > 29 && [strMonth isEqualToString:@"02"])) {
                
                
                NSString *msg = [NSString stringWithFormat:@"February of %@ doesn’t have 29 days",strYear] ;
                
                
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
				//
				//                [rrr show];
                ErrMsg = msg;
                
                if([otherIDType_trim isEqualToString:@"PASSPORT"])
                {
                    
                }else{
                    txtDOB.text = @"";
                    segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                }
                
                return ErrMsg;
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
        //KY - IF USER KEY IN OTHER ID AND IC
        else if(![otherIDType_trim isEqualToString:@"- SELECT -"]  && (txtIDType.text.length > 0 && txtIDType.text.length<12) )
        {
            
			if (IDType.length != 12) {
                
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New IC No must be 12 digits characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                rrr.tag = 1002;
				//                [rrr show];
				//                rrr=nil;
				
				ErrMsg = @"New IC No must be 12 digits characters.";
                return ErrMsg;
            }
        }
		else if(![otherIDType_trim isEqualToString:@""]  && (IDType.length==12) )
        {
			
            //ky
            //get the DOB value from ic entered
			
            NSString *strDate = [IDType substringWithRange:NSMakeRange(4, 2)];
            NSString *strMonth = [IDType substringWithRange:NSMakeRange(2, 2)];
            NSString *strYear = [IDType substringWithRange:NSMakeRange(0, 2)];
            
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
            
            
            NSString *dob_trim = [newDOB stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
			
            //ky - crash bec of  '- SELECT -'
            if(![dob_trim isEqualToString:@"- SELECT -"]){
				NSArray  *temp_dob = [newDOB componentsSeparatedByString:@"/"];
				
				NSString *day = [temp_dob objectAtIndex:0];
				day = [day stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
				NSString *month = [temp_dob objectAtIndex:1];
				NSString *year = [temp_dob objectAtIndex:2];
				
				
				NSString *ic_gender;
				
				NSString *last = [IDType substringFromIndex:[IDType length] -1];
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
					//					rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New IC No does not match with Date of Birth." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
					//					rrr.tag = 1002;
					//					[rrr show];
					//					rrr = nil;
					ErrMsg = @"New IC No does not match with Date of Birth.";
					return ErrMsg;
					
				}
				//				else if(([ic_gender isEqualToString:@"MALE"] && segGender.selectedSegmentIndex !=0) || ([ic_gender isEqualToString:@"FEMALE"] && segGender.selectedSegmentIndex !=1))
				else if(([ic_gender isEqualToString:@"MALE"] && [gender isEqualToString:@"FEMALE"]) || ([ic_gender isEqualToString:@"FEMALE"] && [gender isEqualToString:@"MALE"]))
				{
					
					//					rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New IC No does not match with Gender." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
					//					rrr.tag = 1002;
					//					[rrr show];
					//					rrr = nil;
					ErrMsg = @"New IC No does not match with Gender.";
					return ErrMsg;
				}
            }
            
			
        }
        
        
        if(OtherIDType2.length == 1)
        {
            BOOL error = FALSE;
            NSString *strToBeTest = [OtherIDType2 stringByReplacingOccurrencesOfString:@" " withString:@"" ] ;
            
            for (int i=0; i<strToBeTest.length; i++) {
                int str1=(int)[strToBeTest characterAtIndex:i];
                
                if( str1 ==34 ||  str1 == 38 || str1 == 39 || str1 == 40 || str1 == 41 || str1 == 64 || str1 == 47 || str1 == 45 || str1 == 46){
                    
                    error = TRUE;
                }
            }
            
            if(error)
            {
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Invalid Other ID." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                [alert show];
				//                [txtOtherIDType becomeFirstResponder];
				ErrMsg = @"Invalid Other ID.";
                return ErrMsg;
            }
            
        }
        if ([OtherIDType2 isEqualToString:IDType] && OtherIDType2.length != 0 && IDType.length !=0 )
        {
            
			//            rrr = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                             message:@"Other ID cannot be same as New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            rrr.tag = 81;
			//            [rrr show];
			//            rrr = nil;
			ErrMsg = @"Other ID cannot be same as New IC No.";
            return ErrMsg;
        }
        
        
        
        //Other ID Type as ‘SINGAPOREAN IDENTIFICATION NUMBER’, then the “Nationality” must be “Singaporean”.
        //NSString *otherIDtype = [OtherIDType.titleLabel.text stringByTrimmingCharactersInSet:
		//[NSCharacterSet whitespaceCharacterSet]];
		NSString *otherIDtype = IDTypeCodeSelected;
        
        if ([otherIDtype isEqualToString:@"SID"] && ![nation isEqualToString:@"SINGAPOREAN"]  )
        {
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Nationality must be Singaporean" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            [alert show];
			//            alert.tag= 1005;
			ErrMsg = @"Nationality must be Singaporean";
            return ErrMsg;
        }
        
        //COMPARE THE DATE
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd"];
        NSString *dob =[outletDOB.titleLabel.text stringByTrimmingCharactersInSet:
                        [NSCharacterSet whitespaceCharacterSet]];
        
        
        NSDateFormatter *formatter;
        NSString        *today;
        
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        
        today = [formatter stringFromDate:[NSDate date]];
        
        
        
        if(([[newDOB stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) && ([dob isEqualToString:@"- SELECT -"]) && (!dob.length == 0)){
			//
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Date of Birth is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//
			//            alert.tag = 83;
			//
			//            [alert show];
			ErrMsg = @"Date of Birth is required.";
            return ErrMsg;
        }
		

        
        
        
        if(segGender.selectedSegmentIndex == -1 && ![otherIDType_trim isEqualToString:@"CR"] && ![otherIDType_trim isEqualToString:@"EDD"] ){
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Gender is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            [self resignFirstResponder];
			//            [self.view endEditing:TRUE];
			//            [alert show];
			ErrMsg = @"Gender is required.";
            return ErrMsg;
        }
		
		
		
        if([race isEqualToString:@""] && ![otherIDType_trim isEqualToString:@"EDD"])
        {
			ErrMsg = @"Race is required.";
            return ErrMsg;
        }
        
        //CHECK NATIONALITY
        if([nation isEqualToString:@"- SELECT -"]&& ![otherIDType_trim isEqualToString:@"EDD"])
        {
			//            rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Nationality is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            rrr.tag = 1005;
			//            [rrr show];
            ErrMsg = @"Nationality is required.";
            return ErrMsg;
        }
        else if (IDType.length != 0 && ![nation isEqualToString:@"MALAYSIAN"]) {
            
			//            rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Nationality didn’t match with New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            rrr.tag = 1005;
			//            [rrr show];
            ErrMsg = @"Nationality didn’t match with New IC No.";
            return ErrMsg;
        }
        //check for singaporean
        else if ([otherIDType_trim isEqualToString:@"SID"] && ![nation isEqualToString:@"SINGAPOREAN"]) {
            
			//            rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Nationality didn’t match with Other ID No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            rrr.tag = 1005;
			//            [rrr show];
            ErrMsg = @"Nationality didn’t match with Other ID No.";
            return ErrMsg;
        }
        //check for MALAYSIAN FOR OTHER ID
        //The Nationality must be 'Malaysian'
        
        else if (([otherIDType_trim isEqualToString:@"AN"] || [otherIDType_trim  isEqualToString:@"BC"] || [otherIDType_trim  isEqualToString:@"OLDIC"] || [otherIDType_trim  isEqualToString:@"PN"]) && ![nation isEqualToString:@"MALAYSIAN"]) {
            
			//            rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Nationality didn’t match with Other ID No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            rrr.tag = 1005;
			//            [rrr show];
            ErrMsg = @"Nationality didn’t match with Other ID No.";
            return ErrMsg;
        }
        
        //the Nationality must NOT be “Malaysian
        else if (([otherIDType_trim isEqualToString:@"FBC"] || [otherIDType_trim  isEqualToString:@"FID"] || [otherIDType_trim  isEqualToString:@"PR"]) && [nation isEqualToString:@"MALAYSIAN"]) {
            
			//            rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Nationality didn’t match with Other ID No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            rrr.tag = 1005;
			//            [rrr show];
            ErrMsg = @"Nationality didn’t match with Other ID No.";
            return ErrMsg;
        }
        
        
        //CHECK NATIONALITY
        
        if([nation isEqualToString:@"- SELECT -"]&& ![otherIDType_trim isEqualToString:@"EDD"])
        {
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Nationality is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            alert.tag = 1005;
			//            [alert show];
			ErrMsg = @"Nationality is required";
            return ErrMsg;
        }
        
        //CHECK RELIGION
        if([religion isEqualToString:@""] && ![otherIDType_trim isEqualToString:@"EDD"])
        {
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Religion is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            alert.tag = 1011;
			//            [alert show];
			
			ErrMsg = @"Religion is required";
            return ErrMsg;
        }
        
        
        //CHECK MARITAL STATUS
        if([marital isEqualToString:@""] && ![otherIDType_trim isEqualToString:@"EDD"])
        {
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Marital status is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            alert.tag = 1009;
			//            [alert show];
			ErrMsg = @"Marital status is required.";
            return ErrMsg;
        }
        
        
        
        
        //START CHECK SMOKING
        if((segSmoker.selectedSegmentIndex == -1) && ![otherIDType_trim isEqualToString:@"EDD"])
        {
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Smoking status is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            [self resignFirstResponder];
			//            [self.view endEditing:TRUE];
			//
			//            [alert show];
			ErrMsg = @"Smoking status is required.";
            return ErrMsg;
        }
        
        // CHECK OCCUPATION
        if(([OccupCodeSelected isEqualToString:@""]  && ![otherIDType_trim isEqualToString:@"EDD"]) ||(OccupCodeSelected == NULL && !companyCase && ![otherIDType_trim isEqualToString:@"EDD"])){
            
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Occupation is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//
			//            alert.tag = 84;
			//            [alert show];
			ErrMsg = @"Occupation is required.";
            return ErrMsg;
        }
        
        
        
		//    outletOccup.titleLabel.text = [outletOccup.titleLabel.text stringByTrimmingCharactersInSet:
		//                                  [NSCharacterSet whitespaceCharacterSet]];
        
        
		
        if([OccpCatCode isEqualToString:@"HSEWIFE"]
           ||[OccpCatCode isEqualToString:@"JUV"]
           ||[OccpCatCode isEqualToString:@"RET"]
           ||[OccpCatCode isEqualToString:@"STU"]
           ||[OccpCatCode isEqualToString:@"UNEMP"]
           ||([otherIDType_trim isEqualToString:@"CR"] && OtherIDType2.length != 0)){
            //NSLog(@"here if");
        }
        else{
            
            
            if (ExactDuties.length < 1 && ![otherIDType_trim isEqualToString:@"EDD"])
            {
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Exact duties is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                alert.tag = 1007;
				//                [alert show];
				ErrMsg = @"Exact nature of work is required.";
                return ErrMsg;
            }
            
            else if (ExactDuties.length > 40) {
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Invalid Exact Duties length. Only 40 characters allowed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                alert.tag = 1007;
				//                [alert show];
				ErrMsg = @"Invalid Exact Duties length. Only 40 characters allowed";
                return ErrMsg;
            }
            
            
            if ([BussinessType isEqualToString:@""] && [otherIDType_trim isEqualToString:@"CR"]) {
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Type of business is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                alert.tag=2060;
				//                [alert show];
				ErrMsg = @"Type of business is required";
                return ErrMsg;
            }
            
            
            if (BussinessType.length > 60 && ![otherIDType_trim isEqualToString:@"CR"]) {
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Invalid Type of Business length. Only 60 characters allowed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                alert.tag=2060;
				//                [alert show];
				ErrMsg = @"Invalid Type of Business length. Only 60 characters allowed";
                return ErrMsg;
            }
            
            NSString * AI = [annualIncome_original stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceCharacterSet]];
            
            NSArray  *comp = [AI componentsSeparatedByString:@"."];
            
            
            
            int AI_Length = [[comp objectAtIndex:0] length];
            
            if ([AnnIncome isEqualToString:@""] && ![otherIDType_trim isEqualToString:@"EDD"]) {
                
                
                if((![OccpCatCode isEqualToString:@"HSEWIFE"])
                   && (![OccpCatCode isEqualToString:@"JUV"])
                   && (![OccpCatCode isEqualToString:@"RET"])
                   && (![OccpCatCode isEqualToString:@"STU"])
                   && (![OccpCatCode isEqualToString:@"UNEMP"])) {
                    
                    
					//
					//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
					//                                                                    message:@"Annual Income is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    txtAnnIncome.enabled = true;
                    txtAnnIncome.backgroundColor = [UIColor whiteColor];
                    //alert.tag = 1008;
                    //[alert show];
                    
                    //alert = nil;
					ErrMsg = @"Annual Income is required.";
                    return ErrMsg;
                }
                
                
                
                
            }
            
            
            else if (AI_Length >13  && ![otherIDType_trim isEqualToString:@"EDD"]) {
                
                
                if((![OccpCatCode isEqualToString:@"HSEWIFE"])
                   && (![OccpCatCode isEqualToString:@"JUV"])
                   && (![OccpCatCode isEqualToString:@"RET"])
                   && (![OccpCatCode isEqualToString:@"STU"])
                   && (![OccpCatCode isEqualToString:@"UNEMP"])) {
                    
					//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
					//                                                                    message:@"Annual income must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					//                    alert.tag = 1008;
					//                    [alert show];
					//
					//                    alert=nil;
					ErrMsg = @"Annual income must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points.";
                    return ErrMsg;
                }
            }
            else if(AI_Length < 13 && annual_income == 0 && ![otherIDType_trim isEqualToString:@"EDD"])
            {
				//
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                 message:@"Annual income must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                rrr.tag = 1008;
				//                [rrr show];
				//                rrr = nil;
                ErrMsg = @"Annual income must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points.";
                return ErrMsg;
            }
        }
        
        if(checked){
            NSString *homecountry = [btnHomeCountry.titleLabel.text stringByTrimmingCharactersInSet:
									 [NSCharacterSet whitespaceCharacterSet]];
            if(home1_trim.length==0 && ![otherIDType_trim isEqualToString:@"EDD"] )
            {
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Home Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                alert.tag = 1012;
				//
				//                [alert show];
				ErrMsg = @"Residential Address is required.";
                return ErrMsg;
                
            }
			
            else if([HomeCountry isEqualToString:@"- SELECT -"] || [HomeCountry isEqualToString:@"MAL"])
            {
                
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Country for Home address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                alert.tag=5001;
				//                [alert show];
				ErrMsg = @"Country for residential address is required.";
                return ErrMsg;
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
                
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                 message:@"Annual income must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                rrr.tag = 1008;
				//                [rrr show];
				//                rrr = nil;
                ErrMsg = @"Annual income must be numerical value. It must be greater than zero, maximum 13 digits with 2 decimal points.";
                return ErrMsg;
                
            }
			
            
            if((home1_trim.length==0 && ![otherIDType_trim isEqualToString:@"EDD"]))
            {
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Home Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                alert.tag = 1012;
				//
				//                [alert show];
				ErrMsg = @"Residential Address is required.";
                return ErrMsg;
                
            }else if ([HomePostCode isEqualToString:@""] && ![otherIDType_trim isEqualToString:@"EDD"])
            {
                if (homePostcode_trim.length==0) {
                    
                    
					//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
					//                                                                    message:@"Postcode for home address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					//                    alert.tag=2000;
					//
					//                    [alert show];
					ErrMsg = @"Postcode for Residential address is required.";
                    return ErrMsg;
                }else if (home1_trim.length==0){
                    
					//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
					//                                                                    message:@"Home address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					//                    alert.tag = 1012;
					//
					//                    [alert show];
					ErrMsg = @"Residential Address is required.";
                    return ErrMsg;
                }
                
            }
			//            else if (![txtHomePostCode.text isEqualToString:@""] && ![otherIDType_trim isEqualToString:@"EDD"])
			//            {
			else if (![HomePostCode isEqualToString:@""] && ![otherIDType_trim isEqualToString:@"EDD"])
			{
                
                //HOME POSTCODE START
                //CHECK INVALID SYMBOLS
                NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
                
                HomePostcodeContinue = false;
                BOOL valid;
                BOOL valid_symbol;
                
                NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                
                NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[HomePostCode stringByReplacingOccurrencesOfString:@" " withString:@""]];
                
                valid = [alphaNums isSupersetOfSet:inStringSet];
                valid_symbol = [set isSupersetOfSet:inStringSet];
                
                //NSLog(@"valid_symbol - %i", valid_symbol);
                
                if(HomePostCode.length < 5)
                {
					//                    rrr = [[UIAlertView alloc] initWithTitle:@"Error"
					//                                                     message:@"Postcode for Home Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					//
					//                    rrr.tag = 2001;
					//                    [rrr show];
					//                    rrr=nil;
					ErrMsg = @"Postcode for Residential Address is invalid.";
                    return ErrMsg;
                }
				
                else if (!valid_symbol) {
                    txtHomeState.text=@"";
                    txtHomeState.text = @"";
					//                    rrr = [[UIAlertView alloc] initWithTitle:@"Error"
					//                                                     message:@"Postcode for Home Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					//
					//                    rrr.tag = 2001;
					//                    [rrr show];
					//                    rrr=nil;
					ErrMsg = @"Postcode for Residential Address is invalid.";
                    return ErrMsg;
                    
                }
                
                
                else if (!valid) {
                    txtHomeState.text=@"";
                    txtHomeState.text = @"";
					//                    rrr = [[UIAlertView alloc] initWithTitle:@"Error"
					//                                                     message:@"Postcode for Home Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					//
					//                    rrr.tag = 2001;
					//                    [rrr show];
					//
					//                    rrr=nil;
                    
                    txtHomeState.text = @"";
                    txtHomeTown.text = @"";
                    txtHomeCountry.text = @"";
                    SelectedStateCode = @"";
                    HomePostcodeContinue = FALSE;
                    
					ErrMsg = @"Postcode for Residential Address is invalid.";
                    return ErrMsg;
                }
                else{
                    
                    BOOL gotRow = false;
                    const char *dbpath = [databasePath UTF8String];
                    sqlite3_stmt *statement;
                    
                    
                    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
                        NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", HomePostCode];
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
								
								[ClientProfile setObject:Town forKey:@"txtHomeTown"];
								[ClientProfile setObject:Statecode forKey:@"SelectedStateCode"];
								[ClientProfile setObject:@"MAL" forKey:@"HomeCountry"];
                                
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
					
                    if(!HomePostcodeContinue)
                    {
                        txtHomeState.text = @"";
                        txtHomeTown.text = @"";
                        txtHomeCountry.text = @"";
                        SelectedStateCode = @"";
                        
                        
                        txtHomeState.text=@"";
                        txtHomeState.text = @"";
						//                        rrr = [[UIAlertView alloc] initWithTitle:@"Error"
						//                                                         message:@"Postcode for Home Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
						//
						//                        rrr.tag = 2001;
						//                        [rrr show];
						//                        rrr=nil;
                        [txtHomePostCode addTarget:self action:@selector(EditTextFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
						
						ErrMsg = @"Postcode for Residential Address is invalid.";
                        return ErrMsg;
                        
                        
                    }
                    
                    
                }
                //HOME POSTCODE END
				
            }
			
            
        }
        
        //office post code  end
        
        // Office address
        // Added by Benjamin Law on 17/10/2013 for bug 2561
        
		
        if(![OccpCatCode isEqualToString:@"HSEWIFE"]
		   && ![OccpCatCode isEqualToString:@"JUV"]
		   && ![OccpCatCode isEqualToString:@"UNEMP"]
		   && ![OccpCatCode isEqualToString:@"STU"]) {
            
            if(checked2){
				//                NSString *officecountry = [btnOfficeCountry.titleLabel.text stringByTrimmingCharactersInSet:
				//                                           [NSCharacterSet whitespaceCharacterSet]];
				//
                
                if([office1_trim isEqualToString:@""] && ![otherIDType_trim isEqualToString:@"EDD"])
                {
                    
					//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
					//                                                                    message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					//
                    //alert.tag = 2002;
					//                    [alert show];
					ErrMsg = @"Office Address is required.";
					
                    return ErrMsg;
                    
                }
                if([OffCountry isEqualToString:@"- SELECT -"] || [OffCountry isEqualToString:@"MAL"] || [OffCountry isEqualToString:@""])
                {
					
					//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
					//                                                                    message:@"Country for office address is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					//
					//                    alert.tag=5002;
					//                    [alert show];
					ErrMsg = @"Country for office address is required";
                    return ErrMsg;
                }
                
            }
            else{
                
				if (![OfficePostCode isEqualToString:@""] && ![otherIDType_trim isEqualToString:@"EDD"])
                {
                    
                    //HOME POSTCODE START
                    //CHECK INVALID SYMBOLS
                    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
                    
                    
                    BOOL valid;
                    BOOL valid_symbol;
                    
                    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                    
                    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[OfficePostCode stringByReplacingOccurrencesOfString:@" " withString:@""]];
                    
                    valid = [alphaNums isSupersetOfSet:inStringSet];
                    valid_symbol = [set isSupersetOfSet:inStringSet];
                    
                    
                    if(OfficePostCode.length < 5)
                    {
                        txtOfficeState.text = @"";
                        txtOfficeTown.text = @"";
						//                        rrr = [[UIAlertView alloc] initWithTitle:@"Error"
						//                                                         message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
						//
						//                        rrr.tag = 3001;
						//                        [rrr show];
						//                        rrr=nil;
                        ErrMsg = @"Postcode for Office Address is invalid.";
                        return ErrMsg;
                    }
					
					else if (!valid_symbol) {
                        
                        txtOfficeState.text = @"";
                        txtOfficeTown.text = @"";
						//                        rrr = [[UIAlertView alloc] initWithTitle:@"Error"
						//                                                         message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
						//
						//                        rrr.tag = 3001;
						//                        [rrr show];
						//                        rrr=nil;
                        ErrMsg = @"Postcode for Office Address is invalid.";
                        return ErrMsg;
                        
                    }
                    
                    
                    else if (!valid) {
                        
						//                        rrr = [[UIAlertView alloc] initWithTitle:@"Error"
						//                                                         message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
						//
						//                        rrr.tag = 3001;
						//                        [rrr show];
						//
						//                        rrr=nil;
                        
                        txtHomeState.text = @"";
                        txtHomeTown.text = @"";
                        txtHomeCountry.text = @"";
                        SelectedStateCode = @"";
						
						ErrMsg = @"Postcode for Office Address is invalid.";
                        return ErrMsg;
                    }
                    else{
                        const char *dbpath = [databasePath UTF8String];
                        sqlite3_stmt *statement;
                        
                        OfficePostCode = [OfficePostCode stringByReplacingOccurrencesOfString:@" " withString:@""];
                        
                        //CHECK INVALID SYMBOLS
                        NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
                        
                        
                        BOOL valid;
                        BOOL valid_symbol;
                        
                        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                        
                        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[OfficePostCode stringByReplacingOccurrencesOfString:@" " withString:@""]];
                        
                        valid = [alphaNums isSupersetOfSet:inStringSet];
                        valid_symbol = [set isSupersetOfSet:inStringSet];
                        OfficePostcodeContinue = false;
                        
                        
                        
                        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
                            NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", OfficePostCode];
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
									
									[ClientProfile setObject:OfficeTown forKey:@"txtOfficeTown"];
									[ClientProfile setObject:Statecode forKey:@"SelectedOfficeStateCode"];
									[ClientProfile setObject:@"MAL" forKey:@"OffCountry"];
									
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
                            
                            
                            
							//                            rrr = [[UIAlertView alloc] initWithTitle:@"Error"
							//                                                             message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
							//
							//                            rrr.tag = 3001;
							//                            [rrr show];
							//                            rrr=nil;
							ErrMsg = @"Postcode for Office Address is invalid.";
                            [txtOfficePostCode addTarget:self action:@selector(EditOfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
                            return ErrMsg;
                            
                            
                        }
                        
                    }
                    
                    
                    //HOME POSTCODE END
                    
                }
                
                
                
            }
            
        }
        //KY - IF USER KEY IN OFFICE ADDRESS PARTIALLY, SYSTEM SHOULD CHECK ON THIS
        else if (([OccpCatCode isEqualToString:@"HSEWIFE"]
				  ||[OccpCatCode isEqualToString:@"JUV"]
				  ||[OccpCatCode isEqualToString:@"RET"]
				  ||[OccpCatCode isEqualToString:@"STU"]
				  ||[OccpCatCode isEqualToString:@"UNEMP"]) && (![OfficeAddr1 isEqualToString:@""] || ![OfficePostCode isEqualToString:@""]))
        {
            
			//KY ADD FOR FOREIGN COUNTRY CHECKING START
            
            
            
            if(checked2){
                
                
                NSString *officecountry = [btnOfficeCountry.titleLabel.text stringByTrimmingCharactersInSet:
                                           [NSCharacterSet whitespaceCharacterSet]];
                
                if(office1_trim.length==0  && ![otherIDType_trim isEqualToString:@"EDD"])
                {
                    
					//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
					//                                                                    message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					//
					//                    alert.tag = 2002;
					//                    [alert show];
					ErrMsg = @"Office Address is required.";
                    return ErrMsg;
                    
                }
                if([officecountry isEqualToString:@""])
                {
					//
					//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
					//                                                                    message:@"Country for office address is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					//                    alert.tag=5002;
					//
					//                    [alert show];
					ErrMsg = @"Country for office address is required";
                    return ErrMsg;
                }
                
            }
			else
			{
				
				if((office1_trim.length!=0 || ![OfficeAddr2 isEqualToString:@""] ||![OfficeAddr3 isEqualToString:@""] ) && officePostcode_trim.length==0)
				{
					
					//					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
					//																	message:@"Postcode for Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					//					alert.tag = 3001;
					//
					//					[alert show];
					ErrMsg = @"Postcode for Office Address is required.";
					return ErrMsg;
					
				}
				else  if(office1_trim.length==0   && ![txtOfficePostCode.text isEqualToString:@""])
					
				{
					//					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
					//																	message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					//					alert.tag = 2002;
					//					[alert show];
					ErrMsg = @"Office Address is required.";
					return ErrMsg;
					
				}
				else if (![OfficePostCode isEqualToString:@""] && ![otherIDType_trim isEqualToString:@"EDD"])
				{
					
					//HOME POSTCODE START
					//CHECK INVALID SYMBOLS
					NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
					
					
					BOOL valid;
					BOOL valid_symbol;
					
					NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
					
					NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtOfficePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
					
					valid = [alphaNums isSupersetOfSet:inStringSet];
					valid_symbol = [set isSupersetOfSet:inStringSet];
					
					
					if(txtOfficePostCode.text.length < 5)
					{
						txtOfficeState.text = @"";
						txtOfficeTown.text = @"";
						//						rrr = [[UIAlertView alloc] initWithTitle:@"Error"
						//														 message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
						//
						//						rrr.tag = 3001;
						//						[rrr show];
						//						rrr=nil;
						ErrMsg = @"Postcode for Office Address is invalid.";
						return ErrMsg;
					}
					
					
					else if (!valid_symbol) {
						
						txtOfficeState.text = @"";
						txtOfficeTown.text = @"";
						//						rrr = [[UIAlertView alloc] initWithTitle:@"Error"
						//														 message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
						//
						//						rrr.tag = 3001;
						//						[rrr show];
						//						rrr=nil;
						ErrMsg = @"Postcode for Office Address is invalid.";
						return ErrMsg;
						
					}
					
					
					else if (!valid) {
						
						//						rrr = [[UIAlertView alloc] initWithTitle:@"Error"
						//														 message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
						//
						//						rrr.tag = 3001;
						//						[rrr show];
						//
						//						rrr=nil;
						ErrMsg = @"Postcode for Office Address is invalid.";
						txtHomeState.text = @"";
						txtHomeTown.text = @"";
						txtHomeCountry.text = @"";
						SelectedStateCode = @"";
						return false;
					}
					else{
						const char *dbpath = [databasePath UTF8String];
						sqlite3_stmt *statement;
						
						OfficePostCode = [OfficePostCode stringByReplacingOccurrencesOfString:@" " withString:@""];
						
						//CHECK INVALID SYMBOLS
						NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"'@/-.=!`#$%&*()<>?:]["] invertedSet];
						
						
						BOOL valid;
						BOOL valid_symbol;
						
						NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
						
						NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[OfficePostCode stringByReplacingOccurrencesOfString:@" " withString:@""]];
						
						valid = [alphaNums isSupersetOfSet:inStringSet];
						valid_symbol = [set isSupersetOfSet:inStringSet];
						OfficePostcodeContinue = false;
						
						
						
						if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
							NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", txtOfficePostCode.text];
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
									
									[ClientProfile setObject:OfficeTown forKey:@"txtOfficeTown"];
									[ClientProfile setObject:Statecode forKey:@"SelectedOfficeStateCode"];
									[ClientProfile setObject:@"MAL" forKey:@"OffCountry"];
									
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
							
							
							
							//							rrr = [[UIAlertView alloc] initWithTitle:@"Error"
							//															 message:@"Postcode for Office Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
							//
							//							rrr.tag = 3001;
							//							[rrr show];
							//							rrr=nil;
							[txtOfficePostCode addTarget:self action:@selector(EditOfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
							ErrMsg = @"Postcode for Office Address is invalid.";
							return ErrMsg;
							
							
						}
						
					}
					
					
					//HOME POSTCODE END
					
				}
				
				
				
			}
		}
		
		
        
        
    }
    
	//######office address#######
    if(checked2){
        NSString *officecountry = [btnOfficeCountry.titleLabel.text  stringByTrimmingCharactersInSet:
								   [NSCharacterSet whitespaceCharacterSet]];
        
        if(office1_trim.length==0 && ![otherIDType_trim isEqualToString:@"EDD"])
        {
            
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            alert.tag = 2002;
			//            [alert show];
			ErrMsg = @"Office Address is required.";
            return ErrMsg;
            
        }
        if([officecountry isEqualToString:@"- SELECT -"])
        {
            
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Country for office address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            alert.tag=5002;
			//
			//            [alert show];
			ErrMsg = @"Country for office address is required.";
            return ErrMsg;
        }
        
    }
    
    
    else  if((![OccpCatCode isEqualToString:@"HSEWIFE"])
             && (![OccpCatCode isEqualToString:@"JUV"])
             && (![OccpCatCode isEqualToString:@"RET"])
             && (![OccpCatCode isEqualToString:@"STU"])
             && (![OccpCatCode isEqualToString:@"UNEMP"])) {
        
        
        if(office1_trim.length==0 && ![otherIDType_trim isEqualToString:@"EDD"])
        {
            
            
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Office Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            alert.tag = 2002;
			//            [alert show];
			ErrMsg = @"Office Address is required.";
            return ErrMsg;
            
        }else if (office1_trim.length!=0 && ![otherIDType_trim isEqualToString:@"EDD"])
        {
			if(officePostcode_trim.length ==0){
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Postcode for Office Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                alert.tag = 3001;
				//				[txtOfficePostCode becomeFirstResponder];
				//                [alert show];
				ErrMsg = @"Postcode for Office Address is required.";
                return ErrMsg;
            }
            
        }
        
    }
    //######office address#######
    
    if([Prefix1 isEqualToString:@""]&&[Contact1 isEqualToString:@""]&&[Prefix2 isEqualToString:@""]&&[Contact2 isEqualToString:@""]&&[Prefix3 isEqualToString:@""]&&[Contact3 isEqualToString:@""]&&[Prefix4 isEqualToString:@""]&&[Contact4 isEqualToString:@""] && ![otherIDType_trim isEqualToString:@"EDD"])
    {
        
		//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
		//                                                        message:@"Please enter at least one of the Contact Number (Home, Office, Mobile, Fax)" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		//
		//        alert.tag = 2003;
		//        [alert show];
		ErrMsg = @"Please enter at least one of the contact numbers (Residential, Office, Mobile or Fax).";
        return ErrMsg;
        
    }
    else{
        
        //##Contact######
        
        //Home number
        
        
        if (![Prefix1 isEqualToString:@""])
        {
            
            if(Prefix1.length > 4) {
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Prefix length cannot be more than 4 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                alert.tag=2003;
				//
				//                [alert show];
				ErrMsg = @"Prefix length cannot be more than 4 characters";
                return ErrMsg;
            }
            
            
            NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init] ;
            
            NSNumber* prefix1 = [numberFormatter numberFromString:Prefix1];
            
            NSNumber* contact1 = [numberFormatter numberFromString:Contact1];
            
            
            //KY START
            
            
            BOOL valid;
            BOOL valid2;
            NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
            NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:Contact1];
            NSCharacterSet *inStringSet2 = [NSCharacterSet characterSetWithCharactersInString:Prefix1];
            
            valid = [alphaNums isSupersetOfSet:inStringSet];
            valid2 = [alphaNums isSupersetOfSet:inStringSet2];
            if (!valid2) {
                
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                alert.tag = 2003;
				//
				//                [alert show];
				ErrMsg = @"Input must be integer.";
                return ErrMsg;
            }
            
            if (!valid) {
                
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                alert.tag= 2004;
				//                [alert show];
				ErrMsg = @"Input must be integer.";
                return ErrMsg;
            }
            
            //KY END
            
            
            
            if([Contact1 isEqualToString:@""]){
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Home contact number length must be 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                alert.tag=2004;
				//                [alert show];
				ErrMsg = @"Residential number’s length must be at least 6 digits or more.";
                return ErrMsg;
                
                
            }
            else if (Contact1.length < 6) {
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Home contact number length must be 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                alert.tag=2004;
				//                [alert show];
				ErrMsg = @"Residential number’s length must be at least 6 digits or more.";
                return ErrMsg;
            }
            
            else if(prefix1==nil)
            {
				//                rrr  = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                rrr.tag=2003;
				//                [rrr show];
				//                rrr = nil;
				ErrMsg = @"Input must be integer.";
                return ErrMsg;
            }
            
            else  if(contact1==nil)
            {
				//                rrr  = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                rrr.tag=2004;
				//                [rrr show];
				//                rrr = nil;
				ErrMsg = @"Input must be integer.";
                return ErrMsg;
            }
            
            
        }
        else{
            
            if(![Contact1 isEqualToString:@""]){
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Prefix for Home contact is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//
				//                alert.tag=2003;
				//                [alert show];
				ErrMsg = @"Prefix for residential number is required.";
                return ErrMsg;
            }
            
        }
        
        //#####mobile number#####
        
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init] ;
        
        NSNumber* prefix2 = [numberFormatter numberFromString:Prefix2];
        
        NSNumber* contact2 = [numberFormatter numberFromString:Contact2];
        
        if (![Prefix2 isEqualToString:@""])
        {
            
            if(Prefix2.length > 4) {
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Prefix length cannot be more than 4 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                alert.tag=2005;
				//
				//                [alert show];
				ErrMsg = @"Prefix length cannot be more than 4 characters";
                return ErrMsg;
            }
            
            BOOL valid;
            BOOL valid2;
            NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
            NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:Contact2];
            NSCharacterSet *inStringSet2 = [NSCharacterSet characterSetWithCharactersInString:Prefix2];
            
            valid = [alphaNums isSupersetOfSet:inStringSet];
            valid2 = [alphaNums isSupersetOfSet:inStringSet2];
            if (!valid2) {
                
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                alert.tag = 2005;
				//
				//                [alert show];
				ErrMsg = @"Input must be integer.";
                return ErrMsg;
            }
            
            if (!valid) {
                
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                alert.tag= 2006;
				//                [alert show];
				ErrMsg = @"Input must be integer.";
                return ErrMsg;
            }
            
            
            
            
            if([Contact2 isEqualToString:@""]){
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Mobile contact number length must be 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                alert.tag=2006;
				//                [alert show];
				ErrMsg = @"Mobile number’s length must be at least 6 digits or more.";
                return ErrMsg;
                
                
            }
            else if (Contact2.length < 6) {
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Mobile contact number length must be 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                alert.tag=2006;
				//                [alert show];
				ErrMsg = @"Mobile number’s length must be at least 6 digits or more.";
                return ErrMsg;
            }
            
            
            else if(prefix2==nil)
            {
				//                rrr  = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                rrr.tag=2003;
				//                [rrr show];
				//                rrr = nil;
				ErrMsg = @"Input must be integer.";
                return ErrMsg;
            }
            
            else  if(contact2==nil)
            {
				//                rrr  = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                rrr.tag=2004;
				//                [rrr show];
				//                rrr = nil;
				ErrMsg = @"Input must be integer.";
                return ErrMsg;
            }
            
            
            
            
        }
        else{
            if(![Contact2 isEqualToString:@""]){
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Prefix for Mobile contact is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//
				//                alert.tag=2005;
				//                [alert show];
				ErrMsg = @"Prefix for mobile number is required.";
                return ErrMsg;
            }
        }
        
        
        //####office number
        
        if (![Prefix3 isEqualToString:@""])
        {
            
            if(Prefix3.length > 4) {
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Prefix length cannot be more than 4 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                alert.tag=2007;
				//
				//                [alert show];
				ErrMsg = @"Prefix length cannot be more than 4 characters";
                return ErrMsg;
            }
            
            NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init] ;
            
            NSNumber* prefix3 = [numberFormatter numberFromString:Prefix3];
            
            NSNumber* contact3 = [numberFormatter numberFromString:Contact3];
            
            BOOL valid;
            BOOL valid2;
            NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
            NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:Contact3];
            NSCharacterSet *inStringSet2 = [NSCharacterSet characterSetWithCharactersInString:Prefix3];
            
            valid = [alphaNums isSupersetOfSet:inStringSet];
            valid2 = [alphaNums isSupersetOfSet:inStringSet2];
            if (!valid2) {
                
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                 message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                rrr.tag =2007;
				//                [rrr show];
				ErrMsg = @"Input must be integer.";
                return ErrMsg;
            }
            
            if (!valid) {
                
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                 message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                rrr.tag = 2008;
				//                [rrr show];
				ErrMsg = @"Input must be integer.";
                return ErrMsg;
            }
            
            
            
            
            if([Contact3 isEqualToString:@""]){
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Office contact number length must be 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                alert.tag=2008;
				//                [alert show];
				ErrMsg = @"Office number’s length must be at least 6 digits or more.";
                return ErrMsg;
                
                
            }
            else if (Contact3.length < 6) {
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                 message:@"Office contact number length must be 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                rrr.tag = 2008;
				//                [rrr show];
				ErrMsg = @"Office number’s length must be at least 6 digits or more.";
                return ErrMsg;
            }
            
            
            else if(prefix3==nil)
            {
				//                rrr  = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                rrr.tag=2007;
				//                [rrr show];
				//                rrr = nil;
				ErrMsg = @"Input must be integer.";
                return ErrMsg;
            }
            
            else  if(contact3==nil)
            {
				//                rrr  = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                rrr.tag=2008;
				//                [rrr show];
				//                rrr = nil;
				ErrMsg = @"Input must be integer.";
                return ErrMsg;
            }
            
            
            
            
        }
        else{
            if(![Contact3 isEqualToString:@""]){
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Prefix for Office contact is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//
				//                alert.tag=2007;
				//                [alert show];
				ErrMsg = @"Prefix for office number is required.";
                return ErrMsg;
            }
        }
        
        
        //####office fax number
        
        if (![Prefix4 isEqualToString:@""])
        {
            
            if(Prefix4.length > 4) {
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Prefix length cannot be more than 4 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                alert.tag=2009;
				//
				//                [alert show];
				ErrMsg = @"Prefix length cannot be more than 4 characters";
                return ErrMsg;
            }
            
            NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init] ;
            
            NSNumber* prefix4 = [numberFormatter numberFromString:Prefix4];
            
            NSNumber* contact4 = [numberFormatter numberFromString:Contact4];
            
            
            BOOL valid;
            BOOL valid2;
            NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
            NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:Contact4];
            NSCharacterSet *inStringSet2 = [NSCharacterSet characterSetWithCharactersInString:Prefix4];
            
            valid = [alphaNums isSupersetOfSet:inStringSet];
            valid2 = [alphaNums isSupersetOfSet:inStringSet2];
            if (!valid2) {
                
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                 message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                rrr.tag=2009;
				//
				//                [rrr show];
				ErrMsg = @"Input must be integer.";
                return ErrMsg;
            }
            
            
            
            if (!valid) {
                
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                 message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                rrr.tag =2010;
				//
				//                [rrr show];
				ErrMsg = @"Input must be integer.";
                return ErrMsg;
            }
            
            
            
            if([Contact4 isEqualToString:@""]){
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Fax number length must be 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//                alert.tag=2010;
				//                [alert show];
				ErrMsg = @"Fax number’s length must be at least 6 digits or more.";
                return ErrMsg;
                
                
            }
            else if (Contact4.length < 6) {
				//                rrr = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                 message:@"Fax number length must be 6 digits or more" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                rrr.tag = 2010;
				//
				//                [rrr show];
				ErrMsg = @"Fax number’s length must be at least 6 digits or more.";
                return ErrMsg;
            }
            
            
            else if(prefix4==nil)
            {
				//                rrr  = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                rrr.tag=2003;
				//                [rrr show];
				//                rrr = nil;
				ErrMsg = @"Input must be integer.";
                return ErrMsg;
            }
            
            else  if(contact4==nil)
            {
				//                rrr  = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                  message:@"Input must be integer." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//                rrr.tag=2004;
				//                [rrr show];
				//                rrr = nil;
				ErrMsg = @"Input must be integer.";
                return ErrMsg;
            }
            
            
            
            
        }
        else{
            if(![Contact4 isEqualToString:@""]){
				//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
				//                                                                message:@"Prefix for Fax is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				//
				//
				//                alert.tag=2009;
				//                [alert show];
				ErrMsg = @"Prefix for fax number is required.";
                return ErrMsg;
            }
            
            
        }
        
        
    }
    
    
    
    if(![Email isEqualToString:@""]){
        if( [self NSStringIsValidEmail:Email] == FALSE){
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"You have entered an invalid email." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//
			//            alert.tag = 2050;
			//
			//            [alert show];
			ErrMsg = @"You have entered an invalid email. Please key in the correct email.";
            return ErrMsg;
        }
        
        if (Email.length > 40) {
			//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
			//                                                            message:@"Invalid Email length. Only 40 characters allowed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			//            alert.tag = 2050;
			//            [alert show];
			ErrMsg = @"Invalid Email length. Only 40 characters allowed";
            return ErrMsg;
        }
    }
    
    
    return ErrMsg;
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


#pragma mark - delegate

-(void)GenerateDOB {
	txtIDType.text = [txtIDType.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
	if(txtIDType.text.length == 12)
    {
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtIDType.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
        valid = [alphaNums isSupersetOfSet:inStringSet];
        if (!valid) {
            
            
            rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No must be in numeric" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            rrr.tag = 1002;
            [rrr show];
        }
        else {
            
			
			
            NSString *last = [txtIDType.text substringFromIndex:[txtIDType.text length] -1];
            NSCharacterSet *oddSet = [NSCharacterSet characterSetWithCharactersInString:@"13579"];
            //CANT CHANGE THE GENDER VIA IC IN EDIT
			/*
			 if ([last rangeOfCharacterFromSet:oddSet].location != NSNotFound) {
			 
			 segGender.selectedSegmentIndex = 0;
			 gender = @"MALE";
			 } else {
			 NSLog(@"FEMALE");
			 segGender.selectedSegmentIndex = 1;
			 gender = @"FEMALE";
			 }
			 
			 */
            //get the DOB value from ic entered
            NSString *strDate = [txtIDType.text substringWithRange:NSMakeRange(4, 2)];
            NSString *strMonth = [txtIDType.text substringWithRange:NSMakeRange(2, 2)];
            NSString *strYear = [txtIDType.text substringWithRange:NSMakeRange(0, 2)];
            
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
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                rrr.tag = 1002;
                [rrr show];
                
            }
            else if ([strMonth intValue] > 12 || [strMonth intValue] < 1) {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC month must be between 1 and 12." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                rrr.tag = 1002;
                [rrr show];
                
            }
            else if([strDate intValue] < 1 || [strDate intValue] > 31)
            {
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC day must be between 1 and 31." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                rrr.tag = 1002;
                [rrr show];
                
                
                
            }
            else if (([strMonth isEqualToString:@"01"] || [strMonth isEqualToString:@"03"] || [strMonth isEqualToString:@"05"] || [strMonth isEqualToString:@"07"] || [strMonth isEqualToString:@"08"] || [strMonth isEqualToString:@"10"] || [strMonth isEqualToString:@"12"]) && [strDate intValue] > 31) {
                
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                rrr.tag = 1002;
                [rrr show];
                
				
				
            }
            
            else if (([strMonth isEqualToString:@"04"] || [strMonth isEqualToString:@"06"] || [strMonth isEqualToString:@"09"] || [strMonth isEqualToString:@"11"]) && [strDate intValue] > 30) {
                
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                rrr.tag = 1002;
                [rrr show];
                
            }
            else if (([febStatus isEqualToString:@"Normal"] && [strDate intValue] > 28 && [strMonth isEqualToString:@"02"]) || ([febStatus isEqualToString:@"Jump"] && [strDate intValue] > 29 && [strMonth isEqualToString:@"02"])) {
                
                
                NSString *msg = [NSString stringWithFormat:@"February of %@ doesn’t have 29 days",strYear] ;
                
                
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                
                [rrr show];
                
            }
			
			txtDOB.text = strDOB;
			
            last = nil, oddSet = nil;
            strDate = nil, strMonth = nil, strYear = nil, currentYear = nil, strCurrentYear = nil;
            dateFormatter = Nil, strDOB = nil, strDOB2 = nil, d = Nil, d2 = Nil;
        }
        
        alphaNums = nil, inStringSet = nil;
    }
	else if (txtIDType.text.length > 0 && txtIDType.text.length < 12) {
		rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No must be 12 digits characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		rrr.tag = 1002;
		[rrr show];
		rrr = nil;
		
	}
    
	//  [txtIDType removeTarget:self action:@selector(NewICDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    
    self.navigationItem.rightBarButtonItem.enabled = TRUE;
}


-(void)SelectedCountry:(NSString *)theCountry
{
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
    if (isOffCountry) {
        
        if([theCountry isEqualToString:@"- SELECT -"])
            btnOfficeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        else
            
            btnOfficeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		
        [btnOfficeCountry setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",theCountry] forState:UIControlStateNormal];
        
        [self.CountryListPopover dismissPopoverAnimated:YES];
		
		NSString *OffCountry = @"";
		OffCountry = theCountry;
		OffCountry = [self getCountryCode:OffCountry];
		[ClientProfile setObject:OffCountry forKey:@"OffCountry"];
    }
    else if (isHomeCountry) {
        if([theCountry isEqualToString:@"- SELECT -"])
            btnHomeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        else
            btnHomeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		
        [btnHomeCountry setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",theCountry] forState:UIControlStateNormal];
        
        [self.CountryListPopover dismissPopoverAnimated:YES];
		
		NSString *HomeCountry = @"";
		HomeCountry = theCountry;
		HomeCountry = [self getCountryCode:HomeCountry];
		[ClientProfile setObject:HomeCountry forKey:@"HomeCountry"];
    }

    
    isOffCountry = NO;
    isHomeCountry = NO;

	
	edited = YES;
	
	
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
	[ClientProfile setObject:@"YES" forKey:@"HasChanged"];
}


-(void)Selected2Country:(NSString *)theCountry
{
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
   
		if([theCountry isEqualToString:@"- SELECT -"])
            BtnCountryOfBirth.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        else
            BtnCountryOfBirth.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		
        [BtnCountryOfBirth setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",theCountry] forState:UIControlStateNormal];
        
        [self.Country2ListPopover dismissPopoverAnimated:YES];
		
		NSString *COB = @"";
		COB = theCountry;
		COB = [self getCountryCode:COB];
		[ClientProfile setObject:COB forKey:@"CountryOfBirth"];
	
	
	edited = YES;
	
	
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
	[ClientProfile setObject:@"YES" forKey:@"HasChanged"];
}


-(void)selectedGroup:(NSString *)aaGroup
{
    if([aaGroup isEqualToString:@"- SELECT -"])
		outletGroup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    else
        outletGroup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [outletGroup setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", aaGroup] forState:UIControlStateNormal];
    [self.GroupPopover dismissPopoverAnimated:YES];
    
	edited = YES;
	
	// ###
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
	[ClientProfile setObject:@"YES" forKey:@"HasChanged"];
	
	NSString *group = @"";
	if (![outletGroup.titleLabel.text isEqualToString:@"- SELECT -"]) {
		group =   [outletGroup.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	}
	else {
		group = outletGroup.titleLabel.text;
	}
	if([group isEqualToString:@"- SELECT -"])
		group = @"";
	group = [self getGroupID:group];
	[ClientProfile setObject:group forKey:@"group"];
	
	//###
}

-(void)selectedRace:(NSString *)theRace
{
    
    
    if([theRace isEqualToString:@"- SELECT -"])
        outletRace.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    else
        outletRace.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	
    [outletRace setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",theRace]forState:UIControlStateNormal];
    [self.raceListPopover dismissPopoverAnimated:YES];
    
	edited = YES;
	
	//###
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
	[ClientProfile setObject:@"YES" forKey:@"HasChanged"];
	
	NSString *race = @"";
	race  = [outletRace.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	if([race isEqualToString:@"- SELECT -"])
		race = @"";
	[ClientProfile setObject:race forKey:@"race"];
	//###
    
    
}
-(void)selectedMaritalStatus:(NSString *)status
{
    
    
    if([status isEqualToString:@"- SELECT -"])
        outletMaritalStatus.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    else
        outletMaritalStatus.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	
    [outletMaritalStatus setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",status]forState:UIControlStateNormal];
    [self.MaritalStatusPopover dismissPopoverAnimated:YES];
    
	edited = YES;
	
	//###
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
	[ClientProfile setObject:@"YES" forKey:@"HasChanged"];
	
	NSString *marital = @"";
	marital  = [outletMaritalStatus.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	if([marital isEqualToString:@"- SELECT -"])
		marital = @"";
	[ClientProfile setObject:marital forKey:@"marital"];
	//###
    
    
}


-(void)selectedTitleDesc:(NSString *)selectedTitle
{
    if([selectedTitle isEqualToString:@"- SELECT -"])
        outletTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    else
        outletTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	
    [outletTitle setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", selectedTitle] forState:UIControlStateNormal];
    [self.TitlePickerPopover dismissPopoverAnimated:YES];
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
    [ClientProfile setObject:selectedTitle forKey:@"title"];
    edited = YES;
}


-(void)selectedTitleCode:(NSString *)selectedTitleCode {
	TitleCodeSelected = selectedTitleCode;
	//###
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
	[ClientProfile setObject:@"YES" forKey:@"HasChanged"];
	
	if([TitleCodeSelected isEqualToString:@"(null)"]  || (TitleCodeSelected == NULL))
		TitleCodeSelected = @"";
	[ClientProfile setObject:TitleCodeSelected forKey:@"TitleCodeSelected"];
	//###
}


-(void)selectedNationality:(NSString *)selectedNationality
{
    
    if([selectedNationality isEqualToString:@"- SELECT -"])
        outletNationality.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    else
        outletNationality.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	
    [outletNationality setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",selectedNationality]forState:UIControlStateNormal];
    [self.nationalityPopover dismissPopoverAnimated:YES];
	edited = YES;
	
	//###
	
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
	[ClientProfile setObject:@"YES" forKey:@"HasChanged"];
	
	NSString *nation = @"";
	nation = [outletNationality.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	if([nation isEqualToString:@"- SELECT -"])
		nation = @"";
	[ClientProfile setObject:nation forKey:@"nation"];
	
	//###
}

-(void)selectedReligion:(NSString *)setReligion
{
    
    if([setReligion isEqualToString:@"- SELECT -"])
        outletReligion.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    else
        outletReligion.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	
    [outletReligion setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",setReligion]forState:UIControlStateNormal];
    [self.ReligionListPopover dismissPopoverAnimated:YES];
	edited = YES;
	
	//###
	
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
	[ClientProfile setObject:@"YES" forKey:@"HasChanged"];
	
	NSString *religion = @"";
	religion = [outletReligion.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	if([religion isEqualToString:@"- SELECT -"])
		religion = @"";
	[ClientProfile setObject:religion forKey:@"religion"];
	
	//###
}

-(void)IDTypeDescSelected:(NSString *)selectedIDType
{
	
    txtOtherIDType.text=@"";
	
	ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
    
    OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [OtherIDType setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@",selectedIDType]forState:UIControlStateNormal];
    
    //OtherIDType.titleLabel.text = selectedIDType;
    
    
    if ([selectedIDType isEqualToString:@"- SELECT -"]) {
        
        if(txtIDType.text.length!=0)
        {
            segGender.enabled = NO;
			
            outletDOB.enabled = NO;
            outletDOB.hidden = TRUE;
            outletDOB.titleLabel.text =@"";
            txtDOB.enabled = FALSE;
            txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            txtDOB.hidden = NO;
			
        }
        else{
            segGender.enabled = NO;
			
            segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
            
            outletDOB.enabled = NO;
            outletDOB.hidden = TRUE;
            outletDOB.titleLabel.text =@"";
            txtDOB.enabled = FALSE;
            txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            txtDOB.hidden = NO;
			
        }
        
		segSmoker.enabled = YES;
		
        companyCase = NO;
		//  segGender.enabled = NO;
		//  segSmoker.enabled = YES;
		//  segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
		
//        txtIDType.backgroundColor = [UIColor whiteColor];
//        txtIDType.enabled = YES;
        /*
		 outletDOB.enabled = NO;
		 outletDOB.hidden = TRUE;
		 outletDOB.titleLabel.text =@"";
		 txtDOB.enabled = FALSE;
		 txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
		 txtDOB.hidden = NO;
		 */
        OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        txtOtherIDType.enabled = NO;
        txtOtherIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtOtherIDType.text =@"";
        
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
    else  if ([selectedIDType isEqualToString:@"EXPECTED DELIVERY DATE"] || [selectedIDType isEqualToString:@"EDD"]){
        //Enable DOB
        //Disable - New IC field and Other ID field
        
        
        [btnForeignHome setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        [btnForeignOffice setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        
        btnForeignHome.enabled = false;
        btnForeignOffice.enabled = false;
        btnHomeCountry.enabled = false;
        btnOfficeCountry.enabled = false;
        
        companyCase = NO;
        segGender.enabled = TRUE;
        gender = @"";
        segSmoker.enabled = TRUE;
        segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        txtIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtIDType.enabled = NO;
        
        
        txtDOB.hidden = YES;
        txtDOB.text = @"";
        outletDOB.hidden = NO;
        outletDOB.enabled = YES;
        [outletDOB setTitle:@"- SELECT -" forState:UIControlStateNormal];
        txtDOB.backgroundColor = [UIColor whiteColor];
        
        
        OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        txtOtherIDType.enabled = NO;
        txtOtherIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtOtherIDType.text =@"";
        
        txtExactDuties.editable = NO;
        txtExactDuties.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        
        outletTitle.enabled = YES;
        outletTitle.titleLabel.textColor = [UIColor blackColor];
        
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
    
    else if([selectedIDType isEqualToString:@"BIRTH CERTIFICATE"]||[selectedIDType isEqualToString:@"PASSPORT"] ||[selectedIDType isEqualToString:@"OLD IDENTIFICATION NO"] ||[selectedIDType isEqualToString:@"BC"] ||[selectedIDType isEqualToString:@"PP"] ||[selectedIDType isEqualToString:@"OLDIC"])
    {
        companyCase = NO;
        
        // check if ic field is empty
        if ([txtIDType.text isEqualToString:@""]) {
            txtIDType.backgroundColor = [UIColor whiteColor];
            txtIDType.enabled = YES;
            segGender.enabled = FALSE;
            segSmoker.enabled = YES;
            //outletDOB.enabled = YES;
            //outletDOB.hidden = NO;
            //txtDOB.backgroundColor = [UIColor whiteColor];
            //outletDOB.titleLabel.text =@"";
            //txtDOB.text = @"";
            
            txtDOB.hidden = YES;
            txtDOB.text = @"";
            txtDOB.backgroundColor = [UIColor whiteColor];
            
            // Reset gender
            segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
            
            // Reset dob
            txtDOB.text = @"";
            outletDOB.hidden = NO;
            outletDOB.enabled = FALSE;
            
            
            [outletDOB setTitle:@"- SELECT -" forState:UIControlStateNormal];
            outletDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
        else if (![txtIDType.text isEqualToString:@""]) {
            
			
            segGender.enabled = FALSE;
            txtDOB.enabled = FALSE;
            txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            outletDOB.enabled = FALSE;
        }
        
        
        
        [outletDOB setTitle:@"" forState:UIControlStateNormal];
        txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtDOB.enabled = NO;
        
        outletDOB.enabled = NO;
        
        outletTitle.enabled = YES;
        outletTitle.titleLabel.textColor = [UIColor blackColor];
        
        OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
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
        
        
    }
    
    else if([selectedIDType isEqualToString:@"COMPANY REGISTRATION NUMBER"] || [selectedIDType isEqualToString:@"CR"])
    {
        
        companyCase = YES;
        txtOtherIDType.backgroundColor = [UIColor whiteColor];
        txtOtherIDType.enabled = YES;
        outletDOB.enabled = NO;
        txtIDType.enabled = NO;
        txtIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtIDType.text=@"";
        
        segGender.enabled = FALSE;
        segSmoker.enabled = YES;
        segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        
        
        outletTitle.enabled = NO;
        //outletTitle.titleLabel.text = @"-";
        //outletTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        outletTitle.titleLabel.textColor = [UIColor grayColor];
        
        outletOccup.enabled = NO;
        //outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        // outletOccup.titleLabel.text = @"- SELECT -";
        outletOccup.titleLabel.textColor = [UIColor grayColor];
        
        //segGender.enabled = NO;
        segSmoker.enabled = FALSE;
        
        outletRace.enabled = NO;
        outletRace.titleLabel.textColor = [UIColor grayColor];
		
        
        
        outletReligion.enabled = NO;
        outletReligion.titleLabel.textColor = [UIColor grayColor];
		
        outletMaritalStatus.enabled = NO;
        outletMaritalStatus.titleLabel.textColor = [UIColor grayColor];
		
        
        outletNationality.enabled = NO;
        outletNationality.titleLabel.textColor = [UIColor grayColor];
		
        
        //segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        segSmoker.selectedSegmentIndex = UISegmentedControlNoSegment;
        companyCase = YES;
        txtDOB.hidden = NO;
        txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        outletDOB.hidden = YES;
        txtDOB.text = @"";
        
        
    }
    else{
        txtIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtIDType.enabled = NO;
        txtIDType.text = @"";
        
        txtOtherIDType.backgroundColor = [UIColor whiteColor];
        txtOtherIDType.enabled = YES;
        
        outletOccup.enabled = YES;
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
	
    [self.IDTypePickerPopover dismissPopoverAnimated:YES];
	edited = YES;
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
	//[ClientProfile setObject:selectedIDType forKey:@"title"];
	
}

-(void)IDTypeCodeSelected:(NSString *)IDTypeCode {
	IDTypeCodeSelected = IDTypeCode;
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:IDTypeCode forKey:@"IDTypeCodeSelected"];
}

-(void)selectedIDType:(NSString *)selectedIDType
{
    ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
    
    OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [OtherIDType setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@",selectedIDType]forState:UIControlStateNormal];
    
    OtherIDType.titleLabel.text = selectedIDType;
    
    
    if ([selectedIDType isEqualToString:@"- SELECT -"]) {
        
        if(txtIDType.text.length!=0)
        {
            segGender.enabled = NO;
			
            outletDOB.enabled = NO;
            outletDOB.hidden = TRUE;
            outletDOB.titleLabel.text =@"";
            txtDOB.enabled = FALSE;
            txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            txtDOB.hidden = NO;
			
        }
        else{
            segGender.enabled = NO;
			
            segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
            
            outletDOB.enabled = NO;
            outletDOB.hidden = TRUE;
            outletDOB.titleLabel.text =@"";
            txtDOB.enabled = FALSE;
            txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            txtDOB.hidden = NO;
			
        }
        
		if ([selectedIDType isEqualToString:@"- SELECT -"]) {
			txtOtherIDType.text = @"";
			txtOtherIDType.enabled = false;
			txtOtherIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
		}
		segSmoker.enabled = YES;
		
        companyCase = NO;
		//  segGender.enabled = NO;
		//  segSmoker.enabled = YES;
		//  segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
		
//        txtIDType.backgroundColor = [UIColor whiteColor];
//        txtIDType.enabled = YES;
        /*
		 outletDOB.enabled = NO;
		 outletDOB.hidden = TRUE;
		 outletDOB.titleLabel.text =@"";
		 txtDOB.enabled = FALSE;
		 txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
		 txtDOB.hidden = NO;
		 */
        OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        txtOtherIDType.enabled = NO;
        txtOtherIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtOtherIDType.text =@"";
        
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
    else  if ([selectedIDType isEqualToString:@"EXPECTED DELIVERY DATE"] || [selectedIDType isEqualToString:@"EDD"]){
        //Enable DOB
        //Disable - New IC field and Other ID field
        
        
        [btnForeignHome setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        [btnForeignOffice setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        
        btnForeignHome.enabled = false;
        btnForeignOffice.enabled = false;
        btnHomeCountry.enabled = false;
        btnOfficeCountry.enabled = false;
        
        companyCase = NO;
        segGender.enabled = TRUE;
        segSmoker.enabled = TRUE;
        segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        txtIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtIDType.enabled = NO;
        
        
        txtDOB.hidden = YES;
        txtDOB.text = @"";
        outletDOB.hidden = NO;
        outletDOB.enabled = YES;
        [outletDOB setTitle:@"- SELECT -" forState:UIControlStateNormal];
        txtDOB.backgroundColor = [UIColor whiteColor];
        
        
        OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        txtOtherIDType.enabled = NO;
        txtOtherIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtOtherIDType.text =@"";
        
        txtExactDuties.editable = NO;
        txtExactDuties.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        
        outletTitle.enabled = YES;
        outletTitle.titleLabel.textColor = [UIColor blackColor];
        
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
    
    else if([selectedIDType isEqualToString:@"BIRTH CERTIFICATE"]||[selectedIDType isEqualToString:@"PASSPORT"] ||[selectedIDType isEqualToString:@"OLD IDENTIFICATION NO"] ||[selectedIDType isEqualToString:@"BC"] ||[selectedIDType isEqualToString:@"PP"] ||[selectedIDType isEqualToString:@"OLDIC"])
    {
        companyCase = NO;
        
        // check if ic field is empty
        if ([txtIDType.text isEqualToString:@""]) {
            txtIDType.backgroundColor = [UIColor whiteColor];
            txtIDType.enabled = YES;
            segGender.enabled = FALSE;
            segSmoker.enabled = YES;
            //outletDOB.enabled = YES;
            //outletDOB.hidden = NO;
            //txtDOB.backgroundColor = [UIColor whiteColor];
            //outletDOB.titleLabel.text =@"";
            //txtDOB.text = @"";
            
            txtDOB.hidden = YES;
            txtDOB.text = @"";
            txtDOB.backgroundColor = [UIColor whiteColor];
            
            // Reset gender
            segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
            
            // Reset dob
            txtDOB.text = @"";
            outletDOB.hidden = NO;
            outletDOB.enabled = FALSE;
            
            
            [outletDOB setTitle:@"- SELECT -" forState:UIControlStateNormal];
            outletDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
        else if (![txtIDType.text isEqualToString:@""]) {
            
			
            segGender.enabled = FALSE;
            txtDOB.enabled = FALSE;
            txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            outletDOB.enabled = FALSE;
        }
        
        
        
        [outletDOB setTitle:@"" forState:UIControlStateNormal];
        txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtDOB.enabled = NO;
        
        outletDOB.enabled = NO;
        
        outletTitle.enabled = YES;
        outletTitle.titleLabel.textColor = [UIColor blackColor];
        
        OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
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
        
        
    }
    
    else if([selectedIDType isEqualToString:@"COMPANY REGISTRATION NUMBER"] || [selectedIDType isEqualToString:@"CR"])
    {
        
        companyCase = YES;
        txtOtherIDType.backgroundColor = [UIColor whiteColor];
        txtOtherIDType.enabled = YES;
        outletDOB.enabled = NO;
        txtIDType.enabled = NO;
        txtIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtIDType.text=@"";
        
        segGender.enabled = FALSE;
        segSmoker.enabled = YES;
        segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        
        
        outletTitle.enabled = NO;
        //outletTitle.titleLabel.text = @"-";
        //outletTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        outletTitle.titleLabel.textColor = [UIColor grayColor];
        
        outletOccup.enabled = NO;
        //outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        // outletOccup.titleLabel.text = @"- SELECT -";
        outletOccup.titleLabel.textColor = [UIColor grayColor];
        
        //segGender.enabled = NO;
        segSmoker.enabled = FALSE;
        
        outletRace.enabled = NO;
        outletRace.titleLabel.textColor = [UIColor grayColor];
		
        
        
        outletReligion.enabled = NO;
        outletReligion.titleLabel.textColor = [UIColor grayColor];
		
        outletMaritalStatus.enabled = NO;
        outletMaritalStatus.titleLabel.textColor = [UIColor grayColor];
		
        
        outletNationality.enabled = NO;
        outletNationality.titleLabel.textColor = [UIColor grayColor];
		
        
        //segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        segSmoker.selectedSegmentIndex = UISegmentedControlNoSegment;
        companyCase = YES;
        txtDOB.hidden = NO;
        txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        outletDOB.hidden = YES;
        txtDOB.text = @"";
        
        
    }
    else{
        txtIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtIDType.enabled = NO;
        txtIDType.text = @"";
        
        txtOtherIDType.backgroundColor = [UIColor whiteColor];
        txtOtherIDType.enabled = YES;
        
        outletOccup.enabled = YES;
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
	
    
    [self.IDTypePickerPopover dismissPopoverAnimated:YES];
	edited = YES;
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
	
}

- (void)OccupCodeSelected:(NSString *)OccupCode
{
    OccupCodeSelected = OccupCode;
    strChanges = @"Yes";
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
	edited = YES;
	
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
    
	[self get_unemploy];
    
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
	
	[ClientProfile setObject:OccupCodeSelected forKey:@"OccupCodeSelected"];
}

- (void)OccupDescSelected:(NSString *)color
{
    outletOccup.titleLabel.text = color;
    
    [self resignFirstResponder];
    [self.view endEditing:TRUE];
    [self.OccupationListPopover dismissPopoverAnimated:YES];
    
    
    if(([OccpCatCode isEqualToString:@"HSEWIFE"])
       || ([OccpCatCode isEqualToString:@"JUV"])
       || ([OccpCatCode isEqualToString:@"STU"]))
		
        
    {
        
        ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
        txtAnnIncome.enabled = NO;
        txtAnnIncome.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtAnnIncome.text = @"";
    }
    else
    {
        txtAnnIncome.enabled = YES;
        txtAnnIncome.backgroundColor = [UIColor whiteColor];
    }
    
    if([color isEqualToString:@"- SELECT -"])
        outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    else
        outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
	[outletOccup setTitle:[[NSString stringWithFormat:@"  "] stringByAppendingFormat:@"%@", color] forState:UIControlStateNormal];
	edited = YES;
	
	//###
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
	[ClientProfile setObject:@"YES" forKey:@"HasChanged"];
	
	[ClientProfile setObject:OccupCodeSelected forKey:@"OccupCodeSelected"];
	//###
}

-(void)OccupClassSelected:(NSString *)OccupClass
{
    txtClass.text = OccupClass;
	
	edited = YES;
	
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
}



-(BOOL)get_unemploy_initial
{
    sqlite3_stmt *statement;
    BOOL valid = FALSE;
    
    if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT \"OccpCatCode\" from Adm_OccpCat_Occp WHERE OccpCode = \"%@\" ", pp.ProspectOccupationCode];
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
        //  NSLog(@"3 ky result - %@",result);
    }
    
    annualIncome_original = txtAnnIncome.text;
    
    if(txtAnnIncome.text.length==0)
        txtAnnIncome.text = @"";
    else
        txtAnnIncome.text = result;
	
	
    NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	//[ClientProfile setObject:@"YES" forKey:@"HasChanged"];
    [ClientProfile setObject:txtAnnIncome.text forKey:@"txtAnnIncome"];
	
	NSString *ReSave = [ClientProfile stringForKey:@"ReSave"];
	if ([ReSave isEqualToString:@"YES"]) {
		//[self SaveFromUserDefault];
		//[ClientProfile setObject:@"NO" forKey:@"ReSave"];
		NSLog(@"ANNIncome");
	}
    
}


-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *d = [NSDate date];
    NSDate* d2 = [df dateFromString:dbDate];
    outletRigDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [outletRigDOB setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",strDate]forState:UIControlStateNormal];
  
    if(ToDissAlertforRegDate==YES){
		if ([d compare:d2] == NSOrderedDescending) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
															message:@"Expected Delivery Date must be future date." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
			[alert show];
			
		}
		else{
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
        
        txtRigDate.text =@"";
       // outletRigDOB.hidden=NO;
       [outletRigDOB setTitle:@"- SELECT -" forState:UIControlStateNormal];
        outletRigDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        outletRigDOB.titleLabel.textColor = [UIColor redColor];
        
    }

    
	edited = YES;
	NSUserDefaults *ClientProfile = [NSUserDefaults standardUserDefaults];
	[ClientProfile setObject:@"YES" forKey:@"isEdited"];
}

-(void)CloseWindow
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [_SIDatePopover dismissPopoverAnimated:YES];
}

-(void)dismiss:(UIAlertView*)alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}



- (void)viewDidUnload
{
    [self setTxtrFullName:nil];
    [self setSegGender:nil];
    [self setOutletDOB:nil];
    [self setTxtContact1:nil];
    [self setTxtEmail:nil];
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
    [self setTxtOfficePostCode:nil];
    [self setTxtOfficeTown:nil];
    [self setTxtOfficeState:nil];
    [self setTxtOfficeCountry:nil];
    [self setTxtExactDuties:nil];
    [self setTxtRemark:nil];
    [self setMyScrollView:nil];
    [self setOutletOccup:nil];
    [self setTxtContact1:nil];
    [self setTxtContact1:nil];
    [self setOutletDelete:nil];
    [self setTxtContact2:nil];
    [self setTxtContact3:nil];
    [self setTxtContact4:nil];
    [self setTxtPrefix1:nil];
    [self setTxtPrefix2:nil];
    [self setTxtPrefix3:nil];
    [self setTxtPrefix4:nil];
    [self setLblOfficeAddr:nil];
    [self setLblPostCode:nil];
    [self setOutletGroup:nil];
    [self setOutletTitle:nil];
    [self setTxtIDType:nil];
    [self setOtherIDType:nil];
    [self setTxtOtherIDType:nil];
    [self setSegSmoker:nil];
    [self setTxtAnnIncome:nil];
    [self setTxtBussinessType:nil];
    [self setPp:nil];
    [self setTxtExactDuties:nil];
    [self setTxtClass:nil];
    [self setBtnForeignHome:nil];
    [self setBtnForeignOffice:nil];
    [self setBtnOfficeCountry:nil];
    [self setBtnHomeCountry:nil];
    [self setTxtDOB:nil];
    [self setSegIsGrouping:nil];
    [self setAddGroup:nil];
    [self setViewGroup:nil];
    [self setBtnregDate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end
