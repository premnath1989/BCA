//
//  TrackedTouches.h
//
//Copyright (c) 2013 Wacom Technology Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// TrackedTouch
// The purpose of TrackedTouch is to be a central class for correlating UITouches and location
// data. The problem is that sometimes you can have a touch that while in the same location has a
// different pointer. There can also be the case where there is the same pointer and slightly different
// x and y. This class attempts to contain that knowledge
@interface TrackedTouch : NSObject

/*
 Function: clearTheStylusTouch
 Returns: nothing
 Remarks: This function should never be used.
 */
-(void)setTouch:(CGPoint) previousLocation currentLocation:(CGPoint) currentPosition touch:(UITouch *) inTouch;

/*
 Function: isRejected
 Returns: returns whether or not this touch point has been rejection by the touch rejection
 algorithms
 */
-(BOOL)isRejected;

/*
 Property: lastKnownLocation
 Remarks: Provides the last known location of this touch point corresponding to the current touch
 location of the contained UITouch
 */
@property (readonly) CGPoint lastKnownLocation;

/*
 Property: associatedTouch
 Remarks: This property is used to provide easy access to the UITouch being tracked
 */
@property (readonly) UITouch * associatedTouch;

/*
 Property: isStylus
 Remarks: This property is used to provide easy access to the knowledge of whether or not this
 Tracked Touch is the stylus.
 */
@property (readonly) BOOL isStylus;
@end




// TrackedTouches
// The purpose of TrackedTouches is to be the container for TrackedTouch'es such that you can
// query it to see if a touch is in it adjust touches' locations. This is also the all important
// keeper of the pen touch concept not to mention the touch rejection construct.
@interface TrackedTouches : NSObject
/* 
 Function: count
 Returns: the number of TrackedTouches contained within the class.
 */
-(NSUInteger)count;
/*
 Function: addTouches
 Returns: nothing
 Remarks: takes the touches passes in to touchesBegan and adds them to an internal list for tracking
 and use in touch rejection as well as stylus detection
 */
-(void) addTouches:(NSSet *)inTouches knownTouches:(NSSet *)knownTouches view:(id)inView;

/*
 Function: moveTouches
 Returns: nothing
 Remarks: takes the touches passes in to touchesMoved and adds them if necessary to an internal list 
 for tracking, updates existing entries with the current and previous locations, and used in touch 
 rejection as well as stylus detection
 */
-(void) moveTouches:(NSSet *)inTouches knownTouches:(NSSet *)knownTouches view:(id)inView;

/*
 Function: removeTouches
 Returns: nothing
 Remarks: takes the touches passes in to touchesEnded and removes them form the internal list of
 TrackedTouches.
 */
-(void) removeTouches:(NSSet *)inTouches knownTouches:(NSSet *)knownTouches view:(id)inView;

/*
 Function: getTouches
 Returns: returns the UITouch for the Stylus touchpoint if touch rejection is turned on. Otherwise, 
 it returns all of the UITouch points it knows about which will include the Stylus touchpoint as 
 well as other touches such as those by the palm or fingers.
 */
-(NSArray *)getTouches;

/*
 Function: getTrackedTouches
 Returns: returns the TrackedTouches for all touchpoints currently known about, which would include
 the StylusTouchPoint if there is one..
 */
-(NSArray *)getTrackedTouches;

/*
 Function: clearTouches
 Returns: nothing
 Remarks: this is an important function that allows one to clear the TrackedTouch list. This should
 only be used in cases where dead zones are being seen such as after a page turn or something of that
 nature. Otherwise, it should not be used as it effectively erases the knowledge of currently
 UITouches
 */
-(void)clearTouches;

/*
 Function: clearTheStylusTouch
 Returns: nothing
 Remarks: This function should never be used.
 */
-(void)clearTheStylusTouch;

/*
 Property: pressureTimeOffset
 Remarks: This property is used to set the timing for the touch rejection if you are seeing dropped
 stylus strokes, then one may want to adjust this. The default setting is 30,000 microseconds
 (30 milliseconds). One may need to increase the delay to 60,000 microseconds in accordance with
 the performance of the application.
 PLEASE NOTE: log messages slow down your machine and change the timing, one might want to remove 
 unnecessary log messages before changing this timing.
 */
@property (readwrite) NSUInteger pressureTimeOffset;

/*
 Function: setPressure
 Returns: nothing
 Remarks: This function should never be used.
 */
-(void)setPressure:(NSInteger)inPressure;
/*
 Property: theStylusTouch
 Remarks: This property is used to provide easy access to the stylus' TrackedTouch Class. If the
 pointer is null, then the stylus has not been identified yet.
 */
@property (readonly) TrackedTouch *theStylusTouch;

/*
 Property: touchRejectionEnabled
 Remarks: This property is used to enable or disable the touch rejection feature.
 */
@property (readwrite) BOOL touchRejectionEnabled;
@end
