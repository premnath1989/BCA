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
@synthesize idPayor,idProfile,idProfile2,lastIdPayor,lastIdProfile,planChoose,ridCode,atcRidCode,atcPlanChoice, outletDone;
@synthesize delegate = _delegate;
@synthesize basicSINo,requestCommDate,requestIndexNo,requestLastIDPay,requestLastIDProf,requestSex,requestSmoker, strPA_CPA,payorAge;
@synthesize LADate = _LADate;
@synthesize datePopover = _datePopover;
@synthesize dobPopover = _dobPopover;
@synthesize OccupationList = _OccupationList;
@synthesize OccupationListPopover = _OccupationListPopover;
@synthesize siObj,requesteProposalStatus;
@synthesize planName;

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
	
	if ([requesteProposalStatus isEqualToString:@"Failed"] ||
		[requesteProposalStatus isEqualToString:@"Confirmed"] || [requesteProposalStatus isEqualToString:@"Submitted"] ||
		[requesteProposalStatus isEqualToString:@"Received"] || [EAPPorSI isEqualToString:@"eAPP"] || [requesteProposalStatus isEqualToString:@"Created_View"] ||
        [requesteProposalStatus isEqualToString:@"Created"]) {
		Editable = NO;
	}
	else{
		Editable = YES;
	}
    [self cleanDatabase];
    smoker = @"dummy"; //for easier debugging
    DiffClient = NO; //initialized to NO, as to allow riders to be added, else riders wouldn't be able to be added in every new SI.
    savedIndexNo = -1; //initialized to -1, for debugging and to prevent it from going to the different condition for setting DiffClient
	
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
	QQProspect = NO;
    self.btnOccp.titleLabel.textColor = [UIColor darkGrayColor];
    [LANameField setDelegate:self];
    [LAAgeField setDelegate:self];
    [LAOccLoadingField setDelegate:self];
    [LACPAField setDelegate:self];
    [LAPAField setDelegate:self];
    
    //smoker = @"N"; //default as NO
    
    getSINo = [self.requestSINo description];
	
    NSLog(@"LA-SINo: %@",getSINo);
    
    if (getSINo.length != 0) {
        appDelegate.isSIExist = YES;
		outletDone.enabled = TRUE;
		
        [self checkingExisting];
        [self checkingExistingSI];
        
        if (basicSINo.length != 0) {
            [self getExistingBasic];
            [self getTerm];
            [self toogleExistingBasic];
        }
        
        if (SINo.length != 0) {
            [self getProspectData];
            
            if ([DOBPP isEqualToString:@"0000"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Client profile is corrupted. Please create a new one." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
            }
            
            [self getSavedField];
            NSLog(@"will use existing data");
        }
		
        //removed this requirement due to new marketing requirement : Edwin 27-03-2014
//		if(age < 17){
//			smokerSegment.enabled = FALSE;
//		}
    }
    else {
        NSLog(@"SINo not exist!");
		outletDone.enabled = FALSE;
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
		/*
		if ([ccc.Change isEqualToString:@"yes"]) {
			NSLog(@"prospect info sync into second life assured");
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Prospect's information(2nd life Assured) will synchronize to this SI."
														   delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert show];
		}
		*/
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
		/*
		if ([ggg.Change isEqualToString:@"yes"]) {
			NSLog(@"prospect info sync into payor");
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Prospect's information(Payor) will synchronize to this SI."
														   delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert show];
		}
         */
		
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
    
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
								   initWithTarget:self
								   action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	
	[self.view addGestureRecognizer:tap];
	
	if (Editable == NO) {
		[self DisableTextField:LANameField ];
		[self DisableTextField:LAAgeField ];
		[self DisableTextField:LACPAField ];
		[self DisableTextField:LAOccLoadingField ];
		[self DisableTextField:LAPAField ];
		
		sexSegment.enabled = FALSE;
		smokerSegment.enabled = FALSE;
		btnCommDate.enabled = FALSE;
		btnEnabled.enabled = FALSE;
		btnProspect.enabled = FALSE;
		
		if([EAPPorSI isEqualToString:@"eAPP"]){
			outletDone.enabled = FALSE;
		}
		
	}
    
    if([EAPPorSI isEqualToString:@"eAPP"]){
        [self disableFieldsForEapp];
    }
}

-(void)cleanDatabase {
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK) {
        NSString *querySQL = @"DELETE FROM Trad_LAPayor WHERE SINo IS NULL OR SINo='(null)'";
        if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
            }
        }
        
        querySQL = @"DELETE FROM Clt_Profile WHERE CustCode IS NULL OR CustCode='null'";
        if(sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
    }
}

-(void) disableFieldsForEapp
{
    [btnDOB setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btnCommDate setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btnOccp setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

-(void)hideKeyboard{
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
}

-(void)DisableTextField :(UITextField *)aaTextField{
	aaTextField.backgroundColor = [UIColor lightGrayColor];
	aaTextField.enabled = FALSE;
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
    
    self.view.frame = CGRectMake(0, 0, 800, 1004);
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

//usually for EDD case
-(NSString*) getNonGender:(NSString*)sexs
{
    NSString * toReturn = @"";
    
    if( [sexs length]>0 )
    {
        toReturn = [sexs substringToIndex:1];
    }
    
    return toReturn;
}

-(void)getSavedField
{
    BOOL valid = TRUE;
    if (![NamePP isEqualToString:clientName]) {
        valid = FALSE;
    }
    
    NSString * gender1 = [self getNonGender:GenderPP];
    NSString * sex1 = [self getNonGender:sex];
    
    if (![gender1 isEqualToString:sex1]) {
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
        
        if (!EDDCase) {
            if ([sex isEqualToString:@"MALE"] || [sex isEqualToString:@"M"]) {
                sexSegment.selectedSegmentIndex = 0;
            } else if ([sex isEqualToString:@"FEMALE"] || [sex isEqualToString:@"F"]) {
                sexSegment.selectedSegmentIndex = 1;
            }
            
            if ([smoker isEqualToString:@"Y"]) {
                smokerSegment.selectedSegmentIndex = 0;
            } else if ([smoker isEqualToString:@"N"]) {
                smokerSegment.selectedSegmentIndex = 1;
            }
        }
        [self getOccLoadExist];
        [btnOccp setTitle:occuDesc forState:UIControlStateNormal];
        LAOccLoadingField.text = [NSString stringWithFormat:@"%@",occLoading]; //here noob
        
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
        
        [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode andOccpClass:occuClass andSex:sex andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker DiffClient:DiffClient bEDDCase:EDDCase];
    }
    else {
        
        LANameField.text = NamePP;
        sex = [GenderPP substringToIndex:1];
        [self setSexToGlobal];
        
        if (!EDDCase) {
            if ([GenderPP isEqualToString:@"MALE"] || [GenderPP isEqualToString:@"M"]) {
                sexSegment.selectedSegmentIndex = 0;
            } else if ([GenderPP isEqualToString:@"FEMALE"] || [GenderPP isEqualToString:@"F"]) {
                sexSegment.selectedSegmentIndex = 1;
            }
            
            if ([smoker isEqualToString:@"Y"]) {
                smokerSegment.selectedSegmentIndex = 0;
            } else if ([smoker isEqualToString:@"N"])  {
                smokerSegment.selectedSegmentIndex = 1;
            }
        }
        
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
		
        [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode andOccpClass:occuClass andSex:sex andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker DiffClient:DiffClient bEDDCase:EDDCase];
        
        if ( [planChoose isEqualToString:@"HLACP"] && age > 63) { //change to 63 ; by Edwin 8-10-2013
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 63 for this product." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
        }
        else {
			/*
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Prospect's information will synchronize to this SI." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert setTag:1004];
            [alert show];
             */
            
            if ([OccpCodePP isEqualToString:@"OCC01975"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There is no existing plan which can be offered to this occupation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                
            }
            else if ( [planChoose isEqualToString:@"HLACP"] && age > 63){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 63 for this product." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
                alert = Nil;
            }
            else {
                //---------
                sex = GenderPP;
                [self setSexToGlobal];
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
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age must be at least 30 days." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                    [alert setTag:1005];
                    [alert show];
                }
                else if (AgeExceed189Days) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Expected date of delivery cannot be more than 189 days." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                    [alert setTag:1005];
                    [alert show];
                }
                else {
                    [self checkExistRider];
                    if (AgeChanged) {
                        
                        if (arrExistRiderCode.count > 0) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Rider(s) has been deleted due to business rule." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                            [alert setTag:1007];
                            [alert show];
                        }
                        
                        [self updateData:getSINo];
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
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Some Rider(s) has been deleted due to marketing rule." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
                        }
                        
                        [self updateData:getSINo];
                    }
                    else {
                        [self updateData:getSINo];
                    }
                }
            }
        }
    }
    
    AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    if (age < 10) {
        [self checkingPayor];
        if (payorSINo.length == 0) {
            zzz.ExistPayor = NO;
        }
    }else
    {
        zzz.ExistPayor = YES;
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
    
    if(![planChoose isEqualToString:@"HLAWP"])
    {
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
        {
            if([planChoose isEqualToString:@"S100"] || [planChoose isEqualToString:@"L100"]) // termCover for L100 is 100 minus age
            {
                [self getTerm];
                termCover = termCover - age;
            }
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
    }

    
    [self getPlanCodePenta];
    [_delegate BasicSI:getSINo andAge:age andOccpCode:occuCode andCovered:termCover andBasicSA:sumAss andBasicHL:getHL andBasicTempHL:getTempHL andMOP:MOP andPlanCode:planCode andAdvance:advanceYearlyIncome andBasicPlan:planChoose planName:planName];
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
    smoker = [self.requestSmoker description];
    [self setSexToGlobal];
    sexSegment.selectedSegmentIndex = UISegmentedControlNoSegment;
    smokerSegment.selectedSegmentIndex = UISegmentedControlNoSegment;
    if (!EDDCase) {
        if ([sex isEqualToString:@"MALE"]) {
            sexSegment.selectedSegmentIndex = 0;
        } else if ([sex isEqualToString:@"FEMALE"]) {
            sexSegment.selectedSegmentIndex = 1;
        }
        
        if ([smoker isEqualToString:@"Y"]) {
            smokerSegment.selectedSegmentIndex = 0;
        } else if ([smoker isEqualToString:@"N"]) {
            smokerSegment.selectedSegmentIndex = 1;
        }
    }
    
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
    [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode andOccpClass:occuClass andSex:sex andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker DiffClient:DiffClient bEDDCase:EDDCase];
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
    
    if (_ProspectList == nil) {
        self.ProspectList = [[ListingTbViewController alloc] initWithStyle:UITableViewStylePlain];
        _ProspectList.delegate = self;
        self.prospectPopover = [[UIPopoverController alloc] initWithContentViewController:_ProspectList];
    }
    
    CGRect ww = [sender frame];
	ww.origin.y = [sender frame].origin.y + 30;
    
    [self.prospectPopover presentPopoverFromRect:ww inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
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
    if (QQProspect) {
        
        LANameField.enabled = NO;
        LANameField.backgroundColor = [UIColor lightGrayColor];
        LANameField.textColor = [UIColor darkGrayColor];
        sexSegment.enabled = NO;
        
        btnDOB.enabled = NO;
        self.btnDOB.titleLabel.textColor = [UIColor darkGrayColor];
        
        btnOccp.enabled = NO;
        self.btnOccp.titleLabel.textColor = [UIColor darkGrayColor];
        
		QQProspect = NO;
        // Bug fixed 2663
        QQProspect = FALSE;
    }
    else {
        
        LANameField.enabled = YES;
        LANameField.backgroundColor = [UIColor whiteColor];
        LANameField.textColor = [UIColor blackColor];
        sexSegment.enabled = YES;
		smokerSegment.enabled = YES;
        
        btnDOB.enabled = YES;
        self.btnDOB.titleLabel.textColor = [UIColor blackColor];
        
        btnOccp.enabled = YES;
        self.btnOccp.titleLabel.textColor = [UIColor blackColor];
        
        QQProspect = YES;
        // Bug fixed 2663
        QQProspect = TRUE;
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
    
    CGRect ww = [sender frame];
	ww.origin.y = [sender frame].origin.y + 30;
    
    [self.datePopover presentPopoverFromRect:ww  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
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
    EDDCase = FALSE;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
    NSArray *comm = [commDate componentsSeparatedByString: @"/"];
    NSString *commDay = [comm objectAtIndex:0];
    NSString *commMonth = [comm objectAtIndex:1];
    NSString *commYear = [comm objectAtIndex:2];

    
    NSArray *foo = [DOB componentsSeparatedByString: @"/"];
    NSString *birthDay = [foo objectAtIndex: 0];
    NSString *birthMonth = [foo objectAtIndex: 1];
    NSString *birthYear = [foo objectAtIndex: 2];
    
    int yearN = [commYear intValue];
    int yearB = [birthYear intValue];
    int monthN = [commMonth intValue];
    int monthB = [birthMonth intValue];
    int dayN = [commDay intValue];
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
        
        NSDate *endDate = [dateFormatter dateFromString:commDate];
        
        unsigned flags = NSDayCalendarUnit;
        NSDateComponents *difference = [[NSCalendar currentCalendar] components:flags fromDate:startDate toDate:endDate options:0];
        int diffDays = [difference day];
        
        if (diffDays < 0 && diffDays > -190 ) {
            EDDCase = YES;
            AgeExceed189Days = NO;
        }
        else if (diffDays < 0 && diffDays <  -190 ) {
            AgeExceed189Days = YES;
            EDDCase = FALSE;
        }
        else if (diffDays < 30) {
            AgeLess = YES;
            EDDCase = FALSE;
            AgeExceed189Days = NO;
        }
        msgAge = [[NSString alloc] initWithFormat:@"%d days",diffDays];
        
        age = 0;
        ANB = 1;
    }
    else
    {
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        NSString *selectDate = DOB;
        NSDate *startDate = [dateFormatter dateFromString:selectDate];
        
        NSDate *endDate = [dateFormatter dateFromString:commDate];
        
        unsigned flags = NSDayCalendarUnit;
        NSDateComponents *difference = [[NSCalendar currentCalendar] components:flags fromDate:startDate toDate:endDate options:0];
        int diffDays = [difference day];
        
        if (diffDays < 0 && diffDays > -190 ) {
            EDDCase = YES;
            AgeExceed189Days = NO;
        }
        else if (diffDays < 0 && diffDays <  -190 ) {
            AgeExceed189Days = YES;
            EDDCase = NO;
        }
        else if (diffDays < 30) {
            AgeLess = YES;
            AgeExceed189Days = NO;
        }
        age = 0;
        ANB = 1;
    }
}



#pragma mark - UIALERT VIEW DELEGATE
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1001 && buttonIndex == 0) {
        
        if (useExist) {
            [self updateData:getSINo];
        }
        else if (Inserted) {
            [self updateData2];
        }
        else {
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
        
        /* commented as of now, as this checking is only for quick quote @ Edwin 25-03-2014
        if (smoker.length == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Smoker is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
        }
        else */
        if ([OccpCodePP isEqualToString:@"OCC01975"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There is no existing plan which can be offered to this occupation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
			
        }
		else if ( [planChoose isEqualToString:@"HLACP"] && age > 63){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 63 for this product." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
			alert = Nil;
		}
        else {
            //---------
            sex = GenderPP;
            [self setSexToGlobal];
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
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age must be at least 30 days." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert setTag:1005];
                [alert show];
            }
            else if (AgeExceed189Days) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Expected date of delivery cannot be more than 189 days." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert setTag:1005];
                [alert show];
            }
            else {
                [self checkExistRider];
                if (AgeChanged) {
                    
                    if (arrExistRiderCode.count > 0) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Rider(s) has been deleted due to business rule." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                        [alert setTag:1007];
                        [alert show];
                    }
                    
                    [self updateData:getSINo];
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
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Some Rider(s) has been deleted due to marketing rule." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                    
                    [self updateData:getSINo];
                }
                else {
                    [self updateData:getSINo];
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
        } else if ([sex isEqualToString:@"FEMALE"]) {
            sexSegment.selectedSegmentIndex = 1;
        }
        
        if ([smoker isEqualToString:@"Y"]) {
            smokerSegment.selectedSegmentIndex = 0;
        } else if ([smoker isEqualToString:@"N"]) {
            smokerSegment.selectedSegmentIndex = 1;
        }
        
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
							  @"SELECT a.OccpDesc, b.OccLoading, b.CPA, b.PA, a.Class from Adm_Occp_Loading_Penta a LEFT JOIN Adm_Occp_Loading b ON a.OccpCode = b.OccpCode WHERE b.OccpCode = \"%@\"",occuCode];
        
        occLoading = @"";
        NSLog(@"querySQL = %@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                occuDesc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                occLoading =  
                    [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]==nil ? @"" : [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
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
        
        querySQL = [NSString stringWithFormat:
                    @"select OccpCatCode from Adm_OccpCat_Occp where occpcode = '%@' ", occuCode];
        
        //NSLog(@"querySQL = %@", querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                OccuCatCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
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
		
		sqlite3_close(contactDB);
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
                                "VALUES (\"%@\", \"%@\", \"%@\", \"%@\", %@, \"%@\", \"%@\", \"%@\", \"%@\", '%@')", LANameField.text, DOB, sex, occuCode, @"datetime(\"now\", \"+8 hour\")", @"1", @"", @"1", smoker, @"true"];
        
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

-(void)UpdateClient
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
		if (sexSegment.selectedSegmentIndex == 1) {
			sex = @"FEMALE";
		} else {
			sex = @"MALE";
		}
		
        NSString *insertSQL3 = [NSString stringWithFormat:
								@"Update prospect_profile Set ProspectName = '%@', ProspectDOB = '%@', ProspectGender = '%@', "
								" ProspectOccupationCode = '%@', DateModified='%@', ModifiedBy='%@', Smoker= '%@' WHERE indexNo = '%d' ",
								LANameField.text, DOB, sex, occuCode, @"datetime(\"now\", \"+8 hour\")", @"1", smoker, IndexNo];
		
        if(sqlite3_prepare_v2(contactDB, [insertSQL3 UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                
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
    if (QQProspect) {
        [self insertClient];
    }
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:
							   @"INSERT INTO Trad_LAPayor (SINo, CustCode, PTypeCode,Sequence,DateCreated,CreatedBy) VALUES (\"%@\", \"null\",\"LA\",\"1\",\"%@\",\"hla\")", getSINo, commDate];
        
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
        
        NSString *sexI = @"";
        
        if([sex length]>0)
        {
            sexI = sex;
        }
        
        NSString *insertSQL2 = [NSString stringWithFormat:@"INSERT INTO Clt_Profile (CustCode, Name, Smoker, Sex, DOB, ALB, ANB, OccpCode, "
								"DateCreated, CreatedBy,indexNo) VALUES (\"null\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%d\", \"%@\", "
								"\"%@\", \"hla\", \"%d\")",LANameField.text, smoker, sexI, DOB, age, ANB, occuCode, commDate,IndexNo];
		
        //NSLog(@"%@",insertSQL2);
        if(sqlite3_prepare_v2(contactDB, [insertSQL2 UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                savedIndexNo = IndexNo;
                [self setGlobalExistPayor];
                NSLog(@"Done LA2");
                [self getLastIDPayor];
                [self getLastIDProfile];
                
            } else {
                savedIndexNo = -1;
                NSLog(@"Failed LA2");
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" " message:@"Fail in inserting record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
                return NO;
            }
            sqlite3_finalize(statement);
        }
		
        [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode andOccpClass:occuClass andSex:sex andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker DiffClient:DiffClient bEDDCase:EDDCase];
        Inserted = YES;
        AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
        zzz.SICompleted = NO;
        
        sqlite3_close(contactDB);
    }
    return YES;
}

-(void)setGlobalExistPayor
{
    AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    if (age < 10) {
        [self checkingPayor];
        if (payorSINo.length == 0) {
            zzz.ExistPayor = NO;
        }
    }else
    {
        zzz.ExistPayor = YES; //more than age of 10, bypass this logic and set to YES
    }
}

-(BOOL)updateData:(NSString *) SiNo
{
    [self getDiffClient:IndexNo];
    getSINo = SiNo;
    self.requestSINo = SiNo;
	if (QQProspect == TRUE) {
		[self UpdateClient];
	}
	
    BOOL isUpdated = YES;
    //[self storeLAObj];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *currentdate = [dateFormatter stringFromDate:[NSDate date]];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString * sex1 = @"";
        if( [sex length] > 0 )
        {
            sex1 = sex;
        }
        
        NSString *querySQL = [NSString stringWithFormat:
							  @"UPDATE Clt_Profile SET Name=\'%@\', Smoker=\"%@\", Sex=\"%@\", DOB=\"%@\", ALB=\"%d\", ANB=\"%d\", OccpCode=\"%@\", DateModified=\"%@\", ModifiedBy=\"hla\",indexNo=\"%d\", DateCreated = \"%@\"  WHERE id=\"%d\"",
                              LANameField.text,smoker,sex1,DOB,age,ANB,occuCode,currentdate,IndexNo, commDate,idProfile];
        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                if (DiffClient) 
                {
                    NSLog(@"diffClient!");
                    
                    if (age < 10) {
                        [self checkingPayor];
                        if (payorSINo.length == 0) {
//                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please attach Payor as Life Assured is below 10 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
//                            [alert show];
                            
                            AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
                            zzz.ExistPayor = NO;
                        }
                    }
                    [self checkExistRider];
                    if (arrExistRiderCode.count > 0) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Rider(s) has been deleted due to business rule." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                        [alert setTag:1007];
                        [alert show];
                    }
                    if (age > 18) {
                        [self checkingPayor];
                        if (payorSINo.length != 0 && ![payorSINo isEqualToString:@"(null)"]) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Payor's details will be deleted due to life Assured's age is greater or equal to 18." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                            [alert setTag:1003];
                            [alert show];
                        }
                    }
                    if (age < 16) {
                        [self checking2ndLA];
                        if (CustCode2.length != 0) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"2nd Life Assured's details will be deleted due to life Assured's age is less than 16." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                            //[_delegate deleteSecondLAFromDB];
                            [alert setTag:1002];
                            [alert show];
                        }
                    }
                    
                    isUpdated = NO;
                }
                
                else {
                    if (age < 10) {
                        [self checkingPayor];
                        if (payorSINo.length == 0) {
//                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please attach Payor as Life Assured is below 10 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
//                            [alert show];
                            
                            AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
                            zzz.ExistPayor = NO;
                        }
                    }
                    if (age >= 18) {
                        [self checkingPayor];
                        if (payorSINo.length != 0 && ![payorSINo isEqualToString:@"(null)"]) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Payor's details will be deleted due to life Assured's age is greater or equal to 18" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                            [alert setTag:1003];
                            [alert show];
                        }
                    }
                    if (age < 16) {
                        [self checking2ndLA];
                        if (CustCode2.length != 0) {
                            
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"2nd Life Assured's details will be deleted due to life Assured's age is less than 16" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                            [alert setTag:1002];
                            [alert show];
                        }
                    }
                }
                AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ]; 
                zzz.SICompleted = YES; 
                
                savedIndexNo = IndexNo;
                [self setGlobalExistPayor];
            }
            else {
                savedIndexNo = -1;
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" " message:@"Fail in updating record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
                isUpdated = NO;
            }
            
            [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode andOccpClass:occuClass andSex:sex andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker DiffClient:DiffClient bEDDCase:EDDCase];
            
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
        NSString *sex1 = [self getNonGender:sex];
        NSString *querySQL = [NSString stringWithFormat:
                              @"UPDATE Clt_Profile SET Name=\'%@\', Smoker=\"%@\", Sex=\"%@\", DOB=\"%@\", ALB=\"%d\", ANB=\"%d\", OccpCode=\"%@\", DateModified=\"%@\", ModifiedBy=\"hla\",indexNo=\"%d\", DateCreated = \"%@\"  WHERE id=\"%d\"",
                              LANameField.text,smoker,sex1,DOB,age,ANB,occuCode,currentdate,IndexNo, commDate,lastIdProfile];
//		        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                if (age < 10) {
                    [self checkingPayor];
                    if (payorSINo.length == 0) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please attach Payor as Life Assured is below 10 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                        [alert show];
                    }
                }
                
                savedIndexNo = IndexNo;
                [self setGlobalExistPayor];
            }
            else {
                savedIndexNo = -1;
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" " message:@"Fail in updating record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
            }
            
            [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode andOccpClass:occuClass andSex:sex andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker DiffClient:DiffClient bEDDCase:EDDCase];
            
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
							  @"SELECT a.SINo, a.CustCode, b.Name, b.Smoker, b.Sex, b.DOB, b.ALB, b.OccpCode, b.DateCreated, "
							  "b.id, b.IndexNo, a.rowid FROM Trad_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode "
							  "WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Sequence=1",getSINo];
        
		//NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                SINo = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                CustCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                clientName = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                smoker = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                sex = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                [self setSexToGlobal];
                DOB = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                age = sqlite3_column_int(statement, 6);
                occuCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)];
                commDate = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)];
                idProfile = sqlite3_column_int(statement, 9);
                IndexNo = sqlite3_column_int(statement, 10);
                savedIndexNo = IndexNo;
                [self setGlobalExistPayor];
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

-(void) setSexToGlobal
{
    AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ]; //firstLAsex
    zzz.firstLAsex = sex;
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
							  @"SELECT ProspectName, ifnull(ProspectDOB, 000) as ProspectDOB, ProspectGender, ProspectOccupationCode, QQFlag, Smoker, OtherIDType FROM prospect_profile "
							  "WHERE IndexNo= \"%d\"",IndexNo];
        
		//        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NamePP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                DOBPP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                GenderPP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                if ([[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)] isEqualToString:@"EDD"]) {
                    OccpCodePP = @"OCC01360";
                    EDDCase = TRUE;
                }
                else{
                    OccpCodePP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                    EDDCase = FALSE;
                }
                
                smoker = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
				
				NSString *TempQQProspect = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
				if ([TempQQProspect isEqualToString:@"true"]) {
					QQProspect = TRUE;
					sexSegment.enabled = TRUE;
					smokerSegment.enabled = TRUE;
				}
				else{
					QQProspect = FALSE;
					sexSegment.enabled = FALSE;
					smokerSegment.enabled = FALSE;
				}
				
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
                              @"SELECT a.SINo, a.PlanCode, a.PolicyTerm, a.BasicSA, a.PremiumPaymentOption, a.CashDividend, a.YearlyIncome, "
                              "a.AdvanceYearlyIncome, a.HL1KSA, a.HL1KSATerm, a.TempHL1KSA, a.TempHL1KSATerm, b.planname FROM Trad_Details a "
                              "left outer join trad_sys_profile b on a.plancode=b.plancode "
							  "WHERE SINo=\"%@\"",getSINo];
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
                planName = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 12)];
                
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
        
//        NSLog(@"%@",querySQL);
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

-(BOOL)checking2ndLA
{
    BOOL secondLAExist = false;
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT a.SINo, a.CustCode, b.Name, b.Smoker, b.Sex, b.DOB, b.ALB, b.OccpCode, b.DateCreated, b.id FROM Trad_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Sequence=2",getSINo];
        
//        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                secondLAExist = TRUE;
                CustCode2 = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                idProfile2 = sqlite3_column_int(statement, 9);
            } else {
                secondLAExist = FALSE;
                CustCode2 = nil;
                idProfile2 = 0;
//                NSLog(@"error access Trad_LAPayor");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    return secondLAExist;
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
                else if ([planChoose isEqualToString:@"L100"])
                {
                    termCover = maxTerm;
                }
                else if ([planChoose isEqualToString:@"HLAWP"] || [planChoose isEqualToString:@"S100"])
                {
                    termCover = getPolicyTerm;
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
        
        if ([[OccuCatCode stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"UNEMP"]) {
            querySQL = [querySQL stringByAppendingFormat:@" AND j.RiderCode not in (\"CPA\", 'HB') AND j.PlanOption != \"HMM_1000\"   "];
        }
        
        if ([[OccuCatCode stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@"RET"]) {
            querySQL = [querySQL stringByAppendingFormat:@" AND j.RiderCode not in (\"TPDYLA\") "];
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
    [self getProspectData];
    if (useExist) {
        NSLog(@"will update");
        return[self updateData:getSINo];
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
//    NSLog(@"validate Save for LA");
//    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789'@/-. "] invertedSet];
    if (LANameField.text.length <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please select Life Assured from the listing or create new Client Profile in order to create new SI." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        [LANameField becomeFirstResponder];
    }/*
    else if (smoker.length == 0) { commented as of now, as this checking is only for quick quote @ Edwin 25-03-2014
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Smoker is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
    */
    else if ([btnCommDate.titleLabel.text isEqualToString:@"(null)"] || btnCommDate.titleLabel.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Commencement date is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
    else if (AgeLess || (EDDCase && [planChoose isEqualToString:@"S100"])) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age must be at least 30 days." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert setTag:1005];    
        [alert show];
    }
    else if (AgeExceed189Days) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Expected date of delivery cannot be more than 189 days." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert setTag:1005];
        [alert show];
    }
    else if ([planChoose isEqualToString:@"HLACP"] &&  age > 63) { //changed to 63 ; by Edwin 8-10-2013
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 63 for this product." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
    else if ( (occuCode.length == 0 || btnOccp.titleLabel.text.length == 0) && [sex length]>0 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please select an Occupation Description." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
    else if ([occuCode isEqualToString:@"OCC01975"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There is no existing plan which can be offered to this occupation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
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
    
//    NSLog(@"sino == %@    custcode == %@",SINo,CustCode);
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
		
        NSString *querySQL = [NSString stringWithFormat: @"SELECT Name,Smoker,Sex,DOB,ALB,ANB,OccpCode,DateModified,ModifiedBy,indexNo,DateCreated FROM Clt_Profile WHERE CustCode = \"%@\" ",CustCode];
        
//        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                int rowCount = sqlite3_column_count(statement);
                
                for (int i = 0; i<rowCount; i++) {
                    [tempSIDict setObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, i)] forKey:[NSString stringWithFormat:@"key%d",i]];
//                    NSLog(@"%@:[%@]",[NSString stringWithFormat:@"key%d",i], [tempSIDict objectForKey:[NSString stringWithFormat:@"key%d",i]]);
                }
                
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

-(void)listing:(ListingTbViewController *)inController didSelectIndex:(NSString *)aaIndex andName:(NSString *)aaName andDOB:(NSString *)aaDOB andGender:(NSString *)aaGender andOccpCode:(NSString *)aaCode andSmoker:(NSString *)aaSmoker andMaritalStatus:(NSString *)aaMaritalStatus;
{
    int selectedIndex = [aaIndex intValue];
    
    tempSmoker = smoker;
    tempSex = sex;
    tempDOB = DOB;
    tempAge =age;
    tempOccCode = occuCode;
    tempIndexNo = IndexNo;
    tempCommDate = commDate;
    tempIdProfile = idProfile;
    
    if (commDate.length == 0) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        commDate = [dateFormatter stringFromDate:[NSDate date]];
    }
    
//    NSLog(@"%@",planChoose);
    
    if([aaDOB length]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"The selected client is not applicable for this SI product."
													   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
		[alert show];
		alert = Nil;
        return;
    }

	
    DOB = aaDOB;
    [self calculateAge];
    
	LANameField.enabled = NO;
	LANameField.backgroundColor = [UIColor lightGrayColor];
	LANameField.textColor = [UIColor darkGrayColor];
	
	sexSegment.enabled = NO;
	
	btnDOB.enabled = NO;
	self.btnDOB.titleLabel.textColor = [UIColor darkGrayColor];
	
	btnOccp.enabled = NO;
	self.btnOccp.titleLabel.textColor = [UIColor darkGrayColor];
	
	QQProspect = NO;
	
    if ([planChoose isEqualToString:@"HLACP"] && age > 63)
	{
		smoker = tempSmoker;
		sex = tempSex;
        [self setSexToGlobal];
		DOB = tempDOB;
		age = tempAge;
		occuCode = tempOccCode;
		IndexNo = tempIndexNo;
		commDate = tempCommDate;
		idProfile = tempIdProfile;
		[self.prospectPopover dismissPopoverAnimated:YES];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 63 for this product."
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
		[alert show];
		alert = Nil;
		
		return;
		
	}

//    NSLog(@"aaIndex=%@, IndexNo=%d, prevIndexNo=%d, savedIndexNo=%d", aaIndex,IndexNo,prevIndexNo,savedIndexNo);
    /*
    if ([NSString stringWithFormat:@"%d",IndexNo]!= NULL) {
        smoker = @"N";
        DiffClient = YES;
    }else
    {
        DiffClient = NO;
    }*/
    

    
    
    if (SINo) {
        useExist = YES;
		
    }
    else{
        useExist = NO;
		
    }
    statusLabel.text = @"";
    prevIndexNo = IndexNo;
    IndexNo = [aaIndex intValue];
    
    AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    zzz.ExistPayor = YES;
    /*
     if (age > 63) { //changed to 63 ; by Edwin 8-10-2013
     //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Life Assured's age exceed HLA Income Builder maximum entry age (70 years old)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age Last Birthday must be less than or equal to 63 for this product." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
     [alert show];
     return;
     }
     else*/
    
    NSString *aaGen = [self getNonGender:aaGender];
    
    //NSLog(@"zzz.firstLAsex=%@, [aaGender substringToIndex:1]=%@", [zzz.firstLAsex substringToIndex:1],aaGen);
    
    if([zzz.planChoose isEqualToString:@"L100"] && [self checking2ndLA] && [[zzz.secondLAsex substringToIndex:1] isEqualToString:aaGen])
    {
        IndexNo = prevIndexNo;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"You can't select the First Life Assured with the same sex as the Second Life Assured." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else 
	{
        if( savedIndexNo==selectedIndex )
        {
            //do nothing, user selected the same LA that has been saved
            DiffClient = NO;
        }else
        {
            if(savedIndexNo==-1) //SI is new, savedIndexNo is -1
            {
                DiffClient = NO; //thus DiffClient=NO
            }else
            {
                DiffClient = YES;
            }
        }
        
        LANameField.text = aaName;
        sex = aaGender;
        [self setSexToGlobal];
        sexSegment.selectedSegmentIndex = UISegmentedControlNoSegment;
        smokerSegment.selectedSegmentIndex = UISegmentedControlNoSegment;
		//        [smokerSegment setSelectedSegmentIndex:UISegmentedControlNoSegment];
		sexSegment.enabled = FALSE;
        smokerSegment.enabled = FALSE;
        if (!EDDCase) {
            if ([sex isEqualToString:@"MALE"] || [sex isEqualToString:@"M"] || EDDCase == TRUE ) {
                sexSegment.selectedSegmentIndex = 0;
            } else {
                sexSegment.selectedSegmentIndex = 1;
            }
            
            if ([aaSmoker isEqualToString:@"N"] || EDDCase == TRUE) {
                smokerSegment.selectedSegmentIndex = 1;
            }
            else{
                smokerSegment.selectedSegmentIndex = 0;
            }
        }
//        NSLog(@"sex:%@",sex);
        
        
		
        [btnDOB setTitle:DOB forState:UIControlStateNormal];
        LAAgeField.text = [[NSString alloc] initWithFormat:@"%d",age];
        [self.btnCommDate setTitle:commDate forState:UIControlStateNormal];
        
        if (EDDCase == TRUE) {
            occuCode = @"OCC01360";
        }
        else{
            occuCode = aaCode;
        }
        
        
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
        
        [self.prospectPopover dismissPopoverAnimated:YES];
        
        zzz.SICompleted = NO; //added by Edwin 9-10-2013
	}
    

	
}

-(void) getDiffClient:(int)selectedIndex
{
    if( savedIndexNo==selectedIndex )
    {
        //do nothing, user selected the same LA that has been saved
        DiffClient = NO;
    }else
    {
        if(savedIndexNo==-1) //SI is new, savedIndexNo is -1
        {
            DiffClient = NO; //thus DiffClient=NO
        }else
        {
            DiffClient = YES;
        }
    }   
}

-(void)datePick:(DateViewController *)inController strDate:(NSString *)aDate strAge:(NSString *)aAge intAge:(int)bAge intANB:(int)aANB
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *selectDate = aDate;
    NSDate *startDate = [dateFormatter dateFromString:selectDate];
    
    NSString *todayDate = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *endDate = [dateFormatter dateFromString:todayDate];
    
    unsigned flags = NSDayCalendarUnit;
    NSDateComponents *difference = [[NSCalendar currentCalendar] components:flags fromDate:startDate toDate:endDate options:0];
    int diffDays = [difference day];
    
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
            if (diffDays > 182 ) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Maximum backdating days allowed is 182 days." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];

            }
            else{
                [self.btnCommDate setTitle:aDate forState:UIControlStateNormal];
                commDate = aDate;
            }
            
        }
        
        if (DOB.length != 0 || btnDOB.titleLabel.text.length != 0) {
            [self calculateAge];
            LAAgeField.text = [[NSString alloc] initWithFormat:@"%d",age];
        }
        
        [self.datePopover dismissPopoverAnimated:YES];
        date2 = NO;
    }
    

    


    
    
    [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode andOccpClass:occuClass andSex:sex andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker DiffClient:DiffClient bEDDCase:EDDCase];
	
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
    [self setOutletDone:nil];
    [super viewDidUnload];
}



@end
