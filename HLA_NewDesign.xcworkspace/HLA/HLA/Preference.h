//
//  Preference.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVCalibratedSlider.h"
#import "TVSlider.h"

@interface Preference : UITableViewController<TVCalibratedSliderDelegate>{
    TVCalibratedSlider *_programmaticallyCreatedSlider;
}

@property (weak, nonatomic) IBOutlet UITableViewCell *sliderView;
@property (strong, nonatomic) NSString *sliderValue;

@end
