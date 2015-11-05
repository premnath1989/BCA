//
//  ViewControllerActivity.h
//  iMobile Planner
//
//  Created by Emi on 3/11/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerActivity : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;
@property (weak, nonatomic) IBOutlet UITextField *txtLokasi;
@property (weak, nonatomic) IBOutlet UIButton *btnLokasi;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;

- (IBAction)ActionPilihLokasi:(id)sender;
- (IBAction)ActionSave:(id)sender;
- (IBAction)ActionBack:(id)sender;


@end
