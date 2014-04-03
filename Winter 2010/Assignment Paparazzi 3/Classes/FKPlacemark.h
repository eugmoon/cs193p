//
//  FKPlacemark.h
//  foo
//
//  Created by Eugene Moon on 9/15/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import <MapKit/MKPlacemark.h>


@interface FKPlacemark : MKPlacemark {
	NSString *title;
	NSString *subtitle;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;

@end
