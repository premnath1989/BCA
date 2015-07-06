//
//  ProspectViewController_OLD.m
//  iMobile Planner
//
//  Created by infoconnect on 11/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ProspectViewController_OLD.h"
#import "ProspectListing.h"
#import <QuartzCore/QuartzCore.h>
#import "ColorHexCode.h"


@interface ProspectViewController_OLD ()

@end

@implementation ProspectViewController_OLD

@synthesize txtPrefix1;
@synthesize txtPrefix2;
@synthesize txtPrefix3;
@synthesize txtPrefix4;
@synthesize txtPrefix5;
@synthesize lblOfficeAddr;
@synthesize lblPostCode;
@synthesize outletDone;
@synthesize outletType1;

@synthesize txtRemark;
@synthesize txtEmail;
@synthesize txtContact1;
@synthesize txtContact2;
@synthesize txtContact3;
@synthesize txtContact4;
@synthesize txtContact5;
@synthesize outletType2;
@synthesize outletType3;
@synthesize outletType4;
@synthesize outletType5;

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
@synthesize txtOfficeState;
@synthesize txtOfficeCountry;
@synthesize txtExactDuties;
@synthesize outletOccup;
@synthesize myScrollView;
@synthesize txtPreferredName;
@synthesize txtFullName, ContactTypeTracker;
@synthesize segGender, ContactType, DOB, gender, SelectedStateCode, SelectedOfficeStateCode, OccupCodeSelected;
@synthesize OccupationList = _OccupationList;
@synthesize OccupationListPopover = _OccupationListPopover;
@synthesize btnCancel;
@synthesize ContactTypeClass = _ContactTypeClass;
@synthesize ContactTypePopover = _ContactTypePopover;
@synthesize SIDate = _SIDate;
@synthesize SIDatePopover = _SIDatePopover;
@synthesize delegate = _delegate;

bool PostcodeContinueOLD = TRUE;


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
    
    [txtHomePostCode addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    [txtOfficePostcode addTarget:self action:@selector(OfficePostcodeDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    [txtHomePostCode addTarget:self action:@selector(EditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [txtOfficePostcode addTarget:self action:@selector(OfficeEditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
    
    txtHomeTown.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtHomeState.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtHomeCountry.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtOfficeTown.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtOfficeState.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtOfficeCountry.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    //ContactType = [[NSArray alloc] init];
    //ContactType = [[NSArray alloc] initWithObjects:@"Mobile", @"Home", @"Fax", @"Office", nil];
    
    outletOccup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    CustomColor = Nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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


- (void)viewDidUnload
{
    [self setTxtPreferredName:nil];
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
    [self setTxtContact1:nil];
    [self setOutletType1:nil];
    [self setBtnCancel:nil];
    [self setTxtContact2:nil];
    [self setTxtContact3:nil];
    [self setTxtContact4:nil];
    [self setTxtContact5:nil];
    [self setOutletType2:nil];
    [self setOutletType3:nil];
    [self setOutletType4:nil];
    [self setOutletType5:nil];
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

- (IBAction)ActionGender:(id)sender {
    if ([segGender selectedSegmentIndex]==0) {
        gender = @"MALE";
    }
    else {
        gender = @"FEMALE";
    }
}

-(void)EditTextFieldBegin:(id)sender{
    outletDone.enabled = FALSE;
    
}

-(void)OfficeEditTextFieldBegin:(id)sender{
    
    if ([self OptionalOccp] == FALSE) {
        outletDone.enabled = FALSE;
    }
    
}

- (IBAction)btnDOB:(id)sender {
    /*
	 [self resignFirstResponder];
	 [self.view endEditing:YES];
	 outletDobPicker.hidden = NO;
	 pickerToolbar.hidden = NO;
	 [self.view endEditing:TRUE];
	 txtRemark.hidden = TRUE;
	 //ContactTypePicker.hidden = true;
	 outletContactType.hidden = true;
     */
    
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    [outletDOB setTitle:dateString forState:UIControlStateNormal];
    
    if (_SIDate == Nil) {
		
		self.SIDate = [self.storyboard instantiateViewControllerWithIdentifier:@"SIDate"];
		_SIDate.delegate = self;
		self.SIDatePopover = [[UIPopoverController alloc] initWithContentViewController:_SIDate];
	}
    
    [self.SIDatePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.SIDatePopover presentPopoverFromRect:[sender frame ]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    
    dateFormatter = Nil;
    dateString = Nil;
    
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
 
 if (outletDobPicker.hidden == FALSE) { //DOB picker
 pickerToolbar.hidden = YES;
 outletDobPicker.hidden = YES;
 txtRemark.hidden = FALSE;
 }
 else {
 pickerToolbar.hidden = true;
 
 outletContactType.hidden = true;
 txtRemark.hidden = FALSE;
 }
 
 }
 */

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}


- (IBAction)btnSave:(id)sender {
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
            txtPreferredName.text = [txtPreferredName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            txtFullName.text = [txtFullName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            NSString *insertSQL = [NSString stringWithFormat:
                                   @"INSERT INTO prospect_profile(\"PreferredName\",\"ProspectName\", \"ProspectDOB\", "
                                   "\"ProspectGender\", \"ResidenceAddress1\", \"ResidenceAddress2\", \"ResidenceAddress3\",\"ResidenceAddressTown\",\"ResidenceAddressState\",\"ResidenceAddressPostCode\", "
                                   "\"ResidenceAddressCountry\", \"OfficeAddress1\",\"OfficeAddress2\",\"OfficeAddress3\",\"OfficeAddressTown\",\"OfficeAddressState\",\"OfficeAddressPostCode\", "
                                   "\"OfficeAddressCountry\", \"ProspectEmail\",\"ProspectOccupationCode\", \"ExactDuties\",\"ProspectRemark\",\"DateCreated\","
                                   "\"CreatedBy\",\"DateModified\",\"ModifiedBy\") "
                                   "VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",%@,\"%@\",\"%@\",\"%@\")",
                                   txtPreferredName.text, txtFullName.text, outletDOB.titleLabel.text, gender, txtHomeAddr1.text, txtHomeAddr2.text, txtHomeAddr3.text,
                                   txtHomeTown.text, SelectedStateCode, txtHomePostCode.text, txtHomeCountry.text, txtOfficeAddr1.text, txtOfficeAddr2.text, txtOfficeAddr3.text, txtOfficeTown.text,
                                   SelectedOfficeStateCode, txtOfficePostcode.text, txtOfficeCountry.text, txtEmail.text, OccupCodeSelected, txtExactDuties.text, txtRemark.text,
                                   @"datetime(\"now\", \"+8 hour\")", @"1", @"", @"1"];
            
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
    
	PostcodeContinueOLD = TRUE;
	
}

- (bool) Validation{
    /*
     if (![txtNickName.text isEqualToString:@""]) {
     
     
     }
     else {
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
     message:@"Preferred Name cannot be empty" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
     [alert show];
     return false;
     }
     */
    
    if([[txtPreferredName.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Preferred Name is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        //[self.view endEditing:TRUE];
        
        [alert show];
        [txtPreferredName becomeFirstResponder];
        
        return false;
    }
    else {
        BOOL valid;
        NSString *strToBeTest = [txtPreferredName.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] ;
        
        for (int i=0; i<strToBeTest.length; i++) {
            int str1=(int)[strToBeTest characterAtIndex:i];
            
            if((str1 >96 && str1 <123)  || (str1 >64 && str1 <91) || str1 == 39 || str1 == 64 || str1 == 47 || str1 == 45 || str1 == 46 ){
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
            //[self.view endEditing:TRUE];
            
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
	
	
    if(outletType2.titleLabel.text != NULL) {
        if ([txtPrefix2.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Prefix for contact no 2 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [txtPrefix2 becomeFirstResponder];
            //[self.view endEditing:TRUE];
            
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
    
    
    if(outletType3.titleLabel.text != NULL) {
        if ([txtPrefix3.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Prefix for contact no 3 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [txtPrefix3 becomeFirstResponder];
            //[self.view endEditing:TRUE];
            
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
                    
                    if (txtContact3.text.length > 8) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                        message:@"Contact number length must be less than 8 characters long" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        [txtContact3 becomeFirstResponder];
                        
                        [alert show];
                        return false;
                    }
                    
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
    
    if(outletType4.titleLabel.text != NULL) {
        if ([txtPrefix4.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Prefix for contact no 4 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [txtPrefix4 becomeFirstResponder];
            //[self.view endEditing:TRUE];
            
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
	
    if(outletType5.titleLabel.text != NULL) {
        if ([txtPrefix5.text isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Prefix for contact no 5 is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [txtPrefix5 becomeFirstResponder];
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
	 //[self.view endEditing:TRUE];
	 
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
    
    if(![txtEmail.text isEqualToString:@""]){
        if( [self NSStringIsValidEmail:txtEmail.text] == FALSE){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"You have entered an invalid email." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [txtEmail becomeFirstResponder];
            
            [alert show];
            return FALSE;
        }
    }
    
    
    if([[txtHomeAddr1.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]){
        if(![[txtHomePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Home Address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [txtHomeAddr1 becomeFirstResponder];
            //[self.view endEditing:TRUE];
            
            [alert show];
            return false;
        }
        
        
    }
    
    
    if (PostcodeContinueOLD == TRUE) {
        if(![[txtHomeAddr1.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]){
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
        return FALSE;
    }
    
    
    if([[txtOfficeAddr1.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]){
        if(![[txtOfficePostcode.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]){
            if ([self OptionalOccp] == FALSE) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Office Address is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [txtOfficeAddr1 becomeFirstResponder];
                
                [alert show];
                return false;
            }
            else {
                
            }
        }
        
        
    }
    
    
    if (PostcodeContinueOLD == TRUE) {
        /*
		 if([txtOfficePostcode.text isEqualToString:@""]){
		 if ([self OptionalOccp] == FALSE) {
		 
		 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
		 message:@"Office Address PostCode is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		 
		 [txtOfficePostcode becomeFirstResponder];
		 //[self.view endEditing:TRUE];
		 [alert show];
		 return false;
		 }
		 else {
		 
		 }
		 
		 }
         */
        if(![[txtOfficeAddr1.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]){
            if([txtOfficePostcode.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
																message:@"Office Address PostCode is required" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [txtOfficePostcode becomeFirstResponder];
				
                [alert show];
                return false;
            }
        }
    }
    else {
        return  FALSE;
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
    
    for (int a = 0; a<5; a++) {
        
        switch (a) {
            case 0:
                
                if ([outletType1.titleLabel.text isEqualToString:@"Mobile"]) {
                    contactCode = @"CONT008";
                }
                else if ([outletType1.titleLabel.text isEqualToString: @"Home"]) {
                    contactCode = @"CONT006";
                }
                else if ([outletType1.titleLabel.text isEqualToString: @"Fax"]) {
                    contactCode = @"CONT009";
                }
                else if ([outletType1.titleLabel.text isEqualToString: @"Office"]) {
                    contactCode = @"CONT007";
                }
                else {
                    contactCode = @"";
                }
				
                break;
				
            case 1:
                if ([outletType2.titleLabel.text isEqualToString: @"Mobile"]) {
                    contactCode = @"CONT008";
                }
                else if ([outletType2.titleLabel.text isEqualToString: @"Home"]) {
                    contactCode = @"CONT006";
                }
                else if ([outletType2.titleLabel.text isEqualToString: @"Fax"]) {
                    contactCode = @"CONT009";
                }
                else if ([outletType2.titleLabel.text isEqualToString: @"Office"]) {
                    contactCode = @"CONT007";
                }
                else {
                    contactCode = @"";
                }
                break;
				
            case 2:
                if ([outletType3.titleLabel.text isEqualToString: @"Mobile"]) {
                    contactCode = @"CONT008";
                }
                else if ([outletType3.titleLabel.text isEqualToString: @"Home"]) {
                    contactCode = @"CONT006";
                }
                else if ([outletType3.titleLabel.text isEqualToString: @"Fax"]) {
                    contactCode = @"CONT009";
                }
                else if ([outletType3.titleLabel.text isEqualToString: @"Office"]) {
                    contactCode = @"CONT007";
                }
                else {
                    contactCode = @"";
                }
                break;
				
            case 3:
                if ([outletType4.titleLabel.text isEqualToString: @"Mobile"]) {
                    contactCode = @"CONT008";
                }
                else if ([outletType4.titleLabel.text isEqualToString: @"Home"]) {
                    contactCode = @"CONT006";
                }
                else if ([outletType4.titleLabel.text isEqualToString: @"Fax"]) {
                    contactCode = @"CONT009";
                }
                else if ([outletType4.titleLabel.text isEqualToString: @"Office"]) {
                    contactCode = @"CONT007";
                }
                else {
                    contactCode = @"";
                }
                break;
				
            case 4:
                if ([outletType5.titleLabel.text isEqualToString: @"Mobile"]) {
                    contactCode = @"CONT008";
                }
                else if ([outletType5.titleLabel.text isEqualToString: @"Home"]) {
                    contactCode = @"CONT006";
                }
                else if ([outletType5.titleLabel.text isEqualToString: @"Fax"]) {
                    contactCode = @"CONT009";
                }
                else if ([outletType5.titleLabel.text isEqualToString: @"Office"]) {
                    contactCode = @"CONT007";
                }
                else {
                    contactCode = @"";
                }
                break;
                
            default:
                break;
        }
        
        if (![contactCode isEqualToString:@""]) {
            /*
			 NSString *GetLastIdSQL = [NSString stringWithFormat:@"Select last_insert_rowid() from prospect_profile"];
			 const char *SelectLastId_stmt = [GetLastIdSQL UTF8String];
			 if(sqlite3_prepare_v2(contactDB, SelectLastId_stmt, -1, &statement2, NULL) == SQLITE_OK)
			 {
			 if (sqlite3_step(statement2) == SQLITE_ROW)
			 {
			 lastID = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 0)];
			 
			 sqlite3_finalize(statement2);
			 NSString *insertContactSQL = [NSString stringWithFormat:
			 @"INSERT INTO contact_input(\"IndexNo\",\"contactCode\", \"ContactNo\", \"Primary\") "
			 " VALUES (\"%@\", \"%@\", \"%@\", \"%@\")", lastID, contactCode, txtContact1.text, @"N"];
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
			 }
			 else {
			 NSLog(@"Error - 2 ");
			 }
			 sqlite3_close(contactDB);
			 }
			 else {
			 
			 NSLog(@"Error get last ID statement");
			 }
             */
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
            else if (a==4) {
                insertContactSQL = [NSString stringWithFormat:
                                    @"INSERT INTO contact_input(\"IndexNo\",\"contactCode\", \"ContactNo\", \"Primary\", \"Prefix\") "
                                    " VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", lastID, contactCode, txtContact5.text, @"N", txtPrefix5.text];
            }
            
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
            
            insert_contactStmt = Nil, insertContactSQL = Nil;
			
        }
		
    }
    
    UIAlertView *SuccessAlert = [[UIAlertView alloc] initWithTitle:@"Prospect Profile"
                                                           message:@"A new prospect record successfully inserted." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    SuccessAlert.tag = 1;
    [SuccessAlert show];
    
    statement2 = Nil;
    statement3 = Nil;
    lastID = Nil;
    contactCode = Nil;
    dbpath = Nil;
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1) {
        if (_delegate != Nil) {
            [_delegate FinishInsert ];
        }
        
        [self resignFirstResponder];
        [self.view endEditing:YES];
        //[self dismissModalViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        if (buttonIndex == 0) {
            if ( alertView.tag == 2000 || alertView.tag == 2001 ) {
                [txtHomePostCode becomeFirstResponder];
            }
            else if ( alertView.tag == 3000 || alertView.tag == 3001) {
                [txtOfficePostcode becomeFirstResponder];
            }
        }
        
    }
	
}

- (void)OccupCodeSelected:(NSString *)OccupCode{
	
    OccupCodeSelected = OccupCode;
	/*
	 if ([self OptionalOccp] == TRUE) {
	 lblOfficeAddr.text = @"Office Address";
	 lblPostCode.text = @"Postcode";
	 }
	 else {
	 lblOfficeAddr.text = @"Office Address*";
	 lblPostCode.text = @"Postcode*";
	 }
	 */
    
}

- (void)OccupDescSelected:(NSString *)color {
    [outletOccup setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", color]forState:UIControlStateNormal];
    [self.OccupationListPopover dismissPopoverAnimated:YES];
    
    [self.view endEditing:YES];
    [self resignFirstResponder];
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
}

-(BOOL)OptionalOccp{
    
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


- (IBAction)ActionCancel:(id)sender {
    if (_delegate != Nil) {
        [_delegate FinishInsert ];
    }
    
    _OccupationList = Nil;
    
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    self.myScrollView.frame = CGRectMake(0, 20, 1000, 748);
	/*
	 for (UIWindow* window in [UIApplication sharedApplication].windows) {
	 NSArray* subviews = window.subviews;
	 if ([subviews count] > 0) {
	 
	 BOOL alert = [[subviews objectAtIndex:0] isKindOfClass:[UIAlertView class]];
	 BOOL action = [[subviews objectAtIndex:0] isKindOfClass:[UIActionSheet class]];
	 
	 if (alert || action){
	 NSLog(@"dsadsa");
	 }
	 
	 }
	 }
	 */
    outletDone.enabled = TRUE;
    [rrr dismissWithClickedButtonIndex:0 animated:NO];
    [self dismissModalViewControllerAnimated:YES ];
}

-(void)keyboardDidShow:(NSNotificationCenter *)notification
{
    self.myScrollView.frame = CGRectMake(0, 20, 1000, 748-350);
    self.myScrollView.contentSize = CGSizeMake(1000, 748);
    
    CGRect textFieldRect = [activeField frame];
    textFieldRect.origin.y += 15;
    [self.myScrollView scrollRectToVisible:textFieldRect animated:YES];
    //pickerToolbar.hidden = true;
    //outletDobPicker.hidden = TRUE;
    txtRemark.hidden = FALSE;
}

-(void)keyboardDidHide:(NSNotificationCenter *)notification
{
    self.myScrollView.frame = CGRectMake(0, 20, 1000, 748);
    //ContactTypePicker.hidden = true;
    //outletContactType.hidden = true;
    
}

-(void)textFieldDidChange:(id) sender
{
    BOOL gotRow = false;
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    txtHomePostCode.text = [txtHomePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([txtHomePostCode.text isEqualToString:@""]) {
        /*
		 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
		 message:@"Home postcode is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		 alert.tag = 2001;
		 [alert show];*/
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
		/*
		 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
		 message:@"Home post code must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		 
		 
		 [alert show];
		 */
		
		rrr = [[UIAlertView alloc] initWithTitle:@"Error"
										 message:@"Home post code must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		
		rrr.tag = 2001;
		[rrr show];
		
		
		txtHomePostCode.text = @"";
		txtHomeState.text = @"";
		txtHomeTown.text = @"";
		txtHomeCountry.text = @"";
		SelectedStateCode = @"";
		PostcodeContinueOLD = FALSE;
		
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
					PostcodeContinueOLD = TRUE;
					outletDone.enabled = TRUE;
				}
				sqlite3_finalize(statement);
			}
			
			if (gotRow == false) {
				/*
				 UIAlertView *NoPostcode = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No postcode found for Home Address"
				 delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
				 
				 NoPostcode.tag = 2000;
				 [NoPostcode show];
				 */
				
				rrr = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No postcode found for Home Address"
												delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
				
				rrr.tag = 2000;
				[rrr show];
				
				txtHomePostCode.text = @"";
				txtHomeState.text = @"";
				txtHomeTown.text = @"";
				txtHomeCountry.text = @"";
				SelectedStateCode = @"";
				
				PostcodeContinueOLD = FALSE;
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
        /*
		 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Office postcode is required"
		 delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		 alert.tag = 3001;
		 [alert show];*/
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
		/*
		 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
		 message:@"Office post code must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		 
		 [alert show];
		 */
		
		rrr = [[UIAlertView alloc] initWithTitle:@"Error"
										 message:@"Office post code must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		rrr.tag = 3001;
		[rrr show];
		
		txtOfficePostcode.text = @"";
		txtOfficeState.text = @"";
		txtOfficeTown.text = @"";
		txtOfficeCountry.text = @"";
		SelectedOfficeStateCode = @"";
		PostcodeContinueOLD = FALSE;
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
					PostcodeContinueOLD = TRUE;
					outletDone.enabled = TRUE;
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
					
					PostcodeContinueOLD = FALSE;
				}
				
				sqlite3_close(contactDB);
			}
		}
	}
    
	
}



- (IBAction)btnContact1:(id)sender {
    /*
	 //ContactTypePicker.hidden = false;
	 [self resignFirstResponder];
	 [self.view endEditing:TRUE];
	 
	 outletContactType.hidden = false;
	 outletDobPicker.hidden = true;
	 pickerToolbar.hidden = FALSE;
	 txtRemark.hidden = true;
	 ContactTypeTracker = @"1";
	 //if ([outletType1.titleLabel.text isEqualToString:@""]) {
	 [outletType1 setTitle:@"Mobile" forState:UIControlStateNormal];
	 //}
	 */
    
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
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



- (IBAction)btnContact2:(id)sender {
    /*outletContactType.hidden = false;
	 outletDobPicker.hidden = true;
	 pickerToolbar.hidden = FALSE;
	 txtRemark.hidden = true;
	 ContactTypeTracker = @"2";
	 [self resignFirstResponder];
	 [self.view endEditing:TRUE];
	 if ([outletType2.titleLabel.text isEqualToString:@""]) {
	 [outletType2 setTitle:@"Mobile" forState:UIControlStateNormal];
	 }*/
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
    /*outletContactType.hidden = false;
	 outletDobPicker.hidden = true;
	 pickerToolbar.hidden = FALSE;
	 txtRemark.hidden = true;
	 ContactTypeTracker = @"3";
	 [self.view endEditing:TRUE];
	 [self resignFirstResponder];
	 if ([outletType3.titleLabel.text isEqualToString:@""]) {
	 [outletType3 setTitle:@"Mobile" forState:UIControlStateNormal];
	 }
     */
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
    /*outletContactType.hidden = false;
	 outletDobPicker.hidden = true;
	 pickerToolbar.hidden = FALSE;
	 txtRemark.hidden = true;
	 ContactTypeTracker = @"4";
	 [self.view endEditing:TRUE];
	 [self resignFirstResponder];
	 if ([outletType4.titleLabel.text isEqualToString:@""]) {
	 [outletType4 setTitle:@"Mobile" forState:UIControlStateNormal];
	 }*/
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
    /*outletContactType.hidden = false;
	 outletDobPicker.hidden = true;
	 pickerToolbar.hidden = FALSE;
	 txtRemark.hidden = true;
	 ContactTypeTracker = @"5";
	 [self.view endEditing:TRUE];
	 [self resignFirstResponder];
	 if ([outletType5.titleLabel.text isEqualToString:@""]) {
	 [outletType5 setTitle:@"Mobile" forState:UIControlStateNormal];
	 }*/
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
    [outletDOB setTitle:strDate forState:UIControlStateNormal ];
    
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

-(void)CloseWindow{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [_SIDatePopover dismissPopoverAnimated:YES];
}

-(void)OccupClassSelected:(NSString *)OccupClass{
	
}

@end
