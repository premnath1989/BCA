//
//  PRHtmlHandler.m
//  PDF
//
//  Created by Travel Chu on 3/12/14.
//  Copyright (c) 2014 Nexstream. All rights reserved.
//

#import "PRHtmlHandler.h"
#import "PRPage1.h"
#import "PRPage2.h"
#import "PRPage3.h"
#import "PRPage4.h"
#import "PRPage5.h"
#import "PRPage6.h"
#import "PRPage7.h"
#import "PRPage8.h"
#import "PRPage9.h"
#import "PRPage10.h"
#import "PRPage11.h"
#import "PRPage12.h"
#import "PRPage13.h"
#import "PRPage14.h"

#import "SynthesizeSingleton.h"

@interface PRHtmlHandler ()
@property(strong, nonatomic) NSDictionary *dataDict;
@property(strong, nonatomic) NSDictionary *infoDict;
@end
@implementation PRHtmlHandler
SYNTHESIZE_SINGLETON_FOR_CLASS(PRHtmlHandler);
- (NSString *)htmlStringWithDictionary:(NSDictionary *)dict {
  //    [self changeFile];
  self.pageCount = 14;
  self.currentPage = 0;
  self.top = 822.05;
  NSMutableDictionary *pageTopDict = (NSMutableDictionary *)@{
    @"page2" : @"852",
    @"page3" : @"1704",
    @"page11" : @"2556",
    @"page4" : @"3408",
    @"page13" : @"4260",
    @"page8" : @"5112",
    @"page9" : @"5964",
    @"page5" : @"6816",
    @"page6" : @"7668",
    @"page7" : @"8520",
    @"page10" : @"9372",
    @"page12" : @"10224",
    @"page14" : @"11076",    
//    @"page13" : @"8520",
    @"page2height" : @"842",
    @"page3height" : @"842",
    @"page7height" : @"842"
  };

  [PRHtmlHandler sharedPRHtmlHandler].pageTopDict = pageTopDict;
  _dataDict = dict[@"eApps"];
  _infoDict = _dataDict[@"AssuredInfo"];
  NSString *htmlFile =
      [[NSBundle mainBundle] pathForResource:@"PR"
                                      ofType:@"al"
                                 inDirectory:@"PDFCreater.bundle"];
  self.htmlStr = [NSString stringWithContentsOfFile:htmlFile
                                           encoding:NSUTF8StringEncoding
                                              error:nil];
    NSString *page1 = [PRPage1 prPage1WithDictionary:_dataDict];
    NSString *page2 = [PRPage2 prPage2WithDictionary:_dataDict];
    NSString *page3 = [PRPage3 prPage3WithDictionary:_dataDict];
    NSString *page11 = [PRPage11 prPage11WithDictionary:_dataDict];    
    NSString *page4 = [PRPage4 prPage4WithDictionary:_dataDict];
    NSString *page13 = [PRPage13 prPage13WithDictionary:_dataDict];
    NSString *page8 = [PRPage8 prPage8WithDictionary:_dataDict];
    NSString *page9 = [PRPage9 prPage9WithDictionary:_dataDict];
    NSString *page5 = [PRPage5 prPage5WithDictionary:_dataDict];
    NSString *page6 = [PRPage6 prPage6WithDictionary:_dataDict];
    NSString *page7 = [PRPage7 prPage7WithDictionary:_dataDict];
    NSString *page10 = [PRPage10 prPage10WithDictionary:_dataDict];
    NSString *page12 = [PRPage12 prPage12WithDictionary:_dataDict];
    NSString *page14 = [PRPage14 prPage14WithDictionary:_dataDict];


  self.htmlStr =
      [self.htmlStr stringByReplacingString:@"##PR_page1##" withString:page1];
  self.htmlStr =
      [self.htmlStr stringByReplacingString:@"##PR_page2##" withString:page2];
  self.htmlStr =
      [self.htmlStr stringByReplacingString:@"##PR_page3##" withString:page3];

    self.htmlStr =
    [self.htmlStr stringByReplacingString:@"##PR_page11##" withString:page11];
    
    self.htmlStr =
      [self.htmlStr stringByReplacingString:@"##PR_page4##" withString:page4];

    self.htmlStr =
    [self.htmlStr stringByReplacingString:@"##PR_page13##" withString:page13];
    
    self.htmlStr =
    [self.htmlStr stringByReplacingString:@"##PR_page8##" withString:page8];
    
    self.htmlStr =
    [self.htmlStr stringByReplacingString:@"##PR_page9##" withString:page9];
    
  self.htmlStr =
      [self.htmlStr stringByReplacingString:@"##PR_page5##" withString:page5];
  self.htmlStr =
      [self.htmlStr stringByReplacingString:@"##PR_page6##" withString:page6];
    
    self.htmlStr =
    [self.htmlStr stringByReplacingString:@"##PR_page7##" withString:page7];
    
    self.htmlStr =
      [self.htmlStr stringByReplacingString:@"##PR_page10##" withString:page10];
    
    
//  self.htmlStr =
//      [self.htmlStr stringByReplacingString:@"##PR_page11##" withString:page11];
  self.htmlStr =
      [self.htmlStr stringByReplacingString:@"##PR_page12##" withString:page12];
    
    self.htmlStr =
    [self.htmlStr stringByReplacingString:@"##PR_page14##" withString:page14];

  for (NSString *key in [PRHtmlHandler sharedPRHtmlHandler].pageTopDict) {
    self.htmlStr = [self.htmlStr
        stringByReplacingString:[NSString stringWithFormat:@"##%@top##", key]
                     withString:[PRHtmlHandler sharedPRHtmlHandler]
                                    .pageTopDict[key]];
  }
  self.htmlStr =
      [self.htmlStr stringByReplacingString:@"##page2height##"
                                 withString:[PRHtmlHandler sharedPRHtmlHandler]
                                                .pageTopDict[@"page2height"]];
  self.htmlStr =
      [self.htmlStr stringByReplacingString:@"##page3height##"
                                 withString:[PRHtmlHandler sharedPRHtmlHandler]
                                                .pageTopDict[@"page3height"]];
  self.htmlStr =
      [self.htmlStr stringByReplacingString:@"##page7height##"
                                 withString:[PRHtmlHandler sharedPRHtmlHandler]
                                                .pageTopDict[@"page7height"]];
  self.htmlStr = [self.htmlStr
      stringByReplacingString:@"##pagecount##"
                   withString:[NSString
                                  stringWithFormat:@"%d", self.pageCount]];
  self.htmlStr =
      [self.htmlStr stringByReplacingString:@"(null)" withString:@""];
  self.htmlStr = [self.htmlStr stringByReplacingString:@"span&nbsp;class"
                                            withString:@"span class"];
  return self.htmlStr;
}

- (NSURL *)baseURL {
  return [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                    pathForResource:@"PR"
                                             ofType:@"al"
                                        inDirectory:@"PDFCreater.bundle"]];
}

- (NSString *)handleWatermarkForString:(NSString *)page {
  NSString *pageString =[NSString stringWithFormat:@"<div "
                                 @"style=\"position:absolute;left:274.75px;"
                                 @"top:%0.2fpx\" class=\"cls_014\"><span "
                                 @"class=\"cls_014\">Page %d of "
                                 @"##pagecount##</span></div>",
                                 self.top, self.currentPage];
  self.top = 834.05;
//    NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"yyyy-MM-dd"];
//    NSDate *frameworkCreatedDate=[dateFormat dateFromString:@"2014-03-25"];
//  if ([[NSDate date] timeIntervalSinceDate:frameworkCreatedDate]>=7*24*60*60) {
    return [page
        stringByReplacingString:@"##watermark##"
                     withString:[NSString stringWithFormat:@"%@\n%@", @"",
                                                           pageString]];
//  } else {
//    return
//        [page stringByReplacingString:@"##watermark##" withString:pageString];
//  }
}

- (void)changeFile {
  NSString *htmlstr = [NSString
      stringWithContentsOfFile:[[NSBundle mainBundle]
                                   pathForResource:@"PR_page14"
                                            ofType:@"al"
                                       inDirectory:@"PDFCreater.bundle"]
                      encoding:NSUTF8StringEncoding
                         error:nil];
  NSString *regTags = @"<span class=\"cls_007\">.*</span></div>";
  NSRegularExpression *regex = [NSRegularExpression
      regularExpressionWithPattern:regTags
                           options:NSRegularExpressionCaseInsensitive
                             error:nil];
  NSArray *matches = [regex matchesInString:htmlstr
                                    options:0
                                      range:NSMakeRange(0, [htmlstr length])];
  NSString *copyedStr = [htmlstr mutableCopy];
  for (NSTextCheckingResult *match in matches) {
    NSRange matchRange = [match range];
    NSString *tagString = [copyedStr substringWithRange:matchRange];
    NSString *valueString =
        [tagString stringByReplacingString:@"<span class=\"cls_007\">"
                                withString:@""];
    valueString =
        [valueString stringByReplacingString:@"</span></div>" withString:@""];
    valueString = [valueString stringByReplacingOccurrencesOfString:@" "
                                                         withString:@"&nbsp;"];
    NSString *newString =
        [NSString stringWithFormat:@"<span class=\"cls_007\">%@</span></div>",
                                   valueString];
    htmlstr = [htmlstr stringByReplacingString:tagString withString:newString];
  }

  regTags = @"<span class=\"cls_008\">.*</span></div>";
  regex = [NSRegularExpression
      regularExpressionWithPattern:regTags
                           options:NSRegularExpressionCaseInsensitive
                             error:nil];
  matches = [regex matchesInString:htmlstr
                           options:0
                             range:NSMakeRange(0, [htmlstr length])];
  copyedStr = [htmlstr mutableCopy];
  for (NSTextCheckingResult *match in matches) {
    NSRange matchRange = [match range];
    NSString *tagString = [copyedStr substringWithRange:matchRange];
    NSString *valueString =
        [tagString stringByReplacingString:@"<span class=\"cls_008\">"
                                withString:@""];
    valueString =
        [valueString stringByReplacingString:@"</span></div>" withString:@""];
    valueString = [valueString stringByReplacingOccurrencesOfString:@" "
                                                         withString:@"&nbsp;"];
    NSString *newString =
        [NSString stringWithFormat:@"<span class=\"cls_008\">%@</span></div>",
                                   valueString];
    htmlstr = [htmlstr stringByReplacingString:tagString withString:newString];
  }
  NSLog(@"%@", htmlstr);
}

- (NSString *)increasePositoinWithHeight:(float)height
                               forString:(NSString *)str {
  NSString *regTags = @"top:\\d*.\\d*px";
  NSRegularExpression *regex = [NSRegularExpression
      regularExpressionWithPattern:regTags
                           options:NSRegularExpressionCaseInsensitive
                             error:nil];
  NSArray *matches =
      [regex matchesInString:str options:0 range:NSMakeRange(0, [str length])];
  NSString *copyedStr = [str mutableCopy];
  for (NSTextCheckingResult *match in matches) {
    NSRange matchRange = [match range];
    NSString *tagString = [copyedStr substringWithRange:matchRange];
    NSString *valueString =
        [tagString stringByReplacingString:@"top:" withString:@""];
    valueString = [valueString stringByReplacingString:@"px" withString:@""];
    NSString *newString = [NSString
        stringWithFormat:@"top:%0.2fpx", valueString.floatValue + height];
    str = [str stringByReplacingString:tagString withString:newString];
  }
  return str;
}

@end
