//
//  PayorViewController.m
//  HLA
//
//  Created by shawal sapuan on 7/31/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "PayorViewController.h"
#import "MainScreen.h"
#import "PayorHandler.h"
#import "AppDelegate.h"

@interface PayorViewController ()

@end

NSString *gName = @"";

@implementation PayorViewController
@synthesize nameField;
@synthesize sexSegment;
@synthesize smokerSegment;
@synthesize ageField;
@synthesize occpLoadField;
@synthesize CPAField;
@synthesize PAField;
@synthesize sex,smoker,DOB,jobDesc,age,ANB,OccpCode,occLoading,SINo,CustLastNo,CustDate,CustCode,clientName,clientID,OccpDesc,occCPA_PA, occuCode, occuDesc;
@synthesize popOverController,requestSINo,payorHand;
@synthesize ProspectList = _ProspectList;
@synthesize CheckRiderCode,DOBField,OccpField,IndexNo,requestCommDate;
@synthesize NamePP,DOBPP,GenderPP,OccpCodePP,basicHand,deleteBtn,getCommDate,dataInsert,getSINo;
@synthesize delegate = _delegate;
@synthesize getLAIndexNo,requestLAIndexNo,requestLAAge,getLAAge,occPA,occuClass, RiderToBeDeleted, LAView, Change;
@synthesize LADate = _LADate;
@synthesize btnDOB, btnOccp;

id dobtemp;
- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate ];
	
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
	
    nameField.enabled = NO;
    sexSegment.enabled = NO;
    ageField.enabled = NO;
    occpLoadField.enabled = NO;
    CPAField.enabled = NO;
    PAField.enabled = NO;
    DOBField.enabled = NO;
    OccpField.enabled = NO;
    self.deleteBtn.hidden = YES;
    useExist = NO;
    inserted = NO;
    
    
    [nameField setDelegate:self];
    [ageField setDelegate:self];
    [occpLoadField setDelegate:self];
    [CPAField setDelegate:self];
    [PAField setDelegate:self];
    [DOBField setDelegate:self];
    [OccpField setDelegate:self];
	
    
    [deleteBtn setBackgroundImage:[[UIImage imageNamed:@"iphone_delete_button.png"] stretchableImageWithLeftCapWidth:8.0f topCapHeight:0.0f] forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    deleteBtn.titleLabel.shadowColor = [UIColor lightGrayColor];
    deleteBtn.titleLabel.shadowOffset = CGSizeMake(0, -1);
	
    [self loadData];
}
-(void)loadData
{
    getLAIndexNo = requestLAIndexNo;
    getLAAge = requestLAAge;
    getCommDate = [self.requestCommDate description];
    getSINo = [self.requestSINo description];
    NSLog(@"Payor-SINo:%@, CommDate:%@",getSINo,getCommDate);
    
    if (self.requestSINo) {
        [self checkingExisting];
        if (SINo.length != 0) {
            [self getProspectData];
            [self getSavedField];
            self.deleteBtn.hidden = NO;
        }
    }
	
	
}
-(BOOL)isPayorSelected
{
    if([nameField.text isEqualToString:@""])
    {
        return NO;
		
    }
    return YES;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    /*
	 self.headerTitle.frame = CGRectMake(344, -20, 111, 44);
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
		gName = clientName;
        DOBField.text = [[NSString alloc] initWithFormat:@"%@",DOB];
        ageField.text = [[NSString alloc] initWithFormat:@"%d",age];
		
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
        
        [self getOccLoadExist];
        OccpField.text = [[NSString alloc] initWithFormat:@"%@",OccpDesc];
        occpLoadField.text = [NSString stringWithFormat:@"%@",occLoading];
		
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
        
        [_delegate PayorIndexNo:IndexNo andSmoker:smoker andSex:sex andDOB:DOB andAge:age andOccpCode:OccpCode];
        AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
        zzz.SICompleted = YES;
        Change = @"no";
    }
    else {
		
        nameField.text = NamePP;
		gName = NamePP;
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
        occpLoadField.text = [NSString stringWithFormat:@"%@",occLoading];
		
        if (occCPA_PA == 0) {
            CPAField.text = @"D";
        } else {
            CPAField.text = [NSString stringWithFormat:@"%d",occCPA_PA];
        }
        
        if (occCPA_PA == 0) {
            PAField.text = @"D";
        } else {
            PAField.text = [NSString stringWithFormat:@"%d",occPA];
        }
        
		if ([LAView isEqualToString:@"1"] ) {
			[self updatePayor];
			[self CheckValidRider];
			Change = @"yes";
			[_delegate RiderAdded];
			
		}
		else{
			
			//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"There are changes in Prospect's information. Are you sure want to apply changes to this SI?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Prospect's information will synchronize to this SI." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert setTag:2003];
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

-(IBAction)btnDOBPressed:(id)sender
{
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

-(IBAction)btnOccpPressed:(id)sender
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
    
    [self.OccupationListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(IBAction)enableFields:(id)sender
{
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
    occpLoadField.text = @"";
    CPAField.text = @"";
    PAField.text = @"";
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

- (IBAction)doSave:(id)sender
{
    NSLog(@"do save for payor");
    [_delegate saveAll];
}

- (IBAction)doDelete:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:[NSString stringWithFormat:@"Delete Payor:%@?",nameField.text] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL",nil];
    [alert setTag:2002];
    [alert show];
}
-(void) resetField
{
    nameField.text = @"";
    gName = @"";
    [sexSegment setSelectedSegmentIndex:UISegmentedControlNoSegment];
    DOBField.text = @"";
    ageField.text = @"";
    OccpField.text= @"";
    occpLoadField.text = @"";
    CPAField.text = @"";
    PAField.text = @"";
	
}
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==2001 && buttonIndex == 0) //save
    {
        if (self.requestSINo) {
            if (useExist) {
				[self updatePayor];
				[self CheckValidRider];
				
            } else {
				[self savePayor];
            }
        }
        else {
            [self savePayorHandler];
        }
    }
    else if (alertView.tag == 2002 && buttonIndex == 0) //delete
    {
        NSLog(@"delete 1");
        if (self.requestSINo) {
            [self checkingRider];
            [self deletePayor];
            if (CheckRiderCode.length != 0) {
                [self deleteRider];
                [_delegate RiderAdded];
            }
            [self resetField];
        }
        else {
            [self resetField];
            [_delegate PayorDeleted];
			
            self.deleteBtn.hidden = YES;
        }
    }
    else if (alertView.tag==2003 && buttonIndex == 0) {
        
        if (smoker.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Smoker is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
        } else {
            [self updatePayor];
        }
    }
    else if (alertView.tag==2004 && buttonIndex == 0) {
		//        [self closeScreen];
    }
}

-(void)calculateAge
{
    /*
	 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	 [dateFormatter setDateFormat:@"yyyy"];
	 NSString *currentYear = [dateFormatter stringFromDate:[NSDate date]];
	 [dateFormatter setDateFormat:@"MM"];
	 NSString *currentMonth = [dateFormatter stringFromDate:[NSDate date]];
	 [dateFormatter setDateFormat:@"dd"];
	 NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]]; */
    
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
    if (sex != NULL) {
        sex = nil;
        smoker = nil;
    }
    IndexNo = [aaIndex intValue];
    smoker = @"N";
    
    DOBField.text = [[NSString alloc] initWithFormat:@"%@",aaDOB];
    DOB = aaDOB;
    
    [self calculateAge];
    
    if (getLAIndexNo == [aaIndex intValue]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"This Payor has already been attached to the plan." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
        if (age > 100) {//added by Edwin 8-10-2013
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Age must be less than or equal to 100 for this product." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
        }
		else {
			
			[_delegate payorSaved:NO];
			nameField.text = aaName;
			gName = aaName;
			sex = aaGender;
			
			if ([sex isEqualToString:@"M"]) {
				sexSegment.selectedSegmentIndex = 0;
			} else {
				sexSegment.selectedSegmentIndex = 1;
			}
			NSLog(@"sex:%@",sex);
			
			//        [smokerSegment setSelectedSegmentIndex:UISegmentedControlNoSegment];
			
			
			ageField.text = [[NSString alloc] initWithFormat:@"%d",age];
			
			OccpCode = aaCode;
			[self getOccLoadExist];
			OccpField.text = [[NSString alloc] initWithFormat:@"%@",OccpDesc];
			occpLoadField.text = [NSString stringWithFormat:@"%@",occLoading];
			
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
    
    [popOverController dismissPopoverAnimated:YES];
}

-(void)OccupClassSelected:(NSString *)OccupClass{
	
}

-(void)OccupCodeSelected:(NSString *)OccupCode{
	occuCode = OccupCode;
    OccpCode = OccupCode;
    
    [self getOccLoadExist];
    occpLoadField.text = [NSString stringWithFormat:@"%@",occLoading];
    
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
                if( sqlite3_column_text(statement, 1) != NULL )
                {
					CustDate = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                }
                
                NSLog(@"LastCustNo:%d CustDate:%@",CustLastNo,CustDate);
                
            } else {
                NSLog(@"error check tbl_Adm_TrnTypeNo");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)savePayor
{
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
    CustCode = [[NSString alloc] initWithFormat:@"CL%@-%@",currentdate,fooCust];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO Trad_LAPayor (SINo, CustCode,PTypeCode,Sequence,DateCreated,CreatedBy) VALUES (\"%@\",\"%@\",\"PY\",\"1\",\"%@\",\"hla\")",getSINo, CustCode,dateStr];
		//        NSLog(@"%@",insertSQL);
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
		//        NSLog(@"%@",insertSQL2);
        if(sqlite3_prepare_v2(contactDB, [insertSQL2 UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Done LA2");
                [self updateRunCustCode];
                [_delegate PayorIndexNo:IndexNo andSmoker:smoker andSex:sex andDOB:DOB andAge:age andOccpCode:OccpCode];
                [_delegate payorSaved:YES];
                self.deleteBtn.hidden = NO;
                
                AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
                zzz.ExistPayor = YES;
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
}

-(void)savePayorHandler
{
    [_delegate PayorIndexNo:IndexNo andSmoker:smoker andSex:sex andDOB:DOB andAge:age andOccpCode:OccpCode];
    AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    zzz.SICompleted = NO;
    self.deleteBtn.hidden = NO;
    inserted = YES;
    [_delegate payorSaved:YES];
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
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT a.SINo, a.CustCode, b.Name, b.Smoker, b.Sex, b.DOB, b.ALB, b.OccpCode, b.id, b.IndexNo FROM Trad_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode WHERE a.SINo=\"%@\" AND a.PTypeCode=\"PY\" AND a.Sequence=1",getSINo];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
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
                NSLog(@"error checkingExisting");
                useExist = NO;
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
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    NSString *tempSINo;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT a.SINo, b.id FROM Trad_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode WHERE a.SINo=\"%@\" AND a.PTypeCode=\"PY\" AND a.Sequence=1",[self.requestSINo description]];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                tempSINo = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                clientID = sqlite3_column_int(statement, 1);
                
            } else {
                NSLog(@"error access checkingExisting2");
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
		//        NSLog(@"%@",querySQL);
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

-(BOOL)updatePayor
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *currentdate = [dateFormatter stringFromDate:[NSDate date]];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
		
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE Clt_Profile SET Name=\"%@\", Smoker=\"%@\", Sex=\"%@\", DOB=\"%@\", ALB=\"%d\", ANB=\"%d\", OccpCode=\"%@\", DateModified=\"%@\", ModifiedBy=\"hla\", indexNo=\"%d\" WHERE id=\"%d\"",
							  nameField.text,smoker,sex,DOB,age,ANB,OccpCode,currentdate,IndexNo,clientID];
		
        [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
		
        NSString *updateSQL = [NSString stringWithFormat:
                               @"UPDATE Trad_LAPayor SET (SINo, CustCode,PTypeCode,Sequence,DateCreated,CreatedBy) VALUES (\"%@\",\"%@\",\"LA\",\"1\",\"%@\",\"hla\")",getSINo, CustCode,dateStr];
        NSLog(@"%@",querySQL);//CL20130904-0002
		/*	NSString *querySQL = [NSString stringWithFormat:@"UPDATE Clt_Profile SET Name=\"%@\", Smoker=\"%@\", Sex=\"%@\", DOB=\"%@\", ALB=\"%d\", ANB=\"%d\", OccpCode=\"%@\", DateModified=\"%@\", ModifiedBy=\"hla\", indexNo=\"%d\" WHERE id=\"%d\"",
		 gName ,smoker,sex,DOB,age,ANB,OccpCode,currentdate,IndexNo,clientID];
		 */
		//        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"SI update!");
                [_delegate PayorIndexNo:IndexNo andSmoker:smoker andSex:sex andDOB:DOB andAge:age andOccpCode:OccpCode];
                [_delegate payorSaved:YES];
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

-(void)deletePayor
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
                IndexNo = 0;
                
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
                [_delegate PayorDeleted];
                [self resetField];
				
                CustCode = nil;
                
                if (getLAAge < 10) {
                    AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
                    zzz.ExistPayor = NO;
                }
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

-(void)CheckValidRider
{
    RiderToBeDeleted = [[NSMutableArray alloc] init ];
	
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"Select RiderTerm From trad_Rider_Details where SINO = \"%@\" AND RiderCode in ('PTR') ", SINo];
		//        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {	int SQLTerm = 0;
				SQLTerm	= [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] intValue ];
				
				if(SQLTerm + age > 60){
					
					[RiderToBeDeleted addObject:@"PTR" ];
				}
            }
            else {
				
            }
            sqlite3_finalize(statement);
        }
		
		querySQL = [NSString stringWithFormat:@"Select RiderTerm From trad_Rider_Details where SINO = \"%@\" AND RiderCode in ('PLCP') ", SINo];
		//        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {	int SQLTerm = 0;
				SQLTerm	= [[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)] intValue ];
				
				if(SQLTerm + age > 60){
					[RiderToBeDeleted addObject:@"PLCP" ];
				}
            }
            else {
                
            }
            sqlite3_finalize(statement);
        }
		
		NSString *temp;
		
		if ([OccpCode isEqualToString:@"OCC01975"]) {
			NSString *querySQL = [NSString stringWithFormat:@"Select Ridercode From trad_Rider_Details where SINO = \"%@\" AND RiderCode in ('LCWP', 'PR', 'PTR', 'PLCP') ", SINo];
			//        NSLog(@"%@",querySQL);
			if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{
				while (sqlite3_step(statement) == SQLITE_ROW)
				{
					temp =[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
					[RiderToBeDeleted addObject:temp];
				}
				
				sqlite3_finalize(statement);
			}
			
		}
		
		temp = Nil;
		
		if (RiderToBeDeleted.count > 0) {
			
			for (int i=0; i < RiderToBeDeleted.count; i++) {
				querySQL = [NSString stringWithFormat:@"DELETE From trad_Rider_Details where SINO = \"%@\" AND RiderCode = \"%@\" ", SINo, [RiderToBeDeleted objectAtIndex:i]];
				//        NSLog(@"%@",querySQL);
				if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
				{
					if (sqlite3_step(statement) == SQLITE_DONE)
					{
						
					}
					
					sqlite3_finalize(statement);
				}
			}
			
			[_delegate RiderAdded];
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Rider(s) has been deleted due to business rule."
														   delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
			[alert show];
			
		}
		
        sqlite3_close(contactDB);
    }
}


-(void)checkingRider
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT RiderCode,SumAssured,RiderTerm,Units FROM Trad_Rider_Details WHERE SINo=\"%@\" AND PTypeCode=\"PY\" AND Seq=\"1\"",getSINo];
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
        NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" AND PTypeCode=\"PY\" AND Seq=\"1\"",getSINo];
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

-(void)insertClient
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL3 = [NSString stringWithFormat:
                                @"INSERT INTO prospect_profile(\"ProspectName\", \"ProspectDOB\", \"ProspectGender\", \"ProspectOccupationCode\", \"DateCreated\", \"CreatedBy\", \"DateModified\",\"ModifiedBy\", \"Smoker\", 'QQFlag') "
                                "VALUES (\"%@\", \"%@\", \"%@\", \"%@\", %@, \"%@\", \"%@\", \"%@\", \"%@\", '%@')", nameField.text, DOB, sex, occuCode, @"datetime(\"now\", \"+8 hour\")", @"1", @"", @"1", smoker, @"true"];
        
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
-(BOOL)performSavePayor
{
	/* if([self updatePayor])
	 {
	 [self CheckValidRider];
	 return YES;
	 }*/
    NSLog(@"%@",clientName);
    if([clientName isEqualToString: @""])
    {
        [self savePayor];
		
    }
    else{
        if (CustCode) {
            [self updatePayor];
        }
        else{
            [self savePayor];
        }
    }
    return YES;
}
-(BOOL)validateSave
{
    //    NSLog(@"smoker:%@",smoker);
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789'@/-. "] invertedSet];
    
    if (nameField.text.length <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Payor Name is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
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
    else {
        return YES;
		// [self updatePayor];
		// [self CheckValidRider];
		
		/*  NSString *msg;
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
		 [alert setTag:2001];
		 [alert show];*/
    }
    return NO;
}
#pragma mark - STORE PAYOR BEFORE SAVE INTO DATABASE
-(void)storeData
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *currentdate = [dateFormatter stringFromDate:[NSDate date]];
    if (!payorSIObj) {
        payorSIObj = [[SIObj alloc]init];
    }
    payorSIObj.name = gName;
    payorSIObj.smoker = smoker;
    payorSIObj.sex = sex;
    payorSIObj.DOB = DOB;
    payorSIObj.age = [NSString stringWithFormat:@"%d",age];
    payorSIObj.ANB = [NSString stringWithFormat:@"%d",ANB];
    payorSIObj.occupationCode = OccpCode;
    payorSIObj.dateModified = currentdate;//currentDate
    payorSIObj.indexNo = [NSString stringWithFormat:@"%d",IndexNo];
    payorSIObj.clientID = [NSString stringWithFormat:@"%d",clientID];
	
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
    [self setDOBField:nil];
    [self setAgeField:nil];
    [self setOccpField:nil];
    [self setOccpLoadField:nil];
    [self setCPAField:nil];
    [self setPAField:nil];
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
