//
//  CalculatorViewController.h
//  iMobile Planner
//
//  Created by Emi on 21/9/15.
//  Copyright (c) 2015 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController
- (IBAction)CloseView:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *SliderAge;
@property (weak, nonatomic) IBOutlet UILabel *Age;
@property (weak, nonatomic) IBOutlet UISlider *Disability65;
@property (weak, nonatomic) IBOutlet UISlider *Criticalillness65;
@property (weak, nonatomic) IBOutlet UISlider *Dying65label;
@property (weak, nonatomic) IBOutlet UISlider *probability65label;



@property (weak, nonatomic) IBOutlet UILabel *disabilityPercent;
@property (weak, nonatomic) IBOutlet UILabel *CriticalPercent;
@property (weak, nonatomic) IBOutlet UILabel *Dying65Percent;
@property (weak, nonatomic) IBOutlet UILabel *ProbabilityPercent;

- (IBAction)probability65:(UISlider *)sender;
- (IBAction)Dying65:(UISlider *)sender;
- (IBAction)Criticalillness65:(UISlider *)sender;
- (IBAction)SliderDisability65:(UISlider *)sender;
- (IBAction)Calculate:(id)sender;
- (IBAction)sliderValueChanged:(UISlider *)sender;

@end
