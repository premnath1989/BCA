//
//  SubDetailsData.h
//  iMobile Planner
//
//  Created by shawal sapuan on 7/13/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubDetailsDataDelegate
-(void)selectedPO:(NSString*)theStr;
@end

@interface SubDetailsData : UITableViewController {
    id <SubDetailsDataDelegate> _delegate;
}

@property (nonatomic,strong) id <SubDetailsDataDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *isPolicyOwner;
- (IBAction)isPolicyOwnerBtn:(id)sender;

@end
