//
//  MainTrusteesVC.h
//  iMobile Planner
//
//  Created by Juliana on 9/5/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trustees.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

@protocol MainTrusteesVCProtocol <NSObject>

-(void)setTrusteeLbl1:(NSString *)trusteeLbl1 andTrusteeLbl2:(NSString *)trusteeLbl2;

@end

@interface MainTrusteesVC : UIViewController<UIAlertViewDelegate> {
	Trustees *trustees;
	BOOL isFemale;
	NSString *stringForIC;
	FMResultSet *results;
	FMResultSet *results2;
	NSString *stringID;
}
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (nonatomic, weak) id<MainTrusteesVCProtocol> delegate;
- (IBAction)selectDone:(id)sender;
- (IBAction)selectCancel:(id)sender;
@end
