//
//  Declare.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "Declare.h"
#import "ColorHexCode.h"
#import "DataClass.h"

#define CHARACTER_LIMIT200 200
#define CHARACTER_LIMIT70 70

@interface Declare (){
    DataClass *obj;
}

@end

@implementation Declare

@synthesize btn1;
@synthesize btn2;

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
    
     obj=[DataClass getInstance];
    
    _IntermediaryCode.text = [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCode"];
    
    _NameOfIntermediary.text = [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"NameOfIntermediary"];
    
    _IntermediaryCodeContractDate.text = [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCodeContractDate"];
    
    _NameOfManager.text = [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"NameOfManager"];
    
    _IntermediaryNRIC.text = [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryNRIC"];
    
    _IntermediaryAddress1.text = [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress1"];
    _IntermediaryAddress2.text = [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress2"];
    _IntermediaryAddress3.text = [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress3"];
    _IntermediaryAddress4.text = [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryAddress4"];
    _IntermediaryPostcode.text = [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryPostcode"];
    _IntermediaryTown.text = [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryTown"];
    _IntermediaryState.text = [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryState"];
    _IntermediaryCountry.text = [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"IntermediaryCountry"];
    
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    [fmtDate setDateFormat:@"dd/MM/yyyy"];
    NSDate *startDate = [fmtDate dateFromString:self.IntermediaryCodeContractDate.text];
    NSString *textDate = [NSString stringWithFormat:@"%@",[fmtDate stringFromDate:[NSDate date]]];
    NSDate *endDate = [fmtDate dateFromString:textDate];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];
    int day = [components day];
    // check if its leap year
    fmtDate = nil;
    fmtDate = [[NSDateFormatter alloc] init];
    [fmtDate setDateFormat:@"YYYY"];
    int currentYear = [[fmtDate stringFromDate:[NSDate date]] intValue];
    
    if (((currentYear % 4 == 0) && (currentYear % 100 != 0)) || (currentYear % 400 == 0)) {
        if (day > 366) {
            _NameOfManager.enabled = FALSE;
        }
        else {
            _NameOfManager.enabled = TRUE;
        }
    }
    else {
        if (day > 365) {
            _NameOfManager.enabled = FALSE;
        }
        else {
            _NameOfManager.enabled = TRUE;
        }
    }
    
    if ([[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"CustomerAcknowledgement"] isEqualToString:@"0"]){
        [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        select1 = NO;
        select2 = NO;
        self.selected = @"0";
    }
    else if ([[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"CustomerAcknowledgement"] isEqualToString:@"1"]){
        [btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        select1 = YES;
        select2 = NO;
        self.selected = @"1";
    }
    else if ([[[obj.CFFData objectForKey:@"SecH"] objectForKey:@"CustomerAcknowledgement"] isEqualToString:@"2"]){
        [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        [btn2 setImage:[UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        select1 = NO;
        select2 = YES;
        self.selected = @"2";
    }
    _AdditionalComment.text = [[obj.CFFData objectForKey:@"SecH"] objectForKey:@"AdditionalComment"];
    
    _AdditionalComment.delegate = self;
    _NameOfManager.delegate = self;

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	
	[self.view addGestureRecognizer:tap];
    
}

-(void)hideKeyboard{
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewDidUnload {
    [self setBtn1:nil];
    [self setBtn2:nil];
    [self setIntermediaryCode:nil];
    [self setNameOfIntermediary:nil];
    [self setIntermediaryNRIC:nil];
    [self setIntermediaryCodeContractDate:nil];
    [self setIntermediaryAddress1:nil];
    [self setIntermediaryAddress2:nil];
    [self setIntermediaryAddress3:nil];
    [self setAdditionalComment:nil];
    [self setNameOfManager:nil];
    [self setIntermediaryAddress4:nil];
    [self setIntermediaryPostcode:nil];
    [self setIntermediaryTown:nil];
    [self setIntermediaryState:nil];
    [self setIntermediaryCountry:nil];
    [super viewDidUnload];
}

- (IBAction)clickBtn1:(id)sender {
	[btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    select1 = YES;
    select2 = NO;
    self.selected = @"1";
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}

- (IBAction)clickBtn2:(id)sender {
	[btn2 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    select2 = YES;
    select1 = NO;
    self.selected = @"2";
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}

- (IBAction)IntermediaryCodeContractDateAction:(id)sender {
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}

- (IBAction)IntermediaryAddress1Action:(id)sender {
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}
- (IBAction)NameOfMangerAction:(id)sender {
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _NameOfManager) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return ((newLength <= CHARACTER_LIMIT70));
    }
    return FALSE;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (textView == _AdditionalComment) {
        NSUInteger newLength = [textView.text length] + [text length] - range.length;
        return ((newLength <= CHARACTER_LIMIT200));
    }
    return FALSE;
}
@end
