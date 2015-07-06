//
//  ProductRecommended.h
//  iMobile Planner
//
//  Created by Meng Cheong on 8/26/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExistingProductRecommended.h"

@class ProtectionPlans;

@protocol ProductRecommendedDelegate <NSObject>

-(void)ExistingProductRecommendedUpdate:(ExistingProductRecommended *)controller rowToUpdate:(int)rowToUpdate;
-(void)ExistingProductRecommendedDelete:(ExistingProductRecommended *)controller rowToUpdate:(int)rowToUpdate;
@end


@interface ProductRecommended : UIViewController<UIAlertViewDelegate> //fixed bug 2612

- (IBAction)doSave:(id)sender;

- (IBAction)doCancel:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *myView;

@property (nonatomic, retain) ExistingProductRecommended *ExistingProductRecommendedVC;
@property (nonatomic, weak) id <ProductRecommendedDelegate> delegate;
@property(nonatomic, assign) int rowToUpdate;
@property(nonatomic, assign) int SIProduct;

-(void)doDelete:(int)rowToUpdate;


@end
