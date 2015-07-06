//
//  PersonalDataViewController.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "PersonalDataViewControllerWithData.h"
#import "PersonalDetialsViewController.h"
#import "CustomerViewController.h"
//#import "ChildrenViewController.h"
#import "ChildrenandDependents.h"
#import "ChildrenandDependentsWithData.h"
#import "SpouseViewController.h"
#import "ColorHexCode.h"
#import "DataClass.h"

@interface PersonalDataViewControllerWithData () {
    DataClass *obj;
}

@end

@implementation PersonalDataViewControllerWithData

//@synthesize aa = _aa;

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
    //PersonalDetialsViewController *aa;
    //aa.delegate = self;
    [super viewDidLoad];
    //NSLog(@"cascascas");
    //tableView.delegate = self;
    //tableView.dataSource = self;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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

    showCustomer = 0;
    showSpouse = 0;
    showChildren = 0;
    
    obj = [DataClass getInstance];
    
    _addCustomerTitle.text = [NSString stringWithFormat:@"Customer Name: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerName"]];
    
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"]){
        _addSpouseTitle.text = [NSString stringWithFormat:@"Partner/Spouse Name: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerName"]];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden1"] isEqualToString:@"1"]){
        _addChildren1.text = [NSString stringWithFormat:@"Name: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Name"]];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden2"] isEqualToString:@"1"]){
        _addChildren2.text = [NSString stringWithFormat:@"Name: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Name"]];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden3"] isEqualToString:@"1"]){
        _addChildren3.text = [NSString stringWithFormat:@"Name: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Name"]];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden4"] isEqualToString:@"1"]){
        _addChildren4.text = [NSString stringWithFormat:@"Name: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Name"]];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden5"] isEqualToString:@"1"]){
        _addChildren5.text = [NSString stringWithFormat:@"Name: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Name"]];
    }
    
    //_addCustomerView.hidden = TRUE;
    //_addedCustomerView.hidden = TRUE;
    //_addedSpouseView.hidden = TRUE;
    //_addedChildrenView.hidden = TRUE;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UIStoryboard *storyboard = self.storyboard;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard CFF" bundle:nil];
    
    if (indexPath.section == 0){
        
        if (indexPath.row == 0){
                CustomerViewController *customerViewController = [storyboard instantiateViewControllerWithIdentifier:@"CustomerViewController"];
                [self presentViewController:customerViewController animated:YES completion:nil];
                //personalDetialsView.delegate = self;
            /*
            else{
                CustomerViewController *customerViewController = [storyboard instantiateViewControllerWithIdentifier:@"CustomerViewController"];
                [self presentViewController:customerViewController animated:YES completion:nil];
                //showCustomer = 1;
                [self.tableView reloadData];
            }
            */
        }
        else if (indexPath.row == 1){
                SpouseViewController *spouseViewController = [storyboard instantiateViewControllerWithIdentifier:@"SpouseViewController"];
                [self presentViewController:spouseViewController animated:YES completion:nil];
                //personalDetialsView.delegate = self;
            /*
            else {
                SpouseViewController *spouseViewController = [storyboard instantiateViewControllerWithIdentifier:@"SpouseViewController"];
                [self presentViewController:spouseViewController animated:YES completion:nil];
                //showSpouse = 1;
                [self.tableView reloadData];
            }
            */
        }
    }
    
    else if (indexPath.section == 1){
        if (indexPath.row == 0){
            ChildrenandDependentsWithData *childrenView = [storyboard instantiateViewControllerWithIdentifier:@"ChildrenViewControllerWithData"];
            [self presentViewController:childrenView animated:YES completion:nil];
        }
        else if (indexPath.row == 1){
            ChildrenandDependents *childrenView = [storyboard instantiateViewControllerWithIdentifier:@"ChildrenViewController"];
            [self presentViewController:childrenView animated:YES completion:nil];
        }
        else if (indexPath.row == 2){
            ChildrenandDependents *childrenView = [storyboard instantiateViewControllerWithIdentifier:@"ChildrenViewController"];
            [self presentViewController:childrenView animated:YES completion:nil];
        }
        else if (indexPath.row == 3){
            ChildrenandDependents *childrenView = [storyboard instantiateViewControllerWithIdentifier:@"ChildrenViewController"];
            [self presentViewController:childrenView animated:YES completion:nil];
        }
        else if (indexPath.row == 4){
            ChildrenandDependents *childrenView = [storyboard instantiateViewControllerWithIdentifier:@"ChildrenViewController"];
            [self presentViewController:childrenView animated:YES completion:nil];
        }
    }
}






- (void)viewDidUnload {
    [self setAddCustomerTitle:nil];
    [self setAddSpouseTitle:nil];
    [self setAddChildren1:nil];
    [self setAddChildren2:nil];
    [self setAddChildren3:nil];
    [self setAddChildren4:nil];
    [self setAddChildren5:nil];
//    [self setAddCustomerView:nil];
//    [self setAddedCustomerView:nil];
//    [self setAddSpouseView:nil];
//    [self setAddedSpouseView:nil];
//    [self setAddChildrenView:nil];
//    [self setAddedChildrenView:nil];
    [self setAddCustomerTitle:nil];
    [self setAddSpouseTitle:nil];
    [super viewDidUnload];
}

#pragma mark - ChildrenViewControllerDelegate
-(void)ChildrenViewDisplay{
    NSLog(@"aaaaa");
}

-(void)addedChildren
{
    NSLog(@"1111");
}

#pragma mark - PlayerDetailsViewControllerDelegate

-(void)CustomerViewDisplay:(NSString *)type{
    [self dismissViewControllerAnimated:TRUE completion:^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
        if ([type isEqualToString:@"customer"]){
            CustomerViewController *customerViewController = [storyboard instantiateViewControllerWithIdentifier:@"CustomerViewController"];
            [self presentViewController:customerViewController animated:YES completion:nil];
            //showCustomer = 1;
            [self.tableView reloadData];
        }
        else if ([type isEqualToString:@"spouse"]){
            SpouseViewController *spouseViewController = [storyboard instantiateViewControllerWithIdentifier:@"SpouseViewController"];
            [self presentViewController:spouseViewController animated:YES completion:nil];
            //showSpouse = 1;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - CustomerViewControllerDelegate
-(void)addedCustomerDisplay:(NSString *)type{
    NSLog(@"%@",type);
}



@end
