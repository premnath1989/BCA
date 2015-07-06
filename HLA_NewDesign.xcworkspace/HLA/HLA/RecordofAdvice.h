//
//  RecordofAdvice.h
//  eAppScreen
//
//  Created by Erza on 7/7/13.
//  Copyright (c) 2013 IFC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordofAdvice : UITableViewController<UITextFieldDelegate,UITextViewDelegate> {
    BOOL checked;
}
@property (strong, nonatomic) IBOutlet UIButton *chkQuotation;

- (IBAction)checkQuotation:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btn1;

- (IBAction)clickBtn1:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *TypeOfPlanP1;
@property (weak, nonatomic) IBOutlet UITextField *TermP1;
@property (weak, nonatomic) IBOutlet UITextField *SumAssuredP1;
@property (weak, nonatomic) IBOutlet UITextField *NameOfInsurerP1;
@property (weak, nonatomic) IBOutlet UITextField *NameOfInsuredP1;
@property (weak, nonatomic) IBOutlet UITextField *AdditionalBenefitsP1Dummy;
@property (weak, nonatomic) IBOutlet UITextView *AdditionalBenefitsP1;
@property (weak, nonatomic) IBOutlet UITextField *ReasonP1Dummy;
@property (weak, nonatomic) IBOutlet UITextView *ReasonP1;

@property (weak, nonatomic) IBOutlet UITextField *ActionP1Dummy;
@property (weak, nonatomic) IBOutlet UITextView *ActionP1;


@property (weak, nonatomic) IBOutlet UITextField *TypeOfPlanP2;
- (IBAction)TypeOfPlanP2Action:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *TermP2;
- (IBAction)TermP2Action:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *SumAssuredP2;
- (IBAction)SumAssuredP2Action:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *NameofInsurerP2;
- (IBAction)NameofInsurerP2Action:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *NameofInsuredP2;
@property (weak, nonatomic) IBOutlet UITextField *NameofInsuredP2Action;

@property (weak, nonatomic) IBOutlet UITextField *AdditionalBenefitsP2Dummy;
@property (weak, nonatomic) IBOutlet UITextView *AdditionalBenefitsP2;

@property (weak, nonatomic) IBOutlet UITextField *ReasonP2dummy;

@property (weak, nonatomic) IBOutlet UITextView *ReasonP2;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;



@end
