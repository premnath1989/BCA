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

@interface MainNomineesTrusteesVC : UIViewController<UIAlertViewDelegate> {
	Nominees *nominees;
}
@property (strong, nonatomic) IBOutlet UIView *mainView;

@property (nonatomic, strong) id <MainNomineesTrusteesDelegate> delegate;

- (IBAction)selectDone:(id)sender;
- (IBAction)selectCancel:(id)sender;

@end
