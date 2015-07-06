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
    [super viewDidUnload];
}

- (IBAction)clickBtn1:(id)sender {
	[btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    select1 = YES;
    select2 = NO;
    self.selected = @"1";
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (IBAction)clickBtn2:(id)sender {
	[btn2 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    select2 = YES;
    select1 = NO;
    self.selected = @"2";
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (IBAction)IntermediaryCodeContractDateAction:(id)sender {
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (IBAction)IntermediaryAddress1Action:(id)sender {
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}
- (IBAction)NameOfMangerAction:(id)sender {
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}
@end
