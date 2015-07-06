//
//  Declare.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Declare : UITableViewController{
	BOOL select1;
	BOOL select2;
}

@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
- (IBAction)clickBtn1:(id)sender;
- (IBAction)clickBtn2:(id)sender;



@property (weak, nonatomic) IBOutlet UITextField *IntermediaryCode;
@property (weak, nonatomic) IBOutlet UITextField *NameOfIntermediary;
@property (weak, nonatomic) IBOutlet UITextField *IntermediaryNRIC;
@property (weak, nonatomic) IBOutlet UITextField *IntermediaryCodeContractDate;
@property (weak, nonatomic) IBOutlet UITextField *IntermediaryAddress1;
@property (weak, nonatomic) IBOutlet UITextField *IntermediaryAddress2;
@property (weak, nonatomic) IBOutlet UITextField *IntermediaryAddress3;
@property (weak, nonatomic) IBOutlet UITextField *IntermediaryAddress4;
@property (weak, nonatomic) IBOutlet UITextView *AdditionalComment;
@property (weak, nonatomic) IBOutlet UITextField *NameOfManager;
- (IBAction)NameOfMangerAction:(id)sender;

@property (weak, nonatomic) NSString *selected;


- (IBAction)IntermediaryCodeContractDateAction:(id)sender;
- (IBAction)IntermediaryAddress1Action:(id)sender;


@end
