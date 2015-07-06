//
//  eBrochureViewController.h
//  HLA Ipad
//
//  Created by infoconnect on 1/16/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface eBrochureViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *outletWebview;
@property (strong, nonatomic) id fileName;
@property (strong, nonatomic) id fileTitle;
@end
