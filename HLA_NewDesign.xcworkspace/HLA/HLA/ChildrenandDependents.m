//
//  ChildrenandDependents.m
//  iMobile Planner
//
//  Created by Juliana on 7/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ChildrenandDependents.h"
#import "ColorHexCode.h"
#import "DataClass.h"
#import "ChildrenDependents.h"

#define NUMBERS_ONLY @"1234567890"
#define CHARACTER_LIMIT3 3
#define CHARACTER_LIMIT15 16
#define CHARACTER_LIMIT70 70
#define CHARACTER_LIMIT100 100


@interface ChildrenandDependents (){
    DataClass *obj;
}

@end

@implementation ChildrenandDependents
void UIKeyboardOrderOutAutomatic();

@synthesize btn1;

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
    
    _childName.delegate = self;
    _childAge.delegate = self;
    _childSupport.delegate = self;
    
    
    if (self.rowToUpdate == 0){
        _childName.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Name"];
        
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Sex"] isEqualToString:@""]){
            [_childGender setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Sex"] isEqualToString:@"Male"]){
            [_childGender setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Sex"] isEqualToString:@"Female"]){
            [_childGender setSelectedSegmentIndex:1];
        }
        _childDOB.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1DOB"];
        _childAge.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Age"];
        _relationship.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Relationship"];
        _childSupport.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Support"];
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden1"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
            self.selectBtn.hidden = TRUE;
            self.quickBtn.hidden = TRUE;
            self.deleteBtn.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = FALSE;
            self.deleteBtn.hidden = TRUE;
            self.selectBtn.hidden = FALSE;
            self.quickBtn.hidden = FALSE;
        }
    }
    else if (self.rowToUpdate == 1){
        _childName.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Name"];
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Sex"] isEqualToString:@""]){
            [_childGender setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Sex"] isEqualToString:@"Male"]){
            [_childGender setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Sex"] isEqualToString:@"Female"]){
            [_childGender setSelectedSegmentIndex:1];
        }
        _childDOB.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2DOB"];
        _childAge.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Age"];
        _relationship.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Relationship"];
        _childSupport.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Support"];
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden2"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
            self.selectBtn.hidden = TRUE;
            self.quickBtn.hidden = TRUE;
            self.deleteBtn.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = FALSE;
            self.deleteBtn.hidden = TRUE;
            self.selectBtn.hidden = FALSE;
            self.quickBtn.hidden = FALSE;
        }
    }
    else if (self.rowToUpdate == 2){
        _childName.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Name"];
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Sex"] isEqualToString:@""]){
            [_childGender setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Sex"] isEqualToString:@"Male"]){
            [_childGender setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Sex"] isEqualToString:@"Female"]){
            [_childGender setSelectedSegmentIndex:1];
        }
        _childDOB.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3DOB"];
        _childAge.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Age"];
        _relationship.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Relationship"];
        _childSupport.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Support"];
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden3"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
            self.selectBtn.hidden = TRUE;
            self.quickBtn.hidden = TRUE;
            self.deleteBtn.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = FALSE;
            self.deleteBtn.hidden = TRUE;
            self.selectBtn.hidden = FALSE;
            self.quickBtn.hidden = FALSE;
        }
    }
    else if (self.rowToUpdate == 3){
        _childName.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Name"];
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Sex"] isEqualToString:@""]){
            [_childGender setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Sex"] isEqualToString:@"Male"]){
            [_childGender setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Sex"] isEqualToString:@"Female"]){
            [_childGender setSelectedSegmentIndex:1];
        }
        _childDOB.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4DOB"];
        _childAge.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Age"];
        _relationship.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Relationship"];
        _childSupport.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Support"];
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden4"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
            self.selectBtn.hidden = TRUE;
            self.quickBtn.hidden = TRUE;
            self.deleteBtn.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = FALSE;
            self.deleteBtn.hidden = TRUE;
            self.selectBtn.hidden = FALSE;
            self.quickBtn.hidden = FALSE;
        }
    }
    else if (self.rowToUpdate == 4){
        _childName.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Name"];
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Sex"] isEqualToString:@""]){
            [_childGender setSelectedSegmentIndex:UISegmentedControlNoSegment];
        }
        else if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Sex"] isEqualToString:@"Male"]){
            [_childGender setSelectedSegmentIndex:0];
        }
        else if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Sex"] isEqualToString:@"Female"]){
            [_childGender setSelectedSegmentIndex:1];
        }
        _childDOB.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5DOB"];
        _childAge.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Age"];
        _relationship.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Relationship"];
        _childSupport.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Support"];
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden5"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
            self.selectBtn.hidden = TRUE;
            self.quickBtn.hidden = TRUE;
            self.deleteBtn.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = FALSE;
            self.deleteBtn.hidden = TRUE;
            self.selectBtn.hidden = FALSE;
            self.quickBtn.hidden = FALSE;
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == _childName){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return ((newLength <= CHARACTER_LIMIT70));
    }
    else if (textField == _childAge){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT3));
    }
    else if (textField == _childSupport){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
		//fix for bug 2623 start
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT3));
		//fix for bug 2623 end
    }
    return FALSE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)doDone:(id)sender {
    
    
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: NSLocalizedString(@"iMobile Planner",nil)
                          message: NSLocalizedString(@"Update to list?",nil)
                          delegate: self
                          cancelButtonTitle: NSLocalizedString(@"Yes",nil)
                          otherButtonTitles: NSLocalizedString(@"No",nil), nil];
    [alert setTag:1001];
    [alert show];
    alert = Nil;
    
    
    
	    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001)
    {
        [self dismissViewControllerAnimated:TRUE completion:nil];
    }
}

- (void)viewDidUnload {
	[self setBtn1:nil];
    [self setRelationship:nil];
    [self setChildName:nil];
    [self setChildGender:nil];
    [self setChildDOB:nil];
    [self setChildAge:nil];
    [self setChildSupport:nil];
    [self setDeleteCell:nil];
    [self setDeleteBtn:nil];
    [self setSelectBtn:nil];
    [self setQuickBtn:nil];
	[super viewDidUnload];
}

- (IBAction)clickBtn1:(id)sender {
	btn1.selected = !btn1.selected;
	if (btn1.selected) {
		[btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
	}
	else {
		[btn1 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
	}
}

-(void)selectedRship:(NSString *)selectedRship{
    [_relationship setText:selectedRship];

    if (_RshipTypePickerPopover) {
        [_RshipTypePickerPopover dismissPopoverAnimated:YES];
        _RshipTypePickerPopover = nil;
    }
}

- (IBAction)doRelationship:(id)sender {
    [self.view endEditing:YES];
    UIKeyboardOrderOutAutomatic();
    
    _RshipTypePicker.rowToUpdate = _rowToUpdate;
    if (_RshipTypePicker == nil) {
        _RshipTypePicker = [[RelationshipPopoverViewController alloc] initWithStyle:UITableViewStylePlain];
        _RshipTypePicker.delegate = self;
        _RshipTypePicker.rowToUpdate = _rowToUpdate;
    }
    
    if (_RshipTypePickerPopover == nil) {
        
        _RshipTypePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_RshipTypePicker];
        [_RshipTypePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    } else {
        [_RshipTypePickerPopover dismissPopoverAnimated:YES];
        _RshipTypePickerPopover = nil;
    }

}

- (IBAction)doChildName:(id)sender {
}

- (IBAction)doChildDOB:(id)sender {

    [self.view endEditing:YES];
    UIKeyboardOrderOutAutomatic();
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    //_childDOB.text = dateString;
	//_childDOB.textColor = [UIColor blackColor];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:Nil];
    
    if (_SIDate == Nil) {
        
        self.SIDate = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIDate_DOB"];
        _SIDate.delegate = self;
        _SIDate.rowToUpdate = _rowToUpdate;
        
        //NSLog(@"III%@",_childDOB.text);
        _SIDate.receivedDOB = _childDOB.text;
        self.SIDatePopover = [[UIPopoverController alloc] initWithContentViewController:_SIDate];
    }
    
    //_SIDate.receivedDOB = _childDOB.text;
    [self.SIDatePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.SIDatePopover presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:NO];
    
    
    dateFormatter = Nil;
    dateString = Nil, mainStoryboard = nil;
}

-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    [fmtDate setDateFormat:@"dd/MM/yyyy"];
    
    _childDOB.text = strDate;
	_childDOB.textColor = [UIColor blackColor];
    

    NSDate* dob = [fmtDate dateFromString:_childDOB.text];
    NSDate* now = [NSDate date];
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSYearCalendarUnit
                                       fromDate:dob
                                       toDate:now
                                       options:0];
    NSInteger age = [ageComponents year];
    
    
    _childAge.text = [NSString stringWithFormat:@"%d", age];
    _childAge.enabled = FALSE;
    _childAge.textColor = [UIColor blackColor];
    
    
    
}

-(void)ClearDateSelected:(NSString *)strDate :(NSString *)dbDate
{
    _childDOB.text = @"";
    _childAge.text = @"";
    _childAge.enabled = TRUE;
    _childAge.textColor = [UIColor blackColor];
	//_childDOB.textColor = [UIColor blackColor];
}

-(void)CloseWindow
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [self.SIDatePopover dismissPopoverAnimated:YES];
}

-(void)ClearCloseWindow
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [self.SIDatePopover dismissPopoverAnimated:YES];
}


- (IBAction)doChildAge:(id)sender {
}

- (IBAction)doChildSupport:(id)sender {
}
- (IBAction)doDelete:(id)sender {
    ChildrenDependents *parent = (ChildrenDependents *) self.parentViewController;
    [parent doDelete:self.rowToUpdate];
}
- (IBAction)doSelect:(id)sender {
    
    _childName.enabled = FALSE;
    _childGender.enabled = FALSE;
    _childDOB.enabled = FALSE;
    _childAge.enabled = FALSE;
    
    _childName.text = @"";
    _childGender.selectedSegmentIndex = UISegmentedControlNoSegment;
    _childDOB.text = @"";
    _childAge.text = @"";
    _childSupport.text = @"";
    _relationship.text = @"";
    
    if (self.prospectList == nil) {
        self.prospectList = [[ListingTbViewController alloc] initWithStyle:UITableViewStylePlain];
        self.prospectList.delegate = self;
        self.prospectPopover = [[UIPopoverController alloc] initWithContentViewController:self.prospectList];
    }
    [self.prospectPopover presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
}

- (IBAction)doQuick:(id)sender {
    
    _childName.enabled = TRUE;
    _childGender.enabled = TRUE;
    _childDOB.enabled = TRUE;
    _childAge.enabled = TRUE;
    
    _childName.text = @"";
    _childGender.selectedSegmentIndex = UISegmentedControlNoSegment;
    _childDOB.text = @"";
    _childAge.text = @"";
    _childSupport.text = @"";
    _relationship.text = @"";
}

#pragma mark - delegate
-(void)listing:(ListingTbViewController *)inController didSelectIndex:(NSString *)aaIndex andName:(NSString *)aaName andDOB:(NSString *)aaDOB andGender:(NSString *)aaGender andOccpCode:(NSString *)aaCode andSmoker:(NSString *)aaSmoker {
    
    _childName.text = aaName;
    if ([aaGender isEqualToString:@""]){
        [_childGender setSelectedSegmentIndex:UISegmentedControlNoSegment];
    }
    else if ([aaGender hasPrefix:@"M"]){
        [_childGender setSelectedSegmentIndex:0];
    }
    else if ([aaGender hasPrefix:@"F"]){
        [_childGender setSelectedSegmentIndex:1];
    }
    _childDOB.text = aaDOB;
    
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    [fmtDate setDateFormat:@"dd/MM/yyyy"];
    NSDate *startDate = [fmtDate dateFromString:aaDOB];
    NSString *textDate = [NSString stringWithFormat:@"%@",[fmtDate stringFromDate:[NSDate date]]];
    NSDate *endDate = [fmtDate dateFromString:textDate];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSYearCalendarUnit
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];
    _childAge.text = [NSString stringWithFormat:@"%d",[components year]];
    [self.prospectPopover dismissPopoverAnimated:YES];
}
@end
