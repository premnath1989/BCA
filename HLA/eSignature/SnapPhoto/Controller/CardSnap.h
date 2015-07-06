//
//  CardSnap.h
//  CardSnap
//
//  Created by Danial D. Moghaddam on 5/14/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//
//#import "eSignController.h"
#import <UIKit/UIKit.h>
#import "IDTypePicker.h"
#import "AppDelegate.h"

@protocol refreshSnapdata <NSObject>

@optional
-(void)refreshCardsanpdata;
@end



@interface CardSnap : UIViewController <UITableViewDelegate,UITableViewDataSource,pickerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,refreshSnapdata,UIAlertViewDelegate>
{
    long selectedRow;
    int snapMode;
    NSString *proposalNumber;
    CGRect imagePickerRect;
    NSString *intermediaryName;
    NSString *intermediaryCode;
    NSString *intermediaryNICNo;
    NSString *intermediaryICType;
    NSString *intermediaryContractDate;
    NSString *intermediaryManagerName;
    NSString *lAName;
    NSString *lAOtherIDType;
    NSString *lAICNO;
    NSString *laICType;
    NSString *lADOB;
    NSString *secondLAName;
    NSString *secondLAICNO;
    NSString *secondLAICType;
    NSString *policyOwnerNamel;
    NSString *policyOwnerICNO;
    NSString *policyOwnerICType;
    NSString *cardMemberAccNOFT;
    NSString *cardExpiredDateFT;
    NSString *creditCardBankFT;
    NSString *cardMemberNameFT;
    NSString *totalModalPremiumFT;
    NSString *cardMemberNewICNoFT;
    NSString *cardMemberRelationshipFT;
    
    NSString *cardMemberAccNORC;
    NSString *cardExpiredDateRC;
    NSString *creditCardBankRC;
    NSString *cardMemberNameRC;
    NSString *totalModalPremiumRC;
    NSString *cardMemberNewICNoRC;
    NSString *cardMemberRelationshipRC;
    
    NSString *clientChoice;
    NSString *clientAck;
    NSString *cOName;
    NSString *cOICNo;
    NSString *cOICType;
    NSString *trusteeCount;
    NSString *trusteeName;
	NSString *trusteeName2;
    NSString *trusteeICNo;
    NSString *trusteeICType;
    NSString *secondTrusteeName;
    NSString *secondTrusteeICNo;
    NSString *secondTrusteeICType;
    NSString *gardianName;
    NSString *gardianICNo;
    NSString *gardianICType;
    AppDelegate *appobject;
    NSString *SelectedIndentity;
    NSString *SelectedCell;
    UIButton *buttonSnapView;
    BOOL isAutoSelect;
    BOOL isIncompleted;
    BOOL ChangesMade;
    NSString *ChangesMadeOrString;
    int rowIndex;
	int prevIndex;
    
    
}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *donebtn;
@property (strong, nonatomic) IBOutlet UIButton *Standalone_Btn;
- (IBAction)SaveStandalone:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *SnapShowHistoryButton;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIButton *buttonSnapView;
@property (strong, nonatomic) IBOutlet UIButton *SnapViewButton;
- (IBAction)SnapView:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *backLabel;
@property (strong, nonatomic) IBOutlet UIButton *backBut;
-(void)supportDocForProposalNo:(NSString *)proposalNo fromInfoDic:(NSDictionary *)infoDic;
@property(nonatomic,unsafe_unretained)id<refreshSnapdata>delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *idTypes;
@property (strong, nonatomic) NSMutableArray *snapArr;
@property (strong, nonatomic) NSMutableArray *requiredArr;
@property (strong, nonatomic) NSString *SelectedCell,*ChangesMadeOrString;
@property (nonatomic,retain) UIPopoverController *popOver;
@property (weak, nonatomic) IBOutlet UIView *snapView;
@property (weak, nonatomic) IBOutlet UIButton *idTypeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *frontImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (retain, nonatomic)NSString *SelectedIndentity;
@property (strong, nonatomic) IBOutlet UILabel *CheckView;
@property (strong, nonatomic) IBOutlet UILabel *CheckView1;


- (IBAction)donePressed:(id)sender;
- (IBAction)idTypePressed:(id)sender;
- (IBAction)frontSnapPressed:(UIButton *)sender;
- (IBAction)backSnapPressed:(UIButton *)sender;
- (IBAction)backPressed:(id)sender;
- (void)idTypeSelected:(NSString *)idTypeStr;
-(IBAction)viewbackLoad:(id)sender;
@end
