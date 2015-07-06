//
//  HealthQuestionnaire14.m
//  iMobile Planner
//
//  Created by Erza on 7/30/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "HealthQuestionnaire14.h"
#import "DataClass.h" 
#import "ColorHexCode.h"

@interface HealthQuestionnaire14 ()
{
    DataClass *obj;
}

@end

@implementation HealthQuestionnaire14

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

	_textField.delegate = self;
	
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //Display data from obj
	
    NSString* text = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"Q14"];
    NSString* text1 = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"Q14_weeksTF"];
    NSString* text2 = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"Q14_monthsTF"];
    
    
    
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.monthsTF.keyboardType = UIKeyboardTypeNumberPad;
    
    if(text != NULL || ![text isEqualToString:@""])
        self.textField.text = text;
    if(text1 != NULL || ![text1 isEqualToString:@""])
        self.textField.text = text1;
    if(text2 != NULL || ![text2 isEqualToString:@""])
        self.monthsTF.text = text2;
    
    
	[_textField addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_monthsTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];

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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	BOOL editable;
	if (textField == _outsideTF) {
		editable = NO;
	}
	else{
		editable = YES;
	}
	return  editable;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	NSUInteger newLength = [textField.text length] + [string length] - range.length;
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
	NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
	return (([string isEqualToString:filtered])&&(newLength <= 2));
	
}

-(void)detectChanges:(id) sender
{
    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
}

- (void)viewDidUnload {
    [self setTextField:nil];
    [self setOutsideTF:nil];
    [self setMonthsTF:nil];
    [super viewDidUnload];
}
@end
