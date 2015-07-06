//
//  TagObject.m
//  iMobile Planner
//
//  Created by Juliana on 7/30/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "TagObject.h"

@implementation TagObject

+ (TagObject *) tagObj {
	static TagObject *single=nil;
	
    @synchronized(self)
    {
        if(!single)
        {
            single = [[TagObject alloc] init];
			
        }
		
    }
    return single;
}

@end
