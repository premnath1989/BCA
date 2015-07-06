//
//  myLable.m
//  HLA_CA
//
//  Created by Danial D. Moghaddam on 3/17/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//

#import "myLable.h"
#import <QuartzCore/QuartzCore.h>

@implementation myLable

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // Initialization code
        
        [self setOpaque:NO];
        
        [self setBackgroundColor:[UIColor clearColor]];
        
    }
    
    return self;
}
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    BOOL isPDF = !CGRectIsEmpty(UIGraphicsGetPDFContextBounds());
    if (!layer.shouldRasterize && isPDF)
        [self drawRect:self.bounds]; // draw unrasterized
    else
        [super drawLayer:layer inContext:ctx];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
