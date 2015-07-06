//
//  FFform.m
//  HLA_InfoConnect
//
//  Created by compurex on 12/31/13.
//  Copyright (c) 2013 compurex. All rights reserved.
//

#import "SupplementaryProposalForm1.h"
#import "NDHTMLtoPDF2.h"
@implementation SupplementaryProposalform1{
    NSMutableString *htmlContent;
    NSMutableString *referenceNo;
}

@synthesize PDFGenerator;
-(void)GenerateSupplementaryProposalPDF1:(NSDictionary*)DataDictionary RNNumber:(NSMutableString*) RNNumber
{
    htmlContent = [[NSMutableString alloc]initWithString:[NSMutableString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"index1" ofType:@"html" inDirectory:@"SupplementaryProposalForm"]
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
                                               baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index1" ofType:@"html" inDirectory:[NSString stringWithFormat:@"SupplementaryProposalForm"]]]
                                         //    pathForPDF:[[NSString stringWithFormat:@"~/Documents/Forms/%@_SP_1.pdf",referenceNo]
                                            pathForPDF:[[NSString stringWithFormat:@"~/Documents/Forms/%@_ID.pdf",referenceNo] 
                                                        stringByExpandingTildeInPath]
                                              delegate:nil
                                              pageSize:kPaperSizeA4_portrait    //kPaperSizeA4_landscape for index4
                                               margins:UIEdgeInsetsMake(32, 5, 10, 5)];
 
    
    
    //HTTPPost *PostRequest = [[HTTPPost alloc]init];
    //[PostRequest HTTPPost:[NSString stringWithFormat:@"%@_FF.pdf",referenceNo]];
}
@end
