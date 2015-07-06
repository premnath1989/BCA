//
//  COAPDF.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/16/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <signdociosfoundations/SDSignatureHandler.h>
#import <signdociosfoundations/SDSignatureCaptureController.h>
#import <MessageUI/MessageUI.h>

@class COAPDF;

@protocol COAPDFDelegate <NSObject>

//- (void)playerDetailsViewControllerDidCancel:(PlayerDetailsViewController *)controller;
//- (void)playerDetailsViewController:(PlayerDetailsViewController *)controller didAddPlayer:(Player *)player;
-(void)displayESignForms;
@end


@interface COAPDF : UIViewController<SDSignatureHandler,UIDocumentInteractionControllerDelegate>{

SDSignatureCaptureController *dialog;
    
int initDoTest;    
    
}

@property (nonatomic, weak) id <COAPDFDelegate> delegate;

@property (strong,nonatomic)UIDocumentInteractionController *documentInteractionController;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIWebView *COAView;
@property (strong, nonatomic) IBOutlet UINavigationBar *naviBar;

- (IBAction)doDone:(id)sender;
- (IBAction)openWith:(id)sender;
@end
