//
//  HealthQuestions1stLA.h
//  iMobile Planner
//
//  Created by Erza on 11/15/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagObject.h"

@interface HealthQuestions1stLA : UITableViewController<UITextFieldDelegate, UIGestureRecognizerDelegate> {
    BOOL checked;
    TagObject *to;
}

@property (strong, nonatomic) IBOutlet UITextField *txtHeight;
@property (strong, nonatomic) IBOutlet UITextField *txtWeight;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ1B;
//@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ2;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ3;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ4;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ5;
//@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ6;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ7A;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ7B;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ7C;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ7D;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ7E;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ7F;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ7G;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ7H;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ7I;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ7J;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ8A;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ8B;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ8C;
//@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ8D;
//@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ8E;
//@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ9;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ10;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ11;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ12;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ13;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ14A;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ14B;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segQ15;
@property (assign) int tag;


@property (strong, nonatomic) IBOutlet UIButton *yes1b;
@property (strong, nonatomic) IBOutlet UIButton *yes2;
@property (strong, nonatomic) IBOutlet UIButton *yes3;
@property (strong, nonatomic) IBOutlet UIButton *yes4;
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
@property (strong, nonatomic) IBOutlet UIButton *yes15;


- (IBAction)actionForViewYes:(id)sender;
- (IBAction)segmentPress:(id)sender;
@end
