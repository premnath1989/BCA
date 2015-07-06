//
//  ClearData.h
//  iMobile Planner
//
//  Created by Emi on 16/4/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "FMDatabase.h"

@interface ClearData : UIViewController

@property (nonatomic, retain) NSString *databasePath;
@property (nonatomic, assign) sqlite3 *contactDB;


- (void)ClientWipeOff;
-(void)SubmitedWipeOff :(NSString *)eProposalNo;
-(void)deleteOldPdfs:(NSString *)proposal;
-(void)deleteEApp:(NSString *)proposal database:(FMDatabase *)db;
-(void)deleteCFF:(NSString *)prospectID database:(FMDatabase *)db;


@end
