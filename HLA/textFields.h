//
//  textFields.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface textFields : NSObject

+(BOOL)validateString:(NSString *)string;
+(BOOL)validateString2:(NSString *)string;
+(BOOL)validateString3:(NSString *)string;
+(BOOL)validateString3withView:(NSString *)string view:(UIView *)view;
+(BOOL)validateOtherID:(NSString *)string;
+(NSString *)trimWhiteSpaces:(NSString *)string;
+(BOOL)validateEmail:(NSString *)string;
@end
