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

#define CHARACTER_LIMIT 70

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
    
    _line.textColor = [UIColor blackColor];
    _line2.textColor = [UIColor blackColor];
    obj=[DataClass getInstance];
    
    
    if ([[[obj.CFFData objectForKey:@"SecA"] objectForKey:@"Disclosure"] isEqualToString:@"1"]){
        [checkButton setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        [checkButton2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        checked = YES;
        checked2 = NO;
        textDisclosure.enabled = NO;
        _txtDisclosure2.enabled = NO;
        textDisclosure.text = @"";
        _txtDisclosure2.text = @"";
        checkButton.selected = TRUE;
        checkButton2.selected = FALSE;
        textDisclosure.placeholder = @"Company Name";
    }
    else{
        [checkButton setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        [checkButton2 setImage:[UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        checked = NO;
        checked2 = YES;
        textDisclosure.enabled = YES;
        _txtDisclosure2.enabled = YES;
        checkButton.selected = FALSE;
        checkButton2.selected = TRUE;
        textDisclosure.text = [[obj.CFFData objectForKey:@"SecA"] objectForKey:@"BrokerName"];
        [self textFieldDidEndEditing:textDisclosure];
    }
    
    textDisclosure.delegate = self;
    _txtDisclosure2.delegate = self;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	tap.delegate = self;
	[self.view addGestureRecognizer:tap];
    
}

-(void)hideKeyboard{
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // Disallow recognition of tap gestures in the button.
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
    _txtDisclosure2.enabled = NO;
    textDisclosure.text = @"";
    _txtDisclosure2.text = @"";
    textDisclosure.placeholder = @"Company Name";
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
    _txtDisclosure2.enabled = YES;
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

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == textDisclosure) {
        if (textField.text.length <= 26) {
            // do nothing
        }
        else {
            NSArray *str = [textField.text componentsSeparatedByString:@" "];
            int total = 0;
            int index = 0;
            textField.text = @"";
            for (NSString *s in str) {
                total += s.length + 1;
                if (total <= 26) {
                    textField.text = [NSString stringWithFormat:@"%@ %@", textField.text, s];
                    index++;
                }
            }
            if (textField.text.length > 0) {
                textField.text = [textField.text substringFromIndex:1];
            }
            for (int i = index; i < [str count]; i++) {
                _txtDisclosure2.text = [NSString stringWithFormat:@"%@ %@", _txtDisclosure2.text, [str objectAtIndex:i]];
            }
        }
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (textField == textDisclosure) {
        textDisclosure.text = @"";
        _txtDisclosure2.text = @"";
        return NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == _txtDisclosure2) {
        [_txtDisclosure2 resignFirstResponder];
        [textDisclosure performSelector:@selector(becomeFirstResponder)
                        withObject:nil
                             afterDelay:0.1f];
    }
    else {
        textDisclosure.text = [NSString stringWithFormat:@"%@%@", textDisclosure.text, _txtDisclosure2.text];
        _txtDisclosure2.text = @"";
    }
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
        [[obj.CFFData objectForKey:@"SecA"] setValue:[NSString stringWithFormat:@"%@ %@", textDisclosure.text, _txtDisclosure2.text] forKey:@"BrokerName"];
    }
    //NSLog(@"%@",textDisclosure.text);
//    [[obj.CFFData objectForKey:@"CFF"] setValue:@"0" forKey:@"CFFSave"];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength <= CHARACTER_LIMIT);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *title = @"*Standard disclosure statement applicable depends on the type of intermediary (Please tick where appropriate).";
    
    //Create label with Section Title
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(40, 0, 600, 50);
    label.textColor = [UIColor blackColor];
    label.font = [UIFont italicSystemFontOfSize:16.0];
    label.numberOfLines = 2;
    label.text = title;
    label.backgroundColor = [UIColor clearColor];
    
    // Create header view and add label as a subview
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(40, 0, 600, 100)];
    [view addSubview:label];
    
    return view;
}
- (void)viewDidUnload {
    [self setTxtDisclosure2:nil];
    [self setLine:nil];
    [self setLine2:nil];
    [super viewDidUnload];
}
@end
