//
//  PhotoDetailViewController.h
//  foo2
//
//  Created by Eugene Moon on 7/9/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotoDetailViewController : UIViewController <UIScrollViewDelegate> {
	UIImageView *imageView;
	NSString *photoName;
	
	IBOutlet UIScrollView *scrollView;
}

@property (nonatomic, retain) NSString *photoName;

@end
