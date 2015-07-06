//
//  NSString+tools.m
//  PDF
//
//  Created by Travel Chu on 3/25/14.
//  Copyright (c) 2014 Nexstream. All rights reserved.
//

#import "NSString+tools.h"

@implementation NSString (tools)
- (NSString *)stringByReplacingString:(NSString *)target withString:(NSString *)replacement{
    if (!target) {
        target=@"";
    }
    if (!replacement) {
        replacement=@"";
    }
    return [self stringByReplacingOccurrencesOfString:target withString:replacement];
}
@end
