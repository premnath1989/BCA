//
//  eSignController.m
//  eSignature
//
//  Created by Danial D. Moghaddam on 5/16/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//

#import "eSignController.h"
#import <QuartzCore/QuartzCore.h>

#include "test.h"

#import <sys/socket.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "SnapCustomCell.h"
#import "ColorHexCode.h"
#import "CustomAlertBox.h"
#import "GDataXMLNode.h"
#import "PDFView.h"


@interface eSignController (){
    BOOL issigned;
    
    BOOL isExcecution;
    
    
    int selectedTag;
	NSIndexPath *currentIndexPath;
	BOOL hasData;
	NSString *isCustSign;
	NSString *DateCustSign;
	NSString *SignAt;
	NSString *SignAtTextField;
	
	
	NSString *isPOSign;
	NSString *DatePOSign;
	NSString *isLASign;
	NSString *DateLASign;
	NSString *isLA2Sign;
	NSString *DateLA2Sign;
	NSString *isCOSign;
	NSString *DateCOSign;
	NSString *isTrusteeSign;
	NSString *DateTrusteeSign;
	NSString *isTrustee2Sign;
	NSString *DateTrustee2Sign;
	NSString *isGuardianSign;
	NSString *DateGuardianSign;
	NSString *isWitnessSign;
	NSString *DateWitnessSign;
	NSString *isCardHolderSign;
	NSString *DateCardHolderSign;
	NSString *isManagerSign;
	NSString *DateManagerSign;
	NSString *isIntermediarySign;
	NSString *DateIntermediarySign;
}
@end

//NSString *POsignDate = @"";
//NSString *POsignAt = @"";
NSString *LA1 = @"N";
NSString *LA2 = @"N";
NSString *PO = @"N";
NSString *CO = @"N";
NSString *Trustee1 = @"N";
NSString *Trustee2 = @"N";
NSString *Parent = @"N";
NSString *Witness = @"N";
NSString *CardHolder = @"N";
NSString *Signer_type = @"";



@implementation eSignController
@synthesize signatureFrameLabel,scrollView,signBarButtonItem,SignFirst,image,buttonq;
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _signArr = [[NSMutableArray alloc]init];
        [_signArr addObjectsFromArray:@[@{@"rowTitlw":@"Customer Fact Find"},
         @{@"rowTitlw": @"Life Assured"},
         @{@"rowTitlw": @"2nd Life Assured"},
         @{@"rowTitlw": @"Policy Owner"},
         @{@"rowTitlw": @"Contingent Owner"},
         @{@"rowTitlw": @"1st Trustee"},
         @{@"rowTitlw": @"2nd Trustee"},
         @{@"rowTitlw": @"Father/Mother/Guardian"},
         @{@"rowTitlw": @"Intermediary/Agent/Witness"},
         @{@"rowTitlw": @"Intermediary/Agent"},
         @{@"rowTitlw": @"Manager"},
         @{@"rowTitlw": @"Card Holder"}
         
         ]];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isCustomerSelected = YES;
    _BackButtonName.title=proposalNumber;
    
    
    saveDocument();
    BOOL allSigned=YES;
    for (NSString *key in [GetProposalObject(proposalNumber)allKeys])
    {
        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO)
        {
            allSigned = NO;
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            
            // saving an NSString
            [prefs setObject:@"" forKey:@"keyToLookTick"];
            
            
            //            [self performSelector:@selector(SignInPromptMessage) withObject:nil afterDelay:1.0f];
            
        }
        else
        {
            //            PDFView *apiViewController = [[PDFView alloc] init];
            //            [apiViewController SEtTick];
            
            NSLog(@"howComeImhere");
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            
            // saving an NSString
            [prefs setObject:@"SAVETICK" forKey:@"keyToLookTick"];
            
            
        }
    }
    
    // Do any additional setup after loading the view from its nib.
    _overlayView = [[UIView alloc]init];
    UIWindow *AppWindow = [[UIApplication sharedApplication] keyWindow];
    [_overlayView setFrame:AppWindow.frame];
    [_overlayView setBackgroundColor:[UIColor blackColor]];
    [_overlayView setAlpha:0.6];
    
    [AppWindow addSubview:_overlayView];
    _overlayView.hidden=YES;
    
    
    SignFirst =@"";
    
	[self LoadDB];
	
    
    [_tableView setBackgroundColor:[UIColor clearColor]];
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	
	[self.view addGestureRecognizer:tap];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *currDate = [NSDate date];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    
    //    if(cFFSignatureRequired){
    //        if (([isCustSign isEqualToString:@""] || (NSNull *) isCustSign == [NSNull null]) || isCustSign == nil) {
    //			setValueToField(dateString, kdate1);
    //		}
    //		else
    //			setValueToField(DateCustSign, kdate1);
    //    }
    
    //[kCustomerSign setDelegate:self];
}

-(void)hideKeyboard{
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"isItRefreshing");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark - eSignature Methods & Delegates
- (void) getPDFDocumentRef:(CGPDFDocumentRef*) document {
    
    
	NSString *input_path3 = pdfPath;
	const char *filename = [input_path3 UTF8String];
    CFStringRef path = CFStringCreateWithCString (NULL, filename, kCFStringEncodingUTF8);
    CFURLRef url = CFURLCreateWithFileSystemPath (NULL, path, kCFURLPOSIXPathStyle, 0);
    CFRelease (path);
    *document = CGPDFDocumentCreateWithURL(url);
    CFRelease(url);
    int count = CGPDFDocumentGetNumberOfPages(*document);
    
    NSLog(@"count %d",count);
    if (count == 0) {
        NSLog(@"`%s' needs at least one page!", filename);
    }
}
- (UIImage *)getImageWithAppleRenderer
{
    CGPDFDocumentRef document = nil;
    [self getPDFDocumentRef:&document];
    CGPDFPageRef PDFPage = CGPDFDocumentGetPage(document, 4);
    // Determine the size of the PDF page.
    CGRect pageRect = CGPDFPageGetBoxRect(PDFPage, kCGPDFMediaBox);
    CGSize pdfPageSize = pageRect.size;
    CGFloat originalMinimumPDFScale = imageView.frame.size.width/pdfPageSize.width;
    CGFloat PDFScale = originalMinimumPDFScale;
    //[self setContentSize:CGSizeMake(pdfPageSize.width*PDFScale, pdfPageSize.height*PDFScale)];
    pageRect.size = CGSizeMake(pageRect.size.width*PDFScale, pageRect.size.height*PDFScale);
    NSLog(@"pageRect.size %f",pageRect.size.height);
    
    /*
     Create a low resolution image representation of the PDF page to display before the TiledPDFView renders its content.
     */
    UIGraphicsBeginImageContext(pageRect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // First fill the background with white.
    CGContextSetRGBFillColor(context, 1.0,1.0,1.0,1.0);
    CGContextFillRect(context,pageRect);
    
    CGContextSaveGState(context);
    // Flip the context so that the PDF page is rendered right side up.
    CGContextTranslateCTM(context, 0.0, pageRect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // Scale the context so that the PDF page is rendered at the correct size for the zoom level.
    CGContextScaleCTM(context, PDFScale,PDFScale);
    CGContextDrawPDFPage(context, PDFPage);
    CGContextRestoreGState(context);
    
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    CFRelease(document);
    return backgroundImage;
}
- (UIView *)createUIForPDF
{
    UIView *pdfView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    int y = 0;
    
    
    for (int i= 1 ; i<6; i++) {
        [[NSUserDefaults standardUserDefaults]setInteger:i forKey:@"pageNo"];
        NSMutableData *data;
        struct SIGNDOC_ByteArray *blob;
        blob = renderTest(self.view.frame.size.height*2);
        data = [[NSMutableData alloc] initWithBytesNoCopy:SIGNDOC_ByteArray_data(blob) length:SIGNDOC_ByteArray_count(blob)];
        UIImage *resultImage = [UIImage imageWithData:data];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"image%i.png",i]];
        
        // Save image.
        [UIImagePNGRepresentation(resultImage) writeToFile:filePath atomically:YES];
        
        
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height*2)];
        [imgView setImage:resultImage];
        [pdfView addSubview:imgView];
        y+= (self.view.frame.size.height*2) + 10;
    }
    pdfView.frame = CGRectMake(0, 0, self.view.frame.size.width, y+50);
    return pdfView;
}
- (UIImage *)getImageWithSignDocSDKRenderer
{
    
    if (isCustomerSelected) {
        [[NSUserDefaults standardUserDefaults]setInteger:4 forKey:@"pageNo"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setInteger:5 forKey:@"pageNo"];
    }
    
    NSMutableData *data;
    struct SIGNDOC_ByteArray *blob;
    blob = renderTest(imageView.frame.size.height);
    data = [[NSMutableData alloc] initWithBytesNoCopy:SIGNDOC_ByteArray_data(blob) length:SIGNDOC_ByteArray_count(blob)];
    UIImage *resultImage = [UIImage imageWithData:data];
    
    
    // Create path.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Image.png"];
    
    // Save image.
    [UIImagePNGRepresentation(resultImage) writeToFile:filePath atomically:YES];
    return resultImage;
}
- (void) render {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *currDate = [NSDate date];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    
    NSString *sourceString = [[NSThread callStackSymbols] objectAtIndex:1];
    // Example: 1   UIKit                               0x00540c89 -[UIApplication _callInitializationDelegatesForURL:payload:suspended:] + 1163
    NSCharacterSet *separatorSet = [NSCharacterSet characterSetWithCharactersInString:@" -[]+?.,"];
    NSMutableArray *array = [NSMutableArray arrayWithArray:[sourceString  componentsSeparatedByCharactersInSet:separatorSet]];
    [array removeObject:@""];
    
    UIImage *renderedImage;
    double documentWidth = getDocumentWidth();
    double documentHeight = getDocumentHeight();
    
    int yPoint = 100;
    if (isCustomerSelected) yPoint=-200;
    
    [imageView setFrame:CGRectMake(imageView.frame.origin.x, yPoint, imageView.frame.size.width, imageView.frame.size.width*documentHeight/documentWidth)];
    getImageWithSignDocSDKRenderer = TRUE;
    renderedImage = getImageWithSignDocSDKRenderer ? [self getImageWithSignDocSDKRenderer] : [self getImageWithAppleRenderer];
    imageView.image = renderedImage;
    if (!getImageWithSignDocSDKRenderer) {
        [self showSignature];
    }
    
    //    if(!cFFSignatureRequired){
    //		if (([isCustSign isEqualToString:@""] || (NSNull *) isCustSign == [NSNull null]) || isCustSign == nil) {
    //			setValueToField(dateString, kdate1);
    //		}
    //		else
    //			setValueToField(DateCustSign, kdate1);
    //    }
}
- (void)showSignature {
    struct SIGNDOC_ByteArray *blob;
    NSMutableData *data;
    double documentWidth = getDocumentWidth();
    double imagewidth = imageView.frame.size.width;
    double scale = imagewidth/documentWidth;
    UILabel *signatureLabel = [[UILabel alloc]init];
    CGRect originalSignatureFrame = getSignatureRect();
    [signatureLabel setFrame:CGRectMake(originalSignatureFrame.origin.x*scale, originalSignatureFrame.origin.y*scale, originalSignatureFrame.size.width*scale, originalSignatureFrame.size.height*scale)];
    CGRect signatureImageCoordinates = getSignatureSignDocCoordinates();
    //the coordinates do not depend on height. Height only determines the quality and will return an image of different sizes for the desired area
    blob = getSignatureImage(imageView.frame.size.height, signatureImageCoordinates);
    data = [[NSMutableData alloc] initWithBytesNoCopy:SIGNDOC_ByteArray_data(blob) length:SIGNDOC_ByteArray_count(blob)];
    UIImage *signatureImage = [UIImage imageWithData:data];
    [signatureLabel setBackgroundColor:[UIColor colorWithPatternImage:signatureImage]];
    [imageView addSubview:signatureLabel];
    [imageView bringSubviewToFront:signatureFrameLabel];
    
}
- (void)addSignatureFrame {
    double documentWidth = getDocumentWidth();
    double imagewidth = imageView.frame.size.width;
    double scale = imagewidth/documentWidth;
    // if ([signatureFrameLabel superview]) {
    // [signatureFrameLabel removeFromSuperview];//
    // signatureFrameLabel=nil;
    // }
    signatureFrameLabel = [[UITextView alloc]init];
    CGRect originalSignatureFrame = getSignatureRect();
    
    [signatureFrameLabel setFrame:CGRectMake(originalSignatureFrame.origin.x*scale, originalSignatureFrame.origin.y*scale, originalSignatureFrame.size.width*scale, originalSignatureFrame.size.height*scale)];
    // [signatureFrameLabel setBackgroundColor:[UIColor clearColor]];
    [signatureFrameLabel.layer setBorderColor:[[UIColor redColor] CGColor]];
    [signatureFrameLabel.layer setBorderWidth:2];
    [imageView addSubview:signatureFrameLabel];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self   action:@selector(signatureTapped)];
    [tap setNumberOfTapsRequired:1];
    [signatureFrameLabel addGestureRecognizer:tap];
    [signatureFrameLabel setUserInteractionEnabled:YES];
    [imageView setUserInteractionEnabled:YES];
    
}
- (void)addSignatureFrame:(int)tagValue {
    [HUD show:YES];
    [HUD hide:YES afterDelay:1];
    if (isCustomerSelected) {
        if ((tagValue==1)|| (tagValue==2)|| (tagValue==3) || (tagValue==4)|| (tagValue==5)|| (tagValue==6)|| (tagValue==7) || (tagValue==8) || (tagValue==11)) {
            return;
        }
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *currDate = [NSDate date];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    
    if(!cFFSignatureRequired){
		if (([isCustSign isEqualToString:@""] || (NSNull *) isCustSign == [NSNull null]) || isCustSign == nil) {
			setValueToField(dateString, kdate1);
		}
		else
			setValueToField(DateCustSign, kdate1);
        
    }
    
    //If its already signed --> do not populate the signer name
    NSDictionary *proposalHistory = GetProposalObject(proposalNumber);
    BOOL alreadySigned = NO;
    switch (tagValue) {
        case 0:
            alreadySigned = [[proposalHistory objectForKey:kCustomerSign]boolValue];
            
            break;
        case 1:
            alreadySigned = [[proposalHistory objectForKey:kLASign]boolValue];
            
            break;
            //        case 2:
            //            alreadySigned = [[proposalHistory objectForKey:kLA2Sign]boolValue];
            //
            //            break;
        case 3:
            alreadySigned = [[proposalHistory objectForKey:kPOSign]boolValue];
            break;
        case 4:
            alreadySigned = [[proposalHistory objectForKey:kCOSign]boolValue];
            break;
        case 5:
            alreadySigned = [[proposalHistory objectForKey:k1stTrusteeSign]boolValue];
            break;
        case 6:
            alreadySigned = [[proposalHistory objectForKey:k2ndTrusteeSign]boolValue];
            break;
        case 7:
            alreadySigned = [[proposalHistory objectForKey:kGardianSign]boolValue];
            break;
        case 8:
            alreadySigned = [[proposalHistory objectForKey:kWitnessSign]boolValue];
            break;
        case 9:
            alreadySigned = [[proposalHistory objectForKey:kAgentSign]boolValue];
            break;
        case 10:
            alreadySigned = [[proposalHistory objectForKey:kManagerSign]boolValue];
            break;
        case 11:
            alreadySigned = [[proposalHistory objectForKey:kCardHolderSign]boolValue];
            break;
            
        default:
            break;
    }
    
    
    
    double documentWidth = getDocumentWidth();
    double imagewidth = imageView.frame.size.width;
    double scale = imagewidth/documentWidth;
    // if ([signatureFrameLabel superview]) {
    // [signatureFrameLabel removeFromSuperview];//
    // signatureFrameLabel=nil;
    // }
    signatureFrameLabel = [[UITextView alloc]init];
    CGRect originalSignatureFrame = getSignatureRect();
    signatureFrameLabel.editable=NO;
    [signatureFrameLabel setFrame:CGRectMake(originalSignatureFrame.origin.x*scale, originalSignatureFrame.origin.y*scale, originalSignatureFrame.size.width*scale, originalSignatureFrame.size.height*scale)];
    // UIImage *aImage = [self drawText:currentSigner inImage:[UIImage imageNamed:@"sign-here.png"] atPoint:CGPointMake(200, 450)];
    // signatureFrameLabel.backgroundColor = [UIColor colorWithPatternImage:aImage];
    
    
    
    //    if (![Signer_type isEqualToString: @"Manager"]){
    //        if (!alreadySigned) {
    //            signatureFrameLabel.text=[NSString stringWithFormat:@"\n\n\n%@\n%@",currentSigner,currentSignerIDNumber];
    //            signatureFrameLabel.font=[UIFont systemFontOfSize:8.5];
    //            signatureFrameLabel.textAlignment = NSTextAlignmentCenter;
    //        }
    //        else
    //        {
    //            signatureFrameLabel.text=@"";
    //        }
    //
    //    }
    
    
    if (!alreadySigned) {
        signatureFrameLabel.text=[NSString stringWithFormat:@"\n\n\n%@\n%@",currentSigner,currentSignerIDNumber];
        signatureFrameLabel.font=[UIFont systemFontOfSize:8.5];
        signatureFrameLabel.textAlignment = NSTextAlignmentCenter;
    }
    else
    {
        signatureFrameLabel.text=@"";
    }
    
    
    
    
    
    // [signatureFrameLabel drawTextInRect:UIEdgeInsetsInsetRect(signatureFrameLabel.frame, insets)];
    // signatureFrameLabel.textColor=[UIColor blackColor];
    [signatureFrameLabel setBackgroundColor:[UIColor clearColor]];
    [signatureFrameLabel setAlpha:0.6];
    [signatureFrameLabel.layer setBorderColor:[[UIColor redColor] CGColor]];
    [signatureFrameLabel.layer setBorderWidth:2];
    [imageView addSubview:signatureFrameLabel];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self   action:@selector(signatureTapped:)];
    signatureFrameLabel.tag=tagValue;
    [tap setNumberOfTapsRequired:1];
    [signatureFrameLabel addGestureRecognizer:tap];
    [signatureFrameLabel setUserInteractionEnabled:YES];
    [imageView setUserInteractionEnabled:YES];
    
}
- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}

-(void)signatureTapped:(UITapGestureRecognizer*)sender
{
    
    [self hideKeyboard];
    isLocked = NO;
    NSDictionary *proposalHistory = GetProposalObject(proposalNumber);
    
    BOOL isReady=YES;
    
    UILabel* signLabel=(UILabel *)sender.view;
    NSString *str;
    NSLog(@"selected tag value=%i",signLabel.tag);
    
    NSString *birthDate = _eApplicationGenerator.lADOB;
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:birthDate]];
    int allDays = (((time/60)/60)/24);
    int days = allDays%365;
    int years = (allDays-days)/365;
    //    NSLog(@"You live since %i years and %i days - %i",years,days,allDays);
    
    NSString *yourAge = [NSString stringWithFormat:@"%d",years];
    int Myage = [yourAge intValue];
    
    NSDate *currDate = [NSDate date];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    
    switch (signLabel.tag) {
        case 0:
        {
            
            SetSigNameObject(kCustomerSign);
            // str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.lAName];
            str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],customerName,IDNumber];
            SetSignerName(str);
            currentSigner = customerName;
            currentSignerIDNumber = IDNumber;
            Signer_type = @"Customer";
            isLocked = [[proposalHistory objectForKey:kCustomerSign]boolValue];
            
            if(!cFFSignatureRequired){
                [_tableView reloadData];
				if (([isCustSign isEqualToString:@""] || (NSNull *) isCustSign == [NSNull null]) || isCustSign == nil) {
					setValueToField(dateString, kdate1);
				}
				else
					setValueToField(DateCustSign, kdate1);
            }
            
        }
            break;
        case 1:
        {
            SetSigNameObject(kLASign);
            str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.lAName,_eApplicationGenerator.lAICNO];
            //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
            SetSignerName(str);
            currentSigner = _eApplicationGenerator.lAName;
            currentSignerIDNumber = _eApplicationGenerator.lAICNO;
            Signer_type = @"LA1";
            isLocked = [[proposalHistory objectForKey:kLASign]boolValue];
            //            for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
            //                if(Myage<16){
            //                    if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kManagerSign] && ![key isEqualToString:kGardianSign] && ![key isEqualToString:kCardHolderSign] && ![key isEqualToString:kCOSign] && ![key isEqualToString:kLA2Sign] && ![key isEqualToString:kWitnessSign] && ![key isEqualToString:kLASign]) {
            //                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
            //                            isReady = NO;
            //
            //                        }
            //                    }
            //                }
            //                else if(Myage>16){
            //
            //                    if (![key isEqualToString:kAgentSign]  && ![key isEqualToString:kCustomerSign]  && ![key isEqualToString:kManagerSign] && ![key isEqualToString:k1stTrusteeSign] && ![key isEqualToString:kCardHolderSign] && ![key isEqualToString:k2ndTrusteeSign] &&  ![key isEqualToString:kLASign] && ![key isEqualToString:kCOSign] && ![key isEqualToString:kWitnessSign]) {
            //                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
            //                            isReady = NO;
            //
            //                        }
            //                    }
            //                }
            //
            //
            //            }
			
			for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
				if ([key isEqualToString:kPOSign]) {
					if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
						isReady = NO;
					}
					
				}
			}
			
            if (isReady) {
                SetSigNameObject(kLASign);
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.lAName,_eApplicationGenerator.lAICNO];
                //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.lAName;
                currentSignerIDNumber = _eApplicationGenerator.lAICNO;
                Signer_type = @"LA1";
                isLocked = [[proposalHistory objectForKey:kLASign]boolValue];
            }
            
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Signature of Policy Owner is required to proceed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
                
                [alert show];
                
                _overlayView.hidden=YES;
            }
            
            
        }
            break;
            //        case 2:
            //        {
            //            SetSigNameObject(kLA2Sign);
            //             str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.secondLAName];
            ////            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
            //            SetSignerName(str);
            //            currentSigner = _eApplicationGenerator.secondLAName;
            //            Signer_type = @"LA2";
            //            isLocked = [[proposalHistory objectForKey:kLA2Sign]boolValue];
            //        }
            //            break;
            
        case 3:
        {
            SetSigNameObject(kPOSign);
            str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.policyOwnerNamel,_eApplicationGenerator.policyOwnerICNO];
            //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
            SetSignerName(str);
            currentSigner = _eApplicationGenerator.policyOwnerNamel;
            currentSignerIDNumber = _eApplicationGenerator.policyOwnerICNO;
            Signer_type = @"PO";
            isLocked = [[proposalHistory objectForKey:kPOSign]boolValue];
            
        }
            break;
        case 4:
        {
            SetSigNameObject(kCOSign);
			
            str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.cOName,_eApplicationGenerator.cOICNo];
            //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
            SetSignerName(str);
            currentSigner = _eApplicationGenerator.cOName;
            currentSignerIDNumber = _eApplicationGenerator.cOICNo;
            Signer_type = @"CO";
            isLocked = [[proposalHistory objectForKey:kCOSign]boolValue];
            
            //            for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
            //                if(Myage<16){
            //                    if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kCardHolderSign] && ![key isEqualToString:kManagerSign] && ![key isEqualToString:kCOSign] && ![key isEqualToString:kLA2Sign] && ![key isEqualToString:kWitnessSign] && ![key isEqualToString:kLASign]) {
            //                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
            //                            isReady = NO;
            //
            //                        }
            //                    }
            //                }
            //                else if(Myage>16){
            //
            //                    if (![key isEqualToString:kAgentSign]  && ![key isEqualToString:kCOSign] && ![key isEqualToString:kWitnessSign]) {
            //                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
            //                            isReady = NO;
            //
            //                        }
            //                    }
            //                }
            //
            //
            //            }
			
			for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
				if ([key isEqualToString:kPOSign]) {
					if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
						isReady = NO;
					}
					
				}
			}
			
            if (isReady) {
                SetSigNameObject(kCOSign);
                isLocked = [[proposalHistory objectForKey:kWitnessSign]boolValue];
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.cOName,_eApplicationGenerator.cOICNo];
                //                str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.cOName;
                currentSignerIDNumber = _eApplicationGenerator.cOICNo;
                Signer_type = @"CO";               // [self render];
                //[self addSignatureFrame];
                isLocked = [[proposalHistory objectForKey:kCOSign]boolValue];
//                _overlayView.hidden=NO;
            }
            
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Signature of Policy Owner is required to proceed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
                
                [alert show];
                
                _overlayView.hidden=YES;
            }
            
            
        }
            break;
        case 5:
        {
            SetSigNameObject(k1stTrusteeSign);
            str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.trusteeName,_eApplicationGenerator.TrusteeIDNumber];
            SetSignerName(str);
            currentSigner = _eApplicationGenerator.trusteeName;
            currentSignerIDNumber = _eApplicationGenerator.TrusteeIDNumber;
            Signer_type = @"Trustee1";
            isLocked = [[proposalHistory objectForKey:k1stTrusteeSign]boolValue];
            for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
                if(Myage<16){
                    //                    if (![key isEqualToString:kAgentSign] && ![key isEqualToString:k1stTrusteeSign] && ![key isEqualToString:kLA2Sign] && ![key isEqualToString:kWitnessSign] && ![key isEqualToString:kLASign] && ![key isEqualToString:kCardHolderSign]) {
                    //                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                    //                            isReady = NO;
                    //
                    //                        }
                    //                    }
					if ([key isEqualToString:kPOSign]) {
                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                            isReady = NO;
                        }
                    }
					
                }
                else if(Myage>15){
                    
                    if (![key isEqualToString:kAgentSign]  && ![key isEqualToString:kLASign] && ![key isEqualToString:kManagerSign] && ![key isEqualToString:kCardHolderSign]  && ![key isEqualToString:k1stTrusteeSign] && ![key isEqualToString:k2ndTrusteeSign] && ![key isEqualToString:kWitnessSign]) {
                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                            isReady = NO;
                            
                        }
                    }
                }
                
                
            }
            if (isReady) {
                SetSigNameObject(k1stTrusteeSign);
                isLocked = [[proposalHistory objectForKey:kWitnessSign]boolValue];
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.trusteeName,_eApplicationGenerator.TrusteeIDNumber];
                //                str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.trusteeName;
                currentSignerIDNumber = _eApplicationGenerator.TrusteeIDNumber;
                Signer_type = @"Trustee1";
                // [self render];
                //[self addSignatureFrame];
                isLocked = [[proposalHistory objectForKey:k1stTrusteeSign]boolValue];
//                _overlayView.hidden=NO;
            }
            
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Signature of Policy Owner is required to proceed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
                
                [alert show];
                
                _overlayView.hidden=YES;
            }
            
        }
            break;
        case 6:
        {
            SetSigNameObject(k2ndTrusteeSign);
            str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.secondTrusteeName,_eApplicationGenerator.SecondTrusteeIDNumber];
            //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
            SetSignerName(str);
            currentSigner = _eApplicationGenerator.secondTrusteeName;
            currentSignerIDNumber = _eApplicationGenerator.SecondTrusteeIDNumber;
            Signer_type = @"Trustee2";
            isLocked = [[proposalHistory objectForKey:k2ndTrusteeSign]boolValue];
            for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
                if(Myage<16){
                    //                    if (![key isEqualToString:kAgentSign] && ![key isEqualToString:k2ndTrusteeSign] && ![key isEqualToString:kLA2Sign] && ![key isEqualToString:kWitnessSign] && ![key isEqualToString:kLASign]) {
                    //                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                    //                            isReady = NO;
                    //
                    //                        }
                    //                    }
					if ([key isEqualToString:kPOSign]) {
                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                            isReady = NO;
                        }
                    }
                }
                else if(Myage>15){
                    
                    if (![key isEqualToString:kAgentSign]  && ![key isEqualToString:kCardHolderSign] && ![key isEqualToString:kLASign] && ![key isEqualToString:kManagerSign]  && ![key isEqualToString:k2ndTrusteeSign] && ![key isEqualToString:k1stTrusteeSign]&& ![key isEqualToString:kWitnessSign]) {
                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                            isReady = NO;
                            
                        }
                    }
                }
                
                
            }
            if (isReady) {
                SetSigNameObject(k2ndTrusteeSign);
                isLocked = [[proposalHistory objectForKey:kWitnessSign]boolValue];
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.secondTrusteeName,_eApplicationGenerator.SecondTrusteeIDNumber];
                //                str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.secondTrusteeName;
                currentSignerIDNumber = _eApplicationGenerator.SecondTrusteeIDNumber;
                Signer_type = @"Trustee2";
                // [self render];
                //[self addSignatureFrame];
                isLocked = [[proposalHistory objectForKey:k2ndTrusteeSign]boolValue];
//                _overlayView.hidden=NO;
            }
            
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Signature of Policy Owner is required to proceed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
                
                [alert show];
                
                _overlayView.hidden=YES;
            }
        }
            break;
        case 7:
        {
            SetSigNameObject(kGardianSign);
            str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.gardianName,_eApplicationGenerator.gardianICNo];
            //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
            SetSignerName(str);
            currentSigner = _eApplicationGenerator.gardianName;
            currentSignerIDNumber = _eApplicationGenerator.gardianICNo;
            Signer_type = @"Parent";
            isLocked = [[proposalHistory objectForKey:kGardianSign]boolValue];
            for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
                if(Myage<16){
                    if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kCardHolderSign] && ![key isEqualToString:kManagerSign] && ![key isEqualToString:kGardianSign] && ![key isEqualToString:kLA2Sign] && ![key isEqualToString:kWitnessSign] && ![key isEqualToString:kLASign]) {
                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                            isReady = NO;
                            
                        }
                    }
                }
                else if(Myage>15){
                    
                    if (![key isEqualToString:kAgentSign]  && ![key isEqualToString:kManagerSign]  && ![key isEqualToString:k2ndTrusteeSign] && ![key isEqualToString:k1stTrusteeSign]&& ![key isEqualToString:kWitnessSign]) {
                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                            isReady = NO;
                            
                        }
                    }
                }
                
                
            }
            if (isReady) {
                SetSigNameObject(kGardianSign);
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.gardianName,_eApplicationGenerator.gardianICNo];
                //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.gardianName;
                currentSignerIDNumber = _eApplicationGenerator.gardianICNo;
                Signer_type = @"Parent";
                isLocked = [[proposalHistory objectForKey:kGardianSign]boolValue];
                // [self render];
                //[self addSignatureFrame];
                
//                _overlayView.hidden=NO;
            }
            
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Signature of Policy Owner is required to proceed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
                
                [alert show];
                
                _overlayView.hidden=YES;
            }
        }
            
            break;
        case 8:
        {
            
            SetSigNameObject(kWitnessSign);
            isLocked = [[proposalHistory objectForKey:kWitnessSign]boolValue];
            str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.intermediaryName,_eApplicationGenerator.intermediaryNICNo];
            //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
            SetSignerName(str);
            currentSigner = _eApplicationGenerator.intermediaryName;
            currentSignerIDNumber = _eApplicationGenerator.intermediaryNICNo;
            Signer_type = @"Witness";
            
            //            for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
			
            //                if(Myage<16){
            //                    if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kLA2Sign] && ![key isEqualToString:kWitnessSign] && ![key isEqualToString:kLASign]) {
            //                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
            //                            isReady = NO;
            //
            //                        }
            //                    }
            //                }
            //                else if(Myage>16){
            //
            //                    if (![key isEqualToString:kAgentSign]  && ![key isEqualToString:kManagerSign]  && ![key isEqualToString:kWitnessSign]) {
            //                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
            //                            isReady = NO;
            //
            //                        }
            //                    }
            //                }
            //            }
			//CHECK FOR PO SIGN
			for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
				if ([key isEqualToString:kPOSign]) {
					if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
						isReady = NO;
					}
					
				}
			}
            
            if (isReady) {
                SetSigNameObject(kWitnessSign);
                isLocked = [[proposalHistory objectForKey:kWitnessSign]boolValue];
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.intermediaryName,_eApplicationGenerator.intermediaryNICNo];
                //                str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.intermediaryName;
                currentSignerIDNumber = _eApplicationGenerator.intermediaryNICNo;
                Signer_type = @"Witness";               // [self render];
                //[self addSignatureFrame];
//                _overlayView.hidden=NO;
            }
            
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Signature of Policy Owner is required to proceed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
                
                [alert show];
                
                _overlayView.hidden=YES;
            }
            
        }
            break;
        case 9:
        {
			for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
				if ([key isEqualToString:kPOSign]) {
					if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
						isReady = NO;
					}
					
				}
			}
            if (isReady) {
                SetSigNameObject(kAgentSign);
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.intermediaryName,_eApplicationGenerator.intermediaryNICNo];
                //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.intermediaryName;
                currentSignerIDNumber = _eApplicationGenerator.intermediaryNICNo;
                Signer_type = @"Witness";
                isLocked = [[proposalHistory objectForKey:kAgentSign]boolValue];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Signature of Policy Owner is required to proceed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
                
                [alert show];
                
                _overlayView.hidden=YES;
            }
        }
            break;
        case 10:
        {
            SetSigNameObject(kManagerSign);
            str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.intermediaryManagerName,_eApplicationGenerator.intermediaryManagerIDNumber];
            //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
            SetSignerName(str);
            currentSigner = _eApplicationGenerator.intermediaryManagerName;
            currentSignerIDNumber = _eApplicationGenerator.intermediaryManagerIDNumber;
            Signer_type = @"Manager";
            isLocked = [[proposalHistory objectForKey:kManagerSign]boolValue];
            
        }
            break;
        case 11:
        {
            SetSigNameObject(kCardHolderSign);
            str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.cardMemberNameC,_eApplicationGenerator.cardMemberNewICNoC];
            //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
            SetSignerName(str);
            currentSigner = _eApplicationGenerator.cardMemberNameC;
            currentSignerIDNumber = _eApplicationGenerator.cardMemberNewICNoC;
            Signer_type = @"Cardholder";
            isLocked = [[proposalHistory objectForKey:kCardHolderSign]boolValue];
            //            for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
            //                if(Myage<16){
            //                    if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kManagerSign] && ![key isEqualToString:kGardianSign] && ![key isEqualToString:kCOSign] && ![key isEqualToString:kCardHolderSign]&& ![key isEqualToString:kLA2Sign] && ![key isEqualToString:kWitnessSign] && ![key isEqualToString:kLASign]) {
            //                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
            //                            isReady = NO;
            //
            //                        }
            //                    }
            //                }
            //                else if(Myage>16){
            //
            //                    if (![key isEqualToString:kAgentSign]  && ![key isEqualToString:k1stTrusteeSign] && ![key isEqualToString:kLASign]  && ![key isEqualToString:kManagerSign]  && ![key isEqualToString:kCardHolderSign] && ![key isEqualToString:k2ndTrusteeSign] && ![key isEqualToString:kWitnessSign]) {
            //                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
            //                            isReady = NO;
            //
            //                        }
            //                    }
            //                }
            //
            //
            //            }
			for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
				if ([key isEqualToString:kPOSign]) {
					if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
						isReady = NO;
					}
					
				}
			}
            if (isReady) {
                SetSigNameObject(kCardHolderSign);
                isLocked = [[proposalHistory objectForKey:kWitnessSign]boolValue];
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.cardMemberNameC,_eApplicationGenerator.cardMemberNewICNoC];
                //                str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.cardMemberNameC;
                currentSignerIDNumber = _eApplicationGenerator.cardMemberNewICNoC;
                Signer_type = @"Cardholder";
                // [self render];
                //[self addSignatureFrame];
                isLocked = [[proposalHistory objectForKey:kCardHolderSign]boolValue];
//                _overlayView.hidden=NO;
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Signature of Policy Owner is required to proceed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
                
                [alert show];
                
                _overlayView.hidden=YES;
            }
            
            
        }
            
            break;
        default:
            break;
    }
    
    if (isReady)
        [self captureClicked:nil];
}

- (void) abortSignature: (NSString *) fieldId {
    _overlayView.hidden=YES;
}
- (void) saveSignature {
    
    NSData *signatureData;
    UIImage *signatureImage;
    NSData *imgData;
    
    
    
    
    const char *output_path = [GetPDFPath UTF8String];
    
    signatureData = [dialog signatureAsISO19794Simple];
    
    signatureImage = [dialog signatureAsUIImage];
    BOOL getSignatureImageAsPNG = TRUE;
    if (getSignatureImageAsPNG) {
        //
        signatureImage = [self fixSemiTransparenceInImage:signatureImage];
        [self writeImageToFile:signatureImage];
    }
    imgData = getSignatureImageAsPNG ? [NSData dataWithData:UIImagePNGRepresentation(signatureImage)] : [NSData dataWithData:UIImageJPEGRepresentation(signatureImage, 1)];
    
    signTest([GetObjectSigName cStringUsingEncoding:NSASCIIStringEncoding], (unsigned char *)[signatureData bytes], [signatureData length], (unsigned char *)[imgData bytes], [imgData length], output_path, TRUE);
    
    NSMutableDictionary *dic= [GetProposalObject(proposalNumber)mutableCopy];
    [dic setObject:[NSNumber numberWithBool:YES] forKey:GetObjectSigName];
    SetProposalObject(dic, proposalNumber);
    [self cleanSignatureFrames];
    [_tableView reloadData];
    
    
    // to check if everyone have signed.
    BOOL allSigned=YES;
    for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
            allSigned = NO;
        }
    }
    if (allSigned) {
        [self injectSignDateAndLocation];
    }
    
    [self render];
    if (cFFSignatureRequired) {
        cFFSignatureRequired= NO; //We Have Collected the Customer signature -- Must False the value
        //        [self showSignatureCollectorView];
    }
    [HUD hide:YES];
}
-(void)showAlert{
    
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy ( HH:mm a)"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    NSLog(@"%@",dateString);
    
    NSString *strNewDate;
    NSString *strNewTime;
    NSString *strCurrentDate;
    NSDateFormatter *df =[[NSDateFormatter alloc]init];
    [df setDateStyle:NSDateFormatterMediumStyle];
    [df setTimeStyle:NSDateFormatterMediumStyle];
    strCurrentDate = [df stringFromDate:currDate];
    NSLog(@"Current Date and Time: %@",strCurrentDate);
    int hoursToAdd = 120;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:hoursToAdd];
    NSDate *newDate= [calendar dateByAddingComponents:components toDate:currDate options:0];
    [df setDateFormat:@"(dd/MM/yyyy)"];
    strNewDate = [df stringFromDate:newDate];
    
    NSDate *newTime= [calendar dateByAddingComponents:components toDate:currDate options:0];
    [df setDateFormat:@"(HH:mm a)"];
    strNewTime = [df stringFromDate:newTime];
    
    
    
    
    NSString *PolicyOwner;
    PolicyOwner = @"No amendment is allowed after save. Do you want to save?";
    if ([Signer_type isEqualToString:@"PO"]) {
        
        //PolicyOwner =@"Kindly obtain all the necessary signatures and proceed with the submission before date (date) and time (XX:XX AM/PM). Otherwise, the case will be invalid.";
        PolicyOwner =[NSString stringWithFormat:@"Kindly obtain all the necessary signatures and proceed with the submission before date %@ and time %@. Otherwise, the case will be invalid.\n\n%@",strNewDate,strNewTime,PolicyOwner];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:PolicyOwner delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
    
    NSLog(@"Displaying No Admendment alert");
    [alert setTag:1234];
    [alert show];
    alert=nil;
    
    
}
- (void) handleSignature: (CFDataRef) points withFieldId: (NSString *) fieldId
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *currDate = [NSDate date];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
	
    if(!cFFSignatureRequired){
		if (([isCustSign isEqualToString:@""] || (NSNull *) isCustSign == [NSNull null]) || isCustSign == nil) {
			setValueToField(dateString, kdate1);
		}
		else
			setValueToField(DateCustSign, kdate1);
    }
	_overlayView.hidden=YES;
    if (!points)
        return;
    
    isExcecution=NO;
    selectedTag=0;
    
    [self performSelectorInBackground:@selector(showAlert) withObject:nil];
    
    while (!isExcecution) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    }
    if (selectedTag==0)
        [self saveSignature];
    else{
        [self abortSignature:fieldId];
    }
    
    
}
-(void)injectSignDateAndLocationAfterSign
{
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"dd"];
    NSString *dayStr = [dateFormatter stringFromDate:currDate];
    for (int i=0; i<dayStr.length; i++) {
        setValueToField([dayStr substringWithRange:NSMakeRange(i, 1)], [NSString stringWithFormat:@"%@%i",ksignedOnDay,i]);
    }
    
    [dateFormatter setDateFormat:@"MM"];
    NSString *monthStr = [dateFormatter stringFromDate:currDate];
    for (int i=0; i<monthStr.length; i++) {
        setValueToField([monthStr substringWithRange:NSMakeRange(i, 1)], [NSString stringWithFormat:@"%@%i",ksignedOnMonth,i]);
    }
    
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *yearStr = [dateFormatter stringFromDate:currDate];
    for (int i=0; i<yearStr.length; i++) {
        setValueToField([yearStr substringWithRange:NSMakeRange(i, 1)], [NSString stringWithFormat:@"%@%i",ksignedOnYear,i]);
    }
    
    
    
    //saveField();
}
-(void)injectSignDateAndLocation
{
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"dd"];
    NSString *dayStr = [dateFormatter stringFromDate:currDate];
    for (int i=0; i<dayStr.length; i++) {
        setValueToField([dayStr substringWithRange:NSMakeRange(i, 1)], [NSString stringWithFormat:@"%i",i]);
    }
    
    [dateFormatter setDateFormat:@"MM"];
    NSString *monthStr = [dateFormatter stringFromDate:currDate];
    for (int i=0; i<monthStr.length; i++) {
        setValueToField([monthStr substringWithRange:NSMakeRange(i, 1)], [NSString stringWithFormat:@"%i",i]);
    }
    
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *yearStr = [dateFormatter stringFromDate:currDate];
    for (int i=0; i<yearStr.length; i++) {
        setValueToField([yearStr substringWithRange:NSMakeRange(i, 1)], [NSString stringWithFormat:@"%i",i]);
    }
    
    saveField();
}
- (void)writeImageToFile:(UIImage *)image {
    NSData *imgData = UIImagePNGRepresentation(image);
    NSString  *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Test.png"];
    // to mark signatory
    
    // to mark those that have signed.
    
    if ([Signer_type isEqualToString:@"LA1"])
    {
        LA1 = @"Y";
        NSLog(@"%@ have signed",Signer_type);
    }
    else if ([Signer_type isEqualToString:@"LA2"])
    {
        LA2 = @"Y";
        NSLog(@"%@ have signed",Signer_type);
    }
    else if ([Signer_type isEqualToString:@"PO"])
    {
        PO = @"Y";
        //        POsignDate = @"Date";
        //        POsignAt = @"Kuala Lumpur";
        NSLog(@"%@ have signed",Signer_type);
    }
    else if ([Signer_type isEqualToString:@"CO"])
    {
        CO = @"Y";
        NSLog(@"%@ have signed",Signer_type);
    }
    else if ([Signer_type isEqualToString:@"Trustee1"])
    {
        Trustee1 = @"Y";
        NSLog(@"%@ have signed",Signer_type);
    }
    else if ([Signer_type isEqualToString:@"Trustee2"])
    {
        Trustee2 = @"Y";
        NSLog(@"%@ have signed",Signer_type);
    }
    else if ([Signer_type isEqualToString:@"Parent"])
    {
        Parent = @"Y";
        NSLog(@"%@ have signed",Signer_type);
    }
    else if ([Signer_type isEqualToString:@"Witness"])
    {
        Witness = @"Y";
        NSLog(@"%@ have signed",Signer_type);
    }
    else if ([Signer_type isEqualToString:@"Cardholder"])
    {
        CardHolder = @"Y";
        NSLog(@"%@ have signed",Signer_type);
    }
    
    
    [imgData writeToFile:imagePath atomically:YES];
}
- (UIImage *)fixSemiTransparenceInImage:(UIImage *)image {
    CGImageRef imageRef = [image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    [self removeMarginAlmostBlackBlocks:rawData width:width height:height bytesPerRow:bytesPerRow bytesPerPixel:bytesPerPixel];
    [self fixByAddingTransparency:rawData width:width height:height bytesPerRow:bytesPerRow bytesPerPixel:bytesPerPixel];
    if (height * width == 0) {
        CGColorSpaceRelease(colorSpace);
        return nil;
    }
    UInt8 * m_PixelBuf = malloc(sizeof(UInt8) * height * width * 4);
    CGContextRef ctx = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGImageRef newImgRef = CGBitmapContextCreateImage(ctx);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(ctx);
    free(m_PixelBuf);
    UIImage *finalImage = [UIImage imageWithCGImage:newImgRef];
    CGImageRelease(newImgRef);
    return finalImage;
}
- (void)removeMarginAlmostBlackBlocks:(unsigned char *)rawData width:(NSUInteger)width height:(NSUInteger)height bytesPerRow:(NSUInteger)bytesPerRow  bytesPerPixel:(NSUInteger)bytesPerPixel {
    for(int  y = 0; y < height; y++) {
        for(int x = 0; x < width; x++) {
            int byteIndex = (bytesPerRow * y) + x * bytesPerPixel;
            int red = rawData[byteIndex];
            int green = rawData[byteIndex + 0];
            int blue = rawData[byteIndex + 0];
            if (red + green + blue < 10) {
                rawData[byteIndex+0] = 0;
            }
        }
    }
}

- (void)fixByAddingTransparency:(unsigned char *)rawData width:(NSUInteger)width height:(NSUInteger)height bytesPerRow:(NSUInteger)bytesPerRow  bytesPerPixel:(NSUInteger)bytesPerPixel {
    for(int  y = 0; y < height; y++) {
        for(int x = 0; x < width; x++) {
            int byteIndex = (bytesPerRow * y) + x * bytesPerPixel;
            int alpha = rawData[byteIndex + 3];
            if (alpha != 0 && alpha != 255) {
                //http://en.wikipedia.org/wiki/Alpha_compositing#Alpha_blending for a white background
                rawData[byteIndex]  = (int)((1 - rawData[byteIndex+3]/255.0) * 255 + rawData[byteIndex+3]/255.0 * rawData[byteIndex]);
                rawData[byteIndex+1]  = (int)((1 - rawData[byteIndex+3]/255.0) * 255 + rawData[byteIndex+3]/255.0 * rawData[byteIndex+1]);
                rawData[byteIndex+2]  = (int)((1 - rawData[byteIndex+3]/255.0) * 255 + rawData[byteIndex+3]/255.0 * rawData[byteIndex+2]);
                rawData[byteIndex+3] = 255;
            }
        }
    }
}
- (IBAction)captureClicked:(id)sender {
    
    if (isLocked) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"The signature has been collected. You are not allowed to sign again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    //[self.view addSubview:_overlayView];
    // UIWindow *AppWindow = [[UIApplication sharedApplication] keyWindow];
    // [AppWindow bringSubviewToFront:_overlayView];
    _overlayView.backgroundColor=[UIColor grayColor];
    _overlayView.hidden=NO;
    BOOL createCustomizedDialog = TRUE;
    if (createCustomizedDialog) {
        UIImage *aImage = [self drawText:currentSigner inImage:[UIImage imageNamed:@"sign-here.png"] atPoint:CGPointMake(200, 450)];
        NSArray *xibsArray = [NSArray arrayWithObjects:@"MyCustomDialog", nil];
        dialog = [[SDSignatureCaptureController alloc] initWithParent: self withDelegate: self backgroundImage:aImage dialogXibs:xibsArray languages:nil];
    } else {
        dialog = [[SDSignatureCaptureController alloc] initWithParent: self withDelegate: self];
    }
    NSMutableDictionary *penPropertiesDictionary = [[NSMutableDictionary alloc]init];
    [penPropertiesDictionary setObject:[NSNumber numberWithInteger:10] forKey:@"penSize"];
    [penPropertiesDictionary setObject:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f] forKey:@"color"];
    [dialog setPenProperties:penPropertiesDictionary];
    [dialog setDialogPosition:1];
    [dialog setTitle:currentSigner];
    [dialog captureSignature];
    
}

- (IBAction)backPressed:(id)sender
{
    //[self.view removeFromSuperview];
    
    //[self dismissModalViewControllerAnimated:YES];
    // [self dismissViewControllerAnimated:YES completion:Nil];
    
    //   [delegate refresheSigndata];
    
    
//	[self SaveUpdate];
  	
	BOOL allSigned=YES;
	BOOL partialSigned=NO;
    NSString *birthDate = _eApplicationGenerator.lADOB;
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:birthDate]];
    int allDays = (((time/60)/60)/24);
    int days = allDays%365;
    int years = (allDays-days)/365;
    //    NSLog(@"You live since %i years and %i days - %i",years,days,allDays);
    
    NSString *yourAge = [NSString stringWithFormat:@"%d",years];
    int Myage = [yourAge intValue];
    for (NSString *key in [GetProposalObject(proposalNumber)allKeys])
    {
        if(![key isEqualToString:kLASign]){
			if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
				allSigned = NO;
			}
        }
        
    }
	
	for (NSString *key in [GetProposalObject(proposalNumber)allKeys])
    {
        if([key isEqualToString:kCustomerSign]){
			if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
				partialSigned = YES;
			}
        }
    }
	
	BOOL kwitnessS = YES;
	if ([[GetProposalObject(proposalNumber)objectForKey:@"kWitnessSign"]boolValue]==NO) {
		kwitnessS = NO;
//		partialSigned = YES;
	}
	
	[self LoadDB];
	if  ((NSNull *) SignAt == [NSNull null] || SignAt == nil)
		SignAt = @"";
	
    if (([SignAt isEqualToString:@""]) && allSigned && kwitnessS) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Please key in the signing location."
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
        
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        alertView.tag = 1000;
        
        [alertView show];
		
        
    }
	
    else if (([SignAt isEqualToString:@""]) && (partialSigned || !kwitnessS))
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"There are pending required signature(s). The form has been saved as a draft." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag=12000;
        [alert show];
		[self refreshPDFData];
		// _navC.view.hidden=NO;
		//  [self.view removeFromSuperview];
        //[_navC.view removeFromSuperview];
    }
	
	else {
		HUD = [[MBProgressHUD alloc] initWithView:self.view];
		[self.view addSubview:HUD];
		HUD.labelText = @"Reloading e-Application";
		[HUD show:YES];
		
		[self performSelector:@selector(refreshPDFData) withObject:nil afterDelay:1];
		_navC.view.hidden=NO;
		//[self.view removeFromSuperview];
	}
}
-(void)saveToXML
{
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"Saving signature";
    [HUD show:YES];
    
    NSDictionary* tempSignDic=[[NSDictionary alloc]initWithObjectsAndKeys:DatePOSign,@"SIGNDATE",SignAtTextField,@"SIGNAT",LA1,@"SIGNFASSURED1",LA2,@"SIGNFASSURED2",PO,@"SIGNFPOLOWNER",CO,@"SIGNFCONOWNER",Trustee1,@"SIGNFTRUSTEE1",Trustee2,@"SIGNFTRUSTEE2",Parent,@"SIGNFPARENTS",Witness,@"SIGNFWITNESS",CardHolder,@"SIGNFCARDHOLDER", nil];
    NSLog(@"proposalNumber%@",proposalNumber);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"ProposalXML/%@_PR.xml",proposalNumber]];
    //  NSString* path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@_PR",proposalNumber] ofType:@"xml"];
    
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:path];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0   error:&error];
    
    /* GDataXMLElement *rootElement = [GDataXMLElement elementWithName:@"SignInfo"];
     
     [tempSignDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
     GDataXMLElement *element = [GDataXMLElement elementWithName:key stringValue:obj];
     [rootElement addChild:element];
     }];
     GDataXMLDocument *document = [[GDataXMLDocument alloc]
     initWithRootElement:rootElement];*/
    //  NSData *xmlData1 = document.XMLData;
    // NSData*  xmlData1 = doc.XMLData;
	
	[self SaveToDB];
	[self LoadDB];
	
    NSArray *mySettings = [doc.rootElement elementsForName:@"SignInfo"];
    
    for (GDataXMLElement *mySet in mySettings)
    {
        
        //NSString *POSignDate;
        NSArray *POSD = [mySet elementsForName:@"SIGNDATE"];
        if (POSD.count > 0)
        {
            GDataXMLElement *childElement = (GDataXMLElement *) [POSD objectAtIndex:0];
			
            [childElement setStringValue:DatePOSign];
        }
        
        //NSString *POSignAt;
        NSArray *POSA = [mySet elementsForName:@"SIGNAT"];
        if (POSA.count > 0)
        {
            GDataXMLElement *childElement = (GDataXMLElement *) [POSA objectAtIndex:0];
			
            [childElement setStringValue:SignAtTextField];
        }
        
        //NSString *name;
        NSArray *names = [mySet elementsForName:@"SIGNFASSURED1"];
        if (names.count > 0)
        {
            GDataXMLElement *childElement = (GDataXMLElement *) [names objectAtIndex:0];
            // name = childElement.stringValue;
            // NSLog(childElement.stringValue);
			
			if (([isLASign isEqualToString:@""] || (NSNull *) isLASign == [NSNull null]))
				isLASign = @"N";
			else if ([isLASign isEqualToString:@"YES"])
				isLASign = @"Y";
            [childElement setStringValue:isLASign];
        }
        //2
        NSArray *second2 = [mySet elementsForName:@"SIGNFASSURED2"];
        if (second2.count > 0)
        {
            GDataXMLElement *childElement = (GDataXMLElement *) [second2 objectAtIndex:0];
            // name = childElement.stringValue;
            // NSLog(childElement.stringValue);
			
			if (([isLA2Sign isEqualToString:@""] || (NSNull *) isLA2Sign == [NSNull null]))
				isLA2Sign = @"N";
			else if ([isLA2Sign isEqualToString:@"YES"])
				isLA2Sign = @"Y";
			
            [childElement setStringValue:isLA2Sign];
        }
        NSArray *names3 = [mySet elementsForName:@"SIGNFPOLOWNER"];
        if (names3.count > 0)
        {
            GDataXMLElement *childElement = (GDataXMLElement *) [names3 objectAtIndex:0];
            // name = childElement.stringValue;
            // NSLog(childElement.stringValue);
			
			if (([isPOSign isEqualToString:@""] || (NSNull *) isPOSign == [NSNull null]))
				isPOSign = @"N";
			else if ([isPOSign isEqualToString:@"YES"])
				isPOSign = @"Y";
			
            [childElement setStringValue:isPOSign];
        }
        //2
        NSArray *second4 = [mySet elementsForName:@"SIGNFCONOWNER"];
        if (second4.count > 0)
        {
            GDataXMLElement *childElement = (GDataXMLElement *) [second4 objectAtIndex:0];
            // name = childElement.stringValue;
            // NSLog(childElement.stringValue);
			
			if (([isCOSign isEqualToString:@""] || (NSNull *) isCOSign == [NSNull null]))
				isCOSign = @"N";
			else if ([isCOSign isEqualToString:@"YES"])
				isCOSign = @"Y";
            [childElement setStringValue:isCOSign];
        }
        NSArray *names5 = [mySet elementsForName:@"SIGNFTRUSTEE1"];
        if (names5.count > 0)
        {
            GDataXMLElement *childElement = (GDataXMLElement *) [names5 objectAtIndex:0];
            // name = childElement.stringValue;
            // NSLog(childElement.stringValue);
			
			if (([isTrusteeSign isEqualToString:@""] || (NSNull *) isTrusteeSign == [NSNull null]))
				isTrusteeSign = @"N";
			else if ([isTrusteeSign isEqualToString:@"YES"])
				isTrusteeSign = @"Y";
            [childElement setStringValue:isTrusteeSign];
        }
        //2
        NSArray *second6 = [mySet elementsForName:@"SIGNFTRUSTEE2"];
        if (second6.count > 0)
        {
            GDataXMLElement *childElement = (GDataXMLElement *) [second6 objectAtIndex:0];
            // name = childElement.stringValue;
            // NSLog(childElement.stringValue);
			if (([isTrustee2Sign isEqualToString:@""] || (NSNull *) isTrustee2Sign == [NSNull null]))
				isTrustee2Sign = @"N";
			else if ([isTrustee2Sign isEqualToString:@"YES"])
				isTrustee2Sign = @"Y";
			
            [childElement setStringValue:isTrustee2Sign];
        }
        NSArray *names7 = [mySet elementsForName:@"SIGNFPARENTS"];
        if (names7.count > 0)
        {
            GDataXMLElement *childElement = (GDataXMLElement *) [names7 objectAtIndex:0];
            // name = childElement.stringValue;
            // NSLog(childElement.stringValue);
			if (([isGuardianSign isEqualToString:@""] || (NSNull *) isGuardianSign == [NSNull null]))
				isGuardianSign = @"N";
			else if ([isGuardianSign isEqualToString:@"YES"])
				isGuardianSign = @"Y";
			
            [childElement setStringValue:isGuardianSign];
        }
        //2
        NSArray *second8 = [mySet elementsForName:@"SIGNFWITNESS"];
        if (second8.count > 0)
        {
            GDataXMLElement *childElement = (GDataXMLElement *) [second8 objectAtIndex:0];
            // name = childElement.stringValue;
            // NSLog(childElement.stringValue);
			
			if (([isWitnessSign isEqualToString:@""] || (NSNull *) isWitnessSign == [NSNull null]))
				isWitnessSign = @"N";
			else if ([isWitnessSign isEqualToString:@"YES"])
				isWitnessSign = @"Y";
			
            [childElement setStringValue:isWitnessSign];
        }
        NSArray *second9 = [mySet elementsForName:@"SIGNFCARDHOLDER"];
        if (second9.count > 0)
        {
            GDataXMLElement *childElement = (GDataXMLElement *) [second9 objectAtIndex:0];
            // name = childElement.stringValue;
            // NSLog(childElement.stringValue);
			
			if (([isCardHolderSign isEqualToString:@""] || (NSNull *) isCardHolderSign == [NSNull null]))
				isCardHolderSign = @"N";
			else if ([isCardHolderSign isEqualToString:@"YES"])
				isCardHolderSign = @"Y";
            [childElement setStringValue:isCardHolderSign];
        }
        
        
        
    }
    xmlData=doc.XMLData;
    [xmlData writeToFile:path atomically:YES];
    
    
    
    //  [SignInfoToXML appendFormat:@"<SignInfo><SIGNFASSURED1>N</SIGNFASSURED1><SIGNFASSURED2>N</SIGNFASSURED2><SIGNFPOLOWNER>N</SIGNFPOLOWNER><SIGNFCONOWNER>N</SIGNFCONOWNER><SIGNFTRUSTEE1>N</SIGNFTRUSTEE1><SIGNFTRUSTEE2>N</SIGNFTRUSTEE2><SIGNFPARENTS>N</SIGNFPARENTS><SIGNFWITNESS>N</SIGNFWITNESS><SIGNFCARDHOLDER>N</SIGNFCARDHOLDER>",
    
    
}

-(void)SaveUpdate {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	//    NSString *documentsDirectory = [paths objectAtIndex :0];
    
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];

    
    if (![db open]) {
        [db open];
    }
    
	NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
	NSDate *currDate = [NSDate date];
	[dateFormatter2 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
	NSString *dateString = [dateFormatter2 stringFromDate:currDate];
	
	NSString *queryB = @"";
	queryB = [NSString stringWithFormat:@"UPDATE eApp_Listing SET DateUpdated = '%@' WHERE ProposalNo = '%@'", dateString, proposalNumber];
	[db executeUpdate:queryB];
	
}


- (IBAction)saveDocumentClicked:(id)sender
{
    //    [self saveToXML];
    saveDocument();
	
//	[self SaveUpdate];
	
    BOOL allSigned=YES;
    NSString *birthDate = _eApplicationGenerator.lADOB;
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:birthDate]];
    int allDays = (((time/60)/60)/24);
    int days = allDays%365;
    int years = (allDays-days)/365;
    //    NSLog(@"You live since %i years and %i days - %i",years,days,allDays);
    
    NSString *yourAge = [NSString stringWithFormat:@"%d",years];
    int Myage = [yourAge intValue];
    for (NSString *key in [GetProposalObject(proposalNumber)allKeys])
    {
        if(![key isEqualToString:kLASign]){
            if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                allSigned = NO;
            }
        }
        
    }
	
	BOOL kwitnessS = YES;
	if ([[GetProposalObject(proposalNumber)objectForKey:@"kWitnessSign"]boolValue]==NO) {
		kwitnessS = NO;
	}
	
	
    if  ((NSNull *) SignAt == [NSNull null] || SignAt == nil )
		SignAt = @"";
	
    if (([SignAt isEqualToString:@""]) && allSigned && kwitnessS) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Please key in the signing location."
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
        
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        alertView.tag = 1000;
        
        [alertView show];
        
    }
    else if ([SignAt isEqualToString:@""] && !kwitnessS)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"There are pending required signature(s). The form has been saved as a draft." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag=12000;
        [alert show];
		[self refreshPDFData];
        // _navC.view.hidden=NO;
        //  [self.view removeFromSuperview];
        //[_navC.view removeFromSuperview];
    }
	else {
		saveField();
		
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"All signatures have been saved successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		alert.tag=12000;
		[alert show];
		[self refreshPDFData];
	}
    // [self saveToXML];
    
}

-(void)SignInPromptMessage
{
    NSLog(@"alertHere");
    
    //    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    [button addTarget:self
    //               action:@selector(aMethod:)
    //     forControlEvents:UIControlEventTouchUpInside];
    //    [button setTitle:@"Sign here" forState:UIControlStateNormal];
    //    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    //    [self.view addSubview:button];
    
    
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:nil];
    CustomAlertBox * agree = (CustomAlertBox *)[storyboard instantiateViewControllerWithIdentifier:@"CustomAlertBox"];
    agree.changetext=YES;
    // agree.textLabel.text=@"testing ghjhjjjjkjkj jhkjkjkjkjkjkj jkjkjkjjkjjk jkjkjjkjkjkjkjkjkj";
    // agree.textLabel.numberOfLines=0;
    // CustomAlertBox* agree=[[CustomAlertBox alloc] init];
    agree.delegate=self;
    
    agree.modalPresentationStyle = UIModalPresentationFormSheet;
    agree.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentModalViewController:agree animated:NO];
    agree.view.superview.frame = CGRectMake(120, 200, 450, 600);
    
    
    
}

#pragma mark - Local Method
-(NSString *)eApplicationForProposalNo:(NSString *)proposalNo fromInfoDic:(NSDictionary *)infoDic
{
    
    if (infoDic)
    {
        //Check if Customer Signature is required
        //By Default Customer signature is required, if its a company BOOL will be FALSED during the following check
        cFFSignatureRequired=YES;
        ToCheckAlert = YES;
        CheckRelationship = YES;
        NSMutableArray *array = nil;
        if ([[[infoDic objectForKey:@"AssuredInfo"]objectForKey:@"Party"]isKindOfClass:[NSArray class]]) { //Check if its an array
            array = [[infoDic objectForKey:@"AssuredInfo"]objectForKey:@"Party"];
        }
        else //If its a dictionary; put it in an array to continue
        {
            array = [[NSMutableArray alloc]initWithObjects:[[infoDic objectForKey:@"AssuredInfo"]objectForKey:@"Party"], nil];
        }
        
        for (id obj in array) { //Check if it a company
            if ([[obj objectForKey:@"PTypeCode"]isEqualToString:@"PO"]) {
                //customerName  = [obj objectForKey:@"LAName"];
                if ([[[obj objectForKey:@"LAOtherID"]objectForKey:@"LAOtherIDType"]isEqualToString:@"CR"]) {
                    cFFSignatureRequired = NO;
                    ToCheckAlert = NO;
                }
            }
            if ([[obj objectForKey:@"PTypeCode"]isEqualToString:@"LA"]) {
                //customerName  = [obj objectForKey:@"LAName"];
                if ([[obj objectForKey:@"LARelationship"]isEqualToString:@"SELF"]) {
                    CheckRelationship = NO;
                }
            }
        }
        
        NSMutableArray *array1 = nil;
        if ([[[infoDic objectForKey:@"PersonalInfo"]objectForKey:@"CFFParty"]isKindOfClass:[NSArray class]]) { //Check if its an array
            array1 = [[infoDic objectForKey:@"PersonalInfo"]objectForKey:@"CFFParty"];
        }
        else //If its a dictionary; put it in an array to continue
        {
            array1 = [[NSMutableArray alloc]initWithObjects:[[infoDic objectForKey:@"PersonalInfo"]objectForKey:@"CFFParty"], nil];
        }
        
        for (id obj1 in array1) { //Check if it a company
            NSString *getCFFID = [obj1 objectForKey:@"_ID"];
            if ([getCFFID isEqualToString:@"1"]) {
                customerName  = [obj1 objectForKey:@"Name"];
                IDNumber = [obj1 objectForKey:@"NewICNo"];
                if(IDNumber.length==0){
                    IDNumber = [obj1 objectForKey:@"OtherID"];
                    
                }
            }
        }
        
        NSLog(@"itsOverHere");
        _infoDic = infoDic;
        _eApplicationGenerator = [[ESignGenerator alloc]init];
        NSString *outPutFile=[_eApplicationGenerator eApplicationForProposalNo:proposalNo fromInfoDic:infoDic];
        pdfPath = outPutFile;
        
        NSLog(@"output_file %@",outPutFile);
        proposalNumber = proposalNo;
        SetPDFPath(outPutFile);
        _requiredArr = _eApplicationGenerator.requiredArr;
        
        _pdfViewController = [[PDFViewController alloc] initWithPath:outPutFile];
        _pdfViewController.title = proposalNo;
        //self.view.backgroundColor = [UIColor blueColor];
        
        ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
        
        _navC.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
        
        
        _navC = [[UINavigationController alloc]initWithRootViewController:_pdfViewController];
        _navC.view.frame = self.view.frame;
        
        
        _navC.view.autoresizingMask =  UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin;
        _navC.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
        
        _navC.navigationBar.translucent = NO;
        
        
        
        
        //[_pdfViewController.navigationItem setRightBarButtonItems:@[signBarButtonItem]];
        UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"e-Application Checklist" style:UIBarButtonItemStylePlain target:self action:@selector(cancelIt:)];
        
        if([_cellRghtbuttonDisabled1 isEqualToString:@"disable"])
        {
            signBarButtonItem.enabled=NO;
            
            
        }
        else
        {
            
            
            
            
            
            //hasData = NO;
            
            signBarButtonItem.enabled=YES;
            signBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign" style:UIBarButtonItemStylePlain target:self action:@selector(signIt:)];
            [_pdfViewController.navigationItem setRightBarButtonItems:@[signBarButtonItem]];
            signBarButtonItem.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
            
            NSArray *array1=[[NSUserDefaults standardUserDefaults] objectForKey:@"CompareSign"];
            
            if(![array1 containsObject:proposalNumber])
            {
                [self performSelector:@selector(SignInPromptMessage) withObject:nil afterDelay:1.0f];
            }
            
            
            
        }
        
        //[_pdfViewController.navigationItem setRightBarButtonItems:@[signBarButtonItem,cancelBarButtonItem]];
        //        [_pdfViewController.navigationItem setRightBarButtonItems:@[signBarButtonItem]];
        [_pdfViewController.navigationItem setLeftBarButtonItems:@[cancelBarButtonItem]];
        
        cancelBarButtonItem.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
        
        
        //
        //        BOOL allSigned=YES;
        //        for (NSString *key in [GetProposalObject(proposalNumber)allKeys])
        //        {
        //            if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO)
        //            {
        //                allSigned = NO;
        //                 NSLog(@"testthere");
        //                [signBarButtonItem setEnabled:NO];
        //
        //            }
        //            else
        //            {
        //
        //
        //                NSLog(@"testHere");
        //                [signBarButtonItem setEnabled:YES];
        //
        //
        //
        //            }
        //        }
        
        [self.navigationItem.rightBarButtonItem.customView setAlpha:0.0];
        [self.view addSubview:_navC.view];
        [HUD hide:YES];
        
        
        
        [self refreshPDFData];
        
        
    }
    else
    {
        [HUD hide:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid XML File/Format." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return nil;
    }
    [HUD hide:YES];
    return nil;
}




-(void)refreshPDFData
{
    [_scroller removeFromSuperview];
    _scroller=nil;
    _scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _scroller.tag = 9999;
    [_scroller setBackgroundColor:[UIColor grayColor]];
    UIView *pdfv =[self createUIForPDF];
    [_scroller addSubview:pdfv];
    [_scroller setContentSize:pdfv.frame.size];
    [_pdfViewController.view addSubview:_scroller];
    [HUD hide:YES];
}

-(void)AFuction
{
    NSLog(@"AFunction");
    //    buttonq.enabled =YES;
    //
    //    buttonq = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    [buttonq addTarget:self
    //                action:@selector(aMethod:)
    //      forControlEvents:UIControlEventTouchUpInside];
    //    [buttonq setTitle:@"Show View" forState:UIControlStateNormal];
    //    buttonq.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    //    [self.view addSubview:buttonq];
    
    //   buttonq.enabled =NO;
    
    
    [signBarButtonItem setEnabled:YES];
    
}

-(void)AgreeFlag:(NSString *)agree
{
    
    if([agree isEqualToString:@"Y"])
    {
        
        
    }
    else if ([agree isEqualToString:@"C"])
    {
        
        
        [_navC.view removeFromSuperview];
        [self.view removeFromSuperview];
        
        NSLog(@"iwantremove");
        
        
    }
    
}

-(void)dissmissFlag:(NSString *)cancel
{
    
}

//-(void)Signtheform
//{
//     NSLog(@"im here2");
//    [_navC.view removeFromSuperview];
//    [_tableView reloadData];
//    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
//                            animated:NO                       scrollPosition:UITableViewScrollPositionTop];
//
//  [self tableView:_tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
//
//    NSLog(@"im here");
//
//
//}

-(void)signIt:(id)sender
{
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsPath = [paths objectAtIndex:0];
	NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    NSString *isAllSignAlready;
	
	FMDatabase *db = [FMDatabase databaseWithPath:path];
	[db open];
    
    bool test ;
    
    test=YES;
	
	FMResultSet *results;
	results = nil;
	results = [db executeQuery:@"select * from eProposal_Signature where eProposalNo = ?", proposalNumber, Nil];
	
	//hasData = NO;
	while ([results next])
    {
        
        isAllSignAlready = [results stringForColumn:@"SignAt"];
        
        if  ((NSNull *) isAllSignAlready == [NSNull null])
            isAllSignAlready = @"";
        
        if (isAllSignAlready ==nil||[isAllSignAlready isEqualToString:@""])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"I/We acknowledge that I/We have read and fully understood the declaration and authorization stated above." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            alert.tag = 2000;
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"All the respective Signatures are captured." delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
            //alert.tag = 2000;
            [alert show];
            
        }
        
        test =NO;
        
        
    }
    
    if(test ==NO)
    {
        
    }
    else if(test == YES)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"I/We acknowledge that I/We have read and fully understood the declaration and authorization stated above." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        alert.tag = 2000;
        [alert show];
    }
}
-(void)showSignatureCollectorView
{
	
    isCustomerSelected = YES;
    _navC.view.hidden=YES;
    [_tableView reloadData];
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                            animated:NO                       scrollPosition:UITableViewScrollPositionTop];
    [self tableView:_tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    [HUD hide:YES];
}

-(void)showSignatureCollectorViewforPO
{
    isCustomerSelected = YES;
    [_tableView reloadData];
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                            animated:NO
                      scrollPosition:UITableViewScrollPositionNone];
    [self tableView:_tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:3 inSection:0]];
    [HUD hide:YES];
}

-(void)cancelIt:(id)sender
{
    
    //--------->>>>> Cancel/Dismiss/Back/Hide this controller.
    
    //Write your method to dismiss or hide this view controller here
    //For Example :
    AppDelegate *appobj=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if (appobj.AUBackButtonHandling==YES) {
        [delegate RefreshInformationData];
    }
    
    //    [delegate RefreshInformationData];
    [_navC.view removeFromSuperview];
    [self.view removeFromSuperview];
    
}
-(UIImage*) drawText:(NSString*) text
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point
{
    
    UIFont *font = [UIFont boldSystemFontOfSize:17];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    [[UIColor blackColor] set];
    [text drawInRect:CGRectIntegral(rect) withFont:font];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
-(void)cleanSignatureFrames
{
    for (UIView *view in imageView.subviews) {
        
        [view removeFromSuperview];
    }
}
#pragma mark - DB

-(void)SaveToDB {
    //	NSString *isCustSign;
    //	NSString *DateCustSign;
    //	NSString *isPOSign;
    //	NSString *DatePOSign;
    //	NSString *isLASign;
    //	NSString *DateLASign;
    //	NSString *isLA2Sign;
    //	NSString *DateLA2Sign;
    //	NSString *isCOSign;
    //	NSString *DateCOSign;
    //	NSString *isTrusteeSign;
    //	NSString *DateTrusteeSign;
    //	NSString *isTrustee2Sign;
    //	NSString *DateTrustee2Sign;
    //	NSString *isGuardianSign;
    //	NSString *DateGuardianSign;
    //	NSString *isWitnessSign;
    //	NSString *DateWitnessSign;
    //	NSString *isCardHolderSign;
    //	NSString *DateCardHolderSign;
    //	NSString *isManagerSign;
    //	NSString *DateManagerSign;
    //	NSString *isIntermediarySign;
    //	NSString *DateIntermediarySign;
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsPath = [paths objectAtIndex:0];
	NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
	
	FMDatabase *db = [FMDatabase databaseWithPath:path];
	[db open];
	
	FMResultSet *results;
	results = nil;
	results = [db executeQuery:@"select * from eProposal_Signature where eProposalNo = ?", proposalNumber, Nil];
	
	hasData = NO;
	while ([results next]) {
		hasData = YES;
		isCustSign = [results stringForColumn:@"isCustSign"] != NULL ? [results stringForColumn:@"isCustSign"] : @"";
		DateCustSign = [results stringForColumn:@"DateCustSign"] != NULL ? [results stringForColumn:@"DateCustSign"] : @"";
		isPOSign = [results stringForColumn:@"isPOSign"] != NULL ? [results stringForColumn:@"isPOSign"] : @"";
		DatePOSign = [results stringForColumn:@"DatePOSign"] != NULL ? [results stringForColumn:@"DatePOSign"] : @"";
		isLASign = [results stringForColumn:@"isLASign"] != NULL ? [results stringForColumn:@"isLASign"] : @"";
		DateLASign = [results stringForColumn:@"DateLASign"] != NULL ? [results stringForColumn:@"DateLASign"] : @"";
		isLA2Sign = [results stringForColumn:@"isLA2Sign"] != NULL ? [results stringForColumn:@"isLA2Sign"] : @"";
		DateLA2Sign = [results stringForColumn:@"DateLA2Sign"] != NULL ? [results stringForColumn:@"DateLA2Sign"] : @"";
		isCOSign = [results stringForColumn:@"isCOSign"] != NULL ? [results stringForColumn:@"isCOSign"] : @"";
		DateCOSign = [results stringForColumn:@"DateCOSign"] != NULL ? [results stringForColumn:@"DateCOSign"] : @"";
		isTrusteeSign = [results stringForColumn:@"isTrusteeSign"] != NULL ? [results stringForColumn:@"isTrusteeSign"] : @"";
		DateTrusteeSign = [results stringForColumn:@"DateTrusteeSign"] != NULL ? [results stringForColumn:@"DateTrusteeSign"] : @"";
		isTrustee2Sign = [results stringForColumn:@"isTrustee2Sign"] != NULL ? [results stringForColumn:@"isTrustee2Sign"] : @"";
		DateTrustee2Sign = [results stringForColumn:@"DateTrustee2Sign"] != NULL ? [results stringForColumn:@"DateTrustee2Sign"] : @"";
		isGuardianSign = [results stringForColumn:@"isGuardianSign"] != NULL ? [results stringForColumn:@"isGuardianSign"] : @"";
		DateGuardianSign = [results stringForColumn:@"DateGuardianSign"] != NULL ? [results stringForColumn:@"DateGuardianSign"] : @"";
		isWitnessSign = [results stringForColumn:@"isWitnessSign"] != NULL ? [results stringForColumn:@"isWitnessSign"] : @"";
		DateWitnessSign = [results stringForColumn:@"DateWitnessSign"] != NULL ? [results stringForColumn:@"DateWitnessSign"] : @"";
		isCardHolderSign = [results stringForColumn:@"isCardHolderSign"] != NULL ? [results stringForColumn:@"isCardHolderSign"] : @"";
		DateCardHolderSign = [results stringForColumn:@"DateCardHolderSign"] != NULL ? [results stringForColumn:@"DateCardHolderSign"] : @"";
		isManagerSign = [results stringForColumn:@"isManagerSign"] != NULL ? [results stringForColumn:@"isManagerSign"] : @"";
		DateManagerSign = [results stringForColumn:@"DateManagerSign"] != NULL ? [results stringForColumn:@"DateManagerSign"] : @"";
		isIntermediarySign = [results stringForColumn:@"isIntermediarySign"] != NULL ? [results stringForColumn:@"isIntermediarySign"] : @"";
		DateIntermediarySign = [results stringForColumn:@"DateIntermediarySign"] != NULL ? [results stringForColumn:@"DateIntermediarySign"] : @"";
		SignAt = [results stringForColumn:@"SignAt"] != NULL ? [results stringForColumn:@"SignAt"] : @"";
	}
	
	//check if not update
	
	if (!hasData) {
		[db executeUpdate:@"INSERT INTO eProposal_Signature (eProposalNo) VALUES(?);" ,proposalNumber, Nil];
	}
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *currDate = [NSDate date];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
	
	BOOL cust = FALSE;
	BOOL PO = FALSE;
	BOOL LA = FALSE;
	BOOL LA2 = FALSE;
	BOOL CO = FALSE;
	BOOL Trustee1 = FALSE;
	BOOL Trustee2 = FALSE;
	BOOL Guardian = FALSE;
	BOOL Witness = FALSE;
	BOOL Agent = FALSE;
	BOOL CardHolder = FALSE;
	BOOL Manager = FALSE;
	
	for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
		if ([key isEqualToString:kCustomerSign]) {
			if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
				cust = TRUE;
			}
		}
		else if ([key isEqualToString:kPOSign]) {
			if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
				PO = TRUE;
			}
		}
		else if ([key isEqualToString:kLASign]) {
			if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
				LA = TRUE;
			}
		}
		else if ([key isEqualToString:kLA2Sign]) {
			if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
				LA2 = TRUE;
			}
		}
		else if ([key isEqualToString:kCOSign]) {
			if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
				CO = TRUE;
			}
		}
		else if ([key isEqualToString:k1stTrusteeSign]) {
			if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
				Trustee1 = TRUE;
			}
		}
		else if ([key isEqualToString:k2ndTrusteeSign]) {
			if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
				Trustee2 = TRUE;
			}
		}
		else if ([key isEqualToString:kGardianSign]) {
			if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
				Guardian = TRUE;
			}
		}
		else if ([key isEqualToString:kWitnessSign]) {
			if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
				Witness = TRUE;
			}
		}
		else if ([key isEqualToString:kCardHolderSign]) {
			if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
				CardHolder = TRUE;
			}
		}
		else if ([key isEqualToString:kAgentSign]) {
			if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
				Agent = TRUE;
			}
		}
		else if ([key isEqualToString:kmanagerName]) {
			if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
				Manager = TRUE;
			}
		}
	}
	
	if(!cFFSignatureRequired && (([isCustSign isEqualToString:@""] || (NSNull *) isCustSign == [NSNull null]) || isCustSign == nil) && cust){
		[db executeUpdate:@"Update eProposal_Signature set isCustSign = 'YES', DateCustSign = ? where eProposalNo = ?;" ,dateString, proposalNumber, Nil];
        NSString *queryB = @"";
        queryB = [NSString stringWithFormat:@"UPDATE eApp_Listing SET DateUpdated = '%@' WHERE ProposalNo = '%@'", dateString, proposalNumber];
        [db executeUpdate:queryB];
    }
	if((([isPOSign isEqualToString:@""] || (NSNull *) isPOSign == [NSNull null]) || isPOSign == nil) && PO){
		[db executeUpdate:@"Update eProposal_Signature set isPOSign = 'YES', DatePOSign = ? where eProposalNo = ?;" ,dateString, proposalNumber, Nil];
        NSString *queryB = @"";
        queryB = [NSString stringWithFormat:@"UPDATE eApp_Listing SET DateUpdated = '%@' WHERE ProposalNo = '%@'", dateString, proposalNumber];
        [db executeUpdate:queryB];
    }
	
	if((([isLASign isEqualToString:@""] || (NSNull *) isLASign == [NSNull null]) || isLASign == nil) && LA){
		[db executeUpdate:@"Update eProposal_Signature set isLASign = 'YES', DateLASign = ? where eProposalNo = ?;" ,dateString, proposalNumber, Nil];
        NSString *queryB = @"";
        queryB = [NSString stringWithFormat:@"UPDATE eApp_Listing SET DateUpdated = '%@' WHERE ProposalNo = '%@'", dateString, proposalNumber];
        [db executeUpdate:queryB];
    }
	if((([isLA2Sign isEqualToString:@""] || (NSNull *) isLA2Sign == [NSNull null]) || isLA2Sign == nil) && LA2){
		[db executeUpdate:@"Update eProposal_Signature set isLA2Sign = 'YES', DateLA2Sign = ? where eProposalNo = ?;" ,dateString, proposalNumber, Nil];
        NSString *queryB = @"";
        queryB = [NSString stringWithFormat:@"UPDATE eApp_Listing SET DateUpdated = '%@' WHERE ProposalNo = '%@'", dateString, proposalNumber];
        [db executeUpdate:queryB];
    }
	if((([isCOSign isEqualToString:@""] || (NSNull *) isCOSign == [NSNull null]) || isCOSign == nil) && CO){
		[db executeUpdate:@"Update eProposal_Signature set isCOSign = 'YES', DateCOSign = ? where eProposalNo = ?;" ,dateString, proposalNumber, Nil];
        NSString *queryB = @"";
        queryB = [NSString stringWithFormat:@"UPDATE eApp_Listing SET DateUpdated = '%@' WHERE ProposalNo = '%@'", dateString, proposalNumber];
        [db executeUpdate:queryB];
    }
	if((([isTrusteeSign isEqualToString:@""] || (NSNull *) isTrusteeSign == [NSNull null]) || isTrusteeSign == nil) && Trustee1){
		[db executeUpdate:@"Update eProposal_Signature set isTrusteeSign = 'YES', DateTrusteeSign = ? where eProposalNo = ?;" ,dateString, proposalNumber, Nil];
        NSString *queryB = @"";
        queryB = [NSString stringWithFormat:@"UPDATE eApp_Listing SET DateUpdated = '%@' WHERE ProposalNo = '%@'", dateString, proposalNumber];
        [db executeUpdate:queryB];
    }
	if((([isTrustee2Sign isEqualToString:@""] || (NSNull *) isTrustee2Sign == [NSNull null]) || isTrustee2Sign == nil) && Trustee2){
		[db executeUpdate:@"Update eProposal_Signature set isTrustee2Sign = 'YES', DateTrustee2Sign = ? where eProposalNo = ?;" ,dateString, proposalNumber, Nil];
        NSString *queryB = @"";
        queryB = [NSString stringWithFormat:@"UPDATE eApp_Listing SET DateUpdated = '%@' WHERE ProposalNo = '%@'", dateString, proposalNumber];
        [db executeUpdate:queryB];
    }
	if((([isGuardianSign isEqualToString:@""] || (NSNull *) isGuardianSign == [NSNull null]) || isGuardianSign == nil) && Guardian){
		[db executeUpdate:@"Update eProposal_Signature set isGuardianSign = 'YES', DateGuardianSign = ? where eProposalNo = ?;" ,dateString, proposalNumber, Nil];
        NSString *queryB = @"";
        queryB = [NSString stringWithFormat:@"UPDATE eApp_Listing SET DateUpdated = '%@' WHERE ProposalNo = '%@'", dateString, proposalNumber];
        [db executeUpdate:queryB];
    }
	if((([isCardHolderSign isEqualToString:@""] || (NSNull *) isCardHolderSign == [NSNull null]) || isCardHolderSign == nil) && CardHolder){
		[db executeUpdate:@"Update eProposal_Signature set isCardHolderSign = 'YES', DateCardHolderSign = ? where eProposalNo = ?;" ,dateString, proposalNumber, Nil];
        NSString *queryB = @"";
        queryB = [NSString stringWithFormat:@"UPDATE eApp_Listing SET DateUpdated = '%@' WHERE ProposalNo = '%@'", dateString, proposalNumber];
        [db executeUpdate:queryB];
    }
	if((([isManagerSign isEqualToString:@""] || (NSNull *) isManagerSign == [NSNull null]) || isManagerSign == nil) && Manager){
		[db executeUpdate:@"Update eProposal_Signature set isManagerSign = 'YES', DateManagerSign = ? where eProposalNo = ?;" ,dateString, proposalNumber, Nil];
        NSString *queryB = @"";
        queryB = [NSString stringWithFormat:@"UPDATE eApp_Listing SET DateUpdated = '%@' WHERE ProposalNo = '%@'", dateString, proposalNumber];
        [db executeUpdate:queryB];
    }
	if((([isWitnessSign isEqualToString:@""] || (NSNull *) isWitnessSign == [NSNull null]) || isWitnessSign == nil) && Witness){
		[db executeUpdate:@"Update eProposal_Signature set isWitnessSign = 'YES', DateWitnessSign = ? where eProposalNo = ?;" ,dateString, proposalNumber, Nil];
        NSString *queryB = @"";
        queryB = [NSString stringWithFormat:@"UPDATE eApp_Listing SET DateUpdated = '%@' WHERE ProposalNo = '%@'", dateString, proposalNumber];
        [db executeUpdate:queryB];
    }
	if((([isIntermediarySign isEqualToString:@""] || (NSNull *) isIntermediarySign == [NSNull null]) || isIntermediarySign == nil) && Agent){
		[db executeUpdate:@"Update eProposal_Signature set isIntermediarySign = 'YES', DateIntermediarySign = ? where eProposalNo = ?;" ,dateString, proposalNumber, Nil];
        NSString *queryB = @"";
        queryB = [NSString stringWithFormat:@"UPDATE eApp_Listing SET DateUpdated = '%@' WHERE ProposalNo = '%@'", dateString, proposalNumber];
        [db executeUpdate:queryB];
    }
	if (([SignAt isEqualToString:@""] || (NSNull *) SignAt == [NSNull null]) || SignAt == nil) {
		[db executeUpdate:@"Update eProposal_Signature set SignAt = ? where eProposalNo = ?;" , SignAtTextField, proposalNumber, Nil];
	}
	
//    [self SaveUpdate];
	
	results = nil;
    //	[db close];
}

-(void)LoadDB {
	
	hasData = NO; //set default
    //	NSString *isPOSign;
    //	NSString *DatePOSign;
    //	NSString *isLASign;
    //	NSString *DateLASign;
    //	NSString *isLA2Sign;
    //	NSString *DateLA2Sign;
    //	NSString *isCOSign;
    //	NSString *DateCOSign;
    //	NSString *isTrusteeSign;
    //	NSString *DateTrusteeSign;
    //	NSString *isTrustee2Sign;
    //	NSString *DateTrustee2Sign;
    //	NSString *isGuardianSign;
    //	NSString *DateGuardianSign;
    //	NSString *isWitnessSign;
    //	NSString *DateWitnessSign;
    //	NSString *isCardHolderSign;
    //	NSString *DateCardHolderSign;
    //	NSString *isManagerSign;
    //	NSString *DateManagerSign;
    //	NSString *isIntermediarySign;
    //	NSString *DateIntermediarySign;
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsPath = [paths objectAtIndex:0];
	NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
	
	FMDatabase *db = [FMDatabase databaseWithPath:path];
	[db open];
	
	FMResultSet *results;
	results = nil;
	results = [db executeQuery:@"select * from eProposal_Signature where eProposalNo = ?", proposalNumber, Nil];
	
	while ([results next]) {
		hasData = YES;
		isCustSign = [results stringForColumn:@"isCustSign"] != NULL ? [results stringForColumn:@"isCustSign"] : @"";
		DateCustSign = [results stringForColumn:@"DateCustSign"] != NULL ? [results stringForColumn:@"DateCustSign"] : @"";
		isPOSign = [results stringForColumn:@"isPOSign"] != NULL ? [results stringForColumn:@"isPOSign"] : @"";
		DatePOSign = [results stringForColumn:@"DatePOSign"] != NULL ? [results stringForColumn:@"DatePOSign"] : @"";
		isLASign = [results stringForColumn:@"isLASign"] != NULL ? [results stringForColumn:@"isLASign"] : @"";
		DateLASign = [results stringForColumn:@"DateLASign"] != NULL ? [results stringForColumn:@"DateLASign"] : @"";
		isLA2Sign = [results stringForColumn:@"isLA2Sign"] != NULL ? [results stringForColumn:@"isLA2Sign"] : @"";
		DateLA2Sign = [results stringForColumn:@"DateLA2Sign"] != NULL ? [results stringForColumn:@"DateLA2Sign"] : @"";
		isCOSign = [results stringForColumn:@"isCOSign"] != NULL ? [results stringForColumn:@"isCOSign"] : @"";
		DateCOSign = [results stringForColumn:@"DateCOSign"] != NULL ? [results stringForColumn:@"DateCOSign"] : @"";
		isTrusteeSign = [results stringForColumn:@"isTrusteeSign"] != NULL ? [results stringForColumn:@"isTrusteeSign"] : @"";
		DateTrusteeSign = [results stringForColumn:@"DateTrusteeSign"] != NULL ? [results stringForColumn:@"DateTrusteeSign"] : @"";
		isTrustee2Sign = [results stringForColumn:@"isTrustee2Sign"] != NULL ? [results stringForColumn:@"isTrustee2Sign"] : @"";
		DateTrustee2Sign = [results stringForColumn:@"DateTrustee2Sign"] != NULL ? [results stringForColumn:@"DateTrustee2Sign"] : @"";
		isGuardianSign = [results stringForColumn:@"isGuardianSign"] != NULL ? [results stringForColumn:@"isGuardianSign"] : @"";
		DateGuardianSign = [results stringForColumn:@"DateGuardianSign"] != NULL ? [results stringForColumn:@"DateGuardianSign"] : @"";
		isWitnessSign = [results stringForColumn:@"isWitnessSign"] != NULL ? [results stringForColumn:@"isWitnessSign"] : @"";
		DateWitnessSign = [results stringForColumn:@"DateWitnessSign"] != NULL ? [results stringForColumn:@"DateWitnessSign"] : @"";
		isCardHolderSign = [results stringForColumn:@"isCardHolderSign"] != NULL ? [results stringForColumn:@"isCardHolderSign"] : @"";
		DateCardHolderSign = [results stringForColumn:@"DateCardHolderSign"] != NULL ? [results stringForColumn:@"DateCardHolderSign"] : @"";
		isManagerSign = [results stringForColumn:@"isManagerSign"] != NULL ? [results stringForColumn:@"isManagerSign"] : @"";
		DateManagerSign = [results stringForColumn:@"DateManagerSign"] != NULL ? [results stringForColumn:@"DateManagerSign"] : @"";
		isIntermediarySign = [results stringForColumn:@"isIntermediarySign"] != NULL ? [results stringForColumn:@"isIntermediarySign"] : @"";
		DateIntermediarySign = [results stringForColumn:@"DateIntermediarySign"] != NULL ? [results stringForColumn:@"DateIntermediarySign"] : @"";
		SignAt = [results stringForColumn:@"SignAt"] != NULL ? [results stringForColumn:@"SignAt"] : @"";
	}
    //	[db close];
}


#pragma mark - AlertView Delegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 1234) {
        if (buttonIndex==0)
        {
            
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            HUD.labelText = @"Please Wait";
            [HUD show:YES];
            
            //[self saveSignature];
            NSLog(@"testingME");
            selectedTag=0;
            //			NSLog(@"row: %d", currentIndexPath.row);
            //			[self addSignatureFrame:currentIndexPath.row];
            //			[_tableView reloadData];
			
			cFFSignatureRequired = FALSE;
            
            
        }
        else
        {
            //[_overlayView removeFromSuperview];
            selectedTag=1;
        }
        isExcecution=YES;
        //		[self addSignatureFrame:];
        
    }
    if (alertView.tag == 2000) {
        if (buttonIndex==1) {
            setValueToField(@"  X", kno15AcknowledgeEng);
            setValueToField(@"  X", kno15AcknowledgeMalay);
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            HUD.labelText = @"Please Wait";
            [HUD show:YES];
            [self performSelector:@selector(showSignatureCollectorView) withObject:nil afterDelay:1];
            //            [self showSignatureCollectorView];
        }
    }
    if (alertView.tag == 20009) {
		HUD = [[MBProgressHUD alloc] initWithView:self.view];
		[self.view addSubview:HUD];
		HUD.labelText = @"Please Wait";
		[HUD show:YES];
		
        [self showSignatureCollectorView];
    }
    if (alertView.tag == 200099) {
        [self showSignatureCollectorViewforPO];
    }
    if(alertView.tag==12000)
    {
        _navC.view.hidden=NO;
        
        [delegate refresheSigndata];
        // [delegate RefreshInformationData];
		[self SaveToDB];
		
    }
    
    if (alertView.tag ==1000) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        NSString *convertUpperCase = [textField.text uppercaseString];
		
		if  ((NSNull *) SignAt == [NSNull null])
            SignAt = @"";
		
		if (![SignAt isEqualToString:@""] && SignAt != nil){
			textField.text = SignAt;
		}
		
		NSLog(@"%@", textField.text);
        if ([textField.text length]) {
            //			SignAtTextField = textField.text;
            setValueToField(convertUpperCase, ksignedAt);
			SignAtTextField = convertUpperCase;
            SignAt = convertUpperCase;
            
            setValueToField(_eApplicationGenerator.gardianName, kGardian);
            setValueToField(_eApplicationGenerator.gardianICNo, kGardianICNO);
            
            if(_eApplicationGenerator.intermediaryManagerName.length==0){
                setValueToField(@"", kintermediaryName);
            }
            [self injectSignDateAndLocationAfterSign];
            saveField();
            [self saveToXML];
            [HUD hide:YES afterDelay:1];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"All signatures have been saved successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            alert.tag=12000;
            [alert show];
            [self refreshPDFData];
            
            //Reload the PDF Viewer with the new Signed PDF
            
            //[self.view removeFromSuperview];
            //_navC.view.hidden=NO;
            appobject=(AppDelegate *)[[UIApplication sharedApplication]delegate];
            
            /// appObj.checkList=YES;
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"CompareSign"])
            {
                NSMutableArray *array=[[[NSUserDefaults standardUserDefaults] objectForKey:@"CompareSign"] mutableCopy];
                if (![array containsObject:appobject.eappProposal])
                {
                    [array addObject:appobject.eappProposal];
                }
                [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"CompareSign"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            else{
                NSMutableArray *array=[[NSMutableArray alloc] init];
                [array addObject:appobject.eappProposal];
                [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"CompareSign"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            [delegate refresheSigndata];
            //  [delegate RefreshInformationData];
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please key in the place." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
        
        
        
    }
    
}
#pragma mark -
#pragma mark - UITABLEVIEW DELEGATE & DATASOURCE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _signArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor  = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SnapCustomCell *cell = (SnapCustomCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects;
        
        topLevelObjects= [[NSBundle mainBundle] loadNibNamed:@"SnapCustomCell" owner:self options:nil];
        
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        
        cell = [topLevelObjects objectAtIndex:0];
        
    }
    
    
    NSDictionary *dic = [_signArr objectAtIndex:indexPath.row];
    
    BOOL isRequired = NO;
	BOOL isCHreq = NO;
	BOOL isCOreq = NO;
	BOOL isT1req = NO;
	BOOL isT2req = NO;
	BOOL isGdianreq = NO;
	
    for (id obj in _requiredArr) {
        if ([obj intValue]==indexPath.row) {
            isRequired=YES;
        }
    }
	//For easier checking
	for (id obj in _requiredArr) {
		if ([obj intValue]==4) {
			isCOreq = YES;
        }
		if ([obj intValue]==5) {
			isT1req = YES;
        }
		if ([obj intValue]==6) {
			isT2req = YES;
        }
		if ([obj intValue]==7) {
			isGdianreq = YES;
        }
		if ([obj intValue]==11) {
			isCHreq = YES;
        }
	}
	
	
    if (isRequired) {
        cell.userInteractionEnabled=YES;
        cell.rowTitle.enabled = YES;
    }
    else
    {
        cell.userInteractionEnabled=NO;
        cell.rowTitle.enabled = NO;
        
    }
    cell.rowTitle.text =[dic objectForKey:@"rowTitlw"];
    cell.rowTitle.textColor = [UIColor whiteColor];
    cell.rowTitle.backgroundColor = [UIColor clearColor];
    NSString *birthDate = _eApplicationGenerator.lADOB;
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:birthDate]];
    int allDays = (((time/60)/60)/24);
    int days = allDays%365;
    int years = (allDays-days)/365;
    //    NSLog(@"You live since %i years and %i days - %i",years,days,allDays);
    
    NSString *yourAge = [NSString stringWithFormat:@"%d",years];
    int Myage = [yourAge intValue];
    NSDate *currDate = [NSDate date];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    
    //NSInteger i = [years integerValue];
    // NSInteger *yourage =[years integerValue];
    cell.ticked.hidden = YES;
    NSDictionary *proposalHistory = GetProposalObject(proposalNumber);
    NSString*  str;
    BOOL customerSigned = [[proposalHistory objectForKey:kCustomerSign]boolValue];
    cFFSignatureRequired=!customerSigned;
    switch (indexPath.row) {
        case 0:
        {
            cell.ticked.hidden = ![[proposalHistory objectForKey:kCustomerSign]boolValue];
            if (isRequired && isCustomerSelected) {
                issigned=YES;
                SetSigNameObject(kCustomerSign);
                //str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.lAN ame];
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],customerName,IDNumber];
                SetSignerName(str);
                currentSigner = customerName;
                currentSignerIDNumber = IDNumber;
                Signer_type = @"Customer";
                [self render];
                [self addSignatureFrame:indexPath.row];
                //[self injectSignDateAndLocation];
                
                if(!cFFSignatureRequired){
					if (([isCustSign isEqualToString:@""] || (NSNull *) isCustSign == [NSNull null]) || isCustSign == nil) {
						setValueToField(dateString, kdate1);
					}
					else
						setValueToField(DateCustSign, kdate1);
                    
                }
                
            }
            
        }
            break;
        case 1:{
            
            
            cell.ticked.hidden = ![[proposalHistory objectForKey:kLASign]boolValue];
            if (isRequired && !isCustomerSelected) {
                issigned=YES;
                SetSigNameObject(kLASign);
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.lAName,_eApplicationGenerator.lAICNO];
                //                str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.lAName;
                currentSignerIDNumber = _eApplicationGenerator.lAICNO;
                Signer_type = @"LA1";
                [self render];
                [self addSignatureFrame:indexPath.row];
                //[self injectSignDateAndLocation];
            }
            //}
        }
            break;
            //        case 2:
            //        {
            //            cell.ticked.hidden = ![[proposalHistory objectForKey:kLA2Sign]boolValue];
            //            if (isRequired && !isCustomerSelected) {
            //                issigned=YES;
            //                SetSigNameObject(kLA2Sign);
            //                str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.secondLAName];
            ////                str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
            //                SetSignerName(str);
            //                currentSigner = _eApplicationGenerator.secondLAName;
            //                Signer_type = @"LA2";
            //                [self render];
            //                [self addSignatureFrame:indexPath.row];
            //                [self injectSignDateAndLocation];
            //            }
            //        }
            //            break;
        case 3:
        {
            cell.ticked.hidden = ![[proposalHistory objectForKey:kPOSign]boolValue];
            if (isRequired && !isCustomerSelected) {
                issigned=YES;
                SetSigNameObject(kPOSign);
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.policyOwnerNamel,_eApplicationGenerator.policyOwnerICNO];
                //                str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.policyOwnerNamel;
                currentSignerIDNumber = _eApplicationGenerator.policyOwnerICNO;
                Signer_type = @"PO";
                [self render];
                [self addSignatureFrame:indexPath.row];
                //[self injectSignDateAndLocation];
            }
            
        }
            break;
        case 4:
        {
            cell.ticked.hidden = ![[proposalHistory objectForKey:kCOSign]boolValue];
            if (isRequired && customerSigned) {
                issigned=YES;
                SetSigNameObject(kCOSign);
                //str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.cOName];
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],@"",_eApplicationGenerator.cOICNo];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.cOName;
                currentSignerIDNumber = _eApplicationGenerator.cOICNo;
                Signer_type = @"CO";
                [self render];
                [self addSignatureFrame:indexPath.row];
                
                //[self injectSignDateAndLocation];
            }
        }
            break;
        case 5:
        {
            cell.ticked.hidden = ![[proposalHistory objectForKey:k1stTrusteeSign]boolValue];
            if (isRequired && customerSigned) {
                issigned=YES;
                SetSigNameObject(k1stTrusteeSign);
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.trusteeName,_eApplicationGenerator.TrusteeIDNumber];
                //                str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.trusteeName;
                currentSignerIDNumber = _eApplicationGenerator.TrusteeIDNumber;
                Signer_type = @"Trustee1";
                [self render];
                [self addSignatureFrame:indexPath.row];
                //[self injectSignDateAndLocation];
            }
        }
            break;
        case 6:
        {
            cell.ticked.hidden = ![[proposalHistory objectForKey:k2ndTrusteeSign]boolValue];
            if (isRequired && customerSigned) {
                issigned=YES;
                SetSigNameObject(k2ndTrusteeSign);
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.secondTrusteeName,_eApplicationGenerator.SecondTrusteeIDNumber];
                //                str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.secondTrusteeName;
                currentSignerIDNumber = _eApplicationGenerator.SecondTrusteeIDNumber;
                Signer_type = @"Trustee2";
                [self render];
                [self addSignatureFrame:indexPath.row];
                //[self injectSignDateAndLocation];
            }
            
        }
            break;
        case 7:
        {
            cell.ticked.hidden = ![[proposalHistory objectForKey:kGardianSign]boolValue];
            if (isRequired && customerSigned) {
                issigned=YES;
                SetSigNameObject(kGardianSign);
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.gardianName,_eApplicationGenerator.gardianICNo];
                //                str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.gardianName;
                currentSignerIDNumber = _eApplicationGenerator.gardianICNo;
                Signer_type = @"Parent";
                [self render];
                [self addSignatureFrame:indexPath.row];
                //[self injectSignDateAndLocation];
            }
        }
            break;
        case 8:
        {
            cell.ticked.hidden = ![[proposalHistory objectForKey:kWitnessSign]boolValue];
            if (isRequired && !isCustomerSelected) {
                //                issigned=YES;
                //                SetSigNameObject(kWitnessSign);
                //                // str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.intermediaryName];
                //                str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                //                SetSignerName(str);
                //                currentSigner = _eApplicationGenerator.intermediaryName;
                //                Signer_type = @"Witness";
                //                [self render];
                //                [self addSignatureFrame:indexPath.row];
                //                [self injectSignDateAndLocation];
                
                issigned=YES;
                BOOL isReady=YES;
                
				if (Myage < 16) {
					for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
						if ([key isEqualToString:kPOSign]) {
							if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
								isReady = NO;
							}
						}
						if ([key isEqualToString:kCardHolderSign] && isCHreq) {
							if (![[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
								isReady = NO;
							}
						}
						if ([key isEqualToString:kCOSign] && isCOreq) {
							if (![[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
								isReady = NO;
							}
						}
						if ([key isEqualToString:k1stTrusteeSign] && isT1req) {
							if (![[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
								isReady = NO;
							}
						}
						if ([key isEqualToString:k2ndTrusteeSign] && isT2req) {
							if (![[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
								isReady = NO;
							}
						}
						if ([key isEqualToString:kGardianSign] && isGdianreq) {
							if (![[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
								isReady = NO;
							}
						}
						
					}
				}
				
                for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
                    if(Myage<16 && CheckRelationship){
                        if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kLA2Sign] && ![key isEqualToString:kWitnessSign] && ![key isEqualToString:kLASign] && ![key isEqualToString:kManagerSign]) {
                            if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                                isReady = NO;
                                
                            }
                        }
                    }
                    else if(Myage<16 && !CheckRelationship){
                        if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kLA2Sign] && ![key isEqualToString:kWitnessSign] && ![key isEqualToString:kManagerSign]) {
                            if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                                isReady = NO;
                                
                            }
                        }
                    }
                    else if(Myage>15){
                        
                        if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kManagerSign] &&  ![key isEqualToString:kCustomerSign] && ![key isEqualToString:kWitnessSign] && ![key isEqualToString:kManagerSign]) {
                            if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                                isReady = NO;
                                
                            }
                        }
						
                    }
                }
				
				
				
                
                if (isReady) {
                    SetSigNameObject(kWitnessSign);
                    str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.intermediaryName,_eApplicationGenerator.intermediaryNICNo];
                    //                    str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                    SetSignerName(str);
                    currentSigner = _eApplicationGenerator.intermediaryName;
                    currentSignerIDNumber = _eApplicationGenerator.intermediaryNICNo;
                    Signer_type = @"Witness";
                    [self render];
                    [self addSignatureFrame:indexPath.row];
                    //[self injectSignDateAndLocation];
                }
            }
        }
            break;
        case 9:
        {
            cell.ticked.hidden = ![[proposalHistory objectForKey:kAgentSign]boolValue];
            if (isRequired) {
                issigned=YES;
                BOOL isReady=YES;
                
                for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
                    if(Myage<16 && CheckRelationship){
                        if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kLA2Sign] && ![key isEqualToString:kManagerSign] && ![key isEqualToString:kLASign]) {
                            if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                                isReady = NO;
                                
                            }
                        }
                    }
                    else if(Myage<16 && !CheckRelationship){
                        if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kLA2Sign] && ![key isEqualToString:kManagerSign]) {
                            if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                                isReady = NO;
                                
                            }
                        }
                    }
                    else if(Myage>15){
                        
                        if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kManagerSign]) {
                            if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                                isReady = NO;
                                
                            }
                        }
                    }
                }
				
				for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
					if ([key isEqualToString:kPOSign]) {
						if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
							isReady = NO;
						}
					}
					if ([key isEqualToString:kCardHolderSign] && isCHreq) {
						if (![[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
							isReady = NO;
						}
					}
					if ([key isEqualToString:kCOSign] && isCOreq) {
						if (![[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
							isReady = NO;
						}
					}
					if ([key isEqualToString:k1stTrusteeSign] && isT1req) {
						if (![[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
							isReady = NO;
						}
					}
					if ([key isEqualToString:k2ndTrusteeSign] && isT2req) {
						if (![[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
							isReady = NO;
						}
					}
					if ([key isEqualToString:kGardianSign] && isGdianreq) {
						if (![[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==YES) {
							isReady = NO;
						}
					}
					
				}
                
                if (isReady) {
                    SetSigNameObject(kAgentSign);
                    str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.intermediaryName,_eApplicationGenerator.intermediaryNICNo];
                    //str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                    SetSignerName(str);
                    currentSigner = _eApplicationGenerator.intermediaryName;
                    currentSignerIDNumber = _eApplicationGenerator.intermediaryNICNo;
                    Signer_type = @"Witness";
                    [self render];
                    [self addSignatureFrame:indexPath.row];
                    //[self injectSignDateAndLocation];
                }
            }
        }
            
            break;
        case 10:
        {
            
            cell.ticked.hidden = ![[proposalHistory objectForKey:kManagerSign]boolValue];
            if (isRequired) {
                BOOL isReady=YES;
                issigned=YES;
                for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
                    if (Myage > 15) {
                        if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kManagerSign] && ![key isEqualToString:kWitnessSign]) {
                            if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                                isReady = NO;
                                
                            }
                        }
                    }
                    else {
                        if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kManagerSign] && ![key isEqualToString:kWitnessSign] && ![key isEqualToString:kLASign]) {
                            if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                                isReady = NO;
                                
                            }
                        }
                    }
                }
                if (isReady) {
                    SetSigNameObject(kManagerSign);
                    //str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.intermediaryManagerName];
                    // str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                    str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.intermediaryManagerName,_eApplicationGenerator.intermediaryManagerIDNumber];
                    SetSignerName(str);
                    currentSigner = _eApplicationGenerator.intermediaryManagerName;
                    currentSignerIDNumber = _eApplicationGenerator.intermediaryManagerIDNumber;
                    Signer_type = @"Manager";
                    [self render];
                    [self addSignatureFrame:indexPath.row];
                    //[self injectSignDateAndLocation];
                }
            }
        }
            
            break;
            
        case 11:
        {
            cell.ticked.hidden = ![[proposalHistory objectForKey:kCardHolderSign]boolValue];
            if (isRequired && customerSigned) {
                issigned=YES;
                SetSigNameObject(kCardHolderSign);
                //str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.cardMemberName];
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],@"",_eApplicationGenerator.cardMemberNewICNoC];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.cardMemberNameC;
                currentSignerIDNumber = _eApplicationGenerator.cardMemberNewICNoC;
                Signer_type = @"Cardholder";
                [self render];
                [self addSignatureFrame:indexPath.row];
                //[self injectSignDateAndLocation];
                
            }
        }
            
            break;
            
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *currDate = [NSDate date];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    
    
    [self cleanSignatureFrames];
	
	currentIndexPath = indexPath;
    
    if (indexPath.row!=0 && cFFSignatureRequired && ToCheckAlert)
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Signature of Customer in Customer Fact Find is required in order to proceed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag = 20009;
        [alert show];
		alert = Nil;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                animated:NO                       scrollPosition:UITableViewScrollPositionTop];
        
    }
    NSString *str;
    BOOL isReady=YES;
    NSLog(@"Index Selected = %i",indexPath.row);
	
    if (((indexPath.row==1) || (indexPath.row==2) || (indexPath.row==3) || (indexPath.row==4) || (indexPath.row==5) || (indexPath.row==6) || (indexPath.row==7) || (indexPath.row==8) || (indexPath.row==11) )&& (!cFFSignatureRequired || ToCheckAlert==NO) ) {
        
        initTest();
        isCustomerSelected = NO;
        
        
    }
    else
    {
        isCustomerSelected = YES;
    }
    NSString *birthDate = _eApplicationGenerator.lADOB;
    NSDate *todayDate = [NSDate date];
    // NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:birthDate]];
    int allDays = (((time/60)/60)/24);
    int days = allDays%365;
    int years = (allDays-days)/365;
    //    NSLog(@"You live since %i years and %i days - %i",years,days,allDays);
    
    NSString *yourAge = [NSString stringWithFormat:@"%d",years];
    int Myage = [yourAge intValue];
    NSDictionary *proposalHistory = GetProposalObject(proposalNumber);
    switch (indexPath.row) {
        case 0:
            SetSigNameObject(kCustomerSign);
            str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],customerName,IDNumber];
            //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
            SetSignerName(str);
            currentSigner = customerName;
            currentSignerIDNumber = IDNumber;
            Signer_type = @"Customer";
            [self render];
			
            if(!cFFSignatureRequired){
				if (([isCustSign isEqualToString:@""] || (NSNull *) isCustSign == [NSNull null]) || isCustSign == nil) {
					setValueToField(dateString, kdate1);
				}
				else
                {
					setValueToField(DateCustSign, kdate1);
                }
                
                [self addSignatureFrame:indexPath.row];
                
            }
            // [self addSignatureFrame];
            break;
        case 1:
			SetSigNameObject(kLASign);
            str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.lAName,_eApplicationGenerator.lAICNO];
			//            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
            SetSignerName(str);
            currentSigner = _eApplicationGenerator.lAName;
            currentSignerIDNumber = _eApplicationGenerator.lAICNO;
            Signer_type = @"LA1";
            isLocked = [[proposalHistory objectForKey:kLASign]boolValue];
			
            for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
				if ([key isEqualToString:kPOSign]) {
					if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
						isReady = NO;
					}
                    
				}
				
                //                if(Myage<16){
                //                    if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kManagerSign] && ![key isEqualToString:kGardianSign] && ![key isEqualToString:kCardHolderSign] && ![key isEqualToString:kCOSign] && ![key isEqualToString:kLA2Sign] && ![key isEqualToString:kWitnessSign] && ![key isEqualToString:kLASign]) {
                //                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                //                            isReady = NO;
                //
                //                        }
                //                    }
                //                }
                //                else if(Myage>16){
                //
                //                    if (![key isEqualToString:kAgentSign]  && ![key isEqualToString:kCustomerSign]  && ![key isEqualToString:kManagerSign] && ![key isEqualToString:k1stTrusteeSign] && ![key isEqualToString:kCardHolderSign] && ![key isEqualToString:k2ndTrusteeSign] &&  ![key isEqualToString:kLASign] && ![key isEqualToString:kCOSign] && ![key isEqualToString:kWitnessSign]) {
                //                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                //                            isReady = NO;
                //
                //                        }
                //                    }
                //                }
                
                
            }
			
            if (isReady) {
				SetSigNameObject(kLASign);
				str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.lAName,_eApplicationGenerator.lAICNO];
				//            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
				SetSignerName(str);
				currentSigner = _eApplicationGenerator.lAName;
				currentSignerIDNumber = _eApplicationGenerator.lAICNO;
				Signer_type = @"LA1";
				[self render];
				// [self addSignatureFrame];
			}
			else if(!cFFSignatureRequired)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Signature of Policy Owner is required to proceed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                alert.tag = 200099;
                
                [alert show];
                
                _overlayView.hidden=YES;
            }
			[self addSignatureFrame:indexPath.row];
            break;
            //        case 2:
            //            SetSigNameObject(kLA2Sign);
            //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.secondLAName];
            ////            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
            //            SetSignerName(str);
            //            currentSigner = _eApplicationGenerator.secondLAName;
            //            Signer_type = @"LA2";
            //            [self render];
            //            //[self addSignatureFrame];
            //            break;
        case 3:
            SetSigNameObject(kPOSign);
            str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.policyOwnerNamel,_eApplicationGenerator.policyOwnerICNO];
            //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
            SetSignerName(str);
            currentSigner = _eApplicationGenerator.policyOwnerNamel;
            currentSignerIDNumber = _eApplicationGenerator.policyOwnerICNO;
            Signer_type = @"PO";
            [self render];
            //[self addSignatureFrame];
			//[self addSignatureFrame:indexPath.row];
            break;
            
        case 4:
            SetSigNameObject(kCOSign);
            str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.cOName,_eApplicationGenerator.cOICNo];
            //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
            SetSignerName(str);
            currentSigner = _eApplicationGenerator.cOName;
            currentSignerIDNumber = _eApplicationGenerator.cOICNo;
            Signer_type = @"CO";
            [self render];
            //[self addSignatureFrame];
            
			for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
				if ([key isEqualToString:kPOSign]) {
					if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
						isReady = NO;
					}
					
				}
			}
            //            for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
            //                if(Myage<16){
            //                    if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kManagerSign] && ![key isEqualToString:kCOSign] && ![key isEqualToString:kLA2Sign] && ![key isEqualToString:kWitnessSign] && ![key isEqualToString:kLASign]) {
            //                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
            //                            isReady = NO;
            //
            //                        }
            //                    }
            //                }
            //                else if(Myage>16){
            //
            //                    if (![key isEqualToString:kAgentSign]  && ![key isEqualToString:kCOSign] && ![key isEqualToString:kWitnessSign]) {
            //                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
            //                            isReady = NO;
            //
            //                        }
            //                    }
            //                }
            //
            //
            //            }
            if (isReady) {
                SetSigNameObject(kCOSign);
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.cOName,_eApplicationGenerator.cOICNo];
                //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.cOName;
                currentSignerIDNumber = _eApplicationGenerator.cOICNo;
                Signer_type = @"CO";
                [self render];
                //[self addSignatureFrame];
            }
            
            else if(!cFFSignatureRequired)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Signature of Policy Owner is required to proceed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                alert.tag = 200099;
                
                [alert show];
                
                _overlayView.hidden=YES;
            }
            
            //  [self addSignatureFrame:indexPath.row];
            
            break;
        case 5:
            SetSigNameObject(k1stTrusteeSign);
            str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.trusteeName,_eApplicationGenerator.TrusteeIDNumber];
            //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
            SetSignerName(str);
            currentSigner = _eApplicationGenerator.lAName;
            currentSignerIDNumber = _eApplicationGenerator.TrusteeIDNumber;
            Signer_type = @"Trustee1";
            [self render];
            //[self addSignatureFrame];
            for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
                if(Myage<16){
                    //                    if (![key isEqualToString:kAgentSign] && ![key isEqualToString:k1stTrusteeSign] && ![key isEqualToString:kLA2Sign] && ![key isEqualToString:kWitnessSign] && ![key isEqualToString:kLASign]) {
                    //                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                    //                            isReady = NO;
                    //
                    //                        }
                    //                    }
					if ([key isEqualToString:kPOSign]) {
                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                            isReady = NO;
                        }
                    }
                }
                else if(Myage>15){
                    
                    if (![key isEqualToString:kAgentSign]  && ![key isEqualToString:kManagerSign] && ![key isEqualToString:kCardHolderSign]  && ![key isEqualToString:k1stTrusteeSign] && ![key isEqualToString:k2ndTrusteeSign] && ![key isEqualToString:kWitnessSign]) {
                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                            isReady = NO;
                            
                        }
                    }
                }
                
                
            }
			for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
				if ([key isEqualToString:kPOSign]) {
					if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
						isReady = NO;
					}
					
				}
			}
            if (isReady) {
                SetSigNameObject(k1stTrusteeSign);
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.trusteeName,_eApplicationGenerator.TrusteeIDNumber];
                //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.trusteeName;
                currentSignerIDNumber = _eApplicationGenerator.TrusteeIDNumber;
                Signer_type = @"Trustee1";
                [self render];
            }
            
            else if(!cFFSignatureRequired)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Signature of Policy Owner is required to proceed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                alert.tag = 200099;
                
                [alert show];
                
                _overlayView.hidden=YES;
            }
            //			[self addSignatureFrame:indexPath.row];
            break;
        case 6:
            SetSigNameObject(k2ndTrusteeSign);
            str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.secondTrusteeName,_eApplicationGenerator.SecondTrusteeIDNumber];
            //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
            SetSignerName(str);
            currentSigner = _eApplicationGenerator.secondTrusteeName;
            currentSignerIDNumber = _eApplicationGenerator.SecondTrusteeIDNumber;
            Signer_type = @"Trustee2";
            [self render];
            //[self addSignatureFrame];
            for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
                if(Myage<16){
                    //                    if (![key isEqualToString:kAgentSign] && ![key isEqualToString:k2ndTrusteeSign] && ![key isEqualToString:kLA2Sign] && ![key isEqualToString:kWitnessSign] && ![key isEqualToString:kLASign]) {
                    //                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                    //                            isReady = NO;
                    //
                    //                        }
                    //                    }
					if ([key isEqualToString:kPOSign]) {
                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                            isReady = NO;
                        }
                    }
                }
                else if(Myage>15){
                    
                    if (![key isEqualToString:kAgentSign]  && ![key isEqualToString:kManagerSign]  && ![key isEqualToString:k2ndTrusteeSign] && ![key isEqualToString:k1stTrusteeSign]&& ![key isEqualToString:kWitnessSign]) {
                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                            isReady = NO;
                            
                        }
                    }
                }
                
                
            }
			for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
				if ([key isEqualToString:kPOSign]) {
					if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
						isReady = NO;
					}
					
				}
			}
            if (isReady) {
                SetSigNameObject(k2ndTrusteeSign);
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.secondTrusteeName,_eApplicationGenerator.SecondTrusteeIDNumber];
                //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.secondTrusteeName;
                currentSignerIDNumber = _eApplicationGenerator.SecondTrusteeIDNumber;
                Signer_type = @"Trustee2";
                [self render];
            }
            
            else if(!cFFSignatureRequired)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Signature of Policy Owner is required to proceed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                alert.tag = 200099;
                _overlayView.hidden=YES;
            }
            
            //		[self addSignatureFrame:indexPath.row];
            break;
        case 7:
            SetSigNameObject(kGardianSign);
            // str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.gardianName];
            str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.gardianName,_eApplicationGenerator.gardianICNo];
            //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
            SetSignerName(str);
            currentSigner = _eApplicationGenerator.gardianName;
            currentSignerIDNumber = _eApplicationGenerator.gardianICNo;
            
            Signer_type = @"Parent";
            [self render];
            //[self addSignatureFrame];
            for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
                if(Myage<16){
                    if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kCardHolderSign] && ![key isEqualToString:kManagerSign] && ![key isEqualToString:kGardianSign] && ![key isEqualToString:kLA2Sign] && ![key isEqualToString:kWitnessSign] && ![key isEqualToString:kLASign]) {
                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                            isReady = NO;
                            
                        }
                    }
                }
                else if(Myage>15){
                    
                    if (![key isEqualToString:kAgentSign]  && ![key isEqualToString:kManagerSign]  && ![key isEqualToString:k2ndTrusteeSign] && ![key isEqualToString:k1stTrusteeSign]&& ![key isEqualToString:kWitnessSign]) {
                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                            isReady = NO;
                            
                        }
                    }
                }
                
                
            }
			for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
				if ([key isEqualToString:kPOSign]) {
					if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
						isReady = NO;
					}
					
				}
			}
            if (isReady) {
                SetSigNameObject(kGardianSign);
                str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.gardianName];
                //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.gardianName;
                currentSignerIDNumber = _eApplicationGenerator.gardianICNo;
                Signer_type = @"Parent";
                isLocked = [[proposalHistory objectForKey:kGardianSign]boolValue];
                // [self render];
                //[self addSignatureFrame];
                
                _overlayView.hidden=NO;
            }
            
            else if(!cFFSignatureRequired)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Signature of Policy Owner is required to proceed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                alert.tag = 200099;
                
                [alert show];
                
                _overlayView.hidden=YES;
            }
            //		[self addSignatureFrame:indexPath.row];
            break;
        case 8:
            
            
            
            for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
                if(Myage<16){
                    if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kLA2Sign] && ![key isEqualToString:kWitnessSign] && ![key isEqualToString:kLASign] && ![key isEqualToString:kManagerSign]) {
                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                            isReady = NO;
                            
                        }
                    }
                }
                else if(Myage>15){
                    
                    if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kWitnessSign] && ![key isEqualToString:kManagerSign]) {
                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                            isReady = NO;
                            
                        }
                    }
                }
            }
			for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
				if ([key isEqualToString:kPOSign]) {
					if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
						isReady = NO;
					}
					
				}
			}
            
            if (isReady) {
                SetSigNameObject(kWitnessSign);
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.intermediaryName,_eApplicationGenerator.intermediaryNICNo];
                //                str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.intermediaryName;
                currentSignerIDNumber = _eApplicationGenerator.intermediaryNICNo;
                Signer_type = @"Witness";
                [self render];
                //[self addSignatureFrame];
            }
            else if(!cFFSignatureRequired)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"All the required parties should sign first before proceed with Signature of Intermediary/Agent/Witness." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
            }
            
            
            //            SetSigNameObject(kWitnessSign);
            //            // str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.intermediaryName];
            //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
            //            SetSignerName(str);
            //            currentSigner = _eApplicationGenerator.intermediaryName;
            //            Signer_type = @"Witness";
            //            [self render];
            //            //[self addSignatureFrame];
			//[self addSignatureFrame:indexPath.row];
            break;
        case 9:
            
            
            
            for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
                if(Myage<16){
                    if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kLA2Sign] && ![key isEqualToString:kManagerSign] && ![key isEqualToString:kLASign]) {
                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                            isReady = NO;
                            
                        }
                    }
                }
                else if(Myage>15){
                    
                    if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kManagerSign]) {
                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                            isReady = NO;
                            
                        }
                    }
                }
            }
            
			for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
				if ([key isEqualToString:kPOSign]) {
					if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
						isReady = NO;
					}
					
				}
			}
			
            if (isReady) {
                SetSigNameObject(kAgentSign);
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.intermediaryName,_eApplicationGenerator.intermediaryNICNo];
                //                str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.intermediaryName;
                currentSignerIDNumber = _eApplicationGenerator.intermediaryNICNo;
                Signer_type = @"Witness";
                [self render];
                //[self addSignatureFrame];
            }
            else if (!cFFSignatureRequired)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"All the required parties should sign first before proceed with Signature of Intermediary/Agent." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
            }
            //[self addSignatureFrame:indexPath.row];
            break;
        case 10:
            for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
                if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kManagerSign]) {
                    if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                        isReady = NO;
                        
                    }
                }
            }
            if (isReady) {
                SetSigNameObject(kManagerSign);
                // str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.intermediaryManagerName];
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.intermediaryManagerName,_eApplicationGenerator.intermediaryManagerIDNumber];
                //                str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.intermediaryManagerName;
                currentSignerIDNumber = _eApplicationGenerator.intermediaryManagerIDNumber;
                Signer_type = @"Manager";
                [self render];
                //[self addSignatureFrame];
            }
            else if(!cFFSignatureRequired)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"All the required parties should sign first before proceed with Signature of Manager." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
            }
            
            //         [self addSignatureFrame:indexPath.row];
            break;
            
        case 11:
            SetSigNameObject(kCardHolderSign);
            str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.cardMemberNameC,_eApplicationGenerator.cardMemberNewICNoC];
            //            str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
            SetSignerName(str);
            currentSigner = _eApplicationGenerator.cardMemberNameC;
            currentSignerIDNumber = _eApplicationGenerator.cardMemberNewICNoC;
            Signer_type = @"Cardholder";
            [self render];
            // [self addSignatureFrame];
            for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
                if(Myage<16){
                    //                    if (![key isEqualToString:kAgentSign] && ![key isEqualToString:kGardianSign] && ![key isEqualToString:kCOSign] && ![key isEqualToString:kCardHolderSign]&& ![key isEqualToString:kLA2Sign] && ![key isEqualToString:kWitnessSign] && ![key isEqualToString:kLASign]) {
                    //                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                    //                            isReady = NO;
                    //                            
                    //                        }
                    //                    }
					if ([key isEqualToString:kPOSign]) {
                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                            isReady = NO;
                        }
                    }
                }
                else if(Myage>15){
                    
                    if (![key isEqualToString:kAgentSign]  && ![key isEqualToString:k1stTrusteeSign] && ![key isEqualToString:kLASign]  && ![key isEqualToString:kManagerSign]  && ![key isEqualToString:kCardHolderSign] && ![key isEqualToString:k2ndTrusteeSign] && ![key isEqualToString:kWitnessSign]) {
                        if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
                            isReady = NO;
                            
                        }
                    }
                }
                
                
            }
			for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
				if ([key isEqualToString:kPOSign]) {
					if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
						isReady = NO;
					}
					
				}
			}
            if (isReady) {
                SetSigNameObject(kCardHolderSign);
                isLocked = [[proposalHistory objectForKey:kWitnessSign]boolValue];
                str = [NSString stringWithFormat:@"%@ %@ %@",[self getCurrentTimeDateStr],_eApplicationGenerator.cardMemberNameC,_eApplicationGenerator.cardMemberNewICNoC];
                //                str = [NSString stringWithFormat:@"%@ %@",[self getCurrentTimeDateStr],@""];
                SetSignerName(str);
                currentSigner = _eApplicationGenerator.cardMemberNameC;
                currentSignerIDNumber = _eApplicationGenerator.cardMemberNewICNoC;
                Signer_type = @"Cardholder";
                // [self render];
                //[self addSignatureFrame];
                isLocked = [[proposalHistory objectForKey:kCardHolderSign]boolValue];
                _overlayView.hidden=NO;
            }
            else if(!cFFSignatureRequired)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Signature of Policy Owner is required to proceed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
                
                [alert show];
                
                _overlayView.hidden=YES;
            }
            //		[self addSignatureFrame:indexPath.row];
            break;
            
            
        default:
            break;
    }
    
    [_tableView reloadData];
    [_tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
    
}
-(NSString *)getCurrentTimeDateStr
{
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    return dateString;
}

- (void)viewWillDisappear:(BOOL)animated
{
    eAppReport*viewController = [[eAppReport alloc]
                                 init];
    [viewController removeGenerateButton];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // [viewController release];
}

- (void)viewDidUnload {
    [self setBackButtonName:nil];
    [self setSAvebuttonStatus:nil];
    [super viewDidUnload];
}
@end//prem
