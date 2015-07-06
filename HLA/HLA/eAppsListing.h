//
//  eAppsListing.h
//  iMobile Planner
//
//  Created by shawal sapuan on 6/18/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "ProspectListing.h"
#import "FMDatabase.h"
#import "CustomAlertBox.h"
#import "SIDate.h"
@class eAppsListing;

@protocol eAppsListingDelegate <NSObject>
-(void)updateChecklistSI;
@end

@interface eAppsListing : UIViewController <UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate, UIPopoverControllerDelegate, EditProspectDelegate, UIAlertViewDelegate, CustomAlertBoxDelegate, SIDateDelegate> {
    NSString *databasePath;
    sqlite3 *contactDB;
    sqlite3 *DB_eProposalLADetails;
	BOOL isSearching;
    ProspectListing *ProspectListingPage;
	
	//**E
	SIDate *_SIDate;
    UIPopoverController *_SIDatePopover;
    
    NSString *qqflag;
    NSString *str_SIVersion;
    NSString *str_SIStatus;
    NSString *str_Sys_SI_Version;
    
    NSMutableArray *SecPo_LADetails;
    NSMutableDictionary *SecPo_LADetails_Client;
    
    NSDictionary *SecPo_LADetails_ClientNew;
    
    NSMutableArray *SecPo_LADetails_ClientNew_Array;
    
    NSMutableArray *temp_clients_array;
    NSMutableDictionary *temp_clients_dic;
    
    FMDatabase *database2;
    
    BOOL isPY1;
    BOOL isLA2;
    BOOL isLA1;
    BOOL isLA_QQ;
	
	NSString *gPlanName;
	NSString *gPlanCode;
	NSString *gSIType;
	
    
    
}

@property (nonatomic, weak) NSIndexPath *indexPath2;
@property (nonatomic, weak) UITableViewCell *cellSelected;
@property (nonatomic, weak) UILabel *SINumberSelected;
@property (nonatomic, weak) UILabel *SINameSelected;
@property (nonatomic, weak) UILabel *SIPlanSelected;
@property (nonatomic, weak) NSString *IC;
@property (nonatomic, weak) NSString *proposalNo;



@property (nonatomic, retain) EditProspect *EditProspect;
@property (nonatomic, weak) id <eAppsListingDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *SILabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *idTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *idNoLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *planLabel;

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
- (IBAction)ActionClose:(id)sender;
- (IBAction)testDBSearch:(id)sender;
- (IBAction)reset:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *SINOTF;
@property (weak, nonatomic) IBOutlet UITextField *DATETF;
@property (weak, nonatomic) IBOutlet UITextField *IDNOTF;
@property (weak, nonatomic) IBOutlet UITextField *NAMETF;
@property (weak, nonatomic) IBOutlet UITextField *PLANTF;


@property (retain, nonatomic) NSMutableArray *SINO;
@property (retain, nonatomic) NSMutableArray *DateCreated;
@property (retain, nonatomic) NSMutableArray *Name;
@property (retain, nonatomic) NSMutableArray *PlanName;
@property (retain, nonatomic) NSMutableArray *BasicSA;
@property (retain, nonatomic) NSMutableArray *SIStatus;
@property (retain, nonatomic) NSMutableArray *CustomerCode;
@property (retain, nonatomic) NSMutableArray *IdentifactionNo;
@property (retain, nonatomic) NSMutableArray *QQFlag;
@property (retain, nonatomic) NSMutableArray *PPIndexNo;

@property (retain, nonatomic) NSMutableArray *SIVersion_Check;
@property (retain, nonatomic) NSMutableArray *SIStatus_Check;
 

@property (retain, nonatomic) NSMutableArray *SINOSearch;
@property (retain, nonatomic) NSMutableArray *NameSearch;
@property (retain, nonatomic) NSMutableArray *PlanNameSearch;
@property (retain, nonatomic) NSMutableArray *DateCreatedSearch;
@property (retain, nonatomic) NSMutableArray *IdentificationNoSearch;

@property (retain, nonatomic) UIDatePicker *itsDatePicker;
@property (retain, nonatomic) UIBarButtonItem *itsRightBarButton;
@property (strong, nonatomic) UIPopoverController *popoverController;

@property (strong, nonatomic) IBOutlet UIView *popView;

//**E
@property (nonatomic, retain) SIDate *SIDate;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;
@property (nonatomic, copy) NSString *DBDateSearch;

- (IBAction)btnDateSearch:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletDateSearch;

-(NSString *) GetPlanData: (int)searchType :(NSString *)strValue;
-(NSString *) GetPlanData2: (int)searchType :(NSString *)strValue passdb:(FMDatabase*)database;




@end
