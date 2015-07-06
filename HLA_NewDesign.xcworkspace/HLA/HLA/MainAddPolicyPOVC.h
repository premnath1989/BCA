//
//  MainAddPolicyPOVC.h
//  iMobile Planner
//
//  Created by Juliana on 11/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPolicyPOTableVC.h"

@protocol MainAddPolicyPOVCDelegate <NSObject>

- (void)saveDataPO:(int)clickPO;

@end

@interface MainAddPolicyPOVC : UIViewController<UIAlertViewDelegate> {
	AddPolicyPOTableVC *AddPolicy;
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
@property (weak, nonatomic) id <MainAddPolicyPOVCDelegate> delegate;


@end
