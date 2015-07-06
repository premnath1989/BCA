//
//  eAppCheckList.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/14/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "eAppsListing.h"
#import "SelectCFF.h"
#import "eSignVC.h"
#import "COAPDF.h"
#import "eSignController.h"
#import "CardSnap.h"
#import "AppDelegate.h"
#import "ESignGenerator.h"
#import "MBProgressHUD.h"
#import "ClearData.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
@class eSignController;


@interface eAppCheckList : UIViewController<eAppsListingDelegate,SelectCFFDelegate,eSignVCDelegate,COAPDFDelegate>

{
    NSDictionary *SecPo_LADetails_ClientNew;
    
    NSMutableArray *SecPo_LADetails_ClientNew_Array;
    
    BOOL confirmStatus;
    MBProgressHUD *HUD;
    
    FMResultSet *results2;
	NSString *SavingValue;
    
    UILabel *POSignedLabel,*DateSignedLabel,*CaseTimelineLabel,*TimeRemaining,*labelbg,*underline,*ImportantNotice,*refreshDate;
    BOOL TickYES;
        
        AppDelegate *appobject;
    
    
}
-(void)testingAttack;
- (IBAction)doEAppListing:(id)sender;
@property (strong, nonatomic) MBProgressHUD *HUD;
@property (strong, nonatomic) eSignController *signController;
@property (strong, nonatomic) ESignGenerator *esignGenerator;
@property (strong, nonatomic) CardSnap *cardSnap;
@property (nonatomic, strong) UILabel *proposalNo_display;
@property (nonatomic, strong) UILabel *POSignedLabel,*DateSignedLabel,*CaseTimelineLabel,*TimeRemaining,*labelbg,*underline,*ImportantNotice,*refreshDate;
@property (nonatomic, strong) NSString *SavingValue;
-(void)deleteOldPdfs;
-(void)deleteOldPdfs:(NSString *)proposal;
-(void) deleteEAppCase: (NSString *)SINO;

@property (weak, nonatomic) IBOutlet UITableView *checklistTable;
- (IBAction)confirmBtnClicked:(id)sender;
- (IBAction)unconfirmBtnClicked:(id)sender;
@property (nonatomic, assign) BOOL DeletePDF,TickYES;

@end
