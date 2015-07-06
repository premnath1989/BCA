//
//  FinancialAnalysis.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "FinancialAnalysis.h"
#import "ExistingProtectionPlans.h"
#import "ColorHexCode.h"
#import "DataClass.h"


@interface FinancialAnalysis (){
    DataClass *obj;
}

@end

@implementation FinancialAnalysis

@synthesize btn1;
@synthesize btn2;
@synthesize btn3;
@synthesize btn4;
@synthesize btn5;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    /*[super viewDidLoad];
	
	ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"Customer Fact Find";
    self.navigationItem.titleView = label;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnDone:)];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [_myTableView setContentOffset:CGPointZero animated:YES];*/
    
    // From FNAProtection
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIButton * headerBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    headerBtn.backgroundColor = [UIColor clearColor];
    headerBtn.frame = CGRectMake(615.0, 15.0, 100.0, 30.0);
    
    [headerBtn setTitle:@"Clear All" forState:UIControlStateNormal];
    
    [headerBtn setBackgroundImage:[UIImage imageNamed:@"merahBtn.png"]
                         forState:UIControlStateNormal];
    [headerBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    
    [headerBtn addTarget:self action:@selector(ActionEventForButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *aa = [[UIView alloc] initWithFrame:CGRectZero];
    aa.frame = CGRectMake(0.0,0.0,0.0,40.0);
    aa.backgroundColor = [UIColor clearColor];
    [aa addSubview:headerBtn];
    
    _required1.delegate = self;
    _required2.delegate = self;
    _required3.delegate = self;
    _required4.delegate = self;
    
    _current1.delegate = self;
    _current2.delegate = self;
    _current3.delegate = self;
    _current4.delegate = self;
    
    _customerAlloc.delegate = self;
    _partnerAlloc.delegate = self;
    obj=[DataClass getInstance];
    
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasProtection"] isEqualToString:@"0"]){
        hasProtection = TRUE;
        self.ProtectionSelected = TRUE;
        [_ProtectionPlans setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1"] isEqualToString:@"1"]){
            _plan1.text = [NSString stringWithFormat:@"Policy Owner: %@", [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection1PolicyOwner"]];
        }
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2"] isEqualToString:@"1"]){
            _plan2.text = [NSString stringWithFormat:@"Policy Owner: %@", [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection2PolicyOwner"]];
        }
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3"] isEqualToString:@"1"]){
            _plan3.text = [NSString stringWithFormat:@"Policy Owner: %@", [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingProtection3PolicyOwner"]];
        }
    }
    else{
        hasProtection = FALSE;
        self.ProtectionSelected = FALSE;
        [_ProtectionPlans setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        _current1.enabled = FALSE;
        _current2.enabled = FALSE;
        _current3.enabled = FALSE;
        _current4.enabled = FALSE;
        
    }
    
    _current1.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent1"];
    _required1.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired1"];
    _difference1.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference1"];
    
    _current2.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent2"];
    _required2.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired2"];
    _difference2.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference2"];
    
    _current3.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent3"];
    _required3.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired3"];
    _difference3.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference3"];
    
    _current4.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCurrent4"];
    _required4.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionRequired4"];
    _difference4.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionDifference4"];
    
    _customerAlloc.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionCustomerAlloc"];
    _partnerAlloc.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ProtectionPartnerAlloc"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
    
    UIStoryboard *secondstoryboard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard CFF" bundle:nil];
    
    if (indexPath.section == 0){
        if (indexPath.row == 1){
            ExistingProtectionPlans *existingProtectionPlans = [secondstoryboard instantiateViewControllerWithIdentifier:@"ExistingProtectionPlansViewWithData"];
            [self presentViewController:existingProtectionPlans animated:YES completion:nil];
        }
        else if (indexPath.row == 2){
            ExistingProtectionPlans *existingProtectionPlans = [storyboard instantiateViewControllerWithIdentifier:@"ExistingProtectionPlansView"];
            [self presentViewController:existingProtectionPlans animated:YES completion:nil];
        }
        else if (indexPath.row == 3){
            ExistingProtectionPlans *existingProtectionPlans = [storyboard instantiateViewControllerWithIdentifier:@"ExistingProtectionPlansView"];
            [self presentViewController:existingProtectionPlans animated:YES completion:nil];
        }
    }
    
    if (indexPath.section == 1){
        
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message: @"Please untick 'Tick if client does not have any plan currently'"
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert setTag:1001];
        [alert show];
        alert = Nil;
        
        /*
        if (indexPath.row == 1){
            ExistingProtectionPlans *existingProtectionPlans = [storyboard instantiateViewControllerWithIdentifier:@"ExistingRetirementPlansView"];
            [self presentViewController:existingProtectionPlans animated:YES completion:nil];
        }
        else if (indexPath.row == 2){
            ExistingProtectionPlans *existingProtectionPlans = [storyboard instantiateViewControllerWithIdentifier:@"ExistingRetirementPlansView"];
            [self presentViewController:existingProtectionPlans animated:YES completion:nil];
        }
        else if (indexPath.row == 3){
            ExistingProtectionPlans *existingProtectionPlans = [storyboard instantiateViewControllerWithIdentifier:@"ExistingRetirementPlansView"];
            [self presentViewController:existingProtectionPlans animated:YES completion:nil];
        }
         */
    }
    
    if (indexPath.section == 2){
        
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message: @"Please untick 'Tick if client does not have any plan currently'"
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert setTag:1002];
        [alert show];
        alert = Nil;
        
        /*
        
        if (indexPath.row == 2){
            ExistingProtectionPlans *existingProtectionPlans = [storyboard instantiateViewControllerWithIdentifier:@"ExistingChildrenEducationPlansView"];
            [self presentViewController:existingProtectionPlans animated:YES completion:nil];
        }
        else if (indexPath.row == 3){
            ExistingProtectionPlans *existingProtectionPlans = [storyboard instantiateViewControllerWithIdentifier:@"ExistingChildrenEducationPlansView"];
            [self presentViewController:existingProtectionPlans animated:YES completion:nil];
        }
        else if (indexPath.row == 4){
            ExistingProtectionPlans *existingProtectionPlans = [storyboard instantiateViewControllerWithIdentifier:@"ExistingChildrenEducationPlansView"];
            [self presentViewController:existingProtectionPlans animated:YES completion:nil];
        }
        else if (indexPath.row == 5){
            ExistingProtectionPlans *existingProtectionPlans = [storyboard instantiateViewControllerWithIdentifier:@"ExistingSavingAndInvestmentPlansView"];
            [self presentViewController:existingProtectionPlans animated:YES completion:nil];
        }
         */
    }

	if (indexPath.section == 3){
        if (indexPath.row == 1){
            ExistingProtectionPlans *existingProtectionPlans = [secondstoryboard instantiateViewControllerWithIdentifier:@"ExistingSavingAndInvestmentPlansViewWithData"];
            [self presentViewController:existingProtectionPlans animated:YES completion:nil];
        }
        else if (indexPath.row == 2){
            ExistingProtectionPlans *existingProtectionPlans = [storyboard instantiateViewControllerWithIdentifier:@"ExistingSavingAndInvestmentPlansView"];
            [self presentViewController:existingProtectionPlans animated:YES completion:nil];
        }
        else if (indexPath.row == 3){
            ExistingProtectionPlans *existingProtectionPlans = [storyboard instantiateViewControllerWithIdentifier:@"ExistingSavingAndInvestmentPlansView"];
            [self presentViewController:existingProtectionPlans animated:YES completion:nil];
        }
    }

    /*
    if (indexPath.section == 0){
        
        if (indexPath.row == 0){
            if (showCustomer == 0){
                PersonalDetialsViewController *personalDetialsView = [storyboard instantiateViewControllerWithIdentifier:@"PersonalDetialsViewController"];
                [self presentViewController:personalDetialsView animated:YES completion:nil];
                personalDetialsView.delegate = self;
            }
            else{
                CustomerViewController *customerViewController = [storyboard instantiateViewControllerWithIdentifier:@"CustomerViewController"];
                [self presentViewController:customerViewController animated:YES completion:nil];
                //showCustomer = 1;
                [self.tableView reloadData];
            }
        }
        else if (indexPath.row == 1){
            if (showSpouse == 0){
                PersonalDetialsViewController *personalDetialsView = [storyboard instantiateViewControllerWithIdentifier:@"PersonalDetialsViewController"];
                [self presentViewController:personalDetialsView animated:YES completion:nil];
                //personalDetialsView.delegate = self;
            }
            else {
                SpouseViewController *spouseViewController = [storyboard instantiateViewControllerWithIdentifier:@"SpouseViewController"];
                [self presentViewController:spouseViewController animated:YES completion:nil];
                //showSpouse = 1;
                [self.tableView reloadData];
            }
        }
    }
    
    else if (indexPath.section == 1){
        if (indexPath.row == 0){
            //ChildrenViewController *childrenView = [storyboard instantiateViewControllerWithIdentifier:@"ChildrenViewController"];
            //[self presentViewController:childrenView animated:YES completion:nil];
            //childrenView.delegate = self;
            ChildrenViewController *childrenView = [storyboard instantiateViewControllerWithIdentifier:@"ChildrenViewController"];
            [self presentViewController:childrenView animated:YES completion:nil];
            //childrenView.delegate = self;
        }
    }
     */
}



- (void)viewDidUnload {
	[self setBtn1:nil];
	[self setBtn2:nil];
	[self setBtn3:nil];
	[self setBtn4:nil];
	[self setBtn5:nil];
    [self setMyTableView:nil];
	[super viewDidUnload];
}

- (IBAction)clickBtn1:(id)sender {
	btn1.selected = !btn1.selected;
	if (btn1.selected) {
		[btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
	}
	else {
		[btn1 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
	}
}

- (IBAction)clickBtn2:(id)sender {
	btn2.selected = !btn2.selected;
	if (btn2.selected) {
		[btn2 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
	}
	else {
		[btn2 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
	}
}

- (IBAction)clickBtn3:(id)sender {
	btn3.selected = !btn3.selected;
	if (btn3.selected) {
		[btn3 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
	}
	else {
		[btn3 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
	}
}

- (IBAction)clickBtn4:(id)sender {
	btn4.selected = !btn4.selected;
	if (btn4.selected) {
		[btn4 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
	}
	else {
		[btn4 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
	}
}

- (IBAction)clickBtn5:(id)sender {
	btn5.selected = !btn5.selected;
	if (btn5.selected) {
		[btn5 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
	}
	else {
		[btn5 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
	}
}

@end
