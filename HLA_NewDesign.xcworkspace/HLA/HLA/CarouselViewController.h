//
//  CarouselViewController.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 10/10/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@protocol CarouselDelegate
- (void)PresentMain;
@end


@interface CarouselViewController : UIViewController<iCarouselDataSource, iCarouselDelegate, NSXMLParserDelegate>{
	id<CarouselDelegate> _delegate;
}

@property (nonatomic, strong) id<CarouselDelegate> delegate;
@property (weak, nonatomic) IBOutlet iCarousel *outletCarousel;
@property(strong) NSString *previousElementName;
@property(strong) NSString *elementName;
@property (nonatomic, retain) NSString *getInternet;
@property (nonatomic, retain) NSString *getValid;
@property (nonatomic, retain) NSString *ErrorMsg;
@property (nonatomic, assign) int indexNo;


- (IBAction)btnExit:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *doClientProfile;

@property (weak, nonatomic) IBOutlet UIButton *doSI;
@property (weak, nonatomic) IBOutlet UIButton *doSettings;

@property (weak, nonatomic) IBOutlet UIButton *doEApp;
@property (weak, nonatomic) IBOutlet UIButton *doeCFF;
@property (weak, nonatomic) IBOutlet UIButton *doBrochure;


- (IBAction)doClientProfileBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *doSIBtn;
- (IBAction)doSalesIllustrationBtn:(id)sender;
- (IBAction)doSettingsBtn:(id)sender;
- (IBAction)doeCFFBtn:(id)sender;
- (IBAction)doeAppBtn:(id)sender;
- (IBAction)doBrochureBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *myView;



- (IBAction)selectClientProfile:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *selectSI;
- (IBAction)selectSalesIllustration:(id)sender;
- (IBAction)selectBrochure:(id)sender;
- (IBAction)selectCFF:(id)sender;
- (IBAction)selectEApp:(id)sender;
- (IBAction)selectSettings:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *CPBtn;



@end
