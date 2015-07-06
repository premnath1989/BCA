//
//  DeviceProperties.h
//  SignDoc Mobile
//
//  Created by Udo Kolb on 26.06.12.
//  Copyright (c) 2012 Softpro GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDDeviceProperties : NSObject {
    
}

/* Query the device width in pixel, typically equals the display width */
+ (int) deviceWidth;
/* Query the device height in pixel, typically equals the display height */
+ (int) deviceHeight;
/** Query the device name (e. g. 'iPhone' */
+ (NSString *) deviceName;
/** Query the device serial, MAC address */
+ (NSString *) deviceSerial;
/** query the device type, 501 for iPad, 502 for iPhone */
+ (int) deviceType;
/** Query the smple rate, always 0, no equidistant time samples */
+ (int) sampleRate;
/** Query the resolution of the device */
+ (int) resolution;
/** Query the number of pressure levels of the device */
+ (int) pressureLevels;
/* Query the display width */
+ (int) dispayWidth;
/* Query the display Height */
+ (int) displayHeight;
/* Query the display color depth */
+ (int) displayBpP;
@end
