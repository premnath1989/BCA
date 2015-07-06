//
//  MainExistingPolicyLA2Listing.h
//  iMobile Planner
//
//  Created by Juliana on 11/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExistingPolicyLA2Listing.h"

@protocol MainExistingPolicyLA2ListingDelegate <NSObject>

- (void)haveDataLA2:(BOOL)hLA2;

@end

@interface MainExistingPolicyLA2Listing : UIViewController{
	ExistingPolicyLA2Listing *PolicyListing;
}

@property (strong, nonatomic) IBOutlet UIView *mainView;
- (IBAction)actionForDone:(id)sender;
@property (weak, nonatomic) id <MainExistingPolicyLA2ListingDelegate> delegate;

@end
