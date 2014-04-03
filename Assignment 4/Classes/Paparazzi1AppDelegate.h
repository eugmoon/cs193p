//
//  Paparazzi1AppDelegate.h
//  Paparazzi1
//
//  Created by Eugene Moon on 6/11/12.
//  Copyright EMG 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonListViewController.h"
#import "PhotoListViewController.h"

@interface Paparazzi1AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	
	UINavigationController *firstNavController;
	UINavigationController *secondNavController;
	PersonListViewController *personListViewController;
	PhotoListViewController *photoListViewController;
	IBOutlet UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

