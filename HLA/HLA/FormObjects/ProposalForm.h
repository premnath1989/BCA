//
//  ProposalForm.h
//  HLA_InfoConnect
//
//  Created by compurex on 1/9/14.
//  Copyright (c) 2014 compurex. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ProposalForm : NSObject
@property (nonatomic,retain)UIWebView *PDFGenerator;
-(void)GenerateProposalPDF:(NSDictionary*)DataDictionary RNNumber:(NSMutableString *)RNNumber;
@end
