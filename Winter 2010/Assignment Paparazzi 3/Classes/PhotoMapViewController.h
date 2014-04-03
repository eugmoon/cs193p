//
//  PhotoMapViewController.h
//  foo
//
//  Created by Eugene Moon on 8/2/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "FlickrFetcher.h"


@interface PhotoMapViewController : UIViewController <MKMapViewDelegate> {
	FlickrFetcher *flickrFetcher;
	
	IBOutlet MKMapView *photoMapView;
}

@end
