//
//  CAform.h
//  HLAInfoConnect
//
//  Created by compurex on 12/24/13.
//  Copyright (c) 2013 compurex. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CAform : NSObject
@property (nonatomic,retain)UIWebView *PDFGenerator;
-(void)GenerateCAPDF:(NSDictionary*)DataDictionary RNNumber:(NSMutableString*) RNNumber;
@end
