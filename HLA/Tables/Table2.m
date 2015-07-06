//
//  Table2.m
//  HLA_CA
//
//  Created by Danial D. Moghaddam on 3/19/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//

#import "Table2.h"
#import "myLable.h"
#import <QuartzCore/QuartzCore.h>
@interface Table2 ()

@end

@implementation Table2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setFrame:CGRectMake(24, 230, 536, 208)];
        self.tableview.layer.borderColor = [UIColor blackColor].CGColor;
        self.tableview.layer.borderWidth = 0.7f;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadFromArray:(NSArray *)arr
{
    localArr = [[NSArray alloc]initWithArray:arr];
    [self.tableview reloadData];
    [self.tableview layoutIfNeeded];
    CGRect tableFrame = self.tableview.frame;
    tableFrame.size.height = self.tableview.contentSize.height;
    tableFrame.size.width = self.tableview.contentSize.width; // if you would allow horiz scrolling
    self.tableview.frame = tableFrame;
    tableFrame.origin.x = self.view.frame.origin.x;
    tableFrame.origin.y = self.view.frame.origin.y;
    self.view.frame = tableFrame;
}
#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (localArr.count==0) {
        return 4;
    }
    return localArr.count+1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 55;
    }
    else
    {
        if (localArr.count==0) {
            return 30;
        }
        else
        {
            return 55;
        }
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setMaximumFractionDigits:2];
    [fmt setPositiveFormat:@"#,##0.00"];
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row==0)
    {
//        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 55)];
//        [imgView setImage:[UIImage imageNamed:@"P3-header.jpg"]];
//        [cell addSubview:imgView];
        
    }
    else
    {
        if (localArr.count==0) {
            
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(-1, 0, tableView.frame.size.width+2,  30)];
            [imgView setImage:[UIImage imageNamed:@"P3-row.jpg"]];
            [cell addSubview:imgView];
        }

       else if ([localArr count]>indexPath.row-1) {
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(-1, 0, tableView.frame.size.width+2,  55)];
            [imgView setImage:[UIImage imageNamed:@"P3-row.jpg"]];
            [cell addSubview:imgView];
           
            myLable *PONameLbl = [[myLable alloc]initWithFrame:CGRectMake(3, 1, 60, 55)];
            PONameLbl.numberOfLines = 7;
            [PONameLbl setFont:[UIFont fontWithName:@"Helvetica" size:6]];
            PONameLbl.text = [[localArr objectAtIndex:indexPath.row-1]objectForKey:@"POName"];
            [cell addSubview:PONameLbl];
            [PONameLbl sizeToFit];
            
            myLable *Company = [[myLable alloc]initWithFrame:CGRectMake(70, 1, 41, 55)];
            Company.numberOfLines = 7;
            [Company setFont:[UIFont fontWithName:@"Helvetica" size:6]];
            Company.text = [[localArr objectAtIndex:indexPath.row-1]objectForKey:@"Company"];
            [cell addSubview:Company];
            [Company sizeToFit];
            
            
            myLable *PlanType = [[myLable alloc]initWithFrame:CGRectMake(113, 1, 50, 55)];
            PlanType.numberOfLines = 7;
            [PlanType setFont:[UIFont fontWithName:@"Helvetica" size:6]];
            PlanType.text = [[localArr objectAtIndex:indexPath.row-1]objectForKey:@"PlanType"];
            [cell addSubview:PlanType];
            [PlanType sizeToFit];
           
            
            myLable *LAName = [[myLable alloc]initWithFrame:CGRectMake(168, 1, 68, 55)];
            LAName.numberOfLines = 7;
            [LAName setFont:[UIFont fontWithName:@"Helvetica" size:6]];
            LAName.text = [[localArr objectAtIndex:indexPath.row-1]objectForKey:@"LAName"];
            [cell addSubview:LAName];
            [LAName sizeToFit];
           
            myLable *Benefit1 = [[myLable alloc]initWithFrame:CGRectMake(240, 1, 60, 55)];
            [Benefit1 setFont:[UIFont fontWithName:@"Helvetica" size:6]];
            Benefit1.text = [fmt stringFromNumber:[fmt numberFromString:[[localArr objectAtIndex:indexPath.row-1]objectForKey:@"Benefit1"]]];
            [cell addSubview:Benefit1];
            [Benefit1 sizeToFit];
            
            myLable *Benefit2 = [[myLable alloc]initWithFrame:CGRectMake(289, 1, 60, 55)];
            [Benefit2 setFont:[UIFont fontWithName:@"Helvetica" size:6]];
            Benefit2.text = [fmt stringFromNumber:[fmt numberFromString:[[localArr objectAtIndex:indexPath.row-1]objectForKey:@"Benefit2"]]];
            [cell addSubview:Benefit2];
            [Benefit2 sizeToFit];           
            
            myLable *Benefit3 = [[myLable alloc]initWithFrame:CGRectMake(346, 1, 60, 55)];
            [Benefit3 setFont:[UIFont fontWithName:@"Helvetica" size:6]];
            Benefit3.text = [fmt stringFromNumber:[fmt numberFromString:[[localArr objectAtIndex:indexPath.row-1]objectForKey:@"Benefit3"]]];
            [cell addSubview:Benefit3];
            [Benefit3 sizeToFit];
           
            myLable *Benefit4 = [[myLable alloc]initWithFrame:CGRectMake(401, 1, 60, 55)];
            [Benefit4 setFont:[UIFont fontWithName:@"Helvetica" size:6]];
            Benefit4.text = [fmt stringFromNumber:[fmt numberFromString:[[localArr objectAtIndex:indexPath.row-1]objectForKey:@"Benefit4"]]];
            [cell addSubview:Benefit4];
            [Benefit4 sizeToFit];
           
            myLable *Premium = [[myLable alloc]initWithFrame:CGRectMake(448, 1, 60, 55)];
            [Premium setFont:[UIFont fontWithName:@"Helvetica" size:6]];
            Premium.text = [fmt stringFromNumber:[fmt numberFromString:[[localArr objectAtIndex:indexPath.row-1]objectForKey:@"Premium"]]];
            [cell addSubview:Premium];
            [Premium sizeToFit];
           
            myLable *MaturityDate = [[myLable alloc]initWithFrame:CGRectMake(498, 1, 39, 55)];
            [MaturityDate setFont:[UIFont fontWithName:@"Helvetica" size:6]];
            MaturityDate.text = [[localArr objectAtIndex:indexPath.row-1]objectForKey:@"MaturityDate"];
            [cell addSubview:MaturityDate];
            [MaturityDate sizeToFit];
           
            
        }
        
        
        
        
    }
    return cell;
}

@end
