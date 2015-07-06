//
//  ViewController.h
//  PDF
//
//  Created by Travel Chu on 3/11/14.
//  Copyright (c) 2014 Nexstream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PDFCreater : NSObject

@property (nonatomic, strong) NSString *PDFpath;
@property (nonatomic, strong) NSData *PDFdata;

-(NSString *)generatePRFormFromPRXMLPath:(NSString *)prXMLPath
                            andSIXMLPath:(NSString *)siXMPPath
                     andDatabaseFilePath:(NSString *)sqlDBPath;
@end
