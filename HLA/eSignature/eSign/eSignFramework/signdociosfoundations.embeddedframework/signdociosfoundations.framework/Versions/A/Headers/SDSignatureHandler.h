/*==============================================================*
 * SOFTPRO SignDoc Mobile SDK                                   *
 *                                                              *
 * @(#)SignatureHandlerProtocol.h                               *
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
 * @brief Interface for handling the result of a signature capture process
 */
@protocol SDSignatureHandler <NSObject>

/**
 * @brief Handle signature data
 * @param points signature data, or nil if signature is not valid
 * @param fieldId PDF field name/id
 */
- (void) handleSignature: (CFDataRef) points withFieldId: (NSString *) fieldId;

/**
 * @brief Handle cancelled signature process
 * @param fieldId PDF field name/id
 */
- (void) abortSignature: (NSString *) fieldId;

/**
 * @brief Handle erase/redo signature event
 */
- (void) eraseSignature;

@optional
- (void) pointHistoryX: (unsigned long long) x y:(unsigned long long) y p: (unsigned long long) p t: (unsigned long long) t;
- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation;

@end
