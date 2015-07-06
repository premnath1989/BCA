//
//  FormViewController.h
//  iMobile Planner
//
//  Created by Administrator on 1/18/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "eAppReport.h"

@interface FormViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *outletWebView;

@property (strong, nonatomic) id fileName;
@property (strong, nonatomic) id fileTitle;
@property (strong, nonatomic) NSString *FromCardSnap;

@end
