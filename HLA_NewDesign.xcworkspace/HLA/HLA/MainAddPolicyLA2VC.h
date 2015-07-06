//
//  MainAddPolicyLA2VC.h
//  iMobile Planner
//
//  Created by Juliana on 11/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPolicyLA2TableVC.h"

@protocol MainAddPolicyLA2VCDelegate <NSObject>

- (void)saveDataLA2:(int)clickLA2;

@end

@interface MainAddPolicyLA2VC : UIViewController<UIAlertViewDelegate> {
	AddPolicyLA2TableVC *AddPolicy;
	int num;
	int rrrnum;
	int whichpolicy;
	int test;
	NSString *stringl;
}
@property (strong, nonatomic) IBOutlet UIView *mainView;

@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
- (IBAction)actionForDone:(id)sender;

@property (strong, nonatomic) NSMutableArray *mutArray;
@property BOOL click;
@property (weak, nonatomic) id <MainAddPolicyLA2VCDelegate> delegate;

@end
