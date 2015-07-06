//
//  BrowserViewController.h
//  iMobile Planner
//
//  Created by infoconnect on 4/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "PagesController.h"

@interface BrowserViewController : UIViewController<MFMailComposeViewControllerDelegate,PagesControllerDelegate>
{
	UIBarButtonItem *email;
	UIBarButtonItem *print;
	UIBarButtonItem *pages;
@private // Instance variables
	UIPrintInteractionController *printInteraction;
	PagesController *_PagesList;
	UIPopoverController *_PagesPopover;
	UIWebView  *webView;
}
@property (nonatomic,strong) NSString *SIFilePath;
@property (nonatomic,strong) NSString *_PDSorSI;
@property (nonatomic,strong) NSString *_TradOrEver;
- (id)initWithFilePath:(NSString *)fullFilePath PDSorSI:(NSString *)PDSorSI TradOrEver:(NSString *)aaTradOrEver;
@property (nonatomic, retain) PagesController *PagesList;
@property (nonatomic, retain) UIPopoverController *PagesPopover;
@end
