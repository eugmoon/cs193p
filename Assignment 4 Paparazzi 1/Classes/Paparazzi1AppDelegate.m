//
//  Paparazzi1AppDelegate.m
//  Paparazzi1
//
//  Created by Eugene Moon on 6/11/12.
//  Copyright EMG 2012. All rights reserved.
//

#import "Paparazzi1AppDelegate.h"

@implementation Paparazzi1AppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {

	// Override point for customization after application launch
	NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"photoArray" ofType:@"plist"];
	NSArray *photoArray = [NSArray arrayWithContentsOfFile:plistPath];
	
	firstNavController = [[UINavigationController alloc] init];
	personListViewController = [[PersonListViewController alloc] initWithNibName:@"PersonListViewController" bundle:[NSBundle mainBundle]];
	personListViewController.photoArray = photoArray;
	personListViewController.title = @"Contacts";
	[firstNavController pushViewController:personListViewController animated:NO];
	[personListViewController release];
	
	secondNavController = [[UINavigationController alloc] init];
	photoListViewController = [[PhotoListViewController alloc] initWithNibName:@"PhotoListViewController" bundle:[NSBundle mainBundle]];
	photoListViewController.photoArray = photoArray;
	photoListViewController.title = @"Recents";
	[secondNavController pushViewController:photoListViewController animated:NO];
	[photoListViewController release];
	
	tabBarController.viewControllers = [NSArray arrayWithObjects:firstNavController, secondNavController, nil];
	[secondNavController release];
	[firstNavController release];
	[window addSubview:tabBarController.view];
	[tabBarController release];
	
	[window makeKeyAndVisible];
}


- (void)dealloc {
	[window release];
	[super dealloc];
}


@end
