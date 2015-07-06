//
//  SDMSettingsProtocol.h
//  SignDoc Mobile
//
//  Created by Nils Durner on 07.12.12.
//  Copyright (c) 2012 Softpro GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SDMSettingsProtocol

- (id) initWithSettings: (NSObject<SDMSettingsProtocol> *) src;
- (NSInteger) getPenSize;
- (NSString *) getPenStyle;
- (NSString *) getPortalUrl;
- (NSString *) getSdwUrl;
- (NSString *) getTabletServer;
- (NSString *) getAppTitle;
- (NSInteger) getExpiry;
- (NSInteger) getCaptureDialogPos;
- (NSInteger) getLinkID;
- (NSString *) getProfileName;
- (NSString *) getProfileLogo;
- (NSString *) externalHelp;
- (NSInteger) getBuyTabVisibility;
- (NSInteger) getHomeTabVisibility;
- (NSInteger) getHelpTabVisibility;
- (void) setPenSize: (NSInteger) penSize;
- (void) setPenStyle: (NSString *) penStyle;
- (void) setPortalUrl: (NSString *) portalUrl;
- (void) setSdwUrl: (NSString *) sdwUrl;
- (void) setTabletServer: (NSString *) tabletServer;
- (void) setAppTitle: (NSString *) appTitle;
- (void) setExpiry: (NSInteger) expiry;
- (void) setCaptureDialogPos: (NSInteger) dialogPos;
- (void) setProfileName: (NSString *) profileName;
- (void) setProfileLogo: (NSString *) profileLogo;
- (void) setExternalHelp: (NSString *) externalHelp;
- (void) setConfigUrl: (NSURL *) configUrl;
- (NSURL *) configUrl;
- (void) setSignerName: (NSString *) signerName;
- (NSString *) getSignerName;
- (void) setSetTimestamp: (NSNumber *) setTimestamp;
- (NSNumber *) getSetTimestamp;
- (void) setEnableSignerName: (NSNumber *) enableSignerName;
- (NSNumber *) getEnableSignerName;
- (void) setEnableSetTimestamp: (NSNumber *) setTimestamp;
- (NSNumber *) getEnableSetTimestamp;
- (void) setBuyTabVisibility: (NSInteger) buyTabVisibility;
- (void) setUseCS500: (BOOL) useCS500;
- (BOOL) getUseCS500;


@property (assign, getter = getPenSize, setter = setPenSize:) NSInteger penSize;
@property (copy, getter = getPenStyle, setter = setPenStyle:) NSString *penStyle;
@property (copy, getter = getPortalUrl, setter = setPortalUrl:) NSString *portalUrl;
@property (copy, getter = getSdwUrl, setter = setSdwUrl:) NSString *sdwUrl;
@property (copy, getter = getTabletServer, setter = setTabletServer:) NSString *tabletServer;
@property (copy, getter = getAppTitle, setter = setAppTitle:) NSString *appTitle;
@property (getter = getExpiry, setter = setExpiry:) NSInteger expiry;
@property (getter = getCaptureDialogPos, setter = setCaptureDialogPos:) NSInteger captureDialogPos;
@property (getter = getLinkID, setter = setLinkID:) NSInteger linkID;
@property (getter = getProfileName, setter = setProfileName:) NSString *profileName;
@property (getter = getProfileLogo, setter = setProfileLogo:) NSString *profileLogo;
@property (getter = getExternalHelp, setter = setExternalHelp:) NSString *externalHelp;
@property (getter = configUrl, setter = setConfigUrl:) NSURL *configUrl;
@property (getter = getSignerName, setter = setSignerName: ) NSString *signerName;
@property (copy, getter = getSetTimestamp, setter = setSetTimestamp:) NSNumber *setTimestamp;
@property (getter = getEnableSignerName, setter = setEnableSignerName: ) NSNumber *enableSignerName;
@property (copy, getter = getEnableSetTimestamp, setter = setEnableSetTimestamp:) NSNumber *enableTimestamp;
@property (getter = getBuyTabVisibility, setter = setBuyTabVisibility:) NSInteger buyTabVisibility;
@property (getter = getHomeTabVisibility, setter = setHomeTabVisibility:) NSInteger homeTabVisibility;
@property (getter = getHelpTabVisibility, setter = setHelpTabVisibility:) NSInteger helpTabVisibility;
@property (getter = getUseCS500, setter = setUseCS500:) BOOL useCS500;

@end
