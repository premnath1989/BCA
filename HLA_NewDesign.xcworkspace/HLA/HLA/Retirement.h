//
//  Retirement.h
//  iMobile Planner
//
//  Created by shawal sapuan on 7/1/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Retirement;
@protocol RetirementDelegate
-(void)swipeToEducation;
@end

@interface Retirement : UIViewController {
    id <RetirementDelegate> _delegate;
}

@property (nonatomic,strong) id <RetirementDelegate> delegate;
- (IBAction)swipeNext:(id)sender;

@end
