//
//  COAPDF.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/16/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "COAPDF.h"
#import "DataClass.h"

@interface COAPDF (){
    DataClass *obj;
}

@end

@implementation COAPDF

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSString *urlAddress = [[NSBundle mainBundle] pathForResource:@"COA" ofType:@"pdf"];
    NSURL *url = [NSURL fileURLWithPath:urlAddress];
    
    //NSLog(@"%@",url);
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_COAView loadRequest:requestObj];
    
    obj = [DataClass getInstance];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCOAView:nil];
    [self setOpenWithBtn:nil];
    [super viewDidUnload];
}
- (IBAction)doDone:(id)sender {
    [self.delegate displayESignForms];
}

- (IBAction)openWith:(id)sender {
    
    NSURL *pathURL = [[NSBundle mainBundle] URLForResource:@"COA" withExtension:@"pdf"];
    
    
    self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:pathURL];
    
    [self.documentInteractionController setDelegate:self];
    
    [self.documentInteractionController presentOpenInMenuFromBarButtonItem:_openWithBtn animated:YES];
    
    NSLog(@"signdoc");
}
@end
