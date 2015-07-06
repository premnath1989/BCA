//
//  MainQViewController.m
//  iMobile Planner
//
//  Created by Juliana on 7/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "MainQViewController.h"
#import "ColorHexCode.h"

@interface MainQViewController ()

@end

@implementation MainQViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	//	NSLog(@"tag: %d", bbb.tag);
	tomq1 = [TagObject tagObj];
	obj = [DataClass getInstance];

	if (tomq1.t1 == 1) {
		h1 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire"];
		h1.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h1.textField1 becomeFirstResponder];
		[self addChildViewController:h1];
		[self.mainView addSubview:h1.view];
		//h1.textField1.text isEqualToString:@""
		NSLog(@"1");
	}
	else if (tomq1.t1 == 2) {
		h2 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire2"];
		h2.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h2.textField2 becomeFirstResponder];
		[self addChildViewController:h2];
		[self.mainView addSubview:h2.view];
        
//		NSLog(@"MainQViewController..%@",h2.tohq2.fd2);
        //KY
 
	}
	else if (tomq1.t1 == 3) {
		h3 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire3"];
		h3.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h3.beerTF becomeFirstResponder];
		[self addChildViewController:h3];
		[self.mainView addSubview:h3.view];
		NSLog(@"3");
	}
	else if (tomq1.t1 == 5) {
		h5 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire5"];
		h5.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h5.textField becomeFirstResponder];
		[self addChildViewController:h5];
		[self.mainView addSubview:h5.view];
		NSLog(@"5");
	}
	else if (tomq1.t1 == 6) {
		h6 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire6"];
		h6.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h6.textField becomeFirstResponder];
		[self addChildViewController:h6];
		[self.mainView addSubview:h6.view];
		NSLog(@"6");
	}
	else if (tomq1.t1 == 71) {
		h7 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire7"];
		h7.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h7.textField becomeFirstResponder];
		[self addChildViewController:h7];
		[self.mainView addSubview:h7.view];
	}
	else if (tomq1.t1 == 72) {
		h7b = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire7b"];
		h7b.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h7b.textField becomeFirstResponder];
		[self addChildViewController:h7b];
		[self.mainView addSubview:h7b.view];
	}
	else if (tomq1.t1 == 73) {
		h7c = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire7c"];
		h7c.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h7c.textField becomeFirstResponder];
		[self addChildViewController:h7c];
		[self.mainView addSubview:h7c.view];
	}
	else if (tomq1.t1 == 74) {
		h7d = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire7d"];
		h7d.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h7d.textField becomeFirstResponder];
		[self addChildViewController:h7d];
		[self.mainView addSubview:h7d.view];
	}
	else if (tomq1.t1 == 75) {
		h7e = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire7e"];
		h7e.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h7e.textField becomeFirstResponder];
		[self addChildViewController:h7e];
		[self.mainView addSubview:h7e.view];
	}
	else if (tomq1.t1 == 76) {
		h7f = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire7f"];
		h7f.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h7f.textField becomeFirstResponder];
		[self addChildViewController:h7f];
		[self.mainView addSubview:h7f.view];
	}
	else if (tomq1.t1 == 77) {
		h7g = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire7g"];
		h7g.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h7g.textField becomeFirstResponder];
		[self addChildViewController:h7g];
		[self.mainView addSubview:h7g.view];
	}
	else if (tomq1.t1 == 78) {
		h7h = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire7h"];
		h7h.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h7h.textField becomeFirstResponder];
		[self addChildViewController:h7h];
		[self.mainView addSubview:h7h.view];
	}
	else if (tomq1.t1 == 79) {
		h7i = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire7i"];
		h7i.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h7i.textField becomeFirstResponder];
		[self addChildViewController:h7i];
		[self.mainView addSubview:h7i.view];
	}
	else if (tomq1.t1 == 710) {
		h7j = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire7j"];
		h7j.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h7j.textField becomeFirstResponder];
		[self addChildViewController:h7j];
		[self.mainView addSubview:h7j.view];
	}
	else if (tomq1.t1 == 81) {
		h8 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire8"];
		h8.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h8.textField becomeFirstResponder];
		[self addChildViewController:h8];
		[self.mainView addSubview:h8.view];
	}
	else if (tomq1.t1 == 82) {
		h8b = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire8b"];
		h8b.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h8b.textField becomeFirstResponder];
		[self addChildViewController:h8b];
		[self.mainView addSubview:h8b.view];
	}
	else if (tomq1.t1 == 83) {
		h8c = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire8c"];
		h8c.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h8c.textField becomeFirstResponder];
		[self addChildViewController:h8c];
		[self.mainView addSubview:h8c.view];
	}
	else if (tomq1.t1 == 84) {
		h8d = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire8d"];
		h8d.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h8d.textField becomeFirstResponder];
		[self addChildViewController:h8d];
		[self.mainView addSubview:h8d.view];
	}
	else if (tomq1.t1 == 85) {
		h8e = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire8e"];
		h8e.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h8e.textField becomeFirstResponder];
		[self addChildViewController:h8e];
		[self.mainView addSubview:h8e.view];
	}
	else if (tomq1.t1 == 9) {
		h9 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire9"];
		h9.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h9.textField becomeFirstResponder];
		[self addChildViewController:h9];
		[self.mainView addSubview:h9.view];
        
        //KY
        
        
	}
	else if (tomq1.t1 == 10) {
		h10 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire10"];
		h10.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h10.textField becomeFirstResponder];
		[self addChildViewController:h10];
		[self.mainView addSubview:h10.view];
        
	}
	else if (tomq1.t1 == 11) {
		h11 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire11"];
		h11.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h11.textField becomeFirstResponder];
		[self addChildViewController:h11];
		[self.mainView addSubview:h11.view];
	}
	else if (tomq1.t1 == 12) {
		h12 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire12"];
		h12.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h12.textField becomeFirstResponder];
		[self addChildViewController:h12];
		[self.mainView addSubview:h12.view];
	}
	else if (tomq1.t1 == 13) {
		h13 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire13"];
		h13.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h13.textField becomeFirstResponder];
		[self addChildViewController:h13];
		[self.mainView addSubview:h13.view];
	}
	else if (tomq1.t1 == 141) {
		h14 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire14"];
		h14.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h14.textField becomeFirstResponder];
		[self addChildViewController:h14];
		[self.mainView addSubview:h14.view];
	}
	else if (tomq1.t1 == 142) {
		h14b = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire14b"];
		h14b.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
		[h14b.textField becomeFirstResponder];
		[self addChildViewController:h14b];
		[self.mainView addSubview:h14b.view];
	}

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
	[self setMainView:nil];
    [self setH2View:nil];
    [self setH3View:nil];
    [self setH5View:nil];
    [self setH6View:nil];
    [self setH7View:nil];
    [self setH7bView:nil];
    [self setH7cView:nil];
    [self setH7dView:nil];
    [self setH7eView:nil];
    [self setH7fView:nil];
    [self setH7gView:nil];
    [self setH7hView:nil];
    [self setH7iView:nil];
    [self setH7jView:nil];
    [self setH8View:nil];
    [self setH8bView:nil];
    [self setH8cView:nil];
    [self setH8dView:nil];
    [self setH8eView:nil];
    [self setH9View:nil];
    [self setH10View:nil];
    [self setH11View:nil];
    [self setH12View:nil];
    [self setH13View:nil];
    [self setH14View:nil];
    [self setH14bView:nil];
	[super viewDidUnload];
}

- (IBAction)selectDone:(id)sender {
	if ([h1.textField1.text isEqualToString:@""] || [h2.textField2.text isEqualToString:@""] || [h5.textField.text isEqualToString:@""] || [h6.textField.text isEqualToString:@""] || [h7.textField.text isEqualToString:@""] || [h7b.textField.text isEqualToString:@""] || [h7c.textField.text isEqualToString:@""] || [h7d.textField.text isEqualToString:@""] || [h7e.textField.text isEqualToString:@""] || [h7f.textField.text isEqualToString:@""] || [h7g.textField.text isEqualToString:@""] || [h7h.textField.text isEqualToString:@""] || [h7i.textField.text isEqualToString:@""] || [h7j.textField.text isEqualToString:@""] || [h8.textField.text isEqualToString:@""] || [h8b.textField.text isEqualToString:@""] || [h8c.textField.text isEqualToString:@""] || [h8d.textField.text isEqualToString:@""] || [h8e.textField.text isEqualToString:@""] || [h9.textField.text isEqualToString:@""] || [h10.textField.text isEqualToString:@""] || [h11.textField.text isEqualToString:@""] || [h12.textField.text isEqualToString:@""] || [h13.textField.text isEqualToString:@""] || [h14.textField.text isEqualToString:@""] || [h14b.textField.text isEqualToString:@""] || [h15.textField.text isEqualToString:@""]) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"eApplication" message:@"Please provide further details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
	}
	else if ([h3.beerTF.text isEqualToString:@""] && [h3.wineTF.text isEqualToString:@""] && [h3.wboTF.text isEqualToString:@""]) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"eApplication" message:@"At least one answer is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
	}
	else {
		[self dismissModalViewControllerAnimated:YES];
	}
    NSLog(@"selectDone, t1 = %d, LAType = %@", tomq1.t1, self.LAType);
    //ky- Store Health details text in obj.eAppData
    if (![[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType]) {
        NSLog(@"A");
        [[obj.eAppData objectForKey:@"SecE"] setValue:[NSMutableDictionary dictionary] forKey:self.LAType];
        NSLog(@"B");
    }
    NSLog(@"C");
    if(tomq1.t1 == 1)
    {
        NSLog(@"1");
         [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h1.textField1.text forKey:@"Q1"];
        NSLog(@"2");
    }
    
    else if(tomq1.t1 == 2)
    {
        NSLog(@"3");
         [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h2.textField2.text forKey:@"Q2"];
        NSLog(@"4");

    }
    
    else if(tomq1.t1 == 3)
    {
         [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h3.beerTF.text forKey:@"Q3_beerTF"];
         [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h3.wineTF.text forKey:@"Q3_wineTF"];
         [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h3.wboTF.text forKey:@"Q3_wboTF"];
    }
    
    else if(tomq1.t1 == 5)
    {
         [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h5.textField.text forKey:@"Q5"];
        
    }
    
    else if(tomq1.t1 == 6)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h6.textField.text forKey:@"Q6"];

    else if(tomq1.t1 == 71)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h7.textField.text forKey:@"Q7"];
    
    else if(tomq1.t1 == 72)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h7b.textField.text forKey:@"Q7b"];
    
    else if(tomq1.t1 == 73)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h7c.textField.text forKey:@"Q7c"];
    
    else if(tomq1.t1 == 74)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h7d.textField.text forKey:@"Q7d"];
    
    else if(tomq1.t1 == 75)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h7e.textField.text forKey:@"Q7e"];
    
    else if(tomq1.t1 == 76)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h7f.textField.text forKey:@"Q7f"];
    
    else if(tomq1.t1 == 77)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h7g.textField.text forKey:@"Q7g"];
    
    else if(tomq1.t1 == 78)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h7h.textField.text forKey:@"Q7h"];
    
    else if(tomq1.t1 == 79)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h7i.textField.text forKey:@"Q7i"];
    
    else if(tomq1.t1 == 710)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h7j.textField.text forKey:@"Q7j"];
    
    else if(tomq1.t1 == 81)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h8.textField.text forKey:@"Q8"];
    
    else if(tomq1.t1 == 82)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h8b.textField.text forKey:@"Q8b"];
    
    else if(tomq1.t1 == 83)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h8c.textField.text forKey:@"Q8c"];
    
    else if(tomq1.t1 == 84)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h8d.textField.text forKey:@"Q8d"];
    
    else if(tomq1.t1 == 85)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h8e.textField.text forKey:@"Q8e"];
    
    else if(tomq1.t1 == 9)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h9.textField.text forKey:@"Q9"];
    
     else if(tomq1.t1 == 10)
         [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h10.textField.text forKey:@"Q10"];
    
     else if(tomq1.t1 == 11)
         [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h11.textField.text forKey:@"Q11"];
    
     else if(tomq1.t1 == 12)
         [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h12.textField.text forKey:@"Q12"];
    
     else if(tomq1.t1 == 13)
         [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h13.textField.text forKey:@"Q13"];
    
     else if(tomq1.t1 == 141)
         [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h14.textField.text forKey:@"Q14"];
    
     else if(tomq1.t1 == 142)
         [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h14b.textField.text forKey:@"Q14b"];

     
     
}

- (IBAction)actionForCancel:(id)sender {
	[self dismissViewControllerAnimated:YES completion:Nil];
}

@end
