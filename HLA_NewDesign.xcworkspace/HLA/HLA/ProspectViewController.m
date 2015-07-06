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

@interface ProspectViewController ()

@end

@implementation ProspectViewController
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
@synthesize outletOccup,ClientSmoker,btnOfficeCountry;
@synthesize myScrollView,outletGroup,OtherIDType,txtIDType,txtOtherIDType;
@synthesize txtFullName, ContactTypeTracker,segSmoker,outletTitle,outletNationality,outletRace,outletMaritalStatus,outletReligion;
@synthesize segGender, ContactType, DOB, gender, SelectedStateCode, SelectedOfficeStateCode, OccupCodeSelected,pp;
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

bool PostcodeContinue = TRUE;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
	
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    
    
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    txtRemark.layer.borderWidth = 1.0f;
    txtRemark.layer.borderColor = [[UIColor grayColor] CGColor];
    
   
    
    
    //easysqlite---------start
    self.db = [DBController sharedDatabaseController:@"hladb.sqlite"];
    NSString *sqlStmt1 = [NSString stringWithFormat:@"SELECT IDtypeNo, otheridtype and otheridtypeno FROM prospect_profile where idtypeno and otheridtype is not null"];
    _tableDB = [_db  ExecuteQuery:sqlStmt1];
    //---------end
    
    [txtHomePostCode addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    [txtOfficePostcode addTarget:self action:@selector(OfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    [txtHomePostCode addTarget:self action:@selector(EditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [txtOfficePostcode addTarget:self action:@selector(OfficeEditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [txtIDType addTarget:self action:@selector(NewICDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    [txtIDType addTarget:self action:@selector(NewICTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [txtAnnIncome addTarget:self action:@selector(AnnualIncomeChange:) forControlEvents:UIControlEventEditingDidEnd];
    [txtOtherIDType addTarget:self action:@selector(OtheriDDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    
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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnSave:)];
    checked = NO;
    checked2 = NO;
    isHomeCountry = NO;
    isOffCountry = NO;
    companyCase = NO;
    
    
    
    
    CustomColor = Nil;
    
    [myScrollView setScrollEnabled:YES];
    [myScrollView setContentSize:CGSizeMake(1024, 819)];
    //test6
    
}
/*
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
 
 NSString *SelectedContactType = [ContactType objectAtIndex:row];
 
 if (ContactTypeTracker == @"2") {
 txtContact2.enabled = true;
 [outletType2 setTitle:SelectedContactType forState:UIControlStateNormal];
 
 }
 else if (ContactTypeTracker == @"1") {
 txtContact1.enabled = true;
 [outletType1 setTitle:SelectedContactType forState:UIControlStateNormal];
 
 }
 else if (ContactTypeTracker == @"3") {
 txtContact3.enabled = true;
 [outletType3 setTitle:SelectedContactType forState:UIControlStateNormal];
 
 }
 else if (ContactTypeTracker == @"4") {
 txtContact4.enabled = true;
 [outletType4 setTitle:SelectedContactType forState:UIControlStateNormal];
 }
 else if (ContactTypeTracker == @"5") {
 txtContact5.enabled = TRUE;
 [outletType5 setTitle:SelectedContactType forState:UIControlStateNormal];
 }
 
 }
 */

- (void)viewWillAppear:(BOOL)animated
{
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
    self.myScrollView.contentSize = CGSizeMake(1024, 819);
    
    CGRect textFieldRect = [activeField frame];
    textFieldRect.origin.y += 15;
    [self.myScrollView scrollRectToVisible:textFieldRect animated:YES];
    txtRemark.hidden = FALSE;
}

-(void)keyboardDidHide:(NSNotificationCenter *)notification
{
    self.myScrollView.frame = CGRectMake(0, -44, 1024, 748);
}

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}

-(void)textFieldDidChange:(id) sender
{
    BOOL gotRow = false;
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    txtHomePostCode.text = [txtHomePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([txtHomePostCode.text isEqualToString:@""]) {
        
        rrr = [[UIAlertView alloc] initWithTitle:@"Error"
                                         message:@"Home postcode is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        rrr.tag = 2001;
        [rrr show];
        return;
    }
    
    BOOL valid;
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtHomePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    valid = [alphaNums isSupersetOfSet:inStringSet];
    if (!valid) {
        
        rrr = [[UIAlertView alloc] initWithTitle:@"Error"
                                         message:@"Home post code must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        rrr.tag = 2001;
        [rrr show];
        
        
        txtHomePostCode.text = @"";
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
            
            if (gotRow == false) {
                
                rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No postcode found for Home Address"
                                                delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
                rrr.tag = 2000;
                [rrr show];
                
                txtHomePostCode.text = @"";
                txtHomeState.text = @"";
                txtHomeTown.text = @"";
                txtHomeCountry.text = @"";
                SelectedStateCode = @"";
                
                PostcodeContinue = FALSE;
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
    
    if ([txtOfficePostcode.text isEqualToString:@""]) {
        
        rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Office postcode is required"
                                        delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        rrr.tag = 3001;
        [rrr show];
        return;
    }
    
    BOOL valid;
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtOfficePostcode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    valid = [alphaNums isSupersetOfSet:inStringSet];
    if (!valid) {
        
        rrr = [[UIAlertView alloc] initWithTitle:@"Error"
                                         message:@"Office post code must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        rrr.tag = 3001;
        [rrr show];
        
        txtOfficePostcode.text = @"";
        txtOfficeState.text = @"";
        txtOfficeTown.text = @"";
        txtOfficeCountry.text = @"";
        SelectedOfficeStateCode = @"";
        PostcodeContinue = FALSE;
    }
    else {
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
                
                if (gotRow == false) {
                    /*UIAlertView *NoPostcode = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No postcode found for office"
                     delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                     
                     NoPostcode.tag = 3000;
                     [NoPostcode show];*/
                    rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No postcode found for office"
                                                    delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    
                    rrr.tag = 3000;
                    [rrr show];
                    
                    txtOfficePostcode.text = @"";
                    txtOfficeState.text = @"";
                    txtOfficeTown.text = @"";
                    txtOfficeCountry.text = @"";
                    SelectedOfficeStateCode = @"";
                    
                    PostcodeContinue = FALSE;
                }
                
                sqlite3_close(contactDB);
            }
        }
    }
    
    
}

-(void)EditTextFieldBegin:(id)sender
{
    self.navigationItem.rightBarButtonItem.enabled = FALSE;
}

-(void)OfficeEditTextFieldBegin:(id)sender
{
    
    if ([self OptionalOccp] == FALSE) {
        self.navigationItem.rightBarButtonItem.enabled = FALSE;
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *myString = nil;
    
    if (textField == txtFullName) {
        myString = [txtFullName.text stringByReplacingCharactersInRange:range withString:string];
        if (myString.length > 2) {
            NSString *last = [myString substringFromIndex:[myString length] -1];
            NSString *secLast = [myString substringWithRange:NSMakeRange([myString length] -2, 1)];
            NSString *thirdLast = [myString substringWithRange:NSMakeRange([myString length] -3, 1)];
            
            if ([last isEqualToString:secLast] &&  [secLast isEqualToString:thirdLast]) {
                return NO;
            }
        }
    }
    
    if (textField == txtAnnIncome) {
        
        myString = [txtAnnIncome.text stringByReplacingCharactersInRange:range withString:string];
        NSArray  *arrayOfString = [myString componentsSeparatedByString:@"."];
        if ([arrayOfString count] > 2 )
        {
            return NO;
        }
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
    
    
    return YES;
}

-(void)AnnualIncomeChange:(id) sender
{
    txtAnnIncome.text = [txtAnnIncome.text stringByReplacingOccurrencesOfString:@" " withString:@""];
}

-(void)OtheriDDidChange:(id) sender
{
    [self OtherIDValidation];
}

-(void)NewICDidChange:(id) sender
{
    ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
    txtIDType.text = [txtIDType.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([txtIDType.text isEqualToString:@""]) {
        /*
         rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New IC No is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         rrr.tag = 1002;
         [rrr show];
         txtIDType.text = @"";
         txtDOB.text = @"";
         segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
         */
        
        if([OtherIDType.titleLabel.text isEqualToString:@"Passport"])
        {
            companyCase = NO;
            
            // check if ic field is empty
            if ([txtIDType.text isEqualToString:@""]) {
                
                
                txtIDType.backgroundColor = [UIColor whiteColor];
                txtIDType.enabled = YES;
                segGender.enabled = YES;
                segSmoker.enabled = YES;
                //outletDOB.enabled = YES;
                //outletDOB.hidden = NO;
                //txtDOB.backgroundColor = [UIColor whiteColor];
                //outletDOB.titleLabel.text =@"";
                //txtDOB.text = @"";
                
                //txtDOB.hidden = YES;
                //txtDOB.text = @"";
                //txtDOB.backgroundColor = [UIColor whiteColor];
                
                // Reset gender
                //segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                
                // Reset dob
                //txtDOB.text = @"";
                outletDOB.hidden = NO;
                outletDOB.enabled = TRUE;
                
                //[outletDOB setTitle:@"- Select -" forState:UIControlStateNormal];
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
            // outletOccup.titleLabel.text = @"- Select -";
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
            
            
        } else {
            
            txtDOB.text = @"";
            segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
            
        }
        
        txtIDType.text = @"";
        
        self.navigationItem.rightBarButtonItem.enabled = TRUE;
        
        return;
        
        
    }else if (txtIDType.text.length != 12) {
        rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid New IC No length. IC No length should be 12 characters long" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        rrr.tag = 1002;
        [rrr show];
        
        txtIDType.text = @"";

        NSLog(@"Dang Fang -%@",OtherIDType.titleLabel.text);

        if([OtherIDType.titleLabel.text isEqualToString:@"Passport"])
        {
            companyCase = NO;
            
            // check if ic field is empty
            if ([txtIDType.text isEqualToString:@""]) {
                
                txtIDType.backgroundColor = [UIColor whiteColor];
                txtIDType.enabled = YES;
                segGender.enabled = YES;
                segSmoker.enabled = YES;
                //outletDOB.enabled = YES;
                //outletDOB.hidden = NO;
                //txtDOB.backgroundColor = [UIColor whiteColor];
                //outletDOB.titleLabel.text =@"";
                //txtDOB.text = @"";
                
                //txtDOB.hidden = YES;
                //txtDOB.text = @"";
                //txtDOB.backgroundColor = [UIColor whiteColor];
                
                // Reset gender
                //segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                
                // Reset dob
                //txtDOB.text = @"";
                outletDOB.hidden = NO;
                outletDOB.enabled = TRUE;
                
                //[outletDOB setTitle:@"- Select -" forState:UIControlStateNormal];
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
            // outletOccup.titleLabel.text = @"- Select -";
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
            
            
        } else{
        
            txtDOB.text = @"";
            segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        }
        
        self.navigationItem.rightBarButtonItem.enabled = TRUE;
        
        return;
    }
    
    BOOL valid;
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtIDType.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    valid = [alphaNums isSupersetOfSet:inStringSet];
    if (!valid) {
        
        rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New IC No must be in numeric" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        rrr.tag = 1002;
        [rrr show];
        txtIDType.text = @"";
        if([OtherIDType.titleLabel.text isEqualToString:@"Passport"])
        {
            
        }else{
            txtDOB.text = @"";
            segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        }
    }
    else {
        
        NSString *last = [txtIDType.text substringFromIndex:[txtIDType.text length] -1];
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
            rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            rrr.tag = 1002;
            [rrr show];
            
            txtIDType.text = @"";
            if([OtherIDType.titleLabel.text isEqualToString:@"Passport"])
            {
                
            }else{
                txtDOB.text = @"";
                segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
            }
        }
        else if ([strMonth intValue] > 12 || [strMonth intValue] < 1 || [strDate intValue] < 1 || [strDate intValue] > 31) {
            
            rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            rrr.tag = 1002;
            [rrr show];
            
            txtIDType.text = @"";
            if([OtherIDType.titleLabel.text isEqualToString:@"Passport"])
            {
                
            }else{
                txtDOB.text = @"";
                segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
            }
        }
        else if (([strMonth isEqualToString:@"01"] || [strMonth isEqualToString:@"03"] || [strMonth isEqualToString:@"05"] || [strMonth isEqualToString:@"07"] || [strMonth isEqualToString:@"08"] || [strMonth isEqualToString:@"10"] || [strMonth isEqualToString:@"12"]) && [strDate intValue] > 31) {
            
            rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            rrr.tag = 1002;
            [rrr show];
            
            txtIDType.text = @"";
            if([OtherIDType.titleLabel.text isEqualToString:@"Passport"])
            {
                
            }else{
                txtDOB.text = @"";
                segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
            }
        }
        
        else if (([strMonth isEqualToString:@"04"] || [strMonth isEqualToString:@"06"] || [strMonth isEqualToString:@"09"] || [strMonth isEqualToString:@"11"]) && [strDate intValue] > 30) {
            
            rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            rrr.tag = 1002;
            [rrr show];
            
            txtIDType.text = @"";
            if([OtherIDType.titleLabel.text isEqualToString:@"Passport"])
            {
                
            }else{
                txtDOB.text = @"";
                segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
            }
        }
        else if (([febStatus isEqualToString:@"Normal"] && [strDate intValue] > 28 && [strMonth isEqualToString:@"02"]) || ([febStatus isEqualToString:@"Jump"] && [strDate intValue] > 29 && [strMonth isEqualToString:@"02"])) {
            
            rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            rrr.tag = 1002;
            [rrr show];
            
            txtIDType.text = @"";
            if([OtherIDType.titleLabel.text isEqualToString:@"Passport"])
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
        }
        
        last = nil, oddSet = nil;
        strDate = nil, strMonth = nil, strYear = nil, currentYear = nil, strCurrentYear = nil;
        dateFormatter = Nil, strDOB = nil, strDOB2 = nil, d = Nil, d2 = Nil;
    }
    
    alphaNums = nil, inStringSet = nil;
    
    [self IDValidation];
    
    self.navigationItem.rightBarButtonItem.enabled = TRUE;
   
    
}

-(void)NewICTextFieldBegin:(id)sender {
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
    
    self.navigationItem.rightBarButtonItem.enabled = FALSE;
    
    if([OtherIDType.titleLabel.text isEqualToString:@"Passport"])
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
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    NSLog(@"Gender %d",[segGender selectedSegmentIndex]);
    
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

- (IBAction)btnDOB:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
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
        [outletDOB setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", txtDOB.text] forState:UIControlStateNormal];
        
        
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
    UIButton *btnPressed = (UIButton*)sender;
    ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
    
    if (btnPressed.tag == 0) {
        
        if (checked) {
            [btnForeignHome setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
            checked = NO;
            
            txtHomePostCode.text = @"";
            txtHomeTown.text = @"";
            txtHomeState.text = @"";
            txtHomeCountry.text = @"MALAYSIA";
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
            
            txtHomePostCode.text = @"";
            txtHomeTown.text = @"";
            txtHomeState.text = @"";
            [btnHomeCountry setTitle:@"- Select -" forState:UIControlStateNormal];
            btnHomeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            txtHomeTown.backgroundColor = [UIColor whiteColor];
            txtHomeState.backgroundColor = [UIColor whiteColor];
            txtHomeCountry.backgroundColor = [UIColor whiteColor];
            txtHomeTown.enabled = YES;
            txtHomeState.enabled = YES;
            txtHomeCountry.hidden = YES;
            btnHomeCountry.hidden = NO;
            
            [txtHomePostCode removeTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
            [txtHomePostCode removeTarget:self action:@selector(EditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
        }
        
    }
    
    else if (btnPressed.tag == 1) {
        
        if (checked2) {
            [btnForeignOffice setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
            checked2 = NO;
            
            txtOfficePostcode.text = @"";
            txtOfficeTown.text = @"";
            txtOfficeState.text = @"";
            txtOfficeCountry.text = @"MALAYSIA";
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
            
            txtOfficePostcode.text = @"";
            txtOfficeTown.text = @"";
            txtOfficeState.text = @"";
            [btnOfficeCountry setTitle:@"- Select -" forState:UIControlStateNormal];
            btnOfficeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            txtOfficeTown.backgroundColor = [UIColor whiteColor];
            txtOfficeState.backgroundColor = [UIColor whiteColor];
            txtOfficeCountry.backgroundColor = [UIColor whiteColor];
            txtOfficeTown.enabled = YES;
            txtOfficeState.enabled = YES;
            txtOfficeCountry.hidden = YES;
            btnOfficeCountry.hidden = NO;
            
            [txtOfficePostcode removeTarget:self action:@selector(OfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
            [txtOfficePostcode removeTarget:self action:@selector(OfficeEditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
        }
        
    }
}

- (void)btnSave:(id)sender
{
    
   
    [self.view endEditing:YES];
    [self resignFirstResponder];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    _OccupationList = Nil;
    
    if ([self Validation] == TRUE) {
        
        sqlite3_stmt *statement;
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            txtFullName.text = [txtFullName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSString *OffCountry = nil;
            NSString *HomeCountry = nil;
            
            if (checked) {
                HomeCountry = btnHomeCountry.titleLabel.text;
                SelectedStateCode = txtHomeState.text;
            }
            else {
                HomeCountry = txtHomeCountry.text;
            }
            
            if (checked2) {
                OffCountry = btnOfficeCountry.titleLabel.text;
                SelectedOfficeStateCode = txtOfficeState.text;
            }
            else {
                OffCountry = txtOfficeCountry.text;
            }
            
            NSString *strDOB = nil;
            if (txtDOB.text.length == 0) {
                strDOB = [outletDOB.titleLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
            }
            else {
                strDOB = txtDOB.text;
            }
            
            NSString *insertSQL = [NSString stringWithFormat:
                                   @"INSERT INTO prospect_profile(\"ProspectName\", \"ProspectDOB\", \"ProspectGender\", \"ResidenceAddress1\", \"ResidenceAddress2\", \"ResidenceAddress3\", \"ResidenceAddressTown\", \"ResidenceAddressState\",\"ResidenceAddressPostCode\", \"ResidenceAddressCountry\", \"OfficeAddress1\", \"OfficeAddress2\", \"OfficeAddress3\",\"OfficeAddressTown\", \"OfficeAddressState\", \"OfficeAddressPostCode\", \"OfficeAddressCountry\", \"ProspectEmail\",\"ProspectOccupationCode\", \"ExactDuties\", \"ProspectRemark\", \"DateCreated\", \"CreatedBy\", \"DateModified\",\"ModifiedBy\", \"ProspectGroup\", \"ProspectTitle\", \"IDTypeNo\", \"OtherIDType\", \"OtherIDTypeNo\", \"Smoker\", \"AnnualIncome\", \"BussinessType\", \"Race\", \"MaritalStatus\", \"Religion\", \"Nationality\", \"QQFlag\") "
                                   "VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", %@, \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%s\")", txtFullName.text, strDOB, gender, txtHomeAddr1.text, txtHomeAddr2.text, txtHomeAddr3.text, txtHomeTown.text, SelectedStateCode, txtHomePostCode.text, HomeCountry, txtOfficeAddr1.text, txtOfficeAddr2.text, txtOfficeAddr3.text, txtOfficeTown.text, SelectedOfficeStateCode, txtOfficePostcode.text, OffCountry, txtEmail.text, OccupCodeSelected, txtExactDuties.text, txtRemark.text,
                                   @"datetime(\"now\", \"+8 hour\")", @"1", @"", @"1", outletGroup.titleLabel.text, outletTitle.titleLabel.text , txtIDType.text, OtherIDType.titleLabel.text, txtOtherIDType.text, ClientSmoker, txtAnnIncome.text, txtBussinessType.text,outletRace.titleLabel.text,outletMaritalStatus.titleLabel.text,outletReligion.titleLabel.text,outletNationality.titleLabel.text,"false"];
            NSLog(@"QUERY - %@", insertSQL);
            const char *insert_stmt = [insertSQL UTF8String];
            if(sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    [self GetLastID];
                    
                } else {
                    
                    UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Prospect Profile" message:@"Fail in inserting into profile table" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
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
    
    PostcodeContinue = TRUE;
    
}



- (IBAction)actionHomeCountry:(id)sender
{
    isHomeCountry = YES;
    isOffCountry = NO;
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if (_CountryList == nil) {
        self.CountryList = [[Country alloc] initWithStyle:UITableViewStylePlain];
        _CountryList.delegate = self;
        self.CountryListPopover = [[UIPopoverController alloc] initWithContentViewController:_CountryList];
    }
    
    
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
    
    
    [self.ReligionListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}



- (IBAction)addNewGroup:(id)sender
{
    UIAlertView* dialog = [[UIAlertView alloc] initWithTitle:@"Enter Group Name" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    [dialog setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    [[dialog textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeDefault];
    [dialog setTag:1001];
    [dialog show];
}

- (IBAction)actionOfficeCountry:(id)sender
{
    isOffCountry = YES;
    isHomeCountry = NO;
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    if (_CountryList == nil) {
        self.CountryList = [[Country alloc] initWithStyle:UITableViewStylePlain];
        _CountryList.delegate = self;
        self.CountryListPopover = [[UIPopoverController alloc] initWithContentViewController:_CountryList];
    }
    
    
    [self.CountryListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
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
    if (alertView.tag == 1) {
        if (_delegate != Nil) {
            [_delegate FinishInsert ];
        }
        
        [self resignFirstResponder];
        [self.view endEditing:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ((alertView.tag == 2000 || alertView.tag == 2001) && buttonIndex == 0) {
        [txtHomePostCode becomeFirstResponder];
    }
    else if ((alertView.tag == 3000 || alertView.tag == 3001) && buttonIndex == 0) {
        [txtOfficePostcode becomeFirstResponder];
    }
    else if (alertView.tag == 1001 && buttonIndex == 1) {
        
        NSString *str = [NSString stringWithFormat:@"%@",[[alertView textFieldAtIndex:0]text] ];
        if (str.length != 0) {
            
            NSMutableArray *array = [[NSMutableArray alloc] init];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsPath = [paths objectAtIndex:0];
            NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"dataGroup.plist"];
            [array addObjectsFromArray:[NSArray arrayWithContentsOfFile:plistPath]];
            
            BOOL Found = NO;
            
            for (NSString *existing in array) {
                
                if ([str isEqualToString:existing]) {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Group already exist" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
                    [alert show];
                    
                    Found = YES;
                    break;
                }
            }
            
            if (!Found) {
                
                [array addObject:str];
                [array writeToFile:plistPath atomically: TRUE];
                
                outletGroup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [outletGroup setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",str]forState:UIControlStateNormal];
            }
            
        }
        else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please insert data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
            [alert show];
        }
    }
    else if (alertView.tag == 1002) {
        [txtIDType becomeFirstResponder];
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
        self.IDTypePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_IDTypePicker];
    }
    
    
    [self.IDTypePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}


#pragma mark - validation


- (BOOL) OtherIDValidation
{
    for (NSArray* row in _tableDB.rows)
        {
            if([OtherIDType.titleLabel.text isEqualToString:[row objectAtIndex:1]])
            {
                for (NSArray* row in _tableDB.rows){
                    if ([txtOtherIDType.text isEqualToString:[row objectAtIndex:2]]) {
                
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Customer profile has been created using this ID" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                //[txtIDType becomeFirstResponder];
                
                        [alert show];
                        txtOtherIDType.text=@"";
                       
                        return false;
                
           
                    }
                }
            }
        }
    
    
    
    return true;
}


-(BOOL) IDValidation
{
    //NSString *idtypeCheck;
    
    for (NSArray* row in _tableDB.rows){
        
        if ([txtIDType.text isEqualToString:[row objectAtIndex:0]]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Customer profile has been created using this ID" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //[txtIDType becomeFirstResponder];
           
            [alert show];
             txtIDType.text=@"";
            segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
            txtDOB.text = @"";
            return false;
            
        }
    }
    return true;
}
    
 
- (bool) Validation
{
    
    if(!companyCase){
        
        if([outletTitle.titleLabel.text isEqualToString:@"- Select -"]){
            NSLog(@"noted");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Title is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [outletTitle becomeFirstResponder];
            //[self.view endEditing:TRUE];
            
            [alert show];
            return false;
        }
    }
    
    
    if([[txtFullName.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Full Name is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [txtFullName becomeFirstResponder];
        //[self.view endEditing:TRUE];
        
        [alert show];
        return false;
    }
    else {
        BOOL valid;
        NSString *strToBeTest = [txtFullName.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] ;
        
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
            [txtFullName becomeFirstResponder];
            
            [alert show];
            return false;
        }
    }
    
  
    
    
    
    if(companyCase) {
        
        if ([[txtOtherIDType.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Other ID is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtOtherIDType becomeFirstResponder];
            [alert show];
            return false;
        }
        
        if (txtOtherIDType.text.length > 30) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Invalid Other ID length. Other ID length should be not more 30 characters long" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [txtOtherIDType becomeFirstResponder];
            return false;
        }
        
        if ([[txtOtherIDType.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Other ID is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtOtherIDType becomeFirstResponder];
            [alert show];
            return false;
        }
       /*
        if (txtExactDuties.text.length < 1)
        {
           dffd
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Exact duties is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [txtExactDuties becomeFirstResponder];
            [alert show];
            return false;
        }
        else
            */if (txtExactDuties.text.length > 40) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Invalid Exact Duties length. Only 40 characters allowed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [txtExactDuties becomeFirstResponder];
            [alert show];
            return false;
        }
        
        
        if ([txtBussinessType.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Type of business is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [txtBussinessType becomeFirstResponder];
            [alert show];
            return false;
        }
        
        
        if (txtBussinessType.text.length > 60) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Invalid Type of Business length. Only 60 characters allowed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [txtBussinessType becomeFirstResponder];
            [alert show];
            return false;
        }
        
        
        NSString *baby = [outletOccup.titleLabel.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceCharacterSet]];
        
        if ([txtAnnIncome.text isEqualToString:@""]) {
            if((![outletOccup.titleLabel.text isEqualToString:@"HOUSEWIFE"])
                && (![outletOccup.titleLabel.text isEqualToString:@"JUVENILE"])
                && (![outletOccup.titleLabel.text isEqualToString:@"STUDENT"])
                && (![outletOccup.titleLabel.text isEqualToString:@"UNEMPLOYED"])
                && (![outletOccup.titleLabel.text isEqualToString:@"TEMPORARILY UNEMPLOYED"])
                && (![outletOccup.titleLabel.text isEqualToString:@"RETIRED"])
                && (![baby isEqualToString:@"BABY"])) {
                 [txtAnnIncome becomeFirstResponder];
              
                   
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Annual Income is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                
                return false;
            }
        }
        
        
        if (![[txtAnnIncome.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
            
            
            
            NSString *numOnly = [txtAnnIncome.text stringByReplacingOccurrencesOfString:@"." withString:@""];
            
            BOOL valid;
            NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
            //NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:txtAnnIncome.text];
            NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:numOnly];
            valid = [alphaNums isSupersetOfSet:inStringSet];
            if (!valid) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Annual Income must be numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                [txtAnnIncome becomeFirstResponder];
                return false;
            }
            
            NSArray  *comp = [txtAnnIncome.text componentsSeparatedByString:@"."];
            if([comp count]==2){
                
                if([[comp objectAtIndex:1] length]==2)
                {
                }
                else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Annual Income must be in 2 decimal places. Please re-enter." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                    [txtAnnIncome becomeFirstResponder];
                    return false;
                }
            }else if([comp count]>2){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Annual Income must be numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                [txtAnnIncome becomeFirstResponder];
                return false;
                
            }
            
            
            
            if([txtAnnIncome.text isEqualToString:@"0"]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Annual Income must be greater than zero" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                [txtAnnIncome becomeFirstResponder];
                return false;
                
                
            }
            
            if([txtAnnIncome.text isEqualToString:@"-"])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Annual Income must be numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                [txtAnnIncome becomeFirstResponder];
                return false;
                
                
            }
            if (txtAnnIncome.text.length > 13) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Invalid Annual Income length. Annual Income length should be not more than 13 characters long" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [txtAnnIncome becomeFirstResponder];
                return false;
            }
        }

        
        //######office address#######
        if(checked2){
            
            if([txtOfficeAddr1.text isEqualToString:@""])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Office Address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                //[txtOfficeAddr1 becomeFirstResponder];
                
                [alert show];
                return false;
                
            }
            if([btnOfficeCountry.titleLabel.text isEqualToString:@"- Select -"])
            {
                NSLog(@"cuntry");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Country for office address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
               // [txtOfficeAddr1 becomeFirstResponder];
                
                [alert show];
                return false;
            }
            
        }
        else{
            
            
            if([txtOfficeAddr1.text isEqualToString:@""]&&[txtOfficePostcode.text isEqualToString:@""])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Office Address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                //[txtOfficeAddr1 becomeFirstResponder];
                
                [alert show];
                return false;
                
            }else if ([txtOfficePostcode.text isEqualToString:@""])
            {
                if ([txtOfficeAddr1.text isEqualToString:@""]) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Office Address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                   // [txtOfficeAddr1 becomeFirstResponder];
                    
                    [alert show];
                    return false;
                }else{
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Office postcode is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    //[txtOfficePostcode becomeFirstResponder];
                    
                    [alert show];
                    return false;
                }
                
            }
            
            
            if(txtOfficeAddr1.text.length > 30){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Invalid Office Address length. Only 30 characters allowed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
               // [txtOfficeAddr1 becomeFirstResponder];
                [alert show];
                return false;
            }
            
            if(txtOfficeAddr2.text.length > 30){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Invalid Office Address length. Only 30 characters allowed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
               // [txtOfficeAddr2 becomeFirstResponder];
                [alert show];
                return false;
            }
            
            if(txtOfficeAddr3.text.length > 30){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Invalid Office Address length. Only 30 characters allowed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
               // [txtOfficeAddr3 becomeFirstResponder];
                [alert show];
                return false;
            }
            

        }
        

        
        
        
                
        


        
    }
    else{
        NSString *occupation = [outletOccup.titleLabel.text stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
        
        
        //Check if baby
        if([occupation isEqualToString:@"BABY"] && [OtherIDType.titleLabel.text isEqualToString:@"Birth Certificate"]) {
            NSLog(@"BABY1....");
            
            
           
            
            segGender.enabled = YES;
            if(txtOtherIDType.text.length==0 && txtIDType.text.length == 0)
            {
               /* txtDOB.enabled = YES;
                
                txtDOB.hidden = YES;
                txtDOB.text = @"";
                outletDOB.hidden = NO;
                outletDOB.enabled = YES;
                [outletDOB setTitle:@"- Select -" forState:UIControlStateNormal];
                */
                rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New IC No or Other ID is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag = 1002;
                [rrr show];
                segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                return false;

                
              
            }
            else if (txtOtherIDType.text.length==0){
                rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Other ID is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag = 1002;
                [rrr show];
                segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                return false;
             
                
            }
        }
        
        
            
        if(([OtherIDType.titleLabel.text isEqualToString:@"- Select -"]
           || [OtherIDType.titleLabel.text isEqualToString:@"Birth Certificate"]
           //|| [OtherIDType.titleLabel.text isEqualToString:@"Passport"]
           || [OtherIDType.titleLabel.text isEqualToString:@"Old Identification Number"]) && ![occupation isEqualToString:@"BABY"] ){
          
             NSLog(@"BABY3....");
            ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
            txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];

            
            if ([txtIDType.text isEqualToString:@""] || (txtIDType.text.length == 0) ) {
             
                    rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New IC No is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    rrr.tag = 1002;
                    [rrr show];
                    txtIDType.text = @"";
                    txtDOB.text = @"";
                    segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                    return false;
              
            }
            
            
            
            
            if (txtIDType.text.length != 12) {
                rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid New IC No length. IC No length should be 12 characters long" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                rrr.tag = 1002;
                [rrr show];
                txtIDType.text = @"";
                txtDOB.text = @"";
                segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
                
                return false;
            }
            
            if (![[txtIDType.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
                
                BOOL valid;
                NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:txtIDType.text];
                valid = [alphaNums isSupersetOfSet:inStringSet];
                if (!valid) {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"New IC No must be numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                    [txtIDType becomeFirstResponder];
                    return false;
                }
                
                if (txtIDType.text.length != 12) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Invalid New IC No length. IC No length should be 12 characters long" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [txtIDType becomeFirstResponder];
                    return false;
                }
            }

        }
     /*   else if (txtOtherIDType.text.length == 0 )
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Other ID is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [txtIDType becomeFirstResponder];
            return false;
        }
       */ 
        
        
        if ((txtOtherIDType.text.length == 0 ) && ![OtherIDType.titleLabel.text isEqualToString:@"- Select -"] && ![OtherIDType.titleLabel.text isEqualToString:@"Expected Delivery Date"]  )
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Other ID is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [txtIDType becomeFirstResponder];
            return false;
        }

        
        
        
        
        if(segGender.selectedSegmentIndex == -1){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Gender is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [self resignFirstResponder];
            [self.view endEditing:TRUE];
            
            [alert show];
            return false;
        }
        
        if(segSmoker.selectedSegmentIndex == -1 && ![OtherIDType.titleLabel.text isEqualToString:@"- Select -"] && ![OtherIDType.titleLabel.text isEqualToString:@"Company Registration Number"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Smoking status is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [self resignFirstResponder];
            [self.view endEditing:TRUE];
            
            [alert show];
            return false;
        }
        
        if(([[txtDOB.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) && ([outletDOB.titleLabel.text isEqualToString:@"- Select -"]) && (!outletDOB.titleLabel.text.length == 0)){
            NSLog(@"KY DOB");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Date of Birth is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [self resignFirstResponder];
            [self.view endEditing:TRUE];
            
            [alert show];
            return false;
        }
        
        
        //START CHECK SMOKING
        if(segSmoker.selectedSegmentIndex == -1)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Smoking status is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [self resignFirstResponder];
            [self.view endEditing:TRUE];
            
            [alert show];
            return false;
        }
        
        
        if(OccupCodeSelected == NULL && !companyCase){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Occupation is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [self resignFirstResponder];
            [self.view endEditing:TRUE];
            
            [alert show];
            return false;
        }
        
        NSString *baby = [outletOccup.titleLabel.text stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceCharacterSet]];
        
        outletOccup.titleLabel.text = [outletOccup.titleLabel.text stringByTrimmingCharactersInSet:
         [NSCharacterSet whitespaceCharacterSet]];
        
        if([outletOccup.titleLabel.text isEqualToString:@"HOUSEWIFE"]
           ||[outletOccup.titleLabel.text isEqualToString:@"JUVENILE"]
           ||[outletOccup.titleLabel.text isEqualToString:@"STUDENT"]
           ||[outletOccup.titleLabel.text isEqualToString:@"RETIRED"]
           ||[outletOccup.titleLabel.text isEqualToString:@"UNEMPLOYED"]
           ||[baby isEqualToString:@"BABY"]
           ||[outletOccup.titleLabel.text isEqualToString:@"TEMPORARILY UNEMPLOYED"]
           ||([OtherIDType.titleLabel.text isEqualToString:@"Company Registration Number"] && txtOtherIDType.text.length != 0)){
            NSLog(@"here if");
        }
        else{
            
            NSLog(@"here else - OCCUP-|%@|", baby);
            NSLog(@"untrim occup - %@",outletOccup.titleLabel.text);
            
            
            if (txtExactDuties.text.length < 1)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Exact duties is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [txtExactDuties becomeFirstResponder];
                [alert show];
                return false;
            }
            else if (txtExactDuties.text.length > 40) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Invalid Exact Duties length. Only 40 characters allowed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [txtExactDuties becomeFirstResponder];
                [alert show];
                return false;
            }
            
            
            if ([txtBussinessType.text isEqualToString:@""] && [OtherIDType.titleLabel.text isEqualToString:@"Company Registration Number"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Type of business is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [txtBussinessType becomeFirstResponder];
                [alert show];
                return false;
            }
            
            
            if (txtBussinessType.text.length > 60 && ![OtherIDType.titleLabel.text isEqualToString:@"Company Registration Number"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Invalid Type of Business length. Only 60 characters allowed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [txtBussinessType becomeFirstResponder];
                [alert show];
                return false;
            }
            
            
            
            if ([txtAnnIncome.text isEqualToString:@""]) {
                
                NSString *baby = [outletOccup.titleLabel.text stringByTrimmingCharactersInSet:
                                  [NSCharacterSet whitespaceCharacterSet]];
                
                if((![outletOccup.titleLabel.text isEqualToString:@"HOUSEWIFE"]) && (![outletOccup.titleLabel.text isEqualToString:@"JUVENILE"]) && (![outletOccup.titleLabel.text isEqualToString:@"STUDENT"])
                    && (![outletOccup.titleLabel.text isEqualToString:@"UNEMPLOYED"])
                    && (![outletOccup.titleLabel.text isEqualToString:@"TEMPORARILY UNEMPLOYED"])
                    && (![outletOccup.titleLabel.text isEqualToString:@"RETIRED"])
                    && (![baby isEqualToString:@"BABY"])) {
                    
                    
                    [txtAnnIncome becomeFirstResponder];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Annual Income is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                    
                    return false;
                }
                
                
              
                
            }
            
            
            if (![[txtAnnIncome.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
                
                
                
                NSString *numOnly = [txtAnnIncome.text stringByReplacingOccurrencesOfString:@"." withString:@""];
                
                BOOL valid;
                NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
                //NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:txtAnnIncome.text];
                NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:numOnly];
                valid = [alphaNums isSupersetOfSet:inStringSet];
                if (!valid) {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Annual Income must be numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                    [txtAnnIncome becomeFirstResponder];
                    return false;
                }
                
                NSArray  *comp = [txtAnnIncome.text componentsSeparatedByString:@"."];
                if([comp count]==2){
                    
                    if([[comp objectAtIndex:1] length]==2)
                    {
                    }
                    else{
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Annual Income must be in 2 decimal places. Please re-enter." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                        
                        [txtAnnIncome becomeFirstResponder];
                        return false;
                    }
                }else if([comp count]>2){
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Annual Income must be numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                    [txtAnnIncome becomeFirstResponder];
                    return false;
                    
                }
                
                
                
                if([txtAnnIncome.text isEqualToString:@"0"]){
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Annual Income must be greater than zero" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                    [txtAnnIncome becomeFirstResponder];
                    return false;
                    
                    
                }
                
                if([txtAnnIncome.text isEqualToString:@"-"])
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Annual Income must be numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                    [txtAnnIncome becomeFirstResponder];
                    return false;
                    
                    
                }
                if (txtAnnIncome.text.length > 13) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Invalid Annual Income length. Annual Income length should be not more than 13 characters long" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [txtAnnIncome becomeFirstResponder];
                    return false;
                }
            }
            
            
            
        }
        
        
        
        
        if ([outletOccup.titleLabel.text isEqualToString:@"HOUSEWIFE"]||[outletOccup.titleLabel.text isEqualToString:@"JUVENILE"]||[outletOccup.titleLabel.text isEqualToString:@"RETIRED"]||[outletOccup.titleLabel.text isEqualToString:@"UNEMPLOYED"]||[outletOccup.titleLabel.text isEqualToString:@"TEMPORARILY UNEMPLOYED"]||[outletOccup.titleLabel.text isEqualToString:@"STUDENT"]||[OtherIDType.titleLabel.text isEqualToString:@"Company Registration Number"]) {
            NSLog(@"if yes outlet occup:%@",outletOccup.titleLabel.text);
        }
        else{
            NSLog(@"if else outlet occup:%@",outletOccup.titleLabel.text);
        }
        
        
        //END CHECK THE EXACT DUTIES
        
        

        if([outletMaritalStatus.titleLabel.text isEqualToString:@"- Select -"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Marital status is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [outletMaritalStatus becomeFirstResponder];
            [alert show];
            return false;
        }
        
        
        if([outletRace.titleLabel.text isEqualToString:@"- Select -"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Race is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [outletRace becomeFirstResponder];
            [alert show];
            return false;
        }
        
        if([outletReligion.titleLabel.text isEqualToString:@"- Select -"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Religion is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [outletRace becomeFirstResponder];
            [alert show];
            return false;
        }
        if([outletNationality.titleLabel.text isEqualToString:@"- Select -"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Nationality is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [outletNationality becomeFirstResponder];
            [alert show];
            return false;
        }

        if(checked){
            if([btnHomeCountry.titleLabel.text isEqualToString:@"- Select -"])
            {
                NSLog(@"cuntry");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Country for Home address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                
                [alert show];
                return false;
            }

            
           else  if([txtHomeAddr1.text isEqualToString:@""])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Home Address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [txtHomeAddr1 becomeFirstResponder];
                
                [alert show];
                return false;
                
            }
                        
        }
        else{
            
            
            if([txtHomeAddr1.text isEqualToString:@""]&&[txtHomePostCode.text isEqualToString:@""])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Home Address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [txtHomeAddr1 becomeFirstResponder];
                
                [alert show];
                return false;
                
            }else if ([txtHomePostCode.text isEqualToString:@""])
            {
                if ([txtHomePostCode.text isEqualToString:@""]) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Postcode for home address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [txtHomeAddr1 becomeFirstResponder];
                    
                    [alert show];
                    return false;
                }else{
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Home address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [txtHomePostCode becomeFirstResponder];
                    
                    [alert show];
                    return false;
                }
                
            }
            
            
            
            
            if(txtHomeAddr1.text.length > 30){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Invalid Home Address length. Only 30 characters allowed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [txtHomeAddr1 becomeFirstResponder];
                [alert show];
                return false;
            }
            
            if(txtHomeAddr2.text.length > 30){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Invalid Home Address length. Only 30 characters allowed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [txtHomeAddr2 becomeFirstResponder];
                [alert show];
                return false;
            }
            
            if(txtHomeAddr3.text.length > 30){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Invalid Home Address length. Only 30 characters allowed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [txtHomeAddr3 becomeFirstResponder];
                [alert show];
                return false;
            }
            
        }

        
        // Office address
        // Added by Benjamin Law on 17/10/2013 for bug 2561
        
        if(!([outletOccup.titleLabel.text isEqualToString:@"HOUSEWIFE"]
           ||[outletOccup.titleLabel.text isEqualToString:@"JUVENILE"]
           ||[outletOccup.titleLabel.text isEqualToString:@"STUDENT"]
           ||[outletOccup.titleLabel.text isEqualToString:@"RETIRED"]
           ||[outletOccup.titleLabel.text isEqualToString:@"UNEMPLOYED"]
           ||[outletOccup.titleLabel.text isEqualToString:@"TEMPORARILY UNEMPLOYED"]
           ||[baby isEqualToString:@"BABY"])) {
            
            if(checked2){
                
                if([txtOfficeAddr1.text isEqualToString:@""])
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Office Address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    //[txtOfficeAddr1 becomeFirstResponder];
                    
                    [alert show];
                    return false;
                    
                }
                if([btnOfficeCountry.titleLabel.text isEqualToString:@"- Select -"])
                {
                    NSLog(@"cuntry");
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Country for office address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    // [txtOfficeAddr1 becomeFirstResponder];
                    
                    [alert show];
                    return false;
                }
                
            }
            else{
                
                
                if([txtOfficeAddr1.text isEqualToString:@""]&&[txtOfficePostcode.text isEqualToString:@""])
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Office Address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    //[txtOfficeAddr1 becomeFirstResponder];
                    
                    [alert show];
                    return false;
                    
                }else if ([txtOfficePostcode.text isEqualToString:@""])
                {
                    if ([txtOfficeAddr1.text isEqualToString:@""]) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Office Address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        // [txtOfficeAddr1 becomeFirstResponder];
                        
                        [alert show];
                        return false;
                    }else{
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Office postcode is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        //[txtOfficePostcode becomeFirstResponder];
                        
                        [alert show];
                        return false;
                    }
                    
                }
                
                
                if(txtOfficeAddr1.text.length > 30){
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Invalid Office Address length. Only 30 characters allowed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    // [txtOfficeAddr1 becomeFirstResponder];
                    [alert show];
                    return false;
                }
                
                if(txtOfficeAddr2.text.length > 30){
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Invalid Office Address length. Only 30 characters allowed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    // [txtOfficeAddr2 becomeFirstResponder];
                    [alert show];
                    return false;
                }
                
                if(txtOfficeAddr3.text.length > 30){
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:@"Invalid Office Address length. Only 30 characters allowed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    // [txtOfficeAddr3 becomeFirstResponder];
                    [alert show];
                    return false;
                }
                
                
            }
            
        }


    }
    
  
    NSString *baby = [outletOccup.titleLabel.text stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]];
    
    //######office address#######
    if(checked2){
        
        if([txtOfficeAddr1.text isEqualToString:@""])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Office Address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //[txtOfficeAddr1 becomeFirstResponder];
            
            [alert show];
            return false;
            
        }
        if([btnOfficeCountry.titleLabel.text isEqualToString:@"- Select -"])
        {
            NSLog(@"cuntry");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Country for office address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            // [txtOfficeAddr1 becomeFirstResponder];
            
            [alert show];
            return false;
        }
        
    }
    
   
    else  if((![outletOccup.titleLabel.text isEqualToString:@"HOUSEWIFE"])
             && (![outletOccup.titleLabel.text isEqualToString:@"JUVENILE"])
             && (![outletOccup.titleLabel.text isEqualToString:@"STUDENT"])
             && (![outletOccup.titleLabel.text isEqualToString:@"UNEMPLOYED"])
             && (![outletOccup.titleLabel.text isEqualToString:@"TEMPORARILY UNEMPLOYED"])
             && (![outletOccup.titleLabel.text isEqualToString:@"RETIRED"])
             && (![baby isEqualToString:@"BABY"])) {
        
        
        if([txtOfficeAddr1.text isEqualToString:@""]&&[txtOfficePostcode.text isEqualToString:@""])
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Office Address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //[txtOfficeAddr1 becomeFirstResponder];
            
            [alert show];
            return false;
            
        }else if ([txtOfficePostcode.text isEqualToString:@""])
        {
            if ([txtOfficeAddr1.text isEqualToString:@""]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Office Address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                // [txtOfficeAddr1 becomeFirstResponder];
                
                [alert show];
                return false;
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Office postcode is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                //[txtOfficePostcode becomeFirstResponder];
                
                [alert show];
                return false;
            }
            
        }
        
        
        if(txtOfficeAddr1.text.length > 30){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Invalid Office Address length. Only 30 characters allowed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            // [txtOfficeAddr1 becomeFirstResponder];
            [alert show];
            return false;
        }
        
        if(txtOfficeAddr2.text.length > 30){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Invalid Office Address length. Only 30 characters allowed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            // [txtOfficeAddr2 becomeFirstResponder];
            [alert show];
            return false;
        }
        
        if(txtOfficeAddr3.text.length > 30){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Invalid Office Address length. Only 30 characters allowed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            // [txtOfficeAddr3 becomeFirstResponder];
            [alert show];
            return false;
        }
        
        
    }
    

    
    //######office address#######
    
    
    if([txtPrefix1.text isEqualToString:@""]&&[txtContact1.text isEqualToString:@""]&&[txtPrefix2.text isEqualToString:@""]&&[txtContact2.text isEqualToString:@""]&&[txtPrefix3.text isEqualToString:@""]&&[txtContact3.text isEqualToString:@""]&&[txtPrefix4.text isEqualToString:@""]&&[txtContact4.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Please enter at least one of the Contact Number (Home, Office, Mobile, Fax)" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        
        [alert show];
        return false;
        
    }
    else{
   
    //##Contact######
    
    //Home number
    
    if (![txtPrefix1.text isEqualToString:@""])
    {
        
        if(txtPrefix1.text.length > 4) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Prefix length cannot be more than 4 characters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [txtPrefix1 becomeFirstResponder];
            
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
                                                            message:@"Home contact number must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtContact1 becomeFirstResponder];
            [alert show];
            return false;
        }
        
        if (!valid2) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Prefix for home contact must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtPrefix1 becomeFirstResponder];
            
            [alert show];
            return false;
        }
        
        
        
        if([txtContact1.text isEqualToString:@" "]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Number for home contact is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtContact1 becomeFirstResponder];
            [alert show];
            return false;
            
            
        }
        else if (txtContact1.text.length > 10) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Home contact number length must be 10 characters or less" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtContact1 becomeFirstResponder];
            [alert show];
            return false;
        }
        else if (txtContact1.text.length < 6) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Home contact number length must be 6 characters or more" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtContact1 becomeFirstResponder];
            [alert show];
            return false;
        }
        
        
        
        
        
        
    }
          
    //#####mobile number#####
    if (![txtPrefix2.text isEqualToString:@""])
    {
        
        if(txtPrefix2.text.length > 4) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Prefix length cannot be more than 4 characters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [txtPrefix2 becomeFirstResponder];
            
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
                                                            message:@"Mobile contact number must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtContact2 becomeFirstResponder];
            [alert show];
            return false;
        }
        
        if (!valid2) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Prefix for mobile contact must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtPrefix2 becomeFirstResponder];
            
            [alert show];
            return false;
        }
        
        
        
        if([txtContact2.text isEqualToString:@" "]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Number for mobile contact is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtContact2 becomeFirstResponder];
            [alert show];
            return false;
            
            
        }
        else if (txtContact2.text.length > 10) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Mobile contact number length must be 10 characters or less" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtContact2 becomeFirstResponder];
            [alert show];
            return false;
        }
        else if (txtContact2.text.length < 6) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Mobile contact number length must be 6 characters or more" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtContact2 becomeFirstResponder];
            [alert show];
            return false;
        }
        
        
        
        
        
        
    }
    else{
        if(![txtContact2.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"prefix for mobile contact is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [txtPrefix2 becomeFirstResponder];
        [alert show];
        return false;
        }
    }

    
    
    
    //####office number
    
    if (![txtPrefix3.text isEqualToString:@""])
    {
        
        if(txtPrefix3.text.length > 4) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Prefix length cannot be more than 4 characters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [txtPrefix3 becomeFirstResponder];
            
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
                                                            message:@"Office contact number must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtContact3 becomeFirstResponder];
            [alert show];
            return false;
        }
        
        if (!valid2) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Prefix for office contact must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtPrefix3 becomeFirstResponder];
            
            [alert show];
            return false;
        }
        
        
        
        if([txtContact3.text isEqualToString:@" "]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Number for office contact is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtContact3 becomeFirstResponder];
            [alert show];
            return false;
            
            
        }
        else if (txtContact3.text.length > 10) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Office contact number length must be 10 characters or less" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtContact3 becomeFirstResponder];
            [alert show];
            return false;
        }
        else if (txtContact3.text.length < 6) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Office contact number length must be 6 characters or more" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtContact3 becomeFirstResponder];
            [alert show];
            return false;
        }
        
        
        
        
        
        
    }
    else{
        if(![txtContact3.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"prefix for Office contact is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [txtPrefix3 becomeFirstResponder];
        [alert show];
        return false;
    }
    }
    
    
    //####office fax number
    
    if (![txtPrefix4.text isEqualToString:@""])
    {
        
        if(txtPrefix4.text.length > 4) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Prefix length cannot be more than 4 characters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [txtPrefix4 becomeFirstResponder];
            
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
                                                            message:@"Office fax number must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtContact4 becomeFirstResponder];
            [alert show];
            return false;
        }
        
        if (!valid2) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Prefix for office fax number must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtPrefix4 becomeFirstResponder];
            
            [alert show];
            return false;
        }
        
        
        
        if([txtContact4.text isEqualToString:@" "]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Number for office fax is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtContact4 becomeFirstResponder];
            [alert show];
            return false;
            
            
        }
        else if (txtContact4.text.length > 10) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Office fax number length must be 10 characters or less" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtContact4 becomeFirstResponder];
            [alert show];
            return false;
        }
        else if (txtContact4.text.length < 6) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Office fax number length must be 6 characters or more" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtContact4 becomeFirstResponder];
            [alert show];
            return false;
        }
        
        
        
        
        
        
    }
   /* else{
        if(![txtContact4.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"prefix for Office fax number is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [txtPrefix4 becomeFirstResponder];
        [alert show];
        return false;
    }
        
    
    }
*/
    
    
    }
    
    
    
    if(![txtEmail.text isEqualToString:@""]){
        if( [self NSStringIsValidEmail:txtEmail.text] == FALSE){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"You have entered an invalid email." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtEmail becomeFirstResponder];
            
            [alert show];
            return FALSE;
        }
        
        if (txtEmail.text.length > 40) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Invalid Email length. Only 40 characters allowed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [txtEmail becomeFirstResponder];
            [alert show];
            return false;
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


#pragma mark - db handling

-(void) GetLastID
{
    sqlite3_stmt *statement2;
    sqlite3_stmt *statement3;
    NSString *lastID;
    NSString *contactCode;
    
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
            
            NSLog(@"%@",insertContactSQL);
            
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
    
    UIAlertView *SuccessAlert = [[UIAlertView alloc] initWithTitle:@"Client Profile"
                                                           message:@"A new client record successfully inserted." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    SuccessAlert.tag = 1;
    [SuccessAlert show];
    
    statement2 = Nil;
    statement3 = Nil;
    lastID = Nil;
    contactCode = Nil;
    dbpath = Nil;
    
}

-(BOOL)OptionalOccp
{
    sqlite3_stmt *statement;
    BOOL valid = FALSE;
    
    if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT \"OccpCatCode\" from Adm_OccpCat_Occp WHERE OccpCode = \"%@\" ", OccupCodeSelected];
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
     if ([OccupCodeSelected isEqualToString:@"OCC02317"] || [OccupCodeSelected isEqualToString:@"OCC02229"]
     || [OccupCodeSelected isEqualToString:@"OCC01109"] || [OccupCodeSelected isEqualToString:@"OCC01179"]
     || [OccupCodeSelected isEqualToString:@"OCC01865"] || [OccupCodeSelected isEqualToString:@"OCC02229"]
     || [OccupCodeSelected isEqualToString:@"OCC00570"] || [OccupCodeSelected isEqualToString:@"OCC01596"]
     || [OccupCodeSelected isEqualToString:@"OCC02147"] || [OccupCodeSelected isEqualToString:@"OCC02148"]
     || [OccupCodeSelected isEqualToString:@"OCC02149"] || [OccupCodeSelected isEqualToString:@"OCC02321"]) {
     return TRUE;
     }
     else {
     return FALSE;
     }
     */
    return valid;
    
}


#pragma mark - delegate

-(void)selectedGroup:(NSString *)aaGroup
{
    outletGroup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [outletGroup setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",aaGroup]forState:UIControlStateNormal];
    [self.GroupPopover dismissPopoverAnimated:YES];
}

-(void)selectedTitle:(NSString *)selectedTitle
{
    
    outletTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [outletTitle setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",selectedTitle]forState:UIControlStateNormal];
    
    [self.TitlePickerPopover dismissPopoverAnimated:YES];
    
    NSLog(@"%@",outletTitle.titleLabel.text);
}

-(void)selectedNationality:(NSString *)selectedNationality
{
    outletNationality.titleLabel.text = selectedNationality;
    outletNationality.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [outletNationality setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",selectedNationality]forState:UIControlStateNormal];
    [self.nationalityPopover dismissPopoverAnimated:YES];
}

-(void)selectedReligion:(NSString *)setReligion
{
    outletReligion.titleLabel.text = setReligion;
    outletReligion.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [outletReligion setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",setReligion]forState:UIControlStateNormal];
    [self.ReligionListPopover dismissPopoverAnimated:YES];
}

-(void)CloseWindow
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [_SIDatePopover dismissPopoverAnimated:YES];
}

-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
    outletDOB.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [outletDOB setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",strDate]forState:UIControlStateNormal];
    txtDOB.text = strDate;
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *d = [NSDate date];
    NSDate* d2 = [df dateFromString:dbDate];
    
    if ([d compare:d2] == NSOrderedAscending) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Entered date cannot be greater than today." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
        [outletDOB setTitle:@"" forState:UIControlStateNormal ];
        alert = Nil;
    }
    
    df = Nil, d = Nil, d2 = Nil;
}

-(void)selectedIDType:(NSString *)selectedIDType
{
    ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
    
    
    OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [OtherIDType setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",selectedIDType]forState:UIControlStateNormal];
    
    
    OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    OtherIDType.titleLabel.text = selectedIDType;
    
    NSString *occupation = [outletOccup.titleLabel.text stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]];
   
    
    
    if ([selectedIDType isEqualToString:@"- Select -"]){
        
       // NSLog(@"YEYEY KKY selectedIDType - |%@|", selectedIDType);
        
         
        companyCase = NO;
        segGender.enabled = NO;
        segSmoker.enabled = YES;
        segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        txtIDType.backgroundColor = [UIColor whiteColor];
        txtIDType.enabled = YES;
        outletDOB.enabled = NO;
        outletDOB.hidden = TRUE;
        outletDOB.titleLabel.text =@"";
        
       
        
        txtDOB.enabled = FALSE;
        txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtDOB.hidden = NO;
        
        
        OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        txtOtherIDType.enabled = NO;
        txtOtherIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtOtherIDType.text =@"";
        
        outletTitle.enabled = YES;
        outletTitle.titleLabel.textColor = [UIColor blackColor];
        
        outletOccup.enabled = YES;
        //outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        // outletOccup.titleLabel.text = @"- Select -";
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
   else  if ([selectedIDType isEqualToString:@"Expected Delivery Date"]){
         //Enable DOB
         //Disable - New IC field and Other ID field
        companyCase = NO;
        segGender.enabled = TRUE;
        segSmoker.enabled = TRUE;
        segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        txtIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtIDType.text = @"";
        txtIDType.enabled = NO;
       
   
       txtDOB.hidden = YES;
       txtDOB.text = @"";
       outletDOB.hidden = NO;
       outletDOB.enabled = YES;
       [outletDOB setTitle:@"- Select -" forState:UIControlStateNormal];
       txtDOB.backgroundColor = [UIColor whiteColor];
       
       
       
        OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        txtOtherIDType.enabled = NO;
        txtOtherIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtOtherIDType.text =@"";
       
       
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

    
    else if([selectedIDType isEqualToString:@"Birth Certificate"] && [occupation isEqualToString:@"BABY"])
    {
        
        NSLog(@"BABY2...");
       // outletDOB.hidden = NO;
      //  outletDOB.enabled = TRUE;
       //  segGender.enabled = TRUE;
        
        txtDOB.hidden = YES;
        txtDOB.text = @"";
        outletDOB.hidden = NO;
        outletDOB.enabled = YES;
        [outletDOB setTitle:@"- Select -" forState:UIControlStateNormal];
        
        
    }
    else if(([selectedIDType isEqualToString:@"Birth Certificate"]||[selectedIDType isEqualToString:@"Old Identification Number"]) && ![occupation isEqualToString:@"BABY"])
    {
        NSLog(@"BABY5....");
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
             
            [outletDOB setTitle:@"- Select -" forState:UIControlStateNormal];
        }
        else if (![txtIDType.text isEqualToString:@""]) {
            
             NSLog(@"ID TYPE");
            segGender.enabled = FALSE;
            txtDOB.enabled = FALSE;
            txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
            outletDOB.enabled = FALSE;
        }
        
        
      
        [outletDOB setTitle:@"" forState:UIControlStateNormal];
        
        
        outletDOB.enabled = NO;
        
        outletTitle.enabled = YES;
        outletTitle.titleLabel.textColor = [UIColor blackColor];
        
        OtherIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        txtOtherIDType.enabled = YES;
        txtOtherIDType.backgroundColor = [UIColor whiteColor];
        
        outletOccup.enabled = YES;
        //outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        // outletOccup.titleLabel.text = @"- Select -";
        outletOccup.titleLabel.textColor = [UIColor blackColor];

        
        outletRace.titleLabel.textColor = [UIColor blackColor];
        outletRace.enabled = YES;
        
        outletReligion.enabled = YES;
        outletReligion.titleLabel.textColor = [UIColor blackColor];
        
        outletNationality.enabled = YES;
        outletNationality.titleLabel.textColor = [UIColor blackColor];
        
        outletMaritalStatus.enabled = YES;
        outletMaritalStatus.titleLabel.textColor = [UIColor blackColor];
        
        
        txtDOB.enabled = FALSE;
        txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtDOB.hidden = NO;

        
    }
    
    else if([selectedIDType isEqualToString:@"Company Registration Number"])
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
       // outletOccup.titleLabel.text = @"- Select -";
        outletOccup.titleLabel.textColor = [UIColor grayColor];
        
        //segGender.enabled = NO;
        segSmoker.enabled = NO;
        
        outletRace.enabled = NO;
        outletRace.titleLabel.textColor = [UIColor grayColor];
       // outletRace.titleLabel.text = @"- Select -";
        //[outletRace setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"- Select -"]forState:UIControlStateNormal];
       // outletRace.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        
        outletReligion.enabled = NO;
        outletReligion.titleLabel.textColor = [UIColor grayColor];
       // outletReligion.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        //outletReligion.titleLabel.text =@"- Select -";
        
        outletMaritalStatus.enabled = NO;
        outletMaritalStatus.titleLabel.textColor = [UIColor grayColor];
        //outletMaritalStatus.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
       // outletMaritalStatus.titleLabel.text =@"- Select -";
        
        outletNationality.enabled = NO;
        outletNationality.titleLabel.textColor = [UIColor grayColor];
        //outletNationality.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
      //  outletNationality.titleLabel.text =@"- Select -";
        
        //segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
        segSmoker.selectedSegmentIndex = UISegmentedControlNoSegment;
               companyCase = YES;
        txtDOB.hidden = NO;
        txtDOB.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        outletDOB.hidden = YES;
        txtDOB.text = @"";
        
        
    }
    
    else if([selectedIDType isEqualToString:@"Passport"])
    {
        companyCase = NO;
        
        // check if ic field is empty
        if ([txtIDType.text isEqualToString:@""]) {
            
            
            txtIDType.backgroundColor = [UIColor whiteColor];
            txtIDType.enabled = YES;
            segGender.enabled = YES;
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
            outletDOB.enabled = TRUE;
            
            [outletDOB setTitle:@"- Select -" forState:UIControlStateNormal];
        }
        else if (![txtIDType.text isEqualToString:@""]) {
            
            NSLog(@"ID TYPE");
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
        // outletOccup.titleLabel.text = @"- Select -";
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
        
        NSLog(@"else  kky ....");
          
        txtIDType.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtIDType.enabled = NO;
        txtIDType.text = @"";
        
        txtOtherIDType.backgroundColor = [UIColor whiteColor];
        txtOtherIDType.enabled = YES;
        
        outletOccup.enabled = YES;
        //outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        // outletOccup.titleLabel.text = @"- Select -";
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
        [outletDOB setTitle:@"- Select -" forState:UIControlStateNormal];
        
        
       
       
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
    
}

- (void)OccupCodeSelected:(NSString *)OccupCode{
    
    OccupCodeSelected = OccupCode;
    
}

- (void)OccupDescSelected:(NSString *)color
{
    ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
    //
    outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [outletOccup setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", color]forState:UIControlStateNormal];
    
    
    outletOccup.titleLabel.text = color;
    
    [self.OccupationListPopover dismissPopoverAnimated:YES];
    
    
    
    [self.view endEditing:YES];
    [self resignFirstResponder];
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    NSString *baby = [outletOccup.titleLabel.text stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]];
    
    if([outletOccup.titleLabel.text isEqualToString:@"HOUSEWIFE"]||[outletOccup.titleLabel.text isEqualToString:@"JUVENILE"]||[outletOccup.titleLabel.text isEqualToString:@"STUDENT"]
        ||[outletOccup.titleLabel.text isEqualToString:@"UNEMPLOYED"]
        ||[outletOccup.titleLabel.text isEqualToString:@"TEMPORARILY UNEMPLOYED"]
        ||[outletOccup.titleLabel.text isEqualToString:@"RETIRED"])
    {
        txtAnnIncome.enabled = NO;
        txtAnnIncome.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtAnnIncome.text = @"";
    }
    else if([baby isEqualToString:@"BABY"] && [OtherIDType.titleLabel.text isEqualToString:@"Birth Certificate"]
            && txtIDType.text.length == 0)
    {
        NSLog(@"BABY101 - IC- %@", txtIDType.text);
        
        txtAnnIncome.enabled = NO;
        txtAnnIncome.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
        txtAnnIncome.text = @"";
        
        //txtDOB.enabled = TRUE;
        //txtDOB.backgroundColor = [UIColor whiteColor];
        
        txtDOB.enabled = YES;
        
        txtDOB.hidden = YES;
        txtDOB.text = @"";
        outletDOB.hidden = NO;
        outletDOB.enabled = YES;
        [outletDOB setTitle:@"- Select -" forState:UIControlStateNormal]; //ENABLE DOB OUTLETS
        
        outletDOB.enabled = TRUE;
        segGender.enabled = TRUE;
    }
    else
    {
        txtAnnIncome.enabled = YES;
        txtAnnIncome.backgroundColor = [UIColor whiteColor];
    }
    
        //   check here
    
}

-(void)OccupClassSelected:(NSString *)OccupClass
{
    txtClass.text = OccupClass;
}

-(void)selectedRace:(NSString *)theRace
{
    
    outletRace.titleLabel.text = theRace;
    outletRace.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [outletRace setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",theRace]forState:UIControlStateNormal];
    [self.raceListPopover dismissPopoverAnimated:YES];
    
    
}
-(void)selectedMaritalStatus:(NSString *)status
{
    
    outletMaritalStatus.titleLabel.text = status;
    outletMaritalStatus.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [outletMaritalStatus setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",status]forState:UIControlStateNormal];
    [self.MaritalStatusPopover dismissPopoverAnimated:YES];
    
    
}



-(void)SelectedCountry:(NSString *)theCountry
{
    if (isOffCountry) {
        
        btnOfficeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btnOfficeCountry setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",theCountry] forState:UIControlStateNormal];
        
        [self.CountryListPopover dismissPopoverAnimated:YES];
    }
    else if (isHomeCountry) {
        btnHomeCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btnHomeCountry setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",theCountry] forState:UIControlStateNormal];
        
        [self.CountryListPopover dismissPopoverAnimated:YES];
    }
    
    isOffCountry = NO;
    isHomeCountry = NO;
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end
