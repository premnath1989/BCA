//
//  TableCheckBox.m
//  eAppScreen
//
//  Created by Erza on 7/5/13.
//  Copyright (c) 2013 IFC. All rights reserved.
//

#import "TableCheckBox.h"
#import "ColorHexCode.h"
#import "DataClass.h"

@interface TableCheckBox (){
    DataClass *obj;
}

@end

@implementation TableCheckBox
@synthesize checkButton2;
@synthesize checkButton;
@synthesize textDisclosure;


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
    checked = NO;
    checked2 = NO;
    
    
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
    
    UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    [textDisclosure setLeftViewMode:UITextFieldViewModeAlways];
    [textDisclosure setLeftView:spacerView];
    
    
    obj=[DataClass getInstance];
    
    
    if ([[[obj.CFFData objectForKey:@"SecA"] objectForKey:@"Disclosure"] isEqualToString:@"1"]){
        [checkButton setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        [checkButton2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        checked = YES;
        checked2 = NO;
        textDisclosure.enabled = NO;
        textDisclosure.text = @"";
        checkButton.selected = TRUE;
        checkButton2.selected = FALSE;
    }
    else{
        [checkButton setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        [checkButton2 setImage:[UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        checked = NO;
        checked2 = YES;
        textDisclosure.enabled = YES;
        checkButton.selected = FALSE;
        checkButton2.selected = TRUE;
        textDisclosure.text = [[obj.CFFData objectForKey:@"SecA"] objectForKey:@"BrokerName"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnDone:(id)sender
{
    
}

//



- (IBAction)CheckBoxButton:(id)sender
{
    [checkButton setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
    [checkButton2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    checked = YES;
    checked2 = NO;
    textDisclosure.enabled = NO;
    [[obj.CFFData objectForKey:@"SecA"] setValue:@"1" forKey:@"Disclosure"];
    [[obj.CFFData objectForKey:@"SecA"] setValue:@"" forKey:@"BrokerName"];
    [[obj.CFFData objectForKey:@"SecA"] setValue:@"1" forKey:@"Completed"];
    checkButton.selected = TRUE;
    checkButton2.selected = FALSE;
    
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
    
    //UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3000];
    //imageView.hidden = FALSE;
    //imageView = nil;

}
- (IBAction)checkboxButton2:(id)sender
{
    [checkButton2 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
    [checkButton setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    checked2 = YES;
    checked = NO;
    textDisclosure.enabled = YES;
    [textDisclosure becomeFirstResponder];
    [[obj.CFFData objectForKey:@"SecA"] setValue:@"2" forKey:@"Disclosure"];
    checkButton.selected = FALSE;
    checkButton2.selected = TRUE;
    //self.parentViewController.view
    
    if ([textDisclosure.text isEqualToString:@""]){
        //UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3000];
        //imageView.hidden = TRUE;
        //imageView = nil;
        [[obj.CFFData objectForKey:@"SecA"] setValue:@"0" forKey:@"Completed"];
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}
- (IBAction)txtDisclosure:(id)sender {
    
}

- (IBAction)txtDisclosureEditChanged:(id)sender {
    if ([textDisclosure.text isEqualToString:@""]){
        //UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3000];
        //imageView.hidden = TRUE;
        //imageView = nil;
        [[obj.CFFData objectForKey:@"SecA"] setValue:@"0" forKey:@"Completed"];
    }
    else{
        //UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3000];
        //imageView.hidden = FALSE;
        //imageView = nil;
        [[obj.CFFData objectForKey:@"SecA"] setValue:@"1" forKey:@"Completed"];
        [[obj.CFFData objectForKey:@"SecA"] setValue:textDisclosure.text forKey:@"BrokerName"];
    }
    //NSLog(@"%@",textDisclosure.text);
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"0" forKey:@"CFFSave"];
}
@end
