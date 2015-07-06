//
//  ProspectProfile.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 10/1/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProspectProfile : NSObject

@property (nonatomic, retain) NSString* ProspectID;
@property (nonatomic, retain) NSString* NickName;
@property (nonatomic, retain) NSString* ProspectName;
@property (nonatomic, retain) NSString* ProspectGender;
@property (nonatomic, retain) NSString* ProspectDOB;
@property (nonatomic, retain) NSString* ResidenceAddress1;
@property (nonatomic, retain) NSString* ResidenceAddress2;
@property (nonatomic, retain) NSString* ResidenceAddress3;
@property (nonatomic, retain) NSString* ResidenceAddressTown;
@property (nonatomic, retain) NSString* ResidenceAddressState;
@property (nonatomic, retain) NSString* ResidenceAddressPostCode;
@property (nonatomic, retain) NSString* ResidenceAddressCountry;
@property (nonatomic, retain) NSString* OfficeAddress1;
@property (nonatomic, retain) NSString* OfficeAddress2;
@property (nonatomic, retain) NSString* OfficeAddress3;
@property (nonatomic, retain) NSString* OfficeAddressTown;
@property (nonatomic, retain) NSString* OfficeAddressState;
@property (nonatomic, retain) NSString* OfficeAddressPostCode;
@property (nonatomic, retain) NSString* OfficeAddressCountry;
@property (nonatomic, retain) NSString* ProspectEmail;
@property (nonatomic, retain) NSString* ProspectRemark;
@property (nonatomic, retain) NSString* ProspectOccupationCode;
@property (nonatomic, retain) NSString* ExactDuties;
@property (nonatomic, retain) NSString* ProspectGroup;
@property (nonatomic, retain) NSString* ProspectTitle;
@property (nonatomic, retain) NSString* IDTypeNo;
@property (nonatomic, retain) NSString* OtherIDType;
@property (nonatomic, retain) NSString* OtherIDTypeNo;
@property (nonatomic, retain) NSString* Smoker;
@property (nonatomic, retain) NSString* AnnualIncome;
@property (nonatomic, retain) NSString* BussinessType;
@property (nonatomic, retain) NSString* Race;
@property (nonatomic, retain) NSString* MaritalStatus;
@property (nonatomic, retain) NSString* Religion;
@property (nonatomic, retain) NSString* Nationality;


-(id) initWithName:(NSString*) TheNickName AndProspectID:(NSString*)TheProspectID AndProspectName:(NSString*)TheProspectName 
  AndProspecGender:(NSString*)TheProspectGender AndResidenceAddress1:(NSString*)TheResidenceAddress1
AndResidenceAddress2:(NSString*)TheResidenceAddress2 AndResidenceAddress3:(NSString*)TheResidenceAddress3
AndResidenceAddressTown:(NSString*)TheResidenceAddressTown AndResidenceAddressState:(NSString*)TheResidenceAddressState
AndResidenceAddressPostCode:(NSString*)TheResidenceAddressPostCode
AndResidenceAddressCountry:(NSString*)TheResidenceAddressCountry AndOfficeAddress1:(NSString*)TheOfficeAddress1
 AndOfficeAddress2:(NSString*)TheOfficeAddress2 AndOfficeAddress3:(NSString*)TheOfficeAddress3
AndOfficeAddressTown:(NSString*)TheOfficeAddressTown AndOfficeAddressState:(NSString*)TheOfficeAddressState
AndOfficeAddressPostCode:(NSString*)TheOfficeAddressPostCode
AndOfficeAddressCountry:(NSString*)TheOfficeAddressCountry AndProspectEmail:(NSString*)TheProspectEmail
 AndProspectRemark:(NSString*)TheProspectRemark AndProspectOccupationCode:(NSString*)TheProspectOccupationCode
AndProspectDOB:(NSString*)TheProspectDOB AndExactDuties:(NSString*)TheExactDuties AndGroup:(NSString*)TheGroup AndTitle:(NSString*)TheTitle AndIDTypeNo:(NSString*)TheIDTypeNo AndOtherIDType:(NSString*)TheOtherIDType AndOtherIDTypeNo:(NSString*)TheOtherIDTypeNo AndSmoker:(NSString*)TheSmoker AndAnnIncome:(NSString*)TheIncome AndBussType:(NSString*)TheBussType AndRace:(NSString*)TheRace AndMaritalStatus:(NSString*)TheMaritalStatus AndReligion:(NSString*)TheReligion AndNationality:(NSString*)TheNationality;

@end
