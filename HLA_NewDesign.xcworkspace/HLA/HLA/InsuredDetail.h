//
//  InsuredDetail.h
//  iMobile Planner
//
//  Created by kuan on 9/20/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewInsuredRecord.h"

@interface InsuredDetail : UITableViewController
{
    ViewInsuredRecord* _viewInsuredRecord;
}
@property (strong, nonatomic) IBOutlet UITextField *txtComp;
@property (strong, nonatomic) IBOutlet UITextField *txtDisease;
@property (strong, nonatomic) IBOutlet UITextField *txtAmount;
@property (strong, nonatomic) IBOutlet UITextField *txtYear;



- (IBAction)deleteInsured:(id)sender;

- (IBAction)btnClose:(id)sender;
- (IBAction)saveInsured:(id)sender;


@end
