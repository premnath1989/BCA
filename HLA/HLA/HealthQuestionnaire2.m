//
//  HealthQuestionnaire2.m
//  iMobile Planner
//
//  Created by Erza on 7/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "HealthQuestionnaire2.h"
#import "ColorHexCode.h"
#import "DataClass.h"
#import <QuartzCore/QuartzCore.h>

@interface HealthQuestionnaire2 ()
{
    DataClass *obj;
}

@end

@implementation HealthQuestionnaire2
@synthesize delegate = _delegate;

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
    
    _textView2.delegate = self;
     obj = [DataClass getInstance];
    
    NSLog(@"itsCorrect");
    
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
    tohq2 = [TagObject tagObj];

    //Display data from obj
    NSString* text = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"Q2"];
    
    if(text != NULL || ![text isEqualToString:@""])
    //    self.textField2.text = text;
        self.textView2.text = text;
    
    [[self.textView2 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.textView2 layer] setBorderWidth:1.0];
    [[self.textView2 layer] setCornerRadius:0.1];

    
//	[_textField2 addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
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


- (void)textFieldDidEndEditing:(UITextField *)textField {
    tohq2.fd2 = textField.text;

}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    tohq2.fd2  = textView.text;
    NSLog(@"tohq %@",textView.text);
    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
    NSLog(@"detect changes");
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

- (IBAction)swipeNext2:(id)sender {
    [_delegate swipeToHQ3];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return ((newLength <= 250));
	
}



-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    
    if (textView == _textView2)
    {
        
		NSUInteger newLength = [textView.text length] + [text length] - range.length;
        
		return ((newLength <= 250));
	}
    return TRUE;
}


-(void)detectChanges:(id) sender
{
    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
}

- (void)viewDidUnload {
	[self setTextField2:nil];
    [self setTextView2:nil];
	[super viewDidUnload];
}
@end
