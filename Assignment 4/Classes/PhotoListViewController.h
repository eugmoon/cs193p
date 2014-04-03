//
//  PhotoListViewController.h
//  Paparazzi1
//
//  Created by Eugene Moon on 6/11/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoDetailViewController.h"


@interface PhotoListViewController : UIViewController {
	NSArray *photoArray;
	NSMutableArray *photosArray;
	
	IBOutlet UIButton *firstButton;
	IBOutlet UIButton *secondButton;
	IBOutlet UIButton *thirdButton;
	IBOutlet UIButton *fourthButton;
	IBOutlet UIButton *fifthButton;
	IBOutlet UIButton *sixthButton;
	IBOutlet UIButton *seventhButton;
}

@property (nonatomic, retain) NSArray *photoArray;

- (IBAction)viewPhotoList:(id)sender;

@end
