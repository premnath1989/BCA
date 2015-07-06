//
//  HealthQuestionnaire7i.m
//  iMobile Planner
//
//  Created by Erza on 7/30/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "HealthQuestionnaire7i.h"
#import "DataClass.h"
@interface HealthQuestionnaire7i ()
{
    DataClass *obj;
}


@end

@implementation HealthQuestionnaire7i

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
     obj = [DataClass getInstance];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //Display data from obj
    NSString* text = [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"Q7i"];
    
    if(text != NULL || ![text isEqualToString:@""])
        self.textField.text = text;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload {
    [self setTextField:nil];
    [super viewDidUnload];
}
@end
