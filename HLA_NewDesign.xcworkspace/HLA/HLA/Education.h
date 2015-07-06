//
//  Education.h
//  iMobile Planner
//
//  Created by shawal sapuan on 7/2/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Education;
@protocol EducationDelegate
-(void)swipeToSavings;
@end

@interface Education : UIViewController {
    id <EducationDelegate> _delegate;
}

@property (nonatomic,strong) id <EducationDelegate> delegate;
- (IBAction)swipeNext:(id)sender;

@end
