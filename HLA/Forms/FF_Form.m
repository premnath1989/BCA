//
//  FF_Form.m
//  HLA_CA
//
//  Created by Danial D. Moghaddam on 3/13/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//

#import "FF_Form.h"
#import "myLable.h"
#import "P2Table.h" //this is the Children and dependant table
#import "Table2.h" //this is to display the F. Financial Needs Analysis - Protection Plan
#import "Table3.h" //this is to display the F. Financial Needs Analysis - Saving Plan
#import <QuartzCore/QuartzCore.h>
#import "PRHtmlHandler.h"
#import "TBXML+NSDictionary.h"



#define tintermediaryStatus 100
#define tclientChoice       200
#define tbrokerName       105
#define tbrokerNameBM     106
#define teProposalNo      9999
#define tName      10
#define tNRIC      11
#define tNation    12
#define tRace      13
#define tSexMale   14
#define tSexFemale 15
#define tSmokerYES 16
#define tSmokerNO  17
#define tDOB       18
#define tAge       19
#define tSingle    20
#define tMArried   21
#define tWidowed   22
#define tDivorced  23
#define tOccupation 24
#define tMailingAddress 2500
#define tPermenentAddress 2600
#define tHomeNo     27
#define tWorkNo     28
#define tMobileNo   29
#define tFaxNo      30
#define tEmail      31
#define tQ1Yes      110
#define tQ1YESPartner 120
#define tQ2Yes      210
#define tQ2YESPartner 220
#define tQ3Yes      310
#define tQ3YESPartner 320
#define tQ4Yes      410
#define tQ4YESPartner 420
#define tQ5Yes      510
#define tQ5YESPartner 520

#define tPreference   2000

#define tTotalSA_CurAmt 1001
#define tTotalSA_ReqAmt 102
#define tTotalSA_SurAmt 103

#define tTotalCISA_CurAmt 200
#define tTotalCISA_ReqAmt 202
#define tTotalCISA_SurAmt 203

#define tTotalHB_CurAmt   301
#define tTotalHB_ReqAmt   302
#define tTotalHB_SurAmt   303

#define tTotalPA_CurAmt   401
#define tTotalPA_ReqAmt   402
#define tTotalPA_SurAmt   403

#define tAllocateIncome_1 500
#define tAllocateIncome_2 600

#define tPORow1              1100
#define tComapnyRow1         1101
#define tPlanRow1            1102
#define tPremiumRow1         1103
#define tFreqRow1            1104
#define tStartRow1           1105
#define tDateRow1            1106
#define tPLumpRow1           1107
#define tPAnnualIncomeRow1   1108
#define tAdditionalBenRow1   1109

#define tRetirementCurrAm    1130
#define tRetirementReqAm     1131
#define tRetirementSurp      1132
#define tRetirementIncomeAlloc_1  1133
#define tRetirementIncomeAlloc_2  1134
#define tRetirementOtherIncome_1  1135
#define tRetirementOtherIncome_2  1136

#define tChildNameRow1        1140
#define tChildCompanyRow1     1141
#define tChildPremiumRow1     1142
#define tChildFreqRow         1143
#define tChildStartDateRow1   1144
#define tChildMaturDateRow1   1145
#define tChildPValueAtRow1    1146

#define tChildCurrAmRow1      1162
#define tChildReqAmRow1       1163
#define tChildSurRow1         1164

#define tIncomeAllocToEdu     1174

#define tSavingCurAm          1500
#define tSavingReqAm          1501
#define tSavingSurp           1502
#define tSavingAlloc          1503

#define tAdvPlanTyp           1600
#define tAdvTerm              1601
#define tAdvNameOfIns         1602
#define tAdvNameOfAss         1603
#define tAdvSumAss             1604
#define tAdvAdditionalBenf    1605
#define tAdvReason            1606

#define tAdvAction            1700

#define tInterName            1800
#define tInterContDate        1801
#define tInterAddress         1802
#define tInterAddress2        1812
#define tInterAddress3        1822
#define tInterAddress4        1832
#define tInterAddress5        1842
#define tManagerName          1803
#define tCustomerAck1         1804
#define tCustomerAck2         1805
#define tCustomerName         1806
#define tAdditionalComments   1807


@interface FF_Form ()

@end

@implementation FF_Form

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(NSString *)returnPDFFromDictionary:(NSDictionary *)infoDic proposalNo:(NSString *)proposalNo referenceNo:(NSString *)referenceNo sqliteDBPath:(NSString *)sqliteDBPath
{
    sql = [[SQLHandler alloc]init];
    
    [sql loadSQLFileWithPath:sqliteDBPath];

    page_Paths = [[NSMutableArray alloc]init];
    
    NSArray *arr;
    if ([[[infoDic objectForKey:@"ChildInfo"]objectForKey:@"ChildParty"] isKindOfClass:[NSDictionary class]]) {
        arr = [[NSArray alloc]initWithObjects:[[infoDic objectForKey:@"ChildInfo"]objectForKey:@"ChildParty"], nil];
    }
    else
    {
        arr = [[NSArray alloc]initWithArray:[[infoDic objectForKey:@"ChildInfo"]objectForKey:@"ChildParty"]];
    }
    
    if (arr.count>6) {
        totalPages = @"7";
    }
    else
    {
        totalPages = @"6";
    }
    
    //Page 1 ----->>>>
    int intermediaryStatus = [[[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryStatus"] intValue];
    int clientChoice = [[[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"ClientChoice"] intValue];
    [self.view addSubview:self.page1];
    UIView *intermediaryCheckBox = (UIView *)[self.page1 viewWithTag:tintermediaryStatus+intermediaryStatus];
    intermediaryCheckBox.backgroundColor = [UIColor blackColor];
    
//    UILabel *lbl = (UILabel *)[self.page1 viewWithTag:tName];
//    lbl.text = [infoDic objectForKey:@"BrokerName"];
    
    UIView *clientChoiceCheckBox = (UIView *)[self.page1 viewWithTag:tclientChoice+clientChoice];
    clientChoiceCheckBox.backgroundColor = [UIColor blackColor];
    int pageNo = page_Paths.count;
    
    NSString *broker_name = [NSString stringWithFormat:@"%@",[[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"BrokerName"],nil];
    UILabel *lbl = (UILabel *)[self.page1 viewWithTag:tbrokerName];
    if ([broker_name isEqualToString:@"(null)"]) {
        broker_name=@"";
    }
    lbl.text = broker_name;
    
    NSString *broker_nameBM = [NSString stringWithFormat:@"%@",[[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"BrokerName"]];
    UILabel *lblBM = (UILabel *)[self.page1 viewWithTag:tbrokerNameBM];
    if ([broker_nameBM isEqualToString:@"(null)"]) {
        broker_nameBM=@"";
    }
    lblBM.text = broker_nameBM;
    
    NSString *broker_eProposalNo = [NSString stringWithFormat:@"%@",[[infoDic objectForKey:@"AssuredInfo"]objectForKey:@"eProposalNo"]];
    UILabel *lbl1 = (UILabel *)[self.page1 viewWithTag:teProposalNo];
    lbl1.text = broker_eProposalNo;
    _eProposalNo = [[infoDic objectForKey:@"AssuredInfo"]objectForKey:@"eProposalNo"];
    
    
    //PageNumber
    myLable *pageNumber = [[myLable alloc]initWithFrame:CGRectMake(268, 825, 58, 21)];
    [pageNumber setFont:[UIFont fontWithName:@"Helvetica" size:8]];
    pageNumber.text = [NSString stringWithFormat:@"Page %i of %@",pageNo+1,totalPages];
    [self.page1 addSubview:pageNumber];
    
    NSString *pageName = [NSString stringWithFormat:@"temp%i.pdf",pageNo];
    [page_Paths addObject:[self createPDFfromUIView:self.view saveToDocumentsWithFileName:pageName]];
    //Page 1 <<-----------
    
    //Page 2 ----->>>>
    [self loadPage2:[[infoDic objectForKey:@"PersonalInfo"]objectForKey:@"CFFParty"] footerInfo:[infoDic objectForKey:@"eCFFInfo"] children:[[infoDic objectForKey:@"ChildInfo"]objectForKey:@"ChildParty"]];
    //Page 2 <<-----------
    
    //Page 3 ------->>
    [self loadPage3:[infoDic objectForKey:@"ProtectionInfo"] retirementInfo:[infoDic objectForKey:@"RetirementInfo"] RiskReturnProfile:[[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"RiskReturnProfile"]];
    //Page 3 <<-----------
    
    //Page 4 ------->>
    [self loadPage4:[infoDic objectForKey:@"RetirementInfo"] educInfo:[infoDic objectForKey:@"EducInfo"]];
    //Page 4 <<-----------
    
    //Page 5 ------->>
    [self loadPage5:[infoDic objectForKey:@"SavingInfo"] recordOfAdvice:[infoDic objectForKey:@"RecordOfAdvice"]];
    //Page 5 <<-----------
    
    //Page 6 ------->>
    [self loadPage6:[infoDic objectForKey:@"eCFFInfo"] personalInfo:[infoDic objectForKey:@"PersonalInfo"]];
    //Page 6 <<-----------
    
    
    return [self joinPDF:page_Paths refNo:referenceNo];
}
-(NSString *)createPDFfromUIView:(UIView*)aView saveToDocumentsWithFileName:(NSString*)aFilename
{
    // Creates a mutable data object for updating with binary data, like a byte array
    NSMutableData *pdfData = [NSMutableData data];
    
    // Points the pdf converter to the mutable data object and to the UIView to be converted
    UIGraphicsBeginPDFContextToData(pdfData, aView.bounds, nil);
    UIGraphicsBeginPDFPage();
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    
    
    // draws rect to the view and thus this is captured by UIGraphicsBeginPDFContextToData
    
    [aView.layer renderInContext:pdfContext];
    
    // remove PDF rendering context
    UIGraphicsEndPDFContext();
    
    // Retrieves the document directories from the iOS device
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    documentDirectory = [documentDirectory stringByAppendingString:@"/Forms/"];
    NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:aFilename];
    
    // instructs the mutable data object to write its context to a file on disk
    [pdfData writeToFile:documentDirectoryFilename atomically:YES];
    //NSLog(@"documentDirectoryFileName: %@",documentDirectoryFilename);
    return documentDirectoryFilename;
}
- (NSString *)joinPDF:(NSArray *)listOfPath refNo:(NSString *)refNo{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *layOutPath=[NSString stringWithFormat:@"%@",[paths objectAtIndex:0]];
    if(![[NSFileManager defaultManager] fileExistsAtPath:layOutPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:layOutPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    // File paths
    NSString *fileName = [NSString stringWithFormat:@"%@_FF.pdf",refNo];
    layOutPath = [layOutPath stringByAppendingString:@"/Forms/"];
    NSString *pdfPathOutput = [layOutPath stringByAppendingPathComponent:fileName];
    CFURLRef pdfURLOutput = (__bridge CFURLRef)[NSURL fileURLWithPath:pdfPathOutput];
    NSInteger numberOfPages = 0;
    // Create the output context
    CGContextRef writeContext = CGPDFContextCreateWithURL(pdfURLOutput, NULL, NULL);
    
    for (NSString *source in listOfPath) {
        //        CFURLRef pdfURL = (__bridge CFURLRef)[NSURL fileURLWithPath:source];
        
        CFURLRef pdfURL =  CFURLCreateFromFileSystemRepresentation(NULL, [source UTF8String],[source length], NO);
        
        //file ref
        CGPDFDocumentRef pdfRef = CGPDFDocumentCreateWithURL(pdfURL);
        numberOfPages = CGPDFDocumentGetNumberOfPages(pdfRef);
        
        // Loop variables
        CGPDFPageRef page;
        CGRect mediaBox;
        
        // Read the first PDF and generate the output pages
        //NSLog(@"GENERATING PAGES FROM PDF 1 (%@)...", source);
        for (int i=1; i<=numberOfPages; i++) {
            page = CGPDFDocumentGetPage(pdfRef, i);
            mediaBox = CGPDFPageGetBoxRect(page, kCGPDFMediaBox);
            CGContextBeginPage(writeContext, &mediaBox);
            CGContextDrawPDFPage(writeContext, page);
            CGContextEndPage(writeContext);
        }
        
        CGPDFDocumentRelease(pdfRef);
        CFRelease(pdfURL);
    }
    // CFRelease(pdfURLOutput);
    //
    //    // Finalize the output file
    CGPDFContextClose(writeContext);
    CGContextRelease(writeContext);
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    for (NSString *filePath in listOfPath)  {
        [fileMgr removeItemAtPath:filePath error:NULL];
    }
    
    return pdfPathOutput;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Load Page6
-(void)loadPage6:(NSDictionary *)eCFFInfo personalInfo:(NSDictionary *)personalInfo
{
    UILabel *lbl = (UILabel *)[self.page6 viewWithTag:tInterName];
    lbl.text = [eCFFInfo objectForKey:@"IntermediaryName"];
    lbl = (UILabel *)[self.page6 viewWithTag:tInterContDate];
    lbl.text = [eCFFInfo objectForKey:@"IntermediaryContractDate"];
    
//    NSMutableString *resultString = [NSMutableString string];
//    if ([[eCFFInfo objectForKey:@"IntermediaryAddress1"] length]) {
//    if ([resultString length]>0) {
//        [resultString appendString:@"\n"];
//        [resultString appendFormat:@"%@", [eCFFInfo objectForKey:@"IntermediaryAddress1"]];
//    }
//    else
//    {
//        resultString = [eCFFInfo objectForKey:@"IntermediaryAddress1"];
//    }
//    }
//    
//    if ([[eCFFInfo objectForKey:@"IntermediaryAddress2"] length]) {
//    if ([resultString length]>0) {
//        [resultString appendString:@"\n"];
//        [resultString appendFormat:@"%@", [eCFFInfo objectForKey:@"IntermediaryAddress2"]];
//    }
//    else
//    {
//        resultString = [eCFFInfo objectForKey:@"IntermediaryAddress2"];
//    }
//    }
//    
//    if ([[eCFFInfo objectForKey:@"IntermediaryAddress3"] length]) {
//    if ([resultString length]>0) {
//        [resultString appendString:@"\n"];
//        [resultString appendFormat:@"%@", [eCFFInfo objectForKey:@"IntermediaryAddress3"]];
//    }
//    else
//    {
//        resultString = [eCFFInfo objectForKey:@"IntermediaryAddress3"];
//    }
//    }
//    
//    if ([[eCFFInfo objectForKey:@"IntermediaryAddress4"] length]) {
//        if ([resultString length]>0) {
//            [resultString appendString:@"\n"];
//            [resultString appendFormat:@"%@", [eCFFInfo objectForKey:@"IntermediaryAddress4"]];
//        }
//        else
//        {
//            resultString = [eCFFInfo objectForKey:@"IntermediaryAddress4"];
//        }
//    }
    lbl = (UILabel *)[self.page6 viewWithTag:tInterAddress];
    lbl.text = [eCFFInfo objectForKey:@"IntermediaryAddress1"];
    
    lbl = (UILabel *)[self.page6 viewWithTag:tInterAddress2];
    lbl.text = [eCFFInfo objectForKey:@"IntermediaryAddress2"];
    
    lbl = (UILabel *)[self.page6 viewWithTag:tInterAddress3];
    lbl.text = [eCFFInfo objectForKey:@"IntermediaryAddress3"];
    
    
    NSMutableString *address4 = [NSMutableString string];
    address4 = [eCFFInfo objectForKey:@"IntermediaryPostcode"];
    [address4 appendString:@", "];
    [address4 appendFormat:@"%@", [eCFFInfo objectForKey:@"IntermediaryTown"]];
    lbl = (UILabel *)[self.page6 viewWithTag:tInterAddress4];
    lbl.text = address4;
    
    
    NSMutableString *address5 = [NSMutableString string];
    NSString *getState;
    NSString *getCountry;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    
    FMResultSet *result = [db executeQuery:@"select * from eProposal_State where StateCode = ?",[eCFFInfo objectForKey:@"IntermediaryState"]];
    while ([result next]) {
        getState = [result objectForColumnName:@"StateDesc"];
    }
    result = [db executeQuery:@"select * from eProposal_Country where CountryCode = ?",[eCFFInfo objectForKey:@"IntermediaryCountry"]];
    while ([result next]) {
        getCountry = [result objectForColumnName:@"CountryDesc"];
    }
    
    [address5 appendFormat:@"%@", getState];
    [address5 appendString:@", "];
    [address5 appendFormat:@"%@", getCountry];
    lbl = (UILabel *)[self.page6 viewWithTag:tInterAddress5];
    lbl.text = address5;
    
    
    
    lbl = (UILabel *)[self.page6 viewWithTag:tManagerName];
    lbl.text = [eCFFInfo objectForKey:@"IntermediaryManagerName"];
    
    if ([[personalInfo objectForKey:@"CFFParty"]isKindOfClass:[NSDictionary class]]) {
        lbl = (UILabel *)[self.page6 viewWithTag:tCustomerName];
        lbl.text = [[personalInfo objectForKey:@"CFFParty"]objectForKey:@"Name"];
    }
    else
    {
        lbl = (UILabel *)[self.page6 viewWithTag:tCustomerName];
        lbl.text = [[[personalInfo objectForKey:@"CFFParty"]objectAtIndex:0] objectForKey:@"Name"];
    }
    
    lbl = (UILabel *)[self.page6 viewWithTag:tAdditionalComments];
    lbl.text = [eCFFInfo objectForKey:@"ClientComments"];
    
    NSString *clientAck =[eCFFInfo objectForKey:@"ClientAck"];
    if ([clientAck isEqualToString:@"1"]) {
        UIView *v = (UIView *)[self.page6 viewWithTag:tCustomerAck1];
        v.backgroundColor = [UIColor blackColor];
    }else if ([clientAck isEqualToString:@"2"]){
        UIView *v = (UIView *)[self.page6 viewWithTag:tCustomerAck2];
        v.backgroundColor = [UIColor blackColor];
    }
    
    int pageNo = page_Paths.count;
    myLable *pageNumber = [[myLable alloc]initWithFrame:CGRectMake(268, 825, 58, 21)];
    [pageNumber setFont:[UIFont fontWithName:@"Helvetica" size:8]];
    pageNumber.text = [NSString stringWithFormat:@"Page %i of %@",pageNo+1,totalPages];
    [self.page6 addSubview:pageNumber];
    NSString *pageName = [NSString stringWithFormat:@"temp%i.pdf",pageNo];
    [page_Paths addObject:[self createPDFfromUIView:self.page6 saveToDocumentsWithFileName:pageName]];
    
    //[self createPDFfromUIView:self.page6 saveToDocumentsWithFileName:@"FF_Form_006.pdf"];
}
#pragma mark - Load Page5
-(void)loadPage5:(NSDictionary *)savingInfo recordOfAdvice:(NSDictionary *)recordOfAdvice
{
    BOOL hasLongAdditionalBenf=NO;
    UIView *tempFooterB;
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setMaximumFractionDigits:2];
    [fmt setPositiveFormat:@"#,##0.00"];
    
    NSArray *savingsArr;
    if ([[savingInfo objectForKey:@"SavingPlanInfo"]isKindOfClass:[NSDictionary class]]) {
        savingsArr = [[NSArray alloc]initWithObjects:[savingInfo objectForKey:@"SavingPlanInfo"], nil];
    }
    else
    {
        savingsArr = [[NSArray alloc]initWithArray:[savingInfo objectForKey:@"SavingPlanInfo"]];
    }
    
    Table3 *table3 = [[Table3 alloc]init];
    
    [table3 loadFromArray:savingsArr];
    [self.page5 addSubview:table3.view];
    CGRect rect = table3.view.frame;
    rect.origin.y += rect.size.height +15 ;
    
    CGRect footerFrame = self.page5Footer.frame;
    footerFrame.origin.y = rect.origin.y;
    self.page5Footer.frame = footerFrame;
    
    UILabel *lbl = (UILabel *)[self.page5Footer viewWithTag:tSavingCurAm ];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[savingInfo objectForKey:@"CurAmt"]]];
    
    lbl = (UILabel *)[self.page5Footer viewWithTag:tSavingReqAm];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[savingInfo objectForKey:@"ReqAmt"]]];
    
    lbl = (UILabel *)[self.page5Footer viewWithTag:tSavingSurp];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[savingInfo objectForKey:@"SurAmt"]]];
    
    lbl = (UILabel *)[self.page5Footer viewWithTag:tSavingAlloc];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[savingInfo objectForKey:@"AllocateIncome_1"]]];
    

    NSArray *advicesArr;
    if ([[recordOfAdvice objectForKey:@"Priority"]isKindOfClass:[NSDictionary class]]) {
        advicesArr = [[NSArray alloc]initWithObjects:[recordOfAdvice objectForKey:@"Priority"], nil];
    }
    else
    {
        advicesArr = [[NSArray alloc]initWithArray:[recordOfAdvice objectForKey:@"Priority"]];
    }
    
    //Create Harcoded UnderLines
    for (int i = 0 ; i<2; i++) {
        lbl = (UILabel *)[self.page5Footer viewWithTag:tAdvAdditionalBenf+(i*10)];
        int y = lbl.frame.origin.y;
        for (int i = 0 ; i<4; i++) {
            y+=10;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lbl.frame.origin.x, y, lbl.frame.size.width, 0.5)]; // change the 200 to fit your screen
            lineView.backgroundColor = [UIColor blackColor];
            [self.page5Footer addSubview:lineView];
            y+=6;
        }
    }
    

    
    
    for (int i=0; i<advicesArr.count; i++) {
        lbl = (UILabel *)[self.page5Footer viewWithTag:tAdvPlanTyp+(i*10)];
        lbl.text = [advicesArr[i]objectForKey:@"PlanType"];
        lbl = (UILabel *)[self.page5Footer viewWithTag:tAdvTerm+(i*10)];
        lbl.text = [advicesArr[i]objectForKey:@"Term"];
        lbl = (UILabel *)[self.page5Footer viewWithTag:tAdvNameOfIns+(i*10)];
        lbl.text = [advicesArr[i]objectForKey:@"InsurerName"];
        lbl = (UILabel *)[self.page5Footer viewWithTag:tAdvNameOfAss+(i*10)];
        lbl.text = [advicesArr[i]objectForKey:@"InsuredName"];
        lbl = (UILabel *)[self.page5Footer viewWithTag:tAdvSumAss+(i*10)];
        lbl.text = [fmt stringFromNumber:[fmt numberFromString:[advicesArr[i]objectForKey:@"SA"]]];

        
        

        
        
        UIView *footerB = (UIView *)[self.page5Footer viewWithTag:6666];
        
        lbl = (UILabel *)[footerB viewWithTag:tAdvAction];
        lbl.text =[advicesArr[i]objectForKey:@"Action"] ;
        
        lbl = (UILabel *)[footerB viewWithTag:tAdvReason+(i*10)];
        lbl.text = [advicesArr[i]objectForKey:@"Reason"];
        lbl.numberOfLines=5;
        [lbl sizeToFit];
        
        id addBen = [[advicesArr [i]objectForKey:@"RecordOfAdviceBenefits"]objectForKey:@"Rider"];
        NSArray *additionalArr;
        if ([addBen isKindOfClass:[NSDictionary class]]) {
            additionalArr = [[NSArray alloc]initWithObjects:addBen, nil];
        }
        else
        {
            additionalArr = [[NSArray alloc]initWithArray:addBen];
        }

        
        NSMutableArray *arr = [[NSMutableArray alloc]init];    
        for (int i =0; i<additionalArr.count; i++) {
            [arr addObject:[additionalArr[i]objectForKey:@"RiderName"]];


        } // Array count loop
        
//        NSString *str=[arr componentsJoinedByString:@"\n"];
        lbl = (UILabel *)[self.page5Footer viewWithTag:tAdvAdditionalBenf+(i*10)];
        int y = lbl.frame.origin.y;
        int counter = 0;
        for (id obj in arr) {
            myLable *label = [[myLable alloc]initWithFrame:CGRectMake(lbl.frame.origin.x, y, lbl.frame.size.width, 10)];
            [label setFont:[UIFont fontWithName:@"Helvetica" size:7.0]];
            label.text = obj;
            [self.page5Footer addSubview:label];
            y+=10;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lbl.frame.origin.x, y, lbl.frame.size.width, 0.5)]; // change the 200 to fit your screen
            lineView.backgroundColor = [UIColor blackColor];
            if (counter>3) {
                [self.page5Footer addSubview:lineView];
            }
            
            y+=6;
            counter++;
        }
        
        
//        lbl = (UILabel *)[self.page5Footer viewWithTag:tAdvAdditionalBenf+(i*10)];
//        
////        lbl.layer.borderColor = [UIColor blackColor].CGColor;
////        lbl.layer.borderWidth = 0.5;
////        lbl.text = str;
//        lbl.numberOfLines=20;
//        [lbl sizeToFit];
        
        
        if (arr.count>4) {
            hasLongAdditionalBenf = YES;
            tempFooterB = footerB;
            [footerB removeFromSuperview];
        }
        
        
    }
    
    
    int pageNo = page_Paths.count;
    myLable *pageNumber = [[myLable alloc]initWithFrame:CGRectMake(268, 825, 58, 21)];
    [pageNumber setFont:[UIFont fontWithName:@"Helvetica" size:8]];
    pageNumber.text = [NSString stringWithFormat:@"Page %i of %@",pageNo+1,totalPages];
    [self.page5 addSubview:pageNumber];
    NSString *pageName = [NSString stringWithFormat:@"temp%i.pdf",pageNo];
    [page_Paths addObject:[self createPDFfromUIView:self.page5 saveToDocumentsWithFileName:pageName]];
    
    if (hasLongAdditionalBenf) {
        //Move Footer to another Page
        UIView *additionalPage = [[UIView alloc]initWithFrame:self.page5.frame];
        [additionalPage setBackgroundColor:[UIColor whiteColor]];
        CGRect frame = tempFooterB.frame;
        frame.origin.x=0;
        frame.origin.y=40;
        tempFooterB.frame = frame;
        [additionalPage addSubview:tempFooterB];
        
        int pageNo = page_Paths.count;
        myLable *pageNumber = [[myLable alloc]initWithFrame:CGRectMake(268, 825, 58, 21)];
        [pageNumber setFont:[UIFont fontWithName:@"Helvetica" size:8]];
        pageNumber.text = [NSString stringWithFormat:@"Page %i of %@",pageNo+1,totalPages];
        [additionalPage addSubview:pageNumber];
        NSString *pageName = [NSString stringWithFormat:@"temp%i.pdf",pageNo];
        [page_Paths addObject:[self createPDFfromUIView:additionalPage saveToDocumentsWithFileName:pageName]];
        
        
    }
    
    
    
    

    //[self createPDFfromUIView:self.page5 saveToDocumentsWithFileName:@"FF_Form_005.pdf"];
}
#pragma mark - Load Page4
-(void)loadPage4:(NSDictionary *)retirementInfo educInfo:(NSDictionary *)educInfo
{

    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setMaximumFractionDigits:2];
    [fmt setPositiveFormat:@"#,##0.00"];
    
    NSArray *retirementArr;
    if ([[retirementInfo objectForKey:@"RetirementPlanInfo"]isKindOfClass:[NSDictionary class]]) {
        retirementArr = [[NSArray alloc]initWithObjects:[retirementInfo objectForKey:@"RetirementPlanInfo"], nil];
    }
    else
    {
        retirementArr = [[NSArray alloc]initWithArray:[retirementInfo objectForKey:@"RetirementPlanInfo"]];
    }
    for (int i = 0; i<retirementArr.count; i++) {
        NSDictionary *aDic = [retirementArr objectAtIndex:i];
        UILabel *lbl = (UILabel *)[self.page4 viewWithTag:tPORow1+(i*10)];
        lbl.text = [aDic objectForKey:@"POName"];
        [lbl sizeToFit];
        
        lbl = (UILabel *)[self.page4 viewWithTag:tComapnyRow1+(i*10)];
        lbl.text = [aDic objectForKey:@"Company"];
        [lbl sizeToFit];
        
        lbl = (UILabel *)[self.page4 viewWithTag:tPlanRow1+(i*10)];
        lbl.text = [aDic objectForKey:@"PlanType"];
        [lbl sizeToFit];
        
        lbl = (UILabel *)[self.page4 viewWithTag:tPremiumRow1+(i*10)];
        lbl.text = [fmt stringFromNumber:[fmt numberFromString:[aDic objectForKey:@"Premium"]]];
        [lbl sizeToFit];
        
        lbl = (UILabel *)[self.page4 viewWithTag:tFreqRow1+(i*10)];
        lbl.text = [aDic objectForKey:@"Frequency"];
        [lbl sizeToFit];        
        
        lbl = (UILabel *)[self.page4 viewWithTag:tStartRow1+(i*10)];
        lbl.text = [aDic objectForKey:@"StartDate"];
        [lbl sizeToFit];
                
        lbl = (UILabel *)[self.page4 viewWithTag:tDateRow1+(i*10)];
        lbl.text = [aDic objectForKey:@"EndDate"];
        [lbl sizeToFit];
        
        lbl = (UILabel *)[self.page4 viewWithTag:tPLumpRow1+(i*10)];
        lbl.text = [fmt stringFromNumber:[fmt numberFromString:[aDic objectForKey:@"LSMaturityAmt"]]];        
        [lbl sizeToFit];
        
        lbl = (UILabel *)[self.page4 viewWithTag:tPAnnualIncomeRow1+(i*10)];
        lbl.text = [fmt stringFromNumber:[fmt numberFromString:[aDic objectForKey:@"AIMaturityAmt"]]];
        [lbl sizeToFit];
        
        lbl = (UILabel *)[self.page4 viewWithTag:tAdditionalBenRow1+(i*10)];
        lbl.text = [fmt stringFromNumber:[fmt numberFromString:[aDic objectForKey:@"Benefits"]]];        
        [lbl sizeToFit];
        
    }
    
    UILabel *lbl = (UILabel *)[self.page4 viewWithTag:tRetirementCurrAm];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[retirementInfo objectForKey:@"CurAmt"]]];
    
    
    lbl = (UILabel *)[self.page4 viewWithTag:tRetirementReqAm];
    lbl.text = [retirementInfo objectForKey:@"ReqAmt"];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[retirementInfo objectForKey:@"ReqAmt"]]];
    
    
    lbl = (UILabel *)[self.page4 viewWithTag:tRetirementSurp];
    lbl.text = [retirementInfo objectForKey:@"SurAmt"];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[retirementInfo objectForKey:@"SurAmt"]]];
    
    lbl = (UILabel *)[self.page4 viewWithTag:tRetirementIncomeAlloc_1];
    lbl.text = [retirementInfo objectForKey:@"AllocateIncome_1"];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[retirementInfo objectForKey:@"AllocateIncome_1"]]];
    
    lbl = (UILabel *)[self.page4 viewWithTag:tRetirementIncomeAlloc_2];
    lbl.text = [retirementInfo objectForKey:@"AllocateIncome_2"];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[retirementInfo objectForKey:@"AllocateIncome_2"]]];
    
    
    lbl = (UILabel *)[self.page4 viewWithTag:tRetirementOtherIncome_1];
    lbl.text = [retirementInfo objectForKey:@"IncomeSource_1"];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[retirementInfo objectForKey:@"IncomeSource_1"]]];
    
    lbl = (UILabel *)[self.page4 viewWithTag:tRetirementOtherIncome_2];
    lbl.text = [retirementInfo objectForKey:@"IncomeSource_2"];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[retirementInfo objectForKey:@"IncomeSource_2"]]];    
    
    NSArray *childrenEduArr;
    if ([[educInfo objectForKey:@"EducPlanInfo"]isKindOfClass:[NSDictionary class]]) {
        childrenEduArr = [[NSArray alloc]initWithObjects:[educInfo objectForKey:@"EducPlanInfo"], nil];
    }
    else
    {
        childrenEduArr = [[NSArray alloc]initWithArray:[educInfo objectForKey:@"EducPlanInfo"]];
    }
    int multiplValue=1;
     for (int i = 0; i<childrenEduArr.count; i++) {
         if (i==3)
             multiplValue=10;
         
          NSDictionary *aDic = [childrenEduArr objectAtIndex:i];
         
         UILabel *lbl = (UILabel *)[self.page4 viewWithTag:multiplValue*tChildNameRow1+(i*7)];
         lbl.text = [aDic objectForKey:@"Name"];
         [lbl sizeToFit];
         
         lbl = (UILabel *)[self.page4 viewWithTag:multiplValue*tChildCompanyRow1+(i*7)];
         lbl.text = [aDic objectForKey:@"Company"];
         [lbl sizeToFit];
         
         lbl = (UILabel *)[self.page4 viewWithTag:multiplValue*tChildPremiumRow1+(i*7)];
         lbl.text = [fmt stringFromNumber:[fmt numberFromString:[aDic objectForKey:@"Premium"]]];
         [lbl sizeToFit];
         
         lbl = (UILabel *)[self.page4 viewWithTag:multiplValue*tChildFreqRow+(i*7)];
         lbl.text = [aDic objectForKey:@"Frequency"];
         [lbl sizeToFit];
         
         lbl = (UILabel *)[self.page4 viewWithTag:multiplValue*tChildStartDateRow1+(i*7)];
         lbl.text = [aDic objectForKey:@"StartDate"];
         [lbl sizeToFit];
         
         lbl = (UILabel *)[self.page4 viewWithTag:multiplValue*tChildMaturDateRow1+(i*7)];
         lbl.text = [aDic objectForKey:@"EndDate"];
         [lbl sizeToFit];
         
         lbl = (UILabel *)[self.page4 viewWithTag:multiplValue*tChildPValueAtRow1+(i*7)];
         lbl.text = [fmt stringFromNumber:[fmt numberFromString:[aDic objectForKey:@"MaturityAmt"]]];
         [lbl sizeToFit];
         
     }
    lbl = (UILabel *)[self.page4 viewWithTag:tChildCurrAmRow1];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[educInfo objectForKey:@"CurAmt_C1"]]];
    
    lbl = (UILabel *)[self.page4 viewWithTag:tChildReqAmRow1];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[educInfo objectForKey:@"ReqAmt_C1"]]];
    
    lbl = (UILabel *)[self.page4 viewWithTag:tChildSurRow1];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[educInfo objectForKey:@"SurAmt_C1"]]];
    
    lbl = (UILabel *)[self.page4 viewWithTag:tChildCurrAmRow1+3];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[educInfo objectForKey:@"CurAmt_C2"]]];
    
    lbl = (UILabel *)[self.page4 viewWithTag:tChildReqAmRow1+3];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[educInfo objectForKey:@"ReqAmt_C2"]]];
    
    lbl = (UILabel *)[self.page4 viewWithTag:tChildSurRow1+3];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[educInfo objectForKey:@"SurAmt_C2"]]];
    
    lbl = (UILabel *)[self.page4 viewWithTag:tChildCurrAmRow1+6];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[educInfo objectForKey:@"CurAmt_C3"]]];
    
    lbl = (UILabel *)[self.page4 viewWithTag:tChildReqAmRow1+6];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[educInfo objectForKey:@"ReqAmt_C3"]]];
    
    lbl = (UILabel *)[self.page4 viewWithTag:tChildSurRow1+6];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[educInfo objectForKey:@"SurAmt_C3"]]];
    
    
    lbl = (UILabel *)[self.page4 viewWithTag:tChildCurrAmRow1+9];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[educInfo objectForKey:@"CurAmt_C4"]]];
    
    lbl = (UILabel *)[self.page4 viewWithTag:tChildReqAmRow1+9];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[educInfo objectForKey:@"ReqAmt_C4"]]];    
    
    lbl = (UILabel *)[self.page4 viewWithTag:tChildSurRow1+9];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[educInfo objectForKey:@"SurAmt_C4"]]];    
    
//    lbl = (UILabel *)[self.page4 viewWithTag:tChildCurrAmRow1+12];
//    lbl.text = [educInfo objectForKey:@"CurAmt_C4"];
//    lbl = (UILabel *)[self.page4 viewWithTag:tChildReqAmRow1+12];
//    lbl.text = [educInfo objectForKey:@"ReqAmt_C4"];
//    lbl = (UILabel *)[self.page4 viewWithTag:tChildSurRow1+12];
//    lbl.text = [educInfo objectForKey:@"SurAmt_C4"];
    
    lbl = (UILabel *)[self.page4 viewWithTag:tIncomeAllocToEdu];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[educInfo objectForKey:@"AllocateIncome_1"]]];
    
    int pageNo = page_Paths.count;
    myLable *pageNumber = [[myLable alloc]initWithFrame:CGRectMake(268, 825, 58, 21)];
    [pageNumber setFont:[UIFont fontWithName:@"Helvetica" size:8]];
    pageNumber.text = [NSString stringWithFormat:@"Page %i of %@",pageNo+1,totalPages];
    [self.page4 addSubview:pageNumber];
    NSString *pageName = [NSString stringWithFormat:@"temp%i.pdf",pageNo];
    [page_Paths addObject:[self createPDFfromUIView:self.page4 saveToDocumentsWithFileName:pageName]];
    
    //[self createPDFfromUIView:self.page4 saveToDocumentsWithFileName:@"FF_Form_004.pdf"];

}
#pragma mark - Load Page3
-(void)loadPage3:(NSDictionary *)protectionInfo retirementInfo:(NSDictionary *)retirementInfo RiskReturnProfile:(NSString *)RiskReturnProfile
{
    
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setMaximumFractionDigits:2];
    [fmt setPositiveFormat:@"#,##0.00"];
    
    int preference = [RiskReturnProfile integerValue];
    UILabel *lbl = (UILabel *)[self.page3 viewWithTag:tPreference+preference];
    lbl.text = @"X";
    
    lbl = (UILabel *)[self.page3Footer viewWithTag:tTotalSA_CurAmt];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[protectionInfo objectForKey:@"TotalSA_CurAmt"]]];
    
    lbl = (UILabel *)[self.page3Footer viewWithTag:tTotalSA_ReqAmt];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[protectionInfo objectForKey:@"TotalSA_ReqAmt"]]];
    
    lbl = (UILabel *)[self.page3Footer viewWithTag:tTotalSA_SurAmt];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[protectionInfo objectForKey:@"TotalSA_SurAmt"]]];
    
    lbl = (UILabel *)[self.page3Footer viewWithTag:tTotalCISA_CurAmt];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[protectionInfo objectForKey:@"TotalCISA_CurAmt"]]];
    
    lbl = (UILabel *)[self.page3Footer viewWithTag:tTotalCISA_ReqAmt];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[protectionInfo objectForKey:@"TotalCISA_ReqAmt"]]];
    
    lbl = (UILabel *)[self.page3Footer viewWithTag:tTotalCISA_SurAmt];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[protectionInfo objectForKey:@"TotalCISA_SurAmt"]]];
    
    lbl = (UILabel *)[self.page3Footer viewWithTag:tTotalHB_CurAmt];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[protectionInfo objectForKey:@"TotalHB_CurAmt"]]];
    
    lbl = (UILabel *)[self.page3Footer viewWithTag:tTotalHB_ReqAmt];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[protectionInfo objectForKey:@"TotalHB_ReqAmt"]]];
    
    lbl = (UILabel *)[self.page3Footer viewWithTag:tTotalHB_SurAmt];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[protectionInfo objectForKey:@"TotalHB_SurAmt"]]];
    
    lbl = (UILabel *)[self.page3Footer viewWithTag:tTotalPA_CurAmt];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[protectionInfo objectForKey:@"TotalPA_CurAmt"]]];
    
    lbl = (UILabel *)[self.page3Footer viewWithTag:tTotalPA_ReqAmt];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[protectionInfo objectForKey:@"TotalPA_ReqAmt"]]];
    
    lbl = (UILabel *)[self.page3Footer viewWithTag:tTotalPA_SurAmt];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[protectionInfo objectForKey:@"TotalPA_SurAmt"]]];

    lbl = (UILabel *)[self.page3Footer viewWithTag:tAllocateIncome_1];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[protectionInfo objectForKey:@"AllocateIncome_1"]]];                
    
    lbl = (UILabel *)[self.page3Footer viewWithTag:tAllocateIncome_2];
    lbl.text = [fmt stringFromNumber:[fmt numberFromString:[protectionInfo objectForKey:@"AllocateIncome_2"]]];                
    
    
    
    Table2 *table2 = [[Table2 alloc]init];
    NSArray *arr;
    if ([[protectionInfo objectForKey:@"ProtectionPlanInfo"]isKindOfClass:[NSDictionary class]]) {
        arr = [[NSArray alloc]initWithObjects:[protectionInfo objectForKey:@"ProtectionPlanInfo"], nil];
    }
    else
    {
        arr = [[NSArray alloc]initWithArray:[protectionInfo objectForKey:@"ProtectionPlanInfo"]];
        
    }
    [table2 loadFromArray:arr];
    [self.page3 addSubview:table2.view];
    CGRect rect = table2.view.frame;
    rect.origin.y += rect.size.height ;
    
    CGRect footerFrame = self.page3Footer.frame;
    footerFrame.origin.y = rect.origin.y;
    self.page3Footer.frame = footerFrame;
    
    int pageNo = page_Paths.count;
    myLable *pageNumber = [[myLable alloc]initWithFrame:CGRectMake(268, 825, 58, 21)];
    [pageNumber setFont:[UIFont fontWithName:@"Helvetica" size:8]];
    pageNumber.text = [NSString stringWithFormat:@"Page %i of %@",pageNo+1,totalPages];
    [self.page3 addSubview:pageNumber];
    NSString *pageName = [NSString stringWithFormat:@"temp%i.pdf",pageNo];
    [page_Paths addObject:[self createPDFfromUIView:self.page3 saveToDocumentsWithFileName:pageName]];
    
    
    //[self createPDFfromUIView:self.page3 saveToDocumentsWithFileName:@"FF_Form_003.pdf"];
}
#pragma mark - Load Page2
-(void)loadPage2:(NSArray *)persons footerInfo:(NSDictionary *)footerInfo children:(NSArray *)children
{
    
    NSArray *arr;
    if ([persons isKindOfClass:[NSDictionary class]]) {
        arr = [[NSArray alloc]initWithObjects:persons, nil];
    }
    else
    {
        arr = [[NSArray alloc]initWithArray:persons];
    }
    
    if ([arr count]) {
        [self loadOwner:[arr objectAtIndex:0]];
        if ([arr count]>1) {
            [self loadPartner:[arr objectAtIndex:1]];
        }
    }
    
    if ([children isKindOfClass:[NSDictionary class]]) {
        arr = [[NSArray alloc]initWithObjects:children, nil];
    }
    else
    {
        arr = [[NSArray alloc]initWithArray:children];
    }
    P2Table *childTable = [[P2Table alloc]init];
    [childTable loadFromArray:arr];
    CGRect rect = childTable.view.frame;
    rect.origin.x = 22; rect.origin.y = 480;
    [self.page2 addSubview:childTable.view];
    [self loadPage2Footer:footerInfo];
    
    if (arr.count>5) {
        [self.page2Footer removeFromSuperview];
        int pageNo = page_Paths.count;
        myLable *pageNumber = [[myLable alloc]initWithFrame:CGRectMake(268, 825, 58, 21)];
        [pageNumber setFont:[UIFont fontWithName:@"Helvetica" size:8]];
        pageNumber.text = [NSString stringWithFormat:@"Page %i of %@",pageNo+1,totalPages];
        [self.page2 addSubview:pageNumber];
        NSString *pageName = [NSString stringWithFormat:@"temp%i.pdf",pageNo];
        [page_Paths addObject:[self createPDFfromUIView:self.page2 saveToDocumentsWithFileName:pageName]];
        
        CGRect rect = self.page2Footer.frame;
        rect.origin.y = 10;
        self.page2Footer.frame = rect;
        UIView *page3 = [[UIView alloc]initWithFrame:self.view.frame];
        [page3 addSubview:self.page2Footer];
        pageNo = page_Paths.count;
        pageNumber = [[myLable alloc]initWithFrame:CGRectMake(268, 825, 58, 21)];
        [pageNumber setFont:[UIFont fontWithName:@"Helvetica" size:8]];
        pageNumber.text = [NSString stringWithFormat:@"Page %i of %@",pageNo+1,totalPages];
        [page3 addSubview:pageNumber];
        pageName = [NSString stringWithFormat:@"temp%i.pdf",pageNo];
        [page_Paths addObject:[self createPDFfromUIView:page3 saveToDocumentsWithFileName:pageName]];
        
        
    }
    else
    {
        int pageNo = page_Paths.count;
        myLable *pageNumber = [[myLable alloc]initWithFrame:CGRectMake(268, 825, 58, 21)];
        [pageNumber setFont:[UIFont fontWithName:@"Helvetica" size:8]];
        pageNumber.text = [NSString stringWithFormat:@"Page %i of %@",pageNo+1,totalPages];
        [self.page2 addSubview:pageNumber];
        NSString *pageName = [NSString stringWithFormat:@"temp%i.pdf",pageNo];
        [page_Paths addObject:[self createPDFfromUIView:self.page2 saveToDocumentsWithFileName:pageName]];
    }
    
}

-(void)loadOwner:(NSDictionary *)infoDic
{
	
    NSString *title_Name = [NSString stringWithFormat:@"%@ %@",[self getTitleDesc:[infoDic objectForKey:@"Title"]],[infoDic objectForKey:@"Name"]];
    UILabel *lbl = (UILabel *)[self.page2 viewWithTag:tName];
    lbl.text = [title_Name uppercaseString];
    
    lbl =(UILabel *) [self.page2 viewWithTag:tNRIC];
    lbl.text = [infoDic objectForKey:@"NewICNo"];
    
    lbl =(UILabel *) [self.page2 viewWithTag:tNation];
    lbl.text = [sql getNationalityByCode:[infoDic objectForKey:@"Nationality"]];;
    
    lbl =(UILabel *) [self.page2 viewWithTag:tRace];
    lbl.text = [sql getReligionByCode:[infoDic objectForKey:@"Religion"]];
    
    NSString *sex = [infoDic objectForKey:@"Sex"];
    if ([sex hasPrefix:@"F"]) {
        UIView *v = (UIView *)[self.page2 viewWithTag:tSexFemale];
        v.backgroundColor = [UIColor blackColor];
        
    }
    else if ([sex hasPrefix:@"M"])
    {
        UIView *v = (UIView *)[self.page2 viewWithTag:tSexMale];
        v.backgroundColor = [UIColor blackColor];
    }
    NSString *smoker = [infoDic objectForKey:@"Smoker"];
    if ([smoker hasPrefix:@"Y"]) {
        UIView *v = (UIView *)[self.page2 viewWithTag:tSmokerYES];
        v.backgroundColor = [UIColor blackColor];
        
    }
    else if ([smoker hasPrefix:@"N"])
    {
        UIView *v = (UIView *)[self.page2 viewWithTag:tSmokerNO];
        v.backgroundColor = [UIColor blackColor];
    }
        
    lbl =(UILabel *) [self.page2 viewWithTag:tDOB];
    lbl.text = [infoDic objectForKey:@"DOB"];
    
    NSString *birthDate = [infoDic objectForKey:@"DOB"];
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:birthDate]];
    int allDays = (((time/60)/60)/24);
    int days = allDays%365;
    int years = (allDays-days)/365;
//    NSLog(@"You live since %i years and %i days - %i",years,days,allDays);

    NSString *yourAge = [NSString stringWithFormat:@"%d",years];
    
    lbl =(UILabel *) [self.page2 viewWithTag:tAge];
    lbl.text = yourAge;
    
    NSString *marital = [infoDic objectForKey:@"MaritalStatus"];
    if ([marital hasPrefix:@"S"]) {
        UIView *v = (UIView *)[self.page2 viewWithTag:tSingle];
        v.backgroundColor = [UIColor blackColor];
        
    }
    else if ([marital hasPrefix:@"M"])
    {
        UIView *v = (UIView *)[self.page2 viewWithTag:tMArried];
        v.backgroundColor = [UIColor blackColor];
    }
    else if ([marital hasPrefix:@"D"])
    {
        UIView *v = (UIView *)[self.page2 viewWithTag:tDivorced];
        v.backgroundColor = [UIColor blackColor];
    }
    else if ([marital hasPrefix:@"W"] || [marital hasPrefix:@"R"])
    {
        UIView *v = (UIView *)[self.page2 viewWithTag:tWidowed];
        v.backgroundColor = [UIColor blackColor];
    }
    
    lbl =(UILabel *) [self.page2 viewWithTag:tOccupation];
    lbl.text = [sql getOccupationByCode:[infoDic objectForKey:@"Occupation"]];
    
    if ([[[infoDic objectForKey:@"CFFAddresses"]objectForKey:@"CFFAddress"]count]) {
        
        NSDictionary *address = [[[infoDic objectForKey:@"CFFAddresses"]objectForKey:@"CFFAddress"]objectAtIndex:0];
        
        lbl =(UILabel *) [self.page2 viewWithTag:tMailingAddress+1];
        NSString *line1 = [address objectForKey:@"Address1"];
        lbl.text = [line1 uppercaseString];
        
        lbl =(UILabel *) [self.page2 viewWithTag:tMailingAddress+2];
        NSString *line2 = [NSString stringWithFormat:@"%@ %@",[address objectForKey:@"Address2"],[address objectForKey:@"Address3"]];
        if ([line2 hasPrefix:@"(null)"]||[line2 hasSuffix:@"(null)"]) {
            line2 = [line2 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
        }
        lbl.text = [line2 uppercaseString];
        
        lbl =(UILabel *) [self.page2 viewWithTag:tMailingAddress+3];
        NSString *line3 = [NSString stringWithFormat:@"%@ %@",[address objectForKey:@"Town"],[address objectForKey:@"Postcode"]];
            line3 = [line3 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
        lbl.text = [line3 uppercaseString];

        
        lbl =(UILabel *) [self.page2 viewWithTag:tMailingAddress+4];
        NSString *line4 = [NSString stringWithFormat:@"%@ %@",[sql getStateByCode:[address objectForKey:@"State"]], [sql getCountryByCode:[address objectForKey:@"Country"]]];
        line4 = [line4 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
        lbl.text = [line4 uppercaseString];
        
        if ([[[infoDic objectForKey:@"CFFAddresses"]objectForKey:@"CFFAddress"] count]>1) {
            NSDictionary *address = [[[infoDic objectForKey:@"CFFAddresses"]objectForKey:@"CFFAddress"]objectAtIndex:1];
            
            lbl =(UILabel *) [self.page2 viewWithTag:tPermenentAddress+1];
            NSString *line1 = [address objectForKey:@"Address1"];
            line1 = [line1 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            lbl.text = [line1 uppercaseString];
            
            lbl =(UILabel *) [self.page2 viewWithTag:tPermenentAddress+2];
            NSString *line2 = [NSString stringWithFormat:@"%@ %@",[address objectForKey:@"Address2"],[address objectForKey:@"Address3"]];
            if ([line2 hasPrefix:@"(null)"]||[line2 hasSuffix:@"(null)"]) {
                line2 = [line2 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            }
            lbl.text = [line2 uppercaseString];
            
            lbl =(UILabel *) [self.page2 viewWithTag:tPermenentAddress+3];
            NSString *line3 = [NSString stringWithFormat:@"%@ %@",[address objectForKey:@"Town"],[address objectForKey:@"Postcode"]];
            if ([line3 hasPrefix:@"(null)"]||[line3 hasSuffix:@"(null)"]) {
                line3 = [line3 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            }
            lbl.text = [line3 uppercaseString];
            
            lbl =(UILabel *) [self.page2 viewWithTag:tPermenentAddress+4];
            NSString *line4 = [NSString stringWithFormat:@"%@ %@",[sql getStateByCode:[address objectForKey:@"State"]], [sql getCountryByCode:[address objectForKey:@"Country"]]];
            line4 = [line4 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            lbl.text = [line4 uppercaseString];
        }
    }
    
    lbl =(UILabel *) [self.page2 viewWithTag:tHomeNo];
    lbl.text = [infoDic objectForKey:@"ResidencePhoneNo"];
    lbl =(UILabel *) [self.page2 viewWithTag:tWorkNo];
    lbl.text = [infoDic objectForKey:@"OfficePhoneNo"];
    lbl =(UILabel *) [self.page2 viewWithTag:tMobileNo];
    lbl.text = [infoDic objectForKey:@"MobilePhoneNo"];
    lbl =(UILabel *) [self.page2 viewWithTag:tFaxNo];
    lbl.text = [infoDic objectForKey:@"FaxPhoneNo"];
    lbl =(UILabel *) [self.page2 viewWithTag:tEmail];
    lbl.text = [infoDic objectForKey:@"EmailAddress"];
    
    
}
-(void)loadPartner:(NSDictionary *)infoDic
{
    NSString *title_Name = [NSString stringWithFormat:@"%@ %@",[self getTitleDesc:[infoDic objectForKey:@"Title"]],[infoDic objectForKey:@"Name"]];
    UILabel *lbl = (UILabel *)[self.page2Partner viewWithTag:tName];
    lbl.text = [title_Name uppercaseString];
    
    lbl =(UILabel *) [self.page2Partner viewWithTag:tNRIC];
    lbl.text = [infoDic objectForKey:@"NewICNo"];
    
    lbl =(UILabel *) [self.page2Partner viewWithTag:tNation];
    lbl.text = [sql getNationalityByCode:[infoDic objectForKey:@"Nationality"]];
    
    lbl =(UILabel *) [self.page2Partner viewWithTag:tRace];
    lbl.text = [sql getReligionByCode:[infoDic objectForKey:@"Religion"]];
    
    NSString *sex = [infoDic objectForKey:@"Sex"];
    if ([sex hasPrefix:@"F"]) {
        UIView *v = (UIView *)[self.page2Partner viewWithTag:tSexFemale];
        v.backgroundColor = [UIColor blackColor];
        
    }
    else if ([sex hasPrefix:@"M"])
    {
        UIView *v = (UIView *)[self.page2Partner viewWithTag:tSexMale];
        v.backgroundColor = [UIColor blackColor];
    }
    NSString *smoker = [infoDic objectForKey:@"Smoker"];
    if ([smoker hasPrefix:@"Y"]) {
        UIView *v = (UIView *)[self.page2Partner viewWithTag:tSmokerYES];
        v.backgroundColor = [UIColor blackColor];
        
    }
    else if ([smoker hasPrefix:@"N"])
    {
        UIView *v = (UIView *)[self.page2Partner viewWithTag:tSmokerNO];
        v.backgroundColor = [UIColor blackColor];
    }
    
    lbl =(UILabel *) [self.page2Partner viewWithTag:tDOB];
    lbl.text = [infoDic objectForKey:@"DOB"];

    NSString *birthDate = [infoDic objectForKey:@"DOB"];
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:birthDate]];
    int allDays = (((time/60)/60)/24);
    int days = allDays%365;
    int years = (allDays-days)/365;
    
    NSString *yourAge = [NSString stringWithFormat:@"%d",years];
    
    lbl =(UILabel *) [self.page2Partner viewWithTag:tAge];
    lbl.text = yourAge;
    
    NSString *marital = [infoDic objectForKey:@"MaritalStatus"];
    if ([marital hasPrefix:@"S"]) {
        UIView *v = (UIView *)[self.page2Partner viewWithTag:tSingle];
        v.backgroundColor = [UIColor blackColor];
        
    }
    else if ([marital hasPrefix:@"M"])
    {
        UIView *v = (UIView *)[self.page2Partner viewWithTag:tMArried];
        v.backgroundColor = [UIColor blackColor];
    }
    else if ([marital hasPrefix:@"D"])
    {
        UIView *v = (UIView *)[self.page2Partner viewWithTag:tDivorced];
        v.backgroundColor = [UIColor blackColor];
    }
    else if ([marital hasPrefix:@"W"] || [marital hasPrefix:@"R"])
    {
        UIView *v = (UIView *)[self.page2Partner viewWithTag:tWidowed];
        v.backgroundColor = [UIColor blackColor];
    }
    
    lbl =(UILabel *) [self.page2Partner viewWithTag:tOccupation];
    lbl.text = [sql getOccupationByCode:[infoDic objectForKey:@"Occupation"]];
    
    if ([[[infoDic objectForKey:@"CFFAddresses"]objectForKey:@"CFFAddress"]count]) {
        
        NSDictionary *address = [[[infoDic objectForKey:@"CFFAddresses"]objectForKey:@"CFFAddress"]objectAtIndex:0];
        
        lbl =(UILabel *) [self.page2Partner viewWithTag:tMailingAddress+1];
        NSString *line1 = [address objectForKey:@"Address1"];
        line1 = [line1 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
        lbl.text = [line1 uppercaseString];
        
        lbl =(UILabel *) [self.page2Partner viewWithTag:tMailingAddress+2];
        NSString *line2 = [NSString stringWithFormat:@"%@ %@",[address objectForKey:@"Address2"],[address objectForKey:@"Address3"]];
        if ([line2 hasPrefix:@"(null)"]||[line2 hasSuffix:@"(null)"]) {
            line2 = [line2 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
        }
        lbl.text = [line2 uppercaseString];
        
        lbl =(UILabel *) [self.page2Partner viewWithTag:tMailingAddress+3];
        NSString *line3 = [NSString stringWithFormat:@"%@ %@",[address objectForKey:@"Town"],[address objectForKey:@"Postcode"]];
        line3 = [line3 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
        lbl.text = [line3 uppercaseString];
        
        lbl =(UILabel *) [self.page2Partner viewWithTag:tMailingAddress+4];
        NSString *line4 = [NSString stringWithFormat:@"%@ %@",[sql getStateByCode:[address objectForKey:@"State"]], [sql getCountryByCode:[address objectForKey:@"Country"]]];
        line4 = [line4 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
        lbl.text = [line4 uppercaseString];
        
        if ([[[infoDic objectForKey:@"CFFAddresses"]objectForKey:@"CFFAddress"] count]>1) {
            NSDictionary *address = [[[infoDic objectForKey:@"CFFAddresses"]objectForKey:@"CFFAddress"]objectAtIndex:1];
            
            lbl =(UILabel *) [self.page2Partner viewWithTag:tPermenentAddress+1];
            NSString *line1 = [address objectForKey:@"Address1"];
            line1 = [line1 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            lbl.text = [line1 uppercaseString];
            
            lbl =(UILabel *) [self.page2Partner viewWithTag:tPermenentAddress+2];
            NSString *line2 = [NSString stringWithFormat:@"%@ %@",[address objectForKey:@"Address2"],[address objectForKey:@"Address3"]];
            if ([line2 hasPrefix:@"(null)"]||[line2 hasSuffix:@"(null)"]) {
                line2 = [line2 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            }
            lbl.text = [line2 uppercaseString];
            
            lbl =(UILabel *) [self.page2Partner viewWithTag:tPermenentAddress+3];
            NSString *line3 = [NSString stringWithFormat:@"%@ %@",[address objectForKey:@"Town"],[address objectForKey:@"Postcode"]];
            if ([line3 hasPrefix:@"(null)"]||[line3 hasSuffix:@"(null)"]) {
                line3 = [line3 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            }
            lbl.text = [line3 uppercaseString];
            
            lbl =(UILabel *) [self.page2Partner viewWithTag:tPermenentAddress+4];
            NSString *line4 = [NSString stringWithFormat:@"%@ %@",[sql getStateByCode:[address objectForKey:@"State"]], [sql getCountryByCode:[address objectForKey:@"Country"]]];
            line4 = [line4 stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
            lbl.text = [line4 uppercaseString];
        }
    }

    

    lbl =(UILabel *) [self.page2Partner viewWithTag:tHomeNo];
    lbl.text = [infoDic objectForKey:@"ResidencePhoneNo"];
    lbl =(UILabel *) [self.page2Partner viewWithTag:tWorkNo];
    lbl.text = [infoDic objectForKey:@"OfficePhoneNo"];
    lbl =(UILabel *) [self.page2Partner viewWithTag:tMobileNo];
    lbl.text = [infoDic objectForKey:@"MobilePhoneNo"];
    lbl =(UILabel *) [self.page2Partner viewWithTag:tFaxNo];
    lbl.text = [infoDic objectForKey:@"FaxPhoneNo"];
    lbl =(UILabel *) [self.page2Partner viewWithTag:tEmail];
    lbl.text = [infoDic objectForKey:@"EmailAddress"];
}
-(void)loadPage2Footer:(NSDictionary *)infoDic
{
    id q1 = [infoDic objectForKey:@"NeedsQ1_Ans1"];
    id q1Partner = [infoDic objectForKey:@"NeedsQ1_Ans2"];
    id q1Priority =[infoDic objectForKey:@"NeedsQ1_Priority"];
    
    id q2 = [infoDic objectForKey:@"NeedsQ2_Ans1"];
    id q2Partner = [infoDic objectForKey:@"NeedsQ2_Ans2"];
    id q2Priority =[infoDic objectForKey:@"NeedsQ2_Priority"];
    
    id q3 = [infoDic objectForKey:@"NeedsQ3_Ans1"];
    id q3Partner = [infoDic objectForKey:@"NeedsQ3_Ans2"];
    id q3Priority =[infoDic objectForKey:@"NeedsQ3_Priority"];
    
    id q4 = [infoDic objectForKey:@"NeedsQ4_Ans1"];
    id q4Partner = [infoDic objectForKey:@"NeedsQ4_Ans2"];
    id q4Priority =[infoDic objectForKey:@"NeedsQ4_Priority"];
    
    id q5 = [infoDic objectForKey:@"NeedsQ5_Ans1"];
    id q5Partner = [infoDic objectForKey:@"NeedsQ5_Ans2"];
    id q5Priority =[infoDic objectForKey:@"NeedsQ5_Priority"];
    
    //Q1r
    if ([q1 hasPrefix:@"Y"]) {
        UIView *v = (UIView *)[self.page2Footer viewWithTag:tQ1Yes];
        v.backgroundColor = [UIColor blackColor];
    }
    else if ([q1 hasPrefix:@"N"])
    {
        UIView *v = (UIView *)[self.page2Footer viewWithTag:tQ1Yes+1];
        v.backgroundColor = [UIColor blackColor];
    }
    
    if ([q1Partner hasPrefix:@"Y"]) {
        UIView *v = (UIView *)[self.page2Footer viewWithTag:tQ1YESPartner];
        v.backgroundColor = [UIColor blackColor];
    }
    else if ([q1Partner hasPrefix:@"N"]) {
        UIView *v = (UIView *)[self.page2Footer viewWithTag:tQ1YESPartner+1];
        v.backgroundColor = [UIColor blackColor];
    }
    
    //Q2
    if ([q2 hasPrefix:@"Y"]) {
        UIView *v = (UIView *)[self.page2Footer viewWithTag:tQ2Yes];
        v.backgroundColor = [UIColor blackColor];
    }
    else if ([q2 hasPrefix:@"N"]) {
        UIView *v = (UIView *)[self.page2Footer viewWithTag:tQ2Yes+1];
        v.backgroundColor = [UIColor blackColor];
    }
    
    if ([q2Partner hasPrefix:@"Y"]) {
        UIView *v = (UIView *)[self.page2Footer viewWithTag:tQ2YESPartner];
        v.backgroundColor = [UIColor blackColor];
    }
    else if ([q2Partner hasPrefix:@"N"]){
        UIView *v = (UIView *)[self.page2Footer viewWithTag:tQ2YESPartner+1];
        v.backgroundColor = [UIColor blackColor];
    }
    
    //Q3
    if ([q3 hasPrefix:@"Y"]) {
        UIView *v = (UIView *)[self.page2Footer viewWithTag:tQ3Yes];
        v.backgroundColor = [UIColor blackColor];
    }else if ([q3 hasPrefix:@"N"]){
        UIView *v = (UIView *)[self.page2Footer viewWithTag:tQ3Yes+1];
        v.backgroundColor = [UIColor blackColor];
    }
    
    if ([q3Partner hasPrefix:@"Y"]) {
        UIView *v = (UIView *)[self.page2Footer viewWithTag:tQ3YESPartner];
        v.backgroundColor = [UIColor blackColor];
    }else if ([q3Partner hasPrefix:@"N"]){
        UIView *v = (UIView *)[self.page2Footer viewWithTag:tQ3YESPartner+1];
        v.backgroundColor = [UIColor blackColor];
    }

    //Q4
    if ([q4 hasPrefix:@"Y"]) {
        UIView *v = (UIView *)[self.page2Footer viewWithTag:tQ4Yes];
        v.backgroundColor = [UIColor blackColor];
    }else if ([q4 hasPrefix:@"N"]){
        UIView *v = (UIView *)[self.page2Footer viewWithTag:tQ4Yes+1];
        v.backgroundColor = [UIColor blackColor];
    }
    
    if ([q4Partner hasPrefix:@"Y"]) {
        UIView *v = (UIView *)[self.page2Footer viewWithTag:tQ4YESPartner];
        v.backgroundColor = [UIColor blackColor];
    }else if ([q4Partner hasPrefix:@"N"]){
        UIView *v = (UIView *)[self.page2Footer viewWithTag:tQ4YESPartner+1];
        v.backgroundColor = [UIColor blackColor];
    }
    
    //Q5
    if ([q5 hasPrefix:@"Y"]) {
        UIView *v = (UIView *)[self.page2Footer viewWithTag:tQ5Yes];
        v.backgroundColor = [UIColor blackColor];
    }else if ([q5 hasPrefix:@"N"]){
        UIView *v = (UIView *)[self.page2Footer viewWithTag:tQ5Yes+1];
        v.backgroundColor = [UIColor blackColor];
    }
    
    if ([q5Partner hasPrefix:@"Y"]) {
        UIView *v = (UIView *)[self.page2Footer viewWithTag:tQ5YESPartner];
        v.backgroundColor = [UIColor blackColor];
    }else if ([q5Partner hasPrefix:@"N"]){
        UIView *v = (UIView *)[self.page2Footer viewWithTag:tQ5YESPartner+1];
        v.backgroundColor = [UIColor blackColor];
    }
    
    UILabel *lbl = (UILabel *)[self.page2Footer viewWithTag:1001];
    lbl.text = q1Priority;
    if (lbl.text ==nil) {
        lbl.text = @"N/A";
    }
    
    lbl = (UILabel *)[self.page2Footer viewWithTag:1002];
    lbl.text = q2Priority;
    if (lbl.text ==nil) {
        lbl.text = @"N/A";
    }
    
    lbl = (UILabel *)[self.page2Footer viewWithTag:1003];
    lbl.text = q3Priority;
    if (lbl.text ==nil) {
        lbl.text = @"N/A";
    }
    
    lbl = (UILabel *)[self.page2Footer viewWithTag:1004];    
    lbl.text = q4Priority;
    if (lbl.text ==nil) {
        lbl.text = @"N/A";
    }    
    
    lbl = (UILabel *)[self.page2Footer viewWithTag:1005];
    lbl.text = q5Priority;
    if (lbl.text ==nil) {
        lbl.text = @"N/A";
    }
    
    
}

-(NSString*) getTitleDesc : (NSString*)Title
{
	
	
    NSString *desc;
    Title = [Title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	if (Title.length == 0) {
		return @"";
	}
	
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
	NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT TitleDesc FROM eProposal_Title WHERE TitleCode = ?", Title];
    
    NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        desc =[result objectForColumnName:@"TitleDesc"];
    }
	
    [result close];
    [db close];
    
	if (count == 0) {
		if (Title.length > 0) {
			if ([Title isEqualToString:@"- SELECT -"] || [Title isEqualToString:@"- Select -"]) {
				desc = @"";
			}
			else {
				desc = Title;
			}
		}
	}
    return desc;
}
@end
