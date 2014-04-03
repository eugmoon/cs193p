//
//  Paparazzi2AppDelegate.m
//  Paparazzi2
//
//  Created by Eugene Moon on 7/8/12.
//  Copyright EMG 2012. All rights reserved.
//

#import "Paparazzi2AppDelegate.h"
#import "Person.h"
#import "Photo.h"


@implementation Paparazzi2AppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch
	flickrFetcher = [FlickrFetcher sharedInstance];
	
	if (![flickrFetcher databaseExists]) {
		NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"FakeData" ofType:@"plist"];
		NSArray *photoArray = [NSArray arrayWithContentsOfFile:plistPath];
		
		NSManagedObjectContext *context = [flickrFetcher managedObjectContext];
		if (!context) {
			// Handle the error.
			NSLog(@"Failed to initialize context for Core Data!");
		}
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
		[request setEntity:entity];
		int i = 0;
		NSError *error;
		for (NSDictionary *photoDictionary in photoArray) {
			Person *person = nil;
			if (i > 0) {
				NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like[c] %@", [NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"user"]]];
				NSArray *fetchResultsArray = [NSArray arrayWithArray:[flickrFetcher fetchManagedObjectsForEntity:@"Person" withPredicate:predicate]];
				if ([fetchResultsArray count] > 0) {
					person = (Person *)[fetchResultsArray objectAtIndex:0];
				}
			}
			if (person == nil) {
				person = (Person *)[NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
				[person setName:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"user"]]];
			}
			
			Photo *photo = (Photo *)[NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
			[photo setName:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"name"]]];
			[photo setPath:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"path"]]];
			
			[person addPhotoSetObject:photo];
			[photo setPerson:person];
			i++;
		}
		[request release];
		error = nil;
		if (![context save:&error]) {
			// Handle the error.
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			//			abort();
		}
	}
	
	firstNavController = [[UINavigationController alloc] init];
	personListViewController = [[PersonListViewController alloc] initWithStyle:UITableViewStylePlain];
	personListViewController.title = @"Contacts";
	[firstNavController pushViewController:personListViewController animated:NO];
	[personListViewController release];
	
	secondNavController = [[UINavigationController alloc] init];
	photoListViewController = [[PhotoListViewController alloc] initWithStyle:UITableViewStylePlain];
	photoListViewController.title = @"Recent";
	photoListViewController.person = nil;
	[secondNavController pushViewController:photoListViewController animated:NO];
	[photoListViewController release];
	
	tabBarController.viewControllers = [NSArray arrayWithObjects:firstNavController, secondNavController, nil];
	[secondNavController release];
	[firstNavController release];
	[window addSubview:tabBarController.view];
	[tabBarController release];
	
	[window makeKeyAndVisible];
}

/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
	
	NSError *error = nil;
	NSManagedObjectContext *context = [flickrFetcher managedObjectContext];
	if (context != nil) {
		if ([context hasChanges] && ![context save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[flickrFetcher release];
    
	[window release];
	[super dealloc];
}


@end

