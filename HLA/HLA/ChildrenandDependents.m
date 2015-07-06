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
#import "textFields.h"
#import "SelectPartner.h"

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
@synthesize ClientProfileID;
@synthesize addFromCFF;

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
    _childName.autocapitalizationType = UITextAutocapitalizationTypeWords;

    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    

    
    
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
		ClientProfileID = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1ClientProfileID"];
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden1"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
            self.selectBtn.hidden = FALSE;
            self.quickBtn.hidden = TRUE;
            self.deleteBtn.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
            self.deleteBtn.hidden = TRUE;
            self.selectBtn.hidden = FALSE;
            self.quickBtn.hidden = FALSE;
        }
        
        FMDatabase *database = [FMDatabase databaseWithPath:path];
        [database open];
        bool fromSelect = FALSE;
        FMResultSet *result = [database executeQuery:@"select ProspectDOB from prospect_profile where ProspectName = ?", _childName.text];
        while ([result next]) {
            if ([_childDOB.text isEqualToString:[result stringForColumn:@"ProspectDOB"]]) {
                fromSelect = TRUE;
            }
        }
        
        [database close];
        
        if (fromSelect) {
            addFromCFF = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1addFromCFF"];
            [[obj.CFFData objectForKey:@"SecC"]  setValue:@"1" forKey:@"Childen1addFromCFF"];
            
        }else{
            addFromCFF = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1addFromCFF"];
            [[obj.CFFData objectForKey:@"SecC"]  setValue:@"0" forKey:@"Childen1addFromCFF"];
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
		ClientProfileID = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2ClientProfileID"];
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden2"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
            self.selectBtn.hidden = FALSE;
            self.quickBtn.hidden = TRUE;
            self.deleteBtn.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
            self.deleteBtn.hidden = TRUE;
            self.selectBtn.hidden = FALSE;
            self.quickBtn.hidden = FALSE;
        }
        
        FMDatabase *database = [FMDatabase databaseWithPath:path];
        [database open];
        bool fromSelect = FALSE;
        FMResultSet *result = [database executeQuery:@"select ProspectDOB from prospect_profile where ProspectName = ?", _childName.text];
        while ([result next]) {
            if ([_childDOB.text isEqualToString:[result stringForColumn:@"ProspectDOB"]]) {
                fromSelect = TRUE;
            }
        }
        
        [database close];
        
        if (fromSelect) {
            addFromCFF = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2addFromCFF"];
            [[obj.CFFData objectForKey:@"SecC"]  setValue:@"1" forKey:@"Childen2addFromCFF"];
            
        }else{
            addFromCFF = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2addFromCFF"];
            [[obj.CFFData objectForKey:@"SecC"]  setValue:@"0" forKey:@"Childen2addFromCFF"];
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
		ClientProfileID = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3ClientProfileID"];
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden3"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
            self.selectBtn.hidden = FALSE;
            self.quickBtn.hidden = TRUE;
            self.deleteBtn.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
            self.deleteBtn.hidden = TRUE;
            self.selectBtn.hidden = FALSE;
            self.quickBtn.hidden = FALSE;
        }
        
        FMDatabase *database = [FMDatabase databaseWithPath:path];
        [database open];
        bool fromSelect = FALSE;
        FMResultSet *result = [database executeQuery:@"select ProspectDOB from prospect_profile where ProspectName = ?", _childName.text];
        while ([result next]) {
            if ([_childDOB.text isEqualToString:[result stringForColumn:@"ProspectDOB"]]) {
                fromSelect = TRUE;
            }
        }
        
        [database close];

        if (fromSelect) {
            addFromCFF = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3addFromCFF"];
            [[obj.CFFData objectForKey:@"SecC"]  setValue:@"1" forKey:@"Childen3addFromCFF"];
            
        }else{
            addFromCFF = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3addFromCFF"];
            [[obj.CFFData objectForKey:@"SecC"]  setValue:@"0" forKey:@"Childen3addFromCFF"];
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
		ClientProfileID = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4ClientProfileID"];
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden4"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
            self.selectBtn.hidden = FALSE;
            self.quickBtn.hidden = TRUE;
            self.deleteBtn.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
            self.deleteBtn.hidden = TRUE;
            self.selectBtn.hidden = FALSE;
            self.quickBtn.hidden = FALSE;
        }
        
        FMDatabase *database = [FMDatabase databaseWithPath:path];
        [database open];
        bool fromSelect = FALSE;
        FMResultSet *result = [database executeQuery:@"select ProspectDOB from prospect_profile where ProspectName = ?", _childName.text];
        while ([result next]) {
            if ([_childDOB.text isEqualToString:[result stringForColumn:@"ProspectDOB"]]) {
                fromSelect = TRUE;
            }
        }
        
        [database close];
        
        if (fromSelect) {
            addFromCFF = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4addFromCFF"];
            [[obj.CFFData objectForKey:@"SecC"]  setValue:@"1" forKey:@"Childen4addFromCFF"];
            
        }else{
            addFromCFF = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4addFromCFF"];
            [[obj.CFFData objectForKey:@"SecC"]  setValue:@"0" forKey:@"Childen4addFromCFF"];
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
		ClientProfileID = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5ClientProfileID"];
        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden5"] isEqualToString:@"1"]){
            _deleteCell.hidden = FALSE;
            self.selectBtn.hidden = FALSE;
            self.quickBtn.hidden = TRUE;
            self.deleteBtn.hidden = FALSE;
        }
        else{
            _deleteCell.hidden = TRUE;
            self.deleteBtn.hidden = TRUE;
            self.selectBtn.hidden = FALSE;
            self.quickBtn.hidden = FALSE;
        }
        
        FMDatabase *database = [FMDatabase databaseWithPath:path];
        [database open];
        bool fromSelect = FALSE;
        FMResultSet *result = [database executeQuery:@"select ProspectDOB from prospect_profile where ProspectName = ?", _childName.text];
        while ([result next]) {
            if ([_childDOB.text isEqualToString:[result stringForColumn:@"ProspectDOB"]]) {
                fromSelect = TRUE;
            }
        }
        
        [database close];
        

        if (fromSelect) {
            addFromCFF = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5addFromCFF"];
            [[obj.CFFData objectForKey:@"SecC"]  setValue:@"1" forKey:@"Childen5addFromCFF"];
            
        }else{
            addFromCFF = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5addFromCFF"];
            [[obj.CFFData objectForKey:@"SecC"]  setValue:@"0" forKey:@"Childen5addFromCFF"];
        }
        
    }
    
    if (_childDOB.text.length != 0) {
        [self calculateAge];
        _childAge.enabled = FALSE;
        _childAge.textColor = [UIColor grayColor];
    }
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docsPath = [paths objectAtIndex:0];
//    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    bool fromSelect = FALSE;
    FMResultSet *result = [database executeQuery:@"select ProspectDOB from prospect_profile where ProspectName = ?", _childName.text];
    while ([result next]) {
        if ([_childDOB.text isEqualToString:[result stringForColumn:@"ProspectDOB"]]) {
            fromSelect = TRUE;
        }
    }
    
    [database close];
    
    if (fromSelect) {
        _childName.enabled = FALSE;
        _childGender.enabled = FALSE;
        _childDOB.enabled = FALSE;
        _childAge.enabled = FALSE;
        _dobBtn.enabled = FALSE;
        
        _childName.textColor = [UIColor grayColor];
        _childDOB.textColor = [UIColor grayColor];
        _childAge.textColor = [UIColor grayColor];
        
    }
    
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UITextField class]] ||
        [touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }
    return YES;
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
                          initWithTitle: NSLocalizedString(@" ",nil)
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
    [self setDobBtn:nil];
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
    NSDate *selected = [fmtDate dateFromString:strDate];
    NSDate *today = [NSDate date];
    
    /*if ([selected compare:today] == NSOrderedAscending) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Date should not greater than current date." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
        return;
    }*/
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSInteger components = (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit);
        
        NSDateComponents *firstComponents = [calendar components:components fromDate:selected];
        NSDateComponents *secondComponents = [calendar components:components fromDate:today];
        
        NSDate *date1 = [calendar dateFromComponents:firstComponents];
        NSDate *date2 = [calendar dateFromComponents:secondComponents];
        
        NSComparisonResult result = [date1 compare:date2];
        if (result == NSOrderedDescending) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Date should not greater than current date." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = nil;
            return;
        }
    
    _childDOB.text = strDate;
	_childDOB.textColor = [UIColor blackColor];
    

    [self calculateAge];
    _childAge.enabled = FALSE;
    _childAge.textColor = [UIColor grayColor];
    
    
    
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
    
    /*if (self.prospectList == nil) {
        self.prospectList = [[ListingTbViewController alloc] initWithStyle:UITableViewStylePlain];
        self.prospectList.delegate = self;
        self.prospectList.needFiltered = NO;
        //self.prospectList.blacklistedIndentificationNos = [NSString stringWithFormat:@"('%@')", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerNRIC"]];
        self.prospectPopover = [[UIPopoverController alloc] initWithContentViewController:self.prospectList];
    }
    
    //CGRect rect = [sender frame];
    //rect.size.width = 1;
    self.prospectPopover.popoverLayoutMargins = UIEdgeInsetsMake(190, 0, 0, 0);
    
    [self.prospectPopover presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:NO];*/
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
    SelectPartner *selectPartner = [secondStoryBoard instantiateViewControllerWithIdentifier:@"SelectChildrenDependents"];
    selectPartner.delegate = self;
    selectPartner.child = TRUE;
    [self presentViewController:selectPartner animated:YES completion:nil];
}

- (IBAction)doQuick:(id)sender {
    
    _childName.enabled = TRUE;
    _childGender.enabled = TRUE;
    _childDOB.enabled = TRUE;
    _childAge.enabled = FALSE;
    
    _childName.textColor = [UIColor blackColor];
    _childDOB.textColor = [UIColor blackColor];
    _childAge.textColor = [UIColor grayColor];
    
    _childName.text = @"";
    _childGender.selectedSegmentIndex = UISegmentedControlNoSegment;
    _childDOB.text = @"";
    _childAge.text = @"";
    _childSupport.text = @"";
    _relationship.text = @"";
	ClientProfileID = @"";
}

#pragma mark - delegate
-(void)listing:(ListingTbViewController *)inController didSelectIndex:(NSString *)aaIndex andName:(NSString *)aaName andDOB:(NSString *)aaDOB andGender:(NSString *)aaGender andOccpCode:(NSString *)aaCode andSmoker:(NSString *)aaSmoker {
    
    if ([aaIndex isEqualToString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"customerIndexNo"]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Children and Dependent cannot be the same person with CFF’s Payor" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
        return;
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results;
    
    results = [database executeQuery:@"select * from prospect_profile where IndexNo = ?",aaIndex];
    bool company = FALSE;
    bool partner = FALSE;
    while ([results next]) {
        NSString *otherIDType = [results objectForColumnName:@"OtherIDType"];
		
        //NSString *nric = [results objectForColumnName:@"IDTypeNo"];
        //NSString *otherIDTypeNo = [results objectForColumnName:@"OtherIDTypeNo"];
        if (([[textFields trimWhiteSpaces:otherIDType] caseInsensitiveCompare:@"Company Registration Number"] == NSOrderedSame) || ([[textFields trimWhiteSpaces:otherIDType] caseInsensitiveCompare:@"CR"] == NSOrderedSame)) {
            company = TRUE;
        }
        /*else if ([[textFields trimWhiteSpaces:nric] caseInsensitiveCompare:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerNric"]] == NSOrderedSame) {
            partner = TRUE;
        }
        else if ([[textFields trimWhiteSpaces:otherIDType] caseInsensitiveCompare:[textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOtherIDType"]]] == NSOrderedSame) {
            if ([[textFields trimWhiteSpaces:otherIDTypeNo] caseInsensitiveCompare:[textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOtherID"]]] == NSOrderedSame) {
                partner = TRUE;
            }
        }*/
        else if (([[textFields trimWhiteSpaces:otherIDType] caseInsensitiveCompare:@"Expected Delivery Date"] == NSOrderedSame) || ([[textFields trimWhiteSpaces:otherIDType] caseInsensitiveCompare:@"EDD"] == NSOrderedSame)){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Customer with Expected Delivery Date cannot be Children and Dependents for CFF’s customer. Please reselect or key in correct information in order to proceed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = nil;
            return;
        }
    }
    if (company) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Company cannot be the children and dependent for a CFF's payor." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
        return;
    }
    else if (partner) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Children and Dependent cannot be the same person with CFF’s Partner/Spouse." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
        return;
    }
    
    bool exist = FALSE;
    for (int i = 1; i < 5; i++) {
        NSString *nameKey = [NSString stringWithFormat:@"Childen%dName", i];
        NSString *dobKey = [NSString stringWithFormat:@"Childen%dDOB", i];
        NSString *IDkey = [NSString stringWithFormat:@"Childen%dClientProfileID", i];
		
        NSString *name = [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:nameKey]];
        NSString *dob = [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:dobKey]];
		ClientProfileID = [[obj.CFFData objectForKey:@"SecC"] objectForKey:IDkey];
        
        if ([[textFields trimWhiteSpaces:aaName] isEqualToString:name] && self.rowToUpdate != i-1) {
            if ([[textFields trimWhiteSpaces:aaDOB] isEqualToString:dob]) {
                exist = TRUE;
                break;
            }
        }
    }
    
    if (exist) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Same Children and Dependents’ already exist." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
        return;
    }
    
    _childName.enabled = FALSE;
    _childGender.enabled = FALSE;
    _childDOB.enabled = FALSE;
    _childAge.enabled = FALSE;
    _dobBtn.enabled = FALSE;
    
    _childName.textColor = [UIColor grayColor];
    _childDOB.textColor = [UIColor grayColor];
    _childAge.textColor = [UIColor grayColor];
    
    _childName.text = @"";
    _childGender.selectedSegmentIndex = UISegmentedControlNoSegment;
    _childDOB.text = @"";
    _childAge.text = @"";
    _childSupport.text = @"";
    _relationship.text = @"";
    
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
    
    [self calculateAge];
    [self.prospectPopover dismissPopoverAnimated:YES];
}

-(void)DisplayPartnerCFF:(int)indexNo clientName:(NSString *)clientName clientID:(NSString *)clientID {
    
    NSString *indexString = [NSString stringWithFormat:@"%d", indexNo];
    NSString *clientDOB;
    NSString *clientGender;
	//NSLog(@"IndexString: %@, equal: %@", indexString, [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"customerIndexNo"]);
    if ([indexString isEqualToString:[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"customerIndexNo"]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Children and Dependent cannot be the same person with CFF’s Payor" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
        return;
    }
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:indexString forKey:@"SelectedClientProfileID"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results;
    
    results = [database executeQuery:@"select * from prospect_profile where IndexNo = ?",indexString];
    bool company = FALSE;
    bool partner = FALSE;
    while ([results next]) {
        NSString *otherIDType = [results objectForColumnName:@"OtherIDType"];
        clientGender = [results stringForColumn:@"ProspectGender"];
        clientDOB = [results stringForColumn:@"ProspectDOB"];
		
        if (([[textFields trimWhiteSpaces:otherIDType] caseInsensitiveCompare:@"Company Registration Number"] == NSOrderedSame)|| ([[textFields trimWhiteSpaces:otherIDType] caseInsensitiveCompare:@"CR"] == NSOrderedSame)) {
            company = TRUE;
        }
        else if (([[textFields trimWhiteSpaces:otherIDType] caseInsensitiveCompare:@"Expected Delivery Date"] == NSOrderedSame) || ([[textFields trimWhiteSpaces:otherIDType] caseInsensitiveCompare:@"EDD"] == NSOrderedSame)){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Customer with Expected Delivery Date cannot be Children and Dependents for CFF’s customer. Please reselect or key in correct information in order to proceed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = nil;
            return;
        }
    }
    if (company) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Company cannot be the children and dependent for a CFF's payor." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
        return;
    }
    else if (partner) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Children and Dependent cannot be the same person with CFF’s Partner/Spouse." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
        return;
    }
    
    bool exist = FALSE;
    for (int i = 1; i < 5; i++) {
        NSString *nameKey = [NSString stringWithFormat:@"Childen%dName", i];
        NSString *dobKey = [NSString stringWithFormat:@"Childen%dDOB", i];
		NSString *IDKey = [NSString stringWithFormat:@"Childen%dClientProfileID", i];
        
        NSString *name = [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:nameKey]];
        NSString *dob = [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:dobKey]];
		ClientProfileID = [textFields trimWhiteSpaces:[[obj.CFFData objectForKey:@"SecC"] objectForKey:IDKey]];
        
        if ([[textFields trimWhiteSpaces:clientName] isEqualToString:name] && self.rowToUpdate != i-1) {
            if ([[textFields trimWhiteSpaces:clientDOB] isEqualToString:dob]) {
                exist = TRUE;
                break;
            }
        }
    }
    
    if (exist) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Same Children and Dependents’ already exist." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
        return;
    }
    
    _childName.enabled = FALSE;
    _childGender.enabled = FALSE;
    _childDOB.enabled = FALSE;
    _childAge.enabled = FALSE;
    _dobBtn.enabled = FALSE;
    
    _childName.textColor = [UIColor grayColor];
    _childDOB.textColor = [UIColor grayColor];
    _childAge.textColor = [UIColor grayColor];
    
    _childName.text = @"";
    _childGender.selectedSegmentIndex = UISegmentedControlNoSegment;
    _childDOB.text = @"";
    _childAge.text = @"";
    _childSupport.text = @"";
    _relationship.text = @"";
	ClientProfileID = @"";
    
    _childName.text = clientName;
    if ([clientGender isEqualToString:@""]){
        [_childGender setSelectedSegmentIndex:UISegmentedControlNoSegment];
    }
    else if ([clientGender hasPrefix:@"M"]){
        [_childGender setSelectedSegmentIndex:0];
    }
    else if ([clientGender hasPrefix:@"F"]){
        [_childGender setSelectedSegmentIndex:1];
    }
    _childDOB.text = clientDOB;
    
    [self calculateAge];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - age formula
-(void)calculateAge {
    
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    [fmtDate setDateFormat:@"dd/MM/yyyy"];
    NSString *textDate = [NSString stringWithFormat:@"%@",[fmtDate stringFromDate:[NSDate date]]];
    
    NSArray *curr = [textDate componentsSeparatedByString: @"/"];
    NSString *currentDay = [curr objectAtIndex:0];
    NSString *currentMonth = [curr objectAtIndex:1];
    NSString *currentYear = [curr objectAtIndex:2];
    
    NSArray *foo = [_childDOB.text componentsSeparatedByString: @"/"];
    NSString *birthDay = [foo objectAtIndex: 0];
    NSString *birthMonth = [foo objectAtIndex: 1];
    NSString *birthYear = [foo objectAtIndex: 2];
    
    int yearN = [currentYear intValue];
    int yearB = [birthYear intValue];
    int monthN = [currentMonth intValue];
    int monthB = [birthMonth intValue];
    int dayN = [currentDay intValue];
    int dayB = [birthDay intValue];
    
    int ALB = yearN - yearB;
    int newALB;
    int newANB;
    
    NSString *msgAge;
    if (yearN > yearB)
    {
        if (monthN < monthB) {
            newALB = ALB - 1;
        } else if (monthN == monthB && dayN < dayB) {
            newALB = ALB - 1;
        } else {
            newALB = ALB;
        }
        
        if (monthN > monthB) {
            newANB = ALB + 1;
        } else if (monthN == monthB && dayN >= dayB) {
            newANB = ALB + 1;
        } else {
            newANB = ALB;
        }
    }
    else {
        newALB = 0;
    }
    msgAge = [[NSString alloc] initWithFormat:@"%d",newALB];
    _childAge.text = msgAge;
}

#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
        // create the parent view that will hold header Label
        UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(400.0, 0.0, 100.0, 100.0)];
        customView.backgroundColor = [UIColor clearColor];
        
        // create the button object
        UIButton * headerBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        headerBtn.backgroundColor = [UIColor clearColor];
        //headerBtn.opaque = NO;
        headerBtn.frame = CGRectMake(403.0, 15.0, 100.0, 30.0);
        
        [headerBtn setTitle:@"Clear All" forState:UIControlStateNormal];
        
        [headerBtn setBackgroundImage:[UIImage imageNamed:@"merahBtn.png"]
                             forState:UIControlStateNormal];
        [headerBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        
        [headerBtn addTarget:self action:@selector(ActionEventForButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [customView addSubview:headerBtn];
        
        return customView;
}

#pragma mark - action
-(IBAction)ActionEventForButton:(id)sender
{
    _childName.text = @"";
    _childGender.selectedSegmentIndex = -1;
    _childDOB.text = @"";
    _childAge.text = @"";
    _relationship.text = @"";
    _childSupport.text = @"";
    
    _childName.enabled = TRUE;
    _childGender.enabled = TRUE;
    _childSupport.enabled = TRUE;
    _dobBtn.enabled = TRUE;
    _childAge.enabled = FALSE;
    
    _childName.textColor = [UIColor blackColor];
    _childDOB.textColor = [UIColor blackColor];
    _childAge.textColor = [UIColor grayColor];
    
    if (self.rowToUpdate == 0){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen1DOB"];
    }
    else if (self.rowToUpdate == 1){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen2DOB"];
    }
    else if (self.rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen3DOB"];
    }
    else if (self.rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen4DOB"];
    }
    else if (self.rowToUpdate == 4){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"Childen5DOB"];
    }
}
@end
