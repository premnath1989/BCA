//
//  RecordofAdvice.m
//  eAppScreen
//
//  Created by Erza on 7/7/13.
//  Copyright (c) 2013 IFC. All rights reserved.
//

#import "RecordofAdvice.h"
#import "ColorHexCode.h"
#import "DataClass.h"

#define NUMBERS_ONLY @"1234567890."
#define CHARACTER_LIMIT 15

@interface RecordofAdvice (){
        DataClass *obj;
}

@end

@implementation RecordofAdvice
@synthesize chkQuotation;
@synthesize btn1;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    obj=[DataClass getInstance];
    
    _SumAssuredP2.delegate = self;
    _ReasonP1.delegate = self;
    
    NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecG"] objectForKey:@"NameOfInsurerP1"]);
    
    //Load P1 Data
    if ([[obj.CFFData objectForKey:@"SecG"] objectForKey:@"TypeOfPlanP1"]) {
        NSLog(@"Loading from DataClass");
        _TypeOfPlanP1.text = [[obj.CFFData objectForKey:@"SecG"] objectForKey:@"TypeOfPlanP1"];
        _TermP1.text = [[obj.CFFData objectForKey:@"SecG"] objectForKey:@"TermP1"];
        _SumAssuredP1.text = [[obj.CFFData objectForKey:@"SecG"] objectForKey:@"SumAssuredP1"];
        _NameOfInsurerP1.text = [[obj.CFFData objectForKey:@"SecG"] objectForKey:@"NameOfInsurerP1"];
        _NameOfInsuredP1.text = [[obj.CFFData objectForKey:@"SecG"] objectForKey:@"NameOfInsuredP1"];
        _AdditionalBenefitsP1.text = [[obj.CFFData objectForKey:@"SecG"] objectForKey:@"AdditionalP1"];
        _ReasonP1.text = [[obj.CFFData objectForKey:@"SecG"] objectForKey:@"ReasonP1"];
        _ActionP1.text = [[obj.CFFData objectForKey:@"SecG"] objectForKey:@"ActionP1"];
    }
    else {
        NSLog(@"Loading From Db");
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsPath = [paths objectAtIndex:0];
        NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
        
        NSString *SINo = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:path];
        [database open];
        FMResultSet *results;
        // hardcoded sino for development
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM Trad_Details WHERE SINo = \"%@\"", SINo];
        results = [database executeQuery:query];
        while ([results next]) {
            _TermP1.text = [[results objectForColumnName:@"PolicyTerm"] stringValue];
            _SumAssuredP1.text = [[results objectForColumnName:@"BasicSA"] stringValue];
            
            NSString *planCode = [results objectForColumnName:@"PlanCode"];
            FMResultSet *results1 = [database executeQuery:[NSString stringWithFormat:@"SELECT PlanName FROM Trad_Sys_Profile WHERE PlanCode = \"%@\"", planCode]];
            while ([results1 next]) {
                _TypeOfPlanP1.text = [results1 objectForColumnName:@"PlanName"];
            }
            results1 = nil;
            results1 = [database executeQuery:[NSString stringWithFormat:@"SELECT D.prospectName from Trad_LAPayor as B, Clt_Profile as C, Prospect_Profile as D where B.CustCode = C.CustCode AND C.IndexNo = d.indexno AND B.SINO = \"%@\"", SINo]];
            while ([results1 next]) {
                _NameOfInsuredP1.text = [results1 objectForColumnName:@"ProspectName"];
            }
            
            NSString *riders = @"";
            results1 = nil;
            results1 = [database executeQuery:[NSString stringWithFormat:@"SELECT b.riderdesc FROM Trad_Rider_Details as A, Trad_Sys_Rider_Profile as B WHERE a.ridercode = b.ridercode AND a.sino = \"%@\"", SINo]];
            while ([results1 next]) {
                riders = [NSString stringWithFormat:@"%@\n%@", [results1 objectForColumnName:@"RiderDesc"], riders];
            }
            _AdditionalBenefitsP1.text = riders;
        }
    }
    
    //Load P2 Data
    _TypeOfPlanP2.text = [[obj.CFFData objectForKey:@"SecG"] objectForKey:@"TypeOfPlanP2"];
    _TermP2.text = [[obj.CFFData objectForKey:@"SecG"] objectForKey:@"TermP2"];
    _SumAssuredP2.text = [[obj.CFFData objectForKey:@"SecG"] objectForKey:@"SumAssuredP2"];
    _NameofInsurerP2.text = [[obj.CFFData objectForKey:@"SecG"] objectForKey:@"NameOfInsurerP2"];
    _NameofInsuredP2.text = [[obj.CFFData objectForKey:@"SecG"] objectForKey:@"NameOfInsuredP2"];
    _AdditionalBenefitsP2.text = [[obj.CFFData objectForKey:@"SecG"] objectForKey:@"AdditionalP2"];
    _ReasonP2.text = [[obj.CFFData objectForKey:@"SecG"] objectForKey:@"ReasonP2"];
}

/*
- (BOOL)textField:(UITextField *)sumAssuredP2 shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSUInteger newLength = [_SumAssuredP2.text length] + [string length] - range.length;
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    
    if ([_SumAssuredP2.text isEqualToString:@""])
        _SumAssuredP2.text = @"";
    
    return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT));
}
*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)checkQuotation:(id)sender {
//    [chkQuotation setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
   // [checkboxButton2 setImage:[UIImage imageNamed:@"emptyCheckBox.png"] forState:UIControlStateNormal];

    checked = YES;
}

- (void)viewDidUnload {
    [self setBtn1:nil];
    [self setAdditionalBenefitsP1:nil];
    [self setAdditionalBenefitsP1Dummy:nil];
    [self setReasonP1Dummy:nil];
    [self setReasonP1:nil];
    [self setActionP1Dummy:nil];
    [self setActionP1:nil];
    [self setTypeOfPlanP2:nil];
    [self setTermP2:nil];
    [self setSumAssuredP2:nil];
    [self setNameofInsurerP2:nil];
    [self setNameofInsuredP2:nil];
    [self setNameofInsuredP2Action:nil];
    [self setAdditionalBenefitsP2Dummy:nil];
    [self setAdditionalBenefitsP2:nil];
    [self setReasonP2:nil];
    [self setReasonP2dummy:nil];
    [self setTypeOfPlanP1:nil];
    [self setTermP1:nil];
    [self setSumAssuredP1:nil];
    [self setNameOfInsurerP1:nil];
    [self setNameOfInsuredP1:nil];
    [self setMyTableView:nil];
    [super viewDidUnload];
}

- (IBAction)clickBtn1:(id)sender {
    /*
	btn1.selected = !btn1.selected;
	if (btn1.selected) {
		[btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
	}
	else {
		[btn1 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
	}
     */

}
- (IBAction)TypeOfPlanP2Action:(id)sender {
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}
- (IBAction)SumAssuredP2Action:(id)sender {
    //NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	//[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	//[formatter setMaximumFractionDigits:2];
	//[formatter setPositiveFormat:@"#,##0.00"];
	//_SumAssuredP2.text = [formatter stringFromNumber:[formatter numberFromString:_SumAssuredP2.text]];
    //[[obj.CFFData objectForKey:@"SecG"] setValue:_SumAssuredP2.text forKey:@"SumAssuredP2"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}
- (IBAction)NameofInsurerP2Action:(id)sender {
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (void)textViewDidBeginEditing:(UITextView *)ReasonP1{
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (void)textViewDidEndEditing:(UITextView *)ReasonP1{
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (IBAction)TermP2Action:(id)sender {
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}
@end
