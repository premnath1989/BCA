//  Created by Derek Blair on 2/24/2014.
//  Copyright (c) 2014 iwelabs. All rights reserved.

#import <QuartzCore/QuartzCore.h>
#import "PDFView.h"
#import "PDFWidgetAnnotationView.h"
#import "PDFFormButtonField.h"
#import "PDF.h"
#import "eSignController.h"



@interface PDFView()
    -(void)fadeInWidgetAnnotations;
@end


@implementation PDFView
{
    BOOL _canvasLoaded;
}

@synthesize chat1,chat2,highLighth;


- (id)initWithFrame:(CGRect)frame DataOrPath:(id)dataOrPath AdditionViews:(NSArray*)widgetAnnotationViews
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
           CGRect contentFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _pdfView = [[UIWebView alloc] initWithFrame:contentFrame];
        _pdfView.scalesPageToFit = YES;
        _pdfView.scrollView.delegate = self;
        _pdfView.scrollView.bouncesZoom = NO;
        _pdfView.delegate = self;
        _pdfView.autoresizingMask =  UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin;
         self.autoresizingMask =  UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin;
        
        [self addSubview:_pdfView];
        [_pdfView.scrollView setZoomScale:1];
        [_pdfView.scrollView setContentOffset:CGPointZero];
        
        
//        chat1 = [[UIButton alloc] initWithFrame:CGRectMake(630.0, 3360.0,15,15)];
//        [chat1 setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
//        [chat1 addTarget:self action:@selector(testing) forControlEvents:UIControlEventTouchUpInside];
//        [_pdfView.scrollView addSubview:chat1];
//        
//        chat2 = [[UIButton alloc] initWithFrame:CGRectMake(761.0, 3373.0,15,15)];
//        [chat2 setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
//        [chat2 addTarget:self action:@selector(testing) forControlEvents:UIControlEventTouchUpInside];
//        [_pdfView.scrollView addSubview:chat2];
//        
        

        
        
//        // saving an NSString
//        [prefs setObject:@"SAVETICK" forKey:@"keyToLookTick"];
//        
////        
//        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//        NSString *myString = [prefs stringForKey:@"keyToLookTick"];
//        
//        if ([myString isEqualToString:@"SAVETICK"])
//        {
//            [chat1 setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
//            chat1.enabled =NO;
//            [chat2 setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
//            chat2.enabled =NO;
//            NSLog(@"succesfullhere");
//            myString =@"";
//        }
//        else
//        {
//            NSLog(@"succesfullhereNo");
//        }
//        
//        NSLog(@"mystring %@",myString);
        
        
        
//        highLighth =[[UILabel alloc]initWithFrame:CGRectMake(40.0, 3355.0,935,50)];
//        highLighth.backgroundColor =[UIColor colorWithRed:255.0f/255.0f green:251.0f/255.0f blue:204.0f/255.0f alpha:0.5f];
//        
////        highLighth.backgroundColor =[UIColor redColor];
////        highLighth.alpha =0.3f;
//        [_pdfView.scrollView addSubview:highLighth];
        
        //This allows us to prevent the keyboard from obscuring text fields near the botton of the document.
        [_pdfView.scrollView setContentInset:UIEdgeInsetsMake(0, 0, frame.size.height/2, 0)];
        
        _pdfWidgetAnnotationViews = [[NSMutableArray alloc] initWithArray:widgetAnnotationViews];
        
        for(PDFWidgetAnnotationView* element in _pdfWidgetAnnotationViews)
        {
            element.alpha = 0;
            element.parentView = self;
            element.backgroundColor = [UIColor clearColor];
            if ([element.value hasPrefix:@"."]) {
                element.backgroundColor = [UIColor whiteColor];
            }
            element.userInteractionEnabled = NO;
            [_pdfView.scrollView addSubview:element];
            
            if([element isKindOfClass:[PDFFormButtonField class]])
            {
                [(PDFFormButtonField*)element setButtonSuperview];
            }
        }
        
        if([dataOrPath isKindOfClass:[NSString class]])
        {
            [_pdfView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:dataOrPath]]];
        }
        else if([dataOrPath isKindOfClass:[NSData class]])
        {
            [_pdfView loadData:dataOrPath MIMEType:@"application/pdf" textEncodingName:@"NSASCIIStringEncoding" baseURL:nil];
        }

        UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:nil action:NULL];
            [self addGestureRecognizer:tapGestureRecognizer];
        tapGestureRecognizer.delegate = self;
    }
    return self;
}

-(void)testing
{
    NSLog(@"firing");
    
        
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"Do u agree to proceed"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:@"Cancel", nil];
    [alertView show];


    
}

//-(void)SEtTick
//{
//    [chat1 setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
//    chat1.enabled =NO;
//    NSLog(@"yesss");
//}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [chat1 setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        chat1.enabled =NO;
        [chat2 setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        chat2.enabled =NO;
        
        
        PDFViewController* pdfViewController = (PDFViewController *)[self.superview nextResponder];
        
        pdfViewController.navigationItem.rightBarButtonItem.enabled=YES;
        
      
        
      //  eSignController *apiViewController=[[self superview] superview];
    
        
        
         //UIBarButtonItem *signBarButtonItem
    }
    else if(buttonIndex == 1)
    {
        PDFViewController* pdfViewController = (PDFViewController *)[self.superview nextResponder];
        
        pdfViewController.navigationItem.rightBarButtonItem.enabled=NO;
        
    }
}

-(void)SigninFormx
{
    eSignController *apiViewController = [[eSignController alloc] initWithNibName:nil bundle:nil];
    [apiViewController Signtheform];
}


-(void)addPDFWidgetAnnotationView:(PDFWidgetAnnotationView*)viewToAdd
{
    [_pdfWidgetAnnotationViews addObject:viewToAdd];
    [_pdfView.scrollView addSubview:viewToAdd];
}

-(void)removePDFWidgetAnnotationView:(PDFWidgetAnnotationView*)viewToRemove
{
    [viewToRemove removeFromSuperview];
    [_pdfWidgetAnnotationViews removeObject:viewToRemove];
}


#pragma mark - UIWebViewDelegate


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    _canvasLoaded = YES;
    if(_pdfWidgetAnnotationViews)
    {
        [self fadeInWidgetAnnotations];
    }
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat scale = scrollView.zoomScale;
    if(scale < 1.0f)scale = 1.0f;
    
    for(PDFWidgetAnnotationView* element in _pdfWidgetAnnotationViews)
    {
        [element updateWithZoom:scale];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
}

#pragma mark - UIGestureRecognizerDelegate


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if(_activeWidgetAnnotationView == nil)return NO;
    
    if(!CGRectContainsPoint(_activeWidgetAnnotationView.frame, [touch locationInView:_pdfView.scrollView]))
    {
        if([_activeWidgetAnnotationView isKindOfClass:[UITextView class]])
        {
            [_activeWidgetAnnotationView resignFirstResponder];
            
        }
        else
        {
            [_activeWidgetAnnotationView resign];
        }
    }
    return NO;
}


-(void)setWidgetAnnotationViews:(NSArray*)additionViews
{
    
    for(UIView* v in _pdfWidgetAnnotationViews)[v removeFromSuperview];
    _pdfWidgetAnnotationViews = nil;
    _pdfWidgetAnnotationViews = [[NSMutableArray alloc] initWithArray:additionViews];
    
    for(PDFWidgetAnnotationView* element in _pdfWidgetAnnotationViews)
    {
        element.alpha = 0;
        element.parentView = self;
        [_pdfView.scrollView addSubview:element];
        if([element isKindOfClass:[PDFFormButtonField class]])
        {
            [(PDFFormButtonField*)element setButtonSuperview];
        }
    }
    
    
    if(_canvasLoaded)[self fadeInWidgetAnnotations];
}


#pragma mark - Hidden


-(void)fadeInWidgetAnnotations
{
    [UIView animateWithDuration:0.5 delay:0.2 options:0 animations:^{
        for(UIView* v in _pdfWidgetAnnotationViews)v.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}


@end




