//
//  MainQViewController.h
//  iMobile Planner
//
//  Created by Juliana on 7/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagObject.h"
#import "HealthQuestionnaire.h"
#import "HealthQuestionnaire2.h"
#import "HealthQuestionnaire3.h"
#import "HealthQuestionnaire4.h"
#import "HealthQuestionnaire5.h"
#import "HealthQuestionnaire6.h"
#import "HealthQuestionnaire7.h"
#import "HealthQuestionnaire7b.h"
#import "HealthQuestionnaire7c.h"
#import "HealthQuestionnaire7d.h"
#import "HealthQuestionnaire7e.h"
#import "HealthQuestionnaire7f.h"
#import "HealthQuestionnaire7g.h"
#import "HealthQuestionnaire7h.h"
#import "HealthQuestionnaire7i.h"
#import "HealthQuestionnaire7j.h"
#import "HealthQuestionnaire8.h"
#import "HealthQuestionnaire8b.h"
#import "HealthQuestionnaire8c.h"
#import "HealthQuestionnaire8d.h"
#import "HealthQuestionnaire8e.h"
#import "HealthQuestionnaire9.h"
#import "HealthQuestionnaire10.h"
#import "HealthQuestionnaire11.h"
#import "HealthQuestionnaire12.h"
#import "HealthQuestionnaire13.h"
#import "HealthQuestionnaire14.h"
#import "HealthQuestionnaire14b.h"
#import "HealthQuestionnaire15.h"
#import "DataClass.h"

@interface MainQViewController : UIViewController <UIGestureRecognizerDelegate, UIAlertViewDelegate>{
	int value;
	TagObject *tomq1;
	HealthQuestionnaire *h1;
	HealthQuestionnaire2 *h2;
	HealthQuestionnaire3 *h3;
    HealthQuestionnaire4 *h4;
	HealthQuestionnaire5 *h5;
	HealthQuestionnaire6 *h6;
	HealthQuestionnaire7 *h7;
	HealthQuestionnaire7b *h7b;
	HealthQuestionnaire7c *h7c;
	HealthQuestionnaire7d *h7d;
	HealthQuestionnaire7e *h7e;
	HealthQuestionnaire7f *h7f;
	HealthQuestionnaire7g *h7g;
	HealthQuestionnaire7h *h7h;
	HealthQuestionnaire7i *h7i;
	HealthQuestionnaire7j *h7j;
	HealthQuestionnaire8 *h8;
	HealthQuestionnaire8b *h8b;
	HealthQuestionnaire8c *h8c;
	HealthQuestionnaire8d *h8d;
	HealthQuestionnaire8e *h8e;
	HealthQuestionnaire9 *h9;
	HealthQuestionnaire10 *h10;
	HealthQuestionnaire11 *h11;
	HealthQuestionnaire12 *h12;
	HealthQuestionnaire13 *h13;
	HealthQuestionnaire14 *h14;
	HealthQuestionnaire14b *h14b;
	HealthQuestionnaire15 *h15;

	DataClass *obj;
}

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIView *h2View;
@property (strong, nonatomic) IBOutlet UIView *h3View;
@property (strong, nonatomic) IBOutlet UIView *h4view;
@property (strong, nonatomic) IBOutlet UIView *h5View;
@property (strong, nonatomic) IBOutlet UIView *h6View;
@property (strong, nonatomic) IBOutlet UIView *h7View;
@property (strong, nonatomic) IBOutlet UIView *h7bView;
@property (strong, nonatomic) IBOutlet UIView *h7cView;
@property (strong, nonatomic) IBOutlet UIView *h7dView;
@property (strong, nonatomic) IBOutlet UIView *h7eView;
@property (strong, nonatomic) IBOutlet UIView *h7fView;
@property (strong, nonatomic) IBOutlet UIView *h7gView;
@property (strong, nonatomic) IBOutlet UIView *h7hView;
@property (strong, nonatomic) IBOutlet UIView *h7iView;
@property (strong, nonatomic) IBOutlet UIView *h7jView;
@property (strong, nonatomic) IBOutlet UIView *h8View;
@property (strong, nonatomic) IBOutlet UIView *h8bView;
@property (strong, nonatomic) IBOutlet UIView *h8cView;
@property (strong, nonatomic) IBOutlet UIView *h8dView;
@property (strong, nonatomic) IBOutlet UIView *h8eView;
@property (strong, nonatomic) IBOutlet UIView *h9View;
@property (strong, nonatomic) IBOutlet UIView *h10View;
@property (strong, nonatomic) IBOutlet UIView *h11View;
@property (strong, nonatomic) IBOutlet UIView *h12View;
@property (strong, nonatomic) IBOutlet UIView *h13View;
@property (strong, nonatomic) IBOutlet UIView *h14View;
@property (strong, nonatomic) IBOutlet UIView *h14bView;
@property (weak, nonatomic) NSString *textValue;
@property (weak, nonatomic) NSString *LAType;
- (IBAction)selectDone:(id)sender;
- (IBAction)actionForCancel:(id)sender;

@end
