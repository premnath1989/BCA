//
//  COAPDF.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/16/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "COAPDF.h"
#import "DataClass.h"
#import "FMDatabase.h"

#include "SPSignDocCAPI.h"
#include "test.h"



@interface COAPDF (){
    DataClass *obj;
    bool signBefore;
    NSMutableArray *sign;
}

@end

@implementation COAPDF

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) render
{
    struct SIGNDOC_ByteArray *blob;
    NSMutableData *data;
    
    //UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //scrollView.showsVerticalScrollIndicator=YES;
    //scrollView.scrollEnabled=YES;
    //scrollView.userInteractionEnabled = YES;
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44,
                                                                     1024,
                                                                     1448)];
    int totalHeight = 800;
    for (int i = 1; i < 5; i++) {
        blob = nil;
        //blob = renderTest(self.COAView.frame.size.height, self.COAView.frame.size.width, i);
        blob = renderTest(1448, 700, i);
        data = [[NSMutableData alloc] initWithBytesNoCopy:SIGNDOC_ByteArray_data(blob) length:SIGNDOC_ByteArray_count(blob)];
        UIImage *img = [UIImage imageWithData:data];
        CGFloat yOrigin = (i-1) * img.size.height;
        totalHeight += img.size.height;
        UIImageView *iv = [[UIImageView alloc] initWithFrame:
                              CGRectMake(0, yOrigin,
                                         img.size.width,
                                         img.size.height)];
        iv.image = img;
        NSString *signedDocPath = [docsDir stringByAppendingPathComponent: [NSString stringWithFormat:@"output_%d.png", i]];
        BOOL isSuccess = [data writeToFile:signedDocPath atomically:YES];
        if (isSuccess) {
            NSLog(@"image written");
            [self.scrollView addSubview:iv];
        }
        else {
            NSLog(@"Failed to write image");
        }
        if (i == 4 /*&& !signBefore*/) {
            for (int i = 1; i <= 9; i++) {
                UIButton *btn;
                switch (i) {
                    case 1:
                        btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 480, 150, 50)];
                        break;
                    case 2:
                        btn = [[UIButton alloc] initWithFrame:CGRectMake(280, 480, 150, 50)];
                        break;
                    case 3:
                        btn = [[UIButton alloc] initWithFrame:CGRectMake(510, 480, 150, 50)];
                        break;
                    case 4:
                        btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 600, 150, 50)];
                        break;
                    case 5:
                        btn = [[UIButton alloc] initWithFrame:CGRectMake(280, 600, 150, 50)];
                        break;
                    case 6:
                        btn = [[UIButton alloc] initWithFrame:CGRectMake(510, 600, 150, 50)];
                        break;
                    case 7:
                        btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 720, 150, 50)];
                        break;
                    case 8:
                        btn = [[UIButton alloc] initWithFrame:CGRectMake(280, 720, 150, 50)];
                        break;
                    case 9:
                        btn = [[UIButton alloc] initWithFrame:CGRectMake(510, 720, 150, 50)];
                        break;
                    default:
                        break;
                }
                
                btn.backgroundColor = [UIColor clearColor];
                [btn setTitle:@"Sign Here" forState:UIControlStateNormal];
                btn.titleLabel.textColor = [UIColor redColor];
                btn.tag = i;
                [btn addTarget:self action:@selector(signature:) forControlEvents:UIControlEventTouchUpInside];
                if ([[sign objectAtIndex:(i-1)] isEqualToString:@"N"]) {
                    [iv addSubview:btn];
                }
                iv.userInteractionEnabled = YES;
                btn.userInteractionEnabled = YES;
            }
        }
        
    }
    self.scrollView.contentSize = CGSizeMake(1024, totalHeight);
    _COAView.hidden = TRUE;
    //[self.view.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [self.view addSubview:self.scrollView];
    
    
    //imageView.image = [UIImage imageWithData:data];
    //[_COAView setFrame:CGRectMake(_COAView.frame.origin.x, _COAView.frame.origin.y, [UIImage imageWithData:data].size.width, [UIImage imageWithData:data].size.height)];
    //you can add the image in different ways
    
    //[scrollView addSubview:[[UIImageView alloc]initWithImage:[UIImage imageWithData:data]]];
    
     //[_COAView addSubview:scrollView];
    //[_COAView addSubview:[[UIImageView alloc]initWithImage:[UIImage imageWithData:data]]];
    
    
    
    
    
    
    //NSLog(@"testespath - %@", signedDocPath);
    
    //NSURL *signedurl = [NSURL fileURLWithPath:signedDocPath];

    //NSURLRequest *signedObj = [NSURLRequest requestWithURL:signedurl];
    
    //[_COAView setScalesPageToFit:YES];
    //[_COAView loadRequest:signedObj];
    
    
    //[data release];
    
    //image captured
    /*
     struct SIGNDOC_ByteArray *imgBlob;
     NSMutableData *imgData;
     
     imgBlob = renderTest(selectedImage.frame.size.height);
     imgData = [[NSMutableData alloc] initWithBytesNoCopy:SIGNDOC_ByteArray_data(imgBlob) length:SIGNDOC_ByteArray_count(imgBlob)];
     selectedImage.image = [UIImage imageWithData:imgData];
     [imgData release];
     */
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSString *urlAddress = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"pdf"];
    NSURL *url = [NSURL fileURLWithPath:urlAddress];
    sign = [[NSMutableArray alloc] initWithObjects:@"N",@"N",@"N",@"N",@"N",@"N",@"N",@"N",@"N", nil];
    //NSLog(@"%@",url);
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_COAView setScalesPageToFit:YES];
    [_COAView loadRequest:requestObj];
    
    obj = [DataClass getInstance];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    [db open];
    FMResultSet *result = [db executeQuery:@"select * from eProposal_Authorization where eProposalNo = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
    signBefore = FALSE;
    while ([result next]) {
        if ([[result objectForColumnName:@"flag"] isEqualToString:@"Y"]) {
            signBefore = TRUE;
            //hasInit = 1;
        }
        else {
            signBefore = FALSE;
            //hasInit = 0;
        }
        [sign replaceObjectAtIndex:[result intForColumn:@"Seq"]-1 withObject:[result objectForColumnName:@"flag"]];
    }
    result = nil;
    result = [db executeQuery:@"select count(*) as count from eProposal_Authorization where eProposalNo = ? and flag = 'Y'", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
    while ([result next]) {
        if ([result intForColumn:@"count"] > 0) {
            signBefore = TRUE;
        }
        else {
            signBefore = FALSE;
        }
    }
    [result close];
    [db close];
    if (signBefore) {
        NSString *filename = [NSString stringWithFormat:@"%@.pdf", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
        initTest([filename UTF8String]);
    }
    else {
        initTest("test2.pdf");
    }
    //doTest();
    initDoTest = 0;
    //hasInit = 0; //added to prevent re-initialization of the signature fields for signing the 2nd field.
    [self render];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCOAView:nil];
    [self setNaviBar:nil];
    [super viewDidUnload];
}
- (IBAction)doDone:(id)sender {
    //basil 20131128//[self.delegate displayESignForms];
    uninit();
    /* basil 20131128 */[self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)openWith:(id)sender {
    
    buttonClicked = 1;
    
    /*
    NSURL *pathURL = [[NSBundle mainBundle] URLForResource:@"COA" withExtension:@"pdf"];
    
    
    self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:pathURL];
    
    [self.documentInteractionController setDelegate:self];
    
    [self.documentInteractionController presentOpenInMenuFromBarButtonItem:_openWithBtn animated:YES];
    
    NSLog(@"signdoc");
    */
    
    
    //NSLog(@"In captureClicked:(id)sender:Button pressed: %@", [sender currentTitle]);
    
    //LA
    
    //delegate = [self delegate];
    dialog = [[SDSignatureCaptureController alloc] initWithParent: self withDelegate: self];
    [dialog setTitle:@"Sign here - Life Assured"];
    [dialog captureSignature];
    
}

- (IBAction)signature:(UIButton *)button {
    buttonClicked = button.tag;
    doTest();
    /*
     NSURL *pathURL = [[NSBundle mainBundle] URLForResource:@"COA" withExtension:@"pdf"];
     
     
     self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:pathURL];
     
     [self.documentInteractionController setDelegate:self];
     
     [self.documentInteractionController presentOpenInMenuFromBarButtonItem:_openWithBtn animated:YES];
     
     NSLog(@"signdoc");
     */
    
    
    //NSLog(@"In captureClicked:(id)sender:Button pressed: %@", [sender currentTitle]);
    
    //LA
    
    //delegate = [self delegate];
    dialog = [[SDSignatureCaptureController alloc] initWithParent: self withDelegate: self];
    [dialog setTitle:@"Sign here - Life Assured"];
    [dialog captureSignature];
}

- (void) handleSignature: (CFDataRef) points withFieldId: (NSString *) fieldId
{
    
    // both signature fields will enter this event after signature dialog box
    NSData *signatureData;
    UIImage *signatureImage;
    NSData *imgData;
    
    /*
     if (initDoTest == 0){
     doTest();
     }
     */
    //doTest();
    
    if (CFDataGetLength(points) == 0)
        return;
	
    initDoTest = 1;
    hasInit = 1;
    
    
    NSArray *doc_paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doc_path = [doc_paths objectAtIndex:0];
    const unsigned char *output_path;
    if (![[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]) {
        output_path = [[doc_path stringByAppendingPathComponent:@"output.pdf"] UTF8String];
    }
    else {
        output_path = [[doc_path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]] UTF8String];
    }
    
    signatureData = [dialog signatureAsISO19794Simple];
    signatureImage = [dialog signatureAsUIImage];
    imgData = UIImageJPEGRepresentation(signatureImage, 1);
    
    NSLog(@"Sign field ID:  %@", fieldId);
    
    const char *sig;
    
    if (buttonClicked == 1) {
        sig = "sig1";
    }
    else if (buttonClicked == 2){
        sig = "sig2";
    }
    else if (buttonClicked == 3){
        sig = "sig3";
    }
    else if (buttonClicked == 4){
        sig = "sig4";
    }
    else if (buttonClicked == 5){
        sig = "sig5";
    }
    else if (buttonClicked == 6){
        sig = "sig6";
    }
    else if (buttonClicked == 7){
        sig = "sig7";
    }
    else if (buttonClicked == 8){
        sig = "sig8";
    }
    else {
        sig = "sig9";
    }
    
    signTest(sig, [signatureData bytes], [signatureData length], [imgData bytes], [imgData length], output_path, TRUE);
    
    signBefore = TRUE;
    [sign replaceObjectAtIndex:buttonClicked-1 withObject:@"Y"];
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    [db open];
    [db executeUpdate:@"delete from eProposal_Authorization where eProposalNo = ? and Seq = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], [NSString stringWithFormat:@"%d", buttonClicked], nil];
    [db executeUpdate:@"Insert into eProposal_Authorization (eProposalNo, flag, Seq) Values (?,?,?)", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"Y", [NSString stringWithFormat:@"%d", buttonClicked], nil];
    [db close];
    
    //doTest();
    [self render];
    //LASign.enabled = FALSE;
    //LASign.titleLabel.text = @"Life Assured Signature (Locked)";
    //LASign.titleLabel.
}


- (void) abortSignature: (NSString *) fieldId
{
    //not in used
}

@end
