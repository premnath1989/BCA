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



@interface eAppCheckList : UIViewController<eAppsListingDelegate,SelectCFFDelegate,eSignVCDelegate,COAPDFDelegate>

- (IBAction)doEAppListing:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *checklistTable;
- (IBAction)confirmBtnClicked:(id)sender;
- (IBAction)unconfirmBtnClicked:(id)sender;






@end
