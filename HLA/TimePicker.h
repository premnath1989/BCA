//
//  TimePicker.h
//  iMobile Planner
//
//  Created by Emi on 17/11/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TimePickerDelegate
- (void)TimeSelected:(NSString *)strTime:(NSString *) dbDate;
- (void)CloseWindow;
@end

@interface TimePicker : UIViewController {
	id <TimePickerDelegate> _delegate;
}

@property (nonatomic, strong) id<TimePickerDelegate> Adelegate;

@property (nonatomic, copy) NSString *time;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *BtnDone;
@property (weak, nonatomic) IBOutlet UIDatePicker *TimePicker;

- (IBAction)ActionTime:(id)sender;
- (IBAction)ActionDone:(id)sender;


@end
