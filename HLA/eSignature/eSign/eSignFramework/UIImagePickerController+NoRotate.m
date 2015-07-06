//
//  UIImagePickerController+NoRotate.m
//  SDTest1
//
//  Created by Samuel Frunza-Hincu on 10/2/13.
//  Copyright (c) 2013 Softpro GmbH. All rights reserved.
//

#import "UIImagePickerController+NoRotate.h"

@implementation UIImagePickerController (NoRotate)

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
