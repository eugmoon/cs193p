//
//  Paparazzi3AppDelegate.h
//  Paparazzi3
//
//  Created by Eugene Moon on 7/20/12.
//  Copyright EMG 2012. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "FlickrFetcher.h"
#import "PersonListViewController.h"
#import "PhotoListViewController.h"
#import "PhotoMapViewController.h"

@interface Paparazzi3AppDelegate : NSObject <UIApplicationDelegate, PersonListViewControllerDelegate> {
	
	UIWindow *window;
	
	FlickrFetcher *flickrFetcher;
	UINavigationController *firstNavController;
	UINavigationController *secondNavController;
	UINavigationController *thirdNavController;
	PersonListViewController *personListViewController;
	PhotoListViewController *photoListViewController;
	PhotoMapViewController *photoMapViewController;
	
	IBOutlet UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

