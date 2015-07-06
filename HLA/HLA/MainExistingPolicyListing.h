//
//  MainExistingPolicyListing.h
//  iMobile Planner
//
//  Created by Juliana on 9/19/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//
//
#import <UIKit/UIKit.h>
#import "ExistingPolicyListing.h"
//#import "AddPolicyTableVC.h"
//@protocol AddPolicyTableVCDelegate;
//@class AddPolicyTableVC;
@protocol MainExistingPolicyListingDelegate <NSObject>

- (void)haveData:(BOOL)h;

@end

@interface MainExistingPolicyListing : UIViewController{
//	AddPolicyTableVC *add;
	ExistingPolicyListing *PolicyListing;
}
@property (strong, nonatomic) IBOutlet UIView *mainView;
- (IBAction)actionForDone:(id)sender;
@property (weak, nonatomic) id <MainExistingPolicyListingDelegate> delegate;

@end
