//
//  EverLAViewController.m
//  iMobile Planner
//
//  Created by infoconnect on 6/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "EverLAViewController.h"
#import "AppDelegate.h"
#import "EverSecondLAViewController.h"
#import "EverSeriesMasterViewController.h"
#import "EverPayorViewController.h"

@interface EverLAViewController ()

@end

@implementation EverLAViewController
@synthesize txtName, segGender, segSmoker,segStatus, MaritalStatus, requestMaritalStatus;
@synthesize txtALB, txtCommDate, txtDOB;
@synthesize txtOccpLoad;
@synthesize txtCPA;
@synthesize txtPA;
@synthesize statusLabel;
@synthesize sex,smoker,age,ANB,DOB,jobDesc,SINo,CustCode;
@synthesize occDesc,occCode,occLoading,payorSINo,occCPA_PA, occLoading_UL;
@synthesize popOverController,requestSINo,clientName,occuCode,occuDesc,CustCode2,payorCustCode;
@synthesize commDate,occuClass,IndexNo;
@synthesize NamePP,DOBPP,GenderPP,OccpCodePP,occPA,headerTitle;
@synthesize getSINo,btnDOB, btnOccpDesc, getBumpMode;
@synthesize getHL,getHLTerm,getPolicyTerm,getSumAssured,getHLPct,getHLPctTerm;
@synthesize termCover,planCode,arrExistRiderCode,arrExistPlanChoice,getPrem;
@synthesize prospectPopover = _prospectPopover;
@synthesize idPayor,idProfile,idProfile2,lastIdPayor,lastIdProfile,planChoose,ridCode,atcRidCode,atcPlanChoice;
@synthesize basicSINo,requestCommDate,requestIndexNo,requestLastIDPay,requestLastIDProf,requestSex,requestSmoker, strPA_CPA,payorAge;
@synthesize btnCommDate, btnEnable;
@synthesize LADate = _LADate;
@synthesize datePopover = _datePopover;
@synthesize dobPopover = _dobPopover;
@synthesize OccupationList = _OccupationList;
@synthesize OccupationListPopover = _OccupationListPopover;
@synthesize delegate = _delegate;
@synthesize ProspectList = _ProspectList;


id dobtemp, temp;
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
	
	getSINo = [self.requestSINo description];
	//[btnOccpDesc setBackgroundColor:[UIColor lightGrayColor]];
	txtDOB.hidden = YES;
	txtCommDate.hidden = YES;
	btnDOB.enabled = NO;
	
	AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
	zzz.EverMessage = @"";
	
	if (getSINo.length != 0) {
		[self checkingExisting];
        [self checkingExistingSI];
	
		if (![commDate isEqualToString:@""]) {
			[btnCommDate setTitle:commDate forState:UIControlStateNormal];
			NSDateFormatter* df = [[NSDateFormatter alloc] init];
			[df setDateFormat:@"dd/MM/yyyy"];
			NSDate* d2 = [[NSDate date] dateByAddingTimeInterval:8 *60 * 60 ];;
			NSDate* d = [df dateFromString:commDate];
			NSDate *fromDate;
			NSDate *toDate;
			
			NSCalendar *calendar = [NSCalendar currentCalendar];
			[calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
						 interval:NULL forDate:d];
			[calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
						 interval:NULL forDate:d2];
			
			NSDateComponents *difference = [calendar components:NSDayCalendarUnit
													   fromDate:fromDate toDate:toDate options:0];
			
			
			if ([difference day ] > 0) {
				NSLog(@"more than %d day", [difference day]);
				
				zzz.EverMessage = @"Please note that the commencement date of this sales illustration is earlier than today’s date. "
				"You may want to update the commencement date as sustainability, premium payable and projected values may change due "
				"to different commencement date. Please note the commencement date in this sales illustration is not the commencement "
				"date for the policy as backdating is not allowed in Investment-Linked Plan. Kindly be reminded that the SI created "
				"earlier than 30 days prior to submission date is not allowed for submission";
			}
			else{
				zzz.EverMessage = @"";
			}
			df = Nil;
			d2 = Nil, d= Nil, fromDate=Nil,toDate=Nil,calendar = Nil, difference = Nil;
		}
		
		if (basicSINo.length != 0) {
            [self getExistingBasic];
            [self getTerm];
            [self toogleExistingBasic];
        }
		
		if (SINo.length != 0) {
            [self getProspectData];
            [self getSavedField];
			//txtDOB.text = DOB;
			[btnDOB setTitle:DOB forState:UIControlStateNormal];
			
            NSLog(@"will use existing data");
        }
		if(age < 17){
			segSmoker.enabled = FALSE;
		}
	}
	else{
		MaritalStatus = @"S";
		NSLog(@"SINo not exist!");
	}
	
	if (requestIndexNo != 0) { //user select LA but havent created the SI basic plan yet
        [self tempView];
    }
	

	
	[self checking2ndLA];
	
	if (CustCode2.length != 0) {
		
		EverSecondLAViewController *ccc = [[EverSecondLAViewController alloc] init ];
		ccc.requestLAIndexNo = requestIndexNo;
		ccc.requestCommDate = commDate;
		ccc.requestSINo = getSINo;
		ccc.LAView = @"1";
		ccc.delegate = (EverSeriesMasterViewController *)_delegate;
		
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
		
		EverPayorViewController *ggg = [[EverPayorViewController alloc] init ];
		ggg.requestLAIndexNo = requestIndexNo;
		ggg.requestLAAge = payorAge;
		ggg.requestCommDate = commDate;
		ggg.requestSINo = getSINo;
		ggg.LAView = @"1";
		ggg.delegate = (EverSeriesMasterViewController *)_delegate;
		
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return YES;
    Saved = NO;
}



#pragma mark - handle Data


-(void)toogleExistingBasic
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE UL_Details SET PolicyTerm=\"%d\", UpdatedAt=%@ "
							  "WHERE SINo=\"%@\"",termCover,  @"datetime(\"now\", \"+8 hour\")", getSINo];
        
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
    
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    NSString *sumAss = [formatter stringFromNumber:[NSNumber numberWithDouble:getSumAssured]];
    sumAss = [sumAss stringByReplacingOccurrencesOfString:@"," withString:@""];
	
	[_delegate BasicSI:getSINo andAge:age andOccpCode:occuCode andCovered:termCover andBasicSA:sumAss andBasicHL:getHL
		andBasicHLTerm:getHLTerm andBasicHLPct:getHL andBasicHLPctTerm:getHLTerm andPlanCode:planChoose andBumpMode:getBumpMode];

    AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    zzz.SICompleted = YES;
}

-(void)checking2ndLA
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT a.SINo, a.CustCode, b.Name, b.Smoker, b.Sex, b.DOB, b.ALB, b.OccpCode, b.DateCreated, "
							  "b.id FROM UL_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode "
							  "WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Seq=2",getSINo];
        
		//        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                CustCode2 = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                idProfile2 = sqlite3_column_int(statement, 9);
            } else {
                NSLog(@"No LA or Payor");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)tempView
{
    IndexNo = requestIndexNo;
    lastIdPayor = requestLastIDPay;
    lastIdProfile = requestLastIDProf;
    [self getProspectData];
    
	txtName.text = NamePP;
    DOB = DOBPP;
    commDate = [self.requestCommDate description];
    [self calculateAge];
    [btnDOB setTitle:DOBPP forState:UIControlStateNormal];
	//txtDOB.text = DOBPP;
	txtALB.text = [[NSString alloc] initWithFormat:@"%d",age];
	btnCommDate.titleLabel.text = commDate;
    
    sex = [self.requestSex description];
    if ([sex isEqualToString:@"MALE"] || [sex isEqualToString:@"M"] ) {
		segGender.selectedSegmentIndex = 0;
    } else {
		segGender.selectedSegmentIndex = 1;
    }
    NSLog(@"sex:%@",sex);
    
    smoker = [self.requestSmoker description];
    if ([smoker isEqualToString:@"Y"]) {
		segSmoker.selectedSegmentIndex = 0;
    } else {
		segSmoker.selectedSegmentIndex = 1;
    }
    NSLog(@"smoker:%@",smoker);
    
	MaritalStatus = [self.requestMaritalStatus description];
	if ([MaritalStatus isEqualToString:@"S"]) {
		segStatus.selectedSegmentIndex = 0;
    }
	else if ([MaritalStatus isEqualToString:@"M"]) {
		segStatus.selectedSegmentIndex = 1;
    }
	else if ([MaritalStatus isEqualToString:@"D"]) {
		segStatus.selectedSegmentIndex = 2;
    }
	else{
		segStatus.selectedSegmentIndex = 3;
	}
    NSLog(@"Marital Status:%@",MaritalStatus);
	
    occuCode = OccpCodePP;
    [self getOccLoadExist];
    [btnOccpDesc setTitle:occuDesc forState:UIControlStateNormal];
	txtOccpLoad.text = [NSString stringWithFormat:@"%@",occLoading_UL];
    
    if (occCPA_PA == 0) {
		txtCPA.text = @"D";
    } else {
		txtCPA.text = [NSString stringWithFormat:@"%d",occCPA_PA];
    }
    
    if (occPA == 0) {
		txtPA.text = @"D";
    } else {
		txtPA.text = [NSString stringWithFormat:@"%d",occPA];
    }
    [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode
			andOccpClass:occuClass andSex:[sex substringToIndex:1] andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker andOccpCPA:strPA_CPA
			andLADOB:DOB andLAOccLoading:occLoading_UL];
    Inserted = YES;
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
        AgeChanged = YES;
    }
    
    if (![occuCode isEqualToString:OccpCodePP]) {
        valid = FALSE;
        JobChanged = YES;
    }
    
    if (valid) {
        
		txtName.text = clientName;
        [btnDOB setTitle:DOB forState:UIControlStateNormal];
		txtALB.text = [[NSString alloc] initWithFormat:@"%d",age];
		self.btnCommDate.titleLabel.text =  commDate;
        
        if ([sex isEqualToString:@"MALE"] || [sex isEqualToString:@"M"]) {
            segGender.selectedSegmentIndex = 0;
        } else {
            segGender.selectedSegmentIndex = 1;
        }
        NSLog(@"sex:%@",sex);
        
        if ([smoker isEqualToString:@"Y"]) {
			segSmoker.selectedSegmentIndex = 0;
        } else {
			segSmoker.selectedSegmentIndex = 1;
        }
        NSLog(@"smoker:%@",smoker);
		
		if ([MaritalStatus isEqualToString:@"S"]) {
			segStatus.selectedSegmentIndex = 0;
		}
		else if ([MaritalStatus isEqualToString:@"M"]) {
			segStatus.selectedSegmentIndex = 1;
		}
		else if ([MaritalStatus isEqualToString:@"D"]) {
			segStatus.selectedSegmentIndex = 2;
		}
		else{
			segStatus.selectedSegmentIndex = 3;
		}
        
        [self getOccLoadExist];
        [btnOccpDesc setTitle:occuDesc forState:UIControlStateNormal];
		txtOccpLoad.text = [NSString stringWithFormat:@"%@",occLoading_UL];
        
        if (occCPA_PA == 0) {
			txtCPA.text = @"D";
        } else {
			txtCPA.text = [NSString stringWithFormat:@"%d",occCPA_PA];
        }
        
        if (occPA == 0) {
			txtPA.text = @"D";
        } else {
			txtPA.text = [NSString stringWithFormat:@"%d",occPA];
        }
        
        [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode andOccpClass:occuClass
					  andSex:[sex substringToIndex:1] andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker andOccpCPA:strPA_CPA andLADOB:DOB
					andLAOccLoading:occLoading_UL];
    }
    else {
        
		txtName.text = NamePP;
        sex = GenderPP;
        
        if ([GenderPP isEqualToString:@"M"] || [GenderPP isEqualToString:@"MALE"] ) {
			segGender.selectedSegmentIndex = 0;
        } else {
			segGender.selectedSegmentIndex = 1;
        }
        NSLog(@"sex:%@",GenderPP);
        
        if ([smoker isEqualToString:@"Y"]) {
			segSmoker.selectedSegmentIndex = 0;
        } else if ([smoker isEqualToString:@"N"]) {
			segSmoker.selectedSegmentIndex = 1;
        }
        NSLog(@"smoker:%@",smoker);
        
		if ([MaritalStatus isEqualToString:@"S"]) {
			segStatus.selectedSegmentIndex = 0;
		}
		else if ([MaritalStatus isEqualToString:@"M"]) {
			segStatus.selectedSegmentIndex = 1;
		}
		else if ([MaritalStatus isEqualToString:@"D"]) {
			segStatus.selectedSegmentIndex = 2;
		}
		else{
			segStatus.selectedSegmentIndex = 3;
		}
		
        DOB = DOBPP;
        [self calculateAge];
		
        [btnDOB setTitle:DOB forState:UIControlStateNormal];
		txtALB.text = [[NSString alloc] initWithFormat:@"%d",age];
        btnCommDate.titleLabel.text= commDate;
        
        occuCode = OccpCodePP;
        [self getOccLoadExist];
        [btnOccpDesc setTitle:occuDesc forState:UIControlStateNormal];
		txtOccpLoad.text = [NSString stringWithFormat:@"%@",occLoading_UL];
        
        if (occCPA_PA == 0) {
			txtCPA.text = @"D";
        } else {
			txtCPA.text = [NSString stringWithFormat:@"%d",occCPA_PA];
        }
        
        if (occPA == 0) {
			txtPA.text = @"D";
        } else {
			txtPA.text = [NSString stringWithFormat:@"%d",occPA];
        }
		
        [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode
				andOccpClass:occuClass andSex:[sex substringToIndex:1] andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker andOccpCPA:strPA_CPA
				andLADOB:DOB andLAOccLoading:occLoading_UL];
        
        if (age > 100) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
															message:@"Age Last Birthday must be less than or equal to 100 for this product." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
        }
        else {
			
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
															message:@"Prospect's information will synchronize to this SI." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
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



-(void)getTerm
{
	int maxTerm  =  100;
    termCover = maxTerm - age;
}


-(void)getOccLoadExist
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT a.OccpDesc, b.OccLoading, b.CPA, b.PA, b.Class, replace(a.occloading_ul, '0.0', 'STD') as Occloading_UL from Adm_Occp_Loading_Penta a LEFT JOIN Adm_Occp_Loading b ON a.OccpCode = b.OccpCode WHERE b.OccpCode = \"%@\"",occuCode];
        
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
				occLoading_UL =  [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
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

-(void)insertData
{
	if (isNewClient) {
        [self insertClient];
    }
	
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:
							   @"INSERT INTO UL_LAPayor (PTypeCode,Seq,DateCreated,CreatedBy) VALUES (\"LA\",\"1\",\"%@\","
							   "\"hla\")",commDate];

        if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Done Ever LA");
            }
            else {
                NSLog(@"Failed LA");
            }
            sqlite3_finalize(statement);
        }
        
        NSString *insertSQL2 = [NSString stringWithFormat:@"INSERT INTO Clt_Profile (Name, Smoker, Sex, DOB, ALB, ANB, OccpCode, "
								"DateCreated, CreatedBy,indexNo, MaritalStatusCode) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%d\", \"%d\", \"%@\", "
								"\"%@\", \"hla\", \"%d\", '%@')",txtName.text, smoker, sex, DOB, age, ANB, occuCode, commDate,IndexNo, MaritalStatus];


        if(sqlite3_prepare_v2(contactDB, [insertSQL2 UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Done Ever LA2");
                [self getLastIDPayor];
                [self getLastIDProfile];
                
            } else {
                NSLog(@"Failed LA2");
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Fail in inserting record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
            }
            sqlite3_finalize(statement);
        }
		
        [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode
				andOccpClass:occuClass andSex:[sex substringToIndex:1] andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker andOccpCPA:strPA_CPA
				andLADOB:DOB andLAOccLoading:occLoading_UL];
        Inserted = YES;
        AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
        zzz.SICompleted = NO;
        
        sqlite3_close(contactDB);
    }
}

-(void)insertClient
{
    sqlite3_stmt *statement;
	BOOL bInsert = FALSE;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
		if (segGender.selectedSegmentIndex ==  0) {
			sex = @"MALE";
		}
		else{
			sex = @"FEMALE";
		}
		
        NSString *insertSQL3 = [NSString stringWithFormat:
								@"INSERT INTO prospect_profile(\"ProspectName\", \"ProspectDOB\", \"ProspectGender\", "
								"\"ProspectOccupationCode\", \"DateCreated\", \"CreatedBy\", \"DateModified\",\"ModifiedBy\", "
								"\"Smoker\", 'QQFlag') "
								"VALUES (\"%@\", \"%@\", \"%@\", \"%@\", %@, \"%@\", \"%@\", \"%@\", \"%@\", '%@')",
								txtName.text, DOB, sex, occuCode, @"datetime(\"now\", \"+8 hour\")", @"1", @"", @"1", smoker, @"true"];
		
        if(sqlite3_prepare_v2(contactDB, [insertSQL3 UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
				bInsert = TRUE;
                
            } else {
                NSLog(@"Failed client");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
	
	if (bInsert == TRUE) {
		[self GetLastID];
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


-(void)updateData
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *currentdate = [dateFormatter stringFromDate:[NSDate date]];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
							  @"UPDATE Clt_Profile SET Name=\"%@\", Smoker=\"%@\", Sex=\"%@\", DOB=\"%@\", ALB=\"%d\", "
							  "ANB=\"%d\", OccpCode=\"%@\", DateModified=\"%@\", ModifiedBy=\"hla\",indexNo=\"%d\", "
							  "DateCreated = \"%@\", MaritalStatusCode = '%@'  WHERE id=\"%d\"",
                              txtName.text,smoker,sex,DOB,age,ANB,occuCode,currentdate,IndexNo, commDate,MaritalStatus, idProfile];
		//        NSLog(@"%@",querySQL);
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
						[self deleteRider];
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Rider(s) has been deleted due to business rule." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                        //[alert setTag:1007];
                        [alert show];
                    }
                    if (age > 18) {
                        [self checkingPayor];
                        if (payorSINo.length != 0) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Payor's details will be deleted due to life Assured age is greater or equal to 18." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                            [alert setTag:1003];
                            [alert show];
                        }
                    }
					/*
                    if (age < 16) {
                        [self checking2ndLA];
                        if (CustCode2.length != 0) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"2nd Life Assured's details will be deleted due to life Assured age is less than 16." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                            [alert setTag:1002];
                            [alert show];
                        }
                    }
					 */
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
                        if (payorSINo.length != 0) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Payor's details will be deleted due to life Assured age is greater or equal to 18" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                            [alert setTag:1003];
                            [alert show];
                        }
                    }
					/*
                    if (age < 16) {
                        [self checking2ndLA];
                        if (CustCode2.length != 0) {
                            
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"2nd Life Assured's details will be deleted due to life Assured age is less than 16" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                            [alert setTag:1002];
                            [alert show];
                        }
                    }
					 */
                }
            }
            else {
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Fail in updating record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
            }
            
            [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode andOccpClass:occuClass
						  andSex:[sex substringToIndex:1] andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker andOccpCPA:strPA_CPA andLADOB:DOB
						andLAOccLoading:occLoading_UL];
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
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
                              @"UPDATE Clt_Profile SET Name=\"%@\", Smoker=\"%@\", Sex=\"%@\", DOB=\"%@\", ALB=\"%d\", "
							  "ANB=\"%d\", OccpCode=\"%@\", DateModified=\"%@\", ModifiedBy=\"hla\",indexNo=\"%d\", "
							  "DateCreated = \"%@\", maritalStatusCode = '%@'  WHERE id=\"%d\"",
                              txtName.text,smoker,sex,DOB,age,ANB,occuCode,currentdate,IndexNo, commDate, MaritalStatus, lastIdProfile];
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
            
            [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode andOccpClass:occuClass
						  andSex:[sex substringToIndex:1] andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker andOccpCPA:strPA_CPA andLADOB:DOB
						andLAOccLoading:occLoading_UL];
            
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
							  "b.id, b.IndexNo, a.rowid, b.MaritalStatusCode FROM UL_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode "
							  "WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Seq=1",getSINo];

		//NSLog(@"%@", querySQL);
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
				const char *getMS = (const char*)sqlite3_column_text(statement, 12);
				MaritalStatus = getMS == NULL ? nil : [[NSString alloc] initWithUTF8String:getMS];
                NSLog(@"age:%d, indexNo:%d, idPayor:%d, idProfile:%d",age,IndexNo,idPayor,idProfile);
				
            } else {
                NSLog(@"error access UL_LAPayor");
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
    sqlite3_stmt *statement;
    NSString *tempSINo;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT a.SINo, b.id FROM UL_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode "
							  "WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Seq=1",getSINo];
        
		       // NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                tempSINo = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                idProfile = sqlite3_column_int(statement, 1);
				//                NSLog(@"tempSINo:%@, length:%d",tempSINo, tempSINo.length);
                
            } else {
                NSLog(@"error access UL_Trad_LAPayor");
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
        NSString *querySQL = [NSString stringWithFormat:@"SELECT SINo FROM UL_Details WHERE SINo=\"%@\"",getSINo];
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
		// add in QQFLAG
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT ProspectName, ProspectDOB, ProspectGender, ProspectOccupationCode FROM prospect_profile "
							  "WHERE IndexNo= \"%d\"",IndexNo];
        
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
							  @"SELECT SINo, planCode, CovPeriod, BasicSA, ATPrem, "
							  "HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, BumpMode FROM UL_Details "
							  "WHERE SINo=\"%@\"",getSINo];
		
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                basicSINo = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                planChoose = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                getPolicyTerm = sqlite3_column_int(statement, 2);
                getSumAssured = sqlite3_column_double(statement, 3);
				getPrem = sqlite3_column_double(statement, 4);
                const char *getHL2 = (const char*)sqlite3_column_text(statement, 5);
                getHL = getHL2 == NULL ? nil : [[NSString alloc] initWithUTF8String:getHL2];
                getHLTerm = sqlite3_column_int(statement, 6);
                const char *getTempHL2 = (const char*)sqlite3_column_text(statement, 7);
                getHLPct = getTempHL2 == NULL ? nil : [[NSString alloc] initWithUTF8String:getTempHL2];
                getHLPctTerm = sqlite3_column_int(statement, 8);
				getBumpMode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)];
                
            } else {
                NSLog(@"error access UL_Details");
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
							  @"SELECT a.SINo, a.CustCode, b.Name, b.Smoker, b.Sex, b.DOB, b.ALB, b.OccpCode, b.id FROM "
							  "UL_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode WHERE a.SINo=\"%@\" AND "
							  "a.PTypeCode=\"PY\" AND a.Seq=1",getSINo];
        
		        //NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                payorSINo = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                payorCustCode = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
				payorAge = sqlite3_column_int(statement, 6);
                
            } else {
                NSLog(@"no Payor ");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)delete2ndLA
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM UL_LAPayor WHERE CustCode=\"%@\"",CustCode2];
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
                [_delegate secondLADelete];
                
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
        NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM UL_LAPayor WHERE CustCode=\"%@\"",payorCustCode];
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

-(void)checkExistRider
{
    arrExistRiderCode = [[NSMutableArray alloc] init];
    arrExistPlanChoice = [[NSMutableArray alloc] init];
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT RiderCode, PlanOption FROM UL_Rider_Details WHERE SINo=\"%@\"",getSINo];
		
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
                        "(SELECT a.RiderCode,b.RiderDesc FROM Trad_Sys_RiderComb a LEFT JOIN UL_Rider_Profile b ON a.RiderCode=b.RiderCode WHERE a.PlanCode=\"%@\" AND a.RiderCode != \"MG_IV\")j "
                        "LEFT JOIN UL_Rider_Mtn k ON j.RiderCode=k.RiderCode WHERE k.MinAge <= \"%d\" AND k.MaxAge >= \"%d\"", planChoose, age, age];
        }
        else if (self.occuClass > 4) {
            querySQL = [NSString stringWithFormat:
                        @"SELECT j.*, k.MinAge, k.MaxAge FROM"
                        "(SELECT a.RiderCode,b.RiderDesc FROM Trad_Sys_RiderComb a LEFT JOIN UL_Rider_Profile b ON a.RiderCode=b.RiderCode WHERE a.PlanCode=\"%@\" AND a.RiderCode != \"CPA\" AND a.RiderCode != \"PA\" AND a.RiderCode != \"HMM\" AND a.RiderCode != \"HB\" AND a.RiderCode != \"MG_II\" AND a.RiderCode != \"MG_IV\" AND a.RiderCode != \"HSP_II\")j "
                        "LEFT JOIN UL_Rider_Mtn k ON j.RiderCode=k.RiderCode WHERE k.MinAge <= \"%d\" AND k.MaxAge >= \"%d\"",planChoose, age, age];
        }
		else if ([strPA_CPA isEqualToString:@"D"]){
			querySQL = [NSString stringWithFormat:
                        @"SELECT j.*, k.MinAge, k.MaxAge FROM"
                        "(SELECT a.RiderCode,b.RiderDesc FROM Trad_Sys_RiderComb a LEFT JOIN UL_Rider_Profile b ON a.RiderCode=b.RiderCode WHERE a.PlanCode=\"%@\" AND a.RiderCode != \"MG_IV\" AND a.RiderCode != \"CPA\")j "
                        "LEFT JOIN UL_Rider_Mtn k ON j.RiderCode=k.RiderCode WHERE k.MinAge <= \"%d\" AND k.MaxAge >= \"%d\"", planChoose, age, age];
		}
        else {
            querySQL = [NSString stringWithFormat:
                        @"SELECT j.*, k.MinAge, k.MaxAge FROM"
                        "(SELECT a.RiderCode,b.RiderDesc FROM Trad_Sys_RiderComb a LEFT JOIN UL_Rider_Profile b ON a.RiderCode=b.RiderCode WHERE a.PlanCode=\"%@\")j "
                        "LEFT JOIN UL_Rider_Mtn k ON j.RiderCode=k.RiderCode WHERE k.MinAge <= \"%d\" AND k.MaxAge >= \"%d\"",planChoose, age, age];
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

-(void)deleteRider
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM UL_Rider_Details WHERE SINo=\"%@\"",getSINo];
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
        NSString *querySQL = [NSString stringWithFormat: @"SELECT rowid FROM UL_LAPayor ORDER by rowid desc limit 1"];
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


#pragma mark - Delegate

-(void)datePick:(DateViewController *)inController strDate:(NSString *)aDate strAge:(NSString *)aAge intAge:(int)bAge intANB:(int)aANB{
	if (date1) {
        if (aDate == NULL) {
            [btnDOB setTitle:dobtemp forState:UIControlStateNormal];
            DOB = dobtemp;
            [self calculateAge];
			txtALB.text = [[NSString alloc] initWithFormat:@"%d",age];
            
        } else {
            [btnDOB setTitle:aDate forState:UIControlStateNormal];
            DOB = aDate;
            [self calculateAge];
			txtALB.text = [[NSString alloc] initWithFormat:@"%d",bAge];
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
			txtALB.text = [[NSString alloc] initWithFormat:@"%d",age];
        }
        
        [self.datePopover dismissPopoverAnimated:YES];
        date2 = NO;
    }
    [_delegate LAIDPayor:lastIdPayor andIDProfile:lastIdProfile andAge:age andOccpCode:occuCode andOccpClass:occuClass
				  andSex:[sex substringToIndex:1] andIndexNo:IndexNo andCommDate:commDate andSmoker:smoker andOccpCPA:txtCPA.text andLADOB:btnDOB.titleLabel.text andLAOccLoading:txtOccpLoad.text];
}

-(void)listing:(ListingTbViewController *)inController didSelectIndex:(NSString *)aaIndex andName:(NSString *)aaName andDOB:(NSString *)aaDOB andGender:(NSString *)aaGender andOccpCode:(NSString *)aaCode andSmoker:(NSString *)aaSmoker{
	if ([NSString stringWithFormat:@"%d",IndexNo] != NULL) {
        smoker = @"N";
        DiffClient = YES;
    }
	IndexNo = [aaIndex intValue];
	
	AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    zzz.ExistPayor = YES;

	NSLog(@"new client");
    if (commDate.length == 0) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        commDate = [dateFormatter stringFromDate:[NSDate date]];
    }
	
	DOB = aaDOB;
	
	[self calculateAge];
	
		
		txtName.text = aaName;
		sex = aaGender;
		
		if ([sex isEqualToString:@"MALE"]) {
            segGender.selectedSegmentIndex = 0;
        } else {
            segGender.selectedSegmentIndex = 1;
        }
		
		if(age < 17){
			segSmoker.selectedSegmentIndex = 1;
			segSmoker.enabled = FALSE;
		}
		
		[btnDOB setTitle:DOB forState:UIControlStateNormal];
		//txtDOB.text = DOB;
		txtALB.text = [[NSString alloc] initWithFormat:@"%d",age];
		[self.btnCommDate setTitle:commDate forState:UIControlStateNormal];
		btnCommDate.titleLabel.text = commDate;
		
		occuCode = aaCode;
		[self getOccLoadExist];
		[btnOccpDesc setTitle:occuDesc forState:UIControlStateNormal];
		self.btnOccpDesc.titleLabel.textColor = [UIColor darkGrayColor];
		txtOccpLoad.text = [NSString stringWithFormat:@"%@",occLoading_UL];
		
		if (occCPA_PA == 0) {
			txtCPA.text = @"D";
        }
        else {
			txtCPA.text = [NSString stringWithFormat:@"%d",occCPA_PA];
        }
        
        if (occPA == 0) {
			txtPA.text = @"D";
        }
        else {
			txtPA.text = [NSString stringWithFormat:@"%d",occPA];
        }
	
	
	[self.prospectPopover dismissPopoverAnimated:YES];
}

- (void)OccupCodeSelected:(NSString *)OccupCode
{
    
    occuCode = OccupCode;
    [self getOccLoadExist];
	txtOccpLoad.text = [NSString stringWithFormat:@"%@",occLoading];
    
    if (occCPA_PA == 0) {
        txtCPA.text = @"D";
    }
    else {
		txtCPA.text = [NSString stringWithFormat:@"%d",occCPA_PA];
    }
    
    if (occPA == 0) {
		txtPA.text = @"D";
    }
    else {
		txtPA.text = [NSString stringWithFormat:@"%d",occPA];
    }
}

- (void)OccupDescSelected:(NSString *)OccupDesc{
    [btnOccpDesc setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", OccupDesc]forState:UIControlStateNormal];
    [self.OccupationListPopover dismissPopoverAnimated:YES];
}

-(void)OccupClassSelected:(NSString *)OccupClass{
	
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
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
		else if (age > 70){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Age Last Birthday must be less than or equal to 70 for this product." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
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
            
			txtOccpLoad.text = [NSString stringWithFormat:@"%@",occLoading_UL];
            
            
            if (occCPA_PA == 0) {
				txtCPA.text = @"D";
            } else {
				txtCPA.text = [NSString stringWithFormat:@"%d",occCPA_PA];
            }
            
            if (occPA == 0) {
				txtPA.text = @"D";
            } else {
				txtPA.text = [NSString stringWithFormat:@"%d",occPA];
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
	else if (alertView.tag == 1007 && buttonIndex == 0) {
        [self deleteRider];
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

#pragma mark - memory management

- (void)viewDidUnload {
	[self setSegGender:nil];
	[self setSegSmoker:nil];
	[self setSegStatus:nil];
	[self setBtnDOB:nil];
	[self setTxtALB:nil];
	[self setBtnOccpDesc:nil];
	[self setTxtOccpLoad:nil];
	[self setTxtCPA:nil];
	[self setTxtPA:nil];
	[self setMyScrollView:nil];
	[self setTxtName:nil];
	[self setTxtDOB:nil];
	[self setTxtCommDate:nil];
	[self setBtnEnable:nil];
	[self setBtnCommDate:nil];
	[super viewDidUnload];
}

#pragma mark - Button Action

- (IBAction)ActionDOB:(id)sender {
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
	
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
;
}

- (IBAction)ActionProspect:(id)sender {
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
	
	if (_ProspectList == nil) {
        self.ProspectList = [[ListingTbViewController alloc] initWithStyle:UITableViewStylePlain];
        _ProspectList.delegate = self;
        self.prospectPopover = [[UIPopoverController alloc] initWithContentViewController:_ProspectList];
    }
    
	CGRect ww = [sender frame];
	ww.origin.y = [sender frame].origin.y + 50;
	
    [self.prospectPopover presentPopoverFromRect:ww inView:self.view
						permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
}

- (IBAction)ActionOccpDesc:(id)sender {
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
	
	if (_OccupationList == nil) {
        self.OccupationList = [[OccupationList alloc] initWithStyle:UITableViewStylePlain];
        _OccupationList.delegate = self;
        self.OccupationListPopover = [[UIPopoverController alloc] initWithContentViewController:_OccupationList];
    }
    
    [self.OccupationListPopover presentPopoverFromRect:[sender frame]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

- (IBAction)ActionRefresh:(id)sender {
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd/MM/yyyy"];
	commDate = [dateFormatter stringFromDate:[NSDate date]];
	
	//btnCommDate.titleLabel.text = commDate;
	[btnCommDate setTitle:commDate forState:UIControlStateNormal];
}

- (IBAction)ActionEnable:(id)sender {
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
	
	if (isNewClient) {
        
		txtName.enabled = NO;
		txtName.backgroundColor = [UIColor lightGrayColor];
		txtName.textColor = [UIColor darkGrayColor];
		segGender.enabled = NO;
        
        btnDOB.enabled = NO;
        self.btnDOB.titleLabel.textColor = [UIColor darkGrayColor];
        
		btnOccpDesc.enabled = NO;
        self.btnOccpDesc.titleLabel.textColor = [UIColor darkGrayColor];
        
        isNewClient = NO;
    }
    else {
        
		txtName.enabled = YES;
		txtName.backgroundColor = [UIColor whiteColor];
		txtName.textColor = [UIColor blackColor];
		segGender.enabled = YES;
        
        btnDOB.enabled = YES;
        self.btnDOB.titleLabel.textColor = [UIColor blackColor];
        
        btnOccpDesc.enabled = YES;
        self.btnOccpDesc.titleLabel.textColor = [UIColor blackColor];
        
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"dd/MM/yyyy"];
		commDate = [dateFormatter stringFromDate:[NSDate date]];
		[btnCommDate setTitle:commDate forState:UIControlStateNormal];
		
        isNewClient = YES;
    }
    
	txtName.text = @"";
	segGender.selectedSegmentIndex = UISegmentedControlNoSegment;
	segSmoker.selectedSegmentIndex = UISegmentedControlNoSegment;
    btnDOB.titleLabel.text = @"";
	txtALB.text = @"";
	//btnCommDate.titleLabel.text = @"";
	btnOccpDesc.titleLabel.text = @"";
	txtOccpLoad.text = @"";
	txtCPA.text = @"";
	txtPA.text = @"";
}

-(BOOL)NewDone{
	if ([self Validation] == TRUE) {
		if (self.requestSINo) {
            [self checkingExisting2];
        }
        
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
		
		[_delegate BasicSI:getSINo andAge:age andOccpCode:occuCode andCovered:100 - age andBasicSA:[NSString stringWithFormat:@"%f", getSumAssured]
				andBasicHL:getHL andBasicHLTerm:getHLTerm andBasicHLPct:getHL andBasicHLPctTerm:getHLTerm andPlanCode:planChoose andBumpMode:getBumpMode];

		
        Saved = YES;
		return TRUE;
	} else {
		return FALSE;
	}
}

- (IBAction)ActionDone:(id)sender {
	
	if ([self Validation] == TRUE) {
		/*
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
		
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self
											  cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL",nil];
        [alert setTag:1001];
        [alert show];
		 */
		
		if (self.requestSINo) {
            [self checkingExisting2];
        }
        
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
		
		[_delegate BasicSI:getSINo andAge:age andOccpCode:occuCode andCovered:100 - age andBasicSA:[NSString stringWithFormat:@"%f", getSumAssured]
				andBasicHL:getHL andBasicHLTerm:getHLTerm andBasicHLPct:getHL andBasicHLPctTerm:getHLTerm andPlanCode:planChoose andBumpMode:getBumpMode];

		
		[_delegate LAGlobalSave];
		
	}
	
}

-(BOOL)Validation{
	NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789'@/-. "] invertedSet];
	if (txtName.text.length <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Life Assured Name is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
        //[Field becomeFirstResponder];
		return FALSE;
    }
    else if (smoker.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Smoker is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
		return FALSE;
    }
	else if (AgeLess) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Age must be at least 30 days." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert setTag:1005];
        [alert show];
		return FALSE;
    }
	/*
	else if (age > 70) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Age Last Birthday must be less than or equal to 70 for this product." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
		return FALSE;
    }
	 */
	else if (occuCode.length == 0 || btnOccpDesc.titleLabel.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Please select an Occupation Description." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
		return FALSE;
    }
	else if ([txtName.text rangeOfCharacterFromSet:set].location != NSNotFound) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Invalid input format. Input must be alphabet A to Z, space, apostrotrophe('), alias(@), slash(/), dash(-) or dot(.)" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
		return FALSE;
    }
    else if ([occuCode isEqualToString:@"OCC01975"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"There is no existing plan which can be offered to this occupation." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
		return FALSE;
    }else {
        return TRUE;
    }
}

- (IBAction)ActionMaritalStatus:(id)sender {
	if ([segStatus selectedSegmentIndex]==0) {
		MaritalStatus = @"S";
    }
    else if (segStatus.selectedSegmentIndex == 1){
		MaritalStatus = @"M";
    }
	else if (segStatus.selectedSegmentIndex == 2){
		MaritalStatus = @"D";
    }
	else if (segStatus.selectedSegmentIndex == 3){
		MaritalStatus = @"W";
    }
}

- (IBAction)ActionSmoker:(id)sender {
	if ([segSmoker selectedSegmentIndex]==0) {
        smoker = @"Y";
    }
    else if (segSmoker.selectedSegmentIndex == 1){
        smoker = @"N";
    }
}
- (IBAction)ActionCommDate:(id)sender {
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

	
}
@end
