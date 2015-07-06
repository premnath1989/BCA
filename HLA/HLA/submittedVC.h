//
//  pending.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/17/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PendingVCCell.h"
//#import "eAppStatusList.h"
#import "eAppStatusListforSubmitted.h"
#import <sqlite3.h>
#import "ErrorViewController.h"
static const int XML_TYPE_FETCH_PRAPOSAL_STATUS2=105;

//@interface submittedVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,eAppStatusListDelegate,NSXMLParserDelegate>
@interface submittedVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,eAppStatusListforSubmittedDelegate,NSXMLParserDelegate>
{
    
    NSString *siquotationnumber;
    NSString *proposalnumber;
    NSString *policynumber;
    NSString *iserror;
    NSString *syncflag;
    NSString *uwatatus;
    int xmlType;
    
    //  eAppStatusList *_statusVC;
    eAppStatusListforSubmitted  *_statusVC;
    
    UIPopoverController *_statusPopover;
    NSString *ProposalNo;
    
    NSString *_errorRefNo;
    NSString *_errorCode;
    NSString *_errorDesc;
    NSString *_createdDate;
    sqlite3 *contactDB;
    NSMutableArray *ItemToBeDeleted;
    NSMutableArray *indexPaths;
    
}

- (IBAction)doRefresh:(id)sender;



@property (weak, nonatomic) IBOutlet UITableView *submitTableView;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UIButton *refreshCancelButton;
@property (weak, nonatomic) IBOutlet UITextField *policyOwnerNameField;
@property (weak, nonatomic) IBOutlet UITextField *idNoField;
@property (weak, nonatomic) IBOutlet UITextField *selectField;
@property (weak, nonatomic) IBOutlet UILabel *policyNo;
@property (weak, nonatomic) IBOutlet UILabel *Policyno;
@property (retain, nonatomic) NSMutableArray *PolicyNoArray;
@property (strong, nonatomic) IBOutlet UIButton *btnDelete;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property(strong) NSDictionary *fproposaldata1;


@property (nonatomic, retain) ErrorViewController *errorVc;

@property(strong) NSString *previousElementName;
@property(strong) NSString *elementName;

@property(strong) NSDictionary *sversion;
@property(strong) NSDictionary *fproposaldata;

- (IBAction)searchButtonClicked:(id)sender;
- (IBAction)resetButtonClicked:(id)sender;

- (IBAction)refreshButtonClicked:(UIButton *)sender;
- (IBAction)btnDeletePressed:(id)sender;
- (IBAction)btnCancelPressed:(id)sender;
@property (nonatomic , copy) NSString *errorRefNo;
@property (nonatomic , copy) NSString *errorCode;
@property (nonatomic , copy) NSString *errorDesc;
@property (nonatomic , copy) NSString *createdDate;



@end
