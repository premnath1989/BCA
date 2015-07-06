//
//  eSignController.h
//  eSignature
//
//  Created by Danial D. Moghaddam on 5/16/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPSignDocCAPI.h"
#import <signdociosfoundations/SDSignatureHandler.h>
#import <signdociosfoundations/SDSignatureCaptureController.h>
#import <signdociosfoundations/SDDeviceManager.h>
#import "UIImagePickerController+NoRotate.h"
#import "UIImage+Rotate.h"
#import "UIImage+Resize.h"
#ifdef __APPLE__
#include "TargetConditionals.h"
#endif
#import "ConstantStr.h"
#import "ESignGenerator.h"
#import "PDFViewController.h"
#import "NSObject_ConstantTags.h"
#import "CustomAlertBox.h"
#import "AppDelegate.h"
#import "eAppCheckList.h"
#import "MBProgressHUD.h"
#import "eAppReport.h"
@protocol refreshdata <NSObject>

@optional
-(void)refresheSigndata;
-(void)RefreshInformationData;
@end


@interface eSignController : UIViewController <SDSignatureHandler, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,CustomAlertBoxDelegate,UIAlertViewDelegate,UIScrollViewDelegate,refreshdata> {
    IBOutlet UIImageView *imageView;
    SDSignatureCaptureController *dialog;
    NSString *pdfPath;
    NSString *proposalNumber;
    NSString *currentSigner;
    NSString *currentSignerIDNumber;
    NSString *IDNumber;
     AppDelegate *appobject;
    UIScrollView *scrollView;
    UIBarButtonItem *signBarButtonItem;
    NSString *SignFirst;
    UIButton *image;
    BOOL getImageWithSignDocSDKRenderer;
    BOOL isLocked;
    BOOL ToCheckAlert;
    BOOL CheckRelationship;
    BOOL cFFSignatureRequired;
    NSString *customerName;
    MBProgressHUD *HUD;
    BOOL isCustomerSelected;
    BOOL isAutoSelect;
}
@property(nonatomic, assign) NSString *cellRghtbuttonDisabled1;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *SAvebuttonStatus;
-(NSString *)eApplicationForProposalNo:(NSString *)proposalNo fromInfoDic:(NSDictionary *)infoDic;
@property (nonatomic, retain)UIScrollView *scrollView;
@property(nonatomic,unsafe_unretained)id<refreshdata>delegate;
@property (nonatomic, strong) UITextView *signatureFrameLabel;
@property (nonatomic, strong)  UIView *overlayView;
@property (nonatomic, strong) NSDictionary *infoDic;
@property (strong, nonatomic) IBOutlet UINavigationItem *navigationBAr;
@property (nonatomic, strong) ESignGenerator *eApplicationGenerator;
@property (nonatomic, strong) PDFViewController *pdfViewController;
@property (nonatomic, strong) UINavigationController *navC;
@property (strong, nonatomic) NSMutableArray *signArr;
@property (strong, nonatomic) NSMutableArray *requiredArr;
@property (strong, nonatomic) NSString *SignFirst;
@property (nonatomic, strong)  UIBarButtonItem *signBarButtonItem;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIButton *image;
@property (nonatomic, strong) UIButton *buttonq;
@property (retain, nonatomic) UIScrollView *scroller;
@property(nonatomic, assign) NSString *cellRghtbuttonDisabled;
- (IBAction)saveDocumentClicked:(id)sender;
- (IBAction)captureClicked:(id)sender;
- (IBAction)backPressed:(id)sender;
-(void)AFuction;
-(void)Signtheform;

-(void)buttonDisable: (NSString *)DisableMe;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *BackButtonName;

@end
