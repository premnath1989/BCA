//
//  setting.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 9/28/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface setting : UIViewController

@property (nonatomic, assign,readwrite) int indexNo;
@property (nonatomic,strong) id userRequest;

@property (retain, nonatomic) NSMutableArray *ListOfSubMenu;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
- (IBAction)btnClose:(id)sender;
- (IBAction)ActionProfile:(id)sender;
- (IBAction)ActionSecurity:(id)sender;
- (IBAction)ActionPwd:(id)sender;


@end
