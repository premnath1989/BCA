//
//  CustomerPartner.h
//  iMobile Planner
//
//  Created by shawal sapuan on 7/2/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerPartnerII.h"

@interface CustomerPartner : UIViewController  {
    CustomerPartnerII *_parnerIIVC;
}

@property (nonatomic, retain) CustomerPartnerII *parnerIIVC;
- (IBAction)goNext:(id)sender;

@end
