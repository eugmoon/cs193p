//
//  PhotoDetailViewController.m
//  Paparazzi1
//
//  Created by Eugene Moon on 6/11/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import "PhotoDetailViewController.h"


@implementation PhotoDetailViewController

@synthesize imageFilename;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    }
    return self;
}

- (void)viewDidLoad {
	UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", imageFilename]];
	imageView = [[UIImageView alloc] initWithImage:image];
	[scrollView addSubview:imageView];
	[scrollView setContentSize:[image size]];
	[scrollView setMaximumZoomScale:(960.0 / [image size].width)];
	[scrollView setMinimumZoomScale:(320.0 / [image size].width)];
	[scrollView setZoomScale:(640.0 / [image size].width)];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return imageView;
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
	return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
	[imageFilename release];
	[imageView release];
	
    [super dealloc];
}


@end
