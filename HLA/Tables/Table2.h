//
//  Table2.h
//  HLA_CA
//
//  Created by Danial D. Moghaddam on 3/19/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Table2 : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSArray *localArr;
}

@property (weak, nonatomic) IBOutlet UITableView *tableview;

-(void)loadFromArray:(NSArray *)arr;
@end
