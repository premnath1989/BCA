//
//  SignatureCaptureHandler.h
//  SignDoc Mobile
//
//  Created by Nils Durner on 25.05.11.
//  Copyright 2011 Softpro GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#if HAVE_TABLETSERVER
#import "OutgoingMessageQueue.h"
#endif
#ifdef TARGET_iOSFoundations
#import "SignatureCaptureViewController.h"
#endif
#import "SDSignatureHandler.h"
#import "SDSignatureCaptureController.h"
#import "PathHistoryCallback.h"

@interface SignatureCaptureHandler : NSObject <UIAlertViewDelegate, PathHistoryCallback> {
    // FIXME: these callbacks and the signatureHandler should be unified observer*s*; => TabletServer client
    NSObject *doneObj;
    NSObject *abortObj;
    SEL doneSEL;
    SEL abortSEL;
    
    NSObject<SDSignatureHandler> *signatureHandler;
#if HAVE_TABLETSERVER
    OutgoingMessageQueue *queue;
#endif
#ifdef TARGET_iOSFoundations
    SignatureCaptureViewController
#else
	id
#endif
		*viewController;
    BOOL connected;
    NSString *fieldId;
	NSString *title;
    
    UIViewController *parent;
}

+ (SignatureCaptureHandler *) instance;
- (void) startWithServerReady: (NSNumber *) serverReady;
- (void) clear;
- (BOOL) isCapturing;
- (void) externalAbort;

#if HAVE_TABLETSERVER
@property (retain) OutgoingMessageQueue *queue;
#endif

@property (assign) UIViewController *parent;
@property (readonly)
#ifdef TARGET_iOSFoundations
SignatureCaptureViewController
#else
id
#endif
	*viewController;
@property (retain) id<SDSignatureHandler> signatureHandler;
@property (retain) NSObject *doneObj;
@property (retain) NSObject *abortObj;
@property SEL doneSEL;
@property SEL abortSEL;
@property (retain) NSString *title;
@property (nonatomic,retain) UIImage *backgroundImage;
@property (nonatomic,retain) NSDictionary *penProperties;
@property (assign) NSInteger dialogPosition;
@property (retain) NSString *fieldId;
@property (retain) NSArray *dialogXibs;
@property (retain) NSArray *languages;

@end
