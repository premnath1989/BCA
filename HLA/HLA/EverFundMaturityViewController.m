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
@synthesize a2025,a2028,a2030,a2035,aCashFund,aFundOption,aMaturityFund,aSecureFund,aPercent,outletEdit, aDanaFund, aSmartFund, aVentureFund;
@synthesize indexPaths,ItemToBeDeleted, requesteProposalStatus, EAPPorSI, outletDone, OutletSave, outletEAPP, outletSpace, txtVentureFlexi;
@synthesize PlanCode, BasicTerm;
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
	appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate ];	

	if ([requesteProposalStatus isEqualToString:@"Created"] ||
		[requesteProposalStatus isEqualToString:@"Confirmed"] || [requesteProposalStatus isEqualToString:@"Submitted"] ||
		[requesteProposalStatus isEqualToString:@"Received"] || [EAPPorSI isEqualToString:@"eAPP"] || [requesteProposalStatus isEqualToString:@"Created"]) {
		Editable = NO;
	}
	else{
		Editable = YES;
	}
	
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
    txtVentureFlexi.delegate = self;
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
	
	outletEAPP.width = 0.01;
	outletSpace.width = 650;
	
	if (Editable == NO) {
		outletDelete.enabled = FALSE;
		outletEdit.enabled = FALSE;
		outletFund.enabled = FALSE;
		outletOptions.enabled = FALSE;
		OutletSave.enabled = FALSE;
        
        self.outletDelete.alpha  = 0.5;
		self.outletEdit.alpha  = 0.5;
		self.outletFund.alpha  = 0.5;
		self.outletOptions.alpha  = 0.5;
		self.OutletSave.alpha  = 0.5;
		
		if([EAPPorSI isEqualToString:@"eAPP"]){
			outletDone.enabled = FALSE;
			outletEAPP.width = 0;
			outletSpace.width = 564;
			
		}
	}
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
								   initWithTarget:self
								   action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	
	[self.view addGestureRecognizer:tap];
	
}

-(void)hideKeyboard{
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
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
	
	self.view.frame = CGRectMake(0, 0, 800, 1004);
	[super viewWillAppear:animated];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
	//appDel.isNeedPromptSaveMsg = YES;
}

#pragma mark - CollectionView view data source

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"Select %i, %i",indexPath.row,indexPath.section);

    exist = TRUE;
    
    NSString *zzz = [NSString stringWithFormat:@"%d", indexPath.section-1];
    [ItemToBeDeleted addObject:zzz];
    
    [outletFund setTitle:[aMaturityFund objectAtIndex:indexPath.section-1] forState:UIControlStateNormal];
    if ([[aFundOption objectAtIndex:indexPath.section-1] isEqualToString:@"ReInvest" ]) {
        outletOptions.selectedSegmentIndex = 0;
    }
    else if ([[aFundOption objectAtIndex:indexPath.section-1] isEqualToString:@"Withdraw" ]){
        outletOptions.selectedSegmentIndex = 1;
    }
    else{
        outletOptions.selectedSegmentIndex = 2;
    }
    
    txtPercentageReinvest.text = [NSString stringWithFormat:@"%.0f", [[aPercent objectAtIndex:indexPath.section-1] doubleValue]];
    txt2025.text = [NSString stringWithFormat:@"%.0f", [[a2025 objectAtIndex:indexPath.section-1] doubleValue]];
    txt2028.text = [NSString stringWithFormat:@"%.0f", [[a2028 objectAtIndex:indexPath.section-1] doubleValue]];
    txt2030.text = [NSString stringWithFormat:@"%.0f", [[a2030 objectAtIndex:indexPath.section-1] doubleValue]];
    txt2035.text = [NSString stringWithFormat:@"%.0f", [[a2035 objectAtIndex:indexPath.section-1] doubleValue]];
    txtCashFund.text = [NSString stringWithFormat:@"%.0f", [[aCashFund objectAtIndex:indexPath.section-1] doubleValue]];
    txtSecureFund.text = [NSString stringWithFormat:@"%.0f", [[aSecureFund objectAtIndex:indexPath.section-1] doubleValue]];
    txtDanaFund.text = [NSString stringWithFormat:@"%.0f", [[aDanaFund objectAtIndex:indexPath.section-1] doubleValue]];
    txtVentureFlexi.text = [NSString stringWithFormat:@"%.0f", [[aVentureFund objectAtIndex:indexPath.section-1] doubleValue]];
    ///
    
    self.txtVentureGrowth.text = [NSString stringWithFormat:@"%.0f", [[self.aVentureGrowth objectAtIndex:indexPath.section-1] doubleValue]];
    self.txtVentureBlueChip.text = [NSString stringWithFormat:@"%.0f", [[self.aVentureBlueChip objectAtIndex:indexPath.section-1] doubleValue]];
    self.txtVentureDana.text = [NSString stringWithFormat:@"%.0f", [[self.aVentureDana objectAtIndex:indexPath.section-1] doubleValue]];
    self.txtVentureManaged.text = [NSString stringWithFormat:@"%.0f", [[self.aVentureManaged objectAtIndex:indexPath.section-1] doubleValue]];
    self.txtVentureIncome.text = [NSString stringWithFormat:@"%.0f", [[self.aVentureIncome objectAtIndex:indexPath.section-1] doubleValue]];
    self.txtVenture6666.text = [NSString stringWithFormat:@"%.0f", [[self.aVenture6666 objectAtIndex:indexPath.section-1] doubleValue]];
    self.txtVenture7777.text = [NSString stringWithFormat:@"%.0f", [[self.aVenture7777 objectAtIndex:indexPath.section-1] doubleValue]];
    self.txtVenture8888.text = [NSString stringWithFormat:@"%.0f", [[self.aVenture8888 objectAtIndex:indexPath.section-1] doubleValue]];
    self.txtVenture9999.text = [NSString stringWithFormat:@"%.0f", [[self.aVenture9999 objectAtIndex:indexPath.section-1] doubleValue]];
    
    outletOptions.enabled = TRUE;
    [self toggleFund];
    
    
    
    
    NSMutableArray *sindexPaths = [NSMutableArray arrayWithObject:indexPath];
    if (self.selectedItemIndexPath)
    {
        // if we had a previously selected cell
        
        if ([indexPath compare:self.selectedItemIndexPath] == NSOrderedSame)
        {
            // if it's the same as the one we just tapped on, then we're unselecting it
            
            self.selectedItemIndexPath = nil;
        }
        else
        {
            // if it's different, then add that old one to our list of cells to reload, and
            // save the currently selected indexPath
            outletDelete.hidden = TRUE;
            outletDelete.enabled = FALSE;
            [outletDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
            [outletEdit setTitle:@"Edit" forState:UIControlStateNormal ];
            
            [sindexPaths addObject:self.selectedItemIndexPath];
            self.selectedItemIndexPath = indexPath;
            
        }
    }
    else
    {
        // else, we didn't have previously selected cell, so we only need to save this indexPath for future reference
        outletDelete.hidden = TRUE;
        outletDelete.enabled = FALSE;
        [outletDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        [outletEdit setTitle:@"Edit" forState:UIControlStateNormal ];
        
        self.selectedItemIndexPath = indexPath;
    }
    
    
    
    // and now only reload only the cells that need updating
    [collectionView reloadData];
    //[collectionView reloadItemsAtIndexPaths:sindexPaths];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSLog(@"loading %i",[aMaturityFund count]+1);
    return [aMaturityFund count]+1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 17;//number of columns
    //must be same NUMBEROFCOLUMNS in CustomCollectioVC
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //section == row
    //row == column
    
    static NSString *cellIdentifier = @"cvCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];
    UIView *bgLabel = (UIView *)[cell viewWithTag:101];
    if (indexPath.section == 0) {
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setBackgroundColor:[UIColor colorWithRed:(50.0/256.0) green:(79.0/256.0) blue:(133.0/256.0) alpha:1.0]];
        [bgLabel setBackgroundColor:[UIColor colorWithRed:(50.0/256.0) green:(79.0/256.0) blue:(133.0/256.0) alpha:1.0]];
        
        if (indexPath.row == 0) {
            titleLabel.text = @"Maturity Fund";
        }else if (indexPath.row == 1) {
            titleLabel.text = @"Fund Option";
        }else if (indexPath.row == 2) {
            titleLabel.text = @"Reinvest";
        }else if (indexPath.row == 3) {
            titleLabel.text = @"Withdrawal";
        }else if (indexPath.row == 4) {
            titleLabel.text = @"HLA Ever Green 2025";
        }else if (indexPath.row == 5) {
            titleLabel.text = @"HLA Ever Green 2028";
        }else if (indexPath.row == 6) {
            titleLabel.text = @"HLA Ever Green 2030";
        }else if (indexPath.row == 7) {
            titleLabel.text = @"HLA Ever Green 2035";
        }else if (indexPath.row == 8) {
            titleLabel.text = @"HLA Venture Flexi";
        }else if (indexPath.row == 9) {
            titleLabel.text = @"HLA Venture Growth";
        }else if (indexPath.row == 10) {
            titleLabel.text = @"HLA Venture Blue Chip";
        }else if (indexPath.row == 11) {
            titleLabel.text = @"HLA Venture Dana Putra";
        }else if (indexPath.row == 12) {
            titleLabel.text = @"HLA Dana Suria";
        }else if (indexPath.row == 13) {
            titleLabel.text = @"HLA Venture Managed";
        }else if (indexPath.row == 14) {
            titleLabel.text = @"HLA Secure Fund";
        }else if (indexPath.row == 15) {
            titleLabel.text = @"HLA Venture Income";
        }else if (indexPath.row == 16) {
            titleLabel.text = @"HLA Cash Fund";
        }
        
    }else{
        
        ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
        [titleLabel setTextColor:[UIColor blackColor]];
        
        
        if (self.selectedItemIndexPath != nil && self.selectedItemIndexPath.section == indexPath.section) {
            //[indexPath compare:self.selectedItemIndexPath] == NSOrderedSame
            titleLabel.backgroundColor = [UIColor lightGrayColor];
            bgLabel.backgroundColor = [UIColor lightGrayColor];
        }else{
            if (indexPath.section % 2 == 1) {
                titleLabel.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
                bgLabel.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
            }else{
                titleLabel.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
                bgLabel.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
            }
        }
        
        
        if (indexPath.row == 0) {
            titleLabel.text = [aMaturityFund objectAtIndex:indexPath.section-1];
            
        }else if (indexPath.row == 1) {
            titleLabel.text = [aFundOption objectAtIndex:indexPath.section-1];
        }else if (indexPath.row == 2) {
            if ([[aFundOption objectAtIndex:indexPath.section-1] isEqualToString:@"ReInvest" ]) {
                titleLabel.text= [NSString stringWithFormat:@"%d", 100];
            }
            else if ([[aFundOption objectAtIndex:indexPath.section-1] isEqualToString:@"Withdraw" ]) {
                titleLabel.text= [NSString stringWithFormat:@"%d", 0];
            }
            else if ([[aFundOption objectAtIndex:indexPath.section-1] isEqualToString:@"Partial" ]) {
                titleLabel.text= [NSString stringWithFormat:@"%d", [[aPercent objectAtIndex:indexPath.section-1] intValue ]];
            }
            
        }else if (indexPath.row == 3) {
            if ([[aFundOption objectAtIndex:indexPath.section-1] isEqualToString:@"ReInvest" ]) {
                titleLabel.text= [NSString stringWithFormat:@"%d", 0];
            }
            else if ([[aFundOption objectAtIndex:indexPath.section-1] isEqualToString:@"Withdraw" ]) {
                titleLabel.text= [NSString stringWithFormat:@"%d", 100];
            }
            else if ([[aFundOption objectAtIndex:indexPath.section-1] isEqualToString:@"Partial" ]) {
                titleLabel.text= [NSString stringWithFormat:@"%d", 100 - [[aPercent objectAtIndex:indexPath.section-1] intValue ]];
            }
        }else if (indexPath.row == 4) {
            titleLabel.text = [a2025 objectAtIndex:indexPath.section-1];
        }else if (indexPath.row == 5) {
            titleLabel.text = [a2028 objectAtIndex:indexPath.section-1];
        }else if (indexPath.row == 6) {
            titleLabel.text = [a2030 objectAtIndex:indexPath.section-1];
        }else if (indexPath.row == 7) {
            titleLabel.text = [a2035 objectAtIndex:indexPath.section-1];
        }else if (indexPath.row == 8) {
            titleLabel.text = [aVentureFund objectAtIndex:indexPath.section-1];
        }else if (indexPath.row == 9) {
            titleLabel.text = [self.aVentureGrowth objectAtIndex:indexPath.section-1];
        }else if (indexPath.row == 10) {
            titleLabel.text = [self.aVentureBlueChip objectAtIndex:indexPath.section-1];
        }else if (indexPath.row == 11) {
            titleLabel.text = [self.aVentureDana objectAtIndex:indexPath.section-1];
        }else if (indexPath.row == 12) {
            titleLabel.text = [aDanaFund objectAtIndex:indexPath.section-1];
        }else if (indexPath.row == 13) {
            titleLabel.text = [self.aVentureManaged objectAtIndex:indexPath.section-1];
        }else if (indexPath.row == 14) {
            titleLabel.text = [aSecureFund objectAtIndex:indexPath.section-1];
        }else if (indexPath.row == 15) {
            titleLabel.text = [self.aVentureIncome objectAtIndex:indexPath.section-1];
        }else if (indexPath.row == 16) {
            titleLabel.text = [aCashFund objectAtIndex:indexPath.section-1];
        }else if (indexPath.row == 17) {
            titleLabel.text = [self.aVenture6666 objectAtIndex:indexPath.section-1];
        }else if (indexPath.row == 18) {
            titleLabel.text = [self.aVenture7777 objectAtIndex:indexPath.section-1];
        }else if (indexPath.row == 19) {
            titleLabel.text = [self.aVenture8888 objectAtIndex:indexPath.section-1];
        }else if (indexPath.row == 20) {
            titleLabel.text = [self.aVenture9999 objectAtIndex:indexPath.section-1];
        }else {
            titleLabel.text = @"NA";
        }
        
        
    }
    
    
    
    return cell;
    
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
	[[cell.contentView viewWithTag:2012] removeFromSuperview ];
    
	ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    int y = 0;
	int height = 50;
	int FontSize = 14;
	
	CGRect frame=CGRectMake(0,y, 110, height);
    UILabel *label1=[[UILabel alloc]init];
    label1.frame=frame;
    label1.numberOfLines = 2;
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
    label5.text= [NSString stringWithFormat:@"%d", [[a2025 objectAtIndex:indexPath.row] intValue]];
    label5.textAlignment = UITextAlignmentCenter;
    label5.tag = 2005;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label5];
	
	CGRect frame6=CGRectMake(frame5.origin.x + frame5.size.width,y, 53, height);
    UILabel *label6=[[UILabel alloc]init];
    label6.frame=frame6;
    label6.text= [NSString stringWithFormat:@"%d", [[a2028 objectAtIndex:indexPath.row] intValue]];
    label6.textAlignment = UITextAlignmentCenter;
    label6.tag = 2006;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label6];
	
	CGRect frame7=CGRectMake(frame6.origin.x + frame6.size.width,y, 53, height);
    UILabel *label7=[[UILabel alloc]init];
    label7.frame=frame7;
    label7.text= [NSString stringWithFormat:@"%d", [[a2030 objectAtIndex:indexPath.row] intValue]];
    label7.textAlignment = UITextAlignmentCenter;
    label7.tag = 2007;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label7];

	CGRect frame8=CGRectMake(frame7.origin.x + frame7.size.width,y, 53, height);
    UILabel *label8=[[UILabel alloc]init];
    label8.frame=frame8;
    label8.text= [NSString stringWithFormat:@"%d", [[a2035 objectAtIndex:indexPath.row] intValue]];
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

    CGRect frame9=CGRectMake(frame8.origin.x + frame8.size.width,y, 53, height);
    UILabel *label9=[[UILabel alloc]init];
    label9.frame=frame9;
    label9.text= [NSString stringWithFormat:@"%d", [[aVentureFund objectAtIndex:indexPath.row] intValue]];
    label9.textAlignment = UITextAlignmentCenter;
    label9.tag = 2009;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label9];
    
	CGRect frame10=CGRectMake(frame9.origin.x + frame9.size.width,y, 45, height);
    UILabel *label10=[[UILabel alloc]init];
    label10.frame=frame10;
    label10.text= [NSString stringWithFormat:@"%d", [[aDanaFund objectAtIndex:indexPath.row] intValue]];
    label10.textAlignment = UITextAlignmentCenter;
    label10.tag = 2010;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label10];
	
	CGRect frame11=CGRectMake(frame10.origin.x + frame10.size.width,y, 45, height);
    UILabel *label11=[[UILabel alloc]init];
    label11.frame=frame11;
    label11.text= [NSString stringWithFormat:@"%d", [[aSecureFund objectAtIndex:indexPath.row] intValue]];
    label11.textAlignment = UITextAlignmentCenter;
    label11.tag = 2011;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
    [cell.contentView addSubview:label11];
	
	
	CGRect frame12=CGRectMake(frame11.origin.x + frame11.size.width,y, 60, height);
    UILabel *label12=[[UILabel alloc]init];
    label12.frame=frame12;
    label12.text= [NSString stringWithFormat:@"%d", [[aCashFund objectAtIndex:indexPath.row] intValue]];
    label12.textAlignment = UITextAlignmentCenter;
    label12.tag = 2012;
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
		label9.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
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
		label9.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
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
		label9.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
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
		label9.font = [UIFont fontWithName:@"TreBuchet MS" size:FontSize];
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
        txtVentureFlexi.text = [NSString stringWithFormat:@"%.0f", [[aVentureFund objectAtIndex:indexPath.row] doubleValue]];
        ///
        self.txtVentureGrowth.text = [NSString stringWithFormat:@"%.0f", [[self.aVentureGrowth objectAtIndex:indexPath.row] doubleValue]];
        self.txtVentureBlueChip.text = [NSString stringWithFormat:@"%.0f", [[self.aVentureBlueChip objectAtIndex:indexPath.row] doubleValue]];
        self.txtVentureDana.text = [NSString stringWithFormat:@"%.0f", [[self.aVentureDana objectAtIndex:indexPath.row] doubleValue]];
        self.txtVentureManaged.text = [NSString stringWithFormat:@"%.0f", [[self.aVentureManaged objectAtIndex:indexPath.row] doubleValue]];
        self.txtVentureIncome.text = [NSString stringWithFormat:@"%.0f", [[self.aVentureIncome objectAtIndex:indexPath.row] doubleValue]];
        self.txtVenture6666.text = [NSString stringWithFormat:@"%.0f", [[self.aVenture6666 objectAtIndex:indexPath.row] doubleValue]];
        self.txtVenture7777.text = [NSString stringWithFormat:@"%.0f", [[self.aVenture7777 objectAtIndex:indexPath.row] doubleValue]];
        self.txtVenture8888.text = [NSString stringWithFormat:@"%.0f", [[self.aVenture8888 objectAtIndex:indexPath.row] doubleValue]];
        self.txtVenture9999.text = [NSString stringWithFormat:@"%.0f", [[self.aVenture9999 objectAtIndex:indexPath.row] doubleValue]];
        
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
            txtVentureFlexi.text = [NSString stringWithFormat:@"%.0f", [[aVentureFund objectAtIndex:a] doubleValue]];
            ///
            self.txtVentureGrowth.text = [NSString stringWithFormat:@"%.0f", [[self.aVentureGrowth objectAtIndex:a] doubleValue]];
            self.txtVentureBlueChip.text = [NSString stringWithFormat:@"%.0f", [[self.aVentureBlueChip objectAtIndex:a] doubleValue]];
            self.txtVentureDana.text = [NSString stringWithFormat:@"%.0f", [[self.aVentureDana objectAtIndex:a] doubleValue]];
            self.txtVentureManaged.text = [NSString stringWithFormat:@"%.0f", [[self.aVentureManaged objectAtIndex:a] doubleValue]];
            self.txtVentureIncome.text = [NSString stringWithFormat:@"%.0f", [[self.aVentureIncome objectAtIndex:a] doubleValue]];
            self.txtVenture6666.text = [NSString stringWithFormat:@"%.0f", [[self.aVenture6666 objectAtIndex:a] doubleValue]];
            self.txtVenture7777.text = [NSString stringWithFormat:@"%.0f", [[self.aVenture7777 objectAtIndex:a] doubleValue]];
            self.txtVenture8888.text = [NSString stringWithFormat:@"%.0f", [[self.aVenture8888 objectAtIndex:a] doubleValue]];
            self.txtVenture9999.text = [NSString stringWithFormat:@"%.0f", [[self.aVenture9999 objectAtIndex:a] doubleValue]];
            
			[self toggleFund];
			break;
		}
	}
	
	if (search.location == NSNotFound) { //new
        
        NSRange search = [outletFund.titleLabel.text rangeOfString:@"evergreen" options:NSCaseInsensitiveSearch];
        if (search.location != NSNotFound && outletOptions.selectedSegmentIndex != 1) {
            self.txtVentureIncome.text = @"100";
        }else{
            self.txtVentureIncome.text = @"0";
        }
        
		exist = FALSE;
		txtPercentageReinvest.text = @"0";
		txt2025.text = @"0";
		txt2028.text = @"0";
		txt2030.text = @"0";
		txt2035.text = @"0";
		txtCashFund.text = @"0";//100
		txtSecureFund.text = @"0";
		txtDanaFund.text = @"0";
        txtVentureFlexi.text = @"0";
        
        ///
        self.txtVentureGrowth.text = @"0";
        self.txtVentureBlueChip.text = @"0";
        self.txtVentureDana.text = @"0";
        self.txtVentureManaged.text = @"0";
        self.txtVentureIncome.text = @"0";
        self.txtVenture6666.text = @"0";
        self.txtVenture7777.text = @"0";
        self.txtVenture8888.text = @"0";
        self.txtVenture9999.text = @"0";
        
		[self toggleFund];
	}
	
}



- (IBAction)ActionEAPP:(id)sender {
	self.modalTransitionStyle = UIModalPresentationFormSheet;
    [self dismissViewControllerAnimated:TRUE completion:Nil];
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
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:zzz.EverMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		alert.tag = 1007;
        [alert show];
		zzz.EverMessage = @"";
	}
	else{
		if ([self Validation] == TRUE) {
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
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
	
	
	if (![appDel.EverMessage isEqualToString:@""]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:appDel.EverMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		alert.tag = 1007;
        [alert show];
		appDel.EverMessage = @"";
	}
	else{
		if ([self Validation] == TRUE) {
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
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
		/*
		if (ItemToBeDeleted.count < 1) {
            return;
        }
        else{
            NSLog(@"itemToBeDeleted:%d", ItemToBeDeleted.count);
        }
        */
        
		[self DeleteFund];
	}
	else if (alertView.tag == 1007 && buttonIndex == 0) {
		
		if ([self Validation] == TRUE) {
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
															message:@"Confirm changes?" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"CANCEL",nil];
			[alert setTag:1001];
			[alert show];
			
		}
	}
	

}

-(void)InsertandUpdate{
	
	 if (exist == TRUE) {//??
		 sqlite3_stmt *statement;NSLog(@"exist == TRUE");
		 if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
		 {
				NSString *querySQL = [NSString stringWithFormat: @"Update UL_Fund_Maturity_Option SET Option = '%@', "
										"Partial_Withd_Pct='%@', EverGreen2025='%@', "
									  "EverGreen2028= '%@', EverGreen2030='%@', EverGreen2035='%@', CashFund='%@', RetireFund='%@', DanaFund='%@', SmartFund='0', VentureFund='%@',VentureGrowth='%@',VentureBlueChip='%@',VentureDana='%@',VentureManaged='%@',VentureIncome='%@' "
									  " Where sino = '%@' AND Fund = '%@' ",
									  [self ReturnOption], txtPercentageReinvest.text, txt2025.text,
									  txt2028.text, txt2030.text, txt2035.text, txtCashFund.text, txtSecureFund.text, txtDanaFund.text, txtVentureFlexi.text, self.txtVentureGrowth.text, self.txtVentureBlueChip.text, self.txtVentureDana.text, self.txtVentureManaged.text, self.txtVentureIncome.text, SINo, outletFund.titleLabel.text];
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
		 {//??
			 NSString *querySQL = [NSString stringWithFormat: @"INSERT INTO UL_Fund_Maturity_Option(SINO, Fund, Option, Partial_Withd_Pct, EverGreen2025,"
								   "EverGreen2028, EverGreen2030, EverGreen2035, CashFund, RetireFund, DanaFund, SmartFund, VentureFund, VentureGrowth, VentureBlueChip, VentureDana, VentureManaged, VentureIncome) VALUES('%@', '%@', '%@', "
								   "'%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@') ",
								   SINo, outletFund.titleLabel.text, [self ReturnOption], txtPercentageReinvest.text, txt2025.text,
								   txt2028.text, txt2030.text, txt2035.text, txtCashFund.text, txtSecureFund.text, txtDanaFund.text, @"0", txtVentureFlexi.text, self.txtVentureGrowth.text, self.txtVentureBlueChip.text, self.txtVentureDana.text, self.txtVentureManaged.text, self.txtVentureIncome.text];
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
	//[self.myTableView reloadData];
    [self.collectionView reloadData];
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
								  @"UPDATE UL_Fund_Maturity_Option SET option = 'ReInvest', partial_withd_pct ='0', EverGreen2025='0',EverGreen2028='0',EverGreen2030='0',EverGreen2035='0',CashFund='100', "
								  "RetireFund='0', DanaFund='0', SmartFund='0', VentureFund='0', VentureGrowth='0', VentureBlueChip='0', VentureDana='0', VentureManaged='0', VentureIncome='0' WHERE SINo=\"%@\" AND Fund=\"%@\"",
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
	//[self.myTableView reloadData];
    [self DisplayData];
	[self.collectionView reloadData];
	[ItemToBeDeleted removeAllObjects];
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
    aSmartFund = [[NSMutableArray alloc] init ];
	aVentureFund = [[NSMutableArray alloc] init ];
    ///
    self.aVentureGrowth = [NSMutableArray array];
    self.aVentureBlueChip = [NSMutableArray array];
    self.aVentureDana = [NSMutableArray array];
    self.aVentureManaged = [NSMutableArray array];
    self.aVentureIncome = [NSMutableArray array];
    self.aVenture6666 = [NSMutableArray array];
    self.aVenture7777 = [NSMutableArray array];
    self.aVenture8888 = [NSMutableArray array];
    self.aVenture9999 = [NSMutableArray array];
    
    //??
	sqlite3_stmt *statement;
	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
	{
		NSString *querySQL = [NSString stringWithFormat: @"Select Fund, Option, Partial_Withd_Pct, EverGreen2025, "
							  "EverGreen2028, EverGreen2030, EverGreen2035, CashFund, RetireFund, DanaFund, ifnull(SmartFund,'0'), ifnull(VentureFund,'0'), ifnull(VentureGrowth,'0'), ifnull(VentureBlueChip,'0'), ifnull(VentureDana,'0'), ifnull(VentureManaged,'0'), ifnull(VentureIncome,'0')  "
							  "From UL_Fund_Maturity_Option where SINO = '%@' Order by Fund ASC  ", SINo];
		
		NSLog(@"%@", querySQL);
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
                [aSmartFund addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 10)]];
				[aVentureFund addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 11)]];
                ///
                [self.aVentureGrowth addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 12)]];
                [self.aVentureBlueChip addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 13)]];
                [self.aVentureDana addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 14)]];
                [self.aVentureManaged addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 15)]];
                [self.aVentureIncome addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 16)]];
                //[self.aVenture6666 addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 17)]];
                //[self.aVenture7777 addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 18)]];
                //[self.aVenture8888 addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 19)]];
                //[self.aVenture9999 addObject:[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 20)]];
                
			}
			sqlite3_finalize(statement);
		}
		sqlite3_close(contactDB);
	}
	
	if ([aMaturityFund count] > 0) {
		myTableView.hidden = YES;
		outletTableLabel.hidden = YES;
		[myTableView reloadData];
		outletEdit.hidden = NO;
        [self.collectionView reloadData];
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
    if ([txtVentureFlexi.text isEqualToString:@""]) {
        txtVentureFlexi.text = @"0";
	}
    
    ///
    if ([self.txtVentureGrowth.text isEqualToString:@""]) {
        self.txtVentureGrowth.text = @"0";
    }
    if ([self.txtVentureBlueChip.text isEqualToString:@""]) {
        self.txtVentureBlueChip.text = @"0";
    }
    if ([self.txtVentureDana.text isEqualToString:@""]) {
        self.txtVentureDana.text = @"0";
    }
    if ([self.txtVentureManaged.text isEqualToString:@""]) {
        self.txtVentureManaged.text = @"0";
    }
    if ([self.txtVentureIncome.text isEqualToString:@""]) {
        self.txtVentureIncome.text = @"0";
    }
    if ([self.txtVenture6666.text isEqualToString:@""]) {
        self.txtVenture6666.text = @"0";
    }
    if ([self.txtVenture7777.text isEqualToString:@""]) {
        self.txtVenture7777.text = @"0";
    }
    if ([self.txtVenture8888.text isEqualToString:@""]) {
        self.txtVenture8888.text = @"0";
    }
    if ([self.txtVenture9999.text isEqualToString:@""]) {
        self.txtVenture9999.text = @"0";
    }
}

- (BOOL)Validation{
	[self ValidateString];
	
	if ([outletFund.titleLabel.text isEqualToString:@"Please Select"]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
														message:@"Please select a Maturity Fund." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [alert show];

		return FALSE;
	}
	
	if (outletOptions.selectedSegmentIndex == 2) {
		if ([[txtPercentageReinvest.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@"" ]) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
															message:@"Percentage ReInvest must be greater than 0" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
			[alert show];
			[txtPercentageReinvest becomeFirstResponder ];
			return  FALSE;
		}
		
		if ([txtPercentageReinvest.text intValue ] == 0) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
															message:@"Percentage ReInvest must be greater than 0" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
			[alert show];
			[txtPercentageReinvest becomeFirstResponder ];
			return  FALSE;
		}
		
		if ([txtPercentageReinvest.text intValue ] >= 100) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
															message:@"Percentage ReInvest must not greater than or equal to 100" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
			[alert show];
			[txtPercentageReinvest becomeFirstResponder ];
			return  FALSE;
		}
	}
	
	if (outletOptions.selectedSegmentIndex != 1) {//??
		if ([txt2025.text intValue ] + [txt2028.text intValue ] + [txt2030.text intValue ] + [txt2035.text intValue ] +
			[txtCashFund.text intValue ] + [txtSecureFund.text intValue ] + [txtDanaFund.text intValue] + [txtVentureFlexi.text intValue] + [self.txtVentureGrowth.text intValue] + [self.txtVentureBlueChip.text intValue] + [self.txtVentureManaged.text intValue] + [self.txtVentureDana.text intValue] + [self.txtVentureIncome.text intValue] != 100) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
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
    [self setOutletDone:nil];
	[self setOutletSave:nil];
    [self setOutletEAPP:nil];
    [self setOutletSpace:nil];
    [self setTxtVentureFlexi:nil];
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
        txtVentureFlexi.text = @"0";
		txtPercentageReinvest.text = @"0";
		txt2025.enabled = FALSE;
		txt2028.enabled = FALSE;
		txt2030.enabled = FALSE;
		txt2035.enabled = FALSE;
		txtCashFund.enabled = FALSE;
		txtSecureFund.enabled = FALSE;
		txtDanaFund.enabled = FALSE;
        txtVentureFlexi.enabled = FALSE;
		txtPercentageReinvest.enabled = FALSE;
		txt2025.backgroundColor = [UIColor lightGrayColor];
		txt2028.backgroundColor = [UIColor lightGrayColor];
		txt2030.backgroundColor = [UIColor lightGrayColor];
		txt2035.backgroundColor = [UIColor lightGrayColor];
		txtCashFund.backgroundColor = [UIColor lightGrayColor];
		txtSecureFund.backgroundColor = [UIColor lightGrayColor];
		txtDanaFund.backgroundColor = [UIColor lightGrayColor];
        txtVentureFlexi.backgroundColor = [UIColor lightGrayColor];
		txtPercentageReinvest.backgroundColor = [UIColor lightGrayColor];
        
        ///
        self.txtVentureGrowth.text = @"0";
        self.txtVentureBlueChip.text = @"0";
        self.txtVentureDana.text = @"0";
        self.txtVentureManaged.text = @"0";
        self.txtVentureIncome.text = @"0";
        self.txtVenture6666.text = @"0";
        self.txtVenture7777.text = @"0";
        self.txtVenture8888.text = @"0";
        self.txtVenture9999.text = @"0";
        self.txtVentureGrowth.enabled = NO;
        self.txtVentureBlueChip.enabled = NO;
        self.txtVentureDana.enabled = NO;
        self.txtVentureManaged.enabled = NO;
        self.txtVentureIncome.enabled = NO;
        self.txtVenture6666.enabled = NO;
        self.txtVenture7777.enabled = NO;
        self.txtVenture8888.enabled = NO;
        self.txtVenture9999.enabled = NO;
        self.txtVentureGrowth.backgroundColor = [UIColor lightGrayColor];
        self.txtVentureBlueChip.backgroundColor = [UIColor lightGrayColor];
        self.txtVentureDana.backgroundColor = [UIColor lightGrayColor];
        self.txtVentureManaged.backgroundColor = [UIColor lightGrayColor];
        self.txtVentureIncome.backgroundColor = [UIColor lightGrayColor];
        self.txtVenture6666.backgroundColor = [UIColor lightGrayColor];
        self.txtVenture7777.backgroundColor = [UIColor lightGrayColor];
        self.txtVenture8888.backgroundColor = [UIColor lightGrayColor];
        self.txtVenture9999.backgroundColor = [UIColor lightGrayColor];
        
	}
	else{
        txtPercentageReinvest.text = [NSString stringWithFormat:@"%.0f", [[aPercent objectAtIndex:self.selectedItemIndexPath.section-1] doubleValue]];
        txt2025.text = [NSString stringWithFormat:@"%.0f", [[a2025 objectAtIndex:self.selectedItemIndexPath.section-1] doubleValue]];
        txt2028.text = [NSString stringWithFormat:@"%.0f", [[a2028 objectAtIndex:self.selectedItemIndexPath.section-1] doubleValue]];
        txt2030.text = [NSString stringWithFormat:@"%.0f", [[a2030 objectAtIndex:self.selectedItemIndexPath.section-1] doubleValue]];
        txt2035.text = [NSString stringWithFormat:@"%.0f", [[a2035 objectAtIndex:self.selectedItemIndexPath.section-1] doubleValue]];
        txtCashFund.text = [NSString stringWithFormat:@"%.0f", [[aCashFund objectAtIndex:self.selectedItemIndexPath.section-1] doubleValue]];
        txtSecureFund.text = [NSString stringWithFormat:@"%.0f", [[aSecureFund objectAtIndex:self.selectedItemIndexPath.section-1] doubleValue]];
        txtSecureFund.text = [NSString stringWithFormat:@"%.0f", [[aSecureFund objectAtIndex:self.selectedItemIndexPath.section-1] doubleValue]];
        txtDanaFund.text = [NSString stringWithFormat:@"%.0f", [[aDanaFund objectAtIndex:self.selectedItemIndexPath.section-1] doubleValue]];
        txtVentureFlexi.text = [NSString stringWithFormat:@"%.0f", [[aVentureFund objectAtIndex:self.selectedItemIndexPath.section-1] doubleValue]];
        ///
        self.txtVentureGrowth.text = [NSString stringWithFormat:@"%.0f", [[self.aVentureGrowth objectAtIndex:self.selectedItemIndexPath.section-1] doubleValue]];
        self.txtVentureBlueChip.text = [NSString stringWithFormat:@"%.0f", [[self.aVentureBlueChip objectAtIndex:self.selectedItemIndexPath.section-1] doubleValue]];
        self.txtVentureDana.text = [NSString stringWithFormat:@"%.0f", [[self.aVentureDana objectAtIndex:self.selectedItemIndexPath.section-1] doubleValue]];
        self.txtVentureManaged.text = [NSString stringWithFormat:@"%.0f", [[self.aVentureManaged objectAtIndex:self.selectedItemIndexPath.section-1] doubleValue]];
        self.txtVentureIncome.text = [NSString stringWithFormat:@"%.0f", [[self.aVentureIncome objectAtIndex:self.selectedItemIndexPath.section-1] doubleValue]];
        self.txtVenture6666.text = [NSString stringWithFormat:@"%.0f", [[self.aVenture6666 objectAtIndex:self.selectedItemIndexPath.section-1] doubleValue]];
        self.txtVenture7777.text = [NSString stringWithFormat:@"%.0f", [[self.aVenture7777 objectAtIndex:self.selectedItemIndexPath.section-1] doubleValue]];
        self.txtVenture8888.text = [NSString stringWithFormat:@"%.0f", [[self.aVenture8888 objectAtIndex:self.selectedItemIndexPath.section-1] doubleValue]];
        self.txtVenture9999.text = [NSString stringWithFormat:@"%.0f", [[self.aVenture9999 objectAtIndex:self.selectedItemIndexPath.section-1] doubleValue]];
		[self toggleFund];
	}
}

-(void)toggleFund{
	
	if (Editable == TRUE) {
		if (outletOptions.selectedSegmentIndex == 1 || [outletFund.titleLabel.text isEqualToString:@"Please Select"]) {
			txt2025.text = @"0";
			txt2028.text = @"0";
			txt2030.text = @"0";
			txt2035.text = @"0";
			txtCashFund.text = @"0";
			txtSecureFund.text = @"0";
			txtDanaFund.text = @"0";
            txtVentureFlexi.text = @"0";
			txtPercentageReinvest.text = @"0";
			txt2025.enabled = FALSE;
			txt2028.enabled = FALSE;
			txt2030.enabled = FALSE;
			txt2035.enabled = FALSE;
			txtCashFund.enabled = FALSE;
			txtSecureFund.enabled = FALSE;
			txtDanaFund.enabled = FALSE;
            txtVentureFlexi.enabled = FALSE;
			txtPercentageReinvest.enabled = FALSE;
            
            ///
            self.txtVentureGrowth.enabled = NO;
            self.txtVentureBlueChip.enabled = NO;
            self.txtVentureDana.enabled = NO;
            self.txtVentureManaged.enabled = NO;
            self.txtVentureIncome.enabled = NO;
            self.txtVenture6666.enabled = NO;
            self.txtVenture7777.enabled = NO;
            self.txtVenture8888.enabled = NO;
            self.txtVenture9999.enabled = NO;
            self.txtVentureGrowth.backgroundColor = [UIColor lightGrayColor];
            self.txtVentureBlueChip.backgroundColor = [UIColor lightGrayColor];
            self.txtVentureDana.backgroundColor = [UIColor lightGrayColor];
            self.txtVentureManaged.backgroundColor = [UIColor lightGrayColor];
            self.txtVentureIncome.backgroundColor = [UIColor lightGrayColor];
            self.txtVenture6666.backgroundColor = [UIColor lightGrayColor];
            self.txtVenture7777.backgroundColor = [UIColor lightGrayColor];
            self.txtVenture8888.backgroundColor = [UIColor lightGrayColor];
            self.txtVenture9999.backgroundColor = [UIColor lightGrayColor];
            
		}
		else{
            
            
                    
			if (outletOptions.selectedSegmentIndex == 2) {
				txtPercentageReinvest.enabled = TRUE;
			}
			else{
				txtPercentageReinvest.enabled = FALSE;
			}
			
            self.txtVentureGrowth.enabled = YES;
            self.txtVentureBlueChip.enabled = YES;
            self.txtVentureDana.enabled = YES;
            self.txtVentureManaged.enabled = YES;
            self.txtVentureIncome.enabled = YES;
            
            
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
                txtVentureFlexi.enabled = TRUE;
                //??
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
                txtVentureFlexi.enabled = TRUE;
                //??
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
                txtVentureFlexi.enabled = TRUE;
                //??
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
                txtVentureFlexi.enabled = TRUE;
                //??
			}
			else if ([outletFund.titleLabel.text isEqualToString:@"HLA EverGreen 2023"]) {
				txt2025.enabled = TRUE;
				txt2028.enabled = TRUE;
				txt2030.enabled = TRUE;
				txt2035.enabled = TRUE;
				txtCashFund.enabled = TRUE;
				txtSecureFund.enabled = TRUE;
				txtDanaFund.enabled = TRUE;
                txtVentureFlexi.enabled = TRUE;
                //??
			}
			
		}
	}
	else{
		txt2025.enabled = FALSE;
		txt2028.enabled = FALSE;
		txt2030.enabled = FALSE;
		txt2035.enabled = FALSE;
		txtCashFund.enabled = FALSE;
		txtSecureFund.enabled = FALSE;
		txtDanaFund.enabled = FALSE;
        txtVentureFlexi.enabled = FALSE;
		txtPercentageReinvest.enabled = FALSE;
        //??
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
    
    if (txtVentureFlexi.enabled == FALSE) {
		txtVentureFlexi.backgroundColor = [UIColor lightGrayColor];
	}
	else{
        txtVentureFlexi.backgroundColor = [UIColor whiteColor];
	}
    
    ///
    if (self.txtVentureGrowth.enabled == FALSE) {
        self.txtVentureGrowth.backgroundColor = [UIColor lightGrayColor];
    }
    else{
        self.txtVentureGrowth.backgroundColor = [UIColor whiteColor];
    }
    
    if (self.txtVentureBlueChip.enabled == FALSE) {
        self.txtVentureBlueChip.backgroundColor = [UIColor lightGrayColor];
    }
    else{
        self.txtVentureBlueChip.backgroundColor = [UIColor whiteColor];
    }
    
    if (self.txtVentureDana.enabled == FALSE) {
        self.txtVentureDana.backgroundColor = [UIColor lightGrayColor];
    }
    else{
        self.txtVentureDana.backgroundColor = [UIColor whiteColor];
    }
    
    if (self.txtVentureManaged.enabled == FALSE) {
        self.txtVentureManaged.backgroundColor = [UIColor lightGrayColor];
    }
    else{
        self.txtVentureManaged.backgroundColor = [UIColor whiteColor];
    }
    
    if (self.txtVentureIncome.enabled == FALSE) {
        self.txtVentureIncome.backgroundColor = [UIColor lightGrayColor];
    }
    else{
        self.txtVentureIncome.backgroundColor = [UIColor whiteColor];
    }
    
    if (self.txtVenture6666.enabled == FALSE) {
        self.txtVenture6666.backgroundColor = [UIColor lightGrayColor];
    }
    else{
        self.txtVenture6666.backgroundColor = [UIColor whiteColor];
    }
    
    if (self.txtVenture7777.enabled == FALSE) {
        self.txtVenture7777.backgroundColor = [UIColor lightGrayColor];
    }
    else{
        self.txtVenture7777.backgroundColor = [UIColor whiteColor];
    }
    
    if (self.txtVenture8888.enabled == FALSE) {
        self.txtVenture8888.backgroundColor = [UIColor lightGrayColor];
    }
    else{
        self.txtVenture8888.backgroundColor = [UIColor whiteColor];
    }
    
    if (self.txtVenture9999.enabled == FALSE) {
        self.txtVenture9999.backgroundColor = [UIColor lightGrayColor];
    }
    else{
        self.txtVenture9999.backgroundColor = [UIColor whiteColor];
    }

	if([PlanCode isEqualToString:@"UP"] && [BasicTerm intValue] == 20  ){
		[self DisableTextField:txt2035];
	}

}

-(void)DisableTextField :(UITextField *)aaTextField{
	aaTextField.backgroundColor = [UIColor lightGrayColor];
	aaTextField.enabled = FALSE;
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
	/*
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
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert setTag:1002];
    [alert show];
    */
	
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Delete fund:1" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert setTag:1002];
    [alert show];
}

- (IBAction)ActionEdit:(id)sender {
	[self resignFirstResponder];
    
    if (outletDelete.hidden) {
        outletDelete.hidden = FALSE;
        outletDelete.enabled = TRUE;
        [outletDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        [outletEdit setTitle:@"Cancel" forState:UIControlStateNormal ];
        
    }else{
        outletDelete.hidden = TRUE;
        outletDelete.enabled = FALSE;
        [outletEdit setTitle:@"Edit" forState:UIControlStateNormal ];
        
    }
    
   
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)keyboardDidShow:(NSNotificationCenter *)notification
{
    self.myScrollView.contentSize = CGSizeMake(768, 500);
    [self.myScrollView setContentOffset:CGPointMake(0,50) animated:YES];
	
}

-(void)keyboardDidHide:(NSNotificationCenter *)notification
{
    self.myScrollView.frame = CGRectMake(0, 44, 768, 430);
    self.myScrollView.contentSize = CGSizeMake(768, 430);
}

@end
