//
//  eBrochureViewController.m
//  HLA Ipad
//
//  Created by infoconnect on 1/16/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "eBrochureViewController.h"
#import "ColorHexCode.h"
#import <QuartzCore/QuartzCore.h>

@interface eBrochureViewController ()

@end

@implementation eBrochureViewController
@synthesize outletWebview,fileName,fileTitle;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"amireallyComingHere");
    
    

	
    NSString *pdfFile = [NSString stringWithFormat:@"%@",[self.fileName description]];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:pdfFile ofType:@"pdf"];
    NSURL *targetURL = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [outletWebview setScalesPageToFit:YES];
    [outletWebview loadRequest:request];
    
    if ([pdfFile isEqualToString:@"Nominee & Trustee Guideline"])
    {
        UINavigationBar *myBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 1080, 50)];
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        [self.view addSubview:myBar];
        
               
        UIImage* imageChat = [UIImage imageNamed:@"CloseButton.png"];
        CGRect frameimg = CGRectMake(10, 3,75, 41);
        UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
        someButton.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [someButton setTitle:@"Close" forState:UIControlStateNormal];
        [someButton setBackgroundImage:imageChat forState:UIControlStateNormal];
        [someButton addTarget:self action:@selector(CloseViewController)
             forControlEvents:UIControlEventTouchUpInside];
        [someButton setShowsTouchWhenHighlighted:YES];
        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(10, 3, 70,30);
//        [btn setTitle:@"Close" forState:UIControlStateNormal];
//        [btn setBackgroundColor:[UIColor colorWithRed:.196 green:0.3098 blue:0.52 alpha:1.0]];
//        btn.frame = CGRectMake(10.0, 3.0, 70, 40.0);//width and height should be same value
//        btn.clipsToBounds = YES;
//        
//        [btn addTarget:self
//                   action:@selector(CloseViewController)
//         forControlEvents:UIControlEventTouchUpInside];
//
//        
//        btn.layer.cornerRadius = 5;//half of the width
//        btn.layer.borderColor=[UIColor blueColor].CGColor;
//        btn.layer.borderWidth=2.0f;
        [self.view addSubview:someButton];
        
        ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
        
        CGRect frame = CGRectMake(340, 0, 400, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
        label.font = [UIFont boldSystemFontOfSize:20];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [CustomColor colorWithHexString:@"234A7D"];
        label.text =@"Nominee & Trustee Guidelines";
        [myBar addSubview:label];
    }
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = [NSString stringWithFormat:@"%@",[self.fileTitle description]];
    self.navigationItem.titleView = label;
	
	fileName = Nil;
	fileTitle = Nil;
	label = Nil;
	targetURL = Nil;
	path = Nil;
	pdfFile = Nil;
	request = Nil;
	CustomColor = Nil;
}

-(void)CloseViewController
{
    [self dismissModalViewControllerAnimated:YES];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
    else{
        return  NO;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [self setOutletWebview:nil];
    [super viewDidUnload];
}
@end
