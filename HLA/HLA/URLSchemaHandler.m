//
//  URLSchemaHandler.m
//  Mobile Login
//
//  Created by Edwin Fong on 4/2/14.
//

#import "URLSchemaHandler.h"
#import "CarouselViewController.h"
#import "AppDelegate.h"


@implementation URLSchemaHandler

//@synthesize bundledData;


-(void) viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    loginVar = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    
    
    if([zzz.bundledData length] == 0)
    {
        [self showDialogAppLaunchWithPitStop]; //bundledData is empty
    }else
    {
        [self parseURL:zzz.bundledData];
        [self updateUserData];
        [self showAppContent];
    }
}


-(void) showDialogAppLaunchWithPitStop
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                            message:@"You need to launch launch this app via HLA Fast." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
    alert.tag = 1001;
    [alert show];
    alert = Nil;
}



-(void)parseURL:(NSString *) urlStr
{    
    NSMutableDictionary *queryStringDict = [ [NSMutableDictionary alloc] init];
    NSArray *urlArr = [urlStr componentsSeparatedByString:@"&"];
    
    for(NSString *keyPair in urlArr)
    {
        NSArray *pairedComp = [keyPair componentsSeparatedByString:@"="];
        NSString *key = [pairedComp objectAtIndex:0];
        NSString *value = [pairedComp objectAtIndex:1];
        
        [queryStringDict setObject:value forKey:key];
    }

    loginVar = [ [LoginVar alloc] init];
    loginVar.agentCode = [queryStringDict objectForKey:@"agentCode"]; 
    loginVar.agentName = [queryStringDict objectForKey:@"agentName"]; 
    loginVar.immediateLeaderCode = [queryStringDict objectForKey:@"immediateLeaderCode"]; 
    loginVar.immediateLeaderName = [queryStringDict objectForKey:@"immediateLeaderName"]; 
    loginVar.agentEmail = [queryStringDict objectForKey:@"agentEmail"]; 
    loginVar.agentLoginId = [queryStringDict objectForKey:@"agentLoginId"]; 
    loginVar.agentIcNo = [queryStringDict objectForKey:@"agentIcNo"]; 
    loginVar.agentContractDate = [queryStringDict objectForKey:@"agentContractDate"]; 
    loginVar.agentAddr1 = [queryStringDict objectForKey:@"agentAddr1"]; 
    loginVar.agentAddr2 = [queryStringDict objectForKey:@"agentAddr2"]; 
    loginVar.agentAddr3 = [queryStringDict objectForKey:@"agentAddr3"]; 
    loginVar.agentAddrPostcode = [queryStringDict objectForKey:@"agentAddrPostcode"]; 
    loginVar.agentContactNumber = [queryStringDict objectForKey:@"agentContactNumber"]; 
    loginVar.agentPassword = [queryStringDict objectForKey:@"agentPassword"]; 
    loginVar.lastLogonDate = [queryStringDict objectForKey:@"lastLogonDate"]; 
    loginVar.lastLogoutDate = [queryStringDict objectForKey:@"lastLogoutDate"]; 
    loginVar.channel = [queryStringDict objectForKey:@"channel"]; 
}

-(void)updateUserData
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;

    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE Agent_Profile SET AgentLoginID = \"%@\", AgentCode= \"%@\", AgentName= \"%@\", "
                              "AgentContactNo= \"%@\", ImmediateLeaderCode= \"%@\", ImmediateLeaderName= \"%@\", "
                              "BusinessRegNumber = \"%@\", AgentEmail= \"%@\", AgentICNo=\"%@\", AgentContractDate=\"%@\", "
                              "AgentAddr1=\"%@\", AgentAddr2=\"%@\", AgentAddr3=\"%@\", AgentPortalLoginID = \"%@\", "
                              "AgentPortalPassword = \"%@\" , AgentContactNumber = \"%@\", AgentAddrPostcode = \"%@\", Channel=\"%@\" WHERE IndexNo=\"%d\"",
                              loginVar.agentLoginId, loginVar.agentCode, loginVar.agentName, loginVar.agentContactNumber, loginVar.immediateLeaderCode,
                              loginVar.immediateLeaderName,@"",loginVar.agentEmail,loginVar.agentIcNo, loginVar.agentContractDate, loginVar.agentAddr1,
                              loginVar.agentAddr2, loginVar.agentAddr3, @"", @"", loginVar.agentContactNumber, loginVar.agentAddrPostcode, @"AGT", 1];
        
        
        const char *query_stmt = [querySQL UTF8String];
        
        
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Update agent_profile done");
            } 
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }

}


-(void) showAppContent
{
    CarouselViewController *carouselMenu = [self.storyboard instantiateViewControllerWithIdentifier:@"carouselView"];
    carouselMenu.getInternet = @"No";
    [self presentViewController:carouselMenu animated:YES completion:Nil];
//    [self presentModalViewController:carouselMenu animated:YES];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 1001) {
        exit(0);
    }
    
}



@end
