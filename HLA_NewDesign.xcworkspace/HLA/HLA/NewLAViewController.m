//
//  NewLAViewController.m
//  HLA
//
//  Created by shawal sapuan on 7/30/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "NewLAViewController.h"
#import "PayorViewController.h"
#import "SecondLAViewController.h"
#import "BasicPlanViewController.h"
#import "RiderViewController.h"

#import "AppDelegate.h"
#import "SIMenuViewController.h"
#import "MainScreen.h"
#import "ColorHexCode.h"
#import "MaineApp.h"
#import "eAppMenu.h"

@interface NewLAViewController ()

@end

@implementation NewLAViewController
@synthesize myScrollView;
@synthesize LANameField;
@synthesize sexSegment;
@synthesize smokerSegment;
@synthesize LAAgeField;
@synthesize LAOccLoadingField;
@synthesize LACPAField;
@synthesize LAPAField,btnToEAPP,OutletSpace;
@synthesize btnCommDate,btnEnabled,btnProspect;
@synthesize statusLabel,EAPPorSI;
@synthesize sex,smoker,age,ANB,DOB,jobDesc,SINo,CustCode;
@synthesize occDesc,occCode,occLoading,payorSINo,occCPA_PA;
@synthesize popOverController,requestSINo,clientName,occuCode,occuDesc,CustCode2,payorCustCode;
@synthesize dataInsert,commDate,occuClass,IndexNo,laBH;
@synthesize ProspectList=_ProspectList;
@synthesize NamePP,DOBPP,GenderPP,OccpCodePP,occPA,headerTitle;
@synthesize getSINo,dataInsert2,btnDOB,btnOccp;
@synthesize getHL,getHLTerm,getPolicyTerm,getSumAssured,getTempHL,getTempHLTerm,MOP,cashDividend,advanceYearlyIncome,yearlyIncome;
@synthesize termCover,planCode,arrExistRiderCode,arrExistPlanChoice;
@synthesize prospectPopover = _prospectPopover;
@synthesize idPayor,idProfile,idProfile2,lastIdPayor,lastIdProfile,planChoose,ridCode,atcRidCode,atcPlanChoice;
@synthesize delegate = _delegate;
@synthesize basicSINo,requestCommDate,requestIndexNo,requestLastIDPay,requestLastIDProf,requestSex,requestSmoker, strPA_CPA,payorAge;
@synthesize LADate = _LADate;
@synthesize datePopover = _datePopover;
@synthesize dobPopover = _dobPopover;
@synthesize OccupationList = _OccupationList;
@synthesize OccupationListPopover = _OccupationListPopover;
@synthesize siObj;

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
	
    LANameField.enabled = NO;
    sexSegment.enabled = NO;
    LAAgeField.enabled = NO;
    LAOccLoadingField.enabled = NO;
    LACPAField.enabled = NO;
    LAPAField.enabled = NO;
    btnOccp.enabled = NO;
    btnDOB.enabled = NO;
    useExist = NO;
    AgeChanged = NO;
    JobChanged = NO;
    isNewClient = NO;
    self.btnOccp.titleLabel.textColor = [UIColor darkGrayColor];
    [LANameField setDelegate:self];
    [LAAgeField setDelegate:self];
    [LAOccLoadingField setDelegate:self];
    [LACPAField setDelegate:self];
    [LAPAField setDelegate:self];
    
    smoker = @"N"; //default as NO
    
    getSINo = [self.requestSINo description];
	
    NSLog(@"LA-SINo: %@",getSINo);
    
    if (getSINo.length != 0) {
        appDelegate.isSIExist = YES;
		
        [self checkingExisting];
        [self checkingExistingSI];
        
        if (basicSINo.length != 0) {
            [self getExistingBasic];
            [self getTerm];
            [self toogleExistingBasic];
        }
        
        if (SINo.length != 0) {
            [self getProspectData];
            [self getSavedField];
            NSLog(@"will use existing data");
        }
		
		if(age < 17){
			smokerSegment.enabled = FALSE;
		}
    }
    else {
        NSLog(@"SINo not exist!");
        appDelegate.isSIExist = NO;
    }
    
    if (requestIndexNo != 0) {
        [self tempView];
    }
	
	
	
	[self checking2ndLA];
	
	if (CustCode2.length != 0) {
		SecondLAViewController *ccc = [[SecondLAViewController alloc] init ];
		ccc.requestLAIndexNo = requestIndexNo;
		ccc.requestCommDate = commDate;
		ccc.requestSINo = getSINo;
		ccc.LAView = @"1";
		ccc.delegate = (SIMenuViewController *)_delegate;
		
		UIView *iii = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) ];
		[iii addSubview:ccc.view];
		
		if ([ccc.Change isEqualToString:@"yes"]) {
			NSLog(@"prospect info sync into second life assured");
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Prospect's information(2nd life Assured) will synchronize to this SI."
														   delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert show];
		}
		
		ccc.Change = @"No";
		ccc = Nil;
		iii = Nil;
	}
	
	[self checkingPayor];
	
	if (payorSINo.length != 0) {
		PayorViewController *ggg = [[PayorViewController alloc] init ];
		ggg.requestLAIndexNo = requestIndexNo;
		ggg.requestLAAge = payorAge;
		ggg.requestCommDate = commDate;
		ggg.requestSINo = getSINo;
		ggg.LAView = @"1";
		ggg.delegate = (SIMenuViewController *)_delegate;
		
		UIView *iii = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) ];
		[iii addSubview:ggg.view];
		
		if ([ggg.Change isEqualToString:@"yes"]) {
			NSLog(@"prospect info sync into payor");
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Prospect's information(Payor) will synchronize to this SI."
														   delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert show];
		}
		
		ggg.Change = @"no";
		ggg = Nil;
		iii = Nil;
	}
    
    btnToEAPP.width = 0.01;
    OutletSpace.width = 666;
    if ([[self.EAPPorSI description] isEqualToString:@"eAPP"]) {
		
        btnProspect.hidden = YES;
        //btnEnabled.hidden = YES;
        btnToEAPP.width = 0;
        OutletSpace.width = 564;
        
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    /*
	 self.headerTitle.frame = CGRectMake(306, -20, 156, 44);
	 self.myToolBar.frame = CGRectMake(0, 0, 768, 44);
	 self.view.frame = CGRectMake(0, 20, 768, 1004); */
    
    self.view.frame = CGRectMake(0, 0, 788, 1004);
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
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

#pragma mark - Handle KeyboardShow

-(void)keyboardDidShow:(NSNotificationCenter *)notification
{
    self.myScrollView.frame = CGRectMake(0, 44, 768, 960-264);
    self.myScrollView.contentSize = CGSizeMake(768, 960);
    
    CGRect textFieldRect = [activeField frame];
    textFieldRect.origin.y += 10;
    [self.myScrollView scrollRectToVisible:textFieldRect animated:YES];
    
}

-(void)keyboardDidHide:(NSNotificationCenter *)notification
{
    self.myScrollView.frame = CGRectMake(0, 44, 768, 960);
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    activeField = textField;
    
    [activeField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	
    return YES;
    Saved = NO;
}
-(void)textFieldDidChange:(UITextField*)textField
{
    appDelegate.isNeedPromptSaveMsg = YES;
}
#pragma mark - ToogleView

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
        AgeChanged = YES;
    }
    
    if (![occuCode isEqualToString:OccpCodePP]) {
        valid = FALSE;
        JobChanged = YES;
    }
    
    if (valid) {
        
        LANameField.text = clientName;
        [btnDOB setTitle:DOB forState:UIControlStateNormal];
        LAAgeField.text = [[NSString alloc] initWithFormat:@"%d",age];
        [self.btnCommDate setTitle:commDate forState:UIControlStateNormal];
        
        if ([sex isEqualToString:@"MALE"]) {
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
        [btnOccp setTitle:occuDesc forState:UIControlStateNormal];
        LAOccLoadingField.text = [NSString stringWithFormat:@"%@",occLoading];
        
        if (occCPA_PA == 0) {
            LACPAField.text = @"D";
        } else {
            LACPAField.text = [NSString stringWithFormat:@"%d",occCPA_PA];
        }
        
        if (occPA == 0) {
            LAPAField.text = @"D";
        } else {
            LAPAField.text = [NSString stringWithFormat:@"%d",occPA];
        }
        
        [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode andOccpClass:occuClass andSex:sex andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker];
    }
    else {
        
        LANameField.text = NamePP;
        sex = GenderPP;
        
        if ([GenderPP isEqualToString:@"MALE"]) {
            sexSegment.selectedSegmentIndex = 0;
        } else {
            sexSegment.selectedSegmentIndex = 1;
        }
        NSLog(@"sex:%@",GenderPP);
        
        if ([smoker isEqualToString:@"Y"]) {
            smokerSegment.selectedSegmentIndex = 0;
        } else if ([smoker isEqualToString:@"N"]) {
            smokerSegment.selectedSegmentIndex = 1;
        }
        NSLog(@"smoker:%@",smoker);
        
        DOB = DOBPP;
        [self calculateAge];
		
        [btnDOB setTitle:DOB forState:UIControlStateNormal];
        LAAgeField.text = [[NSString alloc] initWithFormat:@"%d",age];
        [btnCommDate setTitle:commDate forState:UIControlStateNormal];
        
        occuCode = OccpCodePP;
        [self getOccLoadExist];
        [btnOccp setTitle:occuDesc forState:UIControlStateNormal];
        LAOccLoadingField.text = [NSString stringWithFormat:@"%@",occLoading];
        
        if (occCPA_PA == 0) {
            LACPAField.text = @"D";
        } else {
            LACPAField.text = [NSString stringWithFormat:@"%d",occCPA_PA];
        }
        
        if (occPA == 0) {
            LAPAField.text = @"D";
        } else {
            LAPAField.text = [NSString stringWithFormat:@"%d",occPA];
        }
		
        [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode andOccpClass:occuClass andSex:sex andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker];
        
        if (age > 63) { //change to 63 ; by Edwin 8-10-2013
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Age Last Birthday must be less than or equal to 63 for this product." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
        }
        else {
			
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Prospect's information will synchronize to this SI." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert setTag:1004];
            [alert show];
        }
    }
    
    if (age < 10) {
        [self checkingPayor];
        if (payorSINo.length == 0) {
            
            AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
            zzz.ExistPayor = NO;
        }
    }
}

-(void)toogleExistingBasic
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    NSString *sumAss = [formatter stringFromNumber:[NSNumber numberWithDouble:getSumAssured]];
    sumAss = [sumAss stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE Trad_Details SET PolicyTerm=\"%d\", UpdatedAt=%@ WHERE SINo=\"%@\"",termCover,  @"datetime(\"now\", \"+8 hour\")", getSINo];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"termCover update!");
            }
            else {
                NSLog(@"termCover update Failed!");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    [self getPlanCodePenta];
    
    [_delegate BasicSI:getSINo andAge:age andOccpCode:occuCode andCovered:termCover andBasicSA:sumAss andBasicHL:getHL andBasicTempHL:getTempHL andMOP:MOP andPlanCode:planCode andAdvance:advanceYearlyIncome andBasicPlan:planChoose];
    AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    zzz.SICompleted = YES;
}

-(void)tempView
{
    IndexNo = requestIndexNo;
    lastIdPayor = requestLastIDPay;
    lastIdProfile = requestLastIDProf;
    [self getProspectData];
    
    LANameField.text = NamePP;
    DOB = DOBPP;
    commDate = [self.requestCommDate description];
    [self calculateAge];
    [btnDOB setTitle:DOBPP forState:UIControlStateNormal];
    LAAgeField.text = [[NSString alloc] initWithFormat:@"%d",age];
    [self.btnCommDate setTitle:commDate forState:UIControlStateNormal];
    
    sex = [self.requestSex description];
    if ([sex isEqualToString:@"MALE"]) {
        sexSegment.selectedSegmentIndex = 0;
    } else {
        sexSegment.selectedSegmentIndex = 1;
    }
    NSLog(@"sex:%@",sex);
    
    smoker = [self.requestSmoker description];
    if ([smoker isEqualToString:@"Y"]) {
        smokerSegment.selectedSegmentIndex = 0;
    } else {
        smokerSegment.selectedSegmentIndex = 1;
    }
    NSLog(@"smoker:%@",smoker);
    
    occuCode = OccpCodePP;
    [self getOccLoadExist];
    [btnOccp setTitle:occuDesc forState:UIControlStateNormal];
    LAOccLoadingField.text = [NSString stringWithFormat:@"%@",occLoading];
    
    if (occCPA_PA == 0) {
        LACPAField.text = @"D";
    } else {
        LACPAField.text = [NSString stringWithFormat:@"%d",occCPA_PA];
    }
    
    if (occPA == 0) {
        LAPAField.text = @"D";
    } else {
        LAPAField.text = [NSString stringWithFormat:@"%d",occPA];
    }
    [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode andOccpClass:occuClass andSex:sex andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker];
    Inserted = YES;
}

#pragma mark - Action

- (IBAction)ActionEAPP:(id)sender
{
    /*
	 UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:Nil];
	 MaineApp *main = [secondStoryboard instantiateViewControllerWithIdentifier:@"maineApp"];
	 main.IndexTab = 1;
	 main.getMenu = @"MENU";
	 main.getSI = getSINo;
	 [self presentViewController:main animated:NO completion:nil];
	 main = Nil, secondStoryboard = nil; */
   
    /*
    UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
    eAppMenu *zzz = [nextStoryboard instantiateViewControllerWithIdentifier:@"eAppMenuScreen"];
    NSLog(@"ActionEAPP START LA-SINo: %@",getSINo);

    zzz.getSI = getSINo;
    zzz.modalPresentationStyle = UIModalPresentationFullScreen;
    zzz.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:zzz animated:YES];
     NSLog(@"ActionEAPP end");
    */
    
    
   // UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
   // eAppMenu *zzz = [nextStoryboard instantiateViewControllerWithIdentifier:@"eAppMenuScreen"];
    self.modalTransitionStyle = UIModalPresentationFormSheet;
    [self dismissViewControllerAnimated:TRUE completion:Nil];
    

    
    
}

- (IBAction)sexSegmentPressed:(id)sender
{
    if ([sexSegment selectedSegmentIndex]==0) {
        sex = @"MALE";
    }
    else if (sexSegment.selectedSegmentIndex == 1){
        sex = @"FEMALE";
    }
    appDelegate.isNeedPromptSaveMsg = YES;
}

- (IBAction)smokerSegmentPressed:(id)sender
{
    if ([smokerSegment selectedSegmentIndex]==0) {
        smoker = @"Y";
    }
    else if (smokerSegment.selectedSegmentIndex == 1){
        smoker = @"N";
    }
    appDelegate.isNeedPromptSaveMsg = YES;
	
}

- (IBAction)doSaveLA:(id)sender
{
    //[self validateSave];
	//  [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode andOccpClass:occuClass andSex:sex andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker];
	
    [_delegate saveAll];
}

- (IBAction)selectProspect:(id)sender
{
    LANameField.enabled = NO;
    LANameField.backgroundColor = [UIColor lightGrayColor];
    LANameField.textColor = [UIColor darkGrayColor];
    
    sexSegment.enabled = NO;
    
    btnDOB.enabled = NO;
    self.btnDOB.titleLabel.textColor = [UIColor darkGrayColor];
    
    btnOccp.enabled = NO;
    self.btnOccp.titleLabel.textColor = [UIColor darkGrayColor];
    
    isNewClient = NO;
    
    if (_ProspectList == nil) {
        self.ProspectList = [[ListingTbViewController alloc] initWithStyle:UITableViewStylePlain];
        _ProspectList.delegate = self;
        self.prospectPopover = [[UIPopoverController alloc] initWithContentViewController:_ProspectList];
    }
    
    [self.prospectPopover presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
}

- (IBAction)enableFields:(id)sender
{
    /*
	 LANameField.enabled = YES;
	 LANameField.backgroundColor = [UIColor whiteColor];
	 LANameField.textColor = [UIColor blackColor];
	 sexSegment.enabled = YES;
	 
	 btnDOB.enabled = YES;
	 self.btnDOB.titleLabel.textColor = [UIColor blackColor];
	 
	 btnOccp.enabled = YES;
	 self.btnOccp.titleLabel.textColor = [UIColor blackColor];
	 */
    
    if (isNewClient) {
        
        LANameField.enabled = NO;
        LANameField.backgroundColor = [UIColor lightGrayColor];
        LANameField.textColor = [UIColor darkGrayColor];
        sexSegment.enabled = NO;
        
        btnDOB.enabled = NO;
        self.btnDOB.titleLabel.textColor = [UIColor darkGrayColor];
        
        btnOccp.enabled = NO;
        self.btnOccp.titleLabel.textColor = [UIColor darkGrayColor];
        
        isNewClient = NO;
    }
    else {
        
        LANameField.enabled = YES;
        LANameField.backgroundColor = [UIColor whiteColor];
        LANameField.textColor = [UIColor blackColor];
        sexSegment.enabled = YES;
        
        btnDOB.enabled = YES;
        self.btnDOB.titleLabel.textColor = [UIColor blackColor];
        
        btnOccp.enabled = YES;
        self.btnOccp.titleLabel.textColor = [UIColor blackColor];
        
        isNewClient = YES;
    }
    
    LANameField.text = @"";
    sexSegment.selectedSegmentIndex = UISegmentedControlNoSegment;
    smokerSegment.selectedSegmentIndex = UISegmentedControlNoSegment;
    btnDOB.titleLabel.text = @"";
    LAAgeField.text = @"";
    btnCommDate.titleLabel.text = @"";
    btnOccp.titleLabel.text = @"";
    LAOccLoadingField.text = @"";
    LACPAField.text = @"";
    LAPAField.text = @"";
    
}

- (IBAction)btnDOBPressed:(id)sender
{
    date1 = YES;
    date2 = NO;
    
    if (DOB.length==0 || btnDOB.titleLabel.text.length == 0) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
        
        [self.btnDOB setTitle:dateString forState:UIControlStateNormal];
        dobtemp = btnDOB.titleLabel.text;
        NSLog(@"here!, %@",dateString);
    }
    else {
        dobtemp = btnDOB.titleLabel.text;
    }
    
    self.LADate = [self.storyboard instantiateViewControllerWithIdentifier:@"showDate"];
    _LADate.delegate = self;
    _LADate.msgDate = dobtemp;
    _LADate.btnSender = 1;
    self.dobPopover = [[UIPopoverController alloc] initWithContentViewController:_LADate];
    
    [self.dobPopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.dobPopover presentPopoverFromRect:[sender frame]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    appDelegate.isNeedPromptSaveMsg = YES;
	
}

- (IBAction)btnCommDatePressed:(id)sender
{
    date1 = NO;
    date2 = YES;
    
    if (commDate.length==0) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
        
        [btnCommDate setTitle:dateString forState:UIControlStateNormal];
        temp = btnCommDate.titleLabel.text;
    }
    else {
        temp = btnCommDate.titleLabel.text;
    }
	
    self.LADate = [self.storyboard instantiateViewControllerWithIdentifier:@"showDate"];
    _LADate.delegate = self;
    _LADate.msgDate = temp;
    _LADate.btnSender = 3;
    self.datePopover = [[UIPopoverController alloc] initWithContentViewController:_LADate];
    
    [self.datePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.datePopover presentPopoverFromRect:[sender frame]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    appDelegate.isNeedPromptSaveMsg = YES;
	
}

- (IBAction)btnOccpPressed:(id)sender
{
    if (_OccupationList == nil) {
        self.OccupationList = [[OccupationList alloc] initWithStyle:UITableViewStylePlain];
        _OccupationList.delegate = self;
        self.OccupationListPopover = [[UIPopoverController alloc] initWithContentViewController:_OccupationList];
    }
    
    [self.OccupationListPopover presentPopoverFromRect:[sender frame]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    appDelegate.isNeedPromptSaveMsg = YES;
	
}
-(void)calculateAge
{
    AgeLess = NO;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    /*
     [dateFormatter setDateFormat:@"yyyy"];
     NSString *currentYear = [dateFormatter stringFromDate:[NSDate date]];
     [dateFormatter setDateFormat:@"MM"];
     NSString *currentMonth = [dateFormatter stringFromDate:[NSDate date]];
     [dateFormatter setDateFormat:@"dd"];
     NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];
     */
    
    //    NSString *birthYear = [DOB substringFromIndex:[DOB length]-4];
    //    NSString *birthMonth = [DOB substringWithRange:NSMakeRange(3, 2)];
    //    NSString *birthDay = [DOB substringWithRange:NSMakeRange(0, 2)];
    //12/12/2012
    
    NSArray *curr = [commDate componentsSeparatedByString: @"/"];
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
        } else if (monthN == monthB && dayN == dayB) { //edited by heng
            newALB = ALB ;  //edited by heng
        } else {
            newALB = ALB;
            
        }
        
        if (monthN > monthB) {
            newANB = ALB + 1;
        } else if (monthN == monthB && dayN > dayB) {
            newANB = ALB + 1;
        } else if (monthN == monthB && dayN == dayB) { // edited by heng
            newANB = ALB; //edited by heng
        } else {
            newANB = ALB;
        }
        msgAge = [[NSString alloc] initWithFormat:@"%d",newALB];
        age = newALB;
        ANB = newANB;
    }
    else if (yearN == yearB)
    {
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        NSString *selectDate = DOB;
        NSDate *startDate = [dateFormatter dateFromString:selectDate];
        
        NSString *todayDate = [dateFormatter stringFromDate:[NSDate date]];
        NSDate *endDate = [dateFormatter dateFromString:todayDate];
        
        unsigned flags = NSDayCalendarUnit;
        NSDateComponents *difference = [[NSCalendar currentCalendar] components:flags fromDate:startDate toDate:endDate options:0];
        int diffDays = [difference day];
        if (diffDays < 30) {
            AgeLess = YES;
        }
        msgAge = [[NSString alloc] initWithFormat:@"%d days",diffDays];
        //        NSLog(@"birthday:%@, today:%@, diff:%d",selectDate,todayDate,diffDays);
        
        age = 0;
        ANB = 1;
    }
    //    NSLog(@"msgAge:%@",msgAge);
}
#pragma mark - UIALERT VIEW DELEGATE
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1001 && buttonIndex == 0) {
        
        if (useExist) {
            NSLog(@"will update");
            [self updateData];
        }
        else if (Inserted) {
            NSLog(@"will update2");
            [self updateData2];
        }
        else {
            NSLog(@"will insert new");
            [self insertData];
        }
        Saved = YES;
    }
    else if (alertView.tag==1002 && buttonIndex == 0) {
        [self delete2ndLA];
    }
    else if (alertView.tag==1003 && buttonIndex == 0) {
        [self deletePayor];
    }
    else if (alertView.tag==1004 && buttonIndex == 0) {
        
        if (smoker.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Smoker is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
        }
        else if ([OccpCodePP isEqualToString:@"OCC01975"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"There is no existing plan which can be offered to this occupation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
			
        }
		else if (age > 63){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Age Last Birthday must be less than or equal to 63 for this product." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
			alert = Nil;
		}
        else {
            //---------
            sex = GenderPP;
            DOB = DOBPP;
            occuCode = OccpCodePP;
            [self calculateAge];
            [self getOccLoadExist];
            
            LAOccLoadingField.text = [NSString stringWithFormat:@"%@",occLoading];
            
            
            if (occCPA_PA == 0) {
                LACPAField.text = @"D";
            } else {
                LACPAField.text = [NSString stringWithFormat:@"%d",occCPA_PA];
            }
            
            if (occPA == 0) {
                LAPAField.text = @"D";
            } else {
                LAPAField.text = [NSString stringWithFormat:@"%d",occPA];
            }
            //-------------------
            
            [self calculateAge];
            if (AgeLess) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Age must be at least 30 days." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert setTag:1005];
                [alert show];
            }
            else {
                [self checkExistRider];
                if (AgeChanged) {
                    
                    if (arrExistRiderCode.count > 0) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Rider(s) has been deleted due to business rule." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                        [alert setTag:1007];
                        [alert show];
                    }
                    
                    [self updateData];
                }
                
                else if (JobChanged) {
                    
                    //--1)check rider base on occpClass
                    [self getActualRider];
                    NSLog(@"total exist:%d, total valid:%d",arrExistRiderCode.count,ridCode.count);
                    
                    BOOL dodelete = NO;
                    for(int i = 0; i<arrExistRiderCode.count; i++)
                    {
                        if(![ridCode containsObject:[arrExistRiderCode objectAtIndex:i]])
                        {
                            NSLog(@"do delete %@",[arrExistRiderCode objectAtIndex:i]);
                            [self deleteRider:[arrExistRiderCode objectAtIndex:i]];
                            dodelete = YES;
                        }
                    }
                    [self checkExistRider];
                    
                    //--2)check Occp not attach
                    [self getOccpNotAttach];
                    if (atcRidCode.count !=0) {
                        
                        for (int j=0; j<arrExistRiderCode.count; j++)
                        {
                            if ([[arrExistRiderCode objectAtIndex:j] isEqualToString:@"CPA"]) {
                                NSLog(@"do delete %@",[arrExistRiderCode objectAtIndex:j]);
                                [self deleteRider:[arrExistRiderCode objectAtIndex:j]];
                                dodelete = YES;
                            }
                            
                            if ([[arrExistRiderCode objectAtIndex:j] isEqualToString:@"HMM"] && [[arrExistPlanChoice objectAtIndex:j] isEqualToString:@"HMM_1000"]) {
                                NSLog(@"do delete %@",[arrExistRiderCode objectAtIndex:j]);
                                [self deleteRider:[arrExistRiderCode objectAtIndex:j]];
                                dodelete = YES;
                            }
                        }
                    }
                    [self checkExistRider];
                    
                    if (dodelete) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Some Rider(s) has been deleted due to marketing rule." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                    
                    [self updateData];
                }
                else {
                    [self updateData];
                }
            }
        }
    }
    else if (alertView.tag==1004 && buttonIndex == 1) { // added by heng
        LANameField.text = clientName;
        [btnDOB setTitle:DOB forState:UIControlStateNormal];
        LAAgeField.text = [[NSString alloc] initWithFormat:@"%d",age];
        [self.btnCommDate setTitle:commDate forState:UIControlStateNormal];
        
        if ([sex isEqualToString:@"MALE"]) {
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
        [btnOccp setTitle:occuDesc forState:UIControlStateNormal];
        LAOccLoadingField.text = [NSString stringWithFormat:@"%@",occLoading];
        
        if (occCPA_PA == 0) {
            LACPAField.text = @"D";
        } else {
            LACPAField.text = [NSString stringWithFormat:@"%d",occCPA_PA];
        }
        
        if (occPA == 0) {
            LAPAField.text = @"D";
        } else {
            LAPAField.text = [NSString stringWithFormat:@"%d",occPA];
        }
    }
    else if (alertView.tag==1005 && buttonIndex == 0) {
        
        LANameField.text = @"";
        [sexSegment setSelectedSegmentIndex:UISegmentedControlNoSegment];
        [btnDOB setTitle:@"" forState:UIControlStateNormal];
        LAAgeField.text = @"";
        [self.btnCommDate setTitle:@"" forState:UIControlStateNormal];
        [btnOccp setTitle:@"" forState:UIControlStateNormal];
        LAOccLoadingField.text = @"";
        LACPAField.text = @"";
        LAPAField.text = @"";
    }
    else if (alertView.tag==1006 && buttonIndex == 0) //record saved
    {
		//        [self closeScreen];
    }
    else if (alertView.tag == 1007 && buttonIndex == 0) {
        [self deleteRider];
    }
}



#pragma mark - Handle Data

-(void)getOccLoadExist
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT a.OccpDesc, b.OccLoading, b.CPA, b.PA, b.Class from Adm_Occp_Loading_Penta a LEFT JOIN Adm_Occp_Loading b ON a.OccpCode = b.OccpCode WHERE b.OccpCode = \"%@\"",occuCode];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                occuDesc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                occLoading =  [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                occCPA_PA  = sqlite3_column_int(statement, 2);
                occPA  = sqlite3_column_int(statement, 3);
                occuClass = sqlite3_column_int(statement, 4);
                strPA_CPA = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
				
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



-(void)insertClient
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL3 = [NSString stringWithFormat:
                                @"INSERT INTO prospect_profile(\"ProspectName\", \"ProspectDOB\", \"ProspectGender\", \"ProspectOccupationCode\", \"DateCreated\", \"CreatedBy\", \"DateModified\",\"ModifiedBy\", \"Smoker\", 'QQflag') "
                                "VALUES (\"%@\", \"%@\", \"%@\", \"%@\", %@, \"%@\", \"%@\", \"%@\", \"%@\", '%@')", LANameField.text, DOB, sex, occuCode, @"datetime(\"now\", \"+8 hour\")", @"1", @"", @"1", smoker, @"True"];
        
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

-(BOOL)insertData
{
    if (isNewClient) {
        [self insertClient];
    }
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:
							   @"INSERT INTO Trad_LAPayor (PTypeCode,Sequence,DateCreated,CreatedBy) VALUES (\"LA\",\"1\",\"%@\",\"hla\")",commDate];
        
        NSLog(@"%@",insertSQL);
        if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Done LA");
            }
            else {
                NSLog(@"Failed LA");
                return NO;
            }
            sqlite3_finalize(statement);
        }
        
        NSString *insertSQL2 = [NSString stringWithFormat:@"INSERT INTO Clt_Profile (Name, Smoker, Sex, DOB, ALB, ANB, OccpCode, DateCreated, CreatedBy,indexNo) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%d\", \"%@\", \"%@\", \"hla\", \"%d\")",LANameField.text, smoker, sex, DOB, age, ANB, occuCode, commDate,IndexNo];
        
        NSLog(@"%@",insertSQL2);
        if(sqlite3_prepare_v2(contactDB, [insertSQL2 UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Done LA2");
                [self getLastIDPayor];
                [self getLastIDProfile];
                
            } else {
                NSLog(@"Failed LA2");
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Fail in inserting record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
                return NO;
            }
            sqlite3_finalize(statement);
        }
		
        [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode andOccpClass:occuClass andSex:sex andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker];
        Inserted = YES;
        AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
        zzz.SICompleted = NO;
        
        sqlite3_close(contactDB);
    }
    return YES;
}

-(BOOL)updateData
{
    BOOL isUpdated = YES;
    //[self storeLAObj];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *currentdate = [dateFormatter stringFromDate:[NSDate date]];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
							  @"UPDATE Clt_Profile SET Name=\"%@\", Smoker=\"%@\", Sex=\"%@\", DOB=\"%@\", ALB=\"%d\", ANB=\"%d\", OccpCode=\"%@\", DateModified=\"%@\", ModifiedBy=\"hla\",indexNo=\"%d\", DateCreated = \"%@\"  WHERE id=\"%d\"",
                              LANameField.text,smoker,sex,DOB,age,ANB,occuCode,currentdate,IndexNo, commDate,idProfile];
        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                if (DiffClient) {
                    NSLog(@"diffClient!");
                    
                    if (age < 10) {
                        [self checkingPayor];
                        if (payorSINo.length == 0) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Please attach Payor as Life Assured is below 10 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                            [alert show];
                            
                            AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
                            zzz.ExistPayor = NO;
                        }
                    }
                    [self checkExistRider];
                    if (arrExistRiderCode.count > 0) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Rider(s) has been deleted due to business rule." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                        [alert setTag:1007];
                        [alert show];
                    }
                    if (age > 18) {
                        [self checkingPayor];
                        if (payorSINo.length != 0 && ![payorSINo isEqualToString:@"(null)"]) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Payor's details will be deleted due to life Assured age is greater or equal to 18." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                            [alert setTag:1003];
                            [alert show];
                        }
                    }
                    if (age < 16) {
                        [self checking2ndLA];
                        if (CustCode2.length != 0) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"2nd Life Assured's details will be deleted due to life Assured age is less than 16." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                            //[_delegate deleteSecondLAFromDB];
                            [alert setTag:1002];
                            [alert show];
                        }
                    }
                }
                
                else {
                    if (age < 10) {
                        [self checkingPayor];
                        if (payorSINo.length == 0) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Please attach Payor as Life Assured is below 10 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                            [alert show];
                            
                            AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
                            zzz.ExistPayor = NO;
                        }
                    }
                    if (age >= 18) {
                        [self checkingPayor];
                        if (payorSINo.length != 0 && ![payorSINo isEqualToString:@"(null)"]) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Payor's details will be deleted due to life Assured age is greater or equal to 18" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                            [alert setTag:1003];
                            [alert show];
                        }
                    }
                    if (age < 16) {
                        [self checking2ndLA];
                        if (CustCode2.length != 0) {
                            
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"2nd Life Assured's details will be deleted due to life Assured age is less than 16" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                            [alert setTag:1002];
                            [alert show];
                        }
                    }
                }
            }
            else {
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Fail in updating record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
                isUpdated = NO;
            }
            
            [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode andOccpClass:occuClass andSex:sex andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker];
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    return isUpdated;
}

-(void)updateData2
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *currentdate = [dateFormatter stringFromDate:[NSDate date]];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"UPDATE Clt_Profile SET Name=\"%@\", Smoker=\"%@\", Sex=\"%@\", DOB=\"%@\", ALB=\"%d\", ANB=\"%d\", OccpCode=\"%@\", DateModified=\"%@\", ModifiedBy=\"hla\",indexNo=\"%d\", DateCreated = \"%@\"  WHERE id=\"%d\"",
                              LANameField.text,smoker,sex,DOB,age,ANB,occuCode,currentdate,IndexNo, commDate,lastIdProfile];
		//        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                if (age < 10) {
                    [self checkingPayor];
                    if (payorSINo.length == 0) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Please attach Payor as Life Assured is below 10 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                        [alert show];
                    }
                }
            }
            else {
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Fail in updating record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
            }
            
            [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode andOccpClass:occuClass andSex:sex andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker];
            
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
							  @"SELECT a.SINo, a.CustCode, b.Name, b.Smoker, b.Sex, b.DOB, b.ALB, b.OccpCode, b.DateCreated, b.id, b.IndexNo, a.rowid FROM Trad_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Sequence=1",getSINo];
        
        NSLog(@"%@",querySQL);
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
                occuCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                commDate = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)];
                idProfile = sqlite3_column_int(statement, 9);
                IndexNo = sqlite3_column_int(statement, 10);
                idPayor = sqlite3_column_int(statement, 11);
                NSLog(@"age:%d, indexNo:%d, idPayor:%d, idProfile:%d",age,IndexNo,idPayor,idProfile);
				
            } else {
                NSLog(@"error access tbl_SI_Trad_LAPayor");
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
    [self storeLAObj];
}

-(void)checkingExisting2
{
    sqlite3_stmt *statement;
    NSString *tempSINo;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT a.SINo, b.id FROM Trad_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Sequence=1",getSINo];
        
		//        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                tempSINo = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                idProfile = sqlite3_column_int(statement, 1);
				//                NSLog(@"tempSINo:%@, length:%d",tempSINo, tempSINo.length);
                
            } else {
                NSLog(@"error access tbl_SI_Trad_LAPayor");
                useExist = NO;
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    if (tempSINo.length != 0 && ![tempSINo isEqualToString:@"(null)"]) {
        useExist = YES;
    } else {
        useExist = NO;
    }
}

-(void)checkingExistingSI
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT SINo FROM Trad_Details WHERE SINo=\"%@\"",getSINo];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                basicSINo = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
            } else {
                NSLog(@"error access Trad_Details");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
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

-(void)getExistingBasic
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT SINo, PlanCode, PolicyTerm, BasicSA, PremiumPaymentOption, CashDividend, YearlyIncome, AdvanceYearlyIncome, HL1KSA, HL1KSATerm, TempHL1KSA, TempHL1KSATerm FROM Trad_Details WHERE SINo=\"%@\"",getSINo];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                basicSINo = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                planChoose = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                getPolicyTerm = sqlite3_column_int(statement, 2);
                getSumAssured = sqlite3_column_double(statement, 3);
                MOP = sqlite3_column_int(statement, 4);
                cashDividend = [[NSString alloc ] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                yearlyIncome = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)];
                advanceYearlyIncome = sqlite3_column_int(statement, 7);
                
                const char *getHL2 = (const char*)sqlite3_column_text(statement, 8);
                getHL = getHL2 == NULL ? nil : [[NSString alloc] initWithUTF8String:getHL2];
                getHLTerm = sqlite3_column_int(statement, 9);
                
                const char *getTempHL2 = (const char*)sqlite3_column_text(statement, 10);
                getTempHL = getTempHL2 == NULL ? nil : [[NSString alloc] initWithUTF8String:getTempHL2];
                getTempHLTerm = sqlite3_column_int(statement, 11);
                
            } else {
                NSLog(@"error access Trad_Details");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)checkingPayor
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT a.SINo, a.CustCode, b.Name, b.Smoker, b.Sex, b.DOB, b.ALB, b.OccpCode, b.id FROM Trad_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode WHERE a.SINo=\"%@\" AND a.PTypeCode=\"PY\" AND a.Sequence=1",getSINo];
        
        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                payorSINo = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                payorCustCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
				payorAge = sqlite3_column_int(statement, 6);
                
            } else {
                payorSINo= nil;
                payorCustCode = nil;
                NSLog(@"error access checkingPayor");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)checking2ndLA
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT a.SINo, a.CustCode, b.Name, b.Smoker, b.Sex, b.DOB, b.ALB, b.OccpCode, b.DateCreated, b.id FROM Trad_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Sequence=2",getSINo];
        
        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                CustCode2 = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                idProfile2 = sqlite3_column_int(statement, 9);
            } else {
                CustCode2 = nil;
                idProfile2 = 0;
                NSLog(@"error access Trad_LAPayor");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)delete2ndLA
{
    [_delegate secondLADelete];
	
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_LAPayor WHERE CustCode=\"%@\"",CustCode2];
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
        NSString *deleteSQL = [NSString stringWithFormat:@"DELETE FROM Clt_Profile WHERE CustCode=\"%@\"",CustCode2];
        if (sqlite3_prepare_v2(contactDB, [deleteSQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Clt_Profile delete!");
                
            } else {
                NSLog(@"Clt_Profile delete Failed!");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)deletePayor
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_LAPayor WHERE CustCode=\"%@\"",payorCustCode];
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
        NSString *deleteSQL = [NSString stringWithFormat:@"DELETE FROM Clt_Profile WHERE CustCode=\"%@\"",payorCustCode];
        if (sqlite3_prepare_v2(contactDB, [deleteSQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Clt_Profile delete!");
                [_delegate PayorDeleted];
                
            } else {
                NSLog(@"Clt_Profile delete Failed!");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void) getTerm
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT MinTerm,MaxTerm,MinSA,MaxSA FROM Trad_Sys_Mtn WHERE PlanCode=\"%@\"",planChoose];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                int maxTerm  =  sqlite3_column_int(statement, 1);
                if ([planChoose isEqualToString:@"HLAIB"]) {
                    termCover = maxTerm - age;
                }
                else {
                    termCover = maxTerm;
                }
            }
            else {
                NSLog(@"error access Trad_Mtn");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getPlanCodePenta
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = nil;
        if ([planChoose isEqualToString:@"HLAIB"]) {
            querySQL = [NSString stringWithFormat: @"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE SIPlanCode=\"%@\" AND PremPayOpt=\"%d\"",planChoose,MOP];
        }
        else {
            querySQL = [NSString stringWithFormat: @"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE SIPlanCode=\"%@\"",planChoose];
        }
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                planCode =  [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
            } else {
                NSLog(@"error access PentaPlanCode");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)checkExistRider
{
    arrExistRiderCode = [[NSMutableArray alloc] init];
    arrExistPlanChoice = [[NSMutableArray alloc] init];
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT RiderCode, PlanOption FROM Trad_Rider_Details WHERE SINo=\"%@\"",getSINo];
		
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                [arrExistRiderCode addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)]];
                [arrExistPlanChoice addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)]];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getActualRider
{
    ridCode = [[NSMutableArray alloc] init];
    sqlite3_stmt *statement;
    NSString *querySQL;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        if (self.occuClass == 4 && ![strPA_CPA isEqualToString:@"D" ]) {
            querySQL = [NSString stringWithFormat:
                        @"SELECT j.*, k.MinAge, k.MaxAge FROM"
                        "(SELECT a.RiderCode,b.RiderDesc FROM Trad_Sys_RiderComb a LEFT JOIN Trad_Sys_Rider_Profile b ON a.RiderCode=b.RiderCode WHERE a.PlanCode=\"%@\" AND a.RiderCode != \"MG_IV\")j "
                        "LEFT JOIN Trad_Sys_Rider_Mtn k ON j.RiderCode=k.RiderCode WHERE k.MinAge <= \"%d\" AND k.MaxAge >= \"%d\"", planChoose, age, age];
        }
        else if (self.occuClass > 4) {
            querySQL = [NSString stringWithFormat:
                        @"SELECT j.*, k.MinAge, k.MaxAge FROM"
                        "(SELECT a.RiderCode,b.RiderDesc FROM Trad_Sys_RiderComb a LEFT JOIN Trad_Sys_Rider_Profile b ON a.RiderCode=b.RiderCode WHERE a.PlanCode=\"%@\" AND a.RiderCode != \"CPA\" AND a.RiderCode != \"PA\" AND a.RiderCode != \"HMM\" AND a.RiderCode != \"HB\" AND a.RiderCode != \"MG_II\" AND a.RiderCode != \"MG_IV\" AND a.RiderCode != \"HSP_II\")j "
                        "LEFT JOIN Trad_Sys_Rider_Mtn k ON j.RiderCode=k.RiderCode WHERE k.MinAge <= \"%d\" AND k.MaxAge >= \"%d\"",planChoose, age, age];
        }
		else if ([strPA_CPA isEqualToString:@"D"]){
			querySQL = [NSString stringWithFormat:
                        @"SELECT j.*, k.MinAge, k.MaxAge FROM"
                        "(SELECT a.RiderCode,b.RiderDesc FROM Trad_Sys_RiderComb a LEFT JOIN Trad_Sys_Rider_Profile b ON a.RiderCode=b.RiderCode WHERE a.PlanCode=\"%@\" AND a.RiderCode != \"MG_IV\" AND a.RiderCode != \"CPA\")j "
                        "LEFT JOIN Trad_Sys_Rider_Mtn k ON j.RiderCode=k.RiderCode WHERE k.MinAge <= \"%d\" AND k.MaxAge >= \"%d\"", planChoose, age, age];
		}
        else {
            querySQL = [NSString stringWithFormat:
                        @"SELECT j.*, k.MinAge, k.MaxAge FROM"
                        "(SELECT a.RiderCode,b.RiderDesc FROM Trad_Sys_RiderComb a LEFT JOIN Trad_Sys_Rider_Profile b ON a.RiderCode=b.RiderCode WHERE a.PlanCode=\"%@\")j "
                        "LEFT JOIN Trad_Sys_Rider_Mtn k ON j.RiderCode=k.RiderCode WHERE k.MinAge <= \"%d\" AND k.MaxAge >= \"%d\"",planChoose, age, age];
        }
		
        if (age > 60) {
            querySQL = [querySQL stringByAppendingFormat:@" AND j.RiderCode != \"I20R\""];
        }
        if (age > 65) {
            querySQL = [querySQL stringByAppendingFormat:@" AND j.RiderCode != \"IE20R\""];
        }
        
        querySQL = [querySQL stringByAppendingFormat:@" order by j.RiderCode asc"];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                [ridCode addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getOccpNotAttach
{
    atcRidCode = [[NSMutableArray alloc] init];
    atcPlanChoice = [[NSMutableArray alloc] init];
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT RiderCode,PlanChoice FROM Trad_Sys_Occp_NotAttach WHERE OccpCode=\"%@\"",occuCode];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                const char *zzRidCode = (const char *)sqlite3_column_text(statement, 0);
                [atcRidCode addObject:zzRidCode == NULL ? @"" :[[NSString alloc] initWithUTF8String:zzRidCode]];
                
                const char *zzPlan = (const char *)sqlite3_column_text(statement, 1);
                [atcPlanChoice addObject:zzPlan == NULL ? @"" :[[NSString alloc] initWithUTF8String:zzPlan]];
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
        NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\"",getSINo];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"All rider delete!");
                [_delegate RiderAdded];
                
            } else {
                NSLog(@"rider delete Failed!");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)deleteRider:(NSString *)aaCode
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"DELETE FROM Trad_Rider_Details WHERE SINo=\"%@\" AND RiderCode=\"%@\"",getSINo,aaCode];
        
		//        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"rider %@ delete!",aaCode);
                [_delegate RiderAdded];
                
            } else {
                NSLog(@"rider delete Failed!");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void) getLastIDPayor
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT rowid FROM Trad_LAPayor ORDER by rowid desc limit 1"];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                lastIdPayor  =  sqlite3_column_int(statement, 0);
                NSLog(@"lastPayorID:%d",lastIdPayor);
            }
            else {
                NSLog(@"error access Trad_LAPayor");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}
# pragma mark - VALIDATION
-(BOOL)performSaveData
{
    if (useExist) {
        NSLog(@"will update");
        return[self updateData];
    }
    /*else if (Inserted) {
	 NSLog(@"will update2");
	 [self updateData2];
	 }*/
    else {
        NSLog(@"will insert new");
		return [self insertData];
    }
	
}
-(BOOL)validateSave// validate new la before saving
{
    NSLog(@"validate Save for LA");
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789'@/-. "] invertedSet];
    
    if (LANameField.text.length <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Life Assured Name is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [LANameField becomeFirstResponder];
    }
    else if (smoker.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Smoker is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
    
    else if ([btnCommDate.titleLabel.text isEqualToString:@"(null)"] || btnCommDate.titleLabel.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Commencement date is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
    else if (AgeLess) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Age must be at least 30 days." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert setTag:1005];
        [alert show];
    }
    else if (age > 63) { //changed to 63 ; by Edwin 8-10-2013
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Age Last Birthday must be less than or equal to 63 for this product." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
    else if (occuCode.length == 0 || btnOccp.titleLabel.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Please select an Occupation Description." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
    else if ([LANameField.text rangeOfCharacterFromSet:set].location != NSNotFound) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Invalid input format. Input must be alphabet A to Z, space, apostrotrophe('), alias(@), slash(/), dash(-) or dot(.)" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
    else if ([occuCode isEqualToString:@"OCC01975"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"There is no existing plan which can be offered to this occupation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
	/* else {
	 //prompt save
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
	 if (Inserted) {
	 msg = @"Confirm changes?";
	 } else {
	 msg = @"Save?";
	 }
	 }
	 
	 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL",nil];
	 [alert setTag:1001];
	 [alert show];
	 }*/
    else{
        return YES;
    }
    return NO;
    
}

#pragma mark - STORE LA BEFORE SAVE INTO DATABASE
-(void)storeLAObj
{
    if (!siObj) {
        siObj = [[SIObj alloc]init];
    }
    if(!tempSIDict)
    {
        tempSIDict = [[NSMutableDictionary alloc]init];
    }
    
    NSLog(@"sino == %@    custcode == %@",SINo,CustCode);
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
		
        NSString *querySQL = [NSString stringWithFormat: @"SELECT Name,Smoker,Sex,DOB,ALB,ANB,OccpCode,DateModified,ModifiedBy,indexNo,DateCreated FROM Clt_Profile WHERE CustCode = \"%@\" ",CustCode];
        
        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                int rowCount = sqlite3_column_count(statement);
                NSLog(@"rowCount = %d",rowCount);
                
                for (int i = 0; i<rowCount; i++) {
                    [tempSIDict setObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, i)] forKey:[NSString stringWithFormat:@"key%d",i]];
                    NSLog(@"%@",[tempSIDict objectForKey:[NSString stringWithFormat:@"key%d",i]]);
                }
                
                /*siObj.siNO = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
				 siObj.custCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
				 siObj.name = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
				 siObj.smoker = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
				 siObj.sex = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
				 siObj.DOB = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
				 siObj.ALB = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
				 siObj.occupationCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)];
				 siObj.
                 */
                //tempSIDict = [[NSDictionary alloc] init]
                //lastIdProfile  =  sqlite3_column_int(statement, 0);
                
            }
            else {
                NSLog(@"error access Clt_Profile");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
}
-(void) getLastIDProfile
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT id FROM Clt_Profile ORDER by id desc limit 1"];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                lastIdProfile  =  sqlite3_column_int(statement, 0);
                NSLog(@"lastProfileID:%d",lastIdProfile);
            }
            else {
                NSLog(@"error access Clt_Profile");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

#pragma mark - delegate

-(void)listing:(ListingTbViewController *)inController didSelectIndex:(NSString *)aaIndex andName:(NSString *)aaName andDOB:(NSString *)aaDOB andGender:(NSString *)aaGender andOccpCode:(NSString *)aaCode andSmoker:(NSString *)aaSmoker
{
    
    tempSmoker = smoker;
    tempSex = sex;
    tempDOB = DOB;
    tempAge =age;
    tempOccCode = occuCode;
    tempIndexNo = IndexNo;
    tempCommDate = commDate;
    tempIdProfile = idProfile;
	
    NSLog(@"view new client");
    if (commDate.length == 0) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        commDate = [dateFormatter stringFromDate:[NSDate date]];
    }
    
    NSLog(@"%@",planChoose);
	
    DOB = aaDOB;
    [self calculateAge];
    
    if ([planChoose isEqualToString:@"HLACP"] && age > 63)
	{
		smoker = tempSmoker;
		sex = tempSex;
		DOB = tempDOB;
		age = tempAge;
		occuCode = tempOccCode;
		IndexNo = tempIndexNo;
		commDate = tempCommDate;
		idProfile = tempIdProfile;
		[self.prospectPopover dismissPopoverAnimated:YES];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Age Last Birthday must be less than or equal to 63 for this product."
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
		[alert show];
		alert = Nil;
		
		return;
		
	}
	
    if ([NSString stringWithFormat:@"%d",IndexNo] != NULL) {
        smoker = @"N";
        DiffClient = YES;
    }
    if (SINo) {
        useExist = YES;
		
    }
    else{
        useExist = NO;
		
    }
    statusLabel.text = @"";
    IndexNo = [aaIndex intValue];
    
    AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    zzz.ExistPayor = YES;
    
	if (age > 63) { //changed to 63 ; by Edwin 8-10-2013
		//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Life Assured's age exceed HLA Income Builder maximum entry age (70 years old)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Age Last Birthday must be less than or equal to 63 for this product." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        return;
	}
	else
	{
        LANameField.text = aaName;
        sex = aaGender;
		//        [smokerSegment setSelectedSegmentIndex:UISegmentedControlNoSegment];
        
        if ([sex isEqualToString:@"MALE"]) {
            sexSegment.selectedSegmentIndex = 0;
        } else {
            sexSegment.selectedSegmentIndex = 1;
        }
        NSLog(@"sex:%@",sex);
        
        [btnDOB setTitle:DOB forState:UIControlStateNormal];
        LAAgeField.text = [[NSString alloc] initWithFormat:@"%d",age];
        [self.btnCommDate setTitle:commDate forState:UIControlStateNormal];
        
        occuCode = aaCode;
        [self getOccLoadExist];
        [btnOccp setTitle:occuDesc forState:UIControlStateNormal];
        self.btnOccp.titleLabel.textColor = [UIColor darkGrayColor];
        LAOccLoadingField.text = [NSString stringWithFormat:@"%@",occLoading];
        
        if (occCPA_PA == 0) {
            LACPAField.text = @"D";
        }
        else {
            LACPAField.text = [NSString stringWithFormat:@"%d",occCPA_PA];
        }
        
        if (occPA == 0) {
            LAPAField.text = @"D";
        }
        else {
            LAPAField.text = [NSString stringWithFormat:@"%d",occPA];
        }
	}
    
    if(age < 17){
        smokerSegment.enabled = FALSE;
    }else
    {
        smokerSegment.enabled = TRUE;
    }
    
    [self.prospectPopover dismissPopoverAnimated:YES];
    
    zzz.SICompleted = NO; //added by Edwin 9-10-2013
	
}

-(void)datePick:(DateViewController *)inController strDate:(NSString *)aDate strAge:(NSString *)aAge intAge:(int)bAge intANB:(int)aANB
{
    if (date1) {
        if (aDate == NULL) {
            [btnDOB setTitle:dobtemp forState:UIControlStateNormal];
            DOB = dobtemp;
            [self calculateAge];
            LAAgeField.text = [[NSString alloc] initWithFormat:@"%d",age];
            
        } else {
            [btnDOB setTitle:aDate forState:UIControlStateNormal];
            DOB = aDate;
            [self calculateAge];
            LAAgeField.text = [[NSString alloc] initWithFormat:@"%d",bAge];
        }
        
        self.btnDOB.titleLabel.textColor = [UIColor blackColor];
        [self.dobPopover dismissPopoverAnimated:YES];
        date1 = NO;
    }
    else if (date2) {
        if (aDate == NULL) {
            [btnCommDate setTitle:temp forState:UIControlStateNormal];
            commDate = temp;
        }
        else {
            [self.btnCommDate setTitle:aDate forState:UIControlStateNormal];
            commDate = aDate;
        }
        
        if (DOB.length != 0 || btnDOB.titleLabel.text.length != 0) {
            [self calculateAge];
            LAAgeField.text = [[NSString alloc] initWithFormat:@"%d",age];
        }
        
        [self.datePopover dismissPopoverAnimated:YES];
        date2 = NO;
    }
    [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode andOccpClass:occuClass andSex:sex andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker];
	
}

- (void)OccupCodeSelected:(NSString *)OccupCode
{
    
    occuCode = OccupCode;
    [self getOccLoadExist];
    LAOccLoadingField.text = [NSString stringWithFormat:@"%@",occLoading];
    
    if (occCPA_PA == 0) {
        LACPAField.text = @"D";
    }
    else {
        LACPAField.text = [NSString stringWithFormat:@"%d",occCPA_PA];
    }
    
    if (occPA == 0) {
        LAPAField.text = @"D";
    }
    else {
        LAPAField.text = [NSString stringWithFormat:@"%d",occPA];
    }
}

- (void)OccupDescSelected:(NSString *)color {
    [btnOccp setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", color]forState:UIControlStateNormal];
    [self.OccupationListPopover dismissPopoverAnimated:YES];
}

-(void)OccupClassSelected:(NSString *)OccupClass{
	
}

#pragma mark - Memory management
-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.popOverController = nil;
}

- (void)viewDidUnload
{
    [self resignFirstResponder];
    [self setDelegate:nil];
    [self setRequestSINo:nil];
    [self setRequestCommDate:nil];
    [self setRequestSex:nil];
    [self setRequestSmoker:nil];
    [self setGetSINo:nil];
    [self setProspectList:nil];
    [self setLADate:nil];
    [self setProspectPopover:nil];
    [self setDatePopover:nil];
    [self setMyScrollView:nil];
    [self setPopOverController:nil];
    [self setLANameField:nil];
    [self setSexSegment:nil];
    [self setSmokerSegment:nil];
    [self setLAAgeField:nil];
    [self setLAOccLoadingField:nil];
    [self setLACPAField:nil];
    [self setLAPAField:nil];
    [self setBtnCommDate:nil];
    [self setStatusLabel:nil];
    [self setMyToolBar:nil];
    [self setSINo:nil];
    [self setCustCode:nil];
    [self setClientName:nil];
    [self setOccuCode:nil];
    [self setOccuDesc:nil];
    [self setBasicSINo:nil];
    [self setGetHL:nil];
    [self setGetTempHL:nil];
    [self setYearlyIncome:nil];
    [self setCashDividend:nil];
    [self setPlanCode:nil];
    [self setSmoker:nil];
    [self setSex:nil];
    [self setDOB:nil];
    [self setCommDate:nil];
    [self setJobDesc:nil];
    [self setCustCode2:nil];
    [self setPayorSINo:nil];
    [self setPayorCustCode:nil];
    [self setOccDesc:nil];
    [self setOccCode:nil];
    [self setNamePP:nil];
    [self setGenderPP:nil];
    [self setDOBPP:nil];
    [self setOccpCodePP:nil];
    [self setArrExistRiderCode:nil];
    [self setPlanChoose:nil];
    [self setHeaderTitle:nil];
    [self setBtnDOB:nil];
    [self setBtnOccp:nil];
    [self setBtnProspect:nil];
    [self setBtnEnabled:nil];
    [self setBtnEnabled:nil];
    [self setBtnProspect:nil];
    [self setBtnToEAPP:nil];
    [self setOutletSpace:nil];
    [super viewDidUnload];
}



@end
