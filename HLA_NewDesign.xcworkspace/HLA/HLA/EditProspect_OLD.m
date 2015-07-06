//
//  EditProspect_OLD.m
//  iMobile Planner
//
//  Created by infoconnect on 11/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "EditProspect_OLD.h"
#import "ProspectListing.h"
#import <QuartzCore/QuartzCore.h>
#import "ColorHexCode.h"

@interface EditProspect_OLD ()

@end

@implementation EditProspect_OLD
@synthesize lblOfficeAddr;
@synthesize lblPostCode;
@synthesize outletDone;
@synthesize txtPrefix1,strChanges;
@synthesize txtPrefix2;
@synthesize txtPrefix3;
@synthesize txtPrefix4;
@synthesize txtPrefix5;
@synthesize outletDelete;
@synthesize outletType2;
@synthesize outletType3;
@synthesize outletType4;
@synthesize outletType5;
@synthesize txtContact2;
@synthesize txtContact3;
@synthesize txtContact4;
@synthesize txtContact5;
@synthesize txtRemark;

@synthesize txtHomeAddr1;
@synthesize txtHomeAddr2;
@synthesize txtHomeAddr3;
@synthesize txtHomePostCode;
@synthesize txtHomeTown;
@synthesize txtHomeState;
@synthesize txtHomeCountry;
@synthesize txtOfiiceAddr1;
@synthesize txtOfficeAddr2;
@synthesize txtOfficeAddr3;
@synthesize txtOfficePostCode;
@synthesize txtOfficeTown;
@synthesize txtOfficeState;
@synthesize txtOfficeCountry;
@synthesize txtExactDuties;
@synthesize txtPreferredName;
@synthesize txtrFullName;
@synthesize segGender;
@synthesize outletDOB;
@synthesize outletType1;
@synthesize txtContact1, gender, ContactType, ContactTypeTracker;
@synthesize txtEmail, pp, DOB, SelectedStateCode,SelectedOfficeStateCode, OccupCodeSelected;
@synthesize OccupationList = _OccupationList;
@synthesize OccupationListPopover = _OccupationListPopover;
@synthesize myScrollView;
@synthesize outletOccup;
@synthesize delegate = _delegate;
@synthesize ContactTypeClass = _ContactTypeClass;
@synthesize ContactTypePopover = _ContactTypePopover;
@synthesize SIDate = _SIDate;
@synthesize SIDatePopover = _SIDatePopover;

bool IsContinue_OLD = TRUE;

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
	// Do any additional setup after loading the view.
	self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    txtRemark.layer.borderWidth = 1.0f;
    txtRemark.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [txtHomePostCode addTarget:self action:@selector(EditTextFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    
    [txtOfficePostCode addTarget:self action:@selector(EditOfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    [txtEmail addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingDidEnd];
    [txtExactDuties addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingDidEnd];
    [txtHomeAddr1 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingDidEnd];
    [txtHomeAddr2 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingDidEnd];
    [txtHomeAddr3 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingDidEnd];
    [txtOfficeAddr2 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingDidEnd];
    
    [txtOfficeAddr3 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingDidEnd];
    [txtPreferredName addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingDidEnd];
    [txtrFullName addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingDidEnd];
    [txtOfiiceAddr1 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingDidEnd];
    [txtPrefix1 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingDidEnd];
    [txtContact1 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingDidEnd];
    [txtContact2 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingDidEnd];
    [txtContact3 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingDidEnd];
    [txtContact4 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingDidEnd];
    [txtContact5 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingDidEnd];
    [txtPrefix2 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingDidEnd];
    [txtPrefix3 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingDidEnd];
    [txtPrefix4 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingDidEnd];
    [txtPrefix5 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingDidEnd];
    [segGender addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventValueChanged];
    [outletDOB addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventAllTouchEvents];
    [outletType1 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventAllTouchEvents];
    [outletType2 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventAllTouchEvents];
    [outletType3 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventAllTouchEvents];
    [outletType4 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventAllTouchEvents];
    [outletType5 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventAllTouchEvents];
    [txtHomePostCode addTarget:self action:@selector(EditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [txtOfficePostCode addTarget:self action:@selector(OfficeEditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    txtRemark.delegate = self;
    
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    txtHomeTown.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtHomeState.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtHomeCountry.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtOfficeTown.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtOfficeState.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtOfficeCountry.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    
    [outletDelete setBackgroundImage:[[UIImage imageNamed:@"iphone_delete_button.png"] stretchableImageWithLeftCapWidth:8.0f topCapHeight:0.0f]
                            forState:UIControlStateNormal];
    [outletDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    outletDelete.titleLabel.shadowColor = [UIColor lightGrayColor];
    outletDelete.titleLabel.shadowOffset = CGSizeMake(0, -1);
    
    ContactType = [[NSArray alloc] initWithObjects:@"Mobile", @"Home", @"Fax", @"Office", nil];
    outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)picker;
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [ContactType count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [ContactType objectAtIndex:row];
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSString *zzz = [ContactType objectAtIndex:row];
    
	
	if ([ContactTypeTracker isEqualToString: @"2"]) {
		txtContact2.enabled = true;
		[outletType2 setTitle:zzz forState:UIControlStateNormal];
		
	}
	else if ([ContactTypeTracker isEqualToString: @"1"]) {
		txtContact1.enabled = true;
		[outletType1 setTitle:zzz forState:UIControlStateNormal];
		
	}
	else if ([ContactTypeTracker isEqualToString: @"3"]) {
		[outletType3 setTitle:zzz forState:UIControlStateNormal];
		
	}
	else if ([ContactTypeTracker isEqualToString: @"4"]) {
		[outletType4 setTitle:zzz forState:UIControlStateNormal];
	}
	else if ([ContactTypeTracker isEqualToString: @"5"]) {
		[outletType5 setTitle:zzz forState:UIControlStateNormal];
	}
	
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    strChanges = @"Yes";
	
}

- (void)viewDidUnload
{
    [self setTxtPreferredName:nil];
    [self setTxtrFullName:nil];
    [self setSegGender:nil];
    [self setOutletDOB:nil];
    [self setOutletType1:nil];
    [self setTxtContact1:nil];
    [self setTxtEmail:nil];
    [self setTxtHomeAddr1:nil];
    [self setTxtHomeAddr2:nil];
    [self setTxtHomeAddr3:nil];
    [self setTxtHomePostCode:nil];
    [self setTxtHomeTown:nil];
    [self setTxtHomeState:nil];
    [self setTxtHomeCountry:nil];
    [self setTxtOfiiceAddr1:nil];
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
    [self setOutletType2:nil];
    [self setOutletType3:nil];
    [self setOutletType4:nil];
    [self setOutletType5:nil];
    [self setTxtContact2:nil];
    [self setTxtContact3:nil];
    [self setTxtContact4:nil];
    [self setTxtContact5:nil];
    [self setTxtPrefix1:nil];
    [self setTxtPrefix2:nil];
    [self setTxtPrefix3:nil];
    [self setTxtPrefix4:nil];
    [self setTxtPrefix5:nil];
    [self setLblOfficeAddr:nil];
    [self setLblPostCode:nil];
    [self setOutletDone:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (interfaceOrientation==UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        return YES;
    
    return NO;
}


- (void)viewWillAppear:(BOOL)animated
{
    strChanges = @"No";
    
    txtPreferredName.text = pp.NickName;
    txtrFullName.text = pp.ProspectName;
    txtHomeAddr1.text = pp.ResidenceAddress1;
    txtHomeCountry.text = pp.ResidenceAddressCountry;
    txtHomePostCode.text = pp.ResidenceAddressPostCode;
    txtHomeTown.text = pp.ResidenceAddressTown;
    txtOfiiceAddr1.text = pp.OfficeAddress1;
    txtOfficePostCode.text = pp.OfficeAddressPostCode;
    txtOfficeCountry.text = pp.OfficeAddressCountry;
    txtOfficeTown.text = pp.OfficeAddressTown;
    txtRemark.text = pp.ProspectRemark;
    txtEmail.text = pp.ProspectEmail;
    txtHomeAddr3.text = pp.ResidenceAddress3;
    txtHomeAddr2.text = pp.ResidenceAddress2;
    txtOfficeAddr2.text = pp.OfficeAddress2;
    txtOfficeAddr3.text = pp.OfficeAddress3;
    txtExactDuties.text = pp.ExactDuties;
    
    
    if ([pp.ProspectGender isEqualToString:@"MALE"] || [pp.ProspectGender isEqualToString:@"M"] ) {
        gender = @"MALE";
        segGender.selectedSegmentIndex = 0;
    }
    else {
        gender = @"FEMALE";
        segGender.selectedSegmentIndex = 1;
    }
    
    txtContact1.text = @"";
    txtContact2.text = @"";
    txtContact3.text = @"";
    txtContact4.text = @"";
    txtContact5.text = @"";
    
    txtPrefix1.text = @"";
    txtPrefix2.text = @"";
    txtPrefix3.text = @"";
    txtPrefix4.text = @"";
    txtPrefix5.text = @"";
    
    outletType1.titleLabel.text = @"";
    outletType2.titleLabel.text = @"";
    outletType3.titleLabel.text = @"";
    outletType4.titleLabel.text = @"";
    outletType5.titleLabel.text = @"";
    
    
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
                        [outletType1 setTitle:@"Mobile" forState:UIControlStateNormal];
                        txtContact1.text  = ContactNo;
                        txtPrefix1.text = Prefix;
                    }
                    else if ([ContactCode isEqualToString:@"CONT006"]) { //home
                        [outletType1 setTitle:@"Home" forState:UIControlStateNormal];
                        txtContact1.text = ContactNo;
                        txtPrefix1.text = Prefix;
                    }
                    else if ([ContactCode isEqualToString:@"CONT009"]) { //fax
                        [outletType1 setTitle:@"Fax" forState:UIControlStateNormal];
                        txtContact1.text = ContactNo;
                        txtPrefix1.text = Prefix;
                    }
                    else if ([ContactCode isEqualToString:@"CONT007"]) { //office
                        [outletType1 setTitle:@"Office" forState:UIControlStateNormal];
                        txtContact1.text = ContactNo;
                        txtPrefix1.text = Prefix;
                    }
                }
                else if (a==1) {
                    if ([ContactCode isEqualToString:@"CONT008"]) { //mobile
                        [outletType2 setTitle:@"Mobile" forState:UIControlStateNormal];
                        txtContact2.text  = ContactNo;
                        txtPrefix2.text = Prefix;
                    }
                    else if ([ContactCode isEqualToString:@"CONT006"]) { //home
                        [outletType2 setTitle:@"Home" forState:UIControlStateNormal];
                        txtContact2.text = ContactNo;
                        txtPrefix2.text = Prefix;
                    }
                    else if ([ContactCode isEqualToString:@"CONT009"]) { //fax
                        [outletType2 setTitle:@"Fax" forState:UIControlStateNormal];
                        txtContact2.text = ContactNo;
                        txtPrefix2.text = Prefix;
                    }
                    else if ([ContactCode isEqualToString:@"CONT007"]) { //office
                        [outletType2 setTitle:@"Office" forState:UIControlStateNormal];
                        txtContact2.text = ContactNo;
                        txtPrefix2.text = Prefix;
                    }
                }
                else if (a==2) {
                    if ([ContactCode isEqualToString:@"CONT008"]) { //mobile
                        [outletType3 setTitle:@"Mobile" forState:UIControlStateNormal];
                        txtContact3.text  = ContactNo;
                        txtPrefix3.text = Prefix;
                    }
                    else if ([ContactCode isEqualToString:@"CONT006"]) { //home
                        [outletType3 setTitle:@"Home" forState:UIControlStateNormal];
                        txtContact3.text = ContactNo;
                        txtPrefix3.text = Prefix;
                    }
                    else if ([ContactCode isEqualToString:@"CONT009"]) { //fax
                        [outletType3 setTitle:@"Fax" forState:UIControlStateNormal];
                        txtContact3.text = ContactNo;
                        txtPrefix3.text = Prefix;
                    }
                    else if ([ContactCode isEqualToString:@"CONT007"]) { //office
                        [outletType3 setTitle:@"Office" forState:UIControlStateNormal];
                        txtContact3.text = ContactNo;
                        txtPrefix3.text = Prefix;
                    }
                }
                else if (a==3) {
                    if ([ContactCode isEqualToString:@"CONT008"]) { //mobile
                        [outletType4 setTitle:@"Mobile" forState:UIControlStateNormal];
                        txtContact4.text  = ContactNo;
                        txtPrefix4.text = Prefix;
                    }
                    else if ([ContactCode isEqualToString:@"CONT006"]) { //home
                        [outletType4 setTitle:@"Home" forState:UIControlStateNormal];
                        txtContact4.text = ContactNo;
                        txtPrefix4.text = Prefix;
                    }
                    else if ([ContactCode isEqualToString:@"CONT009"]) { //fax
                        [outletType4 setTitle:@"Fax" forState:UIControlStateNormal];
                        txtContact4.text = ContactNo;
                        txtPrefix4.text = Prefix;
                    }
                    else if ([ContactCode isEqualToString:@"CONT007"]) { //office
                        [outletType4 setTitle:@"Office" forState:UIControlStateNormal];
                        txtContact4.text = ContactNo;
                        txtPrefix4.text = Prefix;
                    }
                }
                else if (a==4) {
                    if ([ContactCode isEqualToString:@"CONT008"]) { //mobile
                        [outletType5 setTitle:@"Mobile" forState:UIControlStateNormal];
                        txtContact5.text  = ContactNo;
                        txtPrefix5.text = Prefix;
                    }
                    else if ([ContactCode isEqualToString:@"CONT006"]) { //home
                        [outletType5 setTitle:@"Home" forState:UIControlStateNormal];
                        txtContact5.text = ContactNo;
                        txtPrefix5.text = Prefix;
                    }
                    else if ([ContactCode isEqualToString:@"CONT009"]) { //fax
                        [outletType5 setTitle:@"Fax" forState:UIControlStateNormal];
                        txtContact5.text = ContactNo;
                        txtPrefix5.text = Prefix;
                    }
                    else if ([ContactCode isEqualToString:@"CONT007"]) { //office
                        [outletType5 setTitle:@"Office" forState:UIControlStateNormal];
                        txtContact5.text = ContactNo;
                        txtPrefix5.text = Prefix;
                    }
                }
                a = a + 1;
            }
            sqlite3_finalize(statement);
            [self PopulateOccupCode];
            [self PopulateState];
            
            
            if (![[txtOfficePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"" ]) {
                
                [self PopulateOfficeState];
            }
            else{
                txtOfficeState.text = @"";
            }
        }
        sqlite3_close(contactDB);
        
    }
    else {
        NSLog(@"Error opening database");
    }
    
	dbpath = Nil;
	statement = Nil;
    
    [self.outletDOB setTitle:pp.ProspectDOB forState:UIControlStateNormal];
    
    [super viewWillAppear:animated];
}

-(void) PopulateOccupCode{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
        
        //NSString *querySQL = [NSString stringWithFormat:@"SELECT OccpDesc FROM Adm_Occp where status = 1 and OccpCode = \"%@\"", pp.ProspectOccupationCode];
        NSString *querySQL = [NSString stringWithFormat:@"SELECT OccpDesc FROM Adm_Occp_Loading_Penta where OccpCode = \"%@\"", pp.ProspectOccupationCode];
        //const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW){
                NSString *OccpDesc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                //txtOccup.text = OccpDesc;
                OccupCodeSelected = pp.ProspectOccupationCode;
                //[outletOccup setTitle:OccpDesc forState:UIControlStateNormal];
                [outletOccup setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", OccpDesc]forState:UIControlStateNormal];
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    /*
	 if ([self OptionalOccp:pp.ProspectOccupationCode] == FALSE) {
	 lblOfficeAddr.text = @"Office Address*";
	 lblPostCode.text = @"Postcode*";
	 
	 }
	 else {
	 lblOfficeAddr.text = @"Office Address";
	 lblPostCode.text = @"Postcode";
     
	 }
     */
}

-(void) PopulateState{
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


-(void) PopulateOfficeState{
    
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

-(void)EditTextFieldBegin:(id)sender{
    
    outletDone.enabled = FALSE;
    
}

-(void)OfficeEditTextFieldBegin:(id)sender{
    
    if ([self OptionalOccp:OccupCodeSelected] == FALSE) {
        outletDone.enabled = FALSE;
    }
    
}

- (IBAction)btnDOB:(id)sender {
    /*
	 DobPicker.hidden = NO;
	 pickerToolbar.hidden = NO;
	 [self.view endEditing:TRUE];
	 txtRemark.hidden = TRUE;
	 ContactTypePicker.hidden = true;
	 outletDelete.hidden = true;
     */
    
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
    [self.SIDatePopover presentPopoverFromRect:[sender frame ]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

- (IBAction)btnContactType1:(id)sender {
    
    [self resignFirstResponder];
    [self.view endEditing:TRUE];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    txtContact1.enabled = true;
    ContactTypeTracker = @"1";
    if (_ContactTypeClass == nil) {
        self.ContactTypeClass = [[ContactTypeClass alloc] initWithStyle:UITableViewStylePlain];
        _ContactTypeClass.ContactTypeDelegate = self;
        self.ContactTypePopover = [[UIPopoverController alloc] initWithContentViewController:_ContactTypeClass];
    }
    [self.ContactTypePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    
    [self.ContactTypePopover presentPopoverFromRect:[sender frame]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}
- (IBAction)btnOccup:(id)sender {
    if (_OccupationList == nil) {
        self.OccupationList = [[OccupationList alloc] initWithStyle:UITableViewStylePlain];
        _OccupationList.delegate = self;
        self.OccupationListPopover = [[UIPopoverController alloc] initWithContentViewController:_OccupationList];
    }
    
    [self.OccupationListPopover presentPopoverFromRect:[sender frame]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	
}
/*
 - (IBAction)btnDone:(id)sender {
 if (DobPicker.hidden == FALSE) { //DOB picker
 pickerToolbar.hidden = YES;
 DobPicker.hidden = YES;
 txtRemark.hidden = FALSE;
 outletDelete.hidden = false;
 }
 else { // Contact type picker
 pickerToolbar.hidden = true;
 ContactTypePicker.hidden = true;
 txtRemark.hidden = FALSE;
 outletDelete.hidden = false;
 }
 
 }
 */
- (IBAction)ActionGender:(id)sender {
    if ([segGender selectedSegmentIndex]==0) {
        gender = @"MALE";
    }
    else {
        gender = @"FEMALE";
    }
}

- (IBAction)btnDelete:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: NSLocalizedString(@"Delete prospect",nil)
                          message: NSLocalizedString(@"Are you sure you want to delete this prospect profile?",nil)
                          delegate: self
                          cancelButtonTitle: NSLocalizedString(@"Yes",nil)
                          otherButtonTitles: NSLocalizedString(@"No",nil), nil];
    alert.tag = 1;
    [alert show];
}

/*
 - (IBAction)ActionDobPicker:(id)sender {
 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
 [dateFormatter setDateFormat:@"dd/MM/yyyy"];
 
 NSString *pickerDate = [dateFormatter stringFromDate:[DobPicker date]];
 
 NSString *msg = [NSString stringWithFormat:@"%@",pickerDate];
 [self.outletDOB setTitle:msg forState:UIControlStateNormal];
 }
 */
- (bool) Validation{
    
    if([[txtPreferredName.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Preferred Name is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [txtPreferredName becomeFirstResponder];
        //[self.view endEditing:TRUE];
        
        [alert show];
        return false;
    }
    else {
        BOOL valid;
        NSString *strToBeTest = [txtPreferredName.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] ;
        
        for (int i=0; i<strToBeTest.length; i++) {
            int str1=(int)[strToBeTest characterAtIndex:i];
            
            if((str1 >96 && str1 <123)  || (str1 >64 && str1 <91) || str1 == 39 || str1 == 64 || str1 == 47 || str1 == 45 || str1 == 46){
                valid = TRUE;
                
            }else {
                valid = FALSE;
                break;
            }
        }
        if (!valid) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Invalid input format. Input must be alphabet A to Z, space, apostrotrophe ('), alias(@),slash(/),dash(-) or dot(.)."
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtPreferredName becomeFirstResponder];
            //[self.view endEditing:TRUE];
            
            [alert show];
            return false;
        }
    }
    
    if([[txtrFullName.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
														message:@"Full Name is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [txtrFullName becomeFirstResponder];
        //[self.view endEditing:TRUE];
        
        [alert show];
        return false;
    }
    else {
        BOOL valid;
        NSString *strToBeTest = [txtrFullName.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] ;
        
        for (int i=0; i<strToBeTest.length; i++) {
            int str1=(int)[strToBeTest characterAtIndex:i];
            
            if((str1 >96 && str1 <123)  || (str1 >64 && str1 <91) || str1 == 39 || str1 == 64 || str1 == 47 || str1 == 45 || str1 == 46){
                valid = TRUE;
                
            }else {
                valid = FALSE;
                break;
            }
        }
        if (!valid) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Invalid input format. Input must be alphabet A to Z, space, apostrotrophe ('), alias(@),slash(/),dash(-) or dot(.)" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [txtrFullName becomeFirstResponder];
            
            [alert show];
            return false;
        }
    }
    
    if(segGender.selectedSegmentIndex == -1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
														message:@"Gender is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		
        [self resignFirstResponder];
        [self.view endEditing:TRUE];
        
        [alert show];
        return false;
    }
    
    if(outletDOB.titleLabel.text == NULL){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Date of Birth is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		
        [self resignFirstResponder];
        [self.view endEditing:TRUE];
        
        [alert show];
        return false;
    }
    
    
    if(outletType1.titleLabel.text != NULL) {
        if ([txtPrefix1.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Prefix for contact no 1 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [txtPrefix1 becomeFirstResponder];
            
            [alert show];
            return false;
        }
        else {
            if (txtPrefix1.text.length > 4) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Prefix length cannot be more than 4 characters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [txtPrefix1 becomeFirstResponder];
                
                [alert show];
                return false;
            }
            else {
                if(![txtContact1.text isEqualToString:@"" ]){
                    
                    if (txtContact1.text.length > 8) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Contact number length must be less than 8 characters long" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [txtContact1 becomeFirstResponder];
                        
                        [alert show];
                        return false;
                    }
                    
					if (txtContact1.text.length < 6) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Contact number length must be more than 6 characters long" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [txtContact1 becomeFirstResponder];
                        
                        [alert show];
                        return false;
                    }
					
                    BOOL valid;
                    BOOL valid2;
                    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:txtContact1.text];
                    NSCharacterSet *inStringSet2 = [NSCharacterSet characterSetWithCharactersInString:txtPrefix1.text];
                    
                    valid = [alphaNums isSupersetOfSet:inStringSet];
                    valid2 = [alphaNums isSupersetOfSet:inStringSet2];
                    if (!valid) {
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Contact number must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [txtContact1 becomeFirstResponder];
                        
                        [alert show];
                        return false;
                    }
                    
                    if (!valid2) {
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Prefix for contact no 1 must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [txtPrefix1 becomeFirstResponder];
                        
                        [alert show];
                        return false;
                    }
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Number for contact no 1 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [txtContact1 becomeFirstResponder];
                    
                    [alert show];
                    return FALSE;
                }
            }
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Type for Contact No 1 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [outletType1 becomeFirstResponder];
        //[self.view endEditing:TRUE];
        
        [alert show];
        return FALSE;
    }
    
    if(![outletType2.titleLabel.text isEqualToString:@""]) {
        if ([txtPrefix2.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Prefix for contact no 2 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [txtPrefix2 becomeFirstResponder];
            
            [alert show];
            return false;
        }
        else {
            if (txtPrefix2.text.length > 4) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Prefix length cannot be more than 4 characters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [txtPrefix2 becomeFirstResponder];
                
                [alert show];
                return false;
            }
            else {
                if(![txtContact2.text isEqualToString:@"" ]){
                    
                    if (txtContact2.text.length > 8) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Contact number length must be less than 8 characters long" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [txtContact2 becomeFirstResponder];
                        
                        [alert show];
                        return false;
                    }
                    
					if (txtContact2.text.length < 6) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Contact number length must be more than 6 characters long" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [txtContact2 becomeFirstResponder];
                        
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
                    if (!valid) {
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Contact number must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [txtContact2 becomeFirstResponder];
                        
                        [alert show];
                        return false;
                    }
                    
                    if (!valid2) {
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Prefix for contact no 2 must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [txtPrefix2 becomeFirstResponder];
                        
                        [alert show];
                        return false;
                    }
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Number for contact no 2 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [txtContact2 becomeFirstResponder];
                    
                    [alert show];
                    return FALSE;
                }
            }
        }
    }
    else{
        if (![[txtPrefix2.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Type for contact no 2 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [outletType2 becomeFirstResponder];
            [alert show];
            return FALSE;
        }
        
        if (![[txtContact2.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Type for contact no 2 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [outletType2 becomeFirstResponder];
            [alert show];
            return FALSE;
        }
    }
    
    if(![outletType3.titleLabel.text isEqualToString:@""]) {
        if ([txtPrefix3.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Prefix for contact no 3 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [txtPrefix3 becomeFirstResponder];
            
            [alert show];
            return false;
        }
        else {
            if (txtPrefix3.text.length > 4) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Prefix length cannot be more than 4 characters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [txtPrefix3 becomeFirstResponder];
                
                [alert show];
                return false;
            }
            else {
                if(![txtContact3.text isEqualToString:@"" ]){
					
					if (txtContact3.text.length < 6) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Contact number length must be more than 6 characters long" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [txtContact3 becomeFirstResponder];
                        
                        [alert show];
                        return false;
                    }
					
                    BOOL valid;
                    BOOL valid2;
                    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:txtContact3.text];
                    NSCharacterSet *inStringSet2 = [NSCharacterSet characterSetWithCharactersInString:txtPrefix3.text];
                    
                    valid = [alphaNums isSupersetOfSet:inStringSet];
                    valid2 = [alphaNums isSupersetOfSet:inStringSet2];
                    if (!valid) {
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Contact number must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [txtContact3 becomeFirstResponder];
                        
                        [alert show];
                        return false;
                    }
                    
                    if (!valid2) {
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Prefix for contact no 3 must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
						
                        [txtPrefix3 becomeFirstResponder];
                        
                        [alert show];
                        return false;
                    }
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Number for contact no 3 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [txtContact3 becomeFirstResponder];
                    
                    [alert show];
                    return FALSE;
                }
            }
        }
    }
    else{
        if (![[txtPrefix3.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Type for contact no 3 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [outletType3 becomeFirstResponder];
            [alert show];
            return FALSE;
        }
        
        if (![[txtContact3.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Type for contact no 3 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [outletType3 becomeFirstResponder];
            [alert show];
            return FALSE;
        }
    }
    
    if(![outletType4.titleLabel.text isEqualToString:@""]) {
        if ([txtPrefix4.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Prefix for contact no 4 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [txtPrefix4 becomeFirstResponder];
            
            [alert show];
            return false;
        }
        else {
            if (txtPrefix4.text.length > 4) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Prefix length cannot be more than 4 characters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [txtPrefix4 becomeFirstResponder];
                
                [alert show];
                return false;
            }
            else {
                if(![txtContact4.text isEqualToString:@"" ]){
					
                    if (txtContact4.text.length > 8) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Contact number length must be less than 8 characters long" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [txtContact4 becomeFirstResponder];
                        
                        [alert show];
                        return false;
                    }
					
					if (txtContact4.text.length < 6) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Contact number length must be more than 6 characters long" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [txtContact4 becomeFirstResponder];
                        
                        [alert show];
                        return false;
                    }
                    
                    BOOL valid;
                    BOOL valid2;
                    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:txtContact4.text];
                    NSCharacterSet *inStringSet2 = [NSCharacterSet characterSetWithCharactersInString:txtPrefix4.text];
                    
                    valid = [alphaNums isSupersetOfSet:inStringSet];
                    valid2 = [alphaNums isSupersetOfSet:inStringSet2];
                    if (!valid) {
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Contact number must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [txtContact4 becomeFirstResponder];
                        
                        [alert show];
                        return false;
                    }
                    
                    if (!valid2) {
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Prefix for contact no 4 must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [txtPrefix4 becomeFirstResponder];
                        
                        [alert show];
                        return false;
                    }
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Number for contact no 4 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [txtContact4 becomeFirstResponder];
                    
                    [alert show];
                    return FALSE;
                }
            }
        }
    }
    else{
        if (![[txtPrefix4.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Type for contact no 4 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [outletType4 becomeFirstResponder];
            [alert show];
            return FALSE;
        }
        
        if (![[txtContact4.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Type for contact no 4 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [outletType4 becomeFirstResponder];
            [alert show];
            return FALSE;
        }
    }
    
    if(![outletType5.titleLabel.text isEqualToString:@""]) {
        if ([txtPrefix5.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Prefix for contact no 5 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [txtPrefix5  becomeFirstResponder];
            //[self.view endEditing:TRUE];
            
            [alert show];
            return false;
        }
        else {
            if (txtPrefix5.text.length > 4) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Prefix length cannot be more than 4 characters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [txtPrefix5 becomeFirstResponder];
                
                [alert show];
                return false;
            }
            else {
                if(![txtContact5.text isEqualToString:@"" ]){
                    
                    if (txtContact5.text.length > 8) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Contact number length must be less than 8 characters long" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [txtContact5 becomeFirstResponder];
                        
                        [alert show];
                        return false;
                    }
                    
					if (txtContact5.text.length < 6) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Contact number length must be more than 6 characters long" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [txtContact5 becomeFirstResponder];
                        
                        [alert show];
                        return false;
                    }
					
                    BOOL valid;
                    BOOL valid2;
                    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:txtContact5.text];
                    NSCharacterSet *inStringSet2 = [NSCharacterSet characterSetWithCharactersInString:txtPrefix5.text];
                    
                    valid = [alphaNums isSupersetOfSet:inStringSet];
                    valid2 = [alphaNums isSupersetOfSet:inStringSet2];
                    if (!valid) {
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Contact number must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [txtContact5 becomeFirstResponder];
                        
                        [alert show];
                        return false;
                    }
                    
                    if (!valid2) {
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Prefix for contact no 5 must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [txtPrefix5 becomeFirstResponder];
                        
                        [alert show];
                        return false;
                    }
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Number for contact no 5 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    
                    [txtContact5 becomeFirstResponder];
                    
                    [alert show];
                    return FALSE;
                }
            }
        }
    }
    else{
        if (![[txtPrefix5.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Type for contact no 5 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [outletType5 becomeFirstResponder];
            [alert show];
            return FALSE;
        }
        
        if (![[txtContact5.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Type for contact no 5 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [outletType5 becomeFirstResponder];
            [alert show];
            return FALSE;
        }
    }
    
    /*
	 if([[txtEmail.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]){
	 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
	 message:@"Email address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
	 [txtEmail becomeFirstResponder];
	 
	 [alert show];
	 return false;
	 }
     */
    
    if(OccupCodeSelected == NULL){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Occupation is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [self resignFirstResponder];
        [self.view endEditing:TRUE];
        
        [alert show];
        return false;
    }
    
    if([[txtHomeAddr1.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]){
        if (![txtHomePostCode.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Home Address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtHomeAddr1 becomeFirstResponder];
            
            [alert show];
            return false;
        }
        
    }
    
    
    if (IsContinue_OLD == TRUE) {
        if (![[txtHomeAddr1.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
            if([txtHomePostCode.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Home Address PostCode is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [txtHomePostCode becomeFirstResponder];
                
                [alert show];
                return false;
            }
        }
		
    }
    else {
		if (![[txtHomeAddr1.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
            if([txtHomePostCode.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Home Address PostCode is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [txtHomePostCode becomeFirstResponder];
                
                [alert show];
                return false;
            }
        }
        
    }
    
    
    if([[txtOfiiceAddr1.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]){
        if (![[txtOfficePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
            //if ([self OptionalOccp:OccupCodeSelected] == FALSE) {
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
															message:@"Office Address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[txtOfiiceAddr1 becomeFirstResponder];
			
			[alert show];
			return false;
            //}
			
        }
        
        
    }
    
    
    
    if (IsContinue_OLD == TRUE) {
        /*
		 if([txtOfficePostCode.text isEqualToString:@""]){
		 if ([self OptionalOccp:OccupCodeSelected] == FALSE) {
		 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
		 message:@"Office Address PostCode is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		 
		 [txtOfficePostCode becomeFirstResponder];
		 
		 [alert show];
		 return false;
		 }
		 else {
		 txtOfficeState.text = @"";
		 txtOfficeTown.text = @"";
		 txtOfficeCountry.text = @"";
		 }
		 
		 }
         */
        if (![[txtOfiiceAddr1.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
            if([txtOfficePostCode.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Office Address PostCode is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [txtOfficePostCode becomeFirstResponder];
                
                [alert show];
                return false;
            }
        }
        
    }
    
    else {
        if (![[txtOfiiceAddr1.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
            if([txtOfficePostCode.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Office Address PostCode is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [txtOfficePostCode becomeFirstResponder];
                
                [alert show];
                return false;
            }
        }
    }
    
    
    
    
    if(![txtEmail.text isEqualToString:@""]){
        if( [self NSStringIsValidEmail:txtEmail.text] == FALSE){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"You have entered an invalid email." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [txtEmail becomeFirstResponder];
            
            [alert show];
            return FALSE;
        }
    }
    
    return true;
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

-(void) GetLastID{
    
    sqlite3_stmt *statement3;
    NSString *lastID = @"";
    NSString *contactCode = @"";
    
    //delete record first
    [self DeleteRecord];
    
    for (int a=0; a<5; a++) {
        
        switch (a) {
                
            case 0:
                if ([outletType1.titleLabel.text isEqualToString:@"Mobile"]) {
                    contactCode = @"CONT008";
                }
                else if ([outletType1.titleLabel.text isEqualToString: @"Home"]) {
                    contactCode = @"CONT006";
                }
                else if ([outletType1.titleLabel.text isEqualToString:@"Fax"]) {
                    contactCode = @"CONT009";
                }
                else if ([outletType1.titleLabel.text isEqualToString:@"Office"]) {
                    contactCode = @"CONT007";
                }
                else {
                    contactCode = @"";
                }
                
                break;
				
            case 1:
                if ([outletType2.titleLabel.text isEqualToString:@"Mobile"]) {
                    contactCode = @"CONT008";
                }
                else if ([outletType2.titleLabel.text isEqualToString:@"Home"]) {
                    contactCode = @"CONT006";
                }
                else if ([outletType2.titleLabel.text isEqualToString:@"Fax"]) {
                    contactCode = @"CONT009";
                }
                else if ([outletType2.titleLabel.text isEqualToString:@"Office"]) {
                    contactCode = @"CONT007";
                }
                else {
                    contactCode = @"";
                }
                
				
                break;
            case 2:
                if ([outletType3.titleLabel.text isEqualToString:@"Mobile"]) {
                    contactCode = @"CONT008";
                }
                else if ([outletType3.titleLabel.text isEqualToString:@"Home"]) {
                    contactCode = @"CONT006";
                }
                else if ([outletType3.titleLabel.text isEqualToString:@"Fax"]) {
                    contactCode = @"CONT009";
                }
                else if ([outletType3.titleLabel.text isEqualToString:@"Office"]) {
                    contactCode = @"CONT007";
                }
                else {
                    contactCode = @"";
                }
                
				
                break;
            case 3:
                if ([outletType4.titleLabel.text isEqualToString:@"Mobile"]) {
                    contactCode = @"CONT008";
                }
                else if ([outletType4.titleLabel.text isEqualToString:@"Home"]) {
                    contactCode = @"CONT006";
                }
                else if ([outletType4.titleLabel.text isEqualToString:@"Fax"]) {
                    contactCode = @"CONT009";
                }
                else if ([outletType4.titleLabel.text isEqualToString:@"Office"]) {
                    contactCode = @"CONT007";
                }
                else {
                    contactCode = @"";
                }
                
				
                break;
            case 4:
                if ([outletType5.titleLabel.text isEqualToString:@"Mobile"]) {
                    contactCode = @"CONT008";
                }
                else if ([outletType5.titleLabel.text isEqualToString:@"Home"]) {
                    contactCode = @"CONT006";
                }
                else if ([outletType5.titleLabel.text isEqualToString:@"Fax"]) {
                    contactCode = @"CONT009";
                }
                else if ([outletType5.titleLabel.text isEqualToString:@"Office"]) {
                    contactCode = @"CONT007";
                }
                else {
                    contactCode = @"";
                }
				
                break;
				
        }
        
        
        if (![contactCode isEqualToString:@""]) {
			
            lastID = pp.ProspectID;
            NSString *insertContactSQL;
            
            if (a == 0) {
                insertContactSQL = [NSString stringWithFormat:
									@"INSERT INTO contact_input(\"IndexNo\",\"contactCode\", \"ContactNo\", \"Primary\", \"Prefix\") "
									" VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", lastID, contactCode, txtContact1.text, @"N", txtPrefix1.text];
                
            }
            else if (a == 1) {
                insertContactSQL = [NSString stringWithFormat:
                                    @"INSERT INTO contact_input(\"IndexNo\",\"contactCode\", \"ContactNo\", \"Primary\", \"Prefix\") "
                                    " VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", lastID, contactCode, txtContact2.text, @"N", txtPrefix2.text];
                
            }
            else if (a == 2) {
                insertContactSQL = [NSString stringWithFormat:
                                    @"INSERT INTO contact_input(\"IndexNo\",\"contactCode\", \"ContactNo\", \"Primary\", \"Prefix\") "
                                    " VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", lastID, contactCode, txtContact3.text, @"N", txtPrefix3.text];
                
            }
            else if (a == 3) {
                insertContactSQL = [NSString stringWithFormat:
                                    @"INSERT INTO contact_input(\"IndexNo\",\"contactCode\", \"ContactNo\", \"Primary\", \"Prefix\") "
                                    " VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", lastID, contactCode, txtContact4.text, @"N", txtPrefix4.text];
                
            }
            else if (a == 4) {
                insertContactSQL = [NSString stringWithFormat:
                                    @"INSERT INTO contact_input(\"IndexNo\",\"contactCode\", \"ContactNo\", \"Primary\", \"Prefix\") "
                                    " VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", lastID, contactCode, txtContact5.text, @"N", txtPrefix5.text];
                
            }
            
            if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK) {
                
                const char *insert_contactStmt = [insertContactSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, insert_contactStmt, -1, &statement3, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement3) == SQLITE_DONE){
                        sqlite3_finalize(statement3);
                        //UIAlertView *SuccessAlert = [[UIAlertView alloc] initWithTitle:@"Prospect Profile" message:@"Saved Successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
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
    
    /*
	 UIAlertView *SuccessAlert = [[UIAlertView alloc] initWithTitle:@"Edit Prospect Profile"
	 message:@"Prospect record successfully updated." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	 SuccessAlert.tag = 2;
	 [SuccessAlert show];
	 */
    /*
	 ProspectListing *ListingPage = [self.storyboard instantiateViewControllerWithIdentifier:@"Listing"];
	 [ListingPage ReloadTableData];
	 [ListingPage.tableView reloadData];
	 */
}


- (void) DeleteRecord{
    sqlite3_stmt *statement;
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *DeleteSQL = [NSString stringWithFormat:@"Delete from contact_input where indexNo = \"%@\"", pp.ProspectID];
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

- (void)OccupCodeSelected:(NSString *)OccupCode{
    OccupCodeSelected = OccupCode;
    strChanges = @"Yes";
    /*
	 if ([self OptionalOccp:OccupCodeSelected] == TRUE ) {
	 lblOfficeAddr.text = @"Office Address";
	 lblPostCode.text = @"Postcode";
	 }
	 else {
	 lblOfficeAddr.text = @"Office Address*";
	 lblPostCode.text = @"Postcode*";
	 }
     */
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
	
}

- (void)OccupDescSelected:(NSString *)color {
    [outletOccup setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", color] forState:UIControlStateNormal];
    
    [self resignFirstResponder];
    [self.view endEditing:TRUE];
    [self.OccupationListPopover dismissPopoverAnimated:YES];
    
}

-(BOOL)OptionalOccp:(NSString *)OccupationCode{
    sqlite3_stmt *statement;
    BOOL valid = FALSE;
    
    if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT \"OccpCatCode\" from Adm_OccpCat_Occp WHERE OccpCode = \"%@\" ", OccupationCode];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String ], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW){
                NSString *cat = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                if ([[cat stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@"EMP"]) {
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
    /*
	 if (   [OccupationCode isEqualToString:@"OCC02317"] || [OccupationCode isEqualToString:@"OCC02229"]
	 || [OccupationCode isEqualToString:@"OCC01109"] || [OccupationCode isEqualToString:@"OCC01179"]
	 || [OccupationCode isEqualToString:@"OCC01865"] || [OccupationCode isEqualToString:@"OCC02229"]
	 || [OccupationCode isEqualToString:@"OCC00570"] || [OccupationCode isEqualToString:@"OCC01596"]
	 || [OccupationCode isEqualToString:@"OCC02147"] || [OccupationCode isEqualToString:@"OCC02148"]
	 || [OccupationCode isEqualToString:@"OCC02149"] || [OccupationCode isEqualToString:@"OCC02321"]) {
	 return TRUE;
	 }
	 else {
	 return FALSE;
	 }
	 */
    return valid;
}

-(void)keyboardDidShow:(NSNotificationCenter *)notification
{
    self.myScrollView.frame = CGRectMake(0, 20, 1000, 748-420);
    self.myScrollView.contentSize = CGSizeMake(1000, 748);
    
    CGRect textFieldRect = [activeField frame];
    textFieldRect.origin.y += 15;
    [self.myScrollView scrollRectToVisible:textFieldRect animated:YES];
    
    txtRemark.hidden = FALSE;
}

-(void)keyboardDidHide:(NSNotificationCenter *)notification
{
    self.myScrollView.frame = CGRectMake(0, 20, 1000, 748);
    
}
/*
 - (IBAction)btnCancel:(id)sender {
 //[self dismissModalViewControllerAnimated:YES];
 
 
 [self.view endEditing:YES];
 [self resignFirstResponder];
 
 Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
 id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
 [activeInstance performSelector:@selector(dismissKeyboard)];
 
 
 if ([strChanges isEqualToString:@"Yes"]) {
 
 UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Prospect Profile" message:@"Are you sure you want to discard all the changes ?"
 delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", Nil];
 Alert.tag = 1003;
 [Alert show];
 }
 else {
 [self dismissModalViewControllerAnimated:YES];
 }
 
 
 }
 */
- (IBAction)btnSave:(id)sender {
    [self.view endEditing:YES];
    [self resignFirstResponder];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    self.myScrollView.frame = CGRectMake(0, 20, 1024, 748);
    
    _OccupationList = Nil;
    _SIDate = Nil;
    
    if ([strChanges isEqualToString:@"Yes"]) {
        /*
		 UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Prospect Profile" message:@"Are you sure you want to save all the changes ?"
		 delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", Nil];
		 Alert.tag = 1003;
		 [Alert show];
         */
        [self SaveChanges];
    }
    else {
        [self SaveChanges];
        //[self dismissModalViewControllerAnimated:YES];
        
    }
    
    IsContinue_OLD = TRUE;
    /*
	 ProspectListing *ListingPage = [self.storyboard instantiateViewControllerWithIdentifier:@"Listing"];
	 [ListingPage ReloadTableData];
	 [ListingPage.tableView reloadData];
	 */
    
}

-(void)SaveChanges{
    
    if ([self Validation] == TRUE) {
        
        sqlite3_stmt *statement;
        
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            txtPreferredName.text = [txtPreferredName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            txtrFullName.text = [txtrFullName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            NSString *insertSQL = [NSString stringWithFormat:
                                   @"update prospect_profile set \"PreferredName\" = \"%@\" ,\"ProspectName\" = \"%@\", \"ProspectDOB\" = \"%@\", "
                                   "\"ProspectGender\" = \"%@\", \"ResidenceAddress1\" = \"%@\", \"ResidenceAddress2\" = \"%@\", \"ResidenceAddress3\" = \"%@\", "
                                   "\"ResidenceAddressTown\" = \"%@\",\"ResidenceAddressState\" = \"%@\",\"ResidenceAddressPostCode\" = \"%@\", "
                                   "\"ResidenceAddressCountry\"= \"%@\", \"OfficeAddress1\"= \"%@\", \"OfficeAddress2\"= \"%@\", \"OfficeAddress3\"= \"%@\", "
                                   "\"OfficeAddressTown\"= \"%@\",\"OfficeAddressState\"= \"%@\",\"OfficeAddressPostCode\"= \"%@\", "
                                   "\"OfficeAddressCountry\"= \"%@\", \"ProspectEmail\"= \"%@\",\"ProspectOccupationCode\"= \"%@\", \"ExactDuties\"= \"%@\", \"ProspectRemark\"= \"%@\","
                                   "\"DateModified\"= %@,\"ModifiedBy\"= \"%@\" where indexNo = \"%@\" "
                                   "", txtPreferredName.text, txtrFullName.text, outletDOB.titleLabel.text, gender, txtHomeAddr1.text, txtHomeAddr2.text,
                                   txtHomeAddr3.text, txtHomeTown.text, SelectedStateCode, txtHomePostCode.text, txtHomeCountry.text, txtOfiiceAddr1.text,
                                   txtOfficeAddr2.text, txtOfficeAddr3.text, txtOfficeTown.text, SelectedOfficeStateCode, txtOfficePostCode.text,
                                   txtOfficeCountry.text, txtEmail.text, OccupCodeSelected, txtExactDuties.text, txtRemark.text, @"datetime(\"now\", \"+8 hour\")", @"1", pp.ProspectID];
            
            
            const char *Update_stmt = [insertSQL UTF8String];
            if(sqlite3_prepare_v2(contactDB, Update_stmt, -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    [self GetLastID];
                    
                } else {
                    
                    UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Prospect Profile" message:@"Fail in update" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
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
        
        
        //[self dismissModalViewControllerAnimated:NO];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}




-(void)EditTextFieldDidChange:(id) sender
{
    
    BOOL gotRow = false;
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    
    txtHomePostCode.text =[txtHomePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""] ;
    
    if ([txtHomePostCode.text isEqualToString:@""]) {
		/*
		 rrr = [[UIAlertView alloc] initWithTitle:@"Error"
		 message:@"Home PostCode is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		 rrr.tag = 2001;
		 [rrr show];
		 return;
		 */
        
        txtHomePostCode.text = @"";
        txtHomeState.text = @"";
        txtHomeTown.text = @"";
        txtHomeCountry.text = @"";
        SelectedStateCode = @"";
        //txtHomeAddr1.text = @"";
        //txtHomeAddr2.text = @"";
        //txtHomeAddr3.text = @"";
        outletDone.enabled = TRUE;
    }
    else{
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtHomePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
        valid = [alphaNums isSupersetOfSet:inStringSet];
        if (!valid) {
            
            rrr = [[UIAlertView alloc] initWithTitle:@"Error"
                                             message:@"Home PostCode must be in numeric" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            rrr.tag = 2001;
            [rrr show];
            txtHomePostCode.text = @"";
            txtHomeState.text = @"";
            txtHomeTown.text = @"";
            txtHomeCountry.text = @"";
            SelectedStateCode = @"";
            IsContinue_OLD = FALSE;
            
        }
        else {
            if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
                NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", txtHomePostCode.text];
                const char *query_stmt = [querySQL UTF8String];
                if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    
                    if (sqlite3_step(statement) == SQLITE_ROW){
                        NSString *Town = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                        NSString *State = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                        NSString *Statecode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                        
                        txtHomeState.text = State;
                        txtHomeTown.text = Town;
                        txtHomeCountry.text = @"MALAYSIA";
                        SelectedStateCode = Statecode;
                        gotRow = true;
                        IsContinue_OLD = TRUE;
                        outletDone.enabled = YES;
                    }
                    sqlite3_finalize(statement);
                    
                }
                
                if (gotRow == false) {
                    
                    rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No PostCode found for Home Address"
                                                    delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    rrr.tag = 2000;
                    txtHomePostCode.text = @"";
                    txtHomeState.text = @"";
                    txtHomeTown.text = @"";
                    txtHomeCountry.text = @"";
                    SelectedStateCode = @"";
                    //[NoPostcode show];
                    [rrr show];
                    IsContinue_OLD = FALSE;
                    
                    
                }
                sqlite3_close(contactDB);
            }
            
        }
    }
    
	
    
}

-(void)dismiss:(UIAlertView*)alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)EditOfficePostcodeDidChange:(id) sender
{
	BOOL gotRow = false;
	const char *dbpath = [databasePath UTF8String];
	sqlite3_stmt *statement;
	
	txtOfficePostCode.text = [txtOfficePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""];
	
    if ([txtOfficePostCode.text isEqualToString:@""]) {
        
        /*
		 if ([self OptionalOccp:OccupCodeSelected] == FALSE) {
		 
		 rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Office postcode is required"
		 delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		 rrr.tag = 3001;
		 [rrr show];
		 return;
		 }
		 else {
		 txtOfficePostCode.text = @"";
		 txtOfficeState.text = @"";
		 txtOfficeTown.text = @"";
		 txtOfficeCountry.text = @"";
		 SelectedOfficeStateCode = @"";
		 txtOfiiceAddr1.text = @"";
		 txtOfficeAddr2.text = @"";
		 txtOfficeAddr3.text = @"";
		 }
         */
        txtOfficePostCode.text = @"";
        txtOfficeState.text = @"";
        txtOfficeTown.text = @"";
        txtOfficeCountry.text = @"";
        SelectedOfficeStateCode = @"";
        //txtOfiiceAddr1.text = @"";
        //txtOfficeAddr2.text = @"";
        //txtOfficeAddr3.text = @"";
        outletDone.enabled = TRUE;
        
    }
    
	BOOL valid;
	NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
	NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtOfficePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
	valid = [alphaNums isSupersetOfSet:inStringSet];
	if (!valid) {
		/*
		 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
		 message:@"Office post code must be in numeric" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		 
		 alert.tag = 3001;
		 [alert show];
		 */
		
		rrr = [[UIAlertView alloc] initWithTitle:@"Error"
										 message:@"Office post code must be in numeric" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		
		rrr.tag = 3001;
		[rrr show];
		txtOfficePostCode.text = @"";
		txtOfficeState.text = @"";
		txtOfficeTown.text = @"";
		txtOfficeCountry.text = @"";
		SelectedOfficeStateCode = @"";
		IsContinue_OLD = FALSE;
		
	}
	else {
		if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
			NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", txtOfficePostCode.text];
			const char *query_stmt = [querySQL UTF8String];
			if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
			{
				if (sqlite3_step(statement) == SQLITE_ROW){
					NSString *OfficeTown = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
					NSString *OfficeState = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
					NSString *Statecode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
					
					txtOfficeState.text = OfficeState;
					txtOfficeTown.text = OfficeTown;
					txtOfficeCountry.text = @"MALAYSIA";
					SelectedOfficeStateCode = Statecode;
					gotRow = true;
					IsContinue_OLD = TRUE;
					outletDone.enabled = TRUE;
				}
				sqlite3_finalize(statement);
				
				if (gotRow == false) {
					/*
					 UIAlertView *NoOfficePostcode = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No postcode found for office"
					 delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
					 NoOfficePostcode.tag = 3000;
					 */
					
					rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No postcode found for office"
													delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
					rrr.tag = 3000;
					[txtOfficePostCode becomeFirstResponder];
					txtOfficePostCode.text = @"";
					txtOfficeState.text = @"";
					txtOfficeTown.text = @"";
					txtOfficeCountry.text = @"";
					SelectedOfficeStateCode = @"";
					
					//[NoOfficePostcode show];
					[rrr show];
					IsContinue_OLD = FALSE;
					
				}
			}
			sqlite3_close(contactDB);
		}
		
	}
}

-(void)detectChanges:(id) sender{
    strChanges = @"Yes";
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
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
							 UIAlertView *SuccessAlert = [[UIAlertView alloc] initWithTitle:@"Prospect Profile" message:@"Delete Success" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
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
							
							UIAlertView *SuccessAlert = [[UIAlertView alloc] initWithTitle:@"Prospect Profile"
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
        }
            break;
            
        case 1:
        {
            
            if (alertView.tag == 1) { //delete mode
                /*
				 const char *dbpath = [databasePath UTF8String];
				 
				 if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
				 NSString *DeleteProspectSQL = [NSString stringWithFormat:
				 @"Delete from prospect_profile where \"indexNo\" = \"%@\" ", pp.ProspectID];
				 
				 const char *Delete_prospectStmt = [DeleteProspectSQL UTF8String];
				 if(sqlite3_prepare_v2(contactDB, Delete_prospectStmt, -1, &statement, NULL) == SQLITE_OK)
				 {
				 int zzz = sqlite3_step(statement);
				 
				 if (zzz == SQLITE_DONE){
				 
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
				 
				 UIAlertView *SuccessAlert = [[UIAlertView alloc] initWithTitle:@"Prospect Profile"
				 message:@"Prospect record successfully been deleted" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
				 SuccessAlert.tag = 2;
				 [SuccessAlert show];
				 
				 }
				 sqlite3_finalize(statement2);
				 
				 }
				 
				 sqlite3_close(contactDB);
				 }
                 */
				
            }
            else if (alertView.tag == 1003) { //save changes
                //[self SaveChanges];
            }
			
        }
            break;
    }
}

- (IBAction)btnContact2:(id)sender {
    [self resignFirstResponder];
    [self.view endEditing:TRUE];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    
    txtContact2.enabled = true;
    ContactTypeTracker = @"2";
    if (_ContactTypeClass == nil) {
        self.ContactTypeClass = [[ContactTypeClass alloc] initWithStyle:UITableViewStylePlain];
        _ContactTypeClass.ContactTypeDelegate = self;
        self.ContactTypePopover = [[UIPopoverController alloc] initWithContentViewController:_ContactTypeClass];
    }
    [self.ContactTypePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    
    [self.ContactTypePopover presentPopoverFromRect:[sender frame]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

- (IBAction)btnContact3:(id)sender {
    [self resignFirstResponder];
    [self.view endEditing:TRUE];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    
    txtContact3.enabled = true;
    ContactTypeTracker = @"3";
    if (_ContactTypeClass == nil) {
        self.ContactTypeClass = [[ContactTypeClass alloc] initWithStyle:UITableViewStylePlain];
        _ContactTypeClass.ContactTypeDelegate = self;
        self.ContactTypePopover = [[UIPopoverController alloc] initWithContentViewController:_ContactTypeClass];
    }
    [self.ContactTypePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    
    [self.ContactTypePopover presentPopoverFromRect:[sender frame]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

- (IBAction)btnContact4:(id)sender {
    [self resignFirstResponder];
    [self.view endEditing:TRUE];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    txtContact4.enabled = true;
    ContactTypeTracker = @"4";
    if (_ContactTypeClass == nil) {
        self.ContactTypeClass = [[ContactTypeClass alloc] initWithStyle:UITableViewStylePlain];
        _ContactTypeClass.ContactTypeDelegate = self;
        self.ContactTypePopover = [[UIPopoverController alloc] initWithContentViewController:_ContactTypeClass];
    }
    [self.ContactTypePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    
    [self.ContactTypePopover presentPopoverFromRect:[sender frame]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

- (IBAction)btnContact5:(id)sender {
    
    [self resignFirstResponder];
    [self.view endEditing:TRUE];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    txtContact5.enabled = true;
    ContactTypeTracker = @"5";
    if (_ContactTypeClass == nil) {
        self.ContactTypeClass = [[ContactTypeClass alloc] initWithStyle:UITableViewStylePlain];
        _ContactTypeClass.ContactTypeDelegate = self;
        self.ContactTypePopover = [[UIPopoverController alloc] initWithContentViewController:_ContactTypeClass];
    }
    [self.ContactTypePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    
    [self.ContactTypePopover presentPopoverFromRect:[sender frame]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

-(void)ContactTypeSelected:(NSString *)ContactTypeString{
    if ([ContactTypeTracker isEqualToString:@"1" ]) {
        [outletType1 setTitle:ContactTypeString forState:UIControlStateNormal ];
        [self.ContactTypePopover dismissPopoverAnimated:YES];
        
    }
    else if ([ContactTypeTracker isEqualToString:@"2" ]) {
        [outletType2 setTitle:ContactTypeString forState:UIControlStateNormal ];
        [self.ContactTypePopover dismissPopoverAnimated:YES];
    }
    else if ([ContactTypeTracker isEqualToString:@"3" ]) {
        [outletType3 setTitle:ContactTypeString forState:UIControlStateNormal ];
        [self.ContactTypePopover dismissPopoverAnimated:YES];
    }
    else if ([ContactTypeTracker isEqualToString:@"4" ]) {
        [outletType4 setTitle:ContactTypeString forState:UIControlStateNormal ];
        [self.ContactTypePopover dismissPopoverAnimated:YES];
    }
    else if ([ContactTypeTracker isEqualToString:@"5" ]) {
        [outletType5 setTitle:ContactTypeString forState:UIControlStateNormal ];
        [self.ContactTypePopover dismissPopoverAnimated:YES];
    }
}

-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate{
    
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *d = [NSDate date];
    NSDate* d2 = [df dateFromString:dbDate];
    
    if ([d compare:d2] == NSOrderedAscending) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Entered date cannot be greater than today." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
        
    }
    else{
        [outletDOB setTitle:strDate forState:UIControlStateNormal ];
    }
}

-(void)CloseWindow{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [_SIDatePopover dismissPopoverAnimated:YES];
}

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}

- (IBAction)btnCancel:(id)sender {
    
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
	
    _SIDate = nil;
    
    self.myScrollView.frame = CGRectMake(0, 20, 1000, 748);
    
    //[self dismissModalViewControllerAnimated:YES];
    if ([strChanges isEqualToString:@"Yes"]) {
        
        UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"Prospect Profile" message:@"Are you sure you want to discard all the changes ?"
                                                       delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", Nil];
        Alert.tag = 1003;
        [Alert show];
    }
    else {
        outletDone.enabled = TRUE;
        [rrr dismissWithClickedButtonIndex:0 animated:NO];
        [self dismissModalViewControllerAnimated:YES];
    }
    
}

-(void)OccupClassSelected:(NSString *)OccupClass{
	
}

@end
