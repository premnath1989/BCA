//
//  CAform.m
//  HLAInfoConnect
//
//  Created by compurex on 12/24/13.
//  Copyright (c) 2013 compurex. All rights reserved.
//

#import "SIform.h"
#import "NDHTMLtoPDF2.h"

@implementation SIform{
    NSMutableString *htmlContent;
    NSMutableString *referenceNo;
}

@synthesize PDFGenerator;
-(void)GenerateSIPDF:(NSDictionary*)DataDictionary RNNumber:(NSMutableString*) RNNumber
{
    htmlContent = [[NSMutableString alloc]initWithString:[NSMutableString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"index1" ofType:@"html" inDirectory:@"SI"]
                                                                                          encoding: NSUTF8StringEncoding
                                                                                             error: nil]];
    referenceNo = [[NSMutableString alloc]init];
    NSString *SearchID;
    NSRange SearchIDRange;
    NSString *newValue;
    
    for (id key in DataDictionary) {
        if([key isEqualToString:@"ReferenceNo"]){
            referenceNo = [DataDictionary objectForKey:key];
        }else{
            referenceNo =  RNNumber;
        }
        if([[NSString stringWithFormat:@"%@",[DataDictionary objectForKey:key]] isEqualToString:@"Selection-Yes"] || [[NSString stringWithFormat:@"%@",[DataDictionary objectForKey:key]] isEqualToString:@"Selection-No"]){
            if([[NSString stringWithFormat:@"%@",[DataDictionary objectForKey:key]] isEqualToString:@"Selection-Yes"]){
                SearchID = [NSString stringWithFormat:@"<ul type=\"circle\" id=\"%@\"",key];
                SearchIDRange = [htmlContent rangeOfString: SearchID
                                                   options: NSLiteralSearch];
                newValue = [NSString stringWithFormat:@"<ul type=\"disc\" id=\"%@\"",key];
            }
        }else{
            SearchID = [NSString stringWithFormat:@"id=\"%@\"></span>",key];
            SearchIDRange = [htmlContent rangeOfString: SearchID
                                               options: NSLiteralSearch];
            newValue = [NSString stringWithFormat:@"id=\"%@\">%@</span>",key,[DataDictionary objectForKey:key]];
        }
        while (SearchIDRange.location != NSNotFound) {
            [htmlContent replaceCharactersInRange: SearchIDRange
                                       withString: newValue];
            SearchIDRange = [htmlContent rangeOfString: SearchID];
        }
    }
    
    self.PDFGenerator = [NDHTMLtoPDF2 createPDFWithHTML:htmlContent
                                               baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index1" ofType:@"html" inDirectory:[NSString stringWithFormat:@"SI"]]]
                                            pathForPDF:[[NSString stringWithFormat:@"~/Documents/Forms/%@_SI.pdf",referenceNo] stringByExpandingTildeInPath]
                                              delegate:nil
                                              pageSize:kPaperSizeA4_landscape    //kPaperSizeA4_landscape for index4
                                               margins:UIEdgeInsetsMake(10, 5, 10, 5)];
    
    //HTTPPost *PostRequest = [[HTTPPost alloc]init];
    //[PostRequest HTTPPost:[NSString stringWithFormat:@"%@_SI.pdf",referenceNo]];
}
@end































