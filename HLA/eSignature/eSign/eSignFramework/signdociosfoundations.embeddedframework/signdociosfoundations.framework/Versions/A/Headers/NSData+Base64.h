//
//  NSData+Base64.h
//  base64
//
//  Modified for SOFTPRO by Nils Durner, 2011-07-26
//
//  Created by Matt Gallagher on 2009/06/03.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import <Foundation/Foundation.h>

/**
 * @brief Base64 Codec for NSData
 * @implements NSData
 */
@interface NSData (SPBase64)

/**
 * @brief Creates an NSData object containing the base64 decoded representation of the base64 string 'aString'
 * @param aString the base64 string to decode
 * @return the autoreleased NSData representation of the base64 string
 */
+ (NSData *)sp_dataFromBase64String:(NSString *)aString;

/**
 * @brief Creates an NSString object that contains the base 64 encoding of the receiver's data. Lines are broken at 64 characters long.
 * @return autoreleased base 64 representation of the receiver
 */
- (NSString *) sp_base64EncodedString;

@end
