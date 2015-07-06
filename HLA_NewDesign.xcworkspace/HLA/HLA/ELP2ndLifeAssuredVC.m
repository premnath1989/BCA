//
//  ELP2ndLifeAssuredVC.m
//  iMobile Planner
//
//  Created by Juliana on 11/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ELP2ndLifeAssuredVC.h"
#import "DataClass.h"

@interface ELP2ndLifeAssuredVC () {
    bool backDate;
    int number;
    DataClass *obj;
    NSString *stringID;
}

@end

@implementation ELP2ndLifeAssuredVC

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
    
    obj = [DataClass getInstance];
    
    number = 0;
    
    //-----from db-----
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	stringID = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
    
	FMResultSet *results = [database executeQuery:@"select * from  Trad_Details where SINo = ?",stringID,Nil];
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
    
    if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies2ndLA"] isEqualToString:@"Y"]) {
		_q1SC.selectedSegmentIndex = 0;
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies2ndLA"] isEqualToString:@"N"]) {
		_q1SC.selectedSegmentIndex = 1;
	}
    
    if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA2ndLA"] isEqualToString:@"Y"]) {
		_q2aSC.selectedSegmentIndex = 0;
        _q2bSC.enabled = TRUE;
        _q2cSC.enabled = TRUE;
        _q2dSC.enabled = TRUE;
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA2ndLA"] isEqualToString:@"N"]) {
		_q2aSC.selectedSegmentIndex = 1;
	}
    
    if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeB2ndLA"] isEqualToString:@"Y"]) {
		_q2bSC.selectedSegmentIndex = 0;
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeB2ndLA"] isEqualToString:@"N"]) {
		_q2bSC.selectedSegmentIndex = 1;
	}
    
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeC2ndLA"] isEqualToString:@"Y"]) {
		_q2cSC.selectedSegmentIndex = 0;
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeC2ndLA"] isEqualToString:@"N"]) {
		_q2cSC.selectedSegmentIndex = 1;
	}
    
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeD2ndLA"] isEqualToString:@"Y"]) {
		_q2dSC.selectedSegmentIndex = 0;
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeD2ndLA"] isEqualToString:@"N"]) {
		_q2dSC.selectedSegmentIndex = 1;
	}
    
    //for traditional plans only
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"CashDividend"] isEqualToString:@"POF"]) {
		[_cdwwdBtn setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[_cdkwtcBtn setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"CashDividend"] isEqualToString:@"ACC"]) {
		[_cdwwdBtn setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_cdkwtcBtn setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
	}
	
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TradGuaranteedCPI"] isEqualToString:@"POF"]) {
		[_gcpwwdBtn setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[_gcpkwtcBtn setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TradGuaranteedCPI"] isEqualToString:@"ACC"]) {
		[_gcpwwdBtn setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_gcpkwtcBtn setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
	}
	_wwdLbl.text = [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TPWithdrawPct"];
	_kwtcLbl.text = [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TPKeepPct"];
    
    //for ever series only
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"EverGuaranteedCPI"] isEqualToString:@"Y"]) {
		[_egcpwwdBtn setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_gcprBtn setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"EverGuaranteedCPI"] isEqualToString:@"N"]) {
		[_egcpwwdBtn setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		[_gcprBtn setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"EverGuaranteedCPI"] isEqualToString:@"Reinvest"]) {
		[_egcpwwdBtn setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		[_gcprBtn setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
	}
    
    //special request
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PolicyBackdating2ndLA"] isEqualToString:@"Y"]) {
		[_backdateCheck setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        backDate = !backDate;
        _backdateBtn.enabled = TRUE;
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PolicyBackdating2ndLA"] isEqualToString:@"N"]) {
		[_backdateCheck setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	_backdateLbl.text = [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdating2ndLA"];
	//
	if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy2ndLA"] objectForKey:@"PolicyData"] count] != 0) {
		_viewBtn.hidden = NO;
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setQ1SC:nil];
    [self setAddBtn:nil];
    [self setViewBtn:nil];
    [self setQ2aSC:nil];
    [self setQ2bSC:nil];
    [self setQ2cSC:nil];
    [self setQ2dSC:nil];
    [self setCdwwdBtn:nil];
    [self setCdkwtcBtn:nil];
    [self setGcpkwtcBtn:nil];
    [self setKwtcLbl:nil];
    [self setGcprBtn:nil];
    [self setBackdateLbl:nil];
    [self setBackdateBtn:nil];
    [self setBackdateCheck:nil];
    [super viewDidUnload];
}

#pragma mark - actions
- (IBAction)addViewPolicyAction:(id)sender {
    if ([sender selectedSegmentIndex] == 0) {
		_addBtn.hidden = NO;
	}
	else {
		_addBtn.hidden = YES;
		_viewBtn.hidden = YES;
	}
}

- (IBAction)actionForNoticeA:(id)sender {
    if ([sender selectedSegmentIndex] == 0) {
		_q2bSC.enabled = YES;
		_q2cSC.enabled = YES;
		_q2dSC.enabled = YES;
	}
	else {
		_q2bSC.enabled = NO;
		_q2cSC.enabled = NO;
		_q2dSC.enabled = NO;
	}
}

- (IBAction)actionForBackDate:(id)sender {
    if (!backDate) {
        [_backdateCheck setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        _backdateBtn.enabled = TRUE;
        [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"PolicyBackdating2ndLA"];
    }
    else {
        [_backdateCheck setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        _backdateBtn.enabled = FALSE;
        [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"PolicyBackdating2ndLA"];
    }
    backDate = !backDate;
}

- (IBAction)actionForBackDateBtn:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    _backdateLbl.text = dateString;
	//	_dateSpecialReqLbl.textColor = [UIColor blackColor];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    
    if (_SIDate == Nil) {
        
        _SIDate = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIDate"];
        _SIDate.delegate = self;
        _SIDatePopover = [[UIPopoverController alloc] initWithContentViewController:_SIDate];
    }
    
    [_SIDatePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [_SIDatePopover presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    
    dateFormatter = Nil;
    dateString = Nil, mainStoryboard = nil;
}

- (IBAction)segmentChange:(id)sender {
    if ([sender isEqual:_q1SC]) {
        if (_q1SC.selectedSegmentIndex == 0) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"ExistingPolicies2ndLA"];
        }
        else if (_q1SC.selectedSegmentIndex == 1) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"ExistingPolicies2ndLA"];
        }
    }
    else if ([sender isEqual:_q2aSC]) {
        if (_q2aSC.selectedSegmentIndex == 0) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"NoticeA2ndLA"];
        }
        else if (_q2aSC.selectedSegmentIndex == 1) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"NoticeA2ndLA"];
        }
        
    }
    else if ([sender isEqual:_q2bSC]) {
        if (_q2bSC.selectedSegmentIndex == 0) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"NoticeB2ndLA"];
        }
        else if (_q2bSC.selectedSegmentIndex == 1) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"NoticeB2ndLA"];
        }
        
    }
    else if ([sender isEqual:_q2cSC]) {
        if (_q2cSC.selectedSegmentIndex == 0) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"NoticeC2ndLA"];
        }
        else if (_q2cSC.selectedSegmentIndex == 1) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"NoticeC2ndLA"];
        }
    }
    else if ([sender isEqual:_q2dSC]) {
        if (_q2dSC.selectedSegmentIndex == 0) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"NoticeD2ndLA"];
        }
        else if (_q2dSC.selectedSegmentIndex == 1) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"NoticeD2ndLA"];
        }
    }
}

- (IBAction)viewPolicyAction:(id)sender {
    MainExistingPolicyLA2Listing *mepl = [self.storyboard instantiateViewControllerWithIdentifier:@"MainExistingPolicyLA2Listing"];
	mepl.delegate = self;
	mepl.modalPresentationStyle = UIModalPresentationFormSheet;
	[self presentViewController:mepl animated:YES completion:Nil];
}


- (IBAction)addPolicyAction:(id)sender {
    [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy2ndLA"] setValue:Nil forKey:@"WhichPolicy"];
	[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy2ndLA"] setValue:[NSNumber numberWithInt:number] forKey:@"Count"];
    MainAddPolicyLA2VC *mapvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainAddPolicyLA2"];
	mapvc.delegate = self;
	mapvc.modalPresentationStyle = UIModalPresentationFormSheet;
	[self presentViewController:mapvc animated:YES completion:Nil];
}

#pragma mark - delegate
-(void)CloseWindow
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
	[self.SIDatePopover dismissPopoverAnimated:YES];
}

-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
	_backdateLbl.text = strDate;
    [[obj.eAppData objectForKey:@"SecC"] setValue:strDate forKey:@"DatePolicyBackdating2ndLA"];
    
    
}

- (void)saveDataLA2:(int)clickLA2 {
    if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy2ndLA"] objectForKey:@"PolicyData"] count] > 0) {
        _viewBtn.hidden = NO;
    }
    else {
        _viewBtn.hidden = YES;
    }
}

- (void)haveDataLA2:(BOOL)hLA2 {
	if (hLA2) {
		_viewBtn.hidden = NO;
	}
	else {
		_viewBtn.hidden = YES;
	}
}

@end
