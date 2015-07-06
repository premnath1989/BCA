//
//  SIObj.h
//  iMobile Planner
//
//  Created by ywbeh on 9/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIObj : NSObject
{
   
}
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* smoker;
@property (nonatomic,strong) NSString* sex;
@property (nonatomic,strong) NSString* DOB;
@property (nonatomic,strong) NSString* age;
@property (nonatomic,strong) NSString* ANB;
@property (nonatomic,strong) NSString* occupationCode;
@property (nonatomic,strong) NSString* dateModified;//currentDate
@property (nonatomic,strong) NSString* indexNo;
@property (nonatomic,strong) NSString* commDate;//date created
@property (nonatomic,strong) NSString* idProfile;

@property (nonatomic,strong) NSString* clientID;

//for basic plan
@property (nonatomic,strong) NSString* policyTerm;
@property (nonatomic,strong) NSString* basicSA;
@property (nonatomic,strong) NSString* prePayOption;
@property (nonatomic,strong) NSString* cashDivident;
@property (nonatomic,strong) NSString* yearlyIncome;
@property (nonatomic,strong) NSString* advanceYearlyIncome;
@property (nonatomic,strong) NSString* hl1kSA;
@property (nonatomic,strong) NSString* hl1kSATerm;
@property (nonatomic,strong) NSString* tempHL1kSA;
@property (nonatomic,strong) NSString* temHL1KSAterm;
@property (nonatomic,strong) NSString* updatedAt;
@property (nonatomic,strong) NSString* partialAcc;
@property (nonatomic,strong) NSString* partialPayout;
@property (nonatomic,strong) NSString* siNO;

@property (nonatomic,strong) NSString* custCode;
@property (nonatomic,strong) NSString* ALB;
@property (nonatomic,strong) NSString* dateCreated;
@property (nonatomic,strong) NSString* rowID;
@property (nonatomic,strong) NSString* ID;


@end
