//
//  CustomAlertBox.m
//  iMobile Planner
//
//  Created by kuan on 11/13/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "CustomAlertBox.h"
#import "ColorHexCode.h"
#import "ProspectViewController.h"
#import "WebViewViewController.h"
#import "eBrochureViewController.h"

@interface CustomAlertBox ()

@end

@implementation CustomAlertBox
@synthesize changetext,AlertProspect,AlertProspectGoIn,WebViewViewController;
@synthesize ProspectViewController = _ProspectViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)Actionclose:(id)sender
{
	
	
    [self dismissViewControllerAnimated:YES completion:nil];
	
//	ProspectViewController *test =[[ProspectViewController alloc]init];
//	[test testing];
	
	if (AlertProspect)
	{
//		[ProspectViewController.view removeFromSuperview];
//        [self.view removeFromSuperview];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"returnProspect" object:nil];
		[self resignFirstResponder];
        
        NSLog(@"iwantremove");

	}
	else
	{
		[self.delegate AgreeFlag:@"C"]; 
	}
    
       
    
}
- (IBAction)ActionOK:(id)sender {
    
   
   
  //  [self dismissViewControllerAnimated:TRUE completion:Nil];
	
	if(AlertProspect)
	{
		AlertProspectGoIn =YES;
		
		
		[self dismissViewControllerAnimated:TRUE completion:Nil];
		
			
	}
    else{
    [self dismissViewControllerAnimated:TRUE completion:^{
       
        if(checkedAgree)
			
            [self.delegate AgreeFlag:@"Y"];
        else
            [self.delegate AgreeFlag:@"N"];
    }];
    
    }
    
    
    
}
- (void)viewDidLoad
{
   
	// Do any additional setup after loading the view.
    
    
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
   // self.navigationItem.titleView = label;
    
   // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnDone:)];
    checkedAgree = FALSE;
     _btnok.enabled  = FALSE;
    _btnok.titleLabel.textColor = [UIColor grayColor];
    
    if (changetext) {
        _textLabel.text=@"You are to disclose in this proposal form fully and faithfully all the facts that you know or ought to know. You shall be subject to such duty of disclosure at all times, including during the application of this coverage, changes made to the coverage and during the renewal of this coverage.   \n                                                                                                                                          CONFIRMATION OF E-APPLICATION: I hereby confirm and agree that I had authorized my agent to submit my application through E-application. By so doing, I/we understand that I/we had confirmed the contents in the electronic proposal for assurance therein and any other electronically submitted/ hardcopy form(s) and/or questionnaires submitted to the Company.";
		
		_CloseProspect.hidden =YES;
           
    }
	
	else if (AlertProspect)
	{
		
		
		
		
		UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(210, 97,130,50)];
		fromLabel.text = @"(www.bcalife.co.id)";
		fromLabel.numberOfLines = 1;
		fromLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
		fromLabel.adjustsFontSizeToFitWidth = YES;
		fromLabel.adjustsLetterSpacingToFitWidth = YES;
		//fromLabel.minimumScaleFactor = 10.0f/12.0f;
		fromLabel.clipsToBounds = YES;
		fromLabel.backgroundColor = [UIColor clearColor];
		fromLabel.textColor = [UIColor blueColor];
		fromLabel.textAlignment = NSTextAlignmentLeft;
		[_textLabel addSubview:fromLabel];
		
		_textLabel.text =@"PERSONAL DATA - BCA Life (\"BCA/we/us/our\") safeguards your personal data in accordance with the applicable laws in Malaysia. BCA uses personal data in accordance with the BCA Notice on Personal Data as set out in BCA's website                                which may be amended from time to time (\"Notice on Personal Data\"). The Notice on Personal Data explains the data collection purposes, the persons to whom BCA may transfer data to, your rights to access and correct your data and how you may contact BCA's Data Protection Officer.";
		
		UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textTapped)];
		tapGestureRecognizer.numberOfTapsRequired = 1;
		[fromLabel addGestureRecognizer:tapGestureRecognizer];
		fromLabel.userInteractionEnabled = YES;
		
		
		
//		UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//		[button addTarget:self
//				   action:@selector(textTapped)
//		 forControlEvents:UIControlEventTouchUpInside];
//		[button setTitle:@"" forState:UIControlStateNormal];
//		button.frame = CGRectMake(351, 147,140,30);
//		button.alpha =1.0;
//
//		[self.view addSubview:button];

		
	//	_btnagree.alpha =0;
	//	_btnNotOk.alpha =0;
	//	_btnok.alpha =0;
		//_textLabel.hidden =YES;
	//	_DEclarationTxt.hidden = YES;
		_CloseProspect.hidden =YES;
		
		
	}
    else{
//        _textLabel.text=@"You are to disclose in this proposal form fully and faithfully all the facts that you know or ought to know, otherwise the Policy issued hereunder may be invalidated.                                                                                                                Anda adalah dikehendaki memberi segala maklumat dan fakta yang anda tahu atau sepatutnya tahu dengan sepenuhnya dan dengan ikhlas, jika tidak, Polisi yang dikeluarkan mungkin tidah sah.";
        _textLabel.text=@"You are to disclose in this proposal form fully and faithfully all the facts that you know or ought to know, otherwise the Policy issued hereunder may be invalidated.";
        
        CGRect frame = _textLabel.frame;
        frame.origin.y=-20;//pass the cordinate which you want
       // frame.origin.x= 12;//pass the cordinate which you want
        _textLabel.frame= frame;
        
        
        CGRect frame1 = _btnagree.frame;
        frame1.origin.y=190;//pass the cordinate which you want
        // frame.origin.x= 12;//pass the cordinate which you want
        _btnagree.frame= frame1;
            
        CGRect frame2 = _btnok.frame;
        frame2.origin.y=260;//pass the cordinate which you want
        // frame.origin.x= 12;//pass the cordinate which you want
        _btnok.frame= frame2;

        
        CGRect frame3 = _btnNotOk.frame;
        frame3.origin.y=260;//pass the cordinate which you want
        // frame.origin.x= 12;//pass the cordinate which you want
        _btnNotOk.frame= frame3;
        
        CGRect frame4 = _DEclarationTxt.frame;
        frame4.origin.y=185;//pass the cordinate which you want
        // frame.origin.x= 12;//pass the cordinate which you want
        _DEclarationTxt.frame= frame4;
		
		_CloseProspect.hidden =YES;


        
      
        
    }
}

-(void)textTapped
{
	//[self dismissViewControllerAnimated:YES completion:nil];
//	WebViewViewController *controller=[[WebViewViewController alloc]init];
//	[self.navigationController presentModalViewController:controller animated:YES];
	
	
	WebViewViewController *controller = [[WebViewViewController alloc]
												  initWithNibName:@"WebViewViewController"
												  bundle:nil];
	//controller.delegate = self;
	controller.modalPresentationStyle = UIModalPresentationPageSheet;
	[self presentViewController:controller animated:YES completion:Nil];
	
	
}

- (IBAction)checkBoxAgree:(id)sender
{
    checkedAgree = !checkedAgree;
    
    if(checkedAgree)
    {
        [_btnagree setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        _btnok.enabled = TRUE;
        _btnok.titleLabel.textColor = [UIColor blackColor];
        _btnNotOk.hidden =YES;
        
    }
    else
    {
         [_btnagree setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
          _btnok.enabled  = FALSE;
         _btnok.titleLabel.textColor = [UIColor grayColor];
        _btnNotOk.hidden =NO;
        
    }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}
 
- (void)viewDidUnload {
    [self setBtnNotOk:nil];
    [self setDEclarationTxt:nil];
    [super viewDidUnload];
}
- (IBAction)CloseProspect:(id)sender {
	
	
	[self dismissViewControllerAnimated:YES completion:nil];
	
//	self.ProspectViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Prospect"];
//    _ProspectViewController.delegate = self;
//    [self.navigationController pushViewController:_ProspectViewController animated:YES];
//    _ProspectViewController.navigationItem.title = @"Add Client Profile";

}
@end
