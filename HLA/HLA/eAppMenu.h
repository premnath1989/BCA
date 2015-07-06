//
//  eAppMenu.h
//  iMobile Planner
//
//  Created by shawal sapuan on 7/12/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "eAppsListing.h"
#import "SubDetailsData.h"

@interface eAppMenu : UIViewController <SubDetailsDataDelegate> {
    eAppsListing *_eAppsVC;
    SubDetailsData *_subPOVC;
    BOOL clickPO;
}


@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, retain) eAppsListing *eAppsVC;
@property (nonatomic, retain) SubDetailsData *subPOVC;
@property (nonatomic,strong) id getSI;
@property (nonatomic,strong) id getPO;
@property (nonatomic,strong) id getECFF;
@property (nonatomic,strong) id getEAPP;
@property (nonatomic,strong) id getESignature;

@property (strong, nonatomic) NSMutableArray *items;

- (IBAction)ActionClose:(id)sender;



@end
