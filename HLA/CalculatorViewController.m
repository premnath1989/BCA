//
//  CalculatorViewController.m
//  iMobile Planner
//
//  Created by Emi on 21/9/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController

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
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnDone:)];
    // Do any additional setup after loading the view from its nib.
	
	
}

- (void)btnDone:(id)sender
{

	[self dismissModalViewControllerAnimated:YES];
	
}

- (IBAction)sliderValueChanged:(UISlider *)sender;
{
	_Age.text =  [NSString stringWithFormat:@"%d years old", (int)sender.value];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)probability65:(UISlider *)sender
{
	_ProbabilityPercent.text =  [NSString stringWithFormat:@"%d years old", (int)sender.value];
}

- (IBAction)Dying65:(UISlider *)sender
{
	_Dying65Percent.text =  [NSString stringWithFormat:@"%d years old", (int)sender.value];
}

- (IBAction)Criticalillness65:(UISlider *)sender
{
	_CriticalPercent.text =  [NSString stringWithFormat:@"%d years old", (int)sender.value];
}

- (IBAction)SliderDisability65:(UISlider *)sender
{
	_disabilityPercent.text =  [NSString stringWithFormat:@"%d years old", (int)sender.value];
}

- (IBAction)Calculate:(id)sender
{
	
	int age;
	age =[_Age.text intValue];
	
	//_Age.text == age;
	
	[_Age setText:[NSString stringWithFormat:@"%i",age]];

	
	NSString *stringElementAttach_Disability65 = [NSString stringWithFormat:@"%@ %@",[NSString stringWithFormat:@"%i",age+10],@"%"];
	[_disabilityPercent setText:stringElementAttach_Disability65];
	int disabilityINT = [_disabilityPercent.text intValue];
	
	NSString *stringElementAttach_CriticalIlness65 = [NSString stringWithFormat:@"%@ %@",[NSString stringWithFormat:@"%i",age+16],@"%"];
	[_CriticalPercent setText:stringElementAttach_CriticalIlness65];
	int CriticalINT = [_CriticalPercent.text intValue];
	
	NSString *stringElementAttach_dying65 = [NSString stringWithFormat:@"%@ %@",[NSString stringWithFormat:@"%i",age+19],@"%"];
	[_Dying65Percent setText:stringElementAttach_dying65];
	int Dying65INT = [_Dying65Percent.text intValue];
	
	NSString *stringElementAttach_Probability = [NSString stringWithFormat:@"%@ %@",[NSString stringWithFormat:@"%i",age+14],@"%"];
	[_ProbabilityPercent setText:stringElementAttach_Probability];
	int ProbabilityINT = [_ProbabilityPercent.text intValue];
	
	
	//[_Plan setSelectedSegmentIndex:-1];

	
	
	
	[_probability65label setValue:ProbabilityINT animated:YES];
	[_Disability65 setValue:disabilityINT animated:YES];
	[_Criticalillness65 setValue:CriticalINT animated:YES];
	[_Dying65label setValue:Dying65INT animated:YES];
	
//	_ProbabilityPercent.text =@"25";
//	_Dying65Percent.text =@"25";
//	_CriticalPercent.text =@"25";
//	_disabilityPercent.text =@"25";
	


}

- (IBAction)CloseView:(id)sender
{
	[self dismissModalViewControllerAnimated:YES];
	
}
@end