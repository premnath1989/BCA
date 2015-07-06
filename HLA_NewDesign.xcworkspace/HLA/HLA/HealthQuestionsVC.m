//
//  HealthQuestionsVC.m
//  iMobile Planner
//
//  Created by Erza on 11/15/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "HealthQuestionsVC.h"

@interface HealthQuestionsVC ()

@end

@implementation HealthQuestionsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMySubview:nil];
    [self setPersonTypeLbl:nil];
    [super viewDidUnload];
}
- (IBAction)actionForPersonType:(id)sender {
    if (_RelationshipVC == nil) {
        
        self.RelationshipVC = [[HealthQuestPersonType alloc] initWithStyle:UITableViewStylePlain];
        _RelationshipVC.delegate = self;
        _RelationshipVC.requestType = @"LA";
        self.RelationshipPopover = [[UIPopoverController alloc] initWithContentViewController:_RelationshipVC];
    }
    [self.RelationshipPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)selectedPersonType:(NSString *)thePersonType
{
    
    _personTypeLbl.text = thePersonType;
	_personTypeLbl.textColor = [UIColor blackColor];
    
    UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
    if ([thePersonType hasPrefix:@"1st"]) {
        
        BOOL doesContain = [self.mySubview.subviews containsObject:self.hq1stLA.view];
        if (!doesContain) {
            self.hq1stLA = [nextStoryboard instantiateViewControllerWithIdentifier:@"HQ1stLA"];
            [self addChildViewController:self.hq1stLA];
            [self.mySubview addSubview:self.hq1stLA.view];
        }
    }
    else if ([thePersonType hasPrefix:@"2nd"]) {
        BOOL doesContain = [self.mySubview.subviews containsObject:self.hq2ndLA.view];
        if (!doesContain) {
            self.hq2ndLA = [nextStoryboard instantiateViewControllerWithIdentifier:@"HQ2ndLA"];
            [self addChildViewController:self.hq2ndLA];
            [self.mySubview addSubview:self.hq2ndLA.view];
        }
    }
    else {
        BOOL doesContain = [self.mySubview.subviews containsObject:self.hqPo.view];
        if (!doesContain) {
            self.hqPo = [nextStoryboard instantiateViewControllerWithIdentifier:@"HQPo"];
            [self addChildViewController:self.hqPo];
            [self.mySubview addSubview:self.hqPo.view];
        }
    }
    
    [self.RelationshipPopover dismissPopoverAnimated:YES];
    
}
@end
