//
//  PotentialAreas.m
//  eAppScreen
//
//  Created by Erza on 7/7/13.
//  Copyright (c) 2013 IFC. All rights reserved.
//

#import "PotentialAreas.h"
#import "ColorHexCode.h"
#import "DataClass.h"

#import "MasterMenuCFF.h"

@interface PotentialAreas (){
    DataClass *obj;
    //UIImageView *imageView;
    MasterMenuCFF *parent;
}

@end

@implementation PotentialAreas
@synthesize planned1;
@synthesize planned2;
@synthesize planned3;
@synthesize planned4;
@synthesize planned5;
@synthesize Priority1;
@synthesize Priority2;
@synthesize Priority3;
@synthesize Priority4;
@synthesize Priority5;
@synthesize discussion1;
@synthesize discussion2;
@synthesize discussion3;
@synthesize discussion4;
@synthesize discussion5;

int priorityTag;



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
    //imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
    
    parent = (MasterMenuCFF *) self.parentViewController;
    
    if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Ans1"] length] == 0){
        [planned1 setSelectedSegmentIndex:-1];
    }
    else if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Ans1"] isEqualToString:@"Y"]){
        [planned1 setSelectedSegmentIndex:0];
    }
    else{
        [planned1 setSelectedSegmentIndex:1];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Ans1"] length] == 0){
        [planned2 setSelectedSegmentIndex:-1];
    }
    else if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Ans1"] isEqualToString:@"Y"]){
        [planned2 setSelectedSegmentIndex:0];
    }
    else{
        [planned2 setSelectedSegmentIndex:1];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Ans1"] length] == 0){
        [planned3 setSelectedSegmentIndex:-1];
    }
    else if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Ans1"] isEqualToString:@"Y"]){
        [planned3 setSelectedSegmentIndex:0];
    }
    else{
        [planned3 setSelectedSegmentIndex:1];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Ans1"] length] == 0){
        [planned4 setSelectedSegmentIndex:-1];
    }
    else if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Ans1"] isEqualToString:@"Y"]){
        [planned4 setSelectedSegmentIndex:0];
    }
    else{
        [planned4 setSelectedSegmentIndex:1];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Ans1"] length] == 0){
        [planned5 setSelectedSegmentIndex:-1];
    }
    else if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Ans1"] isEqualToString:@"Y"]){
        [planned5 setSelectedSegmentIndex:0];
    }
    else{
        [planned5 setSelectedSegmentIndex:1];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Ans2"] length] == 0){
        [discussion1 setSelectedSegmentIndex:-1];
    }
    else if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Ans2"] isEqualToString:@"Y"]){
        [discussion1 setSelectedSegmentIndex:0];
    }
    else{
        [discussion1 setSelectedSegmentIndex:1];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Ans2"] length] == 0){
        [discussion2 setSelectedSegmentIndex:-1];
    }
    else if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Ans2"] isEqualToString:@"Y"]){
        [discussion2 setSelectedSegmentIndex:0];
    }
    else{
        [discussion2 setSelectedSegmentIndex:1];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Ans2"] length] == 0){
        [discussion3 setSelectedSegmentIndex:-1];
    }
    else if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Ans2"] isEqualToString:@"Y"]){
        [discussion3 setSelectedSegmentIndex:0];
    }
    else{
        [discussion3 setSelectedSegmentIndex:1];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Ans2"] length] == 0){
        [discussion4 setSelectedSegmentIndex:-1];
    }
    else if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Ans2"] isEqualToString:@"Y"]){
        [discussion4 setSelectedSegmentIndex:0];
    }
    else{
        [discussion4 setSelectedSegmentIndex:1];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Ans2"] length] == 0){
        [discussion5 setSelectedSegmentIndex:-1];
    }
    else if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Ans2"] isEqualToString:@"Y"]){
        [discussion5 setSelectedSegmentIndex:-1];
    }
    else{
        [discussion5 setSelectedSegmentIndex:1];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Priority"] length] == 0){
        Priority1.titleLabel.text = @"N/A";
    }
    else{
        Priority1.titleLabel.text = [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Priority"];
        if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ1_Priority"] isEqualToString:@"1"]){
            discussion1.enabled = FALSE;
        }
    }
    
    if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Priority"] length] == 0){
        Priority2.titleLabel.text = @"N/A";
    }
    else{
        Priority2.titleLabel.text = [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Priority"];
        if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ2_Priority"] isEqualToString:@"1"]){
            discussion2.enabled = FALSE;
        }
    }
    
    if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Priority"] length] == 0){
        Priority3.titleLabel.text = @"N/A";
    }
    else{
        Priority3.titleLabel.text = [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Priority"];
        if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ3_Priority"] isEqualToString:@"1"]){
            discussion3.enabled = FALSE;
        }
    }
    
    if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Priority"] length] == 0){
        Priority4.titleLabel.text = @"N/A";
    }
    else{
        Priority4.titleLabel.text = [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Priority"];
        if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ4_Priority"] isEqualToString:@"1"]){
            discussion4.enabled = FALSE;
        }
    }
    
    if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Priority"] length] == 0){
        Priority5.titleLabel.text = @"N/A";
    }
    else{
        Priority5.titleLabel.text = [[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Priority"];
        if ([[[obj.CFFData objectForKey:@"SecD"] objectForKey:@"NeedsQ5_Priority"] isEqualToString:@"1"]){
            discussion5.enabled = FALSE;
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//-(void)selectedIDType:(NSString *)selectedIDType priority:(int)index
//{
////	index--;
//    NSLog(@"index no %d",priorityTag);
//	if (priorityTag == 1){
//		[_Priority1 setTitle:selectedIDType forState:UIControlStateNormal];
//	}
//    else if (priorityTag == 2){
//		[_Priority2 setTitle:selectedIDType forState:UIControlStateNormal];
//	}
//	else if (priorityTag == 3){
//		[_Priority3 setTitle:selectedIDType forState:UIControlStateNormal];
//	}
//	else if (priorityTag == 4){
//		[_Priority4 setTitle:selectedIDType forState:UIControlStateNormal];
//	}
//	else if (priorityTag == 5){
//		[_Priority5 setTitle:selectedIDType forState:UIControlStateNormal];
//	}
//
//		//_Priority1.frame.size.width = 79;
//    
//    if (_IDTypePickerPopover) {
//        [_IDTypePickerPopover dismissPopoverAnimated:YES];
//        _IDTypePickerPopover = nil;
//    }
//}

-(void)selectedIDType:(NSString *)selectedIDType
{
    
    if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"3"]){
        UITableViewCell *cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.userInteractionEnabled = YES;
    }
    
    UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
	if (priorityTag == 1){
		[Priority1 setTitle:selectedIDType forState:UIControlStateNormal];
        if ([selectedIDType isEqualToString:@"1"]){
            [discussion1 setSelectedSegmentIndex:0];
            discussion1.enabled = FALSE;
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"1" forKey:@"Priority"];
            
            if (planned1.selectedSegmentIndex != -1){
                //imageView.hidden = FALSE;
                
                if (planned2.selectedSegmentIndex != -1 && discussion2.selectedSegmentIndex != -1 && [Priority2.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                if (planned3.selectedSegmentIndex != -1 && discussion3.selectedSegmentIndex != -1 && [Priority3.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                if (planned4.selectedSegmentIndex != -1 && discussion4.selectedSegmentIndex != -1 && [Priority4.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                if (planned5.selectedSegmentIndex != -1 && discussion5.selectedSegmentIndex != -1 && [Priority5.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
            }
            
        }
        else{
            discussion1.enabled = TRUE;
            if (planned1.selectedSegmentIndex != -1 && discussion1.selectedSegmentIndex != -1){
                //imageView.hidden = TRUE;
                NSLog(@"dsdas");
                
                if (planned2.selectedSegmentIndex != -1 && discussion2.selectedSegmentIndex != -1 && ![Priority2.titleLabel.text isEqualToString:@"1"]){
                    //imageView.hidden = TRUE;
                }
                else{
                    if (planned2.selectedSegmentIndex == -1 && discussion2.selectedSegmentIndex == -1 && [Priority2.titleLabel.text isEqualToString:@"N/A"]){
                        //imageView.hidden = TRUE;
                    }
                    else{
                        //imageView.hidden = FALSE;
                    }
                }
                
                if (planned3.selectedSegmentIndex != -1 && discussion3.selectedSegmentIndex != -1 && ![Priority3.titleLabel.text isEqualToString:@"1"]){
                    //imageView.hidden = TRUE;
                }
                else{
                    if (planned3.selectedSegmentIndex == -1 && discussion3.selectedSegmentIndex == -1 && [Priority3.titleLabel.text isEqualToString:@"N/A"]){
                        //imageView.hidden = TRUE;
                    }
                    else{
                        //imageView.hidden = FALSE;
                    }
                }
                
                
                if (planned4.selectedSegmentIndex != -1 && discussion4.selectedSegmentIndex != -1 && ![Priority4.titleLabel.text isEqualToString:@"1"]){
                    //imageView.hidden = TRUE;
                }
                else{
                    if (planned4.selectedSegmentIndex == -1 && discussion4.selectedSegmentIndex == -1 && [Priority4.titleLabel.text isEqualToString:@"N/A"]){
                        //imageView.hidden = TRUE;
                    }
                    else{
                        //imageView.hidden = FALSE;
                    }
                }
                
                if (planned5.selectedSegmentIndex != -1 && discussion5.selectedSegmentIndex != -1 && ![Priority5.titleLabel.text isEqualToString:@"1"]){
                    //imageView.hidden = TRUE;
                }
                else{
                    if (planned5.selectedSegmentIndex == -1 && discussion5.selectedSegmentIndex == -1 && [Priority5.titleLabel.text isEqualToString:@"N/A"]){
                        //imageView.hidden = TRUE;
                    }
                    else{
                        //imageView.hidden = FALSE;
                    }
                }
                
                if ([Priority2.titleLabel.text isEqualToString:@"1"] || [Priority3.titleLabel.text isEqualToString:@"1"] || [Priority4.titleLabel.text isEqualToString:@"1"] || [Priority5.titleLabel.text isEqualToString:@"1"]){
                    //imageView.hidden = FALSE;
                }
                
            }
            else{
                //imageView.hidden = TRUE;
            }
            if ([selectedIDType isEqualToString:@"N/A"]){
                //imageView.hidden = TRUE;
            }
        }
	}
    else if (priorityTag == 2){
		[Priority2 setTitle:selectedIDType forState:UIControlStateNormal];
        if ([selectedIDType isEqualToString:@"1"]){
            [discussion2 setSelectedSegmentIndex:0];
            discussion2.enabled = FALSE;
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"2" forKey:@"Priority"];
            
            if (planned2.selectedSegmentIndex != -1){
                //imageView.hidden = FALSE;
                
                if (planned1.selectedSegmentIndex != -1 && discussion1.selectedSegmentIndex != -1 && [Priority1.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                if (planned3.selectedSegmentIndex != -1 && discussion3.selectedSegmentIndex != -1 && [Priority3.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                if (planned4.selectedSegmentIndex != -1 && discussion4.selectedSegmentIndex != -1 && [Priority4.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                if (planned5.selectedSegmentIndex != -1 && discussion5.selectedSegmentIndex != -1 && [Priority5.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
            }
        }
        else{
            discussion2.enabled = TRUE;
            if (planned2.selectedSegmentIndex != -1 && discussion2.selectedSegmentIndex != -1){
                //imageView.hidden = TRUE;
                
                if (planned1.selectedSegmentIndex != -1 && discussion1.selectedSegmentIndex != -1 && ![Priority1.titleLabel.text isEqualToString:@"1"]){
                    //imageView.hidden = TRUE;
                }
                else{
                    if (planned1.selectedSegmentIndex == -1 && discussion1.selectedSegmentIndex == -1 && [Priority1.titleLabel.text isEqualToString:@"N/A"]){
                        //imageView.hidden = TRUE;
                    }
                    else{
                        //imageView.hidden = FALSE;
                    }
                }
                if (planned3.selectedSegmentIndex != -1 && discussion3.selectedSegmentIndex != -1 && ![Priority3.titleLabel.text isEqualToString:@"1"]){
                    //imageView.hidden = TRUE;
                }
                else{
                    if (planned3.selectedSegmentIndex == -1 && discussion3.selectedSegmentIndex == -1 && [Priority3.titleLabel.text isEqualToString:@"N/A"]){
                        //imageView.hidden = TRUE;
                    }
                    else{
                        //imageView.hidden = FALSE;
                    }
                }
                if (planned4.selectedSegmentIndex != -1 && discussion4.selectedSegmentIndex != -1 && ![Priority4.titleLabel.text isEqualToString:@"1"]){
                    //imageView.hidden = TRUE;
                }
                else{
                    if (planned4.selectedSegmentIndex == -1 && discussion4.selectedSegmentIndex == -1 && [Priority4.titleLabel.text isEqualToString:@"N/A"]){
                        //imageView.hidden = TRUE;
                    }
                    else{
                        //imageView.hidden = FALSE;
                    }
                }
                if (planned5.selectedSegmentIndex != -1 && discussion5.selectedSegmentIndex != -1 && ![Priority5.titleLabel.text isEqualToString:@"1"]){
                    //imageView.hidden = TRUE;
                }
                else{
                    if (planned5.selectedSegmentIndex == -1 && discussion5.selectedSegmentIndex == -1 && [Priority5.titleLabel.text isEqualToString:@"N/A"]){
                        //imageView.hidden = TRUE;
                    }
                    else{
                        //imageView.hidden = FALSE;
                    }
                }
                
                if ([Priority1.titleLabel.text isEqualToString:@"1"] || [Priority3.titleLabel.text isEqualToString:@"1"] || [Priority4.titleLabel.text isEqualToString:@"1"] || [Priority5.titleLabel.text isEqualToString:@"1"]){
                    //imageView.hidden = FALSE;
                }
            }
            else{
                //imageView.hidden = TRUE;
            }
            if ([selectedIDType isEqualToString:@"N/A"]){
                //imageView.hidden = TRUE;
            }
        }
	}
	else if (priorityTag == 3){
		[Priority3 setTitle:selectedIDType forState:UIControlStateNormal];
        if ([selectedIDType isEqualToString:@"1"]){
            [discussion3 setSelectedSegmentIndex:0];
            discussion3.enabled = FALSE;
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"3" forKey:@"Priority"];
            
            if (planned3.selectedSegmentIndex != -1){
                //imageView.hidden = FALSE;
                
                if (planned1.selectedSegmentIndex != -1 && discussion1.selectedSegmentIndex != -1 && [Priority1.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                if (planned2.selectedSegmentIndex != -1 && discussion2.selectedSegmentIndex != -1 && [Priority2.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                if (planned4.selectedSegmentIndex != -1 && discussion4.selectedSegmentIndex != -1 && [Priority4.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                if (planned5.selectedSegmentIndex != -1 && discussion5.selectedSegmentIndex != -1 && [Priority5.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
            }
        }
        else{
            discussion3.enabled = TRUE;
            if (planned3.selectedSegmentIndex != -1 && discussion3.selectedSegmentIndex != -1){
                //imageView.hidden = TRUE;
                
                if (planned1.selectedSegmentIndex != -1 && discussion1.selectedSegmentIndex != -1 && [Priority1.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                else{
                    if (planned1.selectedSegmentIndex == -1 && discussion1.selectedSegmentIndex == -1 && [Priority1.titleLabel.text isEqualToString:@"N/A"]){
                        //imageView.hidden = TRUE;
                    }
                    else{
                        //imageView.hidden = FALSE;
                    }
                }
                if (planned2.selectedSegmentIndex != -1 && discussion2.selectedSegmentIndex != -1 && [Priority2.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                else{
                    if (planned2.selectedSegmentIndex == -1 && discussion2.selectedSegmentIndex == -1 && [Priority2.titleLabel.text isEqualToString:@"N/A"]){
                        //imageView.hidden = TRUE;
                    }
                    else{
                        //imageView.hidden = FALSE;
                    }
                }
                if (planned4.selectedSegmentIndex != -1 && discussion4.selectedSegmentIndex != -1 && [Priority4.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                else{
                    if (planned4.selectedSegmentIndex == -1 && discussion4.selectedSegmentIndex == -1 && [Priority4.titleLabel.text isEqualToString:@"N/A"]){
                        //imageView.hidden = TRUE;
                    }
                    else{
                        //imageView.hidden = FALSE;
                    }
                }
                if (planned5.selectedSegmentIndex != -1 && discussion5.selectedSegmentIndex != -1 && [Priority5.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                else{
                    if (planned5.selectedSegmentIndex == -1 && discussion5.selectedSegmentIndex == -1 && [Priority5.titleLabel.text isEqualToString:@"N/A"]){
                        //imageView.hidden = TRUE;
                    }
                    else{
                        //imageView.hidden = FALSE;
                    }
                }
                
                if ([Priority1.titleLabel.text isEqualToString:@"1"] || [Priority2.titleLabel.text isEqualToString:@"1"] || [Priority4.titleLabel.text isEqualToString:@"1"] || [Priority5.titleLabel.text isEqualToString:@"1"]){
                    //imageView.hidden = FALSE;
                }
            }
            else{
                //imageView.hidden = TRUE;
            }
            if ([selectedIDType isEqualToString:@"N/A"]){
                //imageView.hidden = TRUE;
            }
        }
	}
	else if (priorityTag == 4){
		[Priority4 setTitle:selectedIDType forState:UIControlStateNormal];
        if ([selectedIDType isEqualToString:@"1"]){
            [discussion4 setSelectedSegmentIndex:0];
            discussion4.enabled = FALSE;
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"4" forKey:@"Priority"];
            
            if (planned4.selectedSegmentIndex != -1){
                //imageView.hidden = FALSE;
                
                if (planned1.selectedSegmentIndex != -1 && discussion1.selectedSegmentIndex != -1 && [Priority1.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                if (planned3.selectedSegmentIndex != -1 && discussion3.selectedSegmentIndex != -1 && [Priority3.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                if (planned2.selectedSegmentIndex != -1 && discussion2.selectedSegmentIndex != -1 && [Priority2.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                if (planned5.selectedSegmentIndex != -1 && discussion5.selectedSegmentIndex != -1 && [Priority5.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
            }
        }
        else{
            discussion4.enabled = TRUE;
            if (planned4.selectedSegmentIndex != -1 && discussion4.selectedSegmentIndex != -1){
                //imageView.hidden = TRUE;
                
                if (planned1.selectedSegmentIndex != -1 && discussion1.selectedSegmentIndex != -1 && [Priority1.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                else{
                    if (planned1.selectedSegmentIndex == -1 && discussion1.selectedSegmentIndex == -1 && [Priority1.titleLabel.text isEqualToString:@"N/A"]){
                        //imageView.hidden = TRUE;
                    }
                    else{
                        //imageView.hidden = FALSE;
                    }
                }
                if (planned3.selectedSegmentIndex != -1 && discussion3.selectedSegmentIndex != -1 && [Priority3.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                else{
                    if (planned3.selectedSegmentIndex == -1 && discussion3.selectedSegmentIndex == -1 && [Priority3.titleLabel.text isEqualToString:@"N/A"]){
                        //imageView.hidden = TRUE;
                    }
                    else{
                        //imageView.hidden = FALSE;
                    }
                }
                if (planned2.selectedSegmentIndex != -1 && discussion2.selectedSegmentIndex != -1 && [Priority2.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                else{
                    if (planned2.selectedSegmentIndex == -1 && discussion2.selectedSegmentIndex == -1 && [Priority2.titleLabel.text isEqualToString:@"N/A"]){
                        //imageView.hidden = TRUE;
                    }
                    else{
                        //imageView.hidden = FALSE;
                    }
                }
                if (planned5.selectedSegmentIndex != -1 && discussion5.selectedSegmentIndex != -1 && [Priority5.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                else{
                    if (planned5.selectedSegmentIndex == -1 && discussion5.selectedSegmentIndex == -1 && [Priority5.titleLabel.text isEqualToString:@"N/A"]){
                        //imageView.hidden = TRUE;
                    }
                    else{
                        //imageView.hidden = FALSE;
                    }
                }
                
                if ([Priority1.titleLabel.text isEqualToString:@"1"] || [Priority2.titleLabel.text isEqualToString:@"1"] || [Priority3.titleLabel.text isEqualToString:@"1"] || [Priority5.titleLabel.text isEqualToString:@"1"]){
                    //imageView.hidden = FALSE;
                }
            }
            else{
                //imageView.hidden = TRUE;
            }
            if ([selectedIDType isEqualToString:@"N/A"]){
                //imageView.hidden = TRUE;
            }
        }
	}
	else if (priorityTag == 5){
		[Priority5 setTitle:selectedIDType forState:UIControlStateNormal];
        if ([selectedIDType isEqualToString:@"1"]){
            [discussion5 setSelectedSegmentIndex:0];
            discussion5.enabled = FALSE;
            [[obj.CFFData objectForKey:@"SecD"] setValue:@"5" forKey:@"Priority"];
            
            if (planned5.selectedSegmentIndex != -1){
                //imageView.hidden = FALSE;
                
                if (planned1.selectedSegmentIndex != -1 && discussion1.selectedSegmentIndex != -1 && [Priority1.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                if (planned3.selectedSegmentIndex != -1 && discussion3.selectedSegmentIndex != -1 && [Priority3.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                if (planned2.selectedSegmentIndex != -1 && discussion2.selectedSegmentIndex != -1 && [Priority2.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                if (planned4.selectedSegmentIndex != -1 && discussion4.selectedSegmentIndex != -1 && [Priority4.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
            }
        }
        else{
            discussion5.enabled = TRUE;
            if (planned5.selectedSegmentIndex != -1 && discussion5.selectedSegmentIndex != -1){
                //imageView.hidden = TRUE;
                
                if (planned1.selectedSegmentIndex != -1 && discussion1.selectedSegmentIndex != -1 && [Priority1.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                else{
                    if (planned1.selectedSegmentIndex == -1 && discussion1.selectedSegmentIndex == -1 && [Priority1.titleLabel.text isEqualToString:@"N/A"]){
                        //imageView.hidden = TRUE;
                    }
                    else{
                        //imageView.hidden = FALSE;
                    }
                }
                if (planned3.selectedSegmentIndex != -1 && discussion3.selectedSegmentIndex != -1 && [Priority3.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                else{
                    if (planned3.selectedSegmentIndex == -1 && discussion3.selectedSegmentIndex == -1 && [Priority3.titleLabel.text isEqualToString:@"N/A"]){
                        //imageView.hidden = TRUE;
                    }
                    else{
                        //imageView.hidden = FALSE;
                    }
                }
                if (planned2.selectedSegmentIndex != -1 && discussion2.selectedSegmentIndex != -1 && [Priority2.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                else{
                    if (planned2.selectedSegmentIndex == -1 && discussion2.selectedSegmentIndex == -1 && [Priority2.titleLabel.text isEqualToString:@"N/A"]){
                        //imageView.hidden = TRUE;
                    }
                    else{
                        //imageView.hidden = FALSE;
                    }
                }
                if (planned4.selectedSegmentIndex != -1 && discussion4.selectedSegmentIndex != -1 && [Priority4.titleLabel.text isEqualToString:@"N/A"]){
                    //imageView.hidden = TRUE;
                }
                else{
                    if (planned4.selectedSegmentIndex == -1 && discussion4.selectedSegmentIndex == -1 && [Priority4.titleLabel.text isEqualToString:@"N/A"]){
                        //imageView.hidden = TRUE;
                    }
                    else{
                        //imageView.hidden = FALSE;
                    }
                }
            }
            
            if ([Priority1.titleLabel.text isEqualToString:@"1"] || [Priority2.titleLabel.text isEqualToString:@"1"] || [Priority4.titleLabel.text isEqualToString:@"1"] || [Priority3.titleLabel.text isEqualToString:@"1"]){
                //imageView.hidden = FALSE;
            }
            else{
                //imageView.hidden = TRUE;
            }
            if ([selectedIDType isEqualToString:@"N/A"]){
                //imageView.hidden = TRUE;
            }
        }
	}
	
	//_Priority1.frame.size.width = 79;
    
    if (_IDTypePickerPopover) {
        [_IDTypePickerPopover dismissPopoverAnimated:YES];
        _IDTypePickerPopover = nil;
        imageView = nil;
    }
}

- (void)viewDidUnload {
    [self setPriority2:nil];
    [self setPriority3:nil];
    [self setPriority4:nil];
    [self setPriority5:nil];
    [self setResetAll:nil];
	[self setPriority1:nil];
	[self setPriority2:nil];
	[self setPlanned1:nil];
	[self setDiscussion1:nil];
	[self setPlanned2:nil];
	[self setDiscussion2:nil];
	[self setPlanned3:nil];
	[self setDiscussion3:nil];
	[self setPlanned4:nil];
	[self setDiscussion4:nil];
	[self setPlanned5:nil];
	[self setDiscussion5:nil];
    [self setPriority3:nil];
    [super viewDidUnload];
}

- (IBAction)prioritybtn1:(id)sender {
    
    
    if (_IDTypePicker == nil) {
        _IDTypePicker = [[PriorityViewController alloc] initWithStyle:UITableViewStylePlain];
        _IDTypePicker.delegate = self;
        _IDTypePicker.currentVal = Priority1.titleLabel.text;
        
    }
    
    if (_IDTypePickerPopover == nil) {
        
        _IDTypePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_IDTypePicker];
        _IDTypePicker.currentVal = Priority1.titleLabel.text;
        [_IDTypePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
        priorityTag = 1;
    } else {
        [_IDTypePickerPopover dismissPopoverAnimated:YES];
        _IDTypePickerPopover = nil;
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (IBAction)prioritybtn2:(id)sender {
    

    
    if (_IDTypePicker == nil) {
        _IDTypePicker = [[PriorityViewController alloc] initWithStyle:UITableViewStylePlain];
        _IDTypePicker.delegate = self;
        _IDTypePicker.currentVal = Priority2.titleLabel.text;
		
    }
    
    if (_IDTypePickerPopover == nil) {
        
        _IDTypePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_IDTypePicker];
        _IDTypePicker.currentVal = Priority2.titleLabel.text;
        [_IDTypePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
		priorityTag = 2;
    } else {
        [_IDTypePickerPopover dismissPopoverAnimated:YES];
        _IDTypePickerPopover = nil;
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (IBAction)prioritybtn3:(id)sender {
    

    
    if (_IDTypePicker == nil) {
        _IDTypePicker = [[PriorityViewController alloc] initWithStyle:UITableViewStylePlain];
        _IDTypePicker.delegate = self;
        _IDTypePicker.currentVal = Priority3.titleLabel.text;
		
    }
    
    if (_IDTypePickerPopover == nil) {
        
        _IDTypePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_IDTypePicker];
        _IDTypePicker.currentVal = Priority3.titleLabel.text;
        [_IDTypePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
		priorityTag = 3;
    } else {
        [_IDTypePickerPopover dismissPopoverAnimated:YES];
        _IDTypePickerPopover = nil;
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}


- (IBAction)prioritybtn4:(id)sender {
    

    
    if (_IDTypePicker == nil) {
        _IDTypePicker = [[PriorityViewController alloc] initWithStyle:UITableViewStylePlain];
        _IDTypePicker.delegate = self;
        _IDTypePicker.currentVal = Priority4.titleLabel.text;
		
    }
    
    if (_IDTypePickerPopover == nil) {
        
        _IDTypePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_IDTypePicker];
        _IDTypePicker.currentVal = Priority4.titleLabel.text;
        [_IDTypePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
		priorityTag = 4;
    } else {
        [_IDTypePickerPopover dismissPopoverAnimated:YES];
        _IDTypePickerPopover = nil;
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}
- (IBAction)prioritybtn5:(id)sender {
    

    
    if (_IDTypePicker == nil) {
        _IDTypePicker = [[PriorityViewController alloc] initWithStyle:UITableViewStylePlain];
        _IDTypePicker.delegate = self;
        _IDTypePicker.currentVal = Priority5.titleLabel.text;
		
    }
    
    if (_IDTypePickerPopover == nil) {
        
        _IDTypePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_IDTypePicker];
        _IDTypePicker.currentVal = Priority5.titleLabel.text;
        [_IDTypePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
		priorityTag = 5;
    } else {
        [_IDTypePickerPopover dismissPopoverAnimated:YES];
        _IDTypePickerPopover = nil;
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}
- (IBAction)resetAllBtn:(id)sender {
    //MasterMenuCFF *parent = (MasterMenuCFF *) self.parentViewController;
    
	[planned1 setSelectedSegmentIndex:UISegmentedControlNoSegment];
	[planned2 setSelectedSegmentIndex:UISegmentedControlNoSegment];
	[planned3 setSelectedSegmentIndex:UISegmentedControlNoSegment];
	[planned4 setSelectedSegmentIndex:UISegmentedControlNoSegment];
	[planned5 setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [planned1 setEnabled:TRUE];
    [planned2 setEnabled:TRUE];
    [planned3 setEnabled:TRUE];
    [planned4 setEnabled:TRUE];
    [planned5 setEnabled:TRUE];
	
	[discussion1 setSelectedSegmentIndex:UISegmentedControlNoSegment];
	[discussion2 setSelectedSegmentIndex:UISegmentedControlNoSegment];
	[discussion3 setSelectedSegmentIndex:UISegmentedControlNoSegment];
	[discussion4 setSelectedSegmentIndex:UISegmentedControlNoSegment];
	[discussion5 setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [discussion1 setEnabled:TRUE];
    [discussion2 setEnabled:TRUE];
    [discussion3 setEnabled:TRUE];
    [discussion4 setEnabled:TRUE];
    [discussion5 setEnabled:TRUE];
	
	[Priority1 setTitle:@"N/A" forState:UIControlStateNormal];
	[Priority2 setTitle:@"N/A" forState:UIControlStateNormal];
	[Priority3 setTitle:@"N/A" forState:UIControlStateNormal];
	[Priority4 setTitle:@"N/A" forState:UIControlStateNormal];
	[Priority5 setTitle:@"N/A" forState:UIControlStateNormal];
    
    UITableViewCell *cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.userInteractionEnabled = NO;
    
    UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
    imageView.hidden = TRUE;
    imageView = nil;
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"0" forKey:@"CFFValidate"];
}

- (IBAction)planned1Changed:(id)sender {
    
    if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"3"]){
        UITableViewCell *cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.userInteractionEnabled = YES;
    }
    
    if (discussion1.selectedSegmentIndex != -1 && ![Priority1.titleLabel.text isEqualToString:@"N/A"]){
        if (![Priority1.titleLabel.text isEqualToString:@"1"]){
            UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
            //imageView.hidden = TRUE;
            imageView = nil;
        }
        else{
            UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
            //imageView.hidden = FALSE;
            imageView = nil;
        }
    }
    else{
        UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
        //imageView.hidden = TRUE;
        imageView = nil;
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (IBAction)planned2Changed:(id)sender {
    
    if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"3"]){
        UITableViewCell *cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.userInteractionEnabled = YES;
    }
    
    if (discussion2.selectedSegmentIndex != -1 && ![Priority2.titleLabel.text isEqualToString:@"N/A"]){
        if (![Priority2.titleLabel.text isEqualToString:@"1"]){
            UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
            //imageView.hidden = TRUE;
            imageView = nil;
        }
        else{
            UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
            //imageView.hidden = FALSE;
            imageView = nil;
        }
    }
    else{
        UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
        //imageView.hidden = TRUE;
        imageView = nil;
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (IBAction)planned3Changed:(id)sender {
    
    if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"3"]){
        UITableViewCell *cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.userInteractionEnabled = YES;
    }
    
    if (discussion3.selectedSegmentIndex != -1 && ![Priority3.titleLabel.text isEqualToString:@"N/A"]){
        if (![Priority3.titleLabel.text isEqualToString:@"1"]){
            UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
            //imageView.hidden = TRUE;
            imageView = nil;
        }
        else{
            UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
            //imageView.hidden = FALSE;
            imageView = nil;
        }
    }
    else{
        UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
        //imageView.hidden = TRUE;
        imageView = nil;
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (IBAction)planned4Changed:(id)sender {
    
    if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"3"]){
        UITableViewCell *cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.userInteractionEnabled = YES;
    }
    
    if (discussion4.selectedSegmentIndex != -1 && ![Priority4.titleLabel.text isEqualToString:@"N/A"]){
        if (![Priority4.titleLabel.text isEqualToString:@"1"]){
            UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
            //imageView.hidden = TRUE;
            imageView = nil;
        }
        else{
            UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
            //imageView.hidden = FALSE;
            imageView = nil;
        }
    }
    else{
        UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
        //imageView.hidden = TRUE;
        imageView = nil;
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (IBAction)planned5Changed:(id)sender {
    
    if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"3"]){
        UITableViewCell *cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.userInteractionEnabled = YES;
    }
    
    if (discussion5.selectedSegmentIndex != -1 && ![Priority5.titleLabel.text isEqualToString:@"N/A"]){
        if (![Priority5.titleLabel.text isEqualToString:@"1"]){
            UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
            //imageView.hidden = TRUE;
            imageView = nil;
        }
        else{
            UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
            //imageView.hidden = FALSE;
            imageView = nil;
        }
    }
    else{
        UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
        //imageView.hidden = TRUE;
        imageView = nil;
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (IBAction)discussion1Changed:(id)sender {
   
    if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"3"]){
        UITableViewCell *cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.userInteractionEnabled = YES;
    }
    
    if (planned1.selectedSegmentIndex != -1 && ![Priority1.titleLabel.text isEqualToString:@"N/A"]){
        if (![Priority1.titleLabel.text isEqualToString:@"1"]){
            UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
            //imageView.hidden = TRUE;
            imageView = nil;
        }
        else{
            UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
            //imageView.hidden = FALSE;
            imageView = nil;
        }
    }
    else{
        UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
        //imageView.hidden = TRUE;
        imageView = nil;
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (IBAction)discussion2Changed:(id)sender {
    
    if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"3"]){
        UITableViewCell *cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.userInteractionEnabled = YES;
    }
    
    if (planned2.selectedSegmentIndex != -1 && ![Priority2.titleLabel.text isEqualToString:@"N/A"]){
        if (![Priority2.titleLabel.text isEqualToString:@"1"]){
            UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
            //imageView.hidden = TRUE;
            imageView = nil;
        }
        else{
            UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
            //imageView.hidden = FALSE;
            imageView = nil;
        }
    }
    else{
        UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
        //imageView.hidden = TRUE;
        imageView = nil;
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (IBAction)discussion3Changed:(id)sender {
    
    if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"3"]){
        UITableViewCell *cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.userInteractionEnabled = YES;
    }
    
    if (planned3.selectedSegmentIndex != -1 && ![Priority3.titleLabel.text isEqualToString:@"N/A"]){
        if (![Priority3.titleLabel.text isEqualToString:@"1"]){
            UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
            //imageView.hidden = TRUE;
            imageView = nil;
        }
        else{
            UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
            //imageView.hidden = FALSE;
            imageView = nil;
        }
    }
    else{
        UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
        //imageView.hidden = TRUE;
        imageView = nil;
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (IBAction)discussion4Changed:(id)sender {
    
    if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"3"]){
        UITableViewCell *cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.userInteractionEnabled = YES;
    }
    
    if (planned4.selectedSegmentIndex != -1 && ![Priority4.titleLabel.text isEqualToString:@"N/A"]){
        if (![Priority4.titleLabel.text isEqualToString:@"1"]){
            UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
            //imageView.hidden = TRUE;
            imageView = nil;
        }
        else{
            UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
            //imageView.hidden = FALSE;
            imageView = nil;
        }
    }
    else{
        UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
        //imageView.hidden = TRUE;
        imageView = nil;
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}

- (IBAction)discussion5Changed:(id)sender {
    
    if (![[[obj.CFFData objectForKey:@"SecB"] objectForKey:@"ClientChoice"] isEqualToString:@"3"]){
        UITableViewCell *cell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.userInteractionEnabled = YES;
    }
    
    if (planned5.selectedSegmentIndex != -1 && ![Priority5.titleLabel.text isEqualToString:@"N/A"]){
        if (![Priority5.titleLabel.text isEqualToString:@"1"]){
            UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
            //imageView.hidden = TRUE;
            imageView = nil;
        }
        else{
            UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
            //imageView.hidden = FALSE;
            imageView = nil;
        }
    }
    else{
        UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3003];
        //imageView.hidden = TRUE;
        imageView = nil;
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
}
@end
