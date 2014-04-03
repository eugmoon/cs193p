//
//  PhotoDetailViewController.h
//  foo2
//
//  Created by Eugene Moon on 7/9/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"


@interface PhotoDetailViewController : UIViewController <UIScrollViewDelegate> {
	UIImageView *imageView;
	Photo *photo;
//	NSString *photoId;
//	NSString *photoFarm;
//	NSString *photoServer;
//	NSString *photoSecret;
	
	IBOutlet UIScrollView *scrollView;
}

@property (nonatomic, retain) Photo *photo;
// @property (nonatomic, retain) NSString *photoId;
// @property (nonatomic, retain) NSString *photoFarm;
// @property (nonatomic, retain) NSString *photoServer;
// @property (nonatomic, retain) NSString *photoSecret;

@end
