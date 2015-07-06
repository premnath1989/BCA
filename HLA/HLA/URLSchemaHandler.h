//
//  URLSchemaHandler.h
//  Mobile Login
//
//  Created by Edwin Fong on 4/2/14.
//

#import <Foundation/Foundation.h>
#import "LoginVar.h"
#import <sqlite3.h>

@interface URLSchemaHandler : UIViewController {
    
    LoginVar* loginVar;
    sqlite3 *contactDB;
    NSString *databasePath;
}

//@property (nonatomic, copy) NSString *bundledData;

//extern NSString * bundledData;

@end
