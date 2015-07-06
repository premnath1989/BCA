//
//  pages.m
//  testCordova
//
//  Created by Meng Cheong on 11/6/12.
//  Copyright (c) 2012 Meng Cheong. All rights reserved.
//

#import "pages.h"

@implementation pages
@synthesize PageNum,PageDesc, htmlName;

-(id)initPages:(NSString *)pageNum withPageDesc:(NSString *)pageDesc withHTMLName:(NSString *)htmlName2{
    self.PageNum = pageNum;
    self.PageDesc = pageDesc;
    self.htmlName = htmlName2;
    return self;
}

@end


//PageNum, PageDesc, htmlName