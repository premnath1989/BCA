//
//  ErrorViewController.h
//  iMobile Planner
//
//  Created by Meng Cheong on 4/24/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ErrorViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *errorTableView;

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel1;
@property(weak,nonatomic) NSString* proposalNumber;

- (IBAction)selectCancel:(id)sender;

@property (retain, nonatomic) NSMutableArray *errorDescriptionArray;





@end
