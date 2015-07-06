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
#import "AppDelegate.h"
#define CHARACTER_LIMIT200 200

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
    [self.navigationItem.rightBarButtonItem.customView setAlpha:0.0];
    if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice1"] isEqualToString:@"0"]){
        [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice1 = @"0";
    }
    else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice1"] isEqualToString:@"-1"]){
        [btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        self.Advice1 = @"-1";
    }
    else {
        [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice1 = @"0";
    }

    if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice2"] isEqualToString:@"0"]){
        [btn2 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice2 = @"0";
    }
    else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice2"] isEqualToString:@"-1"]){
        [btn2 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        self.Advice2 = @"-1";
    }
    else {
        [btn2 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice2 = @"0";
    }
    
    if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice3"] isEqualToString:@"0"]){
        [btn3 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice3 = @"0";
    }
    else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice3"] isEqualToString:@"-1"]){
        [btn3 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        self.Advice3 = @"-1";
    }
    else {
        [btn3 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice3 = @"0";
    }

    if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice4"] isEqualToString:@"0"]){
        [btn4 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice4 = @"0";
    }
    else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice4"] isEqualToString:@"-1"]){
        [btn4 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        self.Advice4 = @"-1";
    }
    else {
        [btn4 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice4 = @"0";
    }
    
    if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice5"] isEqualToString:@"0"]){
        [btn5 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice5 = @"0";
    }
    else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice5"] isEqualToString:@"-1"]){
        [btn5 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        self.Advice5 = @"-1";
    }
    else {
        [btn5 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice5 = @"0";
    }
    
    if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice6"] isEqualToString:@"0"]){
        [btn6 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice6 = @"0";
        _othersField.editable = false;
    }
    else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice6"] isEqualToString:@"-1"]){
        [btn6 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        self.Advice6 = @"-1";
        _othersField.editable = true;
    }
    else {
        [btn6 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        self.Advice6 = @"0";
        _othersField.editable = false;
    }
    
    _othersField.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Advice6Others"];
    _othersField.delegate = self;

    [self initialUpdate];
    
    
    //basvi added
    AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    if(!MenuOption.eApp)
    {
    
    _productSI.text =@"Product Recommended (Populate from Sales Illustration)";
    _productSI.textColor = [UIColor grayColor];
        
    _productSI2.text=@"Product Recommended (Populate from Sales Illustration)";
    _productSI2.textColor = [UIColor grayColor];
    }
    
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
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
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
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
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
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
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
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
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
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}

- (IBAction)clickBtn6:(id)sender {
	btn6.selected = !btn6.selected;
	if (btn6.selected) {
		[btn6 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        _othersField.editable = true;
        self.Advice6 = @"-1";
    }
	else {
		[btn6 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        _othersField.editable = false;
        _othersField.text = @"";
        self.Advice6 = @"0";
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = self.storyboard;
    AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    
	if (indexPath.section == 1 ){
        if ((indexPath.row == 1 || indexPath.row ==0) &&!isAutoSelect && MenuOption.eApp)
        {
		ProductRecommended *productRecommended = [storyboard instantiateViewControllerWithIdentifier:@"ProductRecommended"];
            
            ProductRecommended* pdfViewController = (ProductRecommended *)[self.presentedViewController nextResponder];
            pdfViewController.navigationItem.rightBarButtonItem.enabled=YES;
            
            productRecommended.rowToUpdate = indexPath.row;
            productRecommended.SIProduct = 1;
            productRecommended.cellRghtbuttonDisabled =@"disable";
            productRecommended.delegate = self;
            
            
          //  [productRecommended.rightbutton setEnabled:NO];
		[self presentViewController:productRecommended animated:YES completion:nil];
            
        }
        
        if ( indexPath.row ==0 &&isAutoSelect && MenuOption.eApp)
        {
            ProductRecommended *productRecommended = [storyboard instantiateViewControllerWithIdentifier:@"ProductRecommended"];
            
            ProductRecommended* pdfViewController = (ProductRecommended *)[self.presentedViewController nextResponder];
            pdfViewController.navigationItem.rightBarButtonItem.enabled=YES;
            
            productRecommended.rowToUpdate = indexPath.row;
            productRecommended.SIProduct = 1;
            productRecommended.cellRghtbuttonDisabled =@"disable";
            productRecommended.delegate = self;
            
            
            //  [productRecommended.rightbutton setEnabled:NO];
            [self presentViewController:productRecommended animated:YES completion:nil];
            
            
            
        }
        
        if (indexPath.row == 1 &&isAutoSelect && MenuOption.eApp)
        {
            ProductRecommended *productRecommended = [storyboard instantiateViewControllerWithIdentifier:@"ProductRecommended"];
            
            ProductRecommended* pdfViewController = (ProductRecommended *)[self.presentedViewController nextResponder];
            pdfViewController.navigationItem.rightBarButtonItem.enabled=YES;
            
            productRecommended.rowToUpdate = indexPath.row;
            productRecommended.SIProduct = 1;
            productRecommended.cellRghtbuttonDisabled =@"disable";
            productRecommended.delegate = self;
            
            
            //  [productRecommended.rightbutton setEnabled:NO];
           // [self presentViewController:productRecommended animated:YES completion:nil];
            
            
            
        }

        
        if(indexPath.row == 2 ){
            ProductRecommended *productRecommended = [storyboard instantiateViewControllerWithIdentifier:@"ProductRecommended"];
            
            productRecommended.rowToUpdate = indexPath.row;
            productRecommended.SIProduct = 1;
            productRecommended.delegate = self;
           // productRecommended.cellRghtbuttonDisabled =@"disable";
            [productRecommended.rightbutton setEnabled:NO];
            
           
            
            [self presentViewController:productRecommended animated:YES completion:nil];
            productRecommended.navigationItem.rightBarButtonItem.enabled=NO;

            
        }
	}
    
    if (indexPath.section == 1){
        if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please add product(s) recommended in sequence." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            if (indexPath.row == 3) {
                if (![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended1"] isEqualToString:@"1"] && ![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended2"] isEqualToString:@"1"]) {
                    [alert show];
                    
                   
                    return;
                }
            }
            else if (indexPath.row == 4) {
                if ((![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended1"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended2"] isEqualToString:@"1"]) && ![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended3"] isEqualToString:@"1"]) {
                    [alert show];
                    return;
                }
            }
            else if (indexPath.row == 5) {
                if ((![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended1"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended2"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended3"] isEqualToString:@"1"]) && ![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended4"] isEqualToString:@"1"]) {
                    [alert show];
                    return;
                }
            }
            else if (indexPath.row == 6) {
                if ((![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended1"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended2"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended3"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended4"] isEqualToString:@"1"]) && ![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended5"] isEqualToString:@"1"]) {
                    [alert show];
                    return;
                }
            }
         
            ProductRecommended *productRecommended = [storyboard instantiateViewControllerWithIdentifier:@"ProductRecommended"];
            productRecommended.rowToUpdate = indexPath.row;
            productRecommended.SIProduct = 0;
            productRecommended.delegate = self;
            [productRecommended.rightbutton setEnabled:NO];
            [self presentViewController:productRecommended animated:YES completion:nil];
        }
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = self.storyboard;
    AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    
	if (indexPath.section == 1 ){
        if ((indexPath.row == 1 || indexPath.row ==0) &&!isAutoSelect && MenuOption.eApp)
        {
            ProductRecommended *productRecommended = [storyboard instantiateViewControllerWithIdentifier:@"ProductRecommended"];
            
            ProductRecommended* pdfViewController = (ProductRecommended *)[self.presentedViewController nextResponder];
            pdfViewController.navigationItem.rightBarButtonItem.enabled=YES;
            
            productRecommended.rowToUpdate = indexPath.row;
            productRecommended.SIProduct = 1;
            productRecommended.cellRghtbuttonDisabled =@"disable";
            productRecommended.delegate = self;
            
            
            //  [productRecommended.rightbutton setEnabled:NO];
            [self presentViewController:productRecommended animated:YES completion:nil];
            
        }
        
        if ( indexPath.row ==0 &&isAutoSelect && MenuOption.eApp)
        {
            ProductRecommended *productRecommended = [storyboard instantiateViewControllerWithIdentifier:@"ProductRecommended"];
            
            ProductRecommended* pdfViewController = (ProductRecommended *)[self.presentedViewController nextResponder];
            pdfViewController.navigationItem.rightBarButtonItem.enabled=YES;
            
            productRecommended.rowToUpdate = indexPath.row;
            productRecommended.SIProduct = 1;
            productRecommended.cellRghtbuttonDisabled =@"disable";
            productRecommended.delegate = self;
            
            
            //  [productRecommended.rightbutton setEnabled:NO];
            [self presentViewController:productRecommended animated:YES completion:nil];
            
            
            
        }
        
        if (indexPath.row == 1 &&isAutoSelect && MenuOption.eApp)
        {
            ProductRecommended *productRecommended = [storyboard instantiateViewControllerWithIdentifier:@"ProductRecommended"];
            
            ProductRecommended* pdfViewController = (ProductRecommended *)[self.presentedViewController nextResponder];
            pdfViewController.navigationItem.rightBarButtonItem.enabled=YES;
            
            productRecommended.rowToUpdate = indexPath.row;
            productRecommended.SIProduct = 1;
            productRecommended.cellRghtbuttonDisabled =@"disable";
            productRecommended.delegate = self;
            
            
            //  [productRecommended.rightbutton setEnabled:NO];
            // [self presentViewController:productRecommended animated:YES completion:nil];
            
            
            
        }
        
        
        if(indexPath.row == 2 ){
            ProductRecommended *productRecommended = [storyboard instantiateViewControllerWithIdentifier:@"ProductRecommended"];
            
            productRecommended.rowToUpdate = indexPath.row;
            productRecommended.SIProduct = 1;
            productRecommended.delegate = self;
            // productRecommended.cellRghtbuttonDisabled =@"disable";
            [productRecommended.rightbutton setEnabled:NO];
            
            
            
            [self presentViewController:productRecommended animated:YES completion:nil];
            productRecommended.navigationItem.rightBarButtonItem.enabled=NO;
            
            
        }
	}
    
    if (indexPath.section == 1){
        if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please add product(s) recommended in sequence." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            if (indexPath.row == 3) {
                if (![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended1"] isEqualToString:@"1"] && ![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended2"] isEqualToString:@"1"]) {
                    [alert show];
                    return;
                }
            }
            else if (indexPath.row == 4) {
                if ((![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended1"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended2"] isEqualToString:@"1"]) && ![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended3"] isEqualToString:@"1"]) {
                    [alert show];
                    return;
                }
            }
            else if (indexPath.row == 5) {
                if ((![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended1"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended2"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended3"] isEqualToString:@"1"]) && ![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended4"] isEqualToString:@"1"]) {
                    [alert show];
                    return;
                }
            }
            else if (indexPath.row == 6) {
                if ((![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended1"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended2"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended3"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended4"] isEqualToString:@"1"]) && ![[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended5"] isEqualToString:@"1"]) {
                    [alert show];
                    return;
                }
            }
            
            ProductRecommended *productRecommended = [storyboard instantiateViewControllerWithIdentifier:@"ProductRecommended"];
            productRecommended.rowToUpdate = indexPath.row;
            productRecommended.SIProduct = 0;
            productRecommended.delegate = self;
            [self presentViewController:productRecommended animated:YES completion:nil];
        }
    }
}

-(void)ExistingProductRecommendedDelete:(ExistingProductRecommended *)controller rowToUpdate:(int)rowToUpdate{
    if (rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended1"];
        _product1.text = [NSString stringWithFormat:@"Recommended Product (1)"];
    }
    else if (rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended2"];
        _product2.text = [NSString stringWithFormat:@"Recommended Product (2)"];
    }
    else if (rowToUpdate == 4){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended3"];
        _product3.text = [NSString stringWithFormat:@"Recommended Product (3)"];
    }
    else if (rowToUpdate == 5){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended4"];
        _product4.text = [NSString stringWithFormat:@"Recommended Product (4)"];
    }
    else if (rowToUpdate == 6){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"0" forKey:@"ExistingRecommended5"];
        _product5.text = [NSString stringWithFormat:@"Recommended Product (5)"];
    }
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

-(void)ExistingProductRecommendedUpdate:(ExistingProductRecommended *)controller rowToUpdate:(int)rowToUpdate{
    
    
    if (rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"1" forKey:@"ExistingRecommended1"];
        _product1.text = [NSString stringWithFormat:@"Name of Insured: %@",controller.NameOfInsured.text];
    }
    else if (rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"1" forKey:@"ExistingRecommended2"];
        _product2.text = [NSString stringWithFormat:@"Name of Insured: %@",controller.NameOfInsured.text];
    }
    else if (rowToUpdate == 4){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"1" forKey:@"ExistingRecommended3"];
        _product3.text = [NSString stringWithFormat:@"Name of Insured: %@",controller.NameOfInsured.text];
    }
    if (rowToUpdate == 5){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"1" forKey:@"ExistingRecommended4"];
        _product4.text = [NSString stringWithFormat:@"Name of Insured: %@",controller.NameOfInsured.text];
    }
    if (rowToUpdate == 6){
        [[obj.CFFData objectForKey:@"SecI"] setValue:@"1" forKey:@"ExistingRecommended5"];
        _product5.text = [NSString stringWithFormat:@"Name of Insured: %@",controller.NameOfInsured.text];
    }
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

-(void)initialUpdate {
    AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    
    if(MenuOption.eApp){
    isAutoSelect = YES;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results;
    NSString *siNo = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
    results = [database executeQuery:@"select b.name from Trad_LAPayor as a, Clt_Profile as B where sino = ? and a.custcode = b.custcode", siNo, Nil];
    NSMutableArray *sampleArray=[[NSMutableArray alloc]init];
    while ([results next]) {
        _productSI.text  = [results stringForColumn:@"Name"];
        [sampleArray addObject:_productSI.text];
    }
    for (int i=0; i<sampleArray.count; i++) {
        if(i==0){
            _productSI.text =[sampleArray objectAtIndex:i];
            //_productSI.textColor = [UIColor grayColor];
            
           
            _productSI.text = [NSString stringWithFormat:@"Name of Insured: %@",_productSI.text ];
        }
        else if(i==1){
            isAutoSelect = NO;
            _productSI2.text =[sampleArray objectAtIndex:i];
            //_productSI2.textColor = [UIColor grayColor];
            
            
            _productSI2.text = [NSString stringWithFormat:@"Name of Insured: %@",_productSI2.text ];
        }
    }
    }
    
    if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended1"] isEqualToString:@"1"]) {
        _product1.text = [NSString stringWithFormat:@"Name of Insured: %@", [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"NameOfInsured1"]];
    }
    if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended2"] isEqualToString:@"1"]) {
        _product2.text = [NSString stringWithFormat:@"Name of Insured: %@", [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"NameOfInsured2"]];
    }
    if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended3"] isEqualToString:@"1"]) {
        _product3.text = [NSString stringWithFormat:@"Name of Insured: %@", [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"NameOfInsured3"]];
    }
    if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended4"] isEqualToString:@"1"]) {
        _product4.text = [NSString stringWithFormat:@"Name of Insured: %@", [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"NameOfInsured4"]];
    }
    if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended5"] isEqualToString:@"1"]) {
        _product5.text = [NSString stringWithFormat:@"Name of Insured: %@", [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"NameOfInsured5"]];
    }
}

#pragma mark - textview delegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (textView == _othersField) {
        NSUInteger newLength = [textView.text length] + [text length] - range.length;
        return ((newLength <= CHARACTER_LIMIT200));
    }
    return FALSE;
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
