//
//  PartnerViewController.m
//  iMobile Planner
//
//  Created by Meng Cheong on 8/30/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "PartnerViewController.h"
#import "DataClass.h"


@interface PartnerViewController (){
    DataClass *obj;
}

@end

@implementation PartnerViewController

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
    
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerReadOnly"] isEqualToString:@"1"]){
        _PartnerTitle.enabled = FALSE;
        _name.enabled = FALSE;
        _IDTypeNo.enabled = FALSE;
        _otherIDType.enabled = FALSE;
        _otherIDTypeNo.enabled = FALSE;
        _race.enabled = FALSE;
        _religion.enabled = FALSE;
        _nationality.enabled = FALSE;
        _gender.enabled = FALSE;
        _smoker.enabled = FALSE;
        _DOB.enabled = FALSE;
        _age.enabled = FALSE;
        _maritalStatus.enabled = FALSE;
        _mailingAddressForeign.enabled = FALSE;
        _mailingAddress1.enabled = FALSE;
        _mailingAddress2.enabled = FALSE;
        _mailingAddress3.enabled = FALSE;
        _mailingAddressPostcode.enabled = FALSE;
        _mailingAddressTown.enabled = FALSE;
        _mailingAddressState.enabled = FALSE;
        _mailingAddressCountry.enabled = FALSE;
        
        _titlePickerBtn.hidden = TRUE;
        _otherIDTypePickerBtn.hidden = TRUE;
        _racePickerBtn.hidden = TRUE;
        _nationalityPickerBtn.hidden = TRUE;
        
        _mailingAddressCountryPickerBtn.hidden = TRUE;
        _permanentAddressCountryPickerBtn.hidden = TRUE;
    }
    
    _PartnerTitle.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerTitle"];
    _name.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerName"];
    _IDTypeNo.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerNRIC"];
    _otherIDType.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOtherIDType"];
    _otherIDTypeNo.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOtherID"];
    _race.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerRace"];
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerReligion"] isEqualToString:@"Muslim"]){
        [_religion setSelectedSegmentIndex:0];
    }
    else{
        [_religion setSelectedSegmentIndex:1];
    }
    _nationality.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerNationality"];
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerSex"] isEqualToString:@"M"]){
        [_gender setSelectedSegmentIndex:0];
    }
    else{
        [_gender setSelectedSegmentIndex:1];
    }
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerSmoker"] isEqualToString:@"Y"]){
        [_smoker setSelectedSegmentIndex:0];
    }
    else{
        [_smoker setSelectedSegmentIndex:1];
    }
    _DOB.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerDOB"];
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMaritalStatus"] isEqualToString:@"Divorced"]){
        [_maritalStatus setSelectedSegmentIndex:0];
    }
    else if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMaritalStatus"] isEqualToString:@"Married"]){
        [_maritalStatus setSelectedSegmentIndex:1];
    }
    else if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMaritalStatus"] isEqualToString:@"Single"]){
        [_maritalStatus setSelectedSegmentIndex:2];
    }
    else if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMaritalStatus"] isEqualToString:@"Widow"]){
        [_maritalStatus setSelectedSegmentIndex:3];
    }
    else if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMaritalStatus"] isEqualToString:@"Widower"]){
        [_maritalStatus setSelectedSegmentIndex:4];
    }
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressForeign"] isEqualToString:@"0"]){
        [_mailingAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    }
    else{
        [_mailingAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
    }
    _mailingAddress1.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress1"];
    _mailingAddress2.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress2"];
    _mailingAddress3.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddress3"];
    _mailingAddressPostcode.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingPostcode"];
    _mailingAddressTown.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressTown"];
    _mailingAddressState.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressState"];
    _mailingAddressCountry.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMailingAddressCountry"];
    
    
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddressForeign"] isEqualToString:@"0"]){
        [_permanentAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    }
    else{
        [_permanentAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
    }
    _permanentAddress1.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddress1"];
    _permanentAddress2.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddress2"];
    _permanentAddress3.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddress3"];
    _permanentAddressPostcode.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentPostcode"];
    _permanentAddressTown.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddressTown"];
    _permanentAddressState.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddressState"];
    _permanentAddressCountry.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerPermanentAddressCountry"];
    
    _residenceTelExt.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerResidenceTelExt"];
    _residenceTel.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerResidenceTel"];
    
    _officeTelExt.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOfficeTelExt"];
    _officeTel.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerOfficeTel"];
	
	_mobileTelExt.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMobileTelExt"];
    _mobileTel.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerMobileTel"];
    
    _faxExt.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerFaxTelExt"];
    _fax.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerFaxTel"];
    
    _email.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerEmail"];
    
    
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    [fmtDate setDateFormat:@"dd/mm/yyyy"];
    NSDate *startDate = [fmtDate dateFromString:_DOB.text];
    NSString *textDate = [NSString stringWithFormat:@"%@",[fmtDate stringFromDate:[NSDate date]]];
    NSDate *endDate = [fmtDate dateFromString:textDate];
    
    NSDateComponents* components = [[NSCalendar currentCalendar]
                                    components:NSYearCalendarUnit
                                    fromDate:startDate
                                    toDate:endDate
                                    options:0];
    
    _age.text = [NSString stringWithFormat:@"%d",[components year]];
     
    
    fmtDate = Nil;
    components = Nil;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)viewDidUnload {


    [self setPartnerTitle:nil];
    [self setName:nil];
    [self setIDTypeNo:nil];
    [self setOtherIDType:nil];
    [self setOtherIDTypeNo:nil];
    [self setRace:nil];
    [self setReligion:nil];
    [self setNationality:nil];
    [self setGender:nil];
    [self setSmoker:nil];
    [self setDOB:nil];
    [self setAge:nil];
    [self setMaritalStatus:nil];
    [self setMailingAddressForeign:nil];
    [self setMailingAddress1:nil];
    [self setMailingAddress2:nil];
    [self setMailingAddress3:nil];
    [self setMailingAddressPostcode:nil];
    [self setMailingAddressTown:nil];
    [self setMailingAddressState:nil];
    [self setMailingAddressCountry:nil];
    [self setPermanentAddressForeign:nil];
    [self setPermanentAddress1:nil];
    [self setPermanentAddress2:nil];
    [self setPermanentAddress3:nil];
    [self setPermanentAddressPostcode:nil];
    [self setPermanentAddressTown:nil];
    [self setPermanentAddressState:nil];
    [self setPermanentAddressCountry:nil];
    [self setResidenceTelExt:nil];
    [self setResidenceTel:nil];
    [self setOfficeTelExt:nil];
    [self setOfficeTel:nil];
    [self setFaxExt:nil];
    [self setFax:nil];
    [self setEmail:nil];
    [self setTitlePickerBtn:nil];
    [self setOtherIDTypePickerBtn:nil];
    [self setNationalityPickerBtn:nil];
    //[self setDoNationality:nil];
    [self setMailingAddressCountryPickerBtn:nil];
    [self setPermanentAddressCountryPickerBtn:nil];
    //[self setDoPermanentAddressCountry:nil];
    [self setDoNationality:nil];
    [self setRacePickerBtn:nil];
    [self setDoPermanentAddressCountry:nil];
    [self setAge:nil];
    [self setMobileTelExt:nil];
    [self setMobileTel:nil];
    [super viewDidUnload];
}
- (IBAction)doTitle:(id)sender {
}

- (IBAction)doOtherIDType:(id)sender {
}



- (IBAction)doNationality:(id)sender {
}
- (IBAction)doPermanentAddressCountry:(id)sender {
}

- (IBAction)doMailingAddressCountry:(id)sender {
}

- (IBAction)doRace:(id)sender {
}
@end
