//
//  Logout.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 10/2/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface Logout : UIViewController{
    NSString *databasePath;
    sqlite3 *contactDB;
}

@property (nonatomic, assign,readwrite) int indexNo;
@end
