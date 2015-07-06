//
//  Summary.m
//  iMobile Planner
//
//  Created by Erza on 6/18/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "Summary.h"
#import "ColorHexCode.h"
#import "eAppMenu.h"
#import "DataClass.h"
#import "MasterMenuEApp.h"

@interface Summary (){
    DataClass *obj;
}

@end

@implementation Summary
@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"e-Application";
    self.navigationItem.titleView = label;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnDone:)];
    
    obj=[DataClass getInstance];
    
 
    //Display the saved data
 	NSLog(@"summary a: %@", [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SecA_Saved"]);
//    if([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SecA_Saved"] isEqualToString:@"Y"])
//        _tickPersonalDetails.text = @"✓";
//    
//    if([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"SecB_Saved"] isEqualToString:@"Y"])
//        _tickPolicyDetails.text = @"✓";
//    
//   // if([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"SecC_Saved"] isEqualToString:@"Y"])
//     //   _tickeCFF.text = @"✓";
//    
//    if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"SecD_Saved"] isEqualToString:@"Y"])
//        _tickNominees.text = @"✓";
//    
//    if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Saved"] isEqualToString:@"Y"])
//        _tickHealthQuestions.text = @"✓";
//    
//    if([[[obj.eAppData objectForKey:@"SecF"] objectForKey:@"SecF_Saved"] isEqualToString:@"Y"])
//        _tickAdditionalQuestions.text = @"✓";
//    
//     if([[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"SecG_Saved"] isEqualToString:@"Y"])
//         _tickDeclaration.text = @"✓";
    
    
}

 

- (void)btnDone:(id)sender
{
    UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
    eAppMenu *main = [nextStoryboard instantiateViewControllerWithIdentifier:@"eAppMenuScreen"];
    main.getEAPP = @"YES";
    main.modalPresentationStyle = UIModalPresentationFullScreen;
    main.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:main animated:NO];
    
    nextStoryboard = nil;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"click sec:%d path:%d",indexPath.section, indexPath.row);
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            NSString *aa = @"1";
            [_delegate selectedMenu:aa];
            NSLog(@"go sub1");
        }
        if (indexPath.row == 1) {
            [_delegate selectedMenu:@"2"];
        }
        if (indexPath.row == 2) {
            [_delegate selectedMenu:@"3"];
        }
        if (indexPath.row == 4) {
            [_delegate selectedMenu:@"4"];
        }
        if (indexPath.row == 5) {
            [_delegate selectedMenu:@"5"];
        }
        if (indexPath.row == 6) {
            [_delegate selectedMenu:@"6"];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
  
    [super viewDidUnload];
}

- (IBAction)confirmBtn:(id)sender {
    
    /*
    [[obj.eAppData objectForKey:@"Proposal"] setValue:@"Confirmed" forKey:@"Confirmation"];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: NSLocalizedString(@"IMobile Planner",nil)
                          message: NSLocalizedString(@"No amendment is allowd after confirmation. Confirmation process will take a while. Do you want to continue?",nil)
                          delegate: self
                          cancelButtonTitle: NSLocalizedString(@"Yes",nil)
                          otherButtonTitles: NSLocalizedString(@"No",nil), nil];
    [alert setTag:1002];
    [alert show];
    alert = Nil;
     */
    

    
    if ([[obj.eAppData objectForKey:@"Proposal"] objectForKey:@"Complete"] != Nil){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: NSLocalizedString(@"IMobile Planner",nil)
                              message: NSLocalizedString(@"No amendment is allowd after confirmation. Confirmation process will take a while. Do you want to continue?",nil)
                              delegate: self
                              cancelButtonTitle: NSLocalizedString(@"Yes",nil)
                              otherButtonTitles: NSLocalizedString(@"No",nil), nil];
        [alert setTag:1002];
        [alert show];
        alert = Nil;
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message: @"Please complete all section before confirmation."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert setTag:1003];
        [alert show];
        alert = Nil;
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1002 && buttonIndex == 0)
    {

        //[[obj.eAppData objectForKey:@"eSign"] setValue:@"Completed" forKey:@"Complete"];
        [[obj.eAppData objectForKey:@"Proposal"] setValue:@"Confirmed" forKey:@"Confirmation"];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message: @"Proposal Confirmed. Please proceed to eSignature."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert setTag:1001];
        [alert show];
        alert = Nil;
        
        
    }
    
    else if (alertView.tag == 1002 && buttonIndex == 1)
    {
        
        //--edited by bob
        //clickIndex = _selectedIndex;
        //[self updateTabBar2];
    }
}

@end
