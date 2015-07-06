//
//  SDWConfigurationManager.h
//  SignDoc Mobile
//
//  Created by Nils Durner on 06.12.12.
//  Copyright (c) 2012 Softpro GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDMTransientSettings.h"
#import "SDMPersistentSettings.h"

@interface SDWConfigurationManager : NSObject {
	SDMSettings *effectiveSettings;
	SDMPersistentSettings *currentProfile;
}

+ (SDWConfigurationManager *) instance;
+ (void) initializePresets;

- (void)addProConfigIfPurchased;
- (void) rmProConfigIfExpired;

- (void) loadDefaultSettings;
- (void) setDefaultSettingsID: (NSInteger) linkID;
- (void) loadSettingsByID: (NSInteger) linkID;
- (void) resetEffectiveSettings;
- (void) setEffectiveSettings: (NSDictionary *) dict;
- (NSNumber *) addProfileWithLink: (NSURL *) link;
- (SDMSettings *) getEffectiveSettings;
- (SDMSettings *) getCurrentProfile;
- (NSInteger) defaultConfigID;
- (NSInteger) unexpiredProfileCount;

@end
