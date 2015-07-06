//
//  P2Table.h
//  HLA_CA
//
//  Created by Danial D. Moghaddam on 3/13/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface P2Table : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSArray *childrenArr;
}
@property (weak, nonatomic) IBOutlet UITableView *childerTable;
-(void)loadFromArray:(NSArray *)arr;
@end


