//
//  ViewInsuredRecord.m
//  iMobile Planner
//
//  Created by kuan on 9/19/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ViewInsuredRecord.h"
#import "DataClass.h"
#import "InsuredDetail.h"
#import "AddtionalQuestInsured.h"
#import "MainEditInsured.h"

@interface ViewInsuredRecord ()
{
    DataClass *obj;
}

@end
@implementation ViewInsuredRecord


{
    
    NSMutableArray *test;
    
}
@synthesize tableRecord;



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    obj = [DataClass getInstance];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"reloadViewInsuredTable" object:nil];
    
    
    int c = [[[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"] count];
    
    NSMutableArray *insured_Array = [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"];
    test = [[NSMutableArray alloc]init];
    
    
    for(int x = 0; x < c; x++)
    {
        
        InsuredObject *insured_Object =  insured_Array[x];
        
        [test addObject:insured_Object.Company];
        
    }
    
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [test count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell.
    
    
    cell.textLabel.text = [test objectAtIndex:indexPath.row];
    
    return cell;
}


#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MainEditInsured *mainEditInsured = [self.storyboard instantiateViewControllerWithIdentifier:@"MainEditInsured"];
    
    [mainEditInsured setRow:indexPath.row];
    mainEditInsured.view.tag = indexPath.row;
    
	mainEditInsured.modalPresentationStyle = UIModalPresentationFormSheet;
	[self presentViewController:mainEditInsured animated:YES completion:Nil];
    
    
   // NSMutableArray *insured_Array = [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"];
    

    
}
- (IBAction)btnClose:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    [test removeAllObjects];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)refresh
{
    [self reloadTableRecord];
    
      int c = [[[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"] count];
     
    
        if(c == 0)
            
          
    
            [self dismissViewControllerAnimated:TRUE completion:^{
                 [self dismissModalViewControllerAnimated:YES];
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"disableViewBtn" object:self];
                
            }];
    
              
        
}

-(void)reloadTableRecord {
    
  
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        int c = [[[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"] count];
        
        NSMutableArray *insured_Array = [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"Insured_Array"];
        test = [[NSMutableArray alloc]init];
        
        for(int x = 0; x < c; x++)
        {
            
            InsuredObject *insured_Object =  insured_Array[x];
            
            
            [test addObject:insured_Object.Company];
            
        }
        
        [self.tableView reloadData];
        
        
        
        
        
    });
    
      
    
    
    
}

- (void) setDelegate:(id)delegate
{
    _delegate = delegate;
}

@end
