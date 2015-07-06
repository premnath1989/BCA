//
//  ExistingLifePolicies.m
//  iMobile Planner
//
//  Created by Erza on 7/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ExistingLifePolicies.h"
#import "DataClass.h"

@interface ExistingLifePolicies () {
	DataClass *obj;
}

@end

@implementation ExistingLifePolicies

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
	
	
	_personTypeLbl.text = [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PersonType"];
	//Q1
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies"] isEqualToString:@"Y"]) {
		_Q1SC.selectedSegmentIndex = 0;
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies"] isEqualToString:@"N"]) {
		_Q1SC.selectedSegmentIndex = 1;
	}
	//
	//Notice
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA"] isEqualToString:@"Y"]) {
		_noticeASC.selectedSegmentIndex = 0;
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeA"] isEqualToString:@"N"]) {
		_noticeASC.selectedSegmentIndex = 1;
	}
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeB"] isEqualToString:@"Y"]) {
		_noticeBSC.selectedSegmentIndex = 0;
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeB"] isEqualToString:@"N"]) {
		_noticeBSC.selectedSegmentIndex = 1;
	}
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeC"] isEqualToString:@"Y"]) {
		_noticeCSC.selectedSegmentIndex = 0;
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeC"] isEqualToString:@"N"]) {
		_noticeCSC.selectedSegmentIndex = 1;
	}
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeD"] isEqualToString:@"Y"]) {
		_noticeDSC.selectedSegmentIndex = 0;
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"NoticeD"] isEqualToString:@"N"]) {
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
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PolicyBackdating"] isEqualToString:@"Y"]) {
		[_btnPolicyBdt setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PolicyBackdating"] isEqualToString:@"N"]) {
		[_btnPolicyBdt setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	_dateSpecialReqLbl.text = [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"DatePolicyBackdating"];
	//
	if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] objectForKey:@"PolicyData"] count] != 0) {
		_viewPolicyBtn.hidden = NO;
	}
}

- (void)saveData:(int)click {
	NSLog(@"click bbb: %d", click);
//	if (click > 0) {
		_viewPolicyBtn.hidden = NO;
//	}
//	else {
//		_viewPolicyBtn.hidden = YES;
//	}
}

- (void)saveDataPO:(int)clickPO {
	
}

- (void)saveDataLA2:(int)clickLA2 {
	
}

- (void)haveData:(BOOL)h {
	if (h) {
		_viewPolicyBtn.hidden = NO;
	}
	else {
		_viewPolicyBtn.hidden = YES;
	}
}

- (void)haveDataPO:(BOOL)hPO {
	if (hPO) {
		_viewPolicyPOBtn.hidden = NO;
	}
	else {
		_viewPolicyPOBtn.hidden = YES;
	}
}

- (void)haveDataLA2:(BOOL)hLA2 {
	if (hLA2) {
		_viewPolicyLA2Btn.hidden = NO;
	}
	else {
		_viewPolicyLA2Btn.hidden = YES;
	}
}

- (void)viewWillAppear:(BOOL)animated {
	NSLog(@"viewWillAppear");
}

//Add Item To Array
- (IBAction)actionForAddPolicy:(id)sender {
//	NSLog(@"s: %d, num: %d", s, number);
	[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] setValue:Nil forKey:@"WhichPolicy"];
	[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] setValue:[NSNumber numberWithInt:number] forKey:@"Count"];
    MainAddPolicyVC *mapvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainAddPolicy"];
	mapvc.delegate = self;
	mapvc.modalPresentationStyle = UIModalPresentationFormSheet;
	[self presentViewController:mapvc animated:YES completion:Nil];
}

- (IBAction)actionForAddPolicyPO:(id)sender {
	[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyPO"] setValue:Nil forKey:@"WhichPolicy"];
	[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyPO"] setValue:[NSNumber numberWithInt:number] forKey:@"Count"];
    MainAddPolicyPOVC *mappovc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainAddPolicyPO"];
//	mappovc.delegate = self;
	mappovc.modalPresentationStyle = UIModalPresentationFormSheet;
	[self presentViewController:mappovc animated:YES completion:Nil];
}

- (IBAction)actionForAddPolicyLA2:(id)sender {
	[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyLA2"] setValue:Nil forKey:@"WhichPolicy"];
	[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicyLA2"] setValue:[NSNumber numberWithInt:number] forKey:@"Count"];
    MainAddPolicyLA2VC *mapla2vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainAddPolicyLA2"];
	//	mapla2vc.delegate = self;
	mapla2vc.modalPresentationStyle = UIModalPresentationFormSheet;
	[self presentViewController:mapla2vc animated:YES completion:Nil];
}

- (IBAction)actionForViewPolicy:(id)sender {
	MainExistingPolicyListing *mepl = [self.storyboard instantiateViewControllerWithIdentifier:@"MainExistingPolicyListing"];
	mepl.delegate = self;
	mepl.modalPresentationStyle = UIModalPresentationFormSheet;
	[self presentViewController:mepl animated:YES completion:Nil];
}

- (IBAction)actionForViewPolicyPO:(id)sender {
	MainExistingPolicyPOListing *meppol = [self.storyboard instantiateViewControllerWithIdentifier:@"MainExistingPolicyPOListing"];
//	meppol.delegate = self;
	meppol.modalPresentationStyle = UIModalPresentationFormSheet;
	[self presentViewController:meppol animated:YES completion:Nil];
}

- (IBAction)actionForViewPolicyLA2:(id)sender {
	MainExistingPolicyLA2Listing *mepla2l = [self.storyboard instantiateViewControllerWithIdentifier:@"MainExistingPolicyLA2Listing"];
	//	mepla2l.delegate = self;
	mepla2l.modalPresentationStyle = UIModalPresentationFormSheet;
	[self presentViewController:mepla2l animated:YES completion:Nil];
}

- (IBAction)actionForAddViewPolicy:(id)sender {
	if ([sender selectedSegmentIndex] == 0) {
		_addPolicyBtn.hidden = NO;
//		if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] objectForKey:@"PolicyData"] count] != 0) {
//			_viewPolicyBtn.hidden = NO;
//		}
	}
	else {
		_addPolicyBtn.hidden = YES;
		_viewPolicyBtn.hidden = YES;
	}
//	_addPolicyPOBtn.hidden = YES;
//	_viewPolicyPOBtn.hidden = YES;
}

- (IBAction)actionForAddViewPolicyPO:(id)sender {
	if ([sender selectedSegmentIndex] == 0) {
		_addPolicyPOBtn.hidden = NO;
	}
	else {
		_addPolicyPOBtn.hidden = YES;
		_viewPolicyPOBtn.hidden = YES;
	}
//	_addPolicyBtn.hidden = YES;
//	_viewPolicyBtn.hidden = YES;
}

- (IBAction)actionForAddViewPolicyLA2:(id)sender {
	if ([sender selectedSegmentIndex] == 0) {
		_addPolicyLA2Btn.hidden = NO;
	}
	else {
		_addPolicyLA2Btn.hidden = YES;
		_viewPolicyLA2Btn.hidden = YES;
	}
	//	_addPolicyBtn.hidden = YES;
	//	_viewPolicyBtn.hidden = YES;
}

- (IBAction)actionForPersonType:(id)sender {
	if (_PersonTypePicker == nil) {
        _PersonTypePicker = [[ExistingPoliciesPersonType alloc] initWithStyle:UITableViewStylePlain];
		
        _PersonTypePicker.delegate = self;
        self.PersonTypePopover = [[UIPopoverController alloc] initWithContentViewController:_PersonTypePicker];
    }
    
    [self.PersonTypePopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)selectedPersonType:(NSString *)thePersonType {
	_personTypeLbl.text = thePersonType;
	[_PersonTypePopover dismissPopoverAnimated:YES];
	if ([thePersonType isEqualToString:@"1st Life Assured"]) {
		NSLog(@"in la1");
		_Q1POSC.hidden = TRUE;
		_addPolicyPOBtn.hidden = TRUE;
		_viewPolicyPOBtn.hidden = TRUE;
		_noticeAPOSC.hidden = TRUE;
		_noticeBPOSC.hidden = TRUE;
		_noticeCPOSC.hidden = TRUE;
		_noticeDPOSC.hidden = TRUE;
		_btnPolicyBdtPO.hidden = TRUE;
		_dateSpecialReqPOLbl.hidden = TRUE;
		//		_dateSpecialReqPOLbl.text = @"";
		_btnDateSpecialReqPO.hidden = TRUE;
		
		
		_Q1LA2SC.hidden = TRUE;
		_addPolicyLA2Btn.hidden = TRUE;
		_viewPolicyLA2Btn.hidden = TRUE;
		_noticeALA2SC.hidden = TRUE;
		_noticeBLA2SC.hidden = TRUE;
		_noticeCLA2SC.hidden = TRUE;
		_noticeDLA2SC.hidden = TRUE;
		_btnPolicyBdtLA2.hidden = TRUE;
		_dateSpecialReqLA2Lbl.hidden = TRUE;
		//		_dateSpecialReqPOLbl.text = @"";
		_btnDateSpecialReqPO.hidden = TRUE;
		
		
		_Q1SC.hidden = FALSE;
		if (_Q1SC.selectedSegmentIndex == 0) {
			_addPolicyBtn.hidden = FALSE;
		}
		if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] objectForKey:@"PolicyData"] count] != 0) {
			_viewPolicyBtn.hidden = FALSE;
		}
		else {
			_viewPolicyBtn.hidden = TRUE;
		}
		//		_addPolicyBtn.hidden = TRUE;
		//		_viewPolicyBtn.hidden = TRUE;
		_noticeASC.hidden = FALSE;
		_noticeBSC.hidden = FALSE;
		_noticeCSC.hidden = FALSE;
		_noticeDSC.hidden = FALSE;
		_btnPolicyBdt.hidden = FALSE;
		_dateSpecialReqLbl.hidden = FALSE;
		_btnDateSpecialReq.hidden = FALSE;
		
	}
	else if ([thePersonType isEqualToString:@"Policy Owner"]) {
		NSLog(@"in po");
		_Q1POSC.hidden = FALSE;
		if (_Q1POSC.selectedSegmentIndex == 0) {
			_addPolicyPOBtn.hidden = FALSE;
		}
		//		_addPolicyPOBtn.hidden = TRUE;
		//		_viewPolicyPOBtn.hidden = TRUE;
		_noticeAPOSC.hidden = FALSE;
		_noticeBPOSC.hidden = FALSE;
		_noticeCPOSC.hidden = FALSE;
		_noticeDPOSC.hidden = FALSE;
		_btnPolicyBdtPO.hidden = FALSE;
		_dateSpecialReqPOLbl.hidden = FALSE;
		_btnDateSpecialReqPO.hidden = FALSE;
		
		
		_Q1LA2SC.hidden = TRUE;
		_addPolicyLA2Btn.hidden = TRUE;
		_viewPolicyLA2Btn.hidden = TRUE;
		_noticeALA2SC.hidden = TRUE;
		_noticeBLA2SC.hidden = TRUE;
		_noticeCLA2SC.hidden = TRUE;
		_noticeDLA2SC.hidden = TRUE;
		_btnPolicyBdtLA2.hidden = TRUE;
		_dateSpecialReqLA2Lbl.hidden = TRUE;
		//		_dateSpecialReqPOLbl.text = @"";
		_btnDateSpecialReqPO.hidden = TRUE;
		
		
		_Q1SC.hidden = TRUE;
		_addPolicyBtn.hidden = TRUE;
		_viewPolicyBtn.hidden = TRUE;
		_noticeASC.hidden = TRUE;
		_noticeBSC.hidden = TRUE;
		_noticeCSC.hidden = TRUE;
		_noticeDSC.hidden = TRUE;
		_btnPolicyBdt.hidden = TRUE;
		_dateSpecialReqLbl.hidden = TRUE;
		//		_dateSpecialReqLbl.text = @"";
		_btnDateSpecialReq.hidden = TRUE;
		
	}
	else if ([thePersonType isEqualToString:@"2nd Life Assured"]) {
		NSLog(@"in la2");
		_Q1LA2SC.hidden = FALSE;
		if (_Q1LA2SC.selectedSegmentIndex == 0) {
			_addPolicyLA2Btn.hidden = FALSE;
		}
		//		_addPolicyPOBtn.hidden = TRUE;
		//		_viewPolicyPOBtn.hidden = TRUE;
		_noticeALA2SC.hidden = FALSE;
		_noticeBLA2SC.hidden = FALSE;
		_noticeCLA2SC.hidden = FALSE;
		_noticeDLA2SC.hidden = FALSE;
		_btnPolicyBdtLA2.hidden = FALSE;
		_dateSpecialReqLA2Lbl.hidden = FALSE;
		_btnDateSpecialReqLA2.hidden = FALSE;
		
		
		_Q1SC.hidden = TRUE;
		_addPolicyBtn.hidden = TRUE;
		_viewPolicyBtn.hidden = TRUE;
		_noticeASC.hidden = TRUE;
		_noticeBSC.hidden = TRUE;
		_noticeCSC.hidden = TRUE;
		_noticeDSC.hidden = TRUE;
		_btnPolicyBdt.hidden = TRUE;
		_dateSpecialReqLbl.hidden = TRUE;
		//		_dateSpecialReqLbl.text = @"";
		_btnDateSpecialReq.hidden = TRUE;
		
		
		_Q1POSC.hidden = TRUE;
		_addPolicyPOBtn.hidden = TRUE;
		_viewPolicyPOBtn.hidden = TRUE;
		_noticeAPOSC.hidden = TRUE;
		_noticeBPOSC.hidden = TRUE;
		_noticeCPOSC.hidden = TRUE;
		_noticeDPOSC.hidden = TRUE;
		_btnPolicyBdtPO.hidden = TRUE;
		_dateSpecialReqPOLbl.hidden = TRUE;
		//		_dateSpecialReqPOLbl.text = @"";
		_btnDateSpecialReqPO.hidden = TRUE;
		
	}
}

- (IBAction)actionForSelectedPT:(id)sender {
	if (_selectedPTSC.selectedSegmentIndex == 0) {
		NSLog(@"in la1");
		_Q1POSC.hidden = TRUE;
		_addPolicyPOBtn.hidden = TRUE;
		_viewPolicyPOBtn.hidden = TRUE;
		_noticeAPOSC.hidden = TRUE;
		_noticeBPOSC.hidden = TRUE;
		_noticeCPOSC.hidden = TRUE;
		_noticeDPOSC.hidden = TRUE;
		_btnPolicyBdtPO.hidden = TRUE;
		_dateSpecialReqPOLbl.hidden = TRUE;
		//		_dateSpecialReqPOLbl.text = @"";
		_btnDateSpecialReqPO.hidden = TRUE;
		
		_Q1SC.hidden = FALSE;
		if (_Q1SC.selectedSegmentIndex == 0) {
			_addPolicyBtn.hidden = FALSE;
		}
		if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] objectForKey:@"PolicyData"] count] != 0) {
			_viewPolicyBtn.hidden = FALSE;
		}
		else {
			_viewPolicyBtn.hidden = TRUE;
		}
		//		_addPolicyBtn.hidden = TRUE;
		//		_viewPolicyBtn.hidden = TRUE;
		_noticeASC.hidden = FALSE;
		_noticeBSC.hidden = FALSE;
		_noticeCSC.hidden = FALSE;
		_noticeDSC.hidden = FALSE;
		_btnPolicyBdt.hidden = FALSE;
		_dateSpecialReqLbl.hidden = FALSE;
		_btnDateSpecialReq.hidden = FALSE;
		
	}
	else {
		NSLog(@"in po");
		_Q1POSC.hidden = FALSE;
		if (_Q1POSC.selectedSegmentIndex == 0) {
			_addPolicyPOBtn.hidden = FALSE;
		}
		//		_addPolicyPOBtn.hidden = TRUE;
		//		_viewPolicyPOBtn.hidden = TRUE;
		_noticeAPOSC.hidden = FALSE;
		_noticeBPOSC.hidden = FALSE;
		_noticeCPOSC.hidden = FALSE;
		_noticeDPOSC.hidden = FALSE;
		_btnPolicyBdtPO.hidden = FALSE;
		_dateSpecialReqPOLbl.hidden = FALSE;
		_btnDateSpecialReqPO.hidden = FALSE;
		
		_Q1SC.hidden = TRUE;
		_addPolicyBtn.hidden = TRUE;
		_viewPolicyBtn.hidden = TRUE;
		_noticeASC.hidden = TRUE;
		_noticeBSC.hidden = TRUE;
		_noticeCSC.hidden = TRUE;
		_noticeDSC.hidden = TRUE;
		_btnPolicyBdt.hidden = TRUE;
		_dateSpecialReqLbl.hidden = TRUE;
		//		_dateSpecialReqLbl.text = @"";
		_btnDateSpecialReq.hidden = TRUE;
	}
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//	[_po1cell moveRowAtIndexPath:2 toIndexPath:1];
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//	return [super tableView:tableView numberOfRowsInSection:section];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	static NSString *CellIdentifier = @"TestCell";
//	UITableViewCell *cell;
//	
//	if (indexPath.row == 2) {
//		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//		if (!cell)
//		{  cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//		}
//		
//		cell.textLabel.text = @"Type_____Company_____Life/Term_____Accident_____Critical Illness_____DateIssued";
//		return cell;
//	}
//	else if (indexPath.row != 2) {
//		return [super tableView:tableView cellForRowAtIndexPath:indexPath];
//	}
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)actionForTradCashDiv:(id)sender {
	UIButton *btnPressed = (UIButton*)sender;
    
    if (btnPressed.tag == 1) {
		
		[_btnTCDW setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		isWithdrawCashDiv = YES;
		
		[_btnTCDK setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isKeepCashDiv = NO;
	}
	else if (btnPressed.tag == 2) {
		
		[_btnTCDK setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		isKeepCashDiv = YES;
		
		[_btnTCDW setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isWithdrawCashDiv = NO;
	}
}

- (IBAction)actionForTradGuaranteed:(id)sender {
	UIButton *btnPressed = (UIButton*)sender;
    
	_withdrawGuaranteedTF.hidden = YES;
	_pctWithdrawGuaranteed.hidden = YES;
	_keepGuaranteedTF.hidden = YES;
	_pctKeepGuaranteed.hidden = YES;


    if (btnPressed.tag == 1) {
		
		[_btnTGW setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		isWithdrawTradGuaranteed = YES;
		
		[_btnTGK setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isKeepTradGuaranteed = NO;
		
		_withdrawGuaranteedTF.hidden = NO;
		_pctWithdrawGuaranteed.hidden = NO;
	}
	else if (btnPressed.tag == 2) {
		
		[_btnTGK setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		isKeepTradGuaranteed = YES;
		
		[_btnTGW setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isWithdrawTradGuaranteed = NO;
		
		_keepGuaranteedTF.hidden = NO;
		_pctKeepGuaranteed.hidden = NO;
	}
}

- (IBAction)actionForEverGuaranteed:(id)sender {
	UIButton *btnPressed = (UIButton*)sender;
    
    if (btnPressed.tag == 1) {
		
		[_btnEGW setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		isWithdrawEverGuaranteed = YES;
		
		[_btnEGI setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isReinvestEverGuaranteed = NO;
	}
	else if (btnPressed.tag == 2) {
		
		[_btnEGI setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		isReinvestEverGuaranteed = YES;
		
		[_btnEGW setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		isWithdrawEverGuaranteed = NO;
	}

}

- (IBAction)actionForSpecialReq:(id)sender {
	isPolicyBdt = !isPolicyBdt;
	if(isPolicyBdt) {
		[_btnPolicyBdt setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		_btnDateSpecialReq.enabled = YES;_pb = TRUE;
	}
	else {
		[_btnPolicyBdt setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		_btnDateSpecialReq.enabled = NO;
		_dateSpecialReqLbl.text = @"";
//		_dateSpecialReqLbl.textColor = [UIColor lightGrayColor];
		_pb = FALSE;
	}
}

- (IBAction)actionForSpecialReqPO:(id)sender {
	isPolicyBdtPO = !isPolicyBdtPO;
	if(isPolicyBdtPO) {
		[_btnPolicyBdtPO setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		_btnDateSpecialReqPO.enabled = YES;_pbPO = TRUE;
	}
	else {
		[_btnPolicyBdtPO setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		_btnDateSpecialReqPO.enabled = NO;
		_dateSpecialReqPOLbl.text = @"";
		//		_dateSpecialReqLbl.textColor = [UIColor lightGrayColor];
		_pbPO = FALSE;
	}

}

- (IBAction)actionForSpecialReqLA2:(id)sender {
	isPolicyBdtLA2 = !isPolicyBdtLA2;
	if(isPolicyBdtLA2) {
		[_btnPolicyBdtLA2 setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		_btnDateSpecialReqLA2.enabled = YES;_pbLA2 = TRUE;
	}
	else {
		[_btnPolicyBdtLA2 setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		_btnDateSpecialReqLA2.enabled = NO;
		_dateSpecialReqLA2Lbl.text = @"";
		//		_dateSpecialReqLbl.textColor = [UIColor lightGrayColor];
		_pbLA2 = FALSE;
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

- (IBAction)actionForDateSpecialReqPO:(id)sender {
	whichPType = @"PO";
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    _dateSpecialReqPOLbl.text = dateString;
	//	_dateSpecialReqLbl.textColor = [UIColor blackColor];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    
    if (_SIDatePO == Nil) {
        
        self.SIDatePO = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIDate"];
        _SIDatePO.delegate = self;
        self.SIDatePOPopover = [[UIPopoverController alloc] initWithContentViewController:_SIDatePO];
    }
    
    [self.SIDatePOPopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.SIDatePOPopover presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    
    dateFormatter = Nil;
    dateString = Nil, mainStoryboard = nil;

}

- (IBAction)actionForDateSpecialReqLA2:(id)sender {
	whichPType = @"LA2";
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    _dateSpecialReqLA2Lbl.text = dateString;
	//	_dateSpecialReqLbl.textColor = [UIColor blackColor];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    
    if (_SIDateLA2 == Nil) {
        
        self.SIDateLA2 = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIDate"];
        _SIDateLA2.delegate = self;
        self.SIDateLA2Popover = [[UIPopoverController alloc] initWithContentViewController:_SIDateLA2];
    }
    
    [self.SIDateLA2Popover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.SIDateLA2Popover presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    
    dateFormatter = Nil;
    dateString = Nil, mainStoryboard = nil;
	
}

-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
	if ([whichPType isEqualToString:@"LA1"]) {
		NSLog(@"sidatestring");
		_dateSpecialReqLbl.text = strDate;
	}
    else if ([whichPType isEqualToString:@"PO"]) {
		NSLog(@"sidatepostring");
		_dateSpecialReqPOLbl.text = strDate;
	}
	else if ([whichPType isEqualToString:@"LA2"]) {
		NSLog(@"sidatela2string");
		_dateSpecialReqLA2Lbl.text = strDate;
	}
//	_dateSpecialReqLbl.textColor = [UIColor blackColor];
}

-(void)CloseWindow
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
	if ([whichPType isEqualToString:@"LA1"]) {
		NSLog(@"sidate");
		[self.SIDatePopover dismissPopoverAnimated:YES];
//		[self.SIDatePOPopover dismissPopoverAnimated:YES];
	}
	else if ([whichPType isEqualToString:@"PO"]) {
		NSLog(@"sidatepo");
//		[self.SIDatePopover dismissPopoverAnimated:YES];
		[self.SIDatePOPopover dismissPopoverAnimated:YES];
	}
	else if ([whichPType isEqualToString:@"LA2"]) {
		NSLog(@"sidatela2");
		//		[self.SIDatePopover dismissPopoverAnimated:YES];
		[self.SIDateLA2Popover dismissPopoverAnimated:YES];
	}
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

- (IBAction)actionForNoticeAPO:(id)sender {
	if ([sender selectedSegmentIndex] == 0) {
		_noticeBPOSC.enabled = YES;
		_noticeCPOSC.enabled = YES;
		_noticeDPOSC.enabled = YES;
	}
	else {
		_noticeBPOSC.enabled = NO;
		_noticeCPOSC.enabled = NO;
		_noticeDPOSC.enabled = NO;
	}
}

- (IBAction)actionForNoticeALA2:(id)sender {
	if ([sender selectedSegmentIndex] == 0) {
		_noticeBLA2SC.enabled = YES;
		_noticeCLA2SC.enabled = YES;
		_noticeDLA2SC.enabled = YES;
	}
	else {
		_noticeBLA2SC.enabled = NO;
		_noticeCLA2SC.enabled = NO;
		_noticeDLA2SC.enabled = NO;
	}
}

//- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
//	[super setEditing:editing animated:animated];
//	[_existingPolicyTbV setEditing:editing animated:animated];
//	NSMutableArray* paths = [[NSMutableArray alloc] init];
//	
//    // fill paths of insertion rows here
//	
//    if(editing)
//        [_existingPolicyTbV insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationBottom];
//    else
//        [_existingPolicyTbV deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationBottom];	
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//	if (_existingPolicyTbV.editing) 
//		return 3;
//}
//
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//	return UITableViewCellEditingStyleInsert;
//}

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
	[self setExistingPolicyTbV:nil];
	[self setAddPolicyBtn:nil];
	[self setViewPolicyBtn:nil];
	[self setPo1cell:nil];
	[self setPo2cell:nil];
	[self setPo3cell:nil];
	[self setPo4cell:nil];
	[self setLa1cell:nil];
	[self setLa2cell:nil];
	[self setLa3cell:nil];
	[self setLa4cell:nil];
    [self setQ1POSC:nil];
    [self setAddPolicyPOBtn:nil];
    [self setViewPolicyPOBtn:nil];
    [self setNoticeAPOSC:nil];
    [self setNoticeBPOSC:nil];
    [self setNoticeCPOSC:nil];
    [self setNoticeDPOSC:nil];
	[self setBtnPolicyBdtPO:nil];
	[self setBtnDateSpecialReqPO:nil];
	[self setDateSpecialReqPOLbl:nil];
	[self setSelectedPTSC:nil];
	[self setQ1LA2SC:nil];
	[self setAddPolicyLA2Btn:nil];
	[self setViewPolicyLA2Btn:nil];
	[self setNoticeALA2SC:nil];
	[self setNoticeBLA2SC:nil];
	[self setNoticeCLA2SC:nil];
	[self setNoticeDLA2SC:nil];
	[self setBtnPolicyBdtLA2:nil];
	[self setDateSpecialReqLA2Lbl:nil];
	[self setBtnDateSpecialReqLA2:nil];
	[super viewDidUnload];
}
@end
