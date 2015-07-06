//
//  Login.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 9/28/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "Reachability.h"

@protocol LoginDelegate
- (void)Dismiss: (NSString *)ViewToBePresented;
@end


@interface Login : UIViewController<NSXMLParserDelegate>
{
    NSString *databasePath;
    NSString *RatesDatabasePath;
	NSString *UL_RatesDatabasePath;
	    NSString *CommDatabasePath;
    sqlite3 *contactDB;
    UITextField *activeField;
	id<LoginDelegate> _delegate;
	Reachability *internetReachableFoo;
	
}

@property (nonatomic, strong) id<LoginDelegate> delegate;

@property (nonatomic, assign) int statusLogin;
@property (nonatomic, assign) int indexNo;
@property (nonatomic, copy) NSString *agentID;
@property (nonatomic, copy) NSString *agentPortalLoginID;
@property (nonatomic, copy) NSString *agentPortalPassword;
@property (nonatomic, copy) NSString *agentCode;
@property (nonatomic, copy) NSString *msg;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewLogin;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UILabel *lblForgotPwd;
@property (strong, nonatomic) IBOutlet UILabel *labelVersion;
@property (strong, nonatomic) IBOutlet UILabel *labelUpdated;
@property(strong) NSString *previousElementName;
@property(strong) NSString *elementName;

- (IBAction)btnLogin:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletLogin;

-(void)keyboardDidShow:(NSNotificationCenter *)notification;
-(void)keyboardDidHide:(NSNotificationCenter *)notification;
- (IBAction)btnReset:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletReset;

@end
