//
//  BrowserViewController.m
//  iMobile Planner
//
//  Created by infoconnect on 4/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "BrowserViewController.h"

@interface BrowserViewController ()

@end

@implementation BrowserViewController
@synthesize SIFilePath;
@synthesize PagesList = _PagesList;
@synthesize PagesPopover = _PagesPopover;
@synthesize _PDSorSI;
@synthesize _TradOrEver;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithFilePath:(NSString *)fullFilePath PDSorSI:(NSString *)PDSorSI TradOrEver:(NSString *)aaTradOrEver
{
    if ((self = [super init])) // Initialize the superclass object first
    {
        //NSLog(@"*********************************%@",fullFilePath);
		_PDSorSI = PDSorSI;
		_TradOrEver = aaTradOrEver;
		SIFilePath = fullFilePath;
	}
    return self;
}

-(void) emailSI{
	
	[self.PagesPopover dismissPopoverAnimated:YES];
	if ([MFMailComposeViewController canSendMail] == NO){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Email Account found" message:@"Please set up your default email account in iPad first"
													   delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

        alert = Nil;
		NSLog(@"User has not set up email yet");
		return;
	}
	if (printInteraction != nil) [printInteraction dismissAnimated:YES];

	NSURL *fileURL = [NSURL fileURLWithPath:SIFilePath]; //document.fileURL;
	NSString *fileName = [SIFilePath lastPathComponent];//document.fileName; // Document
	
	NSData *attachment = [NSData dataWithContentsOfURL:fileURL options:(NSDataReadingMapped|NSDataReadingUncached) error:nil];
	
	if (attachment != nil) // Ensure that we have valid document file attachment data
	{
		MFMailComposeViewController *mailComposer = [MFMailComposeViewController new];
		
		[mailComposer addAttachmentData:attachment mimeType:@"application/pdf" fileName:fileName];
		
		[mailComposer setSubject:fileName]; // Use the document file name for the subject
		
		mailComposer.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
		mailComposer.modalPresentationStyle = UIModalPresentationFormSheet;
		
		mailComposer.mailComposeDelegate = self; // Set the delegate
		
		[self presentModalViewController:mailComposer animated:YES];
		
		// Cleanup
	}
	else{
				NSLog(@"cannot send email 2");
	}
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif
	
#ifdef DEBUG
	if ((result == MFMailComposeResultFailed) && (error != NULL)) NSLog(@"%@", error);
#endif
	
	[self dismissModalViewControllerAnimated:YES]; // Dismiss
}

-(void)printSI{
	
	[self.PagesPopover dismissPopoverAnimated:YES]; 
	Class printInteractionController = NSClassFromString(@"UIPrintInteractionController");
	
	if ((printInteractionController != nil) && [printInteractionController isPrintingAvailable])
	{
		NSURL *fileURL = [NSURL fileURLWithPath:SIFilePath]; // Document file URL
		
		printInteraction = [printInteractionController sharedPrintController];
		
		if ([printInteractionController canPrintURL:fileURL] == YES) // Check first
		{
			UIPrintInfo *printInfo = [NSClassFromString(@"UIPrintInfo") printInfo];
			
			printInfo.duplex = UIPrintInfoDuplexLongEdge;
			printInfo.outputType = UIPrintInfoOutputGeneral;
			printInfo.jobName = [SIFilePath lastPathComponent];
			
			printInteraction.printInfo = printInfo;
			printInteraction.printingItem = fileURL;
			printInteraction.showsPageRange = YES;
			
			if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
			{
				[printInteraction presentFromBarButtonItem:print animated:YES completionHandler:
				 ^(UIPrintInteractionController *pic, BOOL completed, NSError *error)
				 {
#ifdef DEBUG
					 if ((completed == NO) && (error != nil)) NSLog(@"%s %@", __FUNCTION__, error);
#endif
				 }
				 ];
			}

		}
	}
}

- (void)closeModalWindow:(id)sender {
	NSError *error;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	[fileManager removeItemAtPath:SIFilePath error:&error];
	
	error = Nil;
	fileManager= Nil;
	SIFilePath = Nil;
	
    [self dismissModalViewControllerAnimated:YES];
	[printInteraction dismissAnimated:YES];
	[self.PagesPopover dismissPopoverAnimated:YES];
	printInteraction = Nil;
	print = nil;
	email= nil;
	webView = nil;
	
}

-(void)pagesSI:(UIBarButtonItem *)sender        //--**added by bob
{
    if (_PagesList == nil) {
        
        self.PagesList = [[PagesController alloc] initWithStyle:UITableViewStylePlain];
        _PagesList.delegate = self;
		_PagesList.PDSorSI =_PDSorSI;
		_PagesList.TradOrEver =_TradOrEver;
        self.PagesPopover = [[UIPopoverController alloc] initWithContentViewController:_PagesList];
    }
	
    [self.PagesPopover setPopoverContentSize:CGSizeMake(230.0f, 600.0f)];
    [self.PagesPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)getPages:(NSString *)pdsPages    //--**added by bob
{
    //NSLog(@"select:%@",pdsPages);
    NSString *aa = [[pdsPages componentsSeparatedByString:@"Page"] objectAtIndex:1];
	
	int bb = [aa intValue];
	
	double cc = 761.5 * (bb - 1);
	
	[[webView scrollView] setContentOffset:CGPointMake(0, (cc)) animated:YES];
	
	
	[self.PagesPopover dismissPopoverAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	//self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(closeModalWindow:) ];
    
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(closeModalWindow:) ];
    
    print = [[UIBarButtonItem alloc] initWithTitle:@"Print" style:UIBarButtonItemStyleBordered target:self action:@selector(printSI) ];
    email = [[UIBarButtonItem alloc] initWithTitle:@"Email" style:UIBarButtonItemStyleBordered target:self action:@selector(emailSI) ];
	
	pages = [[UIBarButtonItem alloc] initWithTitle:@"Pages" style:UIBarButtonItemStyleBordered target:self action:
             @selector(pagesSI:)];
	
	//self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:email, print, Nil];
	self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:email, print, pages, Nil]; 
	
	
	webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //Considering your pdf is stored in documents directory with name as "pdfFileName"
    
    //NSString *pdfPath = [[paths objectAtIndex:0]stringByAppendingPathComponent:@"HTML_Demo.pdf"];
    NSURL *url = [NSURL fileURLWithPath:SIFilePath];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    //[webView loadRequest:requestObj];
    
    
    
    
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"document" ofType:@"pdf"];
    //NSURL *targetURL = [NSURL fileURLWithPath:path];
    //NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [webView loadRequest:requestObj];
    [webView setScalesPageToFit:YES];
    [self.view addSubview:webView];
    //webView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (interfaceOrientation==UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        return YES;
    
    return NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
