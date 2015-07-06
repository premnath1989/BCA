//
//  PendingVCCell.h
//  iMobile Planner
//
//  Created by Basvi on 14/01/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PendingVCCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idNOLabel;
@property (weak, nonatomic) IBOutlet UILabel *siNOLabel;
@property (weak, nonatomic) IBOutlet UILabel *proposalNOLabel;
@property (weak, nonatomic) IBOutlet UILabel *agentCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *creationDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *siVersionLabel;
@property (weak, nonatomic) IBOutlet UILabel *eAppVersionLabel;
@property (weak, nonatomic) IBOutlet UIButton *toViewButton;
@property (weak, nonatomic) IBOutlet UILabel *policyNo;
@property (weak, nonatomic) IBOutlet UILabel *TimeRemainingLabel;

@property (weak, nonatomic) IBOutlet UIButton *toViewButton1;






@end
