//
//  MainScreen.h
//  HLA
//
//  Created by Md. Nazmus Saadat on 9/26/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSVerticalTabBarController.h"
#import "BasicPlanHandler.h"
#import "PayorHandler.h"
#import "SecondLAHandler.h"

@interface MainScreen : FSVerticalTabBarController<FSTabBarControllerDelegate>{
	    
}

@property (nonatomic, assign,readwrite) int indexNo;
@property (nonatomic,strong) id userRequest;
@property (nonatomic,strong) id requestSINo;
@property (nonatomic,strong) id tradOrEver;
@property (nonatomic,strong) id EAPPorSI;

@property (nonatomic, assign,readwrite) int IndexTab;
@property (nonatomic,strong) BasicPlanHandler *mainBH;
@property (nonatomic,strong) PayorHandler *mainPH;
@property (nonatomic,strong) SecondLAHandler *mainLa2ndH;



@property (nonatomic,strong) id showQuotation;
@end
