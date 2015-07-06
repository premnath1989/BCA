//
//  Relationship.h
//  iMobile Planner
//
//  Created by shawal sapuan on 7/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RelationshipDelegate
-(void)selectedRelationship:(NSString *)theRelation;
@end

@interface Relationship : UITableViewController {
    id <RelationshipDelegate> _delegate;
}

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) id <RelationshipDelegate> delegate;
@property (nonatomic,strong) id requestType;

@end
