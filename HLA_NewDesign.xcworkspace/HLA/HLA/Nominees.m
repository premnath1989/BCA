//
//  Nominees.m
//  iMobile Planner
//
//  Created by shawal sapuan on 7/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "Nominees.h"
#import "ColorHexCode.h"
#import "DataClass.h"
#import "NomineesTrustees.h"


#define CHARACTER_LIMIT_ICNO 12
#define NUMBERS_ONLY @"0123456789"
#define CHARACTER_LIMIT_PC_F 12
#define CHARACTER_LIMIT_PC_NF 5
#define CHARACTER_LIMIT_NAME 70

@interface Nominees ()
{
    DataClass *obj;
     int totalshare;
}
@end

@implementation Nominees
@synthesize isSameAddress;

void UIKeyboardOrderOutAutomatic();


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
    
	//db for postcode
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    //KY Display the Nominee details from obj
    obj = [DataClass getInstance];
    _sexSC.selectedSegmentIndex = -1;
    
    _btnDelete.hidden = TRUE;
    _cellDelete.hidden = TRUE;
    
    //ky
     NSString *share ;
    if([[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"] == NULL)
    {
        share  = [NSString stringWithFormat:@"Current Total Share: 0%%"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"0" forKey:@"TotalShare"];
    }
    else
        share  = [NSString stringWithFormat:@"Current Total Share: %@%%", [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"]];
    
    _totalShareLbl.text = share;
    [_sharePercentageTF setDelegate:self];
    //ky
    
	
    if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"1"])
    {
        
        _titleLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_title"];
        _titleLbl.textColor = [UIColor blackColor];
        _nameTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_name"];
		NSLog(@"naa: %@", _nameTF.text);
        _icNoTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_ic"];
        _otherIDTypeLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_otherIDType"];
        _otherIDTypeLbl.textColor = [UIColor blackColor];
        _otherIDTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_otherID"];
        _dobLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_dob"];
        _dobLbl.textColor = [UIColor blackColor];
        
        if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_gender"] isEqualToString:@"male"])
            _sexSC.selectedSegmentIndex = 0;
        else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_gender"] isEqualToString:@"female"])
            _sexSC.selectedSegmentIndex =1 ;
        
        _sharePercentageTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_share"];
        _relationshipLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_relatioship"];
        _relationshipLbl.textColor = [UIColor blackColor];
        
        if(_nameTF.text == NULL || [_nameTF.text isEqual: @""])
        {
            _btnDelete.hidden = TRUE;
            _cellDelete.hidden = TRUE;
            
        }
        else
        {
            _btnDelete.hidden = FALSE;
            _cellDelete.hidden = FALSE;
        }
        
        if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_Address"] isEqualToString:@"same"])
            {   [_btnSameAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
                _btnSameAddress.tag = 1;
                isSameAddress = true;
            }
        else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_Address"] isEqualToString:@"foreign"])
            {
                [_btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
                _btnForeignAddress.tag = 1;
                
                _add1TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add1TF"];
                _add2TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add2TF"];
                _add3TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add3TF"];
                
                _postcodeTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_postcodeTF"];
                _townTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_townTF"];
                _stateLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_stateTF"];
                _countryLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_countryTF"];
                
            }
        else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_Address"] isEqualToString:@"new"])
            {
    
                    _add1TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add1TF"];
                    _add2TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add2TF"];
                    _add3TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add3TF"];
    
                    _postcodeTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_postcodeTF"];
                    _townTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_townTF"];
                    _stateLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_stateTF"];
                    _countryLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_countryTF"];
    
                }



    }

    else if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"2"])
    {
        _titleLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_title"];
        _titleLbl.textColor = [UIColor blackColor];
        
        _nameTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_name"];
        _icNoTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_ic"];
        _otherIDTypeLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_otherIDType"];
        _otherIDTypeLbl.textColor = [UIColor blackColor];
        
        _otherIDTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_otherID"];
        _dobLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_dob"];
        _dobLbl.textColor = [UIColor blackColor];
        
        if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_gender"] isEqualToString:@"male"])
            _sexSC.selectedSegmentIndex = 0;
         else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_gender"] isEqualToString:@"female"])
            _sexSC.selectedSegmentIndex =1 ;
        
        _sharePercentageTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_share"];
        _relationshipLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_relatioship"];
        _relationshipLbl.textColor = [UIColor blackColor];
        
        if(_nameTF.text == NULL || [_nameTF.text isEqual: @""])

        {
            _btnDelete.hidden = TRUE;
            _cellDelete.hidden = TRUE;
        }
        else
        {
            _btnDelete.hidden = FALSE;
            _cellDelete.hidden = FALSE;
        }
        
        if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_Address"] isEqualToString:@"same"])
        {   [_btnSameAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            _btnSameAddress.tag = 1;
            isSameAddress = true;
        }
        else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_Address"] isEqualToString:@"foreign"])
        {
            [_btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            _btnForeignAddress.tag = 1;
            
            _add1TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_add1TF"];
            _add2TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_add2TF"];
            _add3TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_add3TF"];
            
            _postcodeTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_postcodeTF"];
            _townTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_townTF"];
            _stateLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_stateTF"];
            _countryLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_countryTF"];
            
        }
        else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_Address"] isEqualToString:@"new"])
        {
            
            _add1TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_add1TF"];
            _add2TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_add2TF"];
            _add3TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_add3TF"];
            
            _postcodeTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_postcodeTF"];
            _townTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_townTF"];
            _stateLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_stateTF"];
            _countryLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_countryTF"];
            
        }


        
    }
    else if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"3"])
    {
        _titleLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_title"];
        _titleLbl.textColor = [UIColor blackColor];
        
        _nameTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_name"];
        _icNoTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_ic"];
        _otherIDTypeLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_otherIDType"];
         _otherIDTypeLbl.textColor = [UIColor blackColor];
        
        _otherIDTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_otherID"];
        _dobLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_dob"];
        _dobLbl.textColor = [UIColor blackColor];
        
        if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_gender"] isEqualToString:@"male"])
            _sexSC.selectedSegmentIndex = 0;
         else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_gender"] isEqualToString:@"female"])
            _sexSC.selectedSegmentIndex =1 ;
        
        _sharePercentageTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_share"];
        _relationshipLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_relatioship"];
        _relationshipLbl.textColor = [UIColor blackColor];
        
        if(_nameTF.text == NULL || [_nameTF.text isEqual: @""])

        {
            _btnDelete.hidden = TRUE;
            _cellDelete.hidden = TRUE;
        }
        else
        {
            _btnDelete.hidden = FALSE;
            _cellDelete.hidden = FALSE;
        }
        
        if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_Address"] isEqualToString:@"same"])
        {   [_btnSameAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            _btnSameAddress.tag = 1;
            isSameAddress = true;
        }
        else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_Address"] isEqualToString:@"foreign"])
        {
            [_btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            _btnForeignAddress.tag = 1;
            
            _add1TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_add1TF"];
            _add2TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_add2TF"];
            _add3TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_add3TF"];
            
            _postcodeTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_postcodeTF"];
            _townTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_townTF"];
            _stateLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_stateTF"];
            _countryLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_countryTF"];
            
        }
        else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_Address"] isEqualToString:@"new"])
        {
            
            _add1TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add1TF"];
            _add2TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add2TF"];
            _add3TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add3TF"];
            
            _postcodeTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_postcodeTF"];
            _townTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_townTF"];
            _stateLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_stateTF"];
            _countryLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_countryTF"];
            
        }


        
    }
    else if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"4"])
    {
        _titleLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_title"];
        _titleLbl.textColor = [UIColor blackColor];
        
        _nameTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_name"];
        _icNoTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_ic"];
        _otherIDTypeLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_otherIDType"];
        _otherIDTypeLbl.textColor = [UIColor blackColor];
        
        _otherIDTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_otherID"];
        _dobLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_dob"];
        _dobLbl.textColor = [UIColor blackColor];
        
        if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_gender"] isEqualToString:@"male"])
            _sexSC.selectedSegmentIndex = 0;
        else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_gender"] isEqualToString:@"female"])
            _sexSC.selectedSegmentIndex =1 ;
        
        _sharePercentageTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_share"];
        _relationshipLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_relatioship"];
        _relationshipLbl.textColor = [UIColor blackColor];
        
        if(_nameTF.text == NULL || [_nameTF.text isEqual: @""])
        {
            _btnDelete.hidden = TRUE;
            _cellDelete.hidden = TRUE;
        }
        else
        {
            _btnDelete.hidden = FALSE;
            _cellDelete.hidden = FALSE;
        }

        
        if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_Address"] isEqualToString:@"same"])
        {   [_btnSameAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            _btnSameAddress.tag = 1;
            isSameAddress = true;
        }
        else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_Address"] isEqualToString:@"foreign"])
        {
            [_btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
            _btnForeignAddress.tag = 1;
            
            _add1TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_add1TF"];
            _add2TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_add2TF"];
            _add3TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_add3TF"];
            
            _postcodeTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_postcodeTF"];
            _townTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_townTF"];
            _stateLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_stateTF"];
            _countryLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_countryTF"];
            
        }
        else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_Address"] isEqualToString:@"new"])
        {
            
            _add1TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_add1TF"];
            _add2TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_add2TF"];
            _add3TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_add3TF"];
            
            _postcodeTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_postcodeTF"];
            _townTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_townTF"];
            _stateLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee14_stateTF"];
            _countryLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_countryTF"];
            
        }

        
    }

}

- (void)textFieldDidEndEditing:(UITextField*)textField {
    if (textField==_sharePercentageTF) {
        // [levelEntryTextField endEditing:YES];
        //[levelEntryTextField removeFromSuperview];
        // here is where you should do something with the data they entered
        // NSString *total =  [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"];
        int total = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"] intValue];
        int add = [_sharePercentageTF.text intValue];
        
        totalshare = total + add;
        if(totalshare > 100)
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message: @"Total Percentage of Share exceeded 100%"
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert setTag:1003];
            [alert show];
            alert = Nil;
            _sharePercentageTF.text = @"";
        }
        else
        {
            NSString  *share  = [NSString stringWithFormat:@"%i",totalshare];
            
            // [[obj.eAppData objectForKey:@"SecD"] setValue:share forKey:@"TotalShare"];
            
            NSString  *stringshare  = [NSString stringWithFormat:@"Current Total Share: %@%%", share];
            
            _totalShareLbl.text = stringshare;
        }
    }
}

- (void)btnDone:(id)sender
{
    
    [self dismissModalViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)donePressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)actionForCountry:(id)sender {
	if (_CountryVC == nil) {
        self.CountryVC = [[CountryPopoverViewController alloc] initWithStyle:UITableViewStylePlain];
        _CountryVC.delegate = self;
        self.CountryPopover = [[UIPopoverController alloc] initWithContentViewController:_CountryVC];
    }
    [self.CountryPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}

-(void)selectedCountry:(NSString *)selectedCountry {
    _countryLbl.text = selectedCountry;
	_countryLbl.textColor = [UIColor blackColor];
    [_CountryPopover dismissPopoverAnimated:YES];
}

- (IBAction)actionForForeignAdd:(id)sender {
	isForeignAddress = !isForeignAddress;
	if(isForeignAddress) {
		[_btnForeignAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        _btnForeignAddress.tag = 1;
		
		_add1TF.enabled = YES;
		_add2TF.enabled = YES;
		_add3TF.enabled = YES;
		
		_postcodeTF.text = @"";
		//		_postcodeTF.textColor = [UIColor lightGrayColor];
		//		_postcodeTF.enabled = YES;
		//
		_townTF.text = @"";
		_townTF.enabled = YES;
		//		_townTF.placeholder = @"Town";
		////		_townTF.textColor = [UIColor lightGrayColor];
		
		//
		_stateLbl.text = @"State";
		_stateLbl.textColor = [UIColor lightGrayColor];
		
		_countryLbl.text = @"Country";
		_countryLbl.textColor = [UIColor lightGrayColor];
		_btnCountryPO.enabled = YES;_fa = TRUE;
	}
	else {
		[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        _btnForeignAddress.tag = 0;
		_add1TF.text = @"";
		_add1TF.enabled = YES;
		_add2TF.text = @"";
		_add2TF.enabled = YES;
		_add3TF.text = @"";
		_add3TF.enabled = YES;
		
		_postcodeTF.text = @"";
		_postcodeTF.enabled = YES;
		
		_townTF.text = @"";
		_townTF.enabled = NO;
		//
		//		_stateLbl.text = @"State";
		//		_stateLbl.textColor = [UIColor lightGrayColor];
		
		_countryLbl.text = @"MALAYSIA";
		_countryLbl.textColor = [UIColor blackColor];
		_btnCountryPO.enabled = NO; _fa = FALSE;
	}
}

- (IBAction)actionForSameAdd:(id)sender {
	isSameAddress = !isSameAddress;
	if(isSameAddress) {
		[_btnSameAddress setImage:[UIImage imageNamed:@"tickCheckBox.png"] forState:UIControlStateNormal];
        _btnSameAddress.tag = 1 ;
        isSameAddress = true;
        
		[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        _btnForeignAddress.tag = 0 ;
		
		_btnForeignAddress.enabled = NO;
		
		_add1TF.text = @"";
		_add1TF.enabled = NO;
		_add2TF.text = @"";
		_add2TF.enabled = NO;
		_add3TF.text = @"";
		_add3TF.enabled = NO;
		
		_postcodeTF.text = @"";
		_postcodeTF.enabled = NO;
		
		_townTF.text = @"";
		_townTF.enabled = NO;
		
		_stateLbl.text = @"State";
		_stateLbl.textColor = [UIColor lightGrayColor];
		
		_countryLbl.text = @"Country";
		_countryLbl.textColor = [UIColor lightGrayColor];
		_btnCountryPO.enabled = NO;_sa = TRUE;
	}
	else {
		[_btnSameAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        _btnSameAddress.tag = 0;
        isSameAddress = false;
		[_btnForeignAddress setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];
        _btnForeignAddress.tag = 0;
        
		_btnForeignAddress.enabled = YES;
		
		_add1TF.enabled = YES;
		_add2TF.enabled = YES;
		_add3TF.enabled = YES;
		
		//		_postcodeTF.placeholder = @"Postcode";
		_postcodeTF.enabled = YES;
		
		//		_townTF.placeholder = @"Town";
		_townTF.enabled = YES;
		
		_countryLbl.text = @"MALAYSIA";
		_countryLbl.textColor = [UIColor blackColor];
		_btnCountryPO.enabled = YES;_sa = FALSE;
	}
}

- (IBAction)actionForRelationship:(id)sender {
    
    UIKeyboardOrderOutAutomatic();
	if (_RelationshipVC == nil) {
		
        self.RelationshipVC = [[Relationship alloc] initWithStyle:UITableViewStylePlain];
        _RelationshipVC.delegate = self;
        _RelationshipVC.requestType = @"LA";
        self.RelationshipPopover = [[UIPopoverController alloc] initWithContentViewController:_RelationshipVC];
    }
    [self.RelationshipPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)selectedRelationship:(NSString *)theRelation
{
    _relationshipLbl.text = theRelation;
	_relationshipLbl.textColor = [UIColor blackColor];
    [self.RelationshipPopover dismissPopoverAnimated:YES];
}

- (IBAction)actionForDOB:(id)sender {
    
    UIKeyboardOrderOutAutomatic();
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    _dobLbl.text = dateString;
	_dobLbl.textColor = [UIColor blackColor];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    
    if (_SIDate == Nil) {
        
        self.SIDate = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIDate"];
        _SIDate.delegate = self;
        self.SIDatePopover = [[UIPopoverController alloc] initWithContentViewController:_SIDate];
    }
    
    [self.SIDatePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.SIDatePopover presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    
    
    dateFormatter = Nil;
    dateString = Nil, mainStoryboard = nil;
}

-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
    _dobLbl.text = strDate;
	_dobLbl.textColor = [UIColor blackColor];
}

-(void)CloseWindow
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [self.SIDatePopover dismissPopoverAnimated:YES];
}

- (IBAction)actionForOtherIDType:(id)sender {
    
    UIKeyboardOrderOutAutomatic();
	if (_IDTypeVC == nil) {
        
        self.IDTypeVC = [[IDTypeViewController alloc] initWithStyle:UITableViewStylePlain];
        _IDTypeVC.delegate = self;
        self.IDTypePopover = [[UIPopoverController alloc] initWithContentViewController:_IDTypeVC];
    }
    
    [self.IDTypePopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

}

-(void)selectedIDType:(NSString *)selectedIDType
{
    _otherIDTypeLbl.text = selectedIDType;
	_otherIDTypeLbl.textColor =  [UIColor blackColor];
    [self.IDTypePopover dismissPopoverAnimated:YES];
	_otherIDTF.enabled = YES;
}

- (IBAction)actionForTitle:(id)sender {
   
    UIKeyboardOrderOutAutomatic();
    
	if (_TitlePicker == nil) {
        _TitlePicker = [[TitleViewController alloc] initWithStyle:UITableViewStylePlain];
        _TitlePicker.delegate = self;
        self.TitlePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_TitlePicker];
    }
    
    [self.TitlePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

-(void)selectedTitle:(NSString *)selectedTitle
{
    _titleLbl.text = selectedTitle;
	_titleLbl.textColor = [UIColor blackColor];
    [self.TitlePickerPopover dismissPopoverAnimated:YES];
}

- (IBAction)editingDidEndPostcode:(id)sender {
	if (!isForeignAddress) {
		
		const char *dbpath = [databasePath UTF8String];
		sqlite3_stmt *statement;
		if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
			NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", _postcodeTF.text];
			const char *query_stmt = [querySQL UTF8String];
			if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
			{
				if (sqlite3_step(statement) == SQLITE_ROW){
					NSString *Town = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
					NSString *State = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
					NSString *Statecode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
					
					_stateLbl.text = State;
					_stateLbl.textColor = [UIColor blackColor];
					_townTF.text = Town;
					_townTF.enabled = NO;
					//				_townTF.textColor = [UIColor blackColor];
					_countryLbl.text = @"MALAYSIA";
					_countryLbl.textColor = [UIColor blackColor];
					//				SelectedOfficeStateCode = Statecode;
					//				gotRow = true;
					//				IsContinue = TRUE;
				}
				sqlite3_finalize(statement);
			}
			sqlite3_close(contactDB);
		}}
	else {
		_townTF.placeholder = @"Town";
		//		_townTF.textColor = [UIColor lightGrayColor];
		_townTF.enabled = YES;
		
		_stateLbl.text = @"State";
		_stateLbl.textColor = [UIColor lightGrayColor];
	}
}

- (IBAction)editingDidEndShare:(id)sender {
//	[_delegate updateTotalSharePct:_sharePercentageTF.text];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	if (textField == _postcodeTF) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		if (isForeignAddress) {
			return ((newLength <= CHARACTER_LIMIT_PC_F));
		}
		else {
			NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
			NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
			return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_PC_NF));
		}
	}
	
	else if (textField == _icNoTF) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT_ICNO));
	}
	else if (textField == _sharePercentageTF) {
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
		NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		return (([string isEqualToString:filtered]));
	}
	else if (textField == _nameTF) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		return ((newLength <= CHARACTER_LIMIT_NAME));
	}
	return YES;
}

- (IBAction)deleteNominee:(id)sender
{
    
    
    
    if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"1"])
    {
            
        int total = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"] intValue];
        
        int share1 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_share"] intValue];
        
        int new = total - share1;
        
       
        NSString* str_share = [NSString stringWithFormat:@"%i", new];


     //   NSLog(@"1 Total(%i) - share1(%i) = New share(%i)",total,share1, new );
        
        [[obj.eAppData objectForKey:@"SecD"] setValue:str_share forKey:@"TotalShare"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_share"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_title"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_name"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_ic"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_otherIDType"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_otherID"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_dob"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_gender"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_relatioship"];
        
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_add1TF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_add2TF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_add3TF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_postcodeTF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_townTF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_stateTF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_countryTF"];
        
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_Address"];
        
        _relationshipLbl.textColor = [UIColor blackColor];
        [self updateParentNominees];
        [self dismissModalViewControllerAnimated:YES];
        
        
       
    }
    
    else if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"2"])
    {
        
        
        int total = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"] intValue];
        
        int share1 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_share"] intValue];
        
        int new = total - share1;
        
        
        NSString* str_share = [NSString stringWithFormat:@"%i", new];
        
              
        [[obj.eAppData objectForKey:@"SecD"] setValue:str_share forKey:@"TotalShare"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_share"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_title"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_name"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_ic"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_otherIDType"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_otherID"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_dob"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_gender"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_relatioship"];
        
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_add1TF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_add2TF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_add3TF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_postcodeTF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_townTF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_stateTF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_countryTF"];

        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_Address"];
        

        _relationshipLbl.textColor = [UIColor blackColor];
        [self updateParentNominees];
        [self dismissModalViewControllerAnimated:YES];

       
    }
    else if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"3"])
    {
        
        int total = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"] intValue];
        
        int share1 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_share"] intValue];
        
        int new = total - share1;
        
        
        NSString* str_share = [NSString stringWithFormat:@"%i", new];
        
         
        
        [[obj.eAppData objectForKey:@"SecD"] setValue:str_share forKey:@"TotalShare"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_share"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_title"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_name"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_ic"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_otherIDType"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_otherID"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_dob"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_gender"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_relatioship"];
        
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_add1TF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_add2TF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_add3TF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_postcodeTF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_townTF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_stateTF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_countryTF"];
        
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_Address"];
        
        
        _relationshipLbl.textColor = [UIColor blackColor];
        [self updateParentNominees];
        [self dismissModalViewControllerAnimated:YES];

        
        
        
    }
    else if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"4"])
    {
        
        int total = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"] intValue];
        
        int share1 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_share"] intValue];
        
        int new = total - share1;
        
        
        NSString* str_share = [NSString stringWithFormat:@"%i", new];
        
       
        
        [[obj.eAppData objectForKey:@"SecD"] setValue:str_share forKey:@"TotalShare"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_share"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_title"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_name"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_ic"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_otherIDType"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_otherID"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_dob"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_gender"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_relatioship"];
        
        
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_add1TF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_add2TF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_add3TF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_postcodeTF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_townTF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_stateTF"];
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_countryTF"];
        
        [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_Address"];
        
        _relationshipLbl.textColor = [UIColor blackColor];
        
        [self updateParentNominees];
        [self dismissModalViewControllerAnimated:YES];

           
    }
    
     
    
   

    
    
}
-(void)updateParentNominees
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DeleteNominee" object:self];
    
    
}

- (void) dealloc
{
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (void)viewDidUnload {
	[self setTotalShareLbl:nil];
	[self setTitleLbl:nil];
	[self setNameTF:nil];
	[self setIcNoTF:nil];
	[self setOtherIDTypeLbl:nil];
	[self setOtherIDTF:nil];
	[self setDobLbl:nil];
	[self setSexSC:nil];
	[self setSharePercentageTF:nil];
	[self setRelationshipLbl:nil];
	[self setBtnSameAddress:nil];
	[self setBtnForeignAddress:nil];
	[self setAdd1TF:nil];
	[self setAdd2TF:nil];
	[self setAdd3TF:nil];
	[self setPostcodeTF:nil];
	[self setTownTF:nil];
	[self setStateLbl:nil];
	[self setCountryLbl:nil];
	[self setBtnTitlePO:nil];
	[super viewDidUnload];
}
@end
