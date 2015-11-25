//
//  ViewControllerActivity.m
//  iMobile Planner
//
//  Created by Emi on 3/11/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ViewControllerActivity.h"
#import "FMDatabase.h"

@interface ViewControllerActivity ()

@end

@implementation ViewControllerActivity

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

- (IBAction)ActionPilihLokasi:(id)sender {
}

- (IBAction)ActionSave:(id)sender {
	
	NSUserDefaults *Cdefaults = [NSUserDefaults standardUserDefaults];
	NSInteger SalesActivity_ID = [Cdefaults integerForKey:@"SalesActivity_ID"];
	int state = [[Cdefaults stringForKey:@"StateAct"] integerValue];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsPath = [paths objectAtIndex:0];
	NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
	
	FMDatabase *db = [FMDatabase databaseWithPath:path];
	
	[db open];
	
	NSString *sqlQuery = @"";

	sqlQuery = [NSString stringWithFormat:@"UPDATE SalesAct_ActLogList SET StateAct = %d, Status = '%@', UpdateAt = %@ where SalesActivity_ID = %d", state, @"Activity", @"datetime(\"now\", \"+8 hour\")", SalesActivity_ID ];
	
	
	BOOL success = [db executeUpdate: sqlQuery];
	
	if (success) {
		NSLog(@"Success Update");
		
		state = state + 1;
		
		[Cdefaults setObject:[NSString stringWithFormat:@"%d",state] forKey:@"StateAct"];
		[Cdefaults synchronize];
		
		[self dismissViewControllerAnimated:YES completion:nil];

	}
	
	[db close];
	
}

- (IBAction)ActionBack:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
	
}
@end
