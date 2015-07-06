//
//  ConfirmationCFF.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductRecommended.h"

@interface ConfirmationCFF : UITableViewController<ProductRecommendedDelegate>

@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UIButton *btn3;
@property (strong, nonatomic) IBOutlet UIButton *btn4;
@property (strong, nonatomic) IBOutlet UIButton *btn5;
@property (strong, nonatomic) IBOutlet UIButton *btn6;

@property (weak, nonatomic) IBOutlet UITextView *othersField;
- (IBAction)clickBtn1:(id)sender;
- (IBAction)clickBtn2:(id)sender;
- (IBAction)clickBtn3:(id)sender;
- (IBAction)clickBtn4:(id)sender;
- (IBAction)clickBtn5:(id)sender;
- (IBAction)clickBtn6:(id)sender;

@property (strong, nonatomic) NSString *Advice1;
@property (strong, nonatomic) NSString *Advice2;
@property (strong, nonatomic) NSString *Advice3;
@property (strong, nonatomic) NSString *Advice4;
@property (strong, nonatomic) NSString *Advice5;
@property (strong, nonatomic) NSString *Advice6;


@property (weak, nonatomic) IBOutlet UILabel *productSI;

@property (weak, nonatomic) IBOutlet UILabel *product1;
@property (weak, nonatomic) IBOutlet UILabel *product2;
@property (weak, nonatomic) IBOutlet UILabel *product3;
@property (weak, nonatomic) IBOutlet UILabel *product4;
@property (weak, nonatomic) IBOutlet UILabel *product5;


@end
