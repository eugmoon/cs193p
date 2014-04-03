//
//  Paparazzi2AppDelegate.h
//  Paparazzi2
//
//  Created by Eugene Moon on 7/8/12.
//  Copyright EMG 2012. All rights reserved.
//

#import "FlickrFetcher.h"
#import "PersonListViewController.h"
#import "PhotoListViewController.h"


@interface Paparazzi2AppDelegate : NSObject <UIApplicationDelegate> {
	
    UIWindow *window;
	
	FlickrFetcher *flickrFetcher;
	UINavigationController *firstNavController;
	UINavigationController *secondNavController;
	PersonListViewController *personListViewController;
	PhotoListViewController *photoListViewController;
	
	IBOutlet UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

