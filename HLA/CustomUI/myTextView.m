//
//  myTextView.m
//  HLA_CA
//
//  Created by Danial D. Moghaddam on 3/17/14.
//  Copyright (c) 2014 Danial D. Moghaddam. All rights reserved.
//

#import "myTextView.h"
#import <QuartzCore/QuartzCore.h>

@implementation myTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
