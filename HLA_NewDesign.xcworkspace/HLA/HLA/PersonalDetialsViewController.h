//
//  PersonalDetialsViewController.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//
#import "FMDatabase.h"
#import "FMResultSet.h"

@class PersonalDetialsViewController;

@protocol PersonalDetialsViewControllerDelegate<NSObject>
- (void)CustomerViewDisplay:(NSString*)type;
- (void)DisplayNewCFF:(int)indexNo clientName:(NSString*)clientName clientID:(NSString*)clientID;
@end

@interface PersonalDetialsViewController : UIViewController{
//NSMutableArray *clientProfile;
}


@property (nonatomic, weak) id <PersonalDetialsViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *clientProfileTableView;
@property (strong, nonatomic) NSMutableArray *existingClient;

- (IBAction)doCancel:(id)sender;
- (IBAction)doAdd:(id)sender;

@end
