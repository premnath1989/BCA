//
//  AgentPortalLogin.m
//  iMobile Planner
//
//  Created by Edwin Fong on 11/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "AgentPortalLogin.h"
#import "SIUtilities.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "AFJSONRequestOperation.h"
#import "AFNetworking.h"
#import "StoreVarFirstTimeReg.h"
#import "AgentProfile.h"
#import "MBProgressHUD.h"
#import "Login.h"

@interface AgentPortalLogin ()

@end

@implementation AgentPortalLogin

@synthesize txtAgentPortalId;
@synthesize txtAgentPortalPassword;


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
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
								   initWithTarget:self
								   action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	
	[self.view addGestureRecognizer:tap];

}

-(void)hideKeyboard{
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
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

- (void)viewDidUnload {
    [self setTxtAgentPortalId:nil];
    [self setTxtAgentPortalPassword:nil];
    [self setBtnNext:nil];
    [super viewDidUnload];
}

- (IBAction)btnLogin:(id)sender {
    [self doProcess];
}

- (void) parseXMLFileAtURL:(NSString *)URL
{
    
    NSString *agentString = @"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-us) AppleWebKit/525.27.1 (KHTML, like Gecko) Version/3.2.1 Safari/525.27.1";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    
    [request setValue:agentString forHTTPHeaderField:@"User-Agent"];
    /*
	 xmlFile = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	 
	 articles = [[NSMutableArray alloc] init];
	 errorParsing = NO;
	 
	 rssParser = [[NSXMLParser alloc] initWithData:xmlFile];
	 */
    
}

-(void)showLogin
{
    Login *LoginPage = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
    LoginPage.modalPresentationStyle = UIModalPresentationFullScreen;
    LoginPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:LoginPage animated:YES ];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)btnNext:(id)sender {

    if([Login forSMPD_Acturial:txtAgentPortalPassword.text])
    {
        [Login setFirstDevice];
        [self showLogin];
    }else
    {
        if ([[Reachability reachabilityWithHostname:@"www.hla.com.my"] currentReachabilityStatus] == NotReachable) {
            // Show alert because no wifi or 3g is available..
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Error in connecting to Web service. Please check your internet connection"
                                                           delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            alert = Nil;
        }else
        {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                
                [self doProcess];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //[MBProgressHUD hideHUDForView:self.view animated:YES];
                });
            }); 
        }
    }
}

- (void) doProcess
{
    NSString *sBadAttempt = [NSString stringWithFormat:@"%d", [self getBadAttempts]];
    NSString *strURL = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx/"
                        "ValidateAgent?Input1=%@&Input2=%@&Input3=%@&Input4=%@",
                        [SIUtilities WSLogin],  txtAgentPortalId.text, txtAgentPortalPassword.text, [self getIPAddress], sBadAttempt];
    NSLog(@"%@", strURL);
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:20];
    
    AFXMLRequestOperation *operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
                                           
                                           XMLParser.delegate = self;
                                           [XMLParser setShouldProcessNamespaces:YES];
                                           [XMLParser parse];
                                           
                                       } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
                                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                                           NSLog(@"error in calling web service");
                                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                                           message:@"Error in connecting to Web service. Please check your internet connection"
                                                                                          delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                           [alert show];
                                           
                                           alert = Nil;
                                       }];
    [operation start];
}


- (NSString *)getIPAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}



-(void) storeBadAttempts
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[NSNumber numberWithInt:badAttempts] forKey:@"badAttempts"];
    [defaults synchronize];
}

-(NSInteger) getBadAttempts
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *number = [defaults objectForKey:@"badAttempts"];
    
    NSInteger anInt = [number intValue];
    
    return anInt;
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
    [MBProgressHUD hideHUDForView:self.view animated:YES];
	
	NSLog(@"%@" , self.elementName);
	NSLog(@"%@" , string);
	
	if([self.elementName isEqualToString:@"BadAttempts"]){
		badAttempts = [string intValue];
	}
	
	if([self.elementName isEqualToString:@"Status"]){
		status = string;
	}
	
	if([self.elementName isEqualToString:@"Error"]){
		error = string;
	}
	
	if([self.elementName isEqualToString:@"AgentInfo"]){
		agentInfo = string;
	}
	
	if([self.elementName isEqualToString:@"Output1"]){ //agent code
		agentCode = string;
	}
	
	
	if([self.elementName isEqualToString:@"Output2"]){ //agent name
		agentName = string;
	}
	
	if([self.elementName isEqualToString:@"Output3"]){ //new IC no
		icNo = string;
	}
	
	if([self.elementName isEqualToString:@"Output4"]){ //contract date
		contractDate = string;
	}
	
	if([self.elementName isEqualToString:@"Output5"]){ //email address
		email = string;
	}
	
	
	if([self.elementName isEqualToString:@"Output6"]){ //address1
		address1 = string;
	}
	
	if([self.elementName isEqualToString:@"Output7"]){ //address2
		address2 = string;
	}
	
	if([self.elementName isEqualToString:@"Output8"]){ //address3
		address3 = string;
	}
	
	if([self.elementName isEqualToString:@"Output9"]){ //postal
		postalCode = string;
	}
	
	if([self.elementName isEqualToString:@"Output10"]){ //state
		stateCode = string;
	}
	
	if([self.elementName isEqualToString:@"Output11"]){ //country
		countryCode = string;
	}
	
	if([self.elementName isEqualToString:@"Output12"]){ //agent status
		agentStatus = string;
	}
	
	if([self.elementName isEqualToString:@"Output13"]){ //leader code
		leaderCode = string;
	}
	
	if([self.elementName isEqualToString:@"Output14"]){ //leader name
		leaderName = string;
	}
	
	
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
	self.elementName = nil;
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
	
	[self storeBadAttempts];
	
	if([status isEqualToString:@"1"])
	{
		NSLog(@"valid");
		
		StoreVarFirstTimeReg *storeVar = [StoreVarFirstTimeReg sharedInstance];
		
		//agentCode,agentName,leaderCode,leaderName,icNo,contractDate;
		storeVar.agentLogin = txtAgentPortalId.text;
		storeVar.agentCode = agentCode;
		storeVar.agentName = agentName;
		storeVar.icNo = icNo;
		storeVar.contractDate = [self getFormattedDate:contractDate];
		storeVar.email = email;
		storeVar.address1 = address1;
		storeVar.address2 = address2;
		storeVar.address3 = address3;
		storeVar.postalCode = postalCode;
		storeVar.stateCode = stateCode;
		storeVar.countryCode = countryCode;
		storeVar.agentStatus = agentStatus;
		storeVar.leaderCode = leaderCode;
		storeVar.leaderName = leaderName;
		
		
		AgentProfile *agentProfile = [self.storyboard instantiateViewControllerWithIdentifier:@"AgentProfile"];
		agentProfile.modalPresentationStyle = UIModalPresentationPageSheet;
		agentProfile.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
		
		[self presentViewController:agentProfile animated:YES completion:nil];
		agentProfile.view.superview.frame = CGRectMake(150, 50, 700, 600);
	}else
        if([status isEqualToString:@"0"])
        {
            NSLog(@"not valid");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:error
                                                           delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            alert = Nil;
        }
	
}


- (NSString*) getFormattedDate:(NSString *)dateInput
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"]; //// here set format of date which is in your output date (means above str with format)
    
    NSDate *date = [dateFormatter dateFromString: dateInput]; // here you can fetch date from string with define format
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];// here set format which you want...
    
    
    NSString * convertedString = [dateFormatter stringFromDate:date];
    
    return convertedString;
}


@end
