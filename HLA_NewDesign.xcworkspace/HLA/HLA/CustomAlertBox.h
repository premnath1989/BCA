//
//  CustomAlertBox.h
//  iMobile Planner
//
//  Created by kuan on 11/13/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomAlertBoxDelegate <NSObject>
-(void)AgreeFlag:(NSString *)agree;
@end



@interface CustomAlertBox : UIViewController

{
    BOOL checkedAgree;
     id <CustomAlertBoxDelegate> _delegate;
}

@property (nonatomic, strong) id delegate;
@property (strong, nonatomic) IBOutlet UIButton *btnagree;

@property (strong, nonatomic) IBOutlet UIButton *btnok;



- (IBAction)checkBoxAgree:(id)sender;
- (IBAction)Actionclose:(id)sender;
- (IBAction)ActionOK:(id)sender;

@end
