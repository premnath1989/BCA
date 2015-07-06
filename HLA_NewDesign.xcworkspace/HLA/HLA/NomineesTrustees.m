//
//  NomineesTrustees.m
//  iMobile Planner
//
//  Created by Erza on 6/18/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "NomineesTrustees.h"
#import "ColorHexCode.h"
#import "Nominees.h"
#import "Trustees.h"
#import "DataClass.h"

@interface NomineesTrustees () {
	DataClass *obj;
}

@end

@implementation NomineesTrustees

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"e-Application";
    self.navigationItem.titleView = label;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnDone:)];
	obj = [DataClass getInstance];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveAddNominees:) name:@"AddNominees" object:nil];
    
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDeleteNominee:) name:@"DeleteNominee" object:nil];

    int total = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"] intValue];
    if(total > 0)
        
        self.totalShareLbl.text =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"];
    
    
    NSString* n1 =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"nominee1"];
    NSString* n2 =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"nominee2"];
    NSString* n3 =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"nominee3"];
    NSString* n4 =[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"nominee4"];

  
    if(n1.length != 0 )
        self.Nominee1Lbl.text = n1;
    if(n2.length != 0 )
        self.Nominee2Lbl.text = n2;
    if(n3.length != 0 )
        self.Nominee3Lbl.text = n3;
    if(n4.length != 0 )
        self.Nominee4Lbl.text = n4;
    
    if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SISelected"] isEqualToString:@"YES" ])
        [self setTotalShare];
        
        
    
//	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docsPath = [paths objectAtIndex:0];
//    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
//    
//    FMDatabase *database = [FMDatabase databaseWithPath:path];
//    [database open];
//	
//	//	results = Nil;
//	NSLog(@"sinumber: %@", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"]);
//	
//    results = [database executeQuery:@"select * from eProposal where SINo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
//	while ([results next]) {
//		//		NSLog(@"idddd: %@", [results stringForColumn:@"ID"]);
//		//		results2 = [database executeQuery:@"select count(*) as count from  eProposal_Trustee_Details where EAPPID = ?",[results stringForColumn:@"ID"],Nil];
//		stringID = [results stringForColumn:@"ID"];
//	}
//	NSLog(@"idddd: %@", stringID);
//	results2 = [database executeQuery:@"select count(*) as count from  eProposal_Trustee_Details where EAPPID = ?",stringID,Nil];
//	
//	int gotTrustee = 0;
//	int gotTrusteeCount = 0;
//	while ([results2 next]) {
//		if ([results2 intForColumn:@"count"] > 0) {
//			NSLog(@"count more than 0");
//			gotTrustee = 1;
//		}
//	}
//	if (gotTrustee == 1) {
//		results2 = Nil;
//		//		while ([results next]) {
//		NSLog(@"got trustee");
//		results2 = [database executeQuery:@"select * from  eProposal_Trustee_Details where EAPPID = ? order by ID asc",stringID,Nil];
//		
//		while ([results2 next]) {
//			NSLog(@"trustee data");
//			NSLog(@"trustee title: %@, %@", stringID, [results2 stringForColumn:@"TrusteeTitle"]);
//			gotTrusteeCount++;
//			if (gotTrusteeCount == 1) {
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeTitle"] forKey:@"Title"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeName"] forKey:@"Name"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeSex"] forKey:@"Sex"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeDOB"] forKey:@"DOB"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeNewICNo"] forKey:@"ICNo"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeOtherIDType"] forKey:@"OtherIDType"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeOtherID"] forKey:@"OtherID"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeRelationship"] forKey:@"Relationship"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeAddress1"] forKey:@"Address1"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeAddress2"] forKey:@"Address2"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeAddress3"] forKey:@"Address3"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteePostcode"] forKey:@"Postcode"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeTown"] forKey:@"Town"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeState"] forKey:@"State"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeCountry"] forKey:@"Country"];
//			}
//			else if (gotTrusteeCount == 2) {
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeTitle"] forKey:@"2TTitle"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeName"] forKey:@"2TName"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeSex"] forKey:@"2TSex"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeDOB"] forKey:@"2TDOB"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeNewICNo"] forKey:@"2TICNo"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeOtherIDType"] forKey:@"2TOtherIDType"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeOtherID"] forKey:@"2TOtherID"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeRelationship"] forKey:@"2TRelationship"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeAddress1"] forKey:@"2TAddress1"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeAddress2"] forKey:@"2TAddress2"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeAddress3"] forKey:@"2TAddress3"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteePostcode"] forKey:@"2TPostcode"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeTown"] forKey:@"2TTown"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeState"] forKey:@"2TState"];
//				[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:[results2 stringForColumn:@"TrusteeCountry"] forKey:@"2TCountry"];
//
//			}
//			
//		}
//		
//		//		}
//	}
//	
//	[results close];
//	[results2 close];
//	[database close];
	
	
	    
}
-(void) setTotalShare
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    NSString *totalshare=@"";
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    results = nil;
    results = [database executeQuery:@"select sum(NMShare) from eProposal_NM_Details where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"],Nil];
    
    
    
    while ([results next]) {
        if([[results objectForColumnIndex:0] isKindOfClass:[NSNull class]])
           
            totalshare = @"0";
        
        else
            totalshare =    [[results objectForColumnIndex:0] stringValue];
        
        

   	}
    
       
    [database close];
      
    _totalShareLbl.text = totalshare;
    [[obj.eAppData objectForKey:@"SecD"] setValue:totalshare forKey:@"TotalShare"];

}

- (void) receiveDeleteNominee:(NSNotification *) notification
{
    
    
    if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"1"])
    {
        self.Nominee1Lbl.text = @"Add Nominee (1)";
        _totalShareLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"];
		[[obj.eAppData objectForKey:@"SecD"] setValue:@"1" forKey:@"Delete1stNominee"];
		// NSLog(@"NomineesTrustees.h TOTAL SHARE- %@",[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"] );
        
    }
    else if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"2"])
    {
        self.Nominee2Lbl.text = @"Add Nominee (2)";
        _totalShareLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"];
		[[obj.eAppData objectForKey:@"SecD"] setValue:@"1" forKey:@"Delete2ndNominee"];
    }
    else if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"3"])
    {
        self.Nominee3Lbl.text = @"Add Nominee (3)";
        _totalShareLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"];
		[[obj.eAppData objectForKey:@"SecD"] setValue:@"1" forKey:@"Delete3rdNominee"];
    }
    else if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"4"])
    {
        self.Nominee4Lbl.text = @"Add Nominee (4)";
        _totalShareLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"];
		[[obj.eAppData objectForKey:@"SecD"] setValue:@"1" forKey:@"Delete4thNominee"];
    }
    
}

- (void) receiveAddNominees:(NSNotification *) notification
{
    
    
    if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"1"])
    {
        self.Nominee1Lbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_name"];
        
    }
    else if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"2"])
    {
        self.Nominee2Lbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_name"];
		
    }
    else if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"3"])
    {
        self.Nominee3Lbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_name"];
		
    }
    else if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"4"])
    {
        
        self.Nominee4Lbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_name"];
		
    }
	
	
	
}

- (void)btnDone:(id)sender
{
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setTotalShareLbl:nil];
	[self setTrusteeLbl1:nil];
	[self setTrusteeLbl2:nil];
    [self setNominee1Lbl:nil];
	[self setNominee2Lbl:nil];
	[self setNominee3Lbl:nil];
	[self setNominee4Lbl:nil];
    [super viewDidUnload];
}
- (IBAction)addNominees:(id)sender
{  
    Nominees *zzz = [self.storyboard instantiateViewControllerWithIdentifier:@"NomineeScreen"];
    zzz.modalPresentationStyle = UIModalPresentationPageSheet;
    zzz.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:zzz animated:NO];
//    zzz.view.superview.frame = CGRectMake(0, 50, 748, 974);
}

- (IBAction)addTrustee:(id)sender
{
    Trustees *zzz = [self.storyboard instantiateViewControllerWithIdentifier:@"TrusteeScreen"];
    zzz.modalPresentationStyle = UIModalPresentationPageSheet;
    zzz.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:zzz animated:NO];
//    zzz.view.superview.frame = CGRectMake(0, 50, 748, 974);
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
		MainNomineesTrusteesVC *mntVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainNomineesTrusteesVC"];
		mntVC.modalPresentationStyle = UIModalPresentationFormSheet;
		mntVC.delegate = self;
		if (indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7){
			
            //KY -
            if(indexPath.row == 4)
            {
				[[obj.eAppData objectForKey:@"SecD"] setValue:@"1" forKey:@"WhichNominees"];
				[self presentModalViewController:mntVC animated:YES];
                
            }
            else  if(indexPath.row == 5)
            {
				
                int share1 = [_totalShareLbl.text intValue];
                
                if(share1 >= 100)
                {
                    if([[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_share"] != NULL)
                    {
                        
                        
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"2" forKey:@"WhichNominees"];
                        [self presentModalViewController:mntVC animated:YES];
						
                    }
                    else
                    {
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Total Percentage of Share exceeded 100%." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        
                        
                        [alert setTag:1001];
                        [alert show];
                        alert = Nil;
                    }
                }
				
                else{
					
					
					[[obj.eAppData objectForKey:@"SecD"] setValue:@"2" forKey:@"WhichNominees"];
					[self presentModalViewController:mntVC animated:YES];
					
                }
                
                
            }
            else  if(indexPath.row == 6)
            {
                int share1 = [_totalShareLbl.text intValue];
                
                if(share1 >= 100)
                {
                    if([[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_share"] != NULL)
                    {
                        
                        
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"3" forKey:@"WhichNominees"];
                        [self presentModalViewController:mntVC animated:YES];
                        
                    }
                    else
                    {
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Total Percentage of Share exceeded 100%." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        
                        
                        [alert setTag:1001];
                        [alert show];
                        alert = Nil;
                    }
					
                }
				
                
                else{
                    
					[[obj.eAppData objectForKey:@"SecD"] setValue:@"3" forKey:@"WhichNominees"];
					[self presentModalViewController:mntVC animated:YES];
                }
                
            }
            else  if(indexPath.row == 7)
            {
                int share1 = [_totalShareLbl.text intValue];
                
                if(share1 >= 100)
                {
                    if([[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_share"] != NULL)
                    {
                        
                        
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"4" forKey:@"WhichNominees"];
                        [self presentModalViewController:mntVC animated:YES];
                        
                    }
                    else
                    {
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Total Percentage of Share exceeded 100%." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        
                        
                        [alert setTag:1001];
                        [alert show];
                        alert = Nil;
                    }
                }
				
				
                else{
					[[obj.eAppData objectForKey:@"SecD"] setValue:@"4" forKey:@"WhichNominees"];
					[self presentModalViewController:mntVC animated:YES];
                }
				
                
                
            }
			
        }
	}
    
    else if (indexPath.section == 1){
		MainTrusteesVC *mtVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTrusteesVC"];
		mtVC.modalPresentationStyle = UIModalPresentationFormSheet;
		mtVC.delegate = self;
		if (indexPath.row == 0) {
			[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"1T" forKey:@"AddTrustee"];
        }
		else if (indexPath.row == 1) {
			[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"2T" forKey:@"AddTrustee"];
		}
		[self presentModalViewController:mtVC animated:YES];
//		[self presentViewController:mtVC animated:YES completion:^{_trusteeLbl1.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Name"];}];
	}
}

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}

- (void)updateTotalSharePct:(NSString *)sharePctInsert {
	NSLog(@"share pct: %@", sharePctInsert);
	[[obj.eAppData objectForKey:@"SecD"] setValue:sharePctInsert forKey:@"TotalShare"];
    _totalShareLbl.text = sharePctInsert;
}
//yy y
//yn y
//ny y
//nn n
- (void)setTrusteeLbl1:(NSString *)trusteeLbl1 andTrusteeLbl2:(NSString *)trusteeLbl2 {
    
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"SamePO"] isEqualToString:@"true"]) {
//		NSLog(@"1");
		_trusteeLbl1.text = @"PO Name";
//		NSLog(@"_t %@", _trusteeLbl1.text);
	}
	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"SamePO"] isEqualToString:@"false"]) {
//		NSLog(@"2");
		_trusteeLbl1.text = trusteeLbl1;
 		NSLog(@"KY_t2 %@", _trusteeLbl1.text);
	}
	else {
		_trusteeLbl1.text = @"Add Trustee (1)";
	}
	
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TSamePO"] isEqualToString:@"true"]) {
//		NSLog(@"3");
		_trusteeLbl2.text = @"PO Name";
//		NSLog(@"_t3 %@", _trusteeLbl2.text);
	}
	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TSamePO"] isEqualToString:@"false"]) {
//		NSLog(@"4");
		_trusteeLbl2.text = trusteeLbl2;
//		NSLog(@"_t4 %@", _trusteeLbl2.text);
	}
	else {
		_trusteeLbl2.text = @"Add Trustee (2)";
	}
	
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:_trusteeLbl1.text forKey:@"TL1"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:_trusteeLbl2.text forKey:@"TL2"];
}

- (void) dealloc
{
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
