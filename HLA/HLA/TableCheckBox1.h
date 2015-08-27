//
//  TableCheckBox.h
//  eAppScreen
//
//  Created by Erza on 7/5/13.
//  Copyright (c) 2013 IFC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableCheckBox;

@protocol TableCheckBoxDelegate1 <NSObject>

//- (void)playerDetailsViewControllerDidCancel:(PlayerDetailsViewController *)controller;
//- (void)playerDetailsViewController:(PlayerDetailsViewController *)controller didAddPlayer:(Player *)player;
-(void)logger;
@end


@interface TableCheckBox1 : UITableViewController<UITextFieldDelegate, UIGestureRecognizerDelegate> {
    BOOL checked;
    BOOL checked2;
    
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *Plan;
@property (weak, nonatomic) IBOutlet UILabel *Probability;
@property (weak, nonatomic) IBOutlet UILabel *dying65;
@property (weak, nonatomic) IBOutlet UILabel *CriticalIlness65;
@property (weak, nonatomic) IBOutlet UILabel *Disability65;
@property (weak, nonatomic) IBOutlet UILabel *AnnualIncome;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SmokingStatus;
@property (weak, nonatomic) IBOutlet UILabel *Age;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Gender;
@property (nonatomic, weak) id <TableCheckBoxDelegate1> delegate;

@property (strong, nonatomic) IBOutlet UIButton *checkButton;
- (IBAction)CheckBoxButton:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *checkButton2;
- (IBAction)checkboxButton2:(id)sender;


@property (strong, nonatomic) IBOutlet UITextField *textDisclosure;
- (IBAction)txtDisclosure:(id)sender;
- (IBAction)txtDisclosureEditChanged:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtDisclosure2;
@property (strong, nonatomic) IBOutlet UILabel *line;
@property (strong, nonatomic) IBOutlet UILabel *line2;



@end
