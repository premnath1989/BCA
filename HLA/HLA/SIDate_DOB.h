//
//  SIDate.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 10/4/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SIDateDelegate_DOB
- (void)DateSelected:(NSString *)strDate:(NSString *) dbDate;
- (void)ClearDateSelected:(NSString *)strDate:(NSString *) dbDate;
- (void)CloseWindow;
- (void)ClearCloseWindow;
@end

@interface SIDate_DOB : UIViewController{
    id<SIDateDelegate_DOB> _delegate;
}

@property (nonatomic, copy) NSString *ProspectDOB;

@property(nonatomic, assign) int rowToUpdate;
@property (nonatomic, copy) NSString *receivedDOB;


@property (nonatomic, strong) id<SIDateDelegate_DOB> delegate;
- (IBAction)ActionDate:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *outletDate;
- (IBAction)btnClose:(id)sender;
- (IBAction)btnDone:(id)sender;
- (IBAction)doClear:(id)sender;

@end
