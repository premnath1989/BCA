//
//  PremiumViewController.m
//  HLA
//
//  Created by shawal sapuan on 9/11/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "PremiumViewController.h"
#import "MainScreen.h"
#import "ReportViewController.h"
#import "AppDelegate.h"
#import "RiderViewController.h"

@interface PremiumViewController ()

@end

@implementation PremiumViewController
@synthesize lblMessage;
@synthesize doGenerate;
@synthesize WebView;
@synthesize requestBasicSA,requestBasicHL,requestMOP,requestTerm,requestPlanCode,requestSINo,requestAge,requestOccpCode;
@synthesize basicRate,LSDRate,riderCode,riderSA,riderHL1K,riderHL100,riderHLP,riderRate,riderTerm;
@synthesize riderDesc,planCodeRider,riderUnit,riderPlanOpt,riderDeduct,pentaSQL;
@synthesize plnOptC,planOptHMM,deducHMM,planHSPII,planMGII,planMGIV;
@synthesize riderAge,riderCustCode,riderSmoker;
@synthesize annualRiderTot,halfRiderTot,quarterRiderTot,monthRiderTot;
@synthesize htmlRider,occLoad,annualRider,halfYearRider,quarterRider,monthlyRider,annualRiderSum,halfRiderSum,monthRiderSum,quarterRiderSum;
@synthesize premBH,age,riderSex,sex,waiverRiderAnn,waiverRiderHalf,waiverRiderQuar,waiverRiderMonth;
@synthesize basicPremAnn,basicPremHalf,basicPremMonth,basicPremQuar,ReportHMMRates;
@synthesize waiverRiderAnn2,waiverRiderHalf2,waiverRiderMonth2,waiverRiderQuar2,ReportFromAge,ReportToAge;
@synthesize riderOccp,strOccp,occLoadRider,getAge,SINo,getOccpCode,getMOP,getTerm,getBasicSA,getBasicHL,getPlanCode,getOccpClass;
@synthesize getBasicTempHL,requestBasicTempHL,requestOccpClass;
@synthesize BasicAnnually,BasicHalfYear,BasicMonthly,BasicQuarterly,getBasicPlan,requestBasicPlan;
@synthesize OccpLoadA,OccpLoadH,OccpLoadM,OccpLoadQ;
@synthesize BasicHLAnnually,BasicHLHalfYear,BasicHLMonthly,BasicHLQuarterly;
@synthesize LSDAnnually,LSDHalfYear,LSDMonthly,LSDQuarterly;
@synthesize basicTotalA,basicTotalM,basicTotalQ,basicTotalS,riderTempHL1K,headerTitle,myToolBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
//	self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];

    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	RatesDatabasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"HLA_Rates.sqlite"]];
    
    getAge = self.requestAge;
    getOccpClass = self.requestOccpClass;
    getOccpCode = [self.requestOccpCode description];
    SINo = [self.requestSINo description];
    getMOP = self.requestMOP;
    getTerm = self.requestTerm;
    getBasicSA = [self.requestBasicSA description];
    getBasicHL = [self.requestBasicHL description];
    getBasicTempHL = [self.requestBasicTempHL description];
    getPlanCode = [self.requestPlanCode description];
    getBasicPlan = [self.requestBasicPlan description];
    NSLog(@"::Prem-SINo:%@, plancode:%@, basicPlan:%@",SINo, getPlanCode, getBasicPlan);
    NSLog(@"::MOP:%d, term:%d, sa:%@, hl:%@, occpcode:%@", getMOP, getTerm, getBasicSA, getBasicHL, getOccpCode);

    // ----------- edited by heng
    AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    if (![zzz.MhiMessage isEqualToString:@""]) {
        
        NSString *RevisedSumAssured = zzz.MhiMessage;
        if (requestBasicSA > RevisedSumAssured ) {
            lblMessage.text = @"";
            lblMessage.hidden = TRUE;
        }
        else {
            lblMessage.text = [NSString stringWithFormat:@"Guaranteed Yearly Income will be increase to RM%@ in accordance to MHI Guideline",RevisedSumAssured];
            lblMessage.hidden = FALSE;
        }
    }
    else {
        lblMessage.hidden = TRUE;
    }
    // ------------- end -------------

    [self getBasicPentaRate];
    [self getLSDRate];
    [self getOccLoad];
    NSLog(@"basicRate:%d,lsdRate:%d,pa_cpa:%d",basicRate,LSDRate,occLoad);
    
    [self deleteSIStorePremium]; //heng's part for SI Report
    [self checkExistRider];
    
    /*//--ActivityIndicator--
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(400, 350);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    UILabel *spinnerLabel = [[UILabel alloc] initWithFrame:CGRectMake(350, 370, 120, 40) ];
    spinnerLabel.text  = @" Please Wait...";
    spinnerLabel.backgroundColor = [UIColor blackColor];
    spinnerLabel.opaque = YES;
    spinnerLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:spinnerLabel];
    [self.view setUserInteractionEnabled:NO];
    [spinner startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        [self calculateBasicPremium];
        if ([riderCode count] != 0) {
            NSLog(@"rider exist!");
            [self calculateRiderPrem];
            [self calculateWaiver];
        } else {
            NSLog(@"rider not exist!");
        }
        [self preparedHTMLTable];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [spinner stopAnimating];
            spinnerLabel.text = @"";
            [self.view setUserInteractionEnabled:YES];
            
            UIView *v =  [[self.view subviews] objectAtIndex:[self.view subviews].count - 1 ];
            [v removeFromSuperview];
            v = Nil;
        });
        
    });
    spinner = nil;
    //--end*/
    
    [self calculateBasicPremium];
    if ([riderCode count] != 0) {
        NSLog(@"rider exist!");
        [self calculateRiderPrem];
        [self calculateWaiver];
    } else {
        NSLog(@"rider not exist!");
    }
    [self preparedHTMLTable];
    
    if ((getMOP == 9 && [getBasicSA intValue] < 1000 && getAge >= 66 && getAge <= 70)||
        (getMOP == 9 && [getBasicSA intValue] >= 1000 && getAge >= 68 && getAge <= 70)||
        (getMOP == 12 && [getBasicSA intValue] < 1000 && getAge >= 59 && getAge <= 70)||
        (getMOP == 12 && [getBasicSA intValue] >= 1000 && getAge >= 61 && getAge <= 70))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Please note that the Guaranteed Benefit payout for selected plan maybe lesser than total premium outlay." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];
    }
    
    doGenerate.hidden = TRUE;
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    /*
    self.headerTitle.frame = CGRectMake(290, -20, 124, 44);
    self.myToolBar.frame = CGRectMake(0, 0, 768, 44);
    self.view.frame = CGRectMake(0, 20, 768, 1004); */
    
    self.view.frame = CGRectMake(0, 0, 788, 1004);
    [super viewWillAppear:animated];
}

#pragma mark - Calculation

-(void)preparedHTMLTable
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@""];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"bg10.jpg"];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path isDirectory:NO];
    
    double BasicSA = [getBasicSA doubleValue];
    
    NSString *displayLSD = nil;
    if (BasicSA < 1200) {
        displayLSD = @"Policy Fee Loading";
    }
    else {
        displayLSD = @"Large Size Discount";
    }
    
    //"<body style=\"background-color:transparent;\"><img src=\"%@\">"
    //"<body background=\"%@\">"
    //"<body style=\"background: url(%@) no-repeat; background-size: 100%%;\">"
    //"<body style=\"background-image:url(%@)\">"
	
    NSString *htmlBasic = [[NSString alloc] initWithFormat:
                           @"<html>"
                           "<body style=\"background-image:url(%@)\">"
                           "<br><br><br>"
                           "<table border='1' width='80%%' align='center' style='border-collapse:collapse; border-color:gray;'> "
                           "<tr>"
                           "<td width='32%%' align='center' style='height:45px; background-color:#4F81BD;'>&nbsp;</td>"
                           "<td width='17%%' align='center' style='height:45px; background-color:#4F81BD;'><font face='TreBuchet MS' size='4'>Annual</font></td>"
                           "<td width='17%%' align='center' style='height:45px; background-color:#4F81BD;'><font face='TreBuchet MS' size='4'>Semi-Annual</font></td>"
                           "<td width='17%%' align='center' style='height:45px; background-color:#4F81BD;'><font face='TreBuchet MS' size='4'>Quarterly</font></td>"
                           "<td width='17%%' align='center' style='height:45px; background-color:#4F81BD;'><font face='TreBuchet MS' size='4'>Monthly</font></td>"
                           "</tr>"
                           "<tr>"
                           "<td style='height:35px;padding: 5px 5px 5px 5px;'><font face='TreBuchet MS' size='3'>Basic Plan</font></td>"
                           "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                           "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                           "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                           "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                           "</tr>"
                           "<tr>"
                           "<td style='height:35px;padding: 5px 5px 5px 5px;'><font face='TreBuchet MS' size='3'>Occupation Loading</font></td>"
                           "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                           "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                           "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                           "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                           "</tr>"
                           "<tr>"
                           "<td style='height:35px;padding: 5px 5px 5px 5px;'><font face='TreBuchet MS' size='3'>Health Loading</font></td>"
                           "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                           "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                           "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                           "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                           "</tr>"
                           "<tr>"
                           "<td style='height:35px;padding: 5px 5px 5px 5px;'><font face='TreBuchet MS' size='3'>%@</font></td>"
                           "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                           "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                           "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                           "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                           "</tr>"
                           "<tr>"
                           "<td style='height:35px;padding: 5px 5px 5px 5px;'><font face='TreBuchet MS' size='3'>Sub-Total</font></td>"
                           "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                           "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                           "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                           "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                           "</tr>",url, BasicAnnually, BasicHalfYear, BasicQuarterly, BasicMonthly, OccpLoadA, OccpLoadH, OccpLoadQ, OccpLoadM, BasicHLAnnually, BasicHLHalfYear, BasicHLQuarterly, BasicHLMonthly, displayLSD, LSDAnnually, LSDHalfYear, LSDQuarterly, LSDMonthly, basicTotalA, basicTotalS, basicTotalQ, basicTotalM];
    
    NSString *htmlTail = nil;
    if ([riderCode count] != 0) {
        
        double _annualSUM = annualRiderSum + basicPremAnn;
        double _halfSUM = halfRiderSum + basicPremHalf;
        double _quarterSUM = quarterRiderSum + basicPremQuar;
        double _monthSUM = monthRiderSum + basicPremMonth;
        NSString *annualSUM = [formatter stringFromNumber:[NSNumber numberWithDouble:_annualSUM]];
        NSString *halfSUM = [formatter stringFromNumber:[NSNumber numberWithDouble:_halfSUM]];
        NSString *quarterSUM = [formatter stringFromNumber:[NSNumber numberWithDouble:_quarterSUM]];
        NSString *monthSUM = [formatter stringFromNumber:[NSNumber numberWithDouble:_monthSUM]];
        
        htmlTail = [[NSString alloc] initWithFormat:
                    @"<tr>"
                    "<td colspan='5'>&nbsp;</td>"
                    "</tr>"
                    "<tr style=\"background-color: black;\">"
                    "<td style='height:35px;padding: 5px 5px 5px 5px;'><font face='TreBuchet MS' size='3' color='white'><b>Total</b></font></td>"
                    "<td align='right'><font face='TreBuchet MS' size='3' color='white'><b>%@</b></font></td>"
                    "<td align='right'><font face='TreBuchet MS' size='3' color='white'><b>%@</b></font></td>"
                    "<td align='right'><font face='TreBuchet MS' size='3' color='white'><b>%@</b></font></td>"
                    "<td align='right'><font face='TreBuchet MS' size='3' color='white'><b>%@</b></font></td>"
                    "</tr>"
                    "</table></body></html>",annualSUM,halfSUM,quarterSUM,monthSUM];
        
        NSString *htmlString = [htmlBasic stringByAppendingString:htmlRider];
        htmlString = [htmlString stringByAppendingString:htmlTail];
        
        NSURL *baseURL = [NSURL URLWithString:@""];
        self.WebView.backgroundColor = [UIColor clearColor];
		self.WebView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
        [self.WebView setOpaque:NO];
        [WebView loadHTMLString:htmlString baseURL:baseURL];
    }
    else {
        
        htmlTail = [[NSString alloc] initWithFormat:
                    @"<tr>"
                    "<td colspan='5'>&nbsp;</td>"
                    "</tr>"
                    "<tr style=\"background-color: black;\">"
                    "<td style='height:35px;padding: 5px 5px 5px 5px;'><font face='TreBuchet MS' size='3' color='white'><b>Total</b></font></td>"
                    "<td align='right'><font face='TreBuchet MS' size='3' color='white'><b>%@</b></font></td>"
                    "<td align='right'><font face='TreBuchet MS' size='3' color='white'><b>%@</b></font></td>"
                    "<td align='right'><font face='TreBuchet MS' size='3' color='white'><b>%@</b></font></td>"
                    "<td align='right'><font face='TreBuchet MS' size='3' color='white'><b>%@</b></font></td>"
                    "</tr>"
                    "</table></body></html>",basicTotalA, basicTotalS, basicTotalQ, basicTotalM];
        
        
        NSString *htmlString = [htmlBasic stringByAppendingString:htmlTail];
        NSURL *baseURL = [NSURL URLWithString:@""];
		self.WebView.backgroundColor = [UIColor clearColor];
		self.WebView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
        [self.WebView setOpaque:NO];
        [WebView loadHTMLString:htmlString baseURL:baseURL];
    }
}

-(void)calculateBasicPremium
{
    double BasicSA = [getBasicSA doubleValue];
    double PolicyTerm = getTerm;
    double BasicHLoad = [getBasicHL doubleValue];
    double BasicTempHLoad = [getBasicTempHL doubleValue];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@""];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    
    //calculate basic premium
    double _BasicAnnually = basicRate * (BasicSA/1000) * 1;
    double _BasicHalfYear = basicRate * (BasicSA/1000) * 0.5125;
    double _BasicQuarterly = basicRate * (BasicSA/1000) * 0.2625;
    double _BasicMonthly = basicRate * (BasicSA/1000) * 0.0875;
    BasicAnnually = [formatter stringFromNumber:[NSNumber numberWithDouble:_BasicAnnually]];
    BasicHalfYear = [formatter stringFromNumber:[NSNumber numberWithDouble:_BasicHalfYear]];
    BasicQuarterly = [formatter stringFromNumber:[NSNumber numberWithDouble:_BasicQuarterly]];
    BasicMonthly = [formatter stringFromNumber:[NSNumber numberWithDouble:_BasicMonthly]];
    double BasicAnnually_ = [[BasicAnnually stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double BasicHalfYear_ = [[BasicHalfYear stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double BasicQuarterly_ = [[BasicQuarterly stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double BasicMonthly_ = [[BasicMonthly stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    NSLog(@"Basic A:%.2f, S:%.2f, Q:%.2f, M:%.2f",BasicAnnually_,BasicHalfYear_,BasicQuarterly_,BasicMonthly_);
    
    //calculate occupationLoading
    double _OccpLoadA = 0;
    double _OccpLoadH = 0;
    double _OccpLoadQ = 0;
    double _OccpLoadM = 0;
    if ([getBasicPlan isEqualToString:@"HLAIB"]) {
        _OccpLoadA = occLoad * ((PolicyTerm + 1)/2) * (BasicSA/1000) * 1;
        _OccpLoadH = occLoad * ((PolicyTerm + 1)/2) * (BasicSA/1000) * 0.5125;
        _OccpLoadQ = occLoad * ((PolicyTerm + 1)/2) * (BasicSA/1000) * 0.2625;
        _OccpLoadM = occLoad * ((PolicyTerm + 1)/2) * (BasicSA/1000) * 0.0875;
    }
    else {
        _OccpLoadA = occLoad *55 * (BasicSA/1000) * 1;
        _OccpLoadH = occLoad *55 * (BasicSA/1000) * 0.5125;
        _OccpLoadQ = occLoad *55 * (BasicSA/1000) * 0.2625;
        _OccpLoadM = occLoad *55 * (BasicSA/1000) * 0.0875;
    }
    OccpLoadA = [formatter stringFromNumber:[NSNumber numberWithDouble:_OccpLoadA]];
    OccpLoadH = [formatter stringFromNumber:[NSNumber numberWithDouble:_OccpLoadH]];
    OccpLoadQ = [formatter stringFromNumber:[NSNumber numberWithDouble:_OccpLoadQ]];
    OccpLoadM = [formatter stringFromNumber:[NSNumber numberWithDouble:_OccpLoadM]];
    double OccpLoadA_ = [[OccpLoadA stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double OccpLoadH_ = [[OccpLoadH stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double OccpLoadQ_ = [[OccpLoadQ stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double OccpLoadM_ = [[OccpLoadM stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    NSLog(@"OccpLoad A:%.2f, S:%.2f, Q:%.2f, M:%.2f",OccpLoadA_, OccpLoadH_, OccpLoadQ_, OccpLoadM_);
    
    //calculate basic health loading
    double _BasicHLAnnually = BasicHLoad * (BasicSA/1000) * 1;
    double _BasicHLHalfYear = BasicHLoad * (BasicSA/1000) * 0.5125;
    double _BasicHLQuarterly = BasicHLoad * (BasicSA/1000) * 0.2625;
    double _BasicHLMonthly = BasicHLoad * (BasicSA/1000) * 0.0875;
    //calculate basic temporary health loading
    double _BasicTempHLAnnually = BasicTempHLoad * (BasicSA/1000) * 1;
    double _BasicTempHLHalfYear = BasicTempHLoad * (BasicSA/1000) * 0.5125;
    double _BasicTempHLQuarterly = BasicTempHLoad * (BasicSA/1000) * 0.2625;
    double _BasicTempHLMonthly = BasicTempHLoad * (BasicSA/1000) * 0.0875;
    
    double _allBasicHLAnn = _BasicHLAnnually + _BasicTempHLAnnually;
    double _allBasicHLHalf = _BasicHLHalfYear + _BasicTempHLHalfYear;
    double _allBasicHLQuar = _BasicHLQuarterly + _BasicTempHLQuarterly;
    double _allBasicHLMonth = _BasicHLMonthly + _BasicTempHLMonthly;
    
    BasicHLAnnually = [formatter stringFromNumber:[NSNumber numberWithDouble:_allBasicHLAnn]];
    BasicHLHalfYear = [formatter stringFromNumber:[NSNumber numberWithDouble:_allBasicHLHalf]];
    BasicHLQuarterly = [formatter stringFromNumber:[NSNumber numberWithDouble:_allBasicHLQuar]];
    BasicHLMonthly = [formatter stringFromNumber:[NSNumber numberWithDouble:_allBasicHLMonth]];
    double BasicHLAnnually_ = [[BasicHLAnnually stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double BasicHLHalfYear_ = [[BasicHLHalfYear stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double BasicHLQuarterly_ = [[BasicHLQuarterly stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double BasicHLMonthly_ = [[BasicHLMonthly stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    NSLog(@"BasicHL A:%.3f, S:%.3f, Q:%.3f, M:%.3f",BasicHLAnnually_, BasicHLHalfYear_, BasicHLQuarterly_, BasicHLMonthly_);
    
    //calculate LSD    
    double _LSDAnnually = LSDRate * (BasicSA/1000) * 1;
    double _LSDHalfYear = LSDRate * (BasicSA/1000) * 0.5125;
    double _LSDQuarterly = LSDRate * (BasicSA/1000) * 0.2625;
    double _LSDMonthly = LSDRate * (BasicSA/1000) * 0.0875;
    NSString *LSDAnnually2 = [formatter stringFromNumber:[NSNumber numberWithDouble:_LSDAnnually]];
    NSString *LSDHalfYear2 = [formatter stringFromNumber:[NSNumber numberWithDouble:_LSDHalfYear]];
    NSString *LSDQuarterly2 = [formatter stringFromNumber:[NSNumber numberWithDouble:_LSDQuarterly]];
    NSString *LSDMonthly2 = [formatter stringFromNumber:[NSNumber numberWithDouble:_LSDMonthly]];
    //for negative value
    LSDAnnually2 = [LSDAnnually2 stringByReplacingOccurrencesOfString:@"(" withString:@""];
    LSDHalfYear2 = [LSDHalfYear2 stringByReplacingOccurrencesOfString:@"(" withString:@""];
    LSDQuarterly2 = [LSDQuarterly2 stringByReplacingOccurrencesOfString:@"(" withString:@""];
    LSDMonthly2 = [LSDMonthly2 stringByReplacingOccurrencesOfString:@"(" withString:@""];
    LSDAnnually2 = [LSDAnnually2 stringByReplacingOccurrencesOfString:@")" withString:@""];
    LSDHalfYear2 = [LSDHalfYear2 stringByReplacingOccurrencesOfString:@")" withString:@""];
    LSDQuarterly2 = [LSDQuarterly2 stringByReplacingOccurrencesOfString:@")" withString:@""];
    LSDMonthly2 = [LSDMonthly2 stringByReplacingOccurrencesOfString:@")" withString:@""];
    double LSDAnnually_ = [[LSDAnnually2 stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double LSDHalfYear_ = [[LSDHalfYear2 stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double LSDQuarterly_ = [[LSDQuarterly2 stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    double LSDMonthly_ = [[LSDMonthly2 stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    NSLog(@"BasicLSD A:%.2f, S:%.2f, Q:%.2f, M:%.2f",LSDAnnually_, LSDHalfYear_, LSDQuarterly_, LSDMonthly_);
    
    //calculate Total basic premium
    double _basicTotalA = 0;
    double _basicTotalS = 0;
    double _basicTotalQ = 0;	
    double _basicTotalM = 0;
    if (BasicSA < 1200) {
        _basicTotalA = BasicAnnually_ + OccpLoadA_ + BasicHLAnnually_ + LSDAnnually_;
        _basicTotalS = BasicHalfYear_ + OccpLoadH_ + BasicHLHalfYear_ + LSDHalfYear_;
        _basicTotalQ = BasicQuarterly_ + OccpLoadQ_ + BasicHLQuarterly_ + LSDQuarterly_;
        _basicTotalM = BasicMonthly_ + OccpLoadM_ + BasicHLMonthly_ + LSDMonthly_;
    }
    else {
        _basicTotalA = BasicAnnually_ + OccpLoadA_ + BasicHLAnnually_ - LSDAnnually_;
        _basicTotalS = BasicHalfYear_ + OccpLoadH_ + BasicHLHalfYear_ - LSDHalfYear_;
        _basicTotalQ = BasicQuarterly_ + OccpLoadQ_ + BasicHLQuarterly_ - LSDQuarterly_;
        _basicTotalM = BasicMonthly_ + OccpLoadM_ + BasicHLMonthly_ - LSDMonthly_;
    }
    
    LSDAnnually = [formatter stringFromNumber:[NSNumber numberWithDouble:LSDAnnually_]];
    LSDHalfYear = [formatter stringFromNumber:[NSNumber numberWithDouble:LSDHalfYear_]];
    LSDQuarterly = [formatter stringFromNumber:[NSNumber numberWithDouble:LSDQuarterly_]];
    LSDMonthly = [formatter stringFromNumber:[NSNumber numberWithDouble:LSDMonthly_]];
    
    basicTotalA = [formatter stringFromNumber:[NSNumber numberWithDouble:_basicTotalA]];
    basicTotalS = [formatter stringFromNumber:[NSNumber numberWithDouble:_basicTotalS]];
    basicTotalQ = [formatter stringFromNumber:[NSNumber numberWithDouble:_basicTotalQ]];
    basicTotalM = [formatter stringFromNumber:[NSNumber numberWithDouble:_basicTotalM]];
    
    //------------heng's part for SI report
    sqlite3_stmt *statement;
    NSString *QuerySQL =  [ NSString stringWithFormat: @"INSERT INTO SI_Store_Premium (\"Type\",\"Annually\",\"SemiAnnually\", "
                           " \"Quarterly\",\"Monthly\", 'SINO') VALUES "
                           " (\"B\", \"%@\", \"%@\", \"%@\", \"%@\", '%@') ", basicTotalA, basicTotalS, basicTotalQ, basicTotalM, SINo];
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        if (sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    double valueBeforeAdjustedA;
    double valueBeforeAdjustedS;
    double valueBeforeAdjustedQ;
    double valueBeforeAdjustedM;
    if (BasicSA < 1200) {
        valueBeforeAdjustedA = BasicAnnually_ + _OccpLoadA + BasicHLAnnually_ + LSDAnnually_;
        valueBeforeAdjustedS = BasicHalfYear_ + _OccpLoadH + BasicHLHalfYear_ + LSDHalfYear_;
        valueBeforeAdjustedQ = BasicQuarterly_ + _OccpLoadQ + BasicHLQuarterly_ + LSDQuarterly_;
        valueBeforeAdjustedM = BasicMonthly_ + _OccpLoadM + BasicHLMonthly_ + LSDMonthly_;
    }
    else{
        valueBeforeAdjustedA = BasicAnnually_ + _OccpLoadA + BasicHLAnnually_ - LSDAnnually_;
        valueBeforeAdjustedS = BasicHalfYear_ + _OccpLoadH + BasicHLHalfYear_ - LSDHalfYear_;
        valueBeforeAdjustedQ = BasicQuarterly_ + _OccpLoadQ + BasicHLQuarterly_ - LSDQuarterly_;
        valueBeforeAdjustedM = BasicMonthly_ + _OccpLoadM + BasicHLMonthly_ - LSDMonthly_;
    }
    
    QuerySQL =  [NSString stringWithFormat: @"INSERT INTO SI_Store_Premium (\"Type\",\"Annually\",\"SemiAnnually\", "
                 " \"Quarterly\",\"Monthly\", 'SINO') VALUES (\"BOriginal\", \"%.9f\", \"%.9f\", \"%.9f\", \"%.9f\", '%@') ",
                 valueBeforeAdjustedA, valueBeforeAdjustedS, valueBeforeAdjustedQ, valueBeforeAdjustedM, SINo];
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        if (sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    //--------------
    
    basicPremAnn = [[basicTotalA stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    basicPremHalf = [[basicTotalS stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    basicPremQuar = [[basicTotalQ stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    basicPremMonth = [[basicTotalM stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
    NSLog(@"BasicPrem:%.2f, S:%.2f, Q:%.2f, M:%.2f",basicPremAnn,basicPremHalf,basicPremQuar,basicPremMonth);
}

-(void)calculateRiderPrem
{
    NSMutableArray *annRiderTitle = [[NSMutableArray alloc] init];
    NSMutableArray *annRiderCode = [[NSMutableArray alloc] init];
    NSMutableArray *annRiderTerm = [[NSMutableArray alloc] init];
    annualRiderTot = [[NSMutableArray alloc] init];
    halfRiderTot = [[NSMutableArray alloc] init];
    quarterRiderTot = [[NSMutableArray alloc] init];
    monthRiderTot = [[NSMutableArray alloc] init];
    
    waiverRiderAnn = [[NSMutableArray alloc] init];
    waiverRiderHalf = [[NSMutableArray alloc] init];
    waiverRiderQuar = [[NSMutableArray alloc] init];
    waiverRiderMonth = [[NSMutableArray alloc] init];
    waiverRiderAnn2 = [[NSMutableArray alloc] init];
    waiverRiderHalf2 = [[NSMutableArray alloc] init];
    waiverRiderQuar2 = [[NSMutableArray alloc] init];
    waiverRiderMonth2 = [[NSMutableArray alloc] init];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@""];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    
    NSUInteger i;
    for (i=0; i<[riderCode count]; i++) {
        
        NSString *RidCode = [[NSString alloc] initWithFormat:@"%@",[riderCode objectAtIndex:i]];
        NSLog(@"riderCode:%@",RidCode);
        
        //getpentacode
        const char *dbpath = [databasePath UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            if ([RidCode isEqualToString:@"C+"])
            {
                if ([[riderPlanOpt objectAtIndex:i] isEqualToString:@"Level"]) {
                    plnOptC = @"L";
                } else if ([[riderPlanOpt objectAtIndex:i] isEqualToString:@"Increasing"]) {
                    plnOptC = @"I";
                } else if ([[riderPlanOpt objectAtIndex:i] isEqualToString:@"Level_NCB"]) {
                    plnOptC = @"B";
                } else if ([[riderPlanOpt objectAtIndex:i] isEqualToString:@"Increasing_NCB"]) {
                    plnOptC = @"N";
                }
                
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"C+\" AND PlanOption=\"%@\"",plnOptC];
                
            }
            else if ([RidCode isEqualToString:@"HMM"])
            {
                planOptHMM = [riderPlanOpt objectAtIndex:i];
                deducHMM = [riderDeduct objectAtIndex:i];
                pentaSQL = [[NSString alloc] initWithFormat:
                            @"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"HMM\" AND PlanOption=\"%@\" AND Deductible=\"%@\" AND FromAge <= \"%@\" AND ToAge >= \"%@\"",planOptHMM,deducHMM,[riderAge objectAtIndex:i],[riderAge objectAtIndex:i]];
            }
            else if ([RidCode isEqualToString:@"HSP_II"])
            {
                if ([[riderPlanOpt objectAtIndex:i] isEqualToString:@"Standard"]) {
                    planHSPII = @"S";
                } else if ([[riderPlanOpt objectAtIndex:i] isEqualToString:@"Deluxe"]) {
                    planHSPII = @"D";
                } else if ([[riderPlanOpt objectAtIndex:i] isEqualToString:@"Premier"]) {
                    planHSPII = @"P";
                }
                pentaSQL = [[NSString alloc] initWithFormat:
                            @"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"HSP_II\" AND PlanOption=\"%@\"",planHSPII];
            }
            else if ([RidCode isEqualToString:@"MG_II"])
            {
                planMGII = [riderPlanOpt objectAtIndex:i];
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"MG_II\" AND PlanOption=\"%@\"",planMGII];
            }
            else if ([RidCode isEqualToString:@"I20R"]||[RidCode isEqualToString:@"I30R"]||[RidCode isEqualToString:@"I40R"]||[RidCode isEqualToString:@"ID20R"]||[RidCode isEqualToString:@"ID30R"]||[RidCode isEqualToString:@"ID40R"]||[RidCode isEqualToString:@"IE20R"]||[RidCode isEqualToString:@"IE30R"])
            {
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"%@\" AND PremPayOpt=\"%d\"",[riderCode objectAtIndex:i],getMOP];
                
            }
            else if ([RidCode isEqualToString:@"ICR"])
            {
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"ICR\" AND Smoker=\"%@\"",[riderSmoker objectAtIndex:i]];
                
            }
            else if ([RidCode isEqualToString:@"MG_IV"])
            {
                planMGIV = [riderPlanOpt objectAtIndex:i];
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"MG_IV\" AND PlanOption=\"%@\" AND FromAge <= \"%@\" AND ToAge >= \"%@\"",planMGIV,[riderAge objectAtIndex:i],[riderAge objectAtIndex:i]];
            }
            else if ([RidCode isEqualToString:@"EDB"]||[RidCode isEqualToString:@"ETPDB"])
            {
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"%@\"",RidCode];
            }
            else if ([RidCode isEqualToString:@"CIWP"]||[RidCode isEqualToString:@"LCWP"]||[RidCode isEqualToString:@"PR"]||[RidCode isEqualToString:@"SP_STD"]||[RidCode isEqualToString:@"SP_PRE"]) {
                sqlite3_close(contactDB);
                continue;
            }
            else {
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"%@\" AND Channel=\"AGT\"",RidCode];
            }
            
//            NSLog(@"%@",pentaSQL);
            const char *query_stmt = [pentaSQL UTF8String];
            if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_ROW)
                {
                    planCodeRider =  [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    NSLog(@"pentaRider:%@",planCodeRider);
                }
                else {
                    NSLog(@"error access PentaPlanCode");
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
        
        int ridTerm = [[riderTerm objectAtIndex:i] intValue];
        age = [[riderAge objectAtIndex:i] intValue];
        sex = [[NSString alloc] initWithFormat:@"%@",[riderSex objectAtIndex:i]];
        //get rate
        if ([RidCode isEqualToString:@"I20R"]||[RidCode isEqualToString:@"I30R"]||[RidCode isEqualToString:@"I40R"]||[RidCode isEqualToString:@"ID20R"]||[RidCode isEqualToString:@"ID30R"]||[RidCode isEqualToString:@"ID40R"]||[RidCode isEqualToString:@"IE20R"]||[RidCode isEqualToString:@"IE30R"])
        {
            [self getRiderRateAge:planCodeRider riderTerm:ridTerm];
        }
        else if ([RidCode isEqualToString:@"CPA"]) {
            [self getRiderRateClass:planCodeRider riderTerm:ridTerm];
        }
        else if ([RidCode isEqualToString:@"PA"]||[RidCode isEqualToString:@"HSP_II"]) {
            [self getRiderRateAgeClass:planCodeRider riderTerm:ridTerm code:RidCode];
        }
        else if ([RidCode isEqualToString:@"HB"]) {
            [self getRiderRateSex:planCodeRider riderTerm:ridTerm];
        }
        else if ([RidCode isEqualToString:@"MG_IV"]||[RidCode isEqualToString:@"MG_II"]||[RidCode isEqualToString:@"HMM"]) {
            [self getRiderRateAgeSexClass:planCodeRider riderTerm:ridTerm code:RidCode];
        }
        else if ([RidCode isEqualToString:@"EDB"] ||[RidCode isEqualToString:@"ETPDB"]) {
            [self getRiderRateSex:planCodeRider];
        }
        else {
            [self getRiderRateAgeSex:planCodeRider riderTerm:ridTerm];
        }
        
        double BasicSA = [getBasicSA doubleValue];
//        double BasicHLoad = [getBasicHL doubleValue];
        
        double ridSA = [[riderSA objectAtIndex:i] doubleValue];
        double PolicyTerm = getTerm;
        double riderHLoad = 0;
        double riderTempHLoad = 0;
        
        //--get value rider HL 
        if ([[riderHL1K objectAtIndex:i] doubleValue] > 0) {
            riderHLoad = [[riderHL1K objectAtIndex:i] doubleValue];
        }
        else if ([[riderHL100 objectAtIndex:i] doubleValue] > 0) {
            riderHLoad = [[riderHL100 objectAtIndex:i] doubleValue];
        }
        else if ([[riderHLP objectAtIndex:i] doubleValue] > 0) {
            riderHLoad = [[riderHLP objectAtIndex:i] doubleValue];
        }
        
        if ([[riderTempHL1K objectAtIndex:i] doubleValue] > 0) {
            riderTempHLoad = [[riderTempHL1K objectAtIndex:i] doubleValue];
        }
        NSLog(@"~riderRate(%@):%.2f, ridersum:%.3f, HL:%.3f, tempHL:%.3f",RidCode,riderRate,ridSA,riderHLoad,riderTempHLoad);
        
        double annFac;
        double halfFac;
        double quarterFac;
        double monthFac;
        if ([RidCode isEqualToString:@"HB"]) {
            annFac = 1;
            halfFac = 0.55;
            quarterFac = 0.3;
            monthFac = 0.1;
        }
        else {
            annFac = 1;
            halfFac = 0.5125;
            quarterFac = 0.2625;
            monthFac = 0.0875;
        }
        
        //calculate occupationLoading
        strOccp = [riderOccp objectAtIndex:i];
        [self getOccLoadRider];
        NSLog(@"occpLoadRate(%@):%d",RidCode,occLoadRider);

        double OccpLoadRidA = occLoadRider * ((PolicyTerm + 1)/2) * (BasicSA/1000) * annFac;
        double OccpLoadRidH = occLoadRider * ((PolicyTerm + 1)/2) * (BasicSA/1000) * halfFac;
        double OccpLoadRidQ = occLoadRider * ((PolicyTerm + 1)/2) * (BasicSA/1000) * quarterFac;
        double OccpLoadRidM = occLoadRider * ((PolicyTerm + 1)/2) * (BasicSA/1000) * monthFac;
        NSLog(@"OccpLoad A:%.3f, S:%.3f, Q:%.3f, M:%.3f",OccpLoadRidA,OccpLoadRidH,OccpLoadRidQ,OccpLoadRidM);
        
        if ([RidCode isEqualToString:@"ETPD"])
        {
            double _ann = (riderRate *ridSA /100 *annFac);
            double _half = (riderRate *ridSA /100 *halfFac);
            double _quar = (riderRate *ridSA /100 *quarterFac);
            double _month = (riderRate *ridSA /100 *monthFac);
            NSString *str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:_ann]];
            NSString *str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:_half]];
            NSString *str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:_quar]];
            NSString *str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:_month]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            //--HL--
            double _HLAnn = (riderHLoad /10 *ridSA /100 *annFac);
            double _HLHalf = (riderHLoad /10 *ridSA /100 *halfFac);
            double _HLQuar = (riderHLoad /10 *ridSA /100 *quarterFac);
            double _HLMonth = (riderHLoad /10 *ridSA /100 *monthFac);
            NSString *str_HLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLAnn]];
            NSString *str_HLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLHalf]];
            NSString *str_HLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLQuar]];
            NSString *str_HLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLMonth]];
            str_HLAnn = [str_HLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLHalf = [str_HLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLQuar = [str_HLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLMonth = [str_HLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _TempHLAnn = (riderTempHLoad /10 *ridSA /100 *annFac);
            double _TempHLHalf = (riderTempHLoad /10 *ridSA /100 *halfFac);
            double _TempHLQuar = (riderTempHLoad /10 *ridSA /100 *quarterFac);
            double _TempHLMonth = (riderTempHLoad /10 *ridSA /100 *monthFac);
            NSString *str_TempHLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLAnn]];
            NSString *str_TempHLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLHalf]];
            NSString *str_TempHLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLQuar]];
            NSString *str_TempHLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLMonth]];
            str_TempHLAnn = [str_TempHLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLHalf = [str_TempHLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLQuar = [str_TempHLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLMonth = [str_TempHLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _allRiderHLAnn = [str_HLAnn doubleValue] + [str_TempHLAnn doubleValue];
            double _allRiderHLHalf = [str_HLHalf doubleValue] + [str_TempHLHalf doubleValue];
            double _allRiderHLQuar = [str_HLQuar doubleValue] + [str_TempHLQuar doubleValue];
            double _allRiderHLMonth = [str_HLMonth doubleValue] + [str_TempHLMonth doubleValue];
            //--end--
            annualRider = [str_ann doubleValue] + _allRiderHLAnn;
            halfYearRider = [str_half doubleValue] + _allRiderHLHalf;
            quarterRider = [str_quar doubleValue] + _allRiderHLQuar;
            monthlyRider = [str_month doubleValue] + _allRiderHLMonth;
        }
        else if ([RidCode isEqualToString:@"I20R"]||[RidCode isEqualToString:@"I30R"]||[RidCode isEqualToString:@"I40R"]||[RidCode isEqualToString:@"IE20R"]||[RidCode isEqualToString:@"IE30R"])
        {
            //--Occp Load
            double occLoadFactorA = occLoadRider * (((double)(ridTerm + 1))/2);
            double occLoadFactorH = occLoadRider * (((double)(ridTerm + 1))/2);
            double occLoadFactorQ = occLoadRider * (((double)(ridTerm + 1))/2);
            double occLoadFactorM = occLoadRider * (((double)(ridTerm + 1))/2);
            
            double calLoadA = occLoadFactorA *ridSA /1000 *annFac;
            double calLoadH = occLoadFactorH *ridSA /1000 *halfFac;
            double calLoadQ = occLoadFactorQ *ridSA /1000 *quarterFac;
            double calLoadM = occLoadFactorM *ridSA /1000 *monthFac;
            NSString *strLoadA = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadA]];
            NSString *strLoadH = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadH]];
            NSString *strLoadQ = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadQ]];
            NSString *strLoadM = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadM]];
            strLoadA = [strLoadA stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadH = [strLoadH stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadQ = [strLoadQ stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadM = [strLoadM stringByReplacingOccurrencesOfString:@"," withString:@""];
            //--end
            double _ann = (riderRate *ridSA /1000 *annFac);
            double _half = (riderRate *ridSA /1000 *halfFac);
            double _quar = (riderRate *ridSA /1000 *quarterFac);
            double _month = (riderRate *ridSA /1000 *monthFac);
            NSString *str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:_ann]];
            NSString *str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:_half]];
            NSString *str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:_quar]];
            NSString *str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:_month]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            //--HL
            double _HLAnn = (riderHLoad *ridSA /1000 *annFac);
            double _HLHalf = (riderHLoad *ridSA /1000 *halfFac);
            double _HLQuar = (riderHLoad *ridSA /1000 *quarterFac);
            double _HLMonth = (riderHLoad *ridSA /1000 *monthFac);
            NSString *str_HLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLAnn]];
            NSString *str_HLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLHalf]];
            NSString *str_HLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLQuar]];
            NSString *str_HLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLMonth]];
            str_HLAnn = [str_HLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLHalf = [str_HLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLQuar = [str_HLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLMonth = [str_HLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _TempHLAnn = (riderTempHLoad *ridSA /1000 *annFac);
            double _TempHLHalf = (riderTempHLoad *ridSA /1000 *halfFac);
            double _TempHLQuar = (riderTempHLoad *ridSA /1000 *quarterFac);
            double _TempHLMonth = (riderTempHLoad *ridSA /1000 *monthFac);
            NSString *str_TempHLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLAnn]];
            NSString *str_TempHLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLHalf]];
            NSString *str_TempHLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLQuar]];
            NSString *str_TempHLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLMonth]];
            str_TempHLAnn = [str_TempHLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLHalf = [str_TempHLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLQuar = [str_TempHLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLMonth = [str_TempHLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _allRiderHLAnn = [str_HLAnn doubleValue] + [str_TempHLAnn doubleValue];
            double _allRiderHLHalf = [str_HLHalf doubleValue] + [str_TempHLHalf doubleValue];
            double _allRiderHLQuar = [str_HLQuar doubleValue] + [str_TempHLQuar doubleValue];
            double _allRiderHLMonth = [str_HLMonth doubleValue] + [str_TempHLMonth doubleValue];
            //--end
            annualRider = [str_ann doubleValue] + [strLoadA doubleValue] + _allRiderHLAnn;
            halfYearRider = [str_half doubleValue] + [strLoadH doubleValue] + _allRiderHLHalf;
            quarterRider = [str_quar doubleValue] + [strLoadQ doubleValue] + _allRiderHLQuar;
            monthlyRider = [str_month doubleValue] + [strLoadM doubleValue] + _allRiderHLMonth;
        }
        else if ([RidCode isEqualToString:@"ICR"])
        {
            double _ann = (riderRate *ridSA /1000 *annFac);
            double _half = (riderRate *ridSA /1000 *halfFac);
            double _quar = (riderRate *ridSA /1000 *quarterFac);
            double _month = (riderRate *ridSA /1000 *monthFac);
            NSString *str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:_ann]];
            NSString *str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:_half]];
            NSString *str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:_quar]];
            NSString *str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:_month]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            //--HL
            double _HLAnn = (riderHLoad *ridSA /1000 *annFac);
            double _HLHalf = (riderHLoad *ridSA /1000 *halfFac);
            double _HLQuar = (riderHLoad *ridSA /1000 *quarterFac);
            double _HLMonth = (riderHLoad *ridSA /1000 *monthFac);
            NSString *str_HLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLAnn]];
            NSString *str_HLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLHalf]];
            NSString *str_HLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLQuar]];
            NSString *str_HLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLMonth]];
            str_HLAnn = [str_HLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLHalf = [str_HLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLQuar = [str_HLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLMonth = [str_HLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _TempHLAnn = (riderTempHLoad *ridSA /1000 *annFac);
            double _TempHLHalf = (riderTempHLoad *ridSA /1000 *halfFac);
            double _TempHLQuar = (riderTempHLoad *ridSA /1000 *quarterFac);
            double _TempHLMonth = (riderTempHLoad *ridSA /1000 *monthFac);
            NSString *str_TempHLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLAnn]];
            NSString *str_TempHLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLHalf]];
            NSString *str_TempHLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLQuar]];
            NSString *str_TempHLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLMonth]];
            str_TempHLAnn = [str_TempHLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLHalf = [str_TempHLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLQuar = [str_TempHLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLMonth = [str_TempHLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _allRiderHLAnn = [str_HLAnn doubleValue] + [str_TempHLAnn doubleValue];
            double _allRiderHLHalf = [str_HLHalf doubleValue] + [str_TempHLHalf doubleValue];
            double _allRiderHLQuar = [str_HLQuar doubleValue] + [str_TempHLQuar doubleValue];
            double _allRiderHLMonth = [str_HLMonth doubleValue] + [str_TempHLMonth doubleValue];
            //--end
            
            annualRider = [str_ann doubleValue] + _allRiderHLAnn;
            halfYearRider = [str_half doubleValue] + _allRiderHLHalf;
            quarterRider = [str_quar doubleValue] + _allRiderHLQuar;
            monthlyRider = [str_month doubleValue] + _allRiderHLMonth;
        }
        else if ([RidCode isEqualToString:@"ID20R"])
        {
            double occLoadFactorA = occLoadRider * (((double)(ridTerm - 20))/2);
            double occLoadFactorH = occLoadRider * (((double)(ridTerm - 20))/2);
            double occLoadFactorQ = occLoadRider * (((double)(ridTerm - 20))/2);
            double occLoadFactorM = occLoadRider * (((double)(ridTerm - 20))/2);
            
            double calLoadA = occLoadFactorA *ridSA /1000 *annFac;
            double calLoadH = occLoadFactorH *ridSA /1000 *halfFac;
            double calLoadQ = occLoadFactorQ *ridSA /1000 *quarterFac;
            double calLoadM = occLoadFactorM *ridSA /1000 *monthFac;
            NSString *strLoadA = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadA]];
            NSString *strLoadH = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadH]];
            NSString *strLoadQ = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadQ]];
            NSString *strLoadM = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadM]];
            strLoadA = [strLoadA stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadH = [strLoadH stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadQ = [strLoadQ stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadM = [strLoadM stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _ann = (riderRate *ridSA /1000 *annFac);
            double _half = (riderRate *ridSA /1000 *halfFac);
            double _quar = (riderRate *ridSA /1000 *quarterFac);
            double _month = (riderRate *ridSA /1000 *monthFac);
            NSString *str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:_ann]];
            NSString *str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:_half]];
            NSString *str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:_quar]];
            NSString *str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:_month]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            //HL
            double _HLAnn = (riderHLoad *ridSA /1000 *annFac);
            double _HLHalf = (riderHLoad *ridSA /1000 *halfFac);
            double _HLQuar = (riderHLoad *ridSA /1000 *quarterFac);
            double _HLMonth = (riderHLoad *ridSA /1000 *monthFac);
            NSString *str_HLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLAnn]];
            NSString *str_HLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLHalf]];
            NSString *str_HLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLQuar]];
            NSString *str_HLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLMonth]];
            str_HLAnn = [str_HLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLHalf = [str_HLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLQuar = [str_HLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLMonth = [str_HLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _TempHLAnn = (riderTempHLoad *ridSA /1000 *annFac);
            double _TempHLHalf = (riderTempHLoad *ridSA /1000 *halfFac);
            double _TempHLQuar = (riderTempHLoad *ridSA /1000 *quarterFac);
            double _TempHLMonth = (riderTempHLoad *ridSA /1000 *monthFac);
            NSString *str_TempHLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLAnn]];
            NSString *str_TempHLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLHalf]];
            NSString *str_TempHLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLQuar]];
            NSString *str_TempHLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLMonth]];
            str_TempHLAnn = [str_TempHLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLHalf = [str_TempHLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLQuar = [str_TempHLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLMonth = [str_TempHLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _allRiderHLAnn = [str_HLAnn doubleValue] + [str_TempHLAnn doubleValue];
            double _allRiderHLHalf = [str_HLHalf doubleValue] + [str_TempHLHalf doubleValue];
            double _allRiderHLQuar = [str_HLQuar doubleValue] + [str_TempHLQuar doubleValue];
            double _allRiderHLMonth = [str_HLMonth doubleValue] + [str_TempHLMonth doubleValue];
            //--end
            
            annualRider = [str_ann doubleValue] + [strLoadA doubleValue] + _allRiderHLAnn;
            halfYearRider = [str_half doubleValue] + [strLoadH doubleValue] + _allRiderHLHalf;
            quarterRider = [str_quar doubleValue] + [strLoadQ doubleValue] + _allRiderHLQuar;
            monthlyRider = [str_month doubleValue] + [strLoadM doubleValue] + _allRiderHLMonth;
            
        }
        else if ([RidCode isEqualToString:@"ID30R"])
        {
            double occLoadFactorA = occLoadRider * (((double)(ridTerm - 30))/2);
            double occLoadFactorH = occLoadRider * (((double)(ridTerm - 30))/2);
            double occLoadFactorQ = occLoadRider * (((double)(ridTerm - 30))/2);
            double occLoadFactorM = occLoadRider * (((double)(ridTerm - 30))/2);
            
            double calLoadA = occLoadFactorA *ridSA /1000 *annFac;
            double calLoadH = occLoadFactorH *ridSA /1000 *halfFac;
            double calLoadQ = occLoadFactorQ *ridSA /1000 *quarterFac;
            double calLoadM = occLoadFactorM *ridSA /1000 *monthFac;
            NSString *strLoadA = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadA]];
            NSString *strLoadH = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadH]];
            NSString *strLoadQ = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadQ]];
            NSString *strLoadM = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadM]];
            strLoadA = [strLoadA stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadH = [strLoadH stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadQ = [strLoadQ stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadM = [strLoadM stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _ann = (riderRate *ridSA /1000 *annFac);
            double _half = (riderRate *ridSA /1000 *halfFac);
            double _quar = (riderRate *ridSA /1000 *quarterFac);
            double _month = (riderRate *ridSA /1000 *monthFac);
            NSString *str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:_ann]];
            NSString *str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:_half]];
            NSString *str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:_quar]];
            NSString *str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:_month]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            //--HL
            double _HLAnn = (riderHLoad *ridSA /1000 *annFac);
            double _HLHalf = (riderHLoad *ridSA /1000 *halfFac);
            double _HLQuar = (riderHLoad *ridSA /1000 *quarterFac);
            double _HLMonth = (riderHLoad *ridSA /1000 *monthFac);
            NSString *str_HLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLAnn]];
            NSString *str_HLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLHalf]];
            NSString *str_HLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLQuar]];
            NSString *str_HLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLMonth]];
            str_HLAnn = [str_HLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLHalf = [str_HLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLQuar = [str_HLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLMonth = [str_HLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _TempHLAnn = (riderTempHLoad *ridSA /1000 *annFac);
            double _TempHLHalf = (riderTempHLoad *ridSA /1000 *halfFac);
            double _TempHLQuar = (riderTempHLoad *ridSA /1000 *quarterFac);
            double _TempHLMonth = (riderTempHLoad *ridSA /1000 *monthFac);
            NSString *str_TempHLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLAnn]];
            NSString *str_TempHLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLHalf]];
            NSString *str_TempHLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLQuar]];
            NSString *str_TempHLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLMonth]];
            str_TempHLAnn = [str_TempHLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLHalf = [str_TempHLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLQuar = [str_TempHLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLMonth = [str_TempHLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _allRiderHLAnn = [str_HLAnn doubleValue] + [str_TempHLAnn doubleValue];
            double _allRiderHLHalf = [str_HLHalf doubleValue] + [str_TempHLHalf doubleValue];
            double _allRiderHLQuar = [str_HLQuar doubleValue] + [str_TempHLQuar doubleValue];
            double _allRiderHLMonth = [str_HLMonth doubleValue] + [str_TempHLMonth doubleValue];
            //--end
            
            annualRider = [str_ann doubleValue] + [strLoadA doubleValue] + _allRiderHLAnn;
            halfYearRider = [str_half doubleValue] + [strLoadH doubleValue] + _allRiderHLHalf;
            quarterRider = [str_quar doubleValue] + [strLoadQ doubleValue] + _allRiderHLQuar;
            monthlyRider = [str_month doubleValue] + [strLoadM doubleValue] + _allRiderHLMonth;
            
        }
        else if ([RidCode isEqualToString:@"ID40R"])
        {
            double occLoadFactorA = occLoadRider * (((double)(ridTerm - 40))/2);
            double occLoadFactorH = occLoadRider * (((double)(ridTerm - 40))/2);
            double occLoadFactorQ = occLoadRider * (((double)(ridTerm - 40))/2);
            double occLoadFactorM = occLoadRider * (((double)(ridTerm - 40))/2);
            
            double calLoadA = occLoadFactorA *ridSA /1000 *annFac;
            double calLoadH = occLoadFactorH *ridSA /1000 *halfFac;
            double calLoadQ = occLoadFactorQ *ridSA /1000 *quarterFac;
            double calLoadM = occLoadFactorM *ridSA /1000 *monthFac;
            NSString *strLoadA = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadA]];
            NSString *strLoadH = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadH]];
            NSString *strLoadQ = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadQ]];
            NSString *strLoadM = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadM]];
            strLoadA = [strLoadA stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadH = [strLoadH stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadQ = [strLoadQ stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadM = [strLoadM stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _ann = (riderRate *ridSA /1000 *annFac);
            double _half = (riderRate *ridSA /1000 *halfFac);
            double _quar = (riderRate *ridSA /1000 *quarterFac);
            double _month = (riderRate *ridSA /1000 *monthFac);
            NSString *str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:_ann]];
            NSString *str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:_half]];
            NSString *str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:_quar]];
            NSString *str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:_month]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            //--HL
            double _HLAnn = (riderHLoad *ridSA /1000 *annFac);
            double _HLHalf = (riderHLoad *ridSA /1000 *halfFac);
            double _HLQuar = (riderHLoad *ridSA /1000 *quarterFac);
            double _HLMonth = (riderHLoad *ridSA /1000 *monthFac);
            NSString *str_HLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLAnn]];
            NSString *str_HLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLHalf]];
            NSString *str_HLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLQuar]];
            NSString *str_HLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLMonth]];
            str_HLAnn = [str_HLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLHalf = [str_HLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLQuar = [str_HLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLMonth = [str_HLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _TempHLAnn = (riderTempHLoad *ridSA /1000 *annFac);
            double _TempHLHalf = (riderTempHLoad *ridSA /1000 *halfFac);
            double _TempHLQuar = (riderTempHLoad *ridSA /1000 *quarterFac);
            double _TempHLMonth = (riderTempHLoad *ridSA /1000 *monthFac);
            NSString *str_TempHLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLAnn]];
            NSString *str_TempHLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLHalf]];
            NSString *str_TempHLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLQuar]];
            NSString *str_TempHLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLMonth]];
            str_TempHLAnn = [str_TempHLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLHalf = [str_TempHLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLQuar = [str_TempHLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLMonth = [str_TempHLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _allRiderHLAnn = [str_HLAnn doubleValue] + [str_TempHLAnn doubleValue];
            double _allRiderHLHalf = [str_HLHalf doubleValue] + [str_TempHLHalf doubleValue];
            double _allRiderHLQuar = [str_HLQuar doubleValue] + [str_TempHLQuar doubleValue];
            double _allRiderHLMonth = [str_HLMonth doubleValue] + [str_TempHLMonth doubleValue];
            //--end
            
            annualRider = [str_ann doubleValue] + [strLoadA doubleValue] + _allRiderHLAnn;
            halfYearRider = [str_half doubleValue] + [strLoadH doubleValue] + _allRiderHLHalf;
            quarterRider = [str_quar doubleValue] + [strLoadQ doubleValue] + _allRiderHLQuar;
            monthlyRider = [str_month doubleValue] + [strLoadM doubleValue] + _allRiderHLMonth;
        }
        else if ([RidCode isEqualToString:@"MG_II"]||[RidCode isEqualToString:@"MG_IV"]||[RidCode isEqualToString:@"HSP_II"]||[RidCode isEqualToString:@"HMM"])
        {
            annualRider = riderRate * (1 + (riderHLoad+riderTempHLoad)/100) * annFac;
            halfYearRider = riderRate * (1 + (riderHLoad+riderTempHLoad)/100) * halfFac;
            quarterRider = riderRate * (1 + (riderHLoad+riderTempHLoad)/100) * quarterFac;
            monthlyRider = riderRate * (1 + (riderHLoad+riderTempHLoad)/100) * monthFac;
            
            // For report part ---------- added by heng
            if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
                for (int a = 0; a<ReportHMMRates.count; a++) {
                    
                    double annualRates = [[ReportHMMRates objectAtIndex:a] doubleValue ] * (1 + riderHLoad/100) * annFac;
                    //[ReportRates addObject:[NSString stringWithFormat:@"%.9f", annualRates]];
                    
                    NSString *querySQL = [NSString stringWithFormat: @"INSERT INTO SI_Store_premium (\"Type\",\"Annually\",\"FromAge\", \"ToAge\", 'SINO') "
                                          " VALUES(\"%@\", \"%.9f\", \"%@\", \"%@\", '%@')",
                                          RidCode, annualRates, [ReportFromAge objectAtIndex:a], [ReportToAge objectAtIndex:a], SINo];
                    
                    if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
                    {
                        if (sqlite3_step(statement) == SQLITE_DONE)
                        {
                            
                        }
                        sqlite3_finalize(statement);
                    }
                    
                }
                sqlite3_close(contactDB);
            }
            // report part end -----------

        }
        else if ([RidCode isEqualToString:@"HB"])
        {
            int selectUnit = [[riderUnit objectAtIndex:i] intValue];
            annualRider = riderRate * (1 + (riderHLoad+riderTempHLoad)/100) * selectUnit * annFac;
            halfYearRider = riderRate * (1 + (riderHLoad+riderTempHLoad)/100) * selectUnit * halfFac;
            quarterRider = riderRate * (1 + (riderHLoad+riderTempHLoad)/100) * selectUnit * quarterFac;
            monthlyRider = riderRate * (1 + (riderHLoad+riderTempHLoad)/100) * selectUnit * monthFac;
        }
        else if ([RidCode isEqualToString:@"CIR"]||[RidCode isEqualToString:@"C+"])
        {
            double _ann = (riderRate *ridSA /1000 *annFac);
            double _half = (riderRate *ridSA /1000 *halfFac);
            double _quar = (riderRate *ridSA /1000 *quarterFac);
            double _month = (riderRate *ridSA /1000 *monthFac);
            NSString *str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:_ann]];
            NSString *str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:_half]];
            NSString *str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:_quar]];
            NSString *str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:_month]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            //--HL
            double _HLAnn = (riderHLoad *ridSA /1000 *annFac);
            double _HLHalf = (riderHLoad *ridSA /1000 *halfFac);
            double _HLQuar = (riderHLoad *ridSA /1000 *quarterFac);
            double _HLMonth = (riderHLoad *ridSA /1000 *monthFac);
            NSString *str_HLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLAnn]];
            NSString *str_HLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLHalf]];
            NSString *str_HLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLQuar]];
            NSString *str_HLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLMonth]];
            str_HLAnn = [str_HLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLHalf = [str_HLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLQuar = [str_HLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLMonth = [str_HLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _TempHLAnn = (riderTempHLoad *ridSA /1000 *annFac);
            double _TempHLHalf = (riderTempHLoad *ridSA /1000 *halfFac);
            double _TempHLQuar = (riderTempHLoad *ridSA /1000 *quarterFac);
            double _TempHLMonth = (riderTempHLoad *ridSA /1000 *monthFac);
            NSString *str_TempHLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLAnn]];
            NSString *str_TempHLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLHalf]];
            NSString *str_TempHLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLQuar]];
            NSString *str_TempHLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLMonth]];
            str_TempHLAnn = [str_TempHLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLHalf = [str_TempHLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLQuar = [str_TempHLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLMonth = [str_TempHLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _allRiderHLAnn = [str_HLAnn doubleValue] + [str_TempHLAnn doubleValue];
            double _allRiderHLHalf = [str_HLHalf doubleValue] + [str_TempHLHalf doubleValue];
            double _allRiderHLQuar = [str_HLQuar doubleValue] + [str_TempHLQuar doubleValue];
            double _allRiderHLMonth = [str_HLMonth doubleValue] + [str_TempHLMonth doubleValue];
            //--end
            
            annualRider = [str_ann doubleValue] + _allRiderHLAnn;
            halfYearRider = [str_half doubleValue] + _allRiderHLHalf;
            quarterRider = [str_quar doubleValue] + _allRiderHLQuar;
            monthlyRider = [str_month doubleValue] + _allRiderHLMonth;
        }
        else if ([RidCode isEqualToString:@"EDB"] || [RidCode isEqualToString:@"ETPDB"]) {
            double _ann = (riderRate *ridSA /1000 *annFac);
            double _half = (riderRate *ridSA /1000 *halfFac);
            double _quar = (riderRate *ridSA /1000 *quarterFac);
            double _month = (riderRate *ridSA /1000 *monthFac);
            NSString *str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:_ann]];
            NSString *str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:_half]];
            NSString *str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:_quar]];
            NSString *str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:_month]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double calLoadA = occLoadRider *3 *ridSA /1000 *annFac;
            double calLoadH = occLoadRider *3 *ridSA /1000 *halfFac;
            double calLoadQ = occLoadRider *3 *ridSA /1000 *quarterFac;
            double calLoadM = occLoadRider *3 *ridSA /1000 *monthFac;
            NSString *strLoadA = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadA]];
            NSString *strLoadH = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadH]];
            NSString *strLoadQ = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadQ]];
            NSString *strLoadM = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadM]];
            strLoadA = [strLoadA stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadH = [strLoadH stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadQ = [strLoadQ stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadM = [strLoadM stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            //--HL
            double _HLAnn = (riderHLoad *ridSA /1000 *annFac);
            double _HLHalf = (riderHLoad *ridSA /1000 *halfFac);
            double _HLQuar = (riderHLoad *ridSA /1000 *quarterFac);
            double _HLMonth = (riderHLoad *ridSA /1000 *monthFac);
            NSString *str_HLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLAnn]];
            NSString *str_HLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLHalf]];
            NSString *str_HLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLQuar]];
            NSString *str_HLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLMonth]];
            str_HLAnn = [str_HLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLHalf = [str_HLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLQuar = [str_HLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLMonth = [str_HLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _TempHLAnn = (riderTempHLoad *ridSA /1000 *annFac);
            double _TempHLHalf = (riderTempHLoad *ridSA /1000 *halfFac);
            double _TempHLQuar = (riderTempHLoad *ridSA /1000 *quarterFac);
            double _TempHLMonth = (riderTempHLoad *ridSA /1000 *monthFac);
            NSString *str_TempHLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLAnn]];
            NSString *str_TempHLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLHalf]];
            NSString *str_TempHLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLQuar]];
            NSString *str_TempHLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLMonth]];
            str_TempHLAnn = [str_TempHLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLHalf = [str_TempHLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLQuar = [str_TempHLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLMonth = [str_TempHLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _allRiderHLAnn = [str_HLAnn doubleValue] + [str_TempHLAnn doubleValue];
            double _allRiderHLHalf = [str_HLHalf doubleValue] + [str_TempHLHalf doubleValue];
            double _allRiderHLQuar = [str_HLQuar doubleValue] + [str_TempHLQuar doubleValue];
            double _allRiderHLMonth = [str_HLMonth doubleValue] + [str_TempHLMonth doubleValue];
            //--end
            
            annualRider = [str_ann doubleValue] + ([strLoadA doubleValue]) + _allRiderHLAnn;
            halfYearRider = [str_half doubleValue] + ([strLoadH doubleValue]) + _allRiderHLHalf;
            quarterRider = [str_quar doubleValue] + ([strLoadQ doubleValue]) + _allRiderHLQuar;
            monthlyRider = [str_month doubleValue] + ([strLoadM doubleValue]) + _allRiderHLMonth;
        }
        else {
            double _ann = (riderRate *ridSA /1000 *annFac);
            double _half = (riderRate *ridSA /1000 *halfFac);
            double _quar = (riderRate *ridSA /1000 *quarterFac);
            double _month = (riderRate *ridSA /1000 *monthFac);
            NSString *str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:_ann]];
            NSString *str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:_half]];
            NSString *str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:_quar]];
            NSString *str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:_month]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            //--HL
            double _HLAnn = (riderHLoad *ridSA /1000 *annFac);
            double _HLHalf = (riderHLoad *ridSA /1000 *halfFac);
            double _HLQuar = (riderHLoad *ridSA /1000 *quarterFac);
            double _HLMonth = (riderHLoad *ridSA /1000 *monthFac);
            NSString *str_HLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLAnn]];
            NSString *str_HLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLHalf]];
            NSString *str_HLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLQuar]];
            NSString *str_HLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_HLMonth]];
            str_HLAnn = [str_HLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLHalf = [str_HLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLQuar = [str_HLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_HLMonth = [str_HLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _TempHLAnn = (riderTempHLoad *ridSA /1000 *annFac);
            double _TempHLHalf = (riderTempHLoad *ridSA /1000 *halfFac);
            double _TempHLQuar = (riderTempHLoad *ridSA /1000 *quarterFac);
            double _TempHLMonth = (riderTempHLoad *ridSA /1000 *monthFac);
            NSString *str_TempHLAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLAnn]];
            NSString *str_TempHLHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLHalf]];
            NSString *str_TempHLQuar = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLQuar]];
            NSString *str_TempHLMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:_TempHLMonth]];
            str_TempHLAnn = [str_TempHLAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLHalf = [str_TempHLHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLQuar = [str_TempHLQuar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_TempHLMonth = [str_TempHLMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            double _allRiderHLAnn = [str_HLAnn doubleValue] + [str_TempHLAnn doubleValue];
            double _allRiderHLHalf = [str_HLHalf doubleValue] + [str_TempHLHalf doubleValue];
            double _allRiderHLQuar = [str_HLQuar doubleValue] + [str_TempHLQuar doubleValue];
            double _allRiderHLMonth = [str_HLMonth doubleValue] + [str_TempHLMonth doubleValue];
            //--end
            
            double calLoadA = occLoadRider *ridSA /1000 *annFac;
            double calLoadH = occLoadRider *ridSA /1000 *halfFac;
            double calLoadQ = occLoadRider *ridSA /1000 *quarterFac;
            double calLoadM = occLoadRider *ridSA /1000 *monthFac;
            NSString *strLoadA = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadA]];
            NSString *strLoadH = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadH]];
            NSString *strLoadQ = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadQ]];
            NSString *strLoadM = [formatter stringFromNumber:[NSNumber numberWithDouble:calLoadM]];
            strLoadA = [strLoadA stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadH = [strLoadH stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadQ = [strLoadQ stringByReplacingOccurrencesOfString:@"," withString:@""];
            strLoadM = [strLoadM stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            annualRider = [str_ann doubleValue] + ([strLoadA doubleValue]) + _allRiderHLAnn;
            halfYearRider = [str_half doubleValue] + ([strLoadH doubleValue]) + _allRiderHLHalf;
            quarterRider = [str_quar doubleValue] + ([strLoadQ doubleValue]) + _allRiderHLQuar;
            monthlyRider = [str_month doubleValue] + ([strLoadM doubleValue]) + _allRiderHLMonth;
            
            if ([RidCode isEqualToString:@"HSP_II"]) {
                // For report part ---------- added by heng
                if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
                    for (int a = 0; a<ReportHMMRates.count; a++) {
                        
                        double annualRates = ([[ReportHMMRates objectAtIndex:a] doubleValue ] *ridSA /1000 *annFac) + (OccpLoadRidA *ridSA /1000 *annFac) + (riderHLoad *ridSA /1000 *annFac);
                        
                        NSString *querySQL = [NSString stringWithFormat: @"INSERT INTO SI_Store_premium (\"Type\",\"Annually\",\"FromAge\", \"ToAge\", 'SINO') "
                                              " VALUES(\"%@\", \"%.9f\", \"%@\", \"%@\", '%@')",
                                              RidCode, annualRates, [ReportFromAge objectAtIndex:a], [ReportToAge objectAtIndex:a], SINo];
                        
                        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
                        {
                            if (sqlite3_step(statement) == SQLITE_DONE)
                            {
                                
                            }
                            sqlite3_finalize(statement);
                        }
                        
                    }
                    sqlite3_close(contactDB);
                }
                
                // report part end -----------
            }
        }
        
        NSString *calRiderAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:annualRider]];
        NSString *calRiderHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:halfYearRider]];
        NSString *calRiderQuarter = [formatter stringFromNumber:[NSNumber numberWithDouble:quarterRider]];
        NSString *calRiderMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:monthlyRider]];
        calRiderAnn = [calRiderAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
        calRiderHalf = [calRiderHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
        calRiderQuarter = [calRiderQuarter stringByReplacingOccurrencesOfString:@"," withString:@""];
        calRiderMonth = [calRiderMonth stringByReplacingOccurrencesOfString:@"," withString:@""];
        [annualRiderTot addObject:calRiderAnn];
        [halfRiderTot addObject:calRiderHalf];
        [quarterRiderTot addObject:calRiderQuarter];
        [monthRiderTot addObject:calRiderMonth];
        [annRiderTitle addObject:RidCode];
        [annRiderTerm addObject:[riderTerm objectAtIndex:i]];
        [annRiderCode addObject:RidCode];
        NSLog(@"RiderTotal(%@) A:%@, S:%@, Q:%@, M:%@",[riderCode objectAtIndex:i],calRiderAnn,calRiderHalf,calRiderQuarter,calRiderMonth);
        
        //for waiver CIWP
        if (!([RidCode isEqualToString:@"LCPR"]) && !([RidCode isEqualToString:@"CIR"]) && !([RidCode isEqualToString:@"PR"]) && !([RidCode isEqualToString:@"LCWP"]) && !([RidCode isEqualToString:@"SP_STD"]) && !([RidCode isEqualToString:@"SP_PRE"]) && !([RidCode isEqualToString:@"CIWP"]) && !([RidCode isEqualToString:@"ICR"])) {
            NSLog(@"waiver1 insert :%@",[riderCode objectAtIndex:i]);
            
            [waiverRiderAnn addObject:calRiderAnn];
            [waiverRiderHalf addObject:calRiderHalf];
            [waiverRiderQuar addObject:calRiderQuarter];
            [waiverRiderMonth addObject:calRiderMonth];
        }
        
        //for other waiver
        if (!([RidCode isEqualToString:@"PLCP"]) && !([RidCode isEqualToString:@"CIWP"]) && !([RidCode isEqualToString:@"LCWP"]) && !([RidCode isEqualToString:@"SP_STD"]) && !([RidCode isEqualToString:@"SP_PRE"]) && !([RidCode isEqualToString:@"PR"]) && !([RidCode isEqualToString:@"PTR"])) {
            NSLog(@"waiver2 insert :%@",[riderCode objectAtIndex:i]);
            
            [waiverRiderAnn2 addObject:calRiderAnn];
            [waiverRiderHalf2 addObject:calRiderHalf];
            [waiverRiderQuar2 addObject:calRiderQuarter];
            [waiverRiderMonth2 addObject:calRiderMonth];
        }
    }
    
    annualRiderSum = 0;
    halfRiderSum = 0;
    quarterRiderSum = 0;
    monthRiderSum = 0;
    NSUInteger a;
    for (a=0; a<[annualRiderTot count]; a++) {
        int ridTerm = [[annRiderTerm objectAtIndex:a] intValue];
        NSString *title = [[NSString alloc ]initWithFormat:@"%@ - (%d years)",[annRiderTitle objectAtIndex:a],ridTerm];
        NSString *annual = [formatter stringFromNumber:[NSNumber numberWithDouble:[[annualRiderTot objectAtIndex:a] doubleValue]]];
        NSString *half = [formatter stringFromNumber:[NSNumber numberWithDouble:[[halfRiderTot objectAtIndex:a] doubleValue]]];
        NSString *quarter = [formatter stringFromNumber:[NSNumber numberWithDouble:[[quarterRiderTot objectAtIndex:a] doubleValue]]];
        NSString *month = [formatter stringFromNumber:[NSNumber numberWithDouble:[[monthRiderTot objectAtIndex:a] doubleValue]]];
        
        //-------------- heng's part for SI Report
        NSString *QuerySQL =  [ NSString stringWithFormat: @"INSERT INTO SI_Store_Premium (\"Type\",\"Annually\",\"SemiAnnually\", "
                               " \"Quarterly\",\"Monthly\",'SINO') VALUES "
                               " (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", '%@') ",[annRiderCode objectAtIndex:a], annual, half, quarter, month, SINo ];
        
        sqlite3_stmt *statement;
        
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
        {
            if (sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_DONE) {
                    
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
        //---------------
        if (htmlRider.length == 0) {
            htmlRider = [[NSString alloc]initWithFormat:
                         @"<tr>"
                         "<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>"
                         "</tr>"
                         "<tr>"
                         "<td style='height:35px;padding: 5px 5px 5px 5px;'><font face='TreBuchet MS' size='3'>%@</font></td>"
                         "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                         "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                         "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                         "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                         "</tr>",title,annual,half,quarter,month];
        } else {
            
            htmlRider = [htmlRider stringByAppendingFormat:
                         @"<tr>"
                         "<td style='height:35px;padding: 5px 5px 5px 5px;'><font face='TreBuchet MS' size='3'>%@</font></td>"
                         "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                         "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                         "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                         "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                         "</tr>",title,annual,half,quarter,month];
        }
        annualRiderSum = annualRiderSum + [[annualRiderTot objectAtIndex:a] doubleValue];
        halfRiderSum = halfRiderSum + [[halfRiderTot objectAtIndex:a] doubleValue];
        quarterRiderSum = quarterRiderSum + [[quarterRiderTot objectAtIndex:a] doubleValue];
        monthRiderSum = monthRiderSum + [[monthRiderTot objectAtIndex:a] doubleValue];
    }
}

-(void)calculateWaiver
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:@""];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    
    double waiverAnnSum = 0;
    double waiverHalfSum = 0;
    double waiverQuarSum = 0;
    double waiverMonthSum = 0;
    for (NSUInteger m=0; m<[waiverRiderAnn count]; m++) {
        waiverAnnSum = waiverAnnSum + [[waiverRiderAnn objectAtIndex:m] doubleValue];
        waiverHalfSum = waiverHalfSum + [[waiverRiderHalf objectAtIndex:m] doubleValue];
        waiverQuarSum = waiverQuarSum + [[waiverRiderQuar objectAtIndex:m] doubleValue];
        waiverMonthSum = waiverMonthSum + [[waiverRiderMonth objectAtIndex:m] doubleValue];
    }
    NSLog(@"AccRiderPrem1 A:%.2f, S:%.2f, Q:%.2f, M:%.2f",waiverAnnSum,waiverHalfSum,waiverQuarSum,waiverMonthSum);
    
    double waiverAnnSum2 = 0;
    double waiverHalfSum2 = 0;
    double waiverQuarSum2 = 0;
    double waiverMonthSum2 = 0;
    for (NSUInteger m=0; m<[waiverRiderAnn2 count]; m++) {
        waiverAnnSum2 = waiverAnnSum2 + [[waiverRiderAnn2 objectAtIndex:m] doubleValue];
        waiverHalfSum2 = waiverHalfSum2 + [[waiverRiderHalf2 objectAtIndex:m] doubleValue];
        waiverQuarSum2 = waiverQuarSum2 + [[waiverRiderQuar2 objectAtIndex:m] doubleValue];
        waiverMonthSum2 = waiverMonthSum2 + [[waiverRiderMonth2 objectAtIndex:m] doubleValue];
    }
    NSLog(@"AccRiderPrem2 A:%.2f, S:%.2f, Q:%.2f, M:%.2f",waiverAnnSum2,waiverHalfSum2,waiverQuarSum2,waiverMonthSum2);
    
    NSMutableArray *waiverTitle = [[NSMutableArray alloc] init];
    NSMutableArray *waiverCode = [[NSMutableArray alloc] init];
    NSMutableArray *waiverTerm = [[NSMutableArray alloc] init];
    NSMutableArray *waiverRidAnnTol = [[NSMutableArray alloc] init];
    NSMutableArray *waiverRidHalfTol = [[NSMutableArray alloc] init];
    NSMutableArray *waiverRidQuarTol = [[NSMutableArray alloc] init];
    NSMutableArray *waiverRidMonthTol = [[NSMutableArray alloc] init];
    NSMutableArray *waiverRidAnnSA = [[NSMutableArray alloc] init];
    NSMutableArray *waiverRidHalfSA = [[NSMutableArray alloc] init];
    NSMutableArray *waiverRidQuarSA = [[NSMutableArray alloc] init];
    NSMutableArray *waiverRidMonthSA = [[NSMutableArray alloc] init];
	
    NSUInteger i;
    for (i=0; i<[riderCode count]; i++) {
        //getpentacode
        const char *dbpath = [databasePath UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            if ([[riderCode objectAtIndex:i] isEqualToString:@"CIWP"]||[[riderCode objectAtIndex:i] isEqualToString:@"LCWP"]||[[riderCode objectAtIndex:i] isEqualToString:@"PR"]||[[riderCode objectAtIndex:i] isEqualToString:@"SP_STD"]||[[riderCode objectAtIndex:i] isEqualToString:@"SP_PRE"]) {
                pentaSQL = [[NSString alloc] initWithFormat:@"SELECT PentaPlanCode FROM Trad_Sys_Product_Mapping WHERE PlanType=\"R\" AND SIPlanCode=\"%@\" AND Channel=\"AGT\"",[riderCode objectAtIndex:i]];
            }
            else {
                sqlite3_close(contactDB);
                continue;
            }
            
            const char *query_stmt = [pentaSQL UTF8String];
            if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_ROW) {
                    planCodeRider =  [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                }
                else {
                    NSLog(@"error access PentaPlanCode");
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
        
        int ridTerm = [[riderTerm objectAtIndex:i] intValue];
        age = [[riderAge objectAtIndex:i] intValue];
        sex = [[NSString alloc] initWithFormat:@"%@",[riderSex objectAtIndex:i]];
        
        //get rate
        [self getRiderRateAgeSex:planCodeRider riderTerm:ridTerm];
        
        double ridSA = [[riderSA objectAtIndex:i] doubleValue];
        double riderHLoad = 0;
        double riderTempHLoad = 0;
        
        if ([[riderHL1K objectAtIndex:i] doubleValue] > 0) {
           riderHLoad = [[riderHL1K objectAtIndex:i] doubleValue];
        }
        else if ([[riderHL100 objectAtIndex:i] doubleValue] > 0) {
            riderHLoad = [[riderHL100 objectAtIndex:i] doubleValue];
        }
        else if ([[riderHLP objectAtIndex:i] doubleValue] > 0) {
            riderHLoad = [[riderHLP objectAtIndex:i] doubleValue];
        }
        
        if ([[riderTempHL1K objectAtIndex:i] doubleValue] > 0) {
            riderTempHLoad = [[riderTempHL1K objectAtIndex:i] doubleValue];
        }
        NSLog(@"riderRate(%@):%.2f, ridersum:%.3f, HL:%.3f, TempHL:%.3f",[riderCode objectAtIndex:i],riderRate,ridSA,riderHLoad,riderTempHLoad);
        
        double annFac = 1;
        double halfFac = 0.5125;
        double quarterFac = 0.2625;
        double monthFac = 0.0875;
        
        //calculate occupationLoading
        strOccp = [riderOccp objectAtIndex:i];
        [self getOccLoadRider];
        NSLog(@"occpLoadRate:%d",occLoadRider);
        
        double annualRider_ = 0;
        double halfYearRider_ = 0;
        double quarterRider_ = 0;
        double monthlyRider_ = 0;
		
		NSString *str_ann;
		NSString *str_half;
		NSString *str_quar;
		NSString *str_month;
		double waiverAnnPremSA = 0.00;
		double waiverHalfPremSA = 0.00;
		double waiverQuarPremSA = 0.00;
		double waiverMonthPremSA = 0.00;
        if ([[riderCode objectAtIndex:i] isEqualToString:@"CIWP"])
        {
            double waiverAnnPrem = ridSA/100 * (waiverAnnSum+basicPremAnn);
            double waiverHalfPrem = ridSA/100 * (waiverHalfSum+basicPremHalf) *2;
            double waiverQuarPrem = ridSA/100 * (waiverQuarSum+basicPremQuar) *4;
            double waiverMonthPrem = ridSA/100 * (waiverMonthSum+basicPremMonth) *12;
			waiverAnnPremSA = ridSA/100 * (waiverAnnSum+basicPremAnn);
			waiverHalfPremSA = ridSA/100 * (waiverHalfSum+basicPremHalf) ;
			waiverQuarPremSA = ridSA/100 * (waiverQuarSum+basicPremQuar) ;
			waiverMonthPremSA = ridSA/100 * (waiverMonthSum+basicPremMonth);
			str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:waiverAnnPrem]];
			str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:waiverHalfPrem]];
			str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:waiverQuarPrem]];
			str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:waiverMonthPrem]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
            NSLog(@"waiverSA A:%@, S:%@, Q:%@, M:%@",str_ann,str_half,str_quar,str_month);
            
            annualRider_ = [str_ann doubleValue] * (riderRate/100 + (double)ridTerm/1000 *0 + (riderHLoad+riderTempHLoad)/100);
            halfYearRider_ = [str_half doubleValue] * (riderRate/100 + (double)ridTerm/1000 *0 + (riderHLoad+riderTempHLoad)/100);
            quarterRider_ = [str_quar doubleValue] * (riderRate/100 + (double)ridTerm/1000 *0 + (riderHLoad+riderTempHLoad)/100);
            monthlyRider_ = [str_month doubleValue] * (riderRate/100 + (double)ridTerm/1000 *0 + (riderHLoad+riderTempHLoad)/100);
            NSLog(@"waiverPrem A:%.2f S:%.2f, Q:%.2f, M:%.2f",annualRider_,halfYearRider_,quarterRider_,monthlyRider_);
            
            annualRider = annualRider_ * annFac;
            halfYearRider = halfYearRider_ * halfFac;
            quarterRider = quarterRider_ * quarterFac;
            monthlyRider = monthlyRider_ * monthFac;
        }
        else if ([[riderCode objectAtIndex:i] isEqualToString:@"LCWP"]||[[riderCode objectAtIndex:i] isEqualToString:@"PR"]||[[riderCode objectAtIndex:i] isEqualToString:@"SP_STD"]||[[riderCode objectAtIndex:i] isEqualToString:@"SP_PRE"])
        {
            double waiverAnnPrem = ridSA/100 * (waiverAnnSum2+basicPremAnn);
            double waiverHalfPrem = ridSA/100 * (waiverHalfSum2+basicPremHalf) *2;
            double waiverQuarPrem = ridSA/100 * (waiverQuarSum2+basicPremQuar) *4;
            double waiverMonthPrem = ridSA/100 * (waiverMonthSum2+basicPremMonth) *12;
			waiverAnnPremSA = ridSA/100 * (waiverAnnSum2+basicPremAnn);
			waiverHalfPremSA = ridSA/100 * (waiverHalfSum2+basicPremHalf);
			waiverQuarPremSA = ridSA/100 * (waiverQuarSum2+basicPremQuar);
			waiverMonthPremSA = ridSA/100 * (waiverMonthSum2+basicPremMonth);
			str_ann = [formatter stringFromNumber:[NSNumber numberWithDouble:waiverAnnPrem]];
			str_half = [formatter stringFromNumber:[NSNumber numberWithDouble:waiverHalfPrem]];
			str_quar = [formatter stringFromNumber:[NSNumber numberWithDouble:waiverQuarPrem]];
			str_month = [formatter stringFromNumber:[NSNumber numberWithDouble:waiverMonthPrem]];
            str_ann = [str_ann stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_half = [str_half stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_quar = [str_quar stringByReplacingOccurrencesOfString:@"," withString:@""];
            str_month = [str_month stringByReplacingOccurrencesOfString:@"," withString:@""];
            NSLog(@"waiverSA A:%@, S:%@, Q:%@, M:%@",str_ann,str_half,str_quar,str_month);
            
            annualRider_ = [str_ann doubleValue] * (riderRate/100 + (double)ridTerm/1000 *occLoadRider + (riderHLoad+riderTempHLoad)/100);
            halfYearRider_ = [str_half doubleValue] * (riderRate/100 + (double)ridTerm/1000 *occLoadRider + (riderHLoad+riderTempHLoad)/100);
            quarterRider_ = [str_quar doubleValue] * (riderRate/100 + (double)ridTerm/1000 *occLoadRider + (riderHLoad+riderTempHLoad)/100);
            monthlyRider_ = [str_month doubleValue] * (riderRate/100 + (double)ridTerm/1000 *occLoadRider + (riderHLoad+riderTempHLoad)/100);
            NSLog(@"waiverPrem A:%.2f S:%.2f, Q:%.2f, M:%.2f",annualRider_,halfYearRider_,quarterRider_,monthlyRider_);
            
            annualRider = annualRider_ * annFac;
            halfYearRider = halfYearRider_ * halfFac;
            quarterRider = quarterRider_ * quarterFac;
            monthlyRider = monthlyRider_ * monthFac;
        }
        
        NSString *calRiderAnn = [formatter stringFromNumber:[NSNumber numberWithDouble:annualRider]];
        NSString *calRiderHalf = [formatter stringFromNumber:[NSNumber numberWithDouble:halfYearRider]];
        NSString *calRiderQuarter = [formatter stringFromNumber:[NSNumber numberWithDouble:quarterRider]];
        NSString *calRiderMonth = [formatter stringFromNumber:[NSNumber numberWithDouble:monthlyRider]];
        calRiderAnn = [calRiderAnn stringByReplacingOccurrencesOfString:@"," withString:@""];
        calRiderHalf = [calRiderHalf stringByReplacingOccurrencesOfString:@"," withString:@""];
        calRiderQuarter = [calRiderQuarter stringByReplacingOccurrencesOfString:@"," withString:@""];
        calRiderMonth = [calRiderMonth stringByReplacingOccurrencesOfString:@"," withString:@""];

		
//        [waiverTitle addObject:[riderDesc objectAtIndex:i]];
        [waiverTitle addObject:[riderCode objectAtIndex:i]];
        [waiverTerm addObject:[riderTerm objectAtIndex:i]];
        [waiverCode addObject:[riderCode objectAtIndex:i]];
        [waiverRidAnnTol addObject:calRiderAnn];
        [waiverRidHalfTol addObject:calRiderHalf];
        [waiverRidQuarTol addObject:calRiderQuarter];
        [waiverRidMonthTol addObject:calRiderMonth];
		
		NSString *calRiderAnnSA = [formatter stringFromNumber:[NSNumber numberWithDouble:waiverAnnPremSA]];
        NSString *calRiderHalfSA = [formatter stringFromNumber:[NSNumber numberWithDouble:waiverHalfPremSA]];
        NSString *calRiderQuarterSA = [formatter stringFromNumber:[NSNumber numberWithDouble:waiverQuarPremSA]];
        NSString *calRiderMonthSA = [formatter stringFromNumber:[NSNumber numberWithDouble:waiverMonthPremSA]];
        calRiderAnnSA = [calRiderAnnSA stringByReplacingOccurrencesOfString:@"," withString:@""];
        calRiderHalfSA = [calRiderHalfSA stringByReplacingOccurrencesOfString:@"," withString:@""];
        calRiderQuarterSA = [calRiderQuarterSA stringByReplacingOccurrencesOfString:@"," withString:@""];
        calRiderMonthSA = [calRiderMonthSA stringByReplacingOccurrencesOfString:@"," withString:@""];
		
		[waiverRidAnnSA addObject:calRiderAnnSA];
        [waiverRidHalfSA addObject:calRiderHalfSA];
        [waiverRidQuarSA addObject:calRiderQuarterSA];
        [waiverRidMonthSA addObject:calRiderMonthSA];
		
        NSLog(@"waiverTotal(%@) A:%@, S:%@, Q:%@, M:%@",[riderCode objectAtIndex:i],calRiderAnn,calRiderHalf,calRiderQuarter,calRiderMonth);
    }

    NSUInteger a;
    for (a=0; a<[waiverRidAnnTol count]; a++) {
        int ridTerm = [[waiverTerm objectAtIndex:a] intValue];
        NSString *title = [[NSString alloc ]initWithFormat:@"%@ - (%d years)",[waiverTitle objectAtIndex:a],ridTerm];
        NSString *annual = [formatter stringFromNumber:[NSNumber numberWithDouble:[[waiverRidAnnTol objectAtIndex:a] doubleValue]]];
        NSString *half = [formatter stringFromNumber:[NSNumber numberWithDouble:[[waiverRidHalfTol objectAtIndex:a] doubleValue]]];
        NSString *quarter = [formatter stringFromNumber:[NSNumber numberWithDouble:[[waiverRidQuarTol objectAtIndex:a] doubleValue]]];
        NSString *month = [formatter stringFromNumber:[NSNumber numberWithDouble:[[waiverRidMonthTol objectAtIndex:a] doubleValue]]];
        
        //-------------- heng's part for SI Report
        
        NSString *QuerySQL =  [ NSString stringWithFormat: @"INSERT INTO SI_Store_Premium (\"Type\",\"Annually\",\"SemiAnnually\", "
                               " \"Quarterly\",\"Monthly\", 'SINO', 'WaiverSAAnnual','WaiverSASemi', 'WaiverSAQuarter', 'WaiverSAMonth') VALUES "
                               " (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\",'%@','%@','%@','%@','%@') ",
							   [waiverCode objectAtIndex:a], annual, half, quarter, month, SINo,
							   [waiverRidAnnSA objectAtIndex:a], [waiverRidHalfSA objectAtIndex:a],
							   [waiverRidQuarSA objectAtIndex:a], [waiverRidMonthSA objectAtIndex:a]];
        
        sqlite3_stmt *statement;
        
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
        {
            if (sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_DONE) {
                    
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
         
        //---------------
        
        if (htmlRider.length == 0) {
            htmlRider = [[NSString alloc]initWithFormat:
                         @"<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>"
                         "<tr><td style='height:35px;'><font face='TreBuchet MS' size='3'>%@</font></td>"
                            "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                            "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                            "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                            "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                         "</tr>",title,annual,half,quarter,month];
        } else {
            
            htmlRider = [htmlRider stringByAppendingFormat:
                         @"<tr><td style='height:35px;'><font face='TreBuchet MS' size='3'>%@</font></td>"
                            "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                            "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                            "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                            "<td align='right'><font face='TreBuchet MS' size='3'>%@</font></td>"
                         "</tr>",title,annual,half,quarter,month];
        }
        
        annualRiderSum = annualRiderSum + [[waiverRidAnnTol objectAtIndex:a] doubleValue];
        halfRiderSum = halfRiderSum + [[waiverRidHalfTol objectAtIndex:a] doubleValue];
        quarterRiderSum = quarterRiderSum + [[waiverRidQuarTol objectAtIndex:a] doubleValue];
        monthRiderSum = monthRiderSum + [[waiverRidMonthTol objectAtIndex:a] doubleValue];
        
        NSLog(@"allRiderSum A:%.2f S:%.2f, Q:%.2f, M:%.2f",annualRiderSum,halfRiderSum,quarterRiderSum,monthRiderSum);
    }
}


#pragma mark - handle db

-(void)getBasicPentaRate
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Basic_Prem WHERE PlanCode=\"%@\" AND FromTerm=\"%d\" AND FromMortality=0",getPlanCode,getTerm];
        
//        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                basicRate =  sqlite3_column_int(statement, 0);
            } else {
                NSLog(@"error access getBasicPentaRate");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getLSDRate
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Basic_LSD WHERE PlanCode=\"%@\" AND FromSA <=\"%@\" AND ToSA >= \"%@\"",getPlanCode,getBasicSA,getBasicSA];
//        NSLog(@"%@",querySQL);
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                LSDRate =  sqlite3_column_int(statement, 0);
                
            } else {
                NSLog(@"error access getLSDRate");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getOccLoad
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT OccLoading_TL FROM Adm_Occp_Loading_Penta WHERE OccpCode=\"%@\"",getOccpCode];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                occLoad =  sqlite3_column_int(statement, 0);
                
            } else {
                NSLog(@"error access getOccLoad");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
}

-(void)checkExistRider
{
    riderCode = [[NSMutableArray alloc] init];
    riderDesc = [[NSMutableArray alloc] init];
    riderTerm = [[NSMutableArray alloc] init];
    riderSA = [[NSMutableArray alloc] init];
    riderPlanOpt = [[NSMutableArray alloc] init];
    riderUnit = [[NSMutableArray alloc] init];
    riderDeduct = [[NSMutableArray alloc] init];
    riderHL1K = [[NSMutableArray alloc] init];
    riderHL100 = [[NSMutableArray alloc] init];
    riderHLP = [[NSMutableArray alloc] init];
    riderCustCode = [[NSMutableArray alloc] init];
    riderSmoker = [[NSMutableArray alloc] init];
    riderSex = [[NSMutableArray alloc] init];
    riderAge = [[NSMutableArray alloc] init];
    riderOccp = [[NSMutableArray alloc] init];
    riderTempHL1K = [[NSMutableArray alloc] init];
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
            @"SELECT a.RiderCode, b.RiderDesc, a.RiderTerm, a.SumAssured, a.PlanOption, a.Units, a.Deductible, a.HL1KSA, a.HL100SA, a.HLPercentage, c.CustCode, d.Smoker, d.Sex, d.ALB, d.OccpCode, a.TempHL1kSA from Trad_Rider_Details a, Trad_Sys_Rider_Profile b, Trad_LAPayor c, Clt_Profile d WHERE a.RiderCode=b.RiderCode AND a.PTypeCode=c.PTypeCode AND a.Seq=c.Sequence AND d.CustCode=c.CustCode AND a.SINo=c.SINo AND a.SINo=\"%@\" ORDER by a.RiderCode asc", SINo];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                [riderCode addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)]];
                [riderDesc addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)]];
                
                const char *RTerm = (const char *) sqlite3_column_text(statement, 2);
                [riderTerm addObject:RTerm == NULL ? nil :[[NSString alloc] initWithUTF8String:(const char *)RTerm]];
                 
                const char *RsumA = (const char *) sqlite3_column_text(statement, 3);
                [riderSA addObject:RsumA == NULL ? nil :[[NSString alloc] initWithUTF8String:RsumA]];
                
                const char *plan = (const char *) sqlite3_column_text(statement, 4);
                [riderPlanOpt addObject:plan == NULL ? nil :[[NSString alloc] initWithUTF8String:plan]];

                const char *uni = (const char *) sqlite3_column_text(statement, 5);
                [riderUnit addObject:uni == NULL ? nil :[[NSString alloc] initWithUTF8String:uni]];

                const char *deduct2 = (const char *) sqlite3_column_text(statement, 6);
                [riderDeduct addObject:deduct2 == NULL ? nil :[[NSString alloc] initWithUTF8String:deduct2]];
                
                double ridHL = sqlite3_column_double(statement, 7);
                [riderHL1K addObject:[[NSString alloc] initWithFormat:@"%.2f",ridHL]];
                
                double ridHL100 = sqlite3_column_double(statement, 8);
                [riderHL100 addObject:[[NSString alloc] initWithFormat:@"%.2f",ridHL100]];
                
                double ridHLP = sqlite3_column_double(statement, 9);
                [riderHLP addObject:[[NSString alloc] initWithFormat:@"%.2f",ridHLP]];
                
                [riderCustCode addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 10)]];
                [riderSmoker addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 11)]];
                [riderSex addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 12)]];
                [riderAge addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 13)]];
                [riderOccp addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 14)]];
                
                double tempRidHL = sqlite3_column_double(statement, 15);
                [riderTempHL1K addObject:[[NSString alloc] initWithFormat:@"%.2f",tempRidHL]];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

//---

-(void)getRiderRateSex:(NSString *)aaplan riderTerm:(int)aaterm
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Rider_Prem WHERE RiderCode=\"%@\" AND FromTerm <=\"%d\" AND ToTerm >= \"%d\" AND FromMortality=0 AND Sex=\"%@\"",aaplan,aaterm,aaterm,sex];
        
//        NSLog(@"%@",querySQL);
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"error access Trad_Sys_Rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getRiderRateSex:(NSString *)aaplan
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Rider_Prem WHERE RiderCode=\"%@\" AND FromMortality=0 AND Sex=\"%@\" AND FromAge<=\"%d\" AND ToAge >=\"%d\"",aaplan,sex,age,age];
        
        NSLog(@"%@",querySQL);
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"error access Trad_Sys_Rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getRiderRateAge:(NSString *)aaplan riderTerm:(int)aaterm
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        //----------------- edited by heng on 25th oct 2012 because IE20R and IE30R dont have term
        NSString *querySQL;
        if (aaterm == 0) {
            querySQL = [NSString stringWithFormat:
                        @"SELECT Rate FROM Trad_Sys_Rider_Prem WHERE RiderCode=\"%@\" AND FromMortality=0 AND FromAge<=\"%d\" AND ToAge >=\"%d\"",aaplan,age,age];
            
        }
        else {
            querySQL = [NSString stringWithFormat:
                        @"SELECT Rate FROM Trad_Sys_Rider_Prem WHERE RiderCode=\"%@\" AND FromTerm <=\"%d\" AND ToTerm >= \"%d\" AND FromMortality=0 AND FromAge<=\"%d\" AND ToAge >=\"%d\"",aaplan,aaterm,aaterm,age,age];
            
        }
        //-------------------
        
//        NSLog(@"%@",querySQL);
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"error access Trad_Sys_Rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getRiderRateAgeSex:(NSString *)aaplan riderTerm:(int)aaterm
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Rider_Prem WHERE RiderCode=\"%@\" AND FromTerm <=\"%d\" AND ToTerm >= \"%d\" AND FromMortality=0 AND FromAge<=\"%d\" AND ToAge >=\"%d\" AND Sex=\"%@\"",aaplan,aaterm,aaterm,age,age,sex];
        
//        NSLog(@"%@",querySQL);
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"error access Trad_Sys_Rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)getRiderRateAgeSexClass:(NSString *)aaplan riderTerm:(int)aaterm code:(NSString *)strRiderCode
{
    const char *dbpath = [RatesDatabasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Rider_Prem WHERE RiderCode=\"%@\" AND FromTerm <=\"%d\" AND ToTerm >= \"%d\" AND "
                              " FromMortality=0 AND FromAge<=\"%d\" AND ToAge >=\"%d\" AND Sex=\"%@\" AND occpClass = \"%d\"",
                              aaplan,aaterm,aaterm,age,age,sex,getOccpClass];
        
//        NSLog(@"%@",querySQL);
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"error access Trad_Sys_Rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        
        //----------- for report part  ----------- added by heng
        if ([strRiderCode isEqualToString:@"HMM"] || [strRiderCode isEqualToString:@"MG_II"] || [strRiderCode isEqualToString:@"MG_IV"] ) {
            ReportHMMRates = [[NSMutableArray alloc] init ];
            ReportFromAge = [[NSMutableArray alloc] init ];
            ReportToAge = [[NSMutableArray alloc] init ];
            querySQL = [NSString stringWithFormat:
                        @"SELECT Rate, \"FromAge\", \"ToAge\" FROM Trad_Sys_Rider_Prem WHERE RiderCode=\"%@\" AND FromTerm <=\"%d\" AND ToTerm >= \"%d\" AND "
                        " FromMortality=0 AND Sex=\"%@\" AND occpClass = \"%d\" ORDER BY fromage",
                        aaplan,aaterm,aaterm,sex, getOccpClass];
            
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    [ReportHMMRates addObject:[NSString stringWithFormat:@"%.3f", sqlite3_column_double(statement, 0)]];
                    [ReportFromAge addObject:[NSString stringWithFormat:@"%d", sqlite3_column_int(statement, 1)]];
                    [ReportToAge addObject:[NSString stringWithFormat:@"%d", sqlite3_column_int(statement, 2)]];
                }
                sqlite3_finalize(statement);
            }
        }
        //----------- report part end -------------------------
        
        sqlite3_close(contactDB);
    }
}

-(void)getRiderRateAgeClass:(NSString *)aaplan riderTerm:(int)aaterm code:(NSString *)strRiderCode
{
    const char *dbpath = [RatesDatabasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Rider_Prem WHERE RiderCode=\"%@\" AND FromTerm <=\"%d\" AND ToTerm >= \"%d\" AND "
                              " FromMortality=0 AND FromAge<=\"%d\" AND ToAge >=\"%d\" AND occpClass = \"%d\"",
                              aaplan,aaterm,aaterm,age,age, getOccpClass];
        
//        NSLog(@"%@",querySQL);
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"error access Trad_Sys_Rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        
        //----------- for report part  ----------- added by heng
        if ([strRiderCode isEqualToString:@"HSP_II"]) {
            ReportHMMRates = [[NSMutableArray alloc] init ];
            ReportFromAge = [[NSMutableArray alloc] init ];
            ReportToAge = [[NSMutableArray alloc] init ];
            querySQL = [NSString stringWithFormat:
                        @"SELECT Rate, \"FromAge\", \"ToAge\" FROM Trad_Sys_Rider_Prem WHERE RiderCode=\"%@\" AND FromTerm <=\"%d\" AND ToTerm >= \"%d\" AND "
                        " FromMortality=0 AND Sex=\"%@\" AND occpClass = \"%d\" ORDER BY fromage",
                        aaplan,aaterm,aaterm,sex, getOccpClass];
            
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    [ReportHMMRates addObject:[NSString stringWithFormat:@"%.3f", sqlite3_column_double(statement, 0)]];
                    [ReportFromAge addObject:[NSString stringWithFormat:@"%d", sqlite3_column_int(statement, 1)]];
                    [ReportToAge addObject:[NSString stringWithFormat:@"%d", sqlite3_column_int(statement, 2)]];
                }
                sqlite3_finalize(statement);
            }
        }
        //----------- report part end -------------------------
        
        sqlite3_close(contactDB);
    }
}

-(void)getRiderRateClass:(NSString *)aaplan riderTerm:(int)aaterm
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT Rate FROM Trad_Sys_Rider_Prem WHERE RiderCode=\"%@\" AND FromTerm <=\"%d\" AND ToTerm >= \"%d\" AND "
                              " FromMortality=0 AND occpClass = \"%d\"",
                              aaplan,aaterm,aaterm, getOccpClass];
        
//        NSLog(@"%@",querySQL);
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                riderRate =  sqlite3_column_double(statement, 0);
            } else {
                NSLog(@"error access Trad_Sys_Rider_Prem");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}
//-----

-(void)getOccLoadRider
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT OccLoading_TL FROM Adm_Occp_Loading_Penta WHERE OccpCode=\"%@\"",strOccp];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                occLoadRider =  sqlite3_column_int(statement, 0);
                
            } else {
                NSLog(@"error access getOccLoadRider");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
}

#pragma mark - memory management

- (void)viewDidUnload
{
    [self resignFirstResponder];
    [self setWebView:nil];
    [self setRequestOccpCode:nil];
    [self setRequestSINo:nil];
    [self setRequestBasicSA:nil];
    [self setRequestBasicHL:nil];
    [self setRequestBasicTempHL:nil];
    [self setRequestPlanCode:nil];
    [self setGetOccpCode:nil];
    [self setSINo:nil];
    [self setGetBasicSA:nil];
    [self setGetBasicHL:nil];
    [self setGetBasicTempHL:nil];
    [self setGetPlanCode:nil];
    [self setSex:nil];
    [self setRiderCode:nil];
    [self setRiderDesc:nil];
    [self setRiderTerm:nil];
    [self setRiderSA:nil];
    [self setRiderHL1K:nil];
    [self setRiderHL100:nil];
    [self setRiderHLP:nil];
    [self setRiderPlanOpt:nil];
    [self setRiderUnit:nil];
    [self setRiderDeduct:nil];
    [self setRiderCustCode:nil];
    [self setRiderSmoker:nil];
    [self setRiderSex:nil];
    [self setRiderAge:nil];
    [self setRiderOccp:nil];
    [self setStrOccp:nil];
    [self setPlanCodeRider:nil];
    [self setPentaSQL:nil];
    [self setPlnOptC:nil];
    [self setPlanOptHMM:nil];
    [self setDeducHMM:nil];
    [self setPlanHSPII:nil];
    [self setPlanMGII:nil];
    [self setPlanMGIV:nil];
    [self setHtmlRider:nil];
    [self setAnnualRiderTot:nil];
    [self setHalfRiderTot:nil];
    [self setQuarterRiderTot:nil];
    [self setMonthRiderTot:nil];
    [self setWaiverRiderAnn:nil];
    [self setWaiverRiderAnn2:nil];
    [self setWaiverRiderHalf:nil];
    [self setWaiverRiderHalf2:nil];
    [self setWaiverRiderQuar:nil];
    [self setWaiverRiderQuar2:nil];
    [self setWaiverRiderMonth:nil];
    [self setWaiverRiderMonth2:nil];
    [self setDoGenerate:nil];
    [self setLblMessage:nil];
    [self setReportHMMRates:nil];
    [self setReportFromAge:nil];
    [self setReportToAge:nil];
    [self setRiderTempHL1K:nil];
    [self setHeaderTitle:nil];
    [self setMyToolBar:nil];
    [super viewDidUnload];
}

- (IBAction)btnGenerate:(id)sender {
    ReportViewController *ReportPage = [self.storyboard instantiateViewControllerWithIdentifier:@"Report"];
    ReportPage.SINo = SINo;
    [self presentViewController:ReportPage animated:NO completion:^{
        [ReportPage dismissViewControllerAnimated:NO completion:^{
            /*
            MainScreen *main = [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
            main.modalPresentationStyle = UIModalPresentationFullScreen;
            main.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            main.IndexTab = 6;
            [self presentModalViewController:main animated:YES];
             */
         ReportViewController *reportVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DemoHtml"];
         [self presentViewController:reportVC animated:YES completion:Nil];
        }];
    }];
}
/*
- (IBAction)btnQuotation:(id)sender {
    if (_Browser == Nil) {
        self.Browser = [self.storyboard instantiateViewControllerWithIdentifier:@"Browser"];
        _Browser.delegate = self;
    }
    
    sqlite3_stmt *statement;
    BOOL cont = FALSE;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {  
        // NSString *querySQL = [NSString stringWithFormat:@"SELECT * from SI_Store_Premium "];
        
        NSString *QuerySQL = [ NSString stringWithFormat:@"select \"PolicyTerm\", \"BasicSA\", \"premiumPaymentOption\", \"CashDividend\",  "
                              "\"YearlyIncome\", \"AdvanceYearlyIncome\", \"HL1KSA\",  \"sex\" from Trad_Details as A, "
                              "Clt_Profile as B, trad_LaPayor as C where A.Sino = C.Sino AND C.custCode = B.custcode AND "
                              "A.sino = \"%@\" AND \"seq\" = 1 ", SINo];
        
        if (sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                cont = TRUE;
                
            } else {
                cont = FALSE;
                NSLog(@"error access SI_Store_Premium");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    if (cont == TRUE) {
        
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.center = CGPointMake(400, 350);
        
        spinner.hidesWhenStopped = YES;
        [self.view addSubview:spinner];
        UILabel *spinnerLabel = [[UILabel alloc] initWithFrame:CGRectMake(350, 370, 120, 40) ];
        spinnerLabel.text  = @" Please Wait...";
        spinnerLabel.backgroundColor = [UIColor blackColor];
        spinnerLabel.opaque = YES;
        spinnerLabel.textColor = [UIColor whiteColor];
        [self.view addSubview:spinnerLabel];
        [spinner startAnimating];
        
        
        //dispatch_queue_t downloadQueue = dispatch_queue_create("downloader", NULL);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
            //dispatch_async(downloadQueue, ^{
            
            ReportViewController *ReportPage = [self.storyboard instantiateViewControllerWithIdentifier:@"Report"];
            ReportPage.SINo = SINo;
            [self presentViewController:ReportPage animated:NO completion:Nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [spinner stopAnimating];
                spinnerLabel.text = @"";
                
                [ReportPage dismissViewControllerAnimated:NO completion:Nil];
    
                    
                    BrowserViewController *controller = [[BrowserViewController alloc] init];
                    controller.title = @"Quotation";
                    controller.delegate = self;
                //controller.premH = premH;
                //controller.premBH = premBH;
                
                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
                UINavigationController *container = [[UINavigationController alloc] init];
                [container setNavigationBarHidden:YES animated:NO];
                [container setViewControllers:[NSArray arrayWithObject:navController] animated:NO];
                
                [self presentModalViewController:container animated:YES];
                
                UIView *v =  [[self.view subviews] objectAtIndex:[self.view subviews].count - 1 ];
                [v removeFromSuperview];
            });
            
            
        });
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"SI has been deleted" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
        [alert show];
    }
    
}
*/
-(void)deleteSIStorePremium{
    sqlite3_stmt *statement;
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
       NSString *DeleteSQL =  [ NSString stringWithFormat: @"DELETE from SI_Store_Premium where sino = '%@'", SINo];
        if (sqlite3_prepare_v2(contactDB, [DeleteSQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
            }
            
            sqlite3_finalize(statement);
        }
            
        sqlite3_close(contactDB);
    }    
    
}

-(void)CloseWindow{
    NSLog(@"received");
    [self.presentingViewController dismissModalViewControllerAnimated:YES ];
}
@end
