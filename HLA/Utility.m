//
//  Utility.m
//  iMobile Planner
//
//  Created by Meng Cheong on 8/1/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "Utility.h"

@implementation Utility
+(void)showAllert:(NSString*)msg{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    alert = nil;
}

+(void)showAlertWithTag:(NSString*)msg withTag:(int)alertTag{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert setTag:alertTag];
    alert = nil;
}


@end
