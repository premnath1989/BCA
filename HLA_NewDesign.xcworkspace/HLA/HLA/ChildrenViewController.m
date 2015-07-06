//
//  ChildrenViewController.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/8/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ChildrenViewController.h"
#import "CustomerViewController.h"

@interface ChildrenViewController ()

@end



@implementation ChildrenViewController

//@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIColor *tintColor = [UIColor colorWithRed:195/255.0f green:212/255.0f blue:255/255.0f alpha:1];
    [self.navigationController.navigationBar setTintColor:tintColor];
    [self.delegate ChildrenViewDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewDidUnload {
    [super viewDidUnload];
}
- (IBAction)childrenViewCancel:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:Nil];
}

- (IBAction)childrenViewDone:(id)sender {
    //NSLog(@"dddd");
    [_delegate ChildrenViewDisplay];
    [self.delegate ChildrenViewDisplay];
}
@end
