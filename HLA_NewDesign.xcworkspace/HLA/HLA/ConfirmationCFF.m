//
//  ConfirmationCFF.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ConfirmationCFF.h"
#import "ColorHexCode.h"
#import "ExistingProductRecommended.h"
#import "ProductRecommended.h"
#import "DataClass.h"

@interface ConfirmationCFF (){
    DataClass *obj;
}

@end

@implementation ConfirmationCFF

@synthesize btn1;
@synthesize btn2;
@synthesize btn3;
@synthesize btn4;
@synthesize btn5;
@synthesize btn6;

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
    
    if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice1"] isEqualToString:@"0"]){
        [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice1 = @"0";
    }
    else{
        [btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        self.Advice1 = @"-1";
    }

    if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice2"] isEqualToString:@"0"]){
        [btn2 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice2 = @"0";
    }
    else{
        [btn2 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        self.Advice2 = @"-1";
    }
    
    if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice3"] isEqualToString:@"0"]){
        [btn3 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice3 = @"0";
    }
    else{
        [btn3 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        self.Advice3 = @"-1";
    }

    if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice4"] isEqualToString:@"0"]){
        [btn4 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice4 = @"0";
    }
    else{
        [btn4 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        self.Advice4 = @"-1";
    }
    
    if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice5"] isEqualToString:@"0"]){
        [btn5 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice5 = @"0";
    }
    else{
        [btn5 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        self.Advice5 = @"-1";
    }
    
    if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice6"] isEqualToString:@"0"]){
        [btn6 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice6 = @"0";
        _othersField.editable = false;
    }
    else{
        [btn6 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        self.Advice6 = @"-1";
        _othersField.editable = true;
    }
    
    _othersField.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice6Others"];




    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)clickBtn1:(id)sender {
	btn1.selected = !btn1.selected;
	if (btn1.selected) {
		[btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        self.Advice1 = @"-1";
	}
	else {
		[btn1 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice1 = @"0";
	}
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (IBAction)clickBtn2:(id)sender {
	btn2.selected = !btn2.selected;
	if (btn2.selected) {
		[btn2 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        self.Advice2 = @"-1";
	}
	else {
		[btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice2 = @"0";
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (IBAction)clickBtn3:(id)sender {
	btn3.selected = !btn3.selected;
	if (btn3.selected) {
		[btn3 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        self.Advice3 = @"-1";
    }
	else {
		[btn3 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice3 = @"0";
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (IBAction)clickBtn4:(id)sender {
	btn4.selected = !btn4.selected;
	if (btn4.selected) {
		[btn4 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        self.Advice4 = @"-1";
    }
	else {
		[btn4 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice4 = @"0";
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (IBAction)clickBtn5:(id)sender {
	btn5.selected = !btn5.selected;
	if (btn5.selected) {
		[btn5 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        self.Advice5 = @"-1";
    }
	else {
		[btn5 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice5 = @"0";
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (IBAction)clickBtn6:(id)sender {
	btn6.selected = !btn6.selected;
	if (btn6.selected) {
		[btn6 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        _othersField.editable = true;
        self.Advice5 = @"-1";
    }
	else {
		[btn6 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        _othersField.editable = false;
        _othersField.text = @"";
        self.Advice5 = @"0";
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = self.storyboard;
    
	if (indexPath.section == 1 && [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"RecommendedSI"] isEqualToString:@"1"]){
		ProductRecommended *productRecommended = [storyboard instantiateViewControllerWithIdentifier:@"ProductRecommended"];
        productRecommended.rowToUpdate = indexPath.row;
        productRecommended.SIProduct = 1;
        productRecommended.delegate = self;
		[self presentViewController:productRecommended animated:YES completion:nil];
	}
    
    if (indexPath.section == 1){
        if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5){
            ProductRecommended *productRecommended = [storyboard instantiateViewControllerWithIdentifier:@"ProductRecommended"];
            productRecommended.rowToUpdate = indexPath.row;
            productRecommended.SIProduct = 0;
            productRecommended.delegate = self;
            [self presentViewController:productRecommended animated:YES completion:nil];
        }
    }
}

-(void)ExistingProductRecommendedDelete:(ExistingProductRecommended *)controller rowToUpdate:(int)rowToUpdate{
    if (rowToUpdate == 1){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended1"];
        _product1.text = [NSString stringWithFormat:@"Recommended Product (1)"];
    }
    else if (rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended2"];
        _product2.text = [NSString stringWithFormat:@"Recommended Product (2)"];
    }
    else if (rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended3"];
        _product3.text = [NSString stringWithFormat:@"Recommended Product (3)"];
    }
    else if (rowToUpdate == 4){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended4"];
        _product4.text = [NSString stringWithFormat:@"Recommended Product (4)"];
    }
    else if (rowToUpdate == 5){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended5"];
        _product5.text = [NSString stringWithFormat:@"Recommended Product (5)"];
    }
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

-(void)ExistingProductRecommendedUpdate:(ExistingProductRecommended *)controller rowToUpdate:(int)rowToUpdate{    
    if (rowToUpdate == 1){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"1" forKey:@"ExistingRecommended1"];
        _product1.text = [NSString stringWithFormat:@"Name of Insured: %@",controller.NameOfInsured.text];
    }
    else if (rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"1" forKey:@"ExistingRecommended2"];
        _product2.text = [NSString stringWithFormat:@"Name of Insured: %@",controller.NameOfInsured.text];
    }
    else if (rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"1" forKey:@"ExistingRecommended3"];
        _product3.text = [NSString stringWithFormat:@"Name of Insured: %@",controller.NameOfInsured.text];
    }
    if (rowToUpdate == 4){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"1" forKey:@"ExistingRecommended4"];
        _product4.text = [NSString stringWithFormat:@"Name of Insured: %@",controller.NameOfInsured.text];
    }
    if (rowToUpdate == 5){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"1" forKey:@"ExistingRecommended5"];
        _product5.text = [NSString stringWithFormat:@"Name of Insured: %@",controller.NameOfInsured.text];
    }
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)viewDidUnload {
	[self setBtn1:nil];
	[self setBtn2:nil];
	[self setBtn3:nil];
	[self setBtn4:nil];
	[self setBtn5:nil];
	[self setBtn6:nil];
    [self setOthersField:nil];
    [self setProductSI:nil];
    [self setProduct1:nil];
    [self setProduct5:nil];
    [super viewDidUnload];
}

@end
