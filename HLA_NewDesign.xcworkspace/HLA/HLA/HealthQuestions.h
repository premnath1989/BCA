//
//  HealthQuestions.h
//  iMobile Planner
//
//  Created by shawal sapuan on 7/10/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagObject.h"
#import "HealthQuestPersonType.h"

@protocol HealthQuestionsProtocol<NSObject>

-(void)testMyProtocolMethod:(int)tagValue;

@end

@interface HealthQuestions : UITableViewController<HealthQuestPersonTypeDelegate> {
    BOOL checked;
//	int tag;
	TagObject *to;
    
    HealthQuestPersonType *_RelationshipVC;
    
    UIPopoverController *_RelationshipPopover;
}

@property (nonatomic, strong) HealthQuestPersonType *RelationshipVC;
@property (nonatomic, retain) UIPopoverController *RelationshipPopover;
@property (strong, nonatomic) IBOutlet UIButton *btnCheck;
@property (strong, nonatomic) IBOutlet UITextField *txtHeight;
@property (strong, nonatomic) IBOutlet UITextField *txtWeight;
@property (strong, nonatomic) IBOutlet UILabel *PersonTypeLb;;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ1B;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ2;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ3;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ4;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ5;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ6;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ7A;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ7B;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ7C;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ7D;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ7E;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ7F;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ7G;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ7H;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ7I;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ7J;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ8A;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ8B;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ8C;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ8D;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ8E;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ9;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ10;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ11;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ12;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ13;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ14A;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ14B;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segQ15;
@property (assign) int tag;

@property (nonatomic , assign) id <HealthQuestionsProtocol> delegate;
@property (strong, nonatomic) IBOutlet UIButton *yes1b;
@property (strong, nonatomic) IBOutlet UIButton *yes2;
@property (strong, nonatomic) IBOutlet UIButton *yes3;
@property (strong, nonatomic) IBOutlet UIButton *yes5;
@property (strong, nonatomic) IBOutlet UIButton *yes6;
@property (strong, nonatomic) IBOutlet UIButton *yes7a;
@property (strong, nonatomic) IBOutlet UIButton *yes7b;
@property (strong, nonatomic) IBOutlet UIButton *yes7c;
@property (strong, nonatomic) IBOutlet UIButton *yes7d;
@property (strong, nonatomic) IBOutlet UIButton *yes7e;
@property (strong, nonatomic) IBOutlet UIButton *yes7f;
@property (strong, nonatomic) IBOutlet UIButton *yes7g;
@property (strong, nonatomic) IBOutlet UIButton *yes7h;
@property (strong, nonatomic) IBOutlet UIButton *yes7i;
@property (strong, nonatomic) IBOutlet UIButton *yes7j;
@property (strong, nonatomic) IBOutlet UIButton *yes8i;
@property (strong, nonatomic) IBOutlet UIButton *yes8ii;
@property (strong, nonatomic) IBOutlet UIButton *yes8iii;
@property (strong, nonatomic) IBOutlet UIButton *yes8iv;
@property (strong, nonatomic) IBOutlet UIButton *yes8v;
@property (strong, nonatomic) IBOutlet UIButton *yes9;
@property (strong, nonatomic) IBOutlet UIButton *yes10;
@property (strong, nonatomic) IBOutlet UIButton *yes11;
@property (strong, nonatomic) IBOutlet UIButton *yes12;
@property (strong, nonatomic) IBOutlet UIButton *yes13;
@property (strong, nonatomic) IBOutlet UIButton *yes14a;
@property (strong, nonatomic) IBOutlet UIButton *yes14b;

- (IBAction)isAllNo:(id)sender;
- (IBAction)segmentPress:(id)sender;
- (IBAction)actionForViewYes:(id)sender;
- (IBAction)actionForPersonType:(id)sender;





@end
