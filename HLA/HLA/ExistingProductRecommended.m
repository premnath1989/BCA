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
#import "AppDelegate.h"

#define NUMBERS_ONLY @"1234567890."
#define CHARACTER_LIMIT 15
#define CHARACTER_LIMIT2 70
#define CHARACTER_LIMIT3 100
#define CHARACTER_LIMIT_PSA 13 //bug 2611
#define CHARACTER_LIMIT200 200

@interface ExistingProductRecommended (){
    DataClass *obj;
}

@end

@implementation ExistingProductRecommended

@synthesize btn1;
@synthesize btn2;
@synthesize eApp;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)functionDelete :(NSString *)delete1
{
    NSLog(@"functionDelete %@",delete1);
}
- (void)viewDidLoad
{
    //	NSLog(@"viewdidload");
    [super viewDidLoad];
	obj=[DataClass getInstance];
    //self.click = @"Yes";
    AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    
    if (self.rowToUpdate == 0){
        if (MenuOption.eApp) {
            [self displayData];
        }
        else{
            //cff case
            
        }
        
        
        //_ProductType.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ProductTypeSI"];
        // _Term.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"TermSI"];
        // _Premium.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"PremiumSI"];
        //        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"FrequencySI"] isEqualToString:@""]){
        //            [_Frequency setSelectedSegmentIndex:UISegmentedControlNoSegment];
        //        }
        //        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"FrequencySI"] isEqualToString:@"Annual"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"FrequencySI"] isEqualToString:@"12"]){
        //            [_Frequency setSelectedSegmentIndex:0];
        //        }
        //        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"FrequencySI"] isEqualToString:@"Semi Annual"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"FrequencySI"] isEqualToString:@"06"]){
        //            [_Frequency setSelectedSegmentIndex:1];
        //        }
        //        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"FrequencySI"] isEqualToString:@"Quarterly"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"FrequencySI"] isEqualToString:@"03"]){
        //            [_Frequency setSelectedSegmentIndex:2];
        //        }
        //        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"FrequencySI"] isEqualToString:@"Monthly"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"FrequencySI"] isEqualToString:@"01"]){
        //            [_Frequency setSelectedSegmentIndex:3];
        //        }
        // _SumAssured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"SumAssuredSI"];
        //_AdditionalBenefits.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"AdditionalBenefitSI"];
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
            self.bought = @"-1";
        }
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"BroughtSI"] isEqualToString:@"0"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = YES;
            self.bought = @"0";
        }
        
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommendedSI"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
            _BoughtCell.hidden = TRUE;
        }
        else{
            _deleteCell.hidden = TRUE;
            _BoughtCell.hidden = TRUE;
        }
    }
    else if (self.rowToUpdate == 1){
        
        [self displayDataForSI];
        _deleteCell.hidden = TRUE;
        _BoughtCell.hidden = TRUE;
        
        
    }
    else if (self.rowToUpdate == 2){
        _NameOfInsured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"NameOfInsured1"];
        _ProductType.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ProductType1"];
        _Term.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Term1"];
        _Premium.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Premium1"];
        //		NSLog(@"segment: %@", [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency1"]);
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency1"] isEqualToString:@""]){
            [_Frequency setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency1"] isEqualToString:@"Annual"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency1"] isEqualToString:@"12"]){
            [_Frequency setSelectedSegmentIndex:0];
            
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency1"] isEqualToString:@"Semi Annual"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency1"] isEqualToString:@"06"]){
            [_Frequency setSelectedSegmentIndex:1];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency1"] isEqualToString:@"Quarterly"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency1"] isEqualToString:@"03"]){
            [_Frequency setSelectedSegmentIndex:2];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency1"] isEqualToString:@"Monthly"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency1"] isEqualToString:@"01"]){
            [_Frequency setSelectedSegmentIndex:3];
        }
        _SumAssured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"SumAssured1"];
        _AdditionalBenefits.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"AdditionalBenefit1"];
		NSLog(@"bought: %@", [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought1"]);
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought1"] isEqualToString:@""]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = NO;
            self.bought = @"0";
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought1"] isEqualToString:@"-1"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = YES;
            select2 = NO;
            self.bought = @"-1";
            _click = @"Yes";
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought1"] isEqualToString:@"0"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = YES;
            self.bought = @"0";
            _click = @"Yes";
        }
        else if ([[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought1"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = YES;
            select2 = NO;
            self.bought = @"-1";
            _click = @"Yes";
        }
        else if (![[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought1"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = NO;
            self.bought = @"0";
        }
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended1"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
    }
    else if (self.rowToUpdate == 3){
        _NameOfInsured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"NameOfInsured2"];
        _ProductType.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ProductType2"];
        _Term.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Term2"];
        _Premium.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Premium2"];
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency2"] isEqualToString:@""]){
            [_Frequency setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency2"] isEqualToString:@"Annual"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency2"] isEqualToString:@"12"]){
            [_Frequency setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency2"] isEqualToString:@"Semi Annual"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency2"] isEqualToString:@"06"]){
            [_Frequency setSelectedSegmentIndex:1];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency2"] isEqualToString:@"Quarterly"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency2"] isEqualToString:@"03"]){
            [_Frequency setSelectedSegmentIndex:2];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency2"] isEqualToString:@"Monthly"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency2"] isEqualToString:@"01"]){
            [_Frequency setSelectedSegmentIndex:3];
        }
        _SumAssured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"SumAssured2"];
        _AdditionalBenefits.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"AdditionalBenefit2"];
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought2"] isEqualToString:@""]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = NO;
            self.bought = @"";
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought2"] isEqualToString:@"-1"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = YES;
            select2 = NO;
            self.bought = @"-1";
            _click = @"Yes";
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought2"] isEqualToString:@"0"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = YES;
            self.bought = @"0";
            _click = @"Yes";
        }
        else if (![[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought2"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = NO;
            self.bought = @"";
        }
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended2"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
    }
    else if (self.rowToUpdate == 4){
        _NameOfInsured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"NameOfInsured3"];
        _ProductType.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ProductType3"];
        _Term.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Term3"];
        _Premium.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Premium3"];
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency3"] isEqualToString:@""]){
            [_Frequency setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency3"] isEqualToString:@"Annual"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency3"] isEqualToString:@"12"]){
            [_Frequency setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency3"] isEqualToString:@"Semi Annual"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency3"] isEqualToString:@"06"]){
            [_Frequency setSelectedSegmentIndex:1];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency3"] isEqualToString:@"Quarterly"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency3"] isEqualToString:@"03"]){
            [_Frequency setSelectedSegmentIndex:2];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency3"] isEqualToString:@"Monthly"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency3"] isEqualToString:@"01"]){
            [_Frequency setSelectedSegmentIndex:3];
        }
        _SumAssured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"SumAssured3"];
        _AdditionalBenefits.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"AdditionalBenefit3"];
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought3"] isEqualToString:@""]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = NO;
            self.bought = @"";
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought3"] isEqualToString:@"-1"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = YES;
            select2 = NO;
            self.bought = @"-1";
            _click = @"Yes";
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought3"] isEqualToString:@"0"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = YES;
            self.bought = @"0";
            _click = @"Yes";
        }
        else if (![[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought3"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = NO;
            self.bought = @"";
        }
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended3"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
    }
    else if (self.rowToUpdate == 5){
        _NameOfInsured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"NameOfInsured4"];
        _ProductType.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ProductType4"];
        _Term.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Term4"];
        _Premium.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Premium4"];
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency4"] isEqualToString:@""]){
            [_Frequency setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency4"] isEqualToString:@"Annual"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency4"] isEqualToString:@"12"]){
            [_Frequency setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency4"] isEqualToString:@"Semi Annual"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency4"] isEqualToString:@"06"]){
            [_Frequency setSelectedSegmentIndex:1];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency4"] isEqualToString:@"Quarterly"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency4"] isEqualToString:@"03"]){
            [_Frequency setSelectedSegmentIndex:2];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency4"] isEqualToString:@"Monthly"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency4"] isEqualToString:@"01"]){
            [_Frequency setSelectedSegmentIndex:3];
        }
        _SumAssured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"SumAssured4"];
        _AdditionalBenefits.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"AdditionalBenefit4"];
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought4"] isEqualToString:@""]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = NO;
            self.bought = @"";
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought4"] isEqualToString:@"-1"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = YES;
            select2 = NO;
            self.bought = @"-1";
            _click = @"Yes";
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought4"] isEqualToString:@"0"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = YES;
            self.bought = @"0";
            _click = @"Yes";
        }
        else if (![[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought4"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = NO;
            self.bought = @"";
        }
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ExistingRecommended4"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
    }
    else if (self.rowToUpdate == 6){
        _NameOfInsured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"NameOfInsured5"];
        _ProductType.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"ProductType5"];
        _Term.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Term5"];
        _Premium.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Premium5"];
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency5"] isEqualToString:@""]){
            [_Frequency setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency5"] isEqualToString:@"Annual"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency5"] isEqualToString:@"12"]){
            [_Frequency setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency5"] isEqualToString:@"Semi Annual"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency5"] isEqualToString:@"06"]){
            [_Frequency setSelectedSegmentIndex:1];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency5"] isEqualToString:@"Quarterly"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency5"] isEqualToString:@"03"]){
            [_Frequency setSelectedSegmentIndex:2];
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency5"] isEqualToString:@"Monthly"] || [[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Frequency5"] isEqualToString:@"01"]){
            [_Frequency setSelectedSegmentIndex:3];
        }
        _SumAssured.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"SumAssured5"];
        _AdditionalBenefits.text = [[obj.CFFData objectForKey:@"SecI"] objectForKey:@"AdditionalBenefit5"];
        if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought5"] isEqualToString:@""]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = NO;
            self.bought = @"";
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought5"] isEqualToString:@"-1"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = YES;
            select2 = NO;
            self.bought = @"-1";
            _click = @"Yes";
        }
        else if ([[[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought5"] isEqualToString:@"0"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
            select1 = YES;
            select2 = NO;
            self.bought = @"0";
            _click = @"Yes";
        }
        else if (![[obj.CFFData objectForKey:@"SecI"] objectForKey:@"Brought5"]){
            [btn1 setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            [btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
            select1 = NO;
            select2 = NO;
            self.bought = @"";
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
    _NameOfInsured.delegate = self;
    _ProductType.delegate = self;
    _AdditionalBenefits.delegate = self;
	//fixed bug 2611 end
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    //    tap.cancelsTouchesInView = NO;
    //    tap.numberOfTapsRequired = 1;
    
    //    [self.view addGestureRecognizer:tap];
    
    
    
    
}



- (void)displayData {
    
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setMaximumFractionDigits:2];
    [fmt setPositiveFormat:@"#,##0.00"];
    
    
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
        _NameOfInsured.text = [results stringForColumn:@"Name"];
        [sampleArray addObject:_NameOfInsured.text];
    }
    for (int i=0; i<sampleArray.count; i++) {
        if(i==0){
            _NameOfInsured.text=[sampleArray objectAtIndex:i];
            _NameOfInsured.textColor = [UIColor grayColor];
            
            _NameOfInsured.enabled = false;
            if (_NameOfInsured.text.length==0) {
                _NameOfInsured.textColor = [UIColor grayColor];
                
                _NameOfInsured.enabled = false;
                
            }
            
            
            results = Nil;
            results = [database executeQuery:@"select PolicyTerm, BasicSA from Trad_Details where SINo = ?", siNo];
            while ([results next]) {
                
                
                _Term.text = [results stringForColumn:@"PolicyTerm"];
                //        _SumAssured.text = [results stringForColumn:@"BasicSA"];
                //        _SumAssured.text = [NSString stringWithFormat:@"%@%@",[results stringForColumn:@"BasicSA"],@"0"];
                _SumAssured.text = [fmt stringFromNumber:[fmt numberFromString:[results stringForColumn:@"BasicSA"]]];
                
                //[self getCountryCode:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressCountry"]
                
                
                _Term.textColor = [UIColor grayColor];
                
                _Term.enabled = false;
                _SumAssured.textColor = [UIColor grayColor];
                
                _SumAssured.enabled = false;
            }
            if (_Term.text.length==0) {
                _Term.textColor = [UIColor grayColor];
                _Term.enabled = false;
                
            }
            if (_SumAssured.text.length==0) {
                _SumAssured.textColor = [UIColor grayColor];
                _SumAssured.enabled = false;
                
            }
            
            NSString *GEtTheFullPlan = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"];
            
            NSString *desc;
            GEtTheFullPlan = [GEtTheFullPlan stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
            
            
            FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
            [db open];
            FMResultSet *result = [db executeQuery:@"SELECT PlanName FROM Trad_Sys_Profile WHERE PlanCode = ?", GEtTheFullPlan];
            
            NSInteger *count = 0;
            while ([result next]) {
                count = count + 1;
                desc = [result objectForColumnName:@"PlanName"];
            }
            
            [result close];
            [db close];
            
            
            _ProductType.text =desc;
            _ProductType.textColor = [UIColor grayColor];
            
            _ProductType.enabled = false;
            
            results = Nil;
            NSString *mode = @"";
            NSString *PaymentMode_Trad = @"";
            NSString *PaymentMode = @"";
            NSString *sino = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
            
            NSString *eproposalNo =  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            
            
            results = [database executeQuery:@"SELECT SIType, SIVersion,BasicPlanCode, eAppVersion, CreatedAt, PaymentMode, SystemName from eProposal WHERE eProposalNo = ?",eproposalNo];
            
            while ([results next]) {
                
                PaymentMode_Trad  = [results stringForColumn:@"PaymentMode"];
            }
            if ([PaymentMode_Trad isEqualToString:@""]||[PaymentMode_Trad isEqualToString:@"<nil>"] || PaymentMode_Trad == nil) {
                _Frequency.enabled = false;
                _Frequency.tintColor = [UIColor grayColor];
                PaymentMode_Trad = @"Annual";
            }
            
            if ((NSNull *) PaymentMode_Trad == [NSNull null])
            {
                _Frequency.enabled = false;
                _Frequency.tintColor = [UIColor grayColor];
                PaymentMode_Trad = @"Annual";
            }
            
            
            if([PaymentMode_Trad isEqualToString:@"Annual"])
            {
                
                //        results =  [database executeQuery:@"SELECT  Annually FROM SI_Store_premium WHERE SiNo = ? AND Type = 'B'",sino];
                
                //        results =  [database executeQuery:@"SELECT  Annually FROM SI_Store_premium WHERE SiNo = ? AND Type != 'BOriginal'",sino];
                results =  [database executeQuery:@"SELECT  Annually FROM SI_Store_premium WHERE SiNo = ? AND Type != 'BOriginal' and SemiAnnually IS NOT NULL",sino];
                mode = @"Annually";
                PaymentMode = @"12";
                [_Frequency setSelectedSegmentIndex:0];
                _Frequency.enabled = false;
                _Frequency.tintColor = [UIColor grayColor];
            }
            
            else if([PaymentMode_Trad isEqualToString:@"SemiAnnual"])
            {
                
                //        results =  [database executeQuery:@"SELECT  Annually FROM SI_Store_premium WHERE SiNo = ? AND Type = 'B'",sino];
                results =  [database executeQuery:@"SELECT  SemiAnnually FROM SI_Store_premium WHERE SiNo = ? AND Type != 'BOriginal' and SemiAnnually IS NOT NULL",sino];
                mode = @"SemiAnnually";
                PaymentMode = @"06";
                [_Frequency setSelectedSegmentIndex:1];
                _Frequency.enabled = false;
                _Frequency.tintColor = [UIColor grayColor];
            }
            
            else if([PaymentMode_Trad isEqualToString:@"Quarterly"])
            {
                
                //        results =  [database executeQuery:@"SELECT  Annually FROM SI_Store_premium WHERE SiNo = ? AND Type = 'B'",sino];
                results =  [database executeQuery:@"SELECT  Quarterly FROM SI_Store_premium WHERE SiNo = ? AND Type != 'BOriginal' and SemiAnnually IS NOT NULL",sino];
                mode = @"Quarterly";
                PaymentMode = @"03";
                [_Frequency setSelectedSegmentIndex:2];
                _Frequency.enabled = false;
                _Frequency.tintColor = [UIColor grayColor];
            }
            
            else if([PaymentMode_Trad isEqualToString:@"Monthly"])
            {
                
                //        results =  [database executeQuery:@"SELECT  Annually FROM SI_Store_premium WHERE SiNo = ? AND Type = 'B'",sino];
                results =  [database executeQuery:@"SELECT  Monthly FROM SI_Store_premium WHERE SiNo = ? AND Type != 'BOriginal' and SemiAnnually IS NOT NULL",sino];
                mode = @"Monthly";
                PaymentMode = @"01";
                [_Frequency setSelectedSegmentIndex:3];
                _Frequency.enabled = false;
                _Frequency.tintColor = [UIColor grayColor];
            }
            
            //    int Test1;
            double Test1;
            double Test2;
            NSString *testtest;
			
            while ([results next]) {
                testtest = [[results stringForColumn:mode]stringByReplacingOccurrencesOfString:@"," withString:@""];
                Test1 = [testtest doubleValue];
                Test2 = Test1 + Test2;
                _Premium.text = [NSString stringWithFormat:@"%g",Test2];
                _Premium.text = [fmt stringFromNumber:[fmt numberFromString:_Premium.text]];
                _Premium.textColor = [UIColor grayColor];
                
                _Premium.enabled = false;
            }
            if (_Premium.text.length==0) {
                _Premium.textColor = [UIColor grayColor];
                _Premium.enabled = false;
                _Frequency.enabled = false;
                _Frequency.tintColor = [UIColor grayColor];
                
                _Frequency.enabled = false;
                _Frequency.tintColor = [UIColor grayColor];
                
            }
            
            results = Nil;
            
            results = [database executeQuery:@"select distinct riderCode, riderdesc from Trad_Rider_Details where SINo = ? and Seq='1' and PTypeCode ='LA'", siNo, Nil];
            
            NSMutableArray *riders = [NSMutableArray array];
            while ([results next]) {
                //additionalBenefits = [NSString stringWithFormat:@"%@ %@", additionalBenefits, [results stringForColumn:@"riderCode"]];
                [riders addObject:[results stringForColumn:@"riderCode"]];
            }
            FMResultSet *results2;
            results2 = Nil;
            NSString *RiderFullName;
            NSString *str_text;
            NSMutableArray *sampleArray1=[[NSMutableArray alloc]init];
            NSDictionary *riderDetails;
            for (NSString *riderCode in riders) {
                results = [database executeQuery:@"select distinct RiderDesc from Trad_Sys_Rider_Profile where RiderCode = ?", riderCode];
                if ([results next]) {
                    
                    results2 = [database executeQuery:@"select distinct * from Trad_Rider_Details where SINo = ? and RiderCode = ?",siNo, riderCode];
                    while ([results2 next]) {
                        
                        
                        
                        RiderFullName = [results2 stringForColumn:@"RiderDesc"];
                        [sampleArray1 addObject:RiderFullName];
                        
                        
                        //[addBen addObject:_AdditionalBenefits.text];
                        
                        
                    }
                    
                    
                }
            }
            if(sampleArray1.count==0){
                _AdditionalBenefits.editable=false;
            }
            
            NSString *tempString;
            for (int i=0; i<sampleArray1.count; i++) {
                //if (str_text.length>0) {
                if (tempString.length>1)
                {
                    tempString=[NSString stringWithFormat:@"%@\n%@",tempString,[sampleArray1 objectAtIndex:i]];
                    str_text=tempString;
                }
                
                else if (tempString.length>0)
                {
                    tempString=[NSString stringWithFormat:@"%@%@ ",tempString,[sampleArray1 objectAtIndex:i]];
                    str_text=tempString;
                }
                
                else{
                    str_text=[NSString stringWithFormat:@"%@",[sampleArray1 objectAtIndex:i]];
                }
                
                _AdditionalBenefits.textColor = [UIColor grayColor];
                
                _AdditionalBenefits.editable = false;
                _AdditionalBenefits.text = str_text;
                tempString=str_text;
                _AdditionalBenefits.textColor = [UIColor grayColor];
                
                _AdditionalBenefits.editable = false;
            }
            
            
        }
        
        else if(i==1){
            
        }
    }
}



- (void)displayDataForSI {
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setMaximumFractionDigits:2];
    [fmt setPositiveFormat:@"#,##0.00"];
    
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
        _NameOfInsured.text = [results stringForColumn:@"Name"];
        [sampleArray addObject:_NameOfInsured.text];
    }
    for (int i=0; i<sampleArray.count; i++) {
        if(i==0){
            
        }
        else if(i==1){
            _NameOfInsured.text=[sampleArray objectAtIndex:i];
            _NameOfInsured.textColor = [UIColor grayColor];
            
            _NameOfInsured.enabled = false;
            if (_NameOfInsured.text.length==0) {
                _NameOfInsured.textColor = [UIColor grayColor];
                
                _NameOfInsured.enabled = false;
                
            }
            
            results = Nil;
            results = [database executeQuery:@"select PolicyTerm, BasicSA from Trad_Details where SINo = ?", siNo];
            while ([results next]) {
                
                
                _Term.text = [results stringForColumn:@"PolicyTerm"];
                //        NSString *sampleString=[results stringForColumn:@"BasicSA"] ;
                //
                //        _SumAssured.text = [NSString stringWithFormat:@"%@%@",sampleString,@"0"];
                _SumAssured.text = [fmt stringFromNumber:[fmt numberFromString:[results stringForColumn:@"BasicSA"]]];
                
                _Term.textColor = [UIColor grayColor];
                
                _Term.enabled = false;
                _SumAssured.textColor = [UIColor grayColor];
                
                _SumAssured.enabled = false;
                
            }
            if (_Term.text.length==0) {
                _Term.textColor = [UIColor grayColor];
                _Term.enabled = false;
                
            }
            if (_SumAssured.text.length==0) {
                _SumAssured.textColor = [UIColor grayColor];
                _SumAssured.enabled = false;
                
            }
            
            
            NSString *GEtTheFullPlan = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"];
            
            NSString *desc;
            GEtTheFullPlan = [GEtTheFullPlan stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
            
            
            FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
            [db open];
            FMResultSet *result = [db executeQuery:@"SELECT PlanName FROM Trad_Sys_Profile WHERE PlanCode = ?", GEtTheFullPlan];
            
            NSInteger *count = 0;
            while ([result next]) {
                count = count + 1;
                desc = [result objectForColumnName:@"PlanName"];
            }
            
            [result close];
            [db close];
            
            
            _ProductType.text =desc;
            _ProductType.textColor = [UIColor grayColor];
            
            _ProductType.enabled = false;
            
            results = Nil;
            NSString *mode = @"";
            NSString *PaymentMode_Trad = @"";
            NSString *PaymentMode = @"";
            NSString *sino = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
            
            NSString *eproposalNo =  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            
            
            results = [database executeQuery:@"SELECT SIType, SIVersion,BasicPlanCode, eAppVersion, CreatedAt, PaymentMode, SystemName from eProposal WHERE eProposalNo = ?",eproposalNo];
            
            while ([results next]) {
                
                PaymentMode_Trad  = [results stringForColumn:@"PaymentMode"];
            }
            if ([PaymentMode_Trad isEqualToString:@""]||[PaymentMode_Trad isEqualToString:@"<nil>"] || PaymentMode_Trad == nil) {
                _Frequency.enabled = false;
                _Frequency.tintColor = [UIColor grayColor];
                PaymentMode_Trad = @"Annual";
            }
            
            if ((NSNull *) PaymentMode_Trad == [NSNull null])
            {
                _Frequency.enabled = false;
                _Frequency.tintColor = [UIColor grayColor];
                PaymentMode_Trad = @"Annual";
            }
            
            if([PaymentMode_Trad isEqualToString:@"Annual"])
            {
                
                //        results =  [database executeQuery:@"SELECT  Annually FROM SI_Store_premium WHERE SiNo = ? AND Type = 'B'",sino];
                results =  [database executeQuery:@"SELECT  Annually FROM SI_Store_premium WHERE SiNo = ? AND Type != 'BOriginal' and SemiAnnually IS NOT NULL",sino];
                mode = @"Annually";
                PaymentMode = @"12";
                [_Frequency setSelectedSegmentIndex:0];
                _Frequency.enabled = false;
                _Frequency.tintColor = [UIColor grayColor];
            }
            
            else if([PaymentMode_Trad isEqualToString:@"SemiAnnual"])
            {
                
                //        results =  [database executeQuery:@"SELECT  Annually FROM SI_Store_premium WHERE SiNo = ? AND Type = 'B'",sino];
                results =  [database executeQuery:@"SELECT  SemiAnnually FROM SI_Store_premium WHERE SiNo = ? AND Type != 'BOriginal' and SemiAnnually IS NOT NULL",sino];
                mode = @"SemiAnnually";
                PaymentMode = @"06";
                [_Frequency setSelectedSegmentIndex:1];
                _Frequency.enabled = false;
                _Frequency.tintColor = [UIColor grayColor];
            }
            
            else if([PaymentMode_Trad isEqualToString:@"Quarterly"])
            {
                
                //        results =  [database executeQuery:@"SELECT  Annually FROM SI_Store_premium WHERE SiNo = ? AND Type = 'B'",sino];
                results =  [database executeQuery:@"SELECT  Quarterly FROM SI_Store_premium WHERE SiNo = ? AND Type != 'BOriginal' and SemiAnnually IS NOT NULL",sino];
                mode = @"Quarterly";
                PaymentMode = @"03";
                [_Frequency setSelectedSegmentIndex:2];
                _Frequency.enabled = false;
                _Frequency.tintColor = [UIColor grayColor];
            }
            
            else if([PaymentMode_Trad isEqualToString:@"Monthly"])
            {
                
                //        results =  [database executeQuery:@"SELECT  Annually FROM SI_Store_premium WHERE SiNo = ? AND Type = 'B'",sino];
                results =  [database executeQuery:@"SELECT  Monthly FROM SI_Store_premium WHERE SiNo = ? AND Type != 'BOriginal' and SemiAnnually IS NOT NULL",sino];
                mode = @"Monthly";
                PaymentMode = @"01";
                [_Frequency setSelectedSegmentIndex:3];
                _Frequency.enabled = false;
                _Frequency.tintColor = [UIColor grayColor];
            }
            
            double Test1;
            double Test2;
            
            
            
            NSString *testtest;
            
            
            while ([results next])
            {
                testtest = [[results stringForColumn:mode]stringByReplacingOccurrencesOfString:@"," withString:@""];
                Test1 = [testtest doubleValue];
                Test2 = Test1 + Test2;
                //        _Premium.text = [results stringForColumn:mode];
                _Premium.text = [NSString stringWithFormat:@"%g",Test2];
                _Premium.text = [fmt stringFromNumber:[fmt numberFromString:_Premium.text]];
                _Premium.textColor = [UIColor grayColor];
                _Premium.enabled = false;
                
            }
            if (_Premium.text.length==0) {
                _Premium.textColor = [UIColor grayColor];
                _Premium.enabled = false;
                _Frequency.enabled = false;
                _Frequency.tintColor = [UIColor grayColor];
                
                _Frequency.enabled = false;
                _Frequency.tintColor = [UIColor grayColor];
                
            }
            
            
            results = Nil;
            
            
            results = [database executeQuery:@"select distinct riderCode, riderdesc,seq,ptypecode from Trad_Rider_Details where SINo = ? and Seq = '2' or PTypeCode ='PY' ", siNo, Nil];
            
            NSMutableArray *riders = [NSMutableArray array];
            while ([results next]) {
                //additionalBenefits = [NSString stringWithFormat:@"%@ %@", additionalBenefits, [results stringForColumn:@"riderCode"]];
                [riders addObject:[results stringForColumn:@"riderCode"]];
            }
            FMResultSet *results2;
            results2 = Nil;
            NSString *RiderFullName;
            NSString *str_text;
            NSMutableArray *sampleArray1=[[NSMutableArray alloc]init];
            
            NSMutableArray *addBen = [NSMutableArray array];
            NSDictionary *riderDetails;
            for (NSString *riderCode in riders) {
                results = [database executeQuery:@"select distinct RiderDesc from Trad_Sys_Rider_Profile where RiderCode = ?", riderCode];
                if ([results next]) {
                    
                    results2 = [database executeQuery:@"select distinct * from Trad_Rider_Details where SINo = ? and RiderCode = ?",siNo, riderCode];
                    while ([results2 next]) {
                        
                        
                        
                        RiderFullName = [results2 stringForColumn:@"RiderDesc"];
                        [sampleArray1 addObject:RiderFullName];
                        
                        
                        //[addBen addObject:_AdditionalBenefits.text];
                        
                        
                    }
                    
                    
                    
                    
                }
            }
            
            if(sampleArray1.count==0){
                _AdditionalBenefits.editable=false;
            }
            NSString *tempString;
            for (int i=0; i<sampleArray1.count; i++) {
                //if (str_text.length>0) {
                if (tempString.length>1)
                {
                    tempString=[NSString stringWithFormat:@"%@\n%@",tempString,[sampleArray1 objectAtIndex:i]];
                    str_text=tempString;
                }
                
                else if (tempString.length>0)
                {
                    tempString=[NSString stringWithFormat:@"%@%@ ",tempString,[sampleArray1 objectAtIndex:i]];
                    str_text=tempString;
                }
                
                else{
                    str_text=[NSString stringWithFormat:@"%@",[sampleArray1 objectAtIndex:i]];
                }
                
                _AdditionalBenefits.textColor = [UIColor grayColor];
                
                _AdditionalBenefits.editable = false;
                _AdditionalBenefits.text = str_text;
                tempString=str_text;
                _AdditionalBenefits.textColor = [UIColor grayColor];
                
                _AdditionalBenefits.editable = false;
            }
            
            
        }
        else if(i==1){
            
        }
        
    }
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
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return ([string isEqualToString:filtered] && newLength <= CHARACTER_LIMIT3);
    }
	else if (textField == _Premium || textField == _SumAssured) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_PSA));
	}
    else if (textField == _NameOfInsured) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength <= CHARACTER_LIMIT2);
    }
    else if (textField == _ProductType) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength <= CHARACTER_LIMIT3);
    }
	return FALSE;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (textView == _AdditionalBenefits) {
        NSUInteger newLength = [textView.text length] + [text length] - range.length;
        return ((newLength <= CHARACTER_LIMIT200));
    }
    return FALSE;
}

- (IBAction)actionForPremium:(id)sender {
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_Premium.text = [formatter stringFromNumber:[formatter numberFromString:_Premium.text]];
}

- (IBAction)actionForSumAssured:(id)sender {
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_SumAssured.text = [formatter stringFromNumber:[formatter numberFromString:_SumAssured.text]];
}

-(NSString*) getPlanName : (NSString*)PlanName
{
    if ([PlanName isEqualToString:@""] || (PlanName == NULL) || ([PlanName isEqualToString:@"(NULL)"])) {
        return @"";
    }
    NSString *desc;
    PlanName = [PlanName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT PlanName FROM Trad_Sys_Profile WHERE RelCode = ?", PlanName];
    
    NSInteger *count = 0;
    while ([result next]) {
        count = count + 1;
        desc = [result objectForColumnName:@"PlanName"];
    }
    
    [result close];
    [db close];
    
    if (count == 0) {
        desc = PlanName;
    }
    
    return desc;
    
}

//fixed bug 2611 end//

@end
