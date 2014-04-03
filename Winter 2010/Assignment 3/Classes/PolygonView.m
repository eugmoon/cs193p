//
//  PolygonView.m
//  HelloPolyII
//
//  Created by Eugene Moon on 6/2/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import "PolygonView.h"


@implementation PolygonView

+ (NSArray *)pointsForPolygonInRect:(CGRect)rect numberOfSides:(int)numberOfSides {
	CGPoint center;
	center = CGPointMake(rect.size.width / 2.0, (rect.size.height / 2.0));
	float radius = 0.9 * center.x;
	NSMutableArray *result = [NSMutableArray array];
	float angle = (2.0 * M_PI) / numberOfSides;
	float exteriorAngle = M_PI - angle;
	float rotationDelta = angle - (0.5 * exteriorAngle);
	
	for (int currentAngle = 0; currentAngle < numberOfSides; currentAngle++) {
		float newAngle = (angle * currentAngle) - rotationDelta;
		float curX = cos(newAngle) * radius;
		float curY = sin(newAngle) * radius;
		[result addObject:[NSValue valueWithCGPoint:CGPointMake(center.x + curX, center.y + curY)]];
	}
	
	return result;
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGRect bounds = [self bounds];
	[[UIColor grayColor] set];
	UIRectFill (bounds);
	
	[[UIColor blackColor] set];
	UIRectFrame (bounds);
	
	NSArray *pointArray = [PolygonView pointsForPolygonInRect:[self bounds] numberOfSides:shape.numberOfSides];
	
	CGContextBeginPath (context);
	for (NSValue *value in pointArray) {
		CGPoint point = [value CGPointValue];
		if (point.x == [[pointArray objectAtIndex:0] CGPointValue].x && point.y == [[pointArray objectAtIndex:0] CGPointValue].y)
			CGContextMoveToPoint (context, point.x, point.y);
		else
			CGContextAddLineToPoint (context, point.x, point.y);
	}
	CGContextClosePath (context);
	[[UIColor whiteColor] setFill];
	[[UIColor purpleColor] setStroke]; 
	CGContextDrawPath (context, kCGPathFillStroke);
}

- (void)dealloc {
	[shape release];
	
	[super dealloc];
}

@end
