//
//  PRPage2.h
//  PDF
//
//  Created by Travel Chu on 3/13/14.
//  Copyright (c) 2014 Nexstream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PRPage2 : NSObject
{
	NSString *CountyDesc;
}
@property (nonatomic,retain)NSString *CountyDesc;

+(NSString*)prPage2WithDictionary:(NSDictionary*)dicttionary;

@end
