//
//  SDMPersistentSettings.h
//  SignDoc Mobile
//
//  Created by Nils Durner on 06.12.12.
//  Copyright (c) 2012 Softpro GmbH. All rights reserved.
//

#import "SDMSettingsProtocol.h"
#import "SDMSettings.h"

@interface SDMPersistentSettings : SDMSettings {
    NSUserDefaults *defs;
	NSNumber *linkID;
}

+ (SDMPersistentSettings *) settingsWithID: (NSInteger) lid immutable: (BOOL) immutable;
+ (SDMPersistentSettings *) settingsWithSettings: (SDMSettings *) sets linkID: (NSInteger) lid;
- (SDMSettings *) nonPersistentSettings;

- (void)setLinkID:(NSInteger) lid;
- (NSInteger) getLinkID;
- (NSString *) displayName;

@property (getter = getLinkID, setter = setLinkID:) NSInteger linkID;
@property BOOL immutable;

@end
