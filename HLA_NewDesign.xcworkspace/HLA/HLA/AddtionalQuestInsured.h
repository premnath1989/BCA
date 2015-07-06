//
//  AddtionalQuestInsured.h
//  iMobile Planner
//
//  Created by kuan on 9/15/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InsuredObject.h"

 
@interface AddtionalQuestInsured : UITableViewController
{
    
}
- (IBAction)closeVC:(id)sender;
- (IBAction)saveInsured:(id)sender;


@property (strong, nonatomic) IBOutlet UITextField *txtCompany;
@property (strong, nonatomic) IBOutlet UITextField *txtDiease;
@property (strong, nonatomic) IBOutlet UITextField *txtAmount;
@property (strong, nonatomic) IBOutlet UITextField *txtYear;
@property (strong, nonatomic) NSMutableArray *insuredArray;


 

-(NSString*)startSomeProcess;
@end
