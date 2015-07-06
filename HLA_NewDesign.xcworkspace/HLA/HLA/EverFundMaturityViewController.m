//
//  EverFundMaturityViewController.m
//  iMobile Planner
//
//  Created by infoconnect on 7/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "EverFundMaturityViewController.h"
#import "PopOverFundViewController.h"
#import "ColorHexCode.h"
#import "AppDelegate.h"

@interface EverFundMaturityViewController ()

@end

BOOL exist;

@implementation EverFundMaturityViewController
@synthesize outletDelete,outletFund,outletOptions, outletTableLabel, SINo;
@synthesize txt2025,txt2028,txt2030,txt2035,txtCashFund,txtPercentageReinvest,txtSecureFund, txtDanaFund, myTableView;
@synthesize a2025,a2028,a2030,a2035,aCashFund,aFundOption,aMaturityFund,aSecureFund,aPercent,outletEdit, aDanaFund;
@synthesize indexPaths,ItemToBeDeleted;
@synthesize FundList = _FundList;
@synthesize FundPopover = _FundPopover;
@synthesize delegate = _delegate;

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
	// Do any additional setup after loading the view.
	self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsDir = [dirPaths objectAtIndex:0];
	databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	

	outletDelete.hidden = YES;
	outletEdit.hidden = NO;
	outletTableLabel.hidden = YES;
	myTableView.hidden = YES;
	myTableView.delegate = self;
	myTableView.dataSource = self;
	
	myTableView.rowHeight = 50;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.separatorColor = [UIColor clearColor];
    myTableView.opaque = NO;
    myTableView.backgroundView = nil;
    [self.view addSubview:myTableView];
	
	UIFont *font = [UIFont boldSystemFontOfSize:16.0f];
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
														   forKey:UITextAttributeFont];
	[outletOptions setTitleTextAttributes:attributes
							   forState:UIControlStateNormal];
	
	txtPercentageReinvest.enabled = FALSE;
	txtPercentageReinvest.backgroundColor = [UIColor lightGrayColor];
	outletOptions.enabled =FALSE;
	txt2025.delegate = self;
	txt2028.delegate = self;
	txt2030.delegate = self;
	txt2035.delegate = self;
	txtCashFund.delegate = self;
	txtSecureFund.delegate = self;
	txtDanaFund.delegate = self;
	exist = FALSE;
	
	ItemToBeDeleted = [[NSMutableArray alloc] init];
    indexPaths = [[NSMutableArray alloc] init];
	outletDelete.enabled = FALSE;
	[outletDelete setBackgroundImage:[[UIImage imageNamed:@"iphone_delete_button.png"] stretchableImageWithLeftCapWidth:8.0f topCapHeight:0.0f] forState:UIControlStateNormal];
    [outletDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	outletDelete.titleLabel.shadowColor = [UIColor lightGrayColor];
    outletDelete.titleLabel.shadowOffset = CGSizeMake(0, -1);
	
	[outletEdit setBackgroundImage:[[UIImage imageNamed:@"iphone_delete_button.png"] stretchableImageWithLeftCapWidth:8.0f topCapHeight:0.0f] forState:UIControlStateNormal];
    [outletEdit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	outletEdit.titleLabel.shadowColor = [UIColor lightGrayColor];
    outletEdit.titleLabel.shadowOffset = CGSizeMake(0, -1);
	
	[self GetExisting];
	[self toggleFund];
	
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
	/*
	 + 	 self.headerTitle.frame = CGRectMake(309, -20, 151, 44);
	 + 	 self.myToolBar.frame = CGRectMake(0, 0, 768, 44);
	 + 	 self.view.frame = CGRectMake(0, 20, 768, 1004); */
	
	self.view.frame = CGRectMake(0, 0, 788, 1004);
	[super viewWillAppear:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)myTableView numberOfRowsInSection:(NSInteger)section
{
    return  [aMaturityFund count];
}

- (UITableViewCell *)tableView:(UITableView *)myTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
	[[cell.contentView viewWithTag:2001] removeFromSuperview ];
    [[cell.contentView viewWithTag:2002] removeFromSuperview ];
    [[cell.contentView viewWithTag:2003] removeFromSuperview ];
    [[cell.contentView viewWithTag:2004] removeFromSuperview ];
    [[cell.contentView viewWithTag:2005] removeFromSuperview ];
    [[cell.contentView viewWithTag:2006] removeFromSuperview ];
    [[cell.contentView viewWithTag:2007] removeFromSuperview ];
    [[cell.contentView viewWithTag:2008] removeFromSuperview ];
    [[cell.contentView viewWithTag:2009] removeFromSuperview ];
    [[cell.contentView viewWithTag:2010] removeFromSuperview ];
	[[cell.contentView viewWithTag:2011] removeFromSuperview ];
	
	ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    int y = 0;
	int height = 50;
	int FontSize = 14;
	
	CGRect frame=CGRectMake(0,y, 145, height);
    UILabel *label1=[[UILabel alloc]init];
    label1.frame=frame;
    label1.text= [NSString stringWithFormat:@"%@", [aMaturityFund objectAtIndex:indexPath.row] ];
    label1.textAlignment = UITextAlignmentCenter;
    label1.tag = 2001;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label1];
	
	CGRect frame2=CGRectMake(frame.origin.x + frame.size.width, y, 70, height);
    UILabel *label2=[[UILabel alloc]init];
    label2.frame=frame2;
    label2.text= [NSString stringWithFormat:@"%@", [aFundOption objectAtIndex:indexPath.row] ];
    label2.textAlignment = UITextAlignmentCenter;
    label2.tag = 2002;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label2];
	
	CGRect frame3=CGRectMake(frame2.origin.x + frame2.size.width, y, 55, height);
    UILabel *label3=[[UILabel alloc]init];
    label3.frame=frame3;
	if ([[aFundOption objectAtIndex:indexPath.row] isEqualToString:@"ReInvest" ]) {
		label3.text= [NSString stringWithFormat:@"%d", 100];
	}
	else if ([[aFundOption objectAtIndex:indexPath.row] isEqualToString:@"Withdraw" ]) {
		label3.text= [NSString stringWithFormat:@"%d", 0];
	}
	else if ([[aFundOption objectAtIndex:indexPath.row] isEqualToString:@"Partial" ]) {
		label3.text= [NSString stringWithFormat:@"%d", [[aPercent objectAtIndex:indexPath.row] intValue ]];
	}
    label3.textAlignment = UITextAlignmentCenter;
    label3.tag = 2003;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label3];
	
	CGRect frame4=CGRectMake(frame3.origin.x + frame3.size.width, y, 55, height);
    UILabel *label4=[[UILabel alloc]init];
    label4.frame=frame4;
    //label4.text= [NSString stringWithFormat:@"%d", [[aPercent objectAtIndex:indexPath.row] intValue ] ];
	if ([[aFundOption objectAtIndex:indexPath.row] isEqualToString:@"ReInvest" ]) {
		label4.text= [NSString stringWithFormat:@"%d", 0];
	}
	else if ([[aFundOption objectAtIndex:indexPath.row] isEqualToString:@"Withdraw" ]) {
		label4.text= [NSString stringWithFormat:@"%d", 100];
	}
	else if ([[aFundOption objectAtIndex:indexPath.row] isEqualToString:@"Partial" ]) {
		label4.text= [NSString stringWithFormat:@"%d", 100 - [[aPercent objectAtIndex:indexPath.row] intValue ]];
	}
    label4.textAlignment = UITextAlignmentCenter;
    label4.tag = 2004;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label4];
	
	CGRect frame5=CGRectMake(frame4.origin.x + frame4.size.width, y, 50, height);
    UILabel *label5=[[UILabel alloc]init];
    label5.frame=frame5;
    label5.text= [NSString stringWithFormat:@"%@", [a2025 objectAtIndex:indexPath.row]];
    label5.textAlignment = UITextAlignmentCenter;
    label5.tag = 2005;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label5];
	
	CGRect frame6=CGRectMake(frame5.origin.x + frame5.size.width,y, 53, height);
    UILabel *label6=[[UILabel alloc]init];
    label6.frame=frame6;
    label6.text= [NSString stringWithFormat:@"%@", [a2028 objectAtIndex:indexPath.row]];
    label6.textAlignment = UITextAlignmentCenter;
    label6.tag = 2006;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label6];
	
	CGRect frame7=CGRectMake(frame6.origin.x + frame6.size.width,y, 53, height);
    UILabel *label7=[[UILabel alloc]init];
    label7.frame=frame7;
    label7.text= [NSString stringWithFormat:@"%@", [a2030 objectAtIndex:indexPath.row]];
    label7.textAlignment = UITextAlignmentCenter;
    label7.tag = 2007;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label7];

	CGRect frame8=CGRectMake(frame7.origin.x + frame7.size.width,y, 53, height);
    UILabel *label8=[[UILabel alloc]init];
    label8.frame=frame8;
    label8.text= [NSString stringWithFormat:@"%@", [a2035 objectAtIndex:indexPath.row]];
    label8.textAlignment = UITextAlignmentCenter;
    label8.tag = 2008;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label8];
	/*
	CGRect frame9=CGRectMake(frame8.origin.x + frame8.size.width,y, 50, 50);
    UILabel *label9=[[UILabel alloc]init];
    label9.frame=frame9;
    label9.text= [NSString stringWithFormat:@"0"];
    label9.textAlignment = UITextAlignmentCenter;
    label9.tag = 2009;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label9];
	*/
	
	CGRect frame10=CGRectMake(frame8.origin.x + frame8.size.width,y, 53, height);
    UILabel *label10=[[UILabel alloc]init];
    label10.frame=frame10;
    label10.text= [NSString stringWithFormat:@"%@", [aDanaFund objectAtIndex:indexPath.row]];
    label10.textAlignment = UITextAlignmentCenter;
    label10.tag = 2009;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label10];
	
	CGRect frame11=CGRectMake(frame10.origin.x + frame10.size.width,y, 53, height);
    UILabel *label11=[[UILabel alloc]init];
    label11.frame=frame11;
    label11.text= [NSString stringWithFormat:@"%@", [aSecureFund objectAtIndex:indexPath.row]];
    label11.textAlignment = UITextAlignmentCenter;
    label11.tag = 2010;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label11];
	
	
	CGRect frame12=CGRectMake(frame11.origin.x + frame11.size.width,y, 60, height);
    UILabel *label12=[[UILabel alloc]init];
    label12.frame=frame12;
    label12.text= [NSString stringWithFormat:@"%@", [aCashFund objectAtIndex:indexPath.row]];
    label12.textAlignment = UITextAlignmentCenter;
    label12.tag = 2011;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label12];
	
	if (indexPath.row % 2 == 0) {
        label1.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label2.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label3.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label3.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		label4.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		label5.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		label6.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		label7.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		label8.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		//label9.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		label10.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		label11.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label12.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
		
        label1.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
        label2.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
        label3.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label4.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label5.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label6.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label7.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label8.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		//label9.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
        label10.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label11.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label12.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
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
		//label9.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        label10.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
		label11.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
		label12.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
		
        label1.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
        label2.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
        label3.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label4.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label5.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label6.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label7.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label8.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		//label9.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
        label10.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label11.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
		label12.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    }
	
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	exist = TRUE;
	
	if ([myTableView isEditing] == TRUE ) {
        BOOL gotRowSelected = FALSE;
        
        for (UITableViewCell *zzz in [myTableView visibleCells])
        {
            if (zzz.selected  == TRUE) {
                gotRowSelected = TRUE;
                break;
            }
        }
        
        if (!gotRowSelected) {
            [outletDelete setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
			outletDelete.enabled = FALSE;
        }
        else {
            [outletDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
			outletDelete.enabled = TRUE;
        }
        
        NSString *zzz = [NSString stringWithFormat:@"%d", indexPath.row];
        [ItemToBeDeleted addObject:zzz];
        [indexPaths addObject:indexPath];
		
		//NSLog(@"%d", ItemToBeDeleted.count);
    }
	else{
		[outletFund setTitle:[aMaturityFund objectAtIndex:indexPath.row] forState:UIControlStateNormal];
		if ([[aFundOption objectAtIndex:indexPath.row] isEqualToString:@"ReInvest" ]) {
			outletOptions.selectedSegmentIndex = 0;
		}
		else if ([[aFundOption objectAtIndex:indexPath.row] isEqualToString:@"Withdraw" ]){
			outletOptions.selectedSegmentIndex = 1;
		}
		else{
			outletOptions.selectedSegmentIndex = 2;
		}
		txtPercentageReinvest.text = [NSString stringWithFormat:@"%.0f", [[aPercent objectAtIndex:indexPath.row] doubleValue]];
		txt2025.text = [NSString stringWithFormat:@"%.0f", [[a2025 objectAtIndex:indexPath.row] doubleValue]];
		txt2028.text = [NSString stringWithFormat:@"%.0f", [[a2028 objectAtIndex:indexPath.row] doubleValue]];
		txt2030.text = [NSString stringWithFormat:@"%.0f", [[a2030 objectAtIndex:indexPath.row] doubleValue]];
		txt2035.text = [NSString stringWithFormat:@"%.0f", [[a2035 objectAtIndex:indexPath.row] doubleValue]];
		txtCashFund.text = [NSString stringWithFormat:@"%.0f", [[aCashFund objectAtIndex:indexPath.row] doubleValue]];
		txtSecureFund.text = [NSString stringWithFormat:@"%.0f", [[aSecureFund objectAtIndex:indexPath.row] doubleValue]];
		txtDanaFund.text = [NSString stringWithFormat:@"%.0f", [[aDanaFund objectAtIndex:indexPath.row] doubleValue]];
		outletOptions.enabled = TRUE;
		[self toggleFund];
	}
	
	
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
	if ([myTableView isEditing] == TRUE ) {
        BOOL gotRowSelected = FALSE;
        
        for (UITableViewCell *zzz in [myTableView visibleCells])
        {
            if (zzz.selected  == TRUE) {
                gotRowSelected = TRUE;
                break;
            }
        }
        
        if (!gotRowSelected) {
            [outletDelete setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
			outletDelete.enabled = FALSE;
        }
        else {
            [outletDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
			outletDelete.enabled = TRUE;
        }
        
        NSString *zzz = [NSString stringWithFormat:@"%d", indexPath.row];
        [ItemToBeDeleted removeObject:zzz];
        [indexPaths removeObject:indexPath];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
	
	if ([string length ] == 0) {
		return  YES;
	}
	
	if (textField.text.length > 2) {
		return NO;
	}
	
	NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
	if ([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound) {
		return NO;
	}
	
	return  YES;
}

#pragma mark - delegate
-(void)Fundlisting:(PopOverFundViewController *)inController andDesc:(NSString *)aaDesc{
	
	[outletFund setTitle:aaDesc forState:UIControlStateNormal];
	[self.FundPopover dismissPopoverAnimated:YES];
	//outletOptions.selectedSegmentIndex = 0;
	[self DisplayData];
	/*
	if (outletOptions.selectedSegmentIndex != 1) {
		exist = FALSE;
		[self toggleFund];
		[self DisplayData];
	}
	else{
		txt2025.text = @"0";
		txt2028.text = @"0";
		txt2030.text = @"0";
		txt2035.text = @"0";
		txtCashFund.text = @"0";
		txtSecureFund.text = @"0";
		txtPercentageReinvest.text = @"0";
		txt2025.enabled = FALSE;
		txt2028.enabled = FALSE;
		txt2030.enabled = FALSE;
		txt2035.enabled = FALSE;
		txtCashFund.enabled = FALSE;
		txtSecureFund.enabled = FALSE;
		txtPercentageReinvest.enabled = FALSE;
		txt2025.backgroundColor = [UIColor lightGrayColor];
		txt2028.backgroundColor = [UIColor lightGrayColor];
		txt2030.backgroundColor = [UIColor lightGrayColor];
		txt2035.backgroundColor = [UIColor lightGrayColor];
		txtCashFund.backgroundColor = [UIColor lightGrayColor];
		txtSecureFund.backgroundColor = [UIColor lightGrayColor];
		txtPercentageReinvest.backgroundColor = [UIColor lightGrayColor];
	}
	 */
	
	outletOptions.enabled = TRUE;
}

#pragma mark - handle data
-(void)DisplayData{

	NSRange search;
	for (int a =0; a<aMaturityFund.count; a++ ) {
		search = [[aMaturityFund objectAtIndex:a ] rangeOfString:outletFund.titleLabel.text options:NSCaseInsensitiveSearch];
		
		if (search.location != NSNotFound) {
			exist = TRUE;

			if ([[aFundOption objectAtIndex:a] isEqualToString:@"ReInvest" ]) {
					outletOptions.selectedSegmentIndex = 0;
			}
			else if ([[aFundOption objectAtIndex:a] isEqualToString:@"Withdraw" ]){
				outletOptions.selectedSegmentIndex = 1;
			}
			else{
				outletOptions.selectedSegmentIndex = 2;
			}
			txtPercentageReinvest.text = [NSString stringWithFormat:@"%.0f", [[aPercent objectAtIndex:a] doubleValue]];
			txt2025.text = [NSString stringWithFormat:@"%.0f", [[a2025 objectAtIndex:a] doubleValue]];
			txt2028.text = [NSString stringWithFormat:@"%.0f", [[a2028 objectAtIndex:a] doubleValue]];
			txt2030.text = [NSString stringWithFormat:@"%.0f", [[a2030 objectAtIndex:a] doubleValue]];
			txt2035.text = [NSString stringWithFormat:@"%.0f", [[a2035 objectAtIndex:a] doubleValue]];
			txtCashFund.text = [NSString stringWithFormat:@"%.0f", [[aCashFund objectAtIndex:a] doubleValue]];
			txtSecureFund.text = [NSString stringWithFormat:@"%.0f", [[aSecureFund objectAtIndex:a] doubleValue]];
			txtSecureFund.text = [NSString stringWithFormat:@"%.0f", [[aSecureFund objectAtIndex:a] doubleValue]];
			txtDanaFund.text = [NSString stringWithFormat:@"%.0f", [[aDanaFund objectAtIndex:a] doubleValue]];
			[self toggleFund];
			break;
		}
	}
	
	if (search.location == NSNotFound) { //new
		exist = FALSE;
		txtPercentageReinvest.text = @"0";
		txt2025.text = @"0";
		txt2028.text = @"0";
		txt2030.text = @"0";
		txt2035.text = @"0";
		txtCashFund.text = @"100";
		txtSecureFund.text = @"0";
		txtDanaFund.text = @"0";
		[self toggleFund];
	}
	
}



- (IBAction)ACtionDone:(id)sender {
	//myTableView.hidden = FALSE;
	//outletTableLabel.hidden = FALSE;
	/*
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
	
	AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
	if (![zzz.EverMessage isEqualToString:@""]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:zzz.EverMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		alert.tag = 1007;
        [alert show];
		zzz.EverMessage = @"";
	}
	else{
		if ([self Validation] == TRUE) {
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
															message:@"Confirm changes?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL",nil];
			[alert setTag:1001];
			[alert show];
			
		}
	}
	*/
	[_delegate FundMaturityGlobalSave];
		
}

- (IBAction)ActionAdd:(id)sender {
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
	
	AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
	if (![zzz.EverMessage isEqualToString:@""]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:zzz.EverMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		alert.tag = 1007;
        [alert show];
		zzz.EverMessage = @"";
	}
	else{
		if ([self Validation] == TRUE) {
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
															message:@"Confirm changes?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL",nil];
			[alert setTag:1001];
			[alert show];
			
		}
	}
	
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (alertView.tag == 1001 && buttonIndex == 0) {
		
		[self InsertandUpdate];
	}
	if (alertView.tag == 1002) {
		
		if (ItemToBeDeleted.count < 1) {
            return;
        }
        else{
            NSLog(@"itemToBeDeleted:%d", ItemToBeDeleted.count);
        }
		
		[self DeleteFund];
	}
	else if (alertView.tag == 1007 && buttonIndex == 0) {
		
		if ([self Validation] == TRUE) {
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
															message:@"Confirm changes?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL",nil];
			[alert setTag:1001];
			[alert show];
			
		}
	}
	

}

-(void)InsertandUpdate{
	
	 if (exist == TRUE) {
		 sqlite3_stmt *statement;
		 if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
		 {
				NSString *querySQL = [NSString stringWithFormat: @"Update UL_Fund_Maturity_Option SET Option = '%@', "
										"Partial_Withd_Pct='%@', EverGreen2025='%@', "
									  "EverGreen2028= '%@', EverGreen2030='%@', EverGreen2035='%@', CashFund='%@', RetireFund='%@', DanaFund='%@' "
									  " Where sino = '%@' AND Fund = '%@' ",
									  [self ReturnOption], txtPercentageReinvest.text, txt2025.text,
									  txt2028.text, txt2030.text, txt2035.text, txtCashFund.text, txtSecureFund.text, txtDanaFund.text, SINo, outletFund.titleLabel.text];
			 if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
				 if (sqlite3_step(statement) == SQLITE_DONE){
	 
				 }
				 sqlite3_finalize(statement);
			 }
			 sqlite3_close(contactDB);
		 }
	 }
	 else{
		 sqlite3_stmt *statement;
		 if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
		 {
			 NSString *querySQL = [NSString stringWithFormat: @"INSERT INTO UL_Fund_Maturity_Option(SINO, Fund, Option, Partial_Withd_Pct, EverGreen2025,"
								   "EverGreen2028, EverGreen2030, EverGreen2035, CashFund, RetireFund, DanaFund) VALUES('%@', '%@', '%@', "
								   "'%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@') ",
								   SINo, outletFund.titleLabel.text, [self ReturnOption], txtPercentageReinvest.text, txt2025.text,
								   txt2028.text, txt2030.text, txt2035.text, txtCashFund.text, txtSecureFund.text, txtDanaFund.text];
			 if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
				 if (sqlite3_step(statement) == SQLITE_DONE){
					 exist = TRUE;
				 }
				 sqlite3_finalize(statement);
			 }
			 sqlite3_close(contactDB);
		 }
	 }
	 
	
	[self GetExisting];
	[self.myTableView reloadData];

}

-(void)DeleteFund{
	sqlite3_stmt *statement;

	NSArray *sorted = [[NSArray alloc] init ];
	sorted = [ItemToBeDeleted sortedArrayUsingComparator:^(id firstObject, id secondObject){
		return [((NSString *)firstObject) compare:((NSString *)secondObject) options:NSNumericSearch];
	}];
	
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
	{
		for(int a=0; a<sorted.count; a++) {
			int value = [[sorted objectAtIndex:a] intValue];
			//value = value - a;
			
			NSString *Fund = [aMaturityFund objectAtIndex:value];
			/*
			NSString *querySQL = [NSString stringWithFormat:
								  @"DELETE FROM UL_Fund_Maturity_Option WHERE SINo=\"%@\" AND Fund=\"%@\"",
								  SINo, Fund];
			*/
			NSString *querySQL = [NSString stringWithFormat:
								  @"UPDATE UL_Fund_Maturity_Option SET option = 'ReInvest', partial_withd_pct ='0', "
								  "EverGreen2025='0',EverGreen2028='0',EverGreen2030='0',EverGreen2035='0',CashFund='100', "
								  "RetireFund='0', DanaFund='0' WHERE SINo=\"%@\" AND Fund=\"%@\"",
								  SINo, Fund];
			//NSLog(@"%@", querySQL);
			if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{
				if (sqlite3_step(statement) == SQLITE_DONE)
				{
					NSLog(@"fund delete!");
				} else {
					NSLog(@"fund delete Failed!");
				}
				sqlite3_finalize(statement);
			}
			/*
			[aMaturityFund removeObjectAtIndex:value];
			[aFundOption removeObjectAtIndex:value];
			[a2025 removeObjectAtIndex:value];
			[a2028 removeObjectAtIndex:value];
			[a2030 removeObjectAtIndex:value];
			[a2035 removeObjectAtIndex:value];
			[aSecureFund removeObjectAtIndex:value];
			[aCashFund removeObjectAtIndex:value];
			[aPercent removeObjectAtIndex:value];
			*/
		}
		sqlite3_close(contactDB);
	}
	
	//[myTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
	[self GetExisting];
	[self.myTableView reloadData];
	
	ItemToBeDeleted = [[NSMutableArray alloc] init];
	indexPaths = [[NSMutableArray alloc] init];
	
	outletDelete.enabled = FALSE;
	[outletDelete setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];

	[self.outletFund setTitle:@"Please Select" forState:UIControlStateNormal];
	 
}

-(void)GetExisting{
	
	a2025 = [[NSMutableArray alloc] init ];
	a2028 = [[NSMutableArray alloc] init ];
	a2030 = [[NSMutableArray alloc] init ];
	a2035 = [[NSMutableArray alloc] init ];
	aCashFund = [[NSMutableArray alloc] init ];
	aSecureFund = [[NSMutableArray alloc] init ];
	aPercent = [[NSMutableArray alloc] init ];
	aFundOption = [[NSMutableArray alloc] init ];
	aMaturityFund = [[NSMutableArray alloc] init ];
	aDanaFund = [[NSMutableArray alloc] init ];
	
	sqlite3_stmt *statement;
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
	{
		NSString *querySQL = [NSString stringWithFormat: @"Select Fund, Option, Partial_Withd_Pct, EverGreen2025, "
							  "EverGreen2028, EverGreen2030, EverGreen2035, CashFund, RetireFund, DanaFund From UL_Fund_Maturity_Option where SINO = '%@'  ",
							SINo];
		
		//NSLog(@"%@", querySQL);
		if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
			while (sqlite3_step(statement) == SQLITE_ROW){
				
				[aMaturityFund addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)]];
				[aFundOption addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)]];
				[aPercent addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)]];
				[a2025 addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)]];
				[a2028 addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)]];
				[a2030 addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)]];
				[a2035 addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 6)]];
				[aCashFund addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 7)]];
				[aSecureFund addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 8)]];
				[aDanaFund addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 9)]];
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
	if ([aMaturityFund count] > 0) {
		myTableView.hidden = NO;
		outletTableLabel.hidden = NO;
		[myTableView reloadData];
		outletEdit.hidden = NO;
	}
	else{
		outletDelete.hidden = YES;
		outletEdit.hidden = YES;
		myTableView.hidden = YES;
		outletTableLabel.hidden = YES;
	}

}

-(NSString*)ReturnOption{
	if (outletOptions.selectedSegmentIndex  == 0) {
		return @"ReInvest";
	}
	else if (outletOptions.selectedSegmentIndex == 1){
		return @"Withdraw";
	}
	else{
		return @"Partial";
	}
	
}

-(void)ValidateString{
	if ([txt2025.text isEqualToString:@""]) {
		txt2025.text = @"0";
	}
	if ([txt2028.text isEqualToString:@""]) {
		txt2028.text = @"0";
	}
	if ([txt2030.text isEqualToString:@""]) {
		txt2030.text = @"0";
	}
	if ([txt2035.text isEqualToString:@""]) {
		txt2035.text = @"0";
	}
	if ([txtCashFund.text isEqualToString:@""]) {
		txtCashFund.text = @"0";
	}
	if ([txtSecureFund.text isEqualToString:@""]) {
		txtSecureFund.text = @"0";
	}
	if ([txtDanaFund.text isEqualToString:@""]) {
		txtDanaFund.text = @"0";
	}
	
}

- (BOOL)Validation{
	[self ValidateString];
	
	if ([outletFund.titleLabel.text isEqualToString:@"Please Select"]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
														message:@"Please select a Maturity Fund." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];

		return FALSE;
	}
	
	if (outletOptions.selectedSegmentIndex == 2) {
		if ([[txtPercentageReinvest.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@"" ]) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
															message:@"Percentage ReInvest must be greater than 0" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
			[alert show];
			[txtPercentageReinvest becomeFirstResponder ];
			return  FALSE;
		}
		
		if ([txtPercentageReinvest.text intValue ] == 0) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
															message:@"Percentage ReInvest must be greater than 0" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
			[alert show];
			[txtPercentageReinvest becomeFirstResponder ];
			return  FALSE;
		}
	}
	
	if (outletOptions.selectedSegmentIndex != 1) {
		if ([txt2025.text intValue ] + [txt2028.text intValue ] + [txt2030.text intValue ] + [txt2035.text intValue ] +
			[txtCashFund.text intValue ] + [txtSecureFund.text intValue ] + [txtDanaFund.text intValue] != 100) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner"
															message:@"Total Fund Percentage must be 100%" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
			[alert show];
			return  FALSE;
		}
	}
	

	return  TRUE;
}

- (void)viewDidUnload {
	[self setOutletFund:nil];
	[self setOutletOptions:nil];
	[self setTxtPercentageReinvest:nil];
	[self setTxt2025:nil];
	[self setTxt2030:nil];
	[self setTxtSecureFund:nil];
	[self setTxt2028:nil];
	[self setTxt2035:nil];
	[self setTxtCashFund:nil];
	[self setOutletDelete:nil];
	[self setMyTableView:nil];
	[self setOutletTableLabel:nil];
	[self setOutletEdit:nil];
	[self setOutletEdit:nil];
	[self setOutletDelete:nil];
	[self setOutletEdit:nil];
	[self setTxtDanaFund:nil];
	[self setTxtDanaFund:nil];
	[super viewDidUnload];
}

- (IBAction)ActionOptions:(id)sender {
	if (outletOptions.selectedSegmentIndex == 2) {
		txtPercentageReinvest.enabled = TRUE;
		txtPercentageReinvest.backgroundColor = [UIColor whiteColor];
	}
	else{
		txtPercentageReinvest.enabled = FALSE;
		txtPercentageReinvest.backgroundColor = [UIColor lightGrayColor];
		txtPercentageReinvest.text = @"0";
	}
	
	if (outletOptions.selectedSegmentIndex == 1) {
		txt2025.text = @"0";
		txt2028.text = @"0";
		txt2030.text = @"0";
		txt2035.text = @"0";
		txtCashFund.text = @"0";
		txtSecureFund.text = @"0";
		txtDanaFund.text = @"0";
		txtPercentageReinvest.text = @"0";
		txt2025.enabled = FALSE;
		txt2028.enabled = FALSE;
		txt2030.enabled = FALSE;
		txt2035.enabled = FALSE;
		txtCashFund.enabled = FALSE;
		txtSecureFund.enabled = FALSE;
		txtDanaFund.enabled = FALSE;
		txtPercentageReinvest.enabled = FALSE;
		txt2025.backgroundColor = [UIColor lightGrayColor];
		txt2028.backgroundColor = [UIColor lightGrayColor];
		txt2030.backgroundColor = [UIColor lightGrayColor];
		txt2035.backgroundColor = [UIColor lightGrayColor];
		txtCashFund.backgroundColor = [UIColor lightGrayColor];
		txtSecureFund.backgroundColor = [UIColor lightGrayColor];
		txtDanaFund.backgroundColor = [UIColor lightGrayColor];
		txtPercentageReinvest.backgroundColor = [UIColor lightGrayColor];
	}
	else{
		[self toggleFund];
	}
}

-(void)toggleFund{
	
	if (outletOptions.selectedSegmentIndex == 1 || [outletFund.titleLabel.text isEqualToString:@"Please Select"]) {
		txt2025.text = @"0";
		txt2028.text = @"0";
		txt2030.text = @"0";
		txt2035.text = @"0";
		txtCashFund.text = @"0";
		txtSecureFund.text = @"0";
		txtDanaFund.text = @"0";
		txtPercentageReinvest.text = @"0";
		txt2025.enabled = FALSE;
		txt2028.enabled = FALSE;
		txt2030.enabled = FALSE;
		txt2035.enabled = FALSE;
		txtCashFund.enabled = FALSE;
		txtSecureFund.enabled = FALSE;
		txtDanaFund.enabled = FALSE;
		txtPercentageReinvest.enabled = FALSE;
	}
	else{
		if (outletOptions.selectedSegmentIndex == 2) {
			txtPercentageReinvest.enabled = TRUE;
		}
		else{
			txtPercentageReinvest.enabled = FALSE;
		}
		
		if ([outletFund.titleLabel.text isEqualToString:@"HLA EverGreen 2035"]) {
			txt2025.text = @"0";
			txt2028.text = @"0";
			txt2030.text = @"0";
			txt2035.text = @"0";
			txt2025.enabled = FALSE;
			txt2028.enabled = FALSE;
			txt2030.enabled = FALSE;
			txt2035.enabled = FALSE;
			txtCashFund.enabled = TRUE;
			txtSecureFund.enabled = TRUE;
			txtDanaFund.enabled = TRUE;
		}
		else if ([outletFund.titleLabel.text isEqualToString:@"HLA EverGreen 2030"]) {
			txt2025.text = @"0";
			txt2028.text = @"0";
			txt2030.text = @"0";
			txt2025.enabled = FALSE;
			txt2028.enabled = FALSE;
			txt2030.enabled = FALSE;
			txt2035.enabled = TRUE;
			txtCashFund.enabled = TRUE;
			txtSecureFund.enabled = TRUE;
			txtDanaFund.enabled = TRUE;
		}
		else if ([outletFund.titleLabel.text isEqualToString:@"HLA EverGreen 2028"]) {
			txt2025.text = @"0";
			txt2028.text = @"0";
			txt2025.enabled = FALSE;
			txt2028.enabled = FALSE;
			txt2030.enabled = TRUE;
			txt2035.enabled = TRUE;
			txtCashFund.enabled = TRUE;
			txtSecureFund.enabled = TRUE;
			txtDanaFund.enabled = TRUE;
		}
		else if ([outletFund.titleLabel.text isEqualToString:@"HLA EverGreen 2025"]) {
			txt2025.text = @"0";
			txt2025.enabled = FALSE;
			txt2028.enabled = TRUE;
			txt2030.enabled = TRUE;
			txt2035.enabled = TRUE;
			txtCashFund.enabled = TRUE;
			txtSecureFund.enabled = TRUE;
			txtDanaFund.enabled = TRUE;
		}
		else if ([outletFund.titleLabel.text isEqualToString:@"HLA EverGreen 2023"]) {
			txt2025.enabled = TRUE;
			txt2028.enabled = TRUE;
			txt2030.enabled = TRUE;
			txt2035.enabled = TRUE;
			txtCashFund.enabled = TRUE;
			txtSecureFund.enabled = TRUE;
			txtDanaFund.enabled = TRUE;
		}
		
	}
	
	if (txt2025.enabled == FALSE) {
		txt2025.backgroundColor = [UIColor lightGrayColor];
	}
	else{
		txt2025.backgroundColor = [UIColor whiteColor];
	}
	
	if (txt2028.enabled == FALSE) {
		txt2028.backgroundColor = [UIColor lightGrayColor];
	}
	else{
		txt2028.backgroundColor = [UIColor whiteColor];
	}
	
	if (txt2030.enabled == FALSE) {
		txt2030.backgroundColor = [UIColor lightGrayColor];
	}
	else{
		txt2030.backgroundColor = [UIColor whiteColor];
	}
	
	if (txt2035.enabled == FALSE) {
		txt2035.backgroundColor = [UIColor lightGrayColor];
	}
	else{
		txt2035.backgroundColor = [UIColor whiteColor];
	}
	
	if (txtCashFund.enabled == FALSE) {
		txtCashFund.backgroundColor = [UIColor lightGrayColor];
	}
	else{
		txtCashFund.backgroundColor = [UIColor whiteColor];
	}
	
	if (txtPercentageReinvest.enabled == FALSE) {
		txtPercentageReinvest.backgroundColor = [UIColor lightGrayColor];
	}
	else{
		txtPercentageReinvest.backgroundColor = [UIColor whiteColor];
	}
	
	if (txtSecureFund.enabled == FALSE) {
		txtSecureFund.backgroundColor = [UIColor lightGrayColor];
	}
	else{
		txtSecureFund.backgroundColor = [UIColor whiteColor];
	}
	
	if (txtDanaFund.enabled == FALSE) {
		txtDanaFund.backgroundColor = [UIColor lightGrayColor];
	}
	else{
		txtDanaFund.backgroundColor = [UIColor whiteColor];
	}
}

- (IBAction)ACtionFund:(id)sender {
	if(_FundList == nil){
        
		self.FundList = [[PopOverFundViewController alloc] initWithString:SINo];
        _FundList.delegate = self;
        self.FundPopover = [[UIPopoverController alloc] initWithContentViewController:_FundList];
	}
    [self.FundPopover setPopoverContentSize:CGSizeMake(350.0f, 300.0f)];
    [self.FundPopover presentPopoverFromRect:[sender frame] inView:self.view
					 permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	
}
- (IBAction)ActionDelete:(id)sender {
	NSString *ridCode;
    int RecCount = 0;
    for (UITableViewCell *cell in [myTableView visibleCells])
    {
        if (cell.selected == TRUE) {
            NSIndexPath *selectedIndexPath = [myTableView indexPathForCell:cell];
            if (RecCount == 0) {
                ridCode = [aMaturityFund objectAtIndex:selectedIndexPath.row];
            }
            
            RecCount = RecCount + 1;
            
            if (RecCount > 1) {
                break;
            }
        }
    }
    
    NSString *msg;
    if (RecCount == 1) {
        msg = [NSString stringWithFormat:@"Delete fund:%@",ridCode];
    }
    else {
        msg = @"Are you sure want to delete these Fund(s)?";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert setTag:1002];
    [alert show];
	
}

- (IBAction)ActionEdit:(id)sender {
	[self resignFirstResponder];
    if ([self.myTableView isEditing]) {
        [self.myTableView setEditing:NO animated:TRUE];
		outletDelete.hidden = true;
        [outletEdit setTitle:@"Edit" forState:UIControlStateNormal ];
        
		
        ItemToBeDeleted = [[NSMutableArray alloc] init];
        indexPaths = [[NSMutableArray alloc] init];
    }
    else{
        [self.myTableView setEditing:YES animated:TRUE];
		outletDelete.hidden = FALSE;
        [outletDelete setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
        [outletEdit setTitle:@"Cancel" forState:UIControlStateNormal ];
    }
}



@end
