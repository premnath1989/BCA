//
//  FormViewController.m
//  iMobile Planner
//
//  Created by Administrator on 1/18/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import "FormViewController.h"
#import "ColorHexCode.h"

@interface FormViewController ()

@end

@implementation FormViewController
@synthesize outletWebView,fileName,fileTitle,FromCardSnap;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"fileName %@",[self.fileName description]);
	
    NSString *pdfFile = [NSString stringWithFormat:@"%@",[self.fileName description]];
    
    //NSString *path = [[NSBundle mainBundle] pathForResource:pdfFile ofType:@"pdf"];
    NSURL *targetURL = [NSURL fileURLWithPath:pdfFile];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [outletWebView setScalesPageToFit:YES];
    [outletWebView loadRequest:request];
    
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
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [button addTarget:self
//               action:@selector(aMethod)
//     forControlEvents:UIControlEventTouchUpInside];
//    [button setTitle:@"Show View" forState:UIControlStateNormal];
//    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
//     [self.view addSubview:button];
    
    if ([FromCardSnap isEqualToString:@"CardSnap"])
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(1.0, 1.0, 30.0, 30.0)];
        [button setImage:[UIImage imageNamed:@"x5.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(aMethod) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    
    
	
	fileName = Nil;
	fileTitle = Nil;
	label = Nil;
	targetURL = Nil;
	//path = Nil;
	pdfFile = Nil;
	request = Nil;
	CustomColor = Nil;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
    else{
        return  NO;
    }
    
}

-(void)aMethod
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [self setOutletWebView:nil];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewDidUnload];
}

- (void)viewWillDisappear:(BOOL)animated
{
    eAppReport *viewController = [[eAppReport alloc]
                                           init];
    [viewController removeGenerateButton];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
   // [viewController release];
}


@end
