//
//  WebViewViewController.h
//  iMobile Planner
//
//  Created by Emi on 21/4/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewViewController : UIViewController
{
	
}

- (IBAction)CloseModal:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
