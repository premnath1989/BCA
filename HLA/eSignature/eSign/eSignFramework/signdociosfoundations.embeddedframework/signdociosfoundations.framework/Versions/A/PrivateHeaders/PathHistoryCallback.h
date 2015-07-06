//
//  PathHistoryCallback.h
//  SignDoc Mobile
//
//  Created by Nils Durner on 27.06.12.
//  Copyright (c) 2012 Softpro GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PathHistoryCallback <NSObject>

- (void) pathHistoryNewPointX: (unsigned long long) x y: (unsigned long long) y p: (unsigned long long) p t: (unsigned long long) t;
- (void) pathHistoryClear;

@end
