//
//  Declaration.m
//  iMobile Planner
//
//  Created by Erza on 6/18/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "Declaration.h"
#import "ColorHexCode.h"
#import "DataClass.h"

@interface Declaration ()
{
    DataClass *obj;
}

@end

@implementation Declaration
@synthesize btnAgree,btnDisagree;
@synthesize agreed,disagreed;

- (void)viewDidLoad
{
    [super viewDidLoad];
     obj = [DataClass getInstance];
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"e-Application";
    self.navigationItem.titleView = label;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnDone:)];
    
	
//    //---retrieve data start---
//	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docsPath = [paths objectAtIndex:0];
//    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
//    FMDatabase *database = [FMDatabase databaseWithPath:path];
//    [database open];
//	stringID = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
//	NSLog(@"string id: %@, si: %@", stringID, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"]);
//	//SEC A - CO start
//	results2 = Nil;
//	//		while ([results next]) {
//	results2 = [database executeQuery:@"select * from  eProposal where eProposalNo = ?",stringID,Nil];
//	while ([results2 next]) {
//		[[obj.eAppData objectForKey:@"SecG"] setValue:[results2 stringForColumn:@"DeclarationAuthorization"] forKey:@"Declaration_agree"];
//	}
//	[results2 close];
//	[database close];
//	//---retrieve data end---
	
	
    agreed = NO;
    disagreed = NO;
    
agree =  [[obj.eAppData objectForKey:@"SecG"] objectForKey:@"Declaration_agree"];
    NSLog(@"agree %@", agree);
    if([agree isEqualToString:@"Y"])
    {
        [btnAgree setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        agreed = YES;
    }
    else if ([agree isEqualToString:@"N"])
    {
        [btnDisagree setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        disagreed = YES;

    }
       
}

- (void)btnDone:(id)sender
{
    
    
}

- (IBAction)isAgree:(id)sender
{

    UIButton *btnPressed = (UIButton*)sender;
    
    if (btnPressed.tag == 1) {

//        if (agreed) {
            [btnAgree setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            agreed = YES;
            
            [btnDisagree setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
            disagreed = NO;
//		[[obj.eAppData objectForKey:@"SecG"] setValue:@"Y" forKey:@"Declaration_agree"];
//        }
//        else {
//            [btnAgree setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
//            agreed = YES;
//            
//            [btnDisagree setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
//            disagreed = NO;
//        }
    }
    
    else if (btnPressed.tag == 2) {
 
//        if (disagreed) {
            [btnDisagree setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            disagreed = YES;
            
            [btnAgree setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
            agreed = NO;
//		[[obj.eAppData objectForKey:@"SecG"] setValue:@"N" forKey:@"Declaration_agree"];
//        }
//        else {
//            [btnDisagree setImage: [UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
//            disagreed = YES;
//            
//            [btnAgree setImage: [UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
//            agreed = NO;
//        }
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
