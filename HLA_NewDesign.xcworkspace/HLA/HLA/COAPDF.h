//
//  COAPDF.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/16/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class COAPDF;

@protocol COAPDFDelegate <NSObject>

//- (void)playerDetailsViewControllerDidCancel:(PlayerDetailsViewController *)controller;
//- (void)playerDetailsViewController:(PlayerDetailsViewController *)controller didAddPlayer:(Player *)player;
-(void)displayESignForms;
@end


@interface COAPDF : UIViewController<UIDocumentInteractionControllerDelegate>

@property (nonatomic, weak) id <COAPDFDelegate> delegate;

@property (strong,nonatomic)UIDocumentInteractionController *documentInteractionController;
@property (weak, nonatomic) IBOutlet UIWebView *COAView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *openWithBtn;

- (IBAction)doDone:(id)sender;
- (IBAction)openWith:(id)sender;
@end
