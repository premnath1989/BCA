//
//  TitleViewController.h
//  iMobile Planner
//
//  Created by Erza on 6/5/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TitleDelegate <NSObject>
@required
-(void)selectedTitle:(NSString *)selectedTitle;
@end

@interface TitleViewController : UITableViewController{
    NSMutableArray *_Title;
}
@property (nonatomic, strong) NSMutableArray *Title;
@property (nonatomic, weak) id<TitleDelegate> delegate;
@end
