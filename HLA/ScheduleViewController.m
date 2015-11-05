//
//  ScheduleViewController.m
//  iMobile Planner
//
//  Created by Emi on 3/11/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ScheduleViewController.h"
#import "FMDatabase.h"

@interface ScheduleViewController ()


@end

@implementation ScheduleViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionBack:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)actionTanggal:(id)sender {
}

- (IBAction)actionWaktu:(id)sender {
}

- (IBAction)actionSave:(id)sender {
	
	NSUserDefaults *Cdefaults = [NSUserDefaults standardUserDefaults];
	NSInteger SalesActivity_ID = [Cdefaults integerForKey:@"SalesActivity_ID"];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsPath = [paths objectAtIndex:0];
	NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
	
	FMDatabase *db = [FMDatabase databaseWithPath:path];
	
	[db open];
	
	NSString *type = @"Contact";
	NSString *SelectStr = [NSString stringWithFormat:@"select * from SalesAct_LogActivity where SalesActivity_ID = %d and Type = \"%@\"'", SalesActivity_ID, type];
	
	FMResultSet *result = [db executeQuery:SelectStr];
	int ID = 0;
	while ([result next]) {
		ID = [result intForColumn:@"SalesActivity_ID"];
	}
	
	
	NSString *sqlQuery = @"";
//	if (ID == 0) {
//		sqlQuery = [NSString stringWithFormat:@"INSERT INTO SalesAct_LogActivity (Lokasi, SalesActivity_ID, CreateAt) VALUES (\"%@\", %d,  %@)", _txtTanggal.text, _txtWaktu.text, SalesActivity_ID, @"datetime(\"now\", \"+8 hour\")"];
//	}
//	else {
//		sqlQuery = [NSString stringWithFormat:@"UPDATE SalesAct_LogActivity SET Lokasi = '%@', UpdateAt = %@ where SalesActivity_ID = %d", _txtLokasi.text, @"datetime(\"now\", \"+8 hour\")", SalesActivity_ID ];
//	}
	
//	BOOL success = [db executeUpdate: sqlQuery];
	
//	if (success) {
//		NSLog(@"Success Update");
//		[self dismissModalViewControllerAnimated:YES];
//		
//	}
	
	[db close];
}
@end
