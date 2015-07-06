//
//  CustomerChoice.m
//  eAppScreen
//
//  Created by Erza on 7/5/13.
//  Copyright (c) 2013 IFC. All rights reserved.
//

#import "CustomerChoice.h"
#import "ColorHexCode.h"
#import "DataClass.h"

#import "MasterMenuCFF.h"

@interface CustomerChoice (){
     DataClass *obj;
}

@end

@implementation CustomerChoice
@synthesize checkboxButton1;
@synthesize checkboxButton2;
@synthesize checkboxButton3;


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
    checked3 = NO;
    checked2 = NO;
    checked1 = NO;
	
	ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"Customer Fact Find";
    self.navigationItem.titleView = label;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnDone:)];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    obj=[DataClass getInstance];
    
    
    
    if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"1"]){
        [checkboxButton1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        [checkboxButton2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        [checkboxButton3 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        checked1 = YES;
        checked2 = NO;
        checked3 = NO;
        checkboxButton1.selected = TRUE;
        checkboxButton2.selected = FALSE;
        checkboxButton3.selected = FALSE;
    }
    else if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"2"]){
        [checkboxButton2 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        [checkboxButton1 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        [checkboxButton3 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        checked1 = NO;
        checked2 = YES;
        checked3 = NO;
        checkboxButton1.selected = FALSE;
        checkboxButton2.selected = TRUE;
        checkboxButton3.selected = FALSE;
    }
    else if ([[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"3"]){
        [checkboxButton3 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        [checkboxButton2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        [checkboxButton1 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        checked1 = NO;
        checked2 = NO;
        checked3 = YES;
        checkboxButton1.selected = FALSE;
        checkboxButton2.selected = FALSE;
        checkboxButton3.selected = TRUE;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)checkButton1:(id)sender {
    [checkboxButton1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
    [checkboxButton2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
     [checkboxButton3 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    checked1 = YES;
    checked2 = NO;
    checked3 = NO;
    checkboxButton1.selected = TRUE;
    checkboxButton2.selected = FALSE;
    checkboxButton3.selected = FALSE;
    [[obj.CFFData objectForKey:@"SecB"] setValue:@"1" forKey:@"ClientChoice"];
    
    //UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3001];
    //imageView.hidden = FALSE;
    //imageView = nil;
    [[obj.CFFData objectForKey:@"SecB"] setValue:@"1" forKey:@"Completed"];
    
    MasterMenuCFF *parent = (MasterMenuCFF *) self.parentViewController;
    
    UITableViewCell * cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    //special
    //if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.userInteractionEnabled = YES;
    //}
    //else{
    //    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    //    cell.textLabel.textColor = [UIColor grayColor];
    //    cell.userInteractionEnabled = NO;
    //}
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    parent = nil;
    cell = nil;
    
    //hack
    UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3002];
    imageView.hidden = FALSE;
    imageView = nil;
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
    
}
- (IBAction)checkButton2:(id)sender {
    [checkboxButton2 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
    [checkboxButton1 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    [checkboxButton3 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    checked1 = NO;
    checked2 = YES;
    checked3 = NO;
    checkboxButton1.selected = FALSE;
    checkboxButton2.selected = TRUE;
    checkboxButton3.selected = FALSE;
    [[obj.CFFData objectForKey:@"SecB"] setValue:@"2" forKey:@"ClientChoice"];
    
    //UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3001];
    //imageView.hidden = FALSE;
    //imageView = nil;
    [[obj.CFFData objectForKey:@"SecB"] setValue:@"1" forKey:@"Completed"];
    
    MasterMenuCFF *parent = (MasterMenuCFF *) self.parentViewController;
    
    UITableViewCell * cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    //special
    //if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"Completed"] isEqualToString:@"1"]){
        cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.userInteractionEnabled = YES;
    //}
    //else{
    //    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    //    cell.textLabel.textColor = [UIColor grayColor];
    //    cell.userInteractionEnabled = NO;
    //}
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    parent = nil;
    cell = nil;
    
    //hack
    UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3002];
    imageView.hidden = FALSE;
    imageView = nil;
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}
- (IBAction)checkButton3:(id)sender {
    [checkboxButton3 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
    [checkboxButton2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    [checkboxButton1 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    checked1 = NO;
    checked2 = NO;
    checked3 = YES;
    checkboxButton1.selected = FALSE;
    checkboxButton2.selected = FALSE;
    checkboxButton3.selected = TRUE;
    [[obj.CFFData objectForKey:@"SecB"] setValue:@"3" forKey:@"ClientChoice"];
    
    //UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3001];
    //imageView.hidden = FALSE;
    //imageView = nil;
    [[obj.CFFData objectForKey:@"SecB"] setValue:@"1" forKey:@"Completed"];
    
    MasterMenuCFF *parent = (MasterMenuCFF *) self.parentViewController;
    
    UITableViewCell * cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    //special
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.userInteractionEnabled = NO;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:8 inSection:0]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.userInteractionEnabled = YES;
    
    parent = nil;
    cell = nil;
    
    //hack
    UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3002];
    imageView.hidden = FALSE;
    imageView = nil;
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
    
    [[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"1" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"1" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"1" forKey:@"Completed"];
    [[obj.CFFData objectForKey:@"SecFSavings"] setValue:@"1" forKey:@"Completed"];
}
@end
