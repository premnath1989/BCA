//
//  CustomView.h
//  iMobile Planner
//
//  Created by infoconnect on 10/10/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EverCustom;
@protocol EverCustom
-(void)ReturnSelection :(NSString *)aaCode andMsg :(NSString *)aaMsg;
@end

@interface CustomView : UIViewController{
	id <EverCustom> _delegate;
}


@property (nonatomic,strong) id <EverCustom> delegate;
@property (nonatomic, strong) id MsgBtn1;
@property (nonatomic, strong) id MsgBtn2;
@property (nonatomic, strong) id MsgBtn3;
@property (nonatomic, strong) id MsgBtn4;
@property (nonatomic, strong) id LabelMsg;
@property (nonatomic, strong) id Input1;
@property (nonatomic, strong) id Input2;
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;

@property (weak, nonatomic) IBOutlet UIButton *outletBtn1;
- (IBAction)ActionBtn1:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletBtn2;
- (IBAction)ActionBtn2:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletBtn3;
- (IBAction)ActionBtn3:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletBtn4;
- (IBAction)ActionBtn4:(id)sender;




@end
