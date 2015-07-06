//
//  SecondLAViewController.m
//  HLA
//
//  Created by shawal sapuan on 7/31/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "SecondLAViewController.h"
#import "MainScreen.h"
#import "AppDelegate.h"

@interface SecondLAViewController ()

@end

NSString *gNameSecond = @"";

@implementation SecondLAViewController
@synthesize nameField;
@synthesize sexSegment;
@synthesize smokerSegment;
@synthesize ageField;
@synthesize OccpLoadField;
@synthesize CPAField;
@synthesize PAField;
@synthesize sex,smoker,DOB,jobDesc,age,ANB,OccpCode,occLoading,SINo,CustLastNo,CustDate,CustCode,clientName,clientID,OccpDesc,occCPA_PA, occuCode,occuDesc;
@synthesize popOverController,requestSINo,la2ndHand,basicHand;
@synthesize ProspectList = _ProspectList;
@synthesize CheckRiderCode,IndexNo;
@synthesize NamePP,DOBPP,GenderPP,OccpCodePP;
@synthesize DOBField,OccpField,deleteBtn,getCommDate,dataInsert;
@synthesize delegate = _delegate;
@synthesize getSINo,getLAIndexNo,requestLAIndexNo,occPA,occuClass,headerTitle, LAView, Change;
@synthesize LADate = _LADate;
@synthesize dobPopover = _dobPopover;
@synthesize btnDOB, btnOccp;
@synthesize saved2ndLA;

id temp;
id dobtemp;
- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate ];
	
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    getLAIndexNo = requestLAIndexNo;
    getCommDate = [self.requestCommDate description];
    getSINo = [self.requestSINo description];
    NSLog(@"2ndLA-SINo:%@, CommDate:%@",getSINo,getCommDate);
    
    nameField.enabled = NO;
    sexSegment.enabled = NO;
    ageField.enabled = NO;
    OccpLoadField.enabled = NO;
    CPAField.enabled = NO;
    PAField.enabled = NO;
    DOBField.enabled = NO;
    OccpField.enabled = NO;
    self.deleteBtn.hidden = YES;
    
    [nameField setDelegate:self];
    [ageField setDelegate:self];
    [OccpLoadField setDelegate:self];
    [CPAField setDelegate:self];
    [PAField setDelegate:self];
    [DOBField setDelegate:self];
    [OccpField setDelegate:self];
	
    useExist = NO;
    inserted = NO;
    
    saved2ndLA = FALSE;
    
    [deleteBtn setBackgroundImage:[[UIImage imageNamed:@"iphone_delete_button.png"] stretchableImageWithLeftCapWidth:8.0f topCapHeight:0.0f] forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    deleteBtn.titleLabel.shadowColor = [UIColor lightGrayColor];
    deleteBtn.titleLabel.shadowOffset = CGSizeMake(0, -1);
    
    if (requestSINo) {
        [self checkingExisting];
        if (SINo.length != 0) {
            [self getProspectData];
            [self getSavedField];
            self.deleteBtn.hidden = NO;
        }
    }
    
    NSLog(@"delegate:%@",_delegate);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    /*
	 self.headerTitle.frame = CGRectMake(294, -20, 210, 44);
	 self.myToolBar.frame = CGRectMake(0, 0, 768, 44);
	 self.view.frame = CGRectMake(0, 20, 768, 1004); */
    
    self.view.frame = CGRectMake(0, 0, 788, 1004);
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

-(void)getSavedField
{
    BOOL valid = TRUE;
    
	
    if (![NamePP isEqualToString:clientName]) {
        valid = FALSE;
    }
    
    if (![GenderPP isEqualToString:sex]) {
        valid = FALSE;
    }
    
    if (![DOB isEqualToString:DOBPP]) {
        valid = FALSE;
    }
    
    if (![OccpCode isEqualToString:OccpCodePP]) {
        valid = FALSE;
    }
	
	
    
	//    NSLog(@"nameSI:%@, genderSI:%@, dobSI:%@, occpSI:%@",clientName,sex,DOB,OccpCode);
	//    NSLog(@"namepp:%@, genderpp:%@, dobPP:%@, occpPP:%@",NamePP,GenderPP,DOBPP,OccpCodePP);
    
    if (valid) {
		
        nameField.text = clientName;
		gNameSecond = clientName;
        DOBField.text = [[NSString alloc] initWithFormat:@"%@",DOB];
        ageField.text = [[NSString alloc] initWithFormat:@"%d",age];
        
        if ([sex isEqualToString:@"M"]) {
            sexSegment.selectedSegmentIndex = 0;
        } else  {
            sexSegment.selectedSegmentIndex = 1;
        }
        NSLog(@"sex:%@",sex);
        
        if ([smoker isEqualToString:@"Y"]) {
            smokerSegment.selectedSegmentIndex = 0;
        } else {
            smokerSegment.selectedSegmentIndex = 1;
        }
        NSLog(@"smoker:%@",smoker);
        
        [self getOccLoadExist];
        OccpField.text = [[NSString alloc] initWithFormat:@"%@",OccpDesc];
        OccpLoadField.text = [NSString stringWithFormat:@"%@",occLoading];
        
        if (occCPA_PA == 0) {
            CPAField.text = @"D";
        } else {
            CPAField.text = [NSString stringWithFormat:@"%d",occCPA_PA];
        }
        
        if (occPA == 0) {
            PAField.text = @"D";
        } else {
            PAField.text = [NSString stringWithFormat:@"%d",occPA];
        }
        
        [_delegate LA2ndIndexNo:IndexNo andSmoker:smoker andSex:sex andDOB:DOB andAge:age andOccpCode:OccpCode];
        AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
        zzz.SICompleted = YES;
		Change = @"no";
    }
    else {
        
        nameField.text = NamePP;
		gNameSecond = NamePP;
        sex = GenderPP;
		
        if ([sex isEqualToString:@"M"]) {
            sexSegment.selectedSegmentIndex = 0;
        } else {
            sexSegment.selectedSegmentIndex = 1;
        }
        NSLog(@"sex:%@",sex);
        
        if ([smoker isEqualToString:@"Y"]) {
            smokerSegment.selectedSegmentIndex = 0;
        } else {
            smokerSegment.selectedSegmentIndex = 1;
        }
        NSLog(@"smoker:%@",smoker);
        
        DOBField.text = [[NSString alloc] initWithFormat:@"%@",DOBPP];
        DOB = DOBPP;
        [self calculateAge];
        ageField.text = [[NSString alloc] initWithFormat:@"%d",age];
        
        OccpCode = OccpCodePP;
        [self getOccLoadExist];
        OccpField.text = [[NSString alloc] initWithFormat:@"%@",OccpDesc];
        OccpLoadField.text = [NSString stringWithFormat:@"%@",occLoading];
        
        if (occCPA_PA == 0) {
            CPAField.text = @"D";
        } else {
            CPAField.text = [NSString stringWithFormat:@"%d",occCPA_PA];
        }
        
        if (occPA == 0) {
            PAField.text = @"D";
        } else {
            PAField.text = [NSString stringWithFormat:@"%d",occPA];
        }
        
		//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"There are changes in Prospect's information. Are you sure want to apply changes to this SI?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        
		//Change = @"yes";
		if ([LAView isEqualToString:@"1"] ) {
			[self updateData];
			[self CheckValidRider];
			Change = @"yes";
			[_delegate RiderAdded];
			
		}
		else
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Prospect's information will synchronize to this SI." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert setTag:1004];
			[alert show];
			
		}
		
    }
}


#pragma mark - action
- (IBAction)doSelectProspect:(id)sender
{
    if (_ProspectList == nil) {
        self.ProspectList = [[ListingTbViewController alloc] initWithStyle:UITableViewStylePlain];
        _ProspectList.delegate = self;
        popOverController = [[UIPopoverController alloc] initWithContentViewController:_ProspectList];
    }
    
    [popOverController presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)sexSegmentChange:(id)sender
{
    if ([sexSegment selectedSegmentIndex]==0) {
        sex = @"M";
    }
    else if (sexSegment.selectedSegmentIndex == 1){
        sex = @"F";
    }
    appDelegate.isNeedPromptSaveMsg = YES;
	
}

- (IBAction)smokerSegmentChange:(id)sender
{
    if ([smokerSegment selectedSegmentIndex]==0) {
        smoker = @"Y";
    }
    else if (smokerSegment.selectedSegmentIndex == 1){
        smoker = @"N";
    }
    appDelegate.isNeedPromptSaveMsg = YES;
	
}

-(IBAction)enableFields:(id)sender{
	if (isNewClient) {
        
        nameField.enabled = NO;
        nameField.backgroundColor = [UIColor lightGrayColor];
        nameField.textColor = [UIColor darkGrayColor];
        sexSegment.enabled = NO;
        
        btnDOB.enabled = NO;
        self.btnDOB.titleLabel.textColor = [UIColor darkGrayColor];
        
        btnOccp.enabled = NO;
        self.btnOccp.titleLabel.textColor = [UIColor darkGrayColor];
        
        isNewClient = NO;
    }
    else {
        
        nameField.enabled = YES;
        nameField.backgroundColor = [UIColor whiteColor];
        nameField.textColor = [UIColor blackColor];
        sexSegment.enabled = YES;
        smokerSegment.enabled = YES;
        
        btnDOB.enabled = YES;
        self.btnDOB.titleLabel.textColor = [UIColor blackColor];
        
        btnOccp.enabled = YES;
        self.btnOccp.titleLabel.textColor = [UIColor blackColor];
        
        isNewClient = YES;
    }
    
    nameField.text = @"";
    sexSegment.selectedSegmentIndex = UISegmentedControlNoSegment;
    smokerSegment.selectedSegmentIndex = UISegmentedControlNoSegment;
    btnDOB.titleLabel.text = @"";
    ageField.text = @"";
    btnOccp.titleLabel.text = @"";
    OccpLoadField.text = @"";
    CPAField.text = @"";
    PAField.text = @"";
}

-(IBAction)btnOccpPressed:(id)sender{
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
    
    [self.OccupationListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(IBAction)btnDOBPressed:(id)sender{
	[self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    date1 = YES;
    
    self.LADate = [self.storyboard instantiateViewControllerWithIdentifier:@"showDate"];
    _LADate.delegate = self;
    _LADate.msgDate = dobtemp;
    _LADate.btnSender = 1;
    
    self.dobPopover = [[UIPopoverController alloc] initWithContentViewController:_LADate];
    
    [self.dobPopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.dobPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
}

- (IBAction)doSave:(id)sender
{
    [_delegate saveAll];
}

- (IBAction)doDelete:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:[NSString stringWithFormat:@"Delete 2nd Life Assured:%@?",nameField.text] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL",nil];
    [alert setTag:1002];
    [alert show];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1001 && buttonIndex == 0)
    {
        if (self.requestSINo) {
            if (useExist) {
                [self updateData];
				[self CheckValidRider];
				[_delegate RiderAdded];
				
            } else {
                [self saveData];
            }
        }
        else {
            [self save2ndLAHandler];
        }
        
    }
    else if (alertView.tag == 1002 && buttonIndex == 0) //delete
    {
        [self deleteSecondLA];//delete from database
        
        [_delegate secondLADelete];
        
    }
    else if (alertView.tag==1004 && buttonIndex == 0) {
        
        if (smoker.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Smoker is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
        } else {
            [self updateData];
			[self CheckValidRider];
			[_delegate RiderAdded];
        }
    }
    else if (alertView.tag == 1005 && buttonIndex == 0) {
		//        [self closeScreen];
    }
}

-(void)calculateAge
{
    NSArray *curr = [getCommDate componentsSeparatedByString: @"/"];
    NSString *currentDay = [curr objectAtIndex:0];
    NSString *currentMonth = [curr objectAtIndex:1];
    NSString *currentYear = [curr objectAtIndex:2];
    
    NSArray *foo = [DOB componentsSeparatedByString: @"/"];
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
    
    NSString *msgAge;
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
        msgAge = [[NSString alloc] initWithFormat:@"%d",newALB];
        age = newALB;
        ANB = newANB;
        
        if (age < 16) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Age must be at least 16 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
        }
    }
    else if (yearN == yearB)
    {
        age = 0;
        ANB = 1;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Age must be at least 16 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
    NSLog(@"msgAge:%@",msgAge);
}

/*
 -(void)closeScreen
 {
 if (dataInsert.count != 0) {
 for (NSUInteger i=0; i< dataInsert.count; i++) {
 SecondLAHandler *ss = [dataInsert objectAtIndex:i];
 MainScreen *main = [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
 main.modalPresentationStyle = UIModalPresentationFullScreen;
 main.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
 main.IndexTab = 3;
 main.mainLaH = laHand;
 main.mainBH = basicHand;
 main.mainLa2ndH = ss;
 [self presentModalViewController:main animated:YES];
 }
 }
 else {
 MainScreen *main = [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
 main.modalPresentationStyle = UIModalPresentationFullScreen;
 main.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
 main.IndexTab = 3;
 main.mainLaH = laHand;
 main.mainBH = basicHand;
 main.mainLa2ndH = la2ndHand;
 [self presentModalViewController:main animated:YES];
 }
 } */

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    return YES;
}
-(void)textFieldDidChange:(UITextField*)textField
{
    appDelegate.isNeedPromptSaveMsg = YES;
}

#pragma mark - delegate

-(void)listing:(ListingTbViewController *)inController didSelectIndex:(NSString *)aaIndex andName:(NSString *)aaName andDOB:(NSString *)aaDOB andGender:(NSString *)aaGender andOccpCode:(NSString *)aaCode andSmoker:(NSString *)aaSmoker
{
    saved2ndLA = FALSE;
    
    if (sex != NULL) {
        sex = nil;
        smoker = nil;
    }
    
    smoker = @"N";
    IndexNo = [aaIndex intValue];
    
    if (getLAIndexNo == IndexNo) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"This Life Assured has already been attached to the plan." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        
        [_delegate saved:NO];
        nameField.text = aaName;
		gNameSecond = aaName;
        sex = aaGender;
		
        if ([sex isEqualToString:@"M"]) {
            sexSegment.selectedSegmentIndex = 0;
        } else {
            sexSegment.selectedSegmentIndex = 1;
        }
        NSLog(@"sex:%@",sex);
        
        DOBField.text = [[NSString alloc] initWithFormat:@"%@",aaDOB];
        DOB = aaDOB;
        [self calculateAge];
        ageField.text = [[NSString alloc] initWithFormat:@"%d",age];
		
        OccpCode = aaCode;
        [self getOccLoadExist];
        OccpField.text = [[NSString alloc] initWithFormat:@"%@",OccpDesc];
        OccpLoadField.text = [NSString stringWithFormat:@"%@",occLoading];
        
        if (occCPA_PA == 0) {
            CPAField.text = @"D";
        } else {
            CPAField.text = [NSString stringWithFormat:@"%d",occCPA_PA];
        }
        
        if (occPA == 0) {
            PAField.text = @"D";
        } else {
            PAField.text = [NSString stringWithFormat:@"%d",occPA];
        }
    }
    
    if(age < 17){
        smokerSegment.enabled = FALSE;
    }
    else
    {
        smokerSegment.enabled = TRUE;
    }
    
    [_delegate setIsSecondLaNeeded:YES];
    [popOverController dismissPopoverAnimated:YES];
}

-(void)OccupClassSelected:(NSString *)OccupClass{
	
}

-(void)OccupCodeSelected:(NSString *)OccupCode{
	occuCode = OccupCode;
    OccpCode = OccupCode;
    [self getOccLoadExist];
    OccpLoadField.text = [NSString stringWithFormat:@"%@",occLoading];
    
    if (occCPA_PA == 0) {
        CPAField.text = @"D";
    }
    else {
        CPAField.text = [NSString stringWithFormat:@"%d",occCPA_PA];
    }
    
    if (occPA == 0) {
        PAField.text = @"D";
    }
    else {
        PAField.text = [NSString stringWithFormat:@"%d",occPA];
    }
}

-(void)OccupDescSelected:(NSString *)OccupDesc{

    [btnOccp setTitle:OccupDesc forState:UIControlStateNormal];
    [self.OccupationListPopover dismissPopoverAnimated:YES];
}

-(void)datePick:(DateViewController *)inController strDate:(NSString *)aDate strAge:(NSString *)aAge intAge:(int)bAge intANB:(int)aANB{
	if (date1) {
        if (aDate == NULL) {
            [btnDOB setTitle:dobtemp forState:UIControlStateNormal];
            DOB = dobtemp;
            [self calculateAge];
            ageField.text = [[NSString alloc] initWithFormat:@"%d",age];
            
        } else {
            [btnDOB setTitle:aDate forState:UIControlStateNormal];
            DOB = aDate;
            [self calculateAge];
            ageField.text = [[NSString alloc] initWithFormat:@"%d",bAge];
        }
        
        self.btnDOB.titleLabel.textColor = [UIColor blackColor];
        [self.dobPopover dismissPopoverAnimated:YES];
        date1 = NO;
    }
}

#pragma mark - db handle

-(void)getRunningCustCode
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT LastNo,LastUpdated FROM Adm_TrnTypeNo WHERE TrnTypeCode=\"CL\""];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                CustLastNo = sqlite3_column_int(statement, 0);
                CustDate = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                
                NSLog(@"LastCustNo:%d CustDate:%@",CustLastNo,CustDate);
                
            } else {
                NSLog(@"error check tbl_Adm_TrnTypeNo");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)saveData
{
    NSLog(@"save data ------------------>");
    
	if (isNewClient) {
        [self insertClient];
    }
	
    [self getRunningCustCode];
    
    //generate CustCode
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentdate = [dateFormatter stringFromDate:[NSDate date]];
    
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    int runningNoCust = CustLastNo + 1;
    NSString *fooCust = [NSString stringWithFormat:@"%04d", runningNoCust];
    
    SINo = [self.requestSINo description];
    CustCode = [[NSString alloc] initWithFormat:@"CL%@-%@",currentdate,fooCust];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:
							   @"INSERT INTO Trad_LAPayor (SINo, CustCode,PTypeCode,Sequence,DateCreated,CreatedBy) VALUES (\"%@\",\"%@\",\"LA\",\"2\",\"%@\",\"hla\")",SINo, CustCode,dateStr];
        
        NSLog(@"%@",insertSQL);
        if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Done LA");
            } else {
                NSLog(@"Failed LA");
            }
            sqlite3_finalize(statement);
        }
        
        NSString *insertSQL2 = [NSString stringWithFormat:
								@"INSERT INTO Clt_Profile (CustCode, Name, Smoker, Sex, DOB, ALB, ANB, OccpCode, DateCreated, CreatedBy,indexNo) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%d\", \"%@\", \"%@\", \"hla\", \"%d\")", CustCode, nameField.text, smoker, sex, DOB, age, ANB, OccpCode, dateStr,IndexNo];
        
        NSLog(@"%@",insertSQL2);
        if(sqlite3_prepare_v2(contactDB, [insertSQL2 UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Done LA2");
                [self updateRunCustCode];
                [_delegate LA2ndIndexNo:IndexNo andSmoker:smoker andSex:sex andDOB:DOB andAge:age andOccpCode:OccpCode];
                [_delegate saved:YES];
            }
            else {
                NSLog(@"Failed LA2");
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Fail in inserting record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    self.deleteBtn.hidden = NO;
    
    saved2ndLA = TRUE;
}

-(void)save2ndLAHandler
{
    [_delegate LA2ndIndexNo:IndexNo andSmoker:smoker andSex:sex andDOB:DOB andAge:age andOccpCode:OccpCode];
    self.deleteBtn.hidden = NO;
    inserted = YES;
    [_delegate saved:YES];
}

-(void)updateRunCustCode
{
    int newLastNo;
    newLastNo = CustLastNo + 1;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE Adm_TrnTypeNo SET LastNo= \"%d\",LastUpdated= \"%@\" WHERE TrnTypeCode=\"CL\"",newLastNo,dateString];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Run Cust update!");
                
            } else {
                NSLog(@"Run Cust update Failed!");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)checkingExisting
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT a.SINo, a.CustCode, b.Name, b.Smoker, b.Sex, b.DOB, b.ALB, b.OccpCode, b.id, b.IndexNo FROM Trad_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Sequence=2",getSINo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                SINo = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                CustCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                clientName = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                smoker = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                sex = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                DOB = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                age = sqlite3_column_int(statement, 6);
                OccpCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                clientID = sqlite3_column_int(statement, 8);
                IndexNo = sqlite3_column_int(statement, 9);
                
            } else {
                NSLog(@"error access tbl_SI_Trad_LAPayor");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    if (SINo.length != 0) {
        useExist = YES;
    } else {
        useExist = NO;
    }
}

-(void)checkingExisting2
{
    sqlite3_stmt *statement;
    NSString *tempSINo;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT a.SINo, b.id FROM Trad_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Sequence=2",[self.requestSINo description]];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                tempSINo = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                clientID = sqlite3_column_int(statement, 1);
            } else {
                NSLog(@"error access Trad_LAPayor");
                useExist = NO;
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    if (tempSINo.length != 0) {
        useExist = YES;
    } else {
        useExist = NO;
    }
}

-(void)getProspectData
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT ProspectName, ProspectDOB, ProspectGender, ProspectOccupationCode FROM prospect_profile WHERE IndexNo= \"%d\"",IndexNo];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NamePP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                DOBPP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                GenderPP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                OccpCodePP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
            } else {
                NSLog(@"error access prospect_profile");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

/*
 -(void)getOccLoadExist
 {
 sqlite3_stmt *statement;
 if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
 {
 NSString *querySQL = [NSString stringWithFormat:
 @"SELECT OccpCode,OccpDesc,Class,PA_CPA,OccLoading_TL from Adm_Occp_Loading_Penta where OccpCode = \"%@\"",OccpCode];
 if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
 {
 if (sqlite3_step(statement) == SQLITE_ROW)
 {
 OccpDesc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
 occCPA_PA  = sqlite3_column_int(statement, 3);
 occLoading =  sqlite3_column_int(statement, 4);
 }
 else {
 NSLog(@"Error retrieve loading!");
 }
 sqlite3_finalize(statement);
 }
 sqlite3_close(contactDB);
 }
 }*/

-(void)getOccLoadExist
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT a.OccpDesc, b.OccLoading, b.CPA, b.PA, b.Class from Adm_Occp_Loading_Penta a LEFT JOIN Adm_Occp_Loading b ON a.OccpCode = b.OccpCode WHERE b.OccpCode = \"%@\"",OccpCode];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                OccpDesc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                occLoading =  [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                occCPA_PA  = sqlite3_column_int(statement, 2);
                occPA  = sqlite3_column_int(statement, 3);
                occuClass = sqlite3_column_int(statement, 4);
                
                NSLog(@"OccpLoad:%@, cpa:%d, pa:%d, class:%d",occLoading, occCPA_PA,occPA,occuClass);
            }
            else {
                NSLog(@"Error getOccLoadExist!");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(BOOL)updateData
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *currentdate = [dateFormatter stringFromDate:[NSDate date]];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
		
        //NSString *querySQL = [NSString stringWithFormat:@"UPDATE Clt_Profile SET Name=\"%@\", Smoker=\"%@\", Sex=\"%@\", DOB=\"%@\", ALB=\"%d\", ANB=\"%d\", OccpCode=\"%@\", DateModified=\"%@\", ModifiedBy=\"hla\", indexNo=\"%d\" WHERE id=\"%d\"",nameField.text,smoker,sex,DOB,age,ANB,OccpCode,currentdate,IndexNo,clientID];
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE Clt_Profile SET Name=\"%@\", Smoker=\"%@\", Sex=\"%@\", DOB=\"%@\", ALB=\"%d\", ANB=\"%d\", OccpCode=\"%@\", DateModified=\"%@\", ModifiedBy=\"hla\", indexNo=\"%d\" WHERE id=\"%d\"",
							  gNameSecond,smoker,sex,DOB,age,ANB,OccpCode,currentdate,IndexNo,clientID];
		
        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"SI update!");
                [_delegate LA2ndIndexNo:IndexNo andSmoker:smoker andSex:sex andDOB:DOB andAge:age andOccpCode:OccpCode];
                [_delegate saved:YES];
                
            }
            else {
                NSLog(@"SI update Failed!");
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Fail in updating record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
                return NO;
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    return YES;
}

-(void)CheckValidRider
{
    
    sqlite3_stmt *statement;
	BOOL popMsg = FALSE;
	
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
		if ([OccpCode isEqualToString:@"OCC01975"]) {
			NSString *querySQL = [NSString stringWithFormat:@"Select * From trad_Rider_Details where SINO = \"%@\" AND RiderCode in ('LCWP', 'PR', 'SP_PRE', 'SP_STD') ", SINo];
			//        NSLog(@"%@",querySQL);
			if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{
				if (sqlite3_step(statement) == SQLITE_ROW)
				{
					popMsg = TRUE;
				}
				
				sqlite3_finalize(statement);
			}
			
			if (popMsg == TRUE) {
				querySQL = [NSString stringWithFormat:@"DELETE From trad_Rider_Details where SINO = \"%@\" AND RiderCode in ('LCWP', 'PR', 'SP_PRE', 'SP_STD') ", SINo];
				
				if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
				{
					if (sqlite3_step(statement) == SQLITE_DONE)
					{
						
					}
					sqlite3_finalize(statement);
					
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Some Rider(s) has been deleted due to marketing rule." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					[alert show];
				}
				
				
			}
			
		}
		
        sqlite3_close(contactDB);
		
    }
}


-(void)deleteLA
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_LAPayor WHERE CustCode=\"%@\"",CustCode];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"LAPayor delete!");
                
            } else {
                NSLog(@"LAPayor delete Failed!");
            }
            sqlite3_finalize(statement);
        }
        NSString *deleteSQL = [NSString stringWithFormat:@"DELETE FROM Clt_Profile WHERE CustCode=\"%@\"",CustCode];
        if (sqlite3_prepare_v2(contactDB, [deleteSQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Clt_Profile delete!");
            }
            else {
                NSLog(@"Clt_Profile delete Failed!");
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Fail in deleting record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    self.deleteBtn.hidden = YES;
    useExist = NO;
}

-(void)checkingRider
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT RiderCode,SumAssured,RiderTerm,Units FROM Trad_Rider_Details WHERE SINo=\"%@\" AND PTypeCode=\"LA\" AND Seq=\"2\"",requestSINo];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                CheckRiderCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)deleteRider
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" AND PTypeCode=\"LA\" AND Seq=\"2\"",requestSINo];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"rider delete!");
                
            } else {
                NSLog(@"rider delete Failed!");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}
-(void)resetField
{
    nameField.text = @"";
    gNameSecond = @"";
    [sexSegment setSelectedSegmentIndex:UISegmentedControlNoSegment];
    DOBField.text = @"";
    ageField.text = @"";
    OccpField.text = @"";
    OccpLoadField.text = @"";
    CPAField.text = @"";
    PAField.text = @"";
}

-(void)insertClient
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL3 = [NSString stringWithFormat:
                                @"INSERT INTO prospect_profile(\"ProspectName\", \"ProspectDOB\", \"ProspectGender\", \"ProspectOccupationCode\", \"DateCreated\", \"CreatedBy\", \"DateModified\",\"ModifiedBy\", \"Smoker\") "
                                "VALUES (\"%@\", \"%@\", \"%@\", \"%@\", %@, \"%@\", \"%@\", \"%@\", \"%@\")", nameField.text, DOB, sex, occuCode, @"datetime(\"now\", \"+8 hour\")", @"1", @"", @"1", smoker];
        
        if(sqlite3_prepare_v2(contactDB, [insertSQL3 UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                [self GetLastID];
                
            } else {
                NSLog(@"Failed client");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

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
                IndexNo = [lastID intValue];
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
                                    " VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", lastID, contactCode, @"", @"N", @""];
            }
            else if (a==1) {
                insertContactSQL = [NSString stringWithFormat:
                                    @"INSERT INTO contact_input(\"IndexNo\",\"contactCode\", \"ContactNo\", \"Primary\", \"Prefix\") "
                                    " VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", lastID, contactCode, @"", @"N", @""];
            }
            else if (a==2) {
                insertContactSQL = [NSString stringWithFormat:
                                    @"INSERT INTO contact_input(\"IndexNo\",\"contactCode\", \"ContactNo\", \"Primary\", \"Prefix\") "
                                    " VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", lastID, contactCode, @"", @"N", @""];
            }
            else if (a==3) {
                insertContactSQL = [NSString stringWithFormat:
                                    @"INSERT INTO contact_input(\"IndexNo\",\"contactCode\", \"ContactNo\", \"Primary\", \"Prefix\") "
                                    " VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", lastID, contactCode, @"", @"N", @""];
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
    
    statement2 = Nil, statement3 = Nil, lastID = Nil;
    contactCode = Nil;
    dbpath = Nil;
}


#pragma mark - VALIDATION
-(void)deleteSecondLA
{
    if (self.requestSINo) {
        [self checkingRider];
        [self deleteLA];
        if (CheckRiderCode.length != 0) {
            [self deleteRider];
            [_delegate RiderAdded];
        }
        [self resetField];
    }
    else {
        [self resetField];
        
        self.deleteBtn.hidden = YES;
    }
	
}
-(BOOL)validateSave
{
    //    NSLog(@"smoker:%@",smoker);
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789'@/-. "] invertedSet];
    
    if (nameField.text.length <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"2nd Life Assured Name is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
    else if (OccpCode.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Please select an Occupation Description." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
    else if ([nameField.text rangeOfCharacterFromSet:set].location != NSNotFound) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Invalid input format. Input must be alphabet A to Z, space, apostrotrophe('), alias(@), slash(/), dash(-) or dot(.)" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
    else if (smoker.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Smoker is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
    else if (age < 16) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Age must be at least 16 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
    else{
        if (self.requestSINo) {
            if (useExist) {
				
				return YES;
				
            } else {
                if(!saved2ndLA) //only if it has not saved : Edwin 30-10-2013
                {
                    [self saveData];
                }
				
            }
			
        }
        return YES;
    }
	
    return NO;
	/* else {
	 NSString *msg;
	 if (self.requestSINo) {
	 [self checkingExisting2];
	 if (useExist) {
	 msg = @"Confirm changes?";
	 } else {
	 msg = @"Save?";
	 }
	 }
	 else {
	 if (inserted) {
	 msg = @"Confirm changes?";
	 }
	 else {
	 msg = @"Save?";
	 }
	 }
	 
	 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL",nil];
	 [alert setTag:1001];
	 [alert show];
	 }*/
	
}
#pragma mark - STORE 2nd LA BEFORE SAVE INTO DATABASE
-(BOOL)performUpdateData//update second la while looping all section
{
    if([self updateData])
    {
        [self CheckValidRider];
        [_delegate RiderAdded];
        return YES;
    }
    return NO;
}
-(void)storeData
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentdate = [dateFormatter stringFromDate:[NSDate date]];
    if (!siObj) {
        siObj = [[SIObj alloc]init];
    }
    siObj.name = gNameSecond;
    siObj.smoker = smoker;
    siObj.sex = sex;
    siObj.DOB = DOB;
    siObj.age = [NSString stringWithFormat:@"%d",age];
    siObj.ANB = [NSString stringWithFormat:@"%d",ANB];
    siObj.occupationCode = OccpCode;
    siObj.dateModified = currentdate;//currentDate
    siObj.indexNo = [NSString stringWithFormat:@"%d",IndexNo];
    siObj.clientID = [NSString stringWithFormat:@"%d",clientID];
	
}

#pragma mark - memory management
-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.popOverController = nil;
}

- (void)viewDidUnload
{
    [self resignFirstResponder];
    [self setPopOverController:nil];
    [self setProspectList:nil];
    [self setDelegate:nil];
    [self setRequestSINo:nil];
    [self setRequestCommDate:nil];
    [self setGetSINo:nil];
    [self setGetCommDate:nil];
    [self setNameField:nil];
    [self setSexSegment:nil];
    [self setSmokerSegment:nil];
    [self setAgeField:nil];
    [self setOccpLoadField:nil];
    [self setCPAField:nil];
    [self setPAField:nil];
    [self setDOBField:nil];
    [self setOccpField:nil];
    [self setDeleteBtn:nil];
    [self setMyToolBar:nil];
    [self setSex:nil];
    [self setSmoker:nil];
    [self setDOB:nil];
    [self setJobDesc:nil];
    [self setOccpCode:nil];
    [self setSINo:nil];
    [self setCustDate:nil];
    [self setCustCode:nil];
    [self setClientName:nil];
    [self setOccpDesc:nil];
    [self setCheckRiderCode:nil];
    [self setNamePP:nil];
    [self setDOBPP:nil];
    [self setGenderPP:nil];
    [self setOccpCodePP:nil];
    [self setHeaderTitle:nil];
    [super viewDidUnload];
}

@end
