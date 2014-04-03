//
//  PhotoDetailViewController.m
//  foo2
//
//  Created by Eugene Moon on 7/9/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "FlickrFetcher.h"


@implementation PhotoDetailViewController

// @synthesize photoId, photoFarm, photoServer, photoSecret;
@synthesize photo;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	UIImage *image = [UIImage imageWithData:[photo photodatalarge]];
	imageView = [[UIImageView alloc] initWithImage:image];
	[scrollView addSubview:imageView];
	[scrollView setContentSize:[image size]];
	[scrollView setMaximumZoomScale:1.25];
	[scrollView setMinimumZoomScale:(320.0 / [image size].width)];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return imageView;
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
	return YES;
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
//	[photoId release];
//	[photoFarm release];
//	[photoServer release];
//	[photoSecret release];
	photo = nil;
	
	[imageView release];
	
    [super dealloc];
}


@end
