//
//  ExistingProductRecommended.m
//  iMobile Planner
//
//  Created by Juliana on 7/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ExistingProductRecommended.h"
#import "ColorHexCode.h"
#import "DataClass.h"
#import "ProductRecommended.h"

#define NUMBERS_ONLY @"1234567890."
#define CHARACTER_LIMIT 15
#define CHARACTER_LIMIT2 70
#define CHARACTER_LIMIT3 100
#define CHARACTER_LIMIT_PSA 13 //bug 2611

@interface ExistingProductRecommended (){
    DataClass *obj;
}

@end

@implementation ExistingProductRecommended

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
//	NSLog(@"viewdidload");
    [super viewDidLoad];
	obj=[DataClass getInstance];
    
    if (self.rowToUpdate == 0){
        _NameOfInsured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"NameOfInsuredSI"];
        _ProductType.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ProductTypeSI"];
        _Term.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"TermSI"];
        _Premium.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"PremiumSI"];
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"FrequencySI"] isEqualToString:@""]){
            [_Frequency setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"FrequencySI"] isEqualToString:@"Annual"]){
            [_Frequency setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"FrequencySI"] isEqualToString:@"Semi Annual"]){
            [_Frequency setSelectedSegmentIndex:1];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"FrequencySI"] isEqualToString:@"Quarterly"]){
            [_Frequency setSelectedSegmentIndex:2];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"FrequencySI"] isEqualToString:@"Monthly"]){
            [_Frequency setSelectedSegmentIndex:3];
        }
        _SumAssured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"SumAssuredSI"];
        _AdditionalBenefits.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"AdditionalBenefitSI"];
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"BroughtSI"] isEqualToString:@""]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = NO;
            self.bought = @"0";
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"BroughtSI"] isEqualToString:@"-1"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = YES;
            select2 = NO;
            self.bought = @"1";
        }
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"BroughtSI"] isEqualToString:@"0"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = YES;
            self.bought = @"2";
        }
        
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommendedSI"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
    }
    else if (self.rowToUpdate == 1){
        _NameOfInsured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"NameOfInsured1"];
        _ProductType.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ProductType1"];
        _Term.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Term1"];
        _Premium.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Premium1"];
//		NSLog(@"segment: %@", [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency1"]);
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency1"] isEqualToString:@""]){
            [_Frequency setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency1"] isEqualToString:@"Annual"]){
            [_Frequency setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency1"] isEqualToString:@"Semi Annual"]){
            [_Frequency setSelectedSegmentIndex:1];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency1"] isEqualToString:@"Quarterly"]){
            [_Frequency setSelectedSegmentIndex:2];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency1"] isEqualToString:@"Monthly"]){
            [_Frequency setSelectedSegmentIndex:3];
        }
        _SumAssured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"SumAssured1"];
                _AdditionalBenefits.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"AdditionalBenefit1"];
		NSLog(@"bought: %@", [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought1"]);
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought1"] isEqualToString:@""]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = YES;
            select2 = NO;
            self.bought = @"-1";
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought1"] isEqualToString:@"-1"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = YES;
            select2 = NO;
            self.bought = @"-1";
        }
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought1"] isEqualToString:@"0"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = YES;
            self.bought = @"0";
        }
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended1"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
    }
    else if (self.rowToUpdate == 2){
        _NameOfInsured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"NameOfInsured2"];
        _ProductType.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ProductType2"];
        _Term.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Term2"];
        _Premium.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Premium2"];
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency2"] isEqualToString:@""]){
            [_Frequency setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency2"] isEqualToString:@"Annual"]){
            [_Frequency setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency2"] isEqualToString:@"Semi Annual"]){
            [_Frequency setSelectedSegmentIndex:1];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency2"] isEqualToString:@"Quarterly"]){
            [_Frequency setSelectedSegmentIndex:2];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency2"] isEqualToString:@"Monthly"]){
            [_Frequency setSelectedSegmentIndex:3];
        }
        _SumAssured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"SumAssured1"];
                _AdditionalBenefits.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"AdditionalBenefit2"];
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought2"] isEqualToString:@""]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = YES;
            select2 = NO;
            self.bought = @"-1";
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought2"] isEqualToString:@"-1"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = YES;
            select2 = NO;
            self.bought = @"-1";
        }
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought2"] isEqualToString:@"0"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = YES;
            self.bought = @"0";
        }
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended2"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
    }
    else if (self.rowToUpdate == 3){
        _NameOfInsured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"NameOfInsured3"];
        _ProductType.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ProductType3"];
        _Term.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Term3"];
        _Premium.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Premium3"];
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency3"] isEqualToString:@""]){
            [_Frequency setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency3"] isEqualToString:@"Annual"]){
            [_Frequency setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency3"] isEqualToString:@"Semi Annual"]){
            [_Frequency setSelectedSegmentIndex:1];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency3"] isEqualToString:@"Quarterly"]){
            [_Frequency setSelectedSegmentIndex:2];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency3"] isEqualToString:@"Monthly"]){
            [_Frequency setSelectedSegmentIndex:3];
        }
        _SumAssured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"SumAssured3"];
        _AdditionalBenefits.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"AdditionalBenefit3"];
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought3"] isEqualToString:@""]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = YES;
            select2 = NO;
            self.bought = @"-1";
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought3"] isEqualToString:@"-1"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = YES;
            select2 = NO;
            self.bought = @"-1";
        }
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought3"] isEqualToString:@"0"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = YES;
            self.bought = @"0";
        }
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended3"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
    }
    else if (self.rowToUpdate == 4){
        _NameOfInsured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"NameOfInsured4"];
        _ProductType.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ProductType4"];
        _Term.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Term4"];
        _Premium.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Premium4"];
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency4"] isEqualToString:@""]){
            [_Frequency setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency4"] isEqualToString:@"Annual"]){
            [_Frequency setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency4"] isEqualToString:@"Semi Annual"]){
            [_Frequency setSelectedSegmentIndex:1];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency4"] isEqualToString:@"Quarterly"]){
            [_Frequency setSelectedSegmentIndex:2];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency4"] isEqualToString:@"Monthly"]){
            [_Frequency setSelectedSegmentIndex:3];
        }
        _SumAssured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"SumAssured4"];
        _AdditionalBenefits.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"AdditionalBenefit4"];
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought4"] isEqualToString:@""]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = YES;
            select2 = NO;
            self.bought = @"-1";
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought4"] isEqualToString:@"-1"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = YES;
            select2 = NO;
            self.bought = @"-1";
        }
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought4"] isEqualToString:@"0"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = YES;
            self.bought = @"0";
        }
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended4"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
    }
    else if (self.rowToUpdate == 5){
        _NameOfInsured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"NameOfInsured5"];
        _ProductType.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ProductType5"];
        _Term.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Term5"];
        _Premium.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Premium5"];
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency5"] isEqualToString:@""]){
            [_Frequency setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency5"] isEqualToString:@"Annual"]){
            [_Frequency setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency5"] isEqualToString:@"Semi Annual"]){
            [_Frequency setSelectedSegmentIndex:1];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency5"] isEqualToString:@"Quarterly"]){
            [_Frequency setSelectedSegmentIndex:2];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency5"] isEqualToString:@"Monthly"]){
            [_Frequency setSelectedSegmentIndex:3];
        }
        _SumAssured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"SumAssured5"];
        _AdditionalBenefits.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"AdditionalBenefit5"];
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought5"] isEqualToString:@""]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = YES;
            select2 = NO;
            self.bought = @"-1";
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought5"] isEqualToString:@"-1"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = YES;
            select2 = NO;
            self.bought = @"-1";
        }
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought5"] isEqualToString:@"0"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = YES;
            self.bought = @"0";
        }
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended5"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
    }
	//fixed bug 2611 start
	_Term.delegate = self;
	_Premium.delegate = self;
	_SumAssured.delegate = self;
	//fixed bug 2611 end
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
	[self setBtn1:nil];
	[self setBtn2:nil];
    [self setNameOfInsured:nil];
    [self setProductType:nil];
    [self setTerm:nil];
    [self setPremium:nil];
    [self setFrequency:nil];
    [self setSumAssured:nil];
    [self setAdditionalBenefits:nil];
    [self setDeleteBtn:nil];
    [self setDeleteCell:nil];
	[super viewDidUnload];
}

- (IBAction)clickBtn1:(id)sender {
	[btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    select1 = YES;
    select2 = NO;
    self.bought = @"-1";
	
	//fixed bug 2612 start
	_click = @"Yes";
	//fixed bug 2612 end
}

- (IBAction)clickBtn2:(id)sender {
    [btn1 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
	[btn2 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
    select1 = NO;
    select2 = YES;
    self.bought = @"0";
	
	//fixed bug 2612 start
	_click = @"Yes";
	//fixed bug 2612 end
}

- (IBAction)doCancel:(id)sender {
	[self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)doDone:(id)sender {
}

- (IBAction)doDelete:(id)sender {
    ProductRecommended *parent = (ProductRecommended *) self.parentViewController;
    [parent doDelete:self.rowToUpdate];
}

//fixed bug 2611 start
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == _Term){
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return ([string isEqualToString:filtered]);
    }
	else if (textField == _Premium || textField == _SumAssured) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_PSA));
	}
	return FALSE;
}

- (IBAction)actionForPremium:(id)sender {
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
//	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,###.00"];
	_Premium.text = [formatter stringFromNumber:[formatter numberFromString:_Premium.text]];
}

- (IBAction)actionForSumAssured:(id)sender {
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
//	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,###.00"];
	_SumAssured.text = [formatter stringFromNumber:[formatter numberFromString:_SumAssured.text]];
}
//fixed bug 2611 end

@end
