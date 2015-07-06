//
//  HealthQuestionsVC.m
//  iMobile Planner
//
//  Created by Erza on 11/15/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "HealthQuestionsVC.h"
#import "FMDatabase.h"
#import "DataClass.h"
#import "AppDelegate.h"
@interface HealthQuestionsVC () {
    DataClass *obj;
    bool la2Available;
	bool PYAvailable;
    bool EDDCaseAvailable;
}

@end

@implementation HealthQuestionsVC

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
    
    EDDCaseAvailable = YES;
	// Do any additional setup after loading the view.
    obj = [DataClass getInstance];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results = [database executeQuery:@"select count(*) as count from eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"LA2", Nil];
    
    NSLog(@"database %@",[[obj.eAppData objectForKey:@"SecE"]valueForKey:@"SecE_Saved"]);
    NSString *FirstTimeCheck =[[obj.eAppData objectForKey:@"SecE"]valueForKey:@"SecE_Saved"];
    
    NSString *POOtherIDType;
    FMResultSet  *results4 = [database executeQuery:@"select LAOtherIDType from eProposal_LA_Details where eProposalNo = ? AND POFlag = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"N"];
    
    while ([results4 next]) {
        POOtherIDType = [results4 objectForColumnName:@"LAOtherIDType"];
    }
    
    if([FirstTimeCheck isEqualToString:@"Y"])
    {
        
        if([POOtherIDType isEqualToString:@"EDD"]){
            
            
            EDDCaseAvailable = NO;
        }
        else{
            EDDCaseAvailable = YES;
        }
       
    }else
    {
        
      
        if([POOtherIDType isEqualToString:@"EDD"]){
            
        
            EDDCaseAvailable = NO;
      //  [self.hq1stLA.txtHeight becomeFirstResponder];
            
            AppDelegate *appobj=(AppDelegate *)[[UIApplication sharedApplication]delegate];
            appobj.HandlingEDDCase=NO;
            _personTypeLbl.text = @"Payor";
            UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
            self.hqPo = [nextStoryboard instantiateViewControllerWithIdentifier:@"HQPO"];
            [self addChildViewController:self.hqPo];
            self.hqPo.view.tag=1000;
            self.hqPo.txtHeight.tag=500;
            self.hqPo.txtWeight.tag=501;
            [self.mySubview addSubview:self.hqPo.view];
        }else{
            AppDelegate *appobj=(AppDelegate *)[[UIApplication sharedApplication]delegate];
            appobj.HandlingEDDCase=YES;
            EDDCaseAvailable = YES;
            _personTypeLbl.text = @"1st Life Assured";
            _personTypeLbl.textColor = [UIColor blackColor];
            self.mySubview.tag=2000;
            UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
            self.hq1stLA = [nextStoryboard instantiateViewControllerWithIdentifier:@"HQ1stLA"];
            
            [self addChildViewController:self.hq1stLA];
            self.hq1stLA.view.tag=1000;
            self.hq1stLA.txtHeight.tag=500;
            self.hq1stLA.txtWeight.tag=501;
            
            [self.mySubview addSubview:self.hq1stLA.view];
        
        
        }

    }
    
    
//    [obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)
    
    while ([results next]) {
        if ([results intForColumn:@"count"] > 0)
        {
            la2Available = TRUE;
            // NSLog(@"available");
            //[[obj.eAppData objectForKey:@"SecE"] setValue:@"2" forKey:@"count"];
        }
        else {
            la2Available = FALSE;
            // NSLog(@"availablex");
            //[[obj.eAppData objectForKey:@"SecE"] setValue:@"1" forKey:@"count"];
        }
    }
	FMResultSet *results2 = [database executeQuery:@"select count(*) as count from eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"PY1", Nil];
    while ([results2 next])
    {
        if ([results2 intForColumn:@"count"] > 0) {
            PYAvailable = TRUE;
            //[[obj.eAppData objectForKey:@"SecE"] setValue:@"3" forKey:@"count"];
        }
        else {
            PYAvailable = FALSE;
            //[[obj.eAppData objectForKey:@"SecE"] setValue:@"1" forKey:@"count"];
        }
    }

    [results close];
    [database close];
	
	if (la2Available)
    {
        
        NSString *LA2hasRider1 = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"LA2HasRider"];
		if ([LA2hasRider1 isEqualToString:@"Y"])
			[[obj.eAppData objectForKey:@"SecE"] setValue:@"2" forKey:@"count"];
		else
			[[obj.eAppData objectForKey:@"SecE"] setValue:@"1" forKey:@"count"];
		
        
        _personTypeLbl.text = @"1st Life Assured";
        _personTypeLbl.textColor = [UIColor blackColor];
        self.mySubview.tag=2000;
        UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
        //    if ([thePersonType hasPrefix:@"1st"])
        //    {
        
        //BOOL doesContain = [self.mySubview.subviews containsObject:self.hq1stLA.view];
        //if (!doesContain) {
        self.hq1stLA = [nextStoryboard instantiateViewControllerWithIdentifier:@"HQ1stLA"];
        
        [self addChildViewController:self.hq1stLA];
        self.hq1stLA.view.tag=1000;
        self.hq1stLA.txtHeight.tag=500;
        self.hq1stLA.txtWeight.tag=501;
        
        [self.mySubview addSubview:self.hq1stLA.view];
      //  [self.hq1stLA.txtHeight becomeFirstResponder];
        
        NSLog(@"clickedHere4");
	}
	else if (PYAvailable)
    {
		NSString *PYhasRider = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"PYHasRider"];
		if ([PYhasRider isEqualToString:@"Y"])
			[[obj.eAppData objectForKey:@"SecE"] setValue:@"3" forKey:@"count"];
		else
			[[obj.eAppData objectForKey:@"SecE"] setValue:@"1" forKey:@"count"];
        if(EDDCaseAvailable == YES){
            
            _personTypeLbl.text = @"1st Life Assured";
            _personTypeLbl.textColor = [UIColor blackColor];
            self.mySubview.tag=2000;
            UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
            //    if ([thePersonType hasPrefix:@"1st"])
            //    {
            
            //BOOL doesContain = [self.mySubview.subviews containsObject:self.hq1stLA.view];
            //if (!doesContain) {
            self.hq1stLA = [nextStoryboard instantiateViewControllerWithIdentifier:@"HQ1stLA"];
            
            [self addChildViewController:self.hq1stLA];
            self.hq1stLA.view.tag=1000;
            self.hq1stLA.txtHeight.tag=500;
            self.hq1stLA.txtWeight.tag=501;
            
            [self.mySubview addSubview:self.hq1stLA.view];
            
        }
        else if( EDDCaseAvailable == NO)
        {
            _personTypeLbl.text = @"Payor";
            UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
            self.hqPo = [nextStoryboard instantiateViewControllerWithIdentifier:@"HQPO"];
            [self addChildViewController:self.hqPo];
            self.hqPo.view.tag=1000;
            self.hqPo.txtHeight.tag=500;
            self.hqPo.txtWeight.tag=501;
            [self.mySubview addSubview:self.hqPo.view];
        }
       
     //   [self.hq1stLA.txtHeight becomeFirstResponder];
        
        NSLog(@"clickedHere3");
	}
	else {
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"1" forKey:@"count"];
        
        _personTypeLbl.text = @"1st Life Assured";
        _personTypeLbl.textColor = [UIColor blackColor];
        self.mySubview.tag=2000;
        UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
        //    if ([thePersonType hasPrefix:@"1st"])
        //    {
        
        //BOOL doesContain = [self.mySubview.subviews containsObject:self.hq1stLA.view];
        //if (!doesContain) {
        self.hq1stLA = [nextStoryboard instantiateViewControllerWithIdentifier:@"HQ1stLA"];
        
        [self addChildViewController:self.hq1stLA];
        self.hq1stLA.view.tag=1000;
        self.hq1stLA.txtHeight.tag=500;
        self.hq1stLA.txtWeight.tag=501;
        
        [self.mySubview addSubview:self.hq1stLA.view];
        //[self.hq1stLA.txtHeight becomeFirstResponder];
        
        NSLog(@"clickedHere2");
        
        
        //}
        //    }

	}
    
////    _personTypeLbl.text = thePersonType;
//	_personTypeLbl.textColor = [UIColor blackColor];
//    self.mySubview.tag=2000;
//    UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
////    if ([thePersonType hasPrefix:@"1st"])
////    {
//    
//        //BOOL doesContain = [self.mySubview.subviews containsObject:self.hq1stLA.view];
//        //if (!doesContain) {
//        self.hq1stLA = [nextStoryboard instantiateViewControllerWithIdentifier:@"HQ1stLA"];
//        
//        [self addChildViewController:self.hq1stLA];
//        self.hq1stLA.view.tag=1000;
//        self.hq1stLA.txtHeight.tag=500;
//        self.hq1stLA.txtWeight.tag=501;
//        
//        [self.mySubview addSubview:self.hq1stLA.view];
//        [self.hq1stLA.txtHeight becomeFirstResponder];
//        
//        NSLog(@"clickedHere");
    

   
        //}
//    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMySubview:nil];
    [self setPersonTypeLbl:nil];
    [super viewDidUnload];
}
- (IBAction)actionForPersonType:(id)sender {
    if (_RelationshipVC == nil)
    {
        
        self.RelationshipVC = [[HealthQuestPersonType alloc] initWithStyle:UITableViewStylePlain];
        _RelationshipVC.delegate = self;
        if (la2Available) {
            NSLog(@"1");
            NSString *LA2hasRider1 = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"LA2HasRider"];
			if ([LA2hasRider1 isEqualToString:@"Y"]) {
				_RelationshipVC.requestType = @"LA2";
			}
			else {
				_RelationshipVC.requestType = @"LA";
			}

            
        }
		else if (PYAvailable) {
			NSLog(@"PY");
			NSString *PYhasRider = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"PYHasRider"];
			if ([PYhasRider isEqualToString:@"Y"]) {
				_RelationshipVC.requestType = @"PY1";
			}
			else {
				_RelationshipVC.requestType = @"LA";
			}
		}
        else {
            NSLog(@"2");
            _RelationshipVC.requestType = @"LA";
        }
        self.RelationshipPopover = [[UIPopoverController alloc] initWithContentViewController:_RelationshipVC];
    }
    [self.RelationshipPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)selectedPersonType:(NSString *)thePersonType
{
    
    _personTypeLbl.text = thePersonType;
	_personTypeLbl.textColor = [UIColor blackColor];
    self.mySubview.tag=2000;
    UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
    if ([thePersonType hasPrefix:@"1st"])
    {
         //BOOL doesContain = [self.mySubview.subviews containsObject:self.hq1stLA.view];
        //if (!doesContain) {
            self.hq1stLA = [nextStoryboard instantiateViewControllerWithIdentifier:@"HQ1stLA"];
       
            [self addChildViewController:self.hq1stLA];
        self.hq1stLA.view.tag=1000;
        self.hq1stLA.txtHeight.tag=500;
           self.hq1stLA.txtWeight.tag=501;
        
            [self.mySubview addSubview:self.hq1stLA.view];
       //  [self.hq1stLA.txtHeight becomeFirstResponder];
        
        NSLog(@"clickedHere1");
        //}
    }
    else if ([thePersonType hasPrefix:@"2nd"]) {
        //BOOL doesContain = [self.mySubview.subviews containsObject:self.hq2ndLA.view];
        //if (!doesContain) {
            self.hq2ndLA = [nextStoryboard instantiateViewControllerWithIdentifier:@"HQ2ndLA"];
            [self addChildViewController:self.hq2ndLA];
        self.hq2ndLA.view.tag=1000;
        self.hq2ndLA.txtHeight.tag=500;
        self.hq2ndLA.txtWeight.tag=501;
            [self.mySubview addSubview:self.hq2ndLA.view];
      //   [self.hq2ndLA.txtHeight becomeFirstResponder];
        //}
    }
    else {//
        //BOOL doesContain = [self.mySubview.subviews containsObject:self.hqPo.view];
        //if (!doesContain) {
            self.hqPo = [nextStoryboard instantiateViewControllerWithIdentifier:@"HQPO"];
            [self addChildViewController:self.hqPo];
        self.hqPo.view.tag=1000;
        self.hqPo.txtHeight.tag=500;
        self.hqPo.txtWeight.tag=501;
            [self.mySubview addSubview:self.hqPo.view];
       //  [self.hqPo.txtHeight becomeFirstResponder];
        //}
    }
    
    [self.RelationshipPopover dismissPopoverAnimated:YES];
    
}
@end
