/*==============================================================*
 * SOFTPRO SignDoc Mobile SDK                                   *
 *                                                              *
 * @(#)NSURL+QueryParams.h                                      *
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
 * @brief Routines to access URL query parameters
 * @implements NSURL
 */
@interface NSURL (SPQueryParams)

/**
 * @brief Creates a dictionary of URL query parameters and their values
 * @return parameter dictionary. Autoreleased.
 */
- (NSDictionary *) sp_queryParams;

/**
 * @brief Returns the URL without query parameters
 * @return URL string. Autoreleased.
 */
- (NSString *) sp_URLStringWithoutQuery;

/**
 * @brief Adds parameters to the URL
 * @param addParams new parameters to be added
 * @return URL with new parameters added. Autoreleased.
 */
- (NSURL *) sp_urlWithParamsAdded: (NSDictionary *) addParams;

@end
