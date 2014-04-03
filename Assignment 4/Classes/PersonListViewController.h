//
//  PersonListViewController.h
//  Paparazzi1
//
//  Created by Eugene Moon on 6/11/12.
//  Copyright 2012 EMG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoListViewController.h"


@interface PersonListViewController : UIViewController {
	NSArray *photoArray;
	NSMutableArray *ownerStringArray;
	IBOutlet UIButton *firstButton;
	IBOutlet UIButton *secondButton;
	IBOutlet UIButton *thirdButton;
	IBOutlet UIButton *fourthButton;
}

@property (nonatomic, retain) NSArray *photoArray;

- (IBAction)viewPhotoList:(id)sender;

@end
