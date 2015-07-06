//
//  P2Table.m
//  HLA_CA
//
//  Created by Danial D. Moghaddam on 3/13/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//

#import "P2Table.h"
#import "myLable.h"
#import "PRHtmlHandler.h"
@interface P2Table ()

@end

@implementation P2Table

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setFrame:CGRectMake(22, 477, 540, 169)];
    }
    return self;
}
-(void)loadFromArray:(NSArray *)arr
{
    childrenArr = [[NSArray alloc]initWithArray:arr];
    [self.childerTable reloadData];
    [self.childerTable layoutIfNeeded];
    CGRect tableFrame = self.childerTable.frame;
    tableFrame.size.height = self.childerTable.contentSize.height;
    tableFrame.size.width = self.childerTable.contentSize.width; // if you would allow horiz scrolling
    self.childerTable.frame = tableFrame;
    tableFrame.origin.x = self.view.frame.origin.x;
    tableFrame.origin.y = self.view.frame.origin.y;
    self.view.frame = tableFrame;
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
#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([childrenArr count]<5) {
        return 6;
    }
    else
    {
    return childrenArr.count+1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 30;
    }
    else
    {
    return 25;

    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row==0) {
//        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
//        [imgView setImage:[UIImage imageNamed:@"P2-1-Header.jpg"]];
//        [cell addSubview:imgView];
        
    }
    else
    {
        if ([childrenArr count]>indexPath.row-1) {
//            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -5, tableView.frame.size.width,  25)];
//            [imgView setImage:[UIImage imageNamed:@"P2-1-Row.jpg"]];
//            [cell addSubview:imgView];
            
//            myLable *count = [[myLable alloc]initWithFrame:CGRectMake(2, 12, 16, 14)];
//            count.text = [NSString stringWithFormat:@"%i",indexPath.row];
//            [count setFont:[UIFont fontWithName:@"Helvetica" size:7]];
//            [cell addSubview:count];
            
            myLable *nameLbl = [[myLable alloc]initWithFrame:CGRectMake(16, 7, 230, 14)];
            [nameLbl setFont:[UIFont fontWithName:@"Helvetica" size:7]];
            nameLbl.numberOfLines = 2;
            nameLbl.text = [[[childrenArr objectAtIndex:indexPath.row-1]objectForKey:@"Name"] uppercaseString];
//            if (nameLbl.text.length > 55) {
//                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 23, 240,  8)];
//                [imgView setImage:[UIImage imageNamed:@"P2-1-Row3.jpg"]];
//                [cell addSubview:imgView];
//            }
            [nameLbl sizeToFit];
            [cell addSubview:nameLbl];

            myLable *relation = [[myLable alloc]initWithFrame:CGRectMake(244, 5, 63, 14)];
            [relation setFont:[UIFont fontWithName:@"Helvetica" size:7]];
            NSString *rel = [[childrenArr objectAtIndex:indexPath.row-1]objectForKey:@"Relationship"];
            NSString *getRelation=[[PRHtmlHandler sharedPRHtmlHandler].sqlHandler getRelationByCode:rel];
            relation.text = getRelation;
            [cell addSubview:relation];
            
            myLable *dob = [[myLable alloc]initWithFrame:CGRectMake(315, 5, 40, 14)];
            [dob setFont:[UIFont fontWithName:@"Helvetica" size:7]];
            dob.text = [[childrenArr objectAtIndex:indexPath.row-1]objectForKey:@"DOB"];
            [cell addSubview:dob];
            
            myLable *age = [[myLable alloc]initWithFrame:CGRectMake(360, 5, 16, 14)];
            [age setFont:[UIFont fontWithName:@"Helvetica" size:7]];
            age.text = [[childrenArr objectAtIndex:indexPath.row-1]objectForKey:@"Age"];
            [cell addSubview:age];
            
            if ([[[childrenArr objectAtIndex:indexPath.row-1]objectForKey:@"Sex"]hasPrefix:@"M"]) {
                UIView *v= [[UIView alloc]initWithFrame:CGRectMake( 375, 4,8,8)];
                v.backgroundColor = [UIColor blackColor];
                [cell addSubview:v];
                
            }
            else
            {
                UIView *v= [[UIView alloc]initWithFrame:CGRectMake(414, 3,8,8)];
                v.backgroundColor = [UIColor blackColor];
                [cell addSubview:v];
            }
            
            myLable *year = [[myLable alloc]initWithFrame:CGRectMake(498, 5, 63, 14)];
            [year setFont:[UIFont fontWithName:@"Helvetica" size:7]];
            year.text = [[childrenArr objectAtIndex:indexPath.row-1]objectForKey:@"YearsToSupport"];
            [cell addSubview:year];
        }
        


        
    }
    return cell;
}
@end
