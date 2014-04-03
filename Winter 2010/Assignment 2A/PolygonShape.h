//
//  PolygonShape.h
//  WhatATool
//
//  Created by Eugene Moon on 5/26/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PolygonShape : NSObject {
	
	int numberOfSides;
	int minimumNumberOfSides;
	int maximumNumberOfSides;
	
}

@property int numberOfSides;
@property int minimumNumberOfSides;
@property int maximumNumberOfSides;
@property (readonly) float angleInDegrees;
@property (readonly) float angleInRadians;
@property (readonly) NSString *name;

- (id)initWithNumberOfSides:(int)sides minimumNumberOfSides:(int)min maximumNumberOfSides:(int)max;
- (void)description;

@end
