//
//  PasswordTips.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 11/20/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PasswordTipDelegate
- (void)CloseWindow;    
@end

@interface PasswordTips : UIViewController{
    id<PasswordTipDelegate> _delegate;
}
@property (nonatomic, strong) id<PasswordTipDelegate> delegate;
- (IBAction)BarButtonClose:(id)sender;



@end
