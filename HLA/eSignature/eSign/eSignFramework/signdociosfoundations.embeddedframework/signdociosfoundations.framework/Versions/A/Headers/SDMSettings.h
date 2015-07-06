//
//  SDMSettings.h
//  SignDoc Mobile
//
//  Created by Nils Durner on 12.12.12.
//  Copyright (c) 2012 Softpro GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDMSettingsProtocol.h"

@interface SDMSettings : NSObject<SDMSettingsProtocol>

- (id) initWithSettings: (NSObject<SDMSettingsProtocol> *) src;
+ (BOOL) verifyURISignature: (NSURL *) uri;
- (void) overloadWithDictionary: (NSDictionary *) params;
- (BOOL) isExpired;

@end
