//
//  UpdateDatabase.h
//  iMobile Planner
//
//  Created by CK Quek on 6/12/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface UpdateTableWithSIType : NSObject

+(void)addSITypeColumn:(NSString*)databasepath;
@end
