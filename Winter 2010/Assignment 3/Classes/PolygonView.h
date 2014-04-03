//
//  PolygonView.h
//  HelloPolyII
//
//  Created by Eugene Moon on 6/2/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PolygonShape.h"


@interface PolygonView : UIView {
	IBOutlet PolygonShape *shape;
}

+ (NSArray *)pointsForPolygonInRect:(CGRect)rect numberOfSides:(int)numberOfSides;

@end
