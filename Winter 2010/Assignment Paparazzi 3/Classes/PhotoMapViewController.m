//
//  PhotoMapViewController.m
//  foo
//
//  Created by Eugene Moon on 8/2/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import <AddressBook/AddressBook.h>
#import "PhotoMapViewController.h"
#import "Photo.h"
#import "FKPlacemark.h"
#import "PhotoDetailViewController.h"


@implementation PhotoMapViewController

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		UIImage *tabBarImage = [UIImage imageNamed:@"globe.png"];
		UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Map" image:tabBarImage tag:2];
		self.tabBarItem = item; 
		[item release];
		
		flickrFetcher = [FlickrFetcher sharedInstance];
	}
    return self;
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
	NSArray *fetchedPhotoArray = [flickrFetcher fetchManagedObjectsForEntity:@"Photo" withPredicate:nil];
	
	for (Photo *fetchedPhoto in fetchedPhotoArray) {
		CLLocation *location = [[CLLocation alloc] initWithLatitude:[[fetchedPhoto latitude] doubleValue] longitude:[[fetchedPhoto longitude] doubleValue]];
		NSDictionary *addrDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"1 Infinite Loop", kABPersonAddressStreetKey, @"Cupertino", kABPersonAddressCityKey, @"CA", kABPersonAddressStateKey, @"95014", kABPersonAddressZIPKey, @"United States", kABPersonAddressCountryKey, @"US", kABPersonAddressCountryCodeKey, nil];
		FKPlacemark *photoPlacemark = [[FKPlacemark alloc] initWithCoordinate:[location coordinate] addressDictionary:addrDictionary];
		if (![fetchedPhoto title])
			photoPlacemark.title = @"Untitled";
		else
			photoPlacemark.title = [fetchedPhoto title];
		photoPlacemark.subtitle = [flickrFetcher usernameForUserID:[fetchedPhoto owner]];
		[mapView addAnnotation:photoPlacemark];
		[photoPlacemark autorelease];
		[location release];
	}
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	if ([annotation isKindOfClass:[FKPlacemark class]]) {
		MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"pinAnnotation"];
		if (annotationView == nil) {
			annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pinAnnotation"];
        }
		else {
			annotationView.annotation = annotation;
        }
		annotationView.enabled = YES;
		annotationView.canShowCallout = YES;
		
		// Create a UIButton object to add on the callout
		UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		[rightButton setTitle:annotation.title forState:UIControlStateNormal];
		[annotationView setRightCalloutAccessoryView:rightButton];
		
		return annotationView;
	}
	return nil; 
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	PhotoDetailViewController *photoDetailViewController = [[PhotoDetailViewController alloc] initWithNibName:@"PhotoDetailViewController" bundle:[NSBundle mainBundle]];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title == %@", view.annotation.title];
	NSArray *fetchedPhotoArray = [flickrFetcher fetchManagedObjectsForEntity:@"Photo" withPredicate:predicate];
	photoDetailViewController.photo = [fetchedPhotoArray objectAtIndex:0];
	
	[self.navigationController pushViewController:photoDetailViewController animated:YES];
	[photoDetailViewController release];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[photoMapView release];
	
    [super dealloc];
}


@end
