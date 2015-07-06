//
//  MainSubDetailsVC.h
//  iMobile Planner
//
//  Created by Juliana on 9/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubDetails.h"

@interface MainSubDetailsVC : UIViewController {
	SubDetails *subDetails;
}
@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBtn;
- (IBAction)selectDone:(id)sender;
- (IBAction)selectClose:(id)sender;

@end
