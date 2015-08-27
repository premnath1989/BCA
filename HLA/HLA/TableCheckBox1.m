//
//  TableCheckBox.m
//  eAppScreen
//
//  Created by Erza on 7/5/13.
//  Copyright (c) 2013 IFC. All rights reserved.
//

#import "TableCheckBox1.h"
#import "ColorHexCode.h"
#import "DataClass.h"

#define CHARACTER_LIMIT 70

@interface TableCheckBox1 (){
    DataClass *obj;
}

@end

@implementation TableCheckBox1
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
	
	obj=[DataClass getInstance];
	
	NSString *StringName =[NSString stringWithFormat:@"%@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerSmoker"]];
	NSString *StringName2 =[NSString stringWithFormat:@"%@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerSex"]];
	NSString *StringName3 =[NSString stringWithFormat:@"%@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerDOB"]];
	
	
	if([StringName isEqualToString:@"N"])
	{
		[_SmokingStatus setSelectedSegmentIndex:1];
		_SmokingStatus.enabled = FALSE;
	}
	else
	{
		[_SmokingStatus setSelectedSegmentIndex:0];
		_SmokingStatus.enabled = FALSE;
	}
	
	if([StringName2 isEqualToString:@"MALE"])
	{
		[_Gender setSelectedSegmentIndex:0];
		_Gender.enabled = FALSE;
	}
	else
	{
		[_Gender setSelectedSegmentIndex:1];
		_Gender.enabled = FALSE;
	}
	
	
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"dd/MM/yyyy"];
	NSDate *date = [dateFormat dateFromString:StringName3];
	
//	// Convert date object to desired output format
//	[dateFormat setDateFormat:@"EEEE MMMM d, YYYY"];
//	StringName3= [dateFormat stringFromDate:date];
	
	
//	NSDate* birthday = ;
//	
	NSDate* now = [NSDate date];
	NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
									   components:kCFCalendarUnitYear
									   fromDate:date
									   toDate:now
									   options:0];
	NSInteger age = [ageComponents year];
	
	//_Age.text == age;
	
	[_Age setText:[NSString stringWithFormat:@"%i",age]];
	
	
	
	NSString *stringElementAttach_Disability65 = [NSString stringWithFormat:@"%@ %@",[NSString stringWithFormat:@"%i",age+10],@"%"];
	[_Disability65 setText:stringElementAttach_Disability65];
	
	NSString *stringElementAttach_CriticalIlness65 = [NSString stringWithFormat:@"%@ %@",[NSString stringWithFormat:@"%i",age+16],@"%"];
	[_CriticalIlness65 setText:stringElementAttach_CriticalIlness65];
	
	NSString *stringElementAttach_dying65 = [NSString stringWithFormat:@"%@ %@",[NSString stringWithFormat:@"%i",age+19],@"%"];
	[_dying65 setText:stringElementAttach_dying65];
	
	NSString *stringElementAttach_Probability = [NSString stringWithFormat:@"%@ %@",[NSString stringWithFormat:@"%i",age+14],@"%"];
	[_Probability setText:stringElementAttach_Probability];
	
	
	[_Plan setSelectedSegmentIndex:-1];
	
	   
	

    
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
    NSString *title = @"  Check Customer Risk";
    
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
