//
//  MainLA1DetailsVC.h
//  iMobile Planner
//
//  Created by Juliana on 11/13/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LA1DetailsVC.h"
#import "LA2DetailsVC.h"
#import "PayorDetailsVC.h"

@interface MainLA1DetailsVC : UIViewController {
	LA1DetailsVC *LA1VC;
	LA2DetailsVC *LA2VC;
	PayorDetailsVC *PayorVC;
}

@property (strong, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UILabel *titleForDetails;

- (IBAction)selectDone:(id)sender;
- (IBAction)selectClose:(id)sender;

@end
