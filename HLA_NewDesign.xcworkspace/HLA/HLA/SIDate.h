//
//  SIDate.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 10/4/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SIDateDelegate
- (void)DateSelected:(NSString *)strDate:(NSString *) dbDate;
- (void)CloseWindow;
@end

@interface SIDate : UIViewController{
    id<SIDateDelegate> _delegate;
}

@property (nonatomic, copy) NSString *ProspectDOB;
@property (nonatomic, strong) id<SIDateDelegate> delegate;
- (IBAction)ActionDate:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *outletDate;
- (IBAction)btnClose:(id)sender;
- (IBAction)btnDone:(id)sender;

@end
