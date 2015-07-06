//
//  IDTypePicker.h
//  CardSnap
//
//  Created by Danial D. Moghaddam on 5/14/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol pickerDelegate;

@interface IDTypePicker : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    id <pickerDelegate> delegate;
}
-(void)initWithArray:(NSArray *)array;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *idTypesArr;
@property (strong, nonatomic) id <pickerDelegate> delegate;
@end

@protocol pickerDelegate <NSObject>

@required
-(void)idTypeSelected:(NSString *)idTypeStr;

@end