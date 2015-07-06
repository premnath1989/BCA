//
//  Table3.m
//  HLA_CA
//
//  Created by Danial D. Moghaddam on 3/20/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//

#import "Table3.h"
#import "myLable.h"
#import <QuartzCore/QuartzCore.h>
@interface Table3 ()

@end

@implementation Table3

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setFrame:CGRectMake(22, 45, 536, 161)];
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
            return 55;
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
    
    if (indexPath.row==0) {
//        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 55)];
//        [imgView setImage:[UIImage imageNamed:@"P5-Line.jpg"]];
//        [cell addSubview:imgView];
        
    }
    else
    {
        if (localArr.count==0) {
            
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(-1, 0, tableView.frame.size.width+2,  55)];
            [imgView setImage:[UIImage imageNamed:@"P5-header.jpg"]];
            [cell addSubview:imgView];
        }
        
        else if ([localArr count]>indexPath.row-1) { 
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,  55)];
            [imgView setImage:[UIImage imageNamed:@"P5-header.jpg"]];
            [cell addSubview:imgView];
            
            myLable *PONameLbl = [[myLable alloc]initWithFrame:CGRectMake(5, 1, 113, 55)];
            PONameLbl.numberOfLines = 5;
            [PONameLbl setFont:[UIFont fontWithName:@"Helvetica" size:6]];
            PONameLbl.text = [[localArr objectAtIndex:indexPath.row-1]objectForKey:@"POName"];
            [cell addSubview:PONameLbl];
            [PONameLbl sizeToFit];
            
            myLable *Company = [[myLable alloc]initWithFrame:CGRectMake(120, 1, 59, 55)];
            Company.numberOfLines = 5;
            [Company setFont:[UIFont fontWithName:@"Helvetica" size:6]];
            Company.text = [[localArr objectAtIndex:indexPath.row-1]objectForKey:@"Company"];
            [cell addSubview:Company];
            [Company sizeToFit];            
            
            myLable *Type = [[myLable alloc]initWithFrame:CGRectMake(183, 1, 73, 55)];
            Type.numberOfLines = 5;
            [Type setFont:[UIFont fontWithName:@"Helvetica" size:6]];
            Type.text = [[localArr objectAtIndex:indexPath.row-1]objectForKey:@"Type"];
            [cell addSubview:Type];
            [Type sizeToFit];            
            
            myLable *Purpose = [[myLable alloc]initWithFrame:CGRectMake(260, 1, 68, 55)];
            [Purpose setFont:[UIFont fontWithName:@"Helvetica" size:6]];
            Purpose.numberOfLines = 5;
            Purpose.text = [[localArr objectAtIndex:indexPath.row-1]objectForKey:@"Purpose"];
            [cell addSubview:Purpose];
            [Purpose sizeToFit];            
            
            myLable *Premium = [[myLable alloc]initWithFrame:CGRectMake(335, 1, 49, 55)];
            [Premium setFont:[UIFont fontWithName:@"Helvetica" size:6]];
            Premium.text = [fmt stringFromNumber:[fmt numberFromString:[[localArr objectAtIndex:indexPath.row-1]objectForKey:@"Premium"]]];
            [cell addSubview:Premium];
            [Premium sizeToFit];            

            
            myLable *ComDate = [[myLable alloc]initWithFrame:CGRectMake(395, 1, 69, 55)];
            [ComDate setFont:[UIFont fontWithName:@"Helvetica" size:6]];
            ComDate.text = [[localArr objectAtIndex:indexPath.row-1]objectForKey:@"ComDate"];
            [cell addSubview:ComDate];
            [ComDate sizeToFit];            
            
            myLable *MaturityAmt = [[myLable alloc]initWithFrame:CGRectMake(460, 1, 82, 55)];
            [MaturityAmt setFont:[UIFont fontWithName:@"Helvetica" size:6]];
            MaturityAmt.text = [fmt stringFromNumber:[fmt numberFromString:[[localArr objectAtIndex:indexPath.row-1]objectForKey:@"MaturityAmt"]]];            
            [cell addSubview:MaturityAmt];
            [MaturityAmt sizeToFit];            
            

        }
        
        
        
        
    }
    return cell;
}

@end
