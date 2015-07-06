//
//  CarouselViewController.m
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 10/10/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "CarouselViewController.h"
#import "SIListing.h"
#import "ProspectListing.h"
#import "setting.h"
#import "MainScreen.h"
#import "Login.h"
#import "NewLAViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "eBrochureViewController.h"
#import "eBrochureListingViewController.h"
#import "ViewController.h"
#import "AFNetworking.h"
#import "eSubmission.h"
#import "CustomerProfile.h"
#import "SettingUserProfile.h"
#import "SIUtilities.h"
#import "MainClient.h"
#import "MainCustomer.h"
#import "MaineApp.h"

const int numberOfModule = 7;

@interface CarouselViewController ()<UIActionSheetDelegate>{
    
}

@end

@implementation CarouselViewController
@synthesize outletCarousel, elementName, previousElementName, getInternet, getValid, indexNo, ErrorMsg;
@synthesize delegate = _delegate;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    outletCarousel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg11.jpg"]];
    self.view.backgroundColor = [UIColor clearColor];
    _myView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg11.jpg"]];
    self.view.backgroundColor = [UIColor clearColor];
    //outletCarousel.dataSource = self;
    //outletCarousel.delegate = self;
    //outletCarousel.type = iCarouselTypeRotary;
    // Do any additional setup after loading the view.
	/*
     if([getValid isEqualToString:@"Valid" ]){
     if ([getInternet isEqualToString:@"Yes" ]) {
     NSString *strURL = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx/"
     "GetSIVersion_TRADUL?Type=IPAD_TRAD&Remarks=Agency&OSType=32", [SIUtilities WSLogin]];
     NSLog(@"%@", strURL);
     NSURL *url = [NSURL URLWithString:strURL];
     NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:5];
     
     AFXMLRequestOperation *operation =
     [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
     
     XMLParser.delegate = self;
     [XMLParser setShouldProcessNamespaces:YES];
     [XMLParser parse];
     
     } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
     NSLog(@"error in calling web service");
     }];
     
     [operation start];
     
     }
     }
     else{
     if ([getInternet isEqualToString:@"Yes" ]) {
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Agency Portal" message:[NSString stringWithFormat:@"%@", ErrorMsg]
     delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
     alert.tag = 1;
     [alert show];
     
     alert = Nil;
     
     }
     }
     */
    //_CPBtn.backgroundColor = [UIColor clearColor];
    
}

#pragma mark - XML parser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict  {
    
	self.previousElementName = self.elementName;
	
    if (qName) {
        self.elementName = qName;
    }
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!self.elementName){
        return;
    }
	
	if([self.elementName isEqualToString:@"string"]){
		
		NSString *strURL = [NSString stringWithFormat:@"%@",  string];
		NSLog(@"%@", strURL);
		NSURL *url = [NSURL URLWithString:strURL];
		NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:5];
        
		AFXMLRequestOperation *operation =
		[AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
															success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
																
																XMLParser.delegate = self;
																[XMLParser setShouldProcessNamespaces:YES];
																[XMLParser parse];
																
															} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
																NSLog(@"error in calling web service");
															}];
		
		[operation start];
	}
	else if ([self.elementName isEqualToString:@"SITradVersion"]){
		NSString * AppsVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
		NSLog(@"latest version is available %@", AppsVersion);
		if (![string isEqualToString:AppsVersion]) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Latest Version"
                                                            message:[NSString stringWithFormat:@"Latest version is available for download. Do you want to download now ?"]
                                                           delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
			alert.tag = 2;
			[alert show];
			
			alert = Nil;
		}
	}
	else if ([self.elementName isEqualToString:@"DLURL"]){
		NSLog(@"%@", string);
	}
	else if ([self.elementName isEqualToString:@"DLFilename"]){
		NSLog(@"%@", string);
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	self.elementName = nil;
}


-(void) parserDidEndDocument:(NSXMLParser *)parser {
	
	//NSLog(@"ppppp");
	
}

#pragma mark - other
- (void)viewDidUnload
{
    [self setOutletCarousel:nil];
    [self setDoClientProfile:nil];
    [self setDoSI:nil];
    [self setDoSettings:nil];
    [self setDoEApp:nil];
    [self setDoeCFF:nil];
    [self setDoBrochure:nil];
    [self setDoSIBtn:nil];
    [self setMyView:nil];
    [self setSelectSI:nil];
    [self setCPBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (interfaceOrientation==UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        return YES;
    
    return NO;
    
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return numberOfModule;
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
	//NSLog(@"dasdasdas%d", index);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    /*
     CAGradientLayer *gradientLayer = [CAGradientLayer layer];
     [gradientLayer setFrame:button.frame];
     [button.layer addSublayer:gradientLayer];
     */
    
    
    button.frame = CGRectMake(0, 0, 450.0f, 400.0f);
    
    //[button setTitle:[NSString stringWithFormat:@"%i", index] forState:UIControlStateNormal];
    if (index % numberOfModule == 1) {
        //[button setTitle:[NSString stringWithFormat:@"Setting", index] forState:UIControlStateNormal];
        //NSString *filename = [NSString stringWithFormat:@"btn_setting_home"];
        //UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:filename ofType:@"PNG"]];
        [button setBackgroundImage:[UIImage imageNamed:@"20130108Settings.png"] forState:UIControlStateNormal];
		button.tag = 1;
    }
    else if (index % numberOfModule == 0) {
        //[button setTitle:[NSString stringWithFormat:@"Prospect Listing", index] forState:UIControlStateNormal];
        //NSString *filename = [NSString stringWithFormat:@"btn_prospect_home"];
        //UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:filename ofType:@"PNG"]];
        [button setBackgroundImage:[UIImage imageNamed:@"homeScreenBrochure2.png"] forState:UIControlStateNormal];
        button.tag = 0;
    }
    else if (index % numberOfModule == 2) {
        //[button setTitle:[NSString stringWithFormat:@"SI Listing", index] forState:UIControlStateNormal];
        //NSString *filename = [NSString stringWithFormat:@"btn_brochure_home"];
        //UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:filename ofType:@"PNG"]];
        [button setBackgroundImage:[UIImage imageNamed:@"20130108eBrochure.png" ] forState:UIControlStateNormal];
        button.tag = 2;
    }
    else if (index % numberOfModule == 3) {
        //[button setTitle:[NSString stringWithFormat:@"New SI", index] forState:UIControlStateNormal];
        //NSString *filename = [NSString stringWithFormat:@"btn_SI_home"];
        //UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:filename ofType:@"PNG"]];
        [button setBackgroundImage:[UIImage imageNamed:@"20130108SalesIllustration.png" ] forState:UIControlStateNormal];
        button.tag = 3;
    }
    
    else if (index % numberOfModule == 4) { //e-sub
        
        [button setBackgroundImage:[UIImage imageNamed:@"homeScreenEApp.png" ] forState:UIControlStateNormal];
        button.tag = 4;
    }
    
    else if (index % numberOfModule == 5) { //customer profile
        
        [button setBackgroundImage:[UIImage imageNamed:@"homeScreenCFF.png" ] forState:UIControlStateNormal];
        button.tag = 5;
    }
    else if (index % numberOfModule == 6) { //Ever Series
		
		[button setBackgroundImage:[UIImage imageNamed:@"bg8.jpg" ] forState:UIControlStateNormal];
		button.tag = 6;
	}
    /*
     [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     NSString *filename = [NSString stringWithFormat:@"IMG_00%i", (index+39)];
     UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:filename ofType:@"PNG"]];
     */
    //[button setBackgroundImage:image forState:UIControlStateNormal];
    
    
    
    button.titleLabel.font = [button.titleLabel.font fontWithSize:50];
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	
    return button;
    
    button = Nil;
}


- (void)buttonTapped:(UIButton *)sender
{
    
    /*
     [[[[UIAlertView alloc] initWithTitle:@"Button Tapped"
     message:[NSString stringWithFormat:@"You tapped button number %i", [outletCarousel indexOfItemView:sender]]
     delegate:nil
     cancelButtonTitle:@"OK"
     otherButtonTitles:nil] autorelease] show];
     */
    AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    
	
    if (sender.tag % numberOfModule == 1) { //setting
        setting *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"Setting"];
        zzz.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:zzz animated:NO completion:Nil];
        zzz = Nil;
		NSLog(@"setting");
		[self.outletCarousel reloadData ];
    }
    
    else if (sender.tag % numberOfModule == 0) { //prospect
        //        MainScreen *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
        MainClient *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"mainClient"];
        zzz.modalPresentationStyle = UIModalPresentationFullScreen;
        zzz.IndexTab = MenuOption.ProspectListingIndex;
		[self presentViewController:zzz animated:NO completion:Nil];
		zzz= Nil;
    }
    
    else if (sender.tag % numberOfModule == 2) {    //ebrochure
        eBrochureListingViewController *BrochureListing = [self.storyboard instantiateViewControllerWithIdentifier:@"eBrochureListing"];
        BrochureListing.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:BrochureListing animated:NO completion:Nil];
        BrochureListing = Nil;
        NSLog(@"brochure");
    }
    
    else if (sender.tag % numberOfModule == 3) {    //si listing
        
        MainScreen *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
		zzz.tradOrEver = @"TRAD";
        zzz.modalPresentationStyle = UIModalPresentationFullScreen;
        zzz.IndexTab = MenuOption.SIListingIndex;
        [self presentViewController:zzz animated:NO completion:Nil];
        zzz= Nil;
        NSLog(@"si listing");
    }
    
    else if (sender.tag % numberOfModule == 4) {    //e-app
        
        UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:Nil];
        MaineApp *zzz= [secondStoryboard instantiateViewControllerWithIdentifier:@"maineApp"];
        zzz.modalPresentationStyle = UIModalPresentationFullScreen;
        zzz.IndexTab = 1;
        [self presentViewController:zzz animated:NO completion:Nil];
        zzz = Nil;
        secondStoryboard = Nil;
		NSLog(@"e-sub!");
    }
    
    else if (sender.tag % numberOfModule == 5) {    //cff
        
        //        CustomerProfile *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"customerProfile"];
        MainCustomer *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"mainCFF"];
        zzz.modalPresentationStyle = UIModalPresentationFullScreen;
        zzz.IndexTab = 1;
        [self presentViewController:zzz animated:NO completion:Nil];
        zzz = Nil;
        NSLog(@"cff!");
    }
	else if (sender.tag % numberOfModule == 6) {    //Ever Series
		
        MainScreen *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
        zzz.tradOrEver = @"EVER";
        zzz.modalPresentationStyle = UIModalPresentationFullScreen;
        zzz.IndexTab = MenuOption.SIListingIndex;
        [self presentViewController:zzz animated:NO completion:Nil];
        zzz= Nil;
        
	}
    
    outletCarousel = Nil;
    MenuOption = Nil;
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0 && alertView.tag == 0 ) {
        [self updateDateLogout];
        
    }
	else if (buttonIndex == 0 && alertView.tag == 1){
        
		SettingUserProfile * UserProfileView = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingUserProfile"];
		UserProfileView.modalPresentationStyle = UIModalPresentationPageSheet;
		UserProfileView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
		UserProfileView.indexNo = self.indexNo;
		UserProfileView.getLatest = @"Yes";
		[self presentModalViewController:UserProfileView animated:YES];
		
		UserProfileView.view.superview.frame = CGRectMake(150, 50, 700, 748);
		UserProfileView = nil;
        
	}
	else if (buttonIndex == 0 && alertView.tag == 2){
		//download latest version
        /*
         NSString *strURL = [NSString stringWithFormat:@"http://www.hla.com.my/agencyportal/includes/DLrotate2.asp?file=iMP/iMP.plist"];
         NSURL *url = [NSURL URLWithString:strURL];
         NSURLRequest *request = [NSURLRequest requestWithURL:url];
         NSURLResponse *response;
         NSError *error;
         NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
         NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
         if(!error)
         {
         //log response
         NSLog(@"Response from server = %@", responseString);
         }
         */
		
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:
                                                    @"http://www.hla.com.my/agencyportal/includes/DLrotate2.asp?file=iMP/iMP.plist"]];
	}
	else if (alertView.tag == 3){
		AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
		MainScreen *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
		if (buttonIndex == 0) {
			zzz.tradOrEver = @"TRAD";
			zzz.modalPresentationStyle = UIModalPresentationFullScreen;
			zzz.IndexTab = MenuOption.SIListingIndex;
			[self presentViewController:zzz animated:NO completion:Nil];
			zzz= Nil;
			NSLog(@"si listing Trad");
			MenuOption = nil;
		}
		else{
			zzz.tradOrEver = @"EVER";
			zzz.modalPresentationStyle = UIModalPresentationFullScreen;
			zzz.IndexTab = MenuOption.SIListingIndex;
			[self presentViewController:zzz animated:NO completion:Nil];
			zzz= Nil;
			NSLog(@"si listing Ever");
			MenuOption = nil;
		}
		
	}
		
}

-(void)updateDateLogout
{
    NSString *databasePath;
    sqlite3 *contactDB;
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    Login *mainLogin = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
    mainLogin.modalPresentationStyle = UIModalPresentationFullScreen;
    mainLogin.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:mainLogin animated:YES];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE User_Profile SET LastLogoutDate= \"%@\" WHERE IndexNo=\"%d\"",dateString, 1];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"date update!");
                
            } else {
                NSLog(@"date update Failed!");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
        query_stmt = Nil;
        querySQL = Nil;
    }
    
    databasePath = Nil, dbpath = Nil, statement = Nil;
    dirPaths = Nil, docsDir = Nil, mainLogin = Nil, dateFormatter = Nil, dateString = Nil;
    exit(0);
    
    
}

- (IBAction)btnExit:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: NSLocalizedString(@"Exit",nil)
                          message: NSLocalizedString(@"Are you sure you want to exit?",nil)
                          delegate: self
                          cancelButtonTitle: NSLocalizedString(@"Yes",nil)
                          otherButtonTitles: NSLocalizedString(@"No",nil), nil];
    
	alert.tag = 0;
    [alert show ];
    alert = Nil;
}


- (IBAction)doClientProfileBtn:(id)sender {
    NSLog(@"csafasfsca");
    AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    MainClient *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"mainClient"];
    zzz.modalPresentationStyle = UIModalPresentationFullScreen;
    zzz.IndexTab = MenuOption.ProspectListingIndex;
    [self presentViewController:zzz animated:NO completion:Nil];
    MenuOption = Nil;
    zzz= Nil;
}
- (IBAction)doSalesIllustrationBtn:(id)sender {
    AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    MainScreen *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
    zzz.tradOrEver = @"TRAD";
    zzz.modalPresentationStyle = UIModalPresentationFullScreen;
    zzz.IndexTab = MenuOption.SIListingIndex;
    [self presentViewController:zzz animated:NO completion:Nil];
    zzz= Nil;
    NSLog(@"si listing");
    MenuOption = nil;
}

- (IBAction)doSettingsBtn:(id)sender {
    //AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    setting *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"Setting"];
    zzz.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:zzz animated:NO completion:Nil];
    zzz = Nil;
    NSLog(@"setting");
    [self.outletCarousel reloadData ];
}

- (IBAction)doeCFFBtn:(id)sender {
    MainCustomer *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"mainCFF"];
    zzz.modalPresentationStyle = UIModalPresentationFullScreen;
    zzz.IndexTab = 1;
    [self presentViewController:zzz animated:NO completion:Nil];
    zzz = Nil;
    NSLog(@"cff!");
}

- (IBAction)doeAppBtn:(id)sender {
    UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:Nil];
    MaineApp *zzz= [secondStoryboard instantiateViewControllerWithIdentifier:@"maineApp"];
    zzz.modalPresentationStyle = UIModalPresentationFullScreen;
    zzz.IndexTab = 1;
    [self presentViewController:zzz animated:NO completion:Nil];
    zzz = Nil;
    secondStoryboard = Nil;
    NSLog(@"e-sub!");
}

- (IBAction)doBrochureBtn:(id)sender {
    eBrochureListingViewController *BrochureListing = [self.storyboard instantiateViewControllerWithIdentifier:@"eBrochureListing"];
    BrochureListing.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:BrochureListing animated:NO completion:Nil];
    BrochureListing = Nil;
    NSLog(@"brochure");
}
- (IBAction)selectClientProfile:(id)sender {
    AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    MainClient *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"mainClient"];
    zzz.modalPresentationStyle = UIModalPresentationFullScreen;
    zzz.IndexTab = MenuOption.ProspectListingIndex;
    [self presentViewController:zzz animated:NO completion:Nil];
    MenuOption = Nil;
    zzz= Nil;
}
- (IBAction)selectSalesIllustration:(id)sender {
	/*
    AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    MainScreen *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
    zzz.tradOrEver = @"TRAD";
    zzz.modalPresentationStyle = UIModalPresentationFullScreen;
    zzz.IndexTab = MenuOption.SIListingIndex;
    [self presentViewController:zzz animated:NO completion:Nil];
    zzz= Nil;
    NSLog(@"si listing");
    MenuOption = nil;
    */
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iMobile" message:@"Please Select which module you want" delegate:self cancelButtonTitle:@"Traditional" otherButtonTitles:@"Ever Series", nil];
	alert.tag = 3;
	[alert show];
}

- (IBAction)selectBrochure:(id)sender {
    eBrochureListingViewController *BrochureListing = [self.storyboard instantiateViewControllerWithIdentifier:@"eBrochureListing"];
    BrochureListing.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:BrochureListing animated:NO completion:Nil];
    BrochureListing = Nil;
    NSLog(@"brochure");
}

- (IBAction)selectCFF:(id)sender {
    MainCustomer *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"mainCFF"];
    zzz.modalPresentationStyle = UIModalPresentationFullScreen;
    zzz.IndexTab = 1;
    [self presentViewController:zzz animated:NO completion:Nil];
    zzz = Nil;
    NSLog(@"cff!");
}

- (IBAction)selectEApp:(id)sender {
    UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:Nil];
    MaineApp *zzz= [secondStoryboard instantiateViewControllerWithIdentifier:@"maineApp"];
    zzz.modalPresentationStyle = UIModalPresentationFullScreen;
    zzz.IndexTab = 1;
    [self presentViewController:zzz animated:NO completion:Nil];
    zzz = Nil;
    secondStoryboard = Nil;
    NSLog(@"e-sub!");
}

- (IBAction)selectSettings:(id)sender {
    //AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    setting *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"Setting"];
    zzz.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:zzz animated:NO completion:Nil];
    zzz = Nil;
    NSLog(@"setting");
    //[self.outletCarousel reloadData ];
}
@end
