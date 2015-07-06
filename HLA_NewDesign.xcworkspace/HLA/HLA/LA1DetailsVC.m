//
//  LA1DetailsVC.m
//  iMobile Planner
//
//  Created by Juliana on 11/13/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "LA1DetailsVC.h"
#import "DataClass.h"

@interface LA1DetailsVC () {
	DataClass *obj;
}

@end

@implementation LA1DetailsVC

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	obj=[DataClass getInstance];
	[self displayData];
}

- (void)displayData {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    db = [FMDatabase databaseWithPath:path];
    [db open];
	
	stringID = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
	
	results = Nil;
	results = [db executeQuery:@"select * from  eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?", stringID, @"LA1", Nil];
	while ([results next]) {
		poFlag = [results stringForColumn:@"POFlag"];
		_titleLbl.text = [results stringForColumn:@"LATitle"];
		_DOBLbl.text = [results stringForColumn:@"LADOB"];
		_nameLbl.text = [results stringForColumn:@"LAName"];
		_raceLbl.text = [results stringForColumn:@"LARace"];
		_nricLbl.text = [results stringForColumn:@"LANewICNo"];
		_nationalityLbl.text = [results stringForColumn:@"LANationality"];
		_OtherTypeIDLbl.text = [results stringForColumn:@"LAOtherIDType"];
		_otherIDLbl.text = [results stringForColumn:@"LAOtherID"];
		religion = [results stringForColumn:@"LAReligion"];
		_OccupationLbl.text = [results stringForColumn:@"LAOccupationCode"];
		_relationshipLbl.text = [results stringForColumn:@"LARelationship"];
		_maritalStatusLbl.text = [results stringForColumn:@"LAMaritalStatus"];
		_employerLbl.text = [results stringForColumn:@"LAEmployerName"];
		_businessLbl.text = [results stringForColumn:@"LATypeOfBusiness"];
		_exactDutiesLbl.text = [results stringForColumn:@"LAExactDuties"];
		_yearlyIncomeLbl.text = [results stringForColumn:@"LAYearlyIncome"];
		gender = [results stringForColumn:@"LASex"];
		smoker = [results stringForColumn:@"LASmoker"];
		
		corrAdd = [results stringForColumn:@"CorrespondenceAddress"];
		
		ownership = [results stringForColumn:@"ResidenceOwnRented"];
		_txtAdd1.text = [results stringForColumn:@"ResidenceAddress1"];
		_txtAdd12.text = [results stringForColumn:@"ResidenceAddress2"];
		_txtAdd13.text = [results stringForColumn:@"ResidenceAddress3"];
		_txtPostcode1.text = [results stringForColumn:@"ResidencePostcode"];
		_txtState1.text = [results stringForColumn:@"ResidenceState"];
		_txtTown1.text = [results stringForColumn:@"ResidenceTown"];
		_txtCountry1.text = [results stringForColumn:@"ResidenceCountry"];
		resForeignAdd = [results stringForColumn:@"ResidenceForeignAddressFlag"];
		
		_txtAdd2.text = [results stringForColumn:@"OfficeAddress1"];
		_txtAdd22.text = [results stringForColumn:@"OfficeAddress2"];
		_txtAdd23.text = [results stringForColumn:@"OfficeAddress3"];
		_txtPostcode2.text = [results stringForColumn:@"OfficePostcode"];
		_txtState2.text = [results stringForColumn:@"OfficeState"];
		_txtTown2.text = [results stringForColumn:@"OfficeTown"];
		_txtCountry2.text = [results stringForColumn:@"OfficeCountry"];
		ofcForeignAdd = [results stringForColumn:@"OfficeForeignAddressFlag"];
		
		_txtResidence2.text = [results stringForColumn:@"ResidencePhoneNo"];
		_txtOffice2.text = [results stringForColumn:@"OfficePhoneNo"];
		_txtEmail.text = [results stringForColumn:@"EmailAddress"];
		_txtMobile2.text = [results stringForColumn:@"MobilePhoneNo"];
		_txtFax2.text = [results stringForColumn:@"FaxPhoneNo"];
	}
	
	results = Nil;
	results = [db executeQuery:@"select * from  eProposal where eProposalNo = ?", stringID, Nil];
	while ([results next]) {
		_txtName.text = [results stringForColumn:@"GuardianName"];
		_txtIC.text = [results stringForColumn:@"GuardianNewICNo"];
	}
	
	[results close];
	[db close];
	
	
	if ([poFlag isEqualToString:@"Y"]) {
		[_btnPOFlag setImage:[UIImage imageNamed:@"tickCheckbox.png"] forState:UIControlStateNormal];
	}
	else if ([poFlag isEqualToString:@"N"]) {
		[_btnPOFlag setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	
	if ([religion isEqualToString:@"MUSLIM"]) {
		_segReligion.selectedSegmentIndex = 0;
	}
	else if ([religion isEqualToString:@"NON-MUSLIM"]) {
		_segReligion.selectedSegmentIndex = 1;
	}
	
	if ([gender isEqualToString:@"M"]) {
		_segGender.selectedSegmentIndex = 0;
	}
	else if ([gender isEqualToString:@"F"]) {
		_segGender.selectedSegmentIndex = 1;
	}
	
	if ([smoker isEqualToString:@"Y"]) {
		_segSmoker.selectedSegmentIndex = 0;
	}
	else if ([smoker isEqualToString:@"N"]) {
		_segSmoker.selectedSegmentIndex = 1;
	}
	
	if ([corrAdd isEqualToString:@"R"]) {
		[_BtnResidence setImage:[UIImage imageNamed:@"tickCheckbox.png"] forState:UIControlStateNormal];
		[_BtnOffice setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	else if ([corrAdd isEqualToString:@"O"]) {
		[_BtnOffice setImage:[UIImage imageNamed:@"tickCheckbox.png"] forState:UIControlStateNormal];
		[_BtnResidence setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	
	if ([ownership isEqualToString:@"Own"]) {
		_segOwnership.selectedSegmentIndex = 0;
	}
	else if ([ownership isEqualToString:@"Rented"]) {
		_segOwnership.selectedSegmentIndex = 1;
	}
	
	if ([resForeignAdd isEqualToString:@"Y"]) {
		[_BtnResidenceForeignAdd setImage:[UIImage imageNamed:@"tickCheckbox.png"] forState:UIControlStateNormal];
	}
	else if ([resForeignAdd isEqualToString:@"N"]) {
		[_BtnResidenceForeignAdd setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
	
	if ([ofcForeignAdd isEqualToString:@"Y"]) {
		[_BtnOfficeForeignAdd setImage:[UIImage imageNamed:@"tickCheckbox.png"] forState:UIControlStateNormal];
	}
	else if ([ofcForeignAdd isEqualToString:@"N"]) {
		[_BtnOfficeForeignAdd setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setNameLbl:nil];
    [self setNricLbl:nil];
    [self setOtherIDLbl:nil];
    [self setSegReligion:nil];
    [self setEmployerLbl:nil];
    [self setBusinessLbl:nil];
    [self setExactDutiesLbl:nil];
    [self setYearlyIncomeLbl:nil];
    [self setSegGender:nil];
    [self setSegSmoker:nil];
    [super viewDidUnload];
}

@end
