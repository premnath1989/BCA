//
//  ELP1stLifeAssuredVC.m
//  iMobile Planner
//
//  Created by Juliana on 11/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ELP1stLifeAssuredVC.h"
#import "DataClass.h"
#import <QuartzCore/QuartzCore.h>

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
    
    NSLog(@"seg setSelectedSegmentIndex %d", _Q1SC.selectedSegmentIndex);
    NSLog(@"seg2 setSelectedSegmentIndex %d", _Q2SC.selectedSegmentIndex);

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
	
	[database close];
	//
	
	
//	_personTypeLbl.text = [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PersonType"];
	//Q1
    
    if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PreferredLife"] isEqualToString:@"Y"])
    {
		 [_prefferedLifeImage setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
	}
    
    else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"PreferredLife"] isEqualToString:@"N"])
    {
         [_prefferedLifeImage setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    }

      
	if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies1stLA"] isEqualToString:@"Y"])
    {
		_Q1SC.selectedSegmentIndex = 0;
        _addPolicyBtn.hidden = FALSE;
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies1stLA"] isEqualToString:@"N"])
    {
		_Q1SC.selectedSegmentIndex = 1;
	}
    
    if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies1stLACR"] isEqualToString:@"Y"])
    {
		_Q2SC.selectedSegmentIndex = 0;
        _addPolicyBtn.hidden = FALSE;
	}
	else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicies1stLACR"] isEqualToString:@"N"])
    {
		_Q2SC.selectedSegmentIndex = 1;
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
    
    

        //Basvi added code 
    NSString *plan =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"];
	NSString *sitype = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"];
    //for traditional
    if ([sitype isEqualToString:@"TRAD"]) {
        _forEverSeriesonlyLbl.textColor = [UIColor grayColor];
        _guarentedforEverSeriesonlyLbl.textColor = [UIColor grayColor];
        _withdrawwheneverdueforEverSeriesonlyLbl.textColor = [UIColor grayColor];
        _reInvestforEverSeriesonlyLbl.textColor = [UIColor grayColor];
        _forTraditionalplansonlyLbl.textColor = [UIColor grayColor];
        _cashdivforTraditionalplansonlyLbl.textColor = [UIColor grayColor];
        _guarentedforTraditionalplansonlyLbl.textColor = [UIColor grayColor];
        _withdrawwheneverdue1forTraditionalplansonlyLbl.textColor = [UIColor grayColor];
        _withdrawwheneverdue2forTraditionalplansonlyLbl.textColor = [UIColor grayColor];
        _keepwithcompany1forTraditionalplansonlyLbl.textColor = [UIColor grayColor];
        _keepwithcompany2forTraditionalplansonlyLbl.textColor = [UIColor grayColor];
        
        
        
      
    }
    else
    {   _forTraditionalplansonlyLbl.textColor = [UIColor grayColor];
        _cashdivforTraditionalplansonlyLbl.textColor = [UIColor grayColor];
        _guarentedforTraditionalplansonlyLbl.textColor = [UIColor grayColor];
        _withdrawwheneverdue1forTraditionalplansonlyLbl.textColor = [UIColor grayColor];
        _withdrawwheneverdue2forTraditionalplansonlyLbl.textColor = [UIColor grayColor];
        _keepwithcompany1forTraditionalplansonlyLbl.textColor = [UIColor grayColor];
        _keepwithcompany2forTraditionalplansonlyLbl.textColor = [UIColor grayColor];
        
    }
    
    obj = [DataClass getInstance];
    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath1 = [paths1 objectAtIndex:0];
    NSString *path1 = [docsPath1 stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database1 = [FMDatabase databaseWithPath:path1];
    [database1 open];

    
    
    NSString *ridercode;
    NSString *PolicyType;
    NSString *sino = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
    NSString *eproposalNo =  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    NSString *BasicPlanCode = @"";
    NSString *payeeType;
    if(ridercode==NULL|| nil)
        ridercode = @"";
    if(BasicPlanCode==NULL||nil)
        BasicPlanCode = @"";
    if(PolicyType==NULL||nil)
        PolicyType = @"";
    
    
    NSString *selectPO = [NSString stringWithFormat:@"select PTypeCode, LANewICNo, LAOtherIDType, LAOtherID, MobilePhoneNo,MobilePhoneNoPrefix, EmailAddress FROM eProposal_LA_Details WHERE eProposalNo = '%@'",eproposalNo];
    
    FMResultSet *results8;
    results8 = [database1 executeQuery:selectPO];
    
     NSMutableArray *LifeAssure1st = [[NSMutableArray alloc]init];
    while ([results8 next])
    {
        payeeType = [results8 objectForColumnName:@"PTypeCode"];
        
        [LifeAssure1st addObject:payeeType];

        NSLog(@"payeeType1 %@",payeeType);
        
        
    }

    
    
    FMResultSet *results3;
    results3 = [database1 executeQuery:@"SELECT BasicPlanCode from eProposal WHERE eProposalNo = ?",eproposalNo];
    while ([results3 next]) {
        
        BasicPlanCode = [results3 stringForColumn:@"BasicPlanCode"];
        
    }
    
    
    results3 = [database1 executeQuery:@"SELECT Ridercode, PTypecode FROM TRAD_Rider_Details WHERE RiderCode in ('WBD10R30', 'WB30R','WBI6R30','EDUWR','WB50R') "
                "AND SINO = ?",sino];
    

    
    NSMutableArray *LifeAssure1stRider = [[NSMutableArray alloc]init];
    
    
    while ([results3 next]) {
        
        PolicyType = [results3 stringForColumn:@"PTypeCode"];
        
        ridercode = [results3 stringForColumn:@"RiderCode"];
        
        
         [LifeAssure1stRider addObject:ridercode];
        
               
        
    }
    [database1 close];
    
//    NSString *test =[LifeAssure1st objectAtIndex:0];
//    
//    NSString *RiderLA1;
//    
//         
//    if ([LifeAssure1stRider count] ==0)
//    {
//        
//    }
//    
//    else
//        
//    {
//        RiderLA1 =[LifeAssure1stRider objectAtIndex:0];
//
//    }
    
//    for (int i=0;i <LifeAssure1st.count ; i++)
//    {
//        if (i==0)
//        {
    
   if (ridercode && [PolicyType isEqualToString:@"LA"])
    {
          
            
            if([BasicPlanCode isEqualToString:@"HLAWP"] && [PolicyType isEqualToString:@"LA"] && ([ridercode isEqualToString:@"WBD10R30"]||[ridercode isEqualToString:@"WB30R"]||[ridercode isEqualToString:@"WBI6R30"]||[ridercode isEqualToString:@"EDUWR"] ||[ridercode isEqualToString:@"WB50R"]))
            {
                
                _withdrawPctLbl.text = [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TPWithdrawPct"];
                _keepPctLbl.text = [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TPKeepPct"];
                
                if ([_withdrawPctLbl.text isEqualToString:@"100"])
                {
                    [_btnTGW setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
                    [_btnTGK setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
                }
                
                else if ([_keepPctLbl.text isEqualToString:@"100"])
                {
                    [_btnTGW setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
                    [_btnTGK setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
                }
                
                else
                {
                    [_btnTGW setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
                    [_btnTGK setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
                    
                }
                
                
                
                
                
            }
            
            else
            {
                _withdrawPctLbl.text = @"";
                _keepPctLbl.text = @"";
                
                if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TradGuaranteedCPI"] isEqualToString:@"POF"]) {
                    [_btnTGW setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
                    [_btnTGK setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
                }
                else if ([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"TradGuaranteedCPI"] isEqualToString:@"ACC"]) {
                    [_btnTGW setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
                    [_btnTGK setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
                }
                
                
            }
    }
    
//        }
//        
//    }

    _withdrawPctLbl.textColor = [UIColor grayColor];
    _keepPctLbl.textColor = [UIColor grayColor];
    [[self.withdrawPctLbl layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.withdrawPctLbl layer] setBorderWidth:1.0];
    [[self.withdrawPctLbl layer] setCornerRadius:0.1];
    
    [[self.keepPctLbl layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.keepPctLbl layer] setBorderWidth:1.0];
    [[self.keepPctLbl layer] setCornerRadius:0.1];
    
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
	NSLog(@"Count: %d", [[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] objectForKey:@"PolicyData"] count]);
	if ([[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] objectForKey:@"PolicyData"] count] != 0)
    {
		_viewPolicyBtn.hidden = NO;
	}
    
    if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"] isEqualToString:@"ES"]) {
        _btnPolicyBdt.enabled = FALSE;
        _btnDateSpecialReq.enabled = FALSE;
    }
    else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"] isEqualToString:@"TRAD"]) {
        _btnPolicyBdt.enabled = TRUE;
        _btnDateSpecialReq.enabled = TRUE;
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
	if (h)
    {
		_viewPolicyBtn.hidden = NO;
	}
	else {
		_viewPolicyBtn.hidden = YES;
	}
}

- (IBAction)actionForAddPolicy:(id)sender
{
	//	NSLog(@"s: %d, num: %d", s, number);
	[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] setValue:Nil forKey:@"WhichPolicy"];
	[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] setValue:[NSNumber numberWithInt:number] forKey:@"Count"];
    
    [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy2ndLA"] setValue:Nil forKey:@"WhichPolicy"];
	[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy2ndLA"] setValue:[NSNumber numberWithInt:number] forKey:@"Count"];
    
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

- (IBAction)actionForAddViewPolicy:(id)sender
{
    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
//    UISegmentedControl *segmentedControl = sender;
//    
//    if(segmentedControl.tag == 1 && segmentedControl.selectedSegmentIndex == 0)
//        
//    {
//        _addPolicyBtn.hidden = NO;
//    }
//    else if(segmentedControl.tag == 2 && segmentedControl.selectedSegmentIndex == 0)
//    {
//        _addPolicyBtn.hidden = NO;
//    }
//    else if((segmentedControl.tag == 1 && segmentedControl.selectedSegmentIndex == 1) &&(segmentedControl.tag == 2 && segmentedControl.selectedSegmentIndex == 1))
//    {
//    _addPolicyBtn.hidden = YES;
//    _viewPolicyBtn.hidden = YES;
//    }
    
    if(((_Q1SC.selectedSegmentIndex ==-1)&&(_Q2SC.selectedSegmentIndex ==1))||((_Q2SC.selectedSegmentIndex ==-1)&&(_Q1SC.selectedSegmentIndex ==1)))
    {
        _addPolicyBtn.hidden = YES;
        _viewPolicyBtn.hidden = YES;
        
    }
    
    else
    {
        
        if((_Q1SC.selectedSegmentIndex ==1)&&(_Q2SC.selectedSegmentIndex ==1))
        {
            _addPolicyBtn.hidden = YES;
            _viewPolicyBtn.hidden = YES;
            [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] setValue:Nil forKey:@"PolicyData"];
            
        }
        
        else
        {
            _addPolicyBtn.hidden = NO;
            
        }

        
    }

    
//    if(((_Q2SC.selectedSegmentIndex ==-1)&&(_Q1SC.selectedSegmentIndex ==1)))
//    {
//        _addPolicyBtn.hidden = YES;
//        _viewPolicyBtn.hidden = YES;
//        
//    }
//    
//    else
//    {
//        _addPolicyBtn.hidden = NO;
//        
//    }

    
//    if((_Q1SC.selectedSegmentIndex ==1)&&(_Q2SC.selectedSegmentIndex ==1))
//    {
//        _addPolicyBtn.hidden = YES;
//        _viewPolicyBtn.hidden = YES;
//
//    }
//    
//    else
//    {
//        _addPolicyBtn.hidden = NO;
//        
//    }
    
  
        
    

}



- (IBAction)actionForSpecialReq:(id)sender {
	isPolicyBdt = !isPolicyBdt;
	if(isPolicyBdt) {
		[_btnPolicyBdt setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
		_btnDateSpecialReq.enabled = YES;_pb = TRUE;
        [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"PolicyBackdating1stLA"];
		[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
	}
	else {
		[_btnPolicyBdt setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
		_btnDateSpecialReq.enabled = NO;
		_dateSpecialReqLbl.text = @"";
		//		_dateSpecialReqLbl.textColor = [UIColor lightGrayColor];
		_pb = FALSE;
        [[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"PolicyBackdating1stLA"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:@"" forKey:@"DatePolicyBackdating1stLA"];
		[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
	}
}

- (IBAction)actionForDateSpecialReq:(id)sender {
	whichPType = @"LA1";
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    //_dateSpecialReqLbl.text = dateString;
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
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
	_dateSpecialReqLbl.text = strDate;
	//	_dateSpecialReqLbl.textColor = [UIColor blackColor];
    [[obj.eAppData objectForKey:@"SecC"] setValue:strDate forKey:@"DatePolicyBackdating1stLA"];
    
}

-(void)CloseWindow
{
    NSLog(@"test");
    [self resignFirstResponder];
    [self.view endEditing:YES];
	[self.SIDatePopover dismissPopoverAnimated:YES];
}

- (IBAction)actionForNoticeA:(id)sender {
	if ([sender selectedSegmentIndex] == 0) {
		_noticeBSC.enabled = YES;
		_noticeCSC.enabled = YES;
		_noticeDSC.enabled = YES;_noticeBSC.selectedSegmentIndex = -1;
			_noticeCSC.selectedSegmentIndex = -1;
		_noticeDSC.selectedSegmentIndex = -1;
	}
	else {
		_noticeBSC.enabled = NO;
		_noticeCSC.enabled = NO;
		_noticeDSC.enabled = NO;
		_noticeBSC.selectedSegmentIndex = -1;
		_noticeCSC.selectedSegmentIndex = -1;
		_noticeDSC.selectedSegmentIndex = -1;
		[[obj.eAppData objectForKey:@"SecC"] setValue:@"" forKey:@"NoticeB1stLA"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:@"" forKey:@"NoticeC1stLA"];
		[[obj.eAppData objectForKey:@"SecC"] setValue:@"" forKey:@"NoticeD1stLA"];
	}
}

- (IBAction)segmentChange:(id)sender {
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
    if ([sender isEqual:_Q1SC]) {
        if (_Q1SC.selectedSegmentIndex == 0) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"ExistingPolicies1stLA"];
        }
        else if (_Q1SC.selectedSegmentIndex == 1) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"ExistingPolicies1stLA"];
			//[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLA"] setValue:Nil forKey:@"PolicyData"];
        }
    }
    
    if ([sender isEqual:_Q2SC]) {
        if (_Q2SC.selectedSegmentIndex == 0) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"ExistingPolicies1stLACR"];
        }
        else if (_Q2SC.selectedSegmentIndex == 1) {
            [[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"ExistingPolicies1stLACR"];
			//[[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy1stLACR"] setValue:Nil forKey:@"PolicyData"];
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
    [self setCashDividenQuest3:nil];
    [self setPrefferedLifeImage:nil];
	[super viewDidUnload];
}

- (IBAction)preffredLifeButton2:(id)sender
{
    
    isChangeTick = !isChangeTick;
    if(isChangeTick)
    {
         [_prefferedLifeImage setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        
        [[obj.eAppData objectForKey:@"SecC"] setValue:@"Y" forKey:@"PreferredLife"];
                
    }
    else
    {
         [_prefferedLifeImage setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        [[obj.eAppData objectForKey:@"SecC"] setValue:@"N" forKey:@"PreferredLife"];
    }
    
}
@end
