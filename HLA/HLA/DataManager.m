//
//  DataManager.m
//  iMobile Planner
//
//  Created by CK Quek on 4/17/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

+ (void)wipeAppData {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString * documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSError *error = nil;
    for (NSString *file in [fileManager contentsOfDirectoryAtPath:documentsDirectory error:&error]) {
        BOOL success = [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:file] error:&error];
        if (!success || error) {
            NSLog(@"Error: Wipe operation failed at file: [%@]", file);
        }
    }
    
    
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    
    error = nil;
    NSString *cacheDirectory = [[NSHomeDirectory() stringByAppendingString:@"/Library/Caches"] stringByAppendingPathComponent:bundleIdentifier];
    BOOL success = [fileManager removeItemAtPath:cacheDirectory error:&error];
    if (!success || error) {
        NSLog(@"Error: Wipe operation failed at directory: [%@]", cacheDirectory);
    }
    
    error = nil;
    NSString *snapshotDirectory = [[NSHomeDirectory() stringByAppendingString:@"/Library/Caches/Snapshots"] stringByAppendingPathComponent:bundleIdentifier];
    success = [fileManager removeItemAtPath:snapshotDirectory error:&error];
    if (!success || error) {
        NSLog(@"Error: Wipe operation failed at directory: [%@]", snapshotDirectory);
    }
    
    // Remove application stored preferences in standardUserDefaults. Probably a good idea to keep this the last part of the cleanup.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
    [defaults setBool:true forKey:@"Terminated"];       // Keep state for next launch
    [defaults synchronize];
}

@end
