//
//  demo.h
//  iMobile Planner
//
//  Created by infoconnect on 8/19/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface demo : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;
- (IBAction)ActionClose:(id)sender;

@end
