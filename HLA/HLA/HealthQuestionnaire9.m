//
//  HealthQuestionnaire9.m
//  iMobile Planner
//
//  Created by Erza on 7/30/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "HealthQuestionnaire9.h"
#import "DataClass.h"   
#import "ColorHexCode.h"
#import <QuartzCore/QuartzCore.h>
@interface HealthQuestionnaire9 ()
{
    DataClass *obj;
}

@end

@implementation HealthQuestionnaire9

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     obj = [DataClass getInstance];
    _textview.delegate = self;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Display data from obj
    NSString* text = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"Q9"];
    
    if(text != NULL || ![text isEqualToString:@""])
        self.textview.text = text;
    
    [[self.textview layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.textview layer] setBorderWidth:1.0];
    [[self.textview layer] setCornerRadius:0.1];
	
	[_textField addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];

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

-(void)textViewDidEndEditing:(UITextView *)textView
{
    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
    NSLog(@"detect changes");
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    
    if (textView == _textview)
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload {
    [self setTextField:nil];
    [self setTextview:nil];
    [super viewDidUnload];
}
@end
