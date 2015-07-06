//
//  HealthQuestionnaire3.m
//  iMobile Planner
//
//  Created by Erza on 7/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "HealthQuestionnaire3.h"
#import "ColorHexCode.h"
#import "DataClass.h"

@interface HealthQuestionnaire3 ()
{
    DataClass *obj;
}

@end

@implementation HealthQuestionnaire3

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    obj = [DataClass getInstance];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
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
    self.navigationItem.titleView = label;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnDone:)];
    tohq3 = [TagObject tagObj];
//	[_outsideTF setUserInteractionEnabled:NO];
    
    //Display data from obj
    
    NSString* text1 = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"Q3_beerTF"];
    NSString* text2 = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"Q3_wineTF"];
    NSString* text3 = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"Q3_wboTF"];
    
    if(text1 != NULL || ![text1 isEqualToString:@""])
        self.beerTF.text = text1;
    if(text2 != NULL || ![text2 isEqualToString:@""])
        self.wineTF.text = text2;
    if(text3 != NULL || ![text3 isEqualToString:@""])
        self.wboTF.text = text3;
}

- (void)btnDone:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	if (textField == _beerTF) {
		tohq3.fd3b = textField.text;
	}
	else if (textField == _wineTF) {
		tohq3.fd3w = textField.text;
	}
	else if (textField == _wboTF) {
		tohq3.fd3wbo = textField.text;
	}
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	BOOL editable;
	if (textField == _ftf) {
		NSLog(@"outside");
		editable = NO;
	}
	else{
		NSLog(@"inside");
		editable = YES;
	}
	return  editable;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBeerTF:nil];
    [self setWineTF:nil];
    [self setWboTF:nil];
	[self setFtf:nil];
    [super viewDidUnload];
}
@end
