//
//  AddtionalQuestInsured.h
//  iMobile Planner
//
//  Created by kuan on 9/15/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InsuredObject.h"
#import "SIDate.h"

 
@interface AddtionalQuestInsured : UITableViewController<SIDateDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>
{
    
}
- (IBAction)closeVC:(id)sender;
- (IBAction)saveInsured:(id)sender;
- (IBAction)actionForDOB:(id)sender;


@property (strong, nonatomic) IBOutlet UITextField *txtCompany;
@property (strong, nonatomic) IBOutlet UITextField *txtDiease;
@property (strong, nonatomic) IBOutlet UITextField *txtAmount;
@property (strong, nonatomic) IBOutlet UITextField *txtYear;
@property (strong, nonatomic) NSMutableArray *insuredArray;

@property (nonatomic, retain) SIDate *SIDate;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;
 
 
-(NSString*)startSomeProcess;
@end
