//
//  PotentialAreas.h
//  eAppScreen
//
//  Created by Erza on 7/7/13.
//  Copyright (c) 2013 IFC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PriorityViewController.h"



@interface PotentialAreas : UITableViewController<PriorityViewControllerDelegate>

@property (nonatomic, strong) PriorityViewController *IDTypePicker;
@property (nonatomic, strong) UIPopoverController *IDTypePickerPopover;


//@property (nonatomic, weak) UIPopoverController *IDTypePickerPopover;



@property (strong, nonatomic) IBOutlet UISegmentedControl *planned1;
@property (strong, nonatomic) IBOutlet UISegmentedControl *discussion1;

@property (strong, nonatomic) IBOutlet UISegmentedControl *planned2;
@property (strong, nonatomic) IBOutlet UISegmentedControl *discussion2;

@property (strong, nonatomic) IBOutlet UISegmentedControl *planned3;
@property (strong, nonatomic) IBOutlet UISegmentedControl *discussion3;

@property (strong, nonatomic) IBOutlet UISegmentedControl *planned4;
@property (strong, nonatomic) IBOutlet UISegmentedControl *discussion4;

@property (strong, nonatomic) IBOutlet UISegmentedControl *planned5;
@property (strong, nonatomic) IBOutlet UISegmentedControl *discussion5;


@property (strong, nonatomic) IBOutlet UIButton *Priority1;
- (IBAction)prioritybtn1:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *Priority2;
- (IBAction)prioritybtn2:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *Priority3;

- (IBAction)prioritybtn3:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *Priority4;
- (IBAction)prioritybtn4:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *Priority5;
- (IBAction)prioritybtn5:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *resetAll;
- (IBAction)resetAllBtn:(id)sender;


- (IBAction)planned1Changed:(id)sender;
- (IBAction)planned2Changed:(id)sender;
- (IBAction)planned3Changed:(id)sender;
- (IBAction)planned4Changed:(id)sender;
- (IBAction)planned5Changed:(id)sender;
- (IBAction)discussion1Changed:(id)sender;
- (IBAction)discussion2Changed:(id)sender;
- (IBAction)discussion3Changed:(id)sender;
- (IBAction)discussion4Changed:(id)sender;
- (IBAction)discussion5Changed:(id)sender;





@end
