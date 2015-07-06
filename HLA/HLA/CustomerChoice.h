//
//  CustomerChoice.h
//  eAppScreen
//
//  Created by Erza on 7/5/13.
//  Copyright (c) 2013 IFC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerChoice : UITableViewController {
    BOOL checked1;
    BOOL checked2;
    BOOL checked3;
}
@property (strong, nonatomic) IBOutlet UIButton *checkboxButton1;
- (IBAction)checkButton1:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *checkboxButton2;
- (IBAction)checkButton2:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *checkboxButton3;
- (IBAction)checkButton3:(id)sender;


@end
