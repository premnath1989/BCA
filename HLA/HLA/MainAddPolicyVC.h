//
//  MainAddPolicyVC.h
//  iMobile Planner
//
//  Created by Juliana on 9/18/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPolicyTableVC.h"

@protocol MainAddPolicyVCDelegate <NSObject>

- (void)saveData:(int)click;

@end

@interface MainAddPolicyVC : UIViewController<UIAlertViewDelegate, UIGestureRecognizerDelegate> {
	AddPolicyTableVC *AddPolicy;
	
	int rrrnum;
	int whichpolicy;
	int test;
	NSString *stringl;
}
@property(nonatomic,assign) int num;
@property (strong, nonatomic) IBOutlet UIView *mainView;

@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
- (IBAction)actionForDone:(id)sender;

@property (strong, nonatomic) NSMutableArray *mutArray;
@property BOOL click;
@property (weak, nonatomic) id <MainAddPolicyVCDelegate> delegate;
@end
