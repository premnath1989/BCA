//
//  Preference.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "Preference.h"
#import "ColorHexCode.h"
#import "DataClass.h"

@interface Preference (){
    DataClass *obj;
}

@end

@implementation Preference
@synthesize sliderValue;

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
	
	ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"Customer Fact Find";
    self.navigationItem.titleView = label;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnDone:)];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    obj=[DataClass getInstance];
    
    _programmaticallyCreatedSlider = [[TVCalibratedSlider alloc] initWithFrame:_sliderView.bounds withStyle:TavicsaStyle];
    
    [_programmaticallyCreatedSlider setThumbImage:nil forState:UIControlStateHighlighted];
    TVCalibratedSliderRange range2;
    //_programmaticallyCreatedSlider.value = 120.0;
    
    range2.maximumValue = 5;
    range2.minimumValue = 0;
    [_programmaticallyCreatedSlider setRange:range2];
	_programmaticallyCreatedSlider.frame = CGRectMake(60, -50, 620, 150);
    [_sliderView addSubview:_programmaticallyCreatedSlider];
    [_programmaticallyCreatedSlider setTextColorForHighlightedState:[UIColor redColor]];
    //	[_programmaticallyCreatedSlider]
    //    [_programmaticallyCreatedSlider setMarkerImageOffsetFromSlider:0];
    [_programmaticallyCreatedSlider setValue:[[[obj.CFFData objectForKey:@"SecE"] objectForKey:@"Preference"] intValue]];
    [_programmaticallyCreatedSlider setMarkerValueOffsetFromSlider:10];
    [_programmaticallyCreatedSlider setDelegate:self];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    
    //NSLog(@"rrr%@",[[obj.CFFData objectForKey:@"SecE"] objectForKey:@"Preference"]);
    
    sliderValue = [[obj.CFFData objectForKey:@"SecE"] objectForKey:@"Preference"];
    
    
}

- (void)valueChanged:(TVCalibratedSlider *)sender {
    //    NSLog(@"Delegate called");
	//NSLog(@"prefer: %d", sender.value);
    sliderValue = [NSString stringWithFormat:@"%d", sender.value];
    if (sender.value != 0){
        UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3004];
        //imageView.hidden = FALSE;
        imageView = nil;
        [[obj.CFFData objectForKey:@"SecE"] setValue:sliderValue forKey:@"Preference"];
        [[obj.CFFData objectForKey:@"SecE"] setValue:@"1" forKey:@"Completed"];
    }
    else{
        UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3004];
        //imageView.hidden = TRUE;;
        imageView = nil;
        [[obj.CFFData objectForKey:@"SecE"] setValue:@"0" forKey:@"Preference"];
        [[obj.CFFData objectForKey:@"SecE"] setValue:@"0" forKey:@"Completed"];
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
