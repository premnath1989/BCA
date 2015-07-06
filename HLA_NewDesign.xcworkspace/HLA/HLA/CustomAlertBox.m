//
//  CustomAlertBox.m
//  iMobile Planner
//
//  Created by kuan on 11/13/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "CustomAlertBox.h"
#import "ColorHexCode.h"

@interface CustomAlertBox ()

@end

@implementation CustomAlertBox

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
}
- (IBAction)ActionOK:(id)sender {
    
   
   
  //  [self dismissViewControllerAnimated:TRUE completion:Nil];
    
    [self dismissViewControllerAnimated:TRUE completion:^{
       
        if(checkedAgree)
            [self.delegate AgreeFlag:@"Y"];
        else
            [self.delegate AgreeFlag:@"N"];
    }];
    
    
    
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
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
}


- (IBAction)checkBoxAgree:(id)sender
{
    checkedAgree = !checkedAgree;
    
    if(checkedAgree)
    {
        [_btnagree setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        _btnok.enabled = TRUE;
        _btnok.titleLabel.textColor = [UIColor blackColor];
        
    }
    else
    {
         [_btnagree setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
          _btnok.enabled  = FALSE;
         _btnok.titleLabel.textColor = [UIColor grayColor];
        
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
 
@end
