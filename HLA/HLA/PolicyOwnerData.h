//
//  PolicyOwnerData.h
//  iMobile Planner
//
//  Created by Meng Cheong on 10/1/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolicyOwnerDataDetails.h"
#import "SubDetails.h"

@protocol PolicyOwnerDataDelegate

-(void)doneDelete;

-(void)updatePO:(BOOL)showPoLabel;

@end


@interface PolicyOwnerData : UIViewController<SubDetailsDelegate>
{
    SubDetails *subDetails;
    id<PolicyOwnerDataDelegate> _delegate;
}
- (IBAction)doSave:(id)sender;
- (IBAction)doCancel:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *myView;

@property (nonatomic, retain) SubDetails *PolicyOwnerDataDetailsVC;
@property (nonatomic, retain) NSMutableDictionary *LADetails;
@property (strong, nonatomic) IBOutlet UINavigationBar *myBar;
@property (strong, nonatomic) id delegate;





@end
