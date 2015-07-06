//
//  Summary.h
//  iMobile Planner
//
//  Created by Erza on 6/18/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolicyDetails.h"

@protocol SummaryDelegate
-(void)selectedMenu:(NSString*)menu;
@end

@interface Summary : UITableViewController {
    id <SummaryDelegate> _delegate;
    
   
}

@property (nonatomic,strong) id <SummaryDelegate> delegate;
- (IBAction)confirmBtn:(id)sender;


@property (strong, nonatomic) IBOutlet UILabel *tickPersonalDetails;
@property (strong, nonatomic) IBOutlet UILabel *tickPolicyDetails;
@property (strong, nonatomic) IBOutlet UILabel *tickNominees;
@property (strong, nonatomic) IBOutlet UILabel *tickeCFF;
@property (strong, nonatomic) IBOutlet UILabel *tickHealthQuestions;
@property (strong, nonatomic) IBOutlet UILabel *tickAdditionalQuestions;
@property (strong, nonatomic) IBOutlet UILabel *tickDeclaration;


@property (strong, nonatomic) IBOutlet UILabel *tickEverCareForm;
@property (strong, nonatomic) IBOutlet UILabel *tickCCOTPForm;
@property (strong, nonatomic) IBOutlet UILabel *tickSpecialLienForm;
@property (strong, nonatomic) IBOutlet UILabel *tickECFFForm;
@property (strong, nonatomic) IBOutlet UILabel *tickEPP;
@property (strong, nonatomic) IBOutlet UILabel *TickGST;
@property (nonatomic, strong) UILabel *tableHeader;
@property (nonatomic, strong) UILabel *tableHeaderCheckMark;


@end
