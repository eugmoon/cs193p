//
//  PhotoDetailViewController.h
//  Paparazzi1
//
//  Created by Eugene Moon on 6/11/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotoDetailViewController : UIViewController <UIScrollViewDelegate> {
	UIImageView *imageView;
	NSString *imageFilename;
	
	IBOutlet UIScrollView *scrollView;
}

@property (nonatomic, retain) NSString *imageFilename;

@end
