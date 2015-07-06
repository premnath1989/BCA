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

@interface SubDetails (){
    DataClass *obj;
    NSDictionary *details;
    bool isPO;
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
    
    obj=[DataClass getInstance];
    
    //db for postcode
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    //NEW PO SECTION
    if ([[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"SecPO_1LA"] isEqualToString:@"Y"]) {
        [self getPO_Oject];
        //[self displayRecord];
        NSLog(@"SecPO_1LA!!!!");
    }
    
    
    if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickPart2"] isEqualToString:@"Y"]) {
		[checkPolicyOwner setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        
        _txtState1.enabled = false;
        _txtState2.enabled = false;
        
        if ([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SecA_savedSubDetails"] isEqualToString:@"Y"]) {
            [self displayRecord];
        }
        
    }
	else {
		[checkPolicyOwner setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
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
        _LblCountry2.enabled = FALSE;
        
        _txtPostcode2.enabled = FALSE;
        _txtState2.enabled = FALSE;
        _txtCountry2.enabled = FALSE;
        _txtTown2.enabled = FALSE;
        
        _txtAdd2.enabled = FALSE;
        _txtAdd22.enabled = FALSE;
        
        _txtAdd23.enabled = FALSE;
        
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
	}
    
    [self displayRecord];
    
}


- (IBAction)ActionCheckCorrespondenceResidence:(id)sender
{
    [_BtnResidence setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    [_BtnOffice setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"TickResidenceAdd"];
    [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickOfficeAdd"];
    
}
- (IBAction)ActionCheckCorrespondenceOffice:(id)sender
{
    [_BtnOffice setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    [_BtnResidence setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"TickOfficeAdd"];
    [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickResidenceAdd"];
    
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
        }
        else
        {
            [_BtnResidenceForeignAdd setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"ForeignResidenceAdd"];
            _txtTown1.enabled = true;
            _txtCountry1.enabled = true;
        }
    }
    else {
        
		[_BtnResidenceForeignAdd setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"ForeignResidenceAdd"];
        _txtTown1.enabled = false;
        _txtCountry1.enabled = false;
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
        }
        else
        {
            [_BtnOfficeForeignAdd setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"ForeignOfficeAdd"];
            _txtTown2.enabled = true;
            _txtCountry2.enabled = true;
            
        }
    }
    else {
		[_BtnOfficeForeignAdd setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"ForeignOfficeAdd"];
        _txtTown2.enabled = false;
        _txtCountry2.enabled = false;
    }
}


- (IBAction)ActionCheckPolicyOwner:(id)sender
{
    
    NSLog(@"kky ActionCheckPolicyOwner..... ");
    isPart2Checked = !isPart2Checked;
	if(isPart2Checked) {
		[checkPolicyOwner setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        
        [[obj.eAppData objectForKey:@"SecA"] setValue:@"Y" forKey:@"TickPart2"];
        
        _LblCorrespondenceAdd.enabled = TRUE;
        _LblResidence.enabled = TRUE;
        _LblOffice.enabled = TRUE;
        _BtnResidence.enabled = TRUE;
        
        _segOwnership.enabled =TRUE;
        _LblResidenceAdd.enabled = TRUE;
        _LblForeignAdd.enabled = TRUE;
        _LblOwnership.enabled = TRUE;
        _LblAddress1.enabled = TRUE;
        _LblPostcode1.enabled = TRUE;
        _LblTown1.enabled = TRUE;
        _LblState1.enabled = TRUE;
        _LblCountry1.enabled = TRUE;
        
        _txtPostcode1.enabled = TRUE;
        //   _txtState1.enabled = TRUE;
        _txtCountry1.enabled = TRUE;
        _txtTown1.enabled = TRUE;
        
        _txtAdd1.enabled = TRUE;
        _txtAdd12.enabled = TRUE;
        _txtAdd13.enabled = TRUE;
        
        _BtnResidenceForeignAdd.enabled =TRUE;
        
        _LblOfficeAdd2.enabled = TRUE;
        _LblForeignAdd2.enabled = TRUE;
        _LblAddress2.enabled = TRUE;
        _LblPostcode2.enabled =TRUE;
        _LblState2.enabled = TRUE;
        _LblTown2.enabled = TRUE;
        _LblCountry2.enabled = TRUE;
        
        _txtPostcode2.enabled = TRUE;
        //  _txtState2.enabled = TRUE;
        _txtCountry2.enabled = TRUE;
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
        _txtName.enabled = TRUE;
        _txtIC.enabled = TRUE;
        
          isPO = TRUE;
    }
    else {
		[checkPolicyOwner setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        
        [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickPart2"];
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
        _LblCountry2.enabled = FALSE;
        
        _txtPostcode2.enabled = FALSE;
        _txtState2.enabled = FALSE;
        _txtCountry2.enabled = FALSE;
        _txtTown2.enabled = FALSE;
        
        
        
        _txtAdd2.enabled = FALSE;
        _txtAdd22.enabled = FALSE;
        _txtAdd23.enabled = FALSE;
        
        
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
        
        _txtName.enabled = FALSE;
        _txtIC.enabled = FALSE;
        
        _txtPostcode1.text = @"";
        _txtState1.text = @"";
        _txtCountry1.text = @"";
        _txtTown1.text = @"";
        
        _txtAdd1.text = @"";
        _txtAdd12.text = @"";
        _txtAdd13.text = @"";
        
        _txtPostcode2.text = @"";
        _txtState2.text = @"";
        _txtCountry2.text = @"";
        _txtTown2.text = @"";
        
        _txtAdd2.text = @"";
        _txtAdd22.text = @"";
        _txtAdd23.text = @"";
        
        _txtResidence1.text = @"";
        _txtResidence2.text = @"";
        
        _txtOffice1.text = @"";
        _txtOffice2.text = @"";
        _txtEmail.text = @"";
        _txtMobile1.text = @"";
        _txtMobile2.text = @"";
        _txtFax1.text = @"";
        _txtFax2.text = @"";
        _txtName.text = @"";
        _txtIC.text = @"";
        
        
        [_BtnResidence setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        [_BtnOffice setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        [_BtnResidenceForeignAdd setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        [_BtnOfficeForeignAdd setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        
        [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickResidenceAdd"];
        [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"TickOfficeAdd"];
        [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"ForeignResidenceAdd"];
        [[obj.eAppData objectForKey:@"SecA"] setValue:@"N" forKey:@"ForeignOfficeAdd"];
        
        
        
          isPO = FALSE;
        
    }
    
}
- (IBAction)ActionTitle:(id)sender
{
    if (_TitlePicker == nil) {
        _TitlePicker = [[TitleViewController alloc] initWithStyle:UITableViewStylePlain];
        _TitlePicker.delegate = self;
        self.TitlePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_TitlePicker];
    }
    
    [self.TitlePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)ActionOtherID:(id)sender
{
    
    if (_IDTypeVC == nil) {
        
        self.IDTypeVC = [[IDTypeViewController alloc] initWithStyle:UITableViewStylePlain];
        _IDTypeVC.delegate = self;
        self.IDTypePopover = [[UIPopoverController alloc] initWithContentViewController:_IDTypeVC];
    }
    
    [self.IDTypePopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}
- (IBAction)ActionDOB:(id)sender;
{
    
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
    
    // dateFormatter = Nil;
    //  dateString = Nil, mainStoryboard = nil;
    
}
- (IBAction)ActionRelationship:(id)sender;
{
    if (_RelationshipVC == nil) {
        
        self.RelationshipVC = [[Relationship alloc] initWithStyle:UITableViewStylePlain];
        _RelationshipVC.delegate = self;
        _RelationshipVC.requestType = @"LA";
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
    [self.RelationshipPopover dismissPopoverAnimated:YES];
}

-(void)selectedTitle:(NSString *)selectedTitle
{
    self.titleLbl.text = selectedTitle;
	self.titleLbl.textColor = [UIColor blackColor];
    [self.TitlePickerPopover dismissPopoverAnimated:YES];
}

- (IBAction)editingDidEndPostcode:(id)sender {
	//if (!isForeignAddress) {
    
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
                NSString *Statecode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                
                _txtState1.text = State;
                _txtState1.textColor = [UIColor blackColor];
                _txtTown1.text = Town;
                _txtTown1.textColor = [UIColor blackColor];
                
                //  _countryLbl.text = @"MALAYSIA";
                // _countryLbl.textColor = [UIColor blackColor];
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    //}
    /*	else {
     _townTF.placeholder = @"Town";
     //		_townTF.textColor = [UIColor lightGrayColor];
     _townTF.enabled = YES;
     
     _stateLbl.text = @"State";
     _stateLbl.textColor = [UIColor lightGrayColor];
     }
     */
}


- (IBAction)editingDidEndPostcode2:(id)sender {
	//if (!isForeignAddress) {
    
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
                NSString *Statecode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                
                _txtState2.text = State;
                _txtState2.textColor = [UIColor blackColor];
                _txtTown2.text = Town;
                _txtTown2.textColor = [UIColor blackColor];
                
                //  _countryLbl.text = @"MALAYSIA";
                // _countryLbl.textColor = [UIColor blackColor];
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    //}
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
-(void)displayRecord_PO
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDeleteNominee:) name:@"DeleteNominee" object:nil];
    
    
    
}
-(void)displayRecord
{
     NSString *plan =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"];
     NSString *pcode = [self.LADetails objectForKey:@"PTypeCode"];
     NSString *POFLAG =    [self.LADetails objectForKey:@"POFlag"];
    
    NSLog(@"SubDetails displayRecord - name -%@  || ptype - %@ || poflag - %@", plan, pcode, POFLAG);
 
    // Check on owner type
 
    if([pcode isEqualToString:@"PO"])
    {
        [checkPolicyOwner setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        
        _txtState1.enabled = false;
        _txtState2.enabled = false;
        isPO = TRUE;
        isPart2Checked = TRUE;
        checkPolicyOwner.enabled = FALSE;
        
         //[[obj.eAppData objectForKey:@"SecPO"] setValue:@"Y" forKey:@"CheckNewPO"];
    }
    else
    {
         //[[obj.eAppData objectForKey:@"SecPO"] setValue:@"N" forKey:@"CheckNewPO"];
        
    if ([POFLAG isEqualToString:@"Y"]) {
        if([plan isEqualToString:@"HLA Cash Promise"]){
            [checkPolicyOwner setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            
            _txtState1.enabled = false;
            _txtState2.enabled = false;
            isPO = TRUE;
            isPart2Checked = TRUE;
        }
        else if([plan isEqualToString:@"HLA EverLife"]){
            [checkPolicyOwner setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            
            _txtState1.enabled = false;
            _txtState2.enabled = false;
            isPO = TRUE;
            isPart2Checked = TRUE;
        }

        if([pcode isEqualToString:@"PY1"])
            checkPolicyOwner.enabled = FALSE;
        else if([pcode isEqualToString:@"LA2"] && [plan isEqualToString:@"HLA Cash Promise"] )
            checkPolicyOwner.enabled = FALSE;
        else
            checkPolicyOwner.enabled = TRUE;
        
    }
    else //PO isEqualToString:@"N"
    {
        NSLog(@"KKY 1 plan - %@ || pcode - %@", plan  , pcode  );
        
        if([plan isEqualToString:@"HLA Cash Promise"])
        {
            
        NSString *isNewPO =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"AddNewPO"];
     
            
           NSString *NewPOName =  [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"NewPOName"];
           
            
             
           if ([pcode isEqualToString:@"LA1"] && ([isNewPO isEqualToString:@"Y"]) )
              {
                  
                  NSLog(@"KKY 2 LA1 - ISNEWPO - %@", isNewPO);
               if([NewPOName isEqualToString:@""] ||  [NewPOName isEqualToString:@"(null)"] || (NewPOName == nil) ||NewPOName ==NULL)
                
                   checkPolicyOwner.enabled = TRUE; //FOR LA1 AND NEW PO - ENABLE CHECK BOX
                else
                    checkPolicyOwner.enabled = FALSE; //FOR LA1 & LA2 - DISABLE CHECK BOX FOR LA1
               }
            else
                 checkPolicyOwner.enabled = FALSE; //FOR LA1 & LA2 - DISABLE CHECK BOX FOR LA1
            
        }
        else if([plan isEqualToString:@"HLA EverLife"])
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
            } else if ([pcode isEqualToString:@"LA1"] && ([isNewPO isEqualToString:@"N"]))
            {
                NSLog(@"LA1 - N ");
                 checkPolicyOwner.enabled = TRUE;
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
            isPart2Checked = FALSE;
                     
                 
    }
}
    
    _policyOwnerType.selectedSegmentIndex = 0;
    _titleLbl.text = [self.LADetails objectForKey:@"LATitle"];
    _DOBLbl.text = [self.LADetails objectForKey:@"LADOB"];
    _nameLbl.text = [self.LADetails objectForKey:@"LAName"];
    _raceLbl.text = [self.LADetails objectForKey:@"LARace"];
    _nricLbl.text = [self.LADetails objectForKey:@"LANewICNO"];
    _nationalityLbl.text = [self.LADetails objectForKey:@"LANationality"];
    _OtherTypeIDLbl.text = [self.LADetails objectForKey:@"LAOtherIDType"];
    _otherIDLbl.text = [self.LADetails objectForKey:@"LAOtherID"];
    
    // Check db contents 1st
    if ([[self.LADetails objectForKey:@"LAReligion"] rangeOfString:@"NON"].location != NSNotFound) {
        _segReligion.selectedSegmentIndex = 1;
    }
    else if([[self.LADetails objectForKey:@"LAReligion"] rangeOfString:@"NON"].location == NSNotFound) {
        _segReligion.selectedSegmentIndex = 0;
    }
    
    _martialStatusLbl.text = [self.LADetails objectForKey:@"LAMaritalStatus"];
    _relationshipLbl.text = [self.LADetails objectForKey:@"LARelationship"];
    _OccupationLbl.text = [self.LADetails objectForKey:@"LAOccupationCode"];
    _employerLbl.text = [self.LADetails objectForKey:@"LAEmployerName"];
    _exaxtDutiesLbl.text = [self.LADetails objectForKey:@"LAExactDuties"];
    _yearlyIncomeLbl.text = [self.LADetails objectForKey:@"LAYearlyIncome"];
   /* if ([self.LADetails objectForKey:@"POFlag"]) {
        [checkPolicyOwner setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        isPO = TRUE;
    }
    */
    if ([self.LADetails objectForKey:@"ResidenceOwnRented"]) {
        _segOwnership.selectedSegmentIndex = 1;
    }
    else {
        _segOwnership.selectedSegmentIndex = 0;
    }
    if ([[self.LADetails objectForKey:@"LASex"] isEqualToString:@"F"]) {
        _segGender.selectedSegmentIndex = 1;
    }
    else if ([[self.LADetails objectForKey:@"LASex"] isEqualToString:@"M"]) {
        _segGender.selectedSegmentIndex = 0;
    }
    
    // No smoker field
    _segSmoker.selectedSegmentIndex = 0;
    _businessLbl.text = [self.LADetails objectForKey:@"LATypeOfBusiness"];
    
    //Check on corresponde address
    [self.LADetails objectForKey:@"CorrespondenceAddress"];
    
    
    
    if([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickResidenceAdd"] isEqualToString:@"Y"])
        [_BtnResidence setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    
    
    else if([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"TickOfficeAdd"] isEqualToString:@"Y"])
        [_BtnOffice setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    
    
    if([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ForeignResidenceAdd"] isEqualToString:@"Y"])
        [_BtnResidenceForeignAdd setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    
    if([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"ForeignOfficeAdd"] isEqualToString:@"Y"])
        [_BtnOfficeForeignAdd setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    
    
    
    
    _txtAdd1.text = [self.LADetails objectForKey:@"ResidenceAddress1"];
    _txtAdd12.text = [self.LADetails objectForKey:@"ResidenceAddress2"];
    _txtAdd13.text = [self.LADetails objectForKey:@"ResidenceAddress3"];
    _txtPostcode1.text = [self.LADetails objectForKey:@"ResidencePostcode"];
    _txtTown1.text = [self.LADetails objectForKey:@"ResidenceTown"];
    _txtState1.text = [self.LADetails objectForKey:@"ResidenceState"];
    _txtCountry1.text = [self.LADetails objectForKey:@"ResidenceCountry"];
    
    if ([[self.LADetails objectForKey:@"ResidenceCountry"] rangeOfString:@"MALAYSIA"].location != NSNotFound) {
        [_BtnResidenceForeignAdd setImage:[UIImage imageNamed:@"emptyCheckbox.png"] forState:UIControlStateNormal];
    }
    else if ([[self.LADetails objectForKey:@"ResidenceCountry"] rangeOfString:@"MALAYSIA"].location == NSNotFound) {
        [_BtnResidenceForeignAdd setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    }
    
    
    _txtAdd2.text = [self.LADetails objectForKey:@"OfficeAddress1"];
    _txtAdd22.text = [self.LADetails objectForKey:@"OfficeAddress2"];
    _txtAdd23.text = [self.LADetails objectForKey:@"OfficeAddress3"];
    _txtPostcode2.text = [self.LADetails objectForKey:@"OfficePostcode"];
    _txtTown2.text = [self.LADetails objectForKey:@"OfficeTown"];
    _txtState2.text = [self.LADetails objectForKey:@"OfficeState"];
    _txtCountry2.text = [self.LADetails objectForKey:@"OfficeCountry"];
    
    if ([[self.LADetails objectForKey:@"OfficeCountry"] rangeOfString:@"MALAYSIA"].location != NSNotFound) {
        [_BtnOfficeForeignAdd setImage:[UIImage imageNamed:@"emptyCheckbox.png"] forState:UIControlStateNormal];
    }
    else if ([[self.LADetails objectForKey:@"OfficeCountry"] rangeOfString:@"MALAYSIA"].location == NSNotFound) {
        [_BtnOfficeForeignAdd setImage:[UIImage imageNamed:@"tickCheckbox.png"] forState:UIControlStateNormal];
    }
    
    // Not sure, just put for placeholder
    if ([self.LADetails objectForKey:@"CorrespondenceAddress"]) {
        [_BtnResidence setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
    }
    else {
        [_BtnOffice setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
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
}
- (void)btnDone:(id)sender
{
    
     
    [self.LADetails setValue:_txtIC.text forKey:@"GuardianNRIC"];
    [self.LADetails setValue:_txtName.text forKey:@"GuardianName"];
    
     
    
    [self.LADetails setValue:_txtEmail.text forKey:@"EmailAddress"];
    [self.LADetails setValue:_txtFax2.text forKey:@"FaxPhoneNo"];
    [self.LADetails setValue:_txtFax1.text forKey:@"FaxPhonePrefix"];
    [self.LADetails setValue:_txtOffice2.text forKey:@"OfficePhoneNo"];
    [self.LADetails setValue:_txtOffice1.text forKey:@"OfficePhonePrefix"];
    [self.LADetails setValue:_txtMobile2.text forKey:@"MobilePhoneNo"];
    [self.LADetails setValue:_txtMobile1.text forKey:@"MobilePhoneNoPrefix"];
    //check on correspondence address
    [self.LADetails setValue:_txtCountry2.text forKey:@"OfficeCountry"];
    [self.LADetails setValue:_txtState2.text forKey:@"OfficeState"];
    [self.LADetails setValue:_txtTown2.text forKey:@"OfficeTown"];
    [self.LADetails setValue:_txtPostcode2.text forKey:@"OfficePostcode"];
    [self.LADetails setValue:_txtAdd23.text forKey:@"OfficeAddress3"];
    [self.LADetails setValue:_txtAdd22.text forKey:@"OfficeAddress2"];
    [self.LADetails setValue:_txtAdd2.text forKey:@"OfficeAdress1"];
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
        [self.LADetails setValue:@"something" forKey:@"ResidenceOwnRented"];
    }
    else if (_segOwnership.selectedSegmentIndex == 0) {
        [self.LADetails setValue:@"somethingelse" forKey:@"ResidenceOwnRented"];
    }
   
    NSLog(@"PO CHECK - %i", isPO);
    if (isPO) {
        [self.LADetails setValue:@"Y" forKey:@"POFlag"];
        [[obj.eAppData objectForKey:@"SecPO"] setValue:_nameLbl.text forKey:@"Confirm_POName"];
        [[obj.eAppData objectForKey:@"SecPO"] setValue:_nricLbl.text forKey:@"Confirm_POIC"];
       
        [[obj.eAppData objectForKey:@"SecPO"] setValue:[self.LADetails objectForKey:@"PTypeCode"] forKey:@"Confirm_POType"];
        
    }
    else {
        [[obj.eAppData objectForKey:@"SecPO"] setValue:@"" forKey:@"Confirm_POType"];
        [self.LADetails setValue:@"N" forKey:@"POFlag"];
    }
    [self.LADetails setValue:_yearlyIncomeLbl.text forKey:@"LAYearlyIncome"];
    
    if([_relationshipLbl.text isEqualToString:@"(null)"])
        _relationshipLbl.text = @"";
    
    [self.LADetails setValue:_relationshipLbl.text forKey:@"LARelationship"];
    [self.LADetails setValue:_OccupationLbl.text forKey:@"LAOccupationCode"];
    
   
    
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
    
   
    [self.LADetails setValue:_otherIDLbl.text forKey:@"LAOtherID"];
    [self.LADetails setValue:_OtherTypeIDLbl.text forKey:@"LAOtherIDType"];
    [self.LADetails setValue:_nationalityLbl.text forKey:@"LANationality"];
    [self.LADetails setValue:_nricLbl.text forKey:@"LANewICNO"];
    [self.LADetails setValue:_raceLbl.text forKey:@"LARace"];
    [self.LADetails setValue:_nameLbl.text forKey:@"LAName"];
    
    _DOBLbl.text =  [_DOBLbl.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [self.LADetails setValue:_DOBLbl.text forKey:@"LADOB"];
    [self.LADetails setValue:_titleLbl.text forKey:@"LATitle"];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *currentdate = [dateFormatter2 stringFromDate:[NSDate date]];
    
    [self.LADetails setValue:currentdate forKey:@"UpdatedAt"];
    
    int index = [[self.LADetails objectForKey:@"index"] intValue];
    [[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LADetails"] removeObjectAtIndex:index];
    [[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LADetails"] insertObject:[self.LADetails mutableCopy] atIndex:index];
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *stmt;
    if ([[self.LADetails objectForKey:@"PTypeCode"] isEqualToString:@"PO"]) {
        NSString *insertQuery = [NSString stringWithFormat:@"INSERT INTO eProposal_LA_Details(eProposalNo, PTypeCode, LAName) VALUES('%@', '%@', '%@')", [self.LADetails objectForKey:@"eProposalNo"], [self.LADetails objectForKey:@"PTypeCode"], [self.LADetails objectForKey:@"LAName"]];
        
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
    
    NSString *sqlQuery = [NSString stringWithFormat:@"Update eProposal_LA_Details SET \"eProposalNo\" = \"%@\", \"PTypeCode\" = \"%@\", \"LATitle\" = \"%@\", \"LAName\" = \"%@\", \"LASex\" = \"%@\", \"LADOB\" = \"%@\", \"LANewICNO\" = \"%@\", \"LAOtherIDType\" = \"%@\", \"LAOtherID\" = \"%@\", \"LAMaritalStatus\" = \"%@\", \"LARace\" = \"%@\", \"LAReligion\" = \"%@\", \"LANationality\" = \"%@\", \"LAOccupationCode\" = \"%@\", \"LAExactDuties\" = \"%@\", \"LATypeOfBusiness\" = \"%@\", \"LAEmployerName\" = \"%@\", \"LAYearlyIncome\" = \"%@\", \"LARelationship\" = \"%@\", \"POFlag\" = \"%@\", \"CorrespondenceAddress\" = \"%@\", \"ResidenceOwnRented\" = \"%@\", \"ResidenceAddress1\" = \"%@\", \"ResidenceAddress2\" = \"%@\", \"ResidenceAddress3\" = \"%@\", \"ResidenceTown\" = \"%@\", \"ResidenceState\" = \"%@\", \"ResidencePostcode\" = \"%@\", \"ResidenceCountry\" = \"%@\", \"OfficeAddress1\" = \"%@\", \"OfficeAddress2\" = \"%@\", \"OfficeAddress3\" = \"%@\", \"OfficeTown\" = \"%@\", \"OfficeState\" = \"%@\", \"OfficePostcode\" = \"%@\", \"OfficeCountry\" = \"%@\", \"ResidencePhoneNo\" = \"%@\", \"OfficePhoneNo\" = \"%@\", \"FaxPhoneNo\" = \"%@\", \"MobilePhoneNo\" = \"%@\", \"EmailAddress\" = \"%@\", \"PentalHealthStatus\" = \"%@\", \"PentalFemaleStatus\" = \"%@\", \"PentalDeclarationStatus\" = \"%@\", \"LACompleteFlag\" = \"%@\", \"AddPO\" = \"%@\", \"CreatedAt\" = \"%@\", \"UpdatedAt\" = \"%@\" WHERE eProposalNo = \"%@\" AND PTypeCode = \"%@\";", [self.LADetails objectForKey:@"eProposalNo"], [self.LADetails objectForKey:@"PTypeCode"], [self.LADetails objectForKey:@"LATitle"], [self.LADetails objectForKey:@"LAName"], [self.LADetails objectForKey:@"LASex"], [self.LADetails objectForKey:@"LADOB"], [self.LADetails objectForKey:@"LANewICNO"], [self.LADetails objectForKey:@"LAOtherIDType"], [self.LADetails objectForKey:@"LAOtherID"], [self.LADetails objectForKey:@"LAMaritalStatus"], [self.LADetails objectForKey:@"LARace"], [self.LADetails objectForKey:@"LAReligion"], [self.LADetails objectForKey:@"LANationality"], [self.LADetails objectForKey:@"LAOccupationCode"], [self.LADetails objectForKey:@"LAExactDuties"], [self.LADetails objectForKey:@"LATypeOfBusiness"], [self.LADetails objectForKey:@"LAEmployerName"], [self.LADetails objectForKey:@"LAYearlyIncome"], [self.LADetails objectForKey:@"LARelationship"], [self.LADetails objectForKey:@"POFlag"], [self.LADetails objectForKey:@"CorrespondeceAddress"], [self.LADetails objectForKey:@"ResidenceOwnRented"], [self.LADetails objectForKey:@"ResidenceAddress1"], [self.LADetails objectForKey:@"ResidenceAddress2"], [self.LADetails objectForKey:@"ResidenceAddress3"], [self.LADetails objectForKey:@"ResidenceTown"], [self.LADetails objectForKey:@"ResidenceState"], [self.LADetails objectForKey:@"ResidencePostcode"], [self.LADetails objectForKey:@"ResidenceCountry"], [self.LADetails objectForKey:@"OfficeAddress1"], [self.LADetails objectForKey:@"OfficeAddress2"], [self.LADetails objectForKey:@"OfficeAddress3"], [self.LADetails objectForKey:@"OfficeTown"], [self.LADetails objectForKey:@"OfficeState"], [self.LADetails objectForKey:@"OfficePostcode"], [self.LADetails objectForKey:@"OfficeCountry"], [NSString stringWithFormat:@"%@%@", [self.LADetails objectForKey:@"ResidencePhoneNoPrefix"], [self.LADetails objectForKey:@"ResidencePhoneNo"]], [NSString stringWithFormat:@"%@%@",[self.LADetails objectForKey:@"OfficePhoneNoPrefix"], [self.LADetails objectForKey:@"OfficePhoneNo"]], [NSString stringWithFormat:@"%@%@",[self.LADetails objectForKey:@"FaxPhoneNoPrefix"], [self.LADetails objectForKey:@"FaxPhoneNo"]], [NSString stringWithFormat:@"%@%@",[self.LADetails objectForKey:@"MobilePhoneNoPrefix"], [self.LADetails objectForKey:@"MobilePhoneNo"]], [self.LADetails objectForKey:@"EmailAddress"], @"", @"", @"", @"1", [self.LADetails objectForKey:@"AddPO"], [self.LADetails objectForKey:@"CreatedAt"], [self.LADetails objectForKey:@"UpdatedAt"], [self.LADetails objectForKey:@"eProposalNo"], [self.LADetails objectForKey:@"PTypeCode"]];
    
    
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
        if (sqlite3_prepare_v2(contactDB, updateOtherpoflag, -1, &statement, NULL) == SQLITE_OK)
        {
            sqlite3_step(statement);
        }
        sqlite3_finalize(statement);
        
        //Update "eProposal" - save Guardian Name & Guardian NIRC
        if(_txtName.text.length != 0 && _txtIC.text !=0)
        {
            if (sqlite3_prepare_v2(contactDB, update_eproposal_Query, -1, &statement, NULL) == SQLITE_OK)
            {
                sqlite3_step(statement);
            }
            sqlite3_finalize(statement);
        }
        
    }
    sqlite3_close(contactDB);
  
    if (![obj.eAppData objectForKey:@"CFF"]) {
        [obj.eAppData setValue:[[NSMutableDictionary alloc] init] forKey:@"CFF"];
    }
    [[obj.eAppData objectForKey:@"SecPO"] setValue:@"1" forKey:@"POCompleted"];
    
    //enable the 'Policy Owner' label in the PolicyOwner table cell
  //   [_delegate updatePOLabel:[self.LADetails objectForKey:@"PTypeCode"]];
    
    
     
    
     //PASS VALUE TO PolicyOwnerData
    [self.delegate  updatePOLabel:[[obj.eAppData objectForKey:@"SecPO"]  objectForKey:@"Confirm_POType"]];
    

   // [[obj.eAppData objectForKey:@"SecPO"] setValue:[self.LADetails objectForKey:@"PTypeCode"] forKey:@"SavedPOType"];
    
    [self dismissModalViewControllerAnimated:YES];
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
        [database close];
        
        [[obj.eAppData objectForKey:@"SecPO"] setValue:@"" forKey:@"NewPOName"];
      
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
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
    [super viewDidUnload];
}
@end
