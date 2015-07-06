//
//  MyDocumentType.m
//  iMobile Planner
//
//  Created by Premnath on 10/10/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import "MyDocumentType.h"
#import <QuartzCore/QuartzCore.h>

@implementation MyDocumentType
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
