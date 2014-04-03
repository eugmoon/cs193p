//
//  PolygonShape.m
//  WhatATool
//
//  Created by Eugene Moon on 5/26/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import "PolygonShape.h"


@implementation PolygonShape

@synthesize numberOfSides, minimumNumberOfSides, maximumNumberOfSides;

- (void) setNumberOfSides:(int) sides {
	if (sides < minimumNumberOfSides)
		NSLog(@"Invalid number of sides: %d is less than the minimum of %d allowed", sides, minimumNumberOfSides);
	else if (sides > maximumNumberOfSides)
		NSLog(@"Invalid number of sides: %d is greater than the maximum of %d allowed", sides, maximumNumberOfSides);
	else
		numberOfSides = sides;
}

- (void) setMinimumNumberOfSides:(int) min {
	if (min > 2)
		minimumNumberOfSides = min;
	else
		NSLog(@"Invalid number of sides: %d is less than the minimum of 3 allowed", min);
}

- (void) setMaximumNumberOfSides:(int) max {
	if (max <=12)
		maximumNumberOfSides = max;
	else
		NSLog(@"Invalid number of sides: %d is more than the maximum of 12 allowed", max);
}

- (id)initWithNumberOfSides:(int)sides minimumNumberOfSides:(int)min maximumNumberOfSides:(int)max {
	[self setMinimumNumberOfSides:min];
	[self setMaximumNumberOfSides:max];
	[self setNumberOfSides:sides];
	
	return self;
}

- (id)init {
	return [self initWithNumberOfSides:5 minimumNumberOfSides:3 maximumNumberOfSides:10];
}

- (float)angleInDegrees {
	if (numberOfSides != 0)
		return (180.0 * (numberOfSides - 2) / numberOfSides);
	else
		return 0;
}

- (float)angleInRadians {
	if (numberOfSides != 0)
		return (M_PI / 2.0 * (numberOfSides - 2) / numberOfSides);
	else
		return 0;
}

- (NSString *)name {
	if (numberOfSides < 3)
		return @"NotAPolygon";
	if (numberOfSides < 4)
		return @"Triangle";
	if (numberOfSides < 5)
		return @"Square";
	if (numberOfSides < 6)
		return @"Pentagon";
	if (numberOfSides < 7)
		return @"Hexagon";
	if (numberOfSides < 8)
		return @"Heptagon";
	if (numberOfSides < 9)
		return @"Octagon";
	if (numberOfSides < 10)
		return @"Nonagon";
	if (numberOfSides < 11)
		return @"Decagon";
	if (numberOfSides < 12)
		return @"Hendecagon";
	else
		return @"Dodecagon";
}

- (void)description {
	NSLog(@"Hello, I am a %d-sided polygon (aka a %@) with angles of %.3f degrees (%f radians).", numberOfSides, [self name], [self angleInDegrees], [self angleInRadians]);
}

- (void)dealloc {
	NSLog(@"Yo, dealloc, man!");
	
	[super dealloc];
}

@end
