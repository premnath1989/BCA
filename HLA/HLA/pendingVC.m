//
//  pending.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/17/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "pendingVC.h"
#include "CkoCrypt2.h"
#import "AgentPortalLogin.h"
#import "eAppReport.h"
#import <AdSupport/ASIdentifierManager.h>

// TODO: To remove dependency
#import "NSStringAdditions.h"
#import "AFXMLRequestOperation.h"
#import "ColorHexCode.h"


@interface pendingVC () {
    NSMutableArray *selectedRecords;
    NSString *databasePath;
    BOOL isSearching;
    DataClass *obj;
    sqlite3 *updateDB;

    NSString *agentCode;

    NSString *cellSelectedExpired;
}


@property (retain, nonatomic) NSMutableArray *POName;
@property (retain, nonatomic) NSMutableArray *IDNo;
@property (retain, nonatomic) NSMutableArray *ProposalNo;
@property (retain, nonatomic) NSMutableArray *LastUpdated;
@property (retain, nonatomic) NSMutableArray *Status;
@property (retain, nonatomic) NSMutableArray *PONameSearch;
@property (retain, nonatomic) NSMutableArray *IDNoSearch;
@property (retain, nonatomic) NSMutableArray *ProposalNoSearch;
@property (retain, nonatomic) NSMutableArray *LastUpdatedSearch;
@property (retain, nonatomic) NSMutableArray *StatusSearch;
@property (retain, nonatomic) NSMutableArray *AgentCode;
@property (retain, nonatomic) NSMutableArray *AgentCodeSearch;
@property (retain, nonatomic) NSMutableArray *eAppVersionM;

@property (retain, nonatomic) NSMutableArray *ClientNameSearch;
@property (retain, nonatomic) NSMutableArray *SINoSearch;
@property (retain, nonatomic) NSMutableArray *planNameSearch;
@property (retain, nonatomic) NSMutableArray *SIVersionSearch;
@property (retain, nonatomic) NSMutableArray *eAppVersionMSearch;

@property (retain, nonatomic) NSMutableArray *SINo;
@property (retain, nonatomic) NSMutableArray *ClientName;
@property (retain, nonatomic) NSMutableArray *planName;
@property (retain, nonatomic) NSMutableArray *SIVersion;

@property (retain, nonatomic) NSMutableArray *OtherIDNo;
@property (retain, nonatomic) NSMutableArray *OtherIDNoSearch;
@end

@implementation pendingVC {
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *Eapp_Version_Svr;
    NSMutableString *Date_Eapp_Version_Svr;
    NSMutableString *Obs_Version_Svr;
    NSMutableString *Date_Obs_Version_Svr;
    NSString *element;
}


@synthesize previousElementName, elementName, agentPortalPassword, loginView;
@synthesize cellSelected;
@synthesize time_display;

- (void)viewDidLoad {
    [super viewDidLoad];

    obj = [DataClass getInstance];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"ReloadPendingVC" object:nil];
    //////// for storing selected record

    selectedRecords = [[NSMutableArray alloc] init];


    self.loginOuterView.hidden = YES;




    /////

    CGRect frame1 = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame1];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor darkTextColor];
    label.text = @"e-Application : Pending Submission Listing";
    self.navigationItem.titleView = label;

    // Display time refreshed
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/YYYY (HH:mm)"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];

    time_display = [[UILabel alloc] initWithFrame:CGRectMake(705, 257, 930, 20)];
    time_display.backgroundColor = [UIColor clearColor];
    time_display.font = [UIFont systemFontOfSize:14];
    time_display.textColor = [UIColor darkGrayColor];
    time_display.text = [NSString stringWithFormat:@"Last refreshed time: %@", dateString];
    time_display.hidden = NO;
    [self.view addSubview:self.time_display];



    CGRect frame = self.view.frame;
    frame.size.width = 1024;
    frame.size.height = 768;
    self.view.frame = frame;
    self.pendingTableVew.backgroundView = nil;
    _pendingTableVew.opaque = NO;
    self.pendingTableVew.backgroundColor = [UIColor clearColor];
    [self ReloadTableData];
    [self setAndpopulateUsername];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    _btnDelete.hidden = TRUE;
    _btnDelete.enabled = FALSE;
    ItemToBeDeleted = [[NSMutableArray alloc] init];
    indexPaths = [[NSMutableArray alloc] init];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tap.cancelsTouchesInView = NO;
    tap.numberOfTapsRequired = 1;

    [self.view addGestureRecognizer:tap];

    [self loadData];
}

- (void)reloadAfterSubmission {
    obj = [DataClass getInstance];

    selectedRecords = [[NSMutableArray alloc] init];

    [self loadData];
}

- (void)loadData {
    //    /* Operation Queue init (autorelease) */
    NSOperationQueue *queue = [NSOperationQueue new];

    /* Create our NSInvocationOperation to call loadDataWithOperation, passing in nil */
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
                                                                            selector:@selector(loadDataWithOperation)
                                                                              object:nil];


    /* Add the operation to the queue */
    [queue addOperation:operation];
}

- (void)loadDataWithOperation {
    NSString *feedURL = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx/GetAppVersion?Input1=IMSOLUTIONS&Input2=Agency", [SIUtilities WSLogin]];


    feeds = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:feedURL];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSURL *myurl = [[connection currentRequest] URL];
    NSString *url_st = [myurl absoluteString];


    NSLog(@"myurl %@", myurl);
    NSLog(@"url_st %@", url_st);


    NSString *sData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"connection sData %@", sData);

    for (NSIndexPath *path in selectedRecords) {
        NSMutableDictionary *recordDic = [[NSMutableDictionary alloc] init];

        if (isSearching) {
            [recordDic setObject:[self.ClientNameSearch objectAtIndex:path.row] forKey:@"name"];
            [recordDic setObject:[self.IDNoSearch objectAtIndex:path.row] forKey:@"IDNo"];
            [recordDic setObject:[self.SINoSearch objectAtIndex:path.row] forKey:@"SINo"];
            [recordDic setObject:[self.ProposalNoSearch objectAtIndex:path.row] forKey:@"ProposalNo"];
            [recordDic setObject:[self.LastUpdatedSearch objectAtIndex:path.row] forKey:@"LastUpdated"];
            [recordDic setObject:[self.SIVersionSearch objectAtIndex:path.row] forKey:@"SIVersion"];
            [recordDic setObject:[self.eAppVersionMSearch objectAtIndex:path.row] forKey:@"eAppVersion"];

            _LocalEappVersion = [NSString stringWithFormat:@"%@", [self.eAppVersionMSearch objectAtIndex:path.row]];
        } else {
            [recordDic setObject:[self.ClientName objectAtIndex:path.row] forKey:@"name"];
            [recordDic setObject:[self.IDNo objectAtIndex:path.row] forKey:@"IDNo"];
            [recordDic setObject:[self.SINo objectAtIndex:path.row] forKey:@"SINo"];
            [recordDic setObject:[self.ProposalNo objectAtIndex:path.row] forKey:@"ProposalNo"];
            [recordDic setObject:[self.LastUpdated objectAtIndex:path.row] forKey:@"LastUpdated"];
            [recordDic setObject:[self.SIVersion objectAtIndex:path.row] forKey:@"SIVersion"];
            [recordDic setObject:[self.eAppVersionM objectAtIndex:path.row] forKey:@"eAppVersion"];

            _LocalEappVersion = [NSString stringWithFormat:@"%@", [self.eAppVersionM objectAtIndex:path.row]];
        }
    }

    NSArray *array = [sData componentsSeparatedByString:@"\n"];

    NSLog(@"array %@", array);

//    NSString *ServerEappVersiontrim = [NSString stringWithFormat:@"%@", [array objectAtIndex:2]];
//
//    NSString *ServerEappVersion = [[[ServerEappVersiontrim stringByTrimmingCharactersInSet:
//                                   [NSCharacterSet whitespaceCharacterSet]] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"><"]] objectAtIndex:2];
//
//    NSString *ServerObsVersion  = [[[NSString stringWithFormat:@"%@", [array objectAtIndex:4]]componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"><"]] objectAtIndex:2];
//
//    NSString *ServerObsDateVersion  = [NSString stringWithFormat:@"%@", [array objectAtIndex:5]];
//    NSArray *ServerObservationDateArrayCollection = [ServerObsDateVersion componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"[]"]];
//    NSString *Serverdate = [NSString stringWithFormat:@"%@", [[ServerObsDateVersion componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"><"]] objectAtIndex:2]];

    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *CurrentdateString = [dateFormat stringFromDate:today];
    NSLog(@"date: %@", CurrentdateString);
//    NSString *Serverdate1 = Serverdate;


    NSComparisonResult result;
    //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending

//    result = [CurrentdateString
//              compare:Serverdate1]; // comparing two dates
//
//    if ([ServerEappVersion isEqualToString:@"(null)"] || [ServerEappVersion isEqualToString:@""] || ((NSNull *)ServerEappVersion == [NSNull null]) || ServerEappVersion == nil || [_LocalEappVersion isEqualToString:@"(null)"] || [_LocalEappVersion isEqualToString:@""] || ((NSNull *)_LocalEappVersion == [NSNull null]) || _LocalEappVersion == nil) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Error in connecting to Web services.Please try again later." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    } else if (([ServerEappVersion isEqualToString:_LocalEappVersion]) == YES) {
//        NSLog(@"here");
//        self.loginOuterView.hidden = NO;
//    } else if ([ServerObsVersion isEqualToString:_LocalEappVersion] == YES) {
//        if (result != NSOrderedDescending) {
//            NSLog(@"today is less");
//            self.loginOuterView.hidden = NO;
//        } else {
//            NSLog(@"newDate is less");
//            NSString *StringWithVersion = [NSString stringWithFormat:@"The selected eApp case is created based on older eApp Version. The version is now treated as obsolete, please recreate the case using new version.\nS: %@\nI: %@", ServerEappVersion, _LocalEappVersion];
//            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:StringWithVersion delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//    } else {
//        NSString *StringWithVersion = [NSString stringWithFormat:@"The selected eApp case is created based on older eApp Version. The version is now treated as obsolete, please recreate the case using new version.\nS: %@\nI: %@", ServerEappVersion, _LocalEappVersion];
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:StringWithVersion delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"" message:@"Error in connecting to Web service. Please check your internet connection" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];


    [myAlert show];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)loaadAppVersion {
    @try {
        NSString *strInput1 = @"IMSOLUTIONS";
        NSString *FeedURL = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx/GetAppVersion?Input1=%@", [SIUtilities WSLogin], strInput1];
        NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:FeedURL]];

        [NSURLConnection connectionWithRequest:theRequest delegate:self];
    } @catch (NSException *e) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"yescmg");
    } @finally {
    }
}

- (void)hideKeyboard {
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];


    [activeInstance performSelector:@selector(dismissKeyboard)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    NSLog(@"Self frame:%@", NSStringFromCGRect(self.view.frame));
}

- (void)ReloadTableData {
    //fmdb start
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];


    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"hladb.sqlite"]];
    FMDatabase *database = [FMDatabase databaseWithPath:databasePath];
    [database open];

    _POName = [[NSMutableArray alloc] init];
    _IDNo = [[NSMutableArray alloc] init];
    _ProposalNo = [[NSMutableArray alloc] init];
    _LastUpdated = [[NSMutableArray alloc] init];
    _AgentCode = [[NSMutableArray alloc] init];
    _Status = [[NSMutableArray alloc] init];
    _ClientName = [[NSMutableArray alloc] init];
    _SINo = [[NSMutableArray alloc] init];
    _planName = [[NSMutableArray alloc] init];
    _SIVersion = [[NSMutableArray alloc] init];
    _eAppVersionM = [[NSMutableArray alloc] init];
    _OtherIDNo  = [[NSMutableArray alloc] init];

    FMResultSet *results = [database executeQuery:@"select A.POName, A.IDNumber, A.OtherIDNo, A.ProposalNo, A.DateCreated, A.DateUpdated, B.eAppVersion, D.status,B.SINo, C.ProspectName, B.BasicPlanCode, B.SIVersion,E.AgentCode from eApp_Listing AS A, eProposal AS B, prospect_profile AS C ,eProposal_Status AS D,Agent_profile AS E, eProposal_Signature as F WHERE A.status = '3' AND A.ProposalNo = B.eProposalNo AND A.ClientProfileID = C.IndexNo AND A.status = D.StatusCode AND A.ProposalNo = F.eProposalNo order by F.DatePOSign ASC"];

    while ([results next]) {
        NSString *poname = [results stringForColumn:@"POName"];
        NSString *idno = [results stringForColumn:@"IDNumber"];
        NSString *proposalno = [results stringForColumn:@"ProposalNo"];

        NSString *lastupdated = [results stringForColumn:@"DateUpdated"];

        if ([lastupdated isEqualToString:@""] || lastupdated == Nil) {
            lastupdated = [results stringForColumn:@"DateCreated"];
        }

        NSString *status = [results stringForColumn:@"status"];
        NSString *agentcode = [results stringForColumn:@"AgentCode"];
        NSString *clientname = [results stringForColumn:@"ProspectName"];
        NSString *sino = [results stringForColumn:@"SINo"];
        NSString *plancode = [results stringForColumn:@"BasicPlanCode"];
        NSString *eappVersion = [results stringForColumn:@"eAppVersion"];
        NSString *otheridno = [results stringForColumn:@"OtherIDNo"];


        NSString *siversion = [results stringForColumn:@"SIVersion"];

        if ((NSNull *)siversion == [NSNull null]) {
            siversion = @"";
        }

        if ((NSNull *)poname == [NSNull null]) {
            poname = @"";
        }

        if ((NSNull *)idno == [NSNull null]) {
            idno = @"";
        }

        if (idno == nil) {
            idno = @"";
        }

        if ((NSNull *)otheridno == [NSNull null]) {
            otheridno = @"";
        }

        if ((NSNull *)eappVersion == [NSNull null]) {
            eappVersion = @"";
        }

        if (eappVersion == nil) {
            eappVersion = @"";
        }

        [_POName addObject:poname];
        [_IDNo addObject:idno];
        [_ProposalNo addObject:proposalno];
        [_LastUpdated addObject:lastupdated];
        [_Status addObject:status];
        [_AgentCode addObject:agentcode];
        [_ClientName addObject:clientname];
        [_SINo addObject:sino];
        [_planName addObject:plancode];
        [_SIVersion addObject:siversion];
        [_eAppVersionM addObject:eappVersion];
        [_OtherIDNo addObject:otheridno];
    }

    [database close];
    [self.pendingTableVew reloadData];

    //fmdb end
}

#pragma mark - Table View datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isSearching) {
        return self.ProposalNoSearch.count;
    } else {
        return self.ProposalNo.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *IDNo;
    NSString *otheridno;




    static NSString *cellIdentifier = @"Cell";
    PendingVCCell *cell = (PendingVCCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];


    if (cell == nil) {
        cell = [[PendingVCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    ColorHexCode *CustomColor = [[ColorHexCode alloc] init];
    cell.nameLabel.textColor = [UIColor blackColor];
    UIView *custom = [[UIView alloc] initWithFrame:CGRectMake(-30, 0, 30, 60)];
    [cell.contentView addSubview:custom];
    cell.idNOLabel.textColor = [UIColor blackColor];
    cell.siNOLabel.textColor = [UIColor blackColor];
    cell.proposalNOLabel.textColor = [UIColor blackColor];
    cell.creationDateLabel.textColor = [UIColor blackColor];
    cell.siVersionLabel.textColor = [UIColor blackColor];
    cell.eAppVersionLabel.textColor = [UIColor blackColor];
    cell.TimeRemainingLabel.textColor = [UIColor blackColor];
    cell.agentCodeLabel.textColor = [UIColor blackColor];

    if (isSearching) {
        cell.nameLabel.text = [self.PONameSearch objectAtIndex:indexPath.row];
        //cell.idNOLabel.text = [self.IDNoSearch objectAtIndex:indexPath.row];
        cell.siNOLabel.text = [self.SINoSearch objectAtIndex:indexPath.row];
        cell.proposalNOLabel.text = [self.ProposalNoSearch objectAtIndex:indexPath.row];
        cell.agentCodeLabel.text = [self.AgentCodeSearch objectAtIndex:indexPath.row];
        cell.creationDateLabel.text = [self.LastUpdatedSearch objectAtIndex:indexPath.row];
        cell.siVersionLabel.text = [self.SIVersionSearch objectAtIndex:indexPath.row];
        cell.eAppVersionLabel.text = [self.eAppVersionMSearch objectAtIndex:indexPath.row];
        cell.TimeRemainingLabel.text = @" ";
        IDNo = [self.IDNoSearch objectAtIndex:indexPath.row];
        otheridno = [self.OtherIDNoSearch objectAtIndex:indexPath.row];
    } else {
        cell.nameLabel.text = [self.POName objectAtIndex:indexPath.row];
        //cell.idNOLabel.text = [self.IDNo objectAtIndex:indexPath.row];
        cell.siNOLabel.text = [self.SINo objectAtIndex:indexPath.row];
        cell.proposalNOLabel.text = [self.ProposalNo objectAtIndex:indexPath.row];
        cell.agentCodeLabel.text = [self.AgentCode objectAtIndex:indexPath.row];
        cell.creationDateLabel.text = [self.LastUpdated objectAtIndex:indexPath.row];
        cell.siVersionLabel.text = [self.SIVersion objectAtIndex:indexPath.row];
        cell.eAppVersionLabel.text = [self.eAppVersionM objectAtIndex:indexPath.row];
        cell.TimeRemainingLabel.text = @" ";
        IDNo = [self.IDNo objectAtIndex:indexPath.row];
        otheridno = [self.OtherIDNo objectAtIndex:indexPath.row];

        NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsPath1 = [paths1 objectAtIndex:0];
        NSString *path1 = [docsPath1 stringByAppendingPathComponent:@"hladb.sqlite"];


        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *path = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];

        FMDatabase *db = [FMDatabase databaseWithPath:path];

        if (![db open]) {
            NSLog(@"Could not open db.");
            db = [FMDatabase databaseWithPath:path];

            [db open];
        }

        NSString *isPOSign;
        NSString *DatePOSign;



        FMResultSet *result_eSign = [db executeQuery:@"SELECT * from eProposal_Signature WHERE eProposalNo = ? ", cell.proposalNOLabel.text];

        isPOSign = [result_eSign stringForColumn:@"isPOSign"];

        while ([result_eSign next]) {
            isPOSign = [result_eSign stringForColumn:@"isPOSign"];
            DatePOSign = [result_eSign stringForColumn:@"DatePOSign"];

            if ((NSNull *)isPOSign == [NSNull null] || [isPOSign isEqualToString:@""]) {
                isPOSign = @"";
            }

            if ((NSNull *)DatePOSign == [NSNull null] || [DatePOSign isEqualToString:@""]) {
                DatePOSign = @"";
            }

            NSString *dateString1 = DatePOSign;

            NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
            // this is imporant - we set our input date format to match our input string
            // if format doesn't match you'll get nil from your string, so be careful
            [dateFormatter1 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
            NSDate *dateFromString1 = [[NSDate alloc] init];
            // voila!
            dateFromString1 = [dateFormatter1 dateFromString:dateString1];
            NSDate *FinalDate = [dateFromString1 dateByAddingTimeInterval:-3600 * 16];
            NSLog(@"dttt %@", dateFromString1);
            NSLog(@"dyyy %@", FinalDate);

            NSString *strNewDate;
            NSString *strCurrentDate;
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df setDateStyle:NSDateFormatterMediumStyle];
            [df setTimeStyle:NSDateFormatterMediumStyle];
            strCurrentDate = [df stringFromDate:FinalDate];
            NSLog(@"Current Date and Time: %@", strCurrentDate);
            int hoursToAdd = 136;
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *components = [[NSDateComponents alloc] init];
            [components setHour:hoursToAdd];
            NSDate *newDate = [calendar dateByAddingComponents:components toDate:FinalDate options:0];

            [df setDateFormat:@"dd/MM/YYYY HH:mm:ss"];
            strNewDate = [df stringFromDate:newDate];
            NSLog(@"New Date and Time: %@", strNewDate);

            //for Time Remaining
            NSDate *mydate = [NSDate date];
            NSTimeInterval secondsInEightHours = 8 * 60 * 60;
            NSDate *currentDate = [mydate dateByAddingTimeInterval:secondsInEightHours];
            NSDate *expireDate = [newDate dateByAddingTimeInterval:secondsInEightHours];

            int countdown = -[currentDate timeIntervalSinceDate:expireDate]; //pay attention here.
            int minutes = (countdown / 60) % 60;
            int hours = (countdown / 3600) % 24;
            int days = (countdown / 86400) % 30;

            NSComparisonResult result;
            //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending

            result = [currentDate compare:expireDate]; // comparing two dates

            if (result == NSOrderedAscending) {
                NSLog(@"today is less");
                cell.TimeRemainingLabel.text = [NSString stringWithFormat:@" %d days %d hours %d mins ", days, hours, minutes];
                cell.TimeRemainingLabel.textColor = [UIColor blackColor];
            } else if (result == NSOrderedDescending) {
                NSLog(@"newDate is less");
                cell.TimeRemainingLabel.text = [NSString stringWithFormat:@" Expired                                       "];
                cell.TimeRemainingLabel.textColor = [UIColor redColor];
				cell.toViewButton.hidden = TRUE;
            } else {
                NSLog(@"Both dates are same");
                cell.TimeRemainingLabel.text = [NSString stringWithFormat:@" %d hours %d mins ", hours, minutes];
                cell.TimeRemainingLabel.textColor = [UIColor redColor];
                NSLog(@"Both dates are same");
            }

            cellSelectedExpired = cell.TimeRemainingLabel.text;
        }
    }

    cell.toViewButton.tag = indexPath.row;
    [cell.toViewButton addTarget:self action:@selector(toViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    if (![otheridno isEqualToString:@""] && ![IDNo isEqualToString:@""]) {
        [cell.idNOLabel setNumberOfLines:2];
        cell.idNOLabel.text = [NSString stringWithFormat:@"%@\n%@", IDNo, otheridno];
    } else if (![IDNo isEqualToString:@""]) {
        [cell.idNOLabel setNumberOfLines:1];
        cell.idNOLabel.text = IDNo;
    } else if (![otheridno isEqualToString:@""]) {
        [cell.idNOLabel setNumberOfLines:1];
        cell.idNOLabel.text = otheridno;
    }

    cell.idNOLabel.tag = 2002;

    [cell.contentView addSubview:cell.idNOLabel];

    if (indexPath.row % 2) {
        cell.contentView.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        custom.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
    } else {
        cell.contentView.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        custom.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.pendingTableVew isEditing] == TRUE) {
        BOOL gotRowSelected = FALSE;

        for (UITableViewCell *zzz in [self.pendingTableVew visibleCells]) {
            if (zzz.selected  == TRUE) {
                gotRowSelected = TRUE;

                break;
            }
        }

        if (!gotRowSelected) {
            [_btnDelete setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];

            _btnDelete.enabled = FALSE;
        } else {
            [_btnDelete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

            _btnDelete.enabled = TRUE;
        }

        NSString *zzz = [NSString stringWithFormat:@"%d", indexPath.row];

        [ItemToBeDeleted addObject:zzz];

        [indexPaths addObject:indexPath];
    }

    self.submitButton.enabled = YES;
    self.submitButton.alpha = 1.0;

    if ([selectedRecords containsObject:indexPath]) {
        [selectedRecords removeObject:indexPath];
    } else {
        [selectedRecords addObject:indexPath];
    }

    int RecCount = 0;

    for (UITableViewCell *cell in [self.pendingTableVew visibleCells]) {
        if (cell.selected == TRUE) {
            NSIndexPath *selectedIndexPath = [self.pendingTableVew indexPathForCell:cell];

            RecCount = RecCount + 1;

            if (RecCount > 2) {
                cell.selected = FALSE;
            }
        }
    }

    NSLog(@"RecCount: %d", RecCount);
}

- (void)toViewButtonAction:(id)sender {
    NSString *proposalNUmber;
    NSString *siNumber;
    NSString *siplanename;
    NSString *siversion;
    UIButton *selectedCellButton = (UIButton *)sender;


    if (isSearching) {
        proposalNUmber = _ProposalNoSearch[selectedCellButton.tag];
        [[obj.eAppData objectForKey:@"EAPP"] setValue:proposalNUmber forKey:@"eProposalNo"];
        siNumber = _SINoSearch[selectedCellButton.tag];
    } else {
        proposalNUmber = _ProposalNo[selectedCellButton.tag];
        [[obj.eAppData objectForKey:@"EAPP"] setValue:proposalNUmber forKey:@"eProposalNo"];
        siNumber = _SINoSearch[selectedCellButton.tag];
        siplanename = _planName[selectedCellButton.tag];
    }

    obj = [DataClass getInstance];

    NSLog(@"Eapp dic is ===%@", [obj.eAppData objectForKey:@"EAPP"]);

    if (obj.eAppData == nil) {
        obj.eAppData = [NSMutableDictionary new];

        NSMutableDictionary *eappDic = [NSMutableDictionary new];
        [eappDic setObject:proposalNUmber forKey:@"eProposalNo"];
        [eappDic setObject:proposalNUmber forKey:@"SINo"];
        [eappDic setObject:siplanename forKey:@"SIPlanName"];
        [obj.eAppData setObject:eappDic forKey:@"EAPP"];
    }

    if ([obj.eAppData objectForKey:@"EAPP"] == nil) {
    }

    NSLog(@"Eapp dic is ===%@", [obj.eAppData objectForKey:@"EAPP"]);


    NSLog(@"toview tag=%i and eapp number =%@", selectedCellButton.tag, [[obj.eAppData objectForKey:@"EAPP"] valueForKey:@"eProposalNo"]);
    NSLog(@"toview tag=%i and eapp number =%@", selectedCellButton.tag, _ProposalNo);
    NSLog(@"toview tag=%i and eapp number =%@", selectedCellButton.tag, _ProposalNo[selectedCellButton.tag]);


    UIStoryboard *main = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:nil];
    AppDelegate *appobject = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appobject.ViewFromPendingBool = YES;
    appobject.ViewDeleteSubmissionBool = YES;
    eAppReport *report =  [main instantiateViewControllerWithIdentifier:@"eAppReport"];

    report.modalPresentationStyle = UIModalPresentationFullScreen;
    report.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:report animated:YES completion:NULL];
    report = Nil;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *selectedIndexPaths = [tableView indexPathsForSelectedRows];


    if (!selectedIndexPaths) {
        self.submitButton.enabled = YES;
        self.submitButton.alpha = 0.4;
    }

    if ([selectedRecords containsObject:indexPath]) {
        [selectedRecords removeObject:indexPath];
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (IBAction)submitCancelButtonClicked:(id)sender {
    UIButton *localButton = (UIButton *)sender;


    if ([[localButton titleForState:UIControlStateNormal] isEqualToString:@"Submit"]) {
        [self.pendingTableVew setEditing:YES animated:YES];
        [localButton setTitle:@"Cancel" forState:UIControlStateNormal];
        self.submitButton.hidden = NO;
        self.submitButton.enabled = NO;
        self.submitButton.alpha = 0.4;
    } else {
        [self.pendingTableVew setEditing:NO animated:YES];
        [localButton setTitle:@"Submit" forState:UIControlStateNormal];
        self.submitButton.hidden = YES;
    }
}

- (void)submitAfterSuccessFulllogin {
    ///////// 1----- Selected records stored in arrray --------    selectedRecords


    ///////// 2----- Calling getSubmiionvalue service and storing in dictionary-----   dictSubmisionval


    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"Please wait while we processing your request.";
    HUD.detailsLabelText = @"( If it takes more than 5 minutes, please exit the application and try again. )";
    [HUD show:YES];

    xmlType = XML_TYPE_GET_SUBMISSION_VALUE;

    NSString *passcode = @"UAT1234567890";
    NSString *source = @"IAPP(S)";

    //webservices
    NSString *strURL = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx?wsdl", [SIUtilities WSLogin]];

    NSString *strXML = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?> <soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body> <GetSubmissionValue xmlns='http://tempuri.org/'><strPassCode>%@</strPassCode><strSource>%@</strSource></GetSubmissionValue></soap:Body></soap:Envelope>", passcode, source];

    NSURL *url = [NSURL URLWithString:strURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"http://tempuri.org/GetSubmissionValue" forHTTPHeaderField:@"SOAPAction"];
    NSString *msgLenght = [NSString stringWithFormat:@"%d", [strXML length]];
    [request addValue:msgLenght forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[strXML dataUsingEncoding:NSUTF8StringEncoding]];

    // Operation
    AFXMLRequestOperation *operation1 = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
        XMLParser.delegate = self;
        [XMLParser setShouldProcessNamespaces:YES];
        [XMLParser parse];

        NSLog([_svdata valueForKey:@"EncryptedPassPhrase"]);
        NSLog([_svdata valueForKey:@"EncryptedSaltValue"]);
        NSLog([_svdata valueForKey:@"EncryptedHashAlgorithm"]);
        NSLog([_svdata valueForKey:@"EncryptedPasswordIteration"]);
        NSLog([_svdata valueForKey:@"EncryptedInitialationVector"]);
        NSLog([_svdata valueForKey:@"EncryptedKeySize"]);

        NSLog([_Logindata valueForKey:@"LoginErrorDescription"]);
        NSLog([_Logindata valueForKey:@"Failedattempts"]);
        NSLog([_Logindata valueForKey:@"FirstAgtCode"]);

        BOOL success;
        CkoCrypt2 *crypt;
        CkoCrypt2 *crypt2;

        // Do any additional setup after loading the view, typically from a nib.
        crypt = [[CkoCrypt2 alloc] init];


        success = [crypt UnlockComponent:@"KUANKHCrypt_vD3vem6YMZjk"];

        if (success != YES) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ChilkatSample" message:@"Crypt library unlock failed" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }

        //do not change start
        //Decrypt string parameters
        NSString *key;
        key = @"Pas5pr@se";

        NSString *iv;
        iv = @"@1B2c3D4e5F6g7H8";

        NSString *salt;
        salt = @"s@1tValue";

        crypt.CryptAlgorithm = @"SHA1";
        crypt.CipherMode = @"cbc";
        crypt.KeyLength = [NSNumber numberWithInt:256];
        crypt.PaddingScheme = [NSNumber numberWithInt:0];

        [crypt SetEncodedKey:key encoding:@"ascii"];
        [crypt SetEncodedIV:iv encoding:@"ascii"];
        [crypt SetEncodedSalt:salt encoding:@"ascii"];

        EncryptedPassPhrase = [_svdata valueForKey:@"EncryptedPassPhrase"];
        EncryptedSaltValue = [_svdata valueForKey:@"EncryptedSaltValue"];
        EncryptedHashAlgorithm = [_svdata valueForKey:@"EncryptedHashAlgorithm"];
        EncryptedPasswordIteration = [_svdata valueForKey:@"EncryptedPasswordIteration"];
        EncryptedInitialationVector = [_svdata valueForKey:@"EncryptedInitialationVector"];
        EncryptedKeySize = [_svdata valueForKey:@"EncryptedKeySize"];

        DecryptedPassPhrase = [crypt DecryptStringENC:[_svdata valueForKey:@"EncryptedPassPhrase"]];
        DecryptedSaltValue = [crypt DecryptStringENC:[_svdata valueForKey:@"EncryptedSaltValue"]];
        DecryptedHashAlgorithm = [crypt DecryptStringENC:[_svdata valueForKey:@"EncryptedHashAlgorithm"]];
        DecryptedPasswordIteration = [crypt DecryptStringENC:[_svdata valueForKey:@"EncryptedPasswordIteration"]];
        DecryptedInitialationVector = [crypt DecryptStringENC:[_svdata valueForKey:@"EncryptedInitialationVector"]];
        DecryptedKeySize = [crypt DecryptStringENC:[_svdata valueForKey:@"EncryptedKeySize"]];
        NSLog(@"Encryption Done!");


        ///// fetching document directory path
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];

        NSString *FormsPath =  [documentsDirectory stringByAppendingPathComponent:@"Forms"];


        crypt2 = [[CkoCrypt2 alloc] init];


        success = [crypt2 UnlockComponent:@"KUANKHCrypt_vD3vem6YMZjk"];

        if (success != YES) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ChilkatSample" message:@"Crypt library unlock failed" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }

        //do not change start
        //Decrypt files parameters
        NSString *key2;
        key2 = DecryptedPassPhrase;

        NSString *salt2;
        salt2 = DecryptedSaltValue;

        NSString *test3 = DecryptedHashAlgorithm;

        NSString *test1 = DecryptedPasswordIteration;

        NSString *test2 = DecryptedKeySize;

        NSString *iv2;
        iv2 = DecryptedInitialationVector;


        crypt2.CryptAlgorithm = @"SHA1";
        crypt2.CipherMode = @"cbc";
        crypt2.KeyLength = [NSNumber numberWithInt:256];
        crypt2.PaddingScheme = [NSNumber numberWithInt:0];

        [crypt2 SetEncodedKey:key2 encoding:@"ascii"];
        [crypt2 SetEncodedIV:iv2 encoding:@"ascii"];
        [crypt2 SetEncodedSalt:salt2 encoding:@"ascii"];

        /////// second array
        for (NSIndexPath *path in selectedRecords) {
            NSMutableDictionary *recordDic = [[NSMutableDictionary alloc] init];
            NSMutableArray *selectedItems = [[NSMutableArray alloc] init];

            if (isSearching) {
                [recordDic setObject:[self.ClientNameSearch objectAtIndex:path.row] forKey:@"name"];
                [recordDic setObject:[self.IDNoSearch objectAtIndex:path.row] forKey:@"IDNo"];
                [recordDic setObject:[self.SINoSearch objectAtIndex:path.row] forKey:@"SINo"];
                [recordDic setObject:[self.ProposalNoSearch objectAtIndex:path.row] forKey:@"ProposalNo"];
                [recordDic setObject:[self.LastUpdatedSearch objectAtIndex:path.row] forKey:@"LastUpdated"];
                [recordDic setObject:[self.SIVersionSearch objectAtIndex:path.row] forKey:@"SIVersion"];
                [recordDic setObject:[self.eAppVersionMSearch objectAtIndex:path.row] forKey:@"eAppVersion"];
            } else {
                [recordDic setObject:[self.ClientName objectAtIndex:path.row] forKey:@"name"];
                [recordDic setObject:[self.IDNo objectAtIndex:path.row] forKey:@"IDNo"];
                [recordDic setObject:[self.SINo objectAtIndex:path.row] forKey:@"SINo"];
                [recordDic setObject:[self.ProposalNo objectAtIndex:path.row] forKey:@"ProposalNo"];
                [recordDic setObject:[self.LastUpdated objectAtIndex:path.row] forKey:@"LastUpdated"];
                [recordDic setObject:[self.SIVersion objectAtIndex:path.row] forKey:@"SIVersion"];
                [recordDic setObject:[self.eAppVersionM objectAtIndex:path.row] forKey:@"eAppVersion"];
            }

            // This variable is for ID file count to be included into complete.xml
            int ID_count = 0;



            //////////   checking for forms and xml on e Proposal
            NSString *pr =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_PR.pdf", [recordDic objectForKey:@"ProposalNo"]]];

            if ([[NSFileManager defaultManager] fileExistsAtPath:pr]) {
                [selectedItems addObject:pr];
            }

            NSString *sp =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_SP_1.pdf", [recordDic objectForKey:@"ProposalNo"]]];

            if ([[NSFileManager defaultManager] fileExistsAtPath:sp]) {
                [selectedItems addObject:sp];
            }

            NSString *si =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_SI.pdf", [recordDic objectForKey:@"ProposalNo"]]];

            if ([[NSFileManager defaultManager] fileExistsAtPath:si]) {
                [selectedItems addObject:si];
            }

            NSString *id1 =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_ID_LA1.pdf", [recordDic objectForKey:@"ProposalNo"]]];

            if ([[NSFileManager defaultManager] fileExistsAtPath:id1]) {
                [selectedItems addObject:id1];
                ID_count = ID_count + 1;
            }

            NSString *id2 =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_ID_LA2.pdf", [recordDic objectForKey:@"ProposalNo"]]];

            if ([[NSFileManager defaultManager] fileExistsAtPath:id2]) {
                [selectedItems addObject:id2];
                ID_count = ID_count + 1;
            }

            NSString *id3 =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_ID_PO.pdf", [recordDic objectForKey:@"ProposalNo"]]];

            if ([[NSFileManager defaultManager] fileExistsAtPath:id3]) {
                [selectedItems addObject:id3];
                ID_count = ID_count + 1;
            }

            NSString *id4 =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_ID_CO.pdf", [recordDic objectForKey:@"ProposalNo"]]];

            if ([[NSFileManager defaultManager] fileExistsAtPath:id4]) {
                [selectedItems addObject:id4];
                ID_count = ID_count + 1;
            }

            NSString *id5 =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_ID_TR1.pdf", [recordDic objectForKey:@"ProposalNo"]]];

            if ([[NSFileManager defaultManager] fileExistsAtPath:id5]) {
                [selectedItems addObject:id5];
                ID_count = ID_count + 1;
            }

            NSString *id6 =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_ID_TR2.pdf", [recordDic objectForKey:@"ProposalNo"]]];

            if ([[NSFileManager defaultManager] fileExistsAtPath:id6]) {
                [selectedItems addObject:id6];
                ID_count = ID_count + 1;
            }

            NSString *id7 =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_ID_GD.pdf", [recordDic objectForKey:@"ProposalNo"]]];

            if ([[NSFileManager defaultManager] fileExistsAtPath:id7]) {
                [selectedItems addObject:id7];
                ID_count = ID_count + 1;
            }

            NSString *id8 =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_ID_CFP.pdf", [recordDic objectForKey:@"ProposalNo"]]];

            if ([[NSFileManager defaultManager] fileExistsAtPath:id8]) {
                [selectedItems addObject:id8];
                ID_count = ID_count + 1;
            }

            NSString *id9 =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_ID_CRP.pdf", [recordDic objectForKey:@"ProposalNo"]]];

            if ([[NSFileManager defaultManager] fileExistsAtPath:id9]) {
                [selectedItems addObject:id9];
                ID_count = ID_count + 1;
            }

            NSString *ff =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_FF.pdf", [recordDic objectForKey:@"ProposalNo"]]];

            if ([[NSFileManager defaultManager] fileExistsAtPath:ff]) {
                [selectedItems addObject:ff];
            }

            NSString *ca =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_CA.pdf", [recordDic objectForKey:@"ProposalNo"]]];

            if ([[NSFileManager defaultManager] fileExistsAtPath:ca]) {
                [selectedItems addObject:ca];
            }

            NSString *au =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_AU.pdf", [recordDic objectForKey:@"ProposalNo"]]];

            if ([[NSFileManager defaultManager] fileExistsAtPath:au]) {
                [selectedItems addObject:au];
            }

            NSString *sixml =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"SIXML/%@_SI.xml", [recordDic objectForKey:@"ProposalNo"]]];

            if ([[NSFileManager defaultManager] fileExistsAtPath:sixml]) {
                [selectedItems addObject:sixml];
            }

            NSString *prxml =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"ProposalXML/%@_PR.xml", [recordDic objectForKey:@"ProposalNo"]]];

            if ([[NSFileManager defaultManager] fileExistsAtPath:prxml]) {
                [selectedItems addObject:prxml];
            }

            // generating COMPLETE.XML
            NSString *agentCode1 = [self.AgentCode objectAtIndex:path.row];

            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *docsPath = [paths objectAtIndex:0];
            NSString *path1 = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];

            FMDatabase *db = [FMDatabase databaseWithPath:path1];
            [db open];

            NSString *eProposalNo = [recordDic objectForKey:@"ProposalNo"];
            NSString *POOtherIDType;
            NSString *selectPO = [NSString stringWithFormat:@"SELECT LAOtherIDType FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'", eProposalNo];
            int cffindicator;
            FMResultSet *results;
            results = [db executeQuery:selectPO];

            while ([results next]) {
                POOtherIDType = [results objectForColumnName:@"LAOtherIDType"];
            }

            //ecffinfo
            if ([POOtherIDType isEqualToString:@"CR"]) {
                cffindicator = 0;
            } else {
                cffindicator = 1;
            }

            NSString *completeString = [NSString stringWithFormat:@"%@;%d;%d;%d;%d;", agentCode1, 0, cffindicator, 0, ID_count]; //A0030269;0;1;0;

            [completeString writeToFile:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_Complete.xml",eProposalNo]] atomically:YES encoding:NSUTF8StringEncoding error:nil];

            // generating COMPLETE.XML - END

            NSString *cmpxml =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_Complete.xml", [recordDic objectForKey:@"ProposalNo"]]];

            if ([[NSFileManager defaultManager] fileExistsAtPath:cmpxml]) {
                [selectedItems addObject:cmpxml];
            }

            //encrypt file
            if (![[NSFileManager defaultManager] fileExistsAtPath:[[selectedItems objectAtIndex:0] stringByAppendingString:@".enc"]]) {
                [[NSFileManager defaultManager] createFileAtPath:[[selectedItems objectAtIndex:0] stringByAppendingString:@".enc"] contents:[NSData data] attributes:nil];
            }

            BOOL issuccess = [crypt2 CkEncryptFile:[selectedItems objectAtIndex:0] destFile:[[selectedItems objectAtIndex:0] stringByAppendingString:@".enc"]];

            if (issuccess) {
                NSLog(@"suc");
            } else {
                NSLog(@"fail");
            }

            //convert to byte
            NSData *data = [[NSData alloc] initWithContentsOfFile:[[selectedItems objectAtIndex:0] stringByAppendingString:@".enc"]];


            // using base64StringFromData method, we are able to convert data to string
            NSString *str = [NSString base64StringFromData:data length:[data length]];
            NSLog(@"Converting form and xml to base64 - ENC???");
            // log the base64 encoded string


            NSString *sourceName = @"IAPP(S)";
            NSString *agentCode =  [self.AgentCode objectAtIndex:path.row];


            NSString *docpath = [selectedItems objectAtIndex:0];

            NSArray *split = [docpath componentsSeparatedByString:@"/"];

            NSString *docname = [split objectAtIndex:[split count] - 1];
			
			NSArray *SplitB = [docname componentsSeparatedByString:@"_"];
			NSString *docCheck = [SplitB objectAtIndex:[SplitB count] - 1];
			if ([docCheck isEqualToString:@"Complete.xml"]) {
				docname = @"Complete.xml";
			}




            //webservices
            NSString *strURL2 = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx?wsdl", [SIUtilities WSLogin]];

            NSString *strXML2 = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><SaveDocumentWithLog_TRADUL xmlns='http://tempuri.org/'><docbinaryarray>%@</docbinaryarray><docname>%@</docname><strParentFolder>%@</strParentFolder><strSubmittedAgentCode>%@</strSubmittedAgentCode><intTotalSupplementaryForm>%d</intTotalSupplementaryForm><intTotalCFFForm>%d</intTotalCFFForm><strSourceName>%@</strSourceName><intTotalIDForm>%d</intTotalIDForm></SaveDocumentWithLog_TRADUL></soap:Body></soap:Envelope>", str, docname, [recordDic objectForKey:@"ProposalNo"], agentCode, 0, cffindicator, sourceName, ID_count];

            NSURL *url = [NSURL URLWithString:strURL2];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            [request addValue:@"http://tempuri.org/SaveDocumentWithLog_TRADUL" forHTTPHeaderField:@"SOAPAction"];
            NSString *msgLenght = [NSString stringWithFormat:@"%d", [strXML2 length]];
            [request addValue:msgLenght forHTTPHeaderField:@"Content-Length"];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:[strXML2 dataUsingEncoding:NSUTF8StringEncoding]];


            // Operation
            AFXMLRequestOperation *operation2 = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
                    NSLog(@"SaveDocWithLog");
                    int count = 0;

                    for (int i = 0; i < [selectedItems count]; i++) {
                        count = count + 1;

                        if (i != 0) {
                            if (![[NSFileManager defaultManager] fileExistsAtPath:[[selectedItems objectAtIndex:i] stringByAppendingString:@".enc"]]) {
                                [[NSFileManager defaultManager] createFileAtPath:[[selectedItems objectAtIndex:i] stringByAppendingString:@".enc"] contents:[NSData data] attributes:nil];
                            }

                            [crypt2 CkEncryptFile:[selectedItems objectAtIndex:i] destFile:[[selectedItems objectAtIndex:i] stringByAppendingString:@".enc"]];
                            [data initWithContentsOfFile:[[selectedItems objectAtIndex:i] stringByAppendingString:@".enc"]];
                            // using base64StringFromData method, we are able to convert data to string
                            NSString *str2 = [NSString base64StringFromData:data length:[data length]];
                            NSString *strURL3 = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx?wsdl", [SIUtilities WSLogin]];
                            NSString *docpath = [selectedItems objectAtIndex:i];
                            NSArray *split = [docpath componentsSeparatedByString:@"/"];
                            NSString *docname = [split objectAtIndex:[split count] - 1];
							
							NSArray *SplitB = [docname componentsSeparatedByString:@"_"];
							NSString *docCheck = [SplitB objectAtIndex:[SplitB count] - 1];
							if ([docCheck isEqualToString:@"Complete.xml"]) {
								docname = @"Complete.xml";
							}

                            NSString *strXML3 = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><SaveDocument xmlns='http://tempuri.org/'><docbinaryarray>%@</docbinaryarray><docname>%@</docname><strParentFolder>%@</strParentFolder><strSourceName>%@</strSourceName></SaveDocument></soap:Body></soap:Envelope>", str2, docname, [recordDic objectForKey:@"ProposalNo"], sourceName];
                            NSURL *url = [NSURL URLWithString:strURL3];
                            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
                            [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
                            [request addValue:@"http://tempuri.org/SaveDocument" forHTTPHeaderField:@"SOAPAction"];
                            NSString *msgLenght = [NSString stringWithFormat:@"%d", [strXML3 length]];
                            [request addValue:msgLenght forHTTPHeaderField:@"Content-Length"];
                            [request setHTTPMethod:@"POST"];
                            [request setHTTPBody:[strXML3 dataUsingEncoding:NSUTF8StringEncoding]];
                            // Operation
                            AFXMLRequestOperation *operation3 = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
                                    NSLog(@"SaveDoc - %d", i);

                                    if (count >= [selectedItems count]) {
                            //webservices
                                        NSString *strURL4 = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx?wsdl", [SIUtilities WSLogin]];
                                        NSString *strXML4 = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><InsertSubmissionListing xmlns='http://tempuri.org/'><strProposalNo>%@</strProposalNo><strSubmittedAgentCode>%@</strSubmittedAgentCode><intTotalSupplementaryForm>%d</intTotalSupplementaryForm><intTotalCFFForm>%d</intTotalCFFForm><strSourceName>%@</strSourceName><intTotalIDForm>%d</intTotalIDForm></InsertSubmissionListing></soap:Body></soap:Envelope>", [recordDic objectForKey:@"ProposalNo"], agentCode, 0, cffindicator, sourceName, ID_count];
                                        NSURL *url = [NSURL URLWithString:strURL4];
                                        NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:url];
                                        [request2 addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
                                        [request2 addValue:@"http://tempuri.org/InsertSubmissionListing" forHTTPHeaderField:@"SOAPAction"];
                                        NSString *msgLenght = [NSString stringWithFormat:@"%d", [strXML4 length]];
                                        [request2 addValue:msgLenght forHTTPHeaderField:@"Content-Length"];
                                        [request2 setHTTPMethod:@"POST"];
                                        [request2 setHTTPBody:[strXML4 dataUsingEncoding:NSUTF8StringEncoding]];
                                        // Operation
                                        AFXMLRequestOperation *operation4 = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request2 success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
                                                NSLog(@"InsertSubmissionListing");
                                        //update record status to submitted.
                                        //fmdb start
                                                NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                                NSString *docsDir = [dirPaths objectAtIndex:0];
                                                databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"hladb.sqlite"]];
                                                sqlite3_stmt *statement;

                                                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                                NSDate *currDate = [NSDate date];
                                                [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
                                                NSString *dateString = [dateFormatter stringFromDate:currDate];

                                                if (sqlite3_open([databasePath UTF8String], &updateDB) == SQLITE_OK) {
                                                    NSString *updatetSQL = [NSString stringWithFormat:@"update eApp_Listing SET Status='4', SubmitDate = '%@' WHERE ProposalNo='%@'", dateString, [recordDic objectForKey:@"ProposalNo"]];

                                                    if (sqlite3_prepare_v2(updateDB, [updatetSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                                                        if (sqlite3_step(statement) == SQLITE_DONE) {
                                                            NSLog(@"Update eapplisting status success!");

                                                            self.loginOuterView.hidden = YES;

                                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Proposal(s) has been submitted successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                            alert.tag = 10;
                                                            [alert show];
                                                            alert = Nil;

                                                            [self deleteencFiles];
                                                            [self reloadAfterSubmission];
                                                        } else {
                                                            NSLog(@"Update eapplisting status fail!");
                                                        }

                                                        sqlite3_finalize(statement);
                                                    }

                                                    sqlite3_close(updateDB);
                                                    [self ReloadTableData];
                                                }

                                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                [HUD hide:YES afterDelay:1];
                                            }

                                                                                                                                failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
                                                NSLog(@"Error:%@", [error localizedDescription]);
                                                NSLog(@"error in calling web service - updatesubmissiontflag");
                                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Error in connecting to Web service. You will now be logged in as offline mode." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                alert.tag = 10;
                                                [alert show];
                                                alert = Nil;
                                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                [HUD hide:YES afterDelay:1];
                                            }];
                                        [operation4 start];
                                    }
                                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
                                    NSLog(@"error in calling web service - Save Document");
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Error in connecting to Web service. You will now be logged in as offline mode." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                    alert.tag = 10;
                                    [alert show];
                                    alert = Nil;
                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                    [HUD hide:YES afterDelay:1];
                                }];
                            [operation3 start];
                        }
                    }
                }

                                                                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
                    NSLog(@"Error:%@", [error localizedDescription]);
                    NSLog(@"error in calling web service - Save Document With Log");
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Error in connecting to Web service. You will now be logged in as offline mode." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    alert.tag = 10;
                    [alert show];
                    alert = Nil;

                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [HUD hide:YES afterDelay:1];
                }];
            [operation2 start];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
        NSLog(@"error in calling web service - submission value");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Error in connecting to Web service. You will now be logged in as offline mode." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 10;
        [alert show];

        alert = Nil;

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [HUD hide:YES afterDelay:1];
    }];

    [operation1 start];
}

- (void)submitAfterSuccessFulllogin2
{
//	 HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    HUD.labelText = @"Please wait while we processing your request.";
//    HUD.detailsLabelText = @"( If it takes more than 5 minutes, please exit the application and try again. )";
//    [HUD show:YES];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *strDoc = @"";
	NSString *strFolder = @"Folder";
	NSString *strSource = @"IPPS";
	
	int count = 0;
	//	count = count + 1;
	
	for (NSIndexPath *path in selectedRecords) {
		NSMutableDictionary *recordDic = [[NSMutableDictionary alloc] init];
		NSMutableArray *selectedItems = [[NSMutableArray alloc] init];
		
		
		
		if (isSearching) {
			[recordDic setObject:[self.ClientNameSearch objectAtIndex:path.row] forKey:@"name"];
			[recordDic setObject:[self.IDNoSearch objectAtIndex:path.row] forKey:@"IDNo"];
			[recordDic setObject:[self.SINoSearch objectAtIndex:path.row] forKey:@"SINo"];
			[recordDic setObject:[self.ProposalNoSearch objectAtIndex:path.row] forKey:@"ProposalNo"];
			//			[recordDic setObject:@"RN150915115319761" forKey:@"ProposalNo"];
			[recordDic setObject:[self.LastUpdatedSearch objectAtIndex:path.row] forKey:@"LastUpdated"];
			[recordDic setObject:[self.SIVersionSearch objectAtIndex:path.row] forKey:@"SIVersion"];
			[recordDic setObject:[self.eAppVersionMSearch objectAtIndex:path.row] forKey:@"eAppVersion"];
		} else {
			[recordDic setObject:[self.ClientName objectAtIndex:path.row] forKey:@"name"];
			[recordDic setObject:[self.IDNo objectAtIndex:path.row] forKey:@"IDNo"];
			[recordDic setObject:[self.SINo objectAtIndex:path.row] forKey:@"SINo"];
			[recordDic setObject:[self.ProposalNo objectAtIndex:path.row] forKey:@"ProposalNo"];
			//			[recordDic setObject:@"RN150915115319761" forKey:@"ProposalNo"];
			[recordDic setObject:[self.LastUpdated objectAtIndex:path.row] forKey:@"LastUpdated"];
			[recordDic setObject:[self.SIVersion objectAtIndex:path.row] forKey:@"SIVersion"];
			[recordDic setObject:[self.eAppVersionM objectAtIndex:path.row] forKey:@"eAppVersion"];
		}
		
		// This variable is for ID file count to be included into complete.xml
		int ID_count = 0;
		
		
		
		//////////   checking for forms and xml on e Proposal
		NSString *pr =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_PR.pdf", [recordDic objectForKey:@"ProposalNo"]]];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:pr]) {
			[selectedItems addObject:pr];
			ID_count = ID_count + 1;
			
		}
		
		NSString *sp =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_SP_1.pdf", [recordDic objectForKey:@"ProposalNo"]]];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:sp]) {
			[selectedItems addObject:sp];
			ID_count = ID_count + 1;
		}
		
		NSString *si =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_SI.pdf", [recordDic objectForKey:@"ProposalNo"]]];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:si]) {
			[selectedItems addObject:si];
			ID_count = ID_count + 1;
		}
		
		NSString *id1 =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_ID_LA1.pdf", [recordDic objectForKey:@"ProposalNo"]]];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:id1]) {
			[selectedItems addObject:id1];
			ID_count = ID_count + 1;
		}
		
		NSString *id2 =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_ID_LA2.pdf", [recordDic objectForKey:@"ProposalNo"]]];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:id2]) {
			[selectedItems addObject:id2];
			ID_count = ID_count + 1;
		}
		
		NSString *id3 =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_ID_PO.pdf", [recordDic objectForKey:@"ProposalNo"]]];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:id3]) {
			[selectedItems addObject:id3];
			ID_count = ID_count + 1;
		}
		
		NSString *id4 =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_ID_CO.pdf", [recordDic objectForKey:@"ProposalNo"]]];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:id4]) {
			[selectedItems addObject:id4];
			ID_count = ID_count + 1;
		}
		
		NSString *id5 =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_ID_TR1.pdf", [recordDic objectForKey:@"ProposalNo"]]];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:id5]) {
			[selectedItems addObject:id5];
			ID_count = ID_count + 1;
		}
		
		NSString *id6 =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_ID_TR2.pdf", [recordDic objectForKey:@"ProposalNo"]]];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:id6]) {
			[selectedItems addObject:id6];
			ID_count = ID_count + 1;
		}
		
		NSString *id7 =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_ID_GD.pdf", [recordDic objectForKey:@"ProposalNo"]]];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:id7]) {
			[selectedItems addObject:id7];
			ID_count = ID_count + 1;
		}
		
		NSString *id8 =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_ID_CFP.pdf", [recordDic objectForKey:@"ProposalNo"]]];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:id8]) {
			[selectedItems addObject:id8];
			ID_count = ID_count + 1;
		}
		
		NSString *id9 =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_ID_CRP.pdf", [recordDic objectForKey:@"ProposalNo"]]];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:id9]) {
			[selectedItems addObject:id9];
			ID_count = ID_count + 1;
		}
		
		NSString *ff =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_FF.pdf", [recordDic objectForKey:@"ProposalNo"]]];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:ff]) {
			[selectedItems addObject:ff];
			//add
			ID_count = ID_count + 1;
		}
		
		NSString *ca =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_CA.pdf", [recordDic objectForKey:@"ProposalNo"]]];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:ca]) {
			[selectedItems addObject:ca];
			ID_count = ID_count + 1;
		}
		
		NSString *au =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_AU.pdf", [recordDic objectForKey:@"ProposalNo"]]];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:au]) {
			[selectedItems addObject:au];
			ID_count = ID_count + 1;
		}
		
		NSString *sixml =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"SIXML/%@_SI.xml", [recordDic objectForKey:@"ProposalNo"]]];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:sixml]) {
			[selectedItems addObject:sixml];
			ID_count = ID_count + 1;
		}
		
		NSString *prxml =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"ProposalXML/%@_PR.xml", [recordDic objectForKey:@"ProposalNo"]]];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:prxml]) {
			[selectedItems addObject:prxml];
			ID_count = ID_count + 1;
		}
		 // generating COMPLETE.XML
		NSString *agentCode1 = [self.AgentCode objectAtIndex:path.row];
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *docsPath = [paths objectAtIndex:0];
		NSString *path1 = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
		
		FMDatabase *db = [FMDatabase databaseWithPath:path1];
		[db open];
		
		NSString *eProposalNo = [recordDic objectForKey:@"ProposalNo"];
		NSString *POOtherIDType;
		NSString *selectPO = [NSString stringWithFormat:@"SELECT LAOtherIDType FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'", eProposalNo];
		int cffindicator;
		FMResultSet *results;
		results = [db executeQuery:selectPO];
		
		while ([results next]) {
			POOtherIDType = [results objectForColumnName:@"LAOtherIDType"];
		}
		
		//ecffinfo
		if ([POOtherIDType isEqualToString:@"CR"]) {
			cffindicator = 0;
		} else {
			cffindicator = 1;
		}
		
		
		// ## Create Complete FILE 
		NSString *completeString = [NSString stringWithFormat:@"%@;%d;%d;%d;%d;", agentCode1, 0, cffindicator, 0, ID_count]; //A0030269;0;1;0;
		NSLog(@"%@, %d", completeString, ID_count);
		
		[completeString writeToFile:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_Complete.xml",eProposalNo]] atomically:YES encoding:NSUTF8StringEncoding error:nil];
		
		// generating COMPLETE.XML - END
		
		NSString *cmpxml =  [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Forms/%@_Complete.xml", [recordDic objectForKey:@"ProposalNo"]]];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:cmpxml]) {
			[selectedItems addObject:cmpxml];
		}
		// ## End
		
	
//		[self EncFile:selectedItems];
		
		
		//		int count = 0;
		
		for (int i = 0; i < [selectedItems count]; i++) {
			
			
			//convert to byte (all file)
			NSData *data = [[NSData alloc] initWithContentsOfFile:[selectedItems objectAtIndex:i]];
			
			//Enc File only
//            NSData *data = [[NSData alloc] initWithContentsOfFile:[[selectedItems objectAtIndex:i] stringByAppendingString:@".enc"]];
			
			// using base64StringFromData method, we are able to convert data to string
			NSString *strBinary = [NSString base64StringFromData:data length:[data length]];
			// log the base64 encoded string
			
			NSString *docpath = [selectedItems objectAtIndex:i];
			NSArray *split = [docpath componentsSeparatedByString:@"/"];
			
			NSString *docname = [split objectAtIndex:[split count] - 1];
			
			
			//Remove this code if want completeXML with proposal NO
//			NSArray *SplitB = [docname componentsSeparatedByString:@"_"];
//			NSString *docCheck = [SplitB objectAtIndex:[SplitB count] - 1];
//			if ([docCheck isEqualToString:@"Complete.xml"]) {
//				docname = @"Complete.xml";
//			}
			
			strDoc = docname;
			NSLog(@"doc name %@", strDoc);	
			
			//webservices
			
			NSString *ipSet = @"192.168.0.140";
//			NSString *ipSet = @"192.168.2.119";
			
			NSString *CountFile = [NSString stringWithFormat:@"%d", ID_count];
			NSLog(@"agentNo: %@", agentCode1);
			
			NSString *strAgentCode = [agentCode1 stringByTrimmingCharactersInSet:
									  [NSCharacterSet whitespaceCharacterSet]];
			
			//#### Send encryption file
			
//			NSString *strXML3 = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><SaveDocument xmlns='http://tempuri.org/'><strBinary>%@</strBinary><strDocName>%@</strDocName><strFolder>%@</strFolder><strSource>%@</strSource><agentID>%@</agentID><totalFile>%@</totalFile></SaveDocument></soap:Body></soap:Envelope>", strBinary, strDoc, strFolder, strSource, strAgentCode, CountFile];
			
			//#### Send original file
			
			NSString *strXML3 = [NSString stringWithFormat:@"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><EncryptAll xmlns='http://tempuri.org/'><strBinary>%@</strBinary><strDocName>%@</strDocName><strFolder>%@</strFolder><strSource>%@</strSource><agentID>%@</agentID><totalFile>%@</totalFile></EncryptAll></soap:Body></soap:Envelope>", strBinary, strDoc, strFolder, strSource, strAgentCode, CountFile];
			
			NSString *strURL = [NSString stringWithFormat:@"http://%@/AgentWebService/AgentMgmt.asmx?wsdl", ipSet];
			
			NSURL *url = [NSURL URLWithString:strURL];
			NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
			[request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//			[request addValue:@"http://tempuri.org/SaveDocument" forHTTPHeaderField:@"SOAPAction"];
			[request addValue:@"http://tempuri.org/EncryptAll" forHTTPHeaderField:@"SOAPAction"];
			NSString *msgLenght = [NSString stringWithFormat:@"%d", [strXML3 length]];
			[request addValue:msgLenght forHTTPHeaderField:@"Content-Length"];
			[request setHTTPMethod:@"POST"];
			[request setHTTPBody:[strXML3 dataUsingEncoding:NSUTF8StringEncoding]];
			
			NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
			NSData *urlData;
			NSURLResponse *response;
			
			NSError *error;
			urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
			if(conn) {
				NSLog(@"Connection Successful");
			} else {
				NSLog(@"Connection could not be made");
			}
			
			
			NSString *replyString = [[NSString alloc] initWithBytes:[urlData bytes] length:[urlData length] encoding: NSASCIIStringEncoding];
			
			NSLog(@"reply: %@", replyString);
			
			//end Web service send file
//			NSLog(@"Item: %@", selectedItems);
			NSLog(@"count: %d, %d", i, [selectedItems count]-1);
			
			if (i == [selectedItems count]-1) {
				
				//temp
				
				
				NSUserDefaults *Temp = [NSUserDefaults standardUserDefaults];
				[Temp setObject:[recordDic objectForKey:@"ProposalNo"] forKey:@"ProNo"];
				
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Proposal(s) has been submitted successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//				alert.tag = 10;
				[alert show];
				alert = Nil;
				
//
//				NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//				NSString *docsDir = [dirPaths objectAtIndex:0];
//				databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent:@"hladb.sqlite"]];
//				sqlite3_stmt *statement;
//				
//				NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//				NSDate *currDate = [NSDate date];
//				[dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
//				NSString *dateString = [dateFormatter stringFromDate:currDate];
//				
//				if (sqlite3_open([databasePath UTF8String], &updateDB) == SQLITE_OK) {
//					NSString *updatetSQL = [NSString stringWithFormat:@"update eApp_Listing SET Status='4', SubmitDate = '%@' WHERE ProposalNo='%@'", dateString, [recordDic objectForKey:@"ProposalNo"]];
//					
//					if (sqlite3_prepare_v2(updateDB, [updatetSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
//						if (sqlite3_step(statement) == SQLITE_DONE) {
//							NSLog(@"Update eapplisting status success!");
//							
//							self.loginOuterView.hidden = YES;
//							
//							UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Proposal(s) has been submitted successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//							alert.tag = 10;
//							[alert show];
//							alert = Nil;
//							
//							[self deleteencFiles];
//							[self reloadAfterSubmission];
//						} else {
//							NSLog(@"Update eapplisting status fail!");
//						}
//						
//						sqlite3_finalize(statement);
//					}
//					
//					sqlite3_close(updateDB);
//					[self ReloadTableData];
//				}
				
			}
			
			
		}
	}
	
//	[MBProgressHUD hideHUDForView:self.view animated:YES];
//	[HUD hide:YES afterDelay:1];
}

-(void)EncFile :(NSMutableArray *) selectedItems{
	
	NSString *passcode = @"UAT1234567890";
    NSString *source = @"IAPP(S)";
	
	BOOL success;
	CkoCrypt2 *crypt;
	CkoCrypt2 *crypt2;
	
	// Do any additional setup after loading the view, typically from a nib.
	crypt = [[CkoCrypt2 alloc] init];
	
	
	success = [crypt UnlockComponent:@"KUANKHCrypt_vD3vem6YMZjk"];
	
	if (success != YES) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ChilkatSample" message:@"Crypt library unlock failed" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
	}
	
	//Decrypt string parameters
	NSString *key;
	key = @"Pas5pr@se";
	
	NSString *iv;
	iv = @"@1B2c3D4e5F6g7H8";
	
	NSString *salt;
	salt = @"s@1tValue";
	
	crypt.CryptAlgorithm = @"SHA1";
	crypt.CipherMode = @"cbc";
	crypt.KeyLength = [NSNumber numberWithInt:256];
	crypt.PaddingScheme = [NSNumber numberWithInt:0];
	
	[crypt SetEncodedKey:key encoding:@"ascii"];
	[crypt SetEncodedIV:iv encoding:@"ascii"];
	[crypt SetEncodedSalt:salt encoding:@"ascii"];
	
	EncryptedPassPhrase = [_svdata valueForKey:@"EncryptedPassPhrase"];
	EncryptedSaltValue = [_svdata valueForKey:@"EncryptedSaltValue"];
	EncryptedHashAlgorithm = [_svdata valueForKey:@"EncryptedHashAlgorithm"];
	EncryptedPasswordIteration = [_svdata valueForKey:@"EncryptedPasswordIteration"];
	EncryptedInitialationVector = [_svdata valueForKey:@"EncryptedInitialationVector"];
	EncryptedKeySize = [_svdata valueForKey:@"EncryptedKeySize"];
	
	DecryptedPassPhrase = [crypt DecryptStringENC:[_svdata valueForKey:@"EncryptedPassPhrase"]];
	DecryptedSaltValue = [crypt DecryptStringENC:[_svdata valueForKey:@"EncryptedSaltValue"]];
	DecryptedHashAlgorithm = [crypt DecryptStringENC:[_svdata valueForKey:@"EncryptedHashAlgorithm"]];
	DecryptedPasswordIteration = [crypt DecryptStringENC:[_svdata valueForKey:@"EncryptedPasswordIteration"]];
	DecryptedInitialationVector = [crypt DecryptStringENC:[_svdata valueForKey:@"EncryptedInitialationVector"]];
	DecryptedKeySize = [crypt DecryptStringENC:[_svdata valueForKey:@"EncryptedKeySize"]];
	NSLog(@"Encryption Done!");

	
	///// fetching document directory path
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *FormsPath =  [documentsDirectory stringByAppendingPathComponent:@"Forms"];
	
	
	crypt2 = [[CkoCrypt2 alloc] init];
	
	
	success = [crypt2 UnlockComponent:@"KUANKHCrypt_vD3vem6YMZjk"];
	
	if (success != YES) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ChilkatSample" message:@"Crypt library unlock failed" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
	}
	
	//do not change start
	//Decrypt files parameters
	NSString *key2;
	key2 = DecryptedPassPhrase;
	
	NSString *salt2;
	salt2 = DecryptedSaltValue;
	
	NSString *test3 = DecryptedHashAlgorithm;
	
	NSString *test1 = DecryptedPasswordIteration;
	
	NSString *test2 = DecryptedKeySize;
	
	NSString *iv2;
	iv2 = DecryptedInitialationVector;
	
	
	crypt2.CryptAlgorithm = @"SHA1";
	crypt2.CipherMode = @"cbc";
	crypt2.KeyLength = [NSNumber numberWithInt:256];
	crypt2.PaddingScheme = [NSNumber numberWithInt:0];
	
	[crypt2 SetEncodedKey:key2 encoding:@"ascii"];
	[crypt2 SetEncodedIV:iv2 encoding:@"ascii"];
	[crypt2 SetEncodedSalt:salt2 encoding:@"ascii"];
	
	
	for (int i = 0; i < [selectedItems count]; i++) {
		
		//encrypt file
		if (![[NSFileManager defaultManager] fileExistsAtPath:[[selectedItems objectAtIndex:i] stringByAppendingString:@".enc"]]) {
			[[NSFileManager defaultManager] createFileAtPath:[[selectedItems objectAtIndex:i] stringByAppendingString:@".enc"] contents:[NSData data] attributes:nil];
		}
		
		BOOL issuccess = [crypt2 CkEncryptFile:[selectedItems objectAtIndex:i] destFile:[[selectedItems objectAtIndex:i] stringByAppendingString:@".enc"]];
		
		if (issuccess) {
			NSLog(@"fileName: %@ success", [selectedItems objectAtIndex:i]);
		} else {
			NSLog(@"fileName: %@ failed", [selectedItems objectAtIndex:i]);
		}
	}
	
	
}


- (void)deleteencFiles {
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    NSString *FormsPath =  [documentsDirectory stringByAppendingPathComponent:@"Forms"];
    NSFileManager *fm = [NSFileManager defaultManager];


    if ([fm fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_PR.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]) {
        [fm removeItemAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_PR.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]] error:&error];
    }

    if ([fm fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_SP_1.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]) {
        [fm removeItemAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_SP_1.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]] error:&error];
    }

    if ([fm fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_SI.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]) {
        [fm removeItemAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_SI.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]] error:&error];
    }

    if ([fm fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_FF.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]) {
        [fm removeItemAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_FF.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]] error:&error];
    }

    if ([fm fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_CA.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]) {
        [fm removeItemAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_CA.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]] error:&error];
    }

    if ([fm fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_AU.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]) {
        [fm removeItemAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_AU.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]] error:&error];
    }

    if ([fm fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@_Complete.xml.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]) {
        [fm removeItemAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@_Complete.xml.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]] error:&error];
    }

    NSString *FormsPathSI =  [documentsDirectory stringByAppendingPathComponent:@"SIXML"];
    NSFileManager *fm1 = [NSFileManager defaultManager];

    if ([fm1 fileExistsAtPath:[FormsPathSI stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_SI.xml.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]) {
        [fm1 removeItemAtPath:[FormsPathSI stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_SI.xml.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]] error:&error];
    }

    NSString *FormsPathPR =  [documentsDirectory stringByAppendingPathComponent:@"ProposalXML"];
    NSFileManager *fm2 = [NSFileManager defaultManager];

    if ([fm2 fileExistsAtPath:[FormsPathPR stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_PR.xml.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]) {
        [fm2 removeItemAtPath:[FormsPathPR stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_PR.xml.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]] error:&error];
    }

    if ([fm fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_LA1.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]) {
        [fm removeItemAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_LA1.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]] error:&error];
    }

    if ([fm fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_LA2.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]) {
        [fm removeItemAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_LA2.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]] error:&error];
    }

    if ([fm fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_PO.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]) {
        [fm removeItemAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_PO.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]] error:&error];
    }

    if ([fm fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CO.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]) {
        [fm removeItemAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CO.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]] error:&error];
    }

    if ([fm fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_TR1.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]) {
        [fm removeItemAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_TR1.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]] error:&error];
    }

    if ([fm fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_TR2.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]) {
        [fm removeItemAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_TR2.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]] error:&error];
    }

    if ([fm fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_GD.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]) {
        [fm removeItemAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_GD.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]] error:&error];
    }

    if ([fm fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CFP.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]) {
        [fm removeItemAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CFP.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]] error:&error];
    }

    if ([fm fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CRP.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]) {
        [fm removeItemAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CRP.pdf.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]] error:&error];
		
	if ([fm fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_Complete.xml.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
		{
			[fm removeItemAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_Complete.xml.enc", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]] error:&error];
		}
		
    }
}

- (IBAction)submitButtonClicked:(id)sender {
    [self.pendingTableVew setEditing:NO animated:YES];
    self.submitButton.enabled = NO;
    self.submitButton.hidden = YES;
    [self.submitCancelButton setTitle:@"Submit" forState:UIControlStateNormal];

    if ([cellSelectedExpired isEqualToString:@" Expired                                       "]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Invalid proposal. e-Signature of Policy Owner had signed with more than 120 hours. Kindly proceed to recreate new proposal should you wish to proceed." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        alert = Nil;
    } else {
		
		[self submitAfterSuccessFulllogin2];
     
    }
}

- (void)loginAction {
    if (self.logintextField.text.length <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Username is required" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

        [self.ipasswordTextField becomeFirstResponder];
        alert = Nil;
    } else if (self.ipasswordTextField.text.length <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Password is required" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

        [self.ipasswordTextField becomeFirstResponder];
        alert = Nil;
    } else {
        if ([[Reachability reachabilityWithHostname:@"www.hla.com.my"] currentReachabilityStatus] == NotReachable) {
            // Show alert because no wifi or 3g is available..
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [HUD hide:YES afterDelay:1];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Error in connecting to Web service. Please check your internet connection" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];

            alert = Nil;
        } else {
            [self checkingFirstLogin];
            NSLog(@"loginstatus:%d", _statusLogin);

            if (_statusLogin == 2) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Contact System Admin." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];

                alert = Nil;
                return;
            } else if (agentCode.length == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Invalid Password. Please check your password" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];

                alert = Nil;
                return;
            } else {
                HUD = [[MBProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:HUD];
                HUD.labelText = @"Please Wait";
                [HUD show:YES];

                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                    xmlType = XML_TYPE_VALIDATE_LOGIN;

                    NSString *sBadAttempt = [NSString stringWithFormat:@"%d", [self getBadAttempts]];


                    NSString *deviceId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];

                    NSLog(@"devideId %@", [[[UIDevice currentDevice] identifierForVendor] UUIDString]);


                    NSString *strURL = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx/iValidateLogin?"
                                        "Input1=%@&Input2=%@&Input3=%@&Input4=%@&Input5=%@&Input6=%@",
                                        [SIUtilities WSLogin],  self.logintextField.text, self.ipasswordTextField.text, [self getIPAddress], sBadAttempt, agentCode, deviceId];

                    NSURL *url = [NSURL URLWithString:strURL];
                    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:20];

                    AFXMLRequestOperation *operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
                                                                                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
                            XMLParser.delegate = self;
                            [XMLParser setShouldProcessNamespaces:YES];
                            [XMLParser parse];

                            if ([SuccessString isEqualToString:@""]) {
                                [self submitAfterSuccessFulllogin2];
                            } else {
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:SuccessString delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                [alert show];

                                alert = Nil;
                            }
                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [HUD hide:YES afterDelay:1];
                            NSLog(@"error in calling web service");
                        }];
                    [operation start];
                    dispatch_async(dispatch_get_main_queue(), ^{
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [HUD hide:YES afterDelay:1];
                        });
                });
            }
        }
    }
}

- (void)checkingFirstLogin {
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;


    agentPortalPassword = @"";
    agentCode = @"";

    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT  FirstLogin, AgentCode "
                              "FROM Agent_Profile WHERE "
                              "AgentLoginID=\"%@\"",
                              self.logintextField.text];

        NSLog(@"querySQL %@", querySQL);
        const char *query_stmt = [querySQL UTF8String];

        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                _statusLogin = sqlite3_column_int(statement, 0);



                const char *portalCode = (const char *)sqlite3_column_text(statement, 1);
                agentCode = portalCode == NULL ? nil : [[NSString alloc] initWithUTF8String:portalCode];


                const char *portalPswd = (const char *)sqlite3_column_text(statement, 4);
                agentPortalPassword = portalPswd == NULL ? nil : [[NSString alloc] initWithUTF8String:portalPswd];
            } else {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [HUD hide:YES afterDelay:1];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Invalid Password. Please check your password" delegate:Nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
                [alert show];
                alert = Nil;
            }

            sqlite3_finalize(statement);
        } else {
            _statusLogin = 2;
            NSLog(@"wrong query");
        }

        sqlite3_close(contactDB);
        querySQL = Nil;
        query_stmt = Nil;
    } else {
        NSLog(@"cannot open");
    }

    dbpath = Nil;
    statement = Nil;
}

- (NSInteger)getBadAttempts {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *number = [defaults objectForKey:KEY_BAD_ATTEMPTS];

    NSInteger anInt = [number intValue];


    return anInt;
}

- (NSString *)getLastSyncDate {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];


    return [defaults stringForKey:KEY_LAST_SYNC_DATE];
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

        while (temp_addr != NULL) {
            if (temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)loginSubmit:(id)sender {
    [self loginAction];
}

- (IBAction)loginViewCancel:(id)sender {
    _ipasswordTextField.text = @"";
    self.loginOuterView.hidden = YES;
    [self ReloadTableData];
    [self.pendingTableVew reloadData];
}

- (IBAction)searchButtonClicked:(id)sender {
    [self.view endEditing:YES];

    if ([self.policyOwnerField.text length] == 0 && [self.idNoTextField.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Search criteria is required. Please key in one of the criteria." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 500;
        [alert show];
        alert = Nil;
        return;
    } else {
        isSearching = TRUE;

        FMDatabase *database = [FMDatabase databaseWithPath:databasePath];
        [database open];

        _PONameSearch = [[NSMutableArray alloc] init];
        _IDNoSearch = [[NSMutableArray alloc] init];
        _StatusSearch = [[NSMutableArray alloc] init];
        _ProposalNoSearch = [[NSMutableArray alloc] init];
        _LastUpdatedSearch = [[NSMutableArray alloc] init];
        _ClientNameSearch = [[NSMutableArray alloc] init];
        _SINoSearch = [[NSMutableArray alloc] init];
        _planNameSearch = [[NSMutableArray alloc] init];
        _SIVersionSearch = [[NSMutableArray alloc] init];
        _eAppVersionMSearch = [[NSMutableArray alloc] init];
        _OtherIDNoSearch = [[NSMutableArray alloc] init];


        NSString *search_poname;
        NSString *search_idno;

        if (self.policyOwnerField.text) {
            search_poname = [NSString stringWithFormat:@"%%%@%%", self.policyOwnerField.text];
        } else {
            search_poname = @"%%";
        }

        if (self.idNoTextField.text) {
            search_idno = [NSString stringWithFormat:@"%%%@%%", self.idNoTextField.text];
        } else {
            search_idno = @"%%";
        }

        NSString *str = [NSString stringWithFormat:@"select A.POName, A.IDNumber, A.OtherIDNo, A.ProposalNo, A.DateCreated, A.DateUpdated, B.eAppVersion, D.status,B.SINo, C.ProspectName, B.BasicPlanCode, B.SIVersion from eApp_Listing AS A, eProposal AS B, prospect_profile AS C ,eProposal_Status AS D WHERE A.status = '3' and A.POName like '%@' and (A.IDNumber like '%@' OR A.OtherIDNo like '%@') AND A.ProposalNo = B.eProposalNo AND A.ClientProfileID = C.IndexNo AND A.status = D.StatusCode", search_poname, search_idno, search_idno];
        FMResultSet *results = [database executeQuery:str];

        results = Nil;
        results = [database executeQuery:[NSString stringWithFormat:@"select count(*) as count from eApp_Listing AS A, eProposal AS B, prospect_profile AS C ,eProposal_Status AS D WHERE A.status = '3' and A.POName like '%@' and (A.IDNumber like '%@' OR A.OtherIDNo like '%@') AND A.ProposalNo = B.eProposalNo AND A.ClientProfileID = C.IndexNo AND A.status = D.StatusCode", search_poname, search_idno, search_idno]];

        if ([results next]) {
            if ([results intForColumn:@"count"] == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"No record found." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                alert = nil;

                _pendingTableVew.hidden = YES;

                return;
            }
        }

        results = nil;
        results = [database executeQuery:str];
        _pendingTableVew.hidden = NO;

        while ([results next]) {
            NSString *poname = [results stringForColumn:@"POName"];
            NSString *idno = [results stringForColumn:@"IDNumber"];
            NSString *proposalno = [results stringForColumn:@"ProposalNo"];

            NSString *lastupdated = [results stringForColumn:@"DateUpdated"];

            if ([lastupdated isEqualToString:@""] || lastupdated == Nil) {
                lastupdated = [results stringForColumn:@"DateCreated"];
            }

            NSString *status = [results stringForColumn:@"status"];

            NSString *clientname = [results stringForColumn:@"ProspectName"];
            NSString *sino = [results stringForColumn:@"SINo"];
            NSString *plancode = [results stringForColumn:@"BasicPlanCode"];
            NSString *eappVersion = [results stringForColumn:@"eAppVersion"];
            NSString *otherIDNo = [results stringForColumn:@"OtherIDNo"];

            NSString *siversion = [results stringForColumn:@"SIVersion"];

            if ((NSNull *)siversion == [NSNull null]) {
                siversion = @"";
            }

            if ((NSNull *)poname == [NSNull null]) {
                poname = @"";
            }

            if ((NSNull *)idno == [NSNull null]) {
                idno = @"";
            }

            if (idno == nil) {
                idno = @"";
            }

            if (otherIDNo == nil) {
                otherIDNo = @"";
            }

            if ((NSNull *)eappVersion == [NSNull null]) {
                eappVersion = @"";
            }

            if (eappVersion == nil) {
                eappVersion = @"";
            }

            [_PONameSearch addObject:poname];
            [_IDNoSearch addObject:idno];
            [_ProposalNoSearch addObject:proposalno];
            [_LastUpdatedSearch addObject:lastupdated];
            [_StatusSearch addObject:status];
            [_ClientNameSearch addObject:clientname];
            [_SINoSearch addObject:sino];
            [_planNameSearch addObject:plancode];
            [_SIVersionSearch addObject:siversion];
            [_eAppVersionMSearch addObject:eappVersion];
            [_OtherIDNoSearch addObject:otherIDNo];
        }
        [database close];
        [self.pendingTableVew reloadData];
    }
}

- (IBAction)btnCancelPressed:(id)sender {
    [self resignFirstResponder];

    if ([_pendingTableVew isEditing]) {
        [self.pendingTableVew setEditing:NO animated:TRUE];
        _btnDelete.hidden = true;
        _btnDelete.enabled = false;
        [_btnCancel setTitle:@"Delete" forState:UIControlStateNormal ];

        ItemToBeDeleted = [[NSMutableArray alloc] init];
        indexPaths = [[NSMutableArray alloc] init];
    } else {
        [self.pendingTableVew setEditing:YES animated:TRUE];
        _btnDelete.hidden = FALSE;
        [_btnDelete setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
        [_btnCancel setTitle:@"Cancel" forState:UIControlStateNormal ];
    }
}

- (IBAction)btnDeletePressed:(id)sender {
    NSString *clt;
    int RecCount = 0;


    for (UITableViewCell *cell in [self.pendingTableVew visibleCells]) {
        if (cell.selected == TRUE) {
            NSIndexPath *selectedIndexPath = [self.pendingTableVew indexPathForCell:cell];
            NSString *PONAME = nil;
            NSString *Status = nil;

            if (isSearching) {
                PONAME = [_PONameSearch objectAtIndex:selectedIndexPath.row];
                Status = [_StatusSearch objectAtIndex:selectedIndexPath.row];
            } else {
                PONAME = [_POName objectAtIndex:selectedIndexPath.row];
                Status = [_Status objectAtIndex:selectedIndexPath.row];
            }

            if (RecCount == 0) {
                clt = PONAME;
            }

            RecCount = RecCount + 1;

            if (RecCount > 1) {
                break;
            }
        }
    }

    NSLog(@"RecCount: %d", RecCount);

    NSString *msg;

    if (RecCount == 1) {
        msg = [NSString stringWithFormat:@"You have not submitted the case for processing. Should you wish to proceed, system will auto delete the record and you are required to recreate the eApp transaction should you wish to submit the case again."];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        [alert setTag:1001];
        [alert show];
    } else if (RecCount < 0) {
        NSString *msg = @"Error: Cannot delete status Submitted / Received";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
        [alert show];
    } else {
        msg = @"You have not submitted the case for processing. Should you wish to proceed, system will auto delete the record and you are required to recreate the eApp transaction should you wish to submit the case again.";

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        [alert setTag:1001];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1001 && buttonIndex == 0) { //delete
        NSLog(@"Before search=%@     after search=%@", _ProposalNo, _ProposalNoSearch);
        NSString *DelErrAt = @"";

        if (ItemToBeDeleted.count < 1) {
            return;
        } else {
            NSLog(@"itemToBeDeleted:%d", ItemToBeDeleted.count);
        }

        NSArray *sorted = [[NSArray alloc] init ];
        sorted = [ItemToBeDeleted sortedArrayUsingComparator:^(id firstObject, id secondObject) {
            return [((NSString *)firstObject)compare : ((NSString *)secondObject)options : NSNumericSearch];
        }];

        sqlite3_stmt *statement;
        NSString *proposal;

        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK) {
            for (int a = 0; a < sorted.count; a++) {
                int value = [[sorted objectAtIndex:a] intValue];
                value = value - a;

                if (isSearching) {
                    proposal = [_ProposalNoSearch objectAtIndex:value];
                } else {
                    proposal = [_ProposalNo objectAtIndex:value];
                }

                //Delete eApp_Listing
                NSString *DeleteSQL = [NSString stringWithFormat:@"Delete from eApp_Listing where ProposalNo = \"%@\"", proposal];

                const char *Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eApp_Listing";
                    NSLog(@"Error in Delete Statement - eApp_Listing");
                }

                //Delete eProposal_LA_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_LA_Details where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_LA_Details");
                }

                //Delete eProposal
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal");
                }

                //Delete eProposal_Existing_Policy_1
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_Existing_Policy_1 where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_Existing_Policy_1");
                }

                //Delete eProposal_Existing_Policy_2
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_Existing_Policy_2 where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_Existing_Policy_2");
                }

                //Delete eProposal_NM_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_NM_Details where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_NM_Details");
                }

                //Delete eProposal_Trustee_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_Trustee_Details where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_Trustee_Details");
                }

                //Delete eProposal_QuestionAns
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_QuestionAns where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_QuestionAns");
                }

                //Delete eProposal_Additional_Questions_1
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_Additional_Questions_1 where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_Additional_Questions_1");
                }

                //Delete eProposal_Additional_Questions_2
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_Additional_Questions_2 where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_Additional_Questions_2");
                }

                //DELETE CFF START

                //Delete eProposal_CFF_Master
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Master where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Master");
                }

                //Delete eProposal_CFF_CA
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_CA where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_CA");
                }

                //Delete eProposal_CFF_CA_Recommendation
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_CA_Recommendation where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_CA_Recommendation");
                }

                //Delete eProposal_CFF_CA_Recommendation_Rider
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_CA_Recommendation_Rider where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_CA_Recommendation_Rider");
                }

                //Delete eProposal_CFF_Education
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Education where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Education");
                }

                //Delete eProposal_CFF_Education_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Education_Details where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Education_Details");
                }

                //Delete eProposal_CFF_Family_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Family_Details where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Family_Details");
                }

                //Delete eProposal_CFF_Personal_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Personal_Details where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Personal_Details");
                }

                //Delete eProposal_CFF_Protection
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Protection where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Protection");
                }

                //Delete eProposal_CFF_Protection_Details

                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Protection_Details where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Protection_Details");
                }

                //Delete eProposal_CFF_RecordOfAdvice
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_RecordOfAdvice where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_RecordOfAdvice");
                }

                //Delete eProposal_CFF_RecordOfAdvice_Rider
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_RecordOfAdvice_Rider where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_RecordOfAdvice_Rider");
                }

                //Delete eProposal_CFF_Retirement
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Retirement where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Retirement");
                }

                //Delete eProposal_CFF_Retirement_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Retirement_Details where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Retirement_Details");
                }

                //Delete eProposal_CFF_SavingsInvest
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_SavingsInvest where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest");
                }

                //Delete eProposal_CFF_SavingsInvest_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_SavingsInvest_Details where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest_Details");
                }

                //Delete eProposal_CFF_SavingsInvest_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_SavingsInvest_Details where eProposalNo = \"%@\"", proposal];

                Delete_stmt = [DeleteSQL UTF8String];

                if (sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK) {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                } else {
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest_Details");
                }

                if (isSearching) {
                    [_ProposalNoSearch removeObjectAtIndex:value];
                } else {
                    [_ProposalNo removeObjectAtIndex:value];
                }

                //DELETE CFF END
            }

            sqlite3_close(contactDB);
        }

        [self.pendingTableVew beginUpdates];
        [self.pendingTableVew deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.pendingTableVew endUpdates];
        [self ReloadTableData];

        if (ItemToBeDeleted == nil) {
            ItemToBeDeleted = [[NSMutableArray alloc] init];
        } else {
            [ItemToBeDeleted removeAllObjects];
        }

        if (indexPaths == nil) {
            indexPaths = [[NSMutableArray alloc] init];
        } else {
            [indexPaths removeAllObjects];
        }

        _btnDelete.enabled = FALSE;
        [_btnDelete setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];

        if ([DelErrAt isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"e-Application case has been successfully deleted." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
}

- (IBAction)resetButtonClicked:(id)sender {
    self.policyOwnerField.text = @"";
    self.idNoTextField.text = @"";
    isSearching = NO;

    _pendingTableVew.hidden = NO;
    [self.pendingTableVew reloadData];
}

#pragma mark - XML parser

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict  {
    NSLog(@"*****%@", attributeDict);


    element = elementName;

    if ([element isEqualToString:@"Result"]) {
        item                    = [[NSMutableDictionary alloc] init];
        Eapp_Version_Svr        = [[NSMutableString alloc] init];
        Date_Obs_Version_Svr    = [[NSMutableString alloc] init];
        Date_Eapp_Version_Svr   = [[NSMutableString alloc] init];
        Obs_Version_Svr         = [[NSMutableString alloc] init];
    }

    self.previousElementName = self.elementName;

    if (qName) {
        self.elementName = qName;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([element isEqualToString:@"Output1"]) {
        [Eapp_Version_Svr appendString:string];

        NSLog(@"output1 %@", string);
    } else if ([element isEqualToString:@"Output2"]) {
        [Date_Eapp_Version_Svr appendString:string];
        NSLog(@"output2 %@", string);
    } else if ([element isEqualToString:@"Output3"]) {
        [Obs_Version_Svr appendString:string];
        NSLog(@"output3 %@", string);
    } else if ([element isEqualToString:@"Output4"]) {
        [Date_Obs_Version_Svr appendString:string];
        NSLog(@"output4 %@", string);
    }

    if (xmlType == XML_TYPE_VALIDATE_LOGIN) {
        if ([self.elementName isEqualToString:@"LoginError"]) {
            SuccessString = string;
            NSLog(@"SuccessString %@", string);
        }
    }

    if (!self.elementName) {
        return;
    }

    if (xmlType == XML_TYPE_GET_SUBMISSION_VALUE) {
        if ([self.elementName isEqualToString:@"Info1"]) {
            EncryptedPassPhrase = string;
        }

        if ([self.elementName isEqualToString:@"Info2"]) {
            EncryptedSaltValue = string;
        }

        if ([self.elementName isEqualToString:@"Info3"]) {
            EncryptedHashAlgorithm = string;
        }

        if ([self.elementName isEqualToString:@"Info4"]) {
            EncryptedPasswordIteration = string;
        }

        if ([self.elementName isEqualToString:@"Info5"]) {
            EncryptedInitialationVector = string;
        }

        if ([self.elementName isEqualToString:@"Info6"]) {
            EncryptedKeySize = string;
        }
    } else if (xmlType == XML_TYPE_VALIDATE_LOGIN) {
        if ([self.elementName isEqualToString:@"LoginError"]) {
            LoginErrorDescription = string;
        }

        if ([self.elementName isEqualToString:@"BadAttempts"]) {
            Failedattempts = string;
        }

        if ([self.elementName isEqualToString:@"FirstAgtCode"]) {
            AgentCode = string;
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"Result"]) {
        NSLog(@"lementName %@", elementName);
    }

    {
        [item setObject:Eapp_Version_Svr forKey:@"Output1"];
        [item setObject:Date_Eapp_Version_Svr forKey:@"Output2"];
        [item setObject:Obs_Version_Svr forKey:@"Output3"];
        [item setObject:Date_Obs_Version_Svr forKey:@"Output4"];

        [feeds addObject:[item copy]];
    }



    self.elementName = nil;
}

//username is defaulted to agent code and non editable
- (void)setAndpopulateUsername {
    self.logintextField.enabled = NO;

    ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
    self.logintextField.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];

    self.logintextField.text = @"Username problem";


    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;

    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK) {
        NSString *querySQL = @"SELECT \"AgentLoginID\" FROM Agent_profile";

        const char *query_stmt = [querySQL UTF8String];

        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                if (sqlite3_column_text(statement, 0) == nil) {
                } else {
                    self.logintextField.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                }
            } else {
                NSLog(@"wrong query");
            }

            sqlite3_finalize(statement);
        } else {
            NSLog(@"wrong query");
        }

        sqlite3_close(contactDB);
        querySQL = Nil;
        query_stmt = Nil;
    } else {
        NSLog(@"cannot open");
    }

    dbpath = Nil;
    statement = Nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"parser %@", parser);

    if (xmlType == XML_TYPE_GET_SUBMISSION_VALUE) {
        _svdata = @{ @"EncryptedPassPhrase" : EncryptedPassPhrase,
                     @"EncryptedSaltValue" : EncryptedSaltValue,
                     @"EncryptedHashAlgorithm" : EncryptedHashAlgorithm,
                     @"EncryptedPasswordIteration" : EncryptedPasswordIteration,
                     @"EncryptedInitialationVector" : EncryptedInitialationVector,
                     @"EncryptedKeySize" : EncryptedKeySize };
    }

    if (xmlType == XML_TYPE_VALIDATE_LOGIN) {
        _Logindata = @{ @"LoginErrorDescription" : LoginErrorDescription,
                        @"Failedattempts" : Failedattempts,
                        @"AgentCode" : AgentCode, };
    }
}

@end
