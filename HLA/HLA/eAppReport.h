//
//  eAppReport.h
//  iMobile Planner
//
//  Created by kuan on 11/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProposalForm.h"
#import "CAform.h"
#import "FFform.h"
#import "SupplementaryProposalform.h"
#import "SupplementaryProposalForm1.h"
//#import "SIform.h"
#import "ApplicationAuthorization.h"
#import "NDHTMLtoPDF.h"
#import "ESignGenerator.h"
#import "eSignController.h"

@class eSignController;


#import "AppDelegate.h"
@interface eAppReport : UIViewController<UITableViewDataSource,UITableViewDelegate,NDHTMLtoPDFDelegate>

{
    
    AppDelegate *appobject;
    NSString *yes;
    UIButton *buttonGenerate;
    UINavigationController* _navC;
}

 
@property (strong, nonatomic) eSignController *signController;
@property (weak, nonatomic) IBOutlet UITableView *reportTable;
 
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) UIButton *buttonGenerate;
@property (nonatomic, retain) ProposalForm *ProposalPDFGenerator;
@property (nonatomic, retain) SupplementaryProposalform *SupplementaryProposalPDFGenerator;
@property (nonatomic, retain) SupplementaryProposalform1 *SupplementaryProposalPDFGenerator1;
//@property (nonatomic, retain) SIform *SIPDFGenerator;
@property (nonatomic, retain) FFform *FFPDFGenerator;

@property (strong, nonatomic) ESignGenerator *eSignGenerator;
@property (strong, nonatomic) eSignController *eSignController;

@property (nonatomic, retain) CAform *CAPDFGenerator;
@property (nonatomic, retain) ApplicationAuthorization *ApplicationAuthorizationPDFGenerator;
@property (nonatomic, strong) NDHTMLtoPDF *PDFCreator;
@property (nonatomic, retain) NSString *getPlanCode;
@property (nonatomic, retain) NSString *getPlanName;

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) NSTimer *myTimer;
@property (nonatomic, strong) UILabel *progressLabel,*Background,*loading;
@property (nonatomic, strong) NSString*yes;
@property (nonatomic, strong) UILabel *proposalNo_display;

- (IBAction)doEAppChecklist:(id)sender;

- (IBAction)doGenerateReport:(id)sender;

-(void)removeGenerateButton;

-(void)initFormListItems;

- (NSDictionary *) populateProposalFormData;
- (NSDictionary *) populateSuppFormData;
- (NSDictionary *) populateSIFormData;
- (NSDictionary *) populateFFFormData;
- (NSDictionary *) populateCAFormData;
- (NSDictionary *) populateApplicationAuthData;

- (NSDictionary *) populateSIXMLData;
- (NSDictionary *) populatePRXMLData;


@end
