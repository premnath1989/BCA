//
//  HealthQuestionnaire.m
//  iMobile Planner
//
//  Created by Erza on 6/18/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "HealthQuestionnaire.h"
#import "ColorHexCode.h"
#import "DataClass.h"


@interface HealthQuestionnaire ()
{
     DataClass *obj;
}

@end

@implementation HealthQuestionnaire
@synthesize delegate = _delegate;



- (void)viewDidLoad
{
    [super viewDidLoad];
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
    label.text = @"Lifestyle Questions";
    self.navigationItem.titleView = label;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnDone:)];
    tohq1 = [TagObject tagObj];

    obj = [DataClass getInstance];

    //Display data from obj
    NSString* text = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"Q1"];
  
    if(text != NULL || ![text isEqualToString:@""])
        self.textField1.text = text;
 
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    	tohq1.fd1 = textField.text;
	
}

 
- (void)btnDone:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
	[self setTextField1:nil];
    [super viewDidUnload];
}

- (IBAction)swipeNext:(id)sender {
    [_delegate swipeToHQ2];
    
}

- (IBAction)endEditing:(id)sender {
	//NSLog(@"what: %@", _textField1.text);
	tohq1.fd1 = _textField1.text;
}


@end
