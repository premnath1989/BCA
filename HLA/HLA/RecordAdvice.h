//
//  RecordAdvice.h
//  iMobile Planner
//
//  Created by shawal sapuan on 7/1/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RecordAdvice;
@protocol RecordDelegate
-(void)swipeToRecordAdviceII;
@end

@interface RecordAdvice : UIViewController {
    id <RecordDelegate> _delegate;
}

@property (nonatomic, strong) id <RecordDelegate> delegate;
- (IBAction)SwipeNext:(id)sender;

@end
