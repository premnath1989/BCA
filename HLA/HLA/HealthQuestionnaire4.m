//
//  HealthQuestionnaire4.m
//  iMobile Planner
//
//  Created by Erza on 3/11/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import "HealthQuestionnaire4.h"
#import "DataClass.h"
#import "ColorHexCode.h"

@interface HealthQuestionnaire4 () {
    DataClass *obj;
}

@end

@implementation HealthQuestionnaire4

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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
    tohq4 = [TagObject tagObj];
    
    //Display data from obj
//    NSString* text = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"Q4"];
    NSString* text1 = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"Q4_cigarettesTF"];
    NSString* text2 = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"Q4_pipeTF"];
    NSString* text3 = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"Q4_cigarTF"];
    NSString* text4 = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"Q4_eCigarTF"];
    
	_cigarettesPerDayTF.keyboardType = UIKeyboardTypeNumberPad;
	_pipePerDayTF.keyboardType = UIKeyboardTypeNumberPad;
	_cigarPerDayTF.keyboardType = UIKeyboardTypeNumberPad;
	_eCigarPerDayTF.keyboardType = UIKeyboardTypeNumberPad;
    
    if(text1 != NULL || ![text1 isEqualToString:@""])
        self.cigarettesPerDayTF.text = text1;
    if(text2 != NULL || ![text2 isEqualToString:@""])
        self.pipePerDayTF.text = text2;
    if(text3 != NULL || ![text3 isEqualToString:@""])
        self.cigarPerDayTF.text = text3;
    if(text4 != NULL || ![text4 isEqualToString:@""])
        self.eCigarPerDayTF.text = text4;
    
    
//    if(text != NULL || ![text isEqualToString:@""])
//        self.cigarettesPerDayTF.text = text;
    
    
	[_cigarettesPerDayTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_pipePerDayTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_cigarPerDayTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_eCigarPerDayTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
    
    
//    _cigarettesPerDayTF.delegate = self;
//	_cigarettesPerDayTF.keyboardType = UIKeyboardTypeNumberPad;
//	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
//	tap.cancelsTouchesInView = NO;
//	tap.numberOfTapsRequired = 1;
//	tap.delegate = self;
//	[self.view addGestureRecognizer:tap];
	
//	[_cigarettesPerDayTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
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


-(void)hideKeyboard{
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UITextField class]] ||
        [touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCigarettesPerDayTF:nil];
    [self setPipePerDayTF:nil];
    [self setCigarPerDayTF:nil];
    [self setECigarPerDayTF:nil];
    [super viewDidUnload];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//	if (textField == _cigarettesPerDayTF)
//    {
//		tohq3.fd3b = textField.text;
//	}
//	else if (textField == _pipePerDayTF) {
//		tohq3.fd3w = textField.text;
//	}
//	else if (textField == _cigarPerDayTF) {
//		tohq3.fd3wbo = textField.text;
//	}
//    
//    else if (textField == _eCigarPerDayTF) {
//		tohq3.fd3wbo = textField.text;
//	}

}


#define NUMBERS_ONLY @"1234567890"
#define CHARACTER_LIMIT 2

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
//    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//    return [string isEqualToString:filtered];
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    if (textField == _cigarettesPerDayTF)
    {
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT));
    }
    if (textField == _pipePerDayTF)
    {
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT));
    }
    if (textField == _cigarPerDayTF)
    {
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT));
    }
    if (textField == _eCigarPerDayTF)
    {
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT));
    }
}

-(void)detectChanges:(id) sender
{
    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"];
}

@end
