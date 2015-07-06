//
//  SnapGen.m
//  CardSnap
//
//  Created by Danial D. Moghaddam on 5/14/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//

#import "SnapGen.h"
#import "myLable.h"
#import "MyDocumentType.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>

@implementation SnapGen
@synthesize Filename1;

-(NSString *)generatePdfFromSnapArray:(NSArray *)snaps withFileName:(NSString *)fileName:(NSString *)SamePolicyOwner
{
    NSMutableArray *page_Paths = [[NSMutableArray alloc]init];
   // int pageNo = 0;
  
    
    for (id obj in snaps)
    {
        
        //  NSLog(@"id obj in snaps %@",obj);
     //   pageNo++;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 595, 842)];
        myLable *lbl = [[myLable alloc]initWithFrame:CGRectMake(50, 20, 500, 50)];
        MyDocumentType *lbl1 = [[MyDocumentType alloc]initWithFrame:CGRectMake(50, 35, 500, 50)];
        
        lbl.font = [UIFont fontWithName:@"Helvetica" size:12];
        lbl1.font = [UIFont fontWithName:@"Helvetica" size:12];
        
        
        if([[obj objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(First Time Payment)"])
            
        {
            //            lbl.text = [NSString stringWithFormat:@"Name : %@ (%@)     Document type : %@",[obj objectForKey:@"name"],@"Card Holder(First Time Payment)",[obj objectForKey:@"idType"]];
            
            lbl.text = [NSString stringWithFormat:@"Name : %@ (%@)",[obj objectForKey:@"name"],@"Card Holder(First Time Payment)"];
            
            lbl1.text = [NSString stringWithFormat:@"Document type : %@",[obj objectForKey:@"idType"]];
            
            
        }
        else if ([[obj objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(Recurring Payment)"])
        {
            //            lbl.text = [NSString stringWithFormat:@"Name : %@ (%@)     Document type : %@",[obj objectForKey:@"name"],@"Card Holder(Recurring Payment)",[obj objectForKey:@"idType"]];
            
            lbl.text = [NSString stringWithFormat:@"Name : %@ (%@)",[obj objectForKey:@"name"],@"Card Holder(Recurring Payment)"];
            
            lbl1.text = [NSString stringWithFormat:@"Document type : %@",[obj objectForKey:@"idType"]];
            
        }
        
        else if ([[obj objectForKey:@"rowTitlw"]isEqualToString:@"1st Life Assured"])
        {
            if ([SamePolicyOwner isEqualToString:@"Policy"])
            {
                //                lbl.text = [NSString stringWithFormat:@"Name : %@ (%@)     Document type : %@",[obj objectForKey:@"name"],@"1st Life Assured & Policy Owner",[obj objectForKey:@"idType"]];
                
                lbl.text = [NSString stringWithFormat:@"Name : %@ (%@)",[obj objectForKey:@"name"],@"1st Life Assured & Policy Owner"];
                
                lbl1.text = [NSString stringWithFormat:@"Document type : %@",[obj objectForKey:@"idType"]];
                
                
            }
            else
            {
                //                lbl.text = [NSString stringWithFormat:@"Name : %@ (%@)     Document type : %@",[obj objectForKey:@"name"],[obj objectForKey:@"rowTitlw"],[obj objectForKey:@"idType"]];
                
                lbl.text = [NSString stringWithFormat:@"Name : %@ (%@)",[obj objectForKey:@"name"],[obj objectForKey:@"rowTitlw"]];
                
                lbl1.text = [NSString stringWithFormat:@"Document type : %@",[obj objectForKey:@"idType"]];
            }
        }
        
        else
        {
            
            
            //            lbl.text = [NSString stringWithFormat:@"Name : %@ (%@)     Document type : %@",[obj objectForKey:@"name"],[obj objectForKey:@"rowTitlw"],[obj objectForKey:@"idType"]];
            
            lbl.text = [NSString stringWithFormat:@"Name : %@ (%@)",[obj objectForKey:@"name"],[obj objectForKey:@"rowTitlw"]];
            
            lbl1.text = [NSString stringWithFormat:@"Document type : %@",[obj objectForKey:@"idType"]];
        }
        
        [view addSubview:lbl];
        [view addSubview:lbl1];
        

        
        
        if ([[obj objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]]) {
            
            if ([[obj objectForKey:@"idType"] isEqualToString:@"Birth Certificate"] || [[obj objectForKey:@"idType"] isEqualToString:@"Foreign Birth Certificate"] || [[obj objectForKey:@"idType"] isEqualToString:@"Foreigner Identification Number"] || [[obj objectForKey:@"idType"] isEqualToString:@"Passport"] || [[obj objectForKey:@"idType"] isEqualToString:@"Singapore Identification Number"]) {
//                UIImageView *front = [[UIImageView alloc]initWithFrame:CGRectMake(50, 67, 512, 700)];
                UIImageView *front = [[UIImageView alloc]initWithFrame:CGRectMake(-50, 200, 700, 460)];
                float degrees = 90; //the value in degrees
                front.transform = CGAffineTransformMakeRotation(degrees * M_PI/180);
                front.image = [obj objectForKey:@"frontSnap"];
                [view addSubview:front];
                
                //WaterMark
                UIImageView *watermark = [[UIImageView alloc]initWithFrame:CGRectMake(50, 250, 512, 360)];
                watermark.image =[UIImage imageNamed:@"hla_use_only"];
                [watermark setAlpha:0.3f];
                [view addSubview:watermark];
            }
            else
            {
                UIImageView *front = [[UIImageView alloc]initWithFrame:CGRectMake(50, 67, 512, 360)];
                front.image = [obj objectForKey:@"frontSnap"];
                [view addSubview:front];

                //WaterMark
                UIImageView *watermark = [[UIImageView alloc]initWithFrame:CGRectMake(50, 67, 512, 360)];
                watermark.image =[UIImage imageNamed:@"hla_use_only"];
                [watermark setAlpha:0.3f];
                [view addSubview:watermark];
                
                if ([[obj objectForKey:@"backSnap"]isKindOfClass:[UIImage class]]) {
                    UIImageView *front = [[UIImageView alloc]initWithFrame:CGRectMake(50, 440, 512, 360)];
                    front.image = [obj objectForKey:@"backSnap"];
                    [view addSubview:front];
                    
                    //WaterMark
                    UIImageView *watermark = [[UIImageView alloc]initWithFrame:CGRectMake(50, 440, 512, 360)];
                    watermark.image = [UIImage imageNamed:@"hla_use_only"];
                    [watermark setAlpha:0.3f];
                    [view addSubview:watermark];
                }
                
                
            }
            
            
            
            NSString *pdf =[obj objectForKey:@"rowTitlw"];
			
			[page_Paths removeAllObjects];
			page_Paths = [[NSMutableArray alloc]init];
		
            if([pdf isEqualToString:@"1st Life Assured"])
            {
               // NSString *pageName = [NSString stringWithFormat:@"temp%i_1st Life Assured.pdf",pageNo];
                [page_Paths addObject:[self createPDFfromUIView:view saveToDocumentsWithFileName:@"1"]];
                Filename1 =[NSString stringWithFormat:@"%@_ID_LA1",fileName];
            }
           
            else if([pdf isEqualToString:@"2nd Life Assured"])
            {
              //  NSString *pageName = [NSString stringWithFormat:@"temp%i_Policy Owner.pdf"];
                [page_Paths addObject:[self createPDFfromUIView:view saveToDocumentsWithFileName:@"1"]];
                Filename1 =[NSString stringWithFormat:@"%@_ID_LA2",fileName];
            }
            
            else if([pdf isEqualToString:@"Policy Owner"])
            {
                //  NSString *pageName = [NSString stringWithFormat:@"temp%i_Policy Owner.pdf"];
                [page_Paths addObject:[self createPDFfromUIView:view saveToDocumentsWithFileName:@"1"]];
                Filename1 =[NSString stringWithFormat:@"%@_ID_PO",fileName];
            }

            else if([pdf isEqualToString:@"Contingent Owner"])
            {
                //  NSString *pageName = [NSString stringWithFormat:@"temp%i_Policy Owner.pdf"];
                [page_Paths addObject:[self createPDFfromUIView:view saveToDocumentsWithFileName:@"1"]];
                Filename1 =[NSString stringWithFormat:@"%@_ID_CO",fileName];
            }
            
            else if([pdf isEqualToString:@"1st Trustee"])
            {
                //  NSString *pageName = [NSString stringWithFormat:@"temp%i_Policy Owner.pdf"];
                [page_Paths addObject:[self createPDFfromUIView:view saveToDocumentsWithFileName:@"1"]];
                Filename1 =[NSString stringWithFormat:@"%@_ID_TR1",fileName];
            }

            else if([pdf isEqualToString:@"2nd Trustee"])
            {
                //  NSString *pageName = [NSString stringWithFormat:@"temp%i_Policy Owner.pdf"];
                [page_Paths addObject:[self createPDFfromUIView:view saveToDocumentsWithFileName:@"1"]];
                Filename1 =[NSString stringWithFormat:@"%@_ID_TR2",fileName];
            }
            
            else if([pdf isEqualToString:@"Father/ Mother/ Guardian"])
            {
                //  NSString *pageName = [NSString stringWithFormat:@"temp%i_Policy Owner.pdf"];
                [page_Paths addObject:[self createPDFfromUIView:view saveToDocumentsWithFileName:@"1"]];
                Filename1 =[NSString stringWithFormat:@"%@_ID_GD",fileName];
            }

            else if([pdf isEqualToString:@"Card Holder \n(First Time Payment)"])
            {
                //  NSString *pageName = [NSString stringWithFormat:@"temp%i_Policy Owner.pdf"];
                [page_Paths addObject:[self createPDFfromUIView:view saveToDocumentsWithFileName:@"1"]];
                Filename1 =[NSString stringWithFormat:@"%@_ID_CFP",fileName];                
            }
            
            else if([pdf isEqualToString:@"Card Holder \n(Recurring Payment)"])
            {
                //  NSString *pageName = [NSString stringWithFormat:@"temp%i_Policy Owner.pdf"];
                [page_Paths addObject:[self createPDFfromUIView:view saveToDocumentsWithFileName:@"1"]];
                Filename1 =[NSString stringWithFormat:@"%@_ID_CRP",fileName];
            }
            
        }
        
    }
    
    return [self joinPDF:page_Paths fileName:Filename1];
}

- (NSString *)joinPDF:(NSArray *)listOfPath fileName:(NSString *)name{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *layOutPath=[NSString stringWithFormat:@"%@",[paths objectAtIndex:0]];
    if(![[NSFileManager defaultManager] fileExistsAtPath:layOutPath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:layOutPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    // File paths
    NSString *fileName = [NSString stringWithFormat:@"%@.pdf",name];
    layOutPath = [layOutPath stringByAppendingString:@"/Forms/"];
    NSString *pdfPathOutput = [layOutPath stringByAppendingPathComponent:fileName];
    CFURLRef pdfURLOutput = (__bridge CFURLRef)[NSURL fileURLWithPath:pdfPathOutput];
    NSInteger numberOfPages = 0;
    // Create the output context
    CGContextRef writeContext = CGPDFContextCreateWithURL(pdfURLOutput, NULL, NULL);
    
    for (NSString *source in listOfPath)
    {
        //        CFURLRef pdfURL = (__bridge CFURLRef)[NSURL fileURLWithPath:source];
        
        CFURLRef pdfURL =  CFURLCreateFromFileSystemRepresentation(NULL, [source UTF8String],[source length], NO);
        
        //file ref
        CGPDFDocumentRef pdfRef = CGPDFDocumentCreateWithURL(pdfURL);
        numberOfPages = CGPDFDocumentGetNumberOfPages(pdfRef);
        
        // Loop variables
        CGPDFPageRef page;
        CGRect mediaBox;
        
        // Read the first PDF and generate the output pages
        //NSLog(@"GENERATING PAGES FROM PDF 1 (%@)...", source);
        for (int i=1; i<=numberOfPages; i++)
        {
            page = CGPDFDocumentGetPage(pdfRef, i);
            mediaBox = CGPDFPageGetBoxRect(page, kCGPDFMediaBox);
            CGContextBeginPage(writeContext, &mediaBox);
            CGContextDrawPDFPage(writeContext, page);
            CGContextEndPage(writeContext);
        }
        
        CGPDFDocumentRelease(pdfRef);
        CFRelease(pdfURL);
    }
    // CFRelease(pdfURLOutput);
    //
    //    // Finalize the output file
    CGPDFContextClose(writeContext);
    CGContextRelease(writeContext);
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    for (NSString *filePath in listOfPath)
    {
        [fileMgr removeItemAtPath:filePath error:NULL];
    }
    
    return pdfPathOutput;
}
-(NSString *)createPDFfromUIView:(UIView*)aView saveToDocumentsWithFileName:(NSString*)aFilename
{
    
    // Creates a mutable data object for updating with binary data, like a byte array
    NSMutableData *pdfData = [NSMutableData data];
    
    // Points the pdf converter to the mutable data object and to the UIView to be converted
    UIGraphicsBeginPDFContextToData(pdfData, aView.bounds, nil);
    UIGraphicsBeginPDFPage();
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    
    // draws rect to the view and thus this is captured by UIGraphicsBeginPDFContextToData
    
    [aView.layer renderInContext:pdfContext];
    
    // remove PDF rendering context
    UIGraphicsEndPDFContext();
    
    // Retrieves the document directories from the iOS device
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    documentDirectory = [documentDirectory stringByAppendingString:@"/Forms/"];
    NSError * error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentDirectory
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&error];
    NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:aFilename];
    
    // instructs the mutable data object to write its context to a file on disk
    [pdfData writeToFile:documentDirectoryFilename atomically:YES];
    
    return documentDirectoryFilename;
}


@end
