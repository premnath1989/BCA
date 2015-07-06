//
//  SDMSettings.h
//  SignDoc Mobile
//
//  Created by Nils Durner on 06.12.12.
//  Copyright (c) 2012 Softpro GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDMSettings.h"

@interface SDMTransientSettings : SDMSettings {
	NSMutableDictionary *dict;
}

- (id) init;

@end
