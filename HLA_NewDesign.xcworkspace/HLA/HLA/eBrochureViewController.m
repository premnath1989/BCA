//
//  eBrochureViewController.m
//  HLA Ipad
//
//  Created by infoconnect on 1/16/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "eBrochureViewController.h"
#import "ColorHexCode.h"

@interface eBrochureViewController ()

@end

@implementation eBrochureViewController
@synthesize outletWebview,fileName,fileTitle;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSString *pdfFile = [NSString stringWithFormat:@"%@",[self.fileName description]];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:pdfFile ofType:@"pdf"];
    NSURL *targetURL = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [outletWebview setScalesPageToFit:YES];
    [outletWebview loadRequest:request];
    
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
