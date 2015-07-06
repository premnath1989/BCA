//
//  pages.h
//  testCordova
//
//  Created by Meng Cheong on 11/6/12.
//  Copyright (c) 2012 Meng Cheong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface pages : NSObject

@property(nonatomic,strong)NSString *PageNum;
@property(nonatomic,strong)NSString *PageDesc;
@property(nonatomic,strong)NSString *htmlName;

-(id)initPages:(NSString *)pageNum withPageDesc:(NSString *)pageDesc withHTMLName:(NSString *)htmlName2;

@end

//PageNum, PageDesc, htmlName