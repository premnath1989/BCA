//
//  FNAEducation.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "FNAEducation.h"
#import "DataClass.h"
#import "EducationPlans.h"
#import "ExistingChildrenEducationPlans.h"

#define NUMBERS_ONLY @"1234567890."
#define CHARACTER_LIMIT 15

@interface FNAEducation (){
     DataClass *obj;
}

@end

@implementation FNAEducation

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
    _required1.delegate = self;
    _current1.delegate = self;
    
    _required2.delegate = self;
    _current2.delegate = self;
    
    _required3.delegate = self;
    _current3.delegate = self;
    
    _required4.delegate = self;
    _current4.delegate = self;
    
    _customerAlloc.delegate = self;
    
    obj=[DataClass getInstance];
    
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasEducation"] isEqualToString:@"0"]){
        hasEducation = TRUE;
        self.EducationSelected = TRUE;
        [_EducationPlans setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1"] isEqualToString:@"1"]){
            _plan1.text = [NSString stringWithFormat:@"Child Name: %@", [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation1ChildName"]];
        }
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2"] isEqualToString:@"1"]){
            _plan2.text = [NSString stringWithFormat:@"Child Name: %@", [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation2ChildName"]];
        }
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3"] isEqualToString:@"1"]){
            _plan3.text = [NSString stringWithFormat:@"Child Name: %@", [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation3ChildName"]];
        }
        
        if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4"] isEqualToString:@"1"]){
            _plan4.text = [NSString stringWithFormat:@"Child Name: %@", [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"ExistingEducation4ChildName"]];
        }
    }
    else{
        hasEducation = FALSE;
        self.EducationSelected = FALSE;
        [_EducationPlans setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        _current1.enabled = FALSE;
        _current2.enabled = FALSE;
        _current3.enabled = FALSE;
        _current4.enabled = FALSE;
    }
    
    
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"HasEducationChild"] isEqualToString:@"0"]){
        hasChildren = TRUE;
        self.ChildrenSelected = TRUE;
    }
    else{
        hasChildren = FALSE;
        self.ChildrenSelected = FALSE;
    }
    
    if ([[[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRowToHide"] isEqualToString:@"2"]){
        [_hasChild setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
    }
    else{
        [_hasChild setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    }
    

    self.rowToHide = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRowToHide"];
    //NSLog(@"ddd%@",self.rowToHide);
    
    
    _current1.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent1"];
    _required1.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired1"];
    _difference1.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference1"];
    
    _current2.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent2"];
    _required2.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired2"];
    _difference2.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference2"];
    
    _current3.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent3"];
    _required3.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired3"];
    _difference3.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference3"];
    
    _current4.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCurrent4"];
    _required4.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationRequired4"];
    _difference4.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationDifference4"];
    
    _customerAlloc.text = [[obj.CFFData objectForKey:@"SecF"] objectForKey:@"EducationCustomerAlloc"];
    

//_LabelToHide.hidden = TRUE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5){
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
        
        EducationPlans *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"EducationPlans"];
        vc.modalPresentationStyle = UIModalPresentationFormSheet;
        vc.rowToUpdate = indexPath.row;
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:NULL];
        [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create the parent view that will hold header Label
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(615.0, 0.0, 100.0, 0.0)];
    customView.backgroundColor = [UIColor clearColor];
    
    // create the button object
    UIButton * headerBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    headerBtn.backgroundColor = [UIColor clearColor];
    //headerBtn.opaque = NO;
    headerBtn.frame = CGRectMake(618.0, 15.0, 100.0, 30.0);
    
    [headerBtn setTitle:@"Clear All" forState:UIControlStateNormal];
    
    [headerBtn setBackgroundImage:[UIImage imageNamed:@"merahBtn.png"]
                         forState:UIControlStateNormal];
    [headerBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    
    [headerBtn addTarget:self action:@selector(ActionEventForButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [customView addSubview:headerBtn];
    
    return customView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([self.rowToHide isEqualToString:@"0"]){
        if (indexPath.row == 6){
            return 218;
        }
        else if (indexPath.row == 7){
            return 94;
        }
        return 44;
    }
    else if ([self.rowToHide isEqualToString:@"1"]){
        if (hasEducation){
            _plan1.hidden = FALSE;
            _plan2.hidden = FALSE;
            _plan3.hidden = FALSE;
            _plan4.hidden = FALSE;
        }
        else{
            if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5){
                _plan1.hidden = TRUE;
                _plan2.hidden = TRUE;
                _plan3.hidden = TRUE;
                _plan4.hidden = TRUE;
                return 0;
            }
        }
        if (indexPath.row == 6){
            return 218;
        }
        else if (indexPath.row == 7){
            return 94;
        }
        return 44;
    }
    else if ([self.rowToHide isEqualToString:@"2"]){
        //NSLog(@"1");
        if (hasChildren){
            //NSLog(@"2");
            _cell2.hidden = FALSE;
            
            if (hasEducation){
                //NSLog(@"3");
                _plan1.hidden = FALSE;
                _plan2.hidden = FALSE;
                _plan3.hidden = FALSE;
                _plan4.hidden = FALSE;;
            }
            else{
                //NSLog(@"4");
                if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5){
                    NSLog(@"5");
                    _plan1.hidden = TRUE;
                    _plan2.hidden = TRUE;
                    _plan3.hidden = TRUE;
                    _plan4.hidden = TRUE;
                    return 0;
                }
            }
            _cell3.hidden = FALSE;
            _cell4.hidden = FALSE;
            _cell5.hidden = FALSE;
            _cell6.hidden = FALSE;
            _cell7.hidden = FALSE;
            _cell8.hidden = FALSE;
            
            if (indexPath.row == 6){
                return 218;
            }
            else if (indexPath.row == 7){
                return 94;
            }
            return 44;
        }
        else{
            if (indexPath.row == 0){
                return 44;
            }
            else{
                _cell2.hidden = true;
                _cell3.hidden = true;
                _cell4.hidden = true;
                _cell5.hidden = true;
                _cell6.hidden = true;
                _cell7.hidden = true;
                _cell8.hidden = true;
                return 0;
            }
        }
    }

    
    /*
    if (hasChildren){
        _plan1.hidden = FALSE;
        _plan2.hidden = FALSE;
        _plan3.hidden = FALSE;
        _plan4.hidden = FALSE;
    }
    else{
        if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 || indexPath.row== 6 || indexPath.row == 7){
            _plan1.hidden = TRUE;
            _plan2.hidden = TRUE;
            _plan3.hidden = TRUE;
            _plan4.hidden = TRUE;
            return 0;
        }
    }
    if (indexPath.row == 6){
        return 218;
    }
    else if (indexPath.row == 7){
        return 94;
    }*/
    
    
    return 0;
}

- (void) ActionEventForButton:(id)sender {
    
    if(self.EducationSelected == FALSE)
    {
        _current1.text = @"0.00";
        _current2.text = @"0.00";
        _current3.text = @"0.00";
        _current4.text = @"0.00";

    }
    else
    {
        _current1.text = @"";
        _current2.text = @"";
        _current3.text = @"";
        _current4.text = @"";

    }
    _difference1.text = @"";
    _difference2.text =@"";
    _difference3.text = @"";
    _difference4.text = @"";
    
        
    _required1.text = @"";
    _required2.text = @"";
    _required3.text = @"";
    _required4.text = @"";
    
    _customerAlloc.text = @"";
    
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"0" forKey:@"CFFValidate"];
    
  
}




- (void)viewDidUnload {
    [self setEducationPlans:nil];
    [self setCurrent1:nil];
    [self setCurrent2:nil];
    [self setCurrent3:nil];
    [self setCurrent4:nil];
    [self setRequired1:nil];
    [self setRequired2:nil];
    [self setRequired3:nil];
    [self setRequired4:nil];
    [self setDifference1:nil];
    [self setDifference2:nil];
    [self setDifference3:nil];
    [self setDifference4:nil];
    [self setCustomerAlloc:nil];
    [self setPlan1:nil];
    [self setPlan2:nil];
    [self setPlan3:nil];
    [self setPlan4:nil];
    [self setMyTableView:nil];
    [self setPlan4:nil];
    [self setHasChild:nil];
    [self setCell1:nil];
    [self setCell2:nil];
    [self setCell3:nil];
    [self setCell4:nil];
    [self setCell5:nil];
    [self setCell6:nil];
    [self setCell7:nil];
    [self setCell8:nil];
    [super viewDidUnload];
}
- (IBAction)EducationPlansBtn:(id)sender {
    if (hasEducation){
        hasEducation = FALSE;
        self.EducationSelected = FALSE;
    }
    else{
        hasEducation = TRUE;
        self.EducationSelected = TRUE;
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
    
    
    if (hasEducation){
        NSString *zero = @"";
        _current1.text = zero;
        _current2.text = zero;
        _current3.text = zero;
        _current4.text = zero;
        
        _current1.enabled = TRUE;
        _current2.enabled = TRUE;
        _current3.enabled = TRUE;
        _current4.enabled = TRUE;
        [_EducationPlans setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasEducation"];
    }
    else{
        NSString *zero = @"0.00";
        _current1.text = zero;
        _current2.text = zero;
        _current3.text = zero;
        _current4.text = zero;
        
        _current1.enabled = FALSE;
        _current2.enabled = FALSE;
        _current3.enabled = FALSE;
        _current4.enabled = FALSE;
        
        [[obj.CFFData objectForKey:@"SecF"] setValue:zero forKey:@"EducationCurrent1"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:zero forKey:@"EducationCurrent2"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:zero forKey:@"EducationCurrent3"];
        [[obj.CFFData objectForKey:@"SecF"] setValue:zero forKey:@"EducationCurrent4"];
        
        [_EducationPlans setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"-1" forKey:@"HasEducation"];
    }
    
    self.rowToHide = @"1";
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    [self CalcualeDifference];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS_ONLY] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return (([string isEqualToString:filtered])&&(newLength <= CHARACTER_LIMIT));
}

- (IBAction)current1Action:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_current1.text = [formatter stringFromNumber:[formatter numberFromString:_current1.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_current1.text forKey:@"EducationCurrent1"];
    
    [self CalcualeDifference];
}
- (IBAction)current2Action:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_current2.text = [formatter stringFromNumber:[formatter numberFromString:_current2.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_current2.text forKey:@"EducationCurrent2"];
    
    [self CalcualeDifference];
}
- (IBAction)current3Action:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_current3.text = [formatter stringFromNumber:[formatter numberFromString:_current3.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_current3.text forKey:@"EducationCurrent3"];
    
    [self CalcualeDifference];
}
- (IBAction)current4Action:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_current4.text = [formatter stringFromNumber:[formatter numberFromString:_current4.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_current4.text forKey:@"EducationCurrent4"];
    
    [self CalcualeDifference];
}
- (IBAction)required1Action:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_required1.text = [formatter stringFromNumber:[formatter numberFromString:_required1.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_required1.text forKey:@"EducationRequired1"];
    
    [self CalcualeDifference];
}
- (IBAction)required2Action:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_required2.text = [formatter stringFromNumber:[formatter numberFromString:_required2.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_required2.text forKey:@"EducationRequired2"];
    
    [self CalcualeDifference];
}
- (IBAction)required3Action:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_required3.text = [formatter stringFromNumber:[formatter numberFromString:_required3.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_required3.text forKey:@"EducationRequired3"];
    
    [self CalcualeDifference];
}
- (IBAction)customerAllocAction:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_customerAlloc.text = [formatter stringFromNumber:[formatter numberFromString:_customerAlloc.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_customerAlloc.text forKey:@"EducationCustomerAlloc"];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}
- (IBAction)required4Action:(id)sender {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
	_required4.text = [formatter stringFromNumber:[formatter numberFromString:_required4.text]];
    [[obj.CFFData objectForKey:@"SecF"] setValue:_required4.text forKey:@"EducationRequired4"];
    
    [self CalcualeDifference];
}



-(void)CalcualeDifference{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
    
    if ([_current1.text length] == 0 || [_required1.text length] == 0){
        _difference1.text = @"";
        [[obj.CFFData objectForKey:@"SecF"] setValue:_difference1.text forKey:@"EducationDifference1"];
    }
    else{
        float stringFloat =  [[_required1.text stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue]
        - [[_current1.text stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];
        
        
        if (stringFloat < 0.00){
            _difference1.text = [formatter stringFromNumber:[formatter numberFromString:[NSString stringWithFormat:@"%f", stringFloat]]];
            _difference1.text = [_difference1.text stringByReplacingOccurrencesOfString:@"-"
                                                                             withString:@""];
            _difference1.text = [NSString stringWithFormat:@"(%@)",_difference1.text];
        }
        else{
            _difference1.text = [formatter stringFromNumber:[formatter numberFromString:[NSString stringWithFormat:@"%f", stringFloat]]];
        }
        [[obj.CFFData objectForKey:@"SecF"] setValue:_difference1.text forKey:@"EducationDifference1"];
    }
    
    if ([_current2.text length] == 0 || [_required2.text length] == 0){
        _difference2.text = @"";
        [[obj.CFFData objectForKey:@"SecF"] setValue:_difference2.text forKey:@"EducationDifference2"];
    }
    else{
        float stringFloat =  [[_required2.text stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue]
        - [[_current2.text stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];
        
        if (stringFloat < 0.00){
            _difference2.text = [formatter stringFromNumber:[formatter numberFromString:[NSString stringWithFormat:@"%f", stringFloat]]];
            _difference2.text = [_difference2.text stringByReplacingOccurrencesOfString:@"-"
                                                                             withString:@""];
            _difference2.text = [NSString stringWithFormat:@"(%@)",_difference2.text];
        }
        else{
            _difference2.text = [formatter stringFromNumber:[formatter numberFromString:[NSString stringWithFormat:@"%f", stringFloat]]];
        }
        [[obj.CFFData objectForKey:@"SecF"] setValue:_difference2.text forKey:@"EducationDifference2"];
    }
    
    if ([_current3.text length] == 0 || [_required3.text length] == 0){
        _difference3.text = @"";
        [[obj.CFFData objectForKey:@"SecF"] setValue:_difference3.text forKey:@"EducationDifference3"];
    }
    else{
        float stringFloat =  [[_required3.text stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue]
        - [[_current3.text stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];
        
        
        if (stringFloat < 0.00){
            _difference3.text = [formatter stringFromNumber:[formatter numberFromString:[NSString stringWithFormat:@"%f", stringFloat]]];
            _difference3.text = [_difference3.text stringByReplacingOccurrencesOfString:@"-"
                                                                             withString:@""];
            _difference3.text = [NSString stringWithFormat:@"(%@)",_difference3.text];
        }
        else{
            _difference3.text = [formatter stringFromNumber:[formatter numberFromString:[NSString stringWithFormat:@"%f", stringFloat]]];
        }
        [[obj.CFFData objectForKey:@"SecF"] setValue:_difference3.text forKey:@"EducationDifference3"];
    }
    
    if ([_current4.text length] == 0 || [_required4.text length] == 0){
        _difference4.text = @"";
        [[obj.CFFData objectForKey:@"SecF"] setValue:_difference4.text forKey:@"EducationDifference4"];
    }
    else{
        float stringFloat =  [[_required4.text stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue]
        - [[_current4.text stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];
        
        
        if (stringFloat < 0.00){
            _difference4.text = [formatter stringFromNumber:[formatter numberFromString:[NSString stringWithFormat:@"%f", stringFloat]]];
            _difference4.text = [_difference4.text stringByReplacingOccurrencesOfString:@"-"
                                                                             withString:@""];
            _difference4.text = [NSString stringWithFormat:@"(%@)",_difference4.text];
        }
        else{
            _difference4.text = [formatter stringFromNumber:[formatter numberFromString:[NSString stringWithFormat:@"%f", stringFloat]]];
        }
        [[obj.CFFData objectForKey:@"SecF"] setValue:_difference4.text forKey:@"EducationDifference4"];
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}


-(void)ExistingEducationPlansUpdate:(ExistingChildrenEducationPlans *)controller rowToUpdate:(int)rowToUpdate{
    if (rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingEducation1"];
        _plan1.text = [NSString stringWithFormat:@"Child Name: %@",controller.ChildName.text];
    }
    else if (rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingEducation2"];
        _plan2.text = [NSString stringWithFormat:@"Child Name: %@",controller.ChildName.text];
    }
    else if (rowToUpdate == 4){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingEducation3"];
        _plan3.text = [NSString stringWithFormat:@"Child Name: %@",controller.ChildName.text];
    }
    else if (rowToUpdate == 5){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ExistingEducation4"];
        _plan4.text = [NSString stringWithFormat:@"Child Name: %@",controller.ChildName.text];
    }
    
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

-(void)ExistingEducationPlansDelete:(ExistingChildrenEducationPlans *)controller rowToUpdate:(int)rowToUpdate{
    if (rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingEducation1"];
        _plan1.text = [NSString stringWithFormat:@"Add Children Education Plan (1)"];
    }
    else if (rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingEducation2"];
        _plan2.text = [NSString stringWithFormat:@"Add Children Education Plan (2)"];
    }
    else if (rowToUpdate == 4){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingEducation3"];
        _plan3.text = [NSString stringWithFormat:@"Add Children Education Plan (3)"];
    }
    else if (rowToUpdate == 5){
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"ExistingEducation4"];
        _plan4.text = [NSString stringWithFormat:@"Add Children Education Plan (4)"];
    }
    [self dismissViewControllerAnimated:TRUE completion:nil];
}


- (IBAction)hasChildBtn:(id)sender {
    if (hasChildren){
        hasChildren = FALSE;
        self.ChildrenSelected = FALSE;
    }
    else{
        hasChildren = TRUE;
        self.ChildrenSelected = TRUE;
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterDecimalStyle];
	[formatter setMaximumFractionDigits:2];
	[formatter setPositiveFormat:@"#,##0.00"];
    
    
    if (hasChildren){ //no child (hasNOChild)
        _current1.enabled = TRUE;
        _current2.enabled = TRUE;
        _current3.enabled = TRUE;
        _current4.enabled = TRUE;
        
        _required1.enabled = TRUE;
        _required2.enabled = TRUE;
        _required3.enabled = TRUE;
        _required4.enabled = TRUE;
        
        _customerAlloc.enabled = TRUE;
        
        [_hasChild setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"HasEducationChild"];
        [[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"0" forKey:@"Completed"];
    }
    else{
        _current1.enabled = FALSE;
        _current2.enabled = FALSE;
        _current3.enabled = FALSE;
        _current4.enabled = FALSE;
        
        _required1.enabled = FALSE;
        _required2.enabled = FALSE;
        _required3.enabled = FALSE;
        _required4.enabled = FALSE;
        
        _customerAlloc.enabled = FALSE;

        [_hasChild setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
        [[obj.CFFData objectForKey:@"SecF"] setValue:@"-1" forKey:@"HasEducationChild"];
        [[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"1" forKey:@"Completed"];
    }
    
    self.rowToHide = @"2";
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    //[self CalcualeDifference];

}
@end
