//
//  DataClass.h
//  testSingleton
//
//  Created by Meng Cheong on 6/17/13.
//  Copyright (c) 2013 Meng Cheong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"

@interface DataClass : NSObject {
    
    NSString *str;
    NSString *status;
    NSMutableDictionary *CFFData;
    NSMutableDictionary *eAppData;
    NSMutableDictionary *SIData;
    
    
}
@property(nonatomic,retain)NSString *str;
@property(nonatomic,retain)NSString *status;
@property(nonatomic,retain)NSMutableDictionary *CFFData;
@property(nonatomic,retain)NSMutableDictionary *eAppData;
@property(nonatomic,retain)NSMutableDictionary *SIData;
+(DataClass*)getInstance;
-(void)logger;
@end
