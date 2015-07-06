//
//  MainQViewController.m
//  iMobile Planner
//
//  Created by Juliana on 7/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "MainQViewController.h"
#import "ColorHexCode.h"
#import "textFields.h"

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
        h1.textView1.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q1"];
		[h1.textView1 becomeFirstResponder];
		[self addChildViewController:h1];
		[self.mainView addSubview:h1.view];
		//h1.textField1.text isEqualToString:@""
		NSLog(@"1");
	}
//	else if (tomq1.t1 == 2) {
//		h2 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire2"];
//		h2.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
//        h2.textView2.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q2"];
//		[h2.textView2 becomeFirstResponder];
//		[self addChildViewController:h2];
//		[self.mainView addSubview:h2.view];
//        
//        //		NSLog(@"MainQViewController..%@",h2.tohq2.fd2);
//        //KY
//        
//	}
	else if (tomq1.t1 == 3) {
		h3 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire3"];
		h3.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  ){
            h3.beerTF.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q3_beerTF"];
            h3.wineTF.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q3_wineTF"];
            h3.wboTF.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q3_wboTF"];
        }
		[h3.beerTF becomeFirstResponder];
		[self addChildViewController:h3];
		[self.mainView addSubview:h3.view];
		NSLog(@"3");
	}
    else if (tomq1.t1 == 4) {
        h4 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire4"];
		h4.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  ){
            h4.cigarettesPerDayTF.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q4_cigarettesTF"];
            h4.pipePerDayTF.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q4_pipeTF"];
            h4.cigarPerDayTF.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q4_cigarTF"];
            h4.eCigarPerDayTF.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q4_eCigarTF"];
        }
		[h4.cigarettesPerDayTF becomeFirstResponder];
		[self addChildViewController:h4];
		[self.mainView addSubview:h4.view];
        
    }
	else if (tomq1.t1 == 5) {
		h5 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire5"];
		h5.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  )
            h5.textview.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q5"];
		[h5.textview becomeFirstResponder];
		[self addChildViewController:h5];
		[self.mainView addSubview:h5.view];
		NSLog(@"5");
	}
//	else if (tomq1.t1 == 6) {
//		h6 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire6"];
//		h6.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
//        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  )
//            h6.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q6"];
//		[h6.textView becomeFirstResponder];
//		[self addChildViewController:h6];
//		[self.mainView addSubview:h6.view];
//		NSLog(@"6");
//	}
	else if (tomq1.t1 == 71) {
		h7 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire7"];
		h7.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  )
            h7.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q7"];
		[h7.textView becomeFirstResponder];
		[self addChildViewController:h7];
		[self.mainView addSubview:h7.view];
	}
	else if (tomq1.t1 == 72) {
		h7b = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire7b"];
		h7b.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  )
            h7b.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q7b"];
		[h7b.textView becomeFirstResponder];
		[self addChildViewController:h7b];
		[self.mainView addSubview:h7b.view];
	}
	else if (tomq1.t1 == 73) {
		h7c = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire7c"];
		h7c.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  )
            h7c.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q7c"];
		[h7c.textView becomeFirstResponder];
		[self addChildViewController:h7c];
		[self.mainView addSubview:h7c.view];
	}
	else if (tomq1.t1 == 74) {
		h7d = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire7d"];
		h7d.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  )
            h7d.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q7d"];
		[h7d.textView becomeFirstResponder];
		[self addChildViewController:h7d];
		[self.mainView addSubview:h7d.view];
	}
	else if (tomq1.t1 == 75) {
		h7e = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire7e"];
		h7e.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  )
            h7e.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q7e"];
		[h7e.textView becomeFirstResponder];
		[self addChildViewController:h7e];
		[self.mainView addSubview:h7e.view];
	}
	else if (tomq1.t1 == 76) {
		h7f = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire7f"];
		h7f.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  )
            h7f.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q7f"];
		[h7f.textView becomeFirstResponder];
		[self addChildViewController:h7f];
		[self.mainView addSubview:h7f.view];
	}
	else if (tomq1.t1 == 77) {
		h7g = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire7g"];
		h7g.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  )
            h7g.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q7g"];
		[h7g.textView becomeFirstResponder];
		[self addChildViewController:h7g];
		[self.mainView addSubview:h7g.view];
	}
	else if (tomq1.t1 == 78) {
		h7h = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire7h"];
		h7h.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  )
            h7h.textview.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q7h"];
		[h7h.textview becomeFirstResponder];
		[self addChildViewController:h7h];
		[self.mainView addSubview:h7h.view];
	}
	else if (tomq1.t1 == 79) {
		h7i = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire7i"];
		h7i.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        h7i.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q7i"];
		[h7i.textView becomeFirstResponder];
		[self addChildViewController:h7i];
		[self.mainView addSubview:h7i.view];
	}
	else if (tomq1.t1 == 710) {
		h7j = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire7j"];
		h7j.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  )
            h7j.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q7j"];
		[h7j.textView becomeFirstResponder];
		[self addChildViewController:h7j];
		[self.mainView addSubview:h7j.view];
	}
	else if (tomq1.t1 == 81) {
		h8 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire8"];
		h8.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  )
            h8.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q8"];
		[h8.textView becomeFirstResponder];
		[self addChildViewController:h8];
		[self.mainView addSubview:h8.view];
	}
	else if (tomq1.t1 == 82) {
		h8b = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire8b"];
		h8b.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  )
            h8b.textview.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q8b"];
		[h8b.textview becomeFirstResponder];
		[self addChildViewController:h8b];
		[self.mainView addSubview:h8b.view];
	}
	else if (tomq1.t1 == 83) {
		h8c = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire8c"];
		h8c.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        h8c.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q8c"];
		[h8c.textView becomeFirstResponder];
		[self addChildViewController:h8c];
		[self.mainView addSubview:h8c.view];
	}
//	else if (tomq1.t1 == 84) {
//		h8d = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire8d"];
//		h8d.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
//        h8d.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q8d"];
//		[h8d.textView becomeFirstResponder];
//		[self addChildViewController:h8d];
//		[self.mainView addSubview:h8d.view];
//	}
//	else if (tomq1.t1 == 85) {
//		h8e = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire8e"];
//		h8e.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
//        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  )
//            h8e.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q8e"];
//		[h8e.textView becomeFirstResponder];
//		[self addChildViewController:h8e];
//		[self.mainView addSubview:h8e.view];
//	}
//	else if (tomq1.t1 == 9) {
//		h9 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire9"];
//		h9.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
//        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  )
//            h9.textview.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q9"];
//		[h9.textview becomeFirstResponder];
//		[self addChildViewController:h9];
//		[self.mainView addSubview:h9.view];
//        
//        //KY
//        
//        
//	}
	else if (tomq1.t1 == 10) {
		h10 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire10"];
		h10.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  )
            h10.textview.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q10"];
		[h10.textview becomeFirstResponder];
		[self addChildViewController:h10];
		[self.mainView addSubview:h10.view];
        
	}
	else if (tomq1.t1 == 11) {
		h11 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire11"];
		h11.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  )
            h11.textview.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q11"];
		[h11.textview becomeFirstResponder];
		[self addChildViewController:h11];
		[self.mainView addSubview:h11.view];
	}
	else if (tomq1.t1 == 12) {
		h12 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire12"];
		h12.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  )
            h12.textview.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q12"];
		[h12.textview becomeFirstResponder];
		[self addChildViewController:h12];
		[self.mainView addSubview:h12.view];
	}
	else if (tomq1.t1 == 13) {
		h13 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire13"];
		h13.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  )
            h13.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q13"];
		[h13.textView becomeFirstResponder];
		[self addChildViewController:h13];
		[self.mainView addSubview:h13.view];
	}
	else if (tomq1.t1 == 141) {
		h14 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire14"];
		h14.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  )
            h14.textField.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q14"];
            h14.monthsTF.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q14_monthsTF"];
                
		[h14.textField becomeFirstResponder];
		[self addChildViewController:h14];
		[self.mainView addSubview:h14.view];
	}
	else if (tomq1.t1 == 142) {
		h14b = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire14b"];
		h14b.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  )
            h14b.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q14b"];
		[h14b.textView becomeFirstResponder];
		[self addChildViewController:h14b];
		[self.mainView addSubview:h14b.view];
	}
    else if (tomq1.t1 == 15) {
        h15 = [self.storyboard instantiateViewControllerWithIdentifier:@"HealthQuestionnaire15"];
		h15.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
        //h15.textField.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q15"];
        if(([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_height"] length]>0)  && [[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] valueForKey:@"SecE_weight"] length]>0  ){
            h15.weightTF.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q15_weight"];
            h15.daysTF.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q15_days"];
        }
		[h15.weightTF becomeFirstResponder];
		[self addChildViewController:h15];
		[self.mainView addSubview:h15.view];
    }
    
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	tap.delegate = self;
	[self.view addGestureRecognizer:tap];
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
	[self hideKeyboard];
	NSLog(@"ENS Q3: %@, %@, %@", h3.beerTF.text, h3.wineTF.text, h3.wboTF.text);
	if (h3.beerTF.text == NULL)
		h3.beerTF.text = @"";
	if (h3.wineTF.text == NULL)
		h3.wineTF.text = @"";
	if (h3.wboTF.text == NULL)
		h3.wboTF.text = @"";
    
    
    if (h4.cigarettesPerDayTF.text == NULL)
		h4.cigarettesPerDayTF.text = @"";
	if (h4.pipePerDayTF.text == NULL)
		h4.pipePerDayTF.text = @"";
	if (h4.cigarPerDayTF.text == NULL)
		h4.cigarPerDayTF.text = @"";
    if (h4.eCigarPerDayTF.text == NULL)
		h4.eCigarPerDayTF.text = @"";
    
    
    
    
	NSLog(@"ENS2: %@", [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q1"]);
    BOOL UpdateData=YES;
	if ([[textFields trimWhiteSpaces:h1.textView1.text] isEqualToString:@""]) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 101;
		[alert show];
	}
	else if ([[textFields trimWhiteSpaces:h2.textView2.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 102;
		h2.textView2.text = @"";
		[alert show];
	}
    
    
    else if (([[textFields trimWhiteSpaces:h3.beerTF.text] isEqualToString:@""]) && ([[textFields trimWhiteSpaces:h3.wineTF.text] isEqualToString:@""]) && ([[textFields trimWhiteSpaces:h3.wboTF.text] isEqualToString:@""])) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"At least one answer is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1031;
		[alert show];
		
	}
    
    else if (([h3.beerTF.text intValue] < 1 && h3.beerTF.text.length != 0))
    {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Input must be integer greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[h4.cigarettesPerDayTF becomeFirstResponder];
		alert.tag = 1031;
		[alert show];
        UpdateData=NO;
	}
    
    
    
	else if ([h3.wineTF.text intValue] < 1 && h3.wineTF.text.length != 0)
    {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Input must be integer greater than zero" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[h14.textField becomeFirstResponder];
		alert.tag = 1032;
		[alert show];
        UpdateData=NO;
	}
    
    
	else if ([h3.wboTF.text intValue] < 1 && h3.wboTF.text.length != 0)
    {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Input must be integer greater than zero" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[h14.textField becomeFirstResponder];
		alert.tag = 1033;
		[alert show];
        UpdateData=NO;
	}
    
       
	else if ([[textFields trimWhiteSpaces:h4.cigarettesPerDayTF.text] isEqualToString:@""]&&[[textFields trimWhiteSpaces:h4.pipePerDayTF.text] isEqualToString:@""]&&[[textFields trimWhiteSpaces:h4.cigarPerDayTF.text] isEqualToString:@""]&&[[textFields trimWhiteSpaces:h4.eCigarPerDayTF.text] isEqualToString:@""])
        
    {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[h4.cigarettesPerDayTF becomeFirstResponder];
		alert.tag = 1041;
		[alert show];
        UpdateData=NO;
        //        if([[[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"POHQ"] valueForKey:@"SecE_weight"] length]<=0){
        //        h4.cigarettesPerDayTF.text = @"";
        //        }
	}
    //	else if (([h4.cigarettesPerDayTF.text intValue] < 1 && h4.cigarettesPerDayTF.text.length != 0)||([h4.pipePerDayTF.text intValue] < 1 && h4.pipePerDayTF.text.length != 0)||([h4.cigarPerDayTF.text intValue] < 1 && h4.cigarPerDayTF.text.length != 0)||([h4.eCigarPerDayTF.text intValue] < 1 && h4.eCigarPerDayTF.text.length != 0))
    //    {
    //		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Input must be integer greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //		//[h4.cigarettesPerDayTF becomeFirstResponder];
    //		alert.tag = 104;
    //		[alert show];
    //        UpdateData=NO;
    //	}
    
    else if ([h4.cigarettesPerDayTF.text intValue] < 1 && h4.cigarettesPerDayTF.text.length != 0)
    {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Input must be integer greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[h4.cigarettesPerDayTF becomeFirstResponder];
		alert.tag = 1041;
		[alert show];
        UpdateData=NO;
	}
    else if ([h4.pipePerDayTF.text intValue] < 1 && h4.pipePerDayTF.text.length != 0)
    {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Input must be integer greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[h4.cigarettesPerDayTF becomeFirstResponder];
		alert.tag = 1042;
		[alert show];
        UpdateData=NO;
	}
    
    else if ([h4.cigarPerDayTF.text intValue] < 1 && h4.cigarPerDayTF.text.length != 0)
    {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Input must be integer greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[h4.cigarettesPerDayTF becomeFirstResponder];
		alert.tag = 1043;
		[alert show];
        UpdateData=NO;
	}
    
    else if ([h4.eCigarPerDayTF.text intValue] < 1 && h4.eCigarPerDayTF.text.length != 0)
    {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Input must be integer greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[h4.cigarettesPerDayTF becomeFirstResponder];
		alert.tag = 1044;
		[alert show];
        UpdateData=NO;
	}
    
	
	else if ([[textFields trimWhiteSpaces:h5.textview.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 105;
		[alert show];
	}
	else if ([[textFields trimWhiteSpaces:h6.textView.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 106;
		h5.textview.text = @"";
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h7.textView.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 107;
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h7b.textView.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1072;
		h7.textView.text = @"";
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h7c.textView.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1073;
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h7d.textView.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1074;
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h7e.textView.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1075;
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h7f.textView.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1076;
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h7g.textView.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1077;
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h7h.textview.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1078;
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h7i.textView.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1079;
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h7j.textView.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 10710;
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h8.textView.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 108;
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h8b.textview.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1082;
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h8c.textView.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1083;
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h8d.textView.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1084;
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h8e.textView.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1085;
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h9.textview.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 109;
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h10.textview.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 110;
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h11.textview.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 111;
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h12.textview.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 112;
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h13.textView.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 113;
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h14b.textView.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1142;
		[alert show];
	}
	
	else if ([[textFields trimWhiteSpaces:h15.weightTF.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1151;
		[alert show];
	}
    
	else if ([[textFields trimWhiteSpaces:h15.daysTF.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1152;
		[alert show];
	}
	else if ([[textFields trimWhiteSpaces:h14.textField.text] isEqualToString:@""] && [[textFields trimWhiteSpaces:h14.monthsTF.text] isEqualToString:@""]){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the details for the selected Health Question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 114;
		[alert show];
	}
    
    
	else if (h14.textField.text.length != 0 && h14.monthsTF.text.length != 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please enter either weeks or months" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[h14.textField becomeFirstResponder];
		alert.tag = 114;
		[alert show];
        UpdateData=NO;
	}
	else if ([h14.textField.text intValue] < 1 && h14.textField.text.length != 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Pregnancy weeks must be greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[h14.textField becomeFirstResponder];
		alert.tag = 114;
		[alert show];
        UpdateData=NO;
	}
	else if ([h14.textField.text intValue] > 40  && h14.textField.text.length != 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Pregnancy weeks must not exceed 40" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[h14.textField becomeFirstResponder];
		alert.tag = 114;
		[alert show];
        UpdateData=NO;
	}
	else if ([h14.monthsTF.text intValue] < 1 && h14.monthsTF.text.length != 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Pregnancy month must be greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[h14.textField becomeFirstResponder];
		alert.tag = 1141;
		[alert show];
        UpdateData=NO;
	}
	else if ([h14.monthsTF.text intValue] > 10  && h14.monthsTF.text.length != 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Pregnancy month must not exceed 10." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[h14.textField becomeFirstResponder];
		alert.tag = 1141;
		[alert show];
        UpdateData=NO;
	}
	else if ([h15.weightTF.text intValue] < 1 && h15.weightTF.text.length != 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Height and weight must be greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[h15.weightTF becomeFirstResponder];
		alert.tag = 1151;
		[alert show];
	}
	else if ([h15.daysTF.text intValue] < 1 && h15.daysTF.text.length != 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Input must be integer greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[h15.daysTF becomeFirstResponder];
		alert.tag = 1152;
		[alert show];
	}
	
	else 
    {
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
		[self dismissModalViewControllerAnimated:YES];
	}
    
    
    //ky- Store Health details text in obj.eAppData
    if (![[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType]) {
        
        [[obj.eAppData objectForKey:@"SecE"] setValue:[NSMutableDictionary dictionary] forKey:self.LAType];
        
    }
    if(tomq1.t1 == 1)
    {
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h1.textView1.text forKey:@"Q1"];
    }
    
    else if(tomq1.t1 == 2)
    {
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h2.textView2.text forKey:@"Q2"];
    }
    
    else if(tomq1.t1 == 3)
    {
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h3.beerTF.text forKey:@"Q3_beerTF"];
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h3.wineTF.text forKey:@"Q3_wineTF"];
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h3.wboTF.text forKey:@"Q3_wboTF"];
    }
    
    else if (tomq1.t1 == 4) {
        if (UpdateData)
            //[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h4.cigarettesPerDayTF.text forKey:@"Q4"];
            [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h4.cigarettesPerDayTF.text forKey:@"Q4_cigarettesTF"];
            [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h4.pipePerDayTF.text forKey:@"Q4_pipeTF"];
            [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h4.cigarPerDayTF.text forKey:@"Q4_cigarTF"];
            [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h4.eCigarPerDayTF.text forKey:@"Q4_eCigarTF"];
    }
    
    
    else if(tomq1.t1 == 5)
    {
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h5.textview.text forKey:@"Q5"];
        
    }
    
    else if(tomq1.t1 == 6)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h6.textView.text forKey:@"Q6"];
    
    else if(tomq1.t1 == 71)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h7.textView.text forKey:@"Q7"];
    
    else if(tomq1.t1 == 72)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h7b.textView.text forKey:@"Q7b"];
    
    else if(tomq1.t1 == 73)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h7c.textView.text forKey:@"Q7c"];
    
    else if(tomq1.t1 == 74)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h7d.textView.text forKey:@"Q7d"];
    
    else if(tomq1.t1 == 75)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h7e.textView.text forKey:@"Q7e"];
    
    else if(tomq1.t1 == 76)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h7f.textView.text forKey:@"Q7f"];
    
    else if(tomq1.t1 == 77)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h7g.textView.text forKey:@"Q7g"];
    
    else if(tomq1.t1 == 78)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h7h.textview.text forKey:@"Q7h"];
    
    else if(tomq1.t1 == 79)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h7i.textView.text forKey:@"Q7i"];
    
    else if(tomq1.t1 == 710)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h7j.textView.text forKey:@"Q7j"];
    
    else if(tomq1.t1 == 81)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h8.textView.text forKey:@"Q8"];
    
    else if(tomq1.t1 == 82)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h8b.textview.text forKey:@"Q8b"];
    
    else if(tomq1.t1 == 83)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h8c.textView.text forKey:@"Q8c"];
    
    else if(tomq1.t1 == 84)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h8d.textView.text forKey:@"Q8d"];
    
    else if(tomq1.t1 == 85)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h8e.textView.text forKey:@"Q8e"];
    
    else if(tomq1.t1 == 9)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h9.textview.text forKey:@"Q9"];
    
    else if(tomq1.t1 == 10)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h10.textview.text forKey:@"Q10"];
    
    else if(tomq1.t1 == 11)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h11.textview.text forKey:@"Q11"];
    
    else if(tomq1.t1 == 12)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h12.textview.text forKey:@"Q12"];
    
    else if(tomq1.t1 == 13)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h13.textView.text forKey:@"Q13"];
    
    else if(tomq1.t1 == 141){
        if (UpdateData)
            
            [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h14.textField.text forKey:@"Q14"];
            [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h14.textField.text forKey:@"Q14_weeksTF"];
            [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h14.monthsTF.text forKey:@"Q14_monthsTF"];
        
    }
    
    else if(tomq1.t1 == 142)
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h14b.textView.text forKey:@"Q14b"];
    
    else if (tomq1.t1 == 15) {
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h15.weightTF.text forKey:@"Q15_weight"];
        [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:h15.daysTF.text forKey:@"Q15_days"];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 101) {
		[h1.textView1 becomeFirstResponder];
	}
	else if (alertView.tag == 102) {
        [h2.textView2 becomeFirstResponder];
    }
	else if (alertView.tag == 1031) {
        [h3.beerTF becomeFirstResponder];
    }
	else if (alertView.tag == 1032) {
        [h3.wineTF becomeFirstResponder];
    }
	else if (alertView.tag == 1033) {
        [h3.wboTF becomeFirstResponder];
    }
	else if (alertView.tag == 1041) {
        [h4.cigarettesPerDayTF becomeFirstResponder];
    }
    else if (alertView.tag == 1042) {
        [h4.pipePerDayTF becomeFirstResponder];
    }
    else if (alertView.tag == 1043) {
        [h4.cigarPerDayTF becomeFirstResponder];
    }
    else if (alertView.tag == 1044) {
        [h4.eCigarPerDayTF becomeFirstResponder];
    }

	else if (alertView.tag == 105) {
        [h5.textview becomeFirstResponder];
    }
	else if (alertView.tag == 106) {
        [h6.textView becomeFirstResponder];
    }
	else if (alertView.tag == 107) {
        [h7.textView becomeFirstResponder];
    }
	else if (alertView.tag == 1072) {
        [h7b.textView becomeFirstResponder];
    }
	else if (alertView.tag == 1073) {
        [h7c.textView becomeFirstResponder];
    }
	else if (alertView.tag == 1074) {
        [h7d.textView becomeFirstResponder];
    }
	else if (alertView.tag == 1075) {
        [h7e.textView becomeFirstResponder];
    }
	else if (alertView.tag == 1076) {
        [h7f.textView becomeFirstResponder];
    }
	else if (alertView.tag == 1077) {
        [h7g.textView becomeFirstResponder];
    }
	else if (alertView.tag == 1078) {
        [h7h.textview becomeFirstResponder];
    }
	else if (alertView.tag == 1079) {
        [h7i.textView becomeFirstResponder];
    }
	else if (alertView.tag == 10710) {
        [h7j.textView becomeFirstResponder];
    }
	else if (alertView.tag == 108) {
        [h8.textView becomeFirstResponder];
    }
	else if (alertView.tag == 1082) {
        [h8b.textview becomeFirstResponder];
    }
	else if (alertView.tag == 1083) {
        [h8c.textView becomeFirstResponder];
    }
	else if (alertView.tag == 1084) {
        [h8d.textView becomeFirstResponder];
    }
	else if (alertView.tag == 1085) {
        [h8e.textView becomeFirstResponder];
    }
	else if (alertView.tag == 109) {
        [h9.textview becomeFirstResponder];
    }
	else if (alertView.tag == 110) {
        [h10.textview becomeFirstResponder];
    }
	else if (alertView.tag == 111) {
        [h11.textview becomeFirstResponder];
    }
	else if (alertView.tag == 112) {
        [h12.textview becomeFirstResponder];
    }
	else if (alertView.tag == 113) {
        [h13.textView becomeFirstResponder];
    }
    else if (alertView.tag == 114) {
        [h14.textField becomeFirstResponder];
    }
	else if (alertView.tag == 1141) {
        [h14.monthsTF becomeFirstResponder];
    }
	else if (alertView.tag == 1142) {
        [h14b.textView becomeFirstResponder];
    }
	else if (alertView.tag == 1151) {
        [h15.weightTF becomeFirstResponder];
    }
	else if (alertView.tag == 1152) {
        [h15.daysTF becomeFirstResponder];
    }
	
}


- (IBAction)actionForCancel:(id)sender {
	
	if (tomq1.t1 == 1)
    {
		h1.textView1.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q1"];
		
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q1B"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q1B"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q1B"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
//	else if (tomq1.t1 == 2) {
//		h2.textView2.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q2"];
//		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
//			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q2"];
//		}
//		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
//			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q2"];
//		}
//		else {
//			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q2"];
//		}
//		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
//	}
	else if (tomq1.t1 == 3) {
        
        h3.beerTF.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q3_beerTF"];
		if ([h3.beerTF.text isEqualToString:@"0"]) {
			h3.beerTF.text = @"";
		}
        h3.wineTF.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q3_wineTF"];
		if ([h3.wineTF.text isEqualToString:@"0"]) {
			h3.wineTF.text = @"";
		}
        h3.wboTF.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q3_wboTF"];
		if ([h3.wboTF.text isEqualToString:@"0"]) {
			h3.wboTF.text = @"";
		}
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q3"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q3"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q3"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
    else if (tomq1.t1 == 4) {
        h4.cigarettesPerDayTF.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q4_cigarettesTF"];
		if ([h4.cigarettesPerDayTF.text isEqualToString:@"0"]) {
			h4.cigarettesPerDayTF.text = @"";
		}
        h4.pipePerDayTF.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q4_pipeTF"];        
		if ([h4.pipePerDayTF.text isEqualToString:@"0"]) {
			h4.pipePerDayTF.text = @"";
		}
        h4.cigarPerDayTF.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q4_cigarTF"];
		if ([h4.cigarPerDayTF.text isEqualToString:@"0"]) {
			h4.cigarPerDayTF.text = @"";
		}
        h4.eCigarPerDayTF.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q4_eCigarTF"];
		if ([h4.eCigarPerDayTF.text isEqualToString:@"0"]) {
			h4.eCigarPerDayTF.text = @"";
		}
        
    }
	else if (tomq1.t1 == 5) {
        h5.textview.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q5"];
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q5"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q5"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q5"];
		}
		
		if ([h5.textview.text isEqualToString:@""] && !([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"])){
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q5"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
//	else if (tomq1.t1 == 6) {
//        h6.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q6"];
//		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
//			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q6"];
//		}
//		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
//			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q6"];
//		}
//		else {
//			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q6"];
//		}
//		
//		if ([h6.textView.text isEqualToString:@""] && !([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"])){
//			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q6"];
//		}
//		
//		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
//	}
	else if (tomq1.t1 == 71) {
        h7.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q7"];
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q7A"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q7A"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q7A"];
		}
		
		if ([h7.textView.text isEqualToString:@""] && !([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"])){
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q7A"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
	else if (tomq1.t1 == 72) {
        h7b.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q7b"];
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q7B"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q7B"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q7B"];
		}
		
		if ([h7b.textView.text isEqualToString:@""] && !([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"])){
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q7B"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
	else if (tomq1.t1 == 73) {
        h7c.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q7c"];
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q7C"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q7C"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q7C"];
		}
		
		if ([h7c.textView.text isEqualToString:@""] && !([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"])){
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q7C"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
	else if (tomq1.t1 == 74) {
        h7d.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q7d"];
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q7D"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q7D"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q7D"];
		}
		
		if ([h7d.textView.text isEqualToString:@""] && !([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"])){
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q7D"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
	else if (tomq1.t1 == 75) {
        h7e.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q7e"];
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q7E"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q7E"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q7E"];
		}
		
		if ([h7e.textView.text isEqualToString:@""] && !([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"])){
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q7E"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
	else if (tomq1.t1 == 76) {
        h7f.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q7f"];
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q7F"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q7F"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q7F"];
		}
		
		if ([h7f.textView.text isEqualToString:@""] && !([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"])){
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q7F"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
	else if (tomq1.t1 == 77) {
        h7g.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q7g"];
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q7G"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q7G"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q7G"];
		}

		if ([h7g.textView.text isEqualToString:@""] && !([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"])){
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q7G"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
	else if (tomq1.t1 == 78) {
        h7h.textview.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q7h"];
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q7H"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q7H"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q7H"];
		}

		if ([h7h.textview.text isEqualToString:@""] && !([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"])){
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q7H"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
	else if (tomq1.t1 == 79) {
        h7i.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q7i"];
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q7I"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q7I"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q7I"];
		}

		if ([h7i.textView.text isEqualToString:@""] && !([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"])){
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q7I"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
	else if (tomq1.t1 == 710) {
        h7j.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q7j"];
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q7J"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q7J"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q7J"];
		}

		if ([h7j.textView.text isEqualToString:@""] && !([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"])){
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q7J"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
	else if (tomq1.t1 == 81) {
        h8.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q8"];
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q8A"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q8A"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q8A"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
	else if (tomq1.t1 == 82) {
        h8b.textview.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q8b"];
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q8B"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q8B"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q8B"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
	else if (tomq1.t1 == 83) {
        h8c.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q8c"];
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q8C"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q8C"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q8C"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
//	else if (tomq1.t1 == 84) {
//        h8d.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q8d"];
//		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
//			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q8D"];
//		}
//		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
//			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q8D"];
//		}
//		else {
//			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q8D"];
//		}
//		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
//	}
//	else if (tomq1.t1 == 85) {
//        h8e.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q8e"];
//		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
//			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q8E"];
//		}
//		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
//			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q8E"];
//		}
//		else {
//			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q8E"];
//		}
//		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
//	}
//	else if (tomq1.t1 == 9) {
//        h9.textview.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q9"];
//		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
//			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q9"];
//		}
//		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
//			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q9"];
//		}
//		else {
//			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q9"];
//		}
//		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
//	}
	else if (tomq1.t1 == 10) {
        h10.textview.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q10"];
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q10"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q10"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q10"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
	else if (tomq1.t1 == 11) {
        h11.textview.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q11"];
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q11"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q11"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q11"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
	else if (tomq1.t1 == 12) {
        h12.textview.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q12"];
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q12"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q12"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q12"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
	else if (tomq1.t1 == 13) {
        h13.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q13"];
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q13"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q13"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q13"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
	else if (tomq1.t1 == 141) {
        h14.textField.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q14"];
		if ([h14.textField.text isEqualToString:@"0"]) {
			h14.textField.text = @"";
		}
        h14.monthsTF.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q14_monthsTF"];
		if ([h14.monthsTF.text isEqualToString:@"0"]) {
			h14.monthsTF.text = @"";
		}
        
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q14A"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q14A"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q14A"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
	else if (tomq1.t1 == 142) {
        h14b.textView.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q14b"];
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q14B"];
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q14B"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q14B"];
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
	}
    else if (tomq1.t1 == 15) {
        h15.weightTF.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q15_weight"];
        h15.daysTF.text = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] objectForKey:@"Q15_days"];
		if ([h15.weightTF.text isEqualToString:@"0"]) {
			h15.weightTF.text = @"";
		}
		if ([h15.daysTF.text isEqualToString:@"0"]) {
			h15.daysTF.text = @"";
		}
		if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"N"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"N" forKey:@"SecE_Q15"];
			h15.weightTF.text = @"";
			h15.daysTF.text = @"";
		}
		else if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"OLD_VALUE"] isEqualToString:@"Y"]) {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"Y" forKey:@"SecE_Q15"];
		}
		else {
			[[[obj.eAppData objectForKey:@"SecE"] objectForKey:self.LAType] setValue:@"" forKey:@"SecE_Q15"];
			h15.weightTF.text = @"";
			h15.daysTF.text = @"";
		}
		[[obj.eAppData objectForKey:@"SecE"] setValue:@"" forKey:@"OLD_VALUE"];
		
    }
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"updateParent" object:nil];
	[self dismissViewControllerAnimated:YES completion:nil];
	
}

@end
