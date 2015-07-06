//
//  ContactType.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 10/4/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContactTypeClassDelegate
- (void)ContactTypeSelected:(NSString *)ContactTypeString;
@end

@interface ContactTypeClass : UITableViewController{
    NSMutableArray *_ContactTypeList;
    id<ContactTypeClassDelegate> _ContactTypeDelegate;
}
@property (nonatomic, retain) NSMutableArray *ContactTypeList;
@property (nonatomic, strong) id<ContactTypeClassDelegate> ContactTypeDelegate;    
@end
