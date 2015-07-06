//
//  ViewController.h
//  HLA
//
//  Created by Md. Nazmus Saadat on 9/26/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Login.h"
#import "CarouselViewController.h"

@interface ViewController : UIViewController<LoginDelegate, CarouselDelegate >{
	    Login *_Login;
		CarouselViewController *_CVC;
}
@property (nonatomic, retain) Login *Login;
@property (nonatomic, retain) CarouselViewController *CVC;
@property (nonatomic, assign,readwrite) int sss;

//bbbb

@end
