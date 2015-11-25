//
//  SaleActivityListVC.m
//  iMobile Planner
//
//  Created by Emi on 13/11/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import "SaleActivityListVC.h"
#import "ColorHexCode.h"
#import "FMDatabase.h"
#import "ContactViewController.h"
#import "ActivityLogVC.h"

@interface SaleActivityListVC ()

@end

@implementation SaleActivityListVC
@synthesize itemInArray,FilteredTableData,isFiltered;
@synthesize arrCountSA;
@synthesize UDSalesAct;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
//	UDGroup = [NSUserDefaults standardUserDefaults];
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    self.ActListingTableView.backgroundColor = [UIColor clearColor];
    self.ActListingTableView.separatorColor = [UIColor clearColor];
    ItemToBeDeleted = [[NSMutableArray alloc] init];
	
    indexPaths = [[NSMutableArray alloc] init];
    FilteredTableData = [[NSMutableArray alloc] init];
    arrCountSA = [[NSMutableArray alloc] init];
    isFiltered = FALSE;
    
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:@"reloadTableList" object:nil];
    [self refreshData];
	

	NSLocale *en_US_POSIX = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
	assert(en_US_POSIX != nil);
	// Set date time
	
	[NSTimer scheduledTimerWithTimeInterval:1.0
									 target:self
								   selector:@selector(targetMethod:)
								   userInfo:nil
									repeats:YES];
	
	
}

-(void)targetMethod:(id)sender
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd MMM yyyy hh:mm aa"];
	
	NSString *currentTime = [dateFormatter stringFromDate: [NSDate date]];
	_lblDateTime.text = currentTime;
}

-(void)refreshData
{
    
    arrCountSA = [[NSMutableArray alloc] init];
	itemInArray = [[NSMutableArray alloc] init];
    

    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"select * from SalesAct_contact"];
	
    
	
    [itemInArray removeAllObjects];
    [arrCountSA removeAllObjects];
	
	
    while ([result next]) {
		
		
		FMResultSet *result2 = [db executeQuery:@"select * from SalesAct_ActLogList where SalesActivity_ID = ?", [result objectForColumnName:@"id"], Nil];
		
		NSString *stateAct = @"";
		while ([result2 next]) {
			stateAct = [result2 objectForColumnName:@"StateAct"];
		}
		
		if ([stateAct isEqualToString:@""]) {
			stateAct = @"0";
		}
		
        NSDictionary *data = [[NSDictionary alloc] initWithObjectsAndKeys:
							  [result objectForColumnName:@"NIP"], @"NIP",
							  [result objectForColumnName:@"NamaLengkap"], @"NamaLengkap",
							  [result objectForColumnName:@"NamaReferral"], @"NamaReferral",
							  [result objectForColumnName:@"CreateAt"], @"CreateAt",
							  [result objectForColumnName:@"TanggalLahir"], @"TanggalLahir",
							  [result objectForColumnName:@"TipeReferral"], @"TipeReferral",
							  [result objectForColumnName:@"SumberReferal"], @"SumberReferal",
							  stateAct, @"StateAct",
							  [result objectForColumnName:@"id"], @"id",
							  nil];
		
		
		
        [itemInArray addObject:[data copy]];
    } 

    [result close];
    [db close];
	
	
	
    
	[self.ActListingTableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)ActionReffer:(id)sender {
	
	
	
}

- (IBAction)ActionActLog:(id)sender {
	
	ActivityLogVC *controller = [[ActivityLogVC alloc]
										 initWithNibName:@"ActivityLogVC"
										 bundle:nil];
	[self presentViewController:controller animated:YES completion:Nil];
	
}


- (IBAction)btnHome:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)ActionAddNew:(id)sender {
	
	
	NSUserDefaults *Cdefaults = [NSUserDefaults standardUserDefaults];
	[Cdefaults setObject:[NSString stringWithFormat:@"Add New Contact"] forKey:@"TitleSetting"];
	[Cdefaults setObject:[NSNumber numberWithInt:0] forKey:@"SalesActivity_ID"];
	
	ContactViewController *controller = [[ContactViewController alloc]
									  initWithNibName:@"ContactViewController"
									  bundle:nil];
	[self presentViewController:controller animated:YES completion:Nil];
}

- (IBAction)toActLog:(id)sender {
	ActivityLogVC *controller = [[ActivityLogVC alloc]
										 initWithNibName:@"ActivityLogVC"
										 bundle:nil];
	[self presentViewController:controller animated:YES completion:Nil];
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
	
	
    
//    NSString *itemDisplay = nil;
//    if(isFiltered) {
//        itemDisplay = [[FilteredTableData objectAtIndex:indexPath.row ]objectForKey:@"NamaLengkap"];
//    }
//    else {
//        itemDisplay = [[itemInArray objectAtIndex:indexPath.row] objectForKey:@"NamaLengkap"];
//    }
    
	//Ref Quality
    CGRect frame=CGRectMake(0,0,117, 50);
    UILabel *label1=[[UILabel alloc]init];
    label1.frame=frame;
    label1.text= @"      ";
//    label1.textAlignment = UITextAlignmentLeft;
    label1.tag = 2001;
    [cell.contentView addSubview:label1];
    
	//Nama
    CGRect frame2=CGRectMake(117,0, 200, 50);
    UILabel *label2=[[UILabel alloc]init];
    label2.frame=frame2;
    label2.text= [[itemInArray objectAtIndex:indexPath.row] objectForKey:@"NamaLengkap"];
//    label2.textAlignment = UITextAlignmentCenter;
    label2.tag = 2002;
    [cell.contentView addSubview:label2];
	
	//Age
	CGRect frame3=CGRectMake(314,0, 100, 50);
    UILabel *label3=[[UILabel alloc]init];
    label3.frame=frame3;
	
	NSString *DOB = [[itemInArray objectAtIndex:indexPath.row] objectForKey:@"TanggalLahir"];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
	
	NSDate *date = [dateFormatter dateFromString:DOB];
	dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd/MM/yyyy"];;
	
	DOB = [dateFormatter stringFromDate:date];
	
    label3.text= [self calculateAge:DOB];
    label3.tag = 2003;
    [cell.contentView addSubview:label3];
    
	//RefDate
    CGRect frame4=CGRectMake(380,0, 150, 50);
    UILabel *label4=[[UILabel alloc]init];
    label4.frame=frame4;
	NSString *dt = [[itemInArray objectAtIndex:indexPath.row] objectForKey:@"CreateAt"];
	dateFormatter = [[NSDateFormatter alloc] init] ;
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	date = [dateFormatter dateFromString:dt];
	dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd MMM yyyy"];;
	dt = [dateFormatter stringFromDate:date];
	label4.text = dt;
	//    label2.textAlignment = UITextAlignmentCenter;
    label4.tag = 2004;
    [cell.contentView addSubview:label4];
	
	//Type
	CGRect frame5=CGRectMake(520,0, 150, 50);
    UILabel *label5=[[UILabel alloc]init];
    label5.frame=frame5;
    label5.text= [[itemInArray objectAtIndex:indexPath.row] objectForKey:@"TipeReferral"];
//	label5.textAlignment = NSTextAlignmentCenter;
    label5.tag = 2005;
    [cell.contentView addSubview:label5];
	
	//Ref Source
	CGRect frame6=CGRectMake(630,0, 150, 50);
    UILabel *label6=[[UILabel alloc]init];
    label6.frame=frame6;
    label6.text= [[itemInArray objectAtIndex:indexPath.row] objectForKey:@"SumberReferal"];
//	label6.textAlignment = NSTextAlignmentCenter;
    label6.tag = 2006;
    [cell.contentView addSubview:label6];
	
	//Ref
	CGRect frame7=CGRectMake(748,0, 200, 50);
    UILabel *label7=[[UILabel alloc]init];
    label7.frame=frame7;
    label7.text= [[itemInArray objectAtIndex:indexPath.row] objectForKey:@"NamaReferral"];
	//    label2.textAlignment = UITextAlignmentCenter;
    label7.tag = 2007;
    [cell.contentView addSubview:label7];

	//NIP aka staff ID
	CGRect frame8=CGRectMake(910,0, 300, 50);
    UILabel *label8=[[UILabel alloc]init];
    label8.frame=frame8;
    label8.text= [[itemInArray objectAtIndex:indexPath.row] objectForKey:@"NIP"];
	//    label2.textAlignment = UITextAlignmentCenter;
    label8.tag = 2008;
    [cell.contentView addSubview:label8];
	
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
        label8.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		
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
        label8.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        
        label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	NSUserDefaults *Cdefaults = [NSUserDefaults standardUserDefaults];
	
	int SAID = [[[itemInArray objectAtIndex:indexPath.row] objectForKey:@"id"] integerValue];
	
	[Cdefaults setObject:[NSNumber numberWithInt:SAID] forKey:@"SalesActivity_ID"];
	[Cdefaults setObject:[NSString stringWithFormat:@"Update Contact"] forKey:@"TitleSetting"];
	[Cdefaults setObject:[[itemInArray objectAtIndex:indexPath.row] objectForKey:@"StateAct"] forKey:@"StateAct"];
	[Cdefaults synchronize];
	
	ContactViewController *controller = [[ContactViewController alloc]
										 initWithNibName:@"ContactViewController"
										 bundle:nil];
	[self presentViewController:controller animated:YES completion:Nil];
	
	
}

-(NSString *)calculateAge: (NSString *)DOB{
    
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    [fmtDate setDateFormat:@"dd/MM/yyyy"];
    NSString *textDate = [NSString stringWithFormat:@"%@",[fmtDate stringFromDate:[NSDate date]]];
    
    NSArray *curr = [textDate componentsSeparatedByString: @"/"];
    NSString *currentDay = [curr objectAtIndex:0];
    NSString *currentMonth = [curr objectAtIndex:1];
    NSString *currentYear = [curr objectAtIndex:2];
    
    NSArray *foo = [DOB componentsSeparatedByString: @"/"];
    NSString *birthDay = [foo objectAtIndex: 0];
    NSString *birthMonth = [foo objectAtIndex: 1];
    NSString *birthYear = [foo objectAtIndex: 2];
    
    int yearN = [currentYear intValue];
    int yearB = [birthYear intValue];
    int monthN = [currentMonth intValue];
    int monthB = [birthMonth intValue];
    int dayN = [currentDay intValue];
    int dayB = [birthDay intValue];
    
    int ALB = yearN - yearB;
    int newALB;
    int newANB;
    
    NSString *msgAge;
    if (yearN > yearB)
    {
        if (monthN < monthB) {
            newALB = ALB - 1;
        } else if (monthN == monthB && dayN < dayB) {
            newALB = ALB - 1;
        } else {
            newALB = ALB;
        }
        
        if (monthN > monthB) {
            newANB = ALB + 1;
        } else if (monthN == monthB && dayN >= dayB) {
            newANB = ALB + 1;
        } else {
            newANB = ALB;
        }
    }
    else {
        newALB = 0;
    }
    msgAge = [[NSString alloc] initWithFormat:@"%d",newALB];
    
	return msgAge;
}

@end
