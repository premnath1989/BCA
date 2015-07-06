/*==============================================================*
 * SOFTPRO SignDoc Mobile SDK                                   *
 *                                                              *
 * @(#)NSData+JSByteArray.h                                     *
 *                                                              *
 * Copyright SOFTPRO GmbH                                       *
 * Wilhelmstrasse 34, D-71034 Boeblingen                        *
 * All rights reserved.                                         *
 *                                                              *
 * This software is the confidential and proprietary            *
 * information of SOFTPRO ("Confidential Information"). You     *
 * shall not disclose such Confidential Information and shall   *
 * use it only in accordance with the terms of the license      *
 * agreement you entered into with SOFTPRO.                     *
 *==============================================================*/

#import <Foundation/Foundation.h>

/**
 * @brief JavaScript serialization
 * @implements NSData
 */
@interface NSData (SPJSByteArray)

/**
 * @brief Serialize to a JavaScript byte[]
 * @return JS representation of this object. Autoreleased.
 */
- (NSString *) sp_jsByteArray;

@end
