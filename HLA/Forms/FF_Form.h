//
//  FF_Form.h
//  HLA_CA
//
//  Created by Danial D. Moghaddam on 3/13/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLHandler.h"
#import "FMDatabase.h"

@interface FF_Form : UIViewController
{
    NSMutableArray *page_Paths;
    NSString *totalPages;
    SQLHandler *sql;
}
-(NSString *)returnPDFFromDictionary:(NSDictionary *)infoDic proposalNo:(NSString *)proposalNo referenceNo:(NSString *)referenceNo sqliteDBPath:(NSString *)sqliteDBPath ;


@property (strong, nonatomic) IBOutlet UIView *page1;
@property (weak, nonatomic) IBOutlet UIView *page2Footer;
@property (weak, nonatomic) IBOutlet UIView *page2Partner;
@property (strong, nonatomic) IBOutlet UIView *page2;
@property (strong, nonatomic) IBOutlet UIView *page3;
@property (weak, nonatomic) IBOutlet UIView *page3Footer;
@property (strong, nonatomic) IBOutlet UIView *page4;
@property (strong, nonatomic) IBOutlet UIView *page5;
@property (weak, nonatomic) IBOutlet UIView *page5Footer;
@property (strong, nonatomic) IBOutlet UIView *page6;
@property (strong, nonatomic) IBOutlet NSString *eProposalNo;


@end
