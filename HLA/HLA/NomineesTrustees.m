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
#import "textFields.h"
#import "eBrochureViewController.h"



@interface NomineesTrustees () {
	DataClass *obj;
    BOOL poIsMuslim;
    
    UIButton * btnTrustee1;
   
    UIButton * btnTrustee2;
    

}

@end

@implementation NomineesTrustees
@synthesize Guidelines,dataItems;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pdfData" ofType:@"plist"]];
    dataItems = [[NSMutableArray alloc] initWithArray:[dict objectForKey:@"NomineePdfFile"]];
    
    NSLog(@"dataItems %@",dataItems);

   
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
    

	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
    [db open];
    results = [db executeQuery:@"select LAReligion, LADOB, LAOtherIDType from eProposal_LA_Details where eProposalNo = ? AND POFlag = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"Y"];
    NSString *dob;
	NSString *LAOtherIDType;
    while ([results next]) {
        NSString *religion = [textFields trimWhiteSpaces:[results stringForColumn:@"LAReligion"]];
        if ([religion hasPrefix:@"M"]) {
            poIsMuslim = TRUE;
        }
        else {
            poIsMuslim = FALSE;
        }
        dob = [results stringForColumn:@"LADOB"];
		LAOtherIDType = [results stringForColumn:@"LAOtherIDType"];
    }
	
	if (![LAOtherIDType isEqualToString:@"CR"]){
		if ([self calculateAge:dob] < 16) {
			self.tableView.allowsSelection = NO;
			_Nominee1Lbl.textColor = [UIColor grayColor];
			_Nominee2Lbl.textColor = [UIColor grayColor];
			_Nominee3Lbl.textColor = [UIColor grayColor];
			_Nominee4Lbl.textColor = [UIColor grayColor];
			_trusteeLbl1.textColor = [UIColor grayColor];
			_trusteeLbl2.textColor = [UIColor grayColor];
		}
	}
	
	if ([LAOtherIDType isEqualToString:@"CR"]){
		self.tableView.allowsSelection = NO;
		_Nominee1Lbl.textColor = [UIColor grayColor];
		_Nominee2Lbl.textColor = [UIColor grayColor];
		_Nominee3Lbl.textColor = [UIColor grayColor];
		_Nominee4Lbl.textColor = [UIColor grayColor];
		_trusteeLbl1.textColor = [UIColor grayColor];
		_trusteeLbl2.textColor = [UIColor grayColor];
	}
	
	// ### ENS Add, disable nominee if Payor has no rider.
	if ([db close]) {
		[db open];
	}
	
	//bool la2Available;
	bool PYAvailable;
	
//	results = [db executeQuery:@"select count(*) as count from eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"LA2", Nil];
//    while ([results next]) {
//        if ([results intForColumn:@"count"] > 0) {
//            la2Available = TRUE;
//        }
//        else {
//            la2Available = FALSE;
//        }
//    }
	
	results2 = [db executeQuery:@"select count(*) as count from eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"PY1", Nil];
    while ([results2 next]) {
        if ([results2 intForColumn:@"count"] > 0) {
            PYAvailable = TRUE;
        }
        else {
            PYAvailable = FALSE;
        }
    }
    
   
	
	NSString *PYhasRider = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"PYHasRider"];
	
	if (PYAvailable == TRUE)
        {
             NSLog(@"PYAvailable == TRUE1");
		if ([PYhasRider isEqualToString:@"N"])
        {
             NSLog(@"PYhasRider isEqualToString:N1");
			self.tableView.allowsSelection = NO;
			_Nominee1Lbl.textColor = [UIColor grayColor];
			_Nominee2Lbl.textColor = [UIColor grayColor];
			_Nominee3Lbl.textColor = [UIColor grayColor];
			_Nominee4Lbl.textColor = [UIColor grayColor];
			_trusteeLbl1.textColor = [UIColor grayColor];
			_trusteeLbl2.textColor = [UIColor grayColor];
            
                      
			
			//Delete nominee data if exist.
			//Delete eProposal_NM_Details
			if (![db executeUpdate:@"Delete from eProposal_NM_Details where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], nil]) {
				NSLog(@"Error in Delete Statement - eProposal_NM_Details");
			}
			
			//Delete eProposal_Trustee_Details
			if (![db executeUpdate:@"Delete from eProposal_Trustee_Details where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], nil]) {
				NSLog(@"Error in Delete Statement - eProposal_Trustee_Details");
			}
			
			self.Nominee1Lbl.text = @"Add Nominee (1)";
			self.Nominee2Lbl.text = @"Add Nominee (2)";
			self.Nominee3Lbl.text = @"Add Nominee (3)";
			self.Nominee4Lbl.text = @"Add Nominee (4)";
			self.trusteeLbl1.text = @"Add Trustee (1)";
			self.trusteeLbl2.text = @"Add Trustee (2)";
			self.totalShareLbl.text = @"0";
		}
		else
        {
            NSLog(@"PYhasRider isEqualToString:Y1");
			self.tableView.allowsSelection = YES;
			_Nominee1Lbl.textColor = [UIColor blackColor];
			_Nominee2Lbl.textColor = [UIColor blackColor];
			_Nominee3Lbl.textColor = [UIColor blackColor];
			_Nominee4Lbl.textColor = [UIColor blackColor];
			_trusteeLbl1.textColor = [UIColor blackColor];
			_trusteeLbl2.textColor = [UIColor blackColor];
		}
	}
  //  btnTrustee1 = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    btnTrustee1.frame = CGRectMake(610, 640, 250, 40);
//    [self.view addSubview:btnTrustee1];
//    btnTrustee2 = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    btnTrustee2.frame = CGRectMake(610, 680, 250, 40);
//    [self.view addSubview:btnTrustee2];
    
    btnTrustee1 = [[UIButton alloc] initWithFrame:CGRectMake(723, 640, 30,30)];
    [btnTrustee1 setImage:[UIImage imageNamed:@"DiscloseBtnFinea.png"] forState:UIControlStateNormal];
    [btnTrustee1 addTarget:self action:@selector(aMethod1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnTrustee1];
    
    btnTrustee2 = [[UIButton alloc] initWithFrame:CGRectMake(723, 685, 30,30)];
    [btnTrustee2 setImage:[UIImage imageNamed:@"DiscloseBtnFinea.png"] forState:UIControlStateNormal];
    [btnTrustee2 addTarget:self action:@selector(aMethod2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnTrustee2];
    
        
    if (poIsMuslim) {
        _trusteeLbl1.enabled=FALSE;
        _trusteeLbl1.textColor = [UIColor grayColor];
        _trusteeLbl2.enabled=FALSE;
        _trusteeLbl2.textColor = [UIColor grayColor];
        
        
        btnTrustee1.enabled=FALSE;
        btnTrustee2.enabled=FALSE;
        _firstTCell.userInteractionEnabled = FALSE;
//        [btnTrustee1 setBackgroundColor:[UIColor grayColor]];
//        [btnTrustee2 setBackgroundColor:[UIColor grayColor]];
        
        _secondTCell.userInteractionEnabled = FALSE;
        //_secondTCell.textColor = [UIColor grayColor];
       
        
        //[_firstTCell setBackgroundColor:[UIColor grayColor]];
       // [_secondTCell setBackgroundColor:[UIColor grayColor]];
        
    }
            
    [db close];
    
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	tap.delegate = self;
	[self.view addGestureRecognizer:tap];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"e-Application";
    self.navigationItem.titleView = label;
//
//    
//    UIButton *helpButton =  [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
//    helpButton.frame = CGRectMake(480.0, 13.0, 280.0, 40.0);
//    helpButton.backgroundColor =[UIColor clearColor];
//    helpButton.alpha =1.00;
//    [helpButton addTarget:self action:@selector(aMethod) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:helpButton];
//    
//    CGRect frame1 = CGRectMake(460.0, 13.0, 280.0, 40.0);
//    UILabel *label1 = [[UILabel alloc] initWithFrame:frame1];
//    label1.backgroundColor = [UIColor clearColor];
//    label1.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
//    label1.font = [UIFont boldSystemFontOfSize:16];
//    label1.textAlignment = UITextAlignmentCenter;
//    label1.textColor = [CustomColor colorWithHexString:@"234A7D"];
//    label1.text = @" Nominee & Trustee Guidelines";
//    [self.view addSubview:label1];
//    
//    UIButton *chat1 = [[UIButton alloc] initWithFrame:CGRectMake(725.0,16.0,30,30)];
//    [chat1 setImage:[UIImage imageNamed:@"DiscloseBtnFinea.png"] forState:UIControlStateNormal];
//    [chat1 addTarget:self action:@selector(aMethod) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:chat1];

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect frame = tableView.frame;
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
       
    UIButton *pdfButton =  [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    pdfButton.frame = CGRectMake(480.0,-8.0, 280.0, 40.0);
    pdfButton.backgroundColor =[UIColor clearColor];
    pdfButton.alpha =1.00;
    [pdfButton addTarget:self action:@selector(aMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pdfButton];
    
    CGRect frame1 = CGRectMake(460.0,-8.0, 280.0, 40.0);
    UILabel *Label_pdfbutton = [[UILabel alloc] initWithFrame:frame1];
    Label_pdfbutton.backgroundColor = [UIColor clearColor];
    Label_pdfbutton.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    Label_pdfbutton.font = [UIFont boldSystemFontOfSize:16];
    Label_pdfbutton.textAlignment = UITextAlignmentCenter;
    Label_pdfbutton.textColor = [CustomColor colorWithHexString:@"234A7D"];
    Label_pdfbutton.text = @" Nominee & Trustee Guidelines";
    [self.view addSubview:Label_pdfbutton];
    
    UIButton *DiscloseButton = [[UIButton alloc] initWithFrame:CGRectMake(725.0,-5.0,30,30)];
    [DiscloseButton setImage:[UIImage imageNamed:@"DiscloseBtnFinea.png"] forState:UIControlStateNormal];
    [DiscloseButton addTarget:self action:@selector(aMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:DiscloseButton];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(50, -5.0, 300, 40)];
    title.text = @"Section A : Nomination of Nominees";
    title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont boldSystemFontOfSize:17.0f];
   // title.textAlignment = UITextAlignmentCenter;
    title.textColor = [UIColor colorWithRed:90.0f/255.0f green:97.0f/255.0f blue:113.0f/255.0f alpha:1.0f];
    [self.view addSubview:title];


    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    //[headerView addSubview:title];
    [headerView addSubview:pdfButton];
    [headerView addSubview:Label_pdfbutton];
    [headerView addSubview:DiscloseButton];
    [headerView addSubview:title];
    
    
    if(section == 0)
    {
        return headerView;
    }
    
    return nil;
    
}

-(void)hideKeyboard{
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UITextField class]] ||
        [touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }
    return YES;
}

-(void)aMethod
{
    
    UIStoryboard *nextStoryboard2 = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    eBrochureViewController *Brochure = [nextStoryboard2 instantiateViewControllerWithIdentifier:@"eBrochure"];
    
    
    //    Brochure.title = [[[dataItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:0];
    Brochure.fileTitle = [dataItems objectAtIndex:0];
    Brochure.fileName = [dataItems objectAtIndex:1];
    
    NSLog(@"brochure name %@",Brochure.fileName);
    NSLog(@"brochure fileTittle %@",Brochure.fileTitle);
    
    


  //  [self.navigationController pushViewController:Brochure animated:YES];
     [self presentModalViewController:Brochure animated:YES];
    
   

    
}
-(void)aMethod1
{
    //    MainTrusteesVC *mtVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTrusteesVC"];
    //    mtVC.modalPresentationStyle = UIModalPresentationFormSheet;
    //    mtVC.delegate = self;
    //    [self presentModalViewController:mtVC animated:YES];
    
    if ([_Nominee1Lbl.text isEqualToString:@"Add Nominee (1)"] && [_Nominee2Lbl.text isEqualToString:@"Add Nominee (2)"] &&[_Nominee3Lbl.text isEqualToString:@"Add Nominee (3)"] && [_Nominee4Lbl.text isEqualToString:@"Add Nominee (4)"] )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please add Nominee(s) first before proceed to add Trustee." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = Nil;
        return;
    }
    
    else  if (![self validateTrust]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Appointment of Trustee is not allowed for non-trust policy." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = Nil;
        return;
    }

    else {
        MainTrusteesVC *mtVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTrusteesVC"];
        mtVC.modalPresentationStyle = UIModalPresentationFormSheet;
        mtVC.delegate = self;
        
        [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"1T" forKey:@"AddTrustee"];
        [self presentModalViewController:mtVC animated:YES];

    }

    
}

-(void)aMethod2
{
    
    if ([_Nominee1Lbl.text isEqualToString:@"Add Nominee (1)"] && [_Nominee2Lbl.text isEqualToString:@"Add Nominee (2)"] &&[_Nominee3Lbl.text isEqualToString:@"Add Nominee (3)"] && [_Nominee4Lbl.text isEqualToString:@"Add Nominee (4)"] )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please add Nominee(s) first before proceed to add Trustee." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = Nil;
        return;
    }
    
    else if (![self validateTrust]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Appointment of Trustee is not allowed for non-trust policy." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = Nil;
        return;
    }

    

    MainTrusteesVC *mtVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTrusteesVC"];
    mtVC.modalPresentationStyle = UIModalPresentationFormSheet;
    mtVC.delegate = self;
    
    if ([_trusteeLbl1.text isEqualToString:@"Add Trustee (1)"] && [_trusteeLbl2.text isEqualToString:@"Add Trustee (2)"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please add Trustee in sequence." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
        return;
    }
    [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"2T" forKey:@"AddTrustee"];
    [self presentModalViewController:mtVC animated:YES];

    
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
    
//    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
	
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
	
	[self CheckTrust];
	
    
}

-(void) CheckTrust {
	
	NSString *Nom1Rel = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_relatioship"];
	NSString *Nom2Rel = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_relatioship"];
	NSString *Nom3Rel = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_relatioship"];
	NSString *Nom4Rel = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_relatioship"];
	
	
	BOOL Nom1 = !([Nom1Rel isEqualToString:@""] || Nom1Rel== nil);
	BOOL Nom2 = !([Nom2Rel isEqualToString:@""] || Nom2Rel== nil);
	BOOL Nom3 = !([Nom3Rel isEqualToString:@""] || Nom3Rel== nil);
	BOOL Nom4 = !([Nom4Rel isEqualToString:@""] || Nom4Rel== nil);
	
	if (!Nom1 && !Nom2 && !Nom3 && !Nom4) {
		[self DeleteTrustee];
	}
	else {
		if (![self validateTrust]) {
			[self DeleteTrustee];
		}
	}
}

-(void) DeleteTrustee {
	//CLEAR TRUSTEE 1
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"Add Trustee (1)" forKey:@"TL1"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"SamePO"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"ForeignAddress"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Name"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Title"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Sex"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"DOB"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"ICNo"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"OtherIDType"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"OtherID"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Relationship"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Address1"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Address2"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Address3"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Postcode"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Town"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"State"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"Country"];
	
	//CLEAR TRUSTEE 2
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"1" forKey:@"Delete2nd"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"Add Trustee (2)" forKey:@"TL2"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TSamePO"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TForeignAddress"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TName"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TTitle"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TSex"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TDOB"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TICNo"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TOtherIDType"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TOtherID"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TRelationship"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TAddress1"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TAddress2"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TAddress3"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TPostcode"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TTown"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TState"];
	[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"" forKey:@"2TCountry"];
	
	self.trusteeLbl1.text = @"Add Trustee (1)";
	self.trusteeLbl2.text = @"Add Trustee (2)";
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
    [self setDisableCell:nil];
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

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath

{
        
    if(_Nominee1Lbl.textColor ==[UIColor grayColor])
    {
         
    }
    
    else
    {
    
	if (indexPath.section == 0)
    {
        NSLog(@"im pressing the tab here");
        
		MainNomineesTrusteesVC *mntVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainNomineesTrusteesVC"];
		mntVC.modalPresentationStyle = UIModalPresentationFormSheet;
		mntVC.delegate = self;
        mntVC.Nominee1Lbl = _Nominee1Lbl;
        mntVC.Nominee2Lbl = _Nominee2Lbl;
        mntVC.Nominee3Lbl = _Nominee3Lbl;
        mntVC.Nominee4Lbl = _Nominee4Lbl;
        mntVC.Trustee1Lbl = _trusteeLbl1;
        mntVC.Trustee2Lbl = _trusteeLbl2;
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
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Total Percentage of Share exceeded 100%." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        
                        
                        [alert setTag:1001];
                        [alert show];
                        alert = Nil;
                    }
                }
				
                else{
					
					if ([_Nominee1Lbl.text isEqualToString:@"Add Nominee (1)"] && ([_Nominee2Lbl.text isEqualToString:@"Add Nominee (2)"])) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please add Nominee in sequence." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        alert = nil;
                        return;
                    }
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
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Total Percentage of Share exceeded 100%." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        
                        
                        [alert setTag:1001];
                        [alert show];
                        alert = Nil;
                    }
					
                }
				
                
                else{
                    
                    if (([_Nominee1Lbl.text isEqualToString:@"Add Nominee (1)"] || [_Nominee2Lbl.text isEqualToString:@"Add Nominee (2)"]) && [_Nominee3Lbl.text isEqualToString:@"Add Nominee (3)"]) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please add Nominee in sequence." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        alert = nil;
                        return;
                    }
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
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Total Percentage of Share exceeded 100%." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        
                        
                        [alert setTag:1001];
                        [alert show];
                        alert = Nil;
                    }
                }
				
				
                else{
                    if (([_Nominee1Lbl.text isEqualToString:@"Add Nominee (1)"] || [_Nominee2Lbl.text isEqualToString:@"Add Nominee (2)"] ||[_Nominee3Lbl.text isEqualToString:@"Add Nominee (3)"]) && [_Nominee4Lbl.text isEqualToString:@"Add Nominee (4)"]) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please add Nominee in sequence." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        alert = nil;
                        return;
                    }
					[[obj.eAppData objectForKey:@"SecD"] setValue:@"4" forKey:@"WhichNominees"];
					[self presentModalViewController:mntVC animated:YES];
                }
				
                
                
            }
			
        }
	}
        

    else if (indexPath.section == 1)
    {
         if (!poIsMuslim)
         {
              
        if ([_Nominee1Lbl.text isEqualToString:@"Add Nominee (1)"] && [_Nominee2Lbl.text isEqualToString:@"Add Nominee (2)"] &&[_Nominee3Lbl.text isEqualToString:@"Add Nominee (3)"] && [_Nominee4Lbl.text isEqualToString:@"Add Nominee (4)"] ) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please add Nominee(s) first before proceed to add Trustee." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = Nil;
            return;
        }
         }
        else if  (poIsMuslim) {
            
            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Trustee is not applicable to Muslim." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//            alert = nil;
            _trusteeLbl1.enabled=FALSE;
            _trusteeLbl1.textColor = [UIColor blueColor];
            _trusteeLbl2.enabled=FALSE;
            _trusteeLbl2.textColor = [UIColor blueColor];
            
            btnTrustee1.enabled=FALSE;
            btnTrustee2.enabled=FALSE;
//            [btnTrustee1 setBackgroundColor:[UIColor grayColor]];
//            [btnTrustee2 setBackgroundColor:[UIColor grayColor]];
            _firstTCell.userInteractionEnabled = FALSE;
            _secondTCell.userInteractionEnabled = FALSE;
            
          //  [_firstTCell setBackgroundColor:[UIColor grayColor]];
           // [_secondTCell setBackgroundColor:[UIColor grayColor]];
           
            
        }
        
        if (![self validateTrust]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Appointment of Trustee is not allowed for non-trust policy." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = Nil;
            return;
        }
		MainTrusteesVC *mtVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTrusteesVC"];
		mtVC.modalPresentationStyle = UIModalPresentationFormSheet;
		mtVC.delegate = self;
		if (indexPath.row == 0) {
			[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"1T" forKey:@"AddTrustee"];
        }
		else if (indexPath.row == 1)
        {
            if ([_trusteeLbl1.text isEqualToString:@"Add Trustee (1)"] && [_trusteeLbl2.text isEqualToString:@"Add Trustee (2)"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please add Trustee in sequence." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                alert = nil;
                return;
            }
			[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"2T" forKey:@"AddTrustee"];
		}
		[self presentModalViewController:mtVC animated:YES];
        //		[self presentViewController:mtVC animated:YES completion:^{_trusteeLbl1.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Name"];}];
	}
        
    }
}

//- (void)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    static NSString *CellIdentifier = @"Cell";
////    UITableViewCell *cell = [tableView
////                             dequeueReusableCellWithIdentifier:CellIdentifier];
////    
////    if (cell == nil)
////    {
////        cell = [[UITableViewCell alloc]
////                 initWithStyle:UITableViewCellStyleDefault
////                 reuseIdentifier:CellIdentifier];
////    }
//    
////    cell.accessoryType = UITableViewCellAccessoryNone;
//    
//    
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    
	if (indexPath.section == 0) {
		MainNomineesTrusteesVC *mntVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainNomineesTrusteesVC"];
		mntVC.modalPresentationStyle = UIModalPresentationFormSheet;
		mntVC.delegate = self;
        mntVC.Nominee1Lbl = _Nominee1Lbl;
        mntVC.Nominee2Lbl = _Nominee2Lbl;
        mntVC.Nominee3Lbl = _Nominee3Lbl;
        mntVC.Nominee4Lbl = _Nominee4Lbl;
        mntVC.Trustee1Lbl = _trusteeLbl1;
        mntVC.Trustee2Lbl = _trusteeLbl2;
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
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Total Percentage of Share exceeded 100%." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        
                        
                        [alert setTag:1001];
                        [alert show];
                        alert = Nil;
                    }
                }
				
                else{
					
					if ([_Nominee1Lbl.text isEqualToString:@"Add Nominee (1)"] && ([_Nominee2Lbl.text isEqualToString:@"Add Nominee (2)"])) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please add Nominee in sequence." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        alert = nil;
                        return;
                    }
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
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Total Percentage of Share exceeded 100%." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        

                        [alert setTag:1001];
                        [alert show];
                        alert = Nil;
                    }
					
                }
				
                
                else{
                    
                    if (([_Nominee1Lbl.text isEqualToString:@"Add Nominee (1)"] || [_Nominee2Lbl.text isEqualToString:@"Add Nominee (2)"]) && [_Nominee3Lbl.text isEqualToString:@"Add Nominee (3)"]) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please add Nominee in sequence." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        alert = nil;
                        return;
                    }
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
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Total Percentage of Share exceeded 100%." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        
                        
                        [alert setTag:1001];
                        [alert show];
                        alert = Nil;
                    }
                }
				
				
                else{
                    if (([_Nominee1Lbl.text isEqualToString:@"Add Nominee (1)"] || [_Nominee2Lbl.text isEqualToString:@"Add Nominee (2)"] ||[_Nominee3Lbl.text isEqualToString:@"Add Nominee (3)"]) && [_Nominee4Lbl.text isEqualToString:@"Add Nominee (4)"]) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please add Nominee in sequence." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                        alert = nil;
                        return;
                    }
					[[obj.eAppData objectForKey:@"SecD"] setValue:@"4" forKey:@"WhichNominees"];
					[self presentModalViewController:mntVC animated:YES];
                }
				
                
                
            }
			
        }
	}
    
    else if (indexPath.section == 1){
        if (!poIsMuslim) {
        if ([_Nominee1Lbl.text isEqualToString:@"Add Nominee (1)"] && [_Nominee2Lbl.text isEqualToString:@"Add Nominee (2)"] &&[_Nominee3Lbl.text isEqualToString:@"Add Nominee (3)"] && [_Nominee4Lbl.text isEqualToString:@"Add Nominee (4)"] ) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please add Nominee(s) first before proceed to add Trustee." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = Nil;
            return;
        }
        }
        if (poIsMuslim)
        {
        
            // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Trustee is not applicable to Muslim." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
          //  alert = nil;
            
            _trusteeLbl1.enabled=FALSE;
            _trusteeLbl1.textColor = [UIColor blueColor];
            _trusteeLbl2.enabled=FALSE;
            _trusteeLbl2.textColor = [UIColor blueColor];
            
            btnTrustee1.enabled=FALSE;
            btnTrustee2.enabled=FALSE;
//            [btnTrustee1 setBackgroundColor:[UIColor grayColor]];
//            [btnTrustee2 setBackgroundColor:[UIColor grayColor]];
            _firstTCell.userInteractionEnabled = FALSE;
            _secondTCell.userInteractionEnabled = FALSE;
            
           // [_firstTCell setBackgroundColor:[UIColor grayColor]];
           // [_secondTCell setBackgroundColor:[UIColor grayColor]];
            return;
        }
        
        if (![self validateTrust]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Appointment of Trustee is not allowed for non-trust policy." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = Nil;
            return;
        }
		MainTrusteesVC *mtVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTrusteesVC"];
		mtVC.modalPresentationStyle = UIModalPresentationFormSheet;
		mtVC.delegate = self;
		if (indexPath.row == 0)
        {
			[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"1T" forKey:@"AddTrustee"];
        }
		else if (indexPath.row == 1)
        {
            if ([_trusteeLbl1.text isEqualToString:@"Add Trustee (1)"] && [_trusteeLbl2.text isEqualToString:@"Add Trustee (2)"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please add Trustee in sequence." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                alert = nil;
                return;
            }
			[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] setValue:@"2T" forKey:@"AddTrustee"];
		}
		[self presentModalViewController:mtVC animated:YES];
//		[self presentViewController:mtVC animated:YES completion:^{_trusteeLbl1.text = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Name"];}];
	}
}

//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}


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
	
    NSLog(@"ENS: %@", [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"SamePO"]);
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"SamePO"] isEqualToString:@"true"]) {
		_trusteeLbl1.text = trusteeLbl1;
	}
	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"SamePO"] isEqualToString:@"false"]) {
		_trusteeLbl1.text = trusteeLbl1;
	}
	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"SamePO"] isEqualToString:@"Y"]) {
		_trusteeLbl1.text = trusteeLbl1;
	}
	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"SamePO"] isEqualToString:@"N"]) {
		_trusteeLbl1.text = trusteeLbl1;
	}
	else {
		_trusteeLbl1.text = @"Add Trustee (1)";
	}

	if (([[textFields trimWhiteSpaces:_trusteeLbl1.text] isEqualToString:@""]) || _trusteeLbl1.text == NULL)
		_trusteeLbl1.text = @"Add Trustee (1)";
	
	if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TSamePO"] isEqualToString:@"true"]) {
		_trusteeLbl2.text = trusteeLbl2;
	}
	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TSamePO"] isEqualToString:@"false"]) {
		_trusteeLbl2.text = trusteeLbl2;
	}
	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TSamePO"] isEqualToString:@"Y"]) {
		_trusteeLbl2.text = trusteeLbl2;
	}
	else if ([[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"2TSamePO"] isEqualToString:@"N"]) {
		_trusteeLbl2.text = trusteeLbl2;
	}
	else {
		_trusteeLbl2.text = @"Add Trustee (2)";
	}
	
	if ([_trusteeLbl2.text isEqualToString:@""] || _trusteeLbl2.text == NULL)
		_trusteeLbl2.text = @"Add Trustee (2)";
	
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

- (BOOL) validateTrust {
    NSArray *childrens = [[NSArray alloc] initWithObjects:@"DAUGHTER", @"SON",nil];
    NSArray *parents = [[NSArray alloc] initWithObjects:@"FATHER", @"MOTHER",nil];
    NSArray *childrensNSpouse = [[NSArray alloc] initWithObjects:@"HUSBAND", @"WIFE", @"DAUGHTER", @"SON", nil];
    NSArray *status = [[NSArray alloc] initWithObjects:@"DIVORCED", @"WIDOW", @"WIDOWER",nil];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    NSString *poStatus;
    NSString *haveChildren;
    
    NSString *relationship1;
    NSString *relationship2;
    NSString *relationship3;
    NSString *relationship4;
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *resultsStatus = [database executeQuery:@"select LAMaritalStatus, HaveChildren from eProposal_LA_Details where eProposalNo = ? and POFlag = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"Y", Nil];
    NSLog(@"%@", [database lastErrorMessage]);
    while ([resultsStatus next]) {
        poStatus = [resultsStatus stringForColumn:@"LAMaritalStatus"];
        haveChildren = [resultsStatus stringForColumn:@"HaveChildren"];
    }
    
    [database close];
    
    // get nominees relationship with PO
    if (![_Nominee1Lbl.text isEqualToString:@"Add Nominee (1)"]) {
        relationship1 = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_relatioship"];
    }
    if (![_Nominee2Lbl.text isEqualToString:@"Add Nominee (2)"]) {
        relationship2 = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_relatioship"];
    }
    if (![_Nominee3Lbl.text isEqualToString:@"Add Nominee (3)"]) {
        relationship3 = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_relatioship"];
    }
    if (![_Nominee4Lbl.text isEqualToString:@"Add Nominee (4)"]) {
        relationship4 = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_relatioship"];
    }
    
    poStatus = [textFields trimWhiteSpaces:poStatus];
    if ([status containsObject:poStatus]) {
        if (haveChildren && [haveChildren isEqualToString:@"Y"]) {
            if (relationship1) {
                if ([childrens containsObject:relationship1]) {
                    return TRUE;
                }
            }
            if (relationship2) {
                if ([childrens containsObject:relationship2]) {
                    return TRUE;
                }
            }
            if (relationship3) {
                if ([childrens containsObject:relationship3]) {
                    return TRUE;
                }
            }
            if (relationship4) {
                if ([childrens containsObject:relationship4]) {
                    return TRUE;
                }
            }
        }
        else {
            if (relationship1) {
                if ([parents containsObject:relationship1]) {
                    return TRUE;
                }
            }
            if (relationship2) {
                if ([parents containsObject:relationship2]) {
                    return TRUE;
                }
            }
            if (relationship3) {
                if ([parents containsObject:relationship3]) {
                    return TRUE;
                }
            }
            if (relationship4) {
                if ([parents containsObject:relationship4]) {
                    return TRUE;
                }
            }
        }
        return FALSE;
    }
    else if ([poStatus isEqualToString:@"SINGLE"]) {
        if (relationship1) {
            if ([parents containsObject:relationship1]) {
                return TRUE;
            }
			if ([childrens containsObject:relationship1]) {
				return TRUE;
			}
        }
        if (relationship2) {
            if ([parents containsObject:relationship2]) {
                return TRUE;
            }
			if ([childrens containsObject:relationship2]) {
				return TRUE;
			}
        }
        if (relationship3) {
            if ([parents containsObject:relationship3]) {
                return TRUE;
            }
			if ([childrens containsObject:relationship3]) {
				return TRUE;
			}
        }
        if (relationship4) {
            if ([parents containsObject:relationship4]) {
                return TRUE;
            }
			if ([childrens containsObject:relationship4]) {
				return TRUE;
			}
        }
        return FALSE;
        
    }
    else if ([poStatus isEqualToString:@"MARRIED"]) {
        if (relationship1) {
            if ([childrensNSpouse containsObject:relationship1]) {
                return TRUE;
            }
        }
        if (relationship2) {
            if ([childrensNSpouse containsObject:relationship2]) {
                return TRUE;
            }
        }
        if (relationship3) {
            if ([childrensNSpouse containsObject:relationship3]) {
                return TRUE;
            }
        }
        if (relationship4) {
            if ([childrensNSpouse containsObject:relationship4]) {
                return TRUE;
            }
        }
        return FALSE;
    }
    return FALSE;
}

-(int)calculateAge:(NSString *)dobText {
    
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    [fmtDate setDateFormat:@"dd/MM/yyyy"];
    NSString *textDate = [NSString stringWithFormat:@"%@",[fmtDate stringFromDate:[NSDate date]]];
    
    NSArray *curr = [textDate componentsSeparatedByString: @"/"];
    NSString *currentDay = [curr objectAtIndex:0];
    NSString *currentMonth = [curr objectAtIndex:1];
    NSString *currentYear = [curr objectAtIndex:2];
    
    NSArray *foo = [dobText componentsSeparatedByString: @"/"];
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
    }
    else {
        newALB = 0;
    }
    return newALB;
}

@end
