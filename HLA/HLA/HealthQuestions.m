//
//  HealthQuestions.m
//  iMobile Planner
//
//  Created by shawal sapuan on 7/10/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "HealthQuestions.h"
#import "ColorHexCode.h"
#import "MainQViewController.h"
#import "HealthQuestionnaire.h"

@interface HealthQuestions ()
{
      DataClass *obj;
}
@end

@implementation HealthQuestions
@synthesize btnCheck,PersonTypeLb;
//@synthesize segQ10,segQ11,segQ12,segQ13,segQ14A,segQ14B,segQ15,segQ1B,segQ2,segQ3,segQ4,segQ5,segQ6;
@synthesize segQ10,segQ11,segQ12,segQ13,segQ14A,segQ14B,segQ15,segQ1B,segQ3,segQ4,segQ5;
//@synthesize segQ7A,segQ7B,segQ7C,segQ7D,segQ7E,segQ7F,segQ7G,segQ7H,segQ7I,segQ7J,segQ8A,segQ8B,segQ8C,segQ8D,segQ8E,segQ9;
@synthesize segQ7A,segQ7B,segQ7C,segQ7D,segQ7E,segQ7F,segQ7G,segQ7H,segQ7I,segQ7J,segQ8A,segQ8B,segQ8C;

@synthesize RelationshipVC = _RelationshipVC;
@synthesize RelationshipPopover = _RelationshipPopover;
@synthesize txtHeight = _txtHeight;
@synthesize txtWeight = _txtWeight;
//ky
MainQViewController *Q1;
MainQViewController *Q2;
MainQViewController *Q3;
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


- (void)viewDidLoad
{
	
    [super viewDidLoad];
    obj = [DataClass getInstance];
    
    Q1 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q2 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
    Q3 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
    
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
    
    Q1.modalPresentationStyle = UIModalPresentationFormSheet;
    Q2.modalPresentationStyle = UIModalPresentationFormSheet;
    Q3.modalPresentationStyle = UIModalPresentationFormSheet;
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


    
    checked = NO;
	to = [TagObject tagObj];
    [self checkSavedData];
    
}
-(void)checkSavedData
{
    
   if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Saved"] isEqualToString:@"Y"])
   
     {
         NSString* personType = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_personType"];
         NSString* height = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_height"];
         NSString* weight = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_weight"];
         
         self.txtHeight.text = height;
         self.txtWeight.text  = weight;
         self.PersonTypeLb.text = personType;
    
         
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q1B"] isEqualToString:@"Y"])
        {
         self.segQ1B.selectedSegmentIndex = 0;
            _yes1b.hidden = FALSE;
        }
        else    
            self.segQ1B.selectedSegmentIndex = 1;
         
         
//        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q2"] isEqualToString:@"Y"])
//        {
//            self.segQ2.selectedSegmentIndex = 0;
//            _yes2.hidden = FALSE;
//        }
//        else
//            self.segQ2.selectedSegmentIndex = 1;
        
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q3"] isEqualToString:@"Y"])
        {
            self.segQ3.selectedSegmentIndex = 0;
            _yes3.hidden = FALSE;
        }
        else
            self.segQ3.selectedSegmentIndex = 1;
        
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q4"] isEqualToString:@"Y"])
        {
            self.segQ4.selectedSegmentIndex = 0;
             
        }
        else
            self.segQ4.selectedSegmentIndex = 1;
        
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q5"] isEqualToString:@"Y"])
        {
            self.segQ5.selectedSegmentIndex = 0;
            _yes5.hidden = FALSE;
        }
        else
            self.segQ5.selectedSegmentIndex = 1;
        
//        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q6"] isEqualToString:@"Y"])
//        {
//            self.segQ6.selectedSegmentIndex = 0;
//            _yes6.hidden = FALSE;
//        }
//        else
//            self.segQ6.selectedSegmentIndex = 1;
        
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q7A"] isEqualToString:@"Y"])
        {
            self.segQ7A.selectedSegmentIndex = 0;
            _yes7a.hidden = FALSE;
        }
        else
            self.segQ7A.selectedSegmentIndex = 1;
        
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q7B"] isEqualToString:@"Y"])
        {
            self.segQ7B.selectedSegmentIndex = 0;
            _yes7b.hidden = FALSE;
        }
        else
            self.segQ7B.selectedSegmentIndex = 1;
        
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q7C"] isEqualToString:@"Y"])
        {
            self.segQ7C.selectedSegmentIndex = 0;
            _yes7c.hidden = FALSE;
        }
        else
            self.segQ7C.selectedSegmentIndex = 1;
        
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q7D"] isEqualToString:@"Y"])
        {    self.segQ7D.selectedSegmentIndex = 0;
            _yes7d.hidden = FALSE;
        }
        else
            self.segQ7D.selectedSegmentIndex = 1;
        
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q7E"] isEqualToString:@"Y"])
        {
            self.segQ7E.selectedSegmentIndex = 0;
            _yes7e.hidden = FALSE;
        }
        else
            self.segQ7E.selectedSegmentIndex = 1;
        
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q7F"] isEqualToString:@"Y"])
        {
            self.segQ7F.selectedSegmentIndex = 0;
            _yes7f.hidden = FALSE;
        }
        else
            self.segQ7F.selectedSegmentIndex = 1;
        
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q7G"] isEqualToString:@"Y"])
        {
            self.segQ7G.selectedSegmentIndex = 0;
            _yes7g.hidden = FALSE;
        }
        else
            self.segQ7G.selectedSegmentIndex = 1;
        
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q7H"] isEqualToString:@"Y"])
        {
            self.segQ7H.selectedSegmentIndex = 0;
            _yes7h.hidden = FALSE;
        }
        else
            self.segQ7H.selectedSegmentIndex = 1;
        
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q7I"] isEqualToString:@"Y"])
        {
            self.segQ7I.selectedSegmentIndex = 0;
            _yes7i.hidden =FALSE;
        }
        else
            self.segQ7I.selectedSegmentIndex = 1;
        
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q7J"] isEqualToString:@"Y"])
        {
            self.segQ7J.selectedSegmentIndex = 0;
            _yes7j.hidden = FALSE;
        }
        else
            self.segQ7J.selectedSegmentIndex = 1;
        
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q8A"] isEqualToString:@"Y"])
        {
            self.segQ8A.selectedSegmentIndex = 0;
            _yes8i.hidden = FALSE;
        }
        else
            self.segQ8A.selectedSegmentIndex = 1;

        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q8B"] isEqualToString:@"Y"])
        {
            self.segQ8B.selectedSegmentIndex = 0;
            _yes8ii.hidden = FALSE;
        }
        else
            self.segQ8B.selectedSegmentIndex = 1;
        
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q8C"] isEqualToString:@"Y"])
        {
            self.segQ8C.selectedSegmentIndex = 0;
            _yes8iii.hidden = FALSE;
        }
        else
            self.segQ8C.selectedSegmentIndex = 1;
    
        
//        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q8D"] isEqualToString:@"Y"])
//        {
//            self.segQ8D.selectedSegmentIndex = 0;
//            _yes8iv.hidden = FALSE;
//        }
//        else
//            self.segQ8D.selectedSegmentIndex = 1;
//        
//        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q8E"] isEqualToString:@"Y"])
//        {
//            self.segQ8E.selectedSegmentIndex = 0;
//            _yes8v.hidden = FALSE;
//        }
//        else
//            self.segQ8E.selectedSegmentIndex = 1;
//        
//        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q9"] isEqualToString:@"Y"])
//        {
//            self.segQ9.selectedSegmentIndex = 0;
//            _yes9.hidden= FALSE;
//        }
//        else
//            self.segQ9.selectedSegmentIndex = 1;
        
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q10"] isEqualToString:@"Y"])
        {
            self.segQ10.selectedSegmentIndex = 0;
            _yes10.hidden = FALSE;
        }
        else
            self.segQ10.selectedSegmentIndex = 1;
     
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q11"] isEqualToString:@"Y"])
        {
            self.segQ11.selectedSegmentIndex = 0;
            _yes11.hidden = FALSE;
        }
        else
            self.segQ11.selectedSegmentIndex = 1;
        
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q12"] isEqualToString:@"Y"])
        {
            self.segQ12.selectedSegmentIndex = 0;
            _yes12.hidden = FALSE;
        }
        else
            self.segQ12.selectedSegmentIndex = 1;
        
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q13"] isEqualToString:@"Y"])
        {
            self.segQ13.selectedSegmentIndex = 0;
            _yes13.hidden = FALSE;
        }
        else
            self.segQ13.selectedSegmentIndex = 1;
        
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q14A"] isEqualToString:@"Y"])
        {
            self.segQ14A.selectedSegmentIndex = 0;
            _yes14a.hidden = FALSE;
        }
        else
            self.segQ14A.selectedSegmentIndex = 1;
         
         
         if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q14B"] isEqualToString:@"Y"])
         {
             self.segQ14B.selectedSegmentIndex = 0;
             _yes14b.hidden = FALSE;
         }
         else
             self.segQ14B.selectedSegmentIndex = 1;
        
        if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Q15"] isEqualToString:@"Y"])
        {
            self.segQ15.selectedSegmentIndex = 0;
        }
        else
            self.segQ15.selectedSegmentIndex = 1;
       
   }

}

- (void)btnDone:(id)sender
{
         
}

- (IBAction)isAllNo:(id)sender
{
//	checked = !checked;
    if (checked) {
        checked = NO;
//        [btnCheck setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
    }
    else {
        //set all to no
        
        checked = YES;
//        [btnCheck setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        segQ1B.selectedSegmentIndex = 1;
//        segQ2.selectedSegmentIndex = 1;
        segQ3.selectedSegmentIndex = 1;
        segQ4.selectedSegmentIndex = 1;
        segQ5.selectedSegmentIndex = 1;
//        segQ6.selectedSegmentIndex = 1;
        segQ7A.selectedSegmentIndex = 1;
        segQ7B.selectedSegmentIndex = 1;
        segQ7C.selectedSegmentIndex = 1;
        segQ7D.selectedSegmentIndex = 1;
        segQ7E.selectedSegmentIndex = 1;
        segQ7F.selectedSegmentIndex = 1;
        segQ7G.selectedSegmentIndex = 1;
        segQ7H.selectedSegmentIndex = 1;
        segQ7I.selectedSegmentIndex = 1;
        segQ7J.selectedSegmentIndex = 1;
        segQ8A.selectedSegmentIndex = 1;
        segQ8B.selectedSegmentIndex = 1;
        segQ8C.selectedSegmentIndex = 1;
//        segQ8D.selectedSegmentIndex = 1;
//        segQ8E.selectedSegmentIndex = 1;
//        segQ9.selectedSegmentIndex = 1;
        segQ10.selectedSegmentIndex = 1;
        segQ11.selectedSegmentIndex = 1;
        segQ12.selectedSegmentIndex = 1;
        segQ13.selectedSegmentIndex = 1;
        segQ14A.selectedSegmentIndex = 1;
        segQ14B.selectedSegmentIndex = 1;
        segQ15.selectedSegmentIndex = 1;
		 
		_yes10.hidden = YES;
		_yes11.hidden = YES;
		_yes12.hidden = YES;
		_yes13.hidden = YES;
		_yes14a.hidden = YES;
		_yes14b.hidden = YES;
		_yes1b.hidden = YES;
		_yes2.hidden = YES;
		_yes3.hidden = YES;
		_yes5.hidden = YES;
		_yes6.hidden = YES;
		_yes7a.hidden = YES;
		_yes7b.hidden = YES;
		_yes7c.hidden = YES;
		_yes7d.hidden = YES;
		_yes7e.hidden = YES;
		_yes7f.hidden = YES;
		_yes7g.hidden = YES;
		_yes7h.hidden = YES;
		_yes7i.hidden = YES;
		_yes7j.hidden = YES;
		_yes8i.hidden = YES;
		_yes8ii.hidden = YES;
		_yes8iii.hidden = YES;
		_yes8iv.hidden = YES;
		_yes8v.hidden = YES;
		_yes9.hidden = YES;
	}
}

- (IBAction)segmentPress:(id)sender {
    
    
//	MainQViewController *aaa = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
	//aaa.modalPresentationStyle = UIModalPresentationFormSheet;
    //a10.modalPresentationStyle = UIModalPresentationFormSheet;
	//Q1.modalPresentationStyle = UIModalPresentationFormSheet;
    
    Q1.modalPresentationStyle = UIModalPresentationFormSheet;
    Q2.modalPresentationStyle = UIModalPresentationFormSheet;
    Q3.modalPresentationStyle = UIModalPresentationFormSheet;
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

    
    
	switch ([sender tag]) {
		case 1:
			if ([sender selectedSegmentIndex] == 0) {
			to.t1 = 1;
			[self presentModalViewController:Q1 animated:YES];
				_yes1b.hidden = NO;
			}
			else {
				_yes1b.hidden = YES;
                
                Q1 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
			}
		break;
//		case 2:
//			if ([sender selectedSegmentIndex] == 0) {
//				to.t1 = 2;
//                
//				[self presentModalViewController:Q2 animated:YES];
//				_yes2.hidden = NO;
//                
//			}
//			else {
//				_yes2.hidden = YES;
//                
//                Q2 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
//			}
//			break;
		case 3:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 3;
				[self presentModalViewController:Q3 animated:YES];
				_yes3.hidden = NO;
			}
			else {
				_yes3.hidden = YES;
                
                Q3 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
			}
			break;
		case 5:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 5;
				[self presentModalViewController:Q5 animated:YES];
				_yes5.hidden = NO;
			}
			else {
				_yes5.hidden = YES;
                
                Q5 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
			}
			break;
//		case 6:
//			if ([sender selectedSegmentIndex] == 0) {
//				to.t1 = 6;
//				[self presentModalViewController:Q6 animated:YES];
//				_yes6.hidden = NO;
//			}
//			else {
//				_yes6.hidden = YES;
//                
//                Q6 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
//			}
//			break;
		case 71:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 71;
				[self presentModalViewController:Q71 animated:YES];
				_yes7a.hidden = NO;
			}
			else {
				_yes7a.hidden = YES;
                
                Q71 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
			}
			break;
		case 72:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 72;
				[self presentModalViewController:Q72 animated:YES];
				_yes7b.hidden = NO;
			}
			else {
				_yes7b.hidden = YES;
                
                Q72 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
			}
			break;
		case 73:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 73;
				[self presentModalViewController:Q73 animated:YES];
				_yes7c.hidden = NO;
			}
			else {
				_yes7c.hidden = YES;
                
                Q73 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
			}
			break;
		case 74:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 74;
				[self presentModalViewController:Q74 animated:YES];
				_yes7d.hidden = NO;
			}
			else {
				_yes7d.hidden = YES;
                
                Q74 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
			}
			break;
		case 75:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 75;
				[self presentModalViewController:Q75 animated:YES];
				_yes7e.hidden = NO;
			}
			else {
				_yes7e.hidden = YES;
                
                Q75 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
			}
			break;
		case 76:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 76;
				[self presentModalViewController:Q76 animated:YES];
				_yes7f.hidden = NO;
			}
			else {
				_yes7f.hidden = YES;
                
                Q76 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
			}
			break;
		case 77:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 77;
				[self presentModalViewController:Q77 animated:YES];
				_yes7g.hidden = NO;
			}
			else {
				_yes7g.hidden = YES;
                
                Q77 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
			}
			break;
		case 78:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 78;
				[self presentModalViewController:Q78 animated:YES];
				_yes7h.hidden = NO;
			}
			else {
				_yes7h.hidden = YES;
                
                Q78 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
			}
			break;
		case 79:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 79;
				[self presentModalViewController:Q79 animated:YES];
				_yes7i.hidden = NO;
			}
			else {
				_yes7i.hidden = YES;
                
                Q79 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
			}
			break;
		case 710:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 710;
				[self presentModalViewController:Q710 animated:YES];
				_yes7j.hidden = NO;
			}
			else {
				_yes7j.hidden = YES;
                
                Q710 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
			}
			break;
		case 81:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 81;
				[self presentModalViewController:Q81 animated:YES];
				_yes8i.hidden = NO;
			}
			else {
				_yes8i.hidden = YES;
                
                Q81 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
			}
			break;
		case 82:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 82;
				[self presentModalViewController:Q82 animated:YES];
				_yes8ii.hidden = NO;
			}
			else {
				_yes8ii.hidden = YES;
                
                Q82 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
			}
			break;
		case 83:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 83;
				[self presentModalViewController:Q83 animated:YES];
				_yes8iii.hidden = NO;
			}
			else {
				_yes8iii.hidden = YES;
                
                Q83 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
			}
			break;
//		case 84:
//			if ([sender selectedSegmentIndex] == 0) {
//				to.t1 = 84;
//				[self presentModalViewController:Q84 animated:YES];
//				_yes8iv.hidden = NO;
//			}
//			else {
//				_yes8iv.hidden = YES;
//                
//                Q84 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
//			}
//			break;
//		case 85:
//			if ([sender selectedSegmentIndex] == 0) {
//				to.t1 = 85;
//				[self presentModalViewController:Q85 animated:YES];
//				_yes8v.hidden = NO;
//			}
//			else {
//				_yes8v.hidden = YES;
//                
//                Q85 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
//			}
//			break;
//		case 9:
//			if ([sender selectedSegmentIndex] == 0) {
//				to.t1 = 9;
//				[self presentModalViewController:Q9 animated:YES];
//				_yes9.hidden = NO;
//			}
//			else {
//				_yes9.hidden = YES;
//        
//                 Q9 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
//                    
//			}
//			break;
		case 10:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 10;
				[self presentModalViewController:Q10 animated:YES];
				_yes10.hidden = NO;
			}
			else {
				_yes10.hidden = YES;
                 Q10 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
			}
			break;
		case 11:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 11;
				[self presentModalViewController:Q11 animated:YES];
				_yes11.hidden = NO;
			}
			else {
				_yes11.hidden = YES;
                 Q11 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
			}
			break;
		case 12:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 12;
				[self presentModalViewController:Q12 animated:YES];
				_yes12.hidden = NO;
			}
			else {
				_yes12.hidden = YES;
                 Q12 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
			}
			break;
		case 13:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 13;
				[self presentModalViewController:Q13 animated:YES];
				_yes13.hidden = NO;
			}
			else {
				_yes13.hidden = YES;
                 Q13 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
			}
			break;
		case 141:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 141;
				[self presentModalViewController:Q141 animated:YES];
				_yes14a.hidden = NO;
			}
			else {
				_yes14a.hidden = YES;
                Q141 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
			}
			break;
		case 142:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 142;
				[self presentModalViewController:Q142 animated:YES];
				_yes14b.hidden = NO;
			}
			else {
				_yes14b.hidden = YES;
                Q142 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
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
	
    
     
	if (btnPressed.tag == 1) {
		to.t1 = btnPressed.tag;
         [self presentModalViewController:Q1 animated:YES];
        
        
	}
//    else if(btnPressed.tag == 2) {
//        to.t1 = btnPressed.tag;
//        [self presentModalViewController:Q2 animated:YES];
//        
//        
//    }
    else if(btnPressed.tag == 3) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q3 animated:YES];
        
        
    }
    else if(btnPressed.tag == 5) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q5 animated:YES];
        
        
    }
//    else if(btnPressed.tag == 6) {
//        to.t1 = btnPressed.tag;
//        [self presentModalViewController:Q6 animated:YES];
//        
//        
//    }
    else if(btnPressed.tag == 71) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q71 animated:YES];
        
        
    }
    else if(btnPressed.tag == 72) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q72 animated:YES];
        
        
    }
    else if(btnPressed.tag == 73) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q73 animated:YES];
        
        
    }
    else if(btnPressed.tag == 74) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q74 animated:YES];
        
        
    }
    else if(btnPressed.tag == 75) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q75 animated:YES];
        
        
    }
    else if(btnPressed.tag == 76) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q76 animated:YES];
        
        
    }
    else if(btnPressed.tag == 77) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q77 animated:YES];
        
        
    }
    else if(btnPressed.tag == 78) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q78 animated:YES];
        
        
    }
    else if(btnPressed.tag == 79) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q79 animated:YES];
        
        
    }
    else if(btnPressed.tag == 710) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q710 animated:YES];
        
        
    }
    else if(btnPressed.tag == 81) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q81 animated:YES];
        
        
    }
    else if(btnPressed.tag == 82) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q82 animated:YES];
        
        
    }
    else if(btnPressed.tag == 83) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q83 animated:YES];
        
        
    }
//    else if(btnPressed.tag == 84) {
//        to.t1 = btnPressed.tag;
//        [self presentModalViewController:Q84 animated:YES];
//        
//        
//    }
//    else if(btnPressed.tag == 85) {
//        to.t1 = btnPressed.tag;
//        [self presentModalViewController:Q85 animated:YES];
//        
//        
//    }
    
//    else if(btnPressed.tag == 9) {
//        to.t1 = btnPressed.tag;
//        [self presentModalViewController:Q9 animated:YES];
//        
//        
//    }
    else if(btnPressed.tag == 10) {
            to.t1 = btnPressed.tag;
            [self presentModalViewController:Q10 animated:YES];
    
           
    }
    else if(btnPressed.tag == 11) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q11 animated:YES];
        
        
    }
    else if(btnPressed.tag == 12) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q12 animated:YES];
        
        
    }
    else if(btnPressed.tag == 13) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q13 animated:YES];
        
        
    }
    else if(btnPressed.tag == 141) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q141 animated:YES];
        
        
    }
    else if(btnPressed.tag == 142) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q142 animated:YES];
        
        
    }

    


}

- (IBAction)actionForPersonType:(id)sender
{
    
    
    if (_RelationshipVC == nil) {
        
        self.RelationshipVC = [[HealthQuestPersonType alloc] initWithStyle:UITableViewStylePlain];
        _RelationshipVC.delegate = self;
        _RelationshipVC.requestType = @"LA";
        self.RelationshipPopover = [[UIPopoverController alloc] initWithContentViewController:_RelationshipVC];
    }
    [self.RelationshipPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)selectedPersonType:(NSString *)thePersonType
{
    
    PersonTypeLb.text = thePersonType;
	PersonTypeLb.textColor = [UIColor blackColor];
    [self.RelationshipPopover dismissPopoverAnimated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setYes1b:nil];
//    [self setYes2:nil];
    [self setYes3:nil];
    [self setYes5:nil];
//    [self setYes6:nil];
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
//    [self setYes8iv:nil];
//    [self setYes8v:nil];
//    [self setYes9:nil];
    [self setYes10:nil];
    [self setYes11:nil];
    [self setYes12:nil];
    [self setYes13:nil];
    [self setYes14a:nil];
    [self setYes14b:nil];
	[super viewDidUnload];
}

@end
