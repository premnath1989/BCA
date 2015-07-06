//
//  CustomAlertBox.h
//  iMobile Planner
//
//  Created by kuan on 11/13/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProspectViewController.h"
#import "WebViewViewController.h"

@protocol CustomAlertBoxDelegate <NSObject>
-(void)AgreeFlag:(NSString *)agree;
-(void)CloseFlag:(NSString *)Closeagree;
@end



@interface CustomAlertBox : UIViewController <ProspectViewControllerDelegate>

{
    BOOL checkedAgree;
     id <CustomAlertBoxDelegate> _delegate;
	ProspectViewController *ProspectViewController;
	WebViewViewController *WebViewViewController;
	
   
}
@property (nonatomic, retain) ProspectViewController *ProspectViewController;
@property (nonatomic, retain) WebViewViewController *WebViewViewController;
@property (weak, nonatomic) IBOutlet UIButton *CloseProspect;
@property (assign, nonatomic)  BOOL changetext;
@property (assign, nonatomic)  BOOL AlertProspect;
@property (assign, nonatomic)  BOOL AlertProspectGoIn;
@property (nonatomic, strong) id delegate;
@property (strong, nonatomic) IBOutlet UIButton *btnagree;
- (IBAction)CloseProspect:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnok;
//@property (strong, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) IBOutlet UIButton *btnNotOk;
@property (strong, nonatomic) IBOutlet UILabel *DEclarationTxt;

@property (strong, nonatomic) IBOutlet UITextView *textLabel;


- (IBAction)checkBoxAgree:(id)sender;
- (IBAction)Actionclose:(id)sender;
- (IBAction)ActionOK:(id)sender;

@end
