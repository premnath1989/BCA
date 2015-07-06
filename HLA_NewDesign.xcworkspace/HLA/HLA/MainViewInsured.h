//
//  MainViewInsured.h
//  iMobile Planner
//
//  Created by kuan on 9/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewInsuredRecord.h"
@interface MainViewInsured : UIViewController
{
    ViewInsuredRecord *viewInsuredRecord;
}
@property (strong, nonatomic) IBOutlet UIView *mainView;
- (IBAction)actionForClose:(id)sender;
@end
