//
//  FormCell.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/16/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *formLabel;
@property (weak, nonatomic) IBOutlet UILabel *formDesc;
@property (weak, nonatomic) IBOutlet UIImageView *formStatus;

@end
