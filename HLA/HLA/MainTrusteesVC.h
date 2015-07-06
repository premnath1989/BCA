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

@interface MainTrusteesVC : UIViewController<UIAlertViewDelegate, UIGestureRecognizerDelegate> {
	Trustees *trustees;
	BOOL isFemale;
	BOOL AgeLess;
	NSString *stringForIC;
	FMResultSet *results;
	FMResultSet *results2;
	NSString *stringID;
    
    NSString *previoustrusteName;
    NSString *stringprevioustruste2TName;
    NSString *previoustrusteIcNo;
    NSString *previoustrusteIcNo2;
}
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (nonatomic, weak) id<MainTrusteesVCProtocol> delegate;

@property (nonatomic, copy) NSString *DOB;
@property (nonatomic, copy) NSString *commDate;
@property (nonatomic, copy) NSString *IDTypeCodeSelected;
@property (nonatomic, copy) NSString *TitleCodeSelected;
@property (nonatomic, assign,readwrite) int age;
@property (nonatomic, assign,readwrite) int ANB;

- (IBAction)selectDone:(id)sender;
- (IBAction)selectCancel:(id)sender;
@end
