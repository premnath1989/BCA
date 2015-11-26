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
	NSString *state = [Cdefaults stringForKey:@"StateAct"];
	
	int state2 = [state integerValue] + 1;
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsPath = [paths objectAtIndex:0];
	NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
	
	FMDatabase *db = [FMDatabase databaseWithPath:path];
	
	[db open];
	
	NSString *sqlQuery = @"";
	if (state2 == 5){
		sqlQuery = [NSString stringWithFormat:@"UPDATE SalesAct_ActLogList SET StateAct = %d, Status = '%@', UpdateAt = %@ where SalesActivity_ID = %d", state2, @"Completed", @"datetime(\"now\", \"+8 hour\")", SalesActivity_ID ];
	}
	else {
		sqlQuery = [NSString stringWithFormat:@"UPDATE SalesAct_ActLogList SET StateAct = %d, Status = '%@', UpdateAt = %@ where SalesActivity_ID = %d", state2, @"Activity", @"datetime(\"now\", \"+8 hour\")", SalesActivity_ID ];
	}
	
	
	
	BOOL success = [db executeUpdate: sqlQuery];
	
	if (success) {
		NSLog(@"Success Update");
		
		
//		state = state + 1;
		
		[Cdefaults setObject:[NSString stringWithFormat:@"%d",state2] forKey:@"StateAct"];
		[Cdefaults synchronize];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeState" object:self];
		[self dismissViewControllerAnimated:YES completion:nil];

	}
	
	[db close];
	
}

- (IBAction)ActionBack:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeState" object:self];
	[self dismissViewControllerAnimated:YES completion:nil];
	
}
@end
