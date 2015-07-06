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
#import <QuartzCore/QuartzCore.h>


@interface HealthQuestionnaire ()
{
     DataClass *obj;
}

@end

@implementation HealthQuestionnaire
@synthesize delegate = _delegate;
@synthesize HealthQuestionsVC = _HealthQuestionsVC;



- (void)viewDidLoad
{
    
    _textView1.delegate = self;

    [super viewDidLoad];
     [[self.textView1 layer] setBorderColor:[[UIColor blackColor] CGColor]];
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
    
    NSLog(@"textTest %@",text);
  
    if(text != NULL || ![text isEqualToString:@""])
       // self.textField1.text = text;
        self.textView1.text =text;
    NSLog(@"textView1 %@",text);
	
//	[_textField1 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    
    [[self.textView1 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.textView1 layer] setBorderWidth:1.0];
    [[self.textView1 layer] setCornerRadius:0.1];
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,0,400,44)];
	tempView.backgroundColor=[UIColor clearColor];
	
	ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
	UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(60,0,400,44)];
	tempLabel.backgroundColor = [UIColor clearColor];
	tempLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:18];
    tempLabel.font = [UIFont boldSystemFontOfSize:18];
    tempLabel.textColor = [CustomColor colorWithHexString:@"234A7D"];

	//tempLabel.text=@"1st Life Assured";
	obj = [DataClass getInstance];
	tempLabel.text = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"PersonType"];
	[tempView addSubview:tempLabel];
	
	return tempView;
}

//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    	tohq1.fd1 = textField.text;
//	 
//}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    tohq1.fd1 = textView.text;
    NSLog(@"tohq %@",textView.text);
    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
    NSLog(@"detect changes");
    
}

- (void)btnDone:(id)sender
{
   // [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
    [self dismissModalViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//	NSUInteger newLength = [textField.text length] + [string length] - range.length;
//    return ((newLength <= 250));
//
//}

-(void)detectChanges:(id) sender
{
    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
}

-(void)detectChanges1:(id)sender
{
    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];   
}

- (void)viewDidUnload
{
	[self setTextField1:nil];
    [self setTextView1:nil];
    [super viewDidUnload];
}

- (IBAction)swipeNext:(id)sender {
    [_delegate swipeToHQ2];
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
   
    
    if (textView == _textView1)
    {
        
		NSUInteger newLength = [textView.text length] + [text length] - range.length;
        
		return ((newLength <= 250));
	}
    
}


- (IBAction)endEditing:(id)sender {
	//NSLog(@"what: %@", _textField1.text);
	tohq1.fd1 = _textField1.text;
    tohq1.fd1 = _textView1.text;
    
}


@end
