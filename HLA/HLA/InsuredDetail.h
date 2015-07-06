//
//  InsuredDetail.h
//  iMobile Planner
//
//  Created by kuan on 9/20/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewInsuredRecord.h"
#import "SIDate.h"

@interface InsuredDetail : UITableViewController <UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    ViewInsuredRecord* _viewInsuredRecord;
    NSUserDefaults *prefs;
}
@property (strong, nonatomic) IBOutlet UITextField *txtComp;
@property (strong, nonatomic) IBOutlet UITextField *txtDisease;
@property (strong, nonatomic) IBOutlet UITextField *txtAmount;
@property (strong, nonatomic) IBOutlet UITextField *txtYear;
@property (strong, nonatomic)NSUserDefaults *prefs;

- (IBAction)deleteInsured:(id)sender;

- (IBAction)btnClose:(id)sender;
- (IBAction)saveInsured:(id)sender;


@end
