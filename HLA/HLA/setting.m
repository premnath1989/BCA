//
//  setting.m
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 9/28/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "setting.h"
#import "ChangePassword.h"
#import "UserProfile.h"
#import "SecurityQuestion.h"
#import "AppDelegate.h"
#import "SettingSecurityQuestion2.h"
#import "StoreVarFirstTimeReg.h"

@interface setting ()

@end

@implementation setting
@synthesize myTableView;
@synthesize ListOfSubMenu;
@synthesize indexNo;
@synthesize userRequest;

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
    ListOfSubMenu = [[NSMutableArray alloc] initWithObjects:@"User Profile", @"Security Question", @"Change Password", nil ];
    //ListOfSubMenu = [[NSMutableArray alloc] initWithObjects:@"User Profile", @"Change Password", nil ];
    [self.view addSubview:myTableView];
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.backgroundView = nil;
    myTableView.opaque = NO;
    myTableView.hidden = YES;
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
}


- (void)viewDidUnload
{
    [self setMyTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (interfaceOrientation==UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        return YES;
    
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;   
}

- (NSInteger)tableView:(UITableView *)myTableView numberOfRowsInSection:(NSInteger)section {
    
    return ListOfSubMenu.count;
}

- (UITableViewCell *)tableView:(UITableView *)myTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = [ListOfSubMenu objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16 ];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   
    if (indexPath.row == 0) {
        [self setNil];
         UserProfile * UserProfileView = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingUserProfileReg2"];
                
        UserProfileView.modalPresentationStyle = UIModalPresentationPageSheet;
        UserProfileView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        UserProfileView.indexNo = self.indexNo;
        UserProfileView.idRequest = self.userRequest;
        [self presentModalViewController:UserProfileView animated:YES];
        UserProfileView.view.superview.frame = CGRectMake(150, 50, 700, 600);
    }
    
     
     
     
    
    else if (indexPath.row == 1) {
        SettingSecurityQuestion2 *SecurityQuesView = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingSecurityQuestion2"];
        SecurityQuesView.modalPresentationStyle = UIModalPresentationPageSheet;
        SecurityQuesView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentModalViewController:SecurityQuesView animated:YES];
        SecurityQuesView.view.superview.frame = CGRectMake(150, 50, 700, 748); 
    }
   
    else if (indexPath.row == 2) {
        //ChangePassword* zzz = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePwd"];
        //zzz.userID = self.indexNo;
        
        ChangePassword *changePwdView = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePwd"];
        changePwdView.modalPresentationStyle = UIModalPresentationPageSheet;
        changePwdView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        changePwdView.userID = self.indexNo;
        [self presentModalViewController:changePwdView animated:YES];
        changePwdView.view.superview.frame = CGRectMake(150, 50, 700, 600); 
    }
    
    
    

}

-(void) setNil
{
    StoreVarFirstTimeReg *storeVar = [StoreVarFirstTimeReg sharedInstance];   
    
    storeVar.agentLogin = @"";
    storeVar.agentCode = @"";
    storeVar.agentName = @"";
    storeVar.icNo = @"";
    storeVar.contractDate = @"";  
    storeVar.email = @"";
    storeVar.address1 = @"";
    storeVar.address2 = @"";
    storeVar.address3 = @"";
    storeVar.postalCode = @"";
    storeVar.stateCode = @"";
    storeVar.countryCode = @""; 
    storeVar.agentStatus = @"";  
    storeVar.leaderCode = @"";
    storeVar.leaderName = @"";
    storeVar.agentContactNumber = @"";
}

- (IBAction)btnClose:(id)sender {
    [self dismissModalViewControllerAnimated:NO];
}

- (IBAction)ActionProfile:(id)sender {
    [self setNil];
    UserProfile * UserProfileView = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingUserProfileReg2"];
    UserProfileView.modalPresentationStyle = UIModalPresentationPageSheet;
    UserProfileView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    UserProfileView.indexNo = self.indexNo;
    UserProfileView.idRequest = self.userRequest;
    [self presentModalViewController:UserProfileView animated:YES];
    UserProfileView.view.superview.frame = CGRectMake(150, 50, 700, 748);

}

- (IBAction)ActionSecurity:(id)sender {
    SettingSecurityQuestion2 *SecurityQuesView = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingSecurityQuestion2"];
    SecurityQuesView.modalPresentationStyle = UIModalPresentationPageSheet;
    SecurityQuesView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:SecurityQuesView animated:YES];
    SecurityQuesView.view.superview.frame = CGRectMake(150, 50, 700, 748);
}

- (IBAction)ActionPwd:(id)sender {
    ChangePassword *changePwdView = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePwd"];
    changePwdView.modalPresentationStyle = UIModalPresentationPageSheet;
    changePwdView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    changePwdView.userID = self.indexNo;
    [self presentModalViewController:changePwdView animated:YES];
    changePwdView.view.superview.frame = CGRectMake(150, 50, 700, 748);
}

@end
