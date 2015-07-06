//
//  ViewController.m
//  PDF
//
//  Created by Travel Chu on 3/11/14.
//  Copyright (c) 2014 Nexstream. All rights reserved.
//

#import "PDFCreater.h"
#import "PRHtmlHandler.h"
#import "PRSQLHelper.h"
#import "TBXML+NSDictionary.h"


#define DocumentsDirectory                                                     \
[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,  \
YES) lastObject]
#define FormPath [DocumentsDirectory stringByAppendingPathComponent:@"Forms"]
@interface PDFCreater () <UIWebViewDelegate>

@property(strong, nonatomic) UIWebView *webView;
@property(nonatomic, assign) CGSize pageSize;
@property(nonatomic, assign) UIEdgeInsets pageMargins;
@property(nonatomic, strong) PRHtmlHandler *prHtmlHandler;
@end

@interface UIPrintPageRenderer (PDF)

- (NSData *)printToPDF;

@end

@implementation PDFCreater

-(NSString *)generatePRFormFromPRXMLPath:(NSString *)prXMLPath
                            andSIXMLPath:(NSString *)siXMPPath
                     andDatabaseFilePath:(NSString *)sqlDBPath {
  NSData *PRXMLData = [NSData dataWithContentsOfFile:prXMLPath];
  NSData *SIXMLData = [NSData dataWithContentsOfFile:siXMPPath];
  if (!PRXMLData || !SIXMLData) {
    [[[UIAlertView alloc] initWithTitle:@" "
                                message:@"XML data is nil !"
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil, nil] show];
    return @"Error";
  }
  self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
  self.webView.delegate = self;
  self.prHtmlHandler = [PRHtmlHandler sharedPRHtmlHandler];
  self.prHtmlHandler.siXMLata = SIXMLData;
    PRSQLHelper *sqlHandler=[[PRSQLHelper alloc] init];
    [sqlHandler loadSQLFileWithPath:sqlDBPath];
    [PRHtmlHandler sharedPRHtmlHandler].sqlHandler = sqlHandler;
  NSError *error;
  NSDictionary *dict = [TBXML dictionaryWithXMLData:PRXMLData error:&error];
  [_webView loadHTMLString:[self.prHtmlHandler htmlStringWithDictionary:dict]
                   baseURL:[self.prHtmlHandler baseURL]];
  if (error) {
    NSLog(@"Parse XML Error:%@", error.localizedDescription);
  }
    BOOL dirFlag = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:FormPath
                                              isDirectory:&dirFlag]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:FormPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
    self.PDFpath = [FormPath
                    stringByAppendingPathComponent:
                    [NSString
                     stringWithFormat:@"%@_PR.pdf",
                     dict[@"eApps"][@"AssuredInfo"][@"eProposalNo"]]];
	

  return self.PDFpath;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  // test only
  //    self.webView.scrollView.contentOffset = CGPointMake(0,
  // self.view.bounds.size.height*3);

  if (webView.isLoading)
    return;
  [_webView stringByEvaluatingJavaScriptFromString:
                @"document.body.style.zoom=1.235;"];
  //    [_webView
  // stringByEvaluatingJavaScriptFromString:@"document.body.style.zoom=1.250;"];
  self.pageMargins = UIEdgeInsetsMake(0, 0, 0, 0);
  self.pageSize = CGSizeMake(595.2, 841.8);

  UIPrintPageRenderer *render = [[UIPrintPageRenderer alloc] init];

  [render addPrintFormatter:self.webView.viewPrintFormatter
      startingAtPageAtIndex:0];

  CGRect printableRect = CGRectMake(
      self.pageMargins.left, self.pageMargins.top,
      self.pageSize.width - self.pageMargins.left - self.pageMargins.right,
      self.pageSize.height - self.pageMargins.top - self.pageMargins.bottom);

  CGRect paperRect =
      CGRectMake(0, 0, self.pageSize.width, self.pageSize.height);

  [render setValue:[NSValue valueWithCGRect:paperRect] forKey:@"paperRect"];
  [render setValue:[NSValue valueWithCGRect:printableRect]
            forKey:@"printableRect"];

  self.PDFdata = [render printToPDF];

  if (self.PDFpath) {
    [self.PDFdata writeToFile:self.PDFpath atomically:YES];
    //        NSLog(@"%@",self.PDFpath);
  }

  [self terminateWebTask];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  if (webView.isLoading)
    return;

  [self terminateWebTask];
}

- (void)terminateWebTask {
  [self.webView stopLoading];
  self.webView.delegate = nil;
  self.webView = nil;
}

@end

@implementation UIPrintPageRenderer (PDF)

- (NSData *)printToPDF {
  NSMutableData *pdfData = [NSMutableData data];

  UIGraphicsBeginPDFContextToData(pdfData, self.paperRect, nil);

  [self prepareForDrawingPages:NSMakeRange(0, self.numberOfPages)];

  CGRect bounds = UIGraphicsGetPDFContextBounds();

  for (int i = 0; i < self.numberOfPages; i++) {
    UIGraphicsBeginPDFPage();

    [self drawPageAtIndex:i inRect:bounds];
  }

  UIGraphicsEndPDFContext();

  return pdfData;
}

@end
