//
//  PartnerClientProfile.h
//  iMobile Planner
//
//  Created by Meng Cheong on 8/30/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartnerViewController.h"

@class PartnerClientProfile;

@protocol PartnerClientProfileDelegate<NSObject>
-(void)partnerUpdate;
-(void)partnerDelete;
@end

@interface PartnerClientProfile : UIViewController{
    PartnerViewController *_PartnerVC;
}
@property (nonatomic, retain) PartnerViewController *PartnerVC;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBtn;
- (IBAction)doDone:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *PartnerTitle;

@property (weak, nonatomic) IBOutlet UIView *contentView;
- (IBAction)doDelete:(id)sender;

@property (nonatomic, weak) id <PartnerClientProfileDelegate> delegate;

@end
