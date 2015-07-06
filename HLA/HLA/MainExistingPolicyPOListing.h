//
//  MainExistingPolicyPOListing.h
//  iMobile Planner
//
//  Created by Juliana on 11/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExistingPolicyPOListing.h"

@protocol MainExistingPolicyPOListingDelegate <NSObject>

- (void)haveDataPO:(BOOL)hPO;

@end

@interface MainExistingPolicyPOListing : UIViewController{
	ExistingPolicyPOListing *PolicyListing;
}

@property (strong, nonatomic) IBOutlet UIView *mainView;
- (IBAction)actionForDone:(id)sender;
@property (weak, nonatomic) id <MainExistingPolicyPOListingDelegate> delegate;

@end
