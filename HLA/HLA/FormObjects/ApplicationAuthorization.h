//
//  ApplicationAuthorization.h
//  HLA_InfoConnect
//
//  Created by compurex on 1/9/14.
//  Copyright (c) 2014 compurex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplicationAuthorization : NSObject
@property (nonatomic,retain)UIWebView *PDFGenerator;
-(void)GenerateApplicationAuthorizationPDF:(NSDictionary*)DataDictionary RNNumber:(NSMutableString*) RNNumber;
@end
