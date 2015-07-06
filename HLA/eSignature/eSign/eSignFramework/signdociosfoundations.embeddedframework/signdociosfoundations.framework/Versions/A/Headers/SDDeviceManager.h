/*==============================================================*
 * SOFTPRO SignDoc Mobile SDK                                   *
 *                                                              *
 * @(#)SDDeviceManager.h                                        *
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
 * @brief Manage pens
 */
@interface SDDeviceManager : NSObject

/**
 * @brief Starts the discovery of pens. Currently, only the Intuos Creative Stylus from Wacom is supported. When the pen is discovered, it will be used for signing as long as it is still available. Signing with the pen will reject finger input.
 */
+(void) startDeviceDiscovery;

@end
