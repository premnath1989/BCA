//
//  NDHTMLtoPDF2.h
//  Nurves
//
//  Created by Clément Wehrung on 31/10/12.
//  Copyright (c) 2012-2013 Nurves. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPaperSizeA4_landscape CGSizeMake(703,504.5)   //portrait 500,703   landscape 703,504.5
#define kPaperSizeA4_portrait CGSizeMake(500,703)

@class NDHTMLtoPDF2;

typedef void (^NDHTMLtoPDFCompletionBlock)(NDHTMLtoPDF2* htmlToPDF);

@protocol NDHTMLtoPDFDelegate <NSObject>

@optional
- (void)HTMLtoPDFDidSucceed:(NDHTMLtoPDF2*)htmlToPDF;
- (void)HTMLtoPDFDidFail:(NDHTMLtoPDF2*)htmlToPDF;
@end

@interface NDHTMLtoPDF2 : UIViewController <UIWebViewDelegate>

@property (nonatomic, copy) NDHTMLtoPDFCompletionBlock successBlock;
@property (nonatomic, copy) NDHTMLtoPDFCompletionBlock errorBlock;

@property (nonatomic, weak) id <NDHTMLtoPDFDelegate> delegate;

@property (nonatomic, strong, readonly) NSString *PDFpath;

+ (id)createPDFWithURL:(NSURL*)URL pathForPDF:(NSString*)PDFpath delegate:(id <NDHTMLtoPDFDelegate>)delegate pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins;
+ (id)createPDFWithHTML:(NSString*)HTML pathForPDF:(NSString*)PDFpath delegate:(id <NDHTMLtoPDFDelegate>)delegate pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins;
+ (id)createPDFWithHTML:(NSString*)HTML baseURL:(NSURL*)baseURL pathForPDF:(NSString*)PDFpath delegate:(id <NDHTMLtoPDFDelegate>)delegate pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins;

+ (id)createPDFWithURL:(NSURL*)URL pathForPDF:(NSString*)PDFpath pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins successBlock:(NDHTMLtoPDFCompletionBlock)successBlock errorBlock:(NDHTMLtoPDFCompletionBlock)errorBlock;
+ (id)createPDFWithHTML:(NSString*)HTML pathForPDF:(NSString*)PDFpath pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins successBlock:(NDHTMLtoPDFCompletionBlock)successBlock errorBlock:(NDHTMLtoPDFCompletionBlock)errorBlock;
+ (id)createPDFWithHTML:(NSString*)HTML baseURL:(NSURL*)baseURL pathForPDF:(NSString*)PDFpath pageSize:(CGSize)pageSize margins:(UIEdgeInsets)pageMargins successBlock:(NDHTMLtoPDFCompletionBlock)successBlock errorBlock:(NDHTMLtoPDFCompletionBlock)errorBlock;
@end
