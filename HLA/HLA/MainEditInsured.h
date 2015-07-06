//
//  MainEditInsured.h
//  iMobile Planner
//
//  Created by kuan on 9/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InsuredDetail.h"

@interface MainEditInsured : UIViewController<UIGestureRecognizerDelegate>

{
    InsuredDetail *insuredDetail;
    
}

@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) NSIndexPath *record;
- (IBAction)actionForClose:(id)sender;
- (IBAction)saveInsured:(id)sender;
- (void) setRow:(int)row;
@end
