//
//  HealthQuestions2ndLA.m
//  iMobile Planner
//
//  Created by Erza on 11/15/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "HealthQuestions2ndLA.h"
#import "DataClass.h"
#import "MainQViewController.h"

@interface HealthQuestions2ndLA () {
    DataClass *obj;
}

@end

@implementation HealthQuestions2ndLA

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
    
    Q1.LAType = @"LA2HQ";
    Q2.LAType = @"LA2HQ";
    Q3.LAType = @"LA2HQ";
    Q5.LAType = @"LA2HQ";
    Q6.LAType = @"LA2HQ";
    Q71.LAType = @"LA2HQ";
    Q72.LAType = @"LA2HQ";
    Q73.LAType = @"LA2HQ";
    Q74.LAType = @"LA2HQ";
    Q75.LAType = @"LA2HQ";
    Q76.LAType = @"LA2HQ";
    Q77.LAType = @"LA2HQ";
    Q78.LAType = @"LA2HQ";
    Q79.LAType = @"LA2HQ";
    Q710.LAType = @"LA2HQ";
    Q81.LAType = @"LA2HQ";
    Q82.LAType = @"LA2HQ";
    Q83.LAType = @"LA2HQ";
    Q84.LAType = @"LA2HQ";
    Q85.LAType = @"LA2HQ";
    Q9.LAType = @"LA2HQ";
    Q10.LAType = @"LA2HQ";
    Q11.LAType = @"LA2HQ";
    Q12.LAType = @"LA2HQ";
    Q13.LAType = @"LA2HQ";
    Q141.LAType = @"LA2HQ";
    Q142.LAType = @"LA2HQ";
    
    self.txtWeight.delegate = self;
    self.txtHeight.delegate = self;
    
    checked = NO;
	to = [TagObject tagObj];
    [self checkSavedData];
}

-(void)checkSavedData
{
    
    if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Saved"] isEqualToString:@"Y"])
        
    {
        NSString* personType = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_personType"];
        NSString* height = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_height"];
        NSString* weight = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_weight"];
        
        self.txtHeight.text = height;
        self.txtWeight.text  = weight;
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q1B"] isEqualToString:@"Y"])
        {
            self.segQ1B.selectedSegmentIndex = 0;
            _yes1b.hidden = FALSE;
        }
        else
            self.segQ1B.selectedSegmentIndex = 1;
        
        [self.segQ1B sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q2"] isEqualToString:@"Y"])
        {
            self.segQ2.selectedSegmentIndex = 0;
            _yes2.hidden = FALSE;
        }
        else
            self.segQ2.selectedSegmentIndex = 1;
        
        [self.segQ2 sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q3"] isEqualToString:@"Y"])
        {
            self.segQ3.selectedSegmentIndex = 0;
            _yes3.hidden = FALSE;
        }
        else
            self.segQ3.selectedSegmentIndex = 1;
        
        [self.segQ3 sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q4"] isEqualToString:@"Y"])
        {
            self.segQ4.selectedSegmentIndex = 0;
            
        }
        else
            self.segQ4.selectedSegmentIndex = 1;
        
        [self.segQ4 sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q5"] isEqualToString:@"Y"])
        {
            self.segQ5.selectedSegmentIndex = 0;
            _yes5.hidden = FALSE;
        }
        else
            self.segQ5.selectedSegmentIndex = 1;
        
        [self.segQ5 sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q6"] isEqualToString:@"Y"])
        {
            self.segQ6.selectedSegmentIndex = 0;
            _yes6.hidden = FALSE;
        }
        else
            self.segQ6.selectedSegmentIndex = 1;
        
        [self.segQ6 sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q7A"] isEqualToString:@"Y"])
        {
            self.segQ7A.selectedSegmentIndex = 0;
            _yes7a.hidden = FALSE;
        }
        else
            self.segQ7A.selectedSegmentIndex = 1;
        
        [self.segQ7A sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q7B"] isEqualToString:@"Y"])
        {
            self.segQ7B.selectedSegmentIndex = 0;
            _yes7b.hidden = FALSE;
        }
        else
            self.segQ7B.selectedSegmentIndex = 1;
        
        [self.segQ7B sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q7C"] isEqualToString:@"Y"])
        {
            self.segQ7C.selectedSegmentIndex = 0;
            _yes7c.hidden = FALSE;
        }
        else
            self.segQ7C.selectedSegmentIndex = 1;
        
        [self.segQ7C sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q7D"] isEqualToString:@"Y"])
        {    self.segQ7D.selectedSegmentIndex = 0;
            _yes7d.hidden = FALSE;
        }
        else
            self.segQ7D.selectedSegmentIndex = 1;
        
        [self.segQ7D sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q7E"] isEqualToString:@"Y"])
        {
            self.segQ7E.selectedSegmentIndex = 0;
            _yes7e.hidden = FALSE;
        }
        else
            self.segQ7E.selectedSegmentIndex = 1;
        
        [self.segQ7E sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q7F"] isEqualToString:@"Y"])
        {
            self.segQ7F.selectedSegmentIndex = 0;
            _yes7f.hidden = FALSE;
        }
        else
            self.segQ7F.selectedSegmentIndex = 1;
        
        [self.segQ7F sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q7G"] isEqualToString:@"Y"])
        {
            self.segQ7G.selectedSegmentIndex = 0;
            _yes7g.hidden = FALSE;
        }
        else
            self.segQ7G.selectedSegmentIndex = 1;
        
        [self.segQ7G sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q7H"] isEqualToString:@"Y"])
        {
            self.segQ7H.selectedSegmentIndex = 0;
            _yes7h.hidden = FALSE;
        }
        else
            self.segQ7H.selectedSegmentIndex = 1;
        
        [self.segQ7H sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q7I"] isEqualToString:@"Y"])
        {
            self.segQ7I.selectedSegmentIndex = 0;
            _yes7i.hidden =FALSE;
        }
        else
            self.segQ7I.selectedSegmentIndex = 1;
        
        [self.segQ7I sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q7J"] isEqualToString:@"Y"])
        {
            self.segQ7J.selectedSegmentIndex = 0;
            _yes7j.hidden = FALSE;
        }
        else
            self.segQ7J.selectedSegmentIndex = 1;
        
        [self.segQ7J sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q8A"] isEqualToString:@"Y"])
        {
            self.segQ8A.selectedSegmentIndex = 0;
            _yes8i.hidden = FALSE;
        }
        else
            self.segQ8A.selectedSegmentIndex = 1;
        
        [self.segQ8A sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q8B"] isEqualToString:@"Y"])
        {
            self.segQ8B.selectedSegmentIndex = 0;
            _yes8ii.hidden = FALSE;
        }
        else
            self.segQ8B.selectedSegmentIndex = 1;
        
        [self.segQ8B sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q8C"] isEqualToString:@"Y"])
        {
            self.segQ8C.selectedSegmentIndex = 0;
            _yes8iii.hidden = FALSE;
        }
        else
            self.segQ8C.selectedSegmentIndex = 1;
        
        [self.segQ8C sendActionsForControlEvents:UIControlEventValueChanged];
        
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q8D"] isEqualToString:@"Y"])
        {
            self.segQ8D.selectedSegmentIndex = 0;
            _yes8iv.hidden = FALSE;
        }
        else
            self.segQ8D.selectedSegmentIndex = 1;
        
        [self.segQ8D sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q8E"] isEqualToString:@"Y"])
        {
            self.segQ8E.selectedSegmentIndex = 0;
            _yes8v.hidden = FALSE;
        }
        else
            self.segQ8E.selectedSegmentIndex = 1;
        
        [self.segQ8E sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q9"] isEqualToString:@"Y"])
        {
            self.segQ9.selectedSegmentIndex = 0;
            _yes9.hidden= FALSE;
        }
        else
            self.segQ9.selectedSegmentIndex = 1;
        
        [self.segQ9 sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q10"] isEqualToString:@"Y"])
        {
            self.segQ10.selectedSegmentIndex = 0;
            _yes9.hidden = FALSE;
        }
        else
            self.segQ10.selectedSegmentIndex = 1;
        
        [self.segQ10 sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q11"] isEqualToString:@"Y"])
        {
            self.segQ11.selectedSegmentIndex = 0;
            _yes11.hidden = FALSE;
        }
        else
            self.segQ11.selectedSegmentIndex = 1;
        
        [self.segQ11 sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q12"] isEqualToString:@"Y"])
        {
            self.segQ12.selectedSegmentIndex = 0;
            _yes12.hidden = FALSE;
        }
        else
            self.segQ12.selectedSegmentIndex = 1;
        
        [self.segQ12 sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q13"] isEqualToString:@"Y"])
        {
            self.segQ13.selectedSegmentIndex = 0;
            _yes13.hidden = FALSE;
        }
        else
            self.segQ13.selectedSegmentIndex = 1;
        
        [self.segQ13 sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q14A"] isEqualToString:@"Y"])
        {
            self.segQ14A.selectedSegmentIndex = 0;
            _yes14a.hidden = FALSE;
        }
        else
            self.segQ14A.selectedSegmentIndex = 1;
        
        [self.segQ14A sendActionsForControlEvents:UIControlEventValueChanged];
        
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q14B"] isEqualToString:@"Y"])
        {
            self.segQ14B.selectedSegmentIndex = 0;
            _yes14b.hidden = FALSE;
        }
        else
            self.segQ14B.selectedSegmentIndex = 1;
        
        [self.segQ14B sendActionsForControlEvents:UIControlEventValueChanged];
        
        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] objectForKey:@"SecE_Q15"] isEqualToString:@"Y"])
        {
            self.segQ15.selectedSegmentIndex = 0;
        }
        else
            self.segQ15.selectedSegmentIndex = 1;
        
        [self.segQ15 sendActionsForControlEvents:UIControlEventValueChanged];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidUnload {
    [self setTxtHeight:nil];
    [self setTxtWeight:nil];
    [self setSegQ1B:nil];
    [self setSegQ2:nil];
    [self setSegQ3:nil];
    [self setSegQ4:nil];
    [self setSegQ5:nil];
    [self setSegQ6:nil];
    [self setSegQ7B:nil];
    [self setSegQ7C:nil];
    [self setSegQ7D:nil];
    [self setSegQ7E:nil];
    [self setSegQ7F:nil];
    [self setSegQ7G:nil];
    [self setSegQ7H:nil];
    [self setSegQ7I:nil];
    [self setSegQ7J:nil];
    [self setSegQ8A:nil];
    [self setSegQ8B:nil];
    [self setSegQ8C:nil];
    [self setSegQ8D:nil];
    [self setSegQ8E:nil];
    [self setSegQ9:nil];
    [self setSegQ10:nil];
    [self setSegQ11:nil];
    [self setSegQ12:nil];
    [self setSegQ13:nil];
    [self setSegQ14A:nil];
    [self setSegQ14B:nil];
    [self setSegQ15:nil];
    [self setYes1b:nil];
    [self setYes2:nil];
    [self setYes3:nil];
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
- (IBAction)actionForViewYes:(id)sender {
    UIButton *btnPressed = (UIButton*)sender;
    
	if (btnPressed.tag == 1) {
		to.t1 = btnPressed.tag;
        [self presentModalViewController:Q1 animated:YES];
	}
    else if(btnPressed.tag == 2) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q2 animated:YES];
    }
    else if(btnPressed.tag == 3) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q3 animated:YES];
    }
    else if(btnPressed.tag == 5) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q5 animated:YES];
    }
    else if(btnPressed.tag == 6) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q6 animated:YES];
    }
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
    else if(btnPressed.tag == 84) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q84 animated:YES];
    }
    else if(btnPressed.tag == 85) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q85 animated:YES];
    }
    else if(btnPressed.tag == 9) {
        to.t1 = btnPressed.tag;
        [self presentModalViewController:Q9 animated:YES];
    }
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

- (IBAction)segmentPress:(id)sender {
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
    
    if (![[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"]) {
        [[obj.eAppData objectForKey:@"SecE"] setValue:[NSMutableDictionary dictionary] forKey:@"LA2HQ"];
    }
    [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"LA2" forKey:@"SecE_personType"];
	switch ([sender tag]) {
		case 1:
			if ([sender selectedSegmentIndex] == 0) {
                to.t1 = 1;
                [self presentModalViewController:Q1 animated:YES];
				_yes1b.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q1B"];
			}
			else {
				_yes1b.hidden = YES;
                
                Q1 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q1.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q1B"];
			}
            break;
		case 2:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 2;
                
				[self presentModalViewController:Q2 animated:YES];
				_yes2.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q2"];
                
			}
			else {
				_yes2.hidden = YES;
                
                Q2 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q2.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q2"];
			}
			break;
		case 3:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 3;
				[self presentModalViewController:Q3 animated:YES];
				_yes3.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q3"];
			}
			else {
				_yes3.hidden = YES;
                
                Q3 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q3.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q3"];
			}
			break;
        case 4:
            if ([sender selectedSegmentIndex] == 0) {
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q4"];
            }
            else {
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q4"];
            }
            break;
		case 5:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 5;
				[self presentModalViewController:Q5 animated:YES];
				_yes5.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q5"];
			}
			else {
				_yes5.hidden = YES;
                
                Q5 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q5.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q5"];
			}
			break;
		case 6:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 6;
				[self presentModalViewController:Q6 animated:YES];
				_yes6.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q6"];
			}
			else {
				_yes6.hidden = YES;
                
                Q6 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q6.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q6"];
			}
			break;
		case 71:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 71;
				[self presentModalViewController:Q71 animated:YES];
				_yes7a.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q7A"];
			}
			else {
				_yes7a.hidden = YES;
                
                Q71 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q71.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q7A"];
			}
			break;
		case 72:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 72;
				[self presentModalViewController:Q72 animated:YES];
				_yes7b.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q7B"];
			}
			else {
				_yes7b.hidden = YES;
                
                Q72 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q72.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q7B"];
			}
			break;
		case 73:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 73;
				[self presentModalViewController:Q73 animated:YES];
				_yes7c.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q7C"];
			}
			else {
				_yes7c.hidden = YES;
                
                Q73 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q73.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q7C"];
			}
			break;
		case 74:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 74;
				[self presentModalViewController:Q74 animated:YES];
				_yes7d.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q7D"];
			}
			else {
				_yes7d.hidden = YES;
                
                Q74 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q74.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q7D"];
			}
			break;
		case 75:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 75;
				[self presentModalViewController:Q75 animated:YES];
				_yes7e.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q7E"];
			}
			else {
				_yes7e.hidden = YES;
                
                Q75 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q75.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q7E"];
			}
			break;
		case 76:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 76;
				[self presentModalViewController:Q76 animated:YES];
				_yes7f.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q7F"];
			}
			else {
				_yes7f.hidden = YES;
                
                Q76 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q76.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q7F"];
			}
			break;
		case 77:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 77;
				[self presentModalViewController:Q77 animated:YES];
				_yes7g.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q7G"];
			}
			else {
				_yes7g.hidden = YES;
                
                Q77 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q77.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q7G"];
			}
			break;
		case 78:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 78;
				[self presentModalViewController:Q78 animated:YES];
				_yes7h.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q7H"];
			}
			else {
				_yes7h.hidden = YES;
                
                Q78 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q78.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q7H"];
			}
			break;
		case 79:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 79;
				[self presentModalViewController:Q79 animated:YES];
				_yes7i.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q7I"];
			}
			else {
				_yes7i.hidden = YES;
                
                Q79 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q79.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q7I"];
			}
			break;
		case 710:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 710;
				[self presentModalViewController:Q710 animated:YES];
				_yes7j.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q7J"];
			}
			else {
				_yes7j.hidden = YES;
                
                Q710 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q710.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q7J"];
			}
			break;
		case 81:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 81;
				[self presentModalViewController:Q81 animated:YES];
				_yes8i.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q8A"];
			}
			else {
				_yes8i.hidden = YES;
                
                Q81 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q81.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q8A"];
			}
			break;
		case 82:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 82;
				[self presentModalViewController:Q82 animated:YES];
				_yes8ii.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q8B"];
			}
			else {
				_yes8ii.hidden = YES;
                
                Q82 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q82.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q8B"];
			}
			break;
		case 83:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 83;
				[self presentModalViewController:Q83 animated:YES];
				_yes8iii.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q8C"];
			}
			else {
				_yes8iii.hidden = YES;
                
                Q83 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q83.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q8C"];
			}
			break;
		case 84:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 84;
				[self presentModalViewController:Q84 animated:YES];
				_yes8iv.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q8D"];
			}
			else {
				_yes8iv.hidden = YES;
                
                Q84 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q84.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q8D"];
			}
			break;
		case 85:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 85;
				[self presentModalViewController:Q85 animated:YES];
				_yes8v.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q8E"];
			}
			else {
				_yes8v.hidden = YES;
                
                Q85 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q85.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q8E"];
			}
			break;
		case 9:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 9;
				[self presentModalViewController:Q9 animated:YES];
				_yes9.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q9"];
			}
			else {
				_yes9.hidden = YES;
                
                Q9 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q9.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q9"];
                
			}
			break;
		case 10:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 10;
				[self presentModalViewController:Q10 animated:YES];
				_yes10.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q10"];
			}
			else {
				_yes10.hidden = YES;
                Q10 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q10.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q10"];
			}
			break;
		case 11:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 11;
				[self presentModalViewController:Q11 animated:YES];
				_yes11.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q11"];
			}
			else {
				_yes11.hidden = YES;
                Q11 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q11.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q11"];
			}
			break;
		case 12:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 12;
				[self presentModalViewController:Q12 animated:YES];
				_yes12.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q12"];
			}
			else {
				_yes12.hidden = YES;
                Q12 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q12.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q12"];
			}
			break;
		case 13:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 13;
				[self presentModalViewController:Q13 animated:YES];
				_yes13.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q13"];
			}
			else {
				_yes13.hidden = YES;
                Q13 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q13.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q13"];
			}
			break;
		case 141:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 141;
				[self presentModalViewController:Q141 animated:YES];
				_yes14a.hidden = NO;
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q14A"];
			}
			else {
				_yes14a.hidden = YES;
                Q141 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q141.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q14A"];
			}
			break;
		case 142:
			if ([sender selectedSegmentIndex] == 0) {
				to.t1 = 142;
				[self presentModalViewController:Q142 animated:YES];
				_yes14b.hidden = NO;[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q14B"];
			}
			else {
				_yes14b.hidden = YES;
                Q142 = [self.storyboard instantiateViewControllerWithIdentifier:@"MainQViewController"];
                Q142.LAType = @"LA2HQ";
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q14B"];
			}
			break;
        case 15:
            if ([sender selectedSegmentIndex] == 0) {
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"Y" forKey:@"SecE_Q15"];
            }
            else {
                [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:@"N" forKey:@"SecE_Q15"];
            }
            break;
		default:
            break;
	}
}

#pragma mark - delegate
-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (![[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"]) {
        [[obj.eAppData objectForKey:@"SecE"] setValue:[NSMutableDictionary dictionary] forKey:@"LA2HQ"];
    }
    if (textField == self.txtHeight) {
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:self.txtHeight.text forKey:@"SecE_height"];
    }
    else if (textField == self.txtWeight) {
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"LA2HQ"] setValue:self.txtWeight.text forKey:@"SecE_weight"];
    }
}
@end
