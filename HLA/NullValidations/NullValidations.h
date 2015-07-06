//
//  NullValidations.h
//  Feedback
//
//  Created by Krishna Prakash on 31/12/13.
//  Copyright (c) 2013 SRAOSS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NullValidations : NSObject

@end


@interface NSDictionary (NullReplacement)

- (NSDictionary *)dictionaryByReplacingNullsWithBlanks;

@end


@interface NSArray (NullReplacement)

- (NSArray *)arrayByReplacingNullsWithBlanks;

@end