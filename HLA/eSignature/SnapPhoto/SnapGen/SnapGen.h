//
//  SnapGen.h
//  CardSnap
//
//  Created by Danial D. Moghaddam on 5/14/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SnapGen : NSObject
-(NSString *)generatePdfFromSnapArray:(NSArray *)snaps withFileName:(NSString *)fileName:(NSString *)SamePolicyOwner ;
@property (strong, nonatomic) NSString *Filename1;
@end
