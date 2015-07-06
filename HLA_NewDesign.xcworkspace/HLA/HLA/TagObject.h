//
//  TagObject.h
//  iMobile Planner
//
//  Created by Juliana on 7/30/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TagObject : NSObject

@property (assign) int tagValue;
@property (strong, nonatomic) NSString *fd1;
@property (strong, nonatomic) NSString *fd2;
@property (strong, nonatomic) NSString *fd3b;
@property (strong, nonatomic) NSString *fd3w;
@property (strong, nonatomic) NSString *fd3wbo;
@property (strong, nonatomic) NSString *fd5;
@property (strong, nonatomic) NSString *fd6;
@property (assign) NSInteger t1;

@property (strong, nonatomic) NSString *personType;
@property (strong, nonatomic) NSString *companyName;
@property (strong, nonatomic) NSString *lifeTerm;
@property (strong, nonatomic) NSString *accident;
@property (strong, nonatomic) NSString *criticalIllness;
@property (strong, nonatomic) NSString *dateIssued;

+ (TagObject *) tagObj;

@end
