//
//  Summary.h
//  iMobile Planner
//
//  Created by Erza on 6/18/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

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

@end
