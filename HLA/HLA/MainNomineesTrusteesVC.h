//
//  MainNomineesTrusteesVC.h
//  iMobile Planner
//
//  Created by Juliana on 8/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Nominees.h"

@protocol MainNomineesTrusteesDelegate <NSObject>
-(void)updateTotalSharePct:(NSString *)sharePctInsert;
@end

@interface MainNomineesTrusteesVC : UIViewController<UIAlertViewDelegate, UIGestureRecognizerDelegate> {
	Nominees *nominees;
    //db for postcode
	NSString *databasePath;
    sqlite3 *contactDB;
}
@property (strong, nonatomic) IBOutlet UIView *mainView;

@property (nonatomic, strong) id <MainNomineesTrusteesDelegate> delegate;
@property (strong, nonatomic) UILabel *Nominee1Lbl;
@property (strong, nonatomic) UILabel *Nominee2Lbl;
@property (strong, nonatomic) UILabel *Nominee3Lbl;
@property (strong, nonatomic) UILabel *Nominee4Lbl;
@property (strong, nonatomic) UILabel *Trustee1Lbl;
@property (strong, nonatomic) UILabel *Trustee2Lbl;

- (IBAction)selectDone:(id)sender;
- (IBAction)selectCancel:(id)sender;

@end
