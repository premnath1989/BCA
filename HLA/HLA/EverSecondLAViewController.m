//
//  EverSecondLAViewController.m
//  iMobile Planner
//
//  Created by infoconnect on 6/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "EverSecondLAViewController.h"
#import "MainScreen.h"
#import "AppDelegate.h"

@interface EverSecondLAViewController ()

@end

NSString *gEverNameSecond = @"";
int getPayorIndexNo;

@implementation EverSecondLAViewController
@synthesize outletGender, outletSmoker, txtALB,txtCPA,txtDOB,txtName,txtOccpDesc,txtPA;
@synthesize age,ANB, CheckRiderCode, clientID, clientName, CustCode, CustDate, CustLastNo;
@synthesize sex, SINo, smoker, dataInsert, DOB, DOBPP, btnDOB, btnEnable, btnOccpDesc;
@synthesize requestCommDate,requestLAIndexNo,requestSINo, GenderPP,getCommDate,getLAIndexNo,getSINo;
@synthesize title,NamePP,jobDesc,IndexNo,occCPA_PA,occLoading,occPA,OccpCode,OccpCodePP, btnProspect, outletDone;
@synthesize OccpDesc,occuClass, outletDelete, Change, LAView, txtOccpLoad, popOverController, occuCode, requesteProposalStatus, EAPPorSI;
@synthesize SmokerPP;
@synthesize outletEAPP, outletSpace;
@synthesize delegate = _delegate;
@synthesize ProspectList = _ProspectList;
@synthesize LADate = _LADate;
@synthesize dobPopover = _dobPopover;

id temp;
id dobtemp;

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
    appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate ];
	
	if ([requesteProposalStatus isEqualToString:@"Created"] ||
		[requesteProposalStatus isEqualToString:@"Confirmed"] || [requesteProposalStatus isEqualToString:@"Submitted"] ||
		[requesteProposalStatus isEqualToString:@"Received"] || [EAPPorSI isEqualToString:@"eAPP"] ) {
		Editable = NO;
	}
	else{
		Editable = YES;
	}
	
    getLAIndexNo = requestLAIndexNo;
    getCommDate = [self.requestCommDate description];
    getSINo = [self.requestSINo description];
    NSLog(@"2ndLA-SINo:%@, CommDate:%@",getSINo,getCommDate);
    
    btnDOB.enabled = FALSE;
	btnOccpDesc.enabled = FALSE;
    self.outletDelete.hidden = YES;
    
    useExist = NO;
    inserted = NO;
    
    [outletDelete setBackgroundImage:[[UIImage imageNamed:@"iphone_delete_button.png"] stretchableImageWithLeftCapWidth:8.0f topCapHeight:0.0f] forState:UIControlStateNormal];
    [outletDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	outletDelete.titleLabel.shadowColor = [UIColor lightGrayColor];
	outletDelete.titleLabel.shadowOffset = CGSizeMake(0, -1);
	outletSmoker.enabled = FALSE;
	
    if (requestSINo) {
        [self checkingExisting];
        if (SINo.length != 0) {
            [self getProspectData];
            [self getSavedField];
			
            self.outletDelete.hidden = NO;
        }
    }
    
	
	
	

	
	outletGender.enabled = FALSE;
	
	if ([[self.EAPPorSI description] isEqualToString:@"eAPP"]) {
	    
        outletEAPP.width = 0;
        //OutletSpace.width = 564;
        
    }
	
	outletEAPP.width = 0.01;
	outletSpace.width = 650;
	btnEnable.hidden = YES;
	
	if (Editable == NO) {
		txtALB.enabled = false;
		txtCPA.enabled = false;
		txtDOB.enabled = FALSE;
		txtName.enabled = false;
		txtOccpLoad.enabled = FALSE;
		txtPA.enabled = false;
		
		txtALB.backgroundColor = [UIColor lightGrayColor];
		txtCPA.backgroundColor = [UIColor lightGrayColor];
		txtDOB.backgroundColor = [UIColor lightGrayColor];
		txtName.backgroundColor = [UIColor lightGrayColor];
		txtOccpLoad.backgroundColor = [UIColor lightGrayColor];
		txtPA.backgroundColor = [UIColor lightGrayColor];
		
		btnDOB.enabled = FALSE;
		btnOccpDesc.enabled = FALSE;
		btnEnable.hidden = YES;
		btnProspect.hidden = YES;
		
		outletDelete.hidden = YES;
		outletGender.enabled = FALSE;
		outletSmoker.enabled = FALSE;
        
        self.btnDOB.alpha = 0.5;
		self.btnOccpDesc.alpha = 0.5;
		self.outletGender.alpha = 0.5;
		self.outletSmoker.alpha = 0.5;
		
		if([EAPPorSI isEqualToString:@"eAPP"]){
			outletDone.enabled = FALSE;
			outletEAPP.width = 0;
			outletSpace.width = 564;
			
		}
	}
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
								   initWithTarget:self
								   action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	
	[self.view addGestureRecognizer:tap];
	
    NSLog(@"delegate:%@",_delegate);
}

-(void)hideKeyboard{
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    self.view.frame = CGRectMake(0, 0, 800, 1004);
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

-(void)textFieldDidBeginEditing:(UITextField *)textField{
	//appDel.isNeedPromptSaveMsg = YES;
}

-(void)getSavedField
{
    BOOL valid = TRUE;
    
	
    if (![NamePP isEqualToString:clientName]) {
        valid = FALSE;
    }
    
    if (![[GenderPP substringToIndex:1] isEqualToString:[sex substringToIndex:1]]) {
        valid = FALSE;
    }
    
    if (![DOB isEqualToString:DOBPP]) {
        valid = FALSE;
    }
    
    if (![OccpCode isEqualToString:OccpCodePP]) {
        valid = FALSE;
    }
	
    if (![smoker isEqualToString:SmokerPP]) {
        valid = FALSE;
    }
	
    
	//    NSLog(@"nameSI:%@, genderSI:%@, dobSI:%@, occpSI:%@",clientName,sex,DOB,OccpCode);
	//    NSLog(@"namepp:%@, genderpp:%@, dobPP:%@, occpPP:%@",NamePP,GenderPP,DOBPP,OccpCodePP);
    
    if (valid) {

		txtName.text = clientName;
		gEverNameSecond = clientName;
		txtDOB.text = [[NSString alloc] initWithFormat:@"%@",DOB];
		[btnDOB setTitle:DOB forState:UIControlStateNormal];
		txtALB.text = [[NSString alloc] initWithFormat:@"%d",age];
        
        if ([sex isEqualToString:@"MALE"] || [sex isEqualToString:@"M"]) {
			outletGender.selectedSegmentIndex = 0;
        } else  {
			outletGender.selectedSegmentIndex = 1;
        }
        NSLog(@"sex:%@",sex);
        
        if ([smoker isEqualToString:@"Y"]) {
			outletSmoker.selectedSegmentIndex = 0;
        } else {
			outletSmoker.selectedSegmentIndex = 1;
        }
        NSLog(@"smoker:%@",smoker);
        
        [self getOccLoadExist];
		txtOccpDesc.text = [[NSString alloc] initWithFormat:@"%@",OccpDesc];
		[btnOccpDesc setTitle:OccpDesc forState:UIControlStateNormal];
		txtOccpLoad.text = [NSString stringWithFormat:@"%@",occLoading];
        
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
        
        [_delegate LA2ndIndexNo:IndexNo andSmoker:smoker andSex:[sex substringToIndex:1] andDOB:DOB andAge:age andOccpCode:OccpCode];
        AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
        zzz.SICompleted = YES;
		Change = @"no";
    }
    else {
        
		txtName.text = NamePP;
		gEverNameSecond = NamePP;
        sex = [GenderPP substringToIndex:1];
		
        if ([sex isEqualToString:@"MALE"] || [sex isEqualToString:@"M"]) {
			outletGender.selectedSegmentIndex = 0;
        } else {
			outletGender.selectedSegmentIndex = 1;
        }
        NSLog(@"sex:%@",sex);
        
        if ([SmokerPP isEqualToString:@"Y"]) {
			outletSmoker.selectedSegmentIndex = 0;
        } else {
			outletSmoker.selectedSegmentIndex = 1;
        }
		smoker = SmokerPP;
		
        NSLog(@"smoker:%@",smoker);
        
		//btnDOB.titleLabel.text = [[NSString alloc] initWithFormat:@"%@",DOBPP];
		[btnDOB setTitle:DOBPP forState:UIControlStateNormal];
        DOB = DOBPP;
        [self calculateAge];
		txtALB.text = [[NSString alloc] initWithFormat:@"%d",age];
        
        OccpCode = OccpCodePP;
        [self getOccLoadExist];
		//btnOccpDesc.titleLabel.text = [[NSString alloc] initWithFormat:@"%@",OccpDesc];
		[btnOccpDesc setTitle:OccpDesc forState:UIControlStateNormal];
		txtOccpLoad.text = [NSString stringWithFormat:@"%@",occLoading];
        
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
        
		//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"There are changes in Prospect's information. Are you sure want to apply changes to this SI?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        
		//Change = @"yes";
		if ([LAView isEqualToString:@"1"] ) {
			[self updateData];
			[self CheckValidRider];
			Change = @"yes";
			[_delegate RiderAdded];
			
		}
		else
		{
            /*
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Prospect's information will synchronize to this SI." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert setTag:1004];
			[alert show];
             */
            
            [self updateData];
			[self CheckValidRider];
			[_delegate RiderAdded];
			
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
        if (self.requestSINo) {
            [self checkingRider];
            [self deleteLA];
            if (CheckRiderCode.length != 0) {
                [self deleteRider];
                [_delegate RiderAdded];
            }
			txtName.text = @"";
			gEverNameSecond = @"";
            [outletGender setSelectedSegmentIndex:UISegmentedControlNoSegment];
			btnDOB.titleLabel.text = @"";
			txtALB.text = @"";
			btnOccpDesc.titleLabel.text = @"";
			txtOccpLoad.text = @"";
			txtCPA.text = @"";
			txtPA.text = @"";
        }
        else {
			txtName.text = @"";
			gEverNameSecond = @"";
            [outletGender setSelectedSegmentIndex:UISegmentedControlNoSegment];
			btnDOB.titleLabel.text = @"";
			txtALB.text = @"";
			btnOccpDesc.titleLabel.text= @"";
			txtOccpLoad.text = @"";
			txtCPA.text = @"";
			txtPA.text = @"";
			
            self.outletDelete.hidden = YES;
        }
        
        [_delegate secondLADelete];
        
    }
    else if (alertView.tag==1004 && buttonIndex == 0) {
        
            /*
            [self updateData];
			[self CheckValidRider];
			[_delegate RiderAdded];
             */

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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age must be at least 16 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
            [alert show];
        }
    }
    else if (yearN == yearB)
    {
        age = 0;
        ANB = 1;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age must be at least 16 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
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

#pragma mark - delegate

-(void)listing:(ListingTbViewController *)inController didSelectIndex:(NSString *)aaIndex andName:(NSString *)aaName andDOB:(NSString *)aaDOB andGender:(NSString *)aaGender andOccpCode:(NSString *)aaCode andSmoker:(NSString *)aaSmoker andMaritalStatus:(NSString *)aaMaritalStatus
{
    if (sex != NULL) {
        sex = nil;
        smoker = nil;
    }
    
    if (IndexNo != [aaIndex intValue]) {
        if ([NSString stringWithFormat:@"%d",IndexNo] != NULL) {
            DiffClient = YES;
        }
    }
    
    smoker = @"N";
    IndexNo = [aaIndex intValue];
    
	[self getPayor];	
	
    if (getLAIndexNo == IndexNo) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"The individual has already been selected as the Life Assured." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
			
    }
	else if (getPayorIndexNo == IndexNo) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"The individual select has already been selected as the Payor." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
		
    }
	else {
        
		DOB = aaDOB;
        [self calculateAge];
		
		if (age > 65) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age must not greater than 65 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
			[alert show];
		}
		else{
			[_delegate saved:NO];
			txtName.text = aaName;
			gEverNameSecond = aaName;
			sex = aaGender;
			
			if ([sex isEqualToString:@"MALE"]) {
				sex = @"MALE";
				outletGender.selectedSegmentIndex = 0;
			} else {
				sex = @"FEMALE";
				outletGender.selectedSegmentIndex = 1;
			}
			//NSLog(@"sex:%@",sex);
			
			if(age < 17){
				outletSmoker.selectedSegmentIndex = 1;
				outletSmoker.enabled = FALSE;
			}
			else{
				outletSmoker.enabled = FALSE;
				if ([aaSmoker isEqualToString:@"N"]) {
					outletSmoker.selectedSegmentIndex = 1;
				}
				else{
					outletSmoker.selectedSegmentIndex = 0;
				}
			}
			
			[btnDOB setTitle:aaDOB forState:UIControlStateNormal];
			txtALB.text = [[NSString alloc] initWithFormat:@"%d",age];
			
			OccpCode = aaCode;
			[self getOccLoadExist];
			[btnOccpDesc setTitle:OccpDesc forState:UIControlStateNormal];
			txtOccpLoad.text = [NSString stringWithFormat:@"%@",occLoading];
			
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
		}
		
    }
    
    [popOverController dismissPopoverAnimated:YES];
}

-(void)OccupClassSelected:(NSString *)OccupClass{
	
}

-(void)OccupCodeSelected:(NSString *)OccupCode{
	occuCode = OccupCode;
    OccpCode = OccupCode;
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

-(void)OccupDescSelected:(NSString *)OccupDesc{
	//NSLog(@"color = %@", color);
    [btnOccpDesc setTitle:OccupDesc forState:UIControlStateNormal];
    [self.OccupationListPopover dismissPopoverAnimated:YES];
}

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
}

#pragma mark - db handle

-(void)getRunningCustCode
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT LastNo,LastUpdated FROM Adm_TrnTypeNo WHERE "
							  "TrnTypeCode=\"CL\""];
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
	if (QQProspect) {
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
							   @"INSERT INTO UL_LAPayor (SINo, CustCode,PTypeCode,Seq,DateCreated,CreatedBy) "
							   "VALUES (\"%@\",\"%@\",\"LA\",\"2\",\"%@\",\"hla\")",SINo, CustCode,dateStr];
        
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
								@"INSERT INTO Clt_Profile (CustCode, Name, Smoker, Sex, DOB, ALB, ANB, "
								"OccpCode, DateCreated, CreatedBy,indexNo) VALUES (\"%@\", \"%@\", \"%@\", "
								"\"%@\", \"%@\", \"%d\", \"%d\", \"%@\", \"%@\", \"hla\", \"%d\")",
								CustCode, txtName.text, smoker, sex, DOB, age, ANB, OccpCode, dateStr,IndexNo];
        
		//        NSLog(@"%@",insertSQL2);
        if(sqlite3_prepare_v2(contactDB, [insertSQL2 UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Done LA2");
                [self updateRunCustCode];
                [_delegate LA2ndIndexNo:IndexNo andSmoker:smoker andSex:[sex substringToIndex:1] andDOB:DOB andAge:age andOccpCode:OccpCode];
                [_delegate saved:YES];
            }
            else {
                NSLog(@"Failed LA2");
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" " message:@"Fail in inserting record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    self.outletDelete.hidden = NO;
}

-(void)save2ndLAHandler
{
	if (QQProspect) {
        [self insertClient];
    }
	
    [_delegate LA2ndIndexNo:IndexNo andSmoker:smoker andSex:[sex substringToIndex:1] andDOB:DOB andAge:age andOccpCode:OccpCode];
    self.outletDelete.hidden = NO;
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
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE Adm_TrnTypeNo SET LastNo= \"%d\",LastUpdated= \"%@\" "
							  "WHERE TrnTypeCode=\"CL\"",newLastNo,dateString];
        
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
							  @"SELECT a.SINo, a.CustCode, b.Name, b.Smoker, b.Sex, b.DOB, b.ALB, b.OccpCode, b.id, "
							  "b.IndexNo FROM UL_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode "
							  "WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Seq=2",getSINo];
        
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
                NSLog(@"error access UL_Trad_LAPayor");
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
							  "WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Seq=2",[self.requestSINo description]];
        
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
                              @"SELECT ProspectName, ProspectDOB, ProspectGender, ProspectOccupationCode, ifnull(QQFlag, 'false'), Smoker FROM "
							  "prospect_profile WHERE IndexNo= \"%d\"",IndexNo];    
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NamePP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                DOBPP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                GenderPP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                OccpCodePP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
				NSString *TempQQProspect = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
				SmokerPP = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
				
				if ([TempQQProspect isEqualToString:@"true"]) {
					QQProspect = TRUE;
					outletGender.enabled = TRUE;
					outletSmoker.enabled = TRUE;
				}
				else{
					QQProspect = FALSE;
					outletGender.enabled = FALSE;
					outletSmoker.enabled = FALSE;
				}
				
            } else {
                NSLog(@"error access prospect_profile");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getPayor
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
							  @"SELECT b.IndexNo FROM UL_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode "
							  "WHERE a.SINo=\"%@\" AND a.PTypeCode=\"PY\" ",getSINo];
		
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                getPayorIndexNo = sqlite3_column_int(statement, 0);
                
            } else {
                
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
                              @"SELECT a.OccpDesc, b.OccLoading, b.CPA, b.PA, b.Class from Adm_Occp_Loading_Penta a "
							  "LEFT JOIN Adm_Occp_Loading b ON a.OccpCode = b.OccpCode WHERE b.OccpCode = \"%@\"",OccpCode];
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

-(void)updateData
{
	if (QQProspect == TRUE) {
		[self UpdateClient];
	}
	
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *currentdate = [dateFormatter stringFromDate:[NSDate date]];
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
		
        //NSString *querySQL = [NSString stringWithFormat:@"UPDATE Clt_Profile SET Name=\"%@\", Smoker=\"%@\", Sex=\"%@\", DOB=\"%@\", ALB=\"%d\", ANB=\"%d\", OccpCode=\"%@\", DateModified=\"%@\", ModifiedBy=\"hla\", indexNo=\"%d\" WHERE id=\"%d\"",nameField.text,smoker,sex,DOB,age,ANB,OccpCode,currentdate,IndexNo,clientID];
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE Clt_Profile SET Name='%@', Smoker=\"%@\", Sex=\"%@\", "
							  "DOB=\"%@\", ALB=\"%d\", ANB=\"%d\", OccpCode=\"%@\", DateModified=\"%@\", ModifiedBy=\"hla\", "
							  "indexNo=\"%d\" WHERE id=\"%d\"",
							  gEverNameSecond,smoker,sex,DOB,age,ANB,OccpCode,currentdate,IndexNo,clientID];
		
        //NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"SI update!");
                [_delegate LA2ndIndexNo:IndexNo andSmoker:smoker andSex:[sex substringToIndex:1] andDOB:DOB andAge:age andOccpCode:OccpCode];
                [_delegate saved:YES];
                
            }
            else {
                NSLog(@"SI update Failed!");
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" " message:@"Fail in updating record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
            }
            sqlite3_finalize(statement);
        }
        
        if (DiffClient) {

            if ([self deleteRider] > 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Rider(s) has been deleted due to business rule." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
                [alert show];
            }
            
            
        }
        
        sqlite3_close(contactDB);
    }
}

-(void)CheckValidRider
{
    
    sqlite3_stmt *statement;
	BOOL popMsg = FALSE;
	
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
		if ([OccpCode isEqualToString:@"OCC01975"]) {
			NSString *querySQL = [NSString stringWithFormat:@"Select * From UL_Rider_Details where SINO = \"%@\" AND RiderCode in ('LCWP', 'PR', 'SP_PRE', 'SP_STD') ", SINo];
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
				querySQL = [NSString stringWithFormat:@"DELETE From UL_Rider_Details where SINO = \"%@\" AND RiderCode in ('LCWP', 'PR', 'SP_PRE', 'SP_STD') ", SINo];
				
				if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
				{
					if (sqlite3_step(statement) == SQLITE_DONE)
					{
						
					}
					sqlite3_finalize(statement);
					
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Some Rider(s) has been deleted due to marketing rule." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
        NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM UL_LAPayor WHERE CustCode=\"%@\"",CustCode];
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
                
                UIAlertView *failAlert = [[UIAlertView alloc] initWithTitle:@" " message:@"Fail in deleting record." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [failAlert show];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    self.outletDelete.hidden = YES;
    useExist = NO;
}

-(void)checkingRider
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT RiderCode,SumAssured,RiderTerm,Units FROM "
							  "UL_Rider_Details WHERE SINo=\"%@\" AND PTypeCode=\"LA\" AND Seq=\"2\"",requestSINo];
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

-(int)deleteRider
{
    sqlite3_stmt *statement;
    int rowsDeleted = 0;
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"DELETE FROM UL_Rider_Details WHERE SINo=\"%@\" AND PTypeCode=\"LA\" AND Seq=\"2\"",requestSINo];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                
                rowsDeleted = sqlite3_changes(contactDB);
                NSLog(@"rider delete!");
                
            } else {
                NSLog(@"rider delete Failed!");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    return rowsDeleted;
}

-(void)insertClient
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
		if (outletGender.selectedSegmentIndex ==  0) {
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
		if (outletGender.selectedSegmentIndex == 0) {
			sex = @"MALE";
		}
		else{
			sex = @"FEMALE";
		}
		
        NSString *insertSQL3 = [NSString stringWithFormat:
								@"Update prospect_profile Set ProspectName = '%@', ProspectDOB = '%@', ProspectGender = '%@', "
								" ProspectOccupationCode = '%@', DateModified='%@', ModifiedBy='%@', Smoker= '%@' WHERE indexNo = '%d' ",
								txtName.text, DOB, sex, occuCode, @"datetime(\"now\", \"+8 hour\")", @"1", smoker, IndexNo];
		
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


#pragma mark - memory management
-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.popOverController = nil;
}

#pragma mark - button Action
- (IBAction)ActionEnable:(id)sender {
	if (QQProspect) {
        
		txtName.enabled = NO;
		txtName.backgroundColor = [UIColor lightGrayColor];
		txtName.textColor = [UIColor darkGrayColor];
		outletGender.enabled = NO;
        
        btnDOB.enabled = NO;
        self.btnDOB.titleLabel.textColor = [UIColor darkGrayColor];
        
        btnOccpDesc.enabled = NO;
        self.btnOccpDesc.titleLabel.textColor = [UIColor darkGrayColor];

		QQProspect = NO;
    }
    else {
        
		txtName.enabled = YES;
		txtName.backgroundColor = [UIColor whiteColor];
		txtName.textColor = [UIColor blackColor];
		outletGender.enabled = YES;
		outletSmoker.enabled = YES;
        
        btnDOB.enabled = YES;
        self.btnDOB.titleLabel.textColor = [UIColor blackColor];
        
        btnOccpDesc.enabled = YES;
        self.btnOccpDesc.titleLabel.textColor = [UIColor blackColor];
        
		QQProspect = YES;
    }
    
	txtName.text = @"";
	outletGender.selectedSegmentIndex = UISegmentedControlNoSegment;
	outletSmoker.selectedSegmentIndex = UISegmentedControlNoSegment;
    btnDOB.titleLabel.text = @"";
	txtALB.text = @"";
    btnOccpDesc.titleLabel.text = @"";
	txtOccpLoad.text = @"";
	txtCPA.text = @"";
	txtPA.text = @"";
}

- (IBAction)ActionDelete:(id)sender {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
													message:[NSString stringWithFormat:@"Delete 2nd Life Assured:%@?",txtName.text] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL",nil];
    [alert setTag:1002];
    [alert show];
}

- (IBAction)ActionGender:(id)sender {
	if ([outletGender selectedSegmentIndex]==0) {
        sex = @"MALE";
    }
    else if (outletGender.selectedSegmentIndex == 1){
        sex = @"FEMALE";
    }
}

- (IBAction)ActionSmoker:(id)sender {
	if ([outletSmoker selectedSegmentIndex]==0) {
        smoker = @"Y";
    }
    else if (outletSmoker.selectedSegmentIndex == 1){
        smoker = @"N";
    }
}

-(BOOL)Validation{
	//NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789'@/-. "] invertedSet];
    
    if (txtName.text.length <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
														message:@"2nd Life Assured Name is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
		return FALSE;
    }
	else if (OccpCode.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please select an Occupation Description." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
		return FALSE;
    }
    /*
    else if ([txtName.text rangeOfCharacterFromSet:set].location != NSNotFound) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid input format. Input must be alphabet A to Z, space, apostrotrophe('), alias(@), slash(/), dash(-) or dot(.)" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
		return FALSE;
    }
     */
    else if (smoker.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Smoker is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
		return FALSE;
    }
    else if (age < 16) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age must be at least 16 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
		return FALSE;
    }
	else if (age > 65) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Age must not greater than 65 years old." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
		return FALSE;
    }
    else {
		return TRUE;
    }
}

- (IBAction)btnDone:(id)sender {
	if (![txtName.text isEqualToString:@""]) {
		if ([self Validation] == TRUE) {
			/*
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
			 
			 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL",nil];
			 [alert setTag:1001];
			 [alert show];
			 */
			
			if (self.requestSINo) {
				[self checkingExisting2];
			}
			
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
	}

	[_delegate SecondLAGlobalSave];
}

- (IBAction)ActionDOB:(id)sender {
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

- (IBAction)ActionOccpDesc:(id)sender {
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
    
    //[self.OccupationListPopover presentPopoverFromRect:[sender bounds]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	[self.OccupationListPopover presentPopoverFromRect:[sender frame]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

-(BOOL)NewDone{
	//NSLog(@"inside second LA");
	if (![txtName.text isEqualToString:@""]) {
		if ([self Validation] == TRUE) {
			if (self.requestSINo) {
				[self checkingExisting2];
			}
			
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
			return TRUE;
		}
		else{

			return FALSE;
		}
	}
	else{

		return TRUE;
	}
		
}

- (IBAction)ActionProspect:(id)sender {
	if (_ProspectList == nil) {
        ListingTbViewController *Listing = [[ListingTbViewController alloc] initWithStyle:UITableViewStylePlain];
        Listing.SIOrEAPPS = @"SI";
        
        //self.ProspectList = [[ListingTbViewController alloc] initWithStyle:UITableViewStylePlain];
        self.ProspectList = Listing;
        _ProspectList.delegate = self;
        popOverController = [[UIPopoverController alloc] initWithContentViewController:_ProspectList];
    }
    
    [popOverController presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	
}

- (IBAction)ActionEAPP:(id)sender {
	self.modalTransitionStyle = UIModalPresentationFormSheet;
    [self dismissViewControllerAnimated:TRUE completion:Nil];
}

#pragma mark - view did unload
- (void)viewDidUnload {
	[self setTxtName:nil];
	[self setOutletGender:nil];
	[self setOutletSmoker:nil];
	[self setTxtDOB:nil];
	[self setTxtALB:nil];
	[self setTxtOccpDesc:nil];
	[self setTxtCPA:nil];
	[self setTxtPA:nil];
	[self setOutletDelete:nil];
	[self setTxtOccpLoad:nil];
	[self setTxtOccpDesc:nil];
    [self setBtnEnable:nil];
    [self setBtnDOB:nil];
    [self setBtnOccpDesc:nil];
	[self setBtnProspect:nil];
    [self setOutletDone:nil];
    [self setOutletEAPP:nil];
	[self setOutletSpace:nil];
	[super viewDidUnload];
}


@end
