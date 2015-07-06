//
//  HealthQuestionsPO.m
//  iMobile Planner
//
//  Created by Erza on 11/15/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "HealthQuestionsPO.h"
#import "MainQViewController.h"
#import "DataClass.h"

@interface HealthQuestionsPO () {
    DataClass *obj;
}

@end

@implementation HealthQuestionsPO

MainQViewController *Q1;
MainQViewController *Q2;
MainQViewController *Q3;
MainQViewController *Q4;
MainQViewController *Q5;
MainQViewController *Q6;

MainQViewController *Q71;
MainQViewController *Q72;
MainQViewController *Q73;
MainQViewController *Q74;
MainQViewController *Q75;
MainQViewController *Q76;
MainQViewController *Q77;
MainQViewController *Q78;
MainQViewController *Q79;
MainQViewController *Q710;

MainQViewController *Q81;
MainQViewController *Q82;
MainQViewController *Q83;
MainQViewController *Q84;
MainQViewController *Q85;

MainQViewController *Q9;
MainQViewController *Q10;
MainQViewController *Q11;
MainQViewController *Q12;
MainQViewController *Q13;

MainQViewController *Q141;
MainQViewController *Q142;

MainQViewController *Q15;

- (void)viewDidLoad
{
    

	
	[super viewDidLoad];
    obj = [DataClass getInstance];
    
    Q1 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q2 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q3 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
	
	Q4 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q5 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q6 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    
    Q71 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q72 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q73 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q74 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q75 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q76 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q77 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q78 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q79 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q710 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q81 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q82 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q83 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q84 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q85 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q9 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q10 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q11 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q12 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q13 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q141 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q142 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
	
	Q15 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q1.modalPresentationStyle = UIModalPresentationFormSheet;
    Q2.modalPresentationStyle = UIModalPresentationFormSheet;
    Q3.modalPresentationStyle = UIModalPresentationFormSheet;
	Q4.modalPresentationStyle = UIModalPresentationFormSheet;
    Q5.modalPresentationStyle = UIModalPresentationFormSheet;
    Q6.modalPresentationStyle = UIModalPresentationFormSheet;
    Q71.modalPresentationStyle = UIModalPresentationFormSheet;
    Q72.modalPresentationStyle = UIModalPresentationFormSheet;
    Q73.modalPresentationStyle = UIModalPresentationFormSheet;
    Q74.modalPresentationStyle = UIModalPresentationFormSheet;
    Q75.modalPresentationStyle = UIModalPresentationFormSheet;
    Q76.modalPresentationStyle = UIModalPresentationFormSheet;
    Q77.modalPresentationStyle = UIModalPresentationFormSheet;
    Q78.modalPresentationStyle = UIModalPresentationFormSheet;
    Q79.modalPresentationStyle = UIModalPresentationFormSheet;
    Q710.modalPresentationStyle = UIModalPresentationFormSheet;
    Q81.modalPresentationStyle = UIModalPresentationFormSheet;
    Q82.modalPresentationStyle = UIModalPresentationFormSheet;
    Q83.modalPresentationStyle = UIModalPresentationFormSheet;
    Q84.modalPresentationStyle = UIModalPresentationFormSheet;
    Q85.modalPresentationStyle = UIModalPresentationFormSheet;
    Q9.modalPresentationStyle = UIModalPresentationFormSheet;
    Q10.modalPresentationStyle = UIModalPresentationFormSheet;
    Q11.modalPresentationStyle = UIModalPresentationFormSheet;
    Q12.modalPresentationStyle = UIModalPresentationFormSheet;
    Q13.modalPresentationStyle = UIModalPresentationFormSheet;
    Q141.modalPresentationStyle = UIModalPresentationFormSheet;
    Q142.modalPresentationStyle = UIModalPresentationFormSheet;
	Q15.modalPresentationStyle = UIModalPresentationFormSheet;
    
    Q1.LAType = @"POHQ";
    Q2.LAType = @"POHQ";
    Q3.LAType = @"POHQ";
	Q4.LAType = @"POHQ";
    Q5.LAType = @"POHQ";
    Q6.LAType = @"POHQ";
    Q71.LAType = @"POHQ";
    Q72.LAType = @"POHQ";
    Q73.LAType = @"POHQ";
    Q74.LAType = @"POHQ";
    Q75.LAType = @"POHQ";
    Q76.LAType = @"POHQ";
    Q77.LAType = @"POHQ";
    Q78.LAType = @"POHQ";
    Q79.LAType = @"POHQ";
    Q710.LAType = @"POHQ";
    Q81.LAType = @"POHQ";
    Q82.LAType = @"POHQ";
    Q83.LAType = @"POHQ";
    Q84.LAType = @"POHQ";
    Q85.LAType = @"POHQ";
    Q9.LAType = @"POHQ";
    Q10.LAType = @"POHQ";
    Q11.LAType = @"POHQ";
    Q12.LAType = @"POHQ";
    Q13.LAType = @"POHQ";
    Q141.LAType = @"POHQ";
    Q142.LAType = @"POHQ";
	Q4.LAType = @"POHQ";
    
    self.txtWeight.delegate = self;
    self.txtHeight.delegate = self;
    
    checked = NO;
	to = [TagObject tagObj];
    [self checkSavedData];
    
    // check age and gender
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    [db open];
    FMResultSet *results = [db executeQuery:@"select LASex, LADOB, LASmoker from eProposal_LA_Details where eProposalNo = ? and PTypeCode = 'PY1'", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
    NSString *gender;
    NSString *dob;
    NSString *smoker;
    if ([results next]) {
        gender = [results stringForColumn:@"LASex"];
        dob = [results stringForColumn:@"LADOB"];
        smoker = [results stringForColumn:@"LASmoker"];
    }
    if ([gender hasPrefix:@"M"]) {
        _segQ14A.selectedSegmentIndex = 1;
        _yes14a.hidden = TRUE;
        _segQ14B.selectedSegmentIndex = 1;
        _yes14b.hidden = TRUE;
        _segQ14A.enabled = FALSE;
        _segQ14B.enabled = FALSE;
        [self segmentPress:_segQ14A];
        [self segmentPress:_segQ14B];
    }
    
    int age = [self calculateAge:dob];
    if (age > 2) {
        _segQ15.enabled = FALSE;
        _segQ15.selectedSegmentIndex = 1;
		[self segmentPress:_segQ15];
    }
    
    if ([smoker hasPrefix:@"N"]) {
        _segQ4.enabled = FALSE;
        _segQ4.selectedSegmentIndex = 1;
		[self segmentPress:_segQ4];
    }
    else if ([smoker hasPrefix:@"Y"]) {
        _segQ4.enabled = FALSE;
        _segQ4.selectedSegmentIndex = 0;
		_yes4.hidden = TRUE;
		[self segmentPress:_segQ4];
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"Q4"] == NULL) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q4"];
		}
    }
    
    NSLog(@"gender = %@, age = %d, smoker = %@", gender, age, smoker);
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	tap.delegate = self;
	[self.view addGestureRecognizer:tap];
	
	[_txtHeight addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_txtWeight addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkSavedData) name:@"updateParent" object:nil];
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


-(void)checkSavedData
{
   // if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Saved"] isEqualToString:@"Y"] || ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"Saved"] isEqualToString:@"Y"]) )
     //changes by satya for 3219 
//  if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] valueForKey:@"SecE_weight"] length]>0  )
//        
//    {
        if (![[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"]) {
            [[obj.eAppData objectForKey:@"SecE"] setValue:[NSMutableDictionary dictionary] forKey:@"POHQ"];
        }
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"PO" forKey:@"SecE_personType"];
        NSString* personType = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_personType"];
        NSString* height = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_height"];
        NSString* weight = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_weight"];
        
        self.txtHeight.text = height;
        self.txtWeight.text  = weight;
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q1B"] isEqualToString:@"Y"])
        {
            self.segQ1B.selectedSegmentIndex = 0;
            _yes1b.hidden = FALSE;
        }
        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q1B"] isEqualToString:@"N"])
		{
            self.segQ1B.selectedSegmentIndex = 1;
            _yes1b.hidden = TRUE;
        }
		else {
            self.segQ1B.selectedSegmentIndex = -1;
            _yes1b.hidden = TRUE;
        }
    
    if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q3"] isEqualToString:@"Y"])
    {
        self.segQ3.selectedSegmentIndex = 0;
        _yes3.hidden = FALSE;
    }
    else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q3"] isEqualToString:@"N"])
    {
        self.segQ3.selectedSegmentIndex = 1;
        _yes3.hidden = TRUE;
    }
    else {
        self.segQ3.selectedSegmentIndex = -1;
        _yes3.hidden = TRUE;
    }
    //[self.segQ3 sendActionsForControlEvents:UIControlEventValueChanged];
    
    if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q4"] isEqualToString:@"Y"])
    {
        self.segQ4.selectedSegmentIndex = 0;
        _yes4.hidden = FALSE;
    }
    else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q4"] isEqualToString:@"N"]){
        self.segQ4.selectedSegmentIndex = 1;
        _yes4.hidden = TRUE;
    }
    
    //[self.segQ4 sendActionsForControlEvents:UIControlEventValueChanged];
    
    if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q5"] isEqualToString:@"Y"])
    {
        self.segQ5.selectedSegmentIndex = 0;
        _yes5.hidden = FALSE;
    }
    else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q5"] isEqualToString:@"N"])
    {
        self.segQ5.selectedSegmentIndex = 1;
        _yes5.hidden = TRUE;
    }
    else {
        self.segQ5.selectedSegmentIndex = -1;
        _yes5.hidden = TRUE;
    }

    
        //[self.segQ1B sendActionsForControlEvents:UIControlEventValueChanged];
    
//        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q2"] isEqualToString:@"Y"])
//        {
//            self.segQ2.selectedSegmentIndex = 0;
//            _yes2.hidden = FALSE;
//        }
//        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q2"] isEqualToString:@"N"])
//		{
//            self.segQ2.selectedSegmentIndex = 1;
//            _yes2.hidden = true;
//        }
//        else {
//            self.segQ2.selectedSegmentIndex = -1;
//            _yes2.hidden = true;
//        }

        //[self.segQ2 sendActionsForControlEvents:UIControlEventValueChanged];
        
        //[self.segQ5 sendActionsForControlEvents:UIControlEventValueChanged];
        
//        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q6"] isEqualToString:@"Y"])
//        {
//            self.segQ6.selectedSegmentIndex = 0;
//            _yes6.hidden = FALSE;
//        }
//        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q6"] isEqualToString:@"N"])
//		{
//            self.segQ6.selectedSegmentIndex = 1;
//            _yes6.hidden = TRUE;
//        }
//		else {
//            self.segQ6.selectedSegmentIndex = -1;
//            _yes6.hidden = TRUE;
//        }
    
        //[self.segQ6 sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7A"] isEqualToString:@"Y"])
        {
            self.segQ7A.selectedSegmentIndex = 0;
            _yes7a.hidden = FALSE;
        }
        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7A"] isEqualToString:@"N"])
		{
            self.segQ7A.selectedSegmentIndex = 1;
            _yes7a.hidden = TRUE;
        }
        else {
            self.segQ7A.selectedSegmentIndex = -1;
            _yes7a.hidden = TRUE;
        }
        //[self.segQ7A sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7B"] isEqualToString:@"Y"])
        {
            self.segQ7B.selectedSegmentIndex = 0;
            _yes7b.hidden = FALSE;
        }
        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7B"] isEqualToString:@"N"])
		{
            self.segQ7B.selectedSegmentIndex = 1;
            _yes7b.hidden = TRUE;
        }
        else {
            self.segQ7B.selectedSegmentIndex = -1;
            _yes7b.hidden = TRUE;
        }
        //[self.segQ7B sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7C"] isEqualToString:@"Y"])
        {
            self.segQ7C.selectedSegmentIndex = 0;
            _yes7c.hidden = FALSE;
        }
        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7C"] isEqualToString:@"N"])
		{
            self.segQ7C.selectedSegmentIndex = 1;
            _yes7c.hidden = TRUE;
        }
		else {
            self.segQ7C.selectedSegmentIndex = -1;
            _yes7c.hidden = TRUE;
        }
        
        //[self.segQ7C sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7D"] isEqualToString:@"Y"])
        {    self.segQ7D.selectedSegmentIndex = 0;
            _yes7d.hidden = FALSE;
        }
        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7D"] isEqualToString:@"N"])
		{    self.segQ7D.selectedSegmentIndex = 1;
            _yes7d.hidden = true;
        }
        else {
			self.segQ7D.selectedSegmentIndex = -1;
            _yes7d.hidden = true;
        }
        //[self.segQ7D sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7E"] isEqualToString:@"Y"])
        {
            self.segQ7E.selectedSegmentIndex = 0;
            _yes7e.hidden = FALSE;
        }
        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7E"] isEqualToString:@"N"])
		{
            self.segQ7E.selectedSegmentIndex = 1;
            _yes7e.hidden = TRUE;
        }
        else {
            self.segQ7E.selectedSegmentIndex = -1;
            _yes7e.hidden = TRUE;
        }
        //[self.segQ7E sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7F"] isEqualToString:@"Y"])
        {
            self.segQ7F.selectedSegmentIndex = 0;
            _yes7f.hidden = FALSE;
        }
        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7F"] isEqualToString:@"N"])
		{
            self.segQ7F.selectedSegmentIndex = 1;
            _yes7f.hidden = TRUE;
        }
		else {
            self.segQ7F.selectedSegmentIndex = -1;
            _yes7f.hidden = TRUE;
        }
        
        //[self.segQ7F sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7G"] isEqualToString:@"Y"])
        {
            self.segQ7G.selectedSegmentIndex = 0;
            _yes7g.hidden = FALSE;
        }
        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7G"] isEqualToString:@"N"])
		{
            self.segQ7G.selectedSegmentIndex = 1;
            _yes7g.hidden = TRUE;
        }
        else {
            self.segQ7G.selectedSegmentIndex = -1;
            _yes7g.hidden = TRUE;
        }
        //[self.segQ7G sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7H"] isEqualToString:@"Y"])
        {
            self.segQ7H.selectedSegmentIndex = 0;
            _yes7h.hidden = FALSE;
        }
        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7H"] isEqualToString:@"N"])
		{
            self.segQ7H.selectedSegmentIndex = 1;
            _yes7h.hidden = TRUE;
        }
        else {
            self.segQ7H.selectedSegmentIndex = -1;
            _yes7h.hidden = TRUE;
        }
        //[self.segQ7H sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7I"] isEqualToString:@"Y"])
        {
            self.segQ7I.selectedSegmentIndex = 0;
            _yes7i.hidden =FALSE;
        }
        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7I"] isEqualToString:@"N"])
		{
            self.segQ7I.selectedSegmentIndex = 1;
            _yes7i.hidden =TRUE;
        }
        else {
            self.segQ7I.selectedSegmentIndex = -1;
            _yes7i.hidden =TRUE;
        }
        //[self.segQ7I sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7J"] isEqualToString:@"Y"])
        {
            self.segQ7J.selectedSegmentIndex = 0;
            _yes7j.hidden = FALSE;
        }
        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7J"] isEqualToString:@"N"])
		{
            self.segQ7J.selectedSegmentIndex =1;
            _yes7j.hidden = TRUE;
        }
        else {
            self.segQ7J.selectedSegmentIndex =-1;
            _yes7j.hidden = TRUE;
        }
        //[self.segQ7J sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q8A"] isEqualToString:@"Y"])
        {
            self.segQ8A.selectedSegmentIndex = 0;
            _yes8i.hidden = FALSE;
        }
        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q8A"] isEqualToString:@"N"])
		{
            self.segQ8A.selectedSegmentIndex = 1;
            _yes8i.hidden = TRUE;
        }
        else {
            self.segQ8A.selectedSegmentIndex = -1;
            _yes8i.hidden = TRUE;
        }
        //[self.segQ8A sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q8B"] isEqualToString:@"Y"])
        {
            self.segQ8B.selectedSegmentIndex = 0;
            _yes8ii.hidden = FALSE;
        }
        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q8B"] isEqualToString:@"N"])
		{
            self.segQ8B.selectedSegmentIndex = 1;
            _yes8ii.hidden = TRUE;
        }
        else {
            self.segQ8B.selectedSegmentIndex = -1;
            _yes8ii.hidden = TRUE;
        }
        //[self.segQ8B sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q8C"] isEqualToString:@"Y"])
        {
            self.segQ8C.selectedSegmentIndex = 0;
            _yes8iii.hidden = FALSE;
        }
        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q8C"] isEqualToString:@"N"])
		{
            self.segQ8C.selectedSegmentIndex = 1;
            _yes8iii.hidden = TRUE;
        }
        else {
            self.segQ8C.selectedSegmentIndex = -1;
            _yes8iii.hidden = TRUE;
        }
        //[self.segQ8C sendActionsForControlEvents:UIControlEventValueChanged];
        
        
//        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q8D"] isEqualToString:@"Y"])
//        {
//            self.segQ8D.selectedSegmentIndex = 0;
//            _yes8iv.hidden = FALSE;
//        }
//        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q8D"] isEqualToString:@"N"])
//		{
//            self.segQ8D.selectedSegmentIndex = 1;
//            _yes8iv.hidden = TRUE;
//        }
//        else {
//            self.segQ8D.selectedSegmentIndex = -1;
//            _yes8iv.hidden = TRUE;
//        }
//        //[self.segQ8D sendActionsForControlEvents:UIControlEventValueChanged];
//        
//        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q8E"] isEqualToString:@"Y"])
//        {
//            self.segQ8E.selectedSegmentIndex = 0;
//            _yes8v.hidden = FALSE;
//        }
//        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q8E"] isEqualToString:@"N"])
//		{
//            self.segQ8E.selectedSegmentIndex = 1;
//            _yes8v.hidden = TRUE;
//        }
//        else {
//            self.segQ8E.selectedSegmentIndex = -1;
//            _yes8v.hidden = TRUE;
//        }
//        //[self.segQ8E sendActionsForControlEvents:UIControlEventValueChanged];
//        
//        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q9"] isEqualToString:@"Y"])
//        {
//            self.segQ9.selectedSegmentIndex = 0;
//            _yes9.hidden= FALSE;
//        }
//        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q9"] isEqualToString:@"N"])
//		{
//            self.segQ9.selectedSegmentIndex = 1;
//            _yes9.hidden= TRUE;
//        }
//		else {
//            self.segQ9.selectedSegmentIndex = -1;
//            _yes9.hidden= TRUE;
//        }
//        //[self.segQ9 sendActionsForControlEvents:UIControlEventValueChanged];
    
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q10"] isEqualToString:@"Y"])
        {
            self.segQ10.selectedSegmentIndex = 0;
            _yes10.hidden = FALSE;
        }
        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q10"] isEqualToString:@"N"])
		{
            self.segQ10.selectedSegmentIndex = 1;
            _yes10.hidden = TRUE;
        }
		else {
            self.segQ10.selectedSegmentIndex = -1;
            _yes10.hidden = TRUE;
        }
        //[self.segQ10 sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q11"] isEqualToString:@"Y"])
        {
            self.segQ11.selectedSegmentIndex = 0;
            _yes11.hidden = FALSE;
        }
        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q11"] isEqualToString:@"N"])
		{
            self.segQ11.selectedSegmentIndex = 1;
            _yes11.hidden = TRUE;
        }
        else {
            self.segQ11.selectedSegmentIndex = -1;
            _yes11.hidden = TRUE;
        }
        //[self.segQ11 sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q12"] isEqualToString:@"Y"])
        {
            self.segQ12.selectedSegmentIndex = 0;
            _yes12.hidden = FALSE;
        }
        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q12"] isEqualToString:@"N"])
		{
            self.segQ12.selectedSegmentIndex = 1;
            _yes12.hidden = TRUE;
        }
        else {
            self.segQ12.selectedSegmentIndex = -1;
            _yes12.hidden = TRUE;
        }
        //[self.segQ12 sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q13"] isEqualToString:@"Y"])
        {
            self.segQ13.selectedSegmentIndex = 0;
            _yes13.hidden = FALSE;
        }
        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q13"] isEqualToString:@"N"])
		{
            self.segQ13.selectedSegmentIndex = 1;
            _yes13.hidden = TRUE;
        }
        else {
            self.segQ13.selectedSegmentIndex = -1;
            _yes13.hidden = TRUE;
        }
        //[self.segQ13 sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q14A"] isEqualToString:@"Y"])
        {
            self.segQ14A.selectedSegmentIndex = 0;
            _yes14a.hidden = FALSE;
        }
        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q14A"] isEqualToString:@"N"])
		{
            self.segQ14A.selectedSegmentIndex = 1;
            _yes14a.hidden = TRUE;
        }
        else
		{
            self.segQ14A.selectedSegmentIndex = -1;
            _yes14a.hidden = TRUE;
        }
        //[self.segQ14A sendActionsForControlEvents:UIControlEventValueChanged];
        
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q14B"] isEqualToString:@"Y"])
        {
            self.segQ14B.selectedSegmentIndex = 0;
            _yes14b.hidden = FALSE;
        }
        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q14B"] isEqualToString:@"N"])
		{
            self.segQ14B.selectedSegmentIndex = 1;
            _yes14b.hidden = TRUE;
        }
        else {
            self.segQ14B.selectedSegmentIndex = -1;
            _yes14b.hidden = TRUE;
        }
        //[self.segQ14B sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q15"] isEqualToString:@"Y"])
        {
            self.segQ15.selectedSegmentIndex = 0;
        }
        else if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q15"] isEqualToString:@"N"])
            self.segQ15.selectedSegmentIndex = 1;
        
        //[self.segQ15 sendActionsForControlEvents:UIControlEventValueChanged];
        
//    }
    
}


- (IBAction)segmentPress:(id)sender {
    
    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
    //	MainQViewController *aaa = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
	//aaa.modalPresentationStyle = UIModalPresentationFormSheet;
    //a10.modalPresentationStyle = UIModalPresentationFormSheet;
	//Q1.modalPresentationStyle = UIModalPresentationFormSheet;
    
    Q1.modalPresentationStyle = UIModalPresentationFormSheet;
    Q2.modalPresentationStyle = UIModalPresentationFormSheet;
    Q3.modalPresentationStyle = UIModalPresentationFormSheet;
	 Q4.modalPresentationStyle = UIModalPresentationFormSheet;
    Q5.modalPresentationStyle = UIModalPresentationFormSheet;
    Q6.modalPresentationStyle = UIModalPresentationFormSheet;
    Q71.modalPresentationStyle = UIModalPresentationFormSheet;
    Q72.modalPresentationStyle = UIModalPresentationFormSheet;
    Q73.modalPresentationStyle = UIModalPresentationFormSheet;
    Q74.modalPresentationStyle = UIModalPresentationFormSheet;
    Q75.modalPresentationStyle = UIModalPresentationFormSheet;
    Q76.modalPresentationStyle = UIModalPresentationFormSheet;
    Q77.modalPresentationStyle = UIModalPresentationFormSheet;
    Q78.modalPresentationStyle = UIModalPresentationFormSheet;
    Q79.modalPresentationStyle = UIModalPresentationFormSheet;
    Q710.modalPresentationStyle = UIModalPresentationFormSheet;
    Q81.modalPresentationStyle = UIModalPresentationFormSheet;
    Q82.modalPresentationStyle = UIModalPresentationFormSheet;
    Q83.modalPresentationStyle = UIModalPresentationFormSheet;
    Q84.modalPresentationStyle = UIModalPresentationFormSheet;
    Q85.modalPresentationStyle = UIModalPresentationFormSheet;
    Q9.modalPresentationStyle = UIModalPresentationFormSheet;
    Q10.modalPresentationStyle = UIModalPresentationFormSheet;
    Q11.modalPresentationStyle = UIModalPresentationFormSheet;
    Q12.modalPresentationStyle = UIModalPresentationFormSheet;
    Q13.modalPresentationStyle = UIModalPresentationFormSheet;
    Q141.modalPresentationStyle = UIModalPresentationFormSheet;
    Q142.modalPresentationStyle = UIModalPresentationFormSheet;
    
    if (![[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"]) {
        [[obj.eAppData objectForKey:@"SecE"] setValue:[NSMutableDictionary dictionary] forKey:@"POHQ"];
    }
    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"PO" forKey:@"SecE_personType"];
	[[obj.eAppData objectForKey:@"SecE"] setValue:@"Payor" forKey:@"PersonType"];
	switch ([sender tag]) {
		case 1:
			if ([sender selectedSegmentIndex] == 0) {
                to.t1 = 1;
                [self presentModalViewController:Q1 animated:YES];
				_yes1b.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q1B"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q1B"];
			}
			else {
				_yes1b.hidden = YES;
                
                Q1 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q1.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q1B"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q1"];
			}
            break;
//		case 2:
//			if ([sender selectedSegmentIndex] == 0) {
//				to.t1 = 2;
//                
//				[self presentModalViewController:Q2 animated:YES];
//				_yes2.hidden = NO;
//				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q2"] isEqualToString:@"N"])
//					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
//                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q2"];
//                
//			}
//			else {
//				_yes2.hidden = YES;
//                
//                Q2 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
//                Q2.LAType = @"POHQ";
//                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q2"];
//				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q2"];
//			}
//			break;
		case 3:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 3;
				[self presentModalViewController:Q3 animated:YES];
				_yes3.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q3"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q3"];
			}
			else {
				_yes3.hidden = YES;
                
                Q3 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q3.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q3"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q3_beerTF"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q3_wineTF"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q3_wboTF"];
			}
			break;
        case 4:
            if ([sender selectedSegmentIndex] == 0) {
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q4"];
				_yes4.hidden = NO;
            }
            else {
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q4"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q4"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q4_cigarettesTF"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q4_pipeTF"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q4_cigarTF"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q4_eCigarTF"];
                
				_yes4.hidden = YES;
            }
            break;
		case 5:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 5;
				[self presentModalViewController:Q5 animated:YES];
				_yes5.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q5"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q5"];
			}
			else {
				_yes5.hidden = YES;
                
                Q5 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q5.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q5"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q5"];
			}
			break;
//		case 6:
//			if ([sender selectedSegmentIndex] == 0) {
//				to.t1 = 6;
//				[self presentModalViewController:Q6 animated:YES];
//				_yes6.hidden = NO;
//				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q6"] isEqualToString:@"N"])
//					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
//                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q6"];
//			}
//			else {
//				_yes6.hidden = YES;
//                
//                Q6 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
//                Q6.LAType = @"POHQ";
//                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q6"];
//				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q6"];
//			}
//			break;
		case 71:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 71;
				[self presentModalViewController:Q71 animated:YES];
				_yes7a.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7A"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q7A"];
			}
			else {
				_yes7a.hidden = YES;
                
                Q71 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q71.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q7A"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q7"];
			}
			break;
		case 72:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 72;
				[self presentModalViewController:Q72 animated:YES];
				_yes7b.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7B"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q7B"];
			}
			else {
				_yes7b.hidden = YES;
                
                Q72 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q72.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q7B"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q7b"];
			}
			break;
		case 73:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 73;
				[self presentModalViewController:Q73 animated:YES];
				_yes7c.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7C"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q7C"];
			}
			else {
				_yes7c.hidden = YES;
                
                Q73 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q73.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q7C"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q7c"];
			}
			break;
		case 74:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 74;
				[self presentModalViewController:Q74 animated:YES];
				_yes7d.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7D"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q7D"];
			}
			else {
				_yes7d.hidden = YES;
                
                Q74 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q74.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q7D"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q7d"];
			}
			break;
		case 75:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 75;
				[self presentModalViewController:Q75 animated:YES];
				_yes7e.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7E"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q7E"];
			}
			else {
				_yes7e.hidden = YES;
                
                Q75 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q75.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q7E"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q7e"];
			}
			break;
		case 76:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 76;
				[self presentModalViewController:Q76 animated:YES];
				_yes7f.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7F"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q7F"];
			}
			else {
				_yes7f.hidden = YES;
                
                Q76 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q76.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q7F"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q7f"];
			}
			break;
		case 77:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 77;
				[self presentModalViewController:Q77 animated:YES];
				_yes7g.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7G"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q7G"];
			}
			else {
				_yes7g.hidden = YES;
                
                Q77 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q77.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q7G"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q7g"];
			}
			break;
		case 78:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 78;
				[self presentModalViewController:Q78 animated:YES];
				_yes7h.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7H"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q7H"];
			}
			else {
				_yes7h.hidden = YES;
                
                Q78 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q78.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q7H"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q7h"];
			}
			break;
		case 79:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 79;
				[self presentModalViewController:Q79 animated:YES];
				_yes7i.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7I"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q7I"];
			}
			else {
				_yes7i.hidden = YES;
                
                Q79 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q79.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q7I"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q7i"];
			}
			break;
		case 710:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 710;
				[self presentModalViewController:Q710 animated:YES];
				_yes7j.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q7J"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q7J"];
			}
			else {
				_yes7j.hidden = YES;
                
                Q710 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q710.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q7J"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q7j"];
			}
			break;
		case 81:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 81;
				[self presentModalViewController:Q81 animated:YES];
				_yes8i.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q8A"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q8A"];
			}
			else {
				_yes8i.hidden = YES;
                
                Q81 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q81.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q8A"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q8"];
			}
			break;
		case 82:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 82;
				[self presentModalViewController:Q82 animated:YES];
				_yes8ii.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q8B"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q8B"];
			}
			else {
				_yes8ii.hidden = YES;
                
                Q82 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q82.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q8B"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q8b"];
			}
			break;
		case 83:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 83;
				[self presentModalViewController:Q83 animated:YES];
				_yes8iii.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q8C"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q8C"];
			}
			else {
				_yes8iii.hidden = YES;
                
                Q83 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q83.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q8C"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q8c"];
			}
			break;
//		case 84:
//			if ([sender selectedSegmentIndex] == 0) {
//				to.t1 = 84;
//				[self presentModalViewController:Q84 animated:YES];
//				_yes8iv.hidden = NO;
//				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q8D"] isEqualToString:@"N"])
//					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
//                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q8D"];
//			}
//			else {
//				_yes8iv.hidden = YES;
//                
//                Q84 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
//                Q84.LAType = @"POHQ";
//                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q8D"];
//				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q8d"];
//			}
//			break;
//		case 85:
//			if ([sender selectedSegmentIndex] == 0) {
//				to.t1 = 85;
//				[self presentModalViewController:Q85 animated:YES];
//				_yes8v.hidden = NO;
//				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q8E"] isEqualToString:@"N"])
//					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
//                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q8E"];
//			}
//			else {
//				_yes8v.hidden = YES;
//                
//                Q85 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
//                Q85.LAType = @"POHQ";
//                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q8E"];
//				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q8e"];
//			}
//			break;
//		case 9:
//			if ([sender selectedSegmentIndex] == 0) {
//				to.t1 = 9;
//				[self presentModalViewController:Q9 animated:YES];
//				_yes9.hidden = NO;
//				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q9"] isEqualToString:@"N"])
//					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
//                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q9"];
//			}
//			else {
//				_yes9.hidden = YES;
//                
//                Q9 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
//                Q9.LAType = @"POHQ";
//                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q9"];
//				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q9"];
//                
//			}
//			break;
		case 10:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 10;
				[self presentModalViewController:Q10 animated:YES];
				_yes10.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q10"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q10"];
			}
			else {
				_yes10.hidden = YES;
                Q10 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q10.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q10"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q10"];
			}
			break;
		case 11:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 11;
				[self presentModalViewController:Q11 animated:YES];
				_yes11.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q11"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q11"];
			}
			else {
				_yes11.hidden = YES;
                Q11 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q11.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q11"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q11"];
			}
			break;
		case 12:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 12;
				[self presentModalViewController:Q12 animated:YES];
				_yes12.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q12"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q12"];
			}
			else {
				_yes12.hidden = YES;
                Q12 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q12.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q12"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q12"];
			}
			break;
		case 13:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 13;
				[self presentModalViewController:Q13 animated:YES];
				_yes13.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q13"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q13"];
			}
			else {
				_yes13.hidden = YES;
                Q13 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q13.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q13"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q13"];
			}
			break;
		case 141:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 141;
				[self presentModalViewController:Q141 animated:YES];
				_yes14a.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q14A"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q14A"];
			}
			else {
				_yes14a.hidden = YES;
                Q141 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q141.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q14A"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q14"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q14_weeksTF"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q4_monthsTF"];
			}
			break;
		case 142:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 142;
				[self presentModalViewController:Q142 animated:YES];
				_yes14b.hidden = NO;
				if ([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] objectForKey:@"SecE_Q14B"] isEqualToString:@"N"])
					[[obj.eAppData objectForKey:@"SecE"] setValue:@"N" forKey:@"OLD_VALUE"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q14B"];
			}
			else {
				_yes14b.hidden = YES;
                Q142 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q142.LAType = @"POHQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q14B"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q14b"];
			}
			break;
        case 15:
            if ([sender selectedSegmentIndex] == 0) {
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"Y" forKey:@"SecE_Q15"];
            }
            else {
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"N" forKey:@"SecE_Q15"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q15_weight"];
				[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:@"" forKey:@"Q15_days"];
            }
            break;
		default:
            break;
	}
}

- (IBAction)actionForViewYes:(id)sender {
	UIButton *btnPressed = (UIButton*)sender;
	//MainQViewController *aaa = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
	//Q1.modalPresentationStyle = UIModalPresentationFormSheet;
	
    [[obj.eAppData objectForKey:@"SecE"] setValue:@"Payor" forKey:@"PersonType"];
    
	if (btnPressed.tag == 1) {
		to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q1 animated:YES];
        
        
	}
    else if(btnPressed.tag == 2) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q2 animated:YES];
        
        
    }
    else if(btnPressed.tag == 3) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q3 animated:YES];
        
        
    }
	else if(btnPressed.tag == 4) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q4 animated:YES];
        
        
    }
    else if(btnPressed.tag == 5) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q5 animated:YES];
        
        
    }
    else if(btnPressed.tag == 6) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q6 animated:YES];
        
        
    }
    else if(btnPressed.tag == 71) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q71 animated:YES];
        
        
    }
    else if(btnPressed.tag == 72) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q72 animated:YES];
        
        
    }
    else if(btnPressed.tag == 73) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q73 animated:YES];
        
        
    }
    else if(btnPressed.tag == 74) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q74 animated:YES];
        
        
    }
    else if(btnPressed.tag == 75) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q75 animated:YES];
        
        
    }
    else if(btnPressed.tag == 76) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q76 animated:YES];
        
        
    }
    else if(btnPressed.tag == 77) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q77 animated:YES];
        
        
    }
    else if(btnPressed.tag == 78) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q78 animated:YES];
        
        
    }
    else if(btnPressed.tag == 79) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q79 animated:YES];
        
        
    }
    else if(btnPressed.tag == 710) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q710 animated:YES];
        
        
    }
    else if(btnPressed.tag == 81) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q81 animated:YES];
        
        
    }
    else if(btnPressed.tag == 82) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q82 animated:YES];
        
        
    }
    else if(btnPressed.tag == 83) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q83 animated:YES];
        
        
    }
    else if(btnPressed.tag == 84) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q84 animated:YES];
        
        
    }
    else if(btnPressed.tag == 85) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q85 animated:YES];
        
        
    }
    
    else if(btnPressed.tag == 9) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q9 animated:YES];
        
        
    }
    else if(btnPressed.tag == 10) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q10 animated:YES];
        
        
    }
    else if(btnPressed.tag == 11) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q11 animated:YES];
        
        
    }
    else if(btnPressed.tag == 12) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q12 animated:YES];
        
        
    }
    else if(btnPressed.tag == 13) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q13 animated:YES];
        
        
    }
    else if(btnPressed.tag == 141) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q141 animated:YES];
        
        
    }
    else if(btnPressed.tag == 142) {
        to.t1 = btnPressed.tag;
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"Y" forKey:@"OLD_VALUE"];
        [self presentModalViewController:Q142 animated:YES];
        
        
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setYes1b:nil];
    [self setYes2:nil];
    [self setYes3:nil];
	[self setYes4:nil];
    [self setYes5:nil];
    [self setYes6:nil];
    [self setYes7a:nil];
    [self setYes7b:nil];
    [self setYes7c:nil];
    [self setYes7d:nil];
    [self setYes7e:nil];
    [self setYes7f:nil];
    [self setYes7g:nil];
    [self setYes7h:nil];
    [self setYes7i:nil];
    [self setYes7j:nil];
    [self setYes8i:nil];
    [self setYes8ii:nil];
    [self setYes8iii:nil];
    [self setYes8iv:nil];
    [self setYes8v:nil];
    [self setYes9:nil];
    [self setYes10:nil];
    [self setYes11:nil];
    [self setYes12:nil];
    [self setYes13:nil];
    [self setYes14a:nil];
    [self setYes14b:nil];
	[super viewDidUnload];
}

#pragma mark - delegate
-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (![[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"]) {
        [[obj.eAppData objectForKey:@"SecE"] setValue:[NSMutableDictionary dictionary] forKey:@"POHQ"];
    }
    if (textField == self.txtHeight) {
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:self.txtHeight.text forKey:@"SecE_height"];
    }
    else if (textField == self.txtWeight) {
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] setValue:self.txtWeight.text forKey:@"SecE_weight"];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    //    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    //    return [string isEqualToString:filtered];
    
    
    if ((textField == self.txtHeight) || (textField == self.txtWeight))
    {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		if ([self doesString:textField.text containCharacter:'.'])
			return (([string isEqualToString:filtered])&&(newLength <= 6));
		else
			return (([string isEqualToString:filtered])&&(newLength <= 5));
	}
}

-(BOOL)doesString:(NSString *)string containCharacter:(char)character
{
    if ([string rangeOfString:[NSString stringWithFormat:@"%c",character]].location != NSNotFound)
    {
        return YES;
    }
    return NO;
}


-(void)detectChanges:(id) sender
{
    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
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
