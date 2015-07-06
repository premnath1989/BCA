//
//  ExistingChildrenEducationPlans.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ExistingChildrenEducationPlans.h"
#import "EducationPlans.h"
#import "ColorHexCode.h"
#import "DataClass.h"

#define NUMBERS_ONLY @"1234567890."
#define DATE @"1234567890/"
#define CHARACTER_LIMIT3 3
#define CHARACTER_LIMIT15 16
#define CHARACTER_LIMIT70 70
#define CHARACTER_LIMIT100 100

@interface ExistingChildrenEducationPlans (){
    DataClass *obj;
}

@end

@implementation ExistingChildrenEducationPlans

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
    
    _ChildName.delegate = self;
    _Company.delegate = self;
    _Premium.delegate = self;
	//fixed for bug 2608 start
	_startDateLbl.delegate = self;
	_maturityDateLbl.delegate = self;
	//fixed for bug 2608 end
    _ProjectedValue.delegate = self;
    
    
    if (self.rowToUpdate == 2){
        _ChildName.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1ChildName"];
        _Company.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Company"];        
        _Premium.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Premium"];
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Frequency"] isEqualToString:@""]){
            [_Frequency setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Frequency"] isEqualToString:@"Annual"]){
            [_Frequency setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Frequency"] isEqualToString:@"Semi Annual"]){
            [_Frequency setSelectedSegmentIndex:1];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Frequency"] isEqualToString:@"Quarterly"]){
            [_Frequency setSelectedSegmentIndex:2];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1Frequency"] isEqualToString:@"Monthly"]){
            [_Frequency setSelectedSegmentIndex:3];
        }
        
        _startDateLbl.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1StartDate"];
        
        _maturityDateLbl.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1MaturityDate"];
        
        //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1MaturityDate"]);
        
        
        _ProjectedValue.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1ValueMaturity"];
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
    }
    else if (self.rowToUpdate == 3){
        _ChildName.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2ChildName"];
        _Company.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Company"];
        _Premium.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Premium"];
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Frequency"] isEqualToString:@""]){
            [_Frequency setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Frequency"] isEqualToString:@"Annual"]){
            [_Frequency setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Frequency"] isEqualToString:@"Semi Annual"]){
            [_Frequency setSelectedSegmentIndex:1];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Frequency"] isEqualToString:@"Quarterly"]){
            [_Frequency setSelectedSegmentIndex:2];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Frequency"] isEqualToString:@"Monthly"]){
            [_Frequency setSelectedSegmentIndex:3];
        }
        
        _startDateLbl.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2StartDate"];
        
        _maturityDateLbl.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2MaturityDate"];
        
        _ProjectedValue.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2ValueMaturity"];
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
    }
    else if (self.rowToUpdate == 4){
        _ChildName.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3ChildName"];
        _Company.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3Company"];
        _Premium.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3Premium"];
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3Frequency"] isEqualToString:@""]){
            [_Frequency setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3Frequency"] isEqualToString:@"Annual"]){
            [_Frequency setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2Frequency"] isEqualToString:@"Semi Annual"]){
            [_Frequency setSelectedSegmentIndex:1];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3Frequency"] isEqualToString:@"Quarterly"]){
            [_Frequency setSelectedSegmentIndex:2];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3Frequency"] isEqualToString:@"Monthly"]){
            [_Frequency setSelectedSegmentIndex:3];
        }
        
        _startDateLbl.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3StartDate"];
        
        _maturityDateLbl.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3MaturityDate"];
        
        _ProjectedValue.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3ValueMaturity"];
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
    }
    else if (self.rowToUpdate == 5){
        _ChildName.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4ChildName"];
        _Company.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Company"];
        _Premium.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Premium"];
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Frequency"] isEqualToString:@""]){
            [_Frequency setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Frequency"] isEqualToString:@"Annual"]){
            [_Frequency setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Frequency"] isEqualToString:@"Semi Annual"]){
            [_Frequency setSelectedSegmentIndex:1];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Frequency"] isEqualToString:@"Quarterly"]){
            [_Frequency setSelectedSegmentIndex:2];
        }
        else if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4Frequency"] isEqualToString:@"Monthly"]){
            [_Frequency setSelectedSegmentIndex:3];
        }
        
        _startDateLbl.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4StartDate"];
        
        _maturityDateLbl.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4MaturityDate"];
        
        _ProjectedValue.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4ValueMaturity"];
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    if (textField == _ChildName){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return ((newLength <= CHARACTER_LIMIT70));
    }
    else if (textField == _Company){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return ((newLength <= CHARACTER_LIMIT70));
    }
    else if (textField == _Premium){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT15));
    }
	//fix for bug 2608 start
    else if (textField == _startDateLbl){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:DATE] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT100));
    }
    else if (textField == _maturityDateLbl){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:DATE] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT100));
    }
	//fix for bug 2608 end
    else if (textField == _ProjectedValue){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT15));
    }
    return FALSE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)doCancel:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)doDone:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}
- (void)viewDidUnload {
    [self setChildName:nil];
    [self setCompany:nil];
    [self setPremium:nil];
    [self setFrequency:nil];
//    [self setStartDate:nil];
//    [self setMaturityDate:nil];
    [self setProjectedValue:nil];
    [self setDeleteCell:nil];
    [self setStartDateLbl:nil];
    [self setMaturityDateLbl:nil];
    [self setStartDateLbl:nil];
    [self setMaturityDateLbl:nil];
    [super viewDidUnload];
}
- (IBAction)PremiumAction:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_Premium.text = [formatter stringFromNumber:[formatter numberFromString:_Premium.text]];
}

- (IBAction)ProjectedValueAction:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_ProjectedValue.text = [formatter stringFromNumber:[formatter numberFromString:_ProjectedValue.text]];
}

- (IBAction)doDelete:(id)sender {
    EducationPlans *parent = (EducationPlans *) self.parentViewController;
    [parent doDelete:self.rowToUpdate];
}

//fix bug 2608 start
- (IBAction)actionForStartDate:(id)sender {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    
    if (_SIDate == Nil) {
        
        self.SIDate = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIDate"];
        _SIDate.delegate = self;
        self.SIDatePopover = [[UIPopoverController alloc] initWithContentViewController:_SIDate];
    }
    
    [self.SIDatePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.SIDatePopover presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    
    dateFormatter = Nil;
	dateString = nil;
	_startDateLbl.text = dateString;
	mainStoryboard = nil;
	_btn = 12;
}

- (IBAction)actionForMaturityDate:(id)sender {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    
    if (_SIDate2 == Nil) {
        
        self.SIDate2 = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIDate"];
        _SIDate2.delegate = self;
        self.SIDatePopover2 = [[UIPopoverController alloc] initWithContentViewController:_SIDate2];
    }
    
    [self.SIDatePopover2 setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.SIDatePopover2 presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    
    dateFormatter = Nil;
	dateString = nil;
	_maturityDateLbl.text = dateString;
	mainStoryboard = nil;
	_btn = 13;
}

-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
	if (_btn == 12) {
		_startDateLbl.text = strDate;
	}
    else if (_btn == 13) {
		_maturityDateLbl.text = strDate;
	}
	//	_dobLbl.textColor = [UIColor blackColor];
}

-(void)CloseWindow
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [self.SIDatePopover dismissPopoverAnimated:YES];
	[self.SIDatePopover2 dismissPopoverAnimated:YES];
}
//fix bug 2608 end

@end
