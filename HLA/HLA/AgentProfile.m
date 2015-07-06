//
//  AgentProfile.m
//  iMobile Planner
//
//  Created by Edwin Fong on 12/2/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "AgentProfile.h"
#import "StoreVarFirstTimeReg.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import "SIUtilities.h"
#import "UIDevice+IdentifierAddition.h"
#import "NSString+URLEncode.h"
#import "ChangePasswordReg.h"
#import "ColorHexCode.h"
#import <dlfcn.h>
#import <mach/port.h>
#import <mach/kern_return.h>

@interface AgentProfile ()

@end


@implementation AgentProfile

@synthesize agentCode,agentName,leaderCode,leaderName,icNo,contractDate;
@synthesize previousElementName,elementName;
@synthesize isValidated;

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
    
    storeVar = [StoreVarFirstTimeReg sharedInstance];
    
    agentCode.text = storeVar.agentCode;
    agentName.text = storeVar.agentName;
    leaderCode.text = storeVar.leaderCode;
    leaderName.text = storeVar.leaderName;
    icNo.text = storeVar.icNo;
    contractDate.text = storeVar.contractDate;	
    
    agentCode.enabled = NO;
    agentName.enabled = NO;
    leaderCode.enabled = NO;
    leaderName.enabled = NO;
    icNo.enabled = NO;
    contractDate.enabled = NO;
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
    
    agentCode.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [agentCode setTextColor:[UIColor grayColor]];
    agentName.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [agentName setTextColor:[UIColor grayColor]];
    leaderCode.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [leaderCode setTextColor:[UIColor grayColor]];
    leaderName.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [leaderName setTextColor:[UIColor grayColor]];
    icNo.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [icNo setTextColor:[UIColor grayColor]];
    contractDate.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [contractDate setTextColor:[UIColor grayColor]];
    
    
    //[contractDate setTitleColor:[UIColor grayColor]];
    //[contractDate setTitleColor:[UIColor grayColor] forState:UIControlStateNormal]; 
    //contractDate.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    
    //[btnDOB setTitle:DOB forState:UIControlStateNormal];
    //[contractDate setTitle:storeVar.contractDate forState:UIControlStateNormal];
	
    
	// Do any additional setup after loading the view.
    [self getDeviceInfo];
    
	
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
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

- (IBAction)cancelAction:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)btnActivateDevice:(id)sender {
    //[self activateDevice];
}

- (IBAction)btnConfirm:(id)sender {
    
    if(isValidated)
    {
        ChangePasswordReg *changePwdView = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePwdReg"];
        changePwdView.modalPresentationStyle = UIModalPresentationPageSheet;
        changePwdView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        //changePwdView.userID = self.indexNo;
        [self presentViewController:changePwdView animated:YES completion:nil];
        changePwdView.view.superview.frame = CGRectMake(150, 50, 700, 600);
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: NSLocalizedString(@" ",nil)
                              message: NSLocalizedString(@"Do you want to activate your device?",nil)
                              delegate: self
                              cancelButtonTitle: NSLocalizedString(@"Yes",nil)
                              otherButtonTitles: NSLocalizedString(@"No",nil), nil];
        
        alert.tag = 1002;
        [alert show ];
        alert = Nil;
    }
    
	// [self checkDeviceActivation];
}
- (IBAction)btnCancel:(id)sender {
    //[self dismissModalViewControllerAnimated:NO];
    if(isValidated)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"Your account has been activated, you're required to complete the entire registration process."
                                                       delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        alert = Nil;
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: NSLocalizedString(@" ",nil)
                              message: NSLocalizedString(@"Do you want to quit iM-Solutions?",nil)
                              delegate: self
                              cancelButtonTitle: NSLocalizedString(@"Yes",nil)
                              otherButtonTitles: NSLocalizedString(@"No",nil), nil];
        
        alert.tag = 1003;
        [alert show ];
        alert = Nil;
    }
}


- (IBAction)btnContractDatePressed:(id)sender {
}

- (void)viewDidUnload {
    [self setAgentCode:nil];
    [self setAgentName:nil];
    [self setLeaderCode:nil];
    [self setLeaderName:nil];
    [self setIcNo:nil];
    [self setContractDate:nil];
    [self setBtnSave:nil];
    //[self setBtnDone:nil];
    [self setBtnConfirm:nil];
    [self setBtnConfirm:nil];
    [self setBtnCancel:nil];
    [self setContractDate:nil];
    [super viewDidUnload];
}

- (void) getDeviceInfo{
    
    //UIDevice *device = [UIDevice currentDevice];
    
    iosVers = [[UIDevice currentDevice] systemVersion];
//    deviceId = [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier];
    deviceId = [self getDeviceSerialNo];
    deviceName = [[UIDevice currentDevice] name];

//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
//                                                    message:[NSString stringWithFormat:@"deviceId=%@",deviceId]
//                                                   delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];
//    
//    alert = Nil;
}

- (NSString *) getDeviceSerialNo
{
	NSString *serialNumber = nil;
	
	void *IOKit = dlopen("/System/Library/Frameworks/IOKit.framework/IOKit", RTLD_NOW);
	if (IOKit)
	{
		mach_port_t *kIOMasterPortDefault = dlsym(IOKit, "kIOMasterPortDefault");
		CFMutableDictionaryRef (*IOServiceMatching)(const char *name) = dlsym(IOKit, "IOServiceMatching");
		mach_port_t (*IOServiceGetMatchingService)(mach_port_t masterPort, CFDictionaryRef matching) = dlsym(IOKit, "IOServiceGetMatchingService");
		CFTypeRef (*IORegistryEntryCreateCFProperty)(mach_port_t entry, CFStringRef key, CFAllocatorRef allocator, uint32_t options) = dlsym(IOKit, "IORegistryEntryCreateCFProperty");
		kern_return_t (*IOObjectRelease)(mach_port_t object) = dlsym(IOKit, "IOObjectRelease");
		
		if (kIOMasterPortDefault && IOServiceGetMatchingService && IORegistryEntryCreateCFProperty && IOObjectRelease)
		{
			mach_port_t platformExpertDevice = IOServiceGetMatchingService(*kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"));
			if (platformExpertDevice)
			{
				CFTypeRef platformSerialNumber = IORegistryEntryCreateCFProperty(platformExpertDevice, CFSTR("IOPlatformSerialNumber"), kCFAllocatorDefault, 0);
				if (CFGetTypeID(platformSerialNumber) == CFStringGetTypeID())
				{
					serialNumber = [NSString stringWithString:(__bridge NSString*)platformSerialNumber];
					CFRelease(platformSerialNumber);
				}
				IOObjectRelease(platformExpertDevice);
			}
		}
		dlclose(IOKit);
	}
	
	return serialNumber;
}

- (void) checkDeviceActivation{
    if ([[Reachability reachabilityWithHostname:@"www.hla.com.my"] currentReachabilityStatus] == NotReachable) {
        // Show alert because no wifi or 3g is available..
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"Error in connecting to Web service. Please check your internet connection"
                                                       delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        alert = Nil;
    }else
    {
        xmlType = 100;
        NSString *strURL = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx/"
                            "CheckDeviceActivationStatus?Input1=%@&Input2=%@&Input3=%@&Input4=%@",
							[SIUtilities WSLogin], storeVar.agentCode,  deviceId, [deviceName urlEncode], iosVers];
        NSLog(@"%@", strURL);
        
        NSURL *url = [NSURL URLWithString:strURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:20];
        
        AFXMLRequestOperation *operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
																							   success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
																								   
																								   XMLParser.delegate = self;
																								   [XMLParser setShouldProcessNamespaces:YES];
																								   [XMLParser parse];
																								   
																							   } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
																								   NSLog(@"error in calling web service");
																								   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
																																				   message:@"Error in connecting to Web service. Please check your internet connection"
																																				  delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
																								   [alert show];
																								   
																								   alert = Nil;
																							   }];
        [operation start];
		
    }
    
}

-(void) activateDevice
{
    xmlType = 101;
    NSString *strURL = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx/"
                        "ActivateDevice?Input1=%@&Input2=%@",
                        [SIUtilities WSLogin], storeVar.agentCode,  deviceId];
    NSLog(@"%@", strURL);
    
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:20];
    
    AFXMLRequestOperation *operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
																						   success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
																							   
																							   XMLParser.delegate = self;
																							   [XMLParser setShouldProcessNamespaces:YES];
																							   [XMLParser parse];
																							   
																						   } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
																							   NSLog(@"error in calling web service");
																							   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
																																			   message:@"Error in connecting to Web service. Please check your internet connection"
																																			  delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
																							   [alert show];
																							   
																							   alert = Nil;
																						   }];
    [operation start];
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
    
    NSLog(@"%@" , self.elementName);
    NSLog(@"%@" , string);
	
    if(xmlType == 100)
    {
        if([self.elementName isEqualToString:@"Output1"]){
            activateStatus = string;
        }
        
        if([self.elementName isEqualToString:@"Output1_ID"]){
            deviceIdPassed = string;
        }
        
    }else
		if(xmlType == 101)
		{
			//if([self.elementName isEqualToString:@"Result"]){
			if( [deviceIdPassed isEqualToString:deviceId] )
			{
				result = @"true";
			}else
			{
				result = string;
			}
			//}
		}
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
	self.elementName = nil;
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
	if(xmlType == 100)
    {
        if( [activateStatus isEqualToString:@"Y"] )
        {
            if( [deviceIdPassed isEqualToString:deviceId] )
            {
                //same device, will proceed instead
                [self activateDevice];
            }else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"You have already registered another device under your account. Please make a license transfer in the agency portal."
                                                               delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                alert.tag=1001;
                [alert show];
                
                alert = Nil;
            }
            
        }else //if not Y, it would be N
        {
            //[self setFirstDevice];
            /*
			 UIAlertView *alert = [[UIAlertView alloc]
			 initWithTitle: NSLocalizedString(@"iM-Solutions",nil)
			 message: NSLocalizedString(@"Do you want to activate your device?",nil)
			 delegate: self
			 cancelButtonTitle: NSLocalizedString(@"Yes",nil)
			 otherButtonTitles: NSLocalizedString(@"No",nil), nil];
			 
			 alert.tag = 1002;
			 [alert show ];
			 alert = Nil;
			 */
            
            [self activateDevice];
        }
	}else
		if(xmlType == 101)
		{
			//commented temporary as the ActivateDevice webservice has problem
			
			if( [result isEqualToString:@"true"] )
			{
				isValidated = TRUE;
				//activated successfully
				ChangePasswordReg *changePwdView = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePwdReg"];
				changePwdView.modalPresentationStyle = UIModalPresentationPageSheet;
				changePwdView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
				//changePwdView.userID = self.indexNo;
				[self presentViewController:changePwdView animated:YES completion:nil];
				changePwdView.view.superview.frame = CGRectMake(150, 50, 700, 600);
				
			}else
			{
				isValidated = FALSE;
				//activation fail
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
																message:@"Activation of this device fails. Please try again."
															   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				[alert show];
				
				alert = Nil;
			}
		}
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	
    if (alertView.tag==1001) {
        /*[self dismissModalViewControllerAnimated:YES];
		 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:
		 @"http://www.hla.com.my/agencyportal/includes/DLrotate2.asp?file=iMP/iMP.plist"]];
         */
        exit(0);
    }else
		if (alertView.tag==1002) {
			if(buttonIndex==0)
			{//yes
				//[self activateDevice];
				[self checkDeviceActivation];
			}else
				if(buttonIndex==1)
				{//no
					
				}
		}else
			if (alertView.tag==1003) {
				if(buttonIndex==0)
				{//yes
					exit(0);
				}else
					if(buttonIndex==1)
					{//no
						
					}
			}
	
}


@end
