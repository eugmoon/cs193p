//
//  Paparazzi3AppDelegate.m
//  Paparazzi3
//
//  Created by Eugene Moon on 7/20/12.
//  Copyright EMG 2012. All rights reserved.
//

#import "Paparazzi3AppDelegate.h"
#import "Person.h"
#import "Photo.h"


@implementation Paparazzi3AppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	flickrFetcher = [FlickrFetcher sharedInstance];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	if (![flickrFetcher databaseExists]) {
		NSArray *recentPhotoArray = [flickrFetcher recentGeoTaggedPhotos];
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
		for (NSDictionary *photoDictionary in recentPhotoArray) {
			Person *person = nil;
			if (i > 0) {
				NSPredicate *predicate = [NSPredicate predicateWithFormat:@"owner like[c] %@", [NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"owner"]]];
				NSArray *fetchResultsArray = [NSArray arrayWithArray:[flickrFetcher fetchManagedObjectsForEntity:@"Person" withPredicate:predicate]];
				if ([fetchResultsArray count] > 0) {
					person = (Person *)[fetchResultsArray objectAtIndex:0];
				}
			}
			if (person == nil) {
				person = (Person *)[NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
				[person setOwner:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"owner"]]];
			}
			
			Photo *photo = (Photo *)[NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
			[photo setFarm:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"farm"]]];
			[photo setOwner:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"owner"]]];
			[photo setPhotoid:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"id"]]];
			[photo setSecret:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"secret"]]];
			[photo setServer:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"server"]]];
			[photo setPhotodatalarge:[flickrFetcher dataForPhotoID:[photo photoid] fromFarm:[photo farm] onServer:[photo server] withSecret:[photo secret] inFormat:FlickrFetcherPhotoFormatLarge]];
			[photo setPhotodatasquare:[flickrFetcher dataForPhotoID:[photo photoid] fromFarm:[photo farm] onServer:[photo server] withSecret:[photo secret] inFormat:FlickrFetcherPhotoFormatSquare]];
			if ([[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"title"]] isEqualToString:@""])
				[photo setTitle:@"No Title"];
			else
				[photo setTitle:[NSString stringWithFormat:@"%@", [photoDictionary objectForKey:@"title"]]];
			NSDictionary *locationDictionary = [flickrFetcher locationForPhotoID:[photo photoid]];
			if ([[locationDictionary objectForKey:@"latitude"] isMemberOfClass:[NSDecimalNumber class]]) {
				[photo setLatitude:[locationDictionary objectForKey:@"latitude"]];
				[photo setLongitude:[locationDictionary objectForKey:@"longitude"]];
			}
			else {
				NSNumber *lat = [NSNumber numberWithDouble:[[locationDictionary objectForKey:@"latitude"] doubleValue]];
				NSNumber *lon = [NSNumber numberWithDouble:[[locationDictionary objectForKey:@"longitude"] doubleValue]];
				[photo setLatitude:lat];
				[photo setLongitude:lon];
			}
			CLLocation *location = [[CLLocation alloc] initWithLatitude:[[photo latitude] doubleValue] longitude:[[photo longitude] doubleValue]];
			[location release];
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
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	firstNavController = [[UINavigationController alloc] init];
	personListViewController = [[PersonListViewController alloc] initWithStyle:UITableViewStylePlain];
	personListViewController.title = @"Contacts";
	personListViewController.delegate = self;
	[firstNavController pushViewController:personListViewController animated:NO];
	
	secondNavController = [[UINavigationController alloc] init];
	photoListViewController = [[PhotoListViewController alloc] initWithStyle:UITableViewStylePlain];
	photoListViewController.title = @"Recent";
	photoListViewController.person = nil;
	[secondNavController pushViewController:photoListViewController animated:NO];
	
	thirdNavController = [[UINavigationController alloc] init];
	photoMapViewController = [[PhotoMapViewController alloc] initWithNibName:@"PhotoMapViewController" bundle:[NSBundle mainBundle]];
	photoMapViewController.title = @"Map";
	[thirdNavController pushViewController:photoMapViewController animated:NO];
	[photoMapViewController release];
	
	tabBarController.viewControllers = [NSArray arrayWithObjects:firstNavController, secondNavController, thirdNavController, nil];
	[thirdNavController release];
	[secondNavController release];
	[firstNavController release];
	[window addSubview:tabBarController.view];
	[tabBarController release];
	
	[window makeKeyAndVisible];
}

- (void)refreshTableView {
	[(UITableView *)personListViewController.view reloadData];
	[(UITableView *)photoListViewController.view reloadData];
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
	[personListViewController release];
	[photoListViewController release];
	
	[window release];
	[super dealloc];
}


@end

