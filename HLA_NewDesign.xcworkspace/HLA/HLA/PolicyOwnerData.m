//
//  PolicyOwnerData.m
//  iMobile Planner
//
//  Created by Meng Cheong on 10/1/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "PolicyOwnerData.h"

@interface PolicyOwnerData ()

@end

@implementation PolicyOwnerData
@synthesize PolicyOwnerDataDetailsVC,titleLabel;

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
    
    NSLog(@"PolicyOwnerData.....");
	// Do any additional setup after loading the view.
    
    /* UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"MengCheong_Storyboard_eApp" bundle:nil];
     
     
     BOOL doesContain = [self.myView.subviews containsObject:self.PolicyOwnerDataDetailsVC.view];
     if (!doesContain){
     self.PolicyOwnerDataDetailsVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"PolicyOwnerDataDetails"];
     //self.ExistingSavingsPlansVC.rowToUpdate = self.rowToUpdate;
     [self addChildViewController:self.PolicyOwnerDataDetailsVC];
     [self.myView addSubview:self.PolicyOwnerDataDetailsVC.view];
     }
     */
    
    UINavigationItem *item = [[UINavigationItem alloc] init];
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStyleDone target:self action:@selector(doDelete:)];
    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(doSave:)];
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(doCancel:)];
    NSArray *myButtonArray = [[NSArray alloc] initWithObjects:saveBtn,deleteButton, nil];
    
    //FIX Bug 2605
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:nil];
    if ([[self.LADetails objectForKey:@"PTypeCode"] isEqualToString:@"PO"]) {
        item.rightBarButtonItems = myButtonArray;
    }
    else {
        item.rightBarButtonItem = saveBtn;
    }
    item.leftBarButtonItem = cancelBtn;
    [_myBar pushNavigationItem:item animated:NO];
    
    
    
    BOOL doesContain = [self.myView.subviews containsObject:self.PolicyOwnerDataDetailsVC.view];
    if (!doesContain){
        self.PolicyOwnerDataDetailsVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"SubDetails"];
        //self.ExistingSavingsPlansVC.rowToUpdate = self.rowToUpdate;
        [self addChildViewController:self.PolicyOwnerDataDetailsVC];
    }
    SubDetails *details = [self.childViewControllers objectAtIndex:0];
    details.LADetails = self.LADetails;
    details.delegate = self;
    [self.myView addSubview:self.PolicyOwnerDataDetailsVC.view];
    
}

 //1. SubDetails(protocol) -> PolicyOwnerData (pass ptype)
 //2. PolicyOwnerData(protocol)  -> PolicyOwner (pass ptype)
-(void)updatePOLabel:(NSString *)potype
{
    
    NSLog(@"Policy Owner - updatePOLabel - %@",potype);
    
    
     [self.delegate updatePO]; //PASS VALUE TO PolicyOwner
    
    
 
  /*  if([potype isEqualToString:@"LA1"])
        po1.hidden = FALSE;
    else if([potype isEqualToString:@"LA2"])
        po2.hidden = FALSE;
    else if([potype isEqualToString:@"PY1"])
        po3.hidden = FALSE;
    else if([potype isEqualToString:@"PO"])
        po4.hidden = FALSE;
   */   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doSave:(id)sender {
    SubDetails *details = [self.childViewControllers objectAtIndex:0];
    [details btnDone:nil];
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)doCancel:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}
- (void)viewDidUnload {
    [self setTitleLabel:nil];
    [self setMyView:nil];
    [self setMyBar:nil];
    [super viewDidUnload];
}

-(void)doDelete:(id)sender {
    SubDetails *details = [self.childViewControllers objectAtIndex:0];
    [details doDelete];
    [self.delegate doneDelete];
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}
@end
