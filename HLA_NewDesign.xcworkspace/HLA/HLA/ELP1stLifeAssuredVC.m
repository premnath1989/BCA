//
//  ELP1stLifeAssuredVC.m
//  iMobile Planner
//
//  Created by Juliana on 11/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ELP1stLifeAssuredVC.h"
#import "DataClass.h"

@interface ELP1stLifeAssuredVC () {
	DataClass *obj;
}

@end

@implementation ELP1stLifeAssuredVC

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	
	// Set initial values in our array
	items = [[NSMutableArray alloc] initWithObjects:nil];
	
	
	// Set int variable, since our last item number is six, we will also set this int variable to six.
	number = 0;
	
	obj = [DataClass getInstance];
	
	//-----from db-----
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	stringID = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
	//	NSLog(@"string id: %@, si: %@", stringID, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"]);
	
	results = Nil;
	results = [database executeQuery:@"select * from  Trad_Details where SINo = ?",stringID,Nil];
	while ([results next]) {
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results stringForColumn:@"CashDividend"] forKey:@"CashDividend"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results stringForColumn:@"YearlyIncome"] forKey:@"TradGuaranteedCPI"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[NSString stringWithFormat:@"%d", [results intForColumn:@"PartialPayout"]] forKey:@"TPWithdrawPct"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:[NSString stringWithFormat:@"%d", [results intForColumn:@"PartialAcc"]] forKey:@"TPKeepPct"];
	}
	
	results = Nil;
	results = [database executeQuery:@"select * from  UL_Details where SINO = ?",stringID,Nil];
	while ([results next]) {
		[[obj.eAppData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ReinvestYI"] forKey:@"EverGuaranteedCPI"];
	}
	
	[results close];
	[database close];
	//
	
	
//	_personTypeLbl.text = [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PersonType"];
	//Q1
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies1stLA"] isEqualToString:@"Y"]) {
		_Q1SC.selectedSegmentIndex = 0;
        _addPolicyBtn.hidden = FALSE;
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies1stLA"] isEqualToString:@"N"]) {
		_Q1SC.selectedSegmentIndex = 1;
	}
	//
	//Notice
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA1stLA"] isEqualToString:@"Y"]) {
		_noticeASC.selectedSegmentIndex = 0;
        _noticeBSC.enabled = TRUE;
        _noticeCSC.enabled = TRUE;
        _noticeDSC.enabled = TRUE;
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA1stLA"] isEqualToString:@"N"]) {
		_noticeASC.selectedSegmentIndex = 1;
	}
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeB1stLA"] isEqualToString:@"Y"]) {
		_noticeBSC.selectedSegmentIndex = 0;
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeB1stLA"] isEqualToString:@"N"]) {
		_noticeBSC.selectedSegmentIndex = 1;
	}
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeC1stLA"] isEqualToString:@"Y"]) {
		_noticeCSC.selectedSegmentIndex = 0;
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeC1stLA"] isEqualToString:@"N"]) {
		_noticeCSC.selectedSegmentIndex = 1;
	}
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeD1stLA"] isEqualToString:@"Y"]) {
		_noticeDSC.selectedSegmentIndex = 0;
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeD1stLA"] isEqualToString:@"N"]) {
		_noticeDSC.selectedSegmentIndex = 1;
	}
	//
	//for traditional plans only
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"CashDividend"] isEqualToString:@"POF"]) {
		[_btnTCDW setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[_btnTCDK setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"CashDividend"] isEqualToString:@"ACC"]) {
		[_btnTCDW setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnTCDK setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
	}
	
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TradGuaranteedCPI"] isEqualToString:@"POF"]) {
		[_btnTGW setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[_btnTGK setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TradGuaranteedCPI"] isEqualToString:@"ACC"]) {
		[_btnTGW setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnTGK setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
	}
	_withdrawPctLbl.text = [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TPWithdrawPct"];
	_keepPctLbl.text = [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TPKeepPct"];
	//
	//for ever series only
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"EverGuaranteedCPI"] isEqualToString:@"Y"]) {
		[_btnEGW setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnEGI setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"EverGuaranteedCPI"] isEqualToString:@"N"]) {
		[_btnEGW setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[_btnEGI setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"EverGuaranteedCPI"] isEqualToString:@"Reinvest"]) {
		[_btnEGW setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_btnEGI setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
	}
	//
	//special request
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PolicyBackdating1stLA"] isEqualToString:@"Y"]) {
		[_btnPolicyBdt setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        isPolicyBdt = !isPolicyBdt;
        _btnDateSpecialReq.enabled = TRUE;
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PolicyBackdating1stLA"] isEqualToString:@"N"]) {
		[_btnPolicyBdt setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	_dateSpecialReqLbl.text = [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdating1stLA"];
	//
	if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] objectForKey:@"PolicyData"] count] != 0) {
		_viewPolicyBtn.hidden = NO;
	}
}

- (void)saveData:(int)click {
    if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] objectForKey:@"PolicyData"] count] > 0) {
        _viewPolicyBtn.hidden = NO;
    }
    else {
        _viewPolicyBtn.hidden = YES;
    }
}

- (void)haveData:(BOOL)h {
	if (h) {
		_viewPolicyBtn.hidden = NO;
	}
	else {
		_viewPolicyBtn.hidden = YES;
	}
}

- (IBAction)actionForAddPolicy:(id)sender {
	//	NSLog(@"s: %d, num: %d", s, number);
	[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] setValue:Nil forKey:@"WhichPolicy"];
	[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] setValue:[NSNumber numberWithInt:number] forKey:@"Count"];
    MainAddPolicyVC *mapvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainAddPolicy"];
	mapvc.delegate = self;
	mapvc.modalPresentationStyle = UIModalPresentationFormSheet;
	[self presentViewController:mapvc animated:YES completion:Nil];
}

- (IBAction)actionForViewPolicy:(id)sender {
	MainExistingPolicyListing *mepl = [self.storyboard instantiateViewControllerWithIdentifier:@"MainExistingPolicyListing"];
	mepl.delegate = self;
	mepl.modalPresentationStyle = UIModalPresentationFormSheet;
	[self presentViewController:mepl animated:YES completion:Nil];
}

- (IBAction)actionForAddViewPolicy:(id)sender {
	if ([sender selectedSegmentIndex] == 0) {
		_addPolicyBtn.hidden = NO;
	}
	else {
		_addPolicyBtn.hidden = YES;
		_viewPolicyBtn.hidden = YES;
	}
}

- (IBAction)actionForSpecialReq:(id)sender {
	isPolicyBdt = !isPolicyBdt;
	if(isPolicyBdt) {
		[_btnPolicyBdt setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		_btnDateSpecialReq.enabled = YES;_pb = TRUE;
        [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"PolicyBackdating1stLA"];
	}
	else {
		[_btnPolicyBdt setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		_btnDateSpecialReq.enabled = NO;
		_dateSpecialReqLbl.text = @"";
		//		_dateSpecialReqLbl.textColor = [UIColor lightGrayColor];
		_pb = FALSE;
        [[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"PolicyBackdating1stLA"];
	}
}

- (IBAction)actionForDateSpecialReq:(id)sender {
	whichPType = @"LA1";
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    _dateSpecialReqLbl.text = dateString;
	//	_dateSpecialReqLbl.textColor = [UIColor blackColor];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    
    if (_SIDate == Nil) {
        
        self.SIDate = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIDate"];
        _SIDate.delegate = self;
        self.SIDatePopover = [[UIPopoverController alloc] initWithContentViewController:_SIDate];
    }
    
    [self.SIDatePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.SIDatePopover presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    
    dateFormatter = Nil;
    dateString = Nil, mainStoryboard = nil;
}

-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
	_dateSpecialReqLbl.text = strDate;
	//	_dateSpecialReqLbl.textColor = [UIColor blackColor];
    [[obj.eAppData objectForKey:@"SecC"] setValue:strDate forKey:@"DatePolicyBackdating1stLA"];
}

-(void)CloseWindow
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
	[self.SIDatePopover dismissPopoverAnimated:YES];
}

- (IBAction)actionForNoticeA:(id)sender {
	if ([sender selectedSegmentIndex] == 0) {
		_noticeBSC.enabled = YES;
		_noticeCSC.enabled = YES;
		_noticeDSC.enabled = YES;
	}
	else {
		_noticeBSC.enabled = NO;
		_noticeCSC.enabled = NO;
		_noticeDSC.enabled = NO;
	}
}

- (IBAction)segmentChange:(id)sender {
    if ([sender isEqual:_Q1SC]) {
        if (_Q1SC.selectedSegmentIndex == 0) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"ExistingPolicies1stLA"];
        }
        else if (_Q1SC.selectedSegmentIndex == 1) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"ExistingPolicies1stLA"];
        }
    }
    else if ([sender isEqual:_noticeASC]) {
        if (_noticeASC.selectedSegmentIndex == 0) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"NoticeA1stLA"];
        }
        else if (_noticeASC.selectedSegmentIndex == 1) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"NoticeA1stLA"];
        }
    }
    else if ([sender isEqual:_noticeBSC]) {
        if (_noticeBSC.selectedSegmentIndex == 0) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"NoticeB1stLA"];
        }
        else if (_noticeBSC.selectedSegmentIndex == 1) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"NoticeB1stLA"];
        }
    }
    else if ([sender isEqual:_noticeCSC]) {
        if (_noticeCSC.selectedSegmentIndex == 0) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"NoticeC1stLA"];
        }
        else if (_noticeCSC.selectedSegmentIndex == 1) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"NoticeC1stLA"];
        }
    }
    else if ([sender isEqual:_noticeDSC]) {
        if (_noticeDSC.selectedSegmentIndex == 0) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"NoticeD1stLA"];
        }
        else if (_noticeDSC.selectedSegmentIndex == 1) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"NoticeD1stLA"];
        }
    }
    [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"SecC_Saved"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
	[self setBtnTCDW:nil];
	[self setBtnTCDK:nil];
	[self setBtnTGW:nil];
	[self setBtnTGK:nil];
	[self setBtnEGW:nil];
	[self setBtnEGI:nil];
	[self setWithdrawGuaranteedTF:nil];
	[self setKeepGuaranteedTF:nil];
	[self setPctWithdrawGuaranteed:nil];
	[self setPctKeepGuaranteed:nil];
	[self setBtnPolicyBdt:nil];
	[self setBtnDateSpecialReq:nil];
	[self setDateSpecialReqLbl:nil];
	[self setNoticeASC:nil];
	[self setNoticeBSC:nil];
	[self setNoticeCSC:nil];
	[self setNoticeDSC:nil];
    [self setWithdrawPctLbl:nil];
    [self setKeepPctLbl:nil];
	[self setQ1SC:nil];
//	[self setExistingPolicyTbV:nil];
	[self setAddPolicyBtn:nil];
	[self setViewPolicyBtn:nil];
	[super viewDidUnload];
}

@end
