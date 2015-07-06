//
//  EverHLoadingViewController.h
//  iMobile Planner
//
//  Created by infoconnect on 6/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class EverHLViewController;
@protocol EverHLViewControllerDelegate
-(void) HLInsert:(NSString *)aaBasicHL andBasicTempHL:(NSString *)aaBasicTempHL;
-(void)HLGlobalSave;
@end


@interface EverHLoadingViewController : UIViewController<UITextFieldDelegate>{
	NSString *databasePath;
    sqlite3 *contactDB;
    id <EverHLViewControllerDelegate> _delegate;
}
@property (nonatomic,strong) id <EverHLViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *txtHLoad;
@property (weak, nonatomic) IBOutlet UITextField *txtHloadTerm;
@property (weak, nonatomic) IBOutlet UITextField *txtHloadPct;
@property (weak, nonatomic) IBOutlet UITextField *txtHLoadPctTerm;
@property (weak, nonatomic) IBOutlet UISegmentedControl *outletMedical;
- (IBAction)ActionMedical:(id)sender;
- (IBAction)ActionDone:(id)sender;

//--request
@property (nonatomic, assign,readwrite) int ageClient;
@property (nonatomic,strong) NSString *planChoose;
@property (nonatomic, copy) NSString *SINo;
//--
@property (nonatomic, assign,readwrite) int termCover;
@property (nonatomic,copy) NSString *getHL;
@property (nonatomic,assign,readwrite) int getHLTerm;
@property (nonatomic,copy) NSString *getHLPct;
@property (nonatomic,assign,readwrite) int getHLTermPct;
@property (nonatomic,assign,readwrite) int getMed;

-(BOOL)NewDone;

@end
