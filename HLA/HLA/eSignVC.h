//
//  eSignVC.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/16/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class eSignVC;
@class formsDetails;

@protocol eSignVCDelegate <NSObject>

//- (void)playerDetailsViewControllerDidCancel:(PlayerDetailsViewController *)controller;
//- (void)playerDetailsViewController:(PlayerDetailsViewController *)controller didAddPlayer:(Player *)player;
-(void)displayPDF:(NSString *)formType;
-(void)updateeSignCell;
@end

@interface eSignVC : UIViewController

@property (nonatomic, weak) id <eSignVCDelegate> delegate;
- (IBAction)doDone:(id)sender;

@end
