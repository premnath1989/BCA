//
//  AppDelegate.h
//  HLA
//
//  Created by Md. Nazmus Saadat on 9/26/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIUtilities.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSString *databasePath;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign,readwrite) int indexNo;
@property (nonatomic, assign,readwrite) int HomeIndex;
@property (nonatomic, assign,readwrite) int ProspectListingIndex;
@property (nonatomic, assign,readwrite) int NewProspectIndex;
@property (nonatomic, assign,readwrite) int SIListingIndex;
@property (nonatomic, assign,readwrite) int NewSIIndex;
@property (nonatomic, assign,readwrite) int ExitIndex;
@property (nonatomic,strong) id userRequest;
@property (nonatomic,strong) id MhiMessage;
@property (nonatomic,strong) id EverMessage;
@property (nonatomic,assign,readwrite) BOOL SICompleted;
@property (nonatomic,assign,readwrite) BOOL ExistPayor;
@property (nonatomic,assign,readwrite) BOOL isNeedPromptSaveMsg;
@property (nonatomic,assign,readwrite) BOOL isSIExist;//after saving basic plan
@property (nonatomic, retain) NSString* bpMsgPrompt;
@property (nonatomic, retain) NSString* PDFpath;
@end
