//
//  CA_Form.m
//  HLA_CA
//
//  Created by Danial D. Moghaddam on 3/11/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//

#import "CA_Form.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
#import "myLable.h"
#import "PRHtmlHandler.h"
#import "TBXML+NSDictionary.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

@interface CA_Form ()
{
    NSMutableArray *insuredArr;
}
@end

@implementation CA_Form
#define tRefNo         101
#define tPolicyNo      102
#define tInsuredName   103
#define tIntermediaryName 104
#define tChoice6Desc      105
#define tDateLbl          106
#define tIndetmediaryIC   107



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
-(NSString *)returnPDFFromDictionary:(NSDictionary *)infoDic proposalNo:(NSString *)proposalNo referenceNo:(NSString *)referenceNo 
{

    [self creatCheckBoxes];
    
    NSString *insuredName;
    NSString *insuredName1;
    NSString *IntermediaryName;
    
//    UILabel *policyLbl = (UILabel *) [self.view viewWithTag:tPolicyNo];
//    policyLbl.text = proposalNo;
//    policyLbl.textAlignment = NSTextAlignmentCenter;
//    policyLbl.layer.borderColor = [UIColor blackColor].CGColor;
//    policyLbl.layer.borderWidth = 0.3;
    
    UILabel *refLbl = (UILabel *) [self.view viewWithTag:tRefNo];
    refLbl.text = referenceNo;
//    refLbl.textAlignment = NSTextAlignmentCenter;
//    refLbl.layer.borderColor = [UIColor blackColor].CGColor;
//    refLbl.layer.borderWidth = 0.3;

    
    NSArray *cffParties;
    if ([[[infoDic objectForKey:@"PersonalInfo"]objectForKey:@"CFFParty"]isKindOfClass:[NSDictionary class]]) {
        cffParties = [[NSArray alloc]initWithObjects:[[infoDic objectForKey:@"PersonalInfo"]objectForKey:@"CFFParty"], nil];

    }
    else
    {
        cffParties = [[NSArray alloc]initWithArray:[[infoDic objectForKey:@"PersonalInfo"]objectForKey:@"CFFParty"]];
    }
    
    //NSLog(@"$$$$$  %@   $$$$$",[[[infoDic objectForKey:@"PersonalInfo"] objectForKey:@"CFFParty"] objectForKey:@"Name"]);
    //Basvi fixes for Bug 3534
    //if ([[infoDic objectForKey:@"PersonalInfo"] objectForKey:@"Name"])
//    insuredName = [[cffParties objectAtIndex:0]objectForKey:@"Name"];
//    if( [[[infoDic objectForKey:@"PersonalInfo"]objectForKey:@"CFFParty"] objectForKey:@"Name"])
//    {
    
    //To get the customer name...
        insuredName = [[cffParties objectAtIndex:0]objectForKey:@"Name"];
    //insuredName1 = [[[infoDic objectForKey:@"PersonalInfo"]objectForKey:@"CFFParty"] objectForKey:@"Name"];
      _name.text=insuredName;
//        insuredName = [[[[infoDic objectForKey:@"PersonalInfo"]objectForKey:@"CFFParty"] objectForKey:@"Name"] objectAtIndex:1];
//     insuredName = [[[infoDic objectForKey:@"PersonalInfo"]objectForKey:@"CFFParty"] objectForKey:@"Name"];
        for (UIView *view in self.view.subviews) {
            if (view.tag==tInsuredName) {
                UILabel *lbl = (UILabel *)view;
                lbl.text = insuredName;
            }
        }
//    }
    
    if ([[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryName"]) {
        IntermediaryName = [[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryName"];
        for (UIView *view in self.view.subviews) {
            if (view.tag==tIntermediaryName) {
                UILabel *lbl = (UILabel *)view;
                lbl.text = IntermediaryName;
            }
        }
        UILabel *lbl = (UILabel *) [self.tableFooter viewWithTag:tIntermediaryName];
        lbl.text = IntermediaryName;

    }
    
    if ([[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryNRIC"]) {
        UILabel *lbl = (UILabel *)[self.view viewWithTag:tIndetmediaryIC];
        lbl.text = [[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryNRIC"];
    }
//    if ([[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryContractDate"]) {
//        UILabel *lbl = (UILabel *)[self.view viewWithTag:tDateLbl];
//        lbl.text = [[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryContractDate"];
//    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *currentdate = [dateFormatter stringFromDate:[NSDate date]];
    UILabel *lbl = (UILabel *)[self.view viewWithTag:tDateLbl];
    lbl.text = currentdate;
    
    id obj = [infoDic objectForKey:@"ConfirmationOfAdviceGivenTo"];
    NSArray*keys=[obj allKeys];
    for (NSString *key in keys) {
        if ([key isEqualToString:@"Choice6_desc"]) {
            UILabel *lbl = (UILabel *)[self.view viewWithTag:tChoice6Desc];
            lbl.text = [obj objectForKey:key];
        }
        if ([key isEqualToString:@"Choice1"]) {
            if ([[obj objectForKey:key]isEqualToString:@"TRUE"]) {
                UIView *view = (UIView *)[self.view viewWithTag:1000];
                view.backgroundColor=[UIColor blackColor];
            }
        }
        if ([key isEqualToString:@"Choice2"]) {
            if ([[obj objectForKey:key]isEqualToString:@"TRUE"]) {
                UIView *view = (UIView *)[self.view viewWithTag:1001];
                view.backgroundColor=[UIColor blackColor];
            }
        }
        if ([key isEqualToString:@"Choice3"]) {
            if ([[obj objectForKey:key]isEqualToString:@"TRUE"]) {
                UIView *view = (UIView *)[self.view viewWithTag:1002];
                view.backgroundColor=[UIColor blackColor];
            }
        }
        if ([key isEqualToString:@"Choice4"]) {
            if ([[obj objectForKey:key]isEqualToString:@"TRUE"]) {
                UIView *view = (UIView *)[self.view viewWithTag:1003];
                view.backgroundColor=[UIColor blackColor];
            }
        }
        if ([key isEqualToString:@"Choice5"]) {
            if ([[obj objectForKey:key]isEqualToString:@"TRUE"]) {
                UIView *view = (UIView *)[self.view viewWithTag:1004];
                view.backgroundColor=[UIColor blackColor];
            }
        }
        if ([key isEqualToString:@"Choice6"]) {
            if ([[obj objectForKey:key]isEqualToString:@"TRUE"]) {
                UIView *view = (UIView *)[self.view viewWithTag:1005];
                view.backgroundColor=[UIColor blackColor];
            }
        }
    }
    
    insuredArr =[[NSMutableArray alloc]init];
    NSArray *recInfo;
    if ([[[infoDic objectForKey:@"ProductRecommended"]objectForKey:@"RecommendationInfo"]isKindOfClass:[NSDictionary class]]) {
        recInfo = [[NSArray alloc]initWithObjects:[[infoDic objectForKey:@"ProductRecommended"]objectForKey:@"RecommendationInfo"], nil];
        
    }
    else
    {
        recInfo = [[NSArray alloc]initWithArray:[[infoDic objectForKey:@"ProductRecommended"]objectForKey:@"RecommendationInfo"]];
    }
    
    if ([recInfo count]) {
        insuredArr = [recInfo mutableCopy];
        [self loadUpTable];
    }
    [self.view setNeedsDisplay];

    return [self createPDFfromUIView:self.view saveToDocumentsWithFileName:[NSString stringWithFormat:@"%@_CA.pdf",referenceNo]];
}
-(void)creatCheckBoxes
{
    for (UIView *v in self.view.subviews) {
        if (v.tag==100) {
            [v setBackgroundColor:[UIColor clearColor]];
            v.layer.borderColor = [UIColor blackColor].CGColor;
            v.layer.borderWidth=0.7f;
        }
        if (v.tag>=1000) {
            [v setBackgroundColor:[UIColor whiteColor]];
            v.layer.borderColor = [UIColor blackColor].CGColor;
            v.layer.borderWidth=0.5f;
        }
    }

}
-(void)loadUpTable
{
    [self.RiderTableView reloadData];
    
    
    [self.RiderTableView layoutIfNeeded];
    CGRect tableFrame = self.RiderTableView.frame;
    tableFrame.size.height = self.RiderTableView.contentSize.height;
    tableFrame.size.width = self.RiderTableView.contentSize.width; // if you would allow horiz scrolling
    self.RiderTableView.frame = tableFrame;
    CGRect footerFrame  = self.tableFooter.frame;
    footerFrame.origin.y = tableFrame.origin.y + tableFrame.size.height + 10;
    self.tableFooter.frame = footerFrame;

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.RiderTableView.layer.borderColor = [UIColor blackColor].CGColor;
    self.RiderTableView.layer.borderWidth = 0.7f;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Create PDF
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    BOOL isPDF = !CGRectIsEmpty(UIGraphicsGetPDFContextBounds());
    if (!layer.shouldRasterize && isPDF)
        [self.view drawRect:self.view.bounds]; // draw unrasterized
    else
        [super drawLayer:layer inContext:ctx];
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
#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return insuredArr.count+1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 55;
    }
    else
    {
        //id obj = [[insuredArr[0]objectForKey:@"AdditionalBenefits"]objectForKey:@"Rider"];
        NSString *infoText = [self returnAdditionalInfoText:[[insuredArr[indexPath.row-1]objectForKey:@"AdditionalBenefits"]objectForKey:@"RecommendedRider"]];
        
        if ([self heightOfCellWithIngredientLine:infoText withSuperviewWidth:85]>20) {
            return [self heightOfCellWithIngredientLine:infoText withSuperviewWidth:85]+10;
        }
        else
        {
        return 20;
    
        }
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row==0) {
//        UIImageView *imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 55)];
//        [imgView2 setImage:[UIImage imageNamed:@"Header.jpg"]];
//        [cell addSubview:imgView2];
        
    }
    else
    {

        NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
        [fmt setMaximumFractionDigits:2];
        [fmt setPositiveFormat:@"#,##0.00"];
        
//        UIImageView *imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 55)];
//        [imgView1 setImage:[UIImage imageNamed:@"Header.jpg"]];
//        [cell addSubview:imgView1];
        
        float imageHeight;
        NSString *infoText = [self returnAdditionalInfoText:[[insuredArr[indexPath.row-1]objectForKey:@"AdditionalBenefits"]objectForKey:@"RecommendedRider"]];
        
        if ([self heightOfCellWithIngredientLine:infoText withSuperviewWidth:85]>20) {
            imageHeight= [self heightOfCellWithIngredientLine:infoText withSuperviewWidth:85]+10;
        }
        else
        {
            imageHeight= 20;
            
        }
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,  imageHeight)];
        [imgView setImage:[UIImage imageNamed:@"Row.png"]];
        [cell addSubview:imgView];
        
        myLable *nameLbl = [[myLable alloc]initWithFrame:CGRectMake(5, 1, 115, 15)];
        
        [nameLbl setFont:[UIFont fontWithName:@"Helvetica" size:7]];
        nameLbl.text=[insuredArr[indexPath.row-1]objectForKey:@"InsuredName"];
        nameLbl.numberOfLines = 2;
        [nameLbl sizeToFit];
        [cell addSubview:nameLbl];
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsPath = [paths objectAtIndex:0];
        NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
        FMDatabase *database = [FMDatabase databaseWithPath:path];
        [database open];

        myLable *productLbl = [[myLable alloc]initWithFrame:CGRectMake(125, 1, 65, 15)];
        [productLbl setFont:[UIFont fontWithName:@"Helvetica" size:7]];
//        productLbl.text=[insuredArr[indexPath.row-1]objectForKey:@"PlanType"];
        FMResultSet *getPlanResult = [database executeQuery:@"select * from Trad_Sys_Profile where PlanCode = ?",[insuredArr[indexPath.row-1]objectForKey:@"PlanType"]];
        while ([getPlanResult next]) {
            productLbl.text=[getPlanResult objectForColumnName:@"PlanName"];
        }
        if (productLbl.text ==nil) {
            productLbl.text=[insuredArr[indexPath.row-1]objectForKey:@"PlanType"];
        }
        productLbl.numberOfLines=2;
        [productLbl sizeToFit];        
        [cell addSubview:productLbl];
        
        myLable *termLbl = [[myLable alloc]initWithFrame:CGRectMake(200, -2, 25, 15)];
        [termLbl setFont:[UIFont fontWithName:@"Helvetica" size:7]];
        termLbl.text=[insuredArr[indexPath.row-1]objectForKey:@"Term"];
        [termLbl setTextAlignment:UITextAlignmentCenter];
        [cell addSubview:termLbl];
        
        NSString *frequency = [insuredArr[indexPath.row-1]objectForKey:@"Frequency"];
        if ([frequency isEqualToString:@"12"]) {
            frequency = @"ANNUAL";
        }else if ([frequency isEqualToString:@"06"]){
            frequency = @"SEMI ANNUAL";            
        }else if ([frequency isEqualToString:@"03"]){
            frequency = @"QUARTERLY";
        }else if ([frequency isEqualToString:@"01"]){
            frequency = @"MONTHLY";
        }
            
        myLable *premiumLbl = [[myLable alloc]initWithFrame:CGRectMake(230, -2, 95, 15)];
        [premiumLbl setFont:[UIFont fontWithName:@"Helvetica" size:7]];
        premiumLbl.text = [NSString stringWithFormat:@"%@ / %@",[fmt stringFromNumber:[fmt numberFromString:[insuredArr[indexPath.row-1]objectForKey:@"Premium"]]],frequency];
//        [premiumLbl setTextAlignment:UITextAlignmentRight];
        [cell addSubview:premiumLbl];
        
        myLable *sumLbl = [[myLable alloc]initWithFrame:CGRectMake(330, -2, 55, 15)];
        [sumLbl setFont:[UIFont fontWithName:@"Helvetica" size:7]];
        sumLbl.text = [fmt stringFromNumber:[fmt numberFromString:[insuredArr[indexPath.row-1]objectForKey:@"SA"]]];
        [sumLbl setTextAlignment:UITextAlignmentRight];
        [cell addSubview:sumLbl];
        
        myLable *additionalLbl = [[myLable alloc]initWithFrame:CGRectMake(390, 1, 85, [self heightOfCellWithIngredientLine:infoText withSuperviewWidth:85])];
//        myLable *additionalLbl = [[myLable alloc]initWithFrame:CGRectMake(390, 5, 85, additionalBenefits_height)];
        [additionalLbl setFont:[UIFont fontWithName:@"Helvetica" size:7]];
        additionalLbl.text=infoText;
        additionalLbl.numberOfLines = 0;
        [additionalLbl sizeToFit];
        [cell addSubview:additionalLbl];
        
        
        myLable *BoughtLbl = [[myLable alloc]initWithFrame:CGRectMake(503, -2, 40, 15)];
        
        [BoughtLbl setFont:[UIFont fontWithName:@"Helvetica" size:7]];
        BoughtLbl.text=[insuredArr[indexPath.row-1]objectForKey:@"BoughtOpt"];
        [cell addSubview:BoughtLbl];

    }
    return cell;
}
-(CGFloat)heightOfCellWithIngredientLine:(NSString *)ingredientLine
                       withSuperviewWidth:(CGFloat)superviewWidth
{

    CGSize size = CGSizeMake(85, FLT_MAX);
    CGSize labelHeight = [ingredientLine sizeWithFont:[UIFont fontWithName:@"Helvetica" size:7] constrainedToSize:size lineBreakMode:NSLineBreakByTruncatingTail];
    return labelHeight.height;
    

}
-(NSString *)returnAdditionalInfoText:(id)object
{
    
    NSString *additional;
    if ([object isKindOfClass:[NSArray class]]) {
        additional = [[object valueForKey:@"RiderName"] componentsJoinedByString:@", "];
    }
    else
    {
        additional = [object objectForKey:@"RiderName"];
        
    }

    return additional;
}
@end
