//
//  ActivityLogVC.m
//  iMobile Planner
//
//  Created by Emi on 19/11/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ActivityLogVC.h"
#import "ColorHexCode.h"
#import "FMDatabase.h"
#import "SaleActivityListVC.h"

@interface ActivityLogVC ()

@end

@implementation ActivityLogVC
@synthesize itemInArray,FilteredTableData,isFiltered;
@synthesize arrCountSA;
@synthesize UDSalesAct;

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
	
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	
	[self LoadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionContact:(id)sender {
}

- (IBAction)actionReferralList:(id)sender {
}

-(void)LoadData {
	arrCountSA = [[NSMutableArray alloc] init];
	itemInArray = [[NSMutableArray alloc] init];
    
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"select * from SalesAct_LogActivity as A, SalesAct_contact as B where A.SalesActivity_ID = B.ID"];
	
    
	
    [itemInArray removeAllObjects];
    [arrCountSA removeAllObjects];
	
	
    while ([result next]) {
		
		
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:
							  [result objectForColumnName:@"NamaLengkap"], @"NamaLengkap",
							  [result objectForColumnName:@"CreateAt"], @"LogCreateAt",
//							  [result objectForColumnName:@"CreateAt"], @"ConCreateAt",
							  [result objectForColumnName:@"TipeReferral"], @"TipeReferral",
							  [result objectForColumnName:@"Activity"], @"Activity",
							  [result objectForColumnName:@"Status"], @"Status",
							  [result objectForColumnName:@"Tanggal"], @"Tanggal",
							  [result objectForColumnName:@"TanggalLahir"], @"TanggalLahir",
							  [result objectForColumnName:@"id"], @"id",
							  nil];
		
		
		
        [itemInArray addObject:[data copy]];
    }
	
    [result close];
    [db close];
	
	
	
    
	[self.myTableView reloadData];
}

- (IBAction)btnBack:(id)sender {
	
	[self dismissViewControllerAnimated:YES completion:Nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowCount;
    if(self.isFiltered)
        rowCount = FilteredTableData.count;
    else
        rowCount = itemInArray.count;
	
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    [[cell.contentView viewWithTag:2001] removeFromSuperview ];
    [[cell.contentView viewWithTag:2002] removeFromSuperview ];
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    
	//Nama
    CGRect frame=CGRectMake(0,0,250, 50);
    UILabel *label1=[[UILabel alloc]init];
    label1.frame=frame;
    label1.text= [NSString stringWithFormat:@"  %@", [[itemInArray objectAtIndex:indexPath.row] objectForKey:@"NamaLengkap"]];
    label1.tag = 2001;
    [cell.contentView addSubview:label1];
    
	//Age
    CGRect frame2=CGRectMake(220,0, 100, 50);
    UILabel *label2=[[UILabel alloc]init];
    label2.frame=frame2;
	NSString *DOB = [[itemInArray objectAtIndex:indexPath.row] objectForKey:@"TanggalLahir"];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
	
	NSDate *date = [dateFormatter dateFromString:DOB];
	dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd/MM/yyyy"];;
	
	DOB = [dateFormatter stringFromDate:date];
	
	SaleActivityListVC *SA = [[SaleActivityListVC alloc]init];
	
    label2.text= [SA calculateAge:DOB];
    label2.tag = 2002;
    [cell.contentView addSubview:label2];
	
	//Last Act Date
	CGRect frame3=CGRectMake(305,0, 200, 50);
    UILabel *label3=[[UILabel alloc]init];
    label3.frame=frame3;
	NSString *dt = [[itemInArray objectAtIndex:indexPath.row] objectForKey:@"LogCreateAt"];
	dateFormatter = [[NSDateFormatter alloc] init] ;
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	date = [dateFormatter dateFromString:dt];
	dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd MMM yyyy"];;
	dt = [dateFormatter stringFromDate:date];
    label3.text= dt;
    label3.tag = 2003;
    [cell.contentView addSubview:label3];
    
	//Type
    CGRect frame4=CGRectMake(470,0, 200, 50);
    UILabel *label4=[[UILabel alloc]init];
    label4.frame=frame4;
	label4.text = [[itemInArray objectAtIndex:indexPath.row] objectForKey:@"TipeReferral"];
	//    label2.textAlignment = UITextAlignmentCenter;
    label4.tag = 2004;
    [cell.contentView addSubview:label4];
	
	//Activity
	CGRect frame5=CGRectMake(590,0, 200, 50);
    UILabel *label5=[[UILabel alloc]init];
    label5.frame=frame5;
    label5.text= [[itemInArray objectAtIndex:indexPath.row] objectForKey:@"Activity"];
	//	label5.textAlignment = NSTextAlignmentCenter;
    label5.tag = 2005;
    [cell.contentView addSubview:label5];
	
	//Status
	CGRect frame6=CGRectMake(720,0, 150, 50);
    UILabel *label6=[[UILabel alloc]init];
    label6.frame=frame6;
    label6.text= [[itemInArray objectAtIndex:indexPath.row] objectForKey:@"Status"];
    label6.tag = 2006;
    [cell.contentView addSubview:label6];
	
	//Next Meeting
	CGRect frame7=CGRectMake(820,0, 200, 50);
    UILabel *label7=[[UILabel alloc]init];
    label7.frame=frame7;
	dt = [[itemInArray objectAtIndex:indexPath.row] objectForKey:@"Tanggal"];
	dateFormatter = [[NSDateFormatter alloc] init] ;
	[dateFormatter setDateFormat:@"dd/MM/yyyy"];
	date = [dateFormatter dateFromString:dt];
	dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd MMM yyyy"];;
	dt = [dateFormatter stringFromDate:date];
	
	label7.text = dt;
	//    label2.textAlignment = UITextAlignmentCenter;
    label7.tag = 2007;
    [cell.contentView addSubview:label7];
	
    // Configure the cell...
	cell.textLabel.font = [UIFont fontWithName:@"Tret MS" size:16];
	
	
    if (indexPath.row % 2 == 0) {
        label1.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label2.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		label3.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label4.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label5.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label6.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		label7.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
       
		
        label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    }
    else {
        label1.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        label2.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
		label3.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        label4.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
		label5.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        label6.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
		label7.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
                
        label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}


@end
