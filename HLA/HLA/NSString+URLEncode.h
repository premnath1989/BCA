//
//  NSString+URLEncode.h
//  Warbler
//
//  Created by JK on 29/05/13.
//  Copyright (c) 2013 Theoria Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncode)

- (NSString *)urlEncode;

- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;


@end
