//
//  CardSnap.m
//  CardSnap
//
//  Created by Danial D. Moghaddam on 5/14/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.

//

#import "CardSnap.h"
#import "SnapCustomCell.h"
#import "SnapGen.h"
#import <QuartzCore/QuartzCore.h>
#import "FormViewController.h"



#define kfirstLA        @"0"
#define ksecondLA       @"1"
#define kpolicyOwner    @"2"
#define kcontigentOwner @"3"
#define kfirstTrustee   @"4"
#define ksecondTrustee  @"5"
#define kgardian        @"6"
//#define kintermediary   @"7"
//#define kmanager        @"8"
#define kcreditCardFT     @"7"
#define kcreditCardRecc     @"8"

#define kFrontSnap      100
#define kBackSnap       200

@interface CardSnap ()
{
    DataClass *obj;
}

@end


@implementation CardSnap
@synthesize delegate,SelectedIndentity,SelectedCell,buttonSnapView;
@synthesize window = _window;

bool NeedToSave;
bool backPressed;
bool checkIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _snapArr = [[NSMutableArray alloc]init];
        [_snapArr addObjectsFromArray:@[@{@"rowTitlw": @"1st Life Assured", @"idType": @"Select Identification Type",@"frontSnap":@"",@"backSnap":@"",@"name":@""},
         @{@"rowTitlw": @"2nd Life Assured", @"idType": @"Select Identification Type",@"frontSnap":@"",@"backSnap":@"",@"name":@""},
         @{@"rowTitlw": @"Policy Owner", @"idType": @"Select Identification Type",@"frontSnap":@"",@"backSnap":@"",@"name":@""},
         @{@"rowTitlw": @"Contingent Owner", @"idType": @"Select Identification Type",@"frontSnap":@"",@"backSnap":@"",@"name":@""},
         @{@"rowTitlw": @"1st Trustee", @"idType": @"Select Identification Type",@"frontSnap":@"",@"backSnap":@"",@"name":@""},
         @{@"rowTitlw": @"2nd Trustee", @"idType": @"Select Identification Type",@"frontSnap":@"",@"backSnap":@"",@"name":@""},
         @{@"rowTitlw": @"Father/ Mother/ Guardian", @"idType": @"Select Identification Type",@"frontSnap":@"",@"backSnap":@"",@"name":@""},
         //                                        @{@"rowTitlw": @"Intermediary", @"idType": @"Select Identification Type",@"frontSnap":@"",@"backSnap":@""},
         //                                        @{@"rowTitlw": @"Manager", @"idType": @"Select Identification Type",@"frontSnap":@"",@"backSnap":@""},
         @{@"rowTitlw":  @"Card Holder \n(First Time Payment)", @"idType": @"Select Identification Type",@"frontSnap":@"",@"backSnap":@"",@"name":@""},
         @{@"rowTitlw": @"Card Holder \n(Recurring Payment)", @"idType": @"Select Identification Type",@"frontSnap":@"",@"backSnap":@"",@"name":@""}
         ]];
        
        _idTypes = [[NSArray alloc]initWithObjects:@"-Select-",@"New IC",@"Old Identification",@"Permanent Resident",@"Army Identification Number",@"Police Identification Number",@"Birth Certificate" ,@"Foreign Birth Certificate" ,@"Foreigner Identification Number" ,@"Passport" ,@"Singapore Identification Number" ,nil];
        
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"RightController");
    backPressed = NO;
	checkIndex = NO;
    // Do any additional setup after loading the view from its nib.
    [self getRequiredSnapList];
    rowIndex = 0;
    [_tableView reloadData];
    isAutoSelect = YES;
    
    obj=[DataClass getInstance];
    
    self.navigationItem.rightBarButtonItem.enabled = FALSE;
    
    _donebtn.enabled = FALSE;
	
	//HIDE DONE BUTTON
	_donebtn.image = nil;
	_donebtn.width = 0.0f;
    
    
    
    if([lAOtherIDType isEqualToString:@"EDD"])
    {
        [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                animated:NO
                          scrollPosition:UITableViewScrollPositionTop];
        [self tableView:_tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0]];
        
    }
    else
    {
        [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                animated:NO
                          scrollPosition:UITableViewScrollPositionTop];
        [self tableView:_tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *FormsPath =  [documentsDirectory stringByAppendingPathComponent:@"Forms"];
    NSMutableArray *dataItems;
    
    buttonSnapView = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonSnapView addTarget:self
                       action:@selector(SnapView1)
             forControlEvents:UIControlEventTouchUpInside];
    [buttonSnapView setTitle:@"View" forState:UIControlStateNormal];
    buttonSnapView.frame = CGRectMake(890, 420.0, 73, 44.0);
    [self.view addSubview:buttonSnapView];
    
    
    if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_LA1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
    {
        buttonSnapView.enabled =YES;
        _CheckView.hidden =NO;
        _CheckView1.hidden =NO;
    }
    
    else
    {
        buttonSnapView.enabled =NO;
        _CheckView.hidden =YES;
        _CheckView1.hidden =YES;
    }
    
    
    
    
    
    //    if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
    //    {
    //        buttonSnapView.enabled = YES;
    //
    //    }
    //    else
    //    {
    //        buttonSnapView.enabled =NO;
    //        buttonSnapView.tintColor =[UIColor grayColor];
    //    }
    
    
    
}

//-(void)SignInPromptMessage
//{
//    NSLog(@"alertHere");
//
//
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:nil];
//    FormViewController * agree = (FormViewController *)[storyboard instantiateViewControllerWithIdentifier:@"forms"];
//    //agree.changetext=YES;
//    // agree.textLabel.text=@"testing ghjhjjjjkjkj jhkjkjkjkjkjkj jkjkjkjjkjjk jkjkjjkjkjkjkjkjkj";
//    // agree.textLabel.numberOfLines=0;
//    // CustomAlertBox* agree=[[CustomAlertBox alloc] init];
//  //  agree.delegate=self;
//
//    agree.modalPresentationStyle = UIModalPresentationFormSheet;
//    agree.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//
//    agree.fileName =@"RN140923100957177_FF.pdf";
//    agree.fileTitle =@"Snap History";
//
//    [self presentModalViewController:agree animated:NO];
//    agree.view.superview.frame = CGRectMake(120, 200, 450, 600);
//
//
//
//}



- (IBAction)SnapView:(id)sender
{
    //  [self SignInPromptMessage];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *FormsPath =  [documentsDirectory stringByAppendingPathComponent:@"Forms"];
    
    NSString *otherIDType_check = @"CR";
    NSString *ptypeCode_check = @"PO";
    NSString *comcase = @"No";
    // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *results_check_comcase = [database executeQuery:@"SELECT * from eProposal_LA_Details WHERE eProposalNo = ? AND PTypeCode =? AND LAOtherIDType = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], ptypeCode_check, otherIDType_check];
    
    
    
    if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID.pdf",@"RN140922083513312"]]])
    {
        
        [self showFormDetails:@"Form"];
    }
    
    [self showFormDetails:@"Form"];
    
    // [self webviewToshowForm];
}

- (void)SnapView1
{
    //  [self SignInPromptMessage];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *FormsPath =  [documentsDirectory stringByAppendingPathComponent:@"Forms"];
    
    NSString *otherIDType_check = @"CR";
    NSString *ptypeCode_check = @"PO";
    NSString *comcase = @"No";
    // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *results_check_comcase = [database executeQuery:@"SELECT * from eProposal_LA_Details WHERE eProposalNo = ? AND PTypeCode =? AND LAOtherIDType = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], ptypeCode_check, otherIDType_check];
    
    
    
    if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID.pdf",@"RN140922083513312"]]])
    {
        
        [self showFormDetails:@"Form"];
    }
    
    [self showFormDetails:@"Form"];
    
    // [self webviewToshowForm];
}




-(void)showFormDetails:(NSString *) indexPath
{
    
    
    
    UIStoryboard *newStoryboard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:Nil];
    FormViewController * form = (FormViewController *)[newStoryboard instantiateViewControllerWithIdentifier:@"forms"];
    
    // NSString *title =  [NSString stringWithFormat:@"%@", [dataItems objectAtIndex:indexPath.row] ];
    NSString *title;
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *FormsPath =  [documentsDirectory stringByAppendingPathComponent:@"Forms"];
    NSMutableArray *dataItems;
    
    if (selectedRow ==0)
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_LA1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            NSLog(@"exist proposal form haha");
            [dataItems addObject:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_LA1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]];
            NSLog(@"formPath %@",[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_LA1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]);
            
            title =  @"SnapView";
            form.fileName =[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_LA1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
            
            form.fileTitle =@"Snap History";
            form.FromCardSnap =@"CardSnap";
            
            if  ((NSNull *) title == [NSNull null])
                title = @"";
            else
                form.fileTitle = title;
            
            
            form.modalPresentationStyle = UIModalPresentationFormSheet;
            form.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            //
            //form.fileName =@"RN140923100957177_FF.pdf";
            // agree.fileTitle =@"Snap History";
            //
            [self presentModalViewController:form animated:NO];
            ///    agree.view.superview.frame = CGRectMake(120, 200, 450, 600);
            
            if(![form.fileName isEqualToString:@"" ] && ![form.fileTitle isEqualToString:@""] )
                
                [self.navigationController pushViewController:form animated:YES];
            
            // [FormViewController view];//this will load your view
            //  [super.navigationController pushViewController:form animated:YES];
        }
        
    }
    
    else if (selectedRow ==1)
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_LA2.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
            NSLog(@"exist proposal form haha");
            [dataItems addObject:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_LA2.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]];
            NSLog(@"formPath %@",[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_LA2.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]);
            
            title =  @"SnapView";
            form.fileName =[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_LA2.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
            
            form.fileTitle =@"Snap History";
            form.FromCardSnap =@"CardSnap";
            
            if  ((NSNull *) title == [NSNull null])
                title = @"";
            else
                form.fileTitle = title;
            
            
            form.modalPresentationStyle = UIModalPresentationFormSheet;
            form.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            //
            //form.fileName =@"RN140923100957177_FF.pdf";
            // agree.fileTitle =@"Snap History";
            //
            [self presentModalViewController:form animated:NO];
            ///    agree.view.superview.frame = CGRectMake(120, 200, 450, 600);
            
            if(![form.fileName isEqualToString:@"" ] && ![form.fileTitle isEqualToString:@""] )
                
                [self.navigationController pushViewController:form animated:YES];
            
            // [FormViewController view];//this will load your view
            //  [super.navigationController pushViewController:form animated:YES];
        }
    }
    
    else if (selectedRow ==2)
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_PO.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
            NSLog(@"exist proposal form haha");
            [dataItems addObject:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_PO.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]];
            NSLog(@"formPath %@",[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_PO.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]);
            
            title =  @"SnapView";
            form.fileName =[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_PO.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
            
            form.fileTitle =@"Snap History";
            form.FromCardSnap =@"CardSnap";
            
            if  ((NSNull *) title == [NSNull null])
                title = @"";
            else
                form.fileTitle = title;
            
            
            form.modalPresentationStyle = UIModalPresentationFormSheet;
            form.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            //
            //form.fileName =@"RN140923100957177_FF.pdf";
            // agree.fileTitle =@"Snap History";
            //
            [self presentModalViewController:form animated:NO];
            ///    agree.view.superview.frame = CGRectMake(120, 200, 450, 600);
            
            if(![form.fileName isEqualToString:@"" ] && ![form.fileTitle isEqualToString:@""] )
                
                [self.navigationController pushViewController:form animated:YES];
            
            // [FormViewController view];//this will load your view
            //  [super.navigationController pushViewController:form animated:YES];
        }
    }
    
    else if (selectedRow ==3)
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CO.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
            NSLog(@"exist proposal form haha");
            [dataItems addObject:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CO.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]];
            NSLog(@"formPath %@",[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CO.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]);
            
            title =  @"SnapView";
            form.fileName =[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CO.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
            
            form.fileTitle =@"Snap History";
            form.FromCardSnap =@"CardSnap";
            
            if  ((NSNull *) title == [NSNull null])
                title = @"";
            else
                form.fileTitle = title;
            
            
            form.modalPresentationStyle = UIModalPresentationFormSheet;
            form.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            //
            //form.fileName =@"RN140923100957177_FF.pdf";
            // agree.fileTitle =@"Snap History";
            //
            [self presentModalViewController:form animated:NO];
            ///    agree.view.superview.frame = CGRectMake(120, 200, 450, 600);
            
            if(![form.fileName isEqualToString:@"" ] && ![form.fileTitle isEqualToString:@""] )
                
                [self.navigationController pushViewController:form animated:YES];
            
            // [FormViewController view];//this will load your view
            //  [super.navigationController pushViewController:form animated:YES];
        }
    }
    
    else if (selectedRow ==4)
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_TR1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
            NSLog(@"exist proposal form haha");
            [dataItems addObject:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_TR1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]];
            NSLog(@"formPath %@",[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_TR1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]);
            
            title =  @"SnapView";
            form.fileName =[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_TR1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
            
            form.fileTitle =@"Snap History";
            form.FromCardSnap =@"CardSnap";
            
            if  ((NSNull *) title == [NSNull null])
                title = @"";
            else
                form.fileTitle = title;
            
            
            form.modalPresentationStyle = UIModalPresentationFormSheet;
            form.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            //
            //form.fileName =@"RN140923100957177_FF.pdf";
            // agree.fileTitle =@"Snap History";
            //
            [self presentModalViewController:form animated:NO];
            ///    agree.view.superview.frame = CGRectMake(120, 200, 450, 600);
            
            if(![form.fileName isEqualToString:@"" ] && ![form.fileTitle isEqualToString:@""] )
                
                [self.navigationController pushViewController:form animated:YES];
            
            // [FormViewController view];//this will load your view
            //  [super.navigationController pushViewController:form animated:YES];
        }
    }
    else if (selectedRow ==5)
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_TR2.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
            NSLog(@"exist proposal form haha");
            [dataItems addObject:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_TR2.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]];
            NSLog(@"formPath %@",[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_TR2.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]);
            
            title =  @"SnapView";
            form.fileName =[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_TR2.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
            
            form.fileTitle =@"Snap History";
            form.FromCardSnap =@"CardSnap";
            
            if  ((NSNull *) title == [NSNull null])
                title = @"";
            else
                form.fileTitle = title;
            
            
            form.modalPresentationStyle = UIModalPresentationFormSheet;
            form.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            //
            //form.fileName =@"RN140923100957177_FF.pdf";
            // agree.fileTitle =@"Snap History";
            //
            [self presentModalViewController:form animated:NO];
            ///    agree.view.superview.frame = CGRectMake(120, 200, 450, 600);
            
            if(![form.fileName isEqualToString:@"" ] && ![form.fileTitle isEqualToString:@""] )
                
                [self.navigationController pushViewController:form animated:YES];
            
            // [FormViewController view];//this will load your view
            //  [super.navigationController pushViewController:form animated:YES];
        }
    }
    
    else if (selectedRow ==6)
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_GD.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
            NSLog(@"exist proposal form haha");
            [dataItems addObject:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_GD.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]];
            NSLog(@"formPath %@",[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_GD.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]);
            
            title =  @"SnapView";
            form.fileName =[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_GD.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
            
            form.fileTitle =@"Snap History";
            form.FromCardSnap =@"CardSnap";
            
            if  ((NSNull *) title == [NSNull null])
                title = @"";
            else
                form.fileTitle = title;
            
            
            form.modalPresentationStyle = UIModalPresentationFormSheet;
            form.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            //
            //form.fileName =@"RN140923100957177_FF.pdf";
            // agree.fileTitle =@"Snap History";
            //
            [self presentModalViewController:form animated:NO];
            ///    agree.view.superview.frame = CGRectMake(120, 200, 450, 600);
            
            if(![form.fileName isEqualToString:@"" ] && ![form.fileTitle isEqualToString:@""] )
                
                [self.navigationController pushViewController:form animated:YES];
            
            // [FormViewController view];//this will load your view
            //  [super.navigationController pushViewController:form animated:YES];
        }
    }
    
    else if (selectedRow ==7)
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CFP.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            NSLog(@"exist proposal form haha");
            [dataItems addObject:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CFP.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]];
            NSLog(@"formPath %@",[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CFP.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]);
            
            title =  @"SnapView";
            form.fileName =[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CFP.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
            
            form.fileTitle =@"Snap History";
            form.FromCardSnap =@"CardSnap";
            
            if  ((NSNull *) title == [NSNull null])
                title = @"";
            else
                form.fileTitle = title;
            
            
            form.modalPresentationStyle = UIModalPresentationFormSheet;
            form.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            //
            //form.fileName =@"RN140923100957177_FF.pdf";
            // agree.fileTitle =@"Snap History";
            //
            [self presentModalViewController:form animated:NO];
            ///    agree.view.superview.frame = CGRectMake(120, 200, 450, 600);
            
            if(![form.fileName isEqualToString:@"" ] && ![form.fileTitle isEqualToString:@""] )
                
                [self.navigationController pushViewController:form animated:YES];
            
            // [FormViewController view];//this will load your view
            //  [super.navigationController pushViewController:form animated:YES];
        }
    }
    
    else if (selectedRow ==8)
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CRP.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
            NSLog(@"exist proposal form haha");
            [dataItems addObject:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CRP.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]];
            NSLog(@"formPath %@",[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CRP.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]);
            
            title =  @"SnapView";
            form.fileName =[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CRP.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
            
            form.fileTitle =@"Snap History";
            form.FromCardSnap =@"CardSnap";
            
            if  ((NSNull *) title == [NSNull null])
                title = @"";
            else
                form.fileTitle = title;
            
            
            form.modalPresentationStyle = UIModalPresentationFormSheet;
            form.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            //
            //form.fileName =@"RN140923100957177_FF.pdf";
            // agree.fileTitle =@"Snap History";
            //
            [self presentModalViewController:form animated:NO];
            ///    agree.view.superview.frame = CGRectMake(120, 200, 450, 600);
            
            if(![form.fileName isEqualToString:@"" ] && ![form.fileTitle isEqualToString:@""] )
                
                [self.navigationController pushViewController:form animated:YES];
            
            // [FormViewController view];//this will load your view
            //  [super.navigationController pushViewController:form animated:YES];
        }
    }
    
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Local Methods
- (IBAction)backSnapDelete:(id)sender {
}

-(void)supportDocForProposalNo:(NSString *)proposalNo fromInfoDic:(NSDictionary *)infoDic
{
    if (infoDic) {
        proposalNumber = proposalNo;
        
        
        //        intermediaryName = [[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryName"];
        //        intermediaryNICNo = [[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryNRIC"];
        //        intermediaryCode = [[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryCode"];
        //        intermediaryContractDate = [[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryContractDate"];
        //        intermediaryManagerName = [[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"IntermediaryManagerName"];
        
        id obj = [[infoDic objectForKey:@"AssuredInfo"]objectForKey:@"Party"];
        NSArray *partiesArr;
        if (![obj isKindOfClass:[NSArray class]]) {
            partiesArr = [[NSArray alloc]initWithObjects:obj, nil];
        }
        else
        {
            partiesArr = obj;
        }
        for (id party in partiesArr) {
            if ([[party objectForKey:@"PTypeCode"]hasPrefix:@"LA"]&&[[party objectForKey:@"Seq"]hasPrefix:@"1"]) {
                //                lAName = [NSString stringWithFormat:@"%@ %@",[party objectForKey:@"LATitle"],[party objectForKey:@"LAName"]];
                lAName = [NSString stringWithFormat:@"%@",[party objectForKey:@"LAName"]];
                
                lAOtherIDType  = [[party objectForKey:@"LAOtherID"]objectForKey:@"LAOtherIDType"];
                lAICNO = [[party objectForKey:@"LANewIC"]objectForKey:@"LANewICNo"];
                laICType = [[party objectForKey:@"LANewIC"]objectForKey:@"LANewICCode"];
                lADOB = [party objectForKey:@"LADOB"];
                
                
                if (![lAICNO length]) {
                    lAICNO = [[party objectForKey:@"LAOtherID"]objectForKey:@"LAOtherID"];
                    laICType = @"Other";
                }
                
            }
            if ([[party objectForKey:@"PTypeCode"]hasPrefix:@"LA"]&&[[party objectForKey:@"Seq"]hasPrefix:@"2"]) {
                //                secondLAName = [NSString stringWithFormat:@"%@ %@",[party objectForKey:@"LATitle"],[party objectForKey:@"LAName"]];
                secondLAName = [NSString stringWithFormat:@"%@",[party objectForKey:@"LAName"]];
                secondLAICNO = [[party objectForKey:@"LANewIC"]objectForKey:@"LANewICNo"];
                secondLAICType = [[party objectForKey:@"LANewIC"]objectForKey:@"LANewICCode"];
                if (![secondLAICNO length]) {
                    secondLAICNO = [[party objectForKey:@"LAOtherID"]objectForKey:@"LAOtherID"];
                    secondLAICType = @"Other";
                }
                
            }
            if ([[party objectForKey:@"PTypeCode"]hasPrefix:@"PO"]) {
                //                policyOwnerNamel = [NSString stringWithFormat:@"%@ %@",[party objectForKey:@"LATitle"],[party objectForKey:@"LAName"]];
                policyOwnerNamel = [NSString stringWithFormat:@"%@",[party objectForKey:@"LAName"]];
                policyOwnerICNO = [[party objectForKey:@"LANewIC"]objectForKey:@"LANewICNo"];
                policyOwnerICType = [[party objectForKey:@"LANewIC"]objectForKey:@"LANewICCode"];
                
                if (![policyOwnerICNO length]) {
                    policyOwnerICNO = [[party objectForKey:@"LAOtherID"]objectForKey:@"LAOtherID"];
                    policyOwnerICType = @"Other";
                }
                
            }
            
            
            
            //           NSLog(@"party %@",party);//[party objectForKey:@"PTypeCode"]);
            
            //            if ([[party objectForKey:@"PTypeCode"]hasPrefix:@"PO"]) {
            //                policyOwnerNamel = [NSString stringWithFormat:@"%@ %@",[party objectForKey:@"LATitle"],[party objectForKey:@"LAName"]];
            //                policyOwnerICNO = [[party objectForKey:@"LANewIC"]objectForKey:@"LANewICNo"];
            //                policyOwnerICType = [[party objectForKey:@"LANewIC"]objectForKey:@"LANewICCode"];
            //
            //                if (![policyOwnerICNO length]) {
            //                    policyOwnerICNO = [[party objectForKey:@"LAOtherID"]objectForKey:@"LAOtherID"];
            //                    policyOwnerICType = @"Other";
            //                }
            //
            //            }
            
        }
        
        //        id obj2 = [infoDic objectForKey:@"TrusteeInfo"];
        //        NSArray *partiesArr2;
        //        if (![obj2 isKindOfClass:[NSArray class]]) {
        //            partiesArr2 = [[NSArray alloc]initWithObjects:obj2, nil];
        //        }
        //        else
        //        {
        //            partiesArr2 = obj2;
        //        }
        //        for (id party2 in partiesArr2) {
        //            if ([[party2 objectForKey:@"Seq"]hasPrefix:@"1"])
        //            {
        //             //   lAName = [NSString stringWithFormat:@"%@ %@",[party2 objectForKey:@"LATitle"],[party2 objectForKey:@"LAName"]];
        //                trusteeName  = [party2 objectForKey:@"TrusteeName"];
        ////                lAICNO = [[party2 objectForKey:@"LANewIC"]objectForKey:@"LANewICNo"];
        ////                laICType = [[party2 objectForKey:@"LANewIC"]objectForKey:@"LANewICCode"];
        ////                lADOB = [party2 objectForKey:@"LADOB"];
        //
        //
        //            }
        //
        //            else
        //            {
        //
        //            }
        ////            if ([[party2 objectForKey:@"PTypeCode"]hasPrefix:@"LA"]&&[[party2 objectForKey:@"Seq"]hasPrefix:@"2"]) {
        ////                secondLAName = [NSString stringWithFormat:@"%@ %@",[party2 objectForKey:@"LATitle"],[party2 objectForKey:@"LAName"]];
        ////                secondLAICNO = [[party2 objectForKey:@"LANewIC"]objectForKey:@"LANewICNo"];
        ////                secondLAICType = [[party2 objectForKey:@"LANewIC"]objectForKey:@"LANewICCode"];
        ////                if (![secondLAICNO length]) {
        ////                    secondLAICNO = [[party2 objectForKey:@"LAOtherID"]objectForKey:@"LAOtherID"];
        ////                    secondLAICType = @"Other";
        ////                }
        //
        //            }
        //
        //        }
        
        
        id obj2 = [infoDic objectForKey:@"TrusteeInfo"];
		int trusteeCount2;
        trusteeCount2 = [[obj2 objectForKey:@"TrusteeCount"] integerValue];
		
        //		NSString *trusteeName2;
		
		id objT = [[infoDic objectForKey:@"TrusteeInfo"]objectForKey:@"Trustee"];
        NSArray *partiesArrT;
        if (![objT isKindOfClass:[NSArray class]]) {
            partiesArrT = [[NSArray alloc]initWithObjects:objT, nil];
        }
        else
        {
            partiesArrT = objT;
        }
        for (id partyy in partiesArrT) {
            if([[partyy objectForKey:@"Seq"]hasPrefix:@"1"]){
				trusteeName = [partyy objectForKey:@"TrusteeName"];
            }
            if([[partyy objectForKey:@"Seq"]hasPrefix:@"2"]){
                trusteeName2 = [partyy objectForKey:@"TrusteeName"];
                
            }
            
        }
		
        
        //        trusteeName = [[obj2 objectForKey:@"Trustee"] objectForKey:@"TrusteeName"];
        
        
        
        trusteeCount = [[infoDic objectForKey:@"TrusteeInfo"]objectForKey:@"TrusteeCount"];
		
		NSLog(@"count: %@", trusteeCount);
        //     trusteeName  = [[[[infoDic objectForKey:@"TrusteeInfo"]infoDic objectForKey:@"Seq = 1"]hasPrefix:@"2"]objectForKey:@"TrusteeName"];
        
        gardianName = [[[infoDic objectForKey:@"iMobileExtraInfo"]objectForKey:@"Guardian"]objectForKey:@"GuardianName"];
        
        
        //        cardMemberAccNO = [[infoDic objectForKey:@"CreditCardInfo"]objectForKey:@"CardMemberAccountNo"];
        //        creditCardBank = [[infoDic objectForKey:@"CreditCardInfo"]objectForKey:@"CreditCardBank"];
        //        cardExpiredDate = [[infoDic objectForKey:@"CreditCardInfo"]objectForKey:@"CardExpiredDate"];
        //        cardMemberName = [[infoDic objectForKey:@"CreditCardInfo"]objectForKey:@"CardMemberName"];
        //        totalModalPremium = [[infoDic objectForKey:@"PaymentInfo"]objectForKey:@"TotalModalPremium"];
        //        cardMemberNewICNo = [[infoDic objectForKey:@"CreditCardInfo"]objectForKey:@"CardMemberNewICNo"];
        //        cardMemberRelationship = [[infoDic objectForKey:@"CreditCardInfo"]objectForKey:@"CardMemberRelationship"];
        //
        //        cardMemberAccNORC = [[infoDic objectForKey:@"FTCreditCardInfo"]objectForKey:@"FTCardMemberAccountNo"];
        //        creditCardBankRC = [[infoDic objectForKey:@"FTCreditCardInfo"]objectForKey:@"FTCreditCardBank"];
        //        cardExpiredDateRC = [[infoDic objectForKey:@"FTCreditCardInfo"]objectForKey:@"FTCardExpiredDate"];
        //        cardMemberNameRC = [[infoDic objectForKey:@"FTCreditCardInfo"]objectForKey:@"FTCardMemberName"];
        //        totalModalPremiumRC = [[infoDic objectForKey:@"FTCreditCardInfo"]objectForKey:@"FTTotalModalPremium"];
        //        cardMemberNewICNoRC = [[infoDic objectForKey:@"FTCreditCardInfo"]objectForKey:@"FTCardMemberNewICNo"];
        //        cardMemberRelationshipRC = [[infoDic objectForKey:@"FTCreditCardInfo"]objectForKey:@"FTCardMemberRelationship"];
        
        cardMemberAccNOFT = [[infoDic objectForKey:@"FTPCreditCardInfo"]objectForKey:@"CardMemberAccountNo"];
        creditCardBankFT = [[infoDic objectForKey:@"FTPCreditCardInfo"]objectForKey:@"CreditCardBank"];
        cardExpiredDateFT = [[infoDic objectForKey:@"FTPCreditCardInfo"]objectForKey:@"CardExpiredDate"];
        cardMemberNameFT = [[infoDic objectForKey:@"FTPCreditCardInfo"]objectForKey:@"CardMemberName"];
        totalModalPremiumFT = [[infoDic objectForKey:@"FTPCreditCardInfo"]objectForKey:@"TotalModalPremium"];
        cardMemberNewICNoFT = [[infoDic objectForKey:@"FTPCreditCardInfo"]objectForKey:@"CardMemberNewICNo"];
        cardMemberRelationshipFT = [[infoDic objectForKey:@"FTPCreditCardInfo"]objectForKey:@"CardMemberRelationship"];
        
        cardMemberAccNORC = [[infoDic objectForKey:@"CreditCardInfo"]objectForKey:@"CardMemberAccountNo"];
        creditCardBankRC = [[infoDic objectForKey:@"CreditCardInfo"]objectForKey:@"CreditCardBank"];
        cardExpiredDateRC = [[infoDic objectForKey:@"CreditCardInfo"]objectForKey:@"CardExpiredDate"];
        cardMemberNameRC = [[infoDic objectForKey:@"CreditCardInfo"]objectForKey:@"CardMemberName"];
        totalModalPremiumRC = [[infoDic objectForKey:@"CreditCardInfo"]objectForKey:@"TotalModalPremium"];
        cardMemberNewICNoRC = [[infoDic objectForKey:@"CreditCardInfo"]objectForKey:@"CardMemberNewICNo"];
        cardMemberRelationshipRC = [[infoDic objectForKey:@"CreditCardInfo"]objectForKey:@"CardMemberRelationship"];
        
        clientChoice = [[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"ClientChoice"];
        clientAck = [[infoDic objectForKey:@"eCFFInfo"]objectForKey:@"ClientAck"];
        
        //        cOName = [NSString stringWithFormat:@"%@ %@",[[infoDic objectForKey:@"ContigentInfo"]objectForKey:@"COTitle"],[[infoDic objectForKey:@"ContigentInfo"]objectForKey:@"COName"]];
		cOName = [NSString stringWithFormat:@"%@",[[infoDic objectForKey:@"ContigentInfo"]objectForKey:@"COName"]];
        cOICNo = [[[infoDic objectForKey:@"ContigentInfo"]objectForKey:@"CONewIC"]objectForKey:@"CONewICNo"];
        cOICType = [[[infoDic objectForKey:@"ContigentInfo"]objectForKey:@"CONewIC"]objectForKey:@"CONewICCode"];
        if (![cOICNo length]) {
            cOICNo = [[[infoDic objectForKey:@"ContigentInfo"]objectForKey:@"COOtherID"]objectForKey:@"COOtherID"];
            cOICType = @"Other";
            
            
            
            
        }
        
        [self getRequiredSnapList];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid XML File/Format." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
    
}

-(void)getRequiredSnapList
{
    _requiredArr = [[NSMutableArray alloc]init];
    
    NSLog(@"requiredArr %@",_requiredArr);
    if ([lAName length]&& ![lAOtherIDType isEqualToString:@"EDD"])
    {
        [_requiredArr addObject:kfirstLA];
    }
    
    if ([policyOwnerNamel rangeOfString:lAName].location == NSNotFound)
    {
        if ([policyOwnerNamel length])
        {
            [_requiredArr addObject:kpolicyOwner];
        }
    }
    else
    {
        NSLog(@"string contains bla!");
    }
    
    
    if ([cOICNo length])
    {
        [_requiredArr addObject:kcontigentOwner];
    }
    
    NSLog(@"trustee count %@",trusteeCount);
    if ([trusteeCount intValue] ==1)
    {
        [_requiredArr addObject:kfirstTrustee];
        NSLog(@"trusteeInfo %lu",(unsigned long)trusteeName.length);
    }
    if ([trusteeCount intValue] ==2) {
        [_requiredArr addObject:kfirstTrustee];
        [_requiredArr addObject:ksecondTrustee];
    }
    if ([gardianName length]) {
        [_requiredArr addObject:kgardian];
    }
    //    if ([intermediaryName length]) {
    //        [_requiredArr addObject:kintermediary];
    //    }
    //    if ([intermediaryManagerName length]) {
    ////        if ([self dateDiff:intermediaryContractDate]<1) {
    ////            [_requiredArr addObject:kmanager];
    ////        }
    //    }
    if ([cardMemberNameFT length]) {
        [_requiredArr addObject:kcreditCardFT];
    }
    
    if ([cardMemberNameRC length]) {
        [_requiredArr addObject:kcreditCardRecc];
    }
}


-(int)dateDiff:(NSString *)fromDate
{
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:fromDate]];
    int allDays = (((time/60)/60)/24);
    int days = allDays%365;
    int years = (allDays-days)/365;
    return years;
}
#pragma mark - IBACTIONS
- (IBAction)idTypePressed:(UIButton *)sender
{
    IDTypePicker *vc = [[IDTypePicker alloc]init];
    vc.delegate = self;
    [vc initWithArray:_idTypes];
    
    _ChangesMadeOrString =@"Selection";
    
    _popOver = [[UIPopoverController alloc]initWithContentViewController:vc];
    _popOver.popoverContentSize = vc.view.frame.size;
    [_popOver presentPopoverFromRect:sender.frame inView:_snapView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}
-(IBAction)frontSnapPressed:(UIButton *)sender
{
    snapMode = kFrontSnap;
    NSMutableDictionary *dic = [[_snapArr objectAtIndex:selectedRow]mutableCopy];
    if ([[dic objectForKey:@"idType"]hasPrefix:@"Select"]||[[dic objectForKey:@"idType"]hasPrefix:@"-Select-"])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please select the Identification Type" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        [self takeCameraSnap];
    }
}

- (BOOL)shouldAutorotate
{
    return NO;
}

-(IBAction)backSnapPressed:(UIButton *)sender
{
    snapMode = kBackSnap;
    NSMutableDictionary *dic = [[_snapArr objectAtIndex:selectedRow]mutableCopy];
    if ([[dic objectForKey:@"idType"]hasPrefix:@"Select"]||[[dic objectForKey:@"idType"]hasPrefix:@"-Select-"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please select the Identification Type" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        [self takeCameraSnap];
    }
    
}

- (IBAction)backPressed:(id)sender
{
    NSLog(@"testing");
    
    NSLog(@"check the bool %@",_ChangesMadeOrString);
    backPressed = YES;
    
    if(NeedToSave)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"Do you want to save"
                                                       delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        [alert show];
        alert.tag=12345;
        alert = Nil;
    }
    else
    {
        [self.view removeFromSuperview];
    }
    
    
    
}


- (IBAction)SaveStandalone:(id)sender
{
    snapMode = kFrontSnap;
    NSMutableDictionary *dic = [[_snapArr objectAtIndex:selectedRow]mutableCopy];
    if ([[dic objectForKey:@"idType"]hasPrefix:@"Select"]||[[dic objectForKey:@"idType"]hasPrefix:@"-Select-"])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please select the Identification Type" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        [self saveButtonClicked];
    }
}
-(void)saveButtonClicked
{
    
	if (checkIndex) {
		selectedRow = prevIndex;
		rowIndex = prevIndex;
		NSLog(@"selectedRow %ld",selectedRow);
	}
    NSLog(@"selectedPicker %@",SelectedIndentity);
    
    NSLog(@"selectedRow %ld",selectedRow);
    
    NSString *nopolicy;
    
    if ([policyOwnerNamel rangeOfString:lAName].location == NSNotFound)
    {
        nopolicy =@"NoPolicy";
    }
    
    else
    {
        nopolicy =@"Policy";
    }
    
    
    
    
    
    
    NSDictionary *dic = [_snapArr objectAtIndex:rowIndex];
    NSString *previousSelectedItem = [dic objectForKey:@"rowTitlw"];
    BOOL onlyFrontREquired = NO;
	
	if ([[dic objectForKey:@"idType"] isEqualToString:@"New IC"]||[[dic objectForKey:@"idType"] isEqualToString:@"Old Identification"]||[[dic objectForKey:@"idType"] isEqualToString:@"Permanent Resident"]||[[dic objectForKey:@"idType"] isEqualToString:@"Army Identification Number"]||[[dic objectForKey:@"idType"] isEqualToString:@"Police Identification Number"]||[[dic objectForKey:@"idType"] isEqualToString:@"Credit Card"]||[[dic objectForKey:@"idType"] isEqualToString:@"Select Identification Type"]||[[dic objectForKey:@"idType"] isEqualToString:@"-Select-"])
	{
		_backImageView.hidden = NO;
		_backBut.hidden = NO;
		_backLabel.hidden = NO;
	}
	else {
		
		_backImageView.hidden = YES;
		_backBut.hidden = YES;
		_backLabel.hidden = YES;
	}
	
    if ([[dic objectForKey:@"idType"] isEqualToString:@"Birth Certificate"]||[[dic objectForKey:@"idType"] isEqualToString:@"Foreign Birth Certificate"]||[[dic objectForKey:@"idType"] isEqualToString:@"Foreigner Identification Number"]||[[dic objectForKey:@"idType"] isEqualToString:@"Passport"]||[[dic objectForKey:@"idType"] isEqualToString:@"Singapore Identification Number"])
    {
        onlyFrontREquired = YES;
    }
    NSString *msgErr = @"";
    
    if ((![[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]])&&(![[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]]))
    {
        
    }
    
    else
    {
        if (!onlyFrontREquired)
        {
            if (![[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]])
            {
                msgErr = [msgErr stringByAppendingString:@"\n -back page"];
            }
        }
        
        if (![[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]])
        {
            msgErr = [msgErr stringByAppendingString:@"\n -front page"];
        }
        
        if ([msgErr length])
        {
            
            
            // [tableView deselectRowAtIndexPath:indexPath animated:YES];
            // [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:0];
            //                [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
            //                                        animated:NO
            //                                  scrollPosition:UITableViewScrollPositionTop];
            
            //                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"The following snapshot(s) for %@ required: %@ ",previousSelectedItem,msgErr] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Front/Back page of identification document is required for %@",previousSelectedItem] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            
            
            [alert show];
            alert =Nil;
            
        }
        
        else
        {
            
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            for (int i = 0; i<_requiredArr.count;i++ )
            {
                NSDictionary *dic = [_snapArr objectAtIndex:[_requiredArr [i]intValue]];
                
                
                
                if ([[dic objectForKey:@"idType"]isEqualToString:@"Other"]) {
                    if (![[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]]) {
                        [arr addObject:[NSString stringWithFormat:@"Front page of identification document is required for %@",[dic objectForKey:@"rowTitlw"]]];
                    }
                }
                else
                {
                    if ([[dic objectForKey:@"idType"] isEqualToString:@"Birth Certificate"]||[[dic objectForKey:@"idType"] isEqualToString:@"Foreign Birth Certificate"]||[[dic objectForKey:@"idType"] isEqualToString:@"Foreigner Identification Number"]||[[dic objectForKey:@"idType"] isEqualToString:@"Passport"]||[[dic objectForKey:@"idType"] isEqualToString:@"Singapore Identification Number"])
                    {
                        //                           _backImageView.hidden = YES;
                        //                           _backBut.hidden = YES;
                        //                           _backLabel.hidden = YES;
                        
                        if (![[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]])
                        {
                            NSLog(@" front");
                            [arr addObject:[NSString stringWithFormat:@"Front page of identification document is required for %@",[dic objectForKey:@"rowTitlw"]]];
                        }
                        
                        
                        if ([policyOwnerNamel rangeOfString:lAName].location == NSNotFound)
                        {
                            if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Life Assured"]) {
                                [dic setValue:lAName forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Policy Owner"]) {
                                [dic setValue:policyOwnerNamel forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Contingent Owner"]) {
                                [dic setValue:cOName forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Trustee"]) {
                                [dic setValue:trusteeName forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"2nd Trustee"]) {
                                [dic setValue:trusteeName2 forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Father/ Mother/ Guardian"]) {
                                [dic setValue:gardianName forKey:@"name"];
                                
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(First Time Payment)"]) {
                                [dic setValue:cardMemberNameFT forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(Recurring Payment)"]) {
                                [dic setValue:cardMemberNameRC forKey:@"name"];
                            }
                        }
                        else
                        {
                            NSLog(@"string contains bla!");
                            if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Life Assured"]) {
                                [dic setValue:lAName forKey:@"name"];
                                [dic setValue:policyOwnerNamel forKey:@"name"];
                            }
                            //                    else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Policy Owner"]) {
                            //                        [dic setValue:policyOwnerNamel forKey:@"name"];
                            //                    }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Contingent Owner"]) {
                                [dic setValue:cOName forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Trustee"]) {
                                [dic setValue:trusteeName forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"2nd Trustee"]) {
                                [dic setValue:trusteeName2 forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Father/ Mother/ Guardian"]) {
                                [dic setValue:gardianName forKey:@"name"];
                            }
                            
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(First Time Payment)"]) {
                                [dic setValue:cardMemberNameFT forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(Recurring Payment)"]) {
                                [dic setValue:cardMemberNameRC forKey:@"name"];
                            }
                        }
                        
                        
                        
                        
                    }
                    
                    else
                    {
						
                        
                        NSLog(@"_snap %@",[dic objectForKey:@"name"]);
                        
                        if ([[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]] && [[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]])
                        {
                            
                            if ([policyOwnerNamel rangeOfString:lAName].location == NSNotFound)
                            {
                                if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Life Assured"]) {
                                    [dic setValue:lAName forKey:@"name"];
                                }
                                else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Policy Owner"]) {
                                    [dic setValue:policyOwnerNamel forKey:@"name"];
                                }
                                else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Contingent Owner"]) {
                                    [dic setValue:cOName forKey:@"name"];
                                }
                                else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Trustee"]) {
                                    [dic setValue:trusteeName forKey:@"name"];
                                }
                                else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"2nd Trustee"]) {
                                    [dic setValue:trusteeName2 forKey:@"name"];
                                }
                                else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Father/ Mother/ Guardian"]) {
                                    [dic setValue:gardianName forKey:@"name"];
                                }
                                else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(First Time Payment)"]) {
                                    [dic setValue:cardMemberNameFT forKey:@"name"];
                                }
                                else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(Recurring Payment)"]) {
                                    [dic setValue:cardMemberNameRC forKey:@"name"];
                                }
                            }
                            
                            else
                            {
                                if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Life Assured"]) {
                                    [dic setValue:lAName forKey:@"name"];
                                    [dic setValue:policyOwnerNamel forKey:@"name"];
                                }
                                //                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Policy Owner"]) {
                                //                            [dic setValue:policyOwnerNamel forKey:@"name"];
                                //                        }
                                else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Contingent Owner"]) {
                                    [dic setValue:cOName forKey:@"name"];
                                }
                                else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Trustee"]) {
                                    [dic setValue:trusteeName forKey:@"name"];
                                }
                                else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"2nd Trustee"]) {
                                    [dic setValue:trusteeName2 forKey:@"name"];
                                }
                                else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Father/ Mother/ Guardian"]) {
                                    [dic setValue:gardianName forKey:@"name"];
                                }
                                else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(First Time Payment)"]) {
                                    [dic setValue:cardMemberNameFT forKey:@"name"];
                                }
                                else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(Recurring Payment)"]) {
                                    [dic setValue:cardMemberNameRC forKey:@"name"];
                                }
                            }
                            
                            
                            
                        }
                        
                        
                        
                    }
                    
                    
                }
                
                // NSDictionary *dic = [_snapArr objectAtIndex:[_requiredArr [i]intValue]];
                //put name into array
                
                buttonSnapView.enabled=YES;
                //                    _CheckView.hidden =NO;
                //                   _CheckView1.hidden =NO;
                
            }
            if ([arr count]) {
                NSString *msg = @"The Following(s) is/are Required: \n ";
                msg = [msg stringByAppendingString:[arr componentsJoinedByString:@" \n "]];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                
            }
            else
            {
                //Successfull!!!
                appobject=(AppDelegate *)[[UIApplication sharedApplication]delegate];
                
                /// appObj.checkList=YES;
                
                
                
                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ComparePhoto"])
                {
                    NSMutableArray *array=[[[NSUserDefaults standardUserDefaults] objectForKey:@"ComparePhoto"] mutableCopy];
                    if (![array containsObject:appobject.eappProposal])
                    {
                        [array addObject:appobject.eappProposal];
                    }
                    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"ComparePhoto"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                else{
                    NSMutableArray *array=[[NSMutableArray alloc] init];
                    [array addObject:appobject.eappProposal];
                    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"ComparePhoto"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                //                   [delegate refreshCardsanpdata];
                SnapGen *snapGen = [[SnapGen alloc]init];
                
                //  NSLog(@"Path = %@",[snapGen generatePdfFromSnapArray:_snapArr withFileName:proposalNumber]);
                
                NSLog(@"Path = %@",[snapGen generatePdfFromSnapArray:_snapArr withFileName:proposalNumber :nopolicy]);
                [delegate refreshCardsanpdata];
                
                [self SaveUpdate];
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Identification Document has been created successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                alert.tag =1001;
                [alert show];
                
                alert=nil;
                
                [_tableView reloadData];
                
                
                
            }
			
        }
        
    }
    
    
}
-(void)SaveUpdate {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString *documentsDirectory = [paths objectAtIndex :0];
    
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
	
	NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
	NSDate *currDate = [NSDate date];
	[dateFormatter2 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
	NSString *dateString = [dateFormatter2 stringFromDate:currDate];
	
	NSString *queryB = @"";
	queryB = [NSString stringWithFormat:@"UPDATE eApp_Listing SET DateUpdated = '%@' WHERE ProposalNo = '%@'", dateString, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
	[db executeUpdate:queryB];
	
}

-(void)testing
{
    
    NSLog(@"selectedPicker %@",SelectedIndentity);
    
    NSString *nopolicy;
    
    if ([policyOwnerNamel rangeOfString:lAName].location == NSNotFound)
    {
        nopolicy =@"NoPolicy";
    }
    
    else
    {
        nopolicy =@"Policy";
    }
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0; i<_requiredArr.count;i++ )
    {
        NSDictionary *dic = [_snapArr objectAtIndex:[_requiredArr [i]intValue]];
        
        
        
        if ([[dic objectForKey:@"idType"]isEqualToString:@"Other"]) {
            if (![[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]]) {
                [arr addObject:[NSString stringWithFormat:@"Front page of identification document is required for %@",[dic objectForKey:@"rowTitlw"]]];
            }
        }
        else
        {
            if ([[dic objectForKey:@"idType"] isEqualToString:@"Birth Certificate"]||[[dic objectForKey:@"idType"] isEqualToString:@"Foreign Birth Certificate"]||[[dic objectForKey:@"idType"] isEqualToString:@"Foreigner Identification Number"]||[[dic objectForKey:@"idType"] isEqualToString:@"Passport"]||[[dic objectForKey:@"idType"] isEqualToString:@"Singapore Identification Number"])
            {
                _backImageView.hidden = YES;
                _backBut.hidden = YES;
                _backLabel.hidden = YES;
                
                if (![[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]])
                {
                    NSLog(@" front");
                    [arr addObject:[NSString stringWithFormat:@"Front page of identification document is required for %@",[dic objectForKey:@"rowTitlw"]]];
                }
                
                //                if (![[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]] && [[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]])
                //                {
                //                    NSLog(@"front");
                //                    [arr addObject:[NSString stringWithFormat:@"* Front Page of %@",[dic objectForKey:@"rowTitlw"]]];
                //                }
                //
                //
                //                if ([[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]] && ![[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]])
                //                {
                //                    NSLog(@"back ");
                //                    [arr addObject:[NSString stringWithFormat:@"* Back Page of %@",[dic objectForKey:@"rowTitlw"]]];
                //                }
                
                if ([policyOwnerNamel rangeOfString:lAName].location == NSNotFound)
                {
                    if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Life Assured"]) {
                        [dic setValue:lAName forKey:@"name"];
                    }
                    else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Policy Owner"]) {
                        [dic setValue:policyOwnerNamel forKey:@"name"];
                    }
                    else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Contingent Owner"]) {
                        [dic setValue:cOName forKey:@"name"];
                    }
                    else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Trustee"]) {
                        [dic setValue:trusteeName forKey:@"name"];
                    }
                    else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"2nd Trustee"]) {
                        [dic setValue:trusteeName2 forKey:@"name"];
                    }
                    else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Father/ Mother/ Guardian"]) {
                        [dic setValue:gardianName forKey:@"name"];
                        
                    }
                    else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(First Time Payment)"]) {
                        [dic setValue:cardMemberNameFT forKey:@"name"];
                    }
                    else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(Recurring Payment)"]) {
                        [dic setValue:cardMemberNameRC forKey:@"name"];
                    }
                }
                else
                {
                    NSLog(@"string contains bla!");
                    if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Life Assured"]) {
                        [dic setValue:lAName forKey:@"name"];
                        [dic setValue:policyOwnerNamel forKey:@"name"];
                    }
                    //                    else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Policy Owner"]) {
                    //                        [dic setValue:policyOwnerNamel forKey:@"name"];
                    //                    }
                    else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Contingent Owner"]) {
                        [dic setValue:cOName forKey:@"name"];
                    }
                    else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Trustee"]) {
                        [dic setValue:trusteeName forKey:@"name"];
                    }
                    else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"2nd Trustee"]) {
                        [dic setValue:trusteeName2 forKey:@"name"];
                    }
                    else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Father/ Mother/ Guardian"]) {
                        [dic setValue:gardianName forKey:@"name"];
                    }
                    
                    else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(First Time Payment)"]) {
                        [dic setValue:cardMemberNameFT forKey:@"name"];
                    }
                    else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(Recurring Payment)"]) {
                        [dic setValue:cardMemberNameRC forKey:@"name"];
                    }
                }
                
                
                
                
            }
            
            else
            {
                
                
                
                //                if (![[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]])
                //                {
                //                    NSLog(@"front");
                //                    [arr addObject:[NSString stringWithFormat:@"* Front  Page of %@",[dic objectForKey:@"rowTitlw"]]];
                //                }
                //                else if
                //                (![[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]])
                //                {
                //                    NSLog(@"back");
                //                    [arr addObject:[NSString stringWithFormat:@"* Back Page of %@",[dic objectForKey:@"rowTitlw"]]];
                //                }
                //                if (![[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]] || ![[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]])
                //                {
                //                    NSLog(@"back & front");
                //                    [arr addObject:[NSString stringWithFormat:@"* Front & Back Page of %@",[dic objectForKey:@"rowTitlw"]]];
                //                }
                
                NSLog(@"_snap %@",[dic objectForKey:@"name"]);
                
                //                if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Life Assured"])&&[self.snapArr objectForKey:@"name"]
                //                {
                //                    <#statements#>
                //                }
                
                //
                //                    if (![[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]] && ![[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]])
                //                    {
                //                        NSLog(@"back & front");
                //                        [arr addObject:[NSString stringWithFormat:@"Front/Back page of identification document is required for %@",[dic objectForKey:@"rowTitlw"]]];
                //                    }
                //
                //                    if (![[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]] && [[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]])
                //                    {
                //                        NSLog(@"front");
                //                        [arr addObject:[NSString stringWithFormat:@"Front page of identification document is required for of %@",[dic objectForKey:@"rowTitlw"]]];
                //                    }
                //
                //
                //                    if ([[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]] && ![[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]])
                //                    {
                //                        NSLog(@"back ");
                //                        [arr addObject:[NSString stringWithFormat:@"Back page of identification document is required for %@",[dic objectForKey:@"rowTitlw"]]];
                //                    }
                
                
                if ([[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]] && [[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]])
                {
                    
                    if ([policyOwnerNamel rangeOfString:lAName].location == NSNotFound)
                    {
                        if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Life Assured"]) {
                            [dic setValue:lAName forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Policy Owner"]) {
                            [dic setValue:policyOwnerNamel forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Contingent Owner"]) {
                            [dic setValue:cOName forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Trustee"]) {
                            [dic setValue:trusteeName forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"2nd Trustee"]) {
                            [dic setValue:trusteeName2 forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Father/ Mother/ Guardian"]) {
                            [dic setValue:gardianName forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(First Time Payment)"]) {
                            [dic setValue:cardMemberNameFT forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(Recurring Payment)"]) {
                            [dic setValue:cardMemberNameRC forKey:@"name"];
                        }
                    }
                    
                    else
                    {
                        if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Life Assured"]) {
                            [dic setValue:lAName forKey:@"name"];
                            [dic setValue:policyOwnerNamel forKey:@"name"];
                        }
                        //                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Policy Owner"]) {
                        //                            [dic setValue:policyOwnerNamel forKey:@"name"];
                        //                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Contingent Owner"]) {
                            [dic setValue:cOName forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Trustee"]) {
                            [dic setValue:trusteeName forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"2nd Trustee"]) {
                            [dic setValue:trusteeName2 forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Father/ Mother/ Guardian"]) {
                            [dic setValue:gardianName forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(First Time Payment)"]) {
                            [dic setValue:cardMemberNameFT forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(Recurring Payment)"]) {
                            [dic setValue:cardMemberNameRC forKey:@"name"];
                        }
                    }
                    
                    
                    
                }
                
                
                
            }
            
            
        }
        
        // NSDictionary *dic = [_snapArr objectAtIndex:[_requiredArr [i]intValue]];
        //put name into array
        
        
        
    }
    if ([arr count]) {
        NSString *msg = @"The Following(s) is/are Required: \n ";
        msg = [msg stringByAppendingString:[arr componentsJoinedByString:@" \n "]];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
    }
    else
    {
        //Successfull!!!
        appobject=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        /// appObj.checkList=YES;
        
        
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ComparePhoto"])
        {
            NSMutableArray *array=[[[NSUserDefaults standardUserDefaults] objectForKey:@"ComparePhoto"] mutableCopy];
            if (![array containsObject:appobject.eappProposal])
            {
                [array addObject:appobject.eappProposal];
            }
            [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"ComparePhoto"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else{
            NSMutableArray *array=[[NSMutableArray alloc] init];
            [array addObject:appobject.eappProposal];
            [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"ComparePhoto"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        //        [delegate refreshCardsanpdata];
        SnapGen *snapGen = [[SnapGen alloc]init];
        
        //  NSLog(@"Path = %@",[snapGen generatePdfFromSnapArray:_snapArr withFileName:proposalNumber]);
        
        NSLog(@"Path = %@",[snapGen generatePdfFromSnapArray:_snapArr withFileName:proposalNumber :nopolicy]);
        [delegate refreshCardsanpdata];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Identification Document has been created successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        //alert.tag =101;
        [alert show];
        
        alert=nil;
        
        checkIndex = NO;
        
    }
    
    
    
    
    
    
}

- (IBAction)donePressed:(id)sender
{
    
    if([_ChangesMadeOrString isEqualToString:@"Selection"])
    {
        NSLog(@"selectedPicker %@",SelectedIndentity);
        
        NSString *nopolicy;
        
        if ([policyOwnerNamel rangeOfString:lAName].location == NSNotFound)
        {
            nopolicy =@"NoPolicy";
        }
        
        else
        {
            nopolicy =@"Policy";
        }
        
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        for (int i = 0; i<_requiredArr.count;i++ )
        {
            NSDictionary *dic = [_snapArr objectAtIndex:[_requiredArr [i]intValue]];
            
            
            
            if ([[dic objectForKey:@"idType"]isEqualToString:@"Other"]) {
                if (![[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]]) {
                    [arr addObject:[NSString stringWithFormat:@"Front page of identification document is required for %@",[dic objectForKey:@"rowTitlw"]]];
                }
            }
            else
            {
                if ([[dic objectForKey:@"idType"] isEqualToString:@"Birth Certificate"]||[[dic objectForKey:@"idType"] isEqualToString:@"Foreign Birth Certificate"]||[[dic objectForKey:@"idType"] isEqualToString:@"Foreigner Identification Number"]||[[dic objectForKey:@"idType"] isEqualToString:@"Passport"]||[[dic objectForKey:@"idType"] isEqualToString:@"Singapore Identification Number"])
                {
                    _backImageView.hidden = YES;
                    _backBut.hidden = YES;
                    _backLabel.hidden = YES;
                    
                    if (![[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]])
                    {
                        NSLog(@" front");
                        [arr addObject:[NSString stringWithFormat:@"Front page of identification document is required for %@",[dic objectForKey:@"rowTitlw"]]];
                    }
                    
                    //                if (![[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]] && [[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]])
                    //                {
                    //                    NSLog(@"front");
                    //                    [arr addObject:[NSString stringWithFormat:@"* Front Page of %@",[dic objectForKey:@"rowTitlw"]]];
                    //                }
                    //
                    //
                    //                if ([[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]] && ![[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]])
                    //                {
                    //                    NSLog(@"back ");
                    //                    [arr addObject:[NSString stringWithFormat:@"* Back Page of %@",[dic objectForKey:@"rowTitlw"]]];
                    //                }
                    
                    if ([policyOwnerNamel rangeOfString:lAName].location == NSNotFound)
                    {
                        if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Life Assured"]) {
                            [dic setValue:lAName forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Policy Owner"]) {
                            [dic setValue:policyOwnerNamel forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Contingent Owner"]) {
                            [dic setValue:cOName forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Trustee"]) {
                            [dic setValue:trusteeName forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"2nd Trustee"]) {
                            [dic setValue:trusteeName2 forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Father/ Mother/ Guardian"]) {
                            [dic setValue:gardianName forKey:@"name"];
                            
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(First Time Payment)"]) {
                            [dic setValue:cardMemberNameFT forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(Recurring Payment)"]) {
                            [dic setValue:cardMemberNameRC forKey:@"name"];
                        }
                    }
                    else
                    {
                        NSLog(@"string contains bla!");
                        if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Life Assured"]) {
                            [dic setValue:lAName forKey:@"name"];
                            [dic setValue:policyOwnerNamel forKey:@"name"];
                        }
                        //                    else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Policy Owner"]) {
                        //                        [dic setValue:policyOwnerNamel forKey:@"name"];
                        //                    }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Contingent Owner"]) {
                            [dic setValue:cOName forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Trustee"]) {
                            [dic setValue:trusteeName forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"2nd Trustee"]) {
                            [dic setValue:trusteeName2 forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Father/ Mother/ Guardian"]) {
                            [dic setValue:gardianName forKey:@"name"];
                        }
                        
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(First Time Payment)"]) {
                            [dic setValue:cardMemberNameFT forKey:@"name"];
                        }
                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(Recurring Payment)"]) {
                            [dic setValue:cardMemberNameRC forKey:@"name"];
                        }
                    }
                    
                    
                    
                    
                }
                
                else
                {
                    
                    
                    
                    //                if (![[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]])
                    //                {
                    //                    NSLog(@"front");
                    //                    [arr addObject:[NSString stringWithFormat:@"* Front  Page of %@",[dic objectForKey:@"rowTitlw"]]];
                    //                }
                    //                else if
                    //                (![[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]])
                    //                {
                    //                    NSLog(@"back");
                    //                    [arr addObject:[NSString stringWithFormat:@"* Back Page of %@",[dic objectForKey:@"rowTitlw"]]];
                    //                }
                    //                if (![[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]] || ![[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]])
                    //                {
                    //                    NSLog(@"back & front");
                    //                    [arr addObject:[NSString stringWithFormat:@"* Front & Back Page of %@",[dic objectForKey:@"rowTitlw"]]];
                    //                }
                    
                    NSLog(@"_snap %@",[dic objectForKey:@"name"]);
                    
                    //                if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Life Assured"])&&[self.snapArr objectForKey:@"name"]
                    //                {
                    //                    <#statements#>
                    //                }
                    
                    
                    if (![[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]] && ![[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]])
                    {
                        NSLog(@"back & front");
                        [arr addObject:[NSString stringWithFormat:@"Front/Back page of identification document is required for %@",[dic objectForKey:@"rowTitlw"]]];
                    }
                    
                    if (![[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]] && [[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]])
                    {
                        NSLog(@"front");
                        [arr addObject:[NSString stringWithFormat:@"Front page of identification document is required for of %@",[dic objectForKey:@"rowTitlw"]]];
                    }
                    
                    
                    if ([[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]] && ![[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]])
                    {
                        NSLog(@"back ");
                        [arr addObject:[NSString stringWithFormat:@"Back page of identification document is required for %@",[dic objectForKey:@"rowTitlw"]]];
                    }
                    
                    
                    if ([[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]] && [[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]])
                    {
                        
                        if ([policyOwnerNamel rangeOfString:lAName].location == NSNotFound)
                        {
                            if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Life Assured"]) {
                                [dic setValue:lAName forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Policy Owner"]) {
                                [dic setValue:policyOwnerNamel forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Contingent Owner"]) {
                                [dic setValue:cOName forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Trustee"]) {
                                [dic setValue:trusteeName forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"2nd Trustee"]) {
                                [dic setValue:trusteeName2 forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Father/ Mother/ Guardian"]) {
                                [dic setValue:gardianName forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(First Time Payment)"]) {
                                [dic setValue:cardMemberNameFT forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(Recurring Payment)"]) {
                                [dic setValue:cardMemberNameRC forKey:@"name"];
                            }
                        }
                        
                        else
                        {
                            if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Life Assured"]) {
                                [dic setValue:lAName forKey:@"name"];
                                [dic setValue:policyOwnerNamel forKey:@"name"];
                            }
                            //                        else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Policy Owner"]) {
                            //                            [dic setValue:policyOwnerNamel forKey:@"name"];
                            //                        }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Contingent Owner"]) {
                                [dic setValue:cOName forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Trustee"]) {
                                [dic setValue:trusteeName forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"2nd Trustee"]) {
                                [dic setValue:trusteeName2 forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Father/ Mother/ Guardian"]) {
                                [dic setValue:gardianName forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(First Time Payment)"]) {
                                [dic setValue:cardMemberNameFT forKey:@"name"];
                            }
                            else if ([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(Recurring Payment)"]) {
                                [dic setValue:cardMemberNameRC forKey:@"name"];
                            }
                        }
                        
                        
                        
                    }
                    
                    
                    
                }
                
                
            }
            
            // NSDictionary *dic = [_snapArr objectAtIndex:[_requiredArr [i]intValue]];
            //put name into array
            
            
            
        }
        if ([arr count]) {
            NSString *msg = @"The Following(s) is/are Required: \n ";
            msg = [msg stringByAppendingString:[arr componentsJoinedByString:@" \n "]];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
        }
        else
        {
            //Successfull!!!
            appobject=(AppDelegate *)[[UIApplication sharedApplication]delegate];
            
            /// appObj.checkList=YES;
            
            
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ComparePhoto"])
            {
                NSMutableArray *array=[[[NSUserDefaults standardUserDefaults] objectForKey:@"ComparePhoto"] mutableCopy];
                if (![array containsObject:appobject.eappProposal])
                {
                    [array addObject:appobject.eappProposal];
                }
                [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"ComparePhoto"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            else{
                NSMutableArray *array=[[NSMutableArray alloc] init];
                [array addObject:appobject.eappProposal];
                [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"ComparePhoto"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            //            [delegate refreshCardsanpdata];
            SnapGen *snapGen = [[SnapGen alloc]init];
            
            
            //  NSLog(@"Path = %@",[snapGen generatePdfFromSnapArray:_snapArr withFileName:proposalNumber]);
            
            NSLog(@"Path = %@",[snapGen generatePdfFromSnapArray:_snapArr withFileName:proposalNumber :nopolicy]);
            [delegate refreshCardsanpdata];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Identification Document has been created successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            alert.tag =101;
            [alert show];
            
            alert=nil;
            
            
            
        }
        
        
        
    }
    
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Please note that identification document is required for Policy Owner and Life Assured in order to proceed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        // alert.tag =101;
        [alert show];
        
        alert=nil;
    }
    
    
}

//-(void)alertViewCancel
//{
//
//
//
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:@"Do you want to save changes?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
//
//    NSLog(@"here1");
//    [alert setTag:1234];
//    [alert show];
//
//    alert=nil;
//
//
//    NSTimer *mytimer;
//
//}

//-(void)removeView
//{
//  [self.view removeFromSuperview];
//}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 101 && buttonIndex == 0)
    {
        [self.view removeFromSuperview];
        
    }
	if (alertView.tag == 12345 && buttonIndex == 0)
    {
        [self SaveStandalone:nil];
		
        
    }
	if (alertView.tag == 12345 && buttonIndex == 1)
    {
		NeedToSave = NO;
        [self.view removeFromSuperview];
		backPressed = NO;
    }
	if (alertView.tag == 1001)
    {
		if (backPressed) {
			NeedToSave = NO;
			[self.view removeFromSuperview];
		}
	}
	if (alertView.tag == 10000 && buttonIndex == 0)
    {
		checkIndex = YES;
        [self SaveStandalone:nil];
		
        
    }
	if (alertView.tag == 10000 && buttonIndex == 1)
    {
		//Remove image if user select NO... ##need to review again later
		
        //		NSMutableDictionary *dic = [[_snapArr objectAtIndex:selectedRow]mutableCopy];
        //
        //		[_snapArr removeObjectAtIndex:selectedRow];
        //		[_snapArr insertObject:dic atIndex:selectedRow];
        //
        //		[dic setObject:@"" forKey:@"frontSnap"];
        //        [dic setObject:@"" forKey:@"backSnap"];
		
        NeedToSave = NO;
    }
	
    
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSLog(@"interface lock is working");
	if (interfaceOrientation==UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        return YES;
    
    return NO;
}


-(void)takeCameraSnap
{
    
    UIImagePickerControllerSourceType source = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:source]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.sourceType = source;
        
        CGRect rect = imagePickerController.view.frame;
        imagePickerRect = rect;
        CGSize frameSize = CGSizeMake(800,562.5 );
        CGRect frameRect = CGRectMake((rect.size.height-frameSize.width)/2, (rect.size.width-frameSize.height)/2, frameSize.width, frameSize.height);
        UIView *view = [[UIView alloc]initWithFrame:frameRect];
        [view setBackgroundColor:[UIColor clearColor]];
        
        view.layer.borderWidth = 5.0;
        view.layer.borderColor = [UIColor redColor].CGColor;
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 300, 20)];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.text = @"Please snap within the red frame";
        [view addSubview:lbl];
        
		imagePickerController.cameraOverlayView = view;
        
        
        imagePickerController.delegate = self;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Your device has no camera!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
}

//- (UIImage *)crop:(UIImage *)image {
//
//    CGRect originalrect = imagePickerRect;
//    CGSize frameSize = CGSizeMake(700, 500 );
//    CGRect frameRect = CGRectMake((originalrect.size.height-frameSize.width)/2, (originalrect.size.width-frameSize.height)/2, frameSize.width, frameSize.height);
//
//    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, frameRect);
//    UIImage *result = [UIImage imageWithCGImage:imageRef scale:1 orientation:UIImageOrientationUp];
//    CGImageRelease(imageRef);
//    return result;
//}



- (UIImage *)crop:(UIImage *)image {
    
    CGRect originalrect = imagePickerRect;
    CGSize frameSize = CGSizeMake(800,562.50 );
    CGRect frameRect = CGRectMake((originalrect.size.height-frameSize.width)/2, (originalrect.size.width-frameSize.height)/2, frameSize.width, frameSize.height);
    
    //    CGImageRef imageRef = CGImageCreateWithImageInRect([self imageWithImage:image scaledToSize:CGSizeMake(imagePickerRect.size.height, imagePickerRect.size.width)].CGImage, frameRect);
    CGImageRef imageRef = CGImageCreateWithImageInRect([self imageWithImage:image scaledToSize:CGSizeMake(512,360)].CGImage, frameRect);
    UIImage *result = [UIImage imageWithCGImage:imageRef scale:1 orientation:UIImageOrientationUp];
    UIImage *lowResImage = [UIImage imageWithData:UIImageJPEGRepresentation(result, 0.7)];
    CGImageRelease(imageRef);
    return lowResImage;
}

//- (UIImage *)crop:(UIImage *)image {

//    CGRect originalrect = imagePickerRect;
//    CGSize frameSize = CGSizeMake(300, 20 );
//    CGRect frameRect = CGRectMake((originalrect.size.height-frameSize.width)/2, (originalrect.size.width-frameSize.height)/2, frameSize.width, frameSize.height);
//
//    NSLog(@"frameRect %f %f %f %f",frameRect.origin.x,frameRect.origin.y,frameRect.size.width,frameRect.size.height);

//    CGSize frameSize = CGSizeMake(700, 500 );
//    CGRect frameRect = CGRectMake((rect.size.height-frameSize.width)/2, (rect.size.width-frameSize.height)/2, frameSize.width, frameSize.

//    CGImageRef imageRef = CGImageCreateWithImageInRect([self imageWithImage:image scaledToSize:CGSizeMake(500,700)].CGImage, imagePickerRect);
//    UIImage *result = [UIImage imageWithCGImage:imageRef scale:10 orientation:UIImageOrientationUp];
//    UIImage *lowResImage = [UIImage imageWithData:UIImageJPEGRepresentation(result, 0.5)];
//    CGImageRelease(imageRef);
//    return lowResImage;
//
//    NSLog(@"image %@",lowResImage);

//    CGImageRef imageRef = CGImageCreateWithImageInRect([orignialImage CGImage], visibleRect);
//    UIImage *result = [UIImage imageWithCGImage:imageRef scale:orignialImage.scale orientation:orignialImage.imageOrientation];
//    CGImageRelease(imageRef);
//    return result;
//}

-(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
    NSLog(@"newImage %@",newImage);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *originalimage = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *image = [self crop:originalimage];
    NSMutableDictionary *dic = [[_snapArr objectAtIndex:selectedRow]mutableCopy];
    if (snapMode== kFrontSnap) {
        [dic setObject:image forKey:@"frontSnap"];
        [_frontImageView setImage:image];
        _CheckView.hidden =YES;
        _CheckView1.hidden =YES;
    }
    else
    {
        [dic setObject:image forKey:@"backSnap"];
        [_backImageView setImage:image];
    }
    
    [_snapArr removeObjectAtIndex:selectedRow];
    [_snapArr insertObject:dic atIndex:selectedRow];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [_tableView reloadData];
    //    [self performSelector:@selector(reloadData) withObject:nil afterDelay:1];
}

#pragma mark - Card Type Picker View Delegate
-(void)idTypeSelected:(NSString *)idTypeStr
{
    
    [_idTypeBtn setTitle:idTypeStr forState:UIControlStateNormal];
    NSMutableDictionary *dic = [[_snapArr objectAtIndex:selectedRow]mutableCopy];
    [dic setValue:idTypeStr forKey:@"idType"];
    [_snapArr removeObjectAtIndex:selectedRow];
    [_snapArr insertObject:dic atIndex:selectedRow];
    
    
    ChangesMade =YES;
    // _ChangesMadeOrString =@"Yes";
    
    NSLog(@"idYypeStrr %@",_snapArr);
    
    SelectedIndentity = idTypeStr;
    
    if ([idTypeStr isEqualToString:@"Birth Certificate"]||[idTypeStr isEqualToString:@"Foreign Birth Certificate"]||[idTypeStr isEqualToString:@"Foreigner Identification Number"]||[idTypeStr isEqualToString:@"Passport"]||[idTypeStr isEqualToString:@"Singapore Identification Number"])
    {
        _backImageView.hidden = YES;
        _backBut.hidden = YES;
        _backLabel.hidden = YES;
    }
    else if ([idTypeStr isEqualToString:@"New IC"]||[idTypeStr isEqualToString:@"Old Identification"]||[idTypeStr isEqualToString:@"Permanent Resident"]||[idTypeStr isEqualToString:@"Army Identification Number"]||[idTypeStr isEqualToString:@"Police Indetification"]||[idTypeStr isEqualToString:@"Credit Card"])
    {
        _backImageView.hidden = NO;
        _backBut.hidden = NO;
        _backLabel.hidden =NO;
        
    }
    
}

#pragma mark -
#pragma mark - UITABLEVIEW DELEGATE & DATASOURCE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _snapArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    SnapCustomCell *cell = (SnapCustomCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects;
        
        topLevelObjects= [[NSBundle mainBundle] loadNibNamed:@"SnapCustomCell" owner:self options:nil];
        
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        
        cell = [topLevelObjects objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        
    }
    // cell.selectionStyle = UITableViewCellSelectionStyleGray;
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    cell.backgroundColor = [UIColor whiteColor];
    NSDictionary *dic = [_snapArr objectAtIndex:indexPath.row];
    
    BOOL isRequired = NO;
    for (id obj in _requiredArr)
    {
        if ([obj intValue]==indexPath.row)
        {
            isRequired=YES;
            
        }
    }
    if (isRequired) {
        cell.userInteractionEnabled=YES;
        cell.rowTitle.enabled = YES;
        NSLog(@"rowtitle %@",cell.rowTitle.text);
    }
    else
    {
        cell.userInteractionEnabled=NO;
        cell.rowTitle.enabled = NO;
        NSLog(@"rowtitle dis %@",cell.rowTitle.text);
        
    }
    cell.rowTitle.text =[dic objectForKey:@"rowTitlw"];
    
    cell.ticked.hidden = YES;
    
    
    //    _idTypes = [[NSArray alloc]initWithObjects:@"New IC",@"Old Identification",@"Permenent Resident"
    
    
    
    
    if ([[dic objectForKey:@"idType"]isEqualToString:@"Birth Certificate"]||[[dic objectForKey:@"idType"]isEqualToString:@"Foreign Birth Certificate"]||[[dic objectForKey:@"idType"]isEqualToString:@"Foreigner Identification Number"]||[[dic objectForKey:@"idType"]isEqualToString:@"Passport"]||[[dic objectForKey:@"idType"]isEqualToString:@"Singapore Identification Number"])
    {
        if ([[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]] && buttonSnapView.enabled == YES)
        {
            cell.ticked.hidden = NO;
            NSLog(@"SHOW TICKED");
			NeedToSave = NO;
        }
		else if ([[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]] && buttonSnapView.enabled == NO)
        {
            NeedToSave = YES;
			prevIndex = indexPath.row;
        }
        else
        {
            if (rowIndex==indexPath.row) {
                isIncompleted = YES;
            }
            
        }
        
    }
    
    else if([[dic objectForKey:@"idType"]isEqualToString:@"New IC"]||[[dic objectForKey:@"idType"]isEqualToString:@"Old Identification"]||[[dic objectForKey:@"idType"]isEqualToString:@"Permanent Resident"]||[[dic objectForKey:@"idType"]isEqualToString:@"Army Identification Number"]||[[dic objectForKey:@"idType"]isEqualToString:@"Police Identification Number"]||[[dic objectForKey:@"idType"]isEqualToString:@"Credit Card"])
    {
        if ([[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]] && [[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]] && buttonSnapView.enabled == YES)
        {
            cell.ticked.hidden = NO;
            NSLog(@"SHOW TICKED");
			NeedToSave = NO;
        }
		else if ([[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]] && [[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]] && buttonSnapView.enabled == NO)
        {
			NeedToSave = YES;
			prevIndex = indexPath.row;
		}
        else
        {
            if (rowIndex==indexPath.row) {
                isIncompleted = YES;
            }
        }
        
    }
    
    
    // checking if PDF exist, if exsit then ticked. - START
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *FormsPath =  [documentsDirectory stringByAppendingPathComponent:@"Forms"];
    NSMutableArray *dataItems;
    
    
    if([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Life Assured"])
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_LA1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            cell.ticked.hidden = NO;
            
        }
    }
    else if([[dic objectForKey:@"rowTitlw"]isEqualToString:@"2nd Life Assured"])
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_LA2.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            cell.ticked.hidden = NO;
             
        }
    }
    else if([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Policy Owner"])
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_PO.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            cell.ticked.hidden = NO;
            
        }
    }
    else if([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Contingent Owner"])
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CO.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            cell.ticked.hidden = NO;
            
        }
    }
    else if([[dic objectForKey:@"rowTitlw"]isEqualToString:@"1st Trustee"])
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_TR1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            cell.ticked.hidden = NO;
            
        }
    }
    else if([[dic objectForKey:@"rowTitlw"]isEqualToString:@"2nd Trustee"])
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_TR2.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            cell.ticked.hidden = NO;
            
        }
    }
    else if([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Father/ Mother/ Guardian"])
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_GD.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            cell.ticked.hidden = NO;
            
        }
    }
    else if([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(First Time Payment)"])
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CFP.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            cell.ticked.hidden = NO;
            
        }
    }
    else if([[dic objectForKey:@"rowTitlw"]isEqualToString:@"Card Holder \n(Recurring Payment)"])
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CRP.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            cell.ticked.hidden = NO;
            
        }
    }
    // checking if PDF exist, if exsit then ticked. - END
    
    
    [cell setNeedsLayout];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _snapView.hidden = NO;
    [_tableView reloadData];
    selectedRow = indexPath.row;
    
    
    UIStoryboard *newStoryboard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:Nil];
    FormViewController * form = (FormViewController *)[newStoryboard instantiateViewControllerWithIdentifier:@"forms"];
    
    // NSString *title =  [NSString stringWithFormat:@"%@", [dataItems objectAtIndex:indexPath.row] ];
    NSString *title;
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *FormsPath =  [documentsDirectory stringByAppendingPathComponent:@"Forms"];
    NSMutableArray *dataItems;
    
	if (NeedToSave) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"Do you want to save"
                                                       delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        [alert show];
        alert.tag=10000;
        alert = Nil;
		
        
	}
	
    if(indexPath.row ==0)
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_LA1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            buttonSnapView.enabled =YES;
            _CheckView.hidden =NO;
            _CheckView1.hidden =NO;
        }
        else
        {
            buttonSnapView.enabled =NO;
            _CheckView.hidden =YES;
            _CheckView1.hidden =YES;
        }
        
    }
    if(indexPath.row ==1)
    {
        
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_LA2.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            buttonSnapView.enabled =YES;
            _CheckView.hidden =NO;
            _CheckView1.hidden =NO;
        }
        else
        {
            buttonSnapView.enabled =NO;
            _CheckView.hidden =YES;
            _CheckView1.hidden =YES;
        }
        
    }
    if(indexPath.row ==2)
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_PO.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            buttonSnapView.enabled =YES;
            _CheckView.hidden =NO;
            _CheckView1.hidden =NO;
        }
        else
        {
            buttonSnapView.enabled =NO;
            _CheckView.hidden =YES;
            _CheckView1.hidden =YES;
        }
        
        
    }
    if(indexPath.row ==3)
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CO.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            buttonSnapView.enabled =YES;
            _CheckView.hidden =NO;
            _CheckView1.hidden =NO;
        }
        else
        {
            buttonSnapView.enabled =NO;
            _CheckView.hidden =YES;
            _CheckView1.hidden =YES;
        }
        
    }
    if(indexPath.row ==4)
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_TR1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            buttonSnapView.enabled =YES;
            _CheckView.hidden =NO;
            _CheckView1.hidden =NO;
        }
        else
        {
            buttonSnapView.enabled =NO;
            _CheckView.hidden =YES;
            _CheckView1.hidden =YES;
        }
        
    }
    if(indexPath.row ==5)
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_TR2.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            buttonSnapView.enabled =YES;
            _CheckView.hidden =NO;
            _CheckView1.hidden =NO;
        }
        else
        {
            buttonSnapView.enabled =NO;
            _CheckView.hidden =YES;
            _CheckView1.hidden =YES;
        }
        
    }
    if(indexPath.row ==6)
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_GD.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            buttonSnapView.enabled =YES;
            _CheckView.hidden =NO;
            _CheckView1.hidden =NO;
        }
        else
        {
            buttonSnapView.enabled =NO;
            _CheckView.hidden =YES;
            _CheckView1.hidden =YES;
        }
        
    }
    if(indexPath.row ==7)
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CFP.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            buttonSnapView.enabled =YES;
            _CheckView.hidden =NO;
            _CheckView1.hidden =NO;
        }
        else
        {
            buttonSnapView.enabled =NO;
            _CheckView.hidden =YES;
            _CheckView1.hidden =YES;
        }
    }
    if(indexPath.row ==8)
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_CRP.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            buttonSnapView.enabled =YES;
            _CheckView.hidden =NO;
            _CheckView1.hidden =NO;
        }
        else
        {
            buttonSnapView.enabled =NO;
            _CheckView.hidden =YES;
            _CheckView1.hidden =YES;
        }
        
    }
    
    
    
    if (isAutoSelect)
    {
        isAutoSelect = NO;
    }
    else
    {
        
        
        NSDictionary *dic = [_snapArr objectAtIndex:rowIndex];
        NSString *previousSelectedItem = [dic objectForKey:@"rowTitlw"];
        BOOL onlyFrontREquired = NO;
        if ([[dic objectForKey:@"idType"] isEqualToString:@"Birth Certificate"]||[[dic objectForKey:@"idType"] isEqualToString:@"Foreign Birth Certificate"]||[[dic objectForKey:@"idType"] isEqualToString:@"Foreigner Identification Number"]||[[dic objectForKey:@"idType"] isEqualToString:@"Passport"]||[[dic objectForKey:@"idType"] isEqualToString:@"Singapore Identification Number"])
        {
            onlyFrontREquired = YES;
        }
        NSString *msgErr = @"";
        
        if ((![[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]])&&(![[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]]))
        {
            
        }
        
        else
        {
            if (!onlyFrontREquired)
            {
                if (![[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]])
                {
                    msgErr = [msgErr stringByAppendingString:@"\n -back page"];
                }
            }
            
            if (![[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]])
            {
                msgErr = [msgErr stringByAppendingString:@"\n -front page"];
            }
            
            if ([msgErr length])
            {
                
                
                // [tableView deselectRowAtIndexPath:indexPath animated:YES];
                // [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:0];
                //                [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                //                                        animated:NO
                //                                  scrollPosition:UITableViewScrollPositionTop];
                
                //                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"The following snapshot(s) for %@ required: %@ ",previousSelectedItem,msgErr] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"Front/Back page of identification document is required for %@",previousSelectedItem] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
                [alert show];
                alert =Nil;
                
            }
            
            
            
        }
        
        
        
    }
    //
    
    
    rowIndex = indexPath.row;
    _frontImageView.image = nil;
    _backImageView.image = nil;
    
    
    
    NSLog(@"selectedRow %ld",selectedRow);
    
    NSString *idType = [[_snapArr objectAtIndex:indexPath.row]objectForKey:@"idType"];
    if ([idType hasPrefix:@"Select"]) {
        NSMutableDictionary *dic = [[_snapArr objectAtIndex:selectedRow]mutableCopy];
        [dic setValue:_idTypes[0] forKey:@"idType"];
        [_snapArr removeObjectAtIndex:selectedRow];
        [_snapArr insertObject:dic atIndex:selectedRow];
        
        
    }
    
    //    if([idType hasPrefix:@"Birth Certificate"]||[idType hasPrefix:@"Foreign Birth Certificate"]||[idType hasPrefix:@"Foreign Identification Number"]||[idType hasPrefix:@"Passport"]||[idType hasPrefix:@"Singapore Identification Number"])
    //    {
    //        _backImageView.hidden = YES;
    //        _backBut.hidden = YES;
    //        _backLabel.hidden =YES;
    //        NSLog(@"imherehere2");
    //    }
    //
    //
    
    //    if ([idType hasPrefix:@"New IC"]||[idType hasPrefix:@"Old Identification"]||[idType hasPrefix:@"Permanent Resident"]||[idType hasPrefix:@"Army Identification Number"]||[idType hasPrefix:@"Police Identification Number"]||[idType hasPrefix:@"Select Identification Type"]||[idType hasPrefix:@"Credit Card"])
    //    {
    //
    //        _backImageView.hidden = NO;
    //        _backBut.hidden = NO;
    //        _backLabel.hidden =NO;
    //        NSLog(@"imherehere");
    //    }
    
    
    
    
    [_idTypeBtn setTitle:[[_snapArr objectAtIndex:indexPath.row]objectForKey:@"idType"] forState:UIControlStateNormal];
    if ([idType hasPrefix:@"Credit"]) {
        //_idTypeBtn.enabled=NO;
        _idTypeBtn.enabled=YES;
        _backImageView.hidden = NO;
        _backBut.hidden = NO;
        _backLabel.hidden =NO;
    }
    else
    {
        _idTypeBtn.enabled=YES;
        _backImageView.hidden = NO;
        _backBut.hidden = NO;
        _backLabel.hidden =NO;
    }
    
    
    [self idTypeSelected:idType];
    
    //Load Images
    NSDictionary *dic = [_snapArr objectAtIndex:indexPath.row];
    if ([[dic objectForKey:@"frontSnap"]isKindOfClass:[UIImage class]]) {
        [_frontImageView setImage:[dic objectForKey:@"frontSnap"]];
        _CheckView.hidden =YES;
        _CheckView1.hidden =YES;
    }
    if ([[dic objectForKey:@"backSnap"]isKindOfClass:[UIImage class]]) {
        [_backImageView setImage:[dic objectForKey:@"backSnap"]];
    }
    
    
}

-(IBAction)viewbackLoad:(id)sender
{
    
}

- (void)viewDidUnload {
    [self setBackBut:nil];
    [self setBackLabel:nil];
    [self setSnapViewButton:nil];
    [self setSnapShowHistoryButton:nil];
    [self setStandalone_Btn:nil];
    [self setCheckView:nil];
    [self setCheckView1:nil];
    [super viewDidUnload];
}
- (IBAction)SnapViewButton:(id)sender {
}

@end//prem
