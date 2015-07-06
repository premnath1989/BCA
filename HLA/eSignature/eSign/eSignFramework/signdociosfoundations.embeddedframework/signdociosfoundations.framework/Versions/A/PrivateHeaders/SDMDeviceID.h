//
//  DeviceID.h
//  SignDoc Mobile
//
//  Created by Nils Durner on 20.04.11.
//  Copyright 2011 Softpro GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SDMDeviceID : NSObject {
	NSDictionary *keychainDict;
}

+ (SDMDeviceID *) instance;
- (NSString *) deviceId;

@end
