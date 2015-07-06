//
//  HealthQuestionnaire15.m
//  iMobile Planner
//
//  Created by Erza on 7/30/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "HealthQuestionnaire15.h"
#import "DataClass.h"
#import "ColorHexCode.h"

@interface HealthQuestionnaire15 () {
    DataClass *obj;
}

@end

@implementation HealthQuestionnaire15

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
    tohq15 = [TagObject tagObj];
    //	[_outsideTF setUserInteractionEnabled:NO];
    
	
	[_weightTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
	[_daysTF addTarget:self action:@selector(detectChanges:) forControlEvents:UIControlEventEditingChanged];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	obj = [DataClass getInstance];
    
    
    //Display data from obj
    
//    NSString* text1 = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"Q15_weight"];
//    NSString* text2 = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"Q15_days"];
	NSString *LAType;
	
	if ([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"PersonType"] isEqualToString:@"1st Life Assured"]) {
		LAType = @"LA1HQ";
	}

	NSString* text1 = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:LAType] objectForKey:@"Q15_weight"];
    NSString* text2 = [[[obj.eAppData objectForKey:@"SecE"] objectForKey:LAType]  objectForKey:@"Q15_days"];
	
    
    if(text1 != NULL || ![text1 isEqualToString:@""])
        self.weightTF.text = text1;
    if(text2 != NULL || ![text2 isEqualToString:@""])
        self.daysTF.text = text2;
    
    _weightTF.delegate = self;
    _daysTF.delegate = self;
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


//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
//    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//    return [string isEqualToString:filtered];
//}

#define NUMBERS_ONLY @"1234567890"
#define NUMBERS_ONLY_With_Dot @"1234567890."
#define CHARACTER_LIMIT 4

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    //    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    //    return [string isEqualToString:filtered];
    
    if(textField == _daysTF)
    {
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
            return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT));
    }

    if (textField == _weightTF)
    {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY_With_Dot] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if ([self doesString:textField.text containCharacter:'.'])
			return (([string isEqualToString:filtered])&&(newLength <= 3));
		else
			return (([string isEqualToString:filtered])&&(newLength <= 3));
    }
}

-(BOOL)doesString:(NSString *)string containCharacter:(char)character
{
    if ([string rangeOfString:[NSString stringWithFormat:@"%c",character]].location != NSNotFound)
    {
        return YES;
    }
    return NO;
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
    [self setWeightTF:nil];
    [self setDaysTF:nil];
    [super viewDidUnload];
}
@end
