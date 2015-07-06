//
//  TitleViewController.h
//  iMobile Planner
//
//  Created by Erza on 6/5/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@protocol TitleDelegate <NSObject>
@required
//-(void)selectedTitle:(NSString *)selectedTitle;
-(void)selectedTitleDesc:(NSString *)selectedTitleDesc;
-(void)selectedTitleCode:(NSString *)selectedTitleCode;
@end

@interface TitleViewController : UITableViewController<UISearchBarDelegate,UISearchDisplayDelegate>{
    NSMutableArray *_TitleDesc;
    NSMutableArray *_TitleCode;
    //NSString *databasePath;
    //sqlite3 *contactDB;
    //id<TitleDelegate> _delegate;
}
@property (nonatomic, strong) NSMutableArray *Title;
@property (nonatomic, retain) NSMutableArray *TitleDesc;
@property (nonatomic, retain) NSMutableArray *TitleCode;
@property (nonatomic, weak) id<TitleDelegate> delegate;
@property (strong, nonatomic) NSMutableArray* FilteredData;
@property (strong, nonatomic) NSMutableArray* FilteredCode;
@property (nonatomic, assign) bool isFiltered;

-(void) setTitle:(NSString *)title;
@end
