//
//  DateViewController.h
//  HLA
//
//  Created by shawal sapuan on 9/25/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DateViewController;
@protocol DateViewControllerDelegate
-(void)datePick:(DateViewController *)inController strDate:(NSString *)aDate strAge:(NSString *)aAge intAge:(int)bAge intANB:(int)aANB;
@end

@interface DateViewController : UIViewController {
    id <DateViewControllerDelegate> _delegate;
}

@property (retain, nonatomic) IBOutlet UIDatePicker *datePickerView;
@property (nonatomic, copy) NSString *msgDate;
@property (nonatomic, copy) NSString *msgAge;
@property (nonatomic,assign,readwrite) int Age;
@property (nonatomic, assign,readwrite) int ANB;
@property (nonatomic,assign,readwrite) int btnSender;
@property (nonatomic, strong) id <DateViewControllerDelegate> delegate;

@property (readonly) NSString *selectedStrDate;
@property (readonly) NSString *selectedStrAge;
@property (readonly) int selectedIntAge;
@property (readonly) int selectedIntANB;

- (IBAction)dateChange:(id)sender;
- (IBAction)donePressed:(id)sender;

@end
